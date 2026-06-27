/* Ark C Compiler - platform_stm32
 * STM32 平台抽象层：通过 HAL UART 输出日志。
 *
 * 本文件仅为伪代码占位，移植时需要：
 *   1. 在工程中加入 STM32 HAL；
 *   2. 配置 USART1 PA9/PA10 + 115200 波特率；
 *   3. 链接本文件而不是 platform_host.c。
 */
#include "platform.h"

/* 用户在主工程中提供：
 *   extern UART_HandleTypeDef huart1;
 * 这里仅声明所需的最少接口。
 */
extern void HAL_UART_Transmit_Wrapper(const unsigned char *buf, int len);

/* 简易整数转字符串（不依赖 libc） */
static int ark_itoa(int v, char *buf, int base) {
    int n = 0;
    int neg = 0;
    unsigned int x;
    int i, j;
    char tmp[16];
    if (v < 0 && base == 10) { neg = 1; x = (unsigned int)(-v); }
    else x = (unsigned int)v;
    if (x == 0) { buf[n++] = '0'; buf[n] = 0; return n; }
    while (x) {
        int d = (int)(x % (unsigned int)base);
        tmp[n++] = (char)(d < 10 ? '0' + d : 'A' + d - 10);
        x /= (unsigned int)base;
    }
    if (neg) tmp[n++] = '-';
    for (i = 0, j = n - 1; i < n; i++, j--) buf[i] = tmp[j];
    buf[n] = 0;
    return n;
}

static void uart_puts(const char *s) {
    int n = 0;
    const char *p = s;
    while (*p) { p++; n++; }
    HAL_UART_Transmit_Wrapper((const unsigned char *)s, n);
}

/* 极简 printf 子集：%d %s %x %c */
void ark_log(const char *fmt, ...) {
    char buf[256];
    int n = 0;
    const char *p = fmt;
    /* va_list 在裸机也可用，但若你不想依赖 stdarg.h，可以替换实现 */
    __builtin_va_list ap;
    __builtin_va_start(ap, fmt);
    while (*p && n < (int)sizeof(buf) - 32) {
        if (*p == '%' && p[1]) {
            char c = p[1]; p += 2;
            if (c == 'd') {
                int v = __builtin_va_arg(ap, int);
                n += ark_itoa(v, &buf[n], 10);
            } else if (c == 'x') {
                int v = __builtin_va_arg(ap, int);
                n += ark_itoa(v, &buf[n], 16);
            } else if (c == 's') {
                const char *s = __builtin_va_arg(ap, const char *);
                while (*s && n < (int)sizeof(buf) - 1) buf[n++] = *s++;
            } else if (c == 'c') {
                int v = __builtin_va_arg(ap, int);
                buf[n++] = (char)v;
            } else {
                buf[n++] = c;
            }
        } else {
            buf[n++] = *p++;
        }
    }
    __builtin_va_end(ap);
    buf[n] = 0;
    uart_puts(buf);
}

void ark_abort(const char *msg) {
    if (msg) uart_puts(msg);
    uart_puts("\r\n[arkcc] FATAL: aborting\r\n");
    for (;;) {
        /* 死循环 */
    }
}
