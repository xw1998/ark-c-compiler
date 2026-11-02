/* Regression expectation (machine-checked by examples/run_tests.ps1).
 * prints sum = 10 through va_arg, returns 0
 * Expected exit code: 0
 */
#include <stdio.h>
#include <stdarg.h>

static int sum_varargs(int count, ...)
{
    va_list ap;
    va_start(ap, count);
    int sum = 0;
    for (int i = 0; i < count; i++) {
        sum += va_arg(ap, int);
    }
    va_end(ap);
    return sum;
}

int main(void)
{
    int result = sum_varargs(4, 1, 2, 3, 4);
    printf("sum = %d\n", result);
    return 0;
}
