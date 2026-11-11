/* Ark C Compiler stdlib - stdlib.c
 * C99 7.20: general utilities.
 *
 * 这里只有"实现",没有平台假设: 不调用宿主 libc, 不用 sbrk/brk.
 * 堆在 heap.c (malloc/free/calloc/realloc), 退出与 atexit 在 exit.c,
 * 信号在 signal.c, errno 的定义在 errno.c.
 *
 * 数值转换一律走 strtoull/strtoll 的核心: 逐位累加 + 乘加前先比较,
 * 越界置 errno=ERANGE 并返回饱和值 (C99 7.20.1.4p8), 不是静默回绕.
 */
#include <stdlib.h>
#include <errno.h>
#include <stddef.h>

#define ARK_ULL_MAX 0xFFFFFFFFFFFFFFFFULL
#define ARK_LL_MAX  0x7FFFFFFFFFFFFFFFLL
#define ARK_LL_MIN  (-0x7FFFFFFFFFFFFFFFLL - 1)

/* ------------------------------------------------------------------ */
/* 字符判定: 不引 ctype.h, 免得两份实现互相依赖                         */
/* ------------------------------------------------------------------ */
static int ark_isdigit(int c) { return c >= '0' && c <= '9'; }

static int ark_isspace(int c)
{
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
}

static int ark_digitval(int c)
{
    if (c >= '0' && c <= '9') return c - '0';
    if (c >= 'a' && c <= 'z') return c - 'a' + 10;
    if (c >= 'A' && c <= 'Z') return c - 'A' + 10;
    return 99;                  /* 不是数字字符 */
}

/* ------------------------------------------------------------------ */
/* 整数转换核心                                                       */
/* ------------------------------------------------------------------ */
/* 返回无符号结果; neg 置 1 表示前面有 '-' (用于 strtoll 的符号),
 * ovf 置 1 表示溢出. endp 按 C99 规则回填. */
static unsigned long long ark_strtoull(const char *s, char **endp, int base, int *neg, int *ovf)
{
    const char *p = s;
    unsigned long long acc = 0;
    int any = 0, d, n;

    *neg = 0;
    *ovf = 0;
    if (endp) *endp = (char *)s;

    while (ark_isspace((unsigned char)*p)) p++;

    if (*p == '+' || *p == '-') {
        if (*p == '-') *neg = 1;
        p++;
    }

    if ((base == 0 || base == 16) && p[0] == '0' && (p[1] == 'x' || p[1] == 'X')
        && ark_digitval((unsigned char)p[2]) < 16) {
        p += 2;
        base = 16;
    } else if (base == 0 && p[0] == '0') {
        base = 8;
    } else if (base == 0) {
        base = 10;
    }
    if (base < 2 || base > 36) {
        /* 非法 base: C99 未定义, 这里明确报错而不是给个数 */
        errno = EINVAL;
        if (endp) *endp = (char *)s;
        return 0;
    }

    for (;;) {
        d = ark_digitval((unsigned char)*p);
        if (d >= base) break;
        any = 1;
        /* 溢出判定: acc*base + d > ULLONG_MAX  <=>  acc > (MAX - d)/base */
        if (acc > (ARK_ULL_MAX - (unsigned long long)d) / (unsigned long long)base) {
            *ovf = 1;
        } else {
            acc = acc * (unsigned long long)base + (unsigned long long)d;
        }
        p++;
    }

    if (!any) {
        /* 没有一位数字: 不是转换失败的错误码, 而是"没转换" (C99 7.20.1.4p7):
         * 返回 0 且 endp 回填原指针. 早先的实现会顺手把 *p 吃掉一位. */
        if (endp) *endp = (char *)s;
        return 0;
    }
    if (endp) *endp = (char *)p;
    if (*ovf) errno = ERANGE;
    (void)n;
    return acc;
}

unsigned long long strtoull(const char *s, char **endp, int base)
{
    int neg, ovf;
    unsigned long long v = ark_strtoull(s, endp, base, &neg, &ovf);
    if (ovf) {
        /* 累加已停在上界之前, v 不是"真值", 只用它判号: 饱和到范围端点 */
        errno = ERANGE;
        return neg ? 0ULL : ARK_ULL_MAX;
    }
    return neg ? (unsigned long long)(0ULL - v) : v;
}

unsigned long strtoul(const char *s, char **endp, int base)
{
    int neg, ovf;
    unsigned long long v = ark_strtoull(s, endp, base, &neg, &ovf);
    if (ovf || v > 0xFFFFFFFFULL) {
        errno = ERANGE;
        return neg ? 0UL : 0xFFFFFFFFUL;
    }
    if (neg) v = 0ULL - v;
    if (v > 0xFFFFFFFFULL) {
        errno = ERANGE;
        return 0xFFFFFFFFUL;
    }
    return (unsigned long)v;
}

