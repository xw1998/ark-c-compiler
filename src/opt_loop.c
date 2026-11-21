/* Ark C Compiler - opt_loop.c
 * ---------------------------------------------------------------------
 * The two loop optimisations: loop-invariant code motion (--licm) and
 * complete unrolling of counted loops (--unroll).
 *
 * Both are opt-in, both are compiled out of the MCU profile by default, and
 * with both switches off the image is byte-identical to a build that does not
 * contain this file (the passes are pure functions of the IR and are only
 * reached from the pipeline table when their flag is on).
 *
 * The rule the project keeps repeating applies to both passes: a shape that
 * is not *proved* safe is left exactly as it was. Neither pass guesses, and
 * neither has an "accept anyway" path.
 * ---------------------------------------------------------------------
 */
#include "opt.h"
#include "ir.h"
#include "memory.h"
#include "common.h"
#include "config.h"
#include "arkcc_config.h"

#if ARKCC_FEATURE_LICM || ARKCC_FEATURE_UNROLL
#include "mir.h"
#endif

/* =====================================================================
 * Loop-invariant code motion (--licm)
 * =====================================================================
 *
 * The IR is a stack machine: a value lives on the evaluation stack until the
 * next instruction consumes it. That rules out the textbook transform (move
 * the computation out and leave the value in a register), because nothing
 * carries a stack slot across the back edge.
 *
 * So the transform keeps the *store* where it is and moves the *computation*
 * into a compiler temporary:
 *
 *     preheader:          t = a * b            (new)
 *     loop body:          x = t                (was: x = a * b)
 *
 * This is also what makes the pass safe for a zero-trip loop: writing a fresh
 * temporary that nobody reads costs nothing, and the store to `x` still
 * happens exactly as often as before. Nothing is speculated that the original
 * program did not already do, with one exception -- see the division rule
 * below.
 *
 * What may be moved (whitelist, and everything else stops a candidate)
 * --------------------------------------------------------------------
 * A candidate is a maximal run of instructions inside one block of the loop
 * that ends with a plain word store, on which the stack effect sums to zero.
 * Every instruction in the run must be:
 *
 *   IR_PUSH_INT / IR_PUSH_VAR / IR_PUSH_GLOBAL   (+1 word)
 *   IR_BINARY      except / and %                (-1 word)
 *   IR_UNARY                                     (0)
 *   IR_DUP (+1) / IR_SWAP (0) / IR_NOP (0)
 *
 * Nothing else is movable, and specifically:
 *   - division and modulo are excluded because they can trap. Hoisting a
 *     trapping operation out of a loop that never runs would introduce a fault
 *     the unoptimised program never had. (IR_DIV / IR_MOD are separate
 *     opcodes and are simply not on the list; the / and % token check covers
 *     the IR_BINARY spelling as well.)
 *   - anything flagged volatile, complex or 64-bit-slot is excluded, as are
 *     8-byte pushes: their word count is ABI-dependent, and a wrong word count
 *     here would silently unbalance the evaluation stack.
 *   - every load that is not a named local or a named global (IR_LOAD_IDX,
 *     IR_LOAD_FLD, IR_PUSH_ADDR, ...) breaks a candidate: reading memory
 *     through a pointer needs alias analysis, which this pass does not have.
 *
 * Invariance of the operands
 * --------------------------
 * A local read is invariant when
 *   (a) its address is never taken anywhere in the function (so no indirect
 *       store and no call can reach it), and
 *   (b) no IR_STORE to that frame offset occurs in the loop.
 * (a) is conservative on purpose: the address of a local can be handed to a
 * callee, and then "no direct store in the loop" proves nothing.
 *
 * A global read is invariant when
 *   (a) the loop contains no call, inline asm, memcpy or indirect store (any
 *       of which could write it), and
 *   (b) no IR_STORE_GLOBAL of the same name occurs in the loop.
 *
 * Candidates of at least three instructions are moved. A two-instruction
 * candidate is `push x; store y`, i.e. a plain copy: moving it buys nothing,
 * and refusing it is also what makes the pass terminate -- the instruction
 * pair it leaves behind is never a candidate again.
 * --------------------------------------------------------------------- */

#if ARKCC_FEATURE_LICM

#define LICM_NOT_MOVABLE (-1000)

