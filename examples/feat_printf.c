/* feat_printf.c — printf 各种格式（c 后端透传给宿主 libc）
 * 期望：返回 0；运行时输出多行
 */
int main(void) {
    int n = 42;
    int hex = 0xDEAD;
    char *s = "ark";
    printf("dec=%d hex=%x str=%s percent=%%\n", n, hex, s);
    printf("padding=[%5d] zero=[%05d]\n", n, n);
    return 0;
}
