/* Ark C Compiler - MDK STM32H743 - system_stm32h7xx
 * Placeholder implementation of system clock init, called by Reset_Handler in the startup file.
 *
 * For a real project, use the system_stm32h7xx.c provided by STM32CubeH7.
 * Here we only provide the minimal symbols SystemInit / SystemCoreClock so linking succeeds.
 * The HAL stubs below provide actual UART/SPI register access so arkcc can
 * communicate over USART1 (shell) and SPI1 (W25Q flash).
 */
#include "stm32h7xx.h"

#warning "system_stm32h7xx.c is a placeholder; replace with the official version"

/* After reset HSI defaults to 64MHz; the placeholder does not switch clocks and keeps a safe value. */
uint32_t SystemCoreClock = 64000000U;

void SystemInit(void) {
    /* A real implementation needs: enable PWR voltage scaling, configure FLASH wait states,
     * HSE/PLL1, etc. The placeholder does the simplest thing: nothing.
     */
}

/* === armcc5 C library retarget: __user_initial_stackheap ===
 * Without this, armlink pulls in the default semihosting-based version which
 * fails with L6915E when scatter loading is in use. We provide our own that
 * uses ark_heap_buffer (in AXI SRAM) as the C library heap and the top of
 * DTCM as the stack. The compiler itself uses mem_pool_alloc (not malloc), so
 * the C library heap is only used by any stray libc calls (strlen/strcmp are
 * usually inline and don't need it).
 *
 * The struct __initial_stackheap layout (armcc5):
 *   { void *heap_base; void *heap_limit; void *stack_base; void *stack_limit; }
 */
extern unsigned char ark_heap_buffer[];  /* defined in main.c, 32 KB in .ark_heap */

struct __initial_stackheap {
    unsigned char *heap_base;
    unsigned char *heap_limit;
    unsigned char *stack_base;
    unsigned char *stack_limit;
};

/* DTCM is 128KB @ 0x20000000. Stack grows downward from the top.
 * Reserve 0x8000 (32KB) for stack, leaving 96KB for .data/.bss. */
#define DTCM_BASE       0x20000000U
#define DTCM_SIZE       0x00020000U   /* 128 KB */
#define STACK_SIZE      0x00008000U   /* 32 KB reserved for stack */

__value_in_regs struct __initial_stackheap __user_initial_stackheap(
        unsigned R0, unsigned SP, unsigned R2, unsigned SL) {
    struct __initial_stackheap config;
    (void)R0; (void)R2; (void)SL;
    /* Heap: use ark_heap_buffer (32KB in AXI SRAM @ 0x24000000) */
    config.heap_base  = ark_heap_buffer;
    config.heap_limit = ark_heap_buffer + 32 * 1024;
    /* Stack: top of DTCM, growing downward. SP is already set by startup. */
    config.stack_base  = (unsigned char *)(DTCM_BASE + DTCM_SIZE);
    config.stack_limit = (unsigned char *)(DTCM_BASE + DTCM_SIZE - STACK_SIZE);
    return config;
}

/* === SysTick-based HAL tick === */
static volatile uint32_t s_tick = 0;

HAL_StatusTypeDef HAL_Init(void) {
    s_tick = 0;
    return HAL_OK;
}

void HAL_IncTick(void) {
    s_tick++;
}

uint32_t HAL_GetTick(void) {
    return s_tick;
}

void HAL_Delay(uint32_t Delay) {
    uint32_t start = s_tick;
    while ((s_tick - start) < Delay) {
        /* busy wait */
    }
}

/* === HAL UART stubs (polling via USART1 registers) ===
 * These provide real UART I/O so arkcc can log messages and accept shell commands. */
HAL_StatusTypeDef HAL_UART_Transmit(UART_HandleTypeDef *huart,
                                    const uint8_t *pData, uint16_t Size,
                                    uint32_t Timeout) {
    uint16_t i;
    (void)Timeout;
    for (i = 0; i < Size; i++) {
        /* Wait until TXE (Transmit Data Register Empty) */
        while (!(huart->Instance->ISR & (1 << 7))) { }
        huart->Instance->TDR = pData[i];
    }
    /* Wait for TC (Transmission Complete) */
    while (!(huart->Instance->ISR & (1 << 6))) { }
    return HAL_OK;
}

HAL_StatusTypeDef HAL_UART_Receive(UART_HandleTypeDef *huart,
                                   uint8_t *pData, uint16_t Size,
                                   uint32_t Timeout) {
    uint16_t i;
    uint32_t to = Timeout;
    for (i = 0; i < Size; i++) {
        /* Wait until RXNE (Read Data Register Not Empty) with timeout */
        while (!(huart->Instance->ISR & (1 << 5))) {
            if (to > 0) { to--; }
            else return HAL_TIMEOUT;
        }
        pData[i] = (uint8_t)huart->Instance->RDR;
        to = Timeout; /* reset timeout for next byte */
    }
    return HAL_OK;
}

HAL_StatusTypeDef HAL_SPI_TransmitReceive(SPI_HandleTypeDef *hspi,
                                          uint8_t *pTxData, uint8_t *pRxData,
                                          uint16_t Size, uint32_t Timeout) {
    uint16_t i;
    (void)Timeout;
    for (i = 0; i < Size; i++) {
        /* Wait until TXP (Tx Packet) */
        while (!(hspi->Instance->SR & (1 << 1))) { }
        hspi->Instance->TXDR = pTxData[i];
        /* Wait until RXP (Rx Packet) */
        while (!(hspi->Instance->SR & (1 << 0))) { }
        pRxData[i] = (uint8_t)hspi->Instance->RXDR;
    }
    return HAL_OK;
}
