/* Ark C Compiler - platform.h
 * 平台抽象层：log 与 abort。
 * 编译器核心代码只能通过这里访问平台 API。
 */
#ifndef ARK_PLATFORM_H
#define ARK_PLATFORM_H

#include "common.h"
#include <stdarg.h>

/* 日志输出，类似 printf */
void ark_log(const char *fmt, ...);

/* 严重错误，终止程序 */
void ark_abort(const char *msg);

#endif /* ARK_PLATFORM_H */
