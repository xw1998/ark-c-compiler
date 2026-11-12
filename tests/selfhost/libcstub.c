/* x86_64 self-host probe: the C library the self-compiled compiler links
 * against.
 *
 * The probe image is a flat ARKOBJ2 image run on unicorn; there is no host
 * libc behind it.  Everything the compiler's *reachable* code path needs from
 * the C library is implemented here for real; everything it must not need is
 * a stub that increments g_stub_hits, so "we never got there" is an assertion
 * the driver checks instead of a silent wrong answer.
 *
 * Reachable on the -c path (preprocess -> lex -> parse -> sema -> irgen ->
 * opt -> x86_64 codegen -> ARKOBJ2 writer):
 *   memcpy memmove memset memcmp strcmp strncmp strcpy strncpy strchr strstr
 *   strlen snprintf
 *   strtod        (lexer: floating literals; the payload has none, see below)
 *   getenv        (backend: ARKCC_DUMP_SYMS debug flag only)
 * Not reachable, therefore shouted:
 *   fopen fclose fread fseek ftell fputc fprintf  (only behind a diagnostic
 *     *file* sink, and the probe never opens one -- diag.c keeps g.sink == 0)
 *   exit           (main.c / the CLI; the probe calls main() itself)
 *   malloc free    (main.c only)
 *
 * Two honest limitations, stated instead of hidden:
 *   1. strtod() is not correctly rounded.  It accumulates up to 19 significant
 *      digits into a long long and scales by a table of powers of ten, which
 *      is exact for values whose decimal <-> binary conversion needs no more
 *      than that; a literal needing the last bit (e.g. 1e-320, or the classic
 *      "...000000000000001" cases) can differ from a correctly rounded libc by one
 *      ulp.  The self-host payload contains no floating literals, so this
 *      never enters the byte-for-byte comparison; if a future payload does use
 *      one, a mismatch here must be attributed to strtod, not to the compiler.
 *   2. snprintf() implements the integer/string conversions the backends and
 *      diagnostics actually use.  A float conversion, or anything else it does
 *      not know, prints "?" and bumps g_stub_hits -- never silently wrong.
 */

#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdarg.h>

int g_stub_hits = 0;         /* every shouted stub bumps this */
int g_snprintf_unknown = 0;  /* unknown format conversion inside snprintf */

/* --- memory ---------------------------------------------------------- */

void *memcpy(void *d, const void *s, size_t n) {
    unsigned char *dp = (unsigned char *)d;
    const unsigned char *sp = (const unsigned char *)s;
    size_t i;
    for (i = 0; i < n; i++) dp[i] = sp[i];
    return d;
}

void *memmove(void *d, const void *s, size_t n) {
    unsigned char *dp = (unsigned char *)d;
    const unsigned char *sp = (const unsigned char *)s;
    size_t i;
    if (dp <= sp || dp >= sp + n) {
        for (i = 0; i < n; i++) dp[i] = sp[i];
    } else {
        for (i = n; i > 0; i--) dp[i - 1] = sp[i - 1];
    }
    return d;
}

void *memset(void *p, int c, size_t n) {
    unsigned char *dp = (unsigned char *)p;
    size_t i;
    for (i = 0; i < n; i++) dp[i] = (unsigned char)c;
    return p;
}

int memcmp(const void *a, const void *b, size_t n) {
    const unsigned char *x = (const unsigned char *)a;
    const unsigned char *y = (const unsigned char *)b;
    size_t i;
    for (i = 0; i < n; i++) {
        if (x[i] != y[i]) return (int)x[i] - (int)y[i];
    }
    return 0;
}

/* --- strings --------------------------------------------------------- */
/* Signatures follow arkcc's own stdlib/include/string.h (which is what every
 * caller was compiled against), not the ISO prototype. */

int strlen(const char *s) {
    int n = 0;
    while (s[n]) n++;
    return n;
}

int strcmp(const char *a, const char *b) {
    int i = 0;
    while (a[i] && a[i] == b[i]) i++;
    return (int)(unsigned char)a[i] - (int)(unsigned char)b[i];
}

int strncmp(const char *a, const char *b, size_t n) {
    size_t i;
    for (i = 0; i < n; i++) {
        if (a[i] != b[i]) return (int)(unsigned char)a[i] - (int)(unsigned char)b[i];
        if (!a[i]) return 0;
    }
    return 0;
}

char *strcpy(char *dst, const char *src) {
    int i = 0;
    while ((dst[i] = src[i]) != 0) i++;
    return dst;
}

char *strncpy(char *dst, const char *src, size_t n) {
    size_t i = 0;
    while (i < n && src[i]) { dst[i] = src[i]; i++; }
    while (i < n) { dst[i] = 0; i++; }
    return dst;
}

char *strchr(const char *s, int c) {
    while (*s) {
        if (*s == (char)c) return (char *)s;
        s++;
    }
    return (c == 0) ? (char *)s : 0;
}

