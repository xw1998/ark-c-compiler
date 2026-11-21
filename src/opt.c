/* Ark C Compiler - opt
 * IR optimization passes: constant folding + dead code elimination + inlining + vectorization.
 *
 * Design notes:
 *   - In the stack IR the triple IR_PUSH_INT a; IR_PUSH_INT b; IR_BINARY op folds
 *     into a single IR_PUSH_INT (a op b). The two consumed instructions become
 *     IR_NOP and are compacted away afterwards.
 *   - IR_BINARY carries the TOK_xxx operator in aux bits 0..7, 0x100 = unsigned.
 *   - Dead code elimination: code after IR_RETURN / IR_JMP / IR_JMP_NAMED and
 *     before the next IR_LABEL / IR_LABEL_NAMED is unreachable -> IR_NOP.
 *   - Passes repeat until a fixed point (or 8 iterations) so (1+2*3) cascades fold.
 *
 * Switches:
 *   - compile time: #if ARKCC_FEATURE_OPT_CONSTFOLD / ARKCC_FEATURE_OPT_DCE
 *   - run time: g_config.enable_opt_constfold / enable_opt_dce
 */
#include "opt.h"
#include "config.h"
#include "arkcc_config.h"
#include "common.h"
#include "memory.h"
#include "irgen.h"      /* irgen_param_slots(): what a parameter costs on the wire */

/* Remove the IR_NOP placeholders from code[] and update code_count. */
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

/* Evaluate a op b. Returns 1 when foldable (result in *out), 0 otherwise.
 * aux uses the IR_BINARY layout: operator in bits 0..7, unsigned flag in 0x100.
 * Arithmetic is done on long long (64-bit); unsigned ops cast to unsigned long long. */
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
        case (int)TOK_SHL:
            /* Bug-I8 FIX: Abandon folding for UB shifts. C99 6.5.7:
             *   - shift count negative or >= width -> UB
             *   - left shift of negative signed value -> UB
             * Folding these to a masked result would silently produce
             * a wrong constant; instead return 0 so the expression is
             * left as-is for the backend to evaluate at runtime. */
            if (b < 0 || b >= 64) return 0;
            if (!is_unsigned && a < 0) return 0;
            r = (long long)((unsigned long long)a << b);
            break;
        case (int)TOK_SHR:
            if (b < 0 || b >= 64) return 0;
            if (is_unsigned) r = (long long)((unsigned long long)a >> b);
            else r = a >> b;
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
            return 0;  /* unknown operator: never fold */
    }
    *out = r;
    return 1;
}

/* #11 FIX: Volatile access protection.
 * IR_PUSH_VAR / IR_PUSH_GLOBAL / IR_STORE / IR_STORE_GLOBAL / IR_LOAD_IDX /
 * IR_STORE_IDX with bit 0x10000 (IR_AUX_VOLATILE) in aux must NOT be
 * eliminated, folded, or combined by any optimization pass. The constfold
 * pass below only folds PUSH_INT+PUSH_INT+BINARY patterns and is inherently
 * safe. The DCE pass only removes unreachable code after RETURN/JMP. Future
 * optimization passes (load combining, dead store elimination, etc.) MUST
 * check (I->aux & IR_AUX_VOLATILE) before removing any memory access. */
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
            /* N5 FIX: Never fold sequences that involve volatile memory
             * accesses. Although PUSH_INT/BINARY don't normally carry the
             * volatile bit, this check is defensive against future IR shapes
             * and documents the invariant. */
            if ((a->aux | b->aux | c->aux) & IR_AUX_VOLATILE) continue;
            if (!eval_binary(a->val, b->val, c->aux, &result)) continue;
            /* Fold: the first instruction becomes the result, the next two become NOP */
            a->val = result;
            b->op = IR_NOP;
            c->op = IR_NOP;
            changed = 1;
            /* Keep scanning forward; cascades are handled by the next pass. */
        }
        if (changed) compact_func(f);
    }
}

