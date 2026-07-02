/* Ark C Compiler - stdlib/src/string.c
 * Minimal C library string/memory function implementation for bare metal
 * (MDK / arkcc ARM backend).
 *
 * Use case: when a project links arkcc-generated .s files via MDK and does
 * not link the Keil ARM standard library, add this file to the project to get
 * minimal implementations of memcpy/memset/memmove/memcmp/strlen/strcpy/strcmp.
 *
 * Note: not compiled by the Makefile by default; host tests use the system libc.
 *       Code style follows C99 and can be compiled directly by armcc/gcc.
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
    /* Handle overlap: if dst > src and ranges overlap, copy backwards. */
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
