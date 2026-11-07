/* Ark C Compiler - MDK STM32H743 - main
 * Self-hosted compiler with interactive shell over UART.
 *
 * Shell commands (received via USART1 @ 115200):
 *   help              - show available commands
 *   ls [dir]          - list files on flash FS
 *   cat <file>        - print file content
 *   compile <file>   - compile a .c source from flash to ARM binary
 *   run <file>        - compile and execute a .c source
 *   rm <file>         - delete a file from flash FS (if supported)
 *   echo <text>      - echo text back (loopback test)
 *
 * Clock setup: HSE 8MHz -> PLL1 -> SYSCLK 480MHz (CPU 480MHz, HCLK 240MHz).
 */
#include "stm32h7xx.h"
#include "bsp_w25q.h"
#include "bsp_sdram.h"
#include "config.h"          /* g_config: 0.8.0 的运行时开关（--reloc-text 等） */

extern uint32_t g_sdram_busy_seen;
extern uint32_t g_sdram_sdsr_after_load;
extern uint32_t g_fmc_bcr1_before;
extern uint32_t g_fmc_bcr1_after;
extern uint32_t g_rcc_d1ccipr;
extern uint32_t g_rcc_ahb3enr;
#include "platform.h"
#include "flash_fs.h"
#include "compiler.h"
#include <string.h>

/* === Bare-metal register definitions ===
 * The placeholder stm32h743xx.h only provides GPIO/USART/SPI structs;
 * RCC and FLASH controllers must be defined here for clock setup.
 * Addresses per STM32H743 RM0433 (RCC on AHB4, FLASH on D1 AHB1). */
#define REG32(addr)      (*(volatile uint32_t *)(addr))

#define RCC_BASE          (0x58024400UL)
#define RCC_CR            REG32(RCC_BASE + 0x00U)
#define RCC_CFGR          REG32(RCC_BASE + 0x10U)
#define RCC_D1CFGR        REG32(RCC_BASE + 0x18U)
#define RCC_PLLCKSELR     REG32(RCC_BASE + 0x28U)
#define RCC_PLLCFGR       REG32(RCC_BASE + 0x2CU)
#define RCC_PLL1DIVR      REG32(RCC_BASE + 0x30U)
#define RCC_AHB4ENR        REG32(RCC_BASE + 0xE0U)
#define RCC_APB2ENR        REG32(RCC_BASE + 0xF0U)
#define RCC_D2CCIP1R       REG32(RCC_BASE + 0x50U)

#define FLASH_R_BASE      (0x52002000UL)
#define FLASH_ACR         REG32(FLASH_R_BASE + 0x00U)

/* RCC_CR bits */
#define RCC_CR_HSION      (1UL << 0)
#define RCC_CR_HSIKERON   (1UL << 1)
/* STM32H7 RM0433: HSIRDY is bit 2 (on F4 it is bit 1).  Waiting on the wrong
 * bit is a hang, not a compile error -- that is exactly what happened here. */
#define RCC_CR_HSIRDY     (1UL << 2)
#define RCC_CR_HSEON      (1UL << 16)
#define RCC_CR_HSERDY     (1UL << 17)
#define RCC_CR_PLL1ON     (1UL << 24)
#define RCC_CR_PLL1RDY    (1UL << 25)

/* SystemCoreClock is defined in system_stm32h7xx.c; updated by SystemClock_Config */
extern uint32_t SystemCoreClock;

/* Address of the compiler's own work buffers (src/compiler.c, .ark_buf).  Printed
 * at boot so the memory layout in use is a reading, not an assumption. */
extern unsigned long arkcc_buf_addr(void);

/* HAL handles (defined global per STM32 convention) */
UART_HandleTypeDef huart1;
SPI_HandleTypeDef  hspi1;

/* === ArkCC dedicated large buffers: placed in dedicated AXI SRAM sections ===
 * The scatter file links .ark_heap / .ark_code sections to AXI SRAM starting at 0x24000000.
 * Sizes reduced to fit in 512KB AXI SRAM (heap 64K→32K, code 32K unchanged).
 */
__attribute__((section(".ark_heap"))) unsigned char ark_heap_buffer[32 * 1024];
__attribute__((section(".ark_code"))) unsigned char ark_code_buffer[32 * 1024];

/* === UART wrapper required by platform_stm32.c === */
void HAL_UART_Transmit_Wrapper(const unsigned char *buf, int len) {
    (void)HAL_UART_Transmit(&huart1, buf, (uint16_t)len, 1000);
}

/* === minimal logf: reuse ark_log === */
void ark_logf(const char *fmt, int v) {
    ark_log(fmt, v);
}

/* ---------------- Shell I/O helpers ---------------- */

/* Send a NUL-terminated string via UART */
static void shell_puts(const char *s) {
    HAL_UART_Transmit(&huart1, (const uint8_t *)s, (uint16_t)strlen(s), 1000);
}

/* Read one line from UART (blocking, ends on '\r' or '\n').
 * Returns line length (without terminator). */
