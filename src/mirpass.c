/* Ark C Compiler - mirpass.c
 * The three MIR checks. See include/mirpass.h for the rules they follow.
 *
 * Nothing here modifies the IR: the graphs are read, warnings are printed,
 * and the function returns. That is what makes "enabling every check produces
 * the same object file" a fact rather than a hope, and the gate asserts it by
 * comparing images byte for byte.
 */
#include "mirpass.h"
#include "mir.h"
#include "memory.h"
#include "diag.h"
#include "common.h"
#include "arkcc_config.h"

#if ARKCC_FEATURE_MIR

/* An instruction that is real code. Labels, the function markers and the NOP
 * placeholders carry no work, so a block made only of them is a layout
 * artefact and never worth reporting. */
static int mp_is_real_inst(const IrInst *I) {
    switch (I->op) {
    case IR_LABEL:
    case IR_LABEL_NAMED:
    case IR_FUNC_BEGIN:
    case IR_FUNC_END:
    case IR_NOP:
        return 0;
    default:
        return 1;
    }
}

/* A block that cannot do anything: pushing constants, jumping and returning
 * have no effect a reader can observe.  The IR emitter writes such blocks
 * itself in every function -- the `JMP end_label` after an `if` arm that
 * already returned, and the implicit trailing `return 0` -- so a dead run made
 * only of them is a layout artefact and not something the user wrote.  Only
 * real work (a store, a call, a branch, a memory read) is reported.
 *
 * The price is stated in docs/MIR_CFG.md: a stray `return 2;` after a
 * `return 1;` is not reported, because it is the same shape as the epilogue
 * every function carries.  Not reporting is a miss; reporting the epilogue in
 * every function of every program would make the check useless. */
static int mp_block_is_phantom(const IrFunc *f, const MirBlock *B) {
    int i;
    for (i = B->start; i < B->end; i++) {
        switch (f->code[i].op) {
        case IR_NOP:
        case IR_LABEL:
        case IR_LABEL_NAMED:
        case IR_FUNC_BEGIN:
        case IR_FUNC_END:
        case IR_PUSH_INT:
        case IR_PUSH_FLOAT:
        case IR_64PUSH:
        case IR_PUSH_STR:
        case IR_PUSH_FUNC:
        case IR_JMP:
        case IR_JMP_NAMED:
        case IR_RETURN:
            break;
        default:
            return 0;
        }
    }
    return 1;
}

static void mp_warn2(int line, const char *msg, const char *a0, const char *a1) {
    DiagLoc loc;
    loc.file = 0;                 /* 0 = the translation unit's main file */
    loc.line = line;
    loc.col  = 0;
    diag_report_msg(DIAG_SEV_WARNING, &loc, msg, a0, a1, 0);
}

static void mp_warn1(int line, const char *msg, const char *a0) {
    mp_warn2(line, msg, a0, 0);
}

/* Source line of a function. IR_FUNC_BEGIN/IR_GETARG carry line 0 (they are
 * frame set-up, not source), so the first instruction that came from a real
 * token is the one that names the function's line. 0 keeps the "At end of
 * source" fallback rather than inventing a position. */
static int mp_func_line(const IrFunc *f) {
    int i;
    if (!f) return 0;
    for (i = 0; i < f->code_count; i++) {
        /* Frame set-up is not source: IR_FUNC_BEGIN / IR_GETARG /
         * IR_LOCAL_ALLOC carry whatever line the previous statement left in
         * g_ir_cur_line, which is how a one-line function used to be
         * reported at the line of the function before it. */
        if (f->code[i].op == IR_FUNC_BEGIN || f->code[i].op == IR_GETARG ||
            f->code[i].op == IR_LOCAL_ALLOC || f->code[i].op == IR_NOP)
            continue;
        if (f->code[i].line > 0) return f->code[i].line;
    }
    return 0;
}

/* ---------------------------------------------------------------- */
/* --warn-unreachable                                                */
/* ---------------------------------------------------------------- */

void mirpass_unreachable(IrFunc *f) {
    MirFunc m;
    unsigned char *reach;
    int b;

    if (!f) return;
    if (mir_build(f, &m) != 0) return;
    reach = (unsigned char *)mem_pool_alloc(m.blk_count);
    mir_reachable(&m, reach);

    b = 0;
    while (b < m.blk_count) {
        int e, i, dead = 0;
        if (reach[b]) { b++; continue; }

        /* Maximal run of unreachable blocks, counted in real instructions. */
        e = b;
        while (e < m.blk_count && !reach[e]) e++;
        for (i = b; i < e; i++) {
            int k;
            if (mp_block_is_phantom(f, &m.blk[i])) continue;
            for (k = m.blk[i].start; k < m.blk[i].end; k++)
                if (mp_is_real_inst(&f->code[k])) dead++;
        }
        if (dead > 0) {
            char nb[12];
            mp_warn2(f->code[m.blk[b].start].line,
                    "%s instruction(s) in '%s' can never run: no path from the "
                    "function entry reaches them",
                    diag_num(nb, dead), f->name ? f->name : "?");
        }
        b = e;
    }
}

