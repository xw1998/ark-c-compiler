/* test_fpu_hw.c - Hardware FPU path (VFP) verification
 *
 * When g_config.enable_fpu_hw=1, the ARM backend uses native VFP
 * instructions (VADD.F32/VMUL.F32/VCVT etc.) instead of __aeabi_f*
 * soft-float stubs.
 *
 * This test verifies semantics on the C backend; the ARM backend only
 * checks assembly generation (run_tests.ps1 runs -target arm -S -o nul
 * for every .c file).
 *
 * Expected exit code: 40  (1.5 + 2.5 = 4.0, 4.0 * 10 = 40)
 */
float add_f(float a, float b) { return a + b; }

int main(void) {
    float r = add_f(1.5f, 2.5f);
    return (int)(r * 10.0f);  /* 40 */
}
