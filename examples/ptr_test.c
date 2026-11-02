/* Regression expectation (machine-checked by examples/run_tests.ps1).
 * a[3] = 3*10 through a pointer
 * Expected exit code: 30
 */
/* ptr_test.c - Pointers, arrays and address-of
 * Expected: a[3] = 30
 */
int main(void) {
    int a[5];
    int *p;
    int i;
    int v;
    for (i = 0; i < 5; i = i + 1) a[i] = i * 10;
    p = &a[0];
    v = p[3];
    return v;
}
