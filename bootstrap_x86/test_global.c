/* Minimal test: just a global variable */
extern int printf(const char *fmt, ...);

static int g_val = 42;

int main(void) {
    int x = g_val;
    printf("x=%d\n", x);
    return x;
}
