/* Ark C Compiler - sema.h
 * 语义分析：变量重定义/未定义、类型推导（弱）、函数参数检查。
 */
#ifndef ARK_SEMA_H
#define ARK_SEMA_H

#include "ast.h"

int sema_check(AstNode *prog);

/* 常量表达式求值：成功返回 1 并把结果写入 *out_value；失败返回 0。
 * 支持：整数/字符字面量、sizeof、一元 -/~/!、二元算术/位/比较/逻辑、
 * 三目 ?:、enum 常量、AST_CAST 透传。 */
int eval_const_expr(AstNode *node, int *out_value);

/* usual arithmetic conversions (C99 6.3.1.8)：
 * 输入两个操作数类型，返回它们应共同转换到的类型。
 * 实现整型提升（char/short/_Bool/enum -> int）与同 rank 符号规则。
 * 假设 sizeof(long)==sizeof(int)==4（ARM 与 Windows LLP64 一致）。
 * irgen 据此判断比较/移位/除法的有符号性。 */
Type *usual_arith_conv(Type *lt, Type *rt);

#endif /* ARK_SEMA_H */
