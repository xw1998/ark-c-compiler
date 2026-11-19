/* Ark C Compiler - mir.c
 * The intra-function CFG and the inter-function call graph. See mir.h for
 * what each one is and which invariants the rest of the compiler is allowed
 * to rely on.
 *
 * The one piece of real work here is the leader rule. Rather than re-deriving
 * "which instruction starts a block" at every use site, it is decided once,
 * in mir_build, from three facts:
 *
 *   - instruction 0 is a leader;
 *   - a label (IR_LABEL / IR_LABEL_NAMED) is a leader;
 *   - the instruction after a terminator is a leader.
 *
 * Everything else follows: a terminator can only be a block's last
 * instruction, a fall-through edge is always "block b -> block b+1", and the
 * block order is the instruction order (so diagnostics come out in source
 * order without sorting).
 */
#include "mir.h"
#include "memory.h"
#include "arkcc_config.h"

#if ARKCC_FEATURE_MIR

/* A terminator ends the flow of its block. IR_FUNC_END is a terminator so a
 * trailing block never claims a fall-through into nothing. */
static int mir_is_terminator(const IrInst *I) {
    switch (I->op) {
    case IR_JMP:
    case IR_JMP_NAMED:
    case IR_JZ:
    case IR_JNZ:
    case IR_CMP_JMP_EQ:
    case IR_RETURN:
    case IR_FUNC_END:
        return 1;
    default:
        return 0;
    }
}

static int mir_is_label(const IrInst *I) {
    return (I->op == IR_LABEL || I->op == IR_LABEL_NAMED);
}

/* Index of the label instruction a jump aims at, or -1.
 * The two label kinds are separate namespaces: IR_LABEL matches on the integer
 * id in `val`, IR_LABEL_NAMED on the string in `name`. IR_CMP_JMP_EQ stores
 * its target id in `aux`, so the caller passes a synthesised probe. */
static int mir_label_index(const IrFunc *f, IrOp kind, long long id,
                           const char *name) {
    int i;
    int named = (kind == IR_JMP_NAMED);
    for (i = 0; i < f->code_count; i++) {
        const IrInst *L = &f->code[i];
        if (named) {
            if (L->op == IR_LABEL_NAMED && L->name && name &&
                ark_streq(L->name, name))
                return i;
        } else {
            if (L->op == IR_LABEL && L->val == id)
                return i;
        }
    }
    return -1;
}

/* Target of a jump instruction, or -1. */
static int mir_jump_target(const IrFunc *f, const IrInst *J) {
    if (J->op == IR_JMP || J->op == IR_JMP_NAMED)
        return mir_label_index(f, J->op, J->val, J->name);
    if (J->op == IR_CMP_JMP_EQ)
        return mir_label_index(f, IR_JMP, J->aux, 0);
    if (J->op == IR_JZ || J->op == IR_JNZ)
        return mir_label_index(f, IR_JMP, J->val, 0);
    return -1;
}

