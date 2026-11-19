/* Ark C Compiler - memlint.h
 * --warn-mem: an intra-procedural memory lint that runs on the AST after sema.
 *
 * What it is
 * ----------
 * Two checks, both deliberately narrower than "memory safety":
 *
 *   1. returning the address of an automatic object
 *        return &local;  return local_array;  return &local.field;
 *      Reported from the syntax alone: no path analysis, no aliasing. The only
 *      thing it can get wrong is to warn about a caller that never dereferences
 *      the result -- which is still a defect worth a warning, so the message
 *      says "address of an automatic object", not "will crash".
 *
 *   2. double free / use-after-free inside one function
 *        p = malloc(n); free(p); free(p);      -> double free
 *        p = malloc(n); free(p); p[0] = 1;     -> use after free
 *      Reported only for a pointer that
 *        - received malloc/calloc/realloc/strdup directly,
 *        - never escaped (never passed to another call, never stored into
 *          another object, never had its address taken, never did arithmetic),
 *        - and is certainly dead on every path that reaches the use (a branch
 *          or loop that frees it on one side only makes the state "unknown",
 *          which silences the report).
 *      Anything outside that shape -- realloc revival, free(p + 4), ownership
 *      handed to/from a callee, setjmp/longjmp, inline asm, goto/labels -- is
 *      NOT reported. Missing a defect is the accepted failure mode; guessing is
 *      not.
 *
 * Why it can be trimmed
 * ---------------------
 * The whole pass lives behind ARKCC_FEATURE_MEMLINT (see arkcc_config.h) and
 * the runtime switch --warn-mem. With either of them off, none of this code is
 * compiled/linked and no behaviour changes. There is no dynamic allocation and
 * no table: one fixed-size frame (8 tracked pointers, 32 local names) on the
 * stack, so it fits the STM32 profile -- it is off there by default only because
 * code size is the scarce resource, not because it needs RAM.
 *
 * Honest boundary: passing this lint says nothing about memory safety. In C the
 * fact "this pointer owns that block" is not in the type system, so no analysis
 * can turn these checks into a guarantee; Rust can, because it changed the
 * language first. See docs/MEMLINT.md.
 */
#ifndef ARK_MEMLINT_H
#define ARK_MEMLINT_H

#include "ast.h"

/* Run both checks over a parsed program. Returns the number of warnings
 * emitted (0 when clean). The pass never modifies the tree. */
int memlint_run(AstNode *prog);

#endif /* ARK_MEMLINT_H */
