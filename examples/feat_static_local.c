/* Regression expectation (machine-checked by examples/run_tests.ps1).
 * static counter after 3 calls
 * Expected exit code: 3
 */
/* feat_static_local.c - Function-local static variable
 * Expected: static counter equals 3 after 3 calls, returns 3
 */
int counter(void) {
    static int c = 0;
    c = c + 1;
    return c;
}

int main(void) {
    counter();
    counter();
    return counter();   /* 3 */
}
