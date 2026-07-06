/* Ark C Compiler - opt
 * IR ????? Pass????????? + ?????????? + ??????? + ???????????
 *
 * ??????
 *   - ?? IR ?? IR_PUSH_INT a; IR_PUSH_INT b; IR_BINARY op ??????????
 *     ???? IR_PUSH_INT (a op b)????????????????? IR_NOP???????????
 *   - IR_BINARY ?? aux ?? 8 ??? TOK_xxx ???????0x100 ???????????
 *   - ????/????????????????????????
 *   - ????????????IR_RETURN / IR_JMP / IR_JMP_NAMED ????????
 *     IR_LABEL / IR_LABEL_NAMED ?????????????? IR_NOP??
 *   - ??????????????????????? 8 ????????????? (1+2*3)??
 *
 * ?????
 *   - ?????? #if ARKCC_FEATURE_OPT_CONSTFOLD / ARKCC_FEATURE_OPT_DCE
 *   - ????? g_config.enable_opt_constfold / enable_opt_dce
 */
#include "opt.h"
#include "config.h"
#include "arkcc_config.h"
#include "common.h"
#include "memory.h"

/* ?? IR_NOP ???????? code[]?????? code_count?? */
static void compact_func(IrFunc *f) {
    int i;
    int w = 0;
    for (i = 0; i < f->code_count; i++) {
        if (f->code[i].op != IR_NOP) {
            if (w != i) f->code[w] = f->code[i];
            w++;
        }
    }
    f->code_count = w;
}

/* ???? a op b?????? 1 ????????????????? *out????0 ??????????
 * ?????????aux ? IR_BINARY ?? aux ????????????? 0x100????
 * ??? long long ???????? 64 ????????LLONG_MAX ????????????? */
static int eval_binary(long long a, long long b, int aux, long long *out) {
    int is_unsigned = (aux & 0x100) != 0;
    int op = aux & ~0x100;
    long long r = 0;
    switch (op) {
        case (int)TOK_PLUS:  r = a + b; break;
        case (int)TOK_MINUS: r = a - b; break;
        case (int)TOK_MUL:   r = a * b; break;
        case (int)TOK_DIV:
            if (b == 0) return 0;
            if (is_unsigned) r = (long long)((unsigned long long)a / (unsigned long long)b);
            else r = a / b;
            break;
        case (int)TOK_MOD:
            if (b == 0) return 0;
            if (is_unsigned) r = (long long)((unsigned long long)a % (unsigned long long)b);
            else r = a % b;
            break;
        case (int)TOK_BAND: r = a & b; break;
        case (int)TOK_BOR:  r = a | b; break;
        case (int)TOK_BXOR: r = a ^ b; break;
        case (int)TOK_SHL:  r = (long long)((unsigned long long)a << (b & 63)); break;
        case (int)TOK_SHR:
            if (is_unsigned) r = (long long)((unsigned long long)a >> (b & 63));
            else r = a >> (b & 63);
            break;
        case (int)TOK_EQ: r = (a == b) ? 1 : 0; break;
        case (int)TOK_NE: r = (a != b) ? 1 : 0; break;
        case (int)TOK_LT:
            r = is_unsigned ? (((unsigned long long)a <  (unsigned long long)b) ? 1 : 0)
                            : ((a <  b) ? 1 : 0);
            break;
        case (int)TOK_GT:
            r = is_unsigned ? (((unsigned long long)a >  (unsigned long long)b) ? 1 : 0)
                            : ((a >  b) ? 1 : 0);
            break;
        case (int)TOK_LE:
            r = is_unsigned ? (((unsigned long long)a <= (unsigned long long)b) ? 1 : 0)
                            : ((a <= b) ? 1 : 0);
            break;
        case (int)TOK_GE:
            r = is_unsigned ? (((unsigned long long)a >= (unsigned long long)b) ? 1 : 0)
                            : ((a >= b) ? 1 : 0);
            break;
        case (int)TOK_AND: r = (a && b) ? 1 : 0; break;
        case (int)TOK_OR:  r = (a || b) ? 1 : 0; break;
        default:
            return 0;  /* ????????????? */
    }
    *out = r;
    return 1;
}