long long strtoll(const char *s, char **endp, int base)
{
    int neg, ovf;
    unsigned long long v = ark_strtoull(s, endp, base, &neg, &ovf);
    if (neg) {
        if (ovf || v > 0x8000000000000000ULL) {
            errno = ERANGE;
            return ARK_LL_MIN;
        }
        return (long long)(0ULL - v);
    }
    if (ovf || v > 0x7FFFFFFFFFFFFFFFULL) {
        errno = ERANGE;
        return ARK_LL_MAX;
    }
    return (long long)v;
}

long strtol(const char *s, char **endp, int base)
{
    long long v = strtoll(s, endp, base);
    if (v > 2147483647LL) {
        errno = ERANGE;
        return 2147483647L;
    }
    if (v < -2147483647LL - 1) {
        errno = ERANGE;
        return -2147483647L - 1;
    }
    return (long)v;
}

int atoi(const char *s) { return (int)strtol(s, (char **)0, 10); }
long atol(const char *s) { return strtol(s, (char **)0, 10); }
long long atoll(const char *s) { return strtoll(s, (char **)0, 10); }

/* ------------------------------------------------------------------ */
/* 浮点转换                                                           */
/* ------------------------------------------------------------------ */
/* 不做正确舍入以外的花样: 十进制位累到 double, 再乘/除 10^exp.
 * 三位以上尾数在 double 里会有 1 ulp 级误差, 这是 double 精度决定的,
 * 不假装支持 strtold 的 long double (arkcc 的 long double 就是 double). */
double strtod(const char *s, char **endp)
{
    const char *p = s;
    double v = 0.0, scale = 1.0;
    int neg = 0, any = 0, exp = 0, eneg = 0;

    if (endp) *endp = (char *)s;
    while (ark_isspace((unsigned char)*p)) p++;
    if (*p == '+' || *p == '-') {
        if (*p == '-') neg = 1;
        p++;
    }
    while (ark_isdigit((unsigned char)*p)) {
        v = v * 10.0 + (double)(*p - '0');
        any = 1;
        p++;
    }
    if (*p == '.') {
        p++;
        while (ark_isdigit((unsigned char)*p)) {
            scale = scale * 10.0;
            v = v * 10.0 + (double)(*p - '0');
            any = 1;
            p++;
        }
    }
    if (!any) {
        if (endp) *endp = (char *)s;
        return 0.0;
    }
    if (*p == 'e' || *p == 'E') {
        const char *e = p + 1;
        if (*e == '+' || *e == '-') {
            if (*e == '-') eneg = 1;
            e++;
        }
        if (ark_isdigit((unsigned char)*e)) {
            while (ark_isdigit((unsigned char)*e)) {
                exp = exp * 10 + (*e - '0');
                if (exp > 4932) exp = 4932;   /* 别让 int 先溢出 */
                e++;
            }
            p = e;
        }
    }
    v = v / scale;
    {
        double pw = pow(10.0, (double)(exp > 400 ? 400 : exp));
        int left = exp > 400 ? exp - 400 : 0;
        while (left > 0) {
            int step = left > 400 ? 400 : left;
            pw = pw * pow(10.0, (double)step);
            left -= step;
            if (pw > 1.0e308) break;
        }
        if (eneg) v = v / pw;
        else      v = v * pw;
    }
    if (neg) v = -v;
    if (endp) *endp = (char *)p;
    return v;
}

double atof(const char *s) { return strtod(s, (char **)0); }
float strtof(const char *s, char **endp) { return (float)strtod(s, endp); }
long double strtold(const char *s, char **endp) { return (long double)strtod(s, endp); }

/* ------------------------------------------------------------------ */
/* 整数算术                                                           */
/* ------------------------------------------------------------------ */
int abs(int j) { return j < 0 ? -j : j; }
long labs(long j) { return j < 0 ? -j : j; }
long long llabs(long long j) { return j < 0 ? -j : j; }

div_t div(int n, int d)
{
    div_t r;
    r.quot = n / d;
    r.rem  = n % d;
    return r;
}

ldiv_t ldiv(long n, long d)
{
    ldiv_t r;
    r.quot = n / d;
    r.rem  = n % d;
    return r;
}

lldiv_t lldiv(long long n, long long d)
{
    lldiv_t r;
    r.quot = n / d;
    r.rem  = n % d;
    return r;
}

/* ------------------------------------------------------------------ */
/* 随机数: 32 位 LCG, 取高位 (低位的周期与相关性都差)                    */
/* ------------------------------------------------------------------ */
static unsigned long g_rand_state = 1u;

