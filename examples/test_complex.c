/* Regression expectation (machine-checked by examples/run_tests.ps1).
 * sizeof(_Complex double) / 8 = 16 / 8
 * Expected exit code: 2
 */
/* _Complex complex type test */
int main(void) {
    _Complex double z;
    /* Verify sizeof(_Complex double) == 16 (2 * 8) */
    return (int)sizeof(z) / 8;  /* 16/8 = 2 */
}