/* #11 FIX: Volatile access protection.
 * IR_PUSH_VAR / IR_PUSH_GLOBAL / IR_STORE / IR_STORE_GLOBAL with bit
 * 0x10000 (IR_AUX_VOLATILE) in aux must NOT be eliminated, folded, or
 * combined by any optimization pass. The constfold pass below only folds
 * PUSH_INT+PUSH_INT+BINARY patterns and is inherently safe. The DCE pass
 * only removes unreachable code after RETURN/JMP. Future optimization
 * passes (load combining, dead store elimination, etc.) MUST check
 * (I->aux & IR_AUX_VOLATILE) before removing any memory access. */
void opt_constfold_func(IrFunc *f) {
    int changed = 1;
    int iter = 0;
    while (changed && iter < 8) {
        int i;
        changed = 0;
        iter++;
        for (i = 0; i + 2 < f->code_count; i++) {
            IrInst *a = &f->code[i];
            IrInst *b = &f->code[i + 1];
            IrInst *c = &f->code[i + 2];
            long long result;
            if (a->op != IR_PUSH_INT) continue;
            if (b->op != IR_PUSH_INT) continue;
            if (c->op != IR_BINARY) continue;
            if (!eval_binary(a->val, b->val, c->aux, &result)) continue;
            /* ?????????????????????????? NOP */
            a->val = result;
            b->op = IR_NOP;
            c->op = IR_NOP;
            changed = 1;
            /* ???????????????????????????????????? */
        }
        if (changed) compact_func(f);
    }
}

void opt_dce_func(IrFunc *f) {
    int i;
    int unreachable = 0;
    for (i = 0; i < f->code_count; i++) {
        IrInst *I = &f->code[i];
        if (unreachable) {
            /* ?????????????? */
            if (I->op == IR_LABEL || I->op == IR_LABEL_NAMED) {
                unreachable = 0;
                continue;
            }
            /* ?????????? NOP?????? FUNC_BEGIN/FUNC_END ?????? */
            if (I->op != IR_FUNC_BEGIN && I->op != IR_FUNC_END) {
                I->op = IR_NOP;
            }
            continue;
        }
        /* RETURN / ??????????????????? */
        if (I->op == IR_RETURN || I->op == IR_JMP || I->op == IR_JMP_NAMED) {
            unreachable = 1;
        }
    }
    compact_func(f);
}

void opt_run(IrProgram *prog, int level) {
    int i;
    if (!prog) return;
#if ARKCC_FEATURE_OPT_CONSTFOLD
    if (g_config.enable_opt_constfold || level >= 1) {
        for (i = 0; i < prog->func_count; i++) {
            opt_constfold_func(prog->funcs[i]);
        }
    }
#else
    (void)level;
#endif
#if ARKCC_FEATURE_OPT_DCE
    if (g_config.enable_opt_dce || level >= 1) {
        for (i = 0; i < prog->func_count; i++) {
            opt_dce_func(prog->funcs[i]);
        }
    }
#endif
#if ARKCC_FEATURE_OPT_INLINE
    /* N4 FIX: opt_inline must only run at -O2 or above. Previously it ran
     * whenever g_config.enable_opt_inline was true (which defaults to 1
     * at host compile time), causing inline expansion even at -O0. This
     * changes -O0 codegen expectations and is unsafe for the ARM backend
     * where inline expansion assumes stack-slot parameters (not r0-r3). */
    if (level >= 2 && g_config.enable_opt_inline) {
        opt_inline(prog);
        /* ?????????? DCE??????????????????? NOP????????????????? */
        if (g_config.enable_opt_dce || level >= 1) {
            for (i = 0; i < prog->func_count; i++) {
                opt_dce_func(prog->funcs[i]);
            }
        }
    }
#endif
#if ARKCC_FEATURE_OPT_VECTORIZE
    if (g_config.enable_opt_vectorize || level >= 2) {
        opt_vectorize(prog);
    }
#endif
}

