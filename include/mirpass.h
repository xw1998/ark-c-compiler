/* Ark C Compiler - mirpass.h
 * ---------------------------------------------------------------------
 * The three checks that read the MIR graphs (see include/mir.h).
 *
 * They are the first passes that ask a question about control flow as a
 * graph instead of about one instruction at a time:
 *
 *   --warn-unreachable    Basic blocks with no path from the function entry.
 *   --warn-unused-static  A static function nothing in the unit can reach.
 *   --warn-recursion      A call cycle among the unit's own functions.
 *
 * Common rules, and why each one is there
 * ---------------------------------------
 * 1. Warnings only. None of these can change the image, so enabling all three
 *    at once must produce the same object file as enabling none. The gate
 *    compares the two images byte for byte.
 * 2. Every check runs on the IR as irgen produced it, before any optimisation,
 *    so the report describes the program the user wrote and does not depend on
 *    -O. That is why they sit at the top of the IR stage table.
 * 3. A check that cannot be trusted is skipped, not guessed:
 *      - an inline asm body is an opaque string, so a symbol it names is
 *        invisible to the graphs; when one exists the unused-static check
 *        stays silent for the whole unit;
 *      - a call through a function pointer contributes no call-graph edge,
 *        so it can hide a cycle or a caller. It never *creates* one, so
 *        --warn-recursion and --warn-unused-static can only under-report in
 *        that case, never over-report. Under-reporting is documented in
 *        docs/MIR_CFG.md; inventing an edge would be a wrong answer.
 * 4. The counts are reported honestly. --warn-unreachable says how many
 *    instructions are dead, not just "there is dead code", because the number
 *    is what tells a reader whether the compiler is pointing at a stray
 *    label or at a forgotten early return.
 *
 * Trimming: ARKCC_FEATURE_MIR (see include/arkcc_config.h). All three share
 * one switch because they share src/mir.c; splitting the switch would let a
 * build carry the graph builder for a check it cannot run.
 * ---------------------------------------------------------------------
 */
#ifndef ARK_MIRPASS_H
#define ARK_MIRPASS_H

#include "ir.h"

/* Per-function check: report every maximal run of basic blocks that no path
 * from the entry reaches. Blocks that carry no real instruction (a label
 * alone, IR_FUNC_BEGIN/END, a NOP) are not part of the run and are never
 * reported -- a trailing "L_end: FUNC_END" is a layout artefact, not dead
 * code, and saying otherwise would make the check unusable. */
void mirpass_unreachable(IrFunc *f);

/* Whole-program check: a static function that is not the target of any call
 * edge, whose address is never taken, and that carries none of the attributes
 * that keep a symbol alive (used / constructor / destructor / weak). */
void mirpass_unused_static(IrProgram *prog);

/* Whole-program check: report each strongly connected component of the call
 * graph that is a cycle (more than one function, or a function that calls
 * itself). Reported once per cycle, at its lowest-numbered function. */
void mirpass_recursion(IrProgram *prog);

#endif /* ARK_MIRPASS_H */
