/* Ark C Compiler - sema
 * ???????????????/????????????????????
 * ?????????????????? > 4 ????????????????????????? typedef??????????????
 */
#include "sema.h"
#include "symtab.h"
#include "memory.h"
#include "platform.h"
#include "common.h"

static int g_errors;

/* Forward declarations */
static void sema_decl(AstNode *node);
static void sema_stmt(AstNode *node);
static Type *sema_expr(AstNode *node);
static AstNode *sema_implicit_cast(AstNode *node, Type *target);

static void err(AstNode *node, const char *msg) {
    ark_log("[sema] line %d: %s\n", node ? node->line : 0, msg);
    g_errors++;
}

/* ??????????C99 6.3.1.1????char/short/_Bool/enum ????? int??
 * ??? int ???????????????????? uchar/ushort?????????????????? int??
 * int/long/llong ???????? */
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

/* ???????C99 6.3.1.1???????? usual arithmetic conversions ?????????????
 * ???? sizeof(long)==sizeof(int)==4??ARM ?? Windows LLP64 ??????
 *   int/unsigned int       -> 1
 *   long/unsigned long     -> 2
 *   long long/unsigned ll  -> 3
 * ??????char/short/bool/enum????? promote_integer ?????? int????=1?? */
static int type_rank(Type *t) {
    if (!t) return 1;
    switch (t->kind) {
        case TYPE_LLONG: return 3;
        case TYPE_LONG:  return 2;
        default:         return 1;  /* int ?????????????? */
    }
}

/* usual arithmetic conversions (C99 6.3.1.8)??
 *   1. ???????????double > float?????? double ??? double?????????? float ? float??
 *   2. ?????????????????????????char/short/_Bool/enum -> int????
 *   3. ????????????
 *   4. ???????????????????unsigned int + int -> unsigned int????
 *   5. ??????
 *      - ?????????????????????????????????????????? ?? ???????????????????
 *        ???????????
 *      - ????????????????????????
 * ????????????????????????irgen ??? is_unsigned ???????/???/??????????? */
Type *usual_arith_conv(Type *lt, Type *rt) {
    /* complex ??????????????? _Complex ????? _Complex double */
    if (lt && lt->kind == TYPE_COMPLEX) return type_complex(type_double());
    if (rt && rt->kind == TYPE_COMPLEX) return type_complex(type_double());
    /* ?? 1 ???????????? */
    if (lt && lt->kind == TYPE_DOUBLE) return type_double();
    if (rt && rt->kind == TYPE_DOUBLE) return type_double();
    if (lt && lt->kind == TYPE_FLOAT)  return type_float();
    if (rt && rt->kind == TYPE_FLOAT)  return type_float();

    /* ?? 2 ???????????? */
    lt = promote_integer(lt);
    rt = promote_integer(rt);
    if (!lt) return rt ? rt : type_int();
    if (!rt) return lt;

    /* ?? 3 ??????????????? */
    if (lt->kind == rt->kind && lt->is_unsigned == rt->is_unsigned) return lt;

    {
        int rl = type_rank(lt);
        int rr = type_rank(rt);
        Type *hi, *lo;   /* ????? / ????? */
        int hi_uns, lo_uns;

        if (rl >= rr) { hi = lt; lo = rt; }
        else          { hi = rt; lo = lt; }
        hi_uns = hi->is_unsigned;
        lo_uns = lo->is_unsigned;

        /* ?? 4 ???????????????????? 3 ????????????????????????????
         * ??????????C99 6.3.1.8??????????????????????
         * ???hi ???????????????????????? hi_uns || lo_uns ????? */
        if (rl == rr) {
            int take_uns = (hi_uns || lo_uns);
            switch (hi->kind) {
                case TYPE_LLONG: return take_uns ? type_ullong() : type_llong();
                case TYPE_LONG:  return take_uns ? type_ulong()  : type_long();
                default:         return take_uns ? type_uint()   : type_int();
            }
        }

        /* ?? 5 ?????????????????????????????????
         * ???????????????????????????????????????? int=long=4B??llong=8B??
         * ?? long(??2) ?? int(??1) ?????rank ?????????????
         *   - ????????????????????????????????
         *   - ?????????? + ?????????????????
         *   - ?????????? + ???????????????????????????? llong 8B vs uint 4B??
         *     ???????????????????? long 4B vs uint 4B??????????????????????? */
        if (hi_uns || !lo_uns) {
            /* ????????? ????????????????????????????????????????????? */
            return hi;
        }
        {
            int hi_bytes = (hi->kind == TYPE_LLONG) ? 8 : 4;
            int lo_bytes = (lo->kind == TYPE_LLONG) ? 8 : 4;
            if (hi_bytes > lo_bytes) {
                /* ??????????? llong 8B vs uint 4B???????????????????????????? */
                return hi;
            }
            /* ???????????????????????????????????????? */
            switch (hi->kind) {
                case TYPE_LLONG: return type_ullong();
                case TYPE_LONG:  return type_ulong();
                default:         return type_uint();
            }
        }
    }
}