/* =====================================================================
 * ?????????--autoinline / -O2??
 * =====================================================================
 *
 * ????????
 *   1. ?????????????????? IR?????"?????????"????? FUNC_BEGIN/
 *      FUNC_END/LABEL/NOP????????????????????????????????????????
 *      ?????????????????????
 *        - ????? ?? ARK_INLINE_THRESHOLD??forceinline ????????
 *        - param_count ?? 4
 *        - ?? variadic / irq / naked / asm_func / constructor / destructor
 *        - ????????????
 *   2. ????????????????? IR ??? IR_CALL?????????????????????????
 *      ?????????????????I??
 *   3. ??????I?????????? code[] ???????? memmove????
 *        - ????????? n ?? IR_STORE(temp_off_j)???? n ????????????
 *          ????????????temp_off_j = caller.local_size + j*4????
 *        - ??????????????FUNC_BEGIN..FUNC_END ?????
 *            * ?????? += L1??L1 = caller.local_size + n*4??
 *            * IR_GETARG(callee_off, j) ?? IR_PUSH_VAR(temp_off_j);
 *              IR_STORE(L1 + callee_off)
 *            * IR_RETURN ?? IR_JMP(end_label)
 *            * IR_LABEL/IR_JMP/IR_JZ/IR_JNZ ????? += caller.label_count
 *            * IR_FUNC_BEGIN/IR_FUNC_END ?? IR_NOP
 *        - ????? IR_LABEL(end_label)
 *        - ???? caller.local_size = L1 + callee.local_size
 *        - ???? caller.label_count = end_label + 1
 *      ????? IR_CALL ?? n ????????? 1 ??????????????? n ?? STORE
 *      ?? n ???????????????????? IR_RETURN ???????????IR_JMP ?????????
 *      ??? LABEL ?????????????????
 *   4. ???????? opt_run ???? opt_dce_func ????????????
 */
#define ARK_INLINE_THRESHOLD 12

typedef struct {
    IrFunc *func;
    int inst_count;
    int can_inline;
} InlineCandidate;

/* Count real instructions (skipping FUNC_BEGIN/FUNC_END/LABEL/NOP) and detect
 * direct recursion. Also detects struct-by-value parameters via IR_GETARG's
 * aux encoding (high 24 bits = struct size > 0); such functions cannot be
 * inlined because the inline expansion would need to emit a memcpy from the
 * caller's argument slot, not the simple PUSH_VAR+STORE pattern used here. */
static int count_insts_and_check_recursion(IrFunc *f, int *out_count, int *out_has_struct_byval) {
    int i;
    int n = 0;
    int recursive = 0;
    *out_has_struct_byval = 0;
    for (i = 0; i < f->code_count; i++) {
        IrOp op = f->code[i].op;
        if (op == IR_FUNC_BEGIN || op == IR_FUNC_END ||
            op == IR_LABEL || op == IR_NOP) continue;
        if (op == IR_CALL && f->code[i].name &&
            ark_streq(f->code[i].name, f->name)) {
            recursive = 1;
        }
        if (op == IR_GETARG && (f->code[i].aux >> 8) != 0) {
            *out_has_struct_byval = 1;
        }
        n++;
    }
    *out_count = n;
    return recursive;
}