/* --- Strength reduction (-fopt-strength) ---------------------------------
 * `x * k` with k = 2^sh is `x << sh`: a left shift keeps the same low 32 bits
 * as the product does, so the rewrite is exact for signed and unsigned
 * operands alike and cannot turn a correct answer into a different one.  irgen
 * always emits the constant instruction immediately before the multiply, for
 * every constant-multiply shape it has:
 *
 *     explicit      x * 4                PUSH x     PUSH_INT 4    BINARY MUL
 *     subscript     a[i]                 PUSH a     PUSH i        PUSH_INT 4  BINARY MUL  BINARY +
 *     pointer add   p + i                PUSH p     PUSH i        PUSH_INT 4  BINARY MUL  BINARY +
 *     struct field  p->x  (offset scale) PUSH_INT 16  ...          BINARY MUL  BINARY +
 *
 * so the pattern is two adjacent instructions:
 *
 *     IR_PUSH_INT k  IR_BINARY (TOK_MUL)  ->  IR_PUSH_INT sh  IR_BINARY (TOK_SHL)
 *     IR_PUSH_INT 1  IR_BINARY (TOK_MUL)  ->  both removed (net stack effect 0)
 *
 * Deliberately not handled:
 *   - k == 0: the product is 0, but the multiplicand is already on the stack
 *     and the stack IR has no neutral "drop" op to take it off again.
 *   - k < 0 (x * -4): the factor also needs a negate, which this shape does
 *     not have room for.
 *   - a constant on the *left* (4 * x): the constant is then not adjacent to
 *     the multiply, so it is out of reach of a two-instruction window.
 * No shape gains an instruction, and the k == 1 case loses two, so the image
 * cannot grow; the number of rewritten pairs is what the -v log reports.
 */
void opt_strength_func(IrFunc *f) {
#if ARKCC_FEATURE_OPT_STRENGTH
    int changed = 0;
    int i;
    for (i = 0; i + 1 < f->code_count; i++) {
        IrInst *a = &f->code[i];
        IrInst *b = &f->code[i + 1];
        long long k;
        int sh = 0;
        if (a->op != IR_PUSH_INT || b->op != IR_BINARY) continue;
        if ((b->aux & ~0x100) != (int)TOK_MUL) continue;
        k = a->val;
        if (k == 1) {                       /* x * 1: the pair is a no-op */
            a->op = IR_NOP;
            b->op = IR_NOP;
            changed = 1;
            continue;
        }
        if (k < 2 || k > 0x40000000LL) continue;
        if ((k & (k - 1)) != 0) continue;   /* not a power of two */
        while ((1LL << sh) < k) sh++;
        a->val = (long long)sh;
        b->aux = (int)TOK_SHL;              /* 0x100 would be the unsigned
                                             * right shift flag; not set here */
        changed = 1;
    }
    if (changed) compact_func(f);
#else
    (void)f;
#endif
}

void opt_dce_func(IrFunc *f) {
    int i;
    int unreachable = 0;
    for (i = 0; i < f->code_count; i++) {
        IrInst *I = &f->code[i];
        if (unreachable) {
            /* Still unreachable: keep collecting. */
            if (I->op == IR_LABEL || I->op == IR_LABEL_NAMED) {
                unreachable = 0;
                continue;
            }
            /* N5 FIX: preserve volatile memory accesses even in dead code.
             * Volatile reads/writes must not be eliminated by the optimizer. */
            if (I->aux & IR_AUX_VOLATILE)
                continue;
            /* Mark the unreachable instruction as NOP (FUNC_BEGIN/FUNC_END stay) */
            if (I->op != IR_FUNC_BEGIN && I->op != IR_FUNC_END) {
                I->op = IR_NOP;
            }
            continue;
        }
        /* After RETURN / unconditional jump everything is unreachable. */
        if (I->op == IR_RETURN || I->op == IR_JMP || I->op == IR_JMP_NAMED) {
            unreachable = 1;
        }
    }
    compact_func(f);
}

#if ARKCC_FEATURE_OPT_DCE_CFG
/* 基本块级可达性删除（CFG DCE）。
 *
 * 为什么线性 DCE 不够：opt_dce_func 只删「RETURN/JMP 之后、下一个标签之前」
 * 的指令，一遇到标签就停止。于是下面这种代码一块都删不掉：
 *
 *     if (x) return 1;
 *     ...                 <- 只有 x 为真才会跳过，仍然可达
 *     L_never:            <- 没有任何跳转指向它
 *         do_something(); <- 永远执行不到，却留在产物里
 *
 * 这里先按「跳转终止指令 / 标签」切基本块，再从函数第一条指令做可达性传播，
 * 把「没有任何路径能到达」的块整块标成 NOP。
 *
 * 保守条款（宁可少删，不可删错）：
 *   1. IR_FUNC_BEGIN / FUNC_END 不动；
 *   2. 标签指令本身保留（它不产生字节，删了反而可能让别的引用落空）；
 *   3. 带 IR_AUX_VOLATILE 的访存一律保留；
 *   4. 不认识的指令按「顺序执行」处理，只把它当作块内普通指令。
 */
static int cfg_label_index(IrFunc *f, IrInst *jump) {
    int i;
    int is_named = (jump->op == IR_JMP_NAMED);
    for (i = 0; i < f->code_count; i++) {
        IrInst *L = &f->code[i];
        if (is_named) {
            if (L->op == IR_LABEL_NAMED && L->name && jump->name &&
                ark_streq(L->name, jump->name)) return i;
        } else {
            if (L->op == IR_LABEL && L->val == jump->val) return i;
        }
    }
    return -1;
}

