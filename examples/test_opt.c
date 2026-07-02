/* test_opt.c - IR-level optimization pass verification
 *
 * When g_config.enable_opt_constfold=1, the IR sequence
 *   PUSH_INT a; PUSH_INT b; BINARY op
 * is folded into a single PUSH_INT (a op b).
 *
 * When g_config.enable_opt_dce=1, unreachable instructions
 * after RETURN/JMP are removed.
 *
 * This test relies on constant folding: 1+2 -> 3; 3*0 -> 0; 0+42 -> 42.
 * Note: arkcc IR folding requires both operands to be literal PUSH_INT,
 * while a/b/c are local variables (PUSH_VAR), so only the innermost
 * 1+2 is folded; outer operations still execute at runtime. Result is 42.
 *
 * Expected exit code: 42
 */
int main(void) {
    int a = 1 + 2;       /* folded to 3 */
    int b = a * 0;       /* runtime: 3 * 0 = 0 */
    int c = b + 42;      /* runtime: 0 + 42 = 42 */
    return c;            /* 42 */
}