static int shell_getline(char *buf, int max) {
    int n = 0;
    while (n < max - 1) {
        uint8_t ch;
        HAL_StatusTypeDef st = HAL_UART_Receive(&huart1, &ch, 1, HAL_MAX_DELAY);
        if (st != HAL_OK) { continue; }
        if (ch == '\r' || ch == '\n') {
            /* Echo newline */
            uint8_t nl[2] = { '\r', '\n' };
            HAL_UART_Transmit(&huart1, nl, 2, 10);
            break;
        }
        /* Echo back */
        HAL_UART_Transmit(&huart1, &ch, 1, 10);
        if (ch == 0x08) { /* backspace */
            if (n > 0) n--;
            continue;
        }
        buf[n++] = (char)ch;
    }
    buf[n] = 0;
    return n;
}

/* Split a command line into argv[] (space-separated tokens).
 * Modifies buf in-place. Returns argc. */
static int shell_split(char *buf, char **argv, int max) {
    int argc = 0;
    char *p = buf;
    while (*p && argc < max) {
        while (*p == ' ') p++;
        if (*p == 0) break;
        argv[argc++] = p;
        while (*p && *p != ' ') p++;
        if (*p) { *p = 0; p++; }
    }
    return argc;
}

/* ---------------- Filesystem listing (flash_fs_stm32.c) ---------------- */
/* fs_list_files is declared in flash_fs_stm32.c if ARK_TARGET_STM32 is defined.
 * It prints all file entries on the flash FS to UART via ark_log. */
extern int fs_list_files(void);

/* ---------------- Shell command handlers ---------------- */

static void cmd_help(void) {
    shell_puts(
        "\r\n=== ArkCC Shell Commands ===\r\n"
        "  help              - show this help\r\n"
        "  ls                - list files on flash FS\r\n"
        "  cat <file>        - print file content\r\n"
        "  compile <file>    - compile .c source to ARM binary\r\n"
        "  run <file>        - compile and execute .c source\r\n"
        "  demo              - install the POSIX hello-world sources into RAM\r\n"
        "  build             - compile+link+run the POSIX hello world on this chip\r\n"
        "  sdram             - init the 32MB FMC SDRAM and run a full read/write check\r\n"
        "  echo <text>      - echo text back\r\n"
        "  version           - show compiler version\r\n"
        "=============================\r\n"
    );
}

static void cmd_ls(void) {
    shell_puts("\r\nFiles on flash FS:\r\n");
    if (fs_list_files() < 0) {
        shell_puts("Error: file listing is not available on this build\r\n");
    }
}

static void cmd_cat(const char *path) {
    static char readbuf[4096];
    int n;
    if (!path || !*path) {
        shell_puts("Usage: cat <file>\r\n");
        return;
    }
    n = fs_read_file(path, readbuf, (int)sizeof(readbuf) - 1);
    if (n < 0) {
        shell_puts("Error: cannot read file\r\n");
        return;
    }
    readbuf[n] = 0;
    shell_puts("\r\n--- ");
    shell_puts(path);
    shell_puts(" ---\r\n");
    shell_puts(readbuf);
    shell_puts("\r\n--- end ---\r\n");
}

static void cmd_compile(const char *path, int run) {
    ArkOptions opts;
    int i;
    int rc;
    if (!path || !*path) {
        shell_puts("Usage: compile <file.c>\r\n");
        return;
    }
    shell_puts("\r\n[arkcc] compiling ");
    shell_puts(path);
    shell_puts("...\r\n");

    /* Reset options (same as ark_compile_and_run but with target=arm for STM32) */
    opts.input_path = path;
    opts.output_path = 0;
    opts.emit_asm = 0;
    opts.verbose = 1;
    opts.target = "arm";
    opts.cpu = "Cortex-M7";
    for (i = 0; i < 16; i++) opts.include_dirs[i] = 0;
    opts.include_dir_count = 0;
    opts.list_backends = 0;
    opts.compile_only = 0;
    opts.preprocess_only = 0;
    opts.link_mode = 0;
    for (i = 0; i < 32; i++) opts.link_inputs[i] = 0;
    opts.link_input_count = 0;
    opts.opt_level = 0;
    opts.debug_info = 0;
    opts.no_unused_warn = 1;
    opts.gen_depend = 0;
    opts.depend_file = 0;
    opts.split_sections = 0;
    opts.scatter_file = 0;
    opts.linker_script = 0;

    rc = ark_compile(&opts);

    {
        char msg[64];
        /* Build "Exit code: N\r\n" without snprintf (keeps HAL simple) */
        const char *prefix = "Exit code: ";
        int p = 0;
        int j;
        for (j = 0; prefix[j]; j++) msg[p++] = prefix[j];
        if (rc < 0) {
            msg[p++] = '-';
            rc = -rc;
        }
        {
            char digits[12];
            int d = 0;
            if (rc == 0) digits[d++] = '0';
            while (rc > 0) { digits[d++] = '0' + (rc % 10); rc /= 10; }
            while (d > 0) msg[p++] = digits[--d];
        }
        msg[p++] = '\r';
        msg[p++] = '\n';
        msg[p] = 0;
        shell_puts(msg);
    }

    if (run && rc == 0) {
        shell_puts("[arkcc] Binary ready in code buffer.\r\n");
        /* On STM32, ark_compile with target=arm places the binary in g_code
         * which is linked to ark_code_buffer. To execute it, cast the buffer
         * as a function pointer and call. NOTE: requires proper stack/VTOR
         * setup; this is a demonstration skeleton. */
        shell_puts("[arkcc] (execution would start here on real hardware)\r\n");
    }
}

