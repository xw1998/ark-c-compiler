/* Ark C Compiler - scatter.c
 * ARM scatter 加载描述文件解析器。
 *
 * 支持语法子集（armlink 兼容）：
 *   LR_IROM1 0x08000000 0x00100000 {
 *       ER_IROM1 0x08000000 0x00100000 {
 *           *.o (RESET, +First)
 *           *(InRoot$$Sections)
 *           .ANY (+RO)
 *       }
 *       ER_IRAM1 0x20000000 0x00020000 {
 *           .ANY (+RW +ZI)
 *       }
 *   }
 *
 * 解析策略：逐 token 读取，识别 LR_<name> <addr> 与 ER_<name> <addr>，
 * 把 { ... } 内的选择器原文记录到 selectors 字段。属性关键字（如 ABSOLUTE、
 * OVERLAY）与大小字段被解析但当前仅记录地址。注释以 ';' 开头到行尾。
 */
#include "scatter.h"
#include "memory.h"
#include "platform.h"
#include "common.h"
#include <stdio.h>
#include <string.h>
#include <ctype.h>

/* 跳过空白与注释（; 到行尾） */
static const char *skip_ws(const char *p) {
    for (;;) {
        while (*p && isspace((unsigned char)*p)) p++;
        if (*p == ';') {
            while (*p && *p != '\n') p++;
            continue;
        }
        break;
    }
    return p;
}

/* 读取标识符（字母/数字/下划线/$）到 out，返回标识符结尾。
 * out 容量至少 64 字节。 */
static const char *read_ident(const char *p, char *out) {
    int n = 0;
    while (*p && (isalnum((unsigned char)*p) || *p == '_' || *p == '$')) {
        if (n < 63) out[n++] = *p;
        p++;
    }
    out[n] = 0;
    return p;
}

/* 解析地址（0x 前缀十六进制或十进制），返回地址结尾。
 * 成功时 *out_addr 被赋值。 */
static const char *read_addr(const char *p, unsigned *out_addr) {
    unsigned v = 0;
    if (p[0] == '0' && (p[1] == 'x' || p[1] == 'X')) {
        p += 2;
        while (*p && isxdigit((unsigned char)*p)) {
            char c = *p;
            int d = (c >= '0' && c <= '9') ? c - '0' :
                    (c >= 'a' && c <= 'f') ? c - 'a' + 10 :
                    (c >= 'A' && c <= 'F') ? c - 'A' + 10 : 0;
            v = v * 16 + (unsigned)d;
            p++;
        }
    } else {
        while (*p && isdigit((unsigned char)*p)) {
            v = v * 10 + (unsigned)(*p - '0');
            p++;
        }
    }
    *out_addr = v;
    return p;
}

/* 收集 { ... } 大括号内的原文（含嵌套），返回匹配 '}' 之后的位置。
 * start 指向开 '{'。结果写入新建缓冲区（mem_pool_alloc），长度 *out_len。 */
static const char *collect_braces(const char *start, char **out_buf, int *out_len) {
    int depth = 0;
    const char *p = start;
    const char *content_start;
    const char *content_end;
    /* 跳到首个 '{' */
    p = skip_ws(p);
    if (*p != '{') return p;
    content_start = p + 1;
    /* 计数嵌套深度，找到匹配 '}' */
    for (;;) {
        if (*p == 0) break;
        if (*p == '{') depth++;
        else if (*p == '}') {
            depth--;
            if (depth == 0) break;
        }
        p++;
    }
    content_end = p;
    if (*p == '}') p++;
    {
        int len = (int)(content_end - content_start);
        char *buf = (char *)mem_pool_alloc(len + 1);
        int i;
        for (i = 0; i < len; i++) buf[i] = content_start[i];
        buf[len] = 0;
        *out_buf = buf;
        *out_len = len;
    }
    return p;
}

