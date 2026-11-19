/* Ark C Compiler - memlint.c
 * --warn-mem: intra-procedural memory lint. See memlint.h for the exact scope
 * (what is reported, what is deliberately not) and docs/MEMLINT.md for the
 * reasoning and the measurements.
 *
 * Shape of the implementation
 * ---------------------------
 * One pass over each function body, in source order, carrying a tiny state:
 *   - env: up to ML_MAX_TRACK pointers whose "alive/dead/unknown" is known,
 *   - loc: up to ML_MAX_LOCAL names in scope, each flagged auto storage (this is
 *          what check 1 needs, and it is scoped properly, so a global x shadowed
 *          by an inner block is not confused with the outer one).
 * No allocation, no symbol table, no CFG: branches and loops are handled by
 * copying the 8-entry env, analysing each side, and *merging* -- any entry whose
 * state differs becomes "unknown", which by construction can never produce a
 * report. That is why "certainly dead on every path" is a property of the code
 * rather than a claim in a comment.
 */
#include "memlint.h"

#if ARKCC_FEATURE_MEMLINT

#include "config.h"
#include "diag.h"
#include "sema.h"      /* eval_const_expr: the same folder the backend uses */

/* Sizes are part of the trim story: raising them costs stack, not heap.
 * A function that exceeds either limit is abandoned whole (f->bail) rather than
 * analysed with a truncated state -- a truncated state could report a defect
 * that is not there. */
#define ML_MAX_TRACK  8    /* pointers tracked per function */
#define ML_MAX_LOCAL 32    /* names in the local scope stack */

#define ML_UNKNOWN 0       /* not tracked: nothing may be reported about it */
#define ML_ALIVE   1
#define ML_DEAD    2

typedef struct {
    const char   *name;
    unsigned char st;
} MlPtr;

typedef struct {
    const char   *name;
    Type         *type;
    unsigned char is_auto;  /* automatic storage duration -> &it dangles */
} MlLocal;

typedef struct {
    MlPtr    p[ML_MAX_TRACK];
    int      n;
    MlLocal  loc[ML_MAX_LOCAL];
    int      nloc;
    int      warnings;
    int      bail;          /* give up on this function (overflow, goto, asm) */
} MlFn;

/* ---------------------------------------------------------------------------
 * Small helpers
 * ------------------------------------------------------------------------- */

static int ml_find(MlFn *f, const char *name)
{
    int i;
    if (!name) return -1;
    for (i = 0; i < f->n; i++)
        if (f->p[i].st != ML_UNKNOWN && ark_streq(f->p[i].name, name)) return i;
    return -1;
}

static void ml_report(MlFn *f, int line, int col, const char *msg,
                      const char *a0)
{
    DiagLoc loc;
    loc.file = 0;           /* 0 = the translation unit's main file */
    loc.line = line;
    loc.col  = col;
    diag_report_msg(DIAG_SEV_WARNING, &loc, msg, a0, 0, 0);
    f->warnings++;
}

/* Same, for the two messages that name an object on both sides of the
 * assignment (the storage and the pointer that outlives it). */
static void ml_report2(MlFn *f, int line, int col, const char *msg,
                       const char *a0, const char *a1)
{
    DiagLoc loc;
    loc.file = 0;
    loc.line = line;
    loc.col  = col;
    diag_report_msg(DIAG_SEV_WARNING, &loc, msg, a0, a1, 0);
    f->warnings++;
}

/* Start tracking `name` (or move it to a new state). A new name when the table
 * is full is treated like any other overflow: the function is abandoned. */
static void ml_track(MlFn *f, const char *name, int st)
{
    int i = ml_find(f, name);
    if (i >= 0) { f->p[i].st = (unsigned char)st; return; }
    if (!name) return;
    if (f->n >= ML_MAX_TRACK) { f->bail = 1; return; }
    f->p[f->n].name = name;
    f->p[f->n].st   = (unsigned char)st;
    f->n++;
}

static void ml_untrack(MlFn *f, const char *name)
{
    int i = ml_find(f, name);
    if (i < 0) return;
    f->p[i].st = ML_UNKNOWN;
}

/* Using `name` as a pointer (deref) after its block was released. Reported
 * once: the state becomes unknown afterwards, so a second use in the same
 * function does not produce a second message about the same defect. */
