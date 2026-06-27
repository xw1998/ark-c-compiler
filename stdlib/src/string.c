/* Ark C Compiler - stdlib/src/string.c
 * 极简 C 库字符串/内存函数实现，面向裸机（MDK / arkcc ARM 后端）。
 *
 * 适用场景：当工程使用 arkcc 生成的 .s 文件被 MDK 链接，且不链接 keil
 * arm 标准库时，可把本文件加入工程获得 memcpy/memset/memmove/memcmp/
 * strlen/strcpy/strcmp 的最简实现。
 *
 * 注意：不会被 Makefile 默认编译；host 测试使用系统 libc。
 *      代码风格遵循 C99，可被 armcc/gcc 直接编译。
 */
#include <stddef.h>
#include <string.h>

void *memcpy(void *dst, const void *src, size_t n) {
    unsigned char *d = (unsigned char *)dst;
    const unsigned char *s = (const unsigned char *)src;
    while (n--) *d++ = *s++;
    return dst;
}

void *memset(void *dst, int c, size_t n) {
    unsigned char *d = (unsigned char *)dst;
    while (n--) *d++ = (unsigned char)c;
    return dst;
}

void *memmove(void *dst, const void *src, size_t n) {
    unsigned char *d = (unsigned char *)dst;
    const unsigned char *s = (const unsigned char *)src;
    /* 处理重叠：若 dst > src 且区间重叠，倒序复制。 */
    if (d == s || n == 0) return dst;
    if (d < s || d >= s + n) {
        while (n--) *d++ = *s++;
    } else {
        d += n; s += n;
        while (n--) *--d = *--s;
    }
    return dst;
}

int memcmp(const void *a, const void *b, size_t n) {
    const unsigned char *p = (const unsigned char *)a;
    const unsigned char *q = (const unsigned char *)b;
    while (n--) {
        if (*p != *q) return (int)*p - (int)*q;
        p++; q++;
    }
    return 0;
}

size_t strlen(const char *s) {
    const char *p = s;
    while (*p) p++;
    return (size_t)(p - s);
}

char *strcpy(char *dst, const char *src) {
    char *d = dst;
    while ((*d++ = *src++) != 0) {}
    return dst;
}

int strcmp(const char *a, const char *b) {
    while (*a && *a == *b) { a++; b++; }
    return (int)(unsigned char)*a - (int)(unsigned char)*b;
}
