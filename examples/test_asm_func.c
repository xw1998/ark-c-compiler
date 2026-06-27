/* test_asm_func.c — __asm 整函数体（armcc 风格）
 * 仅做 ARM 后端的语法+汇编生成检查；C 后端会用 naked 内联汇编。
 * 期望主程序退出码：0
 */
__asm void boot_jump(void) {
    movs r0, #42
    bx lr
}

int main(void) {
    /* 不直接调用 boot_jump（其汇编是 ARM 指令，host x86 不能执行），
     * 仅验证编译/链接通过。 */
    return 0;
}