static void ml_deref(MlFn *f, const char *name, int line, int col)
{
    int i = ml_find(f, name);
    if (i < 0 || f->p[i].st != ML_DEAD) return;
    ml_report(f, line, col,
              "use of %sq after it was freed; the memory is no longer owned by "
              "this pointer", name);
    f->p[i].st = ML_UNKNOWN;
}

static int ml_is_alloc_name(const char *n)
{
    if (!n) return 0;
    return ark_streq(n, "malloc") || ark_streq(n, "calloc") ||
           ark_streq(n, "realloc") || ark_streq(n, "strdup");
}

static int ml_is_alloc_call(const AstNode *e)
{
    /* `(char *)malloc(n)` is the same call: a cast in front of it is a type
     * annotation, not a different value.  Without peeling it, that spelling --
     * the commonest one in real C -- would silently escape the tracking, and a
     * later double free of it would go unreported. */
    while (e && e->kind == AST_CAST) e = e->u.unary.operand;
    return e && e->kind == AST_FUNC_CALL && ml_is_alloc_name(e->u.call.name);
}

/* Names the callee "free"? A call through a function pointer (callee != 0 and
 * no name) is never treated as free -- guessing would be the one thing worse
 * than missing the defect. */
static int ml_is_free_call(const AstNode *e)
{
    return e && e->kind == AST_FUNC_CALL && e->u.call.name &&
           ark_streq(e->u.call.name, "free");
}

static int ml_is_auto(MlFn *f, const char *name)
{
    int i;
    if (!name) return 0;
    for (i = f->nloc - 1; i >= 0; i--)
        if (ark_streq(f->loc[i].name, name)) return f->loc[i].is_auto;
    return 0;
}

static Type *ml_local_type(MlFn *f, const char *name)
{
    int i;
    if (!name) return 0;
    for (i = f->nloc - 1; i >= 0; i--)
        if (ark_streq(f->loc[i].name, name)) return f->loc[i].type;
    return 0;
}

static void ml_push_local(MlFn *f, const char *name, Type *t, int is_auto)
{
    if (!name) return;
    if (f->nloc >= ML_MAX_LOCAL) { f->bail = 1; return; }
    f->loc[f->nloc].name    = name;
    f->loc[f->nloc].type    = t;
    f->loc[f->nloc].is_auto = (unsigned char)is_auto;
    f->nloc++;
}

/* ---------------------------------------------------------------------------
 * Check 1: returning the address of an automatic object
 * ------------------------------------------------------------------------- */

/* The object a member/array chain denotes: a.b -> a, a[i] -> a. Anything else
 * (a dereference, a call, a cast) stops the walk, so `return &*p` is silent. */
static AstNode *ml_root_object(AstNode *e)
{
    int guard = 0;
    while (e && guard++ < 64) {
        if (e->kind == AST_MEMBER && !e->u.member.is_arrow) { e = e->u.member.obj; continue; }
        if (e->kind == AST_ARRAY_ACCESS)                     { e = e->u.array_access.array; continue; }
        break;
    }
    return e;
}

static void ml_check_return(MlFn *f, AstNode *val)
{
    AstNode *e = val;

    while (e && e->kind == AST_CAST) e = e->u.unary.operand;
    if (!e) return;

    if (e->kind == AST_UNARY && e->u.unary.op == TOK_BAND) {
        AstNode *root = ml_root_object(e->u.unary.operand);
        if (root && root->kind == AST_VAR && ml_is_auto(f, root->u.name))
            ml_report(f, root->line, root->col,
                      "returning the address of the automatic object %sq; it "
                      "ceases to exist when this function returns", root->u.name);
        return;
    }

    /* `return local_array;` -- the array decays to a pointer to itself. */
    if (e->kind == AST_VAR && ml_is_auto(f, e->u.name)) {
        Type *t = ml_local_type(f, e->u.name);
        if (t && t->kind == TYPE_ARRAY)
            ml_report(f, e->line, e->col,
                      "returning the address of the automatic array %sq; it "
                      "ceases to exist when this function returns", e->u.name);
        return;
    }

    /* `return (T){...};` -- a block-scope compound literal is automatic even
     * though the syntax looks like a constant. */
    if (e->kind == AST_COMPOUND_LITERAL)
        ml_report(f, e->line, e->col,
                  "returning the address of a compound literal with automatic "
                  "storage; it ceases to exist when this function returns", 0);
}