/* Stack effect, in words, of one instruction that may be moved, or
 * LICM_NOT_MOVABLE. Only word-shaped instructions are accepted; see the
 * comment above for why the 64-bit and float forms are out. */
static int licm_delta(const IrInst *I) {
    if (I->aux & (IR_AUX_VOLATILE | IR_AUX_SLOT64 | IR_AUX_COMPLEX))
        return LICM_NOT_MOVABLE;
    switch (I->op) {
    case IR_NOP:        return 0;
    case IR_PUSH_INT:   return 1;
    case IR_PUSH_VAR:
    case IR_PUSH_GLOBAL:
        if ((I->aux & 0xFF) == 8) return LICM_NOT_MOVABLE;
        return 1;
    case IR_BINARY:
        /* aux holds the operator token in bits 0..7 (0x100 = unsigned). */
        if ((I->aux & 0xFF) == (int)TOK_DIV ||
            (I->aux & 0xFF) == (int)TOK_MOD)
            return LICM_NOT_MOVABLE;
        return -1;
    case IR_UNARY:      return 0;
    case IR_DUP:        return 1;
    case IR_SWAP:       return 0;
    default:            return LICM_NOT_MOVABLE;
    }
}

/* Is `I` a store that may end a candidate? Both spellings are accepted: the
 * store itself stays where it is, so its target does not have to be invariant
 * or even known. */
static int licm_is_store(const IrInst *I) {
    if (I->op != IR_STORE && I->op != IR_STORE_GLOBAL) return 0;
    if (I->aux & (IR_AUX_VOLATILE | IR_AUX_SLOT64 | IR_AUX_COMPLEX)) return 0;
    if ((I->aux & 0xFF) == 8) return 0;
    return 1;
}

typedef struct LicmCtx {
    IrFunc      *f;
    MirFunc     *m;
    MirLoop     *lp;
    unsigned char *taken;     /* 1 = the local's address is taken somewhere  */
    int          local_size;  /* size of `taken`                             */
    int          loop_has_opaque_write; /* call / asm / memcpy / indirect store */
} LicmCtx;

static int licm_off_taken(const LicmCtx *c, long long off) {
    if (off < 0 || off >= c->local_size) return 1;  /* unknown: assume taken */
    return c->taken[off];
}

/* Does the loop contain any instruction that could write memory this pass
 * cannot name? Answered once per loop from a single scan. */
static int licm_loop_has_opaque_write(const MirFunc *m, const MirLoop *lp) {
    int b, i;
    for (b = 0; b < m->blk_count; b++) {
        if (!lp->in_loop[b]) continue;
        for (i = m->blk[b].start; i < m->blk[b].end; i++) {
            switch (m->f->code[i].op) {
            case IR_CALL:
            case IR_ASM:
            case IR_MEMCPY:
            case IR_STORE_IDX:
            case IR_STORE_FLD:
            case IR_STORE_GLOBAL:
            case IR_ALLOCA:
            case IR_SMC:
                return 1;
            default:
                break;
            }
        }
    }
    return 0;
}

/* Does `IR_STORE off` occur anywhere in the loop? */
static int licm_loop_stores_off(const MirFunc *m, const MirLoop *lp, long long off) {
    int b, i;
    for (b = 0; b < m->blk_count; b++) {
        if (!lp->in_loop[b]) continue;
        for (i = m->blk[b].start; i < m->blk[b].end; i++) {
            const IrInst *I = &m->f->code[i];
            if (I->op == IR_STORE && I->val == off) return 1;
        }
    }
    return 0;
}

/* Does `IR_STORE_GLOBAL name` occur anywhere in the loop? */
static int licm_loop_stores_global(const MirFunc *m, const MirLoop *lp,
                                   const char *name) {
    int b, i;
    if (!name) return 1;
    for (b = 0; b < m->blk_count; b++) {
        if (!lp->in_loop[b]) continue;
        for (i = m->blk[b].start; i < m->blk[b].end; i++) {
            const IrInst *I = &m->f->code[i];
            if (I->op == IR_STORE_GLOBAL && I->name && ark_streq(I->name, name))
                return 1;
        }
    }
    return 0;
}

