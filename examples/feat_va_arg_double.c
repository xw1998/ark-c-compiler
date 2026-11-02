/* Regression expectation (machine-checked by examples/run_tests.ps1).
 * va_arg(ap, double) must read the 8-byte payload, not convert a 4-byte slot
 * value; integer varargs keep working alongside.
 * Expected exit code: 0
 */
/* feat_va_arg_double.c - va_arg of double payloads
 * Every argument occupies one 8-byte slot holding the raw payload, so
 * stdarg.h reinterprets the slot address as `type *`. The old
 * `(type)(*ap++)` form performed a numeric conversion from the slot's
 * integer content and returned ~4.6e18.
 */
#include <stdio.h>
#include <stdarg.h>

static double sum_d(int n, ...) {
    va_list ap;
    double s = 0;
    int i;
    va_start(ap, n);
    for (i = 0; i < n; i++) s += va_arg(ap, double);
    va_end(ap);
    return s;
}

static int sum_i(int n, ...) {
    va_list ap;
    int s = 0;
    int i;
    va_start(ap, n);
    for (i = 0; i < n; i++) s += va_arg(ap, int);
    va_end(ap);
    return s;
}

int main(void) {
    double d = sum_d(3, 1.5, 2.25, 3.25);   /* 7.0 */
    int r = 0;

    if (d < 6.99 || d > 7.01) r += 1;
    if (sum_i(2, 4, 5) != 9) r += 2;

    printf("sum_d = %.2f\n", d);
    return r;
}
