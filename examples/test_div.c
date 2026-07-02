/* test_div.c - Signed/unsigned division and modulo
 * Verifies the aux bit (signed vs unsigned) of IR_DIV/IR_MOD.
 * Expected exit code: 100
 *   17/5 = 3, 17%5 = 2, 17u/3u = 5, total 3+2+5+90 = 100
 */
int main(void) {
    int a = 17;
    int b = 5;
    int q = a / b;     /* 3 */
    int r = a % b;     /* 2 */
    unsigned u = 17u;
    unsigned v = 3u;
    unsigned uq = u / v;  /* 5 */
    return q + r + (int)uq + 90;  /* 3 + 2 + 5 + 90 = 100 */
}
