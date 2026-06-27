/* Ark C Compiler - sema
 * 语义分析：未定义/重定义检查、基本类型推导。
 * 与原版相比放宽规则：允许 > 4 个参数；允许变参声明；忽略 typedef；新增节点遍历。
 */
#include "sema.h"
#include "symtab.h"
#include "memory.h"
#include "platform.h"
#include "common.h"

static int g_errors;

static void sema_decl(AstNode *node);
static void sema_stmt(AstNode *node);
static Type *sema_expr(AstNode *node);

static void err(AstNode *node, const char *msg) {
    ark_log("[sema] line %d: %s\n", node ? node->line : 0, msg);
    g_errors++;
}

/* 整型提升（C99 6.3.1.1）：char/short/_Bool/enum 提升为 int。
 * 因为 int 能表示这些类型的全部值域（含 uchar/ushort），所以一律转有符号 int。
 * int/long/llong 自身不变。 */
static Type *promote_integer(Type *t) {
    if (!t) return type_int();
    switch (t->kind) {
        case TYPE_CHAR:
        case TYPE_SHORT:
        case TYPE_BOOL:
        case TYPE_ENUM:
            return type_int();
        default:
            return t;
    }
}

/* 整型秩（C99 6.3.1.1）：用于 usual arithmetic conversions 比较操作数宽度。
 * 假设 sizeof(long)==sizeof(int)==4（ARM 与 Windows LLP64 一致）。
 *   int/unsigned int       -> 1
 *   long/unsigned long     -> 2
 *   long long/unsigned ll  -> 3
 * 其它（char/short/bool/enum）先经 promote_integer 提升到 int，秩=1。 */
static int type_rank(Type *t) {
    if (!t) return 1;
    switch (t->kind) {
        case TYPE_LLONG: return 3;
        case TYPE_LONG:  return 2;
        default:         return 1;  /* int 或经提升后的窄类型 */
    }
}

/* usual arithmetic conversions (C99 6.3.1.8)：
 *   1. 浮点优先级：double > float；任一为 double 即转 double，否则任一为 float 转 float。
 *   2. 否则对两操作数做整型提升（char/short/_Bool/enum -> int）。
 *   3. 同类型直接返回。
 *   4. 同秩同符号：取无符号版本（unsigned int + int -> unsigned int）。
 *   5. 不同秩：
 *      - 若较高秩类型能表示较低秩类型的全部值（即高秩无符号 或 高秩有符号且宽度更大），
 *        取较高秩类型；
 *      - 否则取较高秩类型的无符号版本。
 * 返回两侧应共同转换到的类型。irgen 据此 is_unsigned 判断除法/比较/移位符号性。 */
Type *usual_arith_conv(Type *lt, Type *rt) {
    /* 第 1 步：浮点优先 */
    if (lt && lt->kind == TYPE_DOUBLE) return type_double();
    if (rt && rt->kind == TYPE_DOUBLE) return type_double();
    if (lt && lt->kind == TYPE_FLOAT)  return type_float();
    if (rt && rt->kind == TYPE_FLOAT)  return type_float();

    /* 第 2 步：整型提升 */
    lt = promote_integer(lt);
    rt = promote_integer(rt);
    if (!lt) return rt ? rt : type_int();
    if (!rt) return lt;

    /* 第 3 步：同类型直接返回 */
    if (lt->kind == rt->kind && lt->is_unsigned == rt->is_unsigned) return lt;

    {
        int rl = type_rank(lt);
        int rr = type_rank(rt);
        Type *hi, *lo;   /* 较高秩 / 较低秩 */
        int hi_uns, lo_uns;

        if (rl >= rr) { hi = lt; lo = rt; }
        else          { hi = rt; lo = lt; }
        hi_uns = hi->is_unsigned;
        lo_uns = lo->is_unsigned;

        /* 第 4 步：同秩——同符号已在第 3 步返回，故此处必为一有符号一无符号，
         * 取无符号版本（C99 6.3.1.8：同秩时无符号类型胜出）。
         * 注意：hi 可能恰好是有符号那个，故须 hi_uns || lo_uns 判断。 */
        if (rl == rr) {
            int take_uns = (hi_uns || lo_uns);
            switch (hi->kind) {
                case TYPE_LLONG: return take_uns ? type_ullong() : type_llong();
                case TYPE_LONG:  return take_uns ? type_ulong()  : type_long();
                default:         return take_uns ? type_uint()   : type_int();
            }
        }

        /* 第 5 步：不同秩——较高秩能否表示较低秩全部值？
         * 关键：按实际字节宽度判断，而非秩。本编译器假设 int=long=4B、llong=8B，
         * 故 long(秩2) 与 int(秩1) 同宽，rank 大并不代表更宽。
         *   - 高秩无符号：必能表示低秩全部值，取高秩。
         *   - 高秩有符号 + 低秩有符号：取高秩。
         *   - 高秩有符号 + 低秩无符号：仅当高秩严格更宽（如 llong 8B vs uint 4B）
         *     才取高秩有符号；否则（如 long 4B vs uint 4B，同宽放不下）取高秩无符号版。 */
        if (hi_uns || !lo_uns) {
            /* 高秩无符号 必胜；或低秩有符号（高秩有符号也能放下），取高秩类型 */
            return hi;
        }
        {
            int hi_bytes = (hi->kind == TYPE_LLONG) ? 8 : 4;
            int lo_bytes = (lo->kind == TYPE_LLONG) ? 8 : 4;
            if (hi_bytes > lo_bytes) {
                /* 高秩更宽（如 llong 8B vs uint 4B），有符号也能表示低秩无符号全部值 */
                return hi;
            }
            /* 同宽：高秩有符号放不下低秩无符号，取高秩无符号版本 */
            switch (hi->kind) {
                case TYPE_LLONG: return type_ullong();
                case TYPE_LONG:  return type_ulong();
                default:         return type_uint();
            }
        }
    }
}