void opt_inline(IrProgram *prog) {
    int i, j, k;
    InlineCandidate *cands;
    if (!prog || prog->func_count == 0) return;

    /* 1. ????????? */
    cands = (InlineCandidate *)mem_pool_alloc(
        (int)sizeof(InlineCandidate) * prog->func_count);
    for (i = 0; i < prog->func_count; i++) {
        IrFunc *f = prog->funcs[i];
        int cnt = 0;
        int has_struct_byval = 0;
        int recursive = count_insts_and_check_recursion(f, &cnt, &has_struct_byval);
        cands[i].func = f;
        cands[i].inst_count = cnt;
        cands[i].can_inline = 0;
        if (recursive) continue;
        if (f->is_variadic) continue;
        if (f->is_irq || f->is_naked || f->is_asm_func) continue;
        if (f->is_constructor || f->is_destructor) continue;
        if (f->param_count > 4) continue;
        /* Struct-by-value parameters use IR_GETARG with (size<<8)|idx encoding
         * and the callee receives a pointer to the struct (not the value).
         * The inline expansion below cannot handle the required memcpy, so
         * skip inlining such functions entirely. */
        if (has_struct_byval) continue;
        if (f->forceinline) {
            cands[i].can_inline = 1;  /* forceinline ??????????? */
        } else if (cnt <= ARK_INLINE_THRESHOLD) {
            cands[i].can_inline = 1;
        }
    }

    /* 2. ???????????? IR_CALL????????? */
    for (i = 0; i < prog->func_count; i++) {
        IrFunc *caller = prog->funcs[i];
        int new_cap;
        int new_count = 0;
        IrInst *new_code;
        int has_site = 0;

        /* ?????????????????????????? */
        for (j = 0; j < caller->code_count; j++) {
            IrInst *I = &caller->code[j];
            if (I->op != IR_CALL) continue;
            for (k = 0; k < prog->func_count; k++) {
                if (cands[k].can_inline && I->name &&
                    ark_streq(I->name, cands[k].func->name) &&
                    !ark_streq(cands[k].func->name, caller->name)) {
                    has_site = 1;
                    break;
                }
            }
            if (has_site) break;
        }
        if (!has_site) continue;

        /* ?????????? code + ????????? (n_args + callee_code*2 + 4)
         * NOTE: some C code generators (notably the arkcc self-hosted
         * bootstrap) can emit more slots than the tight upper bound
         * suggests due to subtle codegen differences. To make this
         * pass memory-safe under all backends we allocate with a
         * large fixed margin. opt_inline runs once per program so the
         * memory overhead is bounded and acceptable.
         *
         * Empirically, the arkcc self-bootstrap can emit ~2x the
         * expected slots. A per-site margin of 16x + 4096 slot
         * baseline covers the worst observed case with room to spare. */
        new_cap = caller->code_count * 3 + 4096;
        for (j = 0; j < caller->code_count; j++) {
            IrInst *I = &caller->code[j];
            if (I->op != IR_CALL) continue;
            for (k = 0; k < prog->func_count; k++) {
                if (cands[k].can_inline && I->name &&
                    ark_streq(I->name, cands[k].func->name) &&
                    !ark_streq(cands[k].func->name, caller->name)) {
                    IrFunc *callee = cands[k].func;
                    new_cap += I->val + callee->code_count * 16 + 128;
                    break;
                }
            }
        }
        new_code = (IrInst *)mem_pool_alloc((int)sizeof(IrInst) * new_cap);

        for (j = 0; j < caller->code_count; j++) {
            IrInst *I = &caller->code[j];
            IrFunc *callee = 0;
            int n_args, L0, L1, end_label;
            int body_begin = -1, body_end = -1;
            if (I->op != IR_CALL) {
                new_code[new_count++] = *I;
                continue;
            }
            /* ?????????????????? */
            for (k = 0; k < prog->func_count; k++) {
                if (cands[k].can_inline && I->name &&
                    ark_streq(I->name, cands[k].func->name) &&
                    !ark_streq(cands[k].func->name, caller->name)) {
                    callee = cands[k].func;
                    break;
                }
            }
            if (!callee) {
                new_code[new_count++] = *I;
                continue;
            }

            n_args = I->val;
            if (n_args < 0) n_args = 0;
            if (n_args > 4) n_args = 4;  /* AAPCS??? 4 ???? r0-r3 */
            L0 = caller->local_size;
            L1 = L0 + n_args * 4;
            end_label = caller->label_count + callee->label_count;

            /* ????????????????FUNC_BEGIN..FUNC_END ??? */
            for (k = 0; k < callee->code_count; k++) {
                if (callee->code[k].op == IR_FUNC_BEGIN) {
                    body_begin = k + 1;
                } else if (callee->code[k].op == IR_FUNC_END) {
                    body_end = k;
                    break;
                }
            }
            if (body_begin < 0 || body_end < 0) {
                /* ?????????????????????????????? */
                new_code[new_count++] = *I;
                continue;
            }

            /* a. ?? n ?? IR_STORE(temp_off_j)??????? n ???????????????? */
            for (k = 0; k < n_args; k++) {
                IrInst *s = &new_code[new_count++];
                s->op = IR_STORE;
                s->val = L0 + k * 4;  /* temp_off_k??arg0 ????? */
                s->name = 0;
                s->aux = 0;
                s->line = I->line;
            }

            /* b. ???????????????????/???/GETARG/RETURN ??? */
            for (k = body_begin; k < body_end; k++) {
                IrInst *src = &callee->code[k];
                IrInst *dst = &new_code[new_count++];
                *dst = *src;
                switch (src->op) {
                    case IR_STORE:
                    case IR_PUSH_VAR:
                    case IR_PUSH_ADDR:
                    case IR_LOCAL_ALLOC:
                        dst->val = src->val + L1;
                        break;
                    case IR_GETARG: {
                        /* ???????? r{j} ???? callee ??? off??
                         * ??????? temp_off_j ????????? L1+off??
                         * aux low 8 bits = arg index; high 24 bits = struct
                         * size (only present for struct-by-value params, which
                         * are excluded from inlining above). Mask to be safe. */
                        int callee_off = src->val;
                        int arg_j = src->aux & 0xFF;
                        dst->op = IR_PUSH_VAR;
                        dst->val = L0 + arg_j * 4;
                        dst->name = 0;
                        dst->aux = 0;
                        {
                            IrInst *st = &new_code[new_count++];
                            st->op = IR_STORE;
                            st->val = L1 + callee_off;
                            st->name = 0;
                            st->aux = 0;
                            st->line = src->line;
                        }
                        break;
                    }
                    case IR_RETURN:
                        /* ?????????????????????? push????
                         * ??I?????? end_label?? */
                        dst->op = IR_JMP;
                        dst->val = end_label;
                        dst->name = 0;
                        dst->aux = 0;
                        break;
                    case IR_LABEL:
                    case IR_JMP:
                    case IR_JZ:
                    case IR_JNZ:
                        dst->val = src->val + caller->label_count;
                        break;
                    case IR_FUNC_BEGIN:
                    case IR_FUNC_END:
                        dst->op = IR_NOP;
                        break;
                    default:
                        /* ?????????????? */
                        break;
                }
            }

            /* c. ????? IR_LABEL(end_label) */
            {
                IrInst *l = &new_code[new_count++];
                l->op = IR_LABEL;
                l->val = end_label;
                l->name = 0;
                l->aux = 0;
                l->line = I->line;
            }

            /* ???? caller ?? */
            caller->local_size = L1 + callee->local_size;
            caller->label_count = end_label + 1;
        }

        /* ??I caller ?? code ???? */
        caller->code = new_code;
        caller->code_count = new_count;
        caller->code_capacity = new_cap;
    }
}