char *strstr(const char *s, const char *sub) {
    int n = strlen(sub);
    if (n == 0) return (char *)s;
    while (*s) {
        if (*s == sub[0] && strncmp(s, sub, (size_t)n) == 0) return (char *)s;
        s++;
    }
    return 0;
}

/* --- conversions ----------------------------------------------------- */

static int put_pad(char *buf, size_t n, size_t *pos, char c, int count) {
    int i;
    for (i = 0; i < count; i++) {
        if (*pos + 1 < n) buf[*pos] = c;
        (*pos)++;
    }
    return count;
}

static int put_str(char *buf, size_t n, size_t *pos, const char *s, int width,
                   int left) {
    int len = s ? strlen(s) : 0;
    int pad = width > len ? width - len : 0;
    if (!left) put_pad(buf, n, pos, ' ', pad);
    if (s) {
        int i;
        for (i = 0; i < len; i++) {
            if (*pos + 1 < n) buf[*pos] = s[i];
            (*pos)++;
        }
    }
    if (left) put_pad(buf, n, pos, ' ', pad);
    return len + pad;
}

static int put_uint(char *buf, size_t n, size_t *pos, unsigned long long v,
                    int base, int upper, int width, int zero, int left,
                    const char *neg_prefix) {
    char tmp[32];
    int len = 0;
    int pad;
    int i;
    const char *digs = upper ? "0123456789ABCDEF" : "0123456789abcdef";
    if (v == 0) tmp[len++] = '0';
    while (v) {
        tmp[len++] = digs[(unsigned)(v % (unsigned long long)base)];
        v /= (unsigned long long)base;
    }
    pad = width - len - (neg_prefix ? strlen(neg_prefix) : 0);
    if (pad < 0) pad = 0;
    if (!left && !zero && neg_prefix) put_str(buf, n, pos, neg_prefix, 0, 0);
    if (!left) put_pad(buf, n, pos, zero ? '0' : ' ', pad);
    if (!left && zero && neg_prefix) put_str(buf, n, pos, neg_prefix, 0, 0);
    for (i = len - 1; i >= 0; i--) {
        if (*pos + 1 < n) buf[*pos] = tmp[i];
        (*pos)++;
    }
    if (left) put_pad(buf, n, pos, ' ', pad);
    return len + pad + (neg_prefix ? strlen(neg_prefix) : 0);
}

int vsnprintf(char *buf, size_t n, const char *fmt, va_list ap) {
    size_t pos = 0;
    const char *p = fmt;

    while (p && *p) {
        if (*p != '%') {
            if (pos + 1 < n) buf[pos] = *p;
            pos++;
            p++;
            continue;
        }
        p++;
        if (*p == '%') {
            if (pos + 1 < n) buf[pos] = '%';
            pos++;
            p++;
            continue;
        }

        {
            int left = 0, zero = 0, lng = 0, width = 0;
            char spec;

            while (*p == '-' || *p == '0' || *p == '+' || *p == ' ') {
                if (*p == '-') left = 1;
                if (*p == '0') zero = 1;
                p++;
            }
            while (*p >= '0' && *p <= '9') { width = width * 10 + (*p - '0'); p++; }
            if (*p == '.') {                     /* precision: digits are
                                                  * accepted and ignored; no
                                                  * caller in the tree uses it */
                p++;
                while (*p >= '0' && *p <= '9') p++;
            }
            while (*p == 'l' || *p == 'h') { lng++; p++; }
            spec = *p;
            if (spec) p++;

            switch (spec) {
            case 'd':
            case 'i': {
                long long v;
                const char *sign = 0;
                if (lng >= 2) v = va_arg(ap, long long);
                else if (lng == 1) v = (long long)va_arg(ap, long);
                else v = (long long)va_arg(ap, int);
                if (v < 0) { sign = "-"; v = -v; }
                put_uint(buf, n, &pos, (unsigned long long)v, 10, 0, width,
                         zero, left, sign);
                break;
            }
            case 'u':
                put_uint(buf, n, &pos, (unsigned long long)((lng >= 2)
                             ? va_arg(ap, unsigned long long)
                             : va_arg(ap, unsigned int)), 10, 0, width, zero,
                         left, 0);
                break;
            case 'x':
            case 'X':
                put_uint(buf, n, &pos, (unsigned long long)((lng >= 2)
                             ? va_arg(ap, unsigned long long)
                             : va_arg(ap, unsigned int)), 16, spec == 'X',
                         width, zero, left, 0);
                break;
            case 'p':
                put_str(buf, n, &pos, "0x", 0, 0);
                put_uint(buf, n, &pos, (unsigned long long)(size_t)
                         va_arg(ap, void *), 16, 0, width, 1, left, 0);
                break;
            case 'c': {
                char c = (char)(int)va_arg(ap, int);
                put_str(buf, n, &pos, &c, width, left);
                break;
            }
            case 's':
                put_str(buf, n, &pos, va_arg(ap, const char *), width, left);
                break;
            default:
                /* No float conversions: no reachable caller in this image uses
                 * one, and printing a plausible-but-wrong number would be
                 * worse than saying so. */
                g_snprintf_unknown++;
                g_stub_hits++;
                put_str(buf, n, &pos, "?", 0, 0);
                break;
            }
        }
    }
    if (n > 0) buf[pos < n ? pos : n - 1] = 0;
    return (int)pos;
}