void opt_dce_cfg_func(IrFunc *f) {
    int n, i;
    unsigned char *reach;
    unsigned char *queued;
    int *queue;
    int qh = 0, qt = 0;

    if (!f || f->code_count <= 0) return;
    n = f->code_count;
    reach  = (unsigned char *)mem_pool_alloc(n);
    queued = (unsigned char *)mem_pool_alloc(n);
    queue  = (int *)mem_pool_alloc(n * (int)sizeof(int));

    /* 入口 */
    queue[qt++] = 0;
    queued[0] = 1;

    while (qh < qt) {
        int start = queue[qh++];
        i = start;
        while (i >= 0 && i < n) {
            IrInst *I = &f->code[i];
            if (reach[i]) break;          /* 接到已访问过的块：停止 */
            reach[i] = 1;

            if (I->op == IR_RETURN || I->op == IR_FUNC_END) break;

            if (I->op == IR_JMP || I->op == IR_JMP_NAMED) {
                int t = cfg_label_index(f, I);
                if (t >= 0 && !queued[t]) { queued[t] = 1; queue[qt++] = t; }
                break;
            }
            if (I->op == IR_JZ || I->op == IR_JNZ) {
                int t = cfg_label_index(f, I);
                if (t >= 0 && !queued[t]) { queued[t] = 1; queue[qt++] = t; }
                i++;                      /* 条件跳转：落空路径继续顺序执行 */
                continue;
            }
            if (I->op == IR_CMP_JMP_EQ) {
                /* switch 的比较跳转：目标标签存在 aux 里 */
                IrInst probe;
                int t;
                probe.op  = IR_JMP;
                probe.val = I->aux;
                probe.name = 0;
                t = cfg_label_index(f, &probe);
                if (t >= 0 && !queued[t]) { queued[t] = 1; queue[qt++] = t; }
                i++;
                continue;
            }
            i++;
        }
    }

    for (i = 0; i < n; i++) {
        IrInst *I = &f->code[i];
        if (reach[i]) continue;
        if (I->op == IR_FUNC_BEGIN || I->op == IR_FUNC_END) continue;
        if (I->op == IR_LABEL || I->op == IR_LABEL_NAMED) continue;
        if (I->aux & IR_AUX_VOLATILE) continue;
        I->op = IR_NOP;
    }
    compact_func(f);
}
#endif /* ARKCC_FEATURE_OPT_DCE_CFG */

/* =====================================================================
 * Function inlining (--autoinline / -O2)
 * =====================================================================
 *
 * Algorithm:
 *   1. Mark the inlinable functions: walk each function's IR and exclude the
 *      shapes that cannot be expanded (recursion, variadic, irq, naked, asm_func,
 *      constructor/destructor).
 *        - size rule: instruction count <= ark_inline_threshold(), or forceinline
 *          which bypasses the limit;
 *        - at most 4 parameter *words* (AAPCS register arguments, and the
 *          expansion parks them in four temporary slots);
 *        - every parameter must be reproducible by word copies
 *          (irgen_param_slots()); a payload carried by address is not.
 *   2. Find every call site of an inlinable callee and expand it in place:
 *      the caller's code[] is rebuilt with the callee body spliced in.
 *   3. Expanding one site rebuilds code[] (no memmove, the whole array is written):
 *        - store each of the n arguments with IR_STORE(temp_off_j), where
 *          temp_off_j = caller.local_size + j*4;
 *        - emit the callee body (FUNC_BEGIN..FUNC_END excluded), remapping:
 *            * frame offsets += L1, with L1 = caller.local_size + n*4;
 *            * IR_GETARG(callee_off, j) becomes IR_PUSH_VAR(temp_off_j);
 *              IR_STORE(L1 + callee_off)
 *            * IR_RETURN becomes IR_JMP(end_label);
 *            * IR_LABEL/IR_JMP/IR_JZ/IR_JNZ labels += caller.label_count;
 *            * IR_FUNC_BEGIN/IR_FUNC_END become IR_NOP;
 *        - emit IR_LABEL(end_label);
 *        - set caller.local_size = L1 + callee.local_size;
 *        - set caller.label_count = end_label + 1.
 *      The n call arguments are consumed by the n STOREs and the call result is
 *      left on the stack: IR_RETURN is replaced by IR_JMP so every path reaching
 *      the end label leaves the same number of slots, keeping the stack balanced
 *      for the code that follows the call. 4) opt_run finally runs opt_dce_func.
 */