/* ---------------------------------------------------------------------------
 * Check 3: the address of an automatic object escaping into an object that
 * outlives the block
 * ------------------------------------------------------------------------- */

/* The object whose storage is being taken: `&a`, `&a.b`, `&a[i]` -> a. */
static AstNode *ml_addressed_object(AstNode *v)
{
    if (v && v->kind == AST_UNARY && v->u.unary.op == TOK_BAND)
        return ml_root_object(v->u.unary.operand);
    return 0;
}

/* `g = &local;` / `g = local_array;` / `static_ptr = (void *)&local;`
 *
 * The store target is a static-duration object -- a file-scope variable or a
 * `static` local: any name that is not in this function's automatic scope. The
 * value stored is the address of something that dies with the block, so the
 * pointer outlives what it points at.
 *
 * `*out = &local;` and `f(&local)` store it somewhere this walk cannot name
 * (the callee could copy it to a local, or nowhere), so they stay silent.
 * `tab[i] = &local;` is reported when `tab` itself has static duration: the
 * element lives inside an object that outlives the block, so the address in it
 * still dangles.  The defect this check exists for -- static storage holding a
 * pointer into a dead stack frame -- is always spelled as a store into a
 * static-duration object.
 */
static void ml_check_escape(MlFn *f, AstNode *lhs, AstNode *rhs)
{
    AstNode *target = ml_root_object(lhs);
    AstNode *e = rhs;
    AstNode *obj;

    if (!target || target->kind != AST_VAR) return;
    if (ml_is_auto(f, target->u.name)) return;      /* target dies too: fine */

    while (e && e->kind == AST_CAST) e = e->u.unary.operand;
    if (!e) return;

    obj = ml_addressed_object(e);
    if (obj && obj->kind == AST_VAR && ml_is_auto(f, obj->u.name)) {
        ml_report2(f, obj->line, obj->col,
                   "storing the address of the automatic object %sq into %sq; "
                   "the target outlives the block, so the pointer dangles once "
                   "this function returns",
                   obj->u.name, target->u.name);
        return;
    }

    /* `g = local_array;` -- the array decays to a pointer to itself. */
    if (e->kind == AST_VAR && ml_is_auto(f, e->u.name)) {
        Type *t = ml_local_type(f, e->u.name);
        if (t && t->kind == TYPE_ARRAY)
            ml_report2(f, e->line, e->col,
                       "storing the address of the automatic array %sq into "
                       "%sq; the target outlives the block, so the pointer "
                       "dangles once this function returns",
                       e->u.name, target->u.name);
        return;
    }

    if (e->kind == AST_COMPOUND_LITERAL)
        ml_report(f, e->line, e->col,
                  "storing the address of a compound literal with automatic "
                  "storage into %sq; it ceases to exist when this function "
                  "returns", target->u.name);
}

/* ---------------------------------------------------------------------------
 * Check 4: a constant subscript outside a known array bound
 * ------------------------------------------------------------------------- */

/* `int a[4]; a[4]` / `a[-1]` -- the subscript is a constant and the array's
 * bound is in its type, so the out-of-range access is decidable at compile
 * time.  Narrow on purpose:
 *   - the operand must be an array, not a pointer: a pointer's bound is
 *     whatever it was set to, which this pass does not track;
 *   - the bound must be static (no VLA) and positive (no flexible member);
 *   - the subscript must fold to a constant (eval_const_expr, the same
 *     evaluator the code generator uses for array bounds and case labels);
 *   - the operand must be a named object.  `"abc"[4]` is excluded because the
 *     array bound of a string literal is the one size this pass would have to
 *     take on faith from another stage.
 * Note that `a[4]` is well formed as an *expression* (&a[4] is legal); it is
 * only the dereference that is undefined, which is what a subscript is. */
static void ml_check_bounds(MlFn *f, AstNode *e)
{
    AstNode   *base = e->u.array_access.array;
    AstNode   *idx  = e->u.array_access.index;
    Type      *t;
    long long  v;
    char       nb[16], sb[16];

    if (!base || !idx) return;
    if (base->kind != AST_VAR && base->kind != AST_MEMBER &&
        base->kind != AST_ARRAY_ACCESS) return;
    t = base->type;
    if (!t || t->kind != TYPE_ARRAY) return;
    if (t->is_vla || t->size <= 0) return;
    if (!eval_const_expr(idx, &v)) return;
    if (v >= 0 && v < (long long)t->size) return;
    ml_report2(f, base->line, base->col,
               "subscript %s is outside the bounds of this array of %s "
               "element(s)",
               diag_num(nb, (int)v), diag_num(sb, t->size));
}

