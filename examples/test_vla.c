/* Regression expectation (machine-checked by examples/run_tests.ps1).
 * sum_vla(5) = 1+2+3+4+5
 * Expected exit code: 15
 */
/* VLA variable-length array test */
int sum_vla(int n) {
    int a[n];  /* VLA */
    int i, s = 0;
    for (i = 0; i < n; i++) a[i] = i + 1;
    for (i = 0; i < n; i++) s += a[i];
    return s;
}

int main(void) {
    return sum_vla(5);  /* 1+2+3+4+5 = 15 */
}
