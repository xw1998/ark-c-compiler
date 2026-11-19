/* Ark C Compiler - unusedresult.c
 * --warn-unused-result. See unusedresult.h for the boundary.
 *
 * Shape of the implementation
 * ---------------------------
 *   1. Collect the names of functions declared with the attribute. A
 *      declaration, a definition and a prototype in a header all count; the
 *      attribute sticks by name, so `int f(void);` annotated in one place and
 *      defined in another is still checked (`union by name`).
 *      Only functions with a non-void return type are recorded: on a void
 *      function the attribute cannot catch anything.
 *   2. Walk statements. The only shape that warns is an expression statement
 *      whose entire expression is a call -- `f();`. Everything else (a call in
 *      an initialiser, a condition, an argument, an assignment) uses the value.
 *   3. `(void)f();` is the documented way to discard a result on purpose, so a
 *      cast to void silences the report (GNU and clang behave the same way).
 *
 * No path analysis, no aliasing, no call graph: this is a local check on the
 * shape of one statement.
 */
#include "unusedresult.h"

#if ARKCC_FEATURE_UNUSEDRESULT

#include "config.h"
#include "diag.h"
#include "type.h"

/* Capacity is part of the honesty story: a truncated table would silently stop
 * checking the rest of the translation unit, so overflow is reported once
 * instead. 256 annotated functions in one file is far beyond hand-written
 * firmware; the table is pointers, so the frame is ~2 KB on a 64-bit host and
 * ~1 KB on a 32-bit target, and it never goes to the heap. */
#define UR_MAX_FUNCS 256

typedef struct {
    const char *name;
    int         returns_value;
} UrFunc;

typedef struct {
    UrFunc f[UR_MAX_FUNCS];
    int    count;
    int    overflow;
} UrTable;

static int ur_lookup(const UrTable *t, const char *name)
{
    int i;
    if (!name) return 0;
    for (i = 0; i < t->count; i++)
        if (t->f[i].name && ark_streq(t->f[i].name, name))
            return 1;
    return 0;
}

static void ur_add(UrTable *t, AstNode *fn)
{
    const char *name = fn->u.func.name;
    int i;
    if (!name) return;
    if (!fn->u.func.is_unused_result) return;
    /* A void return cannot lose a value; the attribute is a no-op there. */
    if (fn->u.func.ret_type && fn->u.func.ret_type->kind == TYPE_VOID) return;
    for (i = 0; i < t->count; i++)
        if (t->f[i].name && ark_streq(t->f[i].name, name))
            return;
    if (t->count >= UR_MAX_FUNCS) { t->overflow = 1; return; }
    t->f[t->count].name = name;
    t->f[t->count].returns_value = 1;
    t->count++;
}

static void ur_collect(AstNode *n, UrTable *t)
{
    int i;
    if (!n) return;
    if (n->kind == AST_PROGRAM) {
        for (i = 0; i < n->u.program.decl_count; i++)
            ur_collect(n->u.program.decls[i], t);
        return;
    }
    if (n->kind == AST_FUNC_DEF || n->kind == AST_FUNC_DECL)
        ur_add(t, n);
}

/* Is this expression exactly a call to an annotated function? */
static int ur_bad_call(AstNode *e, const UrTable *t)
{
    if (!e) return 0;
    if (e->kind == AST_FUNC_CALL) {
        /* A call through a pointer has no name; nothing was declared, so
         * nothing is known. */
        return ur_lookup(t, e->u.call.name);
    }
    if (e->kind == AST_COMMA)
        return ur_bad_call(e->u.binary.right, t);
    return 0;
}

static void ur_warn(AstNode *call)
{
    DiagLoc loc;
    loc.file = 0;
    loc.line = call->line;
    loc.col  = call->col;
    diag_report_msg(DIAG_SEV_WARNING, &loc,
                    "ignoring return value of '%s' declared with "
                    "warn_unused_result; cast the call to (void) to discard it "
                    "deliberately", call->u.call.name, 0, 0);
}

static void ur_stmt(AstNode *s, const UrTable *t)
{
    int i;
    if (!s) return;
    switch (s->kind) {
    case AST_BLOCK:
        for (i = 0; i < s->u.block.stmt_count; i++)
            ur_stmt(s->u.block.stmts[i], t);
        break;
    case AST_IF:
        ur_stmt(s->u.if_stmt.then_stmt, t);
        ur_stmt(s->u.if_stmt.else_stmt, t);
        break;
    case AST_WHILE:
        ur_stmt(s->u.while_stmt.body, t);
        break;
    case AST_FOR:
        ur_stmt(s->u.for_stmt.body, t);
        break;
    case AST_DO_WHILE:
        ur_stmt(s->u.while_stmt.body, t);
        break;
    case AST_SWITCH:
        ur_stmt(s->u.switch_stmt.body, t);
        break;
    case AST_CASE:
    case AST_DEFAULT:
        ur_stmt(s->u.case_stmt.stmt, t);
        break;
    case AST_LABEL:
        ur_stmt(s->u.label_stmt.stmt, t);
        break;
    case AST_EXPR_STMT:
        if (ur_bad_call(s->u.unary.operand, t))
            ur_warn(s->u.unary.operand);
        break;
    default:
        break;
    }
}

int unusedresult_run(AstNode *prog)
{
    UrTable t;
    int i;
    int before;
    if (!prog) return 0;
    t.count = 0;
    t.overflow = 0;
    ur_collect(prog, &t);

    if (t.overflow) {
        /* Reporting the truncation is the only honest option: a partial check
         * that stays quiet about the part it skipped reads as a clean file. */
        DiagLoc loc;
        loc.file = 0;
        loc.line = 0;
        loc.col  = 0;
        diag_report_msg(DIAG_SEV_WARNING, &loc,
                        "more than %d functions carry warn_unused_result in "
                        "this translation unit; the check only covers the "
                        "first %d of them", "256", "256", 0);
    }
    if (t.count == 0) return 0;

    before = diag_warnings();
    for (i = 0; i < prog->u.program.decl_count; i++) {
        AstNode *d = prog->u.program.decls[i];
        if (d && d->kind == AST_FUNC_DEF && d->u.func.body)
            ur_stmt(d->u.func.body, &t);
    }
    return diag_warnings() - before;
}

#endif /* ARKCC_FEATURE_UNUSEDRESULT */
