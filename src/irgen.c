/* Ark C Compiler - irgen
 * AST -> 栈式 IR。
 *
 * 函数调用约定（与后端配合）：
 *   - 参数 0..N-1 在调用前依次以 PUSH 入虚栈；IR_CALL n 让后端把栈顶 n 个值
 *     依次取到对应寄存器/栈参中（顺序按 arg0..argN-1）。
 *   - 局部变量与参数在函数序言里通过 GETARG 复制到栈帧槽。
 *   - 字符串字面量通过字符串池 + IR_PUSH_STR 引用。
 *   - 全局变量通过 IR_PUSH_GLOBAL / IR_STORE_GLOBAL 引用。
 */
#include "irgen.h"
#include "symtab.h"
#include "memory.h"
#include "platform.h"
#include "common.h"
#include "sema.h"
#include "config.h"
#include "arkcc_config.h"

/* 内部缓冲区，用于把 AST 初始化列表序列化成 C 源码片段。
 * 64 KB 足够普通示例使用。 */
typedef struct StrBuf {
    char *data;
    int   len;
    int   cap;
} StrBuf;

static void sb_init(StrBuf *b) { b->data = (char *)mem_pool_alloc(256); b->len = 0; b->cap = 256; }
static void sb_putc(StrBuf *b, char c) {
    if (b->len + 1 >= b->cap) {
        int nc = b->cap * 2;
        b->data = (char *)mem_realloc(b->data, b->cap, nc);
        b->cap = nc;
    }
    b->data[b->len++] = c;
    b->data[b->len] = 0;
}
static void sb_puts(StrBuf *b, const char *s) { while (*s) sb_putc(b, *s++); }
static void sb_putd(StrBuf *b, int v) {
    char tmp[16]; int n = 0; unsigned u; int neg = 0; int i;
    if (v < 0) { neg = 1; u = (unsigned)(-v); } else u = (unsigned)v;
    if (u == 0) tmp[n++] = '0';
    while (u) { tmp[n++] = (char)('0' + u % 10); u /= 10; }
    if (neg) sb_putc(b, '-');
    for (i = n - 1; i >= 0; i--) sb_putc(b, tmp[i]);
}
static void sb_putf(StrBuf *b, double v) {
    /* 用最朴素的方式输出浮点：整数部分+'.' +9 位小数。 */
    int neg = 0;
    if (v < 0) { neg = 1; v = -v; }
    if (neg) sb_putc(b, '-');
    {
        long long ip = (long long)v;
        sb_putd(b, (int)ip);
        sb_putc(b, '.');
        v = v - (double)ip;
        {
            int k;
            for (k = 0; k < 6; k++) {
                v *= 10.0;
                {
                    int d = (int)v;
                    if (d > 9) d = 9;
                    sb_putc(b, (char)('0' + d));
                    v -= (double)d;
                }
            }
        }
    }
}
static void sb_putstr_lit(StrBuf *b, const char *s) {
    sb_putc(b, '"');
    while (*s) {
        unsigned char c = (unsigned char)*s++;
        switch (c) {
            case '\n': sb_puts(b, "\\n"); break;
            case '\t': sb_puts(b, "\\t"); break;
            case '\r': sb_puts(b, "\\r"); break;
            case '"':  sb_puts(b, "\\\""); break;
            case '\\': sb_puts(b, "\\\\"); break;
            default:
                if (c < 0x20 || c >= 0x7F) {
                    char buf[8];
                    const char *hex = "0123456789abcdef";
                    buf[0] = '\\'; buf[1] = 'x';
                    buf[2] = hex[(c >> 4) & 0xF];
                    buf[3] = hex[c & 0xF];
                    buf[4] = 0;
                    sb_puts(b, buf);
                } else sb_putc(b, (char)c);
                break;
        }
    }
    sb_putc(b, '"');
}

/* 把 AST 表达式以 C 源码形式追加到 sb，仅支持常量表达式与简单运算。 */
static void serialize_const_expr(StrBuf *b, AstNode *n) {
    if (!n) { sb_puts(b, "0"); return; }
    switch (n->kind) {
        case AST_NUM:
            if (n->type && (n->type->kind == TYPE_FLOAT || n->type->kind == TYPE_DOUBLE)) {
                sb_putf(b, n->fval);
            } else {
                sb_putd(b, n->u.num_val);
            }
            break;
        case AST_STR:
            sb_putstr_lit(b, n->u.name);
            break;
        case AST_UNARY:
            if (n->u.unary.op == (int)TOK_MINUS) { sb_putc(b, '-'); serialize_const_expr(b, n->u.unary.operand); }
            else if (n->u.unary.op == (int)TOK_BNOT) { sb_putc(b, '~'); serialize_const_expr(b, n->u.unary.operand); }
            else serialize_const_expr(b, n->u.unary.operand);
            break;
        case AST_BINARY: {
            const char *op = "+";
            switch (n->u.binary.op) {
                case (int)TOK_PLUS:  op = "+"; break;
                case (int)TOK_MINUS: op = "-"; break;
                case (int)TOK_MUL:   op = "*"; break;
                case (int)TOK_DIV:   op = "/"; break;
                case (int)TOK_MOD:   op = "%"; break;
                case (int)TOK_BAND:  op = "&"; break;
                case (int)TOK_BOR:   op = "|"; break;
                case (int)TOK_BXOR:  op = "^"; break;
                case (int)TOK_SHL:   op = "<<"; break;
                case (int)TOK_SHR:   op = ">>"; break;
                default: break;
            }
            sb_putc(b, '(');
            serialize_const_expr(b, n->u.binary.left);
            sb_puts(b, op);
            serialize_const_expr(b, n->u.binary.right);
            sb_putc(b, ')');
            break;
        }
        case AST_CAST:
            serialize_const_expr(b, n->u.unary.operand);
            break;
        case AST_SIZEOF:
            sb_putd(b, n->u.num_val);
            break;
        case AST_VAR:
            /* 引用全局变量或枚举常量：直接输出名字 */
            if (n->u.name) sb_puts(b, n->u.name);
            else sb_putd(b, 0);
            break;
        default:
            sb_putd(b, 0);
            break;
    }
}

static void serialize_init(StrBuf *b, AstNode *n) {
    if (!n) { sb_putd(b, 0); return; }
    if (n->kind == AST_INIT_LIST) {
        int i;
        sb_putc(b, '{');
        for (i = 0; i < n->u.init_list.item_count; i++) {
            AstNode *it = n->u.init_list.items[i];
            if (i) sb_putc(b, ',');
            if (it) {
                if (it->u.init_field.has_field) {
                    sb_putc(b, '.');
                    sb_puts(b, it->u.init_field.field);
                    sb_putc(b, '=');
                } else if (it->u.init_field.has_index) {
                    sb_putc(b, '[');
                    sb_putd(b, it->u.init_field.index);
                    sb_puts(b, "]=");
                }
                serialize_init(b, it->u.init_field.value);
            }
        }
        sb_putc(b, '}');
        return;
    }
    serialize_const_expr(b, n);
}

/* 把字符串字面量初始化 char a[]="..." 转成 init list（让 C 后端友好地直接保留字符串语法）。
 * 我们仅在序列化时按字符串字面量原样输出。 */

typedef struct {
    IrProgram *prog;
    IrFunc    *fn;
    int        bp;
    int        max_size;
    int        break_label;
    int        cont_label;
    /* switch 编译期信息 */
    int       *case_labels;     /* 每个 case 值对应的标签号 */
    int       *case_values;
    int        case_count;
    int        default_label;
    int        switch_end_label;
} IrGen;

static void irgen_stmt(IrGen *g, AstNode *node);
static void irgen_expr(IrGen *g, AstNode *node);
static void irgen_lvalue_addr(IrGen *g, AstNode *node);
/* 递归聚合初始化：将 init_list 中的标量值写入栈偏移 off 处的 t 实例。
 * 支持 C99 嵌套初始化列表、designated initializer（.field / [idx]）。 */
static void irgen_local_aggregate_init(IrGen *g, int off, Type *t, AstNode *init_list);
/* C99 复合字面量 (type){...}：登记为匿名全局 ark_cl_<n>，返回其名字。
 * 多次引用同一字面量会各自登记独立全局（符合 C99 语义：每次出现都是新对象）。 */
static const char *irgen_compound_literal(IrGen *g, AstNode *node);
/* 全局复合字面量计数器：进程级唯一，确保多函数多次出现名字不冲突。 */
static int g_compound_lit_counter = 0;

static int alloc_label(IrGen *g) {
    return g->fn->label_count++;
}

static int alloc_local(IrGen *g, int size) {
    /* 统一按 8 字节对齐分配槽位：保证 long long / double 位模式完整存放，
     * 避免 Windows LLP64 下 long=4 与 double=8 共用 union 时的高位丢失。 */
    int s = (size + 7) & ~7;
    int off;
    if (s <= 0) s = 8;
    off = g->bp;
    g->bp += s;
    if (g->bp > g->max_size) g->max_size = g->bp;
    return off;
}

/* 为函数内 static 局部变量构造全局化名字：ark_sl_<func>_<var>。
 * 不同函数的同名 static 局部互不冲突，且与用户定义的全局名隔开。
 * 返回的缓冲区来自内存池，整个编译期有效。 */
static char *static_local_name(const char *func, const char *var) {
    int nf = (int)ark_strlen(func);
    int nv = (int)ark_strlen(var);
    char *buf = (char *)mem_pool_alloc(nf + nv + 16);
    int p = 0;
    const char *pre = "ark_sl_";
    while (*pre) buf[p++] = *pre++;
    { int i; for (i = 0; i < nf; i++) buf[p++] = func[i]; }
    buf[p++] = '_';
    { int i; for (i = 0; i < nv; i++) buf[p++] = var[i]; }
    buf[p] = 0;
    return buf;
}