static void cmd_version(void) {
    shell_puts("\r\nArk C Compiler v");
    shell_puts(ARK_VERSION);
    shell_puts("\r\nTarget: STM32H743 (Cortex-M7)\r\n");
}

/* ---------------- Fault reporting ----------------
 * A Cortex-M fault used to land in the startup file's weak handler, which is
 * `B .`: the shell just stopped answering with nothing on the wire, and the
 * only way to find out why was to attach a debugger.  The handlers below are
 * strong definitions that print the stacked frame and the fault status
 * registers first.  (The frame is only valid when the fault did not escalate
 * with a corrupted stack; the printed PC is then meaningless, and BFAR/CFSR
 * are what is left to read.) */
static const char HEXDIG[] = "0123456789abcdef";

static void put_hex32(unsigned v) {
    char s[11];
    int i;
    s[0] = '0'; s[1] = 'x';
    for (i = 0; i < 8; i++) {
        s[2 + i] = HEXDIG[(v >> ((7 - i) * 4)) & 0xF];
    }
    s[10] = 0;
    shell_puts(s);
}

void ark_report_fault(unsigned *sp) {
    if (!sp) return;
    shell_puts("\r\n*** CPU FAULT ***\r\n  r0=");
    put_hex32(sp[0]); shell_puts(" r1="); put_hex32(sp[1]);
    shell_puts(" r2="); put_hex32(sp[2]); shell_puts(" r3="); put_hex32(sp[3]);
    shell_puts("\r\n  r12="); put_hex32(sp[4]);
    shell_puts(" lr="); put_hex32(sp[5]);
    shell_puts(" pc="); put_hex32(sp[6]);
    shell_puts(" psr="); put_hex32(sp[7]);
    shell_puts("\r\n  CFSR="); put_hex32(*(volatile unsigned *)0xE000ED28u);
    shell_puts(" HFSR="); put_hex32(*(volatile unsigned *)0xE000ED2Cu);
    shell_puts("\r\n  MMFAR="); put_hex32(*(volatile unsigned *)0xE000ED34u);
    shell_puts(" BFAR="); put_hex32(*(volatile unsigned *)0xE000ED38u);
    shell_puts("\r\n  (board halted; reset to continue)\r\n");
}

/* ---------------- On-board build and run ----------------
 * The point of this firmware is a closed loop on one chip:
 *   .c sources (RAM file slots) -> arkcc -c -> objects (RAM) -> arkcc -link
 *   -> an image loaded at APP_BASE -> called as a function.
 * Nothing here is host-assisted; the only host interaction is typing.
 */

#define APP_BASE    0x24070000u   /* where a linked app image is loaded      */
#define APP_LIMIT   0x0000F000u   /* 60 KB: below, and clear of the trampoline */
#define TRAMP_ADDR  0x2407F000u   /* fixed-address console trampoline        */

/* Console trampoline for compiled programs.  It must sit at a known address
 * because the on-board compiler has no --defsym: the app's runtime (crt.c)
 * calls this constant address.  Linker/STM32H743VITx_FLASH.sct pins .ark_tramp
 * to TRAMP_ADDR, and main() checks it at boot -- a program that prints into a
 * dangling address would otherwise look like "compiled fine, printed nothing". */
__attribute__((section(".ark_tramp")))
int ark_board_putn(const unsigned char *buf, unsigned len) {
    if (buf && len > 0) {
        HAL_UART_Transmit_Wrapper(buf, (int)len);
    }
    return (int)len;
}

/* Compiler output sink: fs_write_file() on this port ends up in
 * arkcc_on_output().  Two explicit modes -- objects go into a RAM file slot,
 * the linked image goes straight to APP_BASE.  Anything unexpected is
 * reported, never silently dropped. */
#define CAP_NONE 0
#define CAP_RAM  1
#define CAP_LOAD 2

static int         g_cap_mode = CAP_NONE;
static const char *g_cap_name = "";
static int         g_img_len  = -1;

void arkcc_on_output(const unsigned char *data, int len);

void arkcc_on_output(const unsigned char *data, int len) {
    if (g_cap_mode == CAP_RAM) {
        int n = fs_ram_put(g_cap_name, (const char *)data, len);
        if (n != len) {
            ark_log("[arkcc] cannot store %s (%d bytes)\r\n", g_cap_name, len);
        }
    } else if (g_cap_mode == CAP_LOAD) {
        unsigned char *dst = (unsigned char *)APP_BASE;
        int i;
        if (len > (int)APP_LIMIT) {
            ark_log("[arkcc] image is %d bytes, over the %d-byte app window\r\n",
                    len, (int)APP_LIMIT);
            g_img_len = -1;
            return;
        }
        for (i = 0; i < len; i++) dst[i] = data[i];
        g_img_len = len;
    } else {
        ark_log("[arkcc] %d bytes of output with no sink selected\r\n", len);
    }
}

