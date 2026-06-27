/* test_at.c - __at(addr) / __attribute__((at(N))) / #pragma location 解析验证。
 * host 上不验证 MMIO 行为：仅确认编译通过、main 返回 0。
 */

/* GNU 风格 */
static int gnu_at_var __attribute__((at(0x20000100)));

/* ARM Compiler 5 风格 */
static int armcc_at_var __at(0x20000200);

/* #pragma location=N 风格 */
#pragma location=0x20000300
static int pragma_at_var;

int main(void) {
    (void)gnu_at_var;
    (void)armcc_at_var;
    (void)pragma_at_var;
    return 0;
}
