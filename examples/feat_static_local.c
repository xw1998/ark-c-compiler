/* feat_static_local.c — 函数内 static 变量
 * 期望：static counter 调用 3 次后值 = 3，返回 3
 */
int counter(void) {
    static int c = 0;
    c = c + 1;
    return c;
}

int main(void) {
    counter();
    counter();
    return counter();   /* 3 */
}
