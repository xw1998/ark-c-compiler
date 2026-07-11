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

/* ============================================================================
 * Stage 5: ARM C library retargeting
 *
 * __user_initial_stackheap: called by the ARM C library's __rt_entry to obtain
 * the initial heap and stack extents. Returns 4 values in registers (r0-r3):
 *   r0 = heap base   (start of heap area)
 *   r1 = stack base  (top of stack, highest address)
 *   r2 = heap limit  (end of heap area, first address beyond heap)
 *   r3 = stack limit (lowest address the stack may grow to)
 *
 * STM32H743 memory layout (from STM32H743VITx_FLASH.sct):
 *   Flash  : 0x08000000, 2 MB       (code + rodata)
 *   DTCM   : 0x20000000, 128 KB     (.data/.bss + stack, top at 0x20020000)
 *   AXI    : 0x24000000, 512 KB     (.ark_heap/.ark_code/.ark_buf)
 *
 * Heap lives in AXI SRAM; stack grows down from DTCM top.
 * ========================================================================= */

/* Heap/stack addresses for STM32H743.
 * These match the scatter file (STM32H743VITx_FLASH.sct) exactly.
 * On host builds these are never used (platform_host.c is linked instead). */
#define ARK_HEAP_BASE   0x24000000u  /* AXI SRAM start (512 KB) */
#define ARK_HEAP_LIMIT  0x24080000u  /* AXI SRAM end */
#define ARK_STACK_BASE  0x20020000u  /* DTCM top (initial SP) */
#define ARK_STACK_LIMIT 0x20000000u  /* DTCM bottom (stack limit) */

#if defined(__CC_ARM) || defined(__ARMCC_VERSION)

/* armcc5 / armclang: use __value_in_regs for multi-register struct return.
 * This is the standard ARM C library retargeting contract. */
struct __heap_extent {
    void *heap_base;
    void *heap_limit;
    void *stack_base;
    void *stack_limit;
};

/* weak: allows a project-specific strong definition (e.g. in
 * system_stm32h7xx.c) to override this default. If the project
 * does not provide one, this default is used instead. */
__attribute__((weak))
__value_in_regs struct __heap_extent
__user_initial_stackheap(unsigned requested_heap,
                          void *heap_base,
                          void *stack_base,
                          unsigned stack_size) {
    struct __heap_extent e;
    (void)requested_heap;   /* we ignore the C library's suggestion */
    (void)heap_base;        /* and the default heap_base passed in */
    (void)stack_base;
    (void)stack_size;
    e.heap_base   = (void *)ARK_HEAP_BASE;
    e.heap_limit  = (void *)ARK_HEAP_LIMIT;
    e.stack_base  = (void *)ARK_STACK_BASE;
    e.stack_limit = (void *)ARK_STACK_LIMIT;
    return e;
}

/* fputc: armcc5 stdio retargeting hook.
 * Called by printf/fprintf to output a single character.
 * Redirects to UART1 via HAL_UART_Transmit_Wrapper. */
int fputc(int ch, void *stream) {
    (void)stream;
    {
        unsigned char c = (unsigned char)ch;
        /* Translate LF to CRLF for terminal display */
        if (c == '\n') {
            unsigned char cr = '\r';
            HAL_UART_Transmit_Wrapper(&cr, 1);
        }
        HAL_UART_Transmit_Wrapper(&c, 1);
    }
    return ch;
}

/* _ttywrch: armcc5 terminal write for error/diagnostic messages. */
void _ttywrch(int ch) {
    unsigned char c = (unsigned char)ch;
    if (c == '\n') {
        unsigned char cr = '\r';
        HAL_UART_Transmit_Wrapper(&cr, 1);
    }
    HAL_UART_Transmit_Wrapper(&c, 1);
}

/* _sys_exit: armcc5 exit handler (called by exit()/abort()).
 * On bare-metal, we loop forever since there's no OS to return to. */
void _sys_exit(int return_code) {
    (void)return_code;
    uart_puts("\r\n[arkcc] _sys_exit called\r\n");
    for (;;) { }
}

#endif /* __CC_ARM || __ARMCC_VERSION */

/* ============================================================================
 * HAL redirect: strong putchar that overrides the weak default in
 * putchar_default.c. This makes printf (from stdlib/src/printf.c) output
 * to UART1 on STM32, regardless of which compiler built the project.
 * ========================================================================= */
int putchar(int c) {
    unsigned char ch = (unsigned char)c;
    /* Translate LF to CRLF for terminal display */
    if (ch == '\n') {
        unsigned char cr = '\r';
        HAL_UART_Transmit_Wrapper(&cr, 1);
    }
    HAL_UART_Transmit_Wrapper(&ch, 1);
    return c;
}

/* ============================================================================
 * Stage 5: Minimal malloc/free for STM32 bare-metal
 *
 * A simple bump allocator for the heap region in AXI SRAM.
 * The ARM C library's malloc (when using __user_initial_stackheap) uses this
 * region; for arkcc's own use, mem_pool_alloc is preferred. This malloc/free
 * is for user code and any C library functions that call malloc internally.
 * ========================================================================= */
/* This file is only compiled for STM32 targets (see Makefile/build_stm32_armcc.ps1),
 * so malloc/free are always provided here. On host builds, platform_host.c is
 * linked instead and the host libc provides malloc/free. */

static unsigned char *g_heap_ptr = (unsigned char *)ARK_HEAP_BASE;
static unsigned char *g_heap_limit_ptr = (unsigned char *)ARK_HEAP_LIMIT;

/* Simple bump allocator: no free list, no coalescing.
 * Sufficient for embedded use where allocations are mostly permanent.
 * Aligns to 8 bytes (ARM AAPCS requirement). */
void *malloc(unsigned int size) {
    unsigned int aligned = (size + 7u) & ~7u;  /* 8-byte alignment */
    void *p;
    if (g_heap_ptr + aligned > g_heap_limit_ptr) return 0;
    p = g_heap_ptr;
    g_heap_ptr += aligned;
    return p;
}

void free(void *ptr) {
    (void)ptr;  /* bump allocator: free is a no-op */
}

/* calloc: malloc + memset */
void *calloc(unsigned int nmemb, unsigned int size) {
    unsigned int total = nmemb * size;
    void *p = malloc(total);
    if (p) {
        unsigned char *bp = (unsigned char *)p;
        unsigned int i;
        for (i = 0; i < total; i++) bp[i] = 0;
    }
    return p;
}

/* realloc: simple impl — allocate new, copy, (old free is no-op) */
void *realloc(void *ptr, unsigned int size) {
    void *p;
    if (!ptr) return malloc(size);
    p = malloc(size);
    if (p) {
        /* Copy old data (we don't know old size, copy up to new size) */
        unsigned char *dst = (unsigned char *)p;
        unsigned char *src = (unsigned char *)ptr;
        unsigned int i;
        for (i = 0; i < size; i++) dst[i] = src[i];
    }
    return p;
}
