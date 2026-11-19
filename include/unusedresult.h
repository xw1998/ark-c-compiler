/* Ark C Compiler - unusedresult.h
 * --warn-unused-result: a discarded return value of a function the program
 * itself declared `__attribute__((warn_unused_result))` (or `__must_check`,
 * which is the kernel's spelling of the same attribute).
 *
 * What it is
 * ----------
 * One check, deliberately syntactic:
 *
 *   int f(void) __attribute__((warn_unused_result));
 *   void g(void) { f(); }        -> warning: the value f() produced is gone
 *   void g(void) { (void)f(); }  -> silent: the discard is explicit
 *   int  h(void) { return f(); } -> silent: the value is used
 *
 * Only a *statement* whose whole expression is a call to an annotated
 * function is reported. A call buried anywhere inside a larger expression is
 * "used" as far as this pass can see, and a call through a function pointer
 * has no declaration to read the attribute from -- both stay silent. Missing a
 * defect is the accepted failure mode; guessing is not.
 *
 * The pass is a lint, not an optimisation: it runs on the AST after sema, has
 * no -O gate, and never modifies the tree.
 *
 * Why it exists
 * -------------
 * The parser has always accepted `warn_unused_result` and then thrown it away
 * (it sat in the "silently ignored attributes" list). Silently ignoring an
 * attribute that exists to catch a defect is worse than not supporting it: the
 * declaration reads as if the check were active. This pass makes the attribute
 * mean what it says, under a switch that defaults to off so the shipped
 * behaviour is unchanged.
 *
 * Trimming
 * --------
 * The whole pass lives behind ARKCC_FEATURE_UNUSEDRESULT (see
 * arkcc_config.h) and the runtime switch --warn-unused-result. With either off
 * nothing is compiled/linked and no behaviour changes. No heap, one fixed
 * table (256 annotated functions) on the stack; if a translation unit declares
 * more annotated functions than that, the pass reports that it could not check
 * completely instead of quietly checking only the first 256.
 */
#ifndef ARK_UNUSEDRESULT_H
#define ARK_UNUSEDRESULT_H

#include "ast.h"

/* Run the check over a parsed program. Returns the number of warnings emitted
 * (0 when clean). The pass never modifies the tree. */
int unusedresult_run(AstNode *prog);

#endif /* ARK_UNUSEDRESULT_H */
