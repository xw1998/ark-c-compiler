/* Ark C Compiler - MDK STM32H743 - main
 * 自宿主编译器入口：从 W25Q128 上的 /app/main.c 读取源代码并编译运行。
 *
 * 注意：本文件中 HAL_Init / SystemClock_Config / MX_xxx_Init 等均为
 * 占位实现，请用 STM32CubeMX 生成的代码替换以获得真正的硬件初始化。
 */
#include "stm32h7xx.h"
#include "bsp_w25q.h"
#include "platform.h"
#include "flash_fs.h"
#include "compiler.h"

/* HAL 句柄（按 STM32 习惯定义为全局） */
UART_HandleTypeDef huart1;
SPI_HandleTypeDef  hspi1;

/* === ArkCC 专用大块缓冲：放到 AXI SRAM 的专用段 ===
 * scatter 文件把 .ark_heap / .ark_code 段链接到 0x24000000 起的 AXI SRAM。
 */
__attribute__((section(".ark_heap"))) unsigned char ark_heap_buffer[64 * 1024];
__attribute__((section(".ark_code"))) unsigned char ark_code_buffer[32 * 1024];

/* === platform_stm32.c 需要的 UART 包装函数 === */
void HAL_UART_Transmit_Wrapper(const unsigned char *buf, int len) {
    (void)HAL_UART_Transmit(&huart1, buf, (uint16_t)len, 1000);
}

/* === 极简 logf：复用 ark_log === */
void ark_logf(const char *fmt, int v) {
    ark_log(fmt, v);
}

/* ---------------- 占位初始化函数 ---------------- */
static void SystemClock_Config(void) {
#warning "SystemClock_Config 为占位，请用 STM32CubeMX 生成 480MHz PLL 配置替换"
    /* 期望：HSE 25MHz -> PLL1 -> SYSCLK 480MHz
     * 当前占位不做任何寄存器写入，复位后系统跑在内部 HSI 64MHz。
     */
}

static void MX_GPIO_Init(void) {
#warning "MX_GPIO_Init 为占位：需使能 GPIOA 时钟，配置 PA4(CS) 输出 / PA5-PA7 复用 SPI1 / PA9-PA10 复用 USART1"
}

static void MX_USART1_UART_Init(void) {
#warning "MX_USART1_UART_Init 为占位：请补充 USART1 寄存器或调用 HAL_UART_Init(&huart1)"
    huart1.Instance = USART1;
    huart1.BaudRate = 115200U;
}

static void MX_SPI1_Init(void) {
#warning "MX_SPI1_Init 为占位：请补充 SPI1 寄存器或调用 HAL_SPI_Init(&hspi1)"
    hspi1.Instance = SPI1;
    hspi1.Mode     = 0U; /* Master */
}

/* ---------------- main ---------------- */
int main(void) {
    int rc;

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
    ark_log("Compiling /app/main.c from W25Q...\r\n");

    rc = ark_compile_and_run("/app/main.c");
    ark_log("Exit code: %d\r\n", rc);

    while (1) {
        /* 主循环占位 */
    }
}
