/* Ark C Compiler - platform_stm32
 * STM32 ?????????? HAL UART ????????
 *
 * ????????????????????????????
 *   1. ??????????? STM32 HAL??
 *   2. ???? USART1 PA9/PA10 + 115200 ???????
 *   3. ?????????????? platform_host.c??
 */
#include "platform.h"

/* ?????????????????
 *   extern UART_HandleTypeDef huart1;
 * ?????????????????????
 */
extern void HAL_UART_Transmit_Wrapper(const unsigned char *buf, int len);

/* ?????????????????????? libc?? */
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
        /* 小写十六进制字母 a-f，用于 %d %x */
        tmp[n++] = (char)(d < 10 ? '0' + d : 'a' + d - 10);
        x /= (unsigned int)base;
    }
    if (neg) tmp[n++] = '-';
    for (i = 0, j = n - 1; i < n; i++, j--) buf[i] = tmp[j];
    buf[n] = 0;
    return n;
}

/* ark_itoa_upper: 无符号整数转字符串（大写十六进制 A-F），用于 %X %u。
 * 不处理负数（按无符号解释，与 printf 的 %X/%u 一致）。
 */
static int ark_itoa_upper(unsigned int v, char *buf, int base) {
    int n = 0;
    int i, j;
    char tmp[16];
    if (v == 0) { buf[n++] = '0'; buf[n] = 0; return n; }
    while (v) {
        int d = (int)(v % (unsigned int)base);
        tmp[n++] = (char)(d < 10 ? '0' + d : 'A' + d - 10);
        v /= (unsigned int)base;
    }
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

/* ark_log: 简化版 printf，支持 %d %x %X %u %s %c %% 以及宽度/标志/长度修饰符：
 *   %08X  - 宽度8、大写十六进制、前导零填充（如 0000ABCD）
 *   %04X  - 宽度4、大写十六进制、前导零填充
 *   %-40s - 左对齐、宽度40的字符串（右侧空格填充）
 *   %08d  - 宽度8、十进制、前导零填充
 *   %ld   - long 型十进制（按 32 位处理）
 * 解析顺序：'%' [左对齐'-'] [宽度，以 '0' 开头则前导零填充] [长度'l'] 转换字符(d/x/X/s/c/u/%)
 * 使用 stdarg.h（兼容 GCC 与 armcc5）。缓冲区固定 256 字节，每步写入前检查越界。
 */
#include <stdarg.h>

void ark_log(const char *fmt, ...) {
    char buf[256];
    int n = 0;
    const char *p = fmt;
    va_list ap;
    va_start(ap, fmt);
    while (*p && n < (int)sizeof(buf) - 32) {
        if (*p == '%' && p[1]) {
            int left_align = 0;  /* '-' 左对齐标志 */
            int zero_pad = 0;    /* 宽度以 '0' 开头时启用前导零填充 */
            int width = 0;       /* 字段宽度 */
            int is_long = 0;     /* 'l' 长度修饰符 */
            int len = 0;         /* 转换后数字串长度 */
            int pad = 0;         /* 需要填充的字符数 */
            int sign = 0;        /* 负数符号（仅 %d 前导零场景需分离输出） */
            int i = 0;
            char c;
            char num[16];
            const char *s;
            unsigned int uv;
            p++;  /* 跳过 '%' */

            /* 1. 解析左对齐标志 '-' */
            if (*p == '-') { left_align = 1; p++; }

            /* 2. 解析宽度；首位为 '0' 表示前导零填充 */
            if (*p == '0') { zero_pad = 1; p++; }
            while (*p >= '0' && *p <= '9') {
                width = width * 10 + (*p - '0');
                p++;
            }

            /* 3. 解析长度修饰符 'l' */
            if (*p == 'l') { is_long = 1; p++; }

            /* 4. 解析转换字符 */
            c = *p;
            if (c == 0) { buf[n++] = '%'; break; }  /* 格式串异常结束 */
            p++;

            if (c == '%') {
                buf[n++] = '%';
            } else if (c == 'd') {
                int v = is_long ? (int)va_arg(ap, long) : (int)va_arg(ap, int);
                len = ark_itoa(v, num, 10);
                pad = width - len;
                /* 负数 + 前导零：符号置前，零填充置于符号与数字之间（如 -0000005） */
                if (zero_pad && num[0] == '-') sign = 1;
                if (pad > 0 && !left_align) {
                    if (sign) { if (n < (int)sizeof(buf) - 1) buf[n++] = '-'; }
                    while (pad-- > 0 && n < (int)sizeof(buf) - 1)
                        buf[n++] = zero_pad ? '0' : ' ';
                    for (i = sign ? 1 : 0; i < len; i++)
                        if (n < (int)sizeof(buf) - 1) buf[n++] = num[i];
                } else {
                    for (i = 0; i < len; i++)
                        if (n < (int)sizeof(buf) - 1) buf[n++] = num[i];
                    if (pad > 0 && left_align)
                        while (pad-- > 0 && n < (int)sizeof(buf) - 1) buf[n++] = ' ';
                }
            } else if (c == 'u') {
                uv = is_long ? (unsigned int)va_arg(ap, unsigned long) : va_arg(ap, unsigned int);
                len = ark_itoa_upper(uv, num, 10);
                pad = width - len;
                if (pad > 0 && !left_align)
                    while (pad-- > 0 && n < (int)sizeof(buf) - 1)
                        buf[n++] = zero_pad ? '0' : ' ';
                for (i = 0; i < len; i++)
                    if (n < (int)sizeof(buf) - 1) buf[n++] = num[i];
                if (pad > 0 && left_align)
                    while (pad-- > 0 && n < (int)sizeof(buf) - 1) buf[n++] = ' ';
            } else if (c == 'x') {
                uv = is_long ? (unsigned int)va_arg(ap, unsigned long) : (unsigned int)va_arg(ap, int);
                len = ark_itoa((int)uv, num, 16);
                pad = width - len;
                if (pad > 0 && !left_align)
                    while (pad-- > 0 && n < (int)sizeof(buf) - 1)
                        buf[n++] = zero_pad ? '0' : ' ';
                for (i = 0; i < len; i++)
                    if (n < (int)sizeof(buf) - 1) buf[n++] = num[i];
                if (pad > 0 && left_align)
                    while (pad-- > 0 && n < (int)sizeof(buf) - 1) buf[n++] = ' ';
            } else if (c == 'X') {
                uv = is_long ? (unsigned int)va_arg(ap, unsigned long) : (unsigned int)va_arg(ap, int);
                len = ark_itoa_upper(uv, num, 16);
                pad = width - len;
                if (pad > 0 && !left_align)
                    while (pad-- > 0 && n < (int)sizeof(buf) - 1)
                        buf[n++] = zero_pad ? '0' : ' ';
                for (i = 0; i < len; i++)
                    if (n < (int)sizeof(buf) - 1) buf[n++] = num[i];
                if (pad > 0 && left_align)
                    while (pad-- > 0 && n < (int)sizeof(buf) - 1) buf[n++] = ' ';
            } else if (c == 's') {
                s = va_arg(ap, const char *);
                if (!s) s = "(null)";
                { const char *q = s; while (*q) { len++; q++; } }  /* 求串长以决定填充 */
                pad = width - len;
                if (pad > 0 && !left_align)
                    while (pad-- > 0 && n < (int)sizeof(buf) - 1) buf[n++] = ' ';
                while (*s && n < (int)sizeof(buf) - 1) buf[n++] = *s++;
                if (pad > 0 && left_align)
                    while (pad-- > 0 && n < (int)sizeof(buf) - 1) buf[n++] = ' ';
            } else if (c == 'c') {
                int v = va_arg(ap, int);
                if (n < (int)sizeof(buf) - 1) buf[n++] = (char)v;
            } else {
                /* 未识别的转换字符，原样输出 */
                buf[n++] = c;
            }
        } else {
            buf[n++] = *p++;
        }
    }
    va_end(ap);
    buf[n] = 0;
    uart_puts(buf);
}

void ark_abort(const char *msg) {
    if (msg) uart_puts(msg);
    uart_puts("\r\n[arkcc] FATAL: aborting\r\n");
    for (;;) {
        /* ????? */
    }
}

/* C99 __DATE__/__TIME__??????? RTC ?????????????
 * ????????????? STM32 RTC/BKP ??????? */
void ark_get_date_time(char *date_buf, char *time_buf) {
    static const char d[] = "Jan  1 1970";
    static const char tn[] = "00:00:00";
    int i;
    for (i = 0; i < 11; i++) date_buf[i] = d[i];
    date_buf[11] = 0;
    for (i = 0; i < 8; i++) time_buf[i] = tn[i];
    time_buf[8] = 0;
}
