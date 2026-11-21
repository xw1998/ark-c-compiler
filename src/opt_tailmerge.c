/* Ark C Compiler - opt_tailmerge.c
 * ---------------------------------------------------------------------
 * Block-tail merging (block-level cross-jump), stage `ir.tailmerge`,
 * and whole-block merging (`--xblock`, stage `ir.xblock`): one matcher,
 * two candidate generators.
 *
 * Why this pass exists
 * --------------------
 * The cheapest way to make code smaller is not "emit fewer instructions" but
 * "emit the same piece of code once". Inlining, branch folding and plain
 * source-level duplication all produce two blocks whose tails are identical:
 *
 *     if (a) { ...; x = 1; save(); return 0; }
 *     else   { ...; x = 1; save(); return 0; }
 *
 * Merging the two identical tails leaves one copy and turns the other into a
 * jump to it. This is what AC5 calls CrossJumps and what IAR calls
 * intracrossjump; the algorithm below follows the reconstructed shape in
 * `c_compiler/iar/docs/07-crossjump-and-tbaa.md` section 2-3, with the parts
 * that need a machine-level rewriter (jump-width recalculation, hoisting a
 * shared block to the cheapest position) left out on purpose: the IR has no
 * variable-width encodings, so there is nothing to recalculate.
 *
 * The rules, and the evidence behind each one
 * -------------------------------------------
 * 1. Matching is *instruction-identical*, not semantic. AC5's cj6.c experiment
 *    shows two tails that mean the same thing but use r1 instead of r0 are not
 *    merged; matching on something looser would need a proof of equivalence
 *    this pass does not have. In the IR there is no register allocation yet,
 *    so identical source shapes match more often than at machine level.
 *
 * 2. Only tails that start at evaluation-stack depth 0 are merged. The IR is a
 *    stack machine: a jump into a point with live values would carry the
 *    evaluation stack across a control-flow edge, which is a promise the
 *    backends have not made. Depth 0 is the statement boundary and costs
 *    nothing to require.
 *
 * 3. A tail is merged only when it is at least ark_tailmerge_min_len()
 *    instructions long: every extra entry pays one JMP, so a two-instruction
 *    tail would buy one instruction and could cost more once the jump has to
 *    widen. The gate measures the real byte account instead of trusting this
 *    rule, which is how the threshold is kept honest.
 *
 * 4. One merge round at a time, then the CFG is rebuilt -- the same shape as
 *    opt_licm_func. The round count is bounded by the code length, which is
 *    the termination guard IAR spells "Jump size optimization will not
 *    terminate!" and AC5 spells "need another pass".
 *
 * 5. The depth analysis is all-or-nothing per function. A label entered at two
 *    different depths, an opcode whose stack effect this pass does not know,
 *    an inline asm body, an ALLOCA, or a negative depth abandons the whole
 *    function. Merging half of a function whose stack model is not understood
 *    would be exactly the kind of guess this project refuses.
 *
 * Trimming
 * --------
 * ARKCC_FEATURE_TAILMERGE / ARKCC_FEATURE_XBLOCK (include/arkcc_config.h) are
 * 0 for the STM32_MIN profile and for a build without MIR, because both need
 * the CFG. They are independent: the depth model and the instruction matcher
 * are shared, each entry point is compiled on its own. With a feature on but
 * its runtime switch (--tailmerge / --xblock) off, the code is linked but
 * never entered, and the image is byte-identical to a build that does not
 * contain it.
 * ---------------------------------------------------------------------
 */
#include "opt.h"
#include "ir.h"
#include "memory.h"
#include "common.h"
#include "config.h"
#include "arkcc_config.h"

#if ARKCC_FEATURE_TAILMERGE || ARKCC_FEATURE_XBLOCK

#include "mir.h"

/* Any opcode this pass has not been taught a stack effect for stops the whole
 * function. That is deliberate: "assume 0" is how a stack model silently goes
 * wrong. IR_CMP_JMP_EQ is on the list too -- it is a 0.2.x opcode irgen no
 * longer emits, and the two backends disagree about whether the non-taken edge
 * pops it, so neither reading can be trusted here. */