/* 常量表达式求值。返回 1 表示成功，0 表示无法在编译期确定。
 * 用于全局变量初值（int x = 1+2;）、case 标签、数组维度等场景。
 * 该求值器与 ARM ABI 假设保持一致：所有整数按 32 位运算。 */
int eval_const_expr(AstNode *node, int *out_value) {
    int lv, rv;
    if (!node || !out_value) return 0;
    switch (node->kind) {
        case AST_NUM:
            /* 浮点字面量不在整型常量表达式中支持 */
            if (node->type && (node->type->kind == TYPE_FLOAT || node->type->kind == TYPE_DOUBLE))
                return 0;
            *out_value = node->u.num_val;
            return 1;
        case AST_SIZEOF:
            *out_value = node->u.num_val;
            return 1;
        case AST_CAST:
            /* 简化：cast 透传值（不做截断） */
            return eval_const_expr(node->u.unary.operand, out_value);
        case AST_VAR: {
            Symbol *s = sym_find(node->u.name);
            if (s && s->kind == SYM_ENUM_CONST) {
                *out_value = s->enum_value;
                return 1;
            }
            return 0;
        }
        case AST_UNARY:
            if (!eval_const_expr(node->u.unary.operand, &lv)) return 0;
            switch (node->u.unary.op) {
                case (int)TOK_MINUS: *out_value = -lv; return 1;
                case (int)TOK_PLUS:  *out_value =  lv; return 1;
                case (int)TOK_BNOT:  *out_value = ~lv; return 1;
                case (int)TOK_NOT:   *out_value = !lv; return 1;
                default: return 0;
            }
        case AST_BINARY:
            if (!eval_const_expr(node->u.binary.left,  &lv)) return 0;
            if (!eval_const_expr(node->u.binary.right, &rv)) return 0;
            switch (node->u.binary.op) {
                case (int)TOK_PLUS:  *out_value = lv +  rv; return 1;
                case (int)TOK_MINUS: *out_value = lv -  rv; return 1;
                case (int)TOK_MUL:   *out_value = lv *  rv; return 1;
                case (int)TOK_DIV:   if (rv == 0) return 0; *out_value = lv / rv; return 1;
                case (int)TOK_MOD:   if (rv == 0) return 0; *out_value = lv % rv; return 1;
                case (int)TOK_BAND:  *out_value = lv &  rv; return 1;
                case (int)TOK_BOR:   *out_value = lv |  rv; return 1;
                case (int)TOK_BXOR:  *out_value = lv ^  rv; return 1;
                case (int)TOK_SHL:   *out_value = lv << rv; return 1;
                case (int)TOK_SHR:   *out_value = lv >> rv; return 1;
                case (int)TOK_EQ:    *out_value = lv == rv; return 1;
                case (int)TOK_NE:    *out_value = lv != rv; return 1;
                case (int)TOK_LT:    *out_value = lv <  rv; return 1;
                case (int)TOK_GT:    *out_value = lv >  rv; return 1;
                case (int)TOK_LE:    *out_value = lv <= rv; return 1;
                case (int)TOK_GE:    *out_value = lv >= rv; return 1;
                case (int)TOK_AND:   *out_value = lv && rv; return 1;
                case (int)TOK_OR:    *out_value = lv || rv; return 1;
                default: return 0;
            }
        case AST_TERNARY: {
            int cv;
            if (!eval_const_expr(node->u.ternary.cond, &cv)) return 0;
            if (cv) return eval_const_expr(node->u.ternary.true_expr,  out_value);
            else    return eval_const_expr(node->u.ternary.false_expr, out_value);
        }
        default:
            return 0;
    }
}

