/* test_asm_func.c - __asm whole-function body (armcc style)
 * Only used for ARM backend syntax + assembly generation check; the C backend
 * uses a naked inline-asm form.
 * Expected program exit code: 0
 */
__asm void boot_jump(void) {
    movs r0, #42
    bx lr
}

int main(void) {
    /* boot_jump is not called directly (its assembly is ARM, cannot run on host x86);
     * we only verify compilation/linking succeeds. */
    return 0;
}