int mir_build(const IrFunc *f, MirFunc *out) {
    int n, i, b;
    unsigned char *lead;
    int *block_of;

    if (!out) return -1;
    out->f = (IrFunc *)f;
    out->blk = 0;
    out->blk_count = 0;
    out->inst_blk = 0;
    out->pred_list = 0;
    if (!f || f->code_count <= 0) return -1;

    n = f->code_count;
    lead = (unsigned char *)mem_pool_alloc(n);
    block_of = (int *)mem_pool_alloc(n * (int)sizeof(int));
    for (i = 0; i < n; i++) { lead[i] = 0; block_of[i] = -1; }

    lead[0] = 1;
    for (i = 0; i < n; i++) {
        if (mir_is_label(&f->code[i])) lead[i] = 1;
        if (i > 0 && mir_is_terminator(&f->code[i - 1])) lead[i] = 1;
    }

    /* Count and lay out the blocks. */
    {
        int count = 0;
        for (i = 0; i < n; i++) if (lead[i]) count++;
        out->blk = (MirBlock *)mem_pool_alloc(count * (int)sizeof(MirBlock));
        out->blk_count = count;
        b = -1;
        for (i = 0; i < n; i++) {
            if (lead[i]) {
                if (b >= 0) out->blk[b].end = i;
                b++;
                out->blk[b].start = i;
                out->blk[b].end = n;
                out->blk[b].succ[0] = -1;
                out->blk[b].succ[1] = -1;
                out->blk[b].succ_count = 0;
                out->blk[b].pred_start = 0;
                out->blk[b].pred_count = 0;
            }
            block_of[i] = b;
        }
    }
    out->inst_blk = block_of;

    /* Successor edges, from the last instruction of each block. */
    for (b = 0; b < out->blk_count; b++) {
        MirBlock *B = &out->blk[b];
        const IrInst *L = &f->code[B->end - 1];
        int fall = (b + 1 < out->blk_count) ? b + 1 : -1;
        int t = -1;

        switch (L->op) {
        case IR_RETURN:
        case IR_FUNC_END:
            break;                                  /* no successors */
        case IR_JMP:
        case IR_JMP_NAMED:
            t = mir_jump_target(f, L);
            if (t >= 0) B->succ[B->succ_count++] = block_of[t];
            break;
        case IR_JZ:
        case IR_JNZ:
        case IR_CMP_JMP_EQ:
            t = mir_jump_target(f, L);
            if (t >= 0) B->succ[B->succ_count++] = block_of[t];
            if (fall >= 0 && B->succ_count < MIR_MAX_SUCC)
                B->succ[B->succ_count++] = fall;
            break;
        default:
            if (fall >= 0) B->succ[B->succ_count++] = fall;
            break;
        }
    }

    /* Predecessors: one edge per successor slot, flattened per target block. */
    {
        int total = 0;
        int *cursor;
        for (b = 0; b < out->blk_count; b++) total += out->blk[b].succ_count;
        out->pred_list = (int *)mem_pool_alloc((total > 0 ? total : 1) *
                                               (int)sizeof(int));
        /* Fill counts first so pred_start can be a running sum. */
        for (b = 0; b < out->blk_count; b++) {
            int k;
            for (k = 0; k < out->blk[b].succ_count; k++) {
                int to = out->blk[b].succ[k];
                if (to >= 0 && to < out->blk_count) out->blk[to].pred_count++;
            }
        }
        {
            int run = 0;
            for (b = 0; b < out->blk_count; b++) {
                out->blk[b].pred_start = run;
                run += out->blk[b].pred_count;
                out->blk[b].pred_count = 0;      /* reused as a fill cursor */
            }
        }
        cursor = out->pred_list;
        (void)cursor;
        for (b = 0; b < out->blk_count; b++) {
            int k;
            for (k = 0; k < out->blk[b].succ_count; k++) {
                int to = out->blk[b].succ[k];
                if (to < 0 || to >= out->blk_count) continue;
                out->pred_list[out->blk[to].pred_start +
                               out->blk[to].pred_count] = b;
                out->blk[to].pred_count++;
            }
        }
    }

    return 0;
}

int mir_inst_block(const MirFunc *m, int index) {
    if (!m || !m->inst_blk || index < 0 || index >= m->f->code_count) return -1;
    return m->inst_blk[index];
}

int mir_reachable(const MirFunc *m, unsigned char *reach) {
    int b, count = 0;
    int *queue;
    int qh = 0, qt = 0;

    if (!m || !reach || m->blk_count <= 0) return 0;
    for (b = 0; b < m->blk_count; b++) reach[b] = 0;

    queue = (int *)mem_pool_alloc(m->blk_count * (int)sizeof(int));
    reach[0] = 1;
    queue[qt++] = 0;
    while (qh < qt) {
        int cur = queue[qh++];
        int k;
        for (k = 0; k < m->blk[cur].succ_count; k++) {
            int to = m->blk[cur].succ[k];
            if (to < 0 || to >= m->blk_count || reach[to]) continue;
            reach[to] = 1;
            queue[qt++] = to;
        }
    }
    for (b = 0; b < m->blk_count; b++) if (reach[b]) count++;
    return count;
}