int sema_check(AstNode *prog) {
    int i;
    g_errors = 0;
    sym_init();
    if (!prog || prog->kind != AST_PROGRAM) return 0;
    /* 内建函数：把 host libc 暴露的简易函数预先登记，避免"未定义函数"误报 */
    {
        const char *builtins[] = {
            "printf","putchar","puts","strlen","strcmp","strcpy",
            "memset","memcpy","abort","malloc","free",0
        };
        int k;
        for (k = 0; builtins[k]; k++) {
            Symbol *s = sym_add(SYM_FUNC, builtins[k], type_int(), 0);
            s->param_count = -1; /* 未知 */
            s->is_variadic = 1;
        }
    }
    for (i = 0; i < prog->u.program.decl_count; i++) {
        sema_decl(prog->u.program.decls[i]);
    }
    return g_errors;
}

static void sema_func(AstNode *node) {
    char *name = node->u.func.name;
    Symbol *existing = sym_find_current(name);
    Symbol *s;
    int i;
    if (existing) {
        if (existing->kind != SYM_FUNC) {
            err(node, "redefinition of identifier as function");
            return;
        }
        if (existing->is_defined && node->u.func.body) {
            err(node, "function redefinition");
            return;
        }
        s = existing;
    } else {
        s = sym_add(SYM_FUNC, name, node->u.func.ret_type, 0);
    }
    s->param_count = node->u.func.param_count;
    s->is_variadic = node->u.func.is_variadic;
    s->svc_num = node->u.func.svc_num;
    /* 传播 ARM Compiler 5 函数属性到符号表，供 irgen 读出写入 IrFunc。
     * 使用 OR 合并：当函数先声明（带属性）再定义（不带属性）时，
     * 保留属性。 */
    if (node->u.func.is_irq)   s->is_irq   = 1;
    if (node->u.func.is_weak)  s->is_weak  = 1;
    if (node->u.func.is_naked) s->is_naked = 1;
    if (node->u.func.is_used)  s->is_used  = 1;
    if (node->u.func.is_unused) s->is_unused = 1;
    if (node->u.func.is_asm_func) s->is_asm_func = 1;
    if (node->u.func.forceinline) s->forceinline = 1;
    if (node->u.func.alias_target) s->alias_target = node->u.func.alias_target;
    /* 反向回写：让 AST 节点也得到合并后的属性，方便 irgen 直接用 d->u.func.* */
    node->u.func.is_irq   = s->is_irq;
    node->u.func.is_weak  = s->is_weak;
    node->u.func.is_naked = s->is_naked;
    node->u.func.is_used  = s->is_used;
    node->u.func.is_unused = s->is_unused;
    node->u.func.forceinline = s->forceinline;
    if (!node->u.func.alias_target) node->u.func.alias_target = s->alias_target;
    if (node->u.func.body || node->u.func.is_asm_func ||
        node->u.func.alias_target) {
        s->is_defined = 1;
    }
    if (node->u.func.is_asm_func) {
        /* __asm 函数体：不做 body 语义检查 */
        return;
    }

    if (node->u.func.body) {
        sym_enter_scope();
        for (i = 0; i < node->u.func.param_count; i++) {
            AstNode *pp = node->u.func.params[i];
            if (sym_find_current(pp->u.var.name)) {
                err(pp, "duplicate parameter");
            } else {
                Symbol *psym = sym_add(SYM_PARAM, pp->u.var.name, pp->u.var.var_type, 0);
                (void)psym;
            }
        }
        sema_stmt(node->u.func.body);
        sym_leave_scope();
    }
}