#define TM_UNSAFE (-1000)
#define TM_MAX_CALL_ARGS 64

static int tm_is_label(const IrInst *I) {
    return I->op == IR_LABEL || I->op == IR_LABEL_NAMED;
}

/* Stack effect of one instruction, in words, or TM_UNSAFE. The table is the
 * machine backends' semantics (ARM and RV pop the operand of a branch, always
 * on both edges); the C backend's own copy differs for IR_CMP_JMP_EQ, which is
 * why that opcode is refused above rather than answered here. */
static int tm_delta(const IrInst *I) {
    switch (I->op) {
    case IR_NOP:
    case IR_UNARY:
    case IR_F2I:
    case IR_I2F:
    case IR_F2F:
    case IR_64F2I:
    case IR_64I2F:
    case IR_LOAD_FLD:
    case IR_SWAP:
    case IR_SEXT:
    case IR_ZEXT:
    case IR_CDECL64:
    case IR_JMP:
    case IR_JMP_NAMED:
    case IR_LABEL:
    case IR_LABEL_NAMED:
    case IR_LOCAL_ALLOC:
    case IR_GETARG:
    case IR_FUNC_BEGIN:
    case IR_FUNC_END:
    case IR_SVC:
        return 0;
    case IR_PUSH_INT:
    case IR_PUSH_VAR:
    case IR_PUSH_ADDR:
    case IR_PUSH_STR:
    case IR_PUSH_GLOBAL:
    case IR_PUSH_GLOBAL_ADDR:
    case IR_PUSH_FUNC:
    case IR_TRUNC:
    case IR_PUSH_FLOAT:
    case IR_64PUSH:
    case IR_DUP:
        return 1;
    case IR_POP:
    case IR_STORE:
    case IR_STORE_GLOBAL:
    case IR_JZ:
    case IR_JNZ:
    case IR_RETURN:
    case IR_BINARY:
    case IR_FADD:
    case IR_FSUB:
    case IR_FMUL:
    case IR_FDIV:
    case IR_FCMP:
    case IR_DIV:
    case IR_MOD:
    case IR_64BINARY:
    case IR_64CMP:
    case IR_LOAD_IDX:
    case IR_STORE_IDX:
    case IR_STORE_FLD:
    case IR_SIMD_ADD16:
    case IR_SIMD_SUB16:
    case IR_SIMD_ADD8:
    case IR_SIMD_SUB8:
        return -1;
    case IR_CALL: {
        /* (int)I->val is the argument count: irgen keeps it in the low 32
         * bits and puts every flag above bit 31, so the cast drops exactly
         * the flags. There is no shared argument-count macro in this tree
         * (backend_c.c's MAX_CALL_ARGS is that backend's own stack model),
         * so the bound here is a sanity limit: a count past it means this
         * pass cannot reason about the stack, and the function is abandoned
         * rather than guessed at. */
        int n = (int)I->val;
        if (n < 0 || n > TM_MAX_CALL_ARGS) return TM_UNSAFE;
        return -n + 1;              /* pops the arguments, pushes the result */
    }
    case IR_MEMCPY:
        return -2;
    default:
        return TM_UNSAFE;
    }
}

/* Do two instructions say exactly the same thing? Pointer identity is not
 * enough for `name` (two literals with the same spelling can be two objects),
 * and string comparison is not enough for the rest. */
static int tm_same_inst(const IrInst *a, const IrInst *b) {
    if (a->op != b->op) return 0;
    if (a->val != b->val) return 0;
    if (a->aux != b->aux) return 0;
    if (a->aux2 != b->aux2) return 0;
    if (!a->name || !b->name) return a->name == b->name;
    return ark_streq(a->name, b->name);
}

/* ------------------------------------------------------------------ */
/* Stack depth, per basic block and per instruction                    */
/* ------------------------------------------------------------------ */