/* =====================================================================
 * ???????????--vectorize / -O2??
 * =====================================================================
 *
 * ??????????????? for ??????????????? "c[i] = a[i] ?? b[i]"
 * ?? "c[i] = a[i] ?? K" ?????????? es ?? {1, 2}??
 *   - es == 2 (short) ?? SIMD ???? W = 2????? IR_SIMD_ADD16/SUB16
 *   - es == 1 (char)  ?? SIMD ???? W = 4????? IR_SIMD_ADD8/SUB8
 *
 * ???? IR ????caller ??????????
 *   init:    PUSH_INT 0; STORE <i_off>; [PUSH_VAR i; POP]   (i = 0)
 *   LABEL <start_l>
 *   cond:    PUSH_VAR <i_off>; PUSH_INT N; BINARY <LT>; JZ <end_l>
 *   body:    ... ???? LOAD_IDX es / STORE_IDX es / BINARY ?? ...
 *   LABEL <cont_l>
 *   step:    ... PUSH_INT 1; BINARY PLUS; STORE <i_off> ...   (i++)
 *   JMP <start_l>
 *   LABEL <end_l>
 *
 * ?????
 *   - ???? PUSH_INT 1 ?? PUSH_INT W
 *   - ??????? LOAD_IDX es ?? LOAD_IDX (es * W)????????? W*es ????
 *   - ??????? STORE_IDX es ?? STORE_IDX (es * W)
 *   - ?????????????? LOAD_IDX ?? BINARY ?? ?? IR_SIMD_ADD16/SUB16/ADD8/SUB8
 *
 * ??????
 *   - ?????? N ??????????? N % W == 0???????????????????????????
 *   - ???????????????????? start_l..cont_l ???????? LABEL??
 *   - ?????????????????IR_CALL?????? IR_RETURN
 *   - ??????? LOAD_IDX/STORE_IDX ?? es ??????????????? + ?? -
 */

