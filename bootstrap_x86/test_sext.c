/* Minimal test: int -> long long parameter passing */
extern int printf(const char *fmt, ...);

static int g_dummy = 0;

/* Force val to be a long long parameter */
static void check_val(long long val, int expected) {
    if (val == expected) {
        printf("OK: val=%lld\n", val);
    } else {
        printf("FAIL: val=%lld expected=%d\n", val, expected);
    }
}

int main(void) {
    int delta = -1;
    int inc = 1;
    /* This should call check_val(-1, -1) */
    check_val(delta, -1);
    check_val(inc, 1);
    check_val(-1, -1);
    return 0;
}