/* 内联体积上限不再是常量：0.9.1 --size-weight 会移动它
 * （ark_inline_threshold()，权重 5 = 历史值 12）。 */

typedef struct {
    IrFunc *func;
    int inst_count;
    int can_inline;
} InlineCandidate;

/* Count real instructions (skipping FUNC_BEGIN/FUNC_END/LABEL/NOP) and detect
 * direct recursion. */
static int count_insts_and_check_recursion(IrFunc *f, int *out_count) {
    int i;
    int n = 0;
    int recursive = 0;
    for (i = 0; i < f->code_count; i++) {
        IrOp op = f->code[i].op;
        if (op == IR_FUNC_BEGIN || op == IR_FUNC_END ||
            op == IR_LABEL || op == IR_NOP) continue;
        if (op == IR_CALL && f->code[i].name &&
            ark_streq(f->code[i].name, f->name)) {
            recursive = 1;
        }
        n++;
    }
    *out_count = n;
    return recursive;
}

/* Words the callee's parameters occupy on the wire, or -1 when the expansion
 * below cannot reproduce the transfer.
 *
 * This question used to be answered by scanning for IR_GETARG with
 * (aux >> 8) != 0 -- but irgen stamps every parameter's size into aux as
 * (size << 8) | slot, so a plain `int` looked exactly like a struct-by-value
 * parameter and *no function with a parameter was ever inlined* (measured:
 * `static int add1(int x){return x+1;}` stayed a BL at -O2 on ARM, and
 * __forceinline could not override it).  The answer now comes from the
 * parameter types, through the same rule irgen used to lay the arguments out
 * (irgen_param_slots). */
static int inline_param_words(IrFunc *f) {
    int j;
    int total = 0;
    if (f->param_count > 0 && !f->param_types) return -1;
    for (j = 0; j < f->param_count; j++) {
        int w = irgen_param_slots(f->param_types[j]);
        if (w < 0) return -1;
        total += w;
    }
    return total;
}

