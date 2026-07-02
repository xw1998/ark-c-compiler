/* stdlib/src/printf.c - Ark C Compiler embedded minimal printf
 *
 * Purpose: used by the ARM backend on bare-metal platforms such as STM32
 *          when there is no libc. The C backend uses the host libc and does
 *          not need to include this file.
 *
 * Supported format specifiers:
 *   %d %i  - decimal integer (int)
 *   %u     - decimal unsigned integer (unsigned)
 *   %x %X  - hexadecimal unsigned integer (lower/upper case)
 *   %p     - pointer (outputs "0x" + 8-digit zero-padded hex)
 *   %s     - string
 *   %c     - single character
 *   %%     - literal %
 *   Width and '0' padding: %5d / %05d / %08x
 *
 * Not supported: %f %lf (float), %lld (long long), dynamic precision, etc.
 *
 * Output dependency: the user/platform layer provides int putchar(int c);
 * this file references it as a weak dependency.
 * STM32 projects typically redirect putchar to UART/ITM.
 */
#include <stdarg.h>

extern int putchar(int c);

static void print_str(const char *s) {
    if (!s) { /* safety: avoid NULL dereference */
        const char *n = "(null)";
        while (*n) putchar(*n++);
        return;
    }
    while (*s) putchar(*s++);
}

/* Convert long to string in the given base and print it; supports negative
 * numbers (only base==10 is treated as signed).
 * width/pad: when width is insufficient, left-pad with the pad character
 * (' ' or '0'). */
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
                    /* Unknown format: output %X as-is to keep it visible for debugging */
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
