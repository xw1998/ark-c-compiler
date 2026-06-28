/* Ark C Compiler - parser
 * 递归下降语法分析器。
 *
 * 覆盖范围（C99 实用子集）：
 *   - 类型：void/char/short/int/long/long long/_Bool/float/double/signed/unsigned
 *   - 限定符：const/volatile/restrict/inline （解析并忽略）
 *   - 存储类：static/extern/auto/register
 *   - struct/union/enum 与匿名定义、tag 引用
 *   - typedef
 *   - 多维数组、指针、函数指针（仅声明语法层面）
 *   - sizeof(type) / sizeof expr
 *   - (type)expr 显式类型转换
 *   - switch/case/default/break
 *   - goto + label
 *   - 块内任意位置声明 + for-init 内声明
 *   - 字符串字面量、相邻拼接（lex 已做）
 *
 * 由于不在 parser 中维护"全局符号表"，typedef 在 lexer 已经词法化为 IDENT，
 * 这里通过 sym_is_typedef 在解析中识别其作为类型名。
 */
#include "parser.h"
#include "memory.h"
#include "platform.h"
#include "symtab.h"
#include "sema.h"
#include "config.h"
#include "arkcc_config.h"

static AstNode *parse_top_decl(Parser *p);
static AstNode *parse_block(Parser *p);
static AstNode *parse_statement(Parser *p);
static AstNode *parse_expr(Parser *p);
static AstNode *parse_assign_expr(Parser *p);
static AstNode *parse_cond_expr(Parser *p);
static AstNode *parse_or_expr(Parser *p);
static AstNode *parse_and_expr(Parser *p);
static AstNode *parse_bitor_expr(Parser *p);
static AstNode *parse_bitxor_expr(Parser *p);
static AstNode *parse_bitand_expr(Parser *p);
static AstNode *parse_eq_expr(Parser *p);
static AstNode *parse_rel_expr(Parser *p);
static AstNode *parse_shift_expr(Parser *p);
static AstNode *parse_add_expr(Parser *p);
static AstNode *parse_mul_expr(Parser *p);
static AstNode *parse_cast_expr(Parser *p);
static AstNode *parse_unary_expr(Parser *p);
static AstNode *parse_postfix_expr(Parser *p);
static AstNode *parse_primary_expr(Parser *p);
static Type    *parse_declspec(Parser *p, int *p_storage, int *p_is_typedef);
static Type    *parse_declarator(Parser *p, Type *base, char **out_name);
static AstNode *parse_local_var_decl(Parser *p, Type *base, int storage, int is_typedef);
static AstNode *parse_struct_or_union(Parser *p, int is_union);
static AstNode *parse_enum(Parser *p);
static AstNode *parse_initializer(Parser *p);
static void     parse_attribute(Parser *p, Type *attach_type);
static AstNode *parse_asm_statement(Parser *p);
static AstNode *parse_init_list(Parser *p);

/* 存储类位 */
#define STO_STATIC   1
#define STO_EXTERN   2
#define STO_AUTO     4
#define STO_REGISTER 8

/* 当前正在解析的函数名，供 __func__ 替换使用 */
static const char *g_current_func_name = 0;

static int is_decl_start(Parser *p);

static int is_basic_type_token(TokenKind k) {
    switch (k) {
        case TOK_INT: case TOK_CHAR: case TOK_VOID:
        case TOK_SHORT: case TOK_LONG: case TOK_SIGNED: case TOK_UNSIGNED:
        case TOK_FLOAT: case TOK_DOUBLE: case TOK_BOOL:
        case TOK_STRUCT: case TOK_UNION: case TOK_ENUM:
        case TOK_CONST: case TOK_VOLATILE: case TOK_RESTRICT: case TOK_INLINE:
        case TOK_STATIC: case TOK_EXTERN: case TOK_AUTO: case TOK_REGISTER:
        case TOK_TYPEDEF:
        case TOK_PACKED_KW:  /* __packed 可作为 cast/decl 起始限定符 */
        case TOK_COMPLEX:    /* _Complex */
        /* armcc 定宽整数类型 */
        case TOK_INT8: case TOK_INT16: case TOK_INT32: case TOK_INT64:
        /* armcc 函数/变量修饰关键字（可出现在声明开头） */
        case TOK_THREAD: case TOK_PURE: case TOK_INTERWORK:
        case TOK_VALUE_IN_REGS: case TOK_SMC: case TOK_GLOBAL_REG:
            return 1;
        default: return 0;
    }
}

/* 检查当前 token 是否可作为声明开头 */
static int is_decl_start(Parser *p) {
    Token t = lexer_peek(p->lex);
    if (is_basic_type_token(t.kind)) return 1;
    if (t.kind == TOK_IDENT && sym_is_typedef(t.str)) return 1;
    return 0;
}

static void perror_at(Parser *p, const char *msg) {
    Token t = lexer_peek(p->lex);
    ark_log("[parser] line %d: %s (got token kind %d)\n", t.line, msg, (int)t.kind);
    p->error_count++;
}

AstNode *parse_program(Lexer *lex) {
    Parser p;
    AstNode *prog;

    p.lex = lex;
    p.error_count = 0;

    /* 整个分析过程使用 sym 表存放 typedef 信息（只读：parser 中用作判断） */
    sym_init();

    prog = ast_new(AST_PROGRAM, 1);
    prog->u.program.decls = 0;
    prog->u.program.decl_count = 0;

    while (lexer_peek(lex).kind != TOK_EOF) {
        AstNode *decl = parse_top_decl(&p);
        if (decl) {
            int count = prog->u.program.decl_count;
            AstNode **arr = (AstNode **)mem_realloc(
                prog->u.program.decls,
                count * (int)sizeof(AstNode *),
                (count + 1) * (int)sizeof(AstNode *));
            arr[count] = decl;
            prog->u.program.decls = arr;
            prog->u.program.decl_count = count + 1;
        } else {
            if (lexer_peek(lex).kind != TOK_EOF) lexer_advance(lex);
        }
    }
    return prog;
}

/* 跳过所有类型限定符（const/volatile/restrict） */
static void skip_qualifiers(Parser *p) {
    for (;;) {
        TokenKind k = lexer_peek(p->lex).kind;
        if (k == TOK_CONST || k == TOK_VOLATILE || k == TOK_RESTRICT || k == TOK_INLINE) {
            lexer_advance(p->lex);
        } else if (k == TOK_ATTRIBUTE) {
            parse_attribute(p, 0);
        } else break;
    }
}

/* __svc(n) — ARM Compiler 5 SVC 声明；返回 SVC 编号，0 表示未找到 */
static int parse_svc(Parser *p) {
    int svc_num = 0;
    if (lexer_peek(p->lex).kind != TOK_SVC) return 0;
    lexer_advance(p->lex);
    if (lexer_peek(p->lex).kind != TOK_LPAREN) return 0;
    lexer_advance(p->lex);
    if (lexer_peek(p->lex).kind == TOK_NUM) {
        svc_num = lexer_peek(p->lex).value;
        lexer_advance(p->lex);
    }
    if (lexer_peek(p->lex).kind == TOK_RPAREN) lexer_advance(p->lex);
    return svc_num;
}

/* __attribute__((weak/naked/interrupt)) 在 parse_attribute 中识别后写入这些全局，
 * 由 parse_top_decl 在构造函数节点时读取并复位。 */
static int g_attr_is_weak;
static int g_attr_is_naked;
static int g_attr_is_irq;
/* __attribute__((section("..."))) 与 const 限定符：
 * 由 parse_attribute / parse_declspec 写入，parse_top_decl / parse_local_var_decl
 * 读取并复位。const 用于 .rodata 段选择；section 用于自定义段。 */
static char *g_attr_section;
static int   g_decl_is_const;
/* 0.4.0 新增 attribute / 关键字驱动属性。
 *   - used/unused: 防止链接器死代码消除 或 抑制未使用警告
 *   - alias("target"): 函数别名（同地址）
 *   - aligned(n) / __align(n): 强制对齐
 *   - softfp / forceinline: ARM Compiler 5 函数属性 */
static int   g_attr_is_used;
static int   g_attr_is_unused;
static char *g_attr_alias_target;
static int   g_attr_align_bytes;
static int   g_decl_align_bytes;
/* __packed 作用于指针类型（如 `__packed int *p`）：标记传给 parse_declarator，
 * 在构造 TYPE_PTR 时设置 is_packed=1，irgen/ARM 后端据此使用按字节访问。
 * 在 parse_top_decl / parse_local_var_decl 每个声明开始处复位。 */
static int   g_decl_packed_ptr;
/* B3: VLA 尺寸表达式。parse_declarator 解析到非常量数组维度时写入，
 * parse_local_var_decl / parse_top_decl 在构造变量节点时取用并复位。
 * 仅记录首个 VLA 维度（多数 VLA 用法为单维 int a[n]）。 */
static AstNode *g_vla_size_expr;
static int   g_attr_is_softfp;
static int   g_attr_is_forceinline;
/* constructor/destructor/deprecated：函数属性，由 parse_attribute 写入，
 * parse_top_decl 在构造函数节点时读取并复位。 */
static int   g_attr_is_constructor;
static int   g_attr_is_destructor;
static int   g_attr_is_deprecated;
/* __at(addr) / #pragma location=addr：保存当前声明的绝对地址。
 *   - g_attr_has_at=1 表示当前声明命中 at(N)，地址在 g_attr_at_addr。
 *   - g_pragma_location_addr/has 由 #pragma location 设置，下一个 var
 *     声明读取并清空。 */
static unsigned g_attr_at_addr;
static int      g_attr_has_at;

/* 扫描并消费 __irq/__weak/__naked/__softfp/__forceinline 关键字（ARM Compiler 5
 * 风格），返回位掩码：
 *   bit0 = is_irq, bit1 = is_weak, bit2 = is_naked,
 *   bit3 = is_softfp, bit4 = is_forceinline
 * 这些关键字可出现在返回类型前、类型与函数名之间、参数表后等位置。
 *
 * 0.6.x：同时识别 armcc 5 兼容关键字 __value_in_regs/__pure/__interwork/
 * __nothrow/__deprecated/__may_alias/__tp_soft/__args/__return 等，
 * 通过全局变量传递给 parse_top_decl（多数仅语义标记）。
 *   - g_func_is_value_in_regs / g_func_is_pure / g_func_is_const_attr
 *   - g_func_is_interwork / g_func_is_deprecated_kw
 *   静默忽略：__nothrow/__may_alias/__tp_soft/__args/__return
 */
static int g_func_is_value_in_regs;
static int g_func_is_pure;
static int g_func_is_const_attr;
static int g_func_is_interwork;
static int g_func_is_deprecated_kw;

static int parse_func_modifiers(Parser *p) {
    int flags = 0;
    for (;;) {
        TokenKind k = lexer_peek(p->lex).kind;
        if (k == TOK_IRQ)             flags |= 1;
        else if (k == TOK_WEAK)       flags |= 2;
        else if (k == TOK_NAKED)      flags |= 4;
        else if (k == TOK_SOFTFP)     flags |= 8;
        else if (k == TOK_FORCEINLINE) flags |= 16;
#if ARKCC_FEATURE_ARMCC_KEYWORDS
        else if (k == TOK_VALUE_IN_REGS) { g_func_is_value_in_regs = 1; }
        else if (k == TOK_PURE)          { g_func_is_pure = 1; }
        else if (k == TOK_INTERWORK)     { g_func_is_interwork = 1; }
        else if (k == TOK_DEPRECATED_KW) { g_func_is_deprecated_kw = 1; }
        /* 静默忽略的关键字：__nothrow/__may_alias/__tp_soft/__args/__return */
        else if (k == TOK_NOTHROW || k == TOK_MAY_ALIAS ||
                 k == TOK_TP_SOFT || k == TOK_ARGS || k == TOK_RETURN_KW) {
            /* 静默忽略 */
        }
        else break;
#else
        else break;
#endif
        lexer_advance(p->lex);
    }
    return flags;
}

