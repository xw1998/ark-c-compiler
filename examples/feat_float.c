/* feat_float.c - Floating-point arithmetic + comparison
 * Expected exit code: 42
 */
int main(void) {
    double a = 3.5;
    double b = 2.0;
    double sum = a + b;       /* 5.5 */
    double prod = a * b;      /* 7.0 */
    double diff = a - b;      /* 1.5 */
    double quot = a / b;      /* 1.75 */
    int total = (int)(sum * 10.0); /* 55 */
    int flag = (a > b) ? 1 : 0;    /* 1 */
    int eq = (prod == 7.0) ? 1 : 0;/* 1 */
    (void)diff; (void)quot;
    return total - flag * 14 + eq;  /* 55 - 14 + 1 = 42 */
}
