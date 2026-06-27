/* Ark C Compiler - platform_host
 * Host 平台抽象层实现：基于 stdio。
 * 这是唯一允许使用 printf/fprintf/exit 的文件之一。
 */
#include "platform.h"
#include <stdio.h>
#include <stdarg.h>
#include <stdlib.h>

void ark_log(const char *fmt, ...) {
    va_list args;
    va_start(args, fmt);
    vfprintf(stderr, fmt, args);
    va_end(args);
}

void ark_abort(const char *msg) {
    fprintf(stderr, "[arkcc] FATAL: %s\n", msg ? msg : "");
    exit(1);
}