/* Bug-I1: Determine whether a cast from src to dst would change the IR
 * representation (i.e., is not a no-op on the target machine).
 * Returns 1 if an explicit AST_CAST node must be inserted, 0 otherwise.
 * - float <-> int:   always needs a cast (IR_I2F / IR_F2I)
 * - int(32b) <-> ll(64b): needs a cast (widen / narrow stack slots)
 * - same-size int <-> int: no-op (signedness change is represented in type only)
 * - float <-> double:  not handled yet (irgen lacks float<->double promotion);
 *   skip cast so current float arithmetic keeps working.
 * - non-arithmetic types: no-op (pointer/struct/etc. casts are address passes) */
static int cast_changes_repr(Type *src, Type *dst) {
    int src_float, dst_float;
    if (!src || !dst) return 0;
    if (!type_is_arith(src) || !type_is_arith(dst)) return 0;
    src_float = (src->kind == TYPE_FLOAT || src->kind == TYPE_DOUBLE);
    dst_float = (dst->kind == TYPE_FLOAT || dst->kind == TYPE_DOUBLE);
    if (src_float && !dst_float) return 1;        /* float -> int */
    if (!src_float && dst_float) return 1;        /* int -> float */
    if (src_float && dst_float) return 0;          /* float <-> double: skip */
    /* both are integer types: cast only if size differs */
    return (type_size(src) != type_size(dst));
}

/* Bug-I1: Insert an implicit AST_CAST wrapping `node` to convert it to
 * `target` type, following C99 6.3 (assignment / usual arithmetic
 * conversions). Returns `node` unchanged when no actual conversion is
 * needed so that downstream IR is not polluted by redundant cast nodes. */
static AstNode *sema_implicit_cast(AstNode *node, Type *target) {
    if (!node || !target) return node;
    if (!node->type) return node;
    if (!cast_changes_repr(node->type, target)) return node;
    return ast_cast(target, node, node->line);
}