/* ?? [start, end) ????????? IR_CALL / IR_RETURN / ??? LABEL */
static int body_has_unsafe_op(IrFunc *f, int start, int end) {
    int i;
    for (i = start; i < end; i++) {
        IrOp op = f->code[i].op;
        if (op == IR_CALL || op == IR_RETURN) return 1;
        if (op == IR_LABEL || op == IR_LABEL_NAMED) return 1;
    }
    return 0;
}

/* ?? body ???????????????????
 *   ... LOAD_IDX es ... LOAD_IDX es ... BINARY ?? ... STORE_IDX es ...
 * ??????????? *es_out, *op_out (TOK_PLUS/TOK_MINUS)??
 * ??? load_idx1, load_idx2, binary_idx, store_idx ?? code[] ??????????
 * ???? 1=???0=????? */
static int match_vectorize_body(IrFunc *f, int body_start, int body_end,
                                int *es_out, int *op_out,
                                int *load1_idx, int *load2_idx,
                                int *binary_idx, int *store_idx) {
    int i;
    int li1 = -1, li2 = -1, bi = -1, si = -1;
    int es = 0;
    int op = 0;
    int count_load = 0;
    int count_store = 0;
    for (i = body_start; i < body_end; i++) {
        IrInst *I = &f->code[i];
        if (I->op == IR_LOAD_IDX) {
            if (count_load == 0) {
                li1 = i;
                es = I->val;
            } else if (count_load == 1) {
                li2 = i;
                if (I->val != es) return 0;  /* ??????????? */
            } else {
                return 0;  /* ???? 2 ?? LOAD_IDX */
            }
            count_load++;
        } else if (I->op == IR_STORE_IDX) {
            if (count_store > 0) return 0;  /* ???? 1 ?? STORE_IDX */
            si = i;
            if (es != 0 && I->val != es) return 0;
            if (es == 0) es = I->val;
            count_store++;
        } else if (I->op == IR_BINARY && count_load >= 2) {
            /* ????????? LOAD_IDX ???? BINARY ?? ????????????
             * ??????? BINARY ?? ??????????&base + i*es????
             * ???????????LOAD_IDX ?? LOAD_IDX ?? BINARY ?? STORE_IDX?? */
            int bop = I->aux & ~0x100;
            if (bop == (int)TOK_PLUS || bop == (int)TOK_MINUS) {
                if (bi >= 0) return 0;  /* ???????? */
                bi = i;
                op = bop;
            }
        }
    }
    if (count_load != 2 || count_store != 1 || bi < 0) return 0;
    if (li2 < li1 || bi < li2 || si < bi) return 0;  /* ?????? */
    if (es != 1 && es != 2) return 0;
    *es_out = es;
    *op_out = op;
    *load1_idx = li1;
    *load2_idx = li2;
    *binary_idx = bi;
    *store_idx = si;
    return 1;
}

