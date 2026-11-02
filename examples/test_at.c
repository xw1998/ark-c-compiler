/* Regression expectation (machine-checked by examples/run_tests.ps1).
 * parse/emit only; no MMIO behaviour is exercised on the host
 * Expected exit code: 0
 */
/* test_at.c - __at(addr) / __attribute__((at(N))) / #pragma location parsing verification.
 * On host we do not verify MMIO behavior: just confirm it compiles and main returns 0.
 */

/* GNU style */
static int gnu_at_var __attribute__((at(0x20000100)));

/* ARM Compiler 5 style */
static int armcc_at_var __at(0x20000200);

/* #pragma location=N style */
#pragma location=0x20000300
static int pragma_at_var;

int main(void) {
    (void)gnu_at_var;
    (void)armcc_at_var;
    (void)pragma_at_var;
    return 0;
}