/* ---------------------------------------------------------------------------
 * Check 2: double free / use after free (expression walk)
 * ------------------------------------------------------------------------- */

static void ml_expr(MlFn *f, AstNode *e);

static void ml_expr_children(MlFn *f, AstNode *e)
{
    if (!e || f->bail) return;
    switch (e->kind) {
    case AST_BINARY:
        ml_expr(f, e->u.binary.left);
        ml_expr(f, e->u.binary.right);
        break;
    case AST_TERNARY:
        ml_expr(f, e->u.ternary.cond);
        ml_expr(f, e->u.ternary.true_expr);
        ml_expr(f, e->u.ternary.false_expr);
        break;
    case AST_COMMA:
        ml_expr(f, e->u.binary.left);
        ml_expr(f, e->u.binary.right);
        break;
    case AST_CAST:
        ml_expr(f, e->u.unary.operand);
        break;
    case AST_INIT_LIST: {
        int i;
        for (i = 0; i < e->u.init_list.item_count; i++)
            ml_expr(f, e->u.init_list.items[i]);
        break;
    }
    case AST_INIT_FIELD:
        ml_expr(f, e->u.init_field.value);
        break;
    case AST_COMPOUND_LITERAL:
        ml_expr(f, e->u.compound_lit.init);
        break;
    default:
        /* AST_SIZEOF / AST_NUM / AST_STR / AST_GENERIC (already squashed):
         * nothing that can deref or free. */
        break;
    }
}

static void ml_expr(MlFn *f, AstNode *e)
{
    if (!e || f->bail) return;

    switch (e->kind) {
    case AST_NUM:
    case AST_STR:
        return;

    case AST_VAR:
        /* A bare use of a tracked pointer anywhere but a dereference position:
         * it may alias, be stored, or be handed to a callee. Stop tracking it
         * (silence is the accepted direction). */
        ml_untrack(f, e->u.name);
        return;

    case AST_UNARY:
        if (e->u.unary.op == TOK_MUL && e->u.unary.operand &&
            e->u.unary.operand->kind == AST_VAR) {
            ml_deref(f, e->u.unary.operand->u.name,
                     e->u.unary.operand->line, e->u.unary.operand->col);
            return;
        }
        ml_expr(f, e->u.unary.operand);
        return;

    case AST_ARRAY_ACCESS:
        ml_check_bounds(f, e);
        if (e->u.array_access.array && e->u.array_access.array->kind == AST_VAR) {
            ml_deref(f, e->u.array_access.array->u.name,
                     e->u.array_access.array->line,
                     e->u.array_access.array->col);
            ml_expr(f, e->u.array_access.index);
            return;
        }
        ml_expr(f, e->u.array_access.array);
        ml_expr(f, e->u.array_access.index);
        return;

    case AST_MEMBER:
        if (e->u.member.is_arrow && e->u.member.obj &&
            e->u.member.obj->kind == AST_VAR) {
            ml_deref(f, e->u.member.obj->u.name,
                     e->u.member.obj->line, e->u.member.obj->col);
            return;
        }
        ml_expr(f, e->u.member.obj);
        return;

    case AST_ASSIGN:
        if (e->u.binary.left && e->u.binary.left->kind == AST_VAR) {
            const char *nm = e->u.binary.left->u.name;
            ml_expr(f, e->u.binary.right);          /* evaluate the source */
            if (e->u.binary.op == TOK_ASSIGN) {
                ml_check_escape(f, e->u.binary.left, e->u.binary.right);
                if (ml_is_alloc_call(e->u.binary.right)) ml_track(f, nm, ML_ALIVE);
                else                                     ml_untrack(f, nm);
            } else {
                /* p += n, p++, ... : the pointer moved, the pairing is lost */
                ml_untrack(f, nm);
            }
            return;
        }
        /* Store through a pointer: the target is dereferenced. */
        ml_expr(f, e->u.binary.left);
        ml_expr(f, e->u.binary.right);
        return;

    case AST_FUNC_CALL: {
        int i;
        if (ml_is_free_call(e)) {
            AstNode *a0 = e->u.call.arg_count > 0 ? e->u.call.args[0] : 0;
            if (a0 && a0->kind == AST_VAR) {
                int k = ml_find(f, a0->u.name);
                if (k >= 0) {
                    if (f->p[k].st == ML_DEAD) {
                        ml_report(f, a0->line, a0->col,
                                  "%sq is freed twice; the first call already "
                                  "released that memory", a0->u.name);
                        f->p[k].st = ML_UNKNOWN;
                    } else {
                        f->p[k].st = ML_DEAD;
                    }
                }
            } else if (a0) {
                /* free(p + 1), free((char*)p), free(f()->p): not a pairing we
                 * can follow. Any tracked name inside loses its state. */
                ml_expr_children(f, a0);
            }
            for (i = 1; i < e->u.call.arg_count; i++)
                ml_expr(f, e->u.call.args[i]);
            return;
        }
        /* Any other call: an argument that names a tracked pointer hands it to
         * code we cannot see, so it escapes. Recursing also catches a
         * dereference in the argument, which is a real use. */
        for (i = 0; i < e->u.call.arg_count; i++)
            ml_expr(f, e->u.call.args[i]);
        return;
    }

    default:
        ml_expr_children(f, e);
        return;
    }
}