static void opts_reset(ArkOptions *o) {
    int i;
    o->input_path = 0;
    o->output_path = 0;
    o->emit_asm = 0;
    o->verbose = 1;
    o->target = "arm";
    o->cpu = "Cortex-M7";
    for (i = 0; i < ARK_PP_MAX_INC_DIRS; i++) o->include_dirs[i] = 0;
    o->include_dir_count = 0;
    o->list_backends = 0;
    o->compile_only = 0;
    o->preprocess_only = 0;
    o->link_mode = 0;
    for (i = 0; i < ARK_LINK_MAX_OBJS; i++) o->link_inputs[i] = 0;
    o->link_input_count = 0;
    /* -D list.  Leaving these uninitialised cost a bus fault inside
     * ark_compile: it walks pre_defines[] up to pre_define_count, so the
     * stack garbage was dereferenced as a string (BFAR 0xd4990a89). */
    for (i = 0; i < ARK_MAX_PRE_DEFINES; i++) o->pre_defines[i] = 0;
    o->pre_define_count = 0;
    o->opt_level = 0;
    o->debug_info = 0;
    o->no_unused_warn = 1;
    o->gen_depend = 0;
    o->depend_file = 0;
    o->split_sections = 0;
    o->scatter_file = 0;
    o->linker_script = 0;
    /* 这三个字段同样是"漏了就让栈垃圾决定行为"的那一类：vector_table 在
     * 上一版没被赋过值，板上之所以一直把向量表写进洞里，是因为那块栈恰好
     * 非 0；换一个栈布局（比如加了局部变量）它就会变 0，链接器改走"镜像
     * 必须自带向量表"的分支，行为在没有任何代码改动的情况下变了。
     * 板上链接永远要写这张表，所以这里明确置 1。 */
    o->vector_table = 1;
    o->build_date  = 0;
    o->build_time  = 0;
    o->build_epoch = 0;
}

/* -c <src> -o <obj>, captured into the RAM file slot called <obj>. */
static int build_object(const char *src, const char *obj) {
    ArkOptions o;
    int rc;
    opts_reset(&o);
    o.input_path = src;
    o.output_path = obj;
    o.compile_only = 1;
    g_cap_mode = CAP_RAM;
    g_cap_name = obj;
    rc = ark_compile(&o);
    g_cap_mode = CAP_NONE;
    return rc;
}

/* -link <objs> -o app.bin --scatter app.sct, loaded at APP_BASE. */
static int link_app(void) {
    ArkOptions o;
    int rc;
    opts_reset(&o);
    o.link_mode = 1;
    o.link_inputs[0] = "hello.o";
    o.link_inputs[1] = "crt.o";
    o.link_input_count = 2;
    o.output_path = "app.bin";
    o.scatter_file = "app.sct";
    g_img_len = -1;
    g_cap_mode = CAP_LOAD;
    rc = ark_compile(&o);
    g_cap_mode = CAP_NONE;
    return rc;
}

/* Sources kept in the firmware so the demo is reproducible without a host
 * filesystem.  They are ordinary text: `cat hello.c` shows exactly what the
 * compiler reads. */
static const char SRC_UNISTD[] =
    "/* unistd.h -- the POSIX calls this board provides. */\r\n"
    "#ifndef ARK_UNISTD_H\r\n"
    "#define ARK_UNISTD_H\r\n"
    "/* fd 1 is the serial console. */\r\n"
    "int write(int fd, const void *buf, unsigned int len);\r\n"
    "#endif\r\n";

static const char SRC_HELLO[] =
    "/* hello.c -- POSIX hello world, compiled by arkcc on this chip. */\r\n"
    "#include <unistd.h>\r\n"
    "\r\n"
    "static const char msg[] = \"hello, world\\r\\n\";\r\n"
    "\r\n"
    "int main(void);\r\n"
    "int main(void)\r\n"
    "{\r\n"
    "    write(1, msg, sizeof(msg) - 1);\r\n"
    "    write(1, \"written by arkcc running on the STM32H743 itself\\r\\n\",\r\n"
    "          sizeof(\"written by arkcc running on the STM32H743 itself\\r\\n\") - 1);\r\n"
    "    return 0;\r\n"
    "}\r\n";

static const char SRC_CRT[] =
    "/* crt.c -- runtime linked next to the app.ark_board_putn() is pinned at\r\n"
    " * 0x2407F000 by the firmware's scatter file, so the app calls that constant\r\n"
    " * address; no linker script support for absolute symbols is needed here. */\r\n"
    "extern void __arkcc_init_globals(void);\r\n"
    "extern int main(void);\r\n"
    "\r\n"
    "#define ARK_PUTN_ADDR 0x2407F001u\r\n"
    "\r\n"
    "int write(int fd, const void *buf, unsigned int len);\r\n"
    "int write(int fd, const void *buf, unsigned int len)\r\n"
    "{\r\n"
    "    int (*putn)(const void *, unsigned int);\r\n"
    "    (void)fd;\r\n"
    "    putn = (int (*)(const void *, unsigned int))ARK_PUTN_ADDR;\r\n"
    "    return putn(buf, len);\r\n"
    "}\r\n"
    "\r\n"
    "int Reset_Handler(void);\r\n"
    "int Reset_Handler(void)\r\n"
    "{\r\n"
    "    __arkcc_init_globals();\r\n"
    "    return main();\r\n"
    "}\r\n";