/* ---------------------------------------------------------------- */
/* --warn-unused-static                                             */
/* ---------------------------------------------------------------- */

void mirpass_unused_static(IrProgram *prog) {
    MirCallGraph g;
    int *incoming;
    int i, k;

    if (!prog || prog->func_count <= 0) return;
    if (mir_callgraph_build(prog, &g) != 0) return;

    /* An inline asm body names symbols in a string this graph cannot read, so
     * any function could be its target. Staying silent for the whole unit is
     * the only answer that is not a guess. */
    if (g.saw_inline_asm) return;

    incoming = (int *)mem_pool_alloc(g.n * (int)sizeof(int));
    for (i = 0; i < g.n; i++) incoming[i] = 0;
    for (i = 0; i < g.n; i++) {
        for (k = g.callee_start[i]; k < g.callee_start[i + 1]; k++)
            incoming[g.callee_list[k]]++;
    }

    for (i = 0; i < g.n; i++) {
        IrFunc *F = prog->funcs[i];
        int line = 0;
        if (!F->is_static) continue;
        /* `used` keeps a symbol alive for the linker; `unused` is the author
         * saying "this one is deliberately unused", so neither is reported. */
        if (F->is_used || F->is_unused) continue;
        if (F->is_constructor || F->is_destructor) continue;
        if (F->is_weak) continue;
        if (F->is_asm_func) continue;
        /* GCC's -Wunused-function deliberately stays silent for unused static
         * inline helpers: they are meant to be dead code in translation units
         * that do not exercise every branch (e.g. <stdarg.h>'s _Generic
         * helpers).  Match that rule so the check does not fire on standard
         * headers.  __forceinline is armcc's `inline + always_inline`, so it
         * counts as inline here too -- the author asked for it to be folded
         * away, not called. */
        if (F->is_inline || F->forceinline) continue;
        if (g.addr_taken[i]) continue;
        if (incoming[i] > 0) continue;
        line = mp_func_line(F);
        mp_warn1(line, "static function '%s' is defined but never used",
                 F->name ? F->name : "?");
    }
}

/* ---------------------------------------------------------------- */
/* --warn-recursion                                                 */
/* ---------------------------------------------------------------- */

void mirpass_recursion(IrProgram *prog) {
    MirCallGraph g;
    int *scc_of, *size, *first;
    unsigned char *self_loop;
    int ncomp, i, k;

    if (!prog || prog->func_count <= 0) return;
    if (mir_callgraph_build(prog, &g) != 0) return;

    scc_of = (int *)mem_pool_alloc(g.n * (int)sizeof(int));
    ncomp = mir_scc(&g, scc_of);
    if (ncomp <= 0) return;

    size  = (int *)mem_pool_alloc(ncomp * (int)sizeof(int));
    first = (int *)mem_pool_alloc(ncomp * (int)sizeof(int));
    self_loop = (unsigned char *)mem_pool_alloc(ncomp);
    for (i = 0; i < ncomp; i++) { size[i] = 0; first[i] = -1; self_loop[i] = 0; }
    for (i = 0; i < g.n; i++) {
        size[scc_of[i]]++;
        if (first[scc_of[i]] < 0) first[scc_of[i]] = i;
    }
    for (i = 0; i < g.n; i++) {
        for (k = g.callee_start[i]; k < g.callee_start[i + 1]; k++)
            if (g.callee_list[k] == i) self_loop[scc_of[i]] = 1;
    }

    /* Report at the lowest-numbered member of each cycle, once. */
    for (i = 0; i < g.n; i++) {
        int c = scc_of[i];
        int total = size[c];
        char nb[12];
        if (c < 0) continue;
        if (total == 1 && !self_loop[c]) continue;
        if (i != first[c]) continue;
        {
            IrFunc *F = prog->funcs[i];
            int line = mp_func_line(F);
            if (total == 1)
                mp_warn1(line, "function '%s' calls itself: its stack use is "
                              "decided by the input and not by the source",
                         F->name ? F->name : "?");
            else
                mp_warn2(line,
                         "function '%s' is in a call cycle with %s other "
                         "function(s): the stack use is decided by the input, "
                         "not by the source",
                         F->name ? F->name : "?",
                         diag_num(nb, total - 1));
        }
    }
}

#endif /* ARKCC_FEATURE_MIR */
