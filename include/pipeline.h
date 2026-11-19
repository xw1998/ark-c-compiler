/* Ark C Compiler - pipeline.h
 * ---------------------------------------------------------------------
 * One table that says which stages run, in what order, and why.
 *
 * Why this module exists
 * ----------------------
 * Before 0.8.5 the decision "does pass X run?" was spread over opt_run()'s
 * #if / if-ladders plus each call site in compiler.c.  Every new pass added
 * another condition in another place, and a pass that was silently trimmed
 * (or silently gated off by a level) looked exactly like a pass that ran.
 * Here the stages are declared once, as data, and one loop executes them.
 *
 * Two profiles, not two code bases
 * --------------------------------
 * The same compiled binary serves both shapes the project ships:
 *   ARK_PROFILE_FULL  every stage follows its own level/flag gate (the
 *                     historical behaviour; this is the default).
 *   ARK_PROFILE_LITE  only stages marked "lite" may run; the expensive ones
 *                     are skipped with a recorded reason.  This is the MCU
 *                     shape: same source, same binary layout rules, less
 *                     work per translation unit.
 * A stage's *own* gate (compile-time feature, -O level, --flag) still
 * applies under FULL, so --pipeline=full is byte-identical to no option.
 *
 * There is no third "none" profile on purpose: turning everything off is
 * spelled -O0 with no lint flags, and inventing a second spelling would
 * give two ways to produce the same image.
 *
 * Reading the decision
 * --------------------
 * `--print-pipeline` prints the resolved table (host builds only, gated by
 * ARKCC_FEATURE_PIPELINE_DUMP so the board carries no strings).  The rule
 * the project keeps repeating applies here too: a pass that was skipped
 * must say so, because "no output" is not a measurement.
 * ---------------------------------------------------------------------
 */
#ifndef ARK_PIPELINE_H
#define ARK_PIPELINE_H

#include "ast.h"
#include "ir.h"

/* Profile ids. A stage with min_profile = LITE runs under both profiles;
 * one with min_profile = FULL runs only under FULL. */
#define ARK_PROFILE_LITE   1
#define ARK_PROFILE_FULL   2

/* "lite" / "full" -> id, or -1 when the text is not a profile name.
 * Never returns a default: an unknown spelling is the caller's error to
 * report, not something to paper over with "full". */
int         pipeline_profile_parse(const char *s);

/* "lite" / "full" for printing. Returns "?" for an out-of-range id. */
const char *pipeline_profile_name(int profile);

/* The profile g_config asked for. Resolved once per run. */
int         pipeline_profile(void);

/* AST stage: the lint passes. Runs before irgen, in table order. */
void pipeline_run_ast(AstNode *prog);

/* IR stage: the optimization passes. Runs after irgen, before the backend.
 * `level` is the effective -O level (command line vs config, already
 * reconciled); `profile` is pipeline_profile(). */
void pipeline_run_ir(IrProgram *prog, int level, int profile);

/* Print the resolved table: every stage, run or skipped, with the reason.
 * Compiled to nothing when ARKCC_FEATURE_PIPELINE_DUMP is 0. */
void pipeline_dump(int level, int profile);

#endif /* ARK_PIPELINE_H */