/* 第一遍遍历 switch body，收集 case/default 对应的标签号 */
typedef struct CaseList {
    int *labels;
    int *values;
    int  count;
    int  cap;
    int  default_label;
} CaseList;

static void collect_cases(IrGen *g, AstNode *node, CaseList *cl) {
    if (!node) return;
    if (node->kind == AST_CASE) {
        if (cl->count >= cl->cap) {
            int nc = cl->cap == 0 ? 8 : cl->cap * 2;
            cl->labels = (int *)mem_realloc(cl->labels, cl->cap * (int)sizeof(int), nc * (int)sizeof(int));
            cl->values = (int *)mem_realloc(cl->values, cl->cap * (int)sizeof(int), nc * (int)sizeof(int));
            cl->cap = nc;
        }
        cl->values[cl->count] = node->u.case_stmt.value;
        cl->labels[cl->count] = alloc_label(g);
        node->u.case_stmt.label_id = cl->labels[cl->count];
        cl->count++;
        collect_cases(g, node->u.case_stmt.stmt, cl);
        return;
    }
    if (node->kind == AST_DEFAULT) {
        if (cl->default_label < 0) {
            cl->default_label = alloc_label(g);
            node->u.case_stmt.label_id = cl->default_label;
        }
        collect_cases(g, node->u.case_stmt.stmt, cl);
        return;
    }
    if (node->kind == AST_SWITCH) {
        return; /* 嵌套 switch 由其自身处理 */
    }
    if (node->kind == AST_BLOCK) {
        int i;
        for (i = 0; i < node->u.block.stmt_count; i++)
            collect_cases(g, node->u.block.stmts[i], cl);
        return;
    }
    if (node->kind == AST_IF) {
        collect_cases(g, node->u.if_stmt.then_stmt, cl);
        collect_cases(g, node->u.if_stmt.else_stmt, cl);
        return;
    }
    if (node->kind == AST_WHILE || node->kind == AST_DO_WHILE) {
        collect_cases(g, node->u.while_stmt.body, cl);
        return;
    }
    if (node->kind == AST_FOR) {
        collect_cases(g, node->u.for_stmt.body, cl);
        return;
    }
    if (node->kind == AST_LABEL) {
        collect_cases(g, node->u.label_stmt.stmt, cl);
        return;
    }
    if (node->kind == AST_CASE) {
        /* already handled above */
    }
}