int mir_verify(const MirFunc *m) {
    int bad = 0;
    int b;
    if (!m || !m->blk || !m->f) return 1;

    /* Blocks are contiguous, in order, non-empty, and end where the next
     * begins. The last block ends at code_count. */
    if (m->blk_count <= 0) return 1;
    if (m->blk[0].start != 0) bad++;
    for (b = 0; b < m->blk_count; b++) {
        const MirBlock *B = &m->blk[b];
        if (B->start < 0 || B->end <= B->start) { bad++; continue; }
        if (b + 1 < m->blk_count) {
            if (B->end != m->blk[b + 1].start) bad++;
        } else if (B->end != m->f->code_count) {
            bad++;
        }
        /* A terminator may only be the last instruction of its block. */
        {
            int i;
            for (i = B->start; i < B->end - 1; i++)
                if (mir_is_terminator(&m->f->code[i])) { bad++; break; }
        }
        if (B->succ_count < 0 || B->succ_count > MIR_MAX_SUCC) bad++;
        {
            int k;
            for (k = 0; k < B->succ_count; k++)
                if (B->succ[k] < 0 || B->succ[k] >= m->blk_count) bad++;
        }
        /* inst_blk agrees with the block range. */
        {
            int i;
            for (i = B->start; i < B->end; i++)
                if (m->inst_blk[i] != b) { bad++; break; }
        }
    }

    /* Predecessor lists agree with the successor edges, both directions. */
    for (b = 0; b < m->blk_count; b++) {
        const MirBlock *B = &m->blk[b];
        int k, seen = 0;
        for (k = 0; k < B->succ_count; k++) {
            int to = B->succ[k];
            int j, found = 0;
            if (to < 0 || to >= m->blk_count) continue;
            for (j = 0; j < m->blk[to].pred_count; j++)
                if (m->pred_list[m->blk[to].pred_start + j] == b) found = 1;
            if (!found) bad++;
        }
        for (k = 0; k < B->pred_count; k++) {
            int from = m->pred_list[B->pred_start + k];
            int j, found = 0;
            if (from < 0 || from >= m->blk_count) { bad++; continue; }
            for (j = 0; j < m->blk[from].succ_count; j++)
                if (m->blk[from].succ[j] == b) found = 1;
            if (!found) bad++;
            seen++;
        }
        (void)seen;
    }
    return bad;
}

/* ---------------------------------------------------------------- */
/* Call graph                                                        */
/* ---------------------------------------------------------------- */

static int mir_find_func(const IrProgram *prog, const char *name) {
    int i;
    if (!name) return -1;
    for (i = 0; i < prog->func_count; i++)
        if (prog->funcs[i]->name && ark_streq(prog->funcs[i]->name, name))
            return i;
    return -1;
}

/* Growable int list over the arena (no realloc: copy on growth). */
typedef struct { int *p; int n; int cap; } MirInts;

static void mir_ints_push(MirInts *v, int x) {
    int i;
    for (i = 0; i < v->n; i++) if (v->p[i] == x) return;  /* dedupe */
    if (v->n >= v->cap) {
        int nc = v->cap ? v->cap * 2 : 8;
        int *np = (int *)mem_pool_alloc(nc * (int)sizeof(int));
        for (i = 0; i < v->n; i++) np[i] = v->p[i];
        v->p = np;
        v->cap = nc;
    }
    v->p[v->n++] = x;
}

int mir_callgraph_build(const IrProgram *prog, MirCallGraph *out) {
    MirInts *edges;
    int i, total;

    if (!out) return -1;
    out->n = 0;
    out->callee_start = 0;
    out->callee_list = 0;
    out->addr_taken = 0;
    out->unresolved_calls = 0;
    out->saw_inline_asm = 0;
    if (!prog || prog->func_count <= 0) return -1;

    out->n = prog->func_count;
    out->addr_taken = (unsigned char *)mem_pool_alloc(out->n);
    for (i = 0; i < out->n; i++) out->addr_taken[i] = 0;
    edges = (MirInts *)mem_pool_alloc(out->n * (int)sizeof(MirInts));
    for (i = 0; i < out->n; i++) { edges[i].p = 0; edges[i].n = 0; edges[i].cap = 0; }

    /* Address-taken seeds: an alias attribute names the real function, and the
     * aliased name itself is what other code binds to. */
    for (i = 0; i < out->n; i++) {
        const IrFunc *F = prog->funcs[i];
        if (F->alias_target) {
            int t = mir_find_func(prog, F->alias_target);
            if (t >= 0) out->addr_taken[t] = 1;
        }
    }
    /* Global initialisers that carry an address. */
    {
        int g;
        for (g = 0; g < prog->global_count; g++) {
            const IrGlobal *G = prog->globals[g];
            if (G->init_sym && G->init_sym_is_func) {
                int t = mir_find_func(prog, G->init_sym);
                if (t >= 0) out->addr_taken[t] = 1;
            }
            if (G->init_refs) {
                int r;
                for (r = 0; r < G->init_ref_count; r++) {
                    int t = mir_find_func(prog, G->init_refs[r].sym);
                    if (t >= 0) out->addr_taken[t] = 1;
                }
            }
        }
    }

    for (i = 0; i < out->n; i++) {
        const IrFunc *F = prog->funcs[i];
        int k;
        if (F->is_asm_func) out->saw_inline_asm = 1;
        for (k = 0; k < F->code_count; k++) {
            const IrInst *I = &F->code[k];
            if (I->op == IR_ASM) { out->saw_inline_asm = 1; continue; }
            if (I->op == IR_PUSH_FUNC) {
                int t = mir_find_func(prog, I->name);
                if (t >= 0) out->addr_taken[t] = 1;
                continue;
            }
            if (I->op == IR_CALL) {
                int t = mir_find_func(prog, I->name);
                if (t >= 0) mir_ints_push(&edges[i], t);
                else if (!I->name) out->unresolved_calls++;
                continue;
            }
        }
    }

    /* Flatten. */
    total = 0;
    for (i = 0; i < out->n; i++) total += edges[i].n;
    out->callee_start = (int *)mem_pool_alloc((out->n + 1) * (int)sizeof(int));
    out->callee_list = (int *)mem_pool_alloc((total > 0 ? total : 1) *
                                             (int)sizeof(int));
    {
        int run = 0;
        for (i = 0; i < out->n; i++) {
            int k;
            out->callee_start[i] = run;
            for (k = 0; k < edges[i].n; k++) out->callee_list[run++] = edges[i].p[k];
        }
        out->callee_start[out->n] = run;
    }
    return 0;
}

