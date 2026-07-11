/* Test: 8-byte load followed by 4-byte store without narrowing.
 * This is the pattern that crashes the bootstrap when compiling irgen.c.
 * The IR_LOAD_IDX with es=8 pushes [low, high], then IR_STORE_IDX with
 * es=4 pops [high (as val), low (as addr)] and crashes. */

typedef struct {
    int op;
    long long val;
    int aux;
} IrInst;

static IrInst g_insts[16];

int main(void) {
    IrInst *p = &g_insts[0];
    int x;
    /* Read long long member, assign to int. Should narrow. */
    x = p->val;
    /* Return to prevent optimization */
    if (x == 42) return 0;
    return 1;
}
