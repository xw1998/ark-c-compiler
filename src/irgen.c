/* Ark C Compiler - irgen
 * AST -> ?? IR??
 *
 * ???????????????????????
 *   - ???? 0..N-1 ???????????? PUSH ???????IR_CALL n ????????? n ???
 *     ???????????????/?????????? arg0..argN-1????
 *   - ?????????????????????????? GETARG ??????????
 *   - ????????????????????? + IR_PUSH_STR ??????
 *   - ????????? IR_PUSH_GLOBAL / IR_STORE_GLOBAL ??????
 */
#include "irgen.h"
#include "symtab.h"
#include "memory.h"
#include "platform.h"
#include "common.h"
#include "sema.h"
#include "config.h"
#include "arkcc_config.h"
#include <stdio.h>   /* snprintf?????? sb_putf ?????????????? */

/* ???????????????? AST ????????????????? C ????????
 * 64 KB ????????????? */
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
static void sb_putd(StrBuf *b, long long v) {
    char tmp[24]; int n = 0; unsigned long long u; int neg = 0; int i;
    if (v < 0) { neg = 1; u = (unsigned long long)(-v); } else u = (unsigned long long)v;
    if (u == 0) tmp[n++] = '0';
    while (u) { tmp[n++] = (char)('0' + u % 10); u /= 10; }
    if (neg) sb_putc(b, '-');
    for (i = n - 1; i >= 0; i--) sb_putc(b, tmp[i]);
}
static void sb_putf(StrBuf *b, double v) {
    /* ?? %.17g ???????????????????????????????
     * ?????????????????? 1e-10???????????? 1e100???? */
    char tmp[64];
    snprintf(tmp, sizeof(tmp), "%.17g", v);
    sb_puts(b, tmp);
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

/* ?? AST ??????? C ?????????? sb?????????????????????? */
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
            /* If the name refers to a function defined in this translation
             * unit, the C backend emits it as ark_<name>; we must match that
             * prefix here so function pointers in global initializers
             * (e.g. Backend g_arm_backend = { ..., arm_emit, ... }) resolve
             * to the generated ark_arm_emit symbol. */
            if (n->u.name) {
                Symbol *s = sym_find(n->u.name);
                if (s && s->kind == SYM_FUNC) sb_puts(b, "ark_");
                sb_puts(b, n->u.name);
            } else sb_putd(b, 0);
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

/* ?????????????????? char a[]="..." ??? init list???? C ????????????????????????
 * ??????????????????????????????????? */

typedef struct {
    IrProgram *prog;
    IrFunc    *fn;
    int        bp;
    int        max_size;
    int        break_label;
    int        cont_label;
    /* switch ????????? */
    int       *case_labels;     /* ??? case ?????????? */
    int       *case_values;
    int        case_count;
    int        default_label;
    int        switch_end_label;
} IrGen;

static void irgen_stmt(IrGen *g, AstNode *node);
static void irgen_expr(IrGen *g, AstNode *node);
static void irgen_lvalue_addr(IrGen *g, AstNode *node);
/* ????????????? init_list ???????????????? off ???? t ?????
 * ??? C99 ?????????????designated initializer??.field / [idx]???? */
static void irgen_local_aggregate_init(IrGen *g, int off, Type *t, AstNode *init_list);
/* C99 ?????????? (type){...}????????????? ark_cl_<n>?????????????
 * ????????????????????????????????? C99 ????????????????????? */
static const char *irgen_compound_literal(IrGen *g, AstNode *node);
/* ?????????????????????????????????????????????????????? */
static int g_compound_lit_counter = 0;

static int alloc_label(IrGen *g) {
    return g->fn->label_count++;
}

static int alloc_local(IrGen *g, int size) {
    /* ???? 8 ????????????????? long long / double ????????????
     * ???? Windows LLP64 ?? long=4 ?? double=8 ???? union ??????????? */
    int s = (size + 7) & ~7;
    int off;
    if (s <= 0) s = 8;
    off = g->bp;
    g->bp += s;
    if (g->bp > g->max_size) g->max_size = g->bp;
    return off;
}

/* ??????? static ????????????????????ark_sl_<func>_<var>??
 * ???????????? static ???????????????????????????????????
 * ??????????????????????????????????? */
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

/* ???????? switch body????? case/default ????????? */
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
        return; /* ??? switch ???????????? */
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

    /* Pre-pass: register all function/global symbols so cross-references
     * resolve correctly. Also handles armcc __weak override: a non-weak
     * definition overrides a prior weak definition of the same name. */
    for (i = 0; i < prog->u.program.decl_count; i++) {
        AstNode *d = prog->u.program.decls[i];
        if (d->kind == AST_FUNC_DEF || d->kind == AST_FUNC_DECL ||
            d->kind == AST_ASM_FUNC) {
            Symbol *existing = sym_find(d->u.func.name);
            if (!existing) {
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
                if (d->u.func.is_weak) s->is_weak = 1;
            } else {
                /* armcc __weak override: non-weak definition replaces weak. */
                if (existing->is_weak && !d->u.func.is_weak &&
                    (d->kind == AST_FUNC_DEF || d->kind == AST_ASM_FUNC)) {
                    existing->is_weak = 0;
                }
                /* If existing was a non-weak declaration and the actual
                 * definition is __weak, propagate the weak attribute to
                 * the symbol (mirrors sema's "if (node->is_weak) s->is_weak = 1").
                 * Without this, irgen's weak-skip check would wrongly discard
                 * the definition (symbol.is_weak=0 != ast.is_weak=1). */
                else if (!existing->is_weak && d->u.func.is_weak &&
                         (d->kind == AST_FUNC_DEF || d->kind == AST_ASM_FUNC)) {
                    existing->is_weak = 1;
                }
            }
        } else if (d->kind == AST_VAR_DECL && d->u.var.is_global) {
            Symbol *existing = sym_find(d->u.var.name);
            if (!existing) {
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
                        /* char a[]="hello" ?? char *p="..." */
                        gv->has_init = 1;
                        gv->init_str = iv->u.name;
                    } else if (iv->kind == AST_INIT_LIST) {
                        StrBuf sb; sb_init(&sb);
                        serialize_init(&sb, iv);
                        gv->has_init = 1;
                        gv->init_aggregate = sb.data;
                    } else if (iv->kind == AST_COMPOUND_LITERAL) {
                        /* ?????????????????????????? init ???? */
                        StrBuf sb; sb_init(&sb);
                        serialize_init(&sb, iv->u.compound_lit.init);
                        gv->has_init = 1;
                        gv->init_aggregate = sb.data;
                    } else {
                        /* ?????????????????????????????
                         * (sizeof, 1+2, ???????????????)??
                         * ?????????????????????? init_int???? ARM ???
                         * ????????? .word ?????C ????? init_aggregate
                         * ???????? enum ???????? */
                        long long cv = 0;
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
            } else if (!d->u.var.is_extern) {
                /* A definition follows an earlier extern declaration
                 * (e.g. header has `extern T x;`, source has `T x;`).
                 * Clear is_extern on the existing IrGlobal so the C
                 * backend emits a definition, not an extern prototype. */
                IrGlobal *eg = ir_program_find_global(out, d->u.var.name);
                if (eg) {
                    eg->is_extern = 0;
                    eg->is_const  = d->u.var.is_const;
                    eg->section   = d->u.var.section;
                    /* #3 FIX: Process initializer when definition follows extern.
                     * Previously the initializer was silently dropped, causing
                     * all .data globals preceded by extern declarations to
                     * have init_int=0 (e.g. SystemCoreClock=16000000 became 0). */
                    if (d->u.var.init && !eg->has_init) {
                        AstNode *iv = d->u.var.init;
                        if (iv->kind == AST_NUM) {
                            eg->has_init = 1;
                            eg->init_int = iv->u.num_val;
                            if (iv->type && (iv->type->kind == TYPE_FLOAT || iv->type->kind == TYPE_DOUBLE)) {
                                eg->is_float = 1;
                                eg->init_float = iv->fval;
                            }
                        } else if (iv->kind == AST_STR) {
                            eg->has_init = 1;
                            eg->init_str = iv->u.name;
                        } else if (iv->kind == AST_INIT_LIST) {
                            StrBuf sb; sb_init(&sb);
                            serialize_init(&sb, iv);
                            eg->has_init = 1;
                            eg->init_aggregate = sb.data;
                        } else if (iv->kind == AST_COMPOUND_LITERAL) {
                            StrBuf sb; sb_init(&sb);
                            serialize_init(&sb, iv->u.compound_lit.init);
                            eg->has_init = 1;
                            eg->init_aggregate = sb.data;
                        } else {
                            long long cv = 0;
                            eg->has_init = 1;
                            if (eval_const_expr(iv, &cv)) {
                                eg->init_int = cv;
                            } else {
                                StrBuf sb; sb_init(&sb);
                                serialize_const_expr(&sb, iv);
                                eg->init_aggregate = sb.data;
                            }
                        }
                    }
                }
            }
        } else if (d->kind == AST_TYPEDEF) {
            if (d->u.var.name) sym_add(SYM_TYPEDEF, d->u.var.name, d->u.var.var_type, 0);
        } else if (d->kind == AST_BLOCK) {
            /* ????????? */
            int j;
            for (j = 0; j < d->u.block.stmt_count; j++) {
                AstNode *c = d->u.block.stmts[j];
                if (c->kind == AST_VAR_DECL && c->u.var.is_global) {
                    Symbol *existing_c = sym_find(c->u.var.name);
                    if (!existing_c) {
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
                                long long cv = 0;
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
                    } else if (!c->u.var.is_extern) {
                        IrGlobal *eg = ir_program_find_global(out, c->u.var.name);
                        if (eg) {
                            eg->is_extern = 0;
                            eg->is_const  = c->u.var.is_const;
                            eg->section   = c->u.var.section;
                            /* #3 FIX: Process initializer for block-level globals too */
                            if (c->u.var.init && !eg->has_init) {
                                AstNode *iv = c->u.var.init;
                                if (iv->kind == AST_NUM) {
                                    eg->has_init = 1;
                                    eg->init_int = iv->u.num_val;
                                    if (iv->type && (iv->type->kind == TYPE_FLOAT || iv->type->kind == TYPE_DOUBLE)) {
                                        eg->is_float = 1;
                                        eg->init_float = iv->fval;
                                    }
                                } else if (iv->kind == AST_STR) {
                                    eg->has_init = 1;
                                    eg->init_str = iv->u.name;
                                } else if (iv->kind == AST_INIT_LIST) {
                                    StrBuf sb; sb_init(&sb);
                                    serialize_init(&sb, iv);
                                    eg->has_init = 1;
                                    eg->init_aggregate = sb.data;
                                } else if (iv->kind == AST_COMPOUND_LITERAL) {
                                    StrBuf sb; sb_init(&sb);
                                    serialize_init(&sb, iv->u.compound_lit.init);
                                    eg->has_init = 1;
                                    eg->init_aggregate = sb.data;
                                } else {
                                    long long cv = 0;
                                    eg->has_init = 1;
                                    if (eval_const_expr(iv, &cv)) {
                                        eg->init_int = cv;
                                    } else {
                                        StrBuf sb; sb_init(&sb);
                                        serialize_const_expr(&sb, iv);
                                        eg->init_aggregate = sb.data;
                                    }
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
            IrFunc *fn;
            /* armcc __weak override: skip if this weak asm func was
             * overridden by a non-weak definition (see AST_FUNC_DEF above). */
            {
                Symbol *fsym = sym_find(d->u.func.name);
                if (fsym && !!fsym->is_weak != !!d->u.func.is_weak) {
                    continue;
                }
            }
            fn = ir_func_new(d->u.func.name);
            fn->ret_type = d->u.func.ret_type;
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
            /* ???????? alias_target ??????????? IrFunc????????????????? */
            if (d->u.func.alias_target) {
                IrFunc *fn = ir_func_new(d->u.func.name);
                fn->ret_type = d->u.func.ret_type;
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
            /* armcc __weak override: skip IR generation for a weak definition
             * that has been overridden by a non-weak definition of the same
             * name. Detected by symbol.is_weak != ast.is_weak (the symbol's
             * is_weak was cleared in the pre-pass when the non-weak override
             * was seen). */
            {
                Symbol *fsym = sym_find(d->u.func.name);
                if (fsym && !!fsym->is_weak != !!d->u.func.is_weak) {
                    continue;
                }
            }
            g.prog = out;
            g.fn = ir_func_new(d->u.func.name);
            g.fn->ret_type = d->u.func.ret_type;
            g.fn->param_count = d->u.func.param_count;
            g.fn->is_variadic = d->u.func.is_variadic;
            g.fn->is_static = d->u.func.is_static;
            /* ???? ARM Compiler 5 ????????? IrFunc???????????
             * __attribute__((weak/naked)) ?? __irq ???? */
            g.fn->is_irq   = d->u.func.is_irq;
            /* Auto-detect ARM interrupt handlers by name suffix.
             * STM32CubeMX/HAL code doesn't use __irq keyword; without this,
             * ISRs would use the normal prologue and clobber r0-r3/r12.
             * Reset_Handler and Default_Handler are entry points, not ISRs. */
            if (!g.fn->is_irq && g.fn->name) {
                int nl = ark_strlen(g.fn->name);
                if (ark_streq(g.fn->name, "Reset_Handler") ||
                    ark_streq(g.fn->name, "Default_Handler")) {
                    /* entry point, not ISR */
                }
                else if (nl >= 8 && ark_streq(g.fn->name + nl - 8, "_Handler"))
                    g.fn->is_irq = 1;
                else if (nl >= 11 && ark_streq(g.fn->name + nl - 11, "_IRQHandler"))
                    g.fn->is_irq = 1;
            }
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
                Type *ptype = pp->u.var.var_type;
                int sz = type_size(ptype);
                int off;
                int is_struct_val = (ptype &&
                    (ptype->kind == TYPE_STRUCT || ptype->kind == TYPE_UNION) &&
                    sz > 8);
                if (sz <= 0) sz = 4;
                off = alloc_local(&g, sz);
                {
                    Symbol *s = sym_add(SYM_PARAM, pp->u.var.name, ptype, off);
                    (void)s;
                }
                /* For struct-by-value parameters (size > 8), the caller pushes
                 * the source struct address. Encode size in aux high bits so
                 * the C backend can emit memcpy(frame+off, src_ptr, size). */
                if (is_struct_val) {
                    ir_emit(g.fn, IR_GETARG, off, pp->u.var.name, (sz << 8) | j);
                } else {
                    ir_emit(g.fn, IR_GETARG, off, pp->u.var.name, j);
                }
            }
            /* For variadic functions, also store all 8 args (a0..a7) at a
             * fixed frame region (ARK_VA_ARG_BASE..+64) so va_start/va_arg
             * can access the variadic tail. The named-param area above keeps
             * its own offsets for direct named access. */
            if (d->u.func.is_variadic) {
                int k;
                for (k = 0; k < 8; k++) {
                    ir_emit(g.fn, IR_GETARG, 8000 + k * 8, 0, k);
                }
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

/* ????????????? init_list ???????????????? off ???? t ?????
 * ??? C99 ????????????? designated initializer??
 *   - ??????? item ?? [idx] ?????????? off + idx*elem_sz??
 *     ?? item ?????? INIT_LIST?????????????
 *   - ???????? item ?? .field ?????????? off + field->offset??
 *     ?? item ?????? INIT_LIST?????????????
 * ?????????????????????????????????????????????? */
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
                ir_emit(g->fn, IR_STORE, off + idx * elem_sz, 0, elem_sz);
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
                /* designated ??positional cursor ???? target ??? */
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
                int fsz = type_size(target->type);
                if (fsz <= 0) fsz = 4;
                irgen_expr(g, val);
                ir_emit(g->fn, IR_STORE, off + target->offset, 0, fsz);
            }
        }
    }
    /* ??????????????????????????? */
}

/* C99 ?????????? (type){...}?????????????????????????
 *   - ????/??????????? init ??????? C ?????????? init_aggregate
 *   - ???????? (int){42} ????? init_int ????????
 * ??????????????????????? PUSH_GLOBAL_ADDR ??????
 * ????????????????? decay ???????? irgen_expr ?????????? rvalue?? */
static const char *irgen_compound_literal(IrGen *g, AstNode *node) {
    char namebuf[32];
    IrGlobal *gv;
    Type *t = node->u.compound_lit.lit_type;
    AstNode *init = node->u.compound_lit.init;
    /* ??????????? ark_cl_<n> */
    {
        int n = g_compound_lit_counter++;
        int i = 0;
        const char *pfx = "ark_cl_";
        while (*pfx) namebuf[i++] = *pfx++;
        /* ?????????? */
        {
            char tmp[16]; int tn = 0; unsigned u = (unsigned)n;
            if (u == 0) tmp[tn++] = '0';
            while (u) { tmp[tn++] = (char)('0' + u % 10); u /= 10; }
            while (tn > 0) namebuf[i++] = tmp[--tn];
        }
        namebuf[i] = 0;
    }
    gv = ir_program_add_global(g->prog, namebuf, t);
    gv->is_static = 1;  /* ??????????????????????? */
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
    g_ir_cur_line = node->line;
    switch (node->kind) {
        case AST_BLOCK: {
            int i;
            int saved_bp = g->bp;
            /* ?????????????????????????????????????????? */
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
                break;
            }
            if (!node->u.var.name) break;
            if (node->u.var.is_static) {
                /* static ???????????????????????????? mangle ?
                 * ark_sl_<func>_<var>???????????????????? is_static=1
                 * ???? SYM_GLOBAL ???? AST_VAR/AST_ASSIGN ?? PUSH_GLOBAL/
                 * STORE_GLOBAL ?????????????????????? sym_find ?????? */
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
                        long long cv = 0;
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
            /* B3: ??????var_type ????? is_vla ???????
             * ??????????????????????4 ??????
             * ???????????????? * ?????? ?? IR_ALLOCA ?? ???????? */
            if (node->u.var.is_vla && g_config.enable_vla) {
                Type *elem_t = node->u.var.var_type->base;
                int elem_sz = type_size(elem_t);
                if (elem_sz <= 0) elem_sz = 4;
                /* ?????? */
                irgen_expr(g, node->u.var.vla_size_expr);
                /* * ?????? ?? ????? */
                ir_emit(g->fn, IR_PUSH_INT, elem_sz, 0, 0);
                ir_emit(g->fn, IR_BINARY, 0, 0, (int)TOK_MUL);
                /* ?????????????? */
                ir_emit(g->fn, IR_ALLOCA, 0, 0, 0);
                /* ??????? */
                ir_emit(g->fn, IR_STORE, off, 0, 0);
                break;
            }
#endif
            if (node->u.var.init) {
                AstNode *iv = node->u.var.init;
                if (iv->kind == AST_INIT_LIST) {
                    /* ????????????????????????????????????????????????
                     * ?????? C99 ????????????? designated initializer?? */
                    int total = sz;
                    int k;
                    for (k = 0; k < total; k += 4) {
                        ir_emit(g->fn, IR_PUSH_INT, 0, 0, 0);
                        ir_emit(g->fn, IR_STORE, off + k, 0, 4);
                    }
                    irgen_local_aggregate_init(g, off, node->u.var.var_type, iv);
                } else if (iv->kind == AST_STR && node->u.var.var_type &&
                           node->u.var.var_type->kind == TYPE_ARRAY) {
                    /* char a[]="..."?????? memcpy(frame+off, str, n)
                     * ?????????irgen ???? push ??????c ??? stk[--sp]=arg0??
                     * ??????????????push arg2, push arg1, push arg0?? */
                    const char *s2 = iv->u.name;
                    int slen = ark_strlen(s2);
                    int total = type_size(node->u.var.var_type);
                    int arr_len = node->u.var.var_type->size;
                    int copy_n;
                    int kk;
                    if (arr_len <= 0) arr_len = slen + 1;
                    copy_n = slen + 1;
                    if (copy_n > arr_len) copy_n = arr_len;
                    /* ???????? 4 ??????????? 8 ??? long long ???w??? */
                    for (kk = 0; kk < total; kk += 4) {
                        ir_emit(g->fn, IR_PUSH_INT, 0, 0, 0);
                        ir_emit(g->fn, IR_STORE, off + kk, 0, 4);
                    }
                    /* push n, src, dst??????????? arg0=dst?? */
                    ir_emit(g->fn, IR_PUSH_INT, copy_n, 0, 0);
                    {
                        int id = ir_program_add_string(g->prog, s2, slen);
                        ir_emit(g->fn, IR_PUSH_STR, id, s2, 0);
                    }
                    ir_emit(g->fn, IR_PUSH_ADDR, off, 0, 0);
                    ir_emit(g->fn, IR_CALL, 3, "memcpy", 0);
                    ir_emit(g->fn, IR_POP, 0, 0, 0);
                } else if (node->u.var.var_type &&
                           (node->u.var.var_type->kind == TYPE_STRUCT ||
                            node->u.var.var_type->kind == TYPE_UNION)) {
                    /* Struct/union init from a non-init-list expression.
                     * For small aggregates (<= 8 bytes), irgen_expr pushes the
                     * value as a long long bit pattern (covers AST_FUNC_CALL
                     * returns and AST_VAR struct-to-struct copy). Store it
                     * directly via IR_STORE; memcpy cannot be used because
                     * rvalues have no address (treating the value as a pointer
                     * caused STATUS_ACCESS_VIOLATION).
                     * For larger aggregates (> 8 bytes), require an lvalue
                     * source so we can take its address via irgen_lvalue_addr
                     * (handles AST_COMPOUND_LITERAL, AST_UNARY(*), AST_MEMBER,
                     * AST_ARRAY_ACCESS and AST_VAR of array type).
                     * Exception: AST_FUNC_CALL returning a struct is an rvalue
                     * but the C backend stores the result at frame+8176 and
                     * pushes its ADDRESS (not the value). Use irgen_expr to get
                     * the address, then IR_MEMCPY to copy to the destination. */
                    int struct_sz = type_size(node->u.var.var_type);
                    if (struct_sz <= 0) struct_sz = 4;
                    if (iv && iv->kind == AST_FUNC_CALL && struct_sz > 8) {
                        /* Large struct from function: C backend stores result
                         * at frame+8176 and irgen_expr pushes its ADDRESS.
                         * Use IR_MEMCPY (dst on top, src below) to copy. */
                        irgen_expr(g, iv);                        /* push src addr */
                        ir_emit(g->fn, IR_PUSH_ADDR, off, 0, 0);  /* push dst addr */
                        ir_emit(g->fn, IR_MEMCPY, struct_sz, 0, 0);
                    } else if (struct_sz <= 8) {
                        /* Small struct (<=8B): irgen_expr pushes the 8-byte
                         * value (covers AST_FUNC_CALL returning small struct
                         * and AST_VAR struct-to-struct copy). Store directly
                         * via IR_STORE; memcpy cannot be used because rvalues
                         * have no address (treating the value as a pointer
                         * caused STATUS_ACCESS_VIOLATION). */
                        irgen_expr(g, iv);
                        ir_emit(g->fn, IR_STORE, off, 0, 8);
                    } else {
                        /* Large struct var-to-var copy: take source address. */
                        irgen_lvalue_addr(g, iv);                 /* push src addr */
                        ir_emit(g->fn, IR_PUSH_ADDR, off, 0, 0);  /* push dst addr */
                        ir_emit(g->fn, IR_MEMCPY, struct_sz, 0, 0);
                    }
                } else {
                    irgen_expr(g, iv);
                    {
                        Type *st = iv ? iv->type : 0;
                        Type *dt = node->u.var.var_type;
                        int sf = st && (st->kind == TYPE_FLOAT || st->kind == TYPE_DOUBLE);
                        int df = dt && (dt->kind == TYPE_FLOAT || dt->kind == TYPE_DOUBLE);
                        int si = st && type_is_integer(st);
                        int di = dt && type_is_integer(dt);
                        if (sf && di)      ir_emit(g->fn, IR_F2I, 0, 0, 0);
                        else if (si && df) ir_emit(g->fn, IR_I2F, 0, 0, 0);
                        if (dt && dt->kind == TYPE_BOOL) {
                            ir_emit(g->fn, IR_PUSH_INT, 0, 0, 0);
                            ir_emit(g->fn, IR_BINARY, 0, 0, (int)TOK_NE);
                        }
                    }
                    {
                        /* Bug-N3 FIX: add TYPE_LLONG(8) and TYPE_DOUBLE(8) so
                         * 64-bit locals and doubles are stored with the right
                         * width. Without these cases store_aux stayed 0, which
                         * the ARM backend treats as "default 4 bytes",
                         * corrupting adjacent locals when storing long long or
                         * double values. */
                        int store_aux = 0;
                        if (node->u.var.var_type) {
                            switch (node->u.var.var_type->kind) {
                                case TYPE_CHAR:  store_aux = 1; break;
                                case TYPE_SHORT: store_aux = 2; break;
                                case TYPE_INT:
                                case TYPE_ENUM:  store_aux = 4; break;
                                case TYPE_LLONG:  store_aux = 8; break;
                                case TYPE_DOUBLE: store_aux = 8; break;
                                case TYPE_COMPLEX: store_aux = 16; break;
                                default:         store_aux = 0; break;
                            }
                            if (node->u.var.var_type->is_volatile)
                                store_aux |= IR_AUX_VOLATILE;
                        }
                        ir_emit(g->fn, IR_STORE, off, node->u.var.name, store_aux);
                    }
                }
            }
            break;
        }
        case AST_TYPEDEF:
            if (node->u.var.name)
                sym_add(SYM_TYPEDEF, node->u.var.name, node->u.var.var_type, 0);
            break;
        case AST_RETURN:
            if (node->u.unary.operand) {
                /* Struct/union return by value (> 8 bytes): the C backend
                 * stores the result at frame+8176 and returns a pointer.
                 * Push the ADDRESS of the struct (not its truncated value).
                 * For AST_FUNC_CALL, irgen_expr already pushes the result
                 * pointer (the callee returns _ark_ret_buf address).
                 * Small structs (<= 8 bytes) are returned as a value, not
                 * a pointer; irgen_expr pushes the value directly. */
                Type *rt = node->u.unary.operand->type;
                if (!rt) rt = g->fn->ret_type;
                if (rt && (rt->kind == TYPE_STRUCT || rt->kind == TYPE_UNION) &&
                    type_size(rt) > 8) {
                    if (node->u.unary.operand->kind == AST_FUNC_CALL) {
                        irgen_expr(g, node->u.unary.operand);
                    } else {
                        irgen_lvalue_addr(g, node->u.unary.operand);
                    }
                } else {
                    irgen_expr(g, node->u.unary.operand);
                }
            } else {
                ir_emit(g->fn, IR_PUSH_INT, 0, 0, 0);
            }
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

            /* Evaluate switch(expr) once and store in a temp local so the
             * dispatch loop doesn't leak the value onto the stack VM.
             * Each case comparison reloads the temp; after JNZ the stack
             * is balanced regardless of whether a case matched.
             * (Previous DUP-based approach left expr on stack when a case
             * matched via JNZ, leaking 1 slot per switch execution.) */
            {
                int switch_temp = alloc_local(g, 8);
                irgen_expr(g, node->u.switch_stmt.expr);
                ir_emit(g->fn, IR_STORE, switch_temp, 0, 0);
                for (i = 0; i < cl.count; i++) {
                    ir_emit(g->fn, IR_PUSH_VAR, switch_temp, 0, 0);
                    ir_emit(g->fn, IR_PUSH_INT, cl.values[i], 0, 0);
                    ir_emit(g->fn, IR_BINARY, 0, 0, (int)TOK_EQ);
                    ir_emit(g->fn, IR_JNZ, cl.labels[i], 0, 0);
                }
            }
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
            /* ???????????????? case ???????????? switch ???
             * ??????????????"????"??????????????????????? switch ????
             * ???????????? POP??????????????????? switch ???
             * ????????? case ??????? POP ???????????? switch ?????
             * ???? fall-through???????? POP????????????????????
             *   ??? case ??? POP ????? */
            ir_emit(g->fn, IR_LABEL, node->u.case_stmt.label_id, 0, 0);
            /* ???fall-through ??????????????? POP????????? case
             * ??????? switch ??????????????????????? switch ?????
             * ?????????????????????????????? case label ???????? POP?? */
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
            /* ?????????????????????????????????? C ?????????
             *   "asm_text" : outputs : inputs : clobbers
             * ?? C ???????? gcc ????????????ARM ????????????????
             * ??????? '@' ???"??????????"?????????IR_ASM ????????
             *   - '@' ?????????????name ???? `"text" : outputs : inputs : clobbers`
             *   - ?????????????name ????? IR_ASM ???????^ */
            const char *text = node->u.asm_stmt.text ? node->u.asm_stmt.text : "";
            const char *outs = node->u.asm_stmt.outputs;
            const char *ins  = node->u.asm_stmt.inputs;
            const char *clb  = node->u.asm_stmt.clobbers;
            if (outs || ins || clb) {
                /* ?????????????????????????? */
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
            /* ?????????????? PUSH_GLOBAL_ADDR??????????????????
             * ?????? PUSH_INT 0 ?????C ??????? name????????? 0????
             * static ????????????????????????? mangle ??????? */
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
        /* ???????????? lvalue????"???"??????????????
         * irgen_compound_literal ??????????????????? */
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
        } else if (obj->kind == AST_FUNC_CALL) {
            /* Function call returning a struct: irgen_expr pushes the
             * result pointer (address of the struct at frame+8176 in
             * the callee). Treat like arrow ? add member offset to
             * this pointer to get the member address. */
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

/* ???? AST_MEMBER ????????????????
 * AST_MEMBER ????????? bit_offset/bit_width???? ast.h????????? obj ????
 * ????????????????????????? 1 ?????????0 ?????????????????
 * ?????*pbit_off = ???????????*pbit_width = ?????? */
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
    g_ir_cur_line = node->line;  /* ?? DWARF .loc ??? */
    switch (node->kind) {
        case AST_NUM:
            if (node->type && node->type->kind == TYPE_COMPLEX) {
                /* C99 ??????????num_val=-1 ????????? (0, fval)??
                 * ????????????? (fval, 0)??
                 * ?????????????????? IR_PUSH_FLOAT + aux 0x600??double+complex?????? */
                double re, im;
                if (node->u.num_val == -1) { re = 0.0; im = node->fval; }
                else { re = node->fval; im = 0.0; }
                {
                    int cid = ir_program_add_complex(g->prog, re, im);
                    ir_emit(g->fn, IR_PUSH_FLOAT, cid, 0, cid | 0x600);
                }
                break;
            }
            if (node->type && (node->type->kind == TYPE_FLOAT || node->type->kind == TYPE_DOUBLE)) {
                int fid = ir_program_add_float(g->prog, node->fval);
                /* aux ???? 0x200 ??? double ?????ARM ???????? 64 ????????
                 * val ????????????????? */
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
            /* B2: ?????????node->type ? wchar_t*???? ??? IrString??
             * C ???????? L"..." ?? wchar_t ???? */
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
            /* C99 ????????????????????????
             *   - ????/?????rvalue ? decay ???????????????????
             *     ??? PUSH_GLOBAL_ADDR??
             *   - ??????rvalue ??????????? PUSH_GLOBAL ??????????? */
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
                /* static global: keep the name; static local uses mangled name */
                const char *gname = node->u.name;
                if (s->is_static) gname = static_local_name(g->fn->name, node->u.name);
                /* Array/struct/union globals must push their base address (no
                 * dereference): arrays decay to a pointer to their first element,
                 * and structs/unions are accessed via member operations on their
                 * address. PUSH_GLOBAL would emit LDR r0,[r0] which loads 4
                 * bytes of the aggregate's storage as a bogus pointer. */
                if (s->type && (s->type->kind == TYPE_ARRAY ||
                                s->type->kind == TYPE_STRUCT ||
                                s->type->kind == TYPE_UNION)) {
                    ir_emit(g->fn, IR_PUSH_GLOBAL_ADDR, 0, gname, 0);
                } else {
                    ir_emit(g->fn, IR_PUSH_GLOBAL, 0, gname, 0);
                }
            } else if (s->kind == SYM_ENUM_CONST) {
                ir_emit(g->fn, IR_PUSH_INT, s->enum_value, 0, 0);
            } else if (s->type && s->type->kind == TYPE_ARRAY) {
                ir_emit(g->fn, IR_PUSH_ADDR, s->offset, node->u.name, 0);
            } else {
                /* ??????????????? aux??????????????????????/???????
                 * ???????????????? remquo ?? int*??????? int ?????????????
                 * ????????? 4 ?????? 8 ????????? 4 ?????????????
                 * ??????????? aux=0??8 ????????????????????????????????????
                 * long/llong/ptr ??? 8 ????aux=0 ??????
                 * aux ?? 8 ?? = ?????1/2/4????bit8 (0x100) = ???????? */
                int aux = 0;
                if (s->type) {
                    int uns = s->type->is_unsigned ? 0x100 : 0;
                    switch (s->type->kind) {
                        case TYPE_CHAR:  aux = 1 | uns; break;
                        case TYPE_SHORT: aux = 2 | uns; break;
                        case TYPE_INT:
                        case TYPE_ENUM:  aux = 4 | uns; break;
                        case TYPE_LLONG: aux = 8 | uns; break;  /* #5 FIX: 64-bit local */
                        case TYPE_DOUBLE: aux = 8; break;       /* #5 FIX: double local */
                        case TYPE_COMPLEX: aux = 16; break;
                        default:         aux = 0; break;
                    }
                    /* #11 FIX: Mark volatile variable reads */
                    if (s->type->is_volatile) aux |= IR_AUX_VOLATILE;
                }
                ir_emit(g->fn, IR_PUSH_VAR, s->offset, node->u.name, aux);
            }
            break;
        }
        case AST_CAST:
            irgen_expr(g, node->u.unary.operand);
            /* ???? <-> ???? ??????????/?????????? IR_F2I / IR_I2F??
             * aux ???? 0x200 ??? double ??????? ARM ??????
             * __aeabi_d2iz / __aeabi_i2d ???????????????????????
             * F2I ?????????? double??I2F ???????????? double?? */
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
                    /* Bug-P1-7: encode unsigned flag (0x400) so ARM backend
                     * selects __aeabi_ui2d/__aeabi_ui2f for unsigned sources
                     * instead of always using the signed __aeabi_i2d/__aeabi_i2f. */
                    int aux = is_dbl ? 0x200 : 0;
                    if (src_t->is_unsigned) aux |= 0x400;
                    ir_emit(g->fn, IR_I2F, 0, 0, aux);
                }
                /* Bug-I1: int(32-bit) <-> long long(64-bit) widening/narrowing.
                 * Stack layout for 64-bit values: low word pushed first, high
                 * word pushed last (high word on top of stack). */
                else if (src_int && dst_int) {
                    int src_size = type_size(src_t);
                    int dst_size = type_size(dst_t);
                    if (dst_size == 8 && src_size < 8) {
                        /* Widen 32-bit int to 64-bit (2 slots). The int value
                         * is already on the stack as 1 slot; push the high
                         * word (sign or zero extension) on top. */
                        if (src_t->is_unsigned) {
                            /* Zero extend: high word = 0 */
                            ir_emit(g->fn, IR_PUSH_INT, 0, 0, 0);
                        } else {
                            /* Sign extend: duplicate value, then arithmetic
                             * shift right by 31 to produce 0 or -1 as the
                             * high word. */
                            ir_emit(g->fn, IR_DUP, 0, 0, 0);
                            ir_emit(g->fn, IR_PUSH_INT, 31, 0, 0);
                            ir_emit(g->fn, IR_BINARY, 0, 0, (int)TOK_SHR);
                        }
                    }
                    else if (src_size == 8 && dst_size < 8) {
                        /* Narrow 64-bit to 32-bit: discard the high word
                         * (which is on top of stack). */
                        ir_emit(g->fn, IR_POP, 0, 0, 0);
                    }
                    /* same-size int<->int: no-op */
                }
                /* complex -> real????????????????????? IR_F2I ??? 0x400 ????
                 * ????? C ??????????? creal()????????? aux ????????????? */
                if (src_t && src_t->kind == TYPE_COMPLEX &&
                    dst_t && (dst_t->kind == TYPE_FLOAT || dst_t->kind == TYPE_DOUBLE || type_is_integer(dst_t))) {
                    ir_emit(g->fn, IR_F2I, 0, 0, 0x400);  /* 0x400=complex->real ???? */
                }
                /* ???int??int / float??float / ??p?????????? */
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
                int aux_op = op;  /* ?????????????????????????? */
                Type *lt = node->u.binary.left ? node->u.binary.left->type : 0;
                Type *rt = node->u.binary.right ? node->u.binary.right->type : 0;
                if ((lt && (lt->kind == TYPE_FLOAT || lt->kind == TYPE_DOUBLE)) ||
                    (rt && (rt->kind == TYPE_FLOAT || rt->kind == TYPE_DOUBLE))) {
                    is_float = 1;
                    /* ????????????????????? double ???? double ???? */
                    if ((lt && lt->kind == TYPE_DOUBLE) ||
                        (rt && rt->kind == TYPE_DOUBLE)) {
                        is_double = 1;
                    }
                }
                if (!is_float) {
                    /* C99 ?????????? (6.3.1.8)??
                     *   - ????/??????????????????????????????????????????????
                     *   - ???????????????????????????????????????????????????????????
                     * irgen ??????????????????? sema ????????? is_unsigned ?????
                     * ?????????????????/???????????????????????????? */
                    if (op == (int)TOK_SHL || op == (int)TOK_SHR) {
                        /* ??????usual_arith_conv(lt, 0) ???? promote_integer(lt) */
                        Type *pl = usual_arith_conv(lt, 0);
                        is_unsigned = pl && pl->is_unsigned;
                    } else {
                        Type *common = usual_arith_conv(lt, rt);
                        is_unsigned = common && common->is_unsigned;
                        is_llong = common && common->kind == TYPE_LLONG;
                    }
                }
                /* C99 ???????????????????? TYPE_COMPLEX ?????????????
                 * ???????????????????????????=0????????????????
                 * 8 ????????? 8 ???????????????
                 * aux 0x600 = double(0x200) + complex(0x400)?????? IR_FADD/FSUB/FMUL/FDIV?? */
                {
                    int is_complex = 0;
                    if (lt && lt->kind == TYPE_COMPLEX) is_complex = 1;
                    if (rt && rt->kind == TYPE_COMPLEX) is_complex = 1;
                    irgen_expr(g, node->u.binary.left);
                    if (is_complex && lt && lt->kind != TYPE_COMPLEX) {
                        /* ???????????????0x600=float??complex??0x700=int??complex */
                        if (lt->kind == TYPE_FLOAT || lt->kind == TYPE_DOUBLE)
                            ir_emit(g->fn, IR_I2F, 0, 0, 0x600);
                        else
                            ir_emit(g->fn, IR_I2F, 0, 0, 0x700);
                    }
                    irgen_expr(g, node->u.binary.right);
                    if (is_complex && rt && rt->kind != TYPE_COMPLEX) {
                        if (rt->kind == TYPE_FLOAT || rt->kind == TYPE_DOUBLE)
                            ir_emit(g->fn, IR_I2F, 0, 0, 0x600);
                        else
                            ir_emit(g->fn, IR_I2F, 0, 0, 0x700);
                    }
                    if (is_complex && (op == (int)TOK_PLUS || op == (int)TOK_MINUS ||
                                       op == (int)TOK_MUL || op == (int)TOK_DIV)) {
                        IrOp fop = IR_FADD;
                        switch (op) {
                            case (int)TOK_PLUS:  fop = IR_FADD; break;
                            case (int)TOK_MINUS: fop = IR_FSUB; break;
                            case (int)TOK_MUL:   fop = IR_FMUL; break;
                            case (int)TOK_DIV:   fop = IR_FDIV; break;
                        }
                        ir_emit(g->fn, fop, 0, 0, op | 0x600);
                        break;  /* ???? AST_BINARY ???? */
                    }
                    if (is_complex && (op == (int)TOK_EQ || op == (int)TOK_NE)) {
                        ir_emit(g->fn, IR_FCMP, 0, 0, op | 0x600);
                        break;
                    }
                }
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
                    /* aux ???? 0x200 ??? double ?????ARM ????????
                     * __aeabi_dadd / __aeabi_fadd ???C ???? double ????? */
                    ir_emit(g->fn, fop, 0, 0, op | (is_double ? 0x200 : 0));
                } else if (is_llong) {
                    /* 64 ??????C ???? IR_BINARY?????????? long long????
                     * ARM ?????? 4 ???? 64 ????????? 2 ??? */
                    int is_cmp = (op == (int)TOK_EQ || op == (int)TOK_NE ||
                                  op == (int)TOK_LT || op == (int)TOK_GT ||
                                  op == (int)TOK_LE || op == (int)TOK_GE);
                    if (is_cmp) {
                        /* ?? 32 ?? IR_BINARY ?????? aux ???? (0x100) ?????????????
                         * ???????? (unsigned long long) ?????????? (?? ULLONG_MAX
                         * ???? = -1) ????????????????????? LLONG_MAX?? */
                        ir_emit(g->fn, IR_64CMP, 0, 0, op | (is_unsigned ? 0x100 : 0));
                    } else {
                        ir_emit(g->fn, IR_64BINARY, 0, 0, op | (is_unsigned ? 0x100 : 0));
                    }
                } else if (op == (int)TOK_DIV || op == (int)TOK_MOD) {
                    /* ????????/??????? IR_DIV/IR_MOD??aux=1 ?????????
                     * ?? ARM ?????? __aeabi_idiv / __aeabi_uidiv?? */
                    IrOp dop = (op == (int)TOK_DIV) ? IR_DIV : IR_MOD;
                    ir_emit(g->fn, dop, 0, 0, is_unsigned ? 1 : 0);
                } else {
                    /* ?????????(TOK_LT/GT/LE/GE)??????(TOK_SHR)?? aux ????(0x100)
                     * ???????????????????????????????? / ????????
                     * EQ/NE ???????????????/?????????????????? */
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
                /* __packed ?????????aux 0x400 ??????????????????? */
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
                        /* ???/static ?????????????? PUSH_GLOBAL/STORE_GLOBAL??
                         * static ????? mangle ???????????????? frame[0]?? */
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
                    /* General lvalue: *ptr, arr[i], s.f, p->f, etc.
                     * Use irgen_lvalue_addr to get the address, then
                     * load/increment/store through it. The AST_VAR path
                     * above handles the common simple-variable case; this
                     * path handles all other lvalue kinds. */
                    int elem_sz = type_size(operand->type ? operand->type : type_int());
                    int packed_aux = 0;
                    if (elem_sz <= 0) elem_sz = 4;
                    /* __packed pointer unaligned access for *ptr */
                    if (operand->kind == AST_UNARY && operand->u.unary.op == (int)TOK_MUL &&
                        operand->u.unary.operand->type &&
                        operand->u.unary.operand->type->kind == TYPE_PTR &&
                        operand->u.unary.operand->type->is_packed) {
                        packed_aux = 0x400;
                    }
                    if (node->u.unary.is_postfix) {
                        /* Postfix: result = old value; store new value as side effect.
                         * Stack trace: [addr] -> [addr,addr] -> [addr,old] ->
                         * [old,addr] -> [old,addr,addr] -> [old,addr,val] ->
                         * [old,addr,val,delta] -> [old,addr,new] -> [old,new] -> [old] */
                        irgen_lvalue_addr(g, operand);
                        ir_emit(g->fn, IR_DUP, 0, 0, 0);
                        ir_emit(g->fn, IR_PUSH_INT, 0, 0, 0);
                        ir_emit(g->fn, IR_LOAD_IDX, elem_sz, 0, packed_aux);
                        ir_emit(g->fn, IR_SWAP, 0, 0, 0);
                        ir_emit(g->fn, IR_DUP, 0, 0, 0);
                        ir_emit(g->fn, IR_PUSH_INT, 0, 0, 0);
                        ir_emit(g->fn, IR_LOAD_IDX, elem_sz, 0, packed_aux);
                        ir_emit(g->fn, IR_PUSH_INT, delta, 0, 0);
                        ir_emit(g->fn, IR_BINARY, 0, 0, (int)TOK_PLUS);
                        ir_emit(g->fn, IR_STORE_IDX, elem_sz, 0, packed_aux);
                        ir_emit(g->fn, IR_POP, 0, 0, 0);
                    } else {
                        /* Prefix: result = new value; store new value as side effect.
                         * Stack trace: [addr] -> [addr,addr] -> [addr,val] ->
                         * [addr,val,delta] -> [addr,new] -> [new] */
                        irgen_lvalue_addr(g, operand);
                        ir_emit(g->fn, IR_DUP, 0, 0, 0);
                        ir_emit(g->fn, IR_PUSH_INT, 0, 0, 0);
                        ir_emit(g->fn, IR_LOAD_IDX, elem_sz, 0, packed_aux);
                        ir_emit(g->fn, IR_PUSH_INT, delta, 0, 0);
                        ir_emit(g->fn, IR_BINARY, 0, 0, (int)TOK_PLUS);
                        ir_emit(g->fn, IR_STORE_IDX, elem_sz, 0, packed_aux);
                    }
                }
            } else {
                /* val=1 ??????????????? C ??????????????
                 * ??????????? 0-x???????????????????????????????????? */
                int is_float = node->type &&
                    (node->type->kind == TYPE_FLOAT || node->type->kind == TYPE_DOUBLE);
                irgen_expr(g, node->u.unary.operand);
                ir_emit(g->fn, IR_UNARY, is_float ? 1 : 0, 0, op);
            }
            break;
        }
        case AST_ASSIGN: {
            AstNode *L = node->u.binary.left;
            int op = node->u.binary.op;
            if (op == (int)TOK_ASSIGN) {
                /* ????/???????????????? IR_MEMCPY ??????????
                 * IR_MEMCPY ????????=dst, ????=src???????????
                 * ????????????? dst ???????????? AST_EXPR_STMT ???????? */
                if (L->type && (L->type->kind == TYPE_STRUCT || L->type->kind == TYPE_UNION)) {
                    int sz = type_size(L->type);
                    if (sz <= 0) sz = 4;
                    if (sz <= 8) {
                        /* Small struct (<=8B): irgen_expr pushes the 8-byte
                         * value (covers AST_FUNC_CALL returning small struct
                         * and AST_VAR struct-to-struct copy). Store the value
                         * to L's address via IR_STORE_IDX (pops value, then
                         * addr; stores; pushes value back as expression result).
                         * Using IR_MEMCPY here would treat the value as a
                         * pointer and crash with STATUS_ACCESS_VIOLATION. */
                        irgen_lvalue_addr(g, L);                  /* [dst_addr] */
                        irgen_expr(g, node->u.binary.right);      /* [dst_addr, value] */
                        ir_emit(g->fn, IR_STORE_IDX, 8, 0, 0);    /* [value] */
                        break;
                    }
                    /* Large struct: use IR_MEMCPY with addresses.
                     * RHS of struct assignment: if it's a function call
                     * returning a struct, irgen_expr pushes the result address
                     * (C backend stores at frame+8176). Otherwise take the
                     * lvalue address. */
                    irgen_lvalue_addr(g, L);                      /* [dst] */
                    if (node->u.binary.right && node->u.binary.right->kind == AST_FUNC_CALL) {
                        irgen_expr(g, node->u.binary.right);     /* [dst, src] */
                    } else {
                        irgen_lvalue_addr(g, node->u.binary.right);   /* [dst, src] */
                    }
                    irgen_lvalue_addr(g, L);                      /* [dst, src, dst] */
                    ir_emit(g->fn, IR_MEMCPY, sz, 0, 0);          /* pops dst,src; leaves [dst] */
                    break;
                }
                if (L->kind == AST_VAR) {
                    Symbol *s = sym_find(L->u.name);
                    irgen_expr(g, node->u.binary.right);
                    /* ???? <-> ???? ?????????????? */
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
                        /* _Bool ??Z????C99 6.3.1.2?? */
                        if (dt && dt->kind == TYPE_BOOL) {
                            ir_emit(g->fn, IR_PUSH_INT, 0, 0, 0);
                            ir_emit(g->fn, IR_BINARY, 0, 0, (int)TOK_NE);
                        }
                    }
                    if (s && s->kind == SYM_GLOBAL) {
                        const char *gname = L->u.name;
                        if (s->is_static) gname = static_local_name(g->fn->name, L->u.name);
                        ir_emit(g->fn, IR_DUP, 0, 0, 0);
                        ir_emit(g->fn, IR_STORE_GLOBAL, 0, gname, 0);
                    } else if (s) {
                        int store_aux = 0;
                        if (s && s->type) {
                            switch (s->type->kind) {
                                case TYPE_CHAR:  store_aux = 1; break;
                                case TYPE_SHORT: store_aux = 2; break;
                                case TYPE_INT:
                                case TYPE_ENUM:  store_aux = 4; break;
                                case TYPE_COMPLEX: store_aux = 16; break;
                                default:         store_aux = 0; break;
                            }
                            /* #11 FIX: Mark volatile variable writes */
                            if (s->type->is_volatile) store_aux |= IR_AUX_VOLATILE;
                        }
                        ir_emit(g->fn, IR_STORE, s->offset, L->u.name, store_aux);
                        ir_emit(g->fn, IR_PUSH_VAR, s->offset, L->u.name,
                                (s && s->type && s->type->is_volatile) ? IR_AUX_VOLATILE : 0);
                    }
                } else if (L->kind == AST_ARRAY_ACCESS) {
                    AstNode *arr = L->u.array_access.array;
                    int elem_sz = 4;
                    int packed_aux = 0;
                    if (arr->type && (arr->type->kind == TYPE_ARRAY || arr->type->kind == TYPE_PTR))
                        elem_sz = type_size(arr->type->base);
                    if (elem_sz <= 0) elem_sz = 4;
                    /* __packed ???????????aux 0x400 ?????????? */
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
                    /* __packed ???????aux 0x400 ??????????????????? */
                    if (L->u.unary.operand->type &&
                        L->u.unary.operand->type->kind == TYPE_PTR &&
                        L->u.unary.operand->type->is_packed) {
                        packed_aux = 0x400;
                    }
                    ir_emit(g->fn, IR_STORE_IDX, elem_sz, 0, packed_aux);
                } else if (L->kind == AST_MEMBER) {
                    int bo, bw;
                    if (member_bitfield_info(L, &bo, &bw)) {
                        /* #I6 FIX: Set 0x100 flag for signed bitfields in
                         * the LOAD_FLD after assignment. */
                        int fld_aux = bw;
                        if (L->type && !L->type->is_unsigned)
                            fld_aux |= 0x100;
                        irgen_lvalue_addr(g, L);                      /* [addr] */
                        irgen_expr(g, node->u.binary.right);          /* [addr, value] */
                        ir_emit(g->fn, IR_STORE_FLD, bo, 0, bw);      /* [] */
                        irgen_lvalue_addr(g, L);                      /* [addr] */
                        ir_emit(g->fn, IR_LOAD_FLD, bo, 0, fld_aux);   /* [masked_value] */
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
                        int store_aux = 0;
                        int push_aux = 0;
                        if (s && s->type) {
                            switch (s->type->kind) {
                                case TYPE_CHAR:  store_aux = 1; break;
                                case TYPE_SHORT: store_aux = 2; break;
                                case TYPE_INT:
                                case TYPE_ENUM:  store_aux = 4; break;
                                case TYPE_COMPLEX: store_aux = 16; break;
                                default:         store_aux = 0; break;
                            }
                            /* #I5 FIX: Preserve volatile qualifier in compound
                             * assignment. Without this, __HAL_RCC_*_ENABLE() macros
                             * doing tmpreg |= RCC->CR lose volatile semantics. */
                            if (s->type->is_volatile) {
                                store_aux |= IR_AUX_VOLATILE;
                                push_aux = IR_AUX_VOLATILE;
                            }
                        }
                        ir_emit(g->fn, IR_PUSH_VAR, s->offset, L->u.name, push_aux);
                        irgen_expr(g, node->u.binary.right);
                        ir_emit(g->fn, IR_BINARY, 0, 0, bop);
                        ir_emit(g->fn, IR_STORE, s->offset, L->u.name, store_aux);
                        ir_emit(g->fn, IR_PUSH_VAR, s->offset, L->u.name, push_aux);
                    }
                } else if (L->kind == AST_UNARY && L->u.unary.op == (int)TOK_MUL) {
                    /* *ptr OP= val : load old, compute new, store back, leave new on stack.
                     * Bug-I4 FIX: Evaluate the lvalue address ONCE and duplicate it
                     * with IR_DUP so that side effects in L (e.g. i++ in *p++ += 5)
                     * are not doubled. The original address stays at the bottom of
                     * the stack while LOAD_IDX consumes the duplicate; STORE_IDX
                     * then consumes the original, so no SWAP is needed. */
                    int elem_sz = type_size(L->type ? L->type : type_int());
                    int packed_aux = 0;
                    if (elem_sz <= 0) elem_sz = 4;
                    if (L->u.unary.operand->type &&
                        L->u.unary.operand->type->kind == TYPE_PTR &&
                        L->u.unary.operand->type->is_packed) {
                        packed_aux = 0x400;
                    }
                    irgen_lvalue_addr(g, L);                       /* [addr] */
                    ir_emit(g->fn, IR_DUP, 0, 0, 0);               /* [addr, addr] */
                    ir_emit(g->fn, IR_PUSH_INT, 0, 0, 0);           /* [addr, addr, 0] */
                    ir_emit(g->fn, IR_LOAD_IDX, elem_sz, 0, packed_aux); /* [addr, old_val] */
                    irgen_expr(g, node->u.binary.right);            /* [addr, old_val, rhs] */
                    ir_emit(g->fn, IR_BINARY, 0, 0, bop);           /* [addr, new_val] */
                    ir_emit(g->fn, IR_STORE_IDX, elem_sz, 0, packed_aux); /* [new_val] */
                } else if (L->kind == AST_ARRAY_ACCESS) {
                    /* arr[i] OP= val
                     * Bug-I4 FIX: Evaluate the lvalue address ONCE and duplicate
                     * it with IR_DUP so that side effects in the index expression
                     * (e.g. i++ in arr[i++] += 5) are not doubled. */
                    AstNode *arr = L->u.array_access.array;
                    int elem_sz = 4;
                    int packed_aux = 0;
                    if (arr->type && (arr->type->kind == TYPE_ARRAY || arr->type->kind == TYPE_PTR))
                        elem_sz = type_size(arr->type->base);
                    if (elem_sz <= 0) elem_sz = 4;
                    if (arr->type && arr->type->kind == TYPE_PTR && arr->type->is_packed) {
                        packed_aux = 0x400;
                    }
                    irgen_lvalue_addr(g, L);                       /* [addr] */
                    ir_emit(g->fn, IR_DUP, 0, 0, 0);               /* [addr, addr] */
                    ir_emit(g->fn, IR_PUSH_INT, 0, 0, 0);           /* [addr, addr, 0] */
                    ir_emit(g->fn, IR_LOAD_IDX, elem_sz, 0, packed_aux); /* [addr, old_val] */
                    irgen_expr(g, node->u.binary.right);            /* [addr, old_val, rhs] */
                    ir_emit(g->fn, IR_BINARY, 0, 0, bop);           /* [addr, new_val] */
                    ir_emit(g->fn, IR_STORE_IDX, elem_sz, 0, packed_aux); /* [new_val] */
                } else if (L->kind == AST_MEMBER) {
                    int bo, bw;
                    if (member_bitfield_info(L, &bo, &bw)) {
                        /* Bitfield compound-assign requires read-mask-modify-write;
                         * too complex for now, fall back to no-op. */
                        ark_log("[irgen] line %d: compound-assign on bitfield unsupported\n", node->line);
                        ir_emit(g->fn, IR_PUSH_INT, 0, 0, 0);
                    } else {
                        int elem_sz = type_size(L->type ? L->type : type_int());
                        if (elem_sz <= 0) elem_sz = 4;
                        /* Bug-I4 FIX: Evaluate the lvalue address ONCE and
                         * duplicate it with IR_DUP so that side effects in the
                         * member's base object are not doubled. */
                        irgen_lvalue_addr(g, L);                       /* [addr] */
                        ir_emit(g->fn, IR_DUP, 0, 0, 0);               /* [addr, addr] */
                        ir_emit(g->fn, IR_PUSH_INT, 0, 0, 0);           /* [addr, addr, 0] */
                        ir_emit(g->fn, IR_LOAD_IDX, elem_sz, 0, 0);     /* [addr, old_val] */
                        irgen_expr(g, node->u.binary.right);            /* [addr, old_val, rhs] */
                        ir_emit(g->fn, IR_BINARY, 0, 0, bop);           /* [addr, new_val] */
                        ir_emit(g->fn, IR_STORE_IDX, elem_sz, 0, 0);    /* [new_val] */
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
            int is_indirect = (node->u.call.name && node->u.call.name[0] == '?');
            Symbol *s = is_indirect ? 0 : sym_find(node->u.call.name);

            /* C99 ????????????????????????? IR?????? 8??????????
             * ??????????? .c ????????16????????? IR_CALL ?? long long(8???)
             * ????????????????????????????????????? */
            if (s && n == 1) {
                const char *fn = node->u.call.name;
                if (ark_streq(fn, "creal") || ark_streq(fn, "crealf") || ark_streq(fn, "creall")) {
                    irgen_expr(g, node->u.call.args[0]);
                    ir_emit(g->fn, IR_F2I, 0, 0, 0x400);  /* 0x400=???? */
                    break;
                }
                if (ark_streq(fn, "cimag") || ark_streq(fn, "cimagf") || ark_streq(fn, "cimagl")) {
                    irgen_expr(g, node->u.call.args[0]);
                    ir_emit(g->fn, IR_I2F, 0, 0, 0x400);  /* 0x400=???? */
                    break;
                }
                if (ark_streq(fn, "conj") || ark_streq(fn, "conjf") || ark_streq(fn, "conjl")) {
                    irgen_expr(g, node->u.call.args[0]);
                    ir_emit(g->fn, IR_UNARY, 0, 0, (int)TOK_BNOT | 0x400); /* ???????? */
                    break;
                }
                if (ark_streq(fn, "cabs") || ark_streq(fn, "cabsf") || ark_streq(fn, "cabsl")) {
                    irgen_expr(g, node->u.call.args[0]);
                    ir_emit(g->fn, IR_F2I, 0, 0, 0x500);  /* 0x500=?? cabs */
                    break;
                }
                if (ark_streq(fn, "carg") || ark_streq(fn, "cargf") || ark_streq(fn, "cargl")) {
                    irgen_expr(g, node->u.call.args[0]);
                    ir_emit(g->fn, IR_I2F, 0, 0, 0x500);  /* 0x500=????? carg */
                    break;
                }
                if (ark_streq(fn, "cexp") || ark_streq(fn, "cexpf") || ark_streq(fn, "cexpl")) {
                    irgen_expr(g, node->u.call.args[0]);
                    ir_emit(g->fn, IR_FADD, 0, 0, 0x500);  /* 0x500=??????? cexp */
                    break;
                }
            }

            for (i = n - 1; i >= 0; i--) {
                AstNode *arg = node->u.call.args[i];
                Type *at = arg ? arg->type : 0;
                /* struct-by-value: pass the address of the source struct
                 * instead of the (truncated to 8-byte) value. The callee's
                 * IR_GETARG (with size-in-aux) will memcpy the payload into
                 * its own frame slot. */
                if (at && (at->kind == TYPE_STRUCT || at->kind == TYPE_UNION) &&
                    type_size(at) > 8) {
                    irgen_lvalue_addr(g, arg);
                } else {
                    irgen_expr(g, arg);
                }
            }
            /* Indirect call: push the function pointer (callee) last so it
             * becomes aa[0] when the C backend pops. n includes the pointer. */
            if (is_indirect && node->u.call.callee) {
                irgen_expr(g, node->u.call.callee);
                n = n + 1;
            }
            /* __svc(n) ?????????? SVC ?????? BL */
            if (s && s->svc_num != 0) {
                ir_emit(g->fn, IR_SVC, s->svc_num, node->u.call.name, 0);
            }
#if ARKCC_FEATURE_ARMCC_KEYWORDS
            /* __smc(n) ?????????? SMC ?????? BL */
            else if (s && s->smc_num >= 0) {
                ir_emit(g->fn, IR_SMC, s->smc_num, node->u.call.name, 0);
            }
#endif
            else {
                /* Encode argument types into aux bitmask so the C backend can emit
                 * the correct cast for each variadic argument. Each arg uses 2 bits:
                 *   bit(2*i)   = 1 if arg is float/double (default-promoted to double)
                 *   bit(2*i+1) = 1 if arg is long long / unsigned long long (8 bytes)
                 * Default (both bits 0) = int/ptr/short/char (promoted to int, 4 bytes
                 * in the variadic ABI on 32-bit hosts; 8 bytes on 64-bit LP64 but the
                 * high 32 bits are 0). Without this, printf("%d %lld %d", ...) on a
                 * 32-bit host would misread argument offsets because the callee's
                 * va_arg(int) reads 4 bytes while arkcc passed 8, shifting all
                 * subsequent %lld / %s reads and producing garbage.
                 *
                 * NOTE: use arg_count, not n, as the upper bound. For indirect calls
                 * (obj->fnptr()), n includes the function pointer (n = arg_count + 1),
                 * but the callee pointer is stored separately in node->u.call.callee,
                 * NOT in the args[] array. Using n here would read past args[] end
                 * (or dereference NULL when arg_count==0), causing a crash. */
                int argmask = 0;
                int max_args = node->u.call.arg_count;
                if (max_args > 16) max_args = 16;
                for (i = 0; i < max_args; i++) {
                    AstNode *arg = node->u.call.args[i];
                    if (arg && arg->type) {
                        int k = arg->type->kind;
                        if (k == TYPE_FLOAT || k == TYPE_DOUBLE) {
                            argmask |= (1 << (2 * i));
                        } else if (k == TYPE_LLONG) {
                            argmask |= (1 << (2 * i + 1));
                        }
                    }
                }
                ir_emit(g->fn, IR_CALL, n, node->u.call.name, argmask);
            }
            break;
        }
        case AST_ARRAY_ACCESS: {
            int elem_sz;
            int packed_aux = 0;
            AstNode *arr = node->u.array_access.array;
            /* ?????????????????? arr ??????/????????????????
             * ???????????????????? matrix[1] ???? int[3]?????? C ????
             * ??????????????????????????????? IR_LOAD_IDX??
             * ????????????????? + 0 ????????????????? */
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
            /* __packed ???????????aux 0x400 ??????????????????? */
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
                /* #I6 FIX: Set 0x100 flag for signed bitfields so the ARM
                 * backend can apply sign extension (LSL+ASR) instead of
                 * zero extension (LSR+AND). */
                int fld_aux = bw;
                if (node->type && !node->type->is_unsigned)
                    fld_aux |= 0x100;
                irgen_lvalue_addr(g, node);
                ir_emit(g->fn, IR_LOAD_FLD, bo, 0, fld_aux);
            } else if (node->type && node->type->kind == TYPE_ARRAY) {
                /* ????????????????? data[]??????????????????????????
                 * ??????????? IR_LOAD_IDX???? AST_ARRAY_ACCESS ???????????
                 * ????????????????????????????????????????????????????????? */
                irgen_lvalue_addr(g, node);
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