static void sema_decl(AstNode *node) {
    if (!node) return;
    switch (node->kind) {
        case AST_FUNC_DEF:
        case AST_FUNC_DECL:
        case AST_ASM_FUNC:
            sema_func(node);
            break;
        case AST_VAR_DECL: {
            char *name = node->u.var.name;
            if (!name) return;
            if (sym_find_current(name)) {
                /* 允许 extern 重复声明 */
                if (!node->u.var.is_extern) err(node, "redeclaration of global variable");
                return;
            }
            sym_add(SYM_GLOBAL, name, node->u.var.var_type, 0);
            node->u.var.is_global = 1;
            if (node->u.var.init) sema_expr(node->u.var.init);
            break;
        }
        case AST_TYPEDEF:
            if (node->u.var.name)
                sym_add(SYM_TYPEDEF, node->u.var.name, node->u.var.var_type, 0);
            break;
        case AST_BLOCK: {
            int i;
            for (i = 0; i < node->u.block.stmt_count; i++)
                sema_decl(node->u.block.stmts[i]);
            break;
        }
        default:
            /* 忽略其他 */
            break;
    }
}

static void sema_stmt(AstNode *node) {
    if (!node) return;
    switch (node->kind) {
        case AST_BLOCK: {
            int i;
            sym_enter_scope();
            for (i = 0; i < node->u.block.stmt_count; i++) {
                sema_stmt(node->u.block.stmts[i]);
            }
            sym_leave_scope();
            break;
        }
        case AST_VAR_DECL: {
            char *name = node->u.var.name;
            if (!name) break;
            if (sym_find_current(name)) {
                err(node, "redeclaration of local variable");
            } else {
                sym_add(SYM_VAR, name, node->u.var.var_type, 0);
            }
            if (node->u.var.init) sema_expr(node->u.var.init);
            break;
        }
        case AST_TYPEDEF:
            if (node->u.var.name)
                sym_add(SYM_TYPEDEF, node->u.var.name, node->u.var.var_type, 0);
            break;
        case AST_IF:
            sema_expr(node->u.if_stmt.cond);
            sema_stmt(node->u.if_stmt.then_stmt);
            if (node->u.if_stmt.else_stmt) sema_stmt(node->u.if_stmt.else_stmt);
            break;
        case AST_WHILE:
            sema_expr(node->u.while_stmt.cond);
            sema_stmt(node->u.while_stmt.body);
            break;
        case AST_FOR:
            sym_enter_scope();
            if (node->u.for_stmt.init) {
                if (node->u.for_stmt.init->kind == AST_VAR_DECL ||
                    node->u.for_stmt.init->kind == AST_BLOCK)
                    sema_stmt(node->u.for_stmt.init);
                else
                    sema_expr(node->u.for_stmt.init);
            }
            if (node->u.for_stmt.cond) sema_expr(node->u.for_stmt.cond);
            if (node->u.for_stmt.step) sema_expr(node->u.for_stmt.step);
            sema_stmt(node->u.for_stmt.body);
            sym_leave_scope();
            break;
        case AST_DO_WHILE:
            sema_stmt(node->u.while_stmt.body);
            sema_expr(node->u.while_stmt.cond);
            break;
        case AST_SWITCH:
            sema_expr(node->u.switch_stmt.expr);
            sema_stmt(node->u.switch_stmt.body);
            break;
        case AST_CASE:
        case AST_DEFAULT:
            sema_stmt(node->u.case_stmt.stmt);
            break;
        case AST_LABEL:
            sema_stmt(node->u.label_stmt.stmt);
            break;
        case AST_GOTO:
            /* 不做完整检查 */
            break;
        case AST_RETURN:
            if (node->u.unary.operand) sema_expr(node->u.unary.operand);
            break;
        case AST_BREAK:
        case AST_CONTINUE:
            break;
        case AST_EXPR_STMT:
            if (node->u.unary.operand) sema_expr(node->u.unary.operand);
            break;
        case AST_ASM:
            /* 不做语义检查 */
            break;
        default:
            sema_expr(node);
            break;
    }
}