void opt_inline(IrProgram *prog) {
    int i, j, k;
    InlineCandidate *cands;
    if (!prog || prog->func_count == 0) return;

    /* 1. Mark the inlinable functions */
    cands = (InlineCandidate *)mem_pool_alloc(
        (int)sizeof(InlineCandidate) * prog->func_count);
    for (i = 0; i < prog->func_count; i++) {
        IrFunc *f = prog->funcs[i];
        int cnt = 0;
        int pwords;
        int recursive = count_insts_and_check_recursion(f, &cnt);
        pwords = inline_param_words(f);
        cands[i].func = f;
        cands[i].inst_count = cnt;
        cands[i].can_inline = 0;
        if (recursive) continue;
        if (f->is_variadic) continue;
        if (f->is_irq || f->is_naked || f->is_asm_func) continue;
        if (f->is_constructor || f->is_destructor) continue;
        if (f->param_count > 4) continue;
        /* -1: some parameter is carried by address (the callee memcpys the
         * payload) or the target's slots are not 4-byte words.  >4: the
         * expansion parks the incoming words in four temporary slots, which is
         * also the AAPCS register-argument limit.  Both refuse the expansion
         * instead of writing code that copies the wrong words. */
        if (pwords < 0) continue;
        if (pwords > 4) continue;
        if (f->forceinline) {
            cands[i].can_inline = 1;  /* forceinline bypasses the size limit */
        } else if (cnt <= ark_inline_threshold()) {
            cands[i].can_inline = 1;
        }
    }

    /* 2. Rewrite the callers that contain an expandable call site. */
    for (i = 0; i < prog->func_count; i++) {
        IrFunc *caller = prog->funcs[i];
        int new_cap;
        int new_count = 0;
        IrInst *new_code;
        int has_site = 0;

        /* Does this caller contain at least one expandable call site? */
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

        /* Allocate the new code: caller code + expansion room (n_args + callee_code*2 + 4)
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
            int twords = 0;
            int body_begin = -1, body_end = -1;
            if (I->op != IR_CALL) {
                new_code[new_count++] = *I;
                continue;
            }
            /* Find the callee of this IR_CALL. */
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

            n_args = I->val;   /* IR_CALL carries the *argument* count */
            if (n_args < 0) n_args = 0;
            /* The expansion below stores one group of words per declared
             * parameter, so the site has to agree with the callee's own
             * signature.  A mismatch means the IR is not the shape this pass
             * understands; keep the call instead of expanding it wrongly.
             * (Variadic callees never get here -- they are refused above.) */
            if (n_args != callee->param_count) {
                new_code[new_count++] = *I;
                continue;
            }
            /* Total words the arguments occupy: the temporary region is sized
             * in words, not in arguments, because a long long / double / 5..8
             * byte composite parameter travels as two.  The candidate filter
             * already refused more than four. */
            for (k = 0; k < n_args; k++) {
                int w = irgen_param_slots(callee->param_types[k]);
                if (w < 0) w = 1;   /* refused at candidate time; be defensive */
                twords += w;
            }
            L0 = caller->local_size;
            L1 = L0 + twords * 4;
            end_label = caller->label_count + callee->label_count;

            /* Locate the callee body: everything between FUNC_BEGIN and FUNC_END. */
            for (k = 0; k < callee->code_count; k++) {
                if (callee->code[k].op == IR_FUNC_BEGIN) {
                    body_begin = k + 1;
                } else if (callee->code[k].op == IR_FUNC_END) {
                    body_end = k;
                    break;
                }
            }
            if (body_begin < 0 || body_end < 0) {
                /* Malformed callee (no proper body): keep the call unchanged. */
                new_code[new_count++] = *I;
                continue;
            }

            /* a. Store the arguments into the temporary word area: argument j
             * owns words [base, base+w).  The IR pushes an argument's words low
             * first (the high word ends up on top of the stack), so the stores
             * walk q from w-1 down to 0 and land the low word at the lower
             * offset -- the layout IR_GETARG and the backends expect. */
            {
                int base = 0;
                int aj;
                for (aj = 0; aj < n_args; aj++) {
                    int w = irgen_param_slots(callee->param_types[aj]);
                    int q;
                    if (w < 0) w = 1;
                    for (q = w - 1; q >= 0; q--) {
                        IrInst *s = &new_code[new_count++];
                        s->op = IR_STORE;
                        s->val = L0 + (base + q) * 4;
                        s->name = 0;
                        s->aux = 0;
                        s->line = I->line;
                    }
                    base += w;
                }
            }

            /* b. Copy the body, remapping frame offsets / labels / GETARG / RETURN. */
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
                        /* GETARG r{j} targets callee frame offset off; copy the
                         * value from temp slot arg_j into L1+off.
                         * aux low 8 bits = word slot, high 24 bits = the
                         * parameter's size.  A size above 4 means two words
                         * (long long, double, a 5..8-byte composite); sizes
                         * above 8 (payload carried by address) were refused
                         * when the candidate was marked, so 1 or 2 words is
                         * the only shape that reaches this code. */
                        int callee_off = src->val;
                        int arg_j = src->aux & 0xFF;
                        int nwords = ((src->aux >> 8) > 4) ? 2 : 1;
                        int q;
                        for (q = 0; q < nwords; q++) {
                            IrInst *pv;
                            IrInst *st;
                            if (q == 0) {
                                dst->op = IR_PUSH_VAR;
                                dst->val = L0 + arg_j * 4;
                                dst->name = 0;
                                dst->aux = 0;
                                pv = dst;
                            } else {
                                pv = &new_code[new_count++];
                                pv->op = IR_PUSH_VAR;
                                pv->val = L0 + (arg_j + q) * 4;
                                pv->name = 0;
                                pv->aux = 0;
                                pv->line = src->line;
                            }
                            (void)pv;
                            st = &new_code[new_count++];
                            st->op = IR_STORE;
                            st->val = L1 + callee_off + q * 4;
                            st->name = 0;
                            st->aux = 0;
                            st->line = src->line;
                        }
                        break;
                    }
                    case IR_RETURN:
                        /* IR_RETURN: the return value (if any) is already on the stack,
                         * so replace it with IR_JMP(end_label). */
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
                        /* Other opcodes are copied unchanged. */
                        break;
                }
            }

            /* c. Emit IR_LABEL(end_label). */
            {
                IrInst *l = &new_code[new_count++];
                l->op = IR_LABEL;
                l->val = end_label;
                l->name = 0;
                l->aux = 0;
                l->line = I->line;
            }

            /* Update the caller's frame and label counters. */
            caller->local_size = L1 + callee->local_size;
            caller->label_count = end_label + 1;
        }

        /* Install the rebuilt code for this caller. */
        caller->code = new_code;
        caller->code_count = new_count;
        caller->code_capacity = new_cap;
    }
}

