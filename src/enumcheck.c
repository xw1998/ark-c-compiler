/* Ark C Compiler - enumcheck.c
 * --warn-enum: exhaustiveness check for `switch` over an enum.
 * See enumcheck.h for the exact scope and the trimming story.
 *
 * Shape of the implementation
 * ---------------------------
 * Two walks and a set comparison:
 *   1. ec_stmt() finds every AST_SWITCH in the program (it descends into case
 *      bodies, so a switch inside a case is checked on its own -- its labels
 *      are NOT the outer switch's labels).
 *   2. ec_collect() walks the switch body, stops at a nested switch (same
 *      reason), and records the value of every case label plus whether a
 *      `default:` exists.
 *   3. Every enumerator value of the definition is looked up in that list.
 *
 * The case values are already folded: the parser stores an integer constant
 * expression's value in u.case_stmt.value (C99 6.10p1 -- `case 1+2:` and
 * `case (int)TOK_PLUS:` both arrive as numbers). So this pass needs no
 * evaluator of its own and cannot disagree with the code generator about what
 * a label means.
 */
#include "enumcheck.h"

#if ARKCC_FEATURE_ENUMCHECK

#include "config.h"
#include "diag.h"
#include "type.h"

/* Capacity is part of the trim story (stack, not heap) and part of the
 * correctness story (a truncated set must never be reported). 64 is far above
 * what hand-written firmware enums use and keeps the frame under 1 KB. */
#define EC_MAX_ENUM  64
#define EC_MAX_CASES 64

typedef struct {
    long long vals[EC_MAX_CASES];
    int       n;
    int       overflow;     /* more labels than the table holds -> give up */
    int       has_default;
} EcCases;

typedef struct {
    char buf[128];
    int  len;
    int  count;             /* names written */
} EcNames;

static void ec_names_add(EcNames *nm, const char *name)
{
    int i;
    if (!name) return;
    if (nm->count >= 4) {   /* four is enough to make the defect obvious */
        const char *dots = ", ...";
        for (i = 0; dots[i] && nm->len < (int)sizeof(nm->buf) - 1; i++)
            nm->buf[nm->len++] = dots[i];
        nm->buf[nm->len] = 0;
        nm->count++;
        return;
    }
    if (nm->count > 0) {
        nm->buf[nm->len++] = ',';
        nm->buf[nm->len++] = ' ';
    }
    for (i = 0; name[i] && nm->len < (int)sizeof(nm->buf) - 1; i++)
        nm->buf[nm->len++] = name[i];
    nm->buf[nm->len] = 0;
    nm->count++;
}

/* Record the labels that belong to this switch. A nested AST_SWITCH owns its
 * own labels, so it is not entered: its `case` nodes would otherwise be counted
 * as coverage of the outer set, which would hide exactly the defect this pass
 * exists to find. */
static void ec_collect(AstNode *s, EcCases *c)
{
    int i;

    if (!s) return;
    switch (s->kind) {
    case AST_SWITCH:
        return;
    case AST_CASE:
        if (c->n < EC_MAX_CASES) c->vals[c->n++] = s->u.case_stmt.value;
        else                     c->overflow = 1;
        ec_collect(s->u.case_stmt.stmt, c);
        return;
    case AST_DEFAULT:
        c->has_default = 1;
        ec_collect(s->u.case_stmt.stmt, c);
        return;
    case AST_BLOCK:
        for (i = 0; i < s->u.block.stmt_count; i++)
            ec_collect(s->u.block.stmts[i], c);
        return;
    case AST_IF:
        ec_collect(s->u.if_stmt.then_stmt, c);
        ec_collect(s->u.if_stmt.else_stmt, c);
        return;
    case AST_WHILE:
    case AST_DO_WHILE:
        ec_collect(s->u.while_stmt.body, c);
        return;
    case AST_FOR:
        ec_collect(s->u.for_stmt.body, c);
        return;
    case AST_LABEL:
        ec_collect(s->u.label_stmt.stmt, c);
        return;
    default:
        /* break/continue/goto/asm/expr/decl/return: no labels inside. */
        return;
    }
}

static void ec_report(int line, int col, const char *tag, const char *names,
                      int anonymous)
{
    DiagLoc loc;
    loc.file = 0;               /* 0 = the translation unit's main file */
    loc.line = line;
    loc.col  = col;
    if (anonymous)
        diag_report_msg(DIAG_SEV_WARNING, &loc,
                        "switch on an anonymous enum does not handle every "
                        "enumerator (missing: %s); add a case label or a "
                        "default label", names, 0, 0);
    else
        diag_report_msg(DIAG_SEV_WARNING, &loc,
                        "switch on enum '%s' does not handle every enumerator "
                        "(missing: %s); add a case label or a default label",
                        tag, names, 0);
}

static void ec_switch(AstNode *s)
{
    Type      *t, *def;
    EnumConst *e;
    EcCases    cases;
    EcNames    nm;
    int        i, missing = 0;

    t = s->u.switch_stmt.expr ? s->u.switch_stmt.expr->type : 0;
    if (!t || t->kind != TYPE_ENUM) return;
    def = type_enum_definition(t);
    if (!def || !def->enumerators) return;          /* nothing to compare against */
    if (def->enumerator_count > EC_MAX_ENUM) return; /* too large to compare exhaustively */

    cases.n = 0;
    cases.overflow = 0;
    cases.has_default = 0;
    ec_collect(s->u.switch_stmt.body, &cases);
    if (cases.has_default || cases.overflow) return;

    nm.buf[0] = 0;
    nm.len = 0;
    nm.count = 0;
    for (e = def->enumerators; e; e = e->next) {
        int covered = 0;
        for (i = 0; i < cases.n; i++)
            if (cases.vals[i] == e->value) { covered = 1; break; }
        if (!covered) { missing++; ec_names_add(&nm, e->name); }
    }
    if (missing == 0) return;
    ec_report(s->line, s->col, def->tag, nm.buf, def->tag ? 0 : 1);
}

static void ec_stmt(AstNode *s)
{
    int i;

    if (!s) return;
    switch (s->kind) {
    case AST_SWITCH:
        ec_switch(s);
        ec_stmt(s->u.switch_stmt.body);     /* nested switches get their own check */
        return;
    case AST_BLOCK:
        for (i = 0; i < s->u.block.stmt_count; i++)
            ec_stmt(s->u.block.stmts[i]);
        return;
    case AST_IF:
        ec_stmt(s->u.if_stmt.then_stmt);
        ec_stmt(s->u.if_stmt.else_stmt);
        return;
    case AST_WHILE:
    case AST_DO_WHILE:
        ec_stmt(s->u.while_stmt.body);
        return;
    case AST_FOR:
        ec_stmt(s->u.for_stmt.init);
        ec_stmt(s->u.for_stmt.body);
        return;
    case AST_CASE:
    case AST_DEFAULT:
        ec_stmt(s->u.case_stmt.stmt);
        return;
    case AST_LABEL:
        ec_stmt(s->u.label_stmt.stmt);
        return;
    default:
        return;
    }
}

int enumcheck_run(AstNode *prog)
{
    int i, warnings;

    if (!prog || prog->kind != AST_PROGRAM) return 0;
    warnings = diag_warnings();
    for (i = 0; i < prog->u.program.decl_count; i++) {
        AstNode *d = prog->u.program.decls[i];
        if (!d || d->kind != AST_FUNC_DEF) continue;
        ec_stmt(d->u.func.body);
    }
    return diag_warnings() - warnings;
}

#endif /* ARKCC_FEATURE_ENUMCHECK */
