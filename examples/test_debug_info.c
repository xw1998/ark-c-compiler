/* test_debug_info.c - DWARF debug information generation check
 *
 * When g_config.enable_dwarf=1 or g_config.debug_info=1, the ARM backend
 * emits GNU as-style DWARF directives in assembly output:
 *   .file 1 "<src>.c"
 *   .type main, %function
 *   .cfi_startproc / .cfi_endproc
 *   .loc 1 <line>
 *   .size main, .-main
 *
 * This test only exists as a build target: run_tests.ps1 runs
 *   arkcc examples\test_debug_info.c -target arm -S -o nul
 * and
 *   arkcc examples\test_debug_info.c -target c -o test_debug_info.gen.c
 * then compiles and runs it with gcc, expecting exit code 0.
 *
 * Expected exit code: 0
 */
int main(void) { return 0; }
