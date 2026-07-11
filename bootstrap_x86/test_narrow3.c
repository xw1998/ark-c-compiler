/* Test: IrInst.val pattern - read long long member from struct array,
 * assign to int array element. This is the suspected crash pattern. */

typedef struct {
    int op;
    long long val;
    int aux;
} IrInst;

static IrInst g_insts[16];

int main(void) {
    int results[4];
    int i = 0;
    IrInst *p = g_insts;
    /* Read .val (long long) member from p[i], assign to results[i] (int) */
    results[i] = (int)p[i].val;
    /* Also test without cast */
    results[i+1] = p[i].val;
    if (results[0] == 0 && results[1] == 0) return 0;
    return 1;
}
