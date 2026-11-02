/* Regression expectation (machine-checked by examples/run_tests.ps1).
 * 10*20 accumulated 5 times = 1000, >500 so -100
 * Expected exit code: 900
 */
int main(void) {
    int a = 10;
    int b = 20;
    int c = 0;
    int i;
    for (i = 0; i < 5; i = i + 1) {
        c = c + a * b;
    }
    if (c > 500) {
        c = c - 100;
    } else {
        c = c + 1;
    }
    return c;
}
