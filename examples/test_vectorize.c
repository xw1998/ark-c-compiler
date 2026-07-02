/* test_vectorize.c - Auto-vectorization test
 * Expected exit code: 4
 * Two short arrays added element-wise; loop should be vectorized as SADD16:
 *   c = {2,4,6,8}, returns c[2]-c[0] = 6-2 = 4
 *
 * Build and run (C backend falls back to scalar, equivalent to ARM SIMD):
 *   arkcc examples\test_vectorize.c -target c -O2 -o tv.gen.c
 *   gcc -o tv.gen.exe tv.gen.c && ./tv.gen.exe
 *
 * Check whether ARM assembly emits SADD16:
 *   arkcc examples\test_vectorize.c -target arm -O2 -S
 */
short a[4] = {1, 2, 3, 4};
short b[4] = {1, 2, 3, 4};
short c[4];

int main(void) {
    int i;
    for (i = 0; i < 4; i++) {
        c[i] = a[i] + b[i];
    }
    /* c = {2,4,6,8}, c[2]-c[0] = 6-2 = 4 */
    return (int)(c[2] - c[0]);
}
