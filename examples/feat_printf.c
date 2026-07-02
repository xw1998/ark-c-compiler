/* feat_printf.c - printf various formats (C backend passes through to host libc)
 * Expected: returns 0; runtime prints multiple lines
 */
int main(void) {
    int n = 42;
    int hex = 0xDEAD;
    char *s = "ark";
    printf("dec=%d hex=%x str=%s percent=%%\n", n, hex, s);
    printf("padding=[%5d] zero=[%05d]\n", n, n);
    return 0;
}
