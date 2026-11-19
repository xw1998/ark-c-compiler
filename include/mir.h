/* Ark C Compiler - mir.h
 * ---------------------------------------------------------------------
 * MIR: the two graphs the IR has always implied but never exposed.
 *
 * Why this module exists
 * ----------------------
 * Before 0.8.6 every analysis that needed control flow rebuilt it inline.
 * `opt_dce_cfg_func` walks instruction-to-instruction, decides "am I still
 * reachable?" with a local flag, and re-scans the whole function to resolve
 * every jump target (`cfg_label_index` is O(n) per jump).  That works for one
 * pass; it does not scale to the questions that come next -- "is this block
 * dominated by that one", "which functions can reach this one", "is there a
 * call cycle".  Each of those would add another bespoke scan.
 *
 * So the two graphs are built once, here, as data:
 *
 *   MirFunc       intra-function: basic blocks + successor/predecessor edges.
 *   MirCallGraph  inter-function: nodes are IrFuncs, edges are IR_CALL.
 *
 * Invariants that make the rest of the code simple
 * ------------------------------------------------
 *   - Blocks are laid out in instruction order, so a "fall through" edge is
 *     always "the next block".  That means the block of an instruction is a
 *     monotone step, and reporting warnings in block order reports them in
 *     source order.
 *   - A block has at most MIR_MAX_SUCC (2) successors: a conditional branch.
 *     `switch` is a chain of IR_CMP_JMP_EQ, each of which is a conditional
 *     branch, so a switch body is a chain of two-way blocks and not an
 *     n-way terminator.
 *   - A terminator is always the LAST instruction of its block, because the
 *     leader rule makes the instruction after any terminator a new block.
 *
 * What is deliberately absent
 * ---------------------------
 * No dominator tree, no SSA, no loop detection -- nothing is added before the
 * pass that needs it exists.  A graph whose edges are wrong is worse than no
 * graph at all, so the builder also has a `mir_verify` used by the gate: it
 * re-checks the invariants above on every function of a program and returns
 * the number of violations (0 = the graph agrees with the instruction list).
 *
 * Storage
 * -------
 * Everything is allocated from the per-translation-unit arena
 * (mem_pool_alloc); there is nothing to free and no lifetime to get wrong.
 * Building a graph per function per pass is therefore cheap in the only sense
 * that matters here: no allocation failure path, no leak.
 * ---------------------------------------------------------------------
 */
#ifndef ARK_MIR_H
#define ARK_MIR_H

#include "ir.h"

/* A block ends at a terminator or at the instruction before a leader, so no
 * block has more than two successors (fall through + branch target). */
#define MIR_MAX_SUCC 2

typedef struct MirBlock {
    int start;                    /* first instruction index, inclusive   */
    int end;                      /* one past the last instruction        */
    int succ[MIR_MAX_SUCC];       /* successor block ids, -1 = absent     */
    int succ_count;
    int pred_start;               /* slice of MirFunc.pred_list           */
    int pred_count;
} MirBlock;

typedef struct MirFunc {
    IrFunc   *f;
    MirBlock *blk;
    int       blk_count;
    int      *inst_blk;           /* f->code_count entries: inst -> block */
    int      *pred_list;          /* flattened predecessor lists          */
} MirFunc;

/* Build the CFG of one function. `out` is filled in; returns 0 on success and
 * -1 when the function has no instructions (nothing to say about it).
 * The function's instruction list is not modified. */
int  mir_build(const IrFunc *f, MirFunc *out);

/* Block containing instruction `index`; -1 when out of range. */
int  mir_inst_block(const MirFunc *m, int index);

/* Mark reachable blocks from the entry block (block 0). `reach` must hold
 * blk_count bytes; it is cleared first. Returns the number of reachable
 * blocks, so the caller can compare against blk_count. */
int  mir_reachable(const MirFunc *m, unsigned char *reach);