/* Are every operands read by the candidate invariant? */
static int licm_operands_invariant(const LicmCtx *c, int seg_start, int seg_len) {
    int i;
    for (i = seg_start; i < seg_start + seg_len; i++) {
        const IrInst *I = &c->f->code[i];
        if (I->op == IR_PUSH_VAR) {
            if (licm_off_taken(c, I->val)) return 0;
            if (licm_loop_stores_off(c->m, c->lp, I->val)) return 0;
        } else if (I->op == IR_PUSH_GLOBAL) {
            if (c->loop_has_opaque_write) return 0;
            if (licm_loop_stores_global(c->m, c->lp, I->name)) return 0;
        }
    }
    return 1;
}

/* Find the first movable candidate in block `b`. Fills *seg_start / *seg_len
 * (the run including the trailing store) and returns 1 when one is found. */
static int licm_find_in_block(const LicmCtx *c, int b, int *seg_start, int *seg_len) {
    const MirFunc *m = c->m;
    int i = m->blk[b].start, run_start = -1, depth = 0;

    while (i < m->blk[b].end) {
        const IrInst *I = &c->f->code[i];
        int d;

        if (licm_is_store(I)) {
            if (run_start >= 0 && depth - 1 == 0) {
                /* depth counts the value the store consumes: a balanced run
                 * has exactly one word on the stack when the store runs. */
                int len = i - run_start + 1;
                if (len >= 3 && licm_operands_invariant(c, run_start, len)) {
                    *seg_start = run_start;
                    *seg_len = len;
                    return 1;
                }
            }
            run_start = -1;
            depth = 0;
            i++;
            continue;
        }

        d = licm_delta(I);
        if (d == LICM_NOT_MOVABLE) {
            run_start = -1;
            depth = 0;
            i++;
            continue;
        }
        if (run_start < 0) { run_start = i; depth = 0; }
        depth += d;
        if (depth < 0) { run_start = -1; depth = 0; }
        i++;
    }
    return 0;
}

/* Move one candidate out of the loop into a fresh compiler temporary.
 * Returns 1 when the function's code was rewritten. */
static int licm_apply(IrFunc *f, const MirFunc *m, const MirLoop *lp,
                      int seg_start, int seg_len) {
    int ins, new_count, w = 0, i, k;
    IrInst *nc;
    int temp_off, store_aux;
    IrInst store = f->code[seg_start + seg_len - 1];

    /* Insert before the preheader's terminator. A preheader with exactly one
     * successor either ends in an unconditional jump (insert before it) or
     * falls through into the header (insert after its last instruction). */
    ins = m->blk[lp->preheader].end;
    if (ins > m->blk[lp->preheader].start) {
        IrOp last = f->code[ins - 1].op;
        if (last == IR_JMP || last == IR_JMP_NAMED) ins--;
    }

    /* The temporary lives in a new frame slot at the end of the frame, so no
     * existing offset moves. 8-byte aligned, matching the frame rounding the
     * ARM backend applies; one word is reserved. */
    temp_off = (f->local_size + 7) & ~7;
    store_aux = store.aux & 0xFF;

    /* + (segment-1) + 1 at the preheader, - segment + 2 at the loop site */
    new_count = f->code_count + 2 + 8;
    nc = (IrInst *)mem_pool_alloc(new_count * (int)sizeof(IrInst));

    for (i = 0; i < f->code_count; i++) {
        if (i == ins) {
            /* Only the computation moves: the store to the original target
             * stays in the loop, which is what keeps a zero-trip loop from
             * writing a value the unoptimised program never wrote. */
            for (k = 0; k < seg_len - 1; k++) nc[w++] = f->code[seg_start + k];
            /* same width as the original store; the value is bit-identical */
            nc[w] = store;
            nc[w].op  = IR_STORE;
            nc[w].val = temp_off;
            nc[w].name = 0;
            w++;
        }
        if (i == seg_start) {
            nc[w].op  = IR_PUSH_VAR;
            nc[w].val = temp_off;
            nc[w].name = 0;
            nc[w].aux = 4;               /* plain word load, no extension */
            nc[w].line = store.line;
            w++;
            nc[w] = store;               /* the store stays exactly as it was */
            w++;
            i += seg_len - 1;            /* skip the moved run */
            continue;
        }
        nc[w++] = f->code[i];
    }

    f->code = nc;
    f->code_count = w;
    f->code_capacity = new_count;
    f->local_size = temp_off + 8;
    return 1;
}

