/* feat_asm.c - Inline assembly (passed through to host gcc)
 * Expected exit code: 0   (two inline-asm nop forms, no computation)
 */
int main(void) {
    asm volatile("nop");
    __asm__("nop");
    return 0;
}
