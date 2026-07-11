/* stdlib/src/printf.c - Ark C Compiler embedded minimal printf
 *
 * Purpose: used by the ARM backend on bare-metal platforms such as STM32
 *          when there is no libc. The C backend uses the host libc and does
 *          not need to include this file.
 *
 * 支持的格式说明符:
 *   %d %i   - 十进制有符号整数 (int)
 *   %u      - 十进制无符号整数 (unsigned)
 *   %x %X   - 十六进制无符号整数 (小写/大写)
 *   %p      - 指针 (输出 "0x" + 8 位零填充十六进制)
 *   %s      - 字符串
 *   %c      - 单个字符
 *   %%      - 字面的 %
 *   %ld     - long 长度修饰符
 *   %lld    - long long 长度修饰符 (64 位)
 *   宽度与前导零: %5d / %05d / %08x
 *
 * 不支持: %f %lf (浮点), 动态精度 (%.*), 左对齐 (-) 等.
 *
 * 输出依赖: 用户/平台层提供 int putchar(int c);
 *           本文件将其作为弱依赖引用.
 *           STM32 工程通常把 putchar 重定向到 UART/ITM.
 *
 * 设计: 提取通用的 Sink 抽象, 使 printf (走 putchar) 与 snprintf (写缓冲区)
 *       共享同一套格式化核心 vprintf_core, 避免逻辑重复.
 */
#include <stdarg.h>
#include <stddef.h>

extern int putchar(int c);

/* 输出 sink: 把格式化结果导向 stdout 或用户缓冲区.
 *   to_buf == 0 -> 调用 putchar 输出 (用于 printf / vprintf)
 *   to_buf == 1 -> 写入 buf 缓冲区, 最多容纳 size-1 个字符 + 终止 '\0' (用于 snprintf)
 * pos 字段统计 "本应写入" 的字符数 (即 C99 规定的返回值), 即使被截断也继续累加. */
typedef struct {
    char  *buf;     /* 目标缓冲区; to_buf==0 时未使用 */
    size_t size;    /* 缓冲区容量; to_buf==0 时未使用 */
    size_t pos;     /* 已写入 / 本应写入的字符数 */
    int    to_buf;  /* 1=写缓冲区, 0=走 putchar */
} Sink;

/* 向 sink 输出单个字符. 缓冲区模式下严格不越界:
 * 字符只写到 pos < size-1 的位置 (保留一格给终止 '\0'),
 * 但 pos 始终递增以反映 "本应写入" 的总数, 从而符合 C99 截断语义. */
static void sink_putc(Sink *s, char c) {
    if (s->to_buf) {
        if (s->size && s->pos < s->size - 1)
            s->buf[s->pos] = c;
    } else {
        putchar((int)c);
    }
    s->pos++;
}

/* 向 sink 输出字符串; NULL 指针输出 "(null)" 以避免解引用空指针. */
static void sink_puts(Sink *s, const char *str) {
    if (!str) str = "(null)";
    while (*str) sink_putc(s, *str++);
}

/* 把无符号整数按指定进制转换为字符串并输出到 sink.
 *   u      - 待转换的无符号值 (已取绝对值)
 *   neg    - 是否需要输出负号 (仅十进制有符号转换会置 1)
 *   base   - 进制 (10 或 16)
 *   upper  - 十六进制时是否使用大写字母 A-F
 *   width  - 最小字段宽度, 不足则用 pad 填充
 *   pad    - 填充字符 (' ' 或 '0')
 * 填充规则遵循 C99: 0 填充时符号在最前、0 紧随其后、数字最后 (如 -12 -> "-0012");
 * 空格填充时符号紧贴数字高位、空格填在最前 (如 -12 -> "  -12"). */
static void print_int(Sink *s, unsigned long long u, int neg, int base,
                      int upper, int width, char pad) {
    char tmp[24];
    int  i = 0;
    int  digits;
    int  d;
    /* 先转换数字部分, 低位存放在 tmp[0..] */
    if (u == 0) tmp[i++] = '0';
    while (u) {
        d = (int)(u % (unsigned long long)base);
        tmp[i++] = (char)(d < 10 ? '0' + d : (upper ? 'A' : 'a') + d - 10);
        u /= (unsigned long long)base;
    }
    digits = i;  /* 数字部分字符数 (不含符号) */

    if (pad == '0' && neg) {
        /* 0 填充 + 有符号: 输出 "-00..0" + 数字, 符号在前 */
        sink_putc(s, '-');
        while (digits < width - 1) { sink_putc(s, '0'); digits++; }
        /* tmp 中仍是纯数字, i 未变, 直接走下方输出 */
    } else {
        /* 空格填充, 或无符号情况: 符号紧贴数字高位, 空格填在最前 */
        if (neg) tmp[i++] = '-';
        while (i < width) tmp[i++] = pad;
    }
    /* 从高位到低位输出 tmp 中字符 */
    while (i > 0) sink_putc(s, tmp[--i]);
}

