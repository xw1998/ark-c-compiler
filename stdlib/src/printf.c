/* stdlib/src/printf.c - Ark C Compiler 嵌入式精简版 printf
 *
 * 用途：ARM 后端在 STM32 等裸机平台没有 libc 时使用。
 *       C 后端走宿主 libc，不需要 include 本文件。
 *
 * 支持格式串：
 *   %d %i  — 十进制整数（int）
 *   %u     — 十进制无符号整数（unsigned）
 *   %x %X  — 十六进制无符号整数（小写/大写）
 *   %p     — 指针（输出 "0x" + 8 位 0 填充十六进制）
 *   %s     — 字符串
 *   %c     — 单字符
 *   %%     — 字面量 %
 *   宽度与 '0' 填充：%5d / %05d / %08x
 *
 * 不支持：%f %lf（浮点）、%lld（长整型）、动态精度等。
 *
 * 输出依赖：用户/平台层提供 int putchar(int c)，本文件作为弱依赖引用。
 * STM32 工程通常将 putchar 重定向到 UART/ITM。
 */
#include <stdarg.h>

extern int putchar(int c);

static void print_str(const char *s) {
    if (!s) { /* 安全：避免 NULL 解引用 */
        const char *n = "(null)";
        while (*n) putchar(*n++);
        return;
    }
    while (*s) putchar(*s++);
}

/* 把 long 按 base 进制转字符串再输出，支持负数（仅 base==10 视作有符号）。
 * width/pad: 宽度不足时左侧用 pad 字符（' ' 或 '0'）补齐。 */
static void print_int(long n, int base, int upper, int width, char pad) {
    char buf[24];
    int  i = 0;
    int  neg = 0;
    unsigned long u;
    if (n < 0 && base == 10) { neg = 1; u = (unsigned long)(-n); }
    else                     { u = (unsigned long)n; }
    if (u == 0) buf[i++] = '0';
    while (u) {
        int d = (int)(u % (unsigned long)base);
        buf[i++] = (char)(d < 10 ? '0' + d : (upper ? 'A' : 'a') + d - 10);
        u /= (unsigned long)base;
    }
    if (neg) buf[i++] = '-';
    while (i < width) buf[i++] = pad;
    while (i--) putchar(buf[i]);
}

int printf(const char *fmt, ...) {
    va_list ap;
    int count = 0;
    va_start(ap, fmt);
    while (*fmt) {
        if (*fmt != '%') { putchar(*fmt++); count++; continue; }
        fmt++;
        {
            char pad = ' ';
            int  width = 0;
            if (*fmt == '0') { pad = '0'; fmt++; }
            while (*fmt >= '0' && *fmt <= '9') {
                width = width * 10 + (*fmt - '0');
                fmt++;
            }
            switch (*fmt) {
                case 'd': case 'i':
                    print_int((long)va_arg(ap, int), 10, 0, width, pad); break;
                case 'u':
                    print_int((long)va_arg(ap, unsigned int), 10, 0, width, pad); break;
                case 'x':
                    print_int((long)va_arg(ap, unsigned int), 16, 0, width, pad); break;
                case 'X':
                    print_int((long)va_arg(ap, unsigned int), 16, 1, width, pad); break;
                case 'p':
                    print_str("0x");
                    print_int((long)(unsigned long)va_arg(ap, void *), 16, 0, 8, '0');
                    break;
                case 's':
                    print_str(va_arg(ap, char *)); break;
                case 'c':
                    putchar((char)va_arg(ap, int)); break;
                case '%':
                    putchar('%'); break;
                default:
                    /* 未知格式：原样输出 %X，保持调试可见 */
                    putchar('%');
                    putchar(*fmt);
                    break;
            }
            fmt++;
            count++;
        }
    }
    va_end(ap);
    return count;
}
