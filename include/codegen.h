/* Ark C Compiler - codegen.h
 * 后端通用的汇编文本输出缓冲与字符串/整数格式化工具。
 * 各后端共享 AsmBuffer。原 codegen_program 接口被后端表替代。
 */
#ifndef ARK_CODEGEN_H
#define ARK_CODEGEN_H

#include "ir.h"

typedef struct {
    char *buf;
    int   len;
    int   cap;
} AsmBuffer;

void asmbuf_init(AsmBuffer *b);
void asmbuf_putc(AsmBuffer *b, char c);
void asmbuf_puts(AsmBuffer *b, const char *s);
void asmbuf_int(AsmBuffer *b, int v);
void asmbuf_printf_int(AsmBuffer *b, const char *prefix, int v, const char *suffix);

#endif /* ARK_CODEGEN_H */