static const char SRC_SCT[] =
    "; app.sct -- a linked-on-board program runs from AXI SRAM.\r\n"
    "; flash_base is what arkcc encodes into every address, so the image must\r\n"
    "; be loaded here; the vector table it prepends starts at the same address.\r\n"
    "LR_APP 0x24070000 0x0000F000 {\r\n"
    "    ER_APP 0x24070000 0x0000F000 {\r\n"
    "        *(InRoot$$Sections)\r\n"
    "        .ANY (+RO)\r\n"
    "        .ANY (+RW +ZI)\r\n"
    "    }\r\n"
    "}\r\n";

static int ram_install(const char *name, const char *text) {
    int n = fs_ram_put(name, text, -1);
    if (n < 0) {
        shell_puts("Error: cannot store ");
        shell_puts(name);
        shell_puts(" in RAM\r\n");
        return -1;
    }
    return n;
}

static void cmd_demo(void) {
    fs_ram_clear();
    shell_puts("\r\n[arkcc] installing sources into RAM file slots...\r\n");
    if (ram_install("unistd.h", SRC_UNISTD) < 0) return;
    if (ram_install("hello.c", SRC_HELLO) < 0) return;
    if (ram_install("crt.c", SRC_CRT) < 0) return;
    if (ram_install("app.sct", SRC_SCT) < 0) return;
    (void)fs_list_files();
    shell_puts("Now run: build\r\n");
}

static void put_int_dec(int v) {
    char buf[12];
    int n = 0;
    if (v < 0) { shell_puts("-"); v = -v; }
    if (v == 0) buf[n++] = '0';
    while (v > 0) { buf[n++] = (char)('0' + (v % 10)); v /= 10; }
    while (n > 0) {
        char one[2];
        one[0] = buf[--n];
        one[1] = 0;
        shell_puts(one);
    }
}

static void cmd_build(void) {
    int rc;
    unsigned entry;
    int (*fn)(void);

    if (fs_ram_size_at(0) < 0) {
        shell_puts("Error: no sources in RAM; type 'demo' first\r\n");
        return;
    }

    /* 0.8.0 --reloc-text：板上这个链接一定是"多对象 + 位移"（镜像装在
     * 0x24070000，而两个对象都是按默认基址 0x08000000 编出来的），所以
     * 字符串字面量那种段内绝对地址必须由链接器纠正，否则第二个 write()
     * 会去读 0x08000400 那块 Flash。开关开在这里而不是启动时全局设，
     * 是为了让 cc -S / 单对象这类老用法不受影响。 */
    g_config.enable_reloc_text = 1;

    shell_puts("\r\n[arkcc] cc -c hello.c -o hello.o\r\n");
    rc = build_object("hello.c", "hello.o");
    if (rc != 0) { shell_puts("[arkcc] compile hello.c failed: "); put_int_dec(rc); shell_puts("\r\n"); return; }

    shell_puts("[arkcc] cc -c crt.c -o crt.o\r\n");
    rc = build_object("crt.c", "crt.o");
    if (rc != 0) { shell_puts("[arkcc] compile crt.c failed: "); put_int_dec(rc); shell_puts("\r\n"); return; }

    shell_puts("[arkcc] cc -link hello.o crt.o -o app.bin --scatter app.sct\r\n");
    rc = link_app();
    if (rc != 0 || g_img_len < 0) {
        shell_puts("[arkcc] link failed: ");
        put_int_dec(rc);
        shell_puts("\r\n");
        return;
    }
    shell_puts("[arkcc] image loaded at 24070000, ");
    put_int_dec(g_img_len);
    shell_puts(" bytes\r\n");

    /* The linker prepends a 256-entry vector table: [0] initial SP, [1] reset
     * handler (bit 0 set, Thumb).  We call the handler as a normal function --
     * it returns to us when main() returns, so the shell survives. */
    entry = ((const volatile unsigned *)APP_BASE)[1];
    if ((entry & 1u) == 0u || (entry & ~1u) < APP_BASE || (entry & ~1u) >= APP_BASE + (unsigned)APP_LIMIT) {
        shell_puts("[arkcc] vector table looks wrong (reset entry ");
        ark_log("%08x", entry);
        shell_puts("); not calling it\r\n");
        return;
    }

    shell_puts("\r\n--- program output -------------------------------------------\r\n");
    /* Keep bit 0: BLX to an even address switches to ARM state and the very
     * first instruction raises INVSTATE (CFSR 0x00020000).  The Thumb bit is
     * part of a Cortex-M function pointer, not just a vector-table marker. */
    fn = (int (*)(void))entry;
    rc = fn();
    shell_puts("\r\n--------------------------------------------------------------\r\n");
    shell_puts("[arkcc] program returned ");
    put_int_dec(rc);
    shell_puts("\r\n");
}

