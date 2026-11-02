/* Regression expectation (machine-checked by examples/run_tests.ps1).
 * (int)(3.14159265358979 * 1000)
 * Expected exit code: 3141
 */
/* test_double_precision.c - Double-precision floating point (host-side verification)
 *
 * C backend: uses double internally, returns 3141.
 * ARM backend: currently uses __aeabi_f* single-precision stubs, possibly
 *             lower precision; this test only verifies C backend semantics on host. */
double pi = 3.14159265358979;

int main(void) {
    int x = (int)(pi * 1000.0);
    return x;  /* expected 3141 */
}
