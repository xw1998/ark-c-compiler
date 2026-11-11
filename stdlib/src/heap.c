/* Ark C Compiler stdlib - heap.c
 * C99 7.20.3: malloc / free / calloc / realloc.
 *
 * 没有 sbrk: 堆就是这块静态 arena, 大小由 ARK_STDLIB_HEAP_SIZE 决定
 * (默认 8 KB, 编译时用 -DARK_STDLIB_HEAP_SIZE=... 改). 板端自托管用的是
 * port/stm32/platform_stm32.c 里那套池分配器, 不链接本文件.
 *
 * 块头 16 字节 (size / free / next / 保留), 载荷按 8 字节对齐:
 * 8 字节是为了让 double 与 long long 落在自然对齐上 —— 4 字节对齐的
 * "能用" 会在 ARM 上变成非对齐访问, 在 RV32 上静默取到错值.
 *
 * 分配策略: 首次适配 + 与后继空闲块合并. 不做分离空闲链: 8 KB 规模上
 * 分离链带来的常数开销大于收益, 而合并已经消掉了最常见的外部碎片.
 */
#include <stdlib.h>
#include <stddef.h>

#ifndef ARK_STDLIB_HEAP_SIZE
#define ARK_STDLIB_HEAP_SIZE (8192)
#endif

#define ARK_ALIGN 8u
#define ARK_BLK_HDR 16u
#define ARK_MIN_PAYLOAD 8u          /* 拆分后剩的最小载荷, 再小就不拆 */

typedef struct ark_blk {
    unsigned int size;              /* 载荷字节数, ARK_ALIGN 的倍数 */
    unsigned int free;              /* 0 = 在用, 1 = 空闲 */
    struct ark_blk *next;           /* 地址序的下一个块, 0 = 最后一块 */
    unsigned int rsv;               /* 占位: 保证块头 16 字节, 载荷 8 对齐 */
} ark_blk;

static unsigned char g_ark_heap[ARK_STDLIB_HEAP_SIZE] __attribute__((aligned(8)));
static ark_blk *g_ark_head;
static int g_ark_heap_ready;

static unsigned int ark_round_up(unsigned int n)
{
    return (n + (ARK_ALIGN - 1u)) & ~(ARK_ALIGN - 1u);
}

static void ark_heap_init(void)
{
    ark_blk *b;
    unsigned int total;
    g_ark_heap_ready = 1;
    total = (unsigned int)sizeof(g_ark_heap);
    if (total <= ARK_BLK_HDR + ARK_MIN_PAYLOAD) {
        g_ark_head = (ark_blk *)0;      /* 堆小到放不下一个块: 老实说没有 */
        return;
    }
    b = (ark_blk *)(void *)g_ark_heap;
    b->size = ark_round_up(total - ARK_BLK_HDR);
    /* 向上取整可能把块尾带出 arena, 收回一个对齐单位 */
    if ((unsigned int)ARK_BLK_HDR + b->size > total) b->size -= ARK_ALIGN;
    b->free = 1;
    b->next = (ark_blk *)0;
    b->rsv = 0;
    g_ark_head = b;
}

/* 相邻就合并: 只有"地址上紧挨着"才算, 跨 arena 的情况本实现不存在 */
static void ark_coalesce(ark_blk *b)
{
    while (b && b->next && b->next->free) {
        ark_blk *n = b->next;
        b->size += ARK_BLK_HDR + n->size;
        b->next = n->next;
    }
}

void *malloc(size_t n)
{
    ark_blk *b;
    unsigned int need;

    if (!g_ark_heap_ready) ark_heap_init();
    if (n == 0) return (void *)0;           /* 由实现定义; 这里明确给 NULL */
    need = ark_round_up((unsigned int)n);

    for (b = g_ark_head; b; b = b->next) {
        if (!b->free || b->size < need) continue;
        if (b->size >= need + ARK_BLK_HDR + ARK_MIN_PAYLOAD) {
            /* 拆分: 后半段留在原地, 前半段被切走 */
            ark_blk *rest = (ark_blk *)(void *)((unsigned char *)b + ARK_BLK_HDR + need);
            rest->size = b->size - need - ARK_BLK_HDR;
            rest->free = 1;
            rest->next = b->next;
            rest->rsv = 0;
            b->size = need;
            b->next = rest;
        }
        b->free = 0;
        return (void *)((unsigned char *)b + ARK_BLK_HDR);
    }
    return (void *)0;                       /* 堆尽: NULL, 不假装成功 */
}

