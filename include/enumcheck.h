/* Ark C Compiler - enumcheck.h
 * --warn-enum: a switch over an enum that does not name every enumerator.
 *
 * What it is
 * ----------
 *   enum Color { RED, GREEN, BLUE };
 *   switch (c) { case RED: ...; case BLUE: ...; }     -> warning, GREEN missing
 *
 * Only that shape. The check is a set comparison, not data-flow analysis: it
 * fires when
 *   - the controlling expression has enum type (a plain `int` switched over
 *     enum constants is not checked -- the type is what says "this value comes
 *     from that set"),
 *   - the enum definition is reachable (it was defined in this translation unit;
 *     a tag that only appears in a declaration has no enumerator list),
 *   - the switch has no `default:` label (C99 6.5.2: `default` is exactly the
 *     "everything else" that an exhaustive match would spell out),
 *   - and the enumerator set is small enough to compare exhaustively
 *     (EC_MAX_ENUM / EC_MAX_CASES in enumcheck.c). A set too large to hold is
 *     skipped, never reported partially: a truncated comparison could claim a
 *     value is missing when it is only beyond the table.
 *
 * Values, not names, decide coverage: `case RED:` and `case 0:` cover the same
 * enumerator, and two enumerators with the same value are covered together --
 * which matches the runtime select.
 *
 * Why it can be trimmed
 * ---------------------
 * Whole pass behind ARKCC_FEATURE_ENUMCHECK (see arkcc_config.h) and the
 * runtime switch --warn-enum. Either one off means no code, no behaviour
 * change. No allocation, no table: two small arrays on the stack per switch.
 *
 * Honest boundary: this is a lint, not a guarantee that the switch handles
 * every *value*. An enum-typed variable can legally hold a value no enumerator
 * names (an `int` converted to the enum type), and the check says nothing about
 * that; it only says the source forgot a name it itself declared.
 */
#ifndef ARK_ENUMCHECK_H
#define ARK_ENUMCHECK_H

#include "ast.h"

/* Run the check over a parsed program. Returns the number of warnings emitted
 * (0 when clean). The pass never modifies the tree. */
int enumcheck_run(AstNode *prog);

#endif /* ARK_ENUMCHECK_H */