int eval_const_expr(AstNode *node, long long *out_value) {
    long long lv, rv;
    if (!node || !out_value) return 0;
    switch (node->kind) {
        case AST_NUM:
            /* ??????????????????????????????? */
            if (node->type && (node->type->kind == TYPE_FLOAT || node->type->kind == TYPE_DOUBLE))
                return 0;
            *out_value = node->u.num_val;
            return 1;
        case AST_SIZEOF:
            *out_value = node->u.num_val;
            return 1;
        case AST_CAST:
            /* ???cast ?????????????? */
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
            long long cv;
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
    /* ??????????? host libc ?????????????????????"?????????"?? */
    {
        const char *builtins[] = {
            "printf","putchar","puts","strlen","strcmp","strcpy",
            "memset","memcpy","abort","malloc","free",0
        };
        int k;
        for (k = 0; builtins[k]; k++) {
            Symbol *s = sym_add(SYM_FUNC, builtins[k], type_int(), 0);
            s->param_count = -1; /* ??? */
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
            /* armcc __weak redefinition rule: a weak definition can be
             * overridden by a later non-weak definition of the same name.
             * Multiple weak definitions are allowed (first wins). A weak
             * redefinition of an already-defined non-weak function is
             * silently ignored. Two non-weak definitions remain an error. */
            if (!existing->is_weak && !node->u.func.is_weak) {
                err(node, "function redefinition");
                return;
            }
            if (!existing->is_weak && node->u.func.is_weak) {
                /* Existing non-weak, new weak: ignore new weak definition. */
                return;
            }
            if (existing->is_weak && !node->u.func.is_weak) {
                /* Override weak definition: clear is_defined/is_weak so the
                 * new non-weak body will be installed below as the canonical
                 * definition. irgen skips the discarded weak AST node by
                 * detecting symbol.is_weak != ast.is_weak. */
                existing->is_defined = 0;
                existing->is_weak = 0;
            } else {
                /* Both weak: ignore the new definition (first wins). */
                return;
            }
        }
        s = existing;
    } else {
        s = sym_add(SYM_FUNC, name, node->u.func.ret_type, 0);
    }
    s->param_count = node->u.func.param_count;
    s->is_variadic = node->u.func.is_variadic;
    /* Store parameter types so call sites can do 64-bit arg promotion
     * (int -> long long) based on the PARAMETER type, not the arg type.
     * Each params[i] is an AST_VAR_DECL whose u.var.var_type is the
     * parameter's declared type. */
    if (node->u.func.param_count > 0 && node->u.func.params) {
        s->param_types = (Type **)mem_pool_alloc(sizeof(Type *) * node->u.func.param_count);
        for (i = 0; i < node->u.func.param_count; i++) {
            AstNode *pp = node->u.func.params[i];
            s->param_types[i] = (pp && pp->u.var.var_type) ? pp->u.var.var_type : 0;
        }
    }
    s->svc_num = node->u.func.svc_num;
    /* ???? ARM Compiler 5 ?????????????????? irgen ???????? IrFunc??
     * ??? OR ????????????????????????????????????????????
     * ????????? */
    if (node->u.func.is_irq)   s->is_irq   = 1;
    if (node->u.func.is_weak)  s->is_weak  = 1;
    if (node->u.func.is_naked) s->is_naked = 1;
    if (node->u.func.is_used)  s->is_used  = 1;
    if (node->u.func.is_unused) s->is_unused = 1;
    if (node->u.func.is_asm_func) s->is_asm_func = 1;
    if (node->u.func.forceinline) s->forceinline = 1;
    if (node->u.func.alias_target) s->alias_target = node->u.func.alias_target;
    /* ??????????? AST ?????????????????????? irgen ????? d->u.func.* */
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
        /* __asm ??????????? body ?????? */
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
            Symbol *existing;
            if (!name) return;
            existing = sym_find_current(name);
            if (existing) {
                /* Parser pre-registers globals as SYM_VAR at parse time so
                 * sizeof(var)/sizeof(var[i]) can be resolved. Upgrade it to
                 * SYM_GLOBAL here (the canonical kind for downstream irgen). */
                if (existing->kind == SYM_VAR) {
                    existing->kind = SYM_GLOBAL;
                    existing->is_extern = node->u.var.is_extern;
                    node->u.var.is_global = 1;
                    if (node->u.var.init) sema_expr(node->u.var.init);
                    break;
                }
                /* Allow extern declaration after any prior declaration (redundant but legal).
                 * Allow definition after extern declaration (standard header/source pattern).
                 * Only error on actual redefinition (two non-extern definitions). */
                if (node->u.var.is_extern) return;
                if (existing->is_extern) return;
                err(node, "redeclaration of global variable");
                return;
            }
            {
                Symbol *sym = sym_add(SYM_GLOBAL, name, node->u.var.var_type, 0);
                sym->is_extern = node->u.var.is_extern;
            }
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
            /* ???????? */
            break;
    }
}