typedef struct TmDepth {
    int *blk;      /* block entry depth, -1 = not reached / unreachable */
    int *inst;     /* depth before instruction i                           */
    int  ok;       /* 0 = the function cannot be analysed, do not touch it  */
} TmDepth;

static void tm_depth_free(TmDepth *d) {
    /* Everything comes from the per-TU arena; there is nothing to free. The
     * function exists so the call sites read as pairs and a later move to a
     * real allocator has one place to change. */
    (void)d;
}

static void tm_analyse_depth(const MirFunc *m, TmDepth *out) {
    const IrFunc *f = m->f;
    int n = m->blk_count;
    int iter;
    int i, b;

    out->blk = (int *)mem_pool_alloc((n > 0 ? n : 1) * (int)sizeof(int));
    out->inst = (int *)mem_pool_alloc((f->code_count > 0 ? f->code_count : 1) *
                                      (int)sizeof(int));
    out->ok = 1;
    for (i = 0; i < n; i++) out->blk[i] = -1;
    for (i = 0; i < f->code_count; i++) out->inst[i] = -1;

    if (n <= 0) { out->ok = 0; return; }
    out->blk[0] = 0;

    /* Fixpoint over blocks. Each round walks every reached block once; a
     * successor that has no known depth yet takes this one, and a successor
     * that already has a different one means the program reaches a label with
     * two different stack heights. irgen never produces that shape, so when it
     * is seen the IR did not come from irgen (an object file compiled by an
     * older arkc, or a hand-edited one) and the pass stays out. */
    for (iter = 0; iter < n + 2; iter++) {
        int changed = 0;
        for (b = 0; b < n; b++) {
            int d;
            const MirBlock *B = &m->blk[b];
            if (out->blk[b] < 0) continue;
            d = out->blk[b];
            for (i = B->start; i < B->end; i++) {
                int delta = tm_delta(&f->code[i]);
                if (delta == TM_UNSAFE) { out->ok = 0; return; }
                out->inst[i] = d;
                d += delta;
                if (d < 0) { out->ok = 0; return; }
            }
            {
                int k;
                for (k = 0; k < B->succ_count; k++) {
                    int s = B->succ[k];
                    if (s < 0 || s >= n) continue;
                    if (out->blk[s] < 0) { out->blk[s] = d; changed = 1; }
                    else if (out->blk[s] != d) { out->ok = 0; return; }
                }
            }
        }
        if (!changed) break;
    }
    /* Anything still at -1 is unreachable code (DCE normally ate it). Those
     * blocks are simply not candidates; they are not an error. */
}

#if ARKCC_FEATURE_TAILMERGE

/* ------------------------------------------------------------------ */
/* Candidates                                                          */
/* ------------------------------------------------------------------ */

typedef struct TmCand {
    int block;
    int start;      /* first instruction of the mergeable tail */
    int len;        /* instructions in the tail                  */
} TmCand;

/* The mergeable tail of one block: the longest run that ends at the block's
 * last instruction and starts at a point where the evaluation stack is empty.
 * `-1` when the block has no such run. Labels are never part of a tail: a
 * copied label would be a second definition of the same jump target, and every
 * jump would keep aiming at the first one. */
static int tm_tail_of(const MirFunc *m, const TmDepth *d, int b, TmCand *out) {
    const MirBlock *B = &m->blk[b];
    int s = -1;
    int i;

    if (d->blk[b] < 0) return 0;
    /* The tail must be a *suffix* of the block, so it starts at the LAST
     * point where the evaluation stack is empty. Taking the first such point
     * would drag the branch-specific instructions in front of it along and
     * make two branches that only differ at the top look unmergeable. */
    for (i = B->start; i < B->end; i++) {
        if (d->inst[i] == 0) s = i;
    }
    if (s < 0) return 0;
    if (tm_is_label(&m->f->code[s])) s++;
    if (s >= B->end) return 0;
    for (i = s; i < B->end; i++)
        if (tm_is_label(&m->f->code[i])) return 0;
    if (B->end - s < ark_tailmerge_min_len()) return 0;

    out->block = b;
    out->start = s;
    out->len = B->end - s;
    return 1;
}

