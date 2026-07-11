/* Test float/double arithmetic: verifies IR_FADD/FSUB/FMUL/FDIV/FCMP
 * implementation in the x86 backend using x87 FPU.
 * Returns integer results to avoid printf %f float->double promotion. */
extern int printf(const char *fmt, ...);

int g_results[16];
int g_count = 0;

void check(int cond, int idx) {
    g_results[g_count++] = (cond ? 100 + idx : idx);
}

int test_float_arith(void) {
    float a = 1.5f;
    float b = 0.5f;
    float c;
    /* FADD: 1.5 + 0.5 = 2.0 */
    c = a + b;
    check(c > 1.99f && c < 2.01f, 1);
    /* FSUB: 1.5 - 0.5 = 1.0 */
    c = a - b;
    check(c > 0.99f && c < 1.01f, 2);
    /* FMUL: 1.5 * 0.5 = 0.75 */
    c = a * b;
    check(c > 0.74f && c < 0.76f, 3);
    /* FDIV: 1.5 / 0.5 = 3.0 */
    c = a / b;
    check(c > 2.99f && c < 3.01f, 4);
    /* FCMP */
    check(a > b, 5);
    check(!(a < b), 6);
    check(!(a == b), 7);
    check(a != b, 8);
    check(a >= b, 9);
    check(!(a <= b), 10);
    return 0;
}

int test_double_arith(void) {
    double a = 2.25;
    double b = 0.25;
    double c;
    c = a + b;
    check(c > 2.49 && c < 2.51, 11);
    c = a - b;
    check(c > 1.99 && c < 2.01, 12);
    c = a * b;
    check(c > 0.55 && c < 0.57, 13);
    c = a / b;
    check(c > 8.99 && c < 9.01, 14);
    check(a > b, 15);
    check(!(a < b), 16);
    return 0;
}

int main(void) {
    int i;
    int ok = 1;
    g_count = 0;
    test_float_arith();
    test_double_arith();
    for (i = 0; i < g_count; i++) {
        if (g_results[i] < 100) {
            printf("FAIL at test %d (got %d)\n", g_results[i], g_results[i]);
            ok = 0;
        }
    }
    if (ok) printf("All %d float/double tests PASSED\n", g_count);
    return ok ? 0 : 1;
}
