/* test_fpu_hw.c — 硬件 FPU 路径（VFP）验证
 *
 * 当 g_config.enable_fpu_hw=1 时，ARM 后端使用 VFP 原生指令
 * (VADD.F32/VMUL.F32/VCVT 等) 而非 __aeabi_f* 软浮点桩。
 *
 * 本测试在 C 后端验证语义正确性，ARM 后端仅做汇编生成检查
 * （run_tests.ps1 对所有 .c 都会跑 -target arm -S -o nul）。
 *
 * 期望退出码：40  (1.5 + 2.5 = 4.0, 4.0 * 10 = 40)
 */
float add_f(float a, float b) { return a + b; }

int main(void) {
    float r = add_f(1.5f, 2.5f);
    return (int)(r * 10.0f);  /* 40 */
}
