/* test_const_fold.c - Global variable non-literal initializer / constant expression folding
 *
 * Verifies eval_const_expr evaluates the following at compile time:
 *   - Global scalar initializer: int g_x = 1 + 2 * 3;            -> 7
 *   - Fold after macro expansion: int g_dim = SIZE + 2;            -> 7
 *   - Array dimension with expression: int g_buf[SIZE + 2];        -> 7 ints
 *   - sizeof(type) folding: int g_sz = sizeof(int)*(SIZE+2);       -> 28
 *   - Local constant expression: int local = (10 - 3) * 2;        -> 14
 *
 * Note: We do not take sizeof a variable (e.g. sizeof(g_buf)) because
 * global variable types cannot be resolved at parse time; arkcc only
 * supports sizeof(type) and sizeof(expr) where the type is known.
 *
 * Expected exit code: 127   (g_x(7) + g_dim(7) + local(14) + g_buf[6](99)) */
#define SIZE 5

int g_x   = 1 + 2 * 3;                  /* 7: arithmetic folding */
int g_dim = SIZE + 2;                    /* 7: fold after macro expansion */
int g_sz  = sizeof(int) * (SIZE + 2);    /* 4 * 7 = 28: sizeof(type) + folding */
int g_buf[SIZE + 2];                     /* 7 ints: array dimension constant expression */

int main(void) {
    int local = (10 - 3) * 2;           /* 14: local constant expression */
    (void)g_sz;                          /* just verify it compiles; not part of return value */
    g_buf[g_dim - 1] = 99;              /* g_buf[6] = 99 */
    return g_x + g_dim + local + g_buf[6];  /* 7 + 7 + 14 + 99 = 127 */
}