void free(void *p)
{
    ark_blk *b;
    if (!p) return;
    b = (ark_blk *)(void *)((unsigned char *)p - ARK_BLK_HDR);
    b->free = 1;
    ark_coalesce(b);
    /* 合并后还要和"前一个空闲块"合: 单向链找不到前驱, 靠从头扫一次的
     * 代价在 8 KB 规模上可接受, 且能避免长期碎片化 */
    {
        ark_blk *q = g_ark_head;
        while (q && q->next) {
            if (q->free) ark_coalesce(q);
            if (q->next == b) break;
            q = q->next;
        }
        if (q && q->free) ark_coalesce(q);
    }
}

void *calloc(size_t n, size_t sz)
{
    size_t total;
    void *p;
    unsigned char *c;
    size_t i;

    if (n == 0 || sz == 0) return (void *)0;
    total = n * sz;
    if (sz != 0 && total / sz != n) return (void *)0;   /* 乘法溢出: 明确失败 */
    p = malloc(total);
    if (!p) return (void *)0;
    c = (unsigned char *)p;
    for (i = 0; i < total; i++) c[i] = 0;
    return p;
}

void *realloc(void *p, size_t n)
{
    ark_blk *b;
    unsigned int need;
    unsigned char *np;
    unsigned int i;

    if (!p) return malloc(n);
    if (n == 0) { free(p); return (void *)0; }

    b = (ark_blk *)(void *)((unsigned char *)p - ARK_BLK_HDR);
    need = ark_round_up((unsigned int)n);
    if (need <= b->size) {
        /* 缩小: 剩余够一个块就切出去, 否则原样返回 (不制造碎渣) */
        if (b->size >= need + ARK_BLK_HDR + ARK_MIN_PAYLOAD) {
            ark_blk *rest = (ark_blk *)(void *)((unsigned char *)b + ARK_BLK_HDR + need);
            rest->size = b->size - need - ARK_BLK_HDR;
            rest->free = 1;
            rest->next = b->next;
            rest->rsv = 0;
            b->size = need;
            b->next = rest;
            ark_coalesce(rest);
        }
        return p;
    }
    /* 就地长大: 只有紧接着的空闲块才够得着 */
    if (b->next && b->next->free && b->size + ARK_BLK_HDR + b->next->size >= need) {
        ark_coalesce(b);
        if (b->size >= need + ARK_BLK_HDR + ARK_MIN_PAYLOAD) {
            ark_blk *rest = (ark_blk *)(void *)((unsigned char *)b + ARK_BLK_HDR + need);
            rest->size = b->size - need - ARK_BLK_HDR;
            rest->free = 1;
            rest->next = b->next;
            rest->rsv = 0;
            b->size = need;
            b->next = rest;
        }
        return p;
    }
    np = (unsigned char *)malloc(n);
    if (!np) return (void *)0;              /* 原块保持有效, 不丢数据 */
    for (i = 0; i < b->size && i < (unsigned int)n; i++) np[i] = ((unsigned char *)p)[i];
    free(p);
    return np;
}

/* 只读诊断: 供门禁与板上 `mem` 命令看真实占用, 不是 C 标准接口 */
unsigned int ark_heap_used(void)
{
    ark_blk *b;
    unsigned int used = 0;
    if (!g_ark_heap_ready) ark_heap_init();
    for (b = g_ark_head; b; b = b->next) {
        if (!b->free) used += b->size + ARK_BLK_HDR;
    }
    return used;
}

unsigned int ark_heap_capacity(void)
{
    return (unsigned int)sizeof(g_ark_heap);
}