/* =====================================================================
 * Basic-block vectorization (--vectorize / -O2)
 * =====================================================================
 *
 * Detects counted loops of the shape "c[i] = a[i] op b[i]" or
 * "c[i] = a[i] op K" when the element size es is {1, 2}:
 *   - es == 2 (short): SIMD width W = 2, emit IR_SIMD_ADD16/SUB16
 *   - es == 1 (char):  SIMD width W = 4, emit IR_SIMD_ADD8/SUB8
 *
 * Expected IR shape (i is the induction variable):
 *   init:    PUSH_INT 0; STORE <i_off>; [PUSH_VAR i; POP]   (i = 0)
 *   LABEL <start_l>
 *   cond:    PUSH_VAR <i_off>; PUSH_INT N; BINARY <LT>; JZ <end_l>
 *   body:    ... e.g. LOAD_IDX es / STORE_IDX es / BINARY op ...
 *   LABEL <cont_l>
 *   step:    ... PUSH_INT 1; BINARY PLUS; STORE <i_off> ...   (i++)
 *   JMP <start_l>
 *   LABEL <end_l>
 *
 * Rewrite:
 *   - the step PUSH_INT 1 becomes PUSH_INT W
 *   - array LOAD_IDX es becomes LOAD_IDX (es * W) (W elements at a time)
 *   - array STORE_IDX es becomes STORE_IDX (es * W)
 *   - the element BINARY op becomes IR_SIMD_ADD16/SUB16/ADD8/SUB8
 *
 * Limits:
 *   - the trip count N must be a multiple of W, otherwise the loop is left alone
 *   - the loop body must not contain a LABEL between start_l..cont_l
 *   - no IR_CALL and no IR_RETURN in the body
 *   - only LOAD_IDX/STORE_IDX with element size es, and only + / - are handled
 */

/* Return non-zero if [start, end) contains IR_CALL / IR_RETURN / a label. */
static int body_has_unsafe_op(IrFunc *f, int start, int end) {
    int i;
    for (i = start; i < end; i++) {
        IrOp op = f->code[i].op;
        if (op == IR_CALL || op == IR_RETURN) return 1;
        if (op == IR_LABEL || op == IR_LABEL_NAMED) return 1;
    }
    return 0;
}

