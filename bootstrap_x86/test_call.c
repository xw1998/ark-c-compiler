/* Test: function call only, no globals */
extern int printf(const char *fmt, ...);

int main(void) {
    printf("hello\n");
    return 0;
}
