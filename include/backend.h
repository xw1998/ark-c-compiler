/* Ark C Compiler - backend.h
 * 后端抽象层：把"生成汇编/机器码"接口化。
 *
 * 每个后端在 src/backend/<name>/backend_<name>.c 中实现，并通过
 * 同名导出函数 ark_backend_<name>() 暴露 ArkBackend 指针。
 * registry.c 把所有可用后端串起来，main 通过 -target 选择。
 *
 * 多数后端在 emit_asm 阶段就完成主要工作；assemble/link 对软件型后端
 * （c/x86_64/riscv32）可以是 stub，只需把汇编文本原样转储为字节，
 * 让用户用 gcc/as/nasm 后续处理。
 */
#ifndef ARK_BACKEND_H
#define ARK_BACKEND_H

#include "common.h"
#include "ir.h"

/* 占位的链接上下文，供 ARM 后端使用，其他后端忽略即可。 */
struct LinkContext {
    int dummy;
};

typedef struct ArkBackend {
    const char *name;            /* "arm", "x86_64", "riscv32", "c" */
    const char *triple;          /* 描述字符串 */
    int  pointer_size;           /* 字节 */
    /* IR -> 文本汇编。返回写入字节数（不含终止 NUL），失败返回 -1。 */
    int  (*emit_asm)(IrProgram *m, char *out, int cap);
    /* 文本汇编 -> 机器码。失败返回 -1。 */
    int  (*assemble)(const char *asm_text, unsigned char *out, int cap);
    /* 链接重定位。失败返回 -1。 */
    int  (*link)(unsigned char *code, int size, struct LinkContext *lc);
} ArkBackend;

const ArkBackend *ark_backend_find(const char *name);
const ArkBackend *ark_backend_default(void);
void ark_backend_list(void);

/* 各后端导出函数 */
const ArkBackend *ark_backend_arm(void);
const ArkBackend *ark_backend_x86_64(void);
const ArkBackend *ark_backend_riscv32(void);
const ArkBackend *ark_backend_c(void);

#endif /* ARK_BACKEND_H */
