/* test_compound_literal.c - Compound literals (C99)
 * Expected exit code: 3
 */
int main(void) {
    int *p = (int[]){1, 2, 3};
    return p[2];   /* 3 */
}