int scatter_parse_file(const char *path, ScatterDesc *out) {
    FILE *fp;
    long fsize;
    char *src;
    const char *p;
    int read;

    if (!path || !out) return 1;
    fp = fopen(path, "rb");
    if (!fp) {
        ark_log("[scatter] cannot open %s\n", path);
        return 1;
    }
    fseek(fp, 0, SEEK_END);
    fsize = ftell(fp);
    fseek(fp, 0, SEEK_SET);
    if (fsize <= 0) { fclose(fp); return 1; }
    src = (char *)mem_pool_alloc((int)fsize + 1);
    read = (int)fread(src, 1, (size_t)fsize, fp);
    fclose(fp);
    if (read <= 0) return 1;
    src[read] = 0;

    p = src;
    while (*p) {
        char ident[64];
        p = skip_ws(p);
        if (*p == 0) break;
        /* 期望 LR_<name> */
        p = read_ident(p, ident);
        if (ident[0] == 0) { p++; continue; }
        if (strncmp(ident, "LR_", 3) != 0) {
            /* 非 LR 开头：跳过该 token，忽略行 */
            while (*p && *p != '\n') p++;
            continue;
        }
        {
            ScatterLoadRegion *lr = (ScatterLoadRegion *)mem_pool_alloc(sizeof(ScatterLoadRegion));
            lr->name = mem_strdup(ident);
            lr->load_addr = 0;
            lr->exec_regions = 0;
            lr->next = 0;
            /* 读地址 */
            p = skip_ws(p);
            if (*p == '0' || isdigit((unsigned char)*p)) {
                p = read_addr(p, &lr->load_addr);
            }
            /* 跳过可选大小与属性直到 '{' */
            p = skip_ws(p);
            while (*p && *p != '{' && *p != '\n') p++;
            if (*p == '{') {
                /* 解析大括号内容，提取 ER_<name> */
                char *body;
                int body_len;
                const char *bp;
                p = collect_braces(p, &body, &body_len);
                bp = body;
                while (*bp) {
                    char er_ident[64];
                    bp = skip_ws(bp);
                    if (*bp == 0) break;
                    bp = read_ident(bp, er_ident);
                    if (er_ident[0] == 0) { bp++; continue; }
                    if (strncmp(er_ident, "ER_", 3) == 0) {
                        ScatterExecRegion *er = (ScatterExecRegion *)mem_pool_alloc(sizeof(ScatterExecRegion));
                        er->name = mem_strdup(er_ident);
                        er->load_addr = 0;
                        er->selectors = 0;
                        er->next = 0;
                        bp = skip_ws(bp);
                        /* ER 地址 */
                        if (*bp == '0' || isdigit((unsigned char)*bp)) {
                            bp = read_addr(bp, &er->load_addr);
                        }
                        /* 跳过大小/属性到 '{' */
                        bp = skip_ws(bp);
                        while (*bp && *bp != '{' && *bp != '\n') bp++;
                        if (*bp == '{') {
                            char *sel;
                            int sel_len;
                            bp = collect_braces(bp, &sel, &sel_len);
                            er->selectors = sel;
                        }
                        /* 追加到 lr 链表尾 */
                        {
                            ScatterExecRegion **tail = &lr->exec_regions;
                            while (*tail) tail = &(*tail)->next;
                            *tail = er;
                        }
                    } else {
                        /* 非 ER token，跳过到下一个空白 */
                        while (*bp && !isspace((unsigned char)*bp)) bp++;
                    }
                }
            }
            /* 追加到 out 链表尾 */
            {
                ScatterLoadRegion **tail = &out->load_regions;
                while (*tail) tail = &(*tail)->next;
                *tail = lr;
            }
        }
    }
    ark_log("[scatter] parsed %s\n", path);
    return 0;
}

void scatter_free(ScatterDesc *desc) {
    /* arkcc 使用内存池，此处仅置空指针，避免重复释放。
     * 内存池在程序退出时统一回收。 */
    if (desc) desc->load_regions = 0;
}

void scatter_dump(const ScatterDesc *desc) {
    ScatterLoadRegion *lr;
    if (!desc) return;
    for (lr = desc->load_regions; lr; lr = lr->next) {
        ScatterExecRegion *er;
        ark_log("LR %s @0x%08X\n", lr->name, lr->load_addr);
        for (er = lr->exec_regions; er; er = er->next) {
            ark_log("  ER %s @0x%08X\n", er->name, er->load_addr);
            if (er->selectors) ark_log("    selectors: %s\n", er->selectors);
        }
    }
}