/* Collect the offsets whose address is taken anywhere in the function. */
static unsigned char *licm_taken_map(IrFunc *f, int *size_out) {
    unsigned char *taken;
    int size = (f->local_size > 0) ? f->local_size : 1;
    int i;
    taken = (unsigned char *)mem_pool_alloc(size);
    for (i = 0; i < f->code_count; i++) {
        const IrInst *I = &f->code[i];
        if (I->op != IR_PUSH_ADDR) continue;
        if (I->val >= 0 && I->val < size) taken[I->val] = 1;
    }
    *size_out = size;
    return taken;
}

void opt_licm_func(IrFunc *f) {
    int guard;
    if (!f || f->code_count < 4) return;

    /* One hoist per round, then the CFG is rebuilt: a natural loop's block set
     * moves under the pass, and re-deriving it is far cheaper to get right
     * than patching it. The round count is bounded by the code size because
     * every round either removes a candidate from a loop or makes no change,
     * and a two-instruction `push t; store x` is never a candidate, so the
     * same run cannot be hoisted twice. */
    for (guard = 0; guard <= f->code_count; guard++) {
        MirFunc m;
        MirLoop *loops;
        int nloops, nidx, i, applied = 0;
        unsigned char *taken;
        int taken_size = 0;

        if (mir_build(f, &m) != 0) return;
        loops = (MirLoop *)mem_pool_alloc((m.blk_count + 1) * (int)sizeof(MirLoop));
        nloops = mir_loops(&m, loops, m.blk_count);
        if (nloops <= 0) return;

        taken = licm_taken_map(f, &taken_size);

        /* Innermost first: an inner loop has fewer blocks than the loop that
         * contains it, so ascending block count is ascending nesting depth.
         * Hoisting the inner loop's invariants first lets the next round find
         * them in the (now shorter) inner preheader, still inside the outer
         * loop, and move them further out. */
        for (nidx = 0; nidx < nloops && !applied; nidx++) {
            int best = -1;
            for (i = 0; i < nloops; i++) {
                if (loops[i].nblocks < 0) continue;
                if (best < 0 || loops[i].nblocks < loops[best].nblocks) best = i;
            }
            if (best < 0) break;
            {
                MirLoop lp = loops[best];
                LicmCtx ctx;
                int b, seg_start = 0, seg_len = 0;

                loops[best].nblocks = -1;   /* consumed this round */

                if (lp.preheader < 0) continue;
                if (!lp.in_loop || lp.in_loop[lp.preheader]) continue;

                ctx.f = f;
                ctx.m = &m;
                ctx.lp = &lp;
                ctx.taken = taken;
                ctx.local_size = taken_size;
                ctx.loop_has_opaque_write = licm_loop_has_opaque_write(&m, &lp);

                for (b = 0; b < m.blk_count && !applied; b++) {
                    if (!lp.in_loop[b]) continue;
                    if (licm_find_in_block(&ctx, b, &seg_start, &seg_len)) {
                        if (licm_apply(f, &m, &lp, seg_start, seg_len)) applied = 1;
                    }
                }
            }
        }
        if (!applied) return;
    }
}

#endif /* ARKCC_FEATURE_LICM */

/* =====================================================================
 * Complete unrolling of counted loops (--unroll)
 * =====================================================================
 *
 * The accepted shape is exactly the one irgen emits for
 *
 *     for (i = c; i < N; i++) body;      c and N integer constants
 *
 * and nothing else:
 *
 *     B0  LABEL start ; PUSH_VAR i ; PUSH_INT N ; BINARY(<) ; JZ end
 *     B1  <body: straight line, no label, no jump, no return>
 *     B2  LABEL cont  ; PUSH_VAR i ; PUSH_INT 1 ; BINARY(+) ; STORE i ; JMP start
 *     B3  LABEL end   ; ...
 *
 * Every one of the following must hold, or the loop is left untouched:
 *
 *   - the three blocks above are the whole loop (B1's single successor is B2,
 *     B2's single successor is B0) and the header test is `i < N`;
 *   - `start` and `end` are referenced by exactly those two jumps: no
 *     `break`, no `continue`, no `goto` (a `break` would jump out of the
 *     middle of a copy, which the rewrite does not model);
 *   - `i` is written by exactly one store outside the loop -- `i = c` in a
 *     block that dominates the header -- and by the latch, plus nothing else
 *     anywhere. Its address is never taken (so the copies may substitute the
 *     induction value with a constant);
 *   - `N - c` is between 1 and ark_unroll_max(), and the body is short enough
 *     that the expansion stays within ARK_UNROLL_MAX_BODY words;
 *   - the body contains no inline asm or alloca (neither is modelled).
 *
 * The rewrite replaces B0..B2 with N copies of the body, each preceded by
 * `i = c+k`, then `i = c+N` so the value the loop would have left behind is
 * the same. B3 (LABEL end) and everything after it are untouched.
 *
 * A loop that does not match is *not* transformed. That is the whole design:
 * an unroller that guesses is an unroller that silently changes answers.
 * --------------------------------------------------------------------- */