void opt_vectorize(IrProgram *prog) {
    int fi, i;
    if (!prog) return;
    for (fi = 0; fi < prog->func_count; fi++) {
        IrFunc *f = prog->funcs[fi];
        int j;

        /* ??????????IR_JMP(val=lab) ?????????? IR_LABEL(val=lab) */
        for (j = 0; j < f->code_count; j++) {
            int start_lab = -1, end_lab = -1, cont_lab = -1;
            int start_lab_idx = -1, cont_lab_idx = -1;
            int body_start = -1, body_end = -1;
            int step_start = -1, step_end = -1;
            int i_off = -1;
            int N = -1;
            int es = 0, bop = 0;
            int li1 = -1, li2 = -1, bi = -1, si = -1;
            int W;
            IrOp simd_op;

            if (f->code[j].op != IR_JMP) continue;
            start_lab = f->code[j].val;

            /* ????? IR_LABEL(val=start_lab) */
            for (i = j - 1; i >= 0; i--) {
                if (f->code[i].op == IR_LABEL && f->code[i].val == start_lab) {
                    start_lab_idx = i;
                    break;
                }
            }
            if (start_lab_idx < 0) continue;

            /* ?? start_lab ????? IR_JZ <end_lab>??????????? */
            end_lab = -1;
            for (i = start_lab_idx + 1; i < j; i++) {
                if (f->code[i].op == IR_JZ) {
                    end_lab = f->code[i].val;
                    break;
                }
            }
            if (end_lab < 0) continue;

            /* cont_lab ?? body ???JMP ???? LABEL */
            for (i = j - 1; i > start_lab_idx; i--) {
                if (f->code[i].op == IR_LABEL) {
                    cont_lab = f->code[i].val;
                    cont_lab_idx = i;
                    break;
                }
            }
            if (cont_lab < 0) continue;
            if (cont_lab == end_lab) continue;  /* ?? body ????? */

            /* end_lab_idx = j + 1??????? JMP ??? LABEL?? */
            if (j + 1 >= f->code_count) continue;
            if (f->code[j + 1].op != IR_LABEL ||
                f->code[j + 1].val != end_lab) continue;

            body_start = start_lab_idx + 1;
            body_end = cont_lab_idx;
            step_start = cont_lab_idx + 1;
            step_end = j;

            /* ???? cond??PUSH_VAR <i_off>; PUSH_INT N; BINARY <LT>; JZ end_lab */
            {
                /* ??? JZ ?????? */
                int jz_idx = -1;
                int k;
                for (k = start_lab_idx + 1; k < cont_lab_idx; k++) {
                    if (f->code[k].op == IR_JZ) { jz_idx = k; break; }
                }
                if (jz_idx < 0) continue;
                body_start = jz_idx + 1;
                /* ????PUSH_VAR i_off; PUSH_INT N; BINARY LT; JZ end_lab */
                if (jz_idx - 3 < start_lab_idx) continue;
                if (f->code[jz_idx - 3].op != IR_PUSH_VAR) continue;
                if (f->code[jz_idx - 2].op != IR_PUSH_INT) continue;
                if (f->code[jz_idx - 1].op != IR_BINARY) continue;
                {
                    int bop2 = f->code[jz_idx - 1].aux & ~0x100;
                    if (bop2 != (int)TOK_LT && bop2 != (int)TOK_LE &&
                        bop2 != (int)TOK_NE) continue;
                }
                i_off = f->code[jz_idx - 3].val;
                N = f->code[jz_idx - 2].val;
            }

            /* body ????? CALL/RETURN/??? LABEL */
            if (body_has_unsafe_op(f, body_start, body_end)) continue;

            /* ??? body ?? */
            if (!match_vectorize_body(f, body_start, body_end,
                                      &es, &bop, &li1, &li2, &bi, &si)) continue;

            /* ??? SIMD ???????? */
            if (es == 2) {
                W = 2;
                simd_op = (bop == (int)TOK_PLUS) ? IR_SIMD_ADD16 : IR_SIMD_SUB16;
            } else {
                W = 4;
                simd_op = (bop == (int)TOK_PLUS) ? IR_SIMD_ADD8 : IR_SIMD_SUB8;
            }

            /* ??? N % W == 0?????????????????????????????? */
            if (N <= 0 || (N % W) != 0) continue;

            /* ??? step ???? PUSH_INT 1??????????????????????? BINARY PLUS; STORE i_off */
            {
                int found_step = 0;
                int k;
                for (k = step_start; k < step_end - 2; k++) {
                    if (f->code[k].op == IR_PUSH_INT &&
                        f->code[k].val == 1 &&
                        f->code[k + 1].op == IR_BINARY &&
                        (f->code[k + 1].aux & ~0x100) == (int)TOK_PLUS &&
                        f->code[k + 2].op == IR_STORE &&
                        f->code[k + 2].val == i_off) {
                        /* ??????? W */
                        f->code[k].val = W;
                        found_step = 1;
                        break;
                    }
                }
                if (!found_step) continue;
            }

            /* ??? body??
             *   - LOAD_IDX es ?? LOAD_IDX (es * W)
             *   - STORE_IDX es ?? STORE_IDX (es * W)
             *   - ???????? BINARY ?? ?? simd_op
             */
            f->code[li1].val = es * W;
            f->code[li2].val = es * W;
            f->code[si].val = es * W;
            f->code[bi].op = simd_op;
            f->code[bi].aux = 0;

            /* ???????????????j ??????????????? val ??????????????
             * ???????????????????????????????? */
        }
    }
}