/* ---------------------------------------------------------------------------
 * Check 2: statements, with the branch/loop merge
 * ------------------------------------------------------------------------- */

static void ml_stmt(MlFn *f, AstNode *s);

/* An env snapshot. Copying 8 entries is cheaper than any bookkeeping that would
try to avoid the copy, and it keeps the merge obviously correct. */
typedef struct {
    MlPtr  p[ML_MAX_TRACK];
    int    n;
} MlEnv;

static void ml_env_save(MlEnv *e, MlFn *f)
{
    int i;
    e->n = f->n;
    for (i = 0; i < f->n; i++) e->p[i] = f->p[i];
}

static void ml_env_load(MlFn *f, const MlEnv *e)
{
    int i;
    f->n = e->n;
    for (i = 0; i < e->n; i++) f->p[i] = e->p[i];
}

static int ml_env_state(const MlEnv *e, const char *name)
{
    int i;
    if (!name) return ML_UNKNOWN;
    for (i = 0; i < e->n; i++)
        if (e->p[i].st != ML_UNKNOWN && ark_streq(e->p[i].name, name))
            return e->p[i].st;
    return ML_UNKNOWN;
}

/* Keep only the entries whose state is identical on both sides. A pointer that
 * was freed on one path and not on the other is dropped, which is exactly the
 * "certainly dead" requirement: after this, a report can only come from a
 * state that holds on every path that reaches the use. */
static void ml_merge_inplace(MlFn *f, const MlEnv *other)
{
    int i, k = 0;
    for (i = 0; i < f->n; i++) {
        int sa = f->p[i].st;
        int sb = ml_env_state(other, f->p[i].name);
        if (sa != ML_UNKNOWN && sa == sb) f->p[k++] = f->p[i];
    }
    f->n = k;
}

/* Analyse one side of a branch, then merge the result with the state on entry.
 * The post-state of the analysed side is what gets merged in, so both the
 * "taken" and the "not taken" path are represented. */
static void ml_branch(MlFn *f, AstNode *body)
{
    MlEnv pre, after;
    ml_env_save(&pre, f);
    ml_stmt(f, body);
    if (f->bail) return;
    ml_env_save(&after, f);
    ml_env_load(f, &pre);
    ml_merge_inplace(f, &after);
}