/* Rewrite the instruction list: put a fresh label in front of the kept tail
 * and replace every other member's tail with one jump to it. `keep` is the
 * candidate whose copy stays; `drop` holds `ndrop` candidates to redirect.
 * Returns 1 when the code changed. */
static int tm_apply(IrFunc *f, const TmCand *keep, const TmCand *drop, int ndrop) {
    int new_label = f->label_count;
    int extra = 1;                     /* the label in front of the kept tail */
    int new_count = f->code_count + extra;
    int i, k, w = 0;
    IrInst *nc;

    nc = (IrInst *)mem_pool_alloc(new_count * (int)sizeof(IrInst));

    for (i = 0; i < f->code_count; i++) {
        int dropped = 0;
        for (k = 0; k < ndrop; k++) {
            if (i == drop[k].start) {
                IrInst j;
                j.op = IR_JMP;
                j.val = new_label;
                j.name = 0;
                j.aux = 0;
                j.aux2 = 0;
                j.line = f->code[i].line;
                nc[w++] = j;
                i = drop[k].start + drop[k].len - 1;
                dropped = 1;
                break;
            }
        }
        if (dropped) continue;
        if (i == keep->start) {
            IrInst lbl;
            lbl.op = IR_LABEL;
            lbl.val = new_label;
            lbl.name = 0;
            lbl.aux = 0;
            lbl.aux2 = 0;
            lbl.line = f->code[i].line;
            nc[w++] = lbl;
        }
        nc[w++] = f->code[i];
    }

    f->code = nc;
    f->code_count = w;
    f->code_capacity = new_count;
    f->label_count = new_label + 1;
    return 1;
}

void opt_tailmerge_func(IrFunc *f) {
    int guard;

    if (!f || f->code_count < ark_tailmerge_min_len()) return;
    /* An asm body or an SMC is opaque to the depth model; the per-round
     * analysis would refuse the function anyway, this just skips the walk. */
    if (f->is_naked || f->is_asm_func) return;

    /* One merge per round, then the CFG is rebuilt: merging turns one block's
     * tail into a jump, which changes the blocks around it, and re-deriving
     * the graph is far cheaper to get right than patching it. Every round
     * strictly shrinks the instruction list (a tail of at least
     * ark_tailmerge_min_len() instructions becomes one jump), so the loop
     * terminates; the guard only keeps a bug from turning into a hang. */
    for (guard = 0; guard <= f->code_count; guard++) {
        MirFunc m;
        TmDepth d;
        TmCand *cands;
        unsigned char *used;
        int ncand = 0;
        int best_group_start = -1, best_saving = 0, best_ndrop = 0;
        int b, i;

        if (mir_build(f, &m) != 0) return;
        tm_analyse_depth(&m, &d);
        if (!d.ok) { tm_depth_free(&d); return; }

        cands = (TmCand *)mem_pool_alloc((m.blk_count + 1) * (int)sizeof(TmCand));
        used = (unsigned char *)mem_pool_alloc(m.blk_count + 1);
        for (b = 0; b < m.blk_count; b++) used[b] = 0;
        for (b = 0; b < m.blk_count; b++) {
            TmCand c;
            if (tm_tail_of(&m, &d, b, &c)) {
                cands[ncand++] = c;
            }
        }

        /* Group identical tails. The group with the largest total saving wins;
         * ties go to the earliest group so the result does not depend on hash
         * order. Every candidate belongs to at most one group. */
        for (i = 0; i < ncand; i++) {
            int members[64], nmem = 0, saving, k;
            if (used[i]) continue;
            members[nmem++] = i;
            used[i] = 1;
            for (k = i + 1; k < ncand && nmem < 64; k++) {
                int j, same = 1;
                if (used[k] || cands[k].len != cands[i].len) continue;
                for (j = 0; j < cands[i].len; j++) {
                    if (!tm_same_inst(&m.f->code[cands[i].start + j],
                                      &m.f->code[cands[k].start + j])) {
                        same = 0;
                        break;
                    }
                }
                if (same) { members[nmem++] = k; used[k] = 1; }
            }
            if (nmem < 2) continue;
            saving = (nmem - 1) * (cands[i].len - 1);
            if (saving > best_saving) {
                best_saving = saving;
                best_group_start = i;
                best_ndrop = nmem - 1;
            }
        }
        if (best_group_start < 0) return;

        /* Re-collect the winning group: the members were consumed by `used`
         * above, so walk the candidates again with the same comparison. */
        {
            TmCand keep = cands[best_group_start];
            TmCand drops[64];
            int ndrop = 0;
            for (i = 0; i < ncand && ndrop < 64; i++) {
                int j, same = 1;
                if (i == best_group_start) continue;
                if (cands[i].len != keep.len) continue;
                for (j = 0; j < keep.len; j++) {
                    if (!tm_same_inst(&m.f->code[keep.start + j],
                                      &m.f->code[cands[i].start + j])) {
                        same = 0;
                        break;
                    }
                }
                if (same) drops[ndrop++] = cands[i];
            }
            if (ndrop != best_ndrop) return;   /* inconsistent: refuse to guess */
            tm_apply(f, &keep, drops, ndrop);
        }
    }
}