/* __attribute__((a1, a2(arg), ...)) : 识别 packed/aligned 并赋给 attach_type */
static void parse_attribute(Parser *p, Type *attach_type) {
    if (lexer_peek(p->lex).kind != TOK_ATTRIBUTE) return;
    lexer_advance(p->lex);
    if (lexer_peek(p->lex).kind != TOK_LPAREN) return;
    lexer_advance(p->lex);
    if (lexer_peek(p->lex).kind != TOK_LPAREN) return;
    lexer_advance(p->lex);
    while (lexer_peek(p->lex).kind != TOK_RPAREN &&
           lexer_peek(p->lex).kind != TOK_EOF) {
        Token t = lexer_peek(p->lex);
        if (t.kind == TOK_IDENT) {
            const char *nm = t.str;
            lexer_advance(p->lex);
            /* 处理参数 ( ... ) */
            if (lexer_peek(p->lex).kind == TOK_LPAREN) {
                int paren = 1;
                int first_val = 0;
                int saw_val = 0;
                const char *sec_str = 0;
                lexer_advance(p->lex);
                if (lexer_peek(p->lex).kind == TOK_NUM) {
                    first_val = lexer_peek(p->lex).value;
                    saw_val = 1;
                } else if (lexer_peek(p->lex).kind == TOK_STR) {
                    sec_str = lexer_peek(p->lex).str;
                }
                while (paren > 0 && lexer_peek(p->lex).kind != TOK_EOF) {
                    if (lexer_peek(p->lex).kind == TOK_LPAREN) paren++;
                    else if (lexer_peek(p->lex).kind == TOK_RPAREN) paren--;
                    if (paren > 0) lexer_advance(p->lex);
                }
                if (lexer_peek(p->lex).kind == TOK_RPAREN) lexer_advance(p->lex);
                if (saw_val && (ark_streq(nm, "aligned") || ark_streq(nm, "__aligned__"))) {
                    if (attach_type) attach_type->align_override = first_val;
                    g_attr_align_bytes = first_val;
                }
                /* at(N) / __at__(N)：绝对地址定位（ARM Compiler 5 / IAR 风格） */
                if (saw_val && (ark_streq(nm, "at") || ark_streq(nm, "__at__"))) {
                    g_attr_at_addr = (unsigned)first_val;
                    g_attr_has_at = 1;
                }
                /* section("name")：捕获段名供 var 节点使用 */
                if (sec_str && (ark_streq(nm, "section") || ark_streq(nm, "__section__"))) {
                    g_attr_section = mem_strdup(sec_str);
                }
                /* alias("target")：函数别名，记录目标符号 */
                if (sec_str && (ark_streq(nm, "alias") || ark_streq(nm, "__alias__"))) {
                    g_attr_alias_target = mem_strdup(sec_str);
                }
            } else {
                if (attach_type && (ark_streq(nm, "packed") || ark_streq(nm, "__packed__"))) {
                    attach_type->is_packed = 1;
                }
                if (ark_streq(nm, "aligned") || ark_streq(nm, "__aligned__")) {
                    if (attach_type) attach_type->align_override = 8;
                    g_attr_align_bytes = 8;
                }
                /* 函数级属性：weak/naked/interrupt(irq)。这些不挂在 Type 上，
                 * 而是通过全局变量传递给 parse_top_decl 写入函数节点。 */
                if (ark_streq(nm, "weak") || ark_streq(nm, "__weak__")) {
                    g_attr_is_weak = 1;
                }
                if (ark_streq(nm, "naked") || ark_streq(nm, "__naked__")) {
                    g_attr_is_naked = 1;
                }
                if (ark_streq(nm, "interrupt") || ark_streq(nm, "__interrupt__") ||
                    ark_streq(nm, "irq") || ark_streq(nm, "__irq__")) {
                    g_attr_is_irq = 1;
                }
                /* used/unused：透传给 C 后端，让 gcc 控制死代码消除/警告 */
                if (ark_streq(nm, "used") || ark_streq(nm, "__used__")) {
                    g_attr_is_used = 1;
                }
                if (ark_streq(nm, "unused") || ark_streq(nm, "__unused__")) {
                    g_attr_is_unused = 1;
                }
                /* armcc 风格：softfp / forceinline 通过 attribute 出现也支持 */
                if (ark_streq(nm, "softfp") || ark_streq(nm, "__softfp__")) {
                    g_attr_is_softfp = 1;
                }
                if (ark_streq(nm, "always_inline") || ark_streq(nm, "__always_inline__") ||
                    ark_streq(nm, "forceinline")) {
                    g_attr_is_forceinline = 1;
                }
                /* constructor/destructor：main 前/后执行，C 后端透传给 gcc，
                 * ARM 后端生成 .init_array/.fini_array 条目。
                 * 可带可选优先级参数 constructor(N)，已在上文 ( ... ) 分支消费。 */
                if (ark_streq(nm, "constructor") || ark_streq(nm, "__constructor__")) {
                    g_attr_is_constructor = 1;
                }
                if (ark_streq(nm, "destructor") || ark_streq(nm, "__destructor__")) {
                    g_attr_is_destructor = 1;
                }
                /* deprecated：透传给 gcc 触发弃用警告（带可选消息字符串） */
                if (ark_streq(nm, "deprecated") || ark_streq(nm, "__deprecated__")) {
                    g_attr_is_deprecated = 1;
                }
                /* 0.6.x：armcc 5 / GNU 兼容属性补充。
                 *   - pure/const：透传给 gcc，标记函数无副作用。
                 *   - may_alias/nothrow/visibility/nonnull/warn_unused_result/
                 *     sentinel/malloc/fastcall/stdcall/cdecl：静默忽略。 */
                if (ark_streq(nm, "pure") || ark_streq(nm, "__pure__")) {
                    g_func_is_pure = 1;
                }
                if (ark_streq(nm, "const") || ark_streq(nm, "__const__")) {
                    g_func_is_const_attr = 1;
                }
                /* 静默忽略的属性：may_alias/nothrow/visibility/nonnull/
                 * warn_unused_result/sentinel/malloc/fastcall/stdcall/cdecl */
                if (ark_streq(nm, "may_alias") || ark_streq(nm, "__may_alias__") ||
                    ark_streq(nm, "nothrow") || ark_streq(nm, "__nothrow__") ||
                    ark_streq(nm, "visibility") || ark_streq(nm, "__visibility__") ||
                    ark_streq(nm, "nonnull") || ark_streq(nm, "__nonnull__") ||
                    ark_streq(nm, "warn_unused_result") || ark_streq(nm, "__warn_unused_result__") ||
                    ark_streq(nm, "sentinel") || ark_streq(nm, "__sentinel__") ||
                    ark_streq(nm, "malloc") || ark_streq(nm, "__malloc__") ||
                    ark_streq(nm, "fastcall") || ark_streq(nm, "__fastcall__") ||
                    ark_streq(nm, "stdcall") || ark_streq(nm, "__stdcall__") ||
                    ark_streq(nm, "cdecl") || ark_streq(nm, "__cdecl__")) {
                    /* 静默忽略 */
                }
                /* noreturn 等静默忽略 */
            }
        } else {
            lexer_advance(p->lex);
        }
        if (lexer_peek(p->lex).kind == TOK_COMMA) lexer_advance(p->lex);
    }
    if (lexer_peek(p->lex).kind == TOK_RPAREN) lexer_advance(p->lex);
    if (lexer_peek(p->lex).kind == TOK_RPAREN) lexer_advance(p->lex);
}

/* 解析初始化器：{ ... } 或普通表达式 */
static AstNode *parse_init_list(Parser *p) {
    int line = lexer_peek(p->lex).line;
    AstNode *n = ast_new(AST_INIT_LIST, line);
    n->u.init_list.items = 0;
    n->u.init_list.item_count = 0;
    lexer_advance(p->lex); /* '{' */
    while (lexer_peek(p->lex).kind != TOK_RBRACE &&
           lexer_peek(p->lex).kind != TOK_EOF) {
        AstNode *item = 0;
        AstNode *value;
        int has_field = 0, has_index = 0, idx_val = 0;
        char *field_name = 0;
        if (lexer_peek(p->lex).kind == TOK_DOT) {
            lexer_advance(p->lex);
            if (lexer_peek(p->lex).kind == TOK_IDENT) {
                field_name = mem_strdup(lexer_peek(p->lex).str);
                has_field = 1;
                lexer_advance(p->lex);
            }
            if (lexer_peek(p->lex).kind == TOK_ASSIGN) lexer_advance(p->lex);
        } else if (lexer_peek(p->lex).kind == TOK_LBRACKET) {
            lexer_advance(p->lex);
            if (lexer_peek(p->lex).kind == TOK_NUM) {
                idx_val = lexer_peek(p->lex).value;
                has_index = 1;
                lexer_advance(p->lex);
            }
            if (lexer_peek(p->lex).kind == TOK_RBRACKET) lexer_advance(p->lex);
            if (lexer_peek(p->lex).kind == TOK_ASSIGN) lexer_advance(p->lex);
        }
        value = parse_initializer(p);
        item = ast_new(AST_INIT_FIELD, line);
        item->u.init_field.field = field_name;
        item->u.init_field.has_field = has_field;
        item->u.init_field.index = idx_val;
        item->u.init_field.has_index = has_index;
        item->u.init_field.value = value;
        {
            int c = n->u.init_list.item_count;
            n->u.init_list.items = (AstNode **)mem_realloc(
                n->u.init_list.items,
                c * (int)sizeof(AstNode *),
                (c + 1) * (int)sizeof(AstNode *));
            n->u.init_list.items[c] = item;
            n->u.init_list.item_count = c + 1;
        }
        if (lexer_peek(p->lex).kind == TOK_COMMA) lexer_advance(p->lex);
    }
    if (lexer_peek(p->lex).kind == TOK_RBRACE) lexer_advance(p->lex);
    return n;
}

static AstNode *parse_initializer(Parser *p) {
    if (lexer_peek(p->lex).kind == TOK_LBRACE) return parse_init_list(p);
    return parse_assign_expr(p);
}

/* 推导未指定大小的最外层数组维度：
 *   char s[] = "abc"  -> size = strlen+1
 *   int  a[] = {1,2,3} -> size = 3
 *   int  a[] = {[2]=5} -> size = 3
 * 仅处理最外层 size==0 的数组；多层未指定维度需要更复杂推导，这里不处理。 */
static void infer_array_size_from_init(Type *t, AstNode *init) {
    if (!t || t->kind != TYPE_ARRAY || t->size != 0) return;
    if (!init) return;
    if (init->kind == AST_STR) {
        const char *s = init->u.name ? init->u.name : "";
        int n = 0;
        while (s[n]) n++;
        t->size = n + 1;  /* 包含终止 '\0' */
        return;
    }
    if (init->kind == AST_INIT_LIST) {
        int i;
        int sz = 0;
        int pos = 0;
        for (i = 0; i < init->u.init_list.item_count; i++) {
            AstNode *item = init->u.init_list.items[i];
            if (item && item->kind == AST_INIT_FIELD) {
                if (item->u.init_field.has_index) {
                    if (item->u.init_field.index + 1 > sz) sz = item->u.init_field.index + 1;
                } else {
                    pos++;
                }
            }
        }
        if (pos > sz) sz = pos;
        if (sz > 0) t->size = sz;
        return;
    }
    if (init->kind == AST_COMPOUND_LITERAL &&
        init->u.compound_lit.lit_type &&
        init->u.compound_lit.lit_type->kind == TYPE_ARRAY &&
        init->u.compound_lit.lit_type->size > 0) {
        t->size = init->u.compound_lit.lit_type->size;
        return;
    }
}

/* asm ("template" : outs : ins : clobbers) ;
 * 扩展内联汇编：捕获模板与三段操作数（outputs/inputs/clobbers）为原始字符串。
 * 段以顶层 ':' 分隔，整体以 ')' 结束。各段通过 token 拼写重建为字符串。 */