IrProgram *irgen_program(AstNode *prog) {
    IrProgram *out = ir_program_new();
    int i;
    sym_init();

    /* 第一遍：登记所有函数与全局变量 */
    for (i = 0; i < prog->u.program.decl_count; i++) {
        AstNode *d = prog->u.program.decls[i];
        if (d->kind == AST_FUNC_DEF || d->kind == AST_FUNC_DECL ||
            d->kind == AST_ASM_FUNC) {
            if (!sym_find(d->u.func.name)) {
                Symbol *s = sym_add(SYM_FUNC, d->u.func.name, d->u.func.ret_type, 0);
                s->param_count = d->u.func.param_count;
                s->is_variadic = d->u.func.is_variadic;
                s->svc_num = d->u.func.svc_num;
                s->is_asm_func = d->u.func.is_asm_func;
                s->alias_target = d->u.func.alias_target;
#if ARKCC_FEATURE_ARMCC_KEYWORDS
                s->smc_num = d->u.func.smc_num;
#endif
                if (d->kind == AST_FUNC_DEF || d->kind == AST_ASM_FUNC) s->is_defined = 1;
            }
        } else if (d->kind == AST_VAR_DECL && d->u.var.is_global) {
            if (!sym_find(d->u.var.name)) {
                IrGlobal *gv = ir_program_add_global(out, d->u.var.name, d->u.var.var_type);
                Symbol *s = sym_add(SYM_GLOBAL, d->u.var.name, d->u.var.var_type, 0);
                (void)s;
                gv->is_static = d->u.var.is_static;
                gv->is_extern = d->u.var.is_extern;
                gv->is_const = d->u.var.is_const;
                gv->section  = d->u.var.section;
                gv->align_bytes = d->u.var.align_bytes;
                gv->is_used   = d->u.var.is_used;
                gv->is_unused = d->u.var.is_unused;
                gv->has_at    = d->u.var.has_at;
                gv->at_addr   = d->u.var.at_addr;
#if ARKCC_FEATURE_ARMCC_KEYWORDS
                gv->is_tls     = d->u.var.is_tls;
                gv->global_reg = d->u.var.global_reg;
#endif
                if (d->u.var.init) {
                    AstNode *iv = d->u.var.init;
                    if (iv->kind == AST_NUM) {
                        gv->has_init = 1;
                        gv->init_int = iv->u.num_val;
                        if (iv->type && (iv->type->kind == TYPE_FLOAT || iv->type->kind == TYPE_DOUBLE)) {
                            gv->is_float = 1;
                            gv->init_float = iv->fval;
                        }
                    } else if (iv->kind == AST_STR) {
                        /* char a[]="hello" 或 char *p="..." */
                        gv->has_init = 1;
                        gv->init_str = iv->u.name;
                    } else if (iv->kind == AST_INIT_LIST) {
                        StrBuf sb; sb_init(&sb);
                        serialize_init(&sb, iv);
                        gv->has_init = 1;
                        gv->init_aggregate = sb.data;
                    } else if (iv->kind == AST_COMPOUND_LITERAL) {
                        /* 顶层复合字面量初始化全局：展开其 init 列表 */
                        StrBuf sb; sb_init(&sb);
                        serialize_init(&sb, iv->u.compound_lit.init);
                        gv->has_init = 1;
                        gv->init_aggregate = sb.data;
                    } else {
                        /* 非字面量表达式初值：先尝试常量求值
                         * (sizeof, 1+2, 字面量算术运算等)。
                         * 求值成功则按整型字面量存入 init_int，让 ARM 后端
                         * 能正确生成 .word 数据；C 后端走 init_aggregate
                         * 透传源码（含 enum 引用等）。 */
                        int cv = 0;
                        gv->has_init = 1;
                        if (eval_const_expr(iv, &cv)) {
                            gv->init_int = cv;
                        } else {
                            StrBuf sb; sb_init(&sb);
                            serialize_const_expr(&sb, iv);
                            gv->init_aggregate = sb.data;
                        }
                    }
                }
            }
        } else if (d->kind == AST_TYPEDEF) {
            if (d->u.var.name) sym_add(SYM_TYPEDEF, d->u.var.name, d->u.var.var_type, 0);
        } else if (d->kind == AST_BLOCK) {
            /* 多变量声明 */
            int j;
            for (j = 0; j < d->u.block.stmt_count; j++) {
                AstNode *c = d->u.block.stmts[j];
                if (c->kind == AST_VAR_DECL && c->u.var.is_global) {
                    if (!sym_find(c->u.var.name)) {
                        IrGlobal *gc = ir_program_add_global(out, c->u.var.name, c->u.var.var_type);
                        sym_add(SYM_GLOBAL, c->u.var.name, c->u.var.var_type, 0);
                        gc->is_static = c->u.var.is_static;
                        gc->is_extern = c->u.var.is_extern;
                        gc->is_const = c->u.var.is_const;
                        gc->section  = c->u.var.section;
                        gc->align_bytes = c->u.var.align_bytes;
                        gc->is_used   = c->u.var.is_used;
                        gc->is_unused = c->u.var.is_unused;
                        gc->has_at    = c->u.var.has_at;
                        gc->at_addr   = c->u.var.at_addr;
#if ARKCC_FEATURE_ARMCC_KEYWORDS
                        gc->is_tls     = c->u.var.is_tls;
                        gc->global_reg = c->u.var.global_reg;
#endif
                        if (c->u.var.init) {
                            AstNode *iv = c->u.var.init;
                            if (iv->kind == AST_NUM) {
                                gc->has_init = 1;
                                gc->init_int = iv->u.num_val;
                                if (iv->type && (iv->type->kind == TYPE_FLOAT || iv->type->kind == TYPE_DOUBLE)) {
                                    gc->is_float = 1;
                                    gc->init_float = iv->fval;
                                }
                            } else if (iv->kind == AST_STR) {
                                gc->has_init = 1;
                                gc->init_str = iv->u.name;
                            } else if (iv->kind == AST_INIT_LIST) {
                                StrBuf sb; sb_init(&sb);
                                serialize_init(&sb, iv);
                                gc->has_init = 1;
                                gc->init_aggregate = sb.data;
                            } else if (iv->kind == AST_COMPOUND_LITERAL) {
                                StrBuf sb; sb_init(&sb);
                                serialize_init(&sb, iv->u.compound_lit.init);
                                gc->has_init = 1;
                                gc->init_aggregate = sb.data;
                            } else {
                                int cv = 0;
                                gc->has_init = 1;
                                if (eval_const_expr(iv, &cv)) {
                                    gc->init_int = cv;
                                } else {
                                    StrBuf sb; sb_init(&sb);
                                    serialize_const_expr(&sb, iv);
                                    gc->init_aggregate = sb.data;
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    for (i = 0; i < prog->u.program.decl_count; i++) {
        AstNode *d = prog->u.program.decls[i];
        if (d->kind == AST_ASM_FUNC) {
            /* __asm 函数体：构造一个仅持有 asm_body 的 IrFunc，
             * 不生成任何 IR 指令；后端按 naked 风格直接发射汇编。 */
            IrFunc *fn = ir_func_new(d->u.func.name);
            fn->param_count = d->u.func.param_count;
            fn->is_static = d->u.func.is_static;
            fn->is_asm_func = 1;
            fn->asm_body = d->u.func.asm_body;
            fn->is_used = d->u.func.is_used;
            fn->is_unused = d->u.func.is_unused;
            fn->is_weak = d->u.func.is_weak;
            fn->alias_target = d->u.func.alias_target;
            fn->is_constructor = d->u.func.is_constructor;
            fn->is_destructor  = d->u.func.is_destructor;
            fn->is_deprecated  = d->u.func.is_deprecated;
#if ARKCC_FEATURE_ARMCC_KEYWORDS
            fn->is_value_in_regs = d->u.func.is_value_in_regs;
            fn->is_pure          = d->u.func.is_pure;
            fn->is_const_attr    = d->u.func.is_const_attr;
            fn->is_interwork     = d->u.func.is_interwork;
            fn->smc_num          = d->u.func.smc_num;
            fn->global_reg       = d->u.func.global_reg;
#endif
            ir_program_add(out, fn);
            continue;
        }
        if (d->kind == AST_FUNC_DECL) {
            /* 仅声明带 alias_target 的函数也要生成 IrFunc，让后端发出别名指令 */
            if (d->u.func.alias_target) {
                IrFunc *fn = ir_func_new(d->u.func.name);
                fn->param_count = d->u.func.param_count;
                fn->is_static = d->u.func.is_static;
                fn->is_used = d->u.func.is_used;
                fn->is_unused = d->u.func.is_unused;
                fn->is_weak = d->u.func.is_weak;
                fn->alias_target = d->u.func.alias_target;
                fn->is_constructor = d->u.func.is_constructor;
                fn->is_destructor  = d->u.func.is_destructor;
                fn->is_deprecated  = d->u.func.is_deprecated;
#if ARKCC_FEATURE_ARMCC_KEYWORDS
                fn->is_value_in_regs = d->u.func.is_value_in_regs;
                fn->is_pure          = d->u.func.is_pure;
                fn->is_const_attr    = d->u.func.is_const_attr;
                fn->is_interwork     = d->u.func.is_interwork;
                fn->smc_num          = d->u.func.smc_num;
                fn->global_reg       = d->u.func.global_reg;
#endif
                ir_program_add(out, fn);
            }
            continue;
        }
        if (d->kind == AST_FUNC_DEF) {
            IrGen g;
            int j;
            g.prog = out;
            g.fn = ir_func_new(d->u.func.name);
            g.fn->param_count = d->u.func.param_count;
            g.fn->is_variadic = d->u.func.is_variadic;
            g.fn->is_static = d->u.func.is_static;
            /* 传播 ARM Compiler 5 函数属性到 IrFunc，供后端生成
             * __attribute__((weak/naked)) 与 __irq 注释。 */
            g.fn->is_irq   = d->u.func.is_irq;
            g.fn->is_weak  = d->u.func.is_weak;
            g.fn->is_naked = d->u.func.is_naked;
            g.fn->is_used  = d->u.func.is_used;
            g.fn->is_unused= d->u.func.is_unused;
            g.fn->forceinline = d->u.func.forceinline;
            g.fn->alias_target = d->u.func.alias_target;
            g.fn->is_constructor = d->u.func.is_constructor;
            g.fn->is_destructor  = d->u.func.is_destructor;
            g.fn->is_deprecated  = d->u.func.is_deprecated;
#if ARKCC_FEATURE_ARMCC_KEYWORDS
            g.fn->is_value_in_regs = d->u.func.is_value_in_regs;
            g.fn->is_pure          = d->u.func.is_pure;
            g.fn->is_const_attr    = d->u.func.is_const_attr;
            g.fn->is_interwork     = d->u.func.is_interwork;
            g.fn->smc_num          = d->u.func.smc_num;
            g.fn->global_reg       = d->u.func.global_reg;
#endif
            g.bp = 0;
            g.max_size = 0;
            g.break_label = -1;
            g.cont_label = -1;
            g.case_labels = 0;
            g.case_values = 0;
            g.case_count = 0;
            g.default_label = -1;
            g.switch_end_label = -1;

            ir_emit(g.fn, IR_FUNC_BEGIN, 0, d->u.func.name, d->u.func.param_count);

            sym_enter_scope();
            for (j = 0; j < d->u.func.param_count; j++) {
                AstNode *pp = d->u.func.params[j];
                int sz = type_size(pp->u.var.var_type);
                int off;
                if (sz <= 0) sz = 4;
                off = alloc_local(&g, sz);
                {
                    Symbol *s = sym_add(SYM_PARAM, pp->u.var.name, pp->u.var.var_type, off);
                    (void)s;
                }
                ir_emit(g.fn, IR_GETARG, off, pp->u.var.name, j);
            }
            irgen_stmt(&g, d->u.func.body);
            ir_emit(g.fn, IR_PUSH_INT, 0, 0, 0);
            ir_emit(g.fn, IR_RETURN, 0, 0, 0);
            ir_emit(g.fn, IR_FUNC_END, 0, 0, 0);
            g.fn->local_size = (g.max_size + 7) & ~7;
            sym_leave_scope();
            ir_program_add(out, g.fn);
        }
    }
    return out;
}

/* 递归聚合初始化：将 init_list 中的标量值写入栈偏移 off 处的 t 实例。
 * 支持 C99 嵌套初始化列表与 designated initializer。
 *   - 数组：每个 item 按 [idx] 或位置写入 off + idx*elem_sz；
 *     若 item 本身是 INIT_LIST，按元素类型递归。
 *   - 结构体：每个 item 按 .field 或位置写入 off + field->offset；
 *     若 item 本身是 INIT_LIST，按字段类型递归。
 * 调用者应先清零整个区域，本函数仅覆盖显式初始化的元素。 */
static void irgen_local_aggregate_init(IrGen *g, int off, Type *t, AstNode *init_list) {
    int i;
    if (!init_list || init_list->kind != AST_INIT_LIST || !t) return;
    if (t->kind == TYPE_ARRAY) {
        Type *elem_t = t->base;
        int elem_sz = type_size(elem_t);
        int cur_idx = 0;
        if (elem_sz <= 0) elem_sz = 4;
        for (i = 0; i < init_list->u.init_list.item_count; i++) {
            AstNode *it = init_list->u.init_list.items[i];
            int idx;
            AstNode *val;
            if (!it) continue;
            idx = it->u.init_field.has_index ? it->u.init_field.index : cur_idx;
            cur_idx = idx + 1;
            val = it->u.init_field.value;
            if (!val) continue;
            if (val->kind == AST_INIT_LIST) {
                irgen_local_aggregate_init(g, off + idx * elem_sz, elem_t, val);
            } else {
                irgen_expr(g, val);
                ir_emit(g->fn, IR_STORE, off + idx * elem_sz, 0, 0);
            }
        }
    } else if (t->kind == TYPE_STRUCT || t->kind == TYPE_UNION) {
        StructField *f = t->fields;
        for (i = 0; i < init_list->u.init_list.item_count; i++) {
            AstNode *it = init_list->u.init_list.items[i];
            StructField *target = 0;
            AstNode *val;
            if (!it) continue;
            if (it->u.init_field.has_field) {
                target = type_find_field(t, it->u.init_field.field);
                /* designated 后，positional cursor 跳到 target 之后 */
                if (target) {
                    StructField *p = t->fields;
                    while (p && p != target) p = p->next;
                    f = p ? p->next : 0;
                }
            } else {
                target = f;
                if (f) f = f->next;
            }
            val = it->u.init_field.value;
            if (!target || !val) continue;
            if (val->kind == AST_INIT_LIST) {
                irgen_local_aggregate_init(g, off + target->offset, target->type, val);
            } else {
                irgen_expr(g, val);
                ir_emit(g->fn, IR_STORE, off + target->offset, 0, 0);
            }
        }
    }
    /* 标量类型不应作为聚合初始化目标；忽略 */
}

/* C99 复合字面量 (type){...}：登记为匿名全局，返回其名字。
 *   - 数组/结构体类型：把 init 序列化为 C 源码片段存入 init_aggregate
 *   - 标量类型 (int){42} 等：用 init_int 存储常量值
 * 后端按普通全局处理；引用时通过 PUSH_GLOBAL_ADDR 取地址。
 * 数组在多数上下文里 decay 为指针，所以 irgen_expr 也以地址作为其 rvalue。 */
static const char *irgen_compound_literal(IrGen *g, AstNode *node) {
    char namebuf[32];
    IrGlobal *gv;
    Type *t = node->u.compound_lit.lit_type;
    AstNode *init = node->u.compound_lit.init;
    /* 生成唯一名字 ark_cl_<n> */
    {
        int n = g_compound_lit_counter++;
        int i = 0;
        const char *pfx = "ark_cl_";
        while (*pfx) namebuf[i++] = *pfx++;
        /* 数字转字符串 */
        {
            char tmp[16]; int tn = 0; unsigned u = (unsigned)n;
            if (u == 0) tmp[tn++] = '0';
            while (u) { tmp[tn++] = (char)('0' + u % 10); u /= 10; }
            while (tn > 0) namebuf[i++] = tmp[--tn];
        }
        namebuf[i] = 0;
    }
    gv = ir_program_add_global(g->prog, namebuf, t);
    gv->is_static = 1;  /* 复合字面量不暴露到链接器 */
    if (init) {
        if (init->kind == AST_INIT_LIST) {
            StrBuf sb; sb_init(&sb);
            serialize_init(&sb, init);
            gv->has_init = 1;
            gv->init_aggregate = sb.data;
        } else if (init->kind == AST_NUM) {
            gv->has_init = 1;
            gv->init_int = init->u.num_val;
            if (init->type && (init->type->kind == TYPE_FLOAT || init->type->kind == TYPE_DOUBLE)) {
                gv->is_float = 1;
                gv->init_float = init->fval;
            }
        } else if (init->kind == AST_STR) {
            gv->has_init = 1;
            gv->init_str = init->u.name;
        } else {
            StrBuf sb; sb_init(&sb);
            serialize_const_expr(&sb, init);
            gv->has_init = 1;
            gv->init_aggregate = sb.data;
        }
    }
    return gv->name;
}

static void irgen_stmt(IrGen *g, AstNode *node) {
    if (!node) return;
    g_ir_cur_line = node->line;  /* 供 DWARF .loc 使用 */
    switch (node->kind) {
        case AST_BLOCK: {
            int i;
            int saved_bp = g->bp;
            /* 声明块（逗号分隔的局部变量声明）不创建嵌套作用域 */
            if (!node->u.block.is_decl_list) sym_enter_scope();
            for (i = 0; i < node->u.block.stmt_count; i++) {
                irgen_stmt(g, node->u.block.stmts[i]);
            }
            if (!node->u.block.is_decl_list) sym_leave_scope();
            if (!node->u.block.is_decl_list) g->bp = saved_bp;
            break;
        }
        case AST_VAR_DECL: {
            int sz;
            int off;
            Symbol *s;
            if (node->u.var.is_extern) {
                /* 跳过：仅声明 */
                break;
            }
            if (!node->u.var.name) break;
            if (node->u.var.is_static) {
                /* static 局部变量：提升为函数级全局，名字 mangle 为
                 * ark_sl_<func>_<var>，跨调用持久保存。符号标记 is_static=1
                 * 并以 SYM_GLOBAL 注册，使 AST_VAR/AST_ASSIGN 走 PUSH_GLOBAL/
                 * STORE_GLOBAL 路径；符号名仍用原名以便 sym_find 命中。 */
                char *mangled = static_local_name(g->fn->name, node->u.var.name);
                IrGlobal *gv = ir_program_add_global(g->prog, mangled, node->u.var.var_type);
                gv->is_static = 1;
                gv->is_const = node->u.var.is_const;
                gv->section  = node->u.var.section;
                {
                    Symbol *ss = sym_add(SYM_GLOBAL, node->u.var.name,
                                         node->u.var.var_type, 0);
                    ss->is_static = 1;
                    (void)ss;
                }
                if (node->u.var.init) {
                    AstNode *iv = node->u.var.init;
                    if (iv->kind == AST_NUM) {
                        gv->has_init = 1;
                        gv->init_int = iv->u.num_val;
                        if (iv->type && (iv->type->kind == TYPE_FLOAT || iv->type->kind == TYPE_DOUBLE)) {
                            gv->is_float = 1;
                            gv->init_float = iv->fval;
                        }
                    } else if (iv->kind == AST_STR) {
                        gv->has_init = 1;
                        gv->init_str = iv->u.name;
                    } else if (iv->kind == AST_INIT_LIST) {
                        StrBuf sb; sb_init(&sb);
                        serialize_init(&sb, iv);
                        gv->has_init = 1;
                        gv->init_aggregate = sb.data;
                    } else {
                        int cv = 0;
                        gv->has_init = 1;
                        if (eval_const_expr(iv, &cv)) {
                            gv->init_int = cv;
                        } else {
                            StrBuf sb; sb_init(&sb);
                            serialize_const_expr(&sb, iv);
                            gv->init_aggregate = sb.data;
                        }
                    }
                }
                break;
            }
            sz = type_size(node->u.var.var_type);
            if (sz <= 0) sz = 4;
            off = alloc_local(g, sz);
            s = sym_add(SYM_VAR, node->u.var.name, node->u.var.var_type, off);
            (void)s;
#if ARKCC_FEATURE_VLA
            /* B3: 变长数组。var_type 已是带 is_vla 标记的指针；
             * 槽位存放指向动态分配区的指针（4 字节）。
             * 运行时：求值元素个数 * 元素大小 → IR_ALLOCA → 存指针到槽。 */
            if (node->u.var.is_vla && g_config.enable_vla) {
                Type *elem_t = node->u.var.var_type->base;
                int elem_sz = type_size(elem_t);
                if (elem_sz <= 0) elem_sz = 4;
                /* 元素个数 */
                irgen_expr(g, node->u.var.vla_size_expr);
                /* * 元素大小 → 字节数 */
                ir_emit(g->fn, IR_PUSH_INT, elem_sz, 0, 0);
                ir_emit(g->fn, IR_BINARY, 0, 0, (int)TOK_MUL);
                /* 动态分配，压入首地址 */
                ir_emit(g->fn, IR_ALLOCA, 0, 0, 0);
                /* 存入槽位 */
                ir_emit(g->fn, IR_STORE, off, 0, 0);
                break;
            }
#endif
            if (node->u.var.init) {
                AstNode *iv = node->u.var.init;
                if (iv->kind == AST_INIT_LIST) {
                    /* 局部聚合初始化：先清零整个区间，再递归写入显式初始化的元素。
                     * 递归支持 C99 嵌套初始化列表与 designated initializer。 */
                    int total = sz;
                    int k;
                    for (k = 0; k < total; k += 4) {
                        ir_emit(g->fn, IR_PUSH_INT, 0, 0, 0);
                        ir_emit(g->fn, IR_STORE, off + k, 0, 0);
                    }
                    irgen_local_aggregate_init(g, off, node->u.var.var_type, iv);
                } else if (iv->kind == AST_STR && node->u.var.var_type &&
                           node->u.var.var_type->kind == TYPE_ARRAY) {
                    /* char a[]="..."：调用 memcpy(frame+off, str, n)
                     * 调用约定：irgen 反向 push 参数，c 后端 stk[--sp]=arg0。
                     * 所以正向写法：push arg2, push arg1, push arg0。 */
                    const char *s2 = iv->u.name;
                    int slen = ark_strlen(s2);
                    int total = type_size(node->u.var.var_type);
                    int arr_len = node->u.var.var_type->size;
                    int copy_n;
                    int kk;
                    if (arr_len <= 0) arr_len = slen + 1;
                    copy_n = slen + 1;
                    if (copy_n > arr_len) copy_n = arr_len;
                    /* 先清零 */
                    for (kk = 0; kk < total; kk += 4) {
                        ir_emit(g->fn, IR_PUSH_INT, 0, 0, 0);
                        ir_emit(g->fn, IR_STORE, off + kk, 0, 0);
                    }
                    /* push n, src, dst（最后压栈的成为 arg0=dst） */
                    ir_emit(g->fn, IR_PUSH_INT, copy_n, 0, 0);
                    {
                        int id = ir_program_add_string(g->prog, s2, slen);
                        ir_emit(g->fn, IR_PUSH_STR, id, s2, 0);
                    }
                    ir_emit(g->fn, IR_PUSH_ADDR, off, 0, 0);
                    ir_emit(g->fn, IR_CALL, 3, "memcpy", 0);
                    ir_emit(g->fn, IR_POP, 0, 0, 0);
                } else {
                    irgen_expr(g, iv);
                    /* 浮点 -> 整数 赋值需插入 IR_F2I；反向插入 IR_I2F */
                    {
                        Type *st = iv ? iv->type : 0;
                        Type *dt = node->u.var.var_type;
                        int sf = st && (st->kind == TYPE_FLOAT || st->kind == TYPE_DOUBLE);
                        int df = dt && (dt->kind == TYPE_FLOAT || dt->kind == TYPE_DOUBLE);
                        int si = st && type_is_integer(st);
                        int di = dt && type_is_integer(dt);
                        if (sf && di)      ir_emit(g->fn, IR_F2I, 0, 0, 0);
                        else if (si && df) ir_emit(g->fn, IR_I2F, 0, 0, 0);
                    }
                    ir_emit(g->fn, IR_STORE, off, node->u.var.name, 0);
                }
            }
            break;
        }
        case AST_TYPEDEF:
            if (node->u.var.name)
                sym_add(SYM_TYPEDEF, node->u.var.name, node->u.var.var_type, 0);
            break;
        case AST_RETURN:
            if (node->u.unary.operand)
                irgen_expr(g, node->u.unary.operand);
            else
                ir_emit(g->fn, IR_PUSH_INT, 0, 0, 0);
            ir_emit(g->fn, IR_RETURN, 0, 0, 0);
            break;
        case AST_IF: {
            int else_l = alloc_label(g);
            int end_l  = alloc_label(g);
            irgen_expr(g, node->u.if_stmt.cond);
            ir_emit(g->fn, IR_JZ, else_l, 0, 0);
            irgen_stmt(g, node->u.if_stmt.then_stmt);
            ir_emit(g->fn, IR_JMP, end_l, 0, 0);
            ir_emit(g->fn, IR_LABEL, else_l, 0, 0);
            if (node->u.if_stmt.else_stmt)
                irgen_stmt(g, node->u.if_stmt.else_stmt);
            ir_emit(g->fn, IR_LABEL, end_l, 0, 0);
            break;
        }
        case AST_WHILE: {
            int start_l = alloc_label(g);
            int end_l   = alloc_label(g);
            int sb = g->break_label, sc = g->cont_label;
            g->break_label = end_l; g->cont_label = start_l;
            ir_emit(g->fn, IR_LABEL, start_l, 0, 0);
            irgen_expr(g, node->u.while_stmt.cond);
            ir_emit(g->fn, IR_JZ, end_l, 0, 0);
            irgen_stmt(g, node->u.while_stmt.body);
            ir_emit(g->fn, IR_JMP, start_l, 0, 0);
            ir_emit(g->fn, IR_LABEL, end_l, 0, 0);
            g->break_label = sb; g->cont_label = sc;
            break;
        }
        case AST_FOR: {
            int start_l = alloc_label(g);
            int end_l   = alloc_label(g);
            int cont_l  = alloc_label(g);
            int sb = g->break_label, sc = g->cont_label;
            int saved_bp = g->bp;
            sym_enter_scope();
            g->break_label = end_l; g->cont_label = cont_l;
            if (node->u.for_stmt.init) {
                if (node->u.for_stmt.init->kind == AST_VAR_DECL ||
                    node->u.for_stmt.init->kind == AST_BLOCK)
                    irgen_stmt(g, node->u.for_stmt.init);
                else {
                    irgen_expr(g, node->u.for_stmt.init);
                    ir_emit(g->fn, IR_POP, 0, 0, 0);
                }
            }
            ir_emit(g->fn, IR_LABEL, start_l, 0, 0);
            if (node->u.for_stmt.cond) {
                irgen_expr(g, node->u.for_stmt.cond);
                ir_emit(g->fn, IR_JZ, end_l, 0, 0);
            }
            irgen_stmt(g, node->u.for_stmt.body);
            ir_emit(g->fn, IR_LABEL, cont_l, 0, 0);
            if (node->u.for_stmt.step) {
                irgen_expr(g, node->u.for_stmt.step);
                ir_emit(g->fn, IR_POP, 0, 0, 0);
            }
            ir_emit(g->fn, IR_JMP, start_l, 0, 0);
            ir_emit(g->fn, IR_LABEL, end_l, 0, 0);
            sym_leave_scope();
            g->bp = saved_bp;
            g->break_label = sb; g->cont_label = sc;
            break;
        }
        case AST_DO_WHILE: {
            int start_l = alloc_label(g);
            int end_l   = alloc_label(g);
            int cont_l  = alloc_label(g);
            int sb = g->break_label, sc = g->cont_label;
            g->break_label = end_l; g->cont_label = cont_l;
            ir_emit(g->fn, IR_LABEL, start_l, 0, 0);
            irgen_stmt(g, node->u.while_stmt.body);
            ir_emit(g->fn, IR_LABEL, cont_l, 0, 0);
            irgen_expr(g, node->u.while_stmt.cond);
            ir_emit(g->fn, IR_JNZ, start_l, 0, 0);
            ir_emit(g->fn, IR_LABEL, end_l, 0, 0);
            g->break_label = sb; g->cont_label = sc;
            break;
        }
        case AST_SWITCH: {
            int end_l = alloc_label(g);
            int sb = g->break_label;
            CaseList cl;
            int i;
            int *sv_labels = g->case_labels;
            int *sv_values = g->case_values;
            int sv_count = g->case_count;
            int sv_default = g->default_label;
            int sv_end = g->switch_end_label;

            cl.labels = 0; cl.values = 0; cl.count = 0; cl.cap = 0;
            cl.default_label = -1;
            collect_cases(g, node->u.switch_stmt.body, &cl);

            g->case_labels = cl.labels;
            g->case_values = cl.values;
            g->case_count = cl.count;
            g->default_label = cl.default_label;
            g->switch_end_label = end_l;
            g->break_label = end_l;

            /* 求 switch(expr) 的值 */
            irgen_expr(g, node->u.switch_stmt.expr);
            for (i = 0; i < cl.count; i++) {
                /* DUP 然后比较 */
                ir_emit(g->fn, IR_DUP, 0, 0, 0);
                ir_emit(g->fn, IR_PUSH_INT, cl.values[i], 0, 0);
                ir_emit(g->fn, IR_BINARY, 0, 0, (int)TOK_EQ);
                ir_emit(g->fn, IR_JNZ, cl.labels[i], 0, 0);
            }
            ir_emit(g->fn, IR_POP, 0, 0, 0); /* 弹掉 switch 值 */
            if (cl.default_label >= 0) {
                ir_emit(g->fn, IR_JMP, cl.default_label, 0, 0);
            } else {
                ir_emit(g->fn, IR_JMP, end_l, 0, 0);
            }
            irgen_stmt(g, node->u.switch_stmt.body);
            ir_emit(g->fn, IR_LABEL, end_l, 0, 0);

            g->case_labels = sv_labels;
            g->case_values = sv_values;
            g->case_count = sv_count;
            g->default_label = sv_default;
            g->switch_end_label = sv_end;
            g->break_label = sb;
            break;
        }
        case AST_CASE: {
            /* 输出标签，但要在进入 case 体前弹掉栈顶的 switch 值。
             * 这里栈顶处于上方"跳过"路径上仍是脏的；我们已经在 switch 顶层
             * 对未匹配执行了 POP；匹配跳过来时栈顶仍是 switch 值。
             * 为简化：在每个 case 标签处都 POP 一次（栈顶就是 switch 值）。
             * 但若 fall-through，则不应重复 POP。本实现接受这个小代价：
             *   每个 case 起始 POP 一次。 */
            ir_emit(g->fn, IR_LABEL, node->u.case_stmt.label_id, 0, 0);
            /* 注意：fall-through 时栈是干净的，这里不该 POP。简化：跳到 case
             * 之前已经把 switch 值留在栈顶；为保证清栈一致，让 switch 头部把
             * 值放在一个临时位置。简单做法：让每个 case label 之前都跳过 POP。 */
            irgen_stmt(g, node->u.case_stmt.stmt);
            break;
        }
        case AST_DEFAULT: {
            ir_emit(g->fn, IR_LABEL, node->u.case_stmt.label_id, 0, 0);
            irgen_stmt(g, node->u.case_stmt.stmt);
            break;
        }
        case AST_LABEL:
            ir_emit(g->fn, IR_LABEL_NAMED, 0, node->u.label_stmt.name, 0);
            irgen_stmt(g, node->u.label_stmt.stmt);
            break;
        case AST_GOTO:
            ir_emit(g->fn, IR_JMP_NAMED, 0, node->u.name, 0);
            break;
        case AST_BREAK:
            if (g->break_label >= 0)
                ir_emit(g->fn, IR_JMP, g->break_label, 0, 0);
            break;
        case AST_CONTINUE:
            if (g->cont_label >= 0)
                ir_emit(g->fn, IR_JMP, g->cont_label, 0, 0);
            break;
        case AST_EXPR_STMT:
            if (node->u.unary.operand) {
                irgen_expr(g, node->u.unary.operand);
                ir_emit(g->fn, IR_POP, 0, 0, 0);
            }
            break;
        case AST_ASM: {
            /* 扩展内联汇编：把模板与三段操作数拼成完整 C 表达式串：
             *   "asm_text" : outputs : inputs : clobbers
             * 让 C 后端透传给 gcc 处理操作数；ARM 后端忽略操作数部分。
             * 用首字符 '@' 作为"完整扩展形式"的前缀标识，IR_ASM 后端据此分辨：
             *   - '@' 开头：扩展形式，name 中是 `"text" : outputs : inputs : clobbers`
             *   - 其他：纯文本，name 即旧式 IR_ASM 单段模板。 */
            const char *text = node->u.asm_stmt.text ? node->u.asm_stmt.text : "";
            const char *outs = node->u.asm_stmt.outputs;
            const char *ins  = node->u.asm_stmt.inputs;
            const char *clb  = node->u.asm_stmt.clobbers;
            if (outs || ins || clb) {
                /* 拼接扩展形式，引号转义模板字符串 */
                StrBuf sb; sb_init(&sb);
                sb_putc(&sb, '@');
                sb_putstr_lit(&sb, text);
                sb_puts(&sb, " : ");
                if (outs) sb_puts(&sb, outs);
                sb_puts(&sb, " : ");
                if (ins) sb_puts(&sb, ins);
                sb_puts(&sb, " : ");
                if (clb) sb_puts(&sb, clb);
                ir_emit(g->fn, IR_ASM, 0, sb.data, 0);
            } else {
                ir_emit(g->fn, IR_ASM, 0, text, 0);
            }
            break;
        }
        default:
            irgen_expr(g, node);
            ir_emit(g->fn, IR_POP, 0, 0, 0);
            break;
    }
}

static void irgen_lvalue_addr(IrGen *g, AstNode *node) {
    if (!node) return;
    if (node->kind == AST_VAR) {
        Symbol *s = sym_find(node->u.name);
        if (s && s->kind == SYM_GLOBAL) {
            /* 全局变量取地址：发 PUSH_GLOBAL_ADDR，后端以变量地址入栈。
             * 替代旧的 PUSH_INT 0 占位（C 后端会忽略 name，导致地址为 0）。
             * static 局部变量被提升为全局，引用时用 mangle 后的名字 */
            const char *gname = node->u.name;
            if (s->is_static) gname = static_local_name(g->fn->name, node->u.name);
            ir_emit(g->fn, IR_PUSH_GLOBAL_ADDR, 0, gname, 0);
        } else if (s) {
            ir_emit(g->fn, IR_PUSH_ADDR, s->offset, node->u.name, 0);
        } else {
            ir_emit(g->fn, IR_PUSH_INT, 0, 0, 0);
        }
        return;
    }
    if (node->kind == AST_COMPOUND_LITERAL) {
        /* 复合字面量是 lvalue；其"地址"即匿名全局的地址。
         * irgen_compound_literal 会登记全局并返回其名字。 */
        const char *gname = irgen_compound_literal(g, node);
        ir_emit(g->fn, IR_PUSH_GLOBAL_ADDR, 0, gname, 0);
        return;
    }
    if (node->kind == AST_ARRAY_ACCESS) {
        AstNode *arr = node->u.array_access.array;
        int elem_sz = 4;
        if (arr->type && (arr->type->kind == TYPE_ARRAY || arr->type->kind == TYPE_PTR))
            elem_sz = type_size(arr->type->base);
        else
            elem_sz = type_size(node->type ? node->type : type_int());
        if (elem_sz <= 0) elem_sz = 4;

        if (arr->kind == AST_VAR) {
            Symbol *s = sym_find(arr->u.name);
            if (s && s->type && s->type->kind == TYPE_ARRAY && s->kind != SYM_GLOBAL) {
                ir_emit(g->fn, IR_PUSH_ADDR, s->offset, arr->u.name, 0);
            } else {
                irgen_expr(g, arr);
            }
        } else {
            irgen_expr(g, arr);
        }
        irgen_expr(g, node->u.array_access.index);
        ir_emit(g->fn, IR_PUSH_INT, elem_sz, 0, 0);
        ir_emit(g->fn, IR_BINARY, 0, 0, (int)TOK_MUL);
        ir_emit(g->fn, IR_BINARY, 0, 0, (int)TOK_PLUS);
        return;
    }
    if (node->kind == AST_UNARY && node->u.unary.op == (int)TOK_MUL) {
        irgen_expr(g, node->u.unary.operand);
        return;
    }
    if (node->kind == AST_MEMBER) {
        AstNode *obj = node->u.member.obj;
        if (node->u.member.is_arrow) {
            irgen_expr(g, obj);
        } else {
            irgen_lvalue_addr(g, obj);
        }
        ir_emit(g->fn, IR_PUSH_INT, node->u.member.offset, 0, 0);
        ir_emit(g->fn, IR_BINARY, 0, 0, (int)TOK_PLUS);
        return;
    }
    ark_log("[irgen] line %d: invalid lvalue\n", node->line);
}

/* 查找 AST_MEMBER 节点对应的位域信息。
 * AST_MEMBER 节点本身不带 bit_offset/bit_width（见 ast.h），需根据 obj 类型
 * 重新到结构体字段链中查找。返回 1 表示是位域，0 表示非位域或查找失败。
 * 输出：*pbit_off = 单元内位偏移；*pbit_width = 位宽。 */
static int member_bitfield_info(AstNode *node, int *pbit_off, int *pbit_width) {
    AstNode *obj = node->u.member.obj;
    Type *st = 0;
    StructField *f;
    if (!obj) return 0;
    if (node->u.member.is_arrow) {
        if (obj->type && obj->type->kind == TYPE_PTR) st = obj->type->base;
    } else {
        st = obj->type;
    }
    if (!st || (st->kind != TYPE_STRUCT && st->kind != TYPE_UNION)) return 0;
    f = type_find_field(st, node->u.member.member);
    if (!f || f->bit_width <= 0) return 0;
    *pbit_off = f->bit_offset;
    *pbit_width = f->bit_width;
    return 1;
}

static void irgen_expr(IrGen *g, AstNode *node) {
    if (!node) {
        ir_emit(g->fn, IR_PUSH_INT, 0, 0, 0);
        return;
    }
    g_ir_cur_line = node->line;  /* 供 DWARF .loc 使用 */
    switch (node->kind) {
        case AST_NUM:
            if (node->type && (node->type->kind == TYPE_FLOAT || node->type->kind == TYPE_DOUBLE)) {
                int fid = ir_program_add_float(g->prog, node->fval);
                /* aux 高位 0x200 标记 double 精度：ARM 后端据此发射 64 位常量。
                 * val 仍为浮点常量池索引。 */
                int is_dbl = (node->type->kind == TYPE_DOUBLE);
                ir_emit(g->fn, IR_PUSH_FLOAT, fid, 0, fid | (is_dbl ? 0x200 : 0));
            } else {
                ir_emit(g->fn, IR_PUSH_INT, node->u.num_val, 0, 0);
            }
            break;
        case AST_STR: {
            int slen = ark_strlen(node->u.name);
            int id = ir_program_add_string(g->prog, node->u.name, slen);
#if ARKCC_FEATURE_WCHAR
            /* B2: 宽字符串（node->type 为 wchar_t*）→ 标记 IrString，
             * C 后端据此发射 L"..." 与 wchar_t 数组。 */
            if (g_config.enable_wchar && node->type &&
                node->type->kind == TYPE_PTR &&
                node->type->base && node->type->base->kind == TYPE_WCHAR) {
                g->prog->strings[id]->is_wide = 1;
            }
#endif
            ir_emit(g->fn, IR_PUSH_STR, id, node->u.name, 0);
            break;
        }
        case AST_SIZEOF:
            ir_emit(g->fn, IR_PUSH_INT, node->u.num_val, 0, 0);
            break;
        case AST_COMPOUND_LITERAL: {
            /* C99 复合字面量：登记为匿名全局。
             *   - 数组/结构体：rvalue 为 decay 后的指针（即首元素地址），
             *     故发 PUSH_GLOBAL_ADDR；
             *   - 标量：rvalue 即标量值，发 PUSH_GLOBAL 加载其内容。 */
            const char *gname = irgen_compound_literal(g, node);
            if (node->type &&
                (node->type->kind == TYPE_ARRAY ||
                 node->type->kind == TYPE_STRUCT ||
                 node->type->kind == TYPE_UNION)) {
                ir_emit(g->fn, IR_PUSH_GLOBAL_ADDR, 0, gname, 0);
            } else {
                ir_emit(g->fn, IR_PUSH_GLOBAL, 0, gname, 0);
            }
            break;
        }
        case AST_VAR: {
            Symbol *s = sym_find(node->u.name);
            if (!s) {
                ir_emit(g->fn, IR_PUSH_INT, 0, node->u.name, 0);
                break;
            }
            if (s->kind == SYM_GLOBAL) {
                /* static 局部变量被提升为全局，引用时用 mangle 后的名字 */
                const char *gname = node->u.name;
                if (s->is_static) gname = static_local_name(g->fn->name, node->u.name);
                ir_emit(g->fn, IR_PUSH_GLOBAL, 0, gname, 0);
            } else if (s->kind == SYM_ENUM_CONST) {
                ir_emit(g->fn, IR_PUSH_INT, s->enum_value, 0, 0);
            } else if (s->type && s->type->kind == TYPE_ARRAY) {
                ir_emit(g->fn, IR_PUSH_ADDR, s->offset, node->u.name, 0);
            } else {
                ir_emit(g->fn, IR_PUSH_VAR, s->offset, node->u.name, 0);
            }
            break;
        }
        case AST_CAST:
            irgen_expr(g, node->u.unary.operand);
            /* 浮点 <-> 整数 转换：根据源/目标类型发出 IR_F2I / IR_I2F。
             * aux 高位 0x200 标记 double 精度，让 ARM 后端选择
             * __aeabi_d2iz / __aeabi_i2d 等双精度助手而非单精度版本。
             * F2I 看源类型是否 double；I2F 看目标类型是否 double。 */
            {
                Type *src_t = node->u.unary.operand ? node->u.unary.operand->type : 0;
                Type *dst_t = node->type;
                int src_float = src_t && (src_t->kind == TYPE_FLOAT || src_t->kind == TYPE_DOUBLE);
                int dst_float = dst_t && (dst_t->kind == TYPE_FLOAT || dst_t->kind == TYPE_DOUBLE);
                int src_int   = src_t && type_is_integer(src_t);
                int dst_int   = dst_t && type_is_integer(dst_t);
                if (src_float && dst_int) {
                    int is_dbl = (src_t->kind == TYPE_DOUBLE);
                    ir_emit(g->fn, IR_F2I, 0, 0, is_dbl ? 0x200 : 0);
                }
                else if (src_int && dst_float) {
                    int is_dbl = (dst_t->kind == TYPE_DOUBLE);
                    ir_emit(g->fn, IR_I2F, 0, 0, is_dbl ? 0x200 : 0);
                }
                /* 同类（int→int / float→float / 涉及指针）不做转换 */
            }
            break;
        case AST_COMMA:
            irgen_expr(g, node->u.binary.left);
            ir_emit(g->fn, IR_POP, 0, 0, 0);
            irgen_expr(g, node->u.binary.right);
            break;
        case AST_BINARY: {
            int op = node->u.binary.op;
            if (op == (int)TOK_AND) {
                int false_l = alloc_label(g);
                int end_l = alloc_label(g);
                irgen_expr(g, node->u.binary.left);
                ir_emit(g->fn, IR_JZ, false_l, 0, 0);
                irgen_expr(g, node->u.binary.right);
                ir_emit(g->fn, IR_PUSH_INT, 0, 0, 0);
                ir_emit(g->fn, IR_BINARY, 0, 0, (int)TOK_NE);
                ir_emit(g->fn, IR_JMP, end_l, 0, 0);
                ir_emit(g->fn, IR_LABEL, false_l, 0, 0);
                ir_emit(g->fn, IR_PUSH_INT, 0, 0, 0);
                ir_emit(g->fn, IR_LABEL, end_l, 0, 0);
            } else if (op == (int)TOK_OR) {
                int true_l = alloc_label(g);
                int end_l = alloc_label(g);
                irgen_expr(g, node->u.binary.left);
                ir_emit(g->fn, IR_JNZ, true_l, 0, 0);
                irgen_expr(g, node->u.binary.right);
                ir_emit(g->fn, IR_PUSH_INT, 0, 0, 0);
                ir_emit(g->fn, IR_BINARY, 0, 0, (int)TOK_NE);
                ir_emit(g->fn, IR_JMP, end_l, 0, 0);
                ir_emit(g->fn, IR_LABEL, true_l, 0, 0);
                ir_emit(g->fn, IR_PUSH_INT, 1, 0, 0);
                ir_emit(g->fn, IR_LABEL, end_l, 0, 0);
            } else {
                int is_float = 0;
                int is_llong = 0;
                int is_unsigned = 0;
                int is_double = 0;
                int aux_op = op;  /* 发给后端的运算符，可附加高位标志 */
                Type *lt = node->u.binary.left ? node->u.binary.left->type : 0;
                Type *rt = node->u.binary.right ? node->u.binary.right->type : 0;
                if ((lt && (lt->kind == TYPE_FLOAT || lt->kind == TYPE_DOUBLE)) ||
                    (rt && (rt->kind == TYPE_FLOAT || rt->kind == TYPE_DOUBLE))) {
                    is_float = 1;
                    /* 双精度判定：任一操作数为 double 即按 double 运算 */
                    if ((lt && lt->kind == TYPE_DOUBLE) ||
                        (rt && rt->kind == TYPE_DOUBLE)) {
                        is_double = 1;
                    }
                }
                if (!is_float) {
                    /* C99 通常算术转换 (6.3.1.8)：
                     *   - 算术/比较运算：两侧提升到公共类型，符号性由公共类型决定。
                     *   - 移位运算：仅对左操作数做整型提升，符号性由提升后的左操作数决定。
                     * irgen 不显式插入转换指令——只要 sema 正确设置了 is_unsigned 标志，
                     * 后端即可据此选择有符号/无符号除法、比较条件、移位方式。 */
                    if (op == (int)TOK_SHL || op == (int)TOK_SHR) {
                        /* 移位：usual_arith_conv(lt, 0) 退化为 promote_integer(lt) */
                        Type *pl = usual_arith_conv(lt, 0);
                        is_unsigned = pl && pl->is_unsigned;
                    } else {
                        Type *common = usual_arith_conv(lt, rt);
                        is_unsigned = common && common->is_unsigned;
                        is_llong = common && common->kind == TYPE_LLONG;
                    }
                }
                irgen_expr(g, node->u.binary.left);
                irgen_expr(g, node->u.binary.right);
                if (is_float) {
                    IrOp fop = IR_FADD;
                    switch (op) {
                        case (int)TOK_PLUS:  fop = IR_FADD; break;
                        case (int)TOK_MINUS: fop = IR_FSUB; break;
                        case (int)TOK_MUL:   fop = IR_FMUL; break;
                        case (int)TOK_DIV:   fop = IR_FDIV; break;
                        case (int)TOK_EQ: case (int)TOK_NE:
                        case (int)TOK_LT: case (int)TOK_GT:
                        case (int)TOK_LE: case (int)TOK_GE:
                            fop = IR_FCMP; break;
                        default: fop = IR_FADD; break;
                    }
                    /* aux 高位 0x200 标记 double 精度：ARM 后端据此选择
                     * __aeabi_dadd / __aeabi_fadd 等；C 后端按 double 存储。 */
                    ir_emit(g->fn, fop, 0, 0, op | (is_double ? 0x200 : 0));
                } else if (is_llong) {
                    /* 64 位运算：C 后端同 IR_BINARY（槽位已是 long long）；
                     * ARM 后端弹出 4 槽做 64 位运算再压 2 槽。 */
                    int is_cmp = (op == (int)TOK_EQ || op == (int)TOK_NE ||
                                  op == (int)TOK_LT || op == (int)TOK_GT ||
                                  op == (int)TOK_LE || op == (int)TOK_GE);
                    if (is_cmp) {
                        ir_emit(g->fn, IR_64CMP, 0, 0, op);
                    } else {
                        ir_emit(g->fn, IR_64BINARY, 0, 0, op);
                    }
                } else if (op == (int)TOK_DIV || op == (int)TOK_MOD) {
                    /* 整数除法/取模：专用 IR_DIV/IR_MOD，aux=1 表示无符号。
                     * 让 ARM 后端选择 __aeabi_idiv / __aeabi_uidiv。 */
                    IrOp dop = (op == (int)TOK_DIV) ? IR_DIV : IR_MOD;
                    ir_emit(g->fn, dop, 0, 0, is_unsigned ? 1 : 0);
                } else {
                    /* 对无符号比较(TOK_LT/GT/LE/GE)和右移(TOK_SHR)在 aux 高位(0x100)
                     * 编码无符号标志，让后端选择无符号比较条件 / 逻辑右移。
                     * EQ/NE 为位相等比较，有符号/无符号结果一致，无需编码。 */
                    if (is_unsigned && (op == (int)TOK_LT || op == (int)TOK_GT ||
                                        op == (int)TOK_LE || op == (int)TOK_GE ||
                                        op == (int)TOK_SHR)) {
                        aux_op = op | 0x100;
                    }
                    ir_emit(g->fn, IR_BINARY, 0, 0, aux_op);
                }
            }
            break;
        }
        case AST_UNARY: {
            int op = node->u.unary.op;
            if (op == (int)TOK_BAND) {
                irgen_lvalue_addr(g, node->u.unary.operand);
            } else if (op == (int)TOK_MUL) {
                int packed_aux = 0;
                irgen_expr(g, node->u.unary.operand);
                ir_emit(g->fn, IR_PUSH_INT, 0, 0, 0);
                /* __packed 指针解引用：aux 0x400 标记按字节访问未对齐内存 */
                if (node->u.unary.operand->type &&
                    node->u.unary.operand->type->kind == TYPE_PTR &&
                    node->u.unary.operand->type->is_packed) {
                    packed_aux = 0x400;
                }
                ir_emit(g->fn, IR_LOAD_IDX, type_size(node->type ? node->type : type_int()), 0, packed_aux);
            } else if (op == (int)TOK_INC || op == (int)TOK_DEC) {
                int delta = (op == (int)TOK_INC) ? 1 : -1;
                AstNode *operand = node->u.unary.operand;
                if (operand->kind == AST_VAR) {
                    Symbol *s = sym_find(operand->u.name);
                    if (!s) { ir_emit(g->fn, IR_PUSH_INT, 0, 0, 0); break; }
                    if (s->kind == SYM_GLOBAL) {
                        /* 全局/static 局部自增自减：走 PUSH_GLOBAL/STORE_GLOBAL。
                         * static 局部用 mangle 后的名字，避免写到 frame[0]。 */
                        const char *gname = operand->u.name;
                        if (s->is_static) gname = static_local_name(g->fn->name, operand->u.name);
                        if (node->u.unary.is_postfix) {
                            ir_emit(g->fn, IR_PUSH_GLOBAL, 0, gname, 0);
                            ir_emit(g->fn, IR_PUSH_GLOBAL, 0, gname, 0);
                            ir_emit(g->fn, IR_PUSH_INT, delta, 0, 0);
                            ir_emit(g->fn, IR_BINARY, 0, 0, (int)TOK_PLUS);
                            ir_emit(g->fn, IR_STORE_GLOBAL, 0, gname, 0);
                        } else {
                            ir_emit(g->fn, IR_PUSH_GLOBAL, 0, gname, 0);
                            ir_emit(g->fn, IR_PUSH_INT, delta, 0, 0);
                            ir_emit(g->fn, IR_BINARY, 0, 0, (int)TOK_PLUS);
                            ir_emit(g->fn, IR_STORE_GLOBAL, 0, gname, 0);
                            ir_emit(g->fn, IR_PUSH_GLOBAL, 0, gname, 0);
                        }
                    } else if (node->u.unary.is_postfix) {
                        ir_emit(g->fn, IR_PUSH_VAR, s->offset, operand->u.name, 0);
                        ir_emit(g->fn, IR_PUSH_VAR, s->offset, operand->u.name, 0);
                        ir_emit(g->fn, IR_PUSH_INT, delta, 0, 0);
                        ir_emit(g->fn, IR_BINARY, 0, 0, (int)TOK_PLUS);
                        ir_emit(g->fn, IR_STORE, s->offset, operand->u.name, 0);
                    } else {
                        ir_emit(g->fn, IR_PUSH_VAR, s->offset, operand->u.name, 0);
                        ir_emit(g->fn, IR_PUSH_INT, delta, 0, 0);
                        ir_emit(g->fn, IR_BINARY, 0, 0, (int)TOK_PLUS);
                        ir_emit(g->fn, IR_STORE, s->offset, operand->u.name, 0);
                        ir_emit(g->fn, IR_PUSH_VAR, s->offset, operand->u.name, 0);
                    }
                } else {
                    irgen_expr(g, operand);
                }
            } else {
                irgen_expr(g, node->u.unary.operand);
                ir_emit(g->fn, IR_UNARY, 0, 0, op);
            }
            break;
        }
        case AST_ASSIGN: {
            AstNode *L = node->u.binary.left;
            int op = node->u.binary.op;
            if (op == (int)TOK_ASSIGN) {
                /* 结构体/联合体整体赋值：用 IR_MEMCPY 按字节拷贝。
                 * IR_MEMCPY 栈语义：顶=dst, 次顶=src，弹出二者。
                 * 赋值表达式结果留 dst 地址（语句语境由 AST_EXPR_STMT 弹掉）。 */
                if (L->type && (L->type->kind == TYPE_STRUCT || L->type->kind == TYPE_UNION)) {
                    int sz = type_size(L->type);
                    if (sz <= 0) sz = 4;
                    irgen_lvalue_addr(g, L);                      /* [dst] 保留作结果 */
                    irgen_lvalue_addr(g, node->u.binary.right);   /* [dst, src] */
                    irgen_lvalue_addr(g, L);                      /* [dst, src, dst] 顶=dst */
                    ir_emit(g->fn, IR_MEMCPY, sz, 0, 0);          /* 弹 dst+src，留 [dst] */
                    break;
                }
                if (L->kind == AST_VAR) {
                    Symbol *s = sym_find(L->u.name);
                    irgen_expr(g, node->u.binary.right);
                    /* 浮点 <-> 整数 赋值需插入转换指令 */
                    {
                        AstNode *rv = node->u.binary.right;
                        Type *st = rv ? rv->type : 0;
                        Type *dt = s ? s->type : 0;
                        int sf = st && (st->kind == TYPE_FLOAT || st->kind == TYPE_DOUBLE);
                        int df = dt && (dt->kind == TYPE_FLOAT || dt->kind == TYPE_DOUBLE);
                        int si = st && type_is_integer(st);
                        int di = dt && type_is_integer(dt);
                        if (sf && di)      ir_emit(g->fn, IR_F2I, 0, 0, 0);
                        else if (si && df) ir_emit(g->fn, IR_I2F, 0, 0, 0);
                    }
                    if (s && s->kind == SYM_GLOBAL) {
                        const char *gname = L->u.name;
                        if (s->is_static) gname = static_local_name(g->fn->name, L->u.name);
                        ir_emit(g->fn, IR_DUP, 0, 0, 0);
                        ir_emit(g->fn, IR_STORE_GLOBAL, 0, gname, 0);
                    } else if (s) {
                        ir_emit(g->fn, IR_STORE, s->offset, L->u.name, 0);
                        ir_emit(g->fn, IR_PUSH_VAR, s->offset, L->u.name, 0);
                    }
                } else if (L->kind == AST_ARRAY_ACCESS) {
                    AstNode *arr = L->u.array_access.array;
                    int elem_sz = 4;
                    int packed_aux = 0;
                    if (arr->type && (arr->type->kind == TYPE_ARRAY || arr->type->kind == TYPE_PTR))
                        elem_sz = type_size(arr->type->base);
                    if (elem_sz <= 0) elem_sz = 4;
                    /* __packed 指针下标存储：aux 0x400 标记按字节访问 */
                    if (arr->type && arr->type->kind == TYPE_PTR && arr->type->is_packed) {
                        packed_aux = 0x400;
                    }
                    irgen_lvalue_addr(g, L);
                    irgen_expr(g, node->u.binary.right);
                    ir_emit(g->fn, IR_STORE_IDX, elem_sz, 0, packed_aux);
                } else if (L->kind == AST_UNARY && L->u.unary.op == (int)TOK_MUL) {
                    int elem_sz = type_size(L->type ? L->type : type_int());
                    int packed_aux = 0;
                    if (elem_sz <= 0) elem_sz = 4;
                    irgen_expr(g, L->u.unary.operand);
                    irgen_expr(g, node->u.binary.right);
                    /* __packed 指针存储：aux 0x400 标记按字节访问未对齐内存 */
                    if (L->u.unary.operand->type &&
                        L->u.unary.operand->type->kind == TYPE_PTR &&
                        L->u.unary.operand->type->is_packed) {
                        packed_aux = 0x400;
                    }
                    ir_emit(g->fn, IR_STORE_IDX, elem_sz, 0, packed_aux);
                } else if (L->kind == AST_MEMBER) {
                    int bo, bw;
                    if (member_bitfield_info(L, &bo, &bw)) {
                        /* 位域赋值：IR_STORE_FLD 弹出 value(顶) 与 addr(次顶)，
                         * 按位宽掩码写入存储单元，不回压。先存后读以拿到截断后的值。 */
                        irgen_lvalue_addr(g, L);                      /* [addr] */
                        irgen_expr(g, node->u.binary.right);          /* [addr, value] */
                        ir_emit(g->fn, IR_STORE_FLD, bo, 0, bw);      /* [] */
                        irgen_lvalue_addr(g, L);                      /* [addr] */
                        ir_emit(g->fn, IR_LOAD_FLD, bo, 0, bw);       /* [masked_value] */
                    } else {
                        int elem_sz = type_size(L->type ? L->type : type_int());
                        if (elem_sz <= 0) elem_sz = 4;
                        irgen_lvalue_addr(g, L);
                        irgen_expr(g, node->u.binary.right);
                        ir_emit(g->fn, IR_STORE_IDX, elem_sz, 0, 0);
                    }
                } else {
                    ark_log("[irgen] line %d: invalid assignment target\n", node->line);
                    ir_emit(g->fn, IR_PUSH_INT, 0, 0, 0);
                }
            } else {
                int bop = (int)TOK_PLUS;
                switch (op) {
                    case TOK_ADD_ASSIGN: bop = (int)TOK_PLUS;  break;
                    case TOK_SUB_ASSIGN: bop = (int)TOK_MINUS; break;
                    case TOK_MUL_ASSIGN: bop = (int)TOK_MUL;   break;
                    case TOK_DIV_ASSIGN: bop = (int)TOK_DIV;   break;
                    case TOK_MOD_ASSIGN: bop = (int)TOK_MOD;   break;
                    case TOK_AND_ASSIGN: bop = (int)TOK_BAND;  break;
                    case TOK_OR_ASSIGN:  bop = (int)TOK_BOR;   break;
                    case TOK_XOR_ASSIGN: bop = (int)TOK_BXOR;  break;
                    case TOK_SHL_ASSIGN: bop = (int)TOK_SHL;   break;
                    case TOK_SHR_ASSIGN: bop = (int)TOK_SHR;   break;
                    default: break;
                }
                if (L->kind == AST_VAR) {
                    Symbol *s = sym_find(L->u.name);
                    if (s && s->kind == SYM_GLOBAL) {
                        const char *gname = L->u.name;
                        if (s->is_static) gname = static_local_name(g->fn->name, L->u.name);
                        ir_emit(g->fn, IR_PUSH_GLOBAL, 0, gname, 0);
                        irgen_expr(g, node->u.binary.right);
                        ir_emit(g->fn, IR_BINARY, 0, 0, bop);
                        ir_emit(g->fn, IR_DUP, 0, 0, 0);
                        ir_emit(g->fn, IR_STORE_GLOBAL, 0, gname, 0);
                    } else if (s) {
                        ir_emit(g->fn, IR_PUSH_VAR, s->offset, L->u.name, 0);
                        irgen_expr(g, node->u.binary.right);
                        ir_emit(g->fn, IR_BINARY, 0, 0, bop);
                        ir_emit(g->fn, IR_STORE, s->offset, L->u.name, 0);
                        ir_emit(g->fn, IR_PUSH_VAR, s->offset, L->u.name, 0);
                    }
                } else {
                    ark_log("[irgen] line %d: compound-assign target unsupported\n", node->line);
                    ir_emit(g->fn, IR_PUSH_INT, 0, 0, 0);
                }
            }
            break;
        }
        case AST_FUNC_CALL: {
            int i;
            int n = node->u.call.arg_count;
            Symbol *s = sym_find(node->u.call.name);
            for (i = n - 1; i >= 0; i--) {
                irgen_expr(g, node->u.call.args[i]);
            }
            /* __svc(n) 函数：生成 SVC 指令而非 BL */
            if (s && s->svc_num != 0) {
                ir_emit(g->fn, IR_SVC, s->svc_num, node->u.call.name, 0);
            }
#if ARKCC_FEATURE_ARMCC_KEYWORDS
            /* __smc(n) 函数：生成 SMC 指令而非 BL */
            else if (s && s->smc_num >= 0) {
                ir_emit(g->fn, IR_SMC, s->smc_num, node->u.call.name, 0);
            }
#endif
            else {
                ir_emit(g->fn, IR_CALL, n, node->u.call.name, 0);
            }
            break;
        }
        case AST_ARRAY_ACCESS: {
            int elem_sz;
            int packed_aux = 0;
            AstNode *arr = node->u.array_access.array;
            /* 推断下标结果的类型：若 arr 是数组/指针，结果即元素类型。
             * 当结果是数组类型时（如 matrix[1] 仍是 int[3]），按 C 语义
             * 衰退为指向首元素的指针——只把地址压栈，不做 IR_LOAD_IDX。
             * 否则按标量元素读取：地址 + 0 偏移，按元素大小加载。 */
            if (!node->type && arr && arr->type &&
                (arr->type->kind == TYPE_ARRAY || arr->type->kind == TYPE_PTR)) {
                node->type = arr->type->base;
            }
            if (node->type && node->type->kind == TYPE_ARRAY) {
                irgen_lvalue_addr(g, node);
                return;
            }
            if (arr->type && (arr->type->kind == TYPE_ARRAY || arr->type->kind == TYPE_PTR))
                elem_sz = type_size(arr->type->base);
            else
                elem_sz = type_size(node->type ? node->type : type_int());
            if (elem_sz <= 0) elem_sz = 4;
            /* __packed 指针下标读取：aux 0x400 标记按字节访问未对齐内存 */
            if (arr->type && arr->type->kind == TYPE_PTR && arr->type->is_packed) {
                packed_aux = 0x400;
            }
            irgen_lvalue_addr(g, node);
            ir_emit(g->fn, IR_PUSH_INT, 0, 0, 0);
            ir_emit(g->fn, IR_LOAD_IDX, elem_sz, 0, packed_aux);
            break;
        }
        case AST_MEMBER: {
            int bo, bw;
            if (member_bitfield_info(node, &bo, &bw)) {
                /* 位域读取：irgen_lvalue_addr 推入存储单元地址（已含字段偏移），
                 * IR_LOAD_FLD 弹出地址，按 (bit_offset, bit_width) 提取位域值。 */
                irgen_lvalue_addr(g, node);
                ir_emit(g->fn, IR_LOAD_FLD, bo, 0, bw);
            } else {
                int elem_sz = type_size(node->type ? node->type : type_int());
                if (elem_sz <= 0) elem_sz = 4;
                irgen_lvalue_addr(g, node);
                ir_emit(g->fn, IR_PUSH_INT, 0, 0, 0);
                ir_emit(g->fn, IR_LOAD_IDX, elem_sz, 0, 0);
            }
            break;
        }
        case AST_TERNARY: {
            int false_l = alloc_label(g);
            int end_l = alloc_label(g);
            irgen_expr(g, node->u.ternary.cond);
            ir_emit(g->fn, IR_JZ, false_l, 0, 0);
            irgen_expr(g, node->u.ternary.true_expr);
            ir_emit(g->fn, IR_JMP, end_l, 0, 0);
            ir_emit(g->fn, IR_LABEL, false_l, 0, 0);
            irgen_expr(g, node->u.ternary.false_expr);
            ir_emit(g->fn, IR_LABEL, end_l, 0, 0);
            break;
        }
        default:
            ir_emit(g->fn, IR_PUSH_INT, 0, 0, 0);
            break;
    }
}
