/* test_inline.c — 自动函数内联测试
 * 期望退出码：7
 * 编译运行：arkcc examples\test_inline.c -target c -O2 -o ti.gen.c
 *           gcc -o ti.gen.exe ti.gen.c && ./ti.gen.exe
 */
static int add(int a, int b) { return a + b; }
static int mul(int a, int b) { return a * b; }

int main(void) {
    /* add(3, 4) 与 mul(2, 3) 都应被内联；最终返回 7 */
    int x = add(3, 4);   /* 7 */
    int y = mul(2, 3);   /* 6 */
    return x - y + 6;    /* 7 - 6 + 6 = 7 */
}