static AstNode *parse_asm_statement(Parser *p) {
    int line = lexer_peek(p->lex).line;
    AstNode *n = ast_new(AST_ASM, line);
    int is_vol = 0;
    n->u.asm_stmt.text = 0;
    n->u.asm_stmt.outputs = 0;
    n->u.asm_stmt.inputs = 0;
    n->u.asm_stmt.clobbers = 0;
    n->u.asm_stmt.is_volatile = 0;
    lexer_advance(p->lex); /* asm */
    while (lexer_peek(p->lex).kind == TOK_VOLATILE ||
           lexer_peek(p->lex).kind == TOK_CONST ||
           lexer_peek(p->lex).kind == TOK_INLINE) {
        if (lexer_peek(p->lex).kind == TOK_VOLATILE) is_vol = 1;
        lexer_advance(p->lex);
    }
    n->u.asm_stmt.is_volatile = is_vol;
    if (lexer_peek(p->lex).kind != TOK_LPAREN) return n;
    lexer_advance(p->lex);
    /* 模板字符串（可能是多段拼接，lexer 已合并） */
    {
        char *buf = 0;
        int blen = 0;
        while (lexer_peek(p->lex).kind == TOK_STR) {
            const char *s = lexer_peek(p->lex).str;
            int sl = ark_strlen(s);
            int nl = blen + sl;
            char *nb = (char *)mem_pool_alloc(nl + 1);
            int i;
            for (i = 0; i < blen; i++) nb[i] = buf[i];
            for (i = 0; i < sl; i++) nb[blen + i] = s[i];
            nb[nl] = 0;
            buf = nb;
            blen = nl;
            lexer_advance(p->lex);
        }
        n->u.asm_stmt.text = buf ? buf : mem_strdup("");
    }
    /* 扩展汇编操作数段：按 ':' 切分捕获 outputs / inputs / clobbers。
     * 每段扫描到顶层 ':' 或 ')' 为止，将 token 拼写重建为字符串。 */
    {
        int section = -1;  /* 第一个 ':' 后变 0=outputs, 1=inputs, 2=clobbers */
        while (lexer_peek(p->lex).kind != TOK_EOF &&
               lexer_peek(p->lex).kind != TOK_RPAREN) {
            /* 跳过段分隔 ':'：每遇一个冒号，段号 +1，随后收集的 token 归入该段 */
            if (lexer_peek(p->lex).kind == TOK_COLON) {
                lexer_advance(p->lex);
                section++;
                if (section > 2) section = 2;
                continue;
            }
            /* 收集当前段到顶层 ':' 或 ')' */
            {
                char *buf = 0;
                int blen = 0;
                int depth = 0;
                while (lexer_peek(p->lex).kind != TOK_EOF) {
                    Token t = lexer_peek(p->lex);
                    TokenKind k = t.kind;
                    const char *sp = 0;
                    char numbuf[16];
                    if (depth == 0 && (k == TOK_COLON || k == TOK_RPAREN)) break;
                    /* 追加 token 拼写 */
                    if (blen > 0) {
                        char *nb = (char *)mem_pool_alloc(blen + 2);
                        int i; for (i = 0; i < blen; i++) nb[i] = buf[i];
                        nb[blen] = ' '; nb[blen + 1] = 0;
                        buf = nb; blen = blen + 1;
                    }
                    switch (k) {
                        case TOK_STR: {
                            /* 字符串字面量：带引号重建 */
                            int sl = ark_strlen(t.str ? t.str : "");
                            char *nb = (char *)mem_pool_alloc(blen + sl + 3);
                            int i, j = 0;
                            for (i = 0; i < blen; i++) nb[j++] = buf[i];
                            nb[j++] = '"';
                            for (i = 0; i < sl; i++) nb[j++] = t.str[i];
                            nb[j++] = '"';
                            nb[j] = 0;
                            buf = nb; blen = j;
                            break;
                        }
                        case TOK_NUM: {
                            /* 整数字面量 */
                            int v = t.value;
                            int neg = 0; int m = 0; unsigned u;
                            if (v < 0) { neg = 1; u = (unsigned)(-v); } else u = (unsigned)v;
                            if (u == 0) numbuf[m++] = '0';
                            while (u) { numbuf[m++] = (char)('0' + (int)(u % 10)); u /= 10; }
                            {
                                char *nb = (char *)mem_pool_alloc(blen + m + neg + 1);
                                int i, j = 0;
                                for (i = 0; i < blen; i++) nb[j++] = buf[i];
                                if (neg) nb[j++] = '-';
                                for (i = m - 1; i >= 0; i--) nb[j++] = numbuf[i];
                                nb[j] = 0;
                                buf = nb; blen = j;
                            }
                            break;
                        }
                        case TOK_IDENT: sp = t.str ? t.str : ""; break;
                        case TOK_LPAREN: depth++; sp = "("; break;
                        case TOK_RPAREN: depth--; sp = ")"; break;
                        case TOK_COMMA:  sp = ","; break;
                        case TOK_MINUS:  sp = "-"; break;
                        case TOK_PLUS:   sp = "+"; break;
                        case TOK_MUL:    sp = "*"; break;
                        case TOK_BAND:   sp = "&"; break;
                        case TOK_ASSIGN: sp = "="; break;
                        case TOK_DOT:    sp = "."; break;
                        case TOK_ARROW:  sp = "->"; break;
                        case TOK_LBRACKET: sp = "["; break;
                        case TOK_RBRACKET: sp = "]"; break;
                        case TOK_LBRACE: sp = "{"; break;
                        case TOK_RBRACE: sp = "}"; break;
                        default:         sp = ""; break;
                    }
                    if (sp) {
                        int sl = ark_strlen(sp);
                        char *nb = (char *)mem_pool_alloc(blen + sl + 1);
                        int i, j = 0;
                        for (i = 0; i < blen; i++) nb[j++] = buf[i];
                        for (i = 0; i < sl; i++) nb[j++] = sp[i];
                        nb[j] = 0;
                        buf = nb; blen = j;
                    }
                    lexer_advance(p->lex);
                }
                /* 写入对应段（section 由前置 ':' 决定；<0 表示模板后无冒号，忽略） */
                {
                    char *sec = buf ? buf : mem_strdup("");
                    if (section < 0) {
                        /* 模板后直接出现非冒号 token：忽略，避免误写 */
                    } else if (section == 0)      n->u.asm_stmt.outputs = sec;
                    else if (section == 1)       n->u.asm_stmt.inputs = sec;
                    else                         n->u.asm_stmt.clobbers = sec;
                }
            }
        }
        if (lexer_peek(p->lex).kind == TOK_RPAREN) lexer_advance(p->lex);
    }
    if (lexer_peek(p->lex).kind == TOK_SEMICOLON) lexer_advance(p->lex);
    return n;
}

/* 解析 declspec：返回基础类型；同时通过指针返回 storage class 与 is_typedef */
static Type *parse_declspec(Parser *p, int *p_storage, int *p_is_typedef) {
    int sto = 0;
    int is_td = 0;
    int sign = 0;     /* 0=default, 1=signed, 2=unsigned */
    int long_count = 0;
    Type *base = 0;
    int saw_kw = 0;
    int packed_pending = 0;  /* __packed 关键字独立形式：作用于下一个 struct/union 或指针 */
    int complex_pending = 0; /* B4: _Complex 修饰符 */
    Token tok;
    /* 每次 declspec 开始时复位 packed 指针标记，避免跨声明/转换泄漏。
     * 若本 declspec 看到 __packed，循环内会重新置 1。 */
    g_decl_packed_ptr = 0;
    /* 解析关键字直到不再匹配 */
    for (;;) {
        tok = lexer_peek(p->lex);
        switch (tok.kind) {
            case TOK_ATTRIBUTE:
                /* declspec 级别的 attribute：暂时丢弃 */
                parse_attribute(p, 0);
                saw_kw = 1;
                continue;
            case TOK_CONST: case TOK_VOLATILE: case TOK_RESTRICT: case TOK_INLINE:
                if (tok.kind == TOK_CONST) g_decl_is_const = 1;
                lexer_advance(p->lex);
                saw_kw = 1;
                continue;
            case TOK_PACKED_KW:
                /* ARM Compiler 5 风格：__packed 出现在 declspec 中。
                 * 对 struct/union 类型等价于 __attribute__((packed))；
                 * 对指针类型（如 __packed int *p）标记为 packed 指针，
                 * 由 irgen/ARM 后端实现按字节访问未对齐目标的语义。 */
                packed_pending = 1;
                g_decl_packed_ptr = 1;
                lexer_advance(p->lex);
                saw_kw = 1;
                continue;
            case TOK_STATIC:   sto |= STO_STATIC;   lexer_advance(p->lex); saw_kw = 1; continue;
            case TOK_EXTERN:   sto |= STO_EXTERN;   lexer_advance(p->lex); saw_kw = 1; continue;
            case TOK_AUTO:     sto |= STO_AUTO;     lexer_advance(p->lex); saw_kw = 1; continue;
            case TOK_REGISTER: sto |= STO_REGISTER; lexer_advance(p->lex); saw_kw = 1; continue;
            case TOK_TYPEDEF:  is_td = 1; lexer_advance(p->lex); saw_kw = 1; continue;
            case TOK_SIGNED:   sign = 1; lexer_advance(p->lex); saw_kw = 1; continue;
            case TOK_UNSIGNED: sign = 2; lexer_advance(p->lex); saw_kw = 1; continue;
            case TOK_LONG:     long_count++; lexer_advance(p->lex); saw_kw = 1; continue;
#if ARKCC_FEATURE_ARMCC_KEYWORDS
            case TOK_TYPEDEF_KW:
                /* __typedef：等价 typedef */
                is_td = 1; lexer_advance(p->lex); saw_kw = 1; continue;
            case TOK_THREAD:
                /* __thread：线程局部存储。设置存储类标志位 0x10000，
                 * 由 parse_top_decl/parse_local_var_decl 读取并写入 var.is_tls。
                 * 不影响类型推导。 */
                sto |= 0x10000;
                lexer_advance(p->lex);
                saw_kw = 1;
                continue;
            case TOK_INT8:    lexer_advance(p->lex); if (!base) base = type_char();  saw_kw = 1; continue;
            case TOK_INT16:   lexer_advance(p->lex); if (!base) base = type_short(); saw_kw = 1; continue;
            case TOK_INT32:   lexer_advance(p->lex); if (!base) base = type_int();   saw_kw = 1; continue;
            case TOK_INT64:   lexer_advance(p->lex); if (!base) base = type_llong(); saw_kw = 1; continue;
#endif
            case TOK_SHORT:    /* 设置 short 标记 */ {
                lexer_advance(p->lex);
                if (!base) base = type_short();
                saw_kw = 1; continue;
            }
            case TOK_INT:
                lexer_advance(p->lex);
                if (!base) base = type_int();
                saw_kw = 1; continue;
            case TOK_CHAR:
                lexer_advance(p->lex);
                if (!base) base = type_char();
                saw_kw = 1; continue;
            case TOK_VOID:
                lexer_advance(p->lex);
                if (!base) base = type_void();
                saw_kw = 1; continue;
            case TOK_BOOL:
                lexer_advance(p->lex);
                if (!base) base = type_bool();
                saw_kw = 1; continue;
            case TOK_FLOAT:
                lexer_advance(p->lex);
                if (!base) base = type_float();
                saw_kw = 1; continue;
            case TOK_DOUBLE:
                lexer_advance(p->lex);
                if (!base) base = type_double();
                saw_kw = 1; continue;
            case TOK_COMPLEX:
#if ARKCC_FEATURE_COMPLEX
                /* B4: _Complex 修饰符；作用于后续 float/double（默认 double）。
                 * 编译期 + 运行时双重守护。 */
                if (g_config.enable_complex) complex_pending = 1;
#endif
                lexer_advance(p->lex);
                saw_kw = 1; continue;
            case TOK_STRUCT:
            case TOK_UNION: {
                int is_union = (tok.kind == TOK_UNION);
                AstNode *def;
                def = parse_struct_or_union(p, is_union);
                if (def) base = def->type;
                /* __packed 前缀：等价 __attribute__((packed)) */
                if (packed_pending && base) {
                    base->is_packed = 1;
                    packed_pending = 0;
                }
                saw_kw = 1;
                continue;
            }
            case TOK_ENUM: {
                AstNode *en = parse_enum(p);
                if (en) base = en->type;
                else base = type_int();
                saw_kw = 1;
                continue;
            }
            case TOK_IDENT: {
                if (sym_is_typedef(tok.str)) {
                    Symbol *s = sym_find(tok.str);
                    lexer_advance(p->lex);
                    if (s && s->type) base = s->type;
                    else base = type_int();
                    saw_kw = 1;
                    continue;
                }
                /* 否则不是声明的一部分，退出 */
                goto done;
            }
            default:
                goto done;
        }
    }
done:
    if (!base) {
        if (sign == 2) base = type_uint();
        else if (long_count >= 2) base = type_llong();
        else if (long_count == 1) base = type_long();
        else if (saw_kw) base = type_int();
        else return 0;
    } else {
        if (long_count >= 2 && base->kind == TYPE_INT) base = type_llong();
        else if (long_count == 1 && base->kind == TYPE_INT) base = type_long();
        if (sign == 2) {
            /* 切换到 unsigned 变体（仅针对整数类型） */
            switch (base->kind) {
                case TYPE_CHAR:  base = type_uchar();  break;
                case TYPE_SHORT: base = type_ushort(); break;
                case TYPE_INT:   base = type_uint();   break;
                case TYPE_LONG:  base = type_ulong();  break;
                case TYPE_LLONG: base = type_ullong(); break;
                default: break;
            }
        }
    }
    if (p_storage) *p_storage = sto;
    if (p_is_typedef) *p_is_typedef = is_td;
    (void)packed_pending; /* __packed 用于非 struct 类型时静默忽略 */
#if ARKCC_FEATURE_COMPLEX
    /* B4: _Complex 修饰。_Complex double → type_complex(double)；
     * _Complex float → type_complex(float)；
     * _Complex（无 float/double）默认按 _Complex double。 */
    if (complex_pending && g_config.enable_complex) {
        if (!base || (base->kind != TYPE_FLOAT && base->kind != TYPE_DOUBLE)) {
            base = type_double();
        }
        base = type_complex(base);
    }
#endif
    return base;
}