/* Iterative Tarjan: a 5000-function translation unit must not blow the stack
 * of the compiler running on a 4 KB task stack. Each stack frame is
 * (node, next child index). */
int mir_scc(const MirCallGraph *g, int *scc_of) {
    int *index, *low, *stk, *onstk;
    int *sc_stack, *sc_it;   /* explicit DFS frames */
    int sp = 0, sc_top = 0, counter = 0, ncomp = 0;
    int i, v;

    if (!g || !scc_of || g->n <= 0) return 0;
    index  = (int *)mem_pool_alloc(g->n * (int)sizeof(int));
    low    = (int *)mem_pool_alloc(g->n * (int)sizeof(int));
    stk    = (int *)mem_pool_alloc(g->n * (int)sizeof(int));
    onstk  = (int *)mem_pool_alloc(g->n * (int)sizeof(int));
    sc_stack = (int *)mem_pool_alloc(g->n * (int)sizeof(int));
    sc_it    = (int *)mem_pool_alloc(g->n * (int)sizeof(int));

    for (i = 0; i < g->n; i++) { index[i] = -1; low[i] = 0; onstk[i] = 0; scc_of[i] = -1; }

    for (v = 0; v < g->n; v++) {
        if (index[v] >= 0) continue;
        /* push v */
        index[v] = low[v] = counter++;
        stk[sp++] = v;
        onstk[v] = 1;
        sc_stack[sc_top] = v;
        sc_it[sc_top] = g->callee_start[v];
        sc_top++;

        while (sc_top > 0) {
            int u = sc_stack[sc_top - 1];
            int end = g->callee_start[u + 1];
            int advanced = 0;

            /* Continue scanning u's children from where we left off. */
            while (sc_it[sc_top - 1] < end) {
                int w = g->callee_list[sc_it[sc_top - 1]++];
                if (index[w] < 0) {
                    index[w] = low[w] = counter++;
                    stk[sp++] = w;
                    onstk[w] = 1;
                    sc_stack[sc_top] = w;
                    sc_it[sc_top] = g->callee_start[w];
                    sc_top++;
                    advanced = 1;
                    break;
                } else if (onstk[w]) {
                    if (index[w] < low[u]) low[u] = index[w];
                }
            }
            if (advanced) continue;

            /* u is finished. */
            sc_top--;
            if (low[u] == index[u]) {
                int w;
                do {
                    w = stk[--sp];
                    onstk[w] = 0;
                    scc_of[w] = ncomp;
                } while (w != u);
                ncomp++;
            }
            if (sc_top > 0) {
                int p = sc_stack[sc_top - 1];
                if (low[u] < low[p]) low[p] = low[u];
            }
        }
    }
    return ncomp;
}

#endif /* ARKCC_FEATURE_MIR */