void srand(unsigned int seed)
{
    /* 种子 0 会让 LCG 停在 0 上, 换成奇数常量 */
    g_rand_state = seed ? (unsigned long)seed : 0x9E3779B9u;
}

int rand(void)
{
    g_rand_state = g_rand_state * 1103515245u + 12345u;
    return (int)((g_rand_state >> 16) & 0x7FFF);
}

/* ------------------------------------------------------------------ */
/* 排序与检索                                                          */
/* ------------------------------------------------------------------ */
static void ark_swap(unsigned char *a, unsigned char *b, unsigned int sz)
{
    unsigned int i;
    for (i = 0; i < sz; i++) {
        unsigned char t = a[i];
        a[i] = b[i];
        b[i] = t;
    }
}

/* 小数组走插入排序: 快排在小 n 上的递归/开销不值 */
static void ark_insertion(unsigned char *base, unsigned int n, unsigned int sz,
                          int (*cmp)(const void *, const void *))
{
    unsigned int i, j;
    for (i = 1; i < n; i++) {
        j = i;
        while (j > 0 && cmp(base + (j - 1) * sz, base + j * sz) > 0) {
            ark_swap(base + (j - 1) * sz, base + j * sz, sz);
            j--;
        }
    }
}

#define ARK_QSORT_CUTOFF 12

static void ark_qsort(unsigned char *base, unsigned int n, unsigned int sz,
                      int (*cmp)(const void *, const void *))
{
    unsigned int i, last;
    if (n <= ARK_QSORT_CUTOFF) {
        ark_insertion(base, n, sz, cmp);
        return;
    }
    /* 中位枢轴放到 0 号位 */
    {
        unsigned int mid = n / 2;
        if (cmp(base, base + mid * sz) > 0) ark_swap(base, base + mid * sz, sz);
        if (cmp(base, base + (n - 1) * sz) > 0) ark_swap(base, base + (n - 1) * sz, sz);
        if (cmp(base + mid * sz, base + (n - 1) * sz) > 0)
            ark_swap(base + mid * sz, base + (n - 1) * sz, sz);
        ark_swap(base, base + mid * sz, sz);
    }
    last = 0;
    for (i = 1; i < n; i++) {
        if (cmp(base + i * sz, base) < 0) {
            last++;
            if (last != i) ark_swap(base + last * sz, base + i * sz, sz);
        }
    }
    ark_swap(base, base + last * sz, sz);
    if (last > 1) ark_qsort(base, last, sz, cmp);
    if (n - last - 1 > 1) ark_qsort(base + (last + 1) * sz, n - last - 1, sz, cmp);
}

void qsort(void *base, size_t n, size_t sz, int (*cmp)(const void *, const void *))
{
    if (!base || sz == 0 || n < 2 || !cmp) return;
    ark_qsort((unsigned char *)base, (unsigned int)n, (unsigned int)sz, cmp);
}

void *bsearch(const void *key, const void *base, size_t n, size_t sz,
              int (*cmp)(const void *, const void *))
{
    size_t lo = 0, hi = n;
    const unsigned char *b = (const unsigned char *)base;
    if (!key || !b || sz == 0 || !cmp) return (void *)0;
    while (lo < hi) {
        size_t mid = lo + (hi - lo) / 2;
        int r = cmp(key, b + mid * sz);
        if (r < 0) hi = mid;
        else if (r > 0) lo = mid + 1;
        else return (void *)(b + mid * sz);
    }
    return (void *)0;
}

/* ------------------------------------------------------------------ */
/* 其它                                                               */
/* ------------------------------------------------------------------ */
/* arkcc 自带的扩展, 不是 C 标准. base 只支持 2..36. */
char *itoa(int value, char *s, int base)
{
    char tmp[36];
    int i = 0, neg = 0;
    unsigned int v;

    if (base < 2 || base > 36) {
        errno = EINVAL;
        if (s) s[0] = 0;
        return s;
    }
    if (value < 0 && base == 10) {
        neg = 1;
        v = (unsigned int)(-(long)value);
    } else {
        v = (unsigned int)value;
    }
    if (v == 0) tmp[i++] = '0';
    while (v) {
        int d = (int)(v % (unsigned int)base);
        tmp[i++] = (char)(d < 10 ? '0' + d : 'a' + d - 10);
        v = v / (unsigned int)base;
    }
    {
        int j = 0;
        if (neg) s[j++] = '-';
        while (i > 0) s[j++] = tmp[--i];
        s[j] = 0;
    }
    return s;
}

/* freestanding 环境没有环境变量表: 明确返回 NULL (C99 允许) */
char *getenv(const char *name) { (void)name; return (char *)0; }

/* 没有 shell 可调: 明确失败, 不假装成功 */
int system(const char *s) { (void)s; return -1; }