/* struct/union：parse 解析定义或引用，将类型登记到 sym 表的 tag 命名空间 */
static AstNode *parse_struct_or_union(Parser *p, int is_union) {
    char *tag = 0;
    Type *t = 0;
    Type *attr_tmp = 0;   /* 承载前导 __attribute__ 的临时类型 */
    int   has_attr = 0;
    Token tk;
    int line = lexer_peek(p->lex).line;
    lexer_advance(p->lex); /* struct/union */
    /* 前导 __attribute__ 可出现在 tag 之前：struct __attribute__((packed)) Tag {...}
     * 先用临时类型承载 packed/aligned，稍后合并到真正类型上。 */
    while (lexer_peek(p->lex).kind == TOK_ATTRIBUTE) {
        if (!attr_tmp) attr_tmp = type_struct(0, is_union);
        parse_attribute(p, attr_tmp);
        has_attr = 1;
    }
    tk = lexer_peek(p->lex);
    if (tk.kind == TOK_IDENT) {
        tag = mem_strdup(tk.str);
        lexer_advance(p->lex);
        {
            /* 在 tag 命名空间找现有定义 */
            Symbol *s = sym_find(tag);
            if (s && (s->kind == SYM_STRUCT_TAG || s->kind == SYM_UNION_TAG)) {
                t = s->type;
            }
        }
    }
    if (lexer_peek(p->lex).kind == TOK_LBRACE) {
        if (!t || t->fields == 0) {
            t = type_struct(tag, is_union);
            if (tag) {
                Symbol *sm = sym_add(is_union ? SYM_UNION_TAG : SYM_STRUCT_TAG, tag, t, 0);
                (void)sm;
            }
        }
        /* 合并前导 attribute：必须在解析字段前设置，因 type_struct_add_field
         * 会依据 is_packed/align_override 调整对齐。 */
        if (has_attr && attr_tmp) {
            if (attr_tmp->is_packed) t->is_packed = 1;
            if (attr_tmp->align_override) t->align_override = attr_tmp->align_override;
        }
        lexer_advance(p->lex);
        while (lexer_peek(p->lex).kind != TOK_RBRACE &&
               lexer_peek(p->lex).kind != TOK_EOF) {
            int sto = 0; int td = 0;
            Type *ft_base = parse_declspec(p, &sto, &td);
            if (!ft_base) { perror_at(p, "expected field type"); lexer_advance(p->lex); continue; }
            for (;;) {
                char *fname = 0;
                Type *ft = parse_declarator(p, ft_base, &fname);
                int bit_w = -1;
                if (lexer_peek(p->lex).kind == TOK_COLON) {
                    /* 位域：可能没有字段名 */
                    lexer_advance(p->lex);
                    if (lexer_peek(p->lex).kind == TOK_NUM) {
                        bit_w = lexer_peek(p->lex).value;
                        lexer_advance(p->lex);
                    }
                }
                /* 字段尾部可能挂 __attribute__((packed)) 等 */
                while (lexer_peek(p->lex).kind == TOK_ATTRIBUTE) parse_attribute(p, t);
                if (bit_w >= 0) {
                    type_struct_add_bitfield(t, fname ? fname : "", ft, bit_w);
                } else if (fname) {
                    type_struct_add_field(t, fname, ft);
                } else if (ft && (ft->kind == TYPE_STRUCT || ft->kind == TYPE_UNION)) {
                    /* 匿名 struct/union 成员（CMSIS 寄存器布局常用）：把内层
                     * 字段以同偏移基址平铺到 parent，名字直接可在外层访问。 */
                    type_struct_add_anonymous(t, ft);
                }
                if (lexer_peek(p->lex).kind == TOK_COMMA) { lexer_advance(p->lex); continue; }
                break;
            }
            lexer_expect(p->lex, TOK_SEMICOLON);
        }
        lexer_expect(p->lex, TOK_RBRACE);
        /* 结构体定义后可能有 __attribute__((packed/aligned)) */
        while (lexer_peek(p->lex).kind == TOK_ATTRIBUTE) parse_attribute(p, t);
    } else if (!t) {
        /* forward declaration */
        t = type_struct(tag, is_union);
        if (has_attr && attr_tmp) {
            if (attr_tmp->is_packed) t->is_packed = 1;
            if (attr_tmp->align_override) t->align_override = attr_tmp->align_override;
        }
        if (tag) sym_add(is_union ? SYM_UNION_TAG : SYM_STRUCT_TAG, tag, t, 0);
    } else if (has_attr && attr_tmp) {
        /* 引用已有类型时也应用前导 attribute */
        if (attr_tmp->is_packed) t->is_packed = 1;
        if (attr_tmp->align_override) t->align_override = attr_tmp->align_override;
    }
    {
        AstNode *n = ast_new(AST_VAR_DECL, line);
        n->type = t;
        n->u.var.var_type = t;
        return n;
    }
}

static AstNode *parse_enum(Parser *p) {
    char *tag = 0;
    Type *t;
    int next_val = 0;
    int line = lexer_peek(p->lex).line;
    lexer_advance(p->lex); /* enum */
    if (lexer_peek(p->lex).kind == TOK_IDENT) {
        tag = mem_strdup(lexer_peek(p->lex).str);
        lexer_advance(p->lex);
    }
    t = type_enum(tag);
    if (tag) sym_add(SYM_ENUM_TAG, tag, t, 0);
    if (lexer_peek(p->lex).kind == TOK_LBRACE) {
        lexer_advance(p->lex);
        while (lexer_peek(p->lex).kind != TOK_RBRACE &&
               lexer_peek(p->lex).kind != TOK_EOF) {
            Token nt = lexer_peek(p->lex);
            if (nt.kind != TOK_IDENT) { perror_at(p, "expected enum name"); lexer_advance(p->lex); continue; }
            lexer_advance(p->lex);
            if (lexer_peek(p->lex).kind == TOK_ASSIGN) {
                Token vt;
                lexer_advance(p->lex);
                vt = lexer_peek(p->lex);
                if (vt.kind == TOK_NUM) { next_val = vt.value; lexer_advance(p->lex); }
                else if (vt.kind == TOK_MINUS && lexer_peek2(p->lex).kind == TOK_NUM) {
                    lexer_advance(p->lex);
                    next_val = -lexer_peek(p->lex).value;
                    lexer_advance(p->lex);
                }
                else perror_at(p, "expected enum value (simple int)");
            }
            {
                Symbol *s = sym_add(SYM_ENUM_CONST, nt.str, type_int(), 0);
                s->enum_value = next_val;
            }
            next_val++;
            if (lexer_peek(p->lex).kind == TOK_COMMA) lexer_advance(p->lex);
        }
        lexer_expect(p->lex, TOK_RBRACE);
    }
    {
        AstNode *n = ast_new(AST_VAR_DECL, line);
        n->type = t;
        n->u.var.var_type = t;
        return n;
    }
}

/* declarator：处理 * 修饰、数组维度、函数参数；返回最终类型，并把名字写到 out_name。
 *
 * 实现简化：不支持 (*fn_ptr)(int) 这种带括号声明子，仅支持线性 "**name[...][...]"。
 * 但要识别带括号的函数指针语法用于跳过。
 */
static Type *parse_declarator(Parser *p, Type *base, char **out_name) {
    Type *t = base;
    /* 指针 */
    while (lexer_peek(p->lex).kind == TOK_MUL) {
        lexer_advance(p->lex);
        skip_qualifiers(p);
        t = type_pointer(t);
        /* __packed 指针：标记此指针类型为 packed，irgen/ARM 后端据此
         * 使用按字节访问而非 LDR/STR，避免未对齐访问异常。
         * 标志在每个指针层都设置（支持 __packed int **p 这类多重指针）。 */
        if (g_decl_packed_ptr) t->is_packed = 1;
    }
    /* 可选的带括号声明子（函数指针）：("(" "*" name ")" "(" params ")") */
    if (lexer_peek(p->lex).kind == TOK_LPAREN &&
        lexer_peek2(p->lex).kind == TOK_MUL) {
        /* 跳过 (*name) */
        lexer_advance(p->lex); /* '(' */
        lexer_advance(p->lex); /* '*' */
        while (lexer_peek(p->lex).kind == TOK_MUL) lexer_advance(p->lex);
        if (lexer_peek(p->lex).kind == TOK_IDENT) {
            if (out_name) *out_name = mem_strdup(lexer_peek(p->lex).str);
            lexer_advance(p->lex);
        }
        lexer_expect(p->lex, TOK_RPAREN);
        /* 参数列表（忽略具体内容） */
        if (lexer_peek(p->lex).kind == TOK_LPAREN) {
            int depth = 0;
            lexer_advance(p->lex);
            depth = 1;
            while (depth > 0 && lexer_peek(p->lex).kind != TOK_EOF) {
                if (lexer_peek(p->lex).kind == TOK_LPAREN) depth++;
                else if (lexer_peek(p->lex).kind == TOK_RPAREN) depth--;
                if (depth > 0) lexer_advance(p->lex);
            }
            if (lexer_peek(p->lex).kind == TOK_RPAREN) lexer_advance(p->lex);
        }
        /* 视为函数指针 */
        t = type_pointer(t);
        return t;
    }
    if (lexer_peek(p->lex).kind == TOK_IDENT) {
        if (out_name) *out_name = mem_strdup(lexer_peek(p->lex).str);
        lexer_advance(p->lex);
    }
    /* 数组维度（支持多维） */
    {
        /* 收集维度，然后构造 array(array(...)) */
        int dims[8];
        int dim_count = 0;
        int vla_dim = -1;  /* B3: 非常量维度索引；-1 表示无 VLA */
        while (lexer_peek(p->lex).kind == TOK_LBRACKET) {
            int v = 0;
            lexer_advance(p->lex);  /* 吃掉 '[' */
            if (lexer_peek(p->lex).kind == TOK_RBRACKET) {
                v = 0;  /* 无维度：待推导（如 char s[] = "..."） */
            } else {
                /* C99：数组维度须为整型常量表达式。解析条件表达式后用
                 * eval_const_expr 编译期求值；失败回退到 1 避免空数组。
                 * 支持 1+2、SIZE+2（宏展开后）、sizeof(int)*2 等。 */
                AstNode *dim_expr = parse_cond_expr(p);
                int folded = 0;
                if (dim_expr && eval_const_expr(dim_expr, &folded) && folded > 0) {
                    v = folded;
                } else {
#if ARKCC_FEATURE_VLA
                    /* B3: 非常量维度 → 变长数组。仅记录首个 VLA 维度表达式，
                     * 由 parse_local_var_decl / parse_top_decl 取用。
                     * 编译期 + 运行时双重守护。 */
                    if (g_config.enable_vla && vla_dim < 0 && !g_vla_size_expr) {
                        vla_dim = dim_count;
                        g_vla_size_expr = dim_expr;
                        v = 0;  /* 占位；实际类型用 type_pointer */
                    } else {
                        v = 1;  /* 非常量或求值失败：占位维度 */
                    }
#else
                    v = 1;  /* 非常量或求值失败：占位维度 */
#endif
                }
            }
            if (lexer_peek(p->lex).kind == TOK_RBRACKET) lexer_advance(p->lex);
            if (dim_count < 8) dims[dim_count++] = v;
        }
        if (dim_count > 0) {
            int i;
            /* 从右到左构造嵌套数组；保留 size==0 表示待推导（如 char s[] = "..."）。
             * 柔性数组成员亦以 size==0 数组形式出现，由 type_struct_add_field 处理。 */
            for (i = dim_count - 1; i >= 0; i--) {
                if (i == vla_dim) {
                    /* B3: VLA 维度用指针替代数组；标记 is_vla。
                     * 后续 irgen 在变量声明处发 IR_ALLOCA 动态分配。 */
                    t = type_pointer(t);
                    t->is_vla = 1;
                } else {
                    t = type_array(t, dims[i]);
                }
            }
        }
    }
    return t;
}