/* Re-check the invariants documented in the header: blocks are contiguous and
 * in order, every terminator is the last instruction of its block, every edge
 * points at an existing block, and the predecessor lists agree with the
 * successor edges. Returns the number of violations (0 = consistent).
 * Exists for the gate: a graph builder that silently drops an edge would
 * otherwise be indistinguishable from a correct one. */
int  mir_verify(const MirFunc *m);

/* ---------------------------------------------------------------- */
/* Inter-function: the call graph                                    */
/* ---------------------------------------------------------------- */

typedef struct MirCallGraph {
    int  n;                        /* nodes = IrProgram.func_count        */
    int *callee_start;             /* n+1 entries: slice into callee_list */
    int *callee_list;              /* deduplicated callee node ids        */
    unsigned char *addr_taken;     /* the function's address escapes      */
    int  unresolved_calls;         /* IR_CALL through a pointer (no edge) */
    int  saw_inline_asm;           /* any IR_ASM / __asm body in the unit */
} MirCallGraph;

/* Build the call graph of a whole program.
 *
 * Edges come from IR_CALL with a resolvable callee name. A call through a
 * function pointer has no name, so it produces no edge and increments
 * `unresolved_calls` instead of being guessed: a guessed edge would make a
 * "never called" report wrong, and a wrong report is worse than a missing one.
 *
 * `addr_taken` is set for a function whose address appears anywhere -- as
 * IR_PUSH_FUNC, as a global initialiser (IrGlobal.init_sym with
 * init_sym_is_func, and every IrSymRef of an aggregate initialiser, where the
 * IR does not record whether the symbol is code or data), or as a
 * `__attribute__((alias("...")))` target. Each of those is a place the
 * address can leave the translation unit, so "nobody calls it" stops meaning
 * "nobody can reach it".
 *
 * `saw_inline_asm` is a whole-program flag, not per function: an inline asm
 * body is an opaque string, so a symbol it names is invisible to this graph
 * and any function in the unit could be its target.
 *
 * Returns 0 on success, -1 when the program has no functions. */
int  mir_callgraph_build(const IrProgram *prog, MirCallGraph *out);

/* Tarjan's strongly connected components over the call graph. `scc_of` must
 * hold n ints; returns the number of components. Components are numbered in
 * the order they are closed (reverse topological order), which is all a
 * "is this a cycle?" question needs. */
int  mir_scc(const MirCallGraph *g, int *scc_of);

/* ---------------------------------------------------------------- */
/* Natural loops of one function                                     */
/* ---------------------------------------------------------------- */

/* A natural loop: a back edge u -> h where h dominates u, plus every block
 * that can reach u without going through h. The header is included.
 *
 * `preheader` is the block that runs exactly once before the loop: the only
 * predecessor of the header from outside the loop, and it has exactly one
 * successor (the header). -1 means the loop has no such block (several
 * entries, or a conditional entry), which is what the loop passes must refuse
 * to transform rather than guess about. */
typedef struct MirLoop {
    int            header;
    int            preheader;
    int            nblocks;   /* blocks in the loop, header included */
    unsigned char *in_loop;   /* MirFunc.blk_count bytes; 1 = in the loop */
} MirLoop;

/* Collect the natural loops of one function into `out` (at most `max`).
 * Returns the number of loops found; when there are more than `max`, only the
 * first `max` are filled and the count is still the true one. Nested loops are
 * reported separately (inner and outer are two entries); two back edges to the
 * same header are reported once, under the first one. */
int  mir_loops(const MirFunc *m, MirLoop *out, int max);

/* Does block `a` dominate block `b`? (Every path from the entry to `b` passes
 * through `a`.) An out-of-range or unreachable block answers 0 rather than
 * being guessed at: a loop pass that treats "unknown" as "dominates" would
 * hoist past an entry edge. */
int  mir_dominates(const MirFunc *m, int a, int b);


#endif /* ARK_MIR_H */
