/* test_double_prec.c - double true 64-bit precision (host-side verification)
 *
 * 2^40 = 1099511627776, far beyond the 24-bit mantissa of float
 * (largest exactly representable integer is 2^24).
 *   - double (53-bit mantissa): 2^40 + 1 is exactly representable, so b > a
 *   - float  (24-bit mantissa): 2^40 + 1 == 2^40, so b == a
 *
 * The C backend stores floats in double, preserving precision; the ARM
 * backend uses the 0x200 double-precision flag and goes through the
 * __aeabi_d* family, also preserving 64-bit precision.
 *
 * Expected exit code: 77 */
int main(void) {
    double a = 1099511627776.0;   /* 2^40 */
    double b = a + 1.0;           /* double precision: b > a; single precision: b == a */
    if (b > a) return 77;         /* double precision preserved: pass */
    return 1;
}
