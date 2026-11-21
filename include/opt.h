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
 * Threshold: IR instruction count <= ark_inline_threshold() (12 at the default
 * --size-weight=5).
 * Excludes: recursion, variadic, irq, naked, asm_func, >4 params. */
void opt_inline(IrProgram *prog);

/* Loop-invariant code motion (--licm). See src/opt_loop.c for the exact
 * whitelist and the invariance rules; anything not proved safe is left alone. */
void opt_licm_func(IrFunc *f);

/* Complete unrolling of a counted `for` loop (--unroll). Only the canonical
 * `for (i = c; i < N; i++)` shape with constant c/N and a straight-line body
 * is transformed; every other loop is left as it was. */
void opt_unroll_func(IrFunc *f);

/* Block-tail merging (--tailmerge): when several blocks end with the same
 * instruction sequence, keep one copy and rewrite the others as a jump to a
 * fresh label in front of the survivor (block-level cross-jump). Only tails
 * whose evaluation-stack depth is 0 are considered; if the depth model cannot
 * be established for the whole function it is left completely alone. */
void opt_tailmerge_func(IrFunc *f);

/* Whole-block merging (--xblock): the same matcher one level up. Two blocks that
 * are instruction-for-instruction identical leave one copy and turn the other
 * into a jump to a fresh label in front of the survivor. Extra conditions: the
 * evaluation-stack depth on entry must be 0, the body may hold no label, and it
 * must end with an explicit control transfer (a fall-through successor is fixed
 * by layout, not by the body, so identical bodies could otherwise leave by
 * different doors). */
void opt_xblock_func(IrFunc *f);

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

/* Strength reduction (-fopt-strength): `x * 2^k` becomes `x << k`.  The
 * constant must sit immediately in front of the multiply, which is exactly the
 * shape irgen produces for `x * 4`, for the stride scaling in a subscript and
 * for the sizeof(*p) scaling of pointer arithmetic; `x * 1` drops both
 * instructions.  Everything else -- 0, negative factors, non-powers of two --
 * is left as it was, because on this target a multiply is cheaper than the
 * shift/add chain that would replace it. */
void opt_strength_func(IrFunc *f);

#endif /* ARK_OPT_H */
