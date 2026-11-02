/* Regression expectation (machine-checked by examples/run_tests.ps1).
 * g_init(10) + g_zero(0) + g_ro(5)
 * Expected exit code: 15
 */
/* feat_section.c ¡ª __attribute__((section(...)))
 * ÆÚÍû£ºg_init + g_zero + g_ro = 10 + 0 + 5 = 15
 */
int g_init __attribute__((section(".data"))) = 10;
int g_zero __attribute__((section(".bss")));
const int g_ro __attribute__((section(".rodata"))) = 5;

int main(void) {
    return g_init + g_zero + g_ro;
}
