/* test_compound_literal.c — 复合字面量（C99）
 * 期望退出码：3
 */
int main(void) {
    int *p = (int[]){1, 2, 3};
    return p[2];   /* 3 */
}
