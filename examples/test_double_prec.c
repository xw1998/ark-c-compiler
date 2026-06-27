/* test_double_prec.c — double 真 64 位精度（host 端验证）
 *
 * 2^40 = 1099511627776，远超 float 的 24 位尾数（最大精确整数 2^24）。
 *   - double（53 位尾数）：2^40 + 1 可精确表示，故 b > a
 *   - float（24 位尾数）：2^40 + 1 == 2^40，b == a
 *
 * C 后端用 double 存储浮点，应保留精度；ARM 后端经 0x200 双精度标志
 * 走 __aeabi_d* 系列，同样保留 64 位精度。
 *
 * 期望退出码：77 */
int main(void) {
    double a = 1099511627776.0;   /* 2^40 */
    double b = a + 1.0;           /* 双精度下 b > a；单精度下 b == a */
    if (b > a) return 77;         /* 双精度保留：通过 */
    return 1;
}
