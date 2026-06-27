/* Ark C Compiler - memory
 * Bump Allocator 实现 + 简易工具函数。
 * 注意：所有分配在编译结束后通过 mem_pool_reset 一次性释放。
 */
#include "memory.h"
#include "platform.h"

static unsigned char g_pool[ARK_POOL_SIZE];
static int           g_offset = 0;

void mem_pool_reset(void) {
    g_offset = 0;
}

int mem_pool_used(void) {
    return g_offset;
}

void *mem_pool_alloc(int size) {
    if (size <= 0) size = 1;
    size = (size + 7) & ~7; /* 8 字节对齐，兼容 64-bit host 指针 */
    if (g_offset + size > ARK_POOL_SIZE) {
        ark_abort("memory pool exhausted");
        return 0;
    }
    void *p = &g_pool[g_offset];
    g_offset += size;
    /* 清零 */
    {
        unsigned char *q = (unsigned char *)p;
        int i;
        for (i = 0; i < size; i++) q[i] = 0;
    }
    return p;
}

int ark_strlen(const char *s) {
    int n = 0;
    if (!s) return 0;
    while (s[n]) n++;
    return n;
}

int ark_streq(const char *a, const char *b) {
    if (!a || !b) return a == b;
    while (*a && *b) {
        if (*a != *b) return 0;
        a++; b++;
    }
    return *a == 0 && *b == 0;
}

char *mem_strdup(const char *s) {
    int n;
    char *d;
    int i;
    if (!s) return 0;
    n = ark_strlen(s);
    d = (char *)mem_pool_alloc(n + 1);
    for (i = 0; i <= n; i++) d[i] = s[i];
    return d;
}

char *mem_strndup(const char *s, int n) {
    char *d;
    int i;
    if (!s) return 0;
    d = (char *)mem_pool_alloc(n + 1);
    for (i = 0; i < n; i++) d[i] = s[i];
    d[n] = 0;
    return d;
}

void *mem_realloc(void *old_ptr, int old_size, int new_size) {
    void *p = mem_pool_alloc(new_size);
    int copy = old_size < new_size ? old_size : new_size;
    int i;
    unsigned char *src = (unsigned char *)old_ptr;
    unsigned char *dst = (unsigned char *)p;
    if (old_ptr && old_size > 0) {
        for (i = 0; i < copy; i++) dst[i] = src[i];
    }
    return p;
}
