/* test_64bit.c - long long 64-bit arithmetic
 * Verifies IR_64BINARY/IR_64CMP are emitted for LLONG operands.
 * Expected exit code: 50
 *   100 + 200 = 300; 300 / 100 = 3; 3 + 47 = 50
 */
long long ll_add(long long a, long long b) { return a + b; }

int main(void) {
    long long a = 100;
    long long b = 200;
    long long c = ll_add(a, b);  /* 300 */
    long long d = c / 100;       /* 3 */
    return (int)d + 47;          /* 3 + 47 = 50 */
}
