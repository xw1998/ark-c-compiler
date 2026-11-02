/* Regression expectation (machine-checked by examples/run_tests.ps1).
 * factorial(5)
 * Expected exit code: 120
 */
int factorial(int n) {
    if (n <= 1) return 1;
    return n * factorial(n - 1);
}

int main(void) {
    return factorial(5);
}