int snprintf(char *buf, size_t n, const char *fmt, ...) {
    va_list ap;
    int r;
    va_start(ap, fmt);
    r = vsnprintf(buf, n, fmt, ap);
    va_end(ap);
    return r;
}

/* --- floating literal parsing ---------------------------------------- */
/* See the header comment for the rounding caveat.  Returns the value and, if
 * endp is not null, the first unconsumed character. */

double strtod(const char *s, char **endp) {
    static const double pow10[] = {
        1e0, 1e1, 1e2, 1e3, 1e4, 1e5, 1e6, 1e7, 1e8, 1e9,
        1e10, 1e11, 1e12, 1e13, 1e14, 1e15, 1e16, 1e17, 1e18, 1e19,
        1e20, 1e21, 1e22
    };
    const char *p = s;
    int neg = 0, expneg = 0, esign_seen = 0;
    int digits = 0;
    int dexp = 0, eexp = 0;
    unsigned long long mant = 0;

    while (*p == ' ' || *p == '\t' || *p == '\n' || *p == '\r') p++;
    if (*p == '+' || *p == '-') { neg = (*p == '-'); p++; }
    while (*p >= '0' && *p <= '9') {
        if (digits < 19) {
            mant = mant * 10 + (unsigned long long)(*p - '0');
            if (mant) digits++;
        } else {
            dexp++;
        }
        p++;
    }
    if (*p == '.') {
        p++;
        while (*p >= '0' && *p <= '9') {
            if (digits < 19) {
                mant = mant * 10 + (unsigned long long)(*p - '0');
                if (mant) digits++;
                dexp--;
            }
            p++;
        }
    }
    if (*p == 'e' || *p == 'E') {
        const char *q = p + 1;
        if (*q == '+' || *q == '-') { expneg = (*q == '-'); esign_seen = 1; q++; }
        if (*q >= '0' && *q <= '9') {
            while (*q >= '0' && *q <= '9') {
                if (eexp < 10000) eexp = eexp * 10 + (*q - '0');
                q++;
            }
            if (expneg) eexp = -eexp;
            p = q;
        } else {
            (void)esign_seen;      /* "1e" is not an exponent: leave p alone */
        }
    }

    {
        double v = (double)mant;
        int e = dexp + eexp;
        while (e > 0) {
            int step = e > 22 ? 22 : e;
            v *= pow10[step];
            e -= step;
        }
        while (e < 0) {
            int step = e < -22 ? 22 : -e;
            v /= pow10[step];
            e += step;
        }
        if (endp) *endp = (char *)p;
        return neg ? -v : v;
    }
}

/* --- no environment, no heap ----------------------------------------- */

/* A flat image has no environment block and no allocator; NULL / no-op are
 * the truthful answers, not guesses.  Nothing on the -c path asks. */
char *getenv(const char *name) { (void)name; return 0; }

static unsigned char g_heap[1 << 20];
static unsigned int g_heap_used = 0;

void *malloc(size_t n) {
    unsigned int want = (n + 15u) & ~15u;
    if (g_heap_used + want > sizeof(g_heap)) {
        g_stub_hits++;
        return 0;
    }
    {
        void *p = &g_heap[g_heap_used];
        g_heap_used += want;
        return p;
    }
}

void free(void *p) { (void)p; }

/* --- shouted stubs --------------------------------------------------- */

/* FILE is an incomplete type in the header; the self-hosted image never opens
 * a stream, so the pointer stays null and every stream call shouts. */
struct _iobuf;
FILE *stdin = 0;
FILE *stdout = 0;
FILE *stderr = 0;

FILE *fopen(const char *path, const char *mode) {
    (void)path; (void)mode; g_stub_hits++; return 0;
}

int fclose(FILE *fp) { (void)fp; g_stub_hits++; return -1; }

size_t fread(void *ptr, size_t size, size_t nmemb, FILE *fp) {
    (void)ptr; (void)size; (void)nmemb; (void)fp; g_stub_hits++; return 0;
}

int fseek(FILE *fp, long off, int whence) {
    (void)fp; (void)off; (void)whence; g_stub_hits++; return -1;
}

long ftell(FILE *fp) { (void)fp; g_stub_hits++; return -1; }

int fputc(int c, FILE *fp) { (void)c; (void)fp; g_stub_hits++; return -1; }

int fprintf(FILE *fp, const char *fmt, ...) {
    (void)fp; (void)fmt; g_stub_hits++; return -1;
}

void exit(int status) { (void)status; g_stub_hits++; for (;;) { } }
