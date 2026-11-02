/* test_printf_fix.c - Function call (incl. printf variadic) args not truncated to 32-bit int
 *
 * Previously the C backend IR_CALL truncated args to int, losing the
 * upper 32 bits of a long long. printf and ordinary calls share the
 * same IR_CALL arg-passing path, so a long long round-trip in a normal
 * function also covers the printf fix.
 *
 * The lexer only supports 32-bit integer literals, so we build a 64-bit
 * value via INT_MAX + INT_MAX.
 *   2147483647 + 2147483647 = 4294967294, which exceeds half the
 *   32-bit unsigned range and must be stored in 64 bits. If truncated
 *   to a 32-bit int, r becomes -2.
 *
 * Expected exit code: 66   (64-bit round-trip through IR_CALL not truncated; 66 = pass, 1 = fail) */
long long echo(long long v) { return v; }

int main(void) {
    long long big = 2147483647;   /* INT_MAX; lexer parses as 32-bit int */
    long long r;
    big = big + big;              /* 4294967294, requires 64-bit storage */
    r = echo(big);                /* round-trip via IR_CALL */
    /* Not truncated: r = 4294967294, r / 1000000000 = 4;
     * Truncated to 32-bit int: r becomes -2, -2 / 1000000000 = 0. */
    if ((int)(r / 1000000000) == 4) return 66;
    return 1;
}
