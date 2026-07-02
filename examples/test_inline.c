/* test_inline.c - Automatic function inlining test
 * Expected exit code: 7
 * Build and run: arkcc examples\test_inline.c -target c -O2 -o ti.gen.c
 *                gcc -o ti.gen.exe ti.gen.c && ./ti.gen.exe
 */
static int add(int a, int b) { return a + b; }
static int mul(int a, int b) { return a * b; }

int main(void) {
    /* add(3, 4) and mul(2, 3) should be inlined; final return is 7 */
    int x = add(3, 4);   /* 7 */
    int y = mul(2, 3);   /* 6 */
    return x - y + 6;    /* 7 - 6 + 6 = 7 */
}
