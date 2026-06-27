/* feat_asm.c — 内联汇编（透传给宿主 gcc）
 * 期望退出码：0（成功执行 nop）
 */
int main(void) {
    asm volatile("nop");
    __asm__("nop");
    return 0;
}
