/* feat_asm.c - Inline assembly (passed through to host gcc)
 * Expected exit code: 0 (successful nop)
 */
int main(void) {
    asm volatile("nop");
    __asm__("nop");
    return 0;
}