/* __align(n) — ARM Compiler 5 对齐关键字；写入全局 g_decl_align_bytes */
/* __at(addr) — ARM Compiler 5 绝对地址；调用前 token 已确定为 TOK_AT。
 * 形如 __at(0x40020014) ：吃掉关键字与括号后写入 g_attr_has_at/g_attr_at_addr。
 * 调用方应在合适位置调用本函数，至少支持出现在 declspec 前和变量名后。 */
static void parse_at_keyword(Parser *p) {
    if (lexer_peek(p->lex).kind != TOK_AT) return;
    lexer_advance(p->lex);
    if (lexer_peek(p->lex).kind == TOK_LPAREN) {
        lexer_advance(p->lex);
        if (lexer_peek(p->lex).kind == TOK_NUM) {
            g_attr_at_addr = (unsigned)lexer_peek(p->lex).value;
            g_attr_has_at = 1;
            lexer_advance(p->lex);
        }
        if (lexer_peek(p->lex).kind == TOK_RPAREN) lexer_advance(p->lex);
    }
}

#if ARKCC_FEATURE_ARMCC_KEYWORDS
/* __global_reg(n) — ARM Compiler 5 全局寄存器变量声明。
 * 形如 __global_reg(6) int x; ：返回寄存器号，-1 表示未命中。 */
static int parse_global_reg(Parser *p) {
    int reg = -1;
    if (lexer_peek(p->lex).kind != TOK_GLOBAL_REG) return -1;
    lexer_advance(p->lex);
    if (lexer_peek(p->lex).kind == TOK_LPAREN) {
        lexer_advance(p->lex);
        if (lexer_peek(p->lex).kind == TOK_NUM) {
            reg = lexer_peek(p->lex).value;
            lexer_advance(p->lex);
        }
        if (lexer_peek(p->lex).kind == TOK_RPAREN) lexer_advance(p->lex);
    }
    return reg;
}

/* __smc(n) — ARM Compiler 5 SMC（安全监控调用）声明。
 * 与 __svc(n) 同构，返回编号，0 表示未命中。 */
static int parse_smc(Parser *p) {
    int num = 0;
    if (lexer_peek(p->lex).kind != TOK_SMC) return 0;
    lexer_advance(p->lex);
    if (lexer_peek(p->lex).kind == TOK_LPAREN) {
        lexer_advance(p->lex);
        if (lexer_peek(p->lex).kind == TOK_NUM) {
            num = lexer_peek(p->lex).value;
            lexer_advance(p->lex);
        }
        if (lexer_peek(p->lex).kind == TOK_RPAREN) lexer_advance(p->lex);
    }
    return num;
}
#endif

