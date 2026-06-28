/* test_vectorize.c — 自动向量化测试
 * 期望退出码：4
 * 两个 short 数组逐元素相加，循环应被向量化为 SADD16：
 *   c = {2,4,6,8}，返回 c[2]-c[0] = 6-2 = 4
 *
 * 编译运行（C 后端做标量回退，结果与 ARM SIMD 等价）：
 *   arkcc examples\test_vectorize.c -target c -O2 -o tv.gen.c
 *   gcc -o tv.gen.exe tv.gen.c && ./tv.gen.exe
 *
 * 检查 ARM 汇编是否出现 SADD16：
 *   arkcc examples\test_vectorize.c -target arm -O2 -S
 */
short a[4] = {1, 2, 3, 4};
short b[4] = {1, 2, 3, 4};
short c[4];

int main(void) {
    int i;
    for (i = 0; i < 4; i++) {
        c[i] = a[i] + b[i];
    }
    /* c = {2,4,6,8}，c[2]-c[0] = 6-2 = 4 */
    return (int)(c[2] - c[0]);
}