/* FMC SDRAM bring-up: init, then prove the whole 32 MB reads back what was
 * written.  A wrong timing, a swapped address line or a dead NBL shows up as
 * a concrete offset in the report -- never as "OK" with garbage behind it. */
static void cmd_sdram(void) {
    uint32_t sdcr, sdtr, sdrtr, sdsr, sdclk;
    uint32_t t0, ms, bad_off, got, exp, rate;
    int rc;

    shell_puts("\r\n[sdram] FMC SDRAM bank1 @ 0xC0000000 (W9825G6, 32 MB, 16-bit)\r\n");
    rc = bsp_sdram_init();
    if (rc != 0) {
        ark_log("[sdram] init FAILED at step %d: a command never completed "
                "(FMC_SDSR.BUSY stuck)\r\n", -rc);
        return;
    }
    bsp_sdram_info(&sdcr, &sdtr, &sdrtr, &sdsr, &sdclk);
    ark_log("[sdram] SDCR1=0x%08X SDTR1=0x%08X SDRTR=0x%08X SDSR=0x%08X\r\n",
            sdcr, sdtr, sdrtr, sdsr);
    /* Did the FMC actually execute the commands?  BUSY must be observable
     * right after a command write; if it never was, the kernel clock or the
     * controller itself is the problem, not the DRAM chip. */
    ark_log("[sdram] command ran: busy_seen=%d, SDSR after LOAD_MODE=0x%08X\r\n",
            (int)g_sdram_busy_seen, g_sdram_sdsr_after_load);
    ark_log("[sdram] SDCLK = %d kHz (HCLK/2), refresh count = %d\r\n",
            sdclk, (sdrtr >> 1));
    /* Clock/controller gate evidence: FMCEN (BCR1 bit31) and the FMC
     * kernel clock source, so a later failure cannot be blamed on the
     * DRAM part without these two numbers being on the record. */
    ark_log("[sdram] BCR1 before=0x%08X after=0x%08X, D1CCIPR=0x%08X AHB3ENR=0x%08X\r\n",
            g_fmc_bcr1_before, g_fmc_bcr1_after, g_rcc_d1ccipr,
            g_rcc_ahb3enr);
    if ((sdsr & (3UL << 1)) != 0) {
        ark_log("[sdram] bank1 is not in normal mode (SDSR.MODES1=%d)\r\n",
                (int)((sdsr >> 1) & 3));
        return;
    }

    shell_puts("[sdram] writing 32 MB with 16-bit stores...\r\n");
    t0 = HAL_GetTick();
    bsp_sdram_write16(SDRAM_SIZE_BYTES / 2);
    ms = HAL_GetTick() - t0;
    if (ms == 0) ms = 1;
    rate = (32UL * 100UL * 1000UL) / ms;   /* MB/s x100 */
    ark_log("[sdram] written in %d ms (%d.%02d MB/s)\r\n", ms, rate / 100, rate % 100);

    shell_puts("[sdram] verifying...\r\n");
    t0 = HAL_GetTick();
    rc = bsp_sdram_check16(SDRAM_SIZE_BYTES / 2, &bad_off, &got, &exp);
    ms = HAL_GetTick() - t0;
    if (ms == 0) ms = 1;
    rate = (32UL * 100UL * 1000UL) / ms;
    if (rc != 0) {
        ark_log("[sdram] 16-bit MISMATCH at 0x%08X: wrote 0x%04X, read 0x%04X\r\n",
                (uint32_t)(SDRAM_BANK_ADDR + bad_off), exp, got);
        shell_puts("[sdram] FAILED\r\n");
        return;
    }
    ark_log("[sdram] 16-bit verify OK in %d ms (%d.%02d MB/s)\r\n", ms, rate / 100, rate % 100);

    rc = bsp_sdram_check8(255, &bad_off, &got, &exp);
    if (rc != 0) {
        ark_log("[sdram] 8-bit probe FAILED at +%d: wrote 0x%02X, read 0x%02X "
                "(check NBL0/NBL1)\r\n", bad_off, exp, got);
        shell_puts("[sdram] FAILED\r\n");
        return;
    }
    shell_puts("[sdram] 8-bit probe OK (NBL0/NBL1 are wired correctly)\r\n");
    shell_puts("[sdram] SDRAM OK: 32 MB usable at 0xC0000000\r\n");
}