/* 顶层声明 */
static AstNode *parse_top_decl(Parser *p) {
    int storage = 0;
    int is_td = 0;
    Type *base;
    int line = lexer_peek(p->lex).line;
    int func_mods = 0;            /* __irq/__weak/__naked 位掩码：1/2/4 */
    int decl_is_const = 0;        /* 本声明的 const 状态（捕获后复位全局） */
    char *decl_section = 0;       /* 本声明的 section 名（捕获后复位全局） */
    int   is_asm_fn = 0;          /* __asm void fn(){...} 函数体汇编标记 */
    int   decl_align = 0;         /* __align(n) 解析结果 */
    int   decl_is_tls = 0;        /* __thread 线程局部存储标记 */
    int   smc_num = -1;           /* __smc(n) 编号；-1=未使用 */
    int   global_reg_num = -1;    /* __global_reg(n) 寄存器号；-1=未使用 */
    int   func_is_value_in_regs = 0;
    int   func_is_pure = 0;
    int   func_is_const_attr = 0;
    int   func_is_interwork = 0;
    int   func_is_deprecated_kw = 0;
    /* 复位 __attribute__ 驱动的函数属性全局，避免跨声明泄漏 */
    g_attr_is_weak = 0; g_attr_is_naked = 0; g_attr_is_irq = 0;
    g_attr_section = 0; g_decl_is_const = 0;
    g_attr_is_used = 0; g_attr_is_unused = 0;
    g_attr_alias_target = 0;
    g_attr_align_bytes = 0; g_decl_align_bytes = 0;
    g_attr_is_softfp = 0; g_attr_is_forceinline = 0;
    g_attr_has_at = 0; g_attr_at_addr = 0;
    g_attr_is_constructor = 0; g_attr_is_destructor = 0; g_attr_is_deprecated = 0;
    g_decl_packed_ptr = 0;  /* __packed 指针标记：每个声明开始时复位 */
    g_vla_size_expr = 0;  /* B3: 文件作用域不允许 VLA，复位防泄漏 */
    /* 0.6.x：复位 armcc 5 兼容函数修饰符全局 */
    g_func_is_value_in_regs = 0;
    g_func_is_pure = 0;
    g_func_is_const_attr = 0;
    g_func_is_interwork = 0;
    g_func_is_deprecated_kw = 0;
    /* armcc 风格 __asm void fn(){...} 整函数体汇编：在解析任何其他修饰符前识别 */
    if (lexer_peek(p->lex).kind == TOK_ASM) {
        /* 区分 __asm <type> name(...){...}（函数体汇编）与 __asm("..."); 内联 asm。
         * 启发式：紧随其后的 token 若是类型/限定符/类型 ident，则视为函数体汇编。
         * 由于此处处于顶层，asm 语句出现在顶层是非法的，故见 __asm 即按函数体汇编。 */
        Token t2 = lexer_peek2(p->lex);
        if (is_basic_type_token(t2.kind) ||
            (t2.kind == TOK_IDENT && sym_is_typedef(t2.str))) {
            is_asm_fn = 1;
            lexer_advance(p->lex);  /* 吃掉 __asm */
        }
    }
    /* __align(n)：可出现在 declspec 之前 */
    if (lexer_peek(p->lex).kind == TOK_ALIGN_KW) {
        lexer_advance(p->lex);
        if (lexer_peek(p->lex).kind == TOK_LPAREN) {
            lexer_advance(p->lex);
            if (lexer_peek(p->lex).kind == TOK_NUM) {
                decl_align = lexer_peek(p->lex).value;
                lexer_advance(p->lex);
            }
            if (lexer_peek(p->lex).kind == TOK_RPAREN) lexer_advance(p->lex);
        }
    }
    /* __at(addr)：可出现在 declspec 之前 */
    if (lexer_peek(p->lex).kind == TOK_AT) parse_at_keyword(p);
#if ARKCC_FEATURE_ARMCC_KEYWORDS
    /* __global_reg(n)：可出现在 declspec 之前（全局寄存器变量） */
    if (lexer_peek(p->lex).kind == TOK_GLOBAL_REG) {
        global_reg_num = parse_global_reg(p);
    }
#endif
    func_mods |= parse_func_modifiers(p);  /* 前置 __irq 等（返回类型前） */
    base = parse_declspec(p, &storage, &is_td);
    decl_is_const = g_decl_is_const;
    decl_section = g_attr_section;
    if (g_attr_align_bytes && !decl_align) decl_align = g_attr_align_bytes;
#if ARKCC_FEATURE_ARMCC_KEYWORDS
    /* __thread 在 parse_declspec 中设置 storage 的 0x10000 位 */
    decl_is_tls = (storage & 0x10000) ? 1 : 0;
    /* 解析后再次检查 __global_reg（可出现在类型后） */
    if (lexer_peek(p->lex).kind == TOK_GLOBAL_REG && global_reg_num < 0) {
        global_reg_num = parse_global_reg(p);
    }
#endif
    if (!base) {
        perror_at(p, "expected declaration at top level");
        return 0;
    }
    /* 仅 struct/union/enum；; */
    if (lexer_peek(p->lex).kind == TOK_SEMICOLON) {
        lexer_advance(p->lex);
        return ast_new(AST_BLOCK, line); /* 空占位 */
    }

    /* 收集一个声明子 */
    {
        char *name = 0;
        int svc_num = 0;
        func_mods |= parse_func_modifiers(p);  /* 类型后、声明子前 */
        /* __svc(n) 出现在类型与声明子之间 */
        if (lexer_peek(p->lex).kind == TOK_SVC) {
            svc_num = parse_svc(p);
        }
#if ARKCC_FEATURE_ARMCC_KEYWORDS
        /* __smc(n) 出现在类型与声明子之间，与 __svc 同位置 */
        if (lexer_peek(p->lex).kind == TOK_SMC) {
            smc_num = parse_smc(p);
        }
#endif
        func_mods |= parse_func_modifiers(p);  /* __svc 后 */
        /* 解析完函数修饰符后捕获 armcc 5 兼容属性 */
#if ARKCC_FEATURE_ARMCC_KEYWORDS
        func_is_value_in_regs = g_func_is_value_in_regs;
        func_is_pure          = g_func_is_pure;
        func_is_const_attr    = g_func_is_const_attr;
        func_is_interwork     = g_func_is_interwork;
        func_is_deprecated_kw = g_func_is_deprecated_kw;
#endif
        Type *t = parse_declarator(p, base, &name);
        if (!name) {
            perror_at(p, "expected identifier in declaration");
            return 0;
        }

        /* 函数定义 */
        if (lexer_peek(p->lex).kind == TOK_LPAREN) {
            AstNode **params = 0;
            int param_count = 0;
            int is_variadic = 0;
            Type *ret_type = t;
            AstNode *body = 0;

            lexer_advance(p->lex);
            if (lexer_peek(p->lex).kind == TOK_VOID && lexer_peek2(p->lex).kind == TOK_RPAREN) {
                lexer_advance(p->lex);
            } else if (lexer_peek(p->lex).kind != TOK_RPAREN) {
                for (;;) {
                    int psto = 0, ptd = 0;
                    Type *pbase;
                    Type *pt;
                    char *pname = 0;
                    if (lexer_peek(p->lex).kind == TOK_ELLIPSIS) {
                        lexer_advance(p->lex);
                        is_variadic = 1;
                        break;
                    }
                    pbase = parse_declspec(p, &psto, &ptd);
                    if (!pbase) { perror_at(p, "expected param type"); break; }
                    pt = parse_declarator(p, pbase, &pname);
                    if (!pname) pname = mem_strdup("_anon");
                    {
                        AstNode *param = ast_var_decl(pname, pt, 0, line);
                        params = (AstNode **)mem_realloc(params,
                            param_count * (int)sizeof(AstNode *),
                            (param_count + 1) * (int)sizeof(AstNode *));
                        params[param_count++] = param;
                    }
                    if (lexer_peek(p->lex).kind == TOK_COMMA) { lexer_advance(p->lex); continue; }
                    break;
                }
            }
            lexer_expect(p->lex, TOK_RPAREN);
            /* 函数声明/定义后可有 __attribute__ */
            while (lexer_peek(p->lex).kind == TOK_ATTRIBUTE) parse_attribute(p, ret_type);
            func_mods |= parse_func_modifiers(p);  /* 参数表后的 __irq 等 */
            /* 合并 __attribute__((weak/naked/interrupt)) 驱动的函数属性 */
            if (g_attr_is_irq)   func_mods |= 1;
            if (g_attr_is_weak)  func_mods |= 2;
            if (g_attr_is_naked) func_mods |= 4;
#if ARKCC_FEATURE_ARMCC_KEYWORDS
            /* 参数表后再次出现的 armcc 5 兼容修饰符，合并到本地 */
            if (g_func_is_value_in_regs) func_is_value_in_regs = 1;
            if (g_func_is_pure)          func_is_pure = 1;
            if (g_func_is_const_attr)    func_is_const_attr = 1;
            if (g_func_is_interwork)     func_is_interwork = 1;
            if (g_func_is_deprecated_kw) func_is_deprecated_kw = 1;
#endif
            if (lexer_peek(p->lex).kind == TOK_SEMICOLON) {
                AstNode *n;
                lexer_advance(p->lex);
                n = ast_func_def(name, ret_type, params, param_count, 0, line);
                n->kind = AST_FUNC_DECL;
                n->u.func.is_variadic = is_variadic;
                n->u.func.is_static = (storage & STO_STATIC) ? 1 : 0;
                n->u.func.svc_num = svc_num;
                n->u.func.is_irq   = (func_mods & 1) ? 1 : 0;
                n->u.func.is_weak  = (func_mods & 2) ? 1 : 0;
                n->u.func.is_naked = (func_mods & 4) ? 1 : 0;
                n->u.func.is_softfp     = ((func_mods & 8) || g_attr_is_softfp) ? 1 : 0;
                n->u.func.forceinline   = ((func_mods & 16) || g_attr_is_forceinline) ? 1 : 0;
                n->u.func.is_used       = g_attr_is_used;
                n->u.func.is_unused     = g_attr_is_unused;
                n->u.func.alias_target  = g_attr_alias_target;
                n->u.func.is_constructor = g_attr_is_constructor;
                n->u.func.is_destructor  = g_attr_is_destructor;
                n->u.func.is_deprecated  = g_attr_is_deprecated;
#if ARKCC_FEATURE_ARMCC_KEYWORDS
                n->u.func.is_value_in_regs = func_is_value_in_regs;
                n->u.func.is_pure          = func_is_pure;
                n->u.func.is_const_attr    = func_is_const_attr;
                n->u.func.is_interwork     = func_is_interwork;
                n->u.func.smc_num          = smc_num;
                n->u.func.global_reg       = global_reg_num;
                n->u.func.is_deprecated   |= func_is_deprecated_kw;
#endif
                return n;
            }
            /* __asm 函数体汇编：抓取 '{' 到匹配 '}' 之间的原始源码文本，
             * 然后由 lexer 跳过整个块。完成后构造 AST_ASM_FUNC 节点。 */
            if (is_asm_fn) {
                AstNode *n;
                const char *body_start = 0;
                const char *body_end = 0;
                char *body_text = 0;
                if (lexer_peek(p->lex).kind != TOK_LBRACE) {
                    perror_at(p, "expected '{' in __asm function body");
                } else {
                    Token lb = lexer_peek(p->lex);
                    /* lb.src_start 指向 '{' 位置 */
                    body_start = lb.src_start ? lb.src_start + 1 : 0;
                    /* 推进 lexer 跳到 '}' 之后 —— 用括号深度计数 */
                    {
                        int depth = 0;
                        for (;;) {
                            TokenKind k = lexer_peek(p->lex).kind;
                            if (k == TOK_EOF) break;
                            if (k == TOK_LBRACE) {
                                depth++;
                                lexer_advance(p->lex);
                                continue;
                            }
                            if (k == TOK_RBRACE) {
                                depth--;
                                if (depth == 0) {
                                    body_end = lexer_peek(p->lex).src_start;
                                    lexer_advance(p->lex);
                                    break;
                                }
                                lexer_advance(p->lex);
                                continue;
                            }
                            lexer_advance(p->lex);
                        }
                    }
                    if (body_start && body_end && body_end >= body_start) {
                        int blen = (int)(body_end - body_start);
                        body_text = mem_strndup(body_start, blen);
                    } else {
                        body_text = mem_strdup("");
                    }
                }
                n = ast_func_def(name, ret_type, params, param_count, 0, line);
                n->kind = AST_ASM_FUNC;
                n->u.func.is_variadic = is_variadic;
                n->u.func.is_static = (storage & STO_STATIC) ? 1 : 0;
                n->u.func.is_asm_func = 1;
                n->u.func.asm_body = body_text;
                n->u.func.is_used       = g_attr_is_used;
                n->u.func.is_unused     = g_attr_is_unused;
                n->u.func.alias_target  = g_attr_alias_target;
                n->u.func.is_constructor = g_attr_is_constructor;
                n->u.func.is_destructor  = g_attr_is_destructor;
                n->u.func.is_deprecated  = g_attr_is_deprecated;
#if ARKCC_FEATURE_ARMCC_KEYWORDS
                n->u.func.is_value_in_regs = func_is_value_in_regs;
                n->u.func.is_pure          = func_is_pure;
                n->u.func.is_const_attr    = func_is_const_attr;
                n->u.func.is_interwork     = func_is_interwork;
                n->u.func.smc_num          = smc_num;
                n->u.func.global_reg       = global_reg_num;
                n->u.func.is_deprecated   |= func_is_deprecated_kw;
#endif
                return n;
            }
            g_current_func_name = name;
            body = parse_block(p);
            {
                AstNode *n = ast_func_def(name, ret_type, params, param_count, body, line);
                n->u.func.is_variadic = is_variadic;
                n->u.func.is_static = (storage & STO_STATIC) ? 1 : 0;
                n->u.func.svc_num = svc_num;
                n->u.func.is_irq   = (func_mods & 1) ? 1 : 0;
                n->u.func.is_weak  = (func_mods & 2) ? 1 : 0;
                n->u.func.is_naked = (func_mods & 4) ? 1 : 0;
                n->u.func.is_softfp     = ((func_mods & 8) || g_attr_is_softfp) ? 1 : 0;
                n->u.func.forceinline   = ((func_mods & 16) || g_attr_is_forceinline) ? 1 : 0;
                n->u.func.is_used       = g_attr_is_used;
                n->u.func.is_unused     = g_attr_is_unused;
                n->u.func.alias_target  = g_attr_alias_target;
                n->u.func.is_constructor = g_attr_is_constructor;
                n->u.func.is_destructor  = g_attr_is_destructor;
                n->u.func.is_deprecated  = g_attr_is_deprecated;
#if ARKCC_FEATURE_ARMCC_KEYWORDS
                n->u.func.is_value_in_regs = func_is_value_in_regs;
                n->u.func.is_pure          = func_is_pure;
                n->u.func.is_const_attr    = func_is_const_attr;
                n->u.func.is_interwork     = func_is_interwork;
                n->u.func.smc_num          = smc_num;
                n->u.func.global_reg       = global_reg_num;
                n->u.func.is_deprecated   |= func_is_deprecated_kw;
#endif
                g_current_func_name = 0;
                return n;
            }
        }

        /* 顶层变量或 typedef */
        if (is_td) {
            sym_add(SYM_TYPEDEF, name, t, 0);
            /* 多个 typedef：同行 a, b, c; */
            while (lexer_peek(p->lex).kind == TOK_COMMA) {
                char *nm2 = 0;
                lexer_advance(p->lex);
                t = parse_declarator(p, base, &nm2);
                if (nm2) sym_add(SYM_TYPEDEF, nm2, t, 0);
            }
            lexer_expect(p->lex, TOK_SEMICOLON);
            {
                AstNode *n = ast_new(AST_TYPEDEF, line);
                n->u.var.name = name;
                n->u.var.var_type = t;
                return n;
            }
        }
        /* 全局变量 */
        {
            AstNode *init = 0;
            char *cur_section = decl_section;     /* 第一个变量使用 declspec/前置 attribute 捕获的段 */
            int   cur_const    = decl_is_const;
            /* 全局变量名后可能挂 __attribute__((...)) 或 __at(...) */
            while (lexer_peek(p->lex).kind == TOK_ATTRIBUTE ||
                   lexer_peek(p->lex).kind == TOK_AT) {
                if (lexer_peek(p->lex).kind == TOK_AT) {
                    parse_at_keyword(p);
                } else {
                    g_attr_section = 0;
                    parse_attribute(p, t);
                    if (g_attr_section) { cur_section = g_attr_section; }
                }
            }
            if (lexer_peek(p->lex).kind == TOK_ASSIGN) {
                lexer_advance(p->lex);
                init = parse_initializer(p);
            }
            /* 推导未指定大小的数组维度 */
            infer_array_size_from_init(t, init);
            {
                AstNode *n = ast_var_decl(name, t, init, line);
                n->u.var.is_global = 1;
                n->u.var.is_static = (storage & STO_STATIC) ? 1 : 0;
                n->u.var.is_extern = (storage & STO_EXTERN) ? 1 : 0;
                n->u.var.is_const  = cur_const;
                n->u.var.section   = cur_section;
                n->u.var.align_bytes = decl_align ? decl_align : g_attr_align_bytes;
                n->u.var.is_used    = g_attr_is_used;
                n->u.var.is_unused  = g_attr_is_unused;
                n->u.var.has_at     = g_attr_has_at;
                n->u.var.at_addr    = g_attr_at_addr;
#if ARKCC_FEATURE_ARMCC_KEYWORDS
                n->u.var.is_tls     = decl_is_tls;
                n->u.var.global_reg = global_reg_num;
#endif
                /* 处理同行多变量声明 a, b = 2; */
                while (lexer_peek(p->lex).kind == TOK_COMMA) {
                    char *nm2 = 0;
                    Type *t2;
                    AstNode *init2 = 0;
                    char *sec2 = 0;
                    lexer_advance(p->lex);
                    t2 = parse_declarator(p, base, &nm2);
                    while (lexer_peek(p->lex).kind == TOK_ATTRIBUTE) {
                        g_attr_section = 0;
                        parse_attribute(p, t2);
                        if (g_attr_section) sec2 = g_attr_section;
                    }
                    if (lexer_peek(p->lex).kind == TOK_ASSIGN) {
                        lexer_advance(p->lex);
                        init2 = parse_initializer(p);
                    }
                    infer_array_size_from_init(t2, init2);
                    if (nm2) {
                        AstNode *n2 = ast_var_decl(nm2, t2, init2, line);
                        n2->u.var.is_global = 1;
                        n2->u.var.is_static = (storage & STO_STATIC) ? 1 : 0;
                        n2->u.var.is_extern = (storage & STO_EXTERN) ? 1 : 0;
                        n2->u.var.is_const  = cur_const;
                        n2->u.var.section   = sec2;
                        /* 通过 block 包装：用 BLOCK 表示一组声明 */
                        if (n->kind != AST_BLOCK) {
                            AstNode *blk = ast_block(line);
                            block_add_stmt(blk, n);
                            block_add_stmt(blk, n2);
                            n = blk;
                        } else {
                            block_add_stmt(n, n2);
                        }
                    }
                }
                lexer_expect(p->lex, TOK_SEMICOLON);
                return n;
            }
        }
    }
}

