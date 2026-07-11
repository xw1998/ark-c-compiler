/* Test: complex pattern matching the irgen.c crash.
 * Pattern: push dest addr, load 4-byte int, compute address, load 8-byte, store 4-byte.
 * This tests whether narrowing happens when the RHS is a complex expression. */

typedef struct {
    int op;
    long long val;
    int aux;
    int line;
} IrInst;

static IrInst g_insts[16];

int main(void) {
    int i = 0;
    int results[4];
    IrInst *p = &g_insts[0];
    /* Complex: assign long long member to int array element via index */
    results[i] = p[i].val;
    /* Also test: assign via computed address */
    results[1] = (int)(p[i].val);
    if (results[0] == 0 && results[1] == 0) return 0;
    return 1;
}
