/* test_pragma_compat.c - armcc-compatible pragma silent absorption
 * Verifies arkcc is not blocked by these pragmas: diag_suppress / import / push / pop / O0
 * Expected exit code: 0
 */
#pragma diag_suppress 1
#pragma import(__use_no_semihosting)
#pragma push
#pragma pop
#pragma O0

int main(void) { return 0; }