static AstNode *parse_block(Parser *p) {
    int line = lexer_peek(p->lex).line;
    AstNode *blk;
    lexer_expect(p->lex, TOK_LBRACE);
    sym_enter_scope();
    blk = ast_block(line);
    while (lexer_peek(p->lex).kind != TOK_RBRACE &&
           lexer_peek(p->lex).kind != TOK_EOF) {
        AstNode *s = parse_statement(p);
        if (s) block_add_stmt(blk, s);
    }
    sym_leave_scope();
    lexer_expect(p->lex, TOK_RBRACE);
    return blk;
}

/* 局部变量声明（含同行多变量） */
static AstNode *parse_local_var_decl(Parser *p, Type *base, int storage, int is_typedef) {
    int line = lexer_peek(p->lex).line;
    AstNode *blk = 0;
    /* 捕获 declspec 中 const，局部变量 const 通常无段含义但保持传递 */
    int cur_const = g_decl_is_const;
    for (;;) {
        char *name = 0;
        Type *t = parse_declarator(p, base, &name);
        AstNode *init = 0;
        char *cur_section = 0;
        if (!name) {
            perror_at(p, "expected identifier in declaration");
            break;
        }
        if (is_typedef) {
            sym_add(SYM_TYPEDEF, name, t, 0);
        }
        while (lexer_peek(p->lex).kind == TOK_ATTRIBUTE) {
            g_attr_section = 0;
            parse_attribute(p, t);
            if (g_attr_section) cur_section = g_attr_section;
        }
        if (lexer_peek(p->lex).kind == TOK_ASSIGN) {
            lexer_advance(p->lex);
            init = parse_initializer(p);
        }
        infer_array_size_from_init(t, init);
        {
            AstNode *n = ast_var_decl(name, t, init, line);
            n->u.var.is_static = (storage & STO_STATIC) ? 1 : 0;
            n->u.var.is_extern = (storage & STO_EXTERN) ? 1 : 0;
            n->u.var.is_const  = cur_const;
            n->u.var.section   = cur_section;
            n->u.var.align_bytes = g_attr_align_bytes;
            n->u.var.is_used    = g_attr_is_used;
            n->u.var.is_unused  = g_attr_is_unused;
#if ARKCC_FEATURE_ARMCC_KEYWORDS
            /* __thread 局部变量（TLS 标记，仅静态局部有意义） */
            n->u.var.is_tls = (storage & 0x10000) ? 1 : 0;
#endif
#if ARKCC_FEATURE_VLA
            /* B3: 取用 parse_declarator 记录的 VLA 尺寸表达式 */
            if (g_vla_size_expr && g_config.enable_vla) {
                n->u.var.is_vla = 1;
                n->u.var.vla_size_expr = g_vla_size_expr;
                g_vla_size_expr = 0;
            }
#endif
            if (!blk) blk = n;
            else {
                if (blk->kind != AST_BLOCK) {
                    AstNode *b = ast_block(line);
                    b->u.block.is_decl_list = 1;  /* 逗号分隔声明块：不创建嵌套作用域 */
                    block_add_stmt(b, blk);
                    block_add_stmt(b, n);
                    blk = b;
                } else {
                    block_add_stmt(blk, n);
                }
            }
        }
        if (lexer_peek(p->lex).kind == TOK_COMMA) { lexer_advance(p->lex); continue; }
        break;
    }
    lexer_expect(p->lex, TOK_SEMICOLON);
    return blk;
}

static AstNode *parse_statement(Parser *p) {
    Token t = lexer_peek(p->lex);
    int line = t.line;

    if (t.kind == TOK_ASM) {
        AstNode *n = parse_asm_statement(p);
        return n;
    }

    if (is_decl_start(p) || lexer_peek(p->lex).kind == TOK_ALIGN_KW) {
        int sto = 0, td = 0;
        Type *base;
        int local_align = 0;
        /* 复位 const/section 全局，避免跨语句泄漏 */
        g_decl_is_const = 0; g_attr_section = 0;
        g_attr_align_bytes = 0;
        g_attr_is_used = 0; g_attr_is_unused = 0;
        g_decl_packed_ptr = 0;
        /* __align(n) 出现在局部声明前 */
        if (lexer_peek(p->lex).kind == TOK_ALIGN_KW) {
            lexer_advance(p->lex);
            if (lexer_peek(p->lex).kind == TOK_LPAREN) {
                lexer_advance(p->lex);
                if (lexer_peek(p->lex).kind == TOK_NUM) {
                    local_align = lexer_peek(p->lex).value;
                    lexer_advance(p->lex);
                }
                if (lexer_peek(p->lex).kind == TOK_RPAREN) lexer_advance(p->lex);
            }
        }
        base = parse_declspec(p, &sto, &td);
        if (local_align && !g_attr_align_bytes) g_attr_align_bytes = local_align;
        if (lexer_peek(p->lex).kind == TOK_SEMICOLON) {
            /* struct A {...}; 这种空声明 */
            lexer_advance(p->lex);
            return ast_new(AST_BLOCK, line);
        }
        return parse_local_var_decl(p, base, sto, td);
    }

    /* 标签语句 ident ':' */
    if (t.kind == TOK_IDENT && lexer_peek2(p->lex).kind == TOK_COLON) {
        char *name = mem_strdup(t.str);
        AstNode *body;
        lexer_advance(p->lex); /* ident */
        lexer_advance(p->lex); /* : */
        body = parse_statement(p);
        {
            AstNode *n = ast_new(AST_LABEL, line);
            n->u.label_stmt.name = name;
            n->u.label_stmt.stmt = body;
            return n;
        }
    }

    switch (t.kind) {
        case TOK_RETURN: {
            AstNode *val = 0;
            AstNode *n;
            lexer_advance(p->lex);
            if (lexer_peek(p->lex).kind != TOK_SEMICOLON)
                val = parse_expr(p);
            lexer_expect(p->lex, TOK_SEMICOLON);
            n = ast_new(AST_RETURN, line);
            n->u.unary.operand = val;
            n->u.unary.op = 0;
            return n;
        }
        case TOK_IF: {
            AstNode *cond, *then_s, *else_s = 0;
            lexer_advance(p->lex);
            lexer_expect(p->lex, TOK_LPAREN);
            cond = parse_expr(p);
            lexer_expect(p->lex, TOK_RPAREN);
            then_s = parse_statement(p);
            if (lexer_peek(p->lex).kind == TOK_ELSE) {
                lexer_advance(p->lex);
                else_s = parse_statement(p);
            }
            return ast_if(cond, then_s, else_s, line);
        }
        case TOK_WHILE: {
            AstNode *cond, *body;
            lexer_advance(p->lex);
            lexer_expect(p->lex, TOK_LPAREN);
            cond = parse_expr(p);
            lexer_expect(p->lex, TOK_RPAREN);
            body = parse_statement(p);
            return ast_while(cond, body, line);
        }
        case TOK_FOR: {
            AstNode *init = 0, *cond = 0, *step = 0, *body;
            lexer_advance(p->lex);
            lexer_expect(p->lex, TOK_LPAREN);
            sym_enter_scope();
            if (lexer_peek(p->lex).kind != TOK_SEMICOLON) {
                if (is_decl_start(p)) {
                    int sto = 0, td = 0;
                    Type *base;
                    g_decl_is_const = 0; g_attr_section = 0;
                    base = parse_declspec(p, &sto, &td);
                    init = parse_local_var_decl(p, base, sto, td);
                    /* parse_local_var_decl 已经 eat ';' */
                    goto for_have_init_semi;
                } else {
                    init = parse_expr(p);
                }
            }
            lexer_expect(p->lex, TOK_SEMICOLON);
        for_have_init_semi:
            if (lexer_peek(p->lex).kind != TOK_SEMICOLON)
                cond = parse_expr(p);
            lexer_expect(p->lex, TOK_SEMICOLON);
            if (lexer_peek(p->lex).kind != TOK_RPAREN)
                step = parse_expr(p);
            lexer_expect(p->lex, TOK_RPAREN);
            body = parse_statement(p);
            sym_leave_scope();
            return ast_for(init, cond, step, body, line);
        }
        case TOK_DO: {
            AstNode *body, *cond;
            AstNode *n;
            lexer_advance(p->lex);
            body = parse_statement(p);
            lexer_expect(p->lex, TOK_WHILE);
            lexer_expect(p->lex, TOK_LPAREN);
            cond = parse_expr(p);
            lexer_expect(p->lex, TOK_RPAREN);
            lexer_expect(p->lex, TOK_SEMICOLON);
            n = ast_new(AST_DO_WHILE, line);
            n->u.while_stmt.cond = cond;
            n->u.while_stmt.body = body;
            return n;
        }
        case TOK_SWITCH: {
            AstNode *e, *body, *n;
            lexer_advance(p->lex);
            lexer_expect(p->lex, TOK_LPAREN);
            e = parse_expr(p);
            lexer_expect(p->lex, TOK_RPAREN);
            body = parse_statement(p);
            n = ast_new(AST_SWITCH, line);
            n->u.switch_stmt.expr = e;
            n->u.switch_stmt.body = body;
            n->u.switch_stmt.cases = 0;
            n->u.switch_stmt.case_count = 0;
            n->u.switch_stmt.default_case = 0;
            return n;
        }
        case TOK_CASE: {
            AstNode *n;
            int v = 0;
            lexer_advance(p->lex);
            {
                Token vt = lexer_peek(p->lex);
                if (vt.kind == TOK_NUM) { v = vt.value; lexer_advance(p->lex); }
                else if (vt.kind == TOK_MINUS && lexer_peek2(p->lex).kind == TOK_NUM) {
                    lexer_advance(p->lex);
                    v = -lexer_peek(p->lex).value;
                    lexer_advance(p->lex);
                } else if (vt.kind == TOK_IDENT) {
                    Symbol *s = sym_find(vt.str);
                    if (s && s->kind == SYM_ENUM_CONST) v = s->enum_value;
                    lexer_advance(p->lex);
                }
            }
            lexer_expect(p->lex, TOK_COLON);
            n = ast_new(AST_CASE, line);
            n->u.case_stmt.value = v;
            n->u.case_stmt.stmt = parse_statement(p);
            return n;
        }
        case TOK_DEFAULT: {
            AstNode *n;
            lexer_advance(p->lex);
            lexer_expect(p->lex, TOK_COLON);
            n = ast_new(AST_DEFAULT, line);
            n->u.case_stmt.stmt = parse_statement(p);
            return n;
        }
        case TOK_GOTO: {
            AstNode *n;
            Token nt;
            lexer_advance(p->lex);
            nt = lexer_peek(p->lex);
            if (nt.kind != TOK_IDENT) { perror_at(p, "expected label name after goto"); }
            else lexer_advance(p->lex);
            lexer_expect(p->lex, TOK_SEMICOLON);
            n = ast_new(AST_GOTO, line);
            n->u.name = nt.kind == TOK_IDENT ? mem_strdup(nt.str) : mem_strdup("_bad_label");
            return n;
        }
        case TOK_BREAK:
            lexer_advance(p->lex);
            lexer_expect(p->lex, TOK_SEMICOLON);
            return ast_new(AST_BREAK, line);
        case TOK_CONTINUE:
            lexer_advance(p->lex);
            lexer_expect(p->lex, TOK_SEMICOLON);
            return ast_new(AST_CONTINUE, line);
        case TOK_LBRACE:
            return parse_block(p);
        case TOK_SEMICOLON:
            lexer_advance(p->lex);
            return ast_new(AST_BLOCK, line);
        default: {
            AstNode *e = parse_expr(p);
            AstNode *s;
            lexer_expect(p->lex, TOK_SEMICOLON);
            s = ast_new(AST_EXPR_STMT, line);
            s->u.unary.operand = e;
            return s;
        }
    }
}

