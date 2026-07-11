/* Ark C Compiler - irgen.h
 * Generate IR from AST.
 */
#ifndef ARK_IRGEN_H
#define ARK_IRGEN_H

#include "ast.h"
#include "ir.h"

IrProgram *irgen_program(AstNode *prog);

/* 设置 IR 生成是否使用 8 字节槽模型（C 后端）。
 * 启用后 irgen_widen_to_64 和 irgen_cond_to_bool 成为 no-op，
 * 因为 8 字节 long long 槽无需符号扩展或高低字合并。 */
void irgen_set_64bit_slots(int enabled);

#endif /* ARK_IRGEN_H */