/* ---------------- Shell main loop ---------------- */
static void shell_loop(void) {
    static char linebuf[256];
    char *argv[8];
    int argc;

    shell_puts("\r\narkcc> ");
    while (1) {
        if (shell_getline(linebuf, (int)sizeof(linebuf)) == 0) {
            shell_puts("arkcc> ");
            continue;
        }

        argc = shell_split(linebuf, argv, 8);
        if (argc == 0) {
            shell_puts("arkcc> ");
            continue;
        }

        if (strcmp(argv[0], "help") == 0 || strcmp(argv[0], "?") == 0) {
            cmd_help();
        }
        else if (strcmp(argv[0], "ls") == 0) {
            cmd_ls();
        }
        else if (strcmp(argv[0], "cat") == 0 && argc >= 2) {
            cmd_cat(argv[1]);
        }
        else if (strcmp(argv[0], "compile") == 0 && argc >= 2) {
            cmd_compile(argv[1], 0);
        }
        else if (strcmp(argv[0], "run") == 0 && argc >= 2) {
            cmd_compile(argv[1], 1);
        }
        else if (strcmp(argv[0], "echo") == 0 && argc >= 2) {
            shell_puts(argv[1]);
            shell_puts("\r\n");
        }
        else if (strcmp(argv[0], "version") == 0) {
            cmd_version();
        }
        else if (strcmp(argv[0], "demo") == 0) {
            cmd_demo();
        }
        else if (strcmp(argv[0], "build") == 0) {
            cmd_build();
        }
        else if (strcmp(argv[0], "sdram") == 0) {
            cmd_sdram();
        }
        else if (strcmp(argv[0], "exit") == 0 || strcmp(argv[0], "quit") == 0) {
            shell_puts("Use reset button to exit.\r\n");
        }
        else {
            shell_puts("Unknown command. Type 'help'.\r\n");
        }
        shell_puts("arkcc> ");
    }
}

/* ---------------- init functions ---------------- */
/* SystemClock_Config: HSE 8MHz -> PLL1 -> SYSCLK 480MHz.
 * PLL1: M=2, N=120, R=1 -> VCO=(8/2)*120=480MHz, SYSCLK=480/1=480MHz.
 * D1HPRE=/2 -> HCLK=240MHz (feeds APB2, so USART1 BRR=240MHz/115200=2084).
 * D1CPRE=/1 -> CPU=480MHz (SystemCoreClock=480000000).
 */
static void SystemClock_Config(void) {
    /* HSI 64 MHz, no PLL.
     *
     * The previous version assumed an 8 MHz HSE and then had two bugs that made
     * it wait forever on this board: RCC_PLLCKSELR was written as
     * "(2 << 4) | 2", but DIVM1 occupies bits 5:0 and PLLSRC bits 23:22, so the
     * register ended up with DIVM1 = 0x22 (34) and PLLSRC = HSI; and the switch
     * poll tested RCC_CFGR & 0xC, while SWS lives in bits 5:3 -- it could never
     * observe the value it was waiting for no matter what the PLL did.
     *
     * Running from HSI keeps the firmware independent of whichever crystal the
     * board carries.  The clock can be raised later once the HSE frequency is
     * known; nothing else in the shell or the compiler depends on 480 MHz.
     */
    RCC_CR |= RCC_CR_HSION;
    while (!(RCC_CR & RCC_CR_HSIRDY)) { }

    RCC_CFGR = 0x0UL;                        /* SW = HSI */
    while ((RCC_CFGR & 0x38UL) != 0x0UL) { } /* SWS is 3 bits wide (5:3), 0 = HSI */

    FLASH_ACR = (FLASH_ACR & ~0xFUL) | 1UL;  /* 1 wait state is enough at 64 MHz */
    SystemCoreClock = 64000000UL;
}

/* MX_GPIO_Init: PA4(CS output), PA5-PA7(SPI1 AF5), PA9-PA10(USART1 AF7) */
static void MX_GPIO_Init(void) {
    /* Enable GPIOA clock */
    RCC_AHB4ENR |= (1UL << 0);  /* GPIOAEN */

    /* MODER: PA4=01(output), PA5/6/7=10(AF), PA9/10=10(AF) */
    {
        uint32_t m = GPIOA->MODER;
        m &= ~((0x3UL << 8)  | (0x3UL << 10) | (0x3UL << 12) |
                (0x3UL << 14) | (0x3UL << 18) | (0x3UL << 20));
        m |=  (0x1UL << 8)   /* PA4 output */
            | (0x2UL << 10)  /* PA5 AF */
            | (0x2UL << 12)  /* PA6 AF */
            | (0x2UL << 14)  /* PA7 AF */
            | (0x2UL << 18)  /* PA9 AF */
            | (0x2UL << 20); /* PA10 AF */
        GPIOA->MODER = m;
    }

    /* OTYPER: PA4 push-pull (default 0) */
    GPIOA->OTYPER &= ~(1UL << 4);

    /* OSPEEDR: high speed for SPI pins (PA5/6/7) */
    GPIOA->OSPEEDR |= (0x3UL << 10) | (0x3UL << 12) | (0x3UL << 14);

    /* AFR[0]: PA5/PA6/PA7 = AF5 (SPI1) */
    {
        uint32_t a = GPIOA->AFR[0];
        a &= ~((0xFUL << 20) | (0xFUL << 24) | (0xFUL << 28));
        a |=  (5UL << 20) | (5UL << 24) | (5UL << 28);
        GPIOA->AFR[0] = a;
    }
    /* AFR[1]: PA9/PA10 = AF7 (USART1) */
    {
        uint32_t a = GPIOA->AFR[1];
        a &= ~((0xFUL << 4) | (0xFUL << 8));
        a |=  (7UL << 4) | (7UL << 8);
        GPIOA->AFR[1] = a;
    }

    /* PA4 = high (CS inactive) */
    GPIOA->ODR |= (1UL << 4);
}