static Type *sema_expr(AstNode *node) {
    if (!node) return type_int();
    switch (node->kind) {
        case AST_NUM:
            if (!node->type) node->type = type_int();
            return node->type;
        case AST_STR:
            if (!node->type) node->type = type_pointer(type_char());
            return node->type;
        case AST_SIZEOF:
            node->type = type_int();
            return node->type;
        case AST_INIT_LIST: {
            int i;
            for (i = 0; i < node->u.init_list.item_count; i++) {
                AstNode *it = node->u.init_list.items[i];
                if (it && it->u.init_field.value) sema_expr(it->u.init_field.value);
            }
            node->type = type_int();
            return node->type;
        }
        case AST_ASM:
            node->type = type_void();
            return node->type;
        case AST_VAR: {
            Symbol *s = sym_find(node->u.name);
            if (!s) {
                err(node, "undeclared identifier");
                node->type = type_int();
                return node->type;
            }
            node->type = s->type;
            return node->type;
        }
        case AST_BINARY:
        case AST_COMMA: {
            Type *t = type_int();
            sema_expr(node->u.binary.left);
            sema_expr(node->u.binary.right);
            if (node->kind == AST_COMMA) {
                if (node->u.binary.right) t = node->u.binary.right->type ? node->u.binary.right->type : type_int();
            } else {
                /* 类型推导：算术运算的结果类型取左右"较宽"的浮点类型；
                 * 比较与逻辑运算结果恒为 int。 */
                int op = node->u.binary.op;
                int is_cmp = (op == (int)TOK_EQ || op == (int)TOK_NE ||
                              op == (int)TOK_LT || op == (int)TOK_GT ||
                              op == (int)TOK_LE || op == (int)TOK_GE ||
                              op == (int)TOK_AND || op == (int)TOK_OR);
                if (!is_cmp) {
                    Type *lt = node->u.binary.left  ? node->u.binary.left->type  : 0;
                    Type *rt = node->u.binary.right ? node->u.binary.right->type : 0;
                    t = usual_arith_conv(lt, rt);
                }
            }
            node->type = t;
            return node->type;
        }
        case AST_UNARY: {
            Type *t = sema_expr(node->u.unary.operand);
            if (node->u.unary.op == (int)TOK_BAND) {
                node->type = type_pointer(t);
            } else if (node->u.unary.op == (int)TOK_MUL) {
                if (t && (t->kind == TYPE_PTR || t->kind == TYPE_ARRAY))
                    node->type = t->base;
                else
                    node->type = type_int();
            } else {
                node->type = t ? t : type_int();
            }
            return node->type;
        }
        case AST_CAST:
            sema_expr(node->u.unary.operand);
            return node->type;
        case AST_ASSIGN:
            sema_expr(node->u.binary.left);
            sema_expr(node->u.binary.right);
            node->type = node->u.binary.left->type;
            return node->type;
        case AST_FUNC_CALL: {
            Symbol *s = sym_find(node->u.call.name);
            int i;
            if (!s || s->kind != SYM_FUNC) {
                /* 函数指针调用或外部函数：允许，给出 int 类型 */
                for (i = 0; i < node->u.call.arg_count; i++)
                    sema_expr(node->u.call.args[i]);
                node->type = type_int();
                return node->type;
            }
            for (i = 0; i < node->u.call.arg_count; i++)
                sema_expr(node->u.call.args[i]);
            if (s->param_count >= 0 && !s->is_variadic &&
                s->param_count != node->u.call.arg_count) {
                ark_log("[sema] line %d: warning: argument count mismatch for '%s'\n",
                        node->line, node->u.call.name);
            }
            node->type = s->type;
            return node->type;
        }
        case AST_ARRAY_ACCESS: {
            Type *t = sema_expr(node->u.array_access.array);
            sema_expr(node->u.array_access.index);
            if (!t || (t->kind != TYPE_ARRAY && t->kind != TYPE_PTR)) {
                /* 容忍：未知类型按 int 处理 */
                node->type = type_int();
                return node->type;
            }
            node->type = t->base;
            return node->type;
        }
        case AST_MEMBER: {
            Type *t = sema_expr(node->u.member.obj);
            Type *st = t;
            StructField *f;
            if (node->u.member.is_arrow && t && t->kind == TYPE_PTR) st = t->base;
            f = type_find_field(st, node->u.member.member);
            if (f) {
                node->u.member.offset = f->offset;
                node->type = f->type;
            } else {
                node->type = type_int();
            }
            return node->type;
        }
        case AST_TERNARY: {
            Type *tt;
            sema_expr(node->u.ternary.cond);
            tt = sema_expr(node->u.ternary.true_expr);
            sema_expr(node->u.ternary.false_expr);
            node->type = tt;
            return node->type;
        }
        default:
            node->type = type_int();
            return node->type;
    }
}