#if ARKCC_FEATURE_UNROLL

/* Is this instruction a jump whose target is label id `id`? */
static int unroll_jump_targets(const IrInst *I, int *id, int *named, const char **name) {
    switch (I->op) {
    case IR_JMP:
    case IR_JZ:
    case IR_JNZ:
        *id = (int)I->val;
        *named = 0;
        return 1;
    case IR_JMP_NAMED:
        *named = 1;
        *name = I->name;
        return 1;
    default:
        return 0;
    }
}

/* Does any jump in the function target this label, other than the two
 * instructions at `skip_a` / `skip_b`? */
static int unroll_label_used_elsewhere(IrFunc *f, int label_inst,
                                       int skip_a, int skip_b) {
    const IrInst *L = &f->code[label_inst];
    int named = (L->op == IR_LABEL_NAMED);
    int i;
    for (i = 0; i < f->code_count; i++) {
        int id = 0, isnamed = 0;
        const char *nm = 0;
        const IrInst *I = &f->code[i];
        if (i == skip_a || i == skip_b) continue;
        if (I->op == IR_CMP_JMP_EQ) {
            if (!named && (int)I->aux == (int)L->val) return 1;
            continue;
        }
        if (!unroll_jump_targets(I, &id, &isnamed, &nm)) continue;
        if (!named && !isnamed && id == (int)L->val) return 1;
        if (named && isnamed && nm && L->name && ark_streq(nm, L->name)) return 1;
    }
    return 0;
}

/* Count the stores to frame offset `off` in the whole function, remembering
 * where they are. Returns the count; *only* is set to the index of the single
 * store when the count is 1. */
static int unroll_count_stores_to(IrFunc *f, long long off, int *only) {
    int i, n = 0;
    *only = -1;
    for (i = 0; i < f->code_count; i++) {
        const IrInst *I = &f->code[i];
        if (I->op == IR_STORE && I->val == off && !(I->aux & IR_AUX_VOLATILE)) {
            n++;
            *only = i;
        }
    }
    return n;
}