/* MX_USART1_UART_Init: 115200 8N1, BRR=240MHz/115200~=2084 */
static void MX_USART1_UART_Init(void) {
    /* Enable USART1 clock (APB2) */
    RCC_APB2ENR |= (1UL << 4);  /* USART1EN */

    huart1.Instance = USART1;
    huart1.BaudRate = 115200U;

    USART1->CR1 = 0;          /* disable before config */
    /* USARTDIV  = pclk / (16 * baud) = 64e6 / (16 * 115200) = 34.72
     * BRR       = USARTDIV * 16, i.e. BRR[15:4] = mantissa, BRR[3:0] = fraction
     *           = (34 << 4) | 11 = 555  -> 115.3 kBd, 0.1% error
     * Do NOT write USARTDIV*16*16 (=8889): that is 16x too slow and both
     * directions decode as garbage. */
    USART1->BRR = 555UL;
    USART1->CR1 = (1UL << 3) | (1UL << 2) | (1UL << 0);  /* TE | RE | UE */
}

/* MX_SPI1_Init: Master, CPOL=0, CPHA=0, /16 prescaler, SSM|SSI, SPE */
static void MX_SPI1_Init(void) {
    /* Enable SPI1 clock (APB2) */
    RCC_APB2ENR |= (1UL << 12);  /* SPI1EN */

    hspi1.Instance = SPI1;
    hspi1.Mode = 0U;  /* Master */

    /* SPI1/2/3 kernel clock defaults to pll1_q_ck, and this firmware runs on
     * HSI with PLL1 stopped -- the shifter then has no clock at all and no
     * frame ever completes.  per_ck (SPI123SEL = 100) maps to hsi_ker_ck
     * (CKPERSEL = 00) = 64 MHz. */
    RCC_D2CCIP1R = (RCC_D2CCIP1R & ~(7UL << 12)) | (4UL << 12);

    /* Order matters on SPI v2: with SSM=1 the internal NSS is driven by
     * CR1.SSI.  Writing CFG2 (MASTER|SSM) while SSI is still 0 leaves NSS
     * low, the peripheral raises a mode fault on enable and hardware
     * clears MASTER + SPE -- the transfer then waits for RXP forever.
     * So raise SSI first, then MASTER, then SPE. */
    SPI1->CR1  = (1UL << 12);                /* SSI = 1 (internal NSS high) */
    SPI1->CFG1 = (3UL << 28) | 7UL;          /* MBR=/16, DSIZE=8-bit */
    /* RM0433 SPI_CFG2: MASTER = bit22, SSM = bit26.  The original bit
     * numbers (bit2/bit19) are MIDI and SP, so SPI1 stayed in slave mode
     * and every transfer waited for RXP forever -- W25Q_Init hung there. */
    SPI1->CFG2 = (1UL << 22) | (1UL << 26);  /* MASTER, SSM (CPOL=0, CPHA=0) */
    (void)SPI1->SR;                          /* MODF is cleared by read SR ... */
    SPI1->CR1  = (1UL << 12) | (1UL << 0);   /* ... then write CR1: SSI | SPE */
}

/* ---------------- main ---------------- */
int main(void) {
    HAL_Init();
    SystemClock_Config();
    MX_GPIO_Init();
    MX_USART1_UART_Init();
    MX_SPI1_Init();
    (void)W25Q_Init();

    /* Fail closed if the console trampoline is not where crt.c calls it:
     * a compiled program would otherwise jump into garbage and the shell
     * would just look hung with no explanation. */
    {
        unsigned got = (unsigned)(unsigned long)(void (*)(void))ark_board_putn;
        got &= ~1u;
        if (got != TRAMP_ADDR) {
            ark_log("FATAL: ark_board_putn is at %08x, expected %08x -- check"
                    " the .ark_tramp region in the scatter file\r\n",
                    (int)got, (int)TRAMP_ADDR);
            while (1) { }
        }
    }
    /* Report the flash identity once so a missing/miswired chip is visible
     * instead of silently looking like an empty filesystem. */
    ark_log("W25Q JEDEC id = %06x\r\n", W25Q_ReadJedecID());

    ark_log("\r\n=== Ark C Compiler on STM32H743 ===\r\n");
    ark_log("Heap @ %x, Code @ %x\r\n",
            (int)(unsigned long)ark_heap_buffer,
            (int)(unsigned long)ark_code_buffer);
    ark_log("Bufs @ %x (%s)\r\n", (int)arkcc_buf_addr(),
            ((unsigned long)arkcc_buf_addr() >= SDRAM_BANK_ADDR &&
             (unsigned long)arkcc_buf_addr() < SDRAM_BANK_ADDR + SDRAM_SIZE_BYTES)
                ? "compiler work buffers in SDRAM"
                : "compiler work buffers in on-chip RAM");
    ark_log("Type 'help' for commands.\r\n");

    /* Enter interactive shell (reads commands from USART1) */
    shell_loop();

    /* never reached */
    while (1) { }
}
