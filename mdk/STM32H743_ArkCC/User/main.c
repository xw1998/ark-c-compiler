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

#define FLASH_R_BASE      (0x52002000UL)
#define FLASH_ACR         REG32(FLASH_R_BASE + 0x00U)

/* RCC_CR bits */
#define RCC_CR_HSEON      (1UL << 16)
#define RCC_CR_HSERDY     (1UL << 17)
#define RCC_CR_PLL1ON     (1UL << 24)
#define RCC_CR_PLL1RDY    (1UL << 25)

/* SystemCoreClock is defined in system_stm32h7xx.c; updated by SystemClock_Config */
extern uint32_t SystemCoreClock;

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
    /* 1. Enable HSE and wait for ready */
    RCC_CR |= RCC_CR_HSEON;
    while (!(RCC_CR & RCC_CR_HSERDY)) { }

    /* 2. Configure PLL1: M=2, N=120, R=1, source=HSE */
    RCC_PLLCKSELR = (2UL << 4) | 0x2UL;        /* DIVM1=2, PLLSRC=HSE(0x2) */
    RCC_PLLCFGR   = (1UL << 2) | (1UL << 4);  /* PLL1REN, PLL1RGE=01(2-4MHz) */
    RCC_PLL1DIVR  = (120UL - 1UL);            /* N1=119 (reg=N-1), R1=0 (reg=R-1) */

    /* 3. Enable PLL1 and wait for ready */
    RCC_CR |= RCC_CR_PLL1ON;
    while (!(RCC_CR & RCC_CR_PLL1RDY)) { }

    /* 4. Flash latency 4 wait states for 480MHz operation */
    FLASH_ACR = (FLASH_ACR & ~0xFUL) | 4UL;

    /* 5. Bus prescalers: D1HPRE=/2 (HCLK=240MHz), D1CPRE=/1 (CPU=480MHz) */
    RCC_D1CFGR = 0x00000008UL;  /* D1HPRE=0b1000 (/2), D1CPRE=0 (/1) */

    /* 6. Switch system clock to PLL1 */
    RCC_CFGR = 0x3UL;  /* SW=PLL1 */
    while ((RCC_CFGR & 0xCUL) != 0xCUL) { }  /* wait for SWS=PLL1 */

    /* 7. Update global clock variable */
    SystemCoreClock = 480000000UL;
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
    USART1->BRR = 2084UL;     /* 240MHz / 115200 ~= 2084 */
    USART1->CR1 = (1UL << 3) | (1UL << 2) | (1UL << 0);  /* TE | RE | UE */
}

/* MX_SPI1_Init: Master, CPOL=0, CPHA=0, /16 prescaler, SSM|SSI, SPE */
static void MX_SPI1_Init(void) {
    /* Enable SPI1 clock (APB2) */
    RCC_APB2ENR |= (1UL << 12);  /* SPI1EN */

    hspi1.Instance = SPI1;
    hspi1.Mode = 0U;  /* Master */

    SPI1->CR1  = 0;                          /* disable before config */
    SPI1->CFG1 = (3UL << 28) | 7UL;          /* MBR=/16, DSIZE=8-bit */
    SPI1->CFG2 = (1UL << 2) | (1UL << 19);  /* MASTER, SSM (CPOL=0, CPHA=0) */
    SPI1->CR1  = (1UL << 12) | (1UL << 0);   /* SSI | SPE */
}

/* ---------------- main ---------------- */
int main(void) {
    HAL_Init();
    SystemClock_Config();
    MX_GPIO_Init();
    MX_USART1_UART_Init();
    MX_SPI1_Init();
    (void)W25Q_Init();

    ark_log("\r\n=== Ark C Compiler on STM32H743 ===\r\n");
    ark_log("Heap @ %x, Code @ %x\r\n",
            (int)(unsigned long)ark_heap_buffer,
            (int)(unsigned long)ark_code_buffer);
    ark_log("Type 'help' for commands.\r\n");

    /* Enter interactive shell (reads commands from USART1) */
    shell_loop();

    /* never reached */
    while (1) { }
}
