/* test_debug_info.c — DWARF 调试信息生成检查
 *
 * 当 g_config.enable_dwarf=1 或 g_config.debug_info=1 时，ARM 后端
 * 在汇编输出中发射 GNU as 风格的 DWARF 指令：
 *   .file 1 "<src>.c"
 *   .type main, %function
 *   .cfi_startproc / .cfi_endproc
 *   .loc 1 <line>
 *   .size main, .-main
 *
 * 本测试仅作为编译目标存在：run_tests.ps1 会对它运行
 *   arkcc examples\test_debug_info.c -target arm -S -o nul
 * 以及
 *   arkcc examples\test_debug_info.c -target c -o test_debug_info.gen.c
 * 后再 gcc 编译运行，期望退出码 0。
 *
 * 期望退出码：0
 */
int main(void) { return 0; }