#endif /* ARKCC_FEATURE_TAILMERGE */

/* ------------------------------------------------------------------ */
/* Whole blocks (--xblock)                                            */
/* ------------------------------------------------------------------ */
#if ARKCC_FEATURE_XBLOCK

/* The whole-block form of the same idea: when two blocks are instruction-for-
 * instruction identical, one copy is enough and the other becomes a jump to it.
 * The matcher is the one above (tm_same_inst), the depth model is the same one,
 * only the candidate generator and the rewriter differ -- exactly the split the
 * roadmap describes (AC5 folds both forms into `zip`).
 *
 * Three extra conditions come from sharing a *whole* block instead of a tail:
 *
 * a) The evaluation stack must be empty on entry. A tail candidate always
 *    starts at a point where the stack is empty, but a block can be entered
 *    with values live; jumping to the shared copy would carry those values
 *    across a control-flow edge, which no backend promises.
 *
 * b) The body must contain no label. Every label is somebody's jump target;
 *    two copies of it would be two definitions of the same target, and the
 *    jumps would silently all land on whichever copy came first.
 *
 * c) The body must end with a one-successor control transfer: an unconditional
 *    jump or a return. This is what makes "identical body" *sufficient*. A
 *    block that falls through has its continuation fixed by its position in the
 *    instruction list, not by its contents, so two identical bodies sitting in
 *    two places leave by two different doors. A conditional branch is refused
 *    for exactly the same reason: its *taken* successor is named in the body,
 *    but its fall-through successor is whatever block happens to follow it.
 *    With an unconditional jump or a return there is only one successor and it
 *    is named inside the body, so identical bodies really do continue the same
 *    way.
 *
 * The jump target is compared as a *block*, not as a label id: irgen gives each
 * `if`/`else if` its own merge label, so two arms that fall into the same place
 * spell two different ids. Comparing the blocks they name is the same door with
 * a different name on it, and the drop site keeps its own label for everybody
 * else.
 *
 * IR_FUNC_BEGIN / IR_FUNC_END are refused as well: they only make sense once
 * per function, and refusing them also keeps the entry block out of the pool
 * without a special case. */

typedef struct XbCand {
    int block;
    int body;       /* first instruction after the block's leading labels */
    int len;        /* instructions in the body (leading labels excluded) */
} XbCand;

