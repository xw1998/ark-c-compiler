/* Regression expectation (machine-checked by examples/run_tests.ps1).
 * sum of 0..9
 * Expected exit code: 45
 */
/* goto_test.c - goto + label
 * Expected: loop 0..9, sum = 45
 */
int main(void) {
    int i = 0;
    int sum = 0;
loop:
    if (i >= 10) goto done;
    sum = sum + i;
    i = i + 1;
    goto loop;
done:
    return sum;
}
