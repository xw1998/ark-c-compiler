/* test_many_args.c — 超过 4 个参数的函数调用（AAPCS 栈传参）
 * 期望退出码：21 (1+2+3+4+5+6)
 */
int sum6(int a, int b, int c, int d, int e, int f) {
    return a + b + c + d + e + f;
}

int main(void) { return sum6(1, 2, 3, 4, 5, 6); }  /* 21 */