static int xb_body_of(const MirFunc *m, const TmDepth *d, int b, XbCand *out) {
    const MirBlock *B = &m->blk[b];
    int s = B->start;
    int i;
    int end_op;

    if (d->blk[b] != 0) return 0;
    while (s < B->end && tm_is_label(&m->f->code[s])) s++;
    if (s >= B->end) return 0;
    if (B->end - s < ark_xblock_min_len()) return 0;

    for (i = s; i < B->end; i++) {
        IrOp op = m->f->code[i].op;
        if (tm_is_label(&m->f->code[i])) return 0;
        if (op == IR_FUNC_BEGIN || op == IR_FUNC_END) return 0;
    }

    end_op = m->f->code[B->end - 1].op;
    if (end_op != IR_JMP && end_op != IR_JMP_NAMED && end_op != IR_RETURN)
        return 0;

    out->block = b;
    out->body = s;
    out->len = B->end - s;
    return 1;
}

/* Block a one-successor terminator goes to, or -1 when the label is not in this
 * function (a hand-edited or truncated IR, refused rather than guessed). */
static int xb_target_block(const MirFunc *m, const IrInst *J) {
    int i, n = m->f->code_count;
    int named = (J->op == IR_JMP_NAMED);
    for (i = 0; i < n; i++) {
        const IrInst *L = &m->f->code[i];
        if (named) {
            if (L->op == IR_LABEL_NAMED && L->name && J->name &&
                ark_streq(L->name, J->name))
                return m->inst_blk[i];
        } else if (L->op == IR_LABEL && L->val == J->val) {
            return m->inst_blk[i];
        }
    }
    return -1;
}

/* A label can open a block that holds nothing but labels and falls through to
 * the code below it -- irgen puts the two merge labels of an if / else-if chain
 * side by side. Jumping to either one lands in the same place, so the target is
 * resolved past such blocks before it is compared. */
static int xb_resolve_block(const MirFunc *m, int b) {
    int guard;
    for (guard = 0; guard <= m->blk_count; guard++) {
        const MirBlock *B;
        int s;
        if (b < 0 || b >= m->blk_count) return -1;
        B = &m->blk[b];
        s = B->start;
        while (s < B->end && tm_is_label(&m->f->code[s])) s++;
        if (s < B->end) return b;          /* real code: this is the target */
        if (B->succ_count != 1) return b;  /* nothing to follow: compare b    */
        b = B->succ[0];
    }
    return -1;                             /* a cycle of labels: refuse */
}

/* Do two candidate bodies compute the same thing and leave by the same door? */
static int xb_same_body(const MirFunc *m, const XbCand *a, const XbCand *b) {
    const IrInst *c = m->f->code;
    int j;

    if (a->len != b->len) return 0;
    for (j = 0; j + 1 < a->len; j++)
        if (!tm_same_inst(&c[a->body + j], &c[b->body + j])) return 0;
    {
        const IrInst *ea = &c[a->body + a->len - 1];
        const IrInst *eb = &c[b->body + b->len - 1];
        int ta, tb;
        if (ea->op != eb->op) return 0;
        if (ea->op == IR_RETURN) return 1;
        ta = xb_target_block(m, ea);
        tb = xb_target_block(m, eb);
        ta = ta >= 0 ? xb_resolve_block(m, ta) : -1;
        tb = tb >= 0 ? xb_resolve_block(m, tb) : -1;
        return ta >= 0 && ta == tb;
    }
}

/* Put a fresh label in front of the kept body and replace every dropped body
 * with one jump to it. The dropped blocks' *leading* labels stay where they
 * were -- they are other blocks' jump targets, and the jump itself is the only
 * thing that moves. */
