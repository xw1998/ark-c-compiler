/* Test 64-bit arithmetic: this exercises the original crash path
 * where x /= 10 with x as unsigned long long only pushed 4 bytes
 * instead of 8, causing __udivdi3 to read garbage. */
extern int printf(const char *fmt, ...);
extern void asmbuf_putc(void *b, char c);

static char *uitoa_buf;
static int uitoa_pos;

static void uitoa_putc(char c) {
    uitoa_buf[uitoa_pos++] = c;
}

/* Mimics asmbuf_int unsigned path: x % 10, x /= 10 in a loop */
static void uitoa_ull(unsigned long long v) {
    char tmp[24];
    int n = 0;
    int i;
    unsigned long long x = v;
    if (x == 0) tmp[n++] = '0';
    while (x) {
        tmp[n++] = (char)('0' + (int)(x % 10));
        x /= 10;
    }
    for (i = n - 1; i >= 0; i--) uitoa_putc(tmp[i]);
}

int main(void) {
    char buf[32];
    uitoa_buf = buf;
    uitoa_pos = 0;
    uitoa_ull(12345ULL);
    buf[uitoa_pos] = 0;
    printf("result: %s\n", buf);
    if (buf[0] != '1' || buf[1] != '2' || buf[2] != '3' ||
        buf[3] != '4' || buf[4] != '5' || buf[5] != 0) {
        return 1;
    }
    return 0;
}