static void ml_stmt(MlFn *f, AstNode *s)
{
    if (!s || f->bail) return;

    switch (s->kind) {
    case AST_BLOCK: {
        int mark = f->nloc;
        int i;
        for (i = 0; i < s->u.block.stmt_count; i++)
            ml_stmt(f, s->u.block.stmts[i]);
        f->nloc = mark;
        return;
    }

    case AST_VAR_DECL: {
        AstNode *init = s->u.var.init;
        const char *nm = s->u.var.name;
        int is_auto = !s->u.var.is_global && !s->u.var.is_static &&
                      !s->u.var.is_extern;
        /* A fresh block-scope object hides any outer object of the same name,
         * so an older tracked entry for that name is meaningless from here. */
        ml_untrack(f, nm);
        ml_push_local(f, nm, s->u.var.var_type, is_auto);
        if (init) {
            ml_expr(f, init);
            if (!s->u.var.is_static && ml_is_alloc_call(init))
                ml_track(f, nm, ML_ALIVE);
        }
        return;
    }

    case AST_EXPR_STMT:
        ml_expr(f, s->u.unary.operand);
        return;

    case AST_RETURN:
        ml_check_return(f, s->u.unary.operand);
        ml_expr(f, s->u.unary.operand);
        return;

    case AST_IF: {
        ml_expr(f, s->u.if_stmt.cond);
        if (s->u.if_stmt.else_stmt) {
            MlEnv pre, then_env;
            ml_env_save(&pre, f);
            ml_stmt(f, s->u.if_stmt.then_stmt);
            if (f->bail) return;
            ml_env_save(&then_env, f);
            ml_env_load(f, &pre);
            ml_stmt(f, s->u.if_stmt.else_stmt);
            if (f->bail) return;
            ml_merge_inplace(f, &then_env);
        } else {
            ml_branch(f, s->u.if_stmt.then_stmt);
        }
        return;
    }

    case AST_WHILE:
    case AST_DO_WHILE:
        ml_expr(f, s->u.while_stmt.cond);
        ml_branch(f, s->u.while_stmt.body);
        return;

    case AST_FOR: {
        int mark = f->nloc;
        AstNode *body = s->u.for_stmt.body;
        if (s->u.for_stmt.init) {
            if (s->u.for_stmt.init->kind == AST_VAR_DECL ||
                s->u.for_stmt.init->kind == AST_BLOCK)
                ml_stmt(f, s->u.for_stmt.init);
            else
                ml_expr(f, s->u.for_stmt.init);
        }
        if (s->u.for_stmt.cond) ml_expr(f, s->u.for_stmt.cond);
        if (s->u.for_stmt.step) ml_expr(f, s->u.for_stmt.step);
        ml_branch(f, body);
        f->nloc = mark;
        return;
    }

    case AST_SWITCH:
        ml_expr(f, s->u.switch_stmt.expr);
        ml_branch(f, s->u.switch_stmt.body);
        return;

    case AST_CASE:
    case AST_DEFAULT:
        ml_stmt(f, s->u.case_stmt.stmt);
        return;

    case AST_LABEL:
    case AST_GOTO:
    case AST_ASM:
    case AST_ASM_FUNC:
        /* A goto can reach a use without passing the free (or the reverse), and
         * inline assembly can free or keep anything. Neither can be analysed
         * from the tree, so the whole function is abandoned. Nothing has been
         * reported after this point; reports already emitted came from
         * straight-line code before the first jump target. */
        f->bail = 1;
        return;

    case AST_FUNC_DEF:
        /* Nested function bodies are not this pass's business. */
        return;

    default:
        return;
    }
}

/* ---------------------------------------------------------------------------
 * Entry points
 * ------------------------------------------------------------------------- */

static int ml_function(MlFn *f, AstNode *fn)
{
    int i;

    f->n = 0;
    f->nloc = 0;
    f->warnings = 0;
    f->bail = 0;

    if (fn->u.func.is_asm_func || !fn->u.func.body) return 0;

    /* Parameters have automatic storage duration too: `return &p;` dangles. */
    for (i = 0; i < fn->u.func.param_count; i++) {
        AstNode *p = fn->u.func.params[i];
        if (p && p->kind == AST_VAR_DECL) {
            int is_auto = !p->u.var.is_global && !p->u.var.is_static &&
                          !p->u.var.is_extern;
            ml_push_local(f, p->u.var.name, p->u.var.var_type, is_auto);
        }
    }

    ml_stmt(f, fn->u.func.body);
    return f->warnings;
}

int memlint_run(AstNode *prog)
{
    int i, total = 0;

    if (!prog || prog->kind != AST_PROGRAM) return 0;

    for (i = 0; i < prog->u.program.decl_count; i++) {
        AstNode *d = prog->u.program.decls[i];
        MlFn fn;
        if (!d || d->kind != AST_FUNC_DEF) continue;
        total += ml_function(&fn, d);
    }
    return total;
}

#endif /* ARKCC_FEATURE_MEMLINT */