static void xb_apply(IrFunc *f, const XbCand *keep, const XbCand *drop, int ndrop) {
    int new_label = f->label_count;
    int cap = f->code_count + 1;
    IrInst *nc = (IrInst *)mem_pool_alloc(cap * (int)sizeof(IrInst));
    int i, k, w = 0;

    for (i = 0; i < f->code_count; i++) {
        int dropped = 0;
        for (k = 0; k < ndrop; k++) {
            if (i == drop[k].body) {
                IrInst j;
                j.op = IR_JMP;
                j.val = new_label;
                j.name = 0;
                j.aux = 0;
                j.aux2 = 0;
                j.line = f->code[i].line;
                nc[w++] = j;
                i = drop[k].body + drop[k].len - 1;
                dropped = 1;
                break;
            }
        }
        if (dropped) continue;
        if (i == keep->body) {
            IrInst lbl;
            lbl.op = IR_LABEL;
            lbl.val = new_label;
            lbl.name = 0;
            lbl.aux = 0;
            lbl.aux2 = 0;
            lbl.line = f->code[i].line;
            nc[w++] = lbl;
        }
        nc[w++] = f->code[i];
    }

    f->code = nc;
    f->code_count = w;
    f->code_capacity = cap;
    f->label_count = new_label + 1;
}

void opt_xblock_func(IrFunc *f) {
    int guard;

    if (!f || f->code_count < ark_xblock_min_len()) return;
    if (f->is_naked || f->is_asm_func) return;

    /* Same shape as the tail pass: one merge per round, then the CFG is
     * rebuilt. Every round removes at least one instruction (a body of at
     * least ark_xblock_min_len() instructions becomes one jump), so the loop
     * terminates; the guard only keeps a bug from becoming a hang. */
    for (guard = 0; guard <= f->code_count; guard++) {
        MirFunc m;
        TmDepth d;
        XbCand *cands;
        unsigned char *used;
        int ncand = 0;
        int best = -1, best_saving = 0, best_ndrop = 0;
        int b, i;

        if (mir_build(f, &m) != 0) return;
        tm_analyse_depth(&m, &d);
        if (!d.ok) { tm_depth_free(&d); return; }

        cands = (XbCand *)mem_pool_alloc((m.blk_count + 1) * (int)sizeof(XbCand));
        used = (unsigned char *)mem_pool_alloc(m.blk_count + 1);
        for (b = 0; b < m.blk_count; b++) used[b] = 0;
        for (b = 0; b < m.blk_count; b++) {
            XbCand c;
            if (xb_body_of(&m, &d, b, &c)) cands[ncand++] = c;
        }

        /* Group identical bodies. Saving per member is len - 1 (the body is
         * replaced by one jump), so a group of k shares (k-1)*(len-1). Ties go
         * to the earliest group so the result does not depend on hash order. */
        for (i = 0; i < ncand; i++) {
            int members[64], nmem = 0, saving, k;
            if (used[i]) continue;
            members[nmem++] = i;
            used[i] = 1;
            for (k = i + 1; k < ncand && nmem < 64; k++) {
                if (used[k]) continue;
                if (xb_same_body(&m, &cands[i], &cands[k])) {
                    members[nmem++] = k;
                    used[k] = 1;
                }
            }
            if (nmem < 2) continue;
            saving = (nmem - 1) * (cands[i].len - 1);
            if (saving > best_saving) {
                best_saving = saving;
                best = i;
                best_ndrop = nmem - 1;
            }
        }
        if (best < 0) return;

        /* Re-collect the winning group: `used` consumed the members above, so
         * walk the candidates again with the same comparison. */
        {
            XbCand keep = cands[best];
            XbCand drops[64];
            int ndrop = 0;
            for (i = 0; i < ncand && ndrop < 64; i++) {
                if (i == best) continue;
                if (xb_same_body(&m, &keep, &cands[i])) drops[ndrop++] = cands[i];
            }
            if (ndrop != best_ndrop) return;   /* inconsistent: refuse to guess */
            xb_apply(f, &keep, drops, ndrop);
        }
    }
}

#endif /* ARKCC_FEATURE_XBLOCK */
#else  /* !ARKCC_FEATURE_TAILMERGE && !ARKCC_FEATURE_XBLOCK */

/* Nothing at all: the pipeline row is inert (built_in = 0) and the option is
 * refused in main.c, so a trimmed build never calls this symbol. */

#endif /* ARKCC_FEATURE_TAILMERGE */