/* Rewrite one function. Returns 1 when the function was changed. */
static int unroll_try_func(IrFunc *f) {
    MirFunc m;
    MirLoop *loops;
    int nloops, li, changed = 0;

    if (!f || f->code_count < 6 || f->code_count > ARK_UNROLL_MAX_BODY * 4) return 0;
    if (mir_build(f, &m) != 0) return 0;
    loops = (MirLoop *)mem_pool_alloc((m.blk_count + 1) * (int)sizeof(MirLoop));
    nloops = mir_loops(&m, loops, m.blk_count);

    for (li = 0; li < nloops; li++) {
        MirLoop *lp = &loops[li];
        int hdr = lp->header, latch = -1, body = -1, b, i;
        int c, n_end, ctr_off = -1;
        int store_inst = -1, k, w = 0, new_count, prefix_len, suffix_start;
        int latch_store = -1;
        IrInst *nc, *src;
        int test_inst, jz_inst, step_plus;

        if (lp->nblocks != 3 || lp->preheader < 0) continue;

        /* B1 (body) and B2 (latch): the latch is the block whose terminator
         * jumps back to the header; the body is the header's fall-through
         * child whose only successor is the latch. */
        if (f->code[m.blk[hdr].start].op != IR_LABEL) continue;
        for (b = 0; b < m.blk_count; b++) {
            const MirBlock *B = &m.blk[b];
            int last;
            if (!lp->in_loop[b] || b == hdr) continue;
            if (B->succ_count != 1 || B->succ[0] != hdr) continue;
            last = B->end - 1;
            if (f->code[last].op == IR_JMP &&
                f->code[last].val == f->code[m.blk[hdr].start].val)
                latch = b;
        }
        if (latch < 0) continue;
        for (b = 0; b < m.blk_count; b++)
            if (lp->in_loop[b] && b != hdr && b != latch) body = b;
        if (body < 0) continue;
        if (m.blk[body].succ_count != 1 || m.blk[body].succ[0] != latch) continue;
        if (m.blk[latch].succ_count != 1 || m.blk[latch].succ[0] != hdr) continue;

        /* --- header: LABEL start ; PUSH_VAR ctr ; PUSH_INT N ; BINARY < ; JZ end */
        if (m.blk[hdr].end - m.blk[hdr].start != 5) continue;
        i = m.blk[hdr].start;
        if (f->code[i].op != IR_LABEL) continue;
        if (f->code[i + 1].op != IR_PUSH_VAR) continue;
        if ((f->code[i + 1].aux & 0xFF) != 0 && (f->code[i + 1].aux & 0xFF) != 4) continue;
        if (f->code[i + 1].aux & IR_AUX_VOLATILE) continue;
        ctr_off = (int)f->code[i + 1].val;
        if (f->code[i + 2].op != IR_PUSH_INT) continue;
        n_end = (int)f->code[i + 2].val;
        if (f->code[i + 3].op != IR_BINARY) continue;
        if ((f->code[i + 3].aux & 0xFF) != (int)TOK_LT) continue;   /* only i < N */
        test_inst = i + 3;
        jz_inst = i + 4;
        if (f->code[jz_inst].op != IR_JZ) continue;                 /* must exit when i>=N */

        /* --- latch: LABEL cont ; [PUSH_VAR ctr] ; PUSH_VAR ctr ; PUSH_INT 1 ;
         *            BINARY + ; STORE ctr ; [POP] ; JMP start
         *
         * irgen leaves the discarded value of the step expression on the stack
         * for a postfix `i++` (push the old value, then POP it), so the two
         * bracketed instructions are accepted but not required. Anything else
         * in the latch -- an extra store, a second jump, a non-unit step --
         * rejects the loop. */
        i = m.blk[latch].start;
        if (f->code[i].op != IR_LABEL && f->code[i].op != IR_LABEL_NAMED) continue;
        i++;
        if (i + 1 < m.blk[latch].end &&
            f->code[i].op == IR_PUSH_VAR && (int)f->code[i].val == ctr_off &&
            f->code[i + 1].op == IR_PUSH_VAR && (int)f->code[i + 1].val == ctr_off)
            i++;
        if (i + 4 > m.blk[latch].end) continue;
        if (f->code[i].op != IR_PUSH_VAR || (int)f->code[i].val != ctr_off) continue;
        if (f->code[i + 1].op != IR_PUSH_INT || f->code[i + 1].val != 1) continue;
        step_plus = i + 2;
        if (f->code[step_plus].op != IR_BINARY) continue;
        if ((f->code[step_plus].aux & 0xFF) != (int)TOK_PLUS) continue;
        if (f->code[i + 3].op != IR_STORE || (int)f->code[i + 3].val != ctr_off) continue;
        if (f->code[i + 3].aux & IR_AUX_VOLATILE) continue;
        latch_store = i + 3;
        i += 4;
        if (i < m.blk[latch].end - 1 && f->code[i].op == IR_POP) i++;
        if (i != m.blk[latch].end - 1) continue;
        if (f->code[i].op != IR_JMP) continue;                       /* numeric id only */

        /* --- the body must be straight line, with no labels and no jumps --- */
        if (m.blk[body].end - m.blk[body].start > ARK_UNROLL_MAX_BODY) continue;
        for (i = m.blk[body].start; i < m.blk[body].end; i++) {
            IrOp op = f->code[i].op;
            if (op == IR_LABEL || op == IR_LABEL_NAMED) break;
            if (op == IR_JMP || op == IR_JMP_NAMED || op == IR_JZ || op == IR_JNZ ||
                op == IR_CMP_JMP_EQ || op == IR_RETURN || op == IR_FUNC_END) break;
            if (op == IR_ASM || op == IR_ALLOCA || op == IR_SMC) break;
            if (op == IR_PUSH_ADDR && (int)f->code[i].val == ctr_off) break;
        }
        if (i < m.blk[body].end) continue;

        /* --- start / end may be referenced only by those two jumps --- */
        if (f->code[m.blk[latch].end - 1].val != f->code[m.blk[hdr].start].val) continue;
        if (unroll_label_used_elsewhere(f, m.blk[hdr].start, jz_inst,
                                        m.blk[latch].end - 1)) continue;
        if (m.blk[latch].end >= f->code_count) continue;
        if (f->code[m.blk[latch].end].op != IR_LABEL) continue;
        if (unroll_label_used_elsewhere(f, m.blk[latch].end, jz_inst,
                                        m.blk[latch].end - 1)) continue;

        /* --- i = c, once, in a block that dominates the header --- */
        {
            int total = unroll_count_stores_to(f, ctr_off, &store_inst);
            int init_inst, init_block;
            if (total != 2) continue;               /* the init and the latch */
            if (store_inst != latch_store) continue;
            /* find the other one */
            for (i = 0; i < f->code_count; i++) {
                if (i == store_inst) continue;
                if (f->code[i].op == IR_STORE && f->code[i].val == ctr_off &&
                    !(f->code[i].aux & IR_AUX_VOLATILE)) break;
            }
            if (i >= f->code_count) continue;
            init_inst = i;
            if (init_inst < 1 || f->code[init_inst - 1].op != IR_PUSH_INT) continue;
            init_block = m.inst_blk[init_inst];
            if (init_block < 0 || init_block == hdr) continue;
            if (!mir_dominates(&m, init_block, hdr)) continue;
            c = (int)f->code[init_inst - 1].val;
            /* the init push and store must not be inside the loop */
            if (lp->in_loop[init_block]) continue;
        }

        if (n_end - c < 1 || n_end - c > ark_unroll_max()) continue;

        /* --- rewrite: replace [hdr.start, latch.end) --- */
        prefix_len = m.blk[hdr].start;
        suffix_start = m.blk[latch].end;
        new_count = f->code_count
                  + (n_end - c) * (m.blk[body].end - m.blk[body].start + 2)
                  + 2 + 8
                  - (suffix_start - prefix_len);
        nc = (IrInst *)mem_pool_alloc(new_count * (int)sizeof(IrInst));
        src = f->code;

        for (i = 0; i < prefix_len; i++) nc[w++] = src[i];
        for (k = 0; k < n_end - c; k++) {
            int val = c + k;
            int bi;
            nc[w].op = IR_PUSH_INT; nc[w].val = val; nc[w].name = 0;
            nc[w].aux = 0; nc[w].line = src[m.blk[body].start].line;
            w++;
            nc[w].op = IR_STORE; nc[w].val = ctr_off; nc[w].name = 0;
            nc[w].aux = src[latch_store].aux; nc[w].line = nc[w - 1].line;
            w++;
            for (bi = m.blk[body].start; bi < m.blk[body].end; bi++) {
                nc[w] = src[bi];
                if (nc[w].op == IR_PUSH_VAR && (int)nc[w].val == ctr_off) {
                    nc[w].op = IR_PUSH_INT;
                    nc[w].val = val;
                    nc[w].name = 0;
                    nc[w].aux = 0;
                }
                w++;
            }
        }
        /* leave the induction variable where the loop would have left it */
        nc[w].op = IR_PUSH_INT; nc[w].val = n_end; nc[w].name = 0; nc[w].aux = 0;
        nc[w].line = src[test_inst].line;
        w++;
        nc[w].op = IR_STORE; nc[w].val = ctr_off; nc[w].name = 0;
        nc[w].aux = src[latch_store].aux; nc[w].line = nc[w - 1].line;
        w++;
        for (i = suffix_start; i < f->code_count; i++) nc[w++] = src[i];

        f->code = nc;
        f->code_count = w;
        f->code_capacity = new_count;
        changed = 1;
        break;   /* one loop per round; the caller re-runs until no change */
    }
    return changed;
}

void opt_unroll_func(IrFunc *f) {
    int guard;
    if (!f) return;
    /* Rebuild between rewrites: after one unroll the block numbering and the
     * label ids no longer describe the code, and re-deriving them is both
     * cheaper to verify and impossible to get subtly wrong. */
    for (guard = 0; guard < 8; guard++) {
        if (!unroll_try_func(f)) return;
    }
}

#endif /* ARKCC_FEATURE_UNROLL */