/* 格式化核心: 解析 fmt 并按 ap 中的参数输出到 sink.
 * 返回实际 / 本应写入的字符数 (不含终止 '\0'). */
static int vprintf_core(Sink *s, const char *fmt, va_list ap) {
    while (*fmt) {
        if (*fmt != '%') { sink_putc(s, *fmt++); continue; }
        fmt++;
        {
            char pad    = ' ';
            int  width  = 0;
            int  lcount = 0;  /* 'l' 修饰符个数: 1=%ld, >=2=%lld */
            unsigned long long uv;
            int neg;

            if (*fmt == '0') { pad = '0'; fmt++; }
            while (*fmt >= '0' && *fmt <= '9') {
                width = width * 10 + (*fmt - '0');
                fmt++;
            }
            /* 解析长度修饰符 l / ll */
            while (*fmt == 'l') { lcount++; fmt++; }

            switch (*fmt) {
                case 'd': case 'i': {
                    /* 先转对应无符号类型再取负, 避免对 INT_MIN / LONG_MIN /
                     * LLONG_MIN 取负时的有符号溢出 (UB). 无符号取负是模运算, 定义良好. */
                    if (lcount >= 2) {
                        long long v = va_arg(ap, long long);
                        unsigned long long au = (unsigned long long)v;
                        neg = (v < 0);
                        if (neg) au = -au;
                        uv = au;
                    } else if (lcount == 1) {
                        long v = va_arg(ap, long);
                        unsigned long au = (unsigned long)v;
                        neg = (v < 0);
                        if (neg) au = -au;
                        uv = (unsigned long long)au;
                    } else {
                        int v = va_arg(ap, int);
                        unsigned au = (unsigned)v;
                        neg = (v < 0);
                        if (neg) au = -au;
                        uv = (unsigned long long)au;
                    }
                    print_int(s, uv, neg, 10, 0, width, pad);
                    break;
                }
                case 'u': {
                    if (lcount >= 2)      uv = (unsigned long long)va_arg(ap, unsigned long long);
                    else if (lcount == 1) uv = (unsigned long long)va_arg(ap, unsigned long);
                    else                  uv = (unsigned long long)va_arg(ap, unsigned int);
                    print_int(s, uv, 0, 10, 0, width, pad);
                    break;
                }
                case 'x':
                case 'X': {
                    int upper = (*fmt == 'X');
                    if (lcount >= 2)      uv = (unsigned long long)va_arg(ap, unsigned long long);
                    else if (lcount == 1) uv = (unsigned long long)va_arg(ap, unsigned long);
                    else                  uv = (unsigned long long)va_arg(ap, unsigned int);
                    print_int(s, uv, 0, 16, upper, width, pad);
                    break;
                }
                case 'p':
                    sink_puts(s, "0x");
                    print_int(s, (unsigned long long)(unsigned long)va_arg(ap, void *),
                             0, 16, 0, 8, '0');
                    break;
                case 's':
                    sink_puts(s, va_arg(ap, char *));
                    break;
                case 'c':
                    sink_putc(s, (char)va_arg(ap, int));
                    break;
                case '%':
                    sink_putc(s, '%');
                    break;
                default:
                    /* 未知格式: 原样输出 %X 以便调试时可见 */
                    sink_putc(s, '%');
                    if (*fmt) sink_putc(s, *fmt);
                    break;
            }
            if (*fmt) fmt++;
        }
    }
    return (int)s->pos;
}

int printf(const char *fmt, ...) {
    va_list ap;
    Sink s;
    s.buf = 0; s.size = 0; s.pos = 0; s.to_buf = 0;
    va_start(ap, fmt);
    (void)vprintf_core(&s, fmt, ap);
    va_end(ap);
    return (int)s.pos;
}

int vprintf(const char *fmt, va_list ap) {
    Sink s;
    s.buf = 0; s.size = 0; s.pos = 0; s.to_buf = 0;
    return vprintf_core(&s, fmt, ap);
}

int vsnprintf(char *buf, size_t size, const char *fmt, va_list ap) {
    Sink s;
    s.buf = buf; s.size = size; s.pos = 0; s.to_buf = 1;
    (void)vprintf_core(&s, fmt, ap);
    /* size > 0 时在末尾写入终止 '\0'; 若被截断, 写到缓冲区末位 */
    if (size > 0) {
        size_t end = (s.pos < size) ? s.pos : (size - 1);
        buf[end] = '\0';
    }
    return (int)s.pos;
}

int snprintf(char *buf, size_t size, const char *fmt, ...) {
    va_list ap;
    int n;
    va_start(ap, fmt);
    n = vsnprintf(buf, size, fmt, ap);
    va_end(ap);
    return n;
}
