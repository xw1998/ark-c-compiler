/* Ark C Compiler - opt.h
 * IR-level optimization passes: constant folding, dead code elimination.
 *
 * Runs after irgen and before backend code generation.
 * Guards:
 *   - Compile-time: #if ARKCC_FEATURE_OPT_CONSTFOLD / ARKCC_FEATURE_OPT_DCE
 *   - Runtime: g_config.enable_opt_constfold / g_config.enable_opt_dce / opt_level
 */
#ifndef ARK_OPT_H
#define ARK_OPT_H

#include "ir.h"

/* Where the passes are scheduled.  Since 0.8.5 the "does this pass run at
 * this -O level under this profile" decision lives in one table in
 * src/pipeline.c; this header only declares the passes themselves.  Call
 * pipeline_run_ir() (include/pipeline.h), not a list of opt_* in sequence. */

/* Per-function constant folding: folds PUSH_INT + PUSH_INT + BINARY patterns. */
void opt_constfold_func(IrFunc *f);

/* Per-function dead code elimination: removes unreachable instructions
 * after RETURN/JMP up to the next label. */
void opt_dce_func(IrFunc *f);
/* 基本块级可达性 DCE（--dce-cfg）。语义与 opt_dce_func 相同：只删不可达指令。 */
void opt_dce_cfg_func(IrFunc *f);

/* Auto inlining: inlines small function bodies into call sites.
 * Threshold: IR instruction count <= ARK_INLINE_THRESHOLD (default 12).
 * Excludes: recursion, variadic, irq, naked, asm_func, >4 params. */
void opt_inline(IrProgram *prog);

/* Loop-invariant code motion (--licm). See src/opt_loop.c for the exact
 * whitelist and the invariance rules; anything not proved safe is left alone. */
void opt_licm_func(IrFunc *f);

/* Complete unrolling of a counted `for` loop (--unroll). Only the canonical
 * `for (i = c; i < N; i++)` shape with constant c/N and a straight-line body
 * is transformed; every other loop is left as it was. */
void opt_unroll_func(IrFunc *f);

/* Auto vectorization: recognizes simple counted loops (a[i]=b[i] +/- c[i])
 * and parallelizes them with SIMD instructions.
 * Only truly accelerates on the ARM backend; C backend falls back to scalar. */
void opt_vectorize(IrProgram *prog);
/* Whole-program constant propagation (--const-global): replaces a load of a
 * `const` object that is provably never written and whose address is never
 * taken with the immediate its initialiser spells out, then re-runs constant
 * folding so the newly visible constant cascades.  Returns the number of loads
 * replaced (0 when nothing was proved). See the comment on the definition in
 * src/opt.c for what each precondition rules out. */
#if ARKCC_FEATURE_CONST_GLOBAL
int  opt_const_global(IrProgram *prog);
#endif

#endif /* ARK_OPT_H */