/* Match a vectorizable body shape:
 *   ... LOAD_IDX es ... LOAD_IDX es ... BINARY op ... STORE_IDX es ...
 * On success fills *es_out and *op_out (TOK_PLUS/TOK_MINUS), plus
 * load_idx1, load_idx2, binary_idx and store_idx with the code[] indices.
 * Returns 1 on a match, 0 otherwise. */
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
            /* aux 0x200 = volatile, 0x400 = __packed: neither survives the
             * rewrite.  A volatile access may not become one wide access, and a
             * packed one is assembled byte by byte by both backends precisely
             * because the address does not suit the width -- widening it to
             * es*W would put the misaligned trap back (and, on ARM, silently
             * read the wrong bytes).  Leave those loops alone. */
            if (I->aux & (0x200 | 0x400)) return 0;
            if (count_load == 0) {
                li1 = i;
                es = I->val;
            } else if (count_load == 1) {
                li2 = i;
                if (I->val != es) return 0;  /* element size mismatch */
            } else {
                return 0;  /* only two LOAD_IDX are allowed */
            }
            count_load++;
        } else if (I->op == IR_STORE_IDX) {
            if (I->aux & (0x200 | 0x400)) return 0;  /* see the load case above */
            if (count_store > 0) return 0;  /* only one STORE_IDX */
            si = i;
            if (es != 0 && I->val != es) return 0;
            if (es == 0) es = I->val;
            count_store++;
        } else if (I->op == IR_BINARY && count_load >= 2) {
            /* Take the BINARY that follows the two LOAD_IDX as the element op.
             * The address arithmetic (base + i*es) comes before the loads, so the
             * matched op is exactly LOAD_IDX, LOAD_IDX, BINARY op, STORE_IDX. */
            int bop = I->aux & ~0x100;
            if (bop == (int)TOK_PLUS || bop == (int)TOK_MINUS) {
                if (bi >= 0) return 0;  /* more than one candidate op */
                bi = i;
                op = bop;
            }
        }
    }
    if (count_load != 2 || count_store != 1 || bi < 0) return 0;
    if (li2 < li1 || bi < li2 || si < bi) return 0;  /* wrong instruction order */
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

        /* Look for IR_JMP(val=lab) whose target is an IR_LABEL(val=lab). */
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

            /* Find IR_LABEL(val=start_lab). */
            for (i = j - 1; i >= 0; i--) {
                if (f->code[i].op == IR_LABEL && f->code[i].val == start_lab) {
                    start_lab_idx = i;
                    break;
                }
            }
            if (start_lab_idx < 0) continue;

            /* From start_lab, find the IR_JZ <end_lab> that guards the loop. */
            end_lab = -1;
            for (i = start_lab_idx + 1; i < j; i++) {
                if (f->code[i].op == IR_JZ) {
                    end_lab = f->code[i].val;
                    break;
                }
            }
            if (end_lab < 0) continue;

            /* cont_lab: the LABEL right before the JMP back. */
            for (i = j - 1; i > start_lab_idx; i--) {
                if (f->code[i].op == IR_LABEL) {
                    cont_lab = f->code[i].val;
                    cont_lab_idx = i;
                    break;
                }
            }
            if (cont_lab < 0) continue;
            if (cont_lab == end_lab) continue;  /* empty body */

            /* end_lab_idx = j + 1 must be the LABEL that follows the JMP. */
            if (j + 1 >= f->code_count) continue;
            if (f->code[j + 1].op != IR_LABEL ||
                f->code[j + 1].val != end_lab) continue;

            body_start = start_lab_idx + 1;
            body_end = cont_lab_idx;
            step_start = cont_lab_idx + 1;
            step_end = j;

            /* Check the condition: PUSH_VAR <i_off>; PUSH_INT N; BINARY <LT>; JZ end_lab */
            {
                /* Locate the JZ first. */
                int jz_idx = -1;
                int k;
                for (k = start_lab_idx + 1; k < cont_lab_idx; k++) {
                    if (f->code[k].op == IR_JZ) { jz_idx = k; break; }
                }
                if (jz_idx < 0) continue;
                body_start = jz_idx + 1;
                /* Read it back: PUSH_VAR i_off; PUSH_INT N; BINARY LT; JZ end_lab */
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

            /* The body must not contain CALL / RETURN / LABEL. */
            if (body_has_unsafe_op(f, body_start, body_end)) continue;

            /* Match the body shape. */
            if (!match_vectorize_body(f, body_start, body_end,
                                      &es, &bop, &li1, &li2, &bi, &si)) continue;

            /* Pick the SIMD opcode and width. */
            if (es == 2) {
                W = 2;
                simd_op = (bop == (int)TOK_PLUS) ? IR_SIMD_ADD16 : IR_SIMD_SUB16;
            } else {
                W = 4;
                simd_op = (bop == (int)TOK_PLUS) ? IR_SIMD_ADD8 : IR_SIMD_SUB8;
            }

            /* Require N % W == 0 so no epilogue is needed. */
            if (N <= 0 || (N % W) != 0) continue;

            /* Find the step (PUSH_INT 1 ... BINARY PLUS; STORE i_off) and bump the stride. */
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
                        /* Change the stride to W. */
                        f->code[k].val = W;
                        found_step = 1;
                        break;
                    }
                }
                if (!found_step) continue;
            }

            /* Rewrite the body:
             *   - LOAD_IDX es -> LOAD_IDX (es * W)
             *   - STORE_IDX es -> STORE_IDX (es * W)
             *   - element BINARY op -> simd_op
             */
            /* The element narrowing has to go with the width.  irgen puts an
             * IR_TRUNC right after every narrow load (a char/short load lands
             * in a 32-bit slot and is re-extended to its type) and right before
             * the store.  Now that one load covers W elements, narrowing that
             * word back to a single element keeps lane 0 and throws the rest
             * away: measured on a char loop, c came back as {2,0,0,0} instead
             * of {2,4,6,8} -- a wrong answer in both backends, not a slow one.
             * IR_TRUNC with 32 bits is a no-op in both backends, so raising the
             * width is the whole fix and the ops keep their indices. */
            if (f->code[li1 + 1].op == IR_TRUNC) f->code[li1 + 1].val = 32;
            if (f->code[li2 + 1].op == IR_TRUNC) f->code[li2 + 1].val = 32;
            if (f->code[bi + 1].op == IR_TRUNC)  f->code[bi + 1].val = 32;

            f->code[li1].val = es * W;
            f->code[li2].val = es * W;
            f->code[si].val = es * W;
            f->code[bi].op = simd_op;
            f->code[bi].aux = 0;

            /* The loop index j now points past the rewritten body, so the scan
             * continues directly with the next loop. */
        }
    }
}
/* ------------------------------------------------------------------ */
/* Whole-program constant propagation (--const-global)                 */
/* ------------------------------------------------------------------ */
#if ARKCC_FEATURE_CONST_GLOBAL

