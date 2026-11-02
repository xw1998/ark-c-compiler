/* Regression expectation (machine-checked by examples/run_tests.ps1).
 * q(14) + r(2) + (0x12345 & 0xFF = 69) + 15
 * Expected exit code: 100
 */
/* feat_div.c - Integer division, modulo, large immediates
 * Expected: 100 / 7 = 14; 100 % 7 = 2; 14 + 2 + 84 = 100
 */
int main(void) {
    int a = 100;
    int b = 7;
    int q = a / b;       /* 14 */
    int r = a % b;       /* 2  */
    int big = 0x12345;   /* 74565 */
    int low = big & 0xFF; /* 0x45 = 69 */
    return q + r + low + 15;  /* 14 + 2 + 69 + 15 = 100 */
}
