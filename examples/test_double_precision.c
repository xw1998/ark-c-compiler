/* test_double_precision.c — 双精度浮点（host 端验证）
 *
 * C 后端：内部用 double 计算，返回 3141。
 * ARM 后端：当前用 __aeabi_f* 单精度桩，精度可能略低；
 *           本测试仅在 host 验证 C 后端语义。 */
double pi = 3.14159265358979;

int main(void) {
    int x = (int)(pi * 1000.0);
    return x;  /* 期望 3141 */
}