/* A file-scope `const` object is a constant in the sense C gives it: every
 * read of it, in every translation unit, is the value its initialiser spells
 * out, because writing it is undefined behaviour.  irgen still emits
 * IR_PUSH_GLOBAL for such a read -- a load through the object's address --
 * because at the moment it generates the instruction it does not know whether
 * the definition even lives in this translation unit.  After inlining (and,
 * under --ipo, after every unit has been appended into one program) the answer
 * is known, and that load can become an immediate.
 *
 * What has to be proved, and what each condition rules out:
 *   const, defined here, scalar initialiser
 *       -- an object with no initialiser has no value to propagate; an
 *          aggregate, a string or an address constant needs a different
 *          rewrite than "push one word".
 *   never stored to, address never taken
 *       (IR_STORE_GLOBAL / IR_PUSH_GLOBAL_ADDR / named by an initialiser)
 *       -- C declares writes to a const object UB, but a program that does it
 *          is still compiled: once the address escapes we cannot see who
 *          writes through it, so the load has to stay.
 *   the load itself is not volatile
 *       -- IR_AUX_VOLATILE means "read this every time"; folding it would be
 *          a wrong answer, not an optimisation.
 *   4-byte non-floating type
 *       -- IR_PUSH_INT pushes exactly one word.  A `long long` or a double
 *          travels as two, and a narrower object would need the extension
 *          decided here; those keep the load, which is correct, just slower.
 *   no __at() / section() / __thread / __global_reg
 *       -- placement attributes and register variables exist so that
 *          something outside the C program can look at the object.
 *
 * Returns the number of loads replaced; 0 means nothing was proved and the
 * program is byte-for-byte untouched.
 */
int opt_const_global(IrProgram *p) {
    typedef struct { const char *name; long long value; int blocked; } CgCand;
    CgCand *cand;
    int ncand = 0, hits = 0, i, k, j;

    if (!p || p->global_count <= 0) return 0;
    cand = (CgCand *)mem_pool_alloc((int)sizeof(CgCand) * p->global_count);
    if (!cand) return 0;

    /* Step 1: which objects are even candidates. */
    for (i = 0; i < p->global_count; i++) {
        IrGlobal *g = p->globals[i];
        if (!g->is_const || g->is_extern || !g->has_init) continue;
        if (g->is_float || g->init_is_complex) continue;
        if (g->init_str || g->init_aggregate || g->init_sym) continue;
        if (g->init_ref_count > 0) continue;
        if (g->section || g->has_at || g->is_tls || g->global_reg >= 0) continue;
        if (!g->type || g->type->is_volatile) continue;
        switch (g->type->kind) {
        case TYPE_VOID: case TYPE_ARRAY: case TYPE_STRUCT:
        case TYPE_UNION: case TYPE_FUNC:
            continue;
        default:
            break;
        }
        if (type_size(g->type) != 4) continue;
        cand[ncand].name    = g->name;
        cand[ncand].value   = g->init_int;
        cand[ncand].blocked = 0;
        ncand++;
    }
    if (ncand == 0) return 0;

    /* Step 2: disqualify any object whose address escapes.  A write through a
     * pointer, or a read by code that is not in this program, both start with
     * the address being taken. */
    for (i = 0; i < p->func_count; i++) {
        IrFunc *f = p->funcs[i];
        for (k = 0; k < f->code_count; k++) {
            IrInst *I = &f->code[k];
            if (I->op != IR_PUSH_GLOBAL_ADDR && I->op != IR_STORE_GLOBAL) continue;
            if (!I->name) continue;
            for (j = 0; j < ncand; j++)
                if (ark_streq(cand[j].name, I->name)) { cand[j].blocked = 1; break; }
        }
    }
    for (i = 0; i < p->global_count; i++) {
        IrGlobal *g = p->globals[i];
        if (g->init_sym) {
            for (j = 0; j < ncand; j++)
                if (ark_streq(cand[j].name, g->init_sym)) { cand[j].blocked = 1; break; }
        }
        for (k = 0; k < g->init_ref_count; k++) {
            if (!g->init_refs[k].sym) continue;
            for (j = 0; j < ncand; j++)
                if (ark_streq(cand[j].name, g->init_refs[k].sym)) { cand[j].blocked = 1; break; }
        }
    }

    /* Step 3: replace the surviving loads with the value, then re-fold so the
     * constant cascades through the arithmetic that consumed it.  Only
     * functions that actually changed are re-folded: running the folder over
     * every function would change -O output for programs this pass did not
     * touch. */
    for (i = 0; i < p->func_count; i++) {
        IrFunc *f = p->funcs[i];
        int changed = 0;
        for (k = 0; k < f->code_count; k++) {
            IrInst *I = &f->code[k];
            if (I->op != IR_PUSH_GLOBAL || !I->name) continue;
            if (I->aux & (IR_AUX_VOLATILE | IR_AUX_SLOT64 | IR_AUX_COMPLEX)) continue;
            for (j = 0; j < ncand; j++) {
                if (cand[j].blocked) continue;
                if (!ark_streq(cand[j].name, I->name)) continue;
                I->op   = IR_PUSH_INT;
                I->val  = cand[j].value;
                I->name = 0;
                I->aux  = 0;
                I->aux2 = 0;
                hits++;
                changed = 1;
                break;
            }
        }
        if (changed) opt_constfold_func(f);
    }
    return hits;
}
#endif /* ARKCC_FEATURE_CONST_GLOBAL */