static AstNode *parse_expr(Parser *p) {
    AstNode *e = parse_assign_expr(p);
    while (lexer_peek(p->lex).kind == TOK_COMMA) {
        int line = lexer_peek(p->lex).line;
        AstNode *r;
        AstNode *n;
        lexer_advance(p->lex);
        r = parse_assign_expr(p);
        n = ast_new(AST_COMMA, line);
        n->u.binary.left = e;
        n->u.binary.right = r;
        n->u.binary.op = (int)TOK_COMMA;
        e = n;
    }
    return e;
}

static AstNode *parse_assign_expr(Parser *p) {
    AstNode *left = parse_cond_expr(p);
    Token t = lexer_peek(p->lex);
    if (t.kind == TOK_ASSIGN || t.kind == TOK_ADD_ASSIGN || t.kind == TOK_SUB_ASSIGN ||
        t.kind == TOK_MUL_ASSIGN || t.kind == TOK_DIV_ASSIGN || t.kind == TOK_MOD_ASSIGN ||
        t.kind == TOK_AND_ASSIGN || t.kind == TOK_OR_ASSIGN || t.kind == TOK_XOR_ASSIGN ||
        t.kind == TOK_SHL_ASSIGN || t.kind == TOK_SHR_ASSIGN) {
        int op = (int)t.kind;
        AstNode *right;
        lexer_advance(p->lex);
        right = parse_assign_expr(p);
        return ast_assign(op, left, right, t.line);
    }
    return left;
}

static AstNode *parse_cond_expr(Parser *p) {
    AstNode *cond = parse_or_expr(p);
    if (lexer_peek(p->lex).kind == TOK_QUESTION) {
        int line = lexer_peek(p->lex).line;
        AstNode *te, *fe;
        AstNode *n;
        lexer_advance(p->lex);
        te = parse_expr(p);
        lexer_expect(p->lex, TOK_COLON);
        fe = parse_cond_expr(p);
        n = ast_new(AST_TERNARY, line);
        n->u.ternary.cond = cond;
        n->u.ternary.true_expr = te;
        n->u.ternary.false_expr = fe;
        return n;
    }
    return cond;
}

#define DEFINE_BINOP_LAYER(fn, next, cond_expr) \
static AstNode *fn(Parser *p) {                                  \
    AstNode *left = next(p);                                      \
    while (1) {                                                   \
        TokenKind k = lexer_peek(p->lex).kind;                    \
        if (cond_expr) {                                          \
            int line = lexer_peek(p->lex).line;                   \
            AstNode *right;                                       \
            lexer_advance(p->lex);                                \
            right = next(p);                                      \
            left = ast_binary((int)k, left, right, line);         \
        } else break;                                             \
    }                                                             \
    return left;                                                  \
}

DEFINE_BINOP_LAYER(parse_or_expr,     parse_and_expr,    (k == TOK_OR))
DEFINE_BINOP_LAYER(parse_and_expr,    parse_bitor_expr,  (k == TOK_AND))
DEFINE_BINOP_LAYER(parse_bitor_expr,  parse_bitxor_expr, (k == TOK_BOR))
DEFINE_BINOP_LAYER(parse_bitxor_expr, parse_bitand_expr, (k == TOK_BXOR))
DEFINE_BINOP_LAYER(parse_bitand_expr, parse_eq_expr,     (k == TOK_BAND))
DEFINE_BINOP_LAYER(parse_eq_expr,     parse_rel_expr,    (k == TOK_EQ || k == TOK_NE))
DEFINE_BINOP_LAYER(parse_rel_expr,    parse_shift_expr,  (k == TOK_LT || k == TOK_GT || k == TOK_LE || k == TOK_GE))
DEFINE_BINOP_LAYER(parse_shift_expr,  parse_add_expr,    (k == TOK_SHL || k == TOK_SHR))
DEFINE_BINOP_LAYER(parse_add_expr,    parse_mul_expr,    (k == TOK_PLUS || k == TOK_MINUS))
DEFINE_BINOP_LAYER(parse_mul_expr,    parse_cast_expr,   (k == TOK_MUL || k == TOK_DIV || k == TOK_MOD))

static int type_size_of_token(Parser *p) {
    int sto = 0, td = 0;
    Type *base = parse_declspec(p, &sto, &td);
    Type *t;
    char *nm = 0;
    if (!base) return 4;
    t = parse_declarator(p, base, &nm);
    (void)nm;
    return type_size(t);
}

static AstNode *parse_cast_expr(Parser *p) {
    /* 检查是否是 ( type-name ) expr */
    if (lexer_peek(p->lex).kind == TOK_LPAREN) {
        Token t2 = lexer_peek2(p->lex);
        if (is_basic_type_token(t2.kind) ||
            (t2.kind == TOK_IDENT && sym_is_typedef(t2.str))) {
            int sto = 0, td = 0;
            int line = lexer_peek(p->lex).line;
            Type *base;
            Type *t;
            char *nm = 0;
            AstNode *operand;
            lexer_advance(p->lex); /* '(' */
            base = parse_declspec(p, &sto, &td);
            t = parse_declarator(p, base, &nm);
            lexer_expect(p->lex, TOK_RPAREN);
            /* C99 复合字面量：(type){ ... } —— 视为匿名聚合并取地址 */
            if (lexer_peek(p->lex).kind == TOK_LBRACE) {
                AstNode *init = parse_init_list(p);
                AstNode *n = ast_new(AST_COMPOUND_LITERAL, line);
                n->type = t;
                n->u.compound_lit.lit_type = t;
                n->u.compound_lit.init = init;
                return n;
            }
            operand = parse_cast_expr(p);
            return ast_cast(t, operand, line);
        }
    }
    return parse_unary_expr(p);
}

static AstNode *parse_unary_expr(Parser *p) {
    Token t = lexer_peek(p->lex);
    int line = t.line;
    switch (t.kind) {
        case TOK_PLUS:
            lexer_advance(p->lex);
            return parse_cast_expr(p);
        case TOK_MINUS:
        case TOK_NOT:
        case TOK_BNOT:
        case TOK_INC:
        case TOK_DEC: {
            int op = (int)t.kind;
            lexer_advance(p->lex);
            return ast_unary(op, parse_cast_expr(p), line);
        }
        case TOK_MUL:
            lexer_advance(p->lex);
            return ast_unary((int)TOK_MUL, parse_cast_expr(p), line);
        case TOK_BAND:
            lexer_advance(p->lex);
            return ast_unary((int)TOK_BAND, parse_cast_expr(p), line);
        case TOK_SIZEOF: {
            int sz;
            lexer_advance(p->lex);
            if (lexer_peek(p->lex).kind == TOK_LPAREN) {
                Token t2 = lexer_peek2(p->lex);
                if (is_basic_type_token(t2.kind) ||
                    (t2.kind == TOK_IDENT && sym_is_typedef(t2.str))) {
                    lexer_advance(p->lex); /* '(' */
                    sz = type_size_of_token(p);
                    lexer_expect(p->lex, TOK_RPAREN);
                    return ast_sizeof_val(sz, line);
                }
            }
            /* sizeof expr：粗略地按 expr 类型推断，简化为 4 */
            {
                AstNode *e = parse_unary_expr(p);
                int s = 4;
                if (e && e->type) s = type_size(e->type);
                if (s <= 0) s = 4;
                return ast_sizeof_val(s, line);
            }
        }
        default:
            return parse_postfix_expr(p);
    }
}

static AstNode *parse_postfix_expr(Parser *p) {
    AstNode *node = parse_primary_expr(p);
    for (;;) {
        Token t = lexer_peek(p->lex);
        int line = t.line;
        if (t.kind == TOK_LBRACKET) {
            AstNode *idx;
            lexer_advance(p->lex);
            idx = parse_expr(p);
            lexer_expect(p->lex, TOK_RBRACKET);
            node = ast_array_access(node, idx, line);
        } else if (t.kind == TOK_LPAREN) {
            AstNode **args = 0;
            int arg_count = 0;
            char *callee_name;
            lexer_advance(p->lex);
            if (lexer_peek(p->lex).kind != TOK_RPAREN) {
                for (;;) {
                    AstNode *a = parse_assign_expr(p);
                    args = (AstNode **)mem_realloc(args,
                        arg_count * (int)sizeof(AstNode *),
                        (arg_count + 1) * (int)sizeof(AstNode *));
                    args[arg_count++] = a;
                    if (lexer_peek(p->lex).kind == TOK_COMMA) {
                        lexer_advance(p->lex);
                    } else break;
                }
            }
            lexer_expect(p->lex, TOK_RPAREN);
            if (node->kind != AST_VAR) {
                /* 函数指针调用：把 callee_name 设为占位 */
                callee_name = mem_strdup("?indirect");
            } else {
                callee_name = node->u.name;
            }
            node = ast_func_call(callee_name, args, arg_count, line);
        } else if (t.kind == TOK_DOT || t.kind == TOK_ARROW) {
            int is_arrow = (t.kind == TOK_ARROW);
            Token mt;
            lexer_advance(p->lex);
            mt = lexer_peek(p->lex);
            if (mt.kind != TOK_IDENT) {
                perror_at(p, "expected member name");
                return node;
            }
            lexer_advance(p->lex);
            node = ast_member(node, mt.str, is_arrow, line);
        } else if (t.kind == TOK_INC || t.kind == TOK_DEC) {
            AstNode *u;
            lexer_advance(p->lex);
            u = ast_unary((int)t.kind, node, line);
            u->u.unary.is_postfix = 1;
            node = u;
        } else break;
    }
    return node;
}

static AstNode *parse_primary_expr(Parser *p) {
    Token t = lexer_peek(p->lex);
    int line = t.line;
    if (t.kind == TOK_FCONST) {
        /* 浮点字面量：复用 AST_NUM 节点，借助新增字段 fval 与 type=double */
        AstNode *node;
        lexer_advance(p->lex);
        node = ast_new(AST_NUM, line);
        node->u.num_val = (int)t.fvalue;
        node->fval = t.fvalue;
        node->type = type_double();
        return node;
    }
    if (t.kind == TOK_NUM) {
        lexer_advance(p->lex);
        return ast_num(t.value, line);
    }
    if (t.kind == TOK_STR) {
        AstNode *sn;
        lexer_advance(p->lex);
        sn = ast_str(t.str, line);
#if ARKCC_FEATURE_WCHAR
        /* B2: lexer 把宽字符串 L"..." 的 value 置 1；这里给 AST_STR
         * 节点标注 wchar_t* 类型，irgen/后端据此发射宽字符串。 */
        if (t.value == 1 && g_config.enable_wchar) {
            sn->type = type_pointer(type_wchar());
        }
#endif
        return sn;
    }
    if (t.kind == TOK_IDENT) {
        /* __func__ 处理：返回当前函数名作为字符串字面量 */
        if (ark_streq(t.str, "__func__") || ark_streq(t.str, "__FUNCTION__") ||
            ark_streq(t.str, "__PRETTY_FUNCTION__")) {
            lexer_advance(p->lex);
            return ast_str(g_current_func_name ? g_current_func_name : "?", line);
        }
        /* 枚举常量直接展开为字面量 */
        Symbol *s = sym_find(t.str);
        if (s && s->kind == SYM_ENUM_CONST) {
            lexer_advance(p->lex);
            return ast_num(s->enum_value, line);
        }
        lexer_advance(p->lex);
        return ast_var(t.str, line);
    }
    if (t.kind == TOK_LPAREN) {
        AstNode *e;
        lexer_advance(p->lex);
        e = parse_expr(p);
        lexer_expect(p->lex, TOK_RPAREN);
        return e;
    }
    perror_at(p, "unexpected token in expression");
    lexer_advance(p->lex);
    return ast_num(0, line);
}