static void sema_stmt(AstNode *node) {
    if (!node) return;
    switch (node->kind) {
        case AST_BLOCK: {
            int i;
            /* ?????????????????????????????????????????? */
            if (!node->u.block.is_decl_list) sym_enter_scope();
            for (i = 0; i < node->u.block.stmt_count; i++) {
                sema_stmt(node->u.block.stmts[i]);
            }
            if (!node->u.block.is_decl_list) sym_leave_scope();
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
            /* ??????????? */
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
            /* ?????????? */
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
                int op = node->u.binary.op;
                int is_cmp = (op == (int)TOK_EQ || op == (int)TOK_NE ||
                              op == (int)TOK_LT || op == (int)TOK_GT ||
                              op == (int)TOK_LE || op == (int)TOK_GE ||
                              op == (int)TOK_AND || op == (int)TOK_OR);
                Type *lt = node->u.binary.left  ? node->u.binary.left->type  : 0;
                Type *rt = node->u.binary.right ? node->u.binary.right->type : 0;
                Type *common = usual_arith_conv(lt, rt);
                if (!is_cmp) {
                    t = common;
                }
                /* Bug-I1: Cast both operands to the common type so irgen sees
                 * consistent operand types and emits proper IR_I2F / IR_F2I /
                 * 64-bit widen instructions. Only for arithmetic operands;
                 * pointer arithmetic (ptr + int) is left untouched. */
                if (common && lt && rt &&
                    type_is_arith(lt) && type_is_arith(rt)) {
                    node->u.binary.left  = sema_implicit_cast(node->u.binary.left,  common);
                    node->u.binary.right = sema_implicit_cast(node->u.binary.right, common);
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
            /* Bug-I1: Apply assignment conversion (C99 6.5.16.1): cast RHS
             * to LHS type when the two differ meaningfully (e.g. int -> double,
             * int -> long long). Same-size int<->int is a no-op cast. */
            if (node->u.binary.left && node->u.binary.right) {
                Type *lt = node->u.binary.left->type;
                node->u.binary.right = sema_implicit_cast(node->u.binary.right, lt);
            }
            node->type = node->u.binary.left->type;
            return node->type;
        case AST_FUNC_CALL: {
            Symbol *s = sym_find(node->u.call.name);
            int i;
            if (!s || s->kind != SYM_FUNC) {
                /* Indirect call (callee is a function pointer expression):
                 * must sema the callee so member offsets/types are resolved.
                 * Direct calls to unknown functions: just sema the args. */
                if (node->u.call.callee) {
                    Type *ct = sema_expr(node->u.call.callee);
                    /* Use callee's return type if it's a function pointer */
                    if (ct && ct->kind == TYPE_PTR && ct->base &&
                        ct->base->kind == TYPE_FUNC) {
                        node->type = ct->base->base;
                    } else {
                        node->type = type_int();
                    }
                } else {
                    node->type = type_int();
                }
                for (i = 0; i < node->u.call.arg_count; i++)
                    sema_expr(node->u.call.args[i]);
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
                /* ????????????? int ???? */
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
            Type *tt, *ft, *common;
            sema_expr(node->u.ternary.cond);
            tt = sema_expr(node->u.ternary.true_expr);
            ft = sema_expr(node->u.ternary.false_expr);
            /* Bug-I1 (B6): C99 6.5.15 - the result type is the common type
             * of the two branches after usual arithmetic conversions. Cast
             * both branches to the common type so irgen produces consistent
             * code. */
            common = usual_arith_conv(tt, ft);
            if (common && tt && ft &&
                type_is_arith(tt) && type_is_arith(ft)) {
                node->u.ternary.true_expr  = sema_implicit_cast(node->u.ternary.true_expr,  common);
                node->u.ternary.false_expr = sema_implicit_cast(node->u.ternary.false_expr, common);
                tt = common;
            }
            node->type = tt;
            return node->type;
        }
        default:
            node->type = type_int();
            return node->type;
    }
}
