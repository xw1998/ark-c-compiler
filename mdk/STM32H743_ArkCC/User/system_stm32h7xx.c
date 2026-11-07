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

extern void ark_fpu_barrier(void);

void SystemInit(void) {
    /* SRAM1/2/3 sit in the D2 domain and are clock-gated by RCC_AHB2ENR, which
     * resets to all-zero.  The scatter file places .data/.bss at 0x30000000
     * (SRAM1..3), and __main copies and zeroes those sections before main()
     * runs -- so the clocks have to be on HERE, not in main().  With them off
     * the copies went nowhere: s_tick read back as 0xAEF2... instead of 0 and
     * HAL_Delay() spun forever waiting for a tick that could never arrive.
     *
     * Offsets from RM0433: RCC base 0x58024400, AHB2ENR 0xDC,
     * SRAM1EN bit29 / SRAM2EN bit30 / SRAM3EN bit31. */
    *(volatile unsigned *)0x580244DCU |= (1U << 29) | (1U << 30) | (1U << 31);

    /* Enable the FPU (CPACR: CP10/CP11 full access, bits 20-23).
     * Cost of leaving it off was a hard fault the moment the compiler touched
     * floating point: lexer_read_token() prologue is `VPUSH {d8-d13}` at
     * 0x08014838, and with CP10/CP11 disabled that instruction raises
     * UsageFault NOCP (CFSR bit19 = 0x00080000), escalated to HardFault
     * (HFSR.FORCED).  SCB base 0xE000ED00, CPACR 0xE000ED88. */
    *(volatile unsigned *)0xE000ED88U |= (0xFU << 20);
    ark_fpu_barrier();
}

/* AC5 embedded assembler: this project does not pull in core_cm7.h, so the
 * __DSB/__ISB intrinsics are unavailable.  Same style as stm32h7xx_it.c. */
__asm void ark_fpu_barrier(void) {
    DSB
    ISB
    BX      lr
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
    /* Start SysTick at 1 kHz.  Nothing configured it before, so the counter
     * never moved and every HAL_Delay() (W25Q_Init, for one) hung in its busy
     * loop -- the firmware never reached the banner.  64 MHz HSI / 1000.
     * SysTick registers: CTRL 0xE000E010, LOAD 0xE000E014, VAL 0xE000E018. */
    *(volatile unsigned *)0xE000E014U = 64000U - 1U;
    *(volatile unsigned *)0xE000E018U = 0U;
    *(volatile unsigned *)0xE000E010U = 7U;   /* CLKSOURCE | TICKINT | ENABLE */
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
        /* Wait until RXNE (Read Data Register Not Empty) with timeout.
         *
         * ORE/FE/NE must be drained by reading RDR as well, not ignored:
         * an overrun happens whenever the core is halted (debugger stop,
         * breakpoint) while bytes keep arriving, and the receive path then
         * stays deaf -- the shell stops echoing every command with nothing
         * on the wire to explain it.  That is exactly what happened here. */
        while (!(huart->Instance->ISR & (1 << 5))) {
            /* STM32H7 USART is the v4 flavour: ORE/FE/NE are cleared by
             * WRITING USART_ICR, not by the F1/F4 "read ISR then read
             * RDR" sequence.  The first fix here used that sequence and
             * the flags stayed set, so the receiver stayed deaf -- every
             * command after one overrun (an overrun happens whenever the
             * core is halted with bytes on the wire) was ignored in
             * silence.  ICR bits: FECF=1, NECF=2, ORECF=3. */
            if (huart->Instance->ISR & 0x0EUL) {
                huart->Instance->ICR = 0x0EUL;   /* FECF | NECF | ORECF */
                (void)huart->Instance->RDR;      /* drop the lost byte */
            }
            if (to > 0) { to--; }
            else return HAL_TIMEOUT;
        }
        pData[i] = (uint8_t)huart->Instance->RDR;
        to = Timeout; /* reset timeout for next byte */
    }
    return HAL_OK;
}

/* STM32H7 SPI (v2) needs an explicit job descriptor: CR2.TSIZE says how
 * many frames this transfer has and CR1.CSTART kicks it off.  Without
 * them TXDR accepts bytes that never leave the FIFO, so the following RXP
 * wait spins forever -- that is exactly how W25Q_Init() froze at boot.
 * The kernel clock must be alive too; see MX_SPI1_Init() (SPI1/2/3 default
 * to pll1_q_ck, and this firmware runs on HSI with PLL1 off).
 * Timeout is honoured in milliseconds via HAL_GetTick(); HAL_MAX_DELAY
 * still means "wait forever" but a dead bus now reports HAL_TIMEOUT
 * instead of hanging the shell. */
HAL_StatusTypeDef HAL_SPI_TransmitReceive(SPI_HandleTypeDef *hspi,
                                          uint8_t *pTxData, uint8_t *pRxData,
                                          uint16_t Size, uint32_t Timeout) {
    uint16_t i;
    uint32_t start = HAL_GetTick();
    if (Size == 0U) { return HAL_OK; }

    hspi->Instance->CR2 = (hspi->Instance->CR2 & ~0xFFFFUL) | (uint32_t)Size;
    hspi->Instance->CR1 |= (1UL << 0);   /* SPE     */
    hspi->Instance->CR1 |= (1UL << 9);   /* CSTART  */

    for (i = 0; i < Size; i++) {
        /* Wait until TXP (Tx Packet) */
        while (!(hspi->Instance->SR & (1 << 1))) {
            if (Timeout != HAL_MAX_DELAY && (HAL_GetTick() - start) >= Timeout) {
                return HAL_TIMEOUT;
            }
        }
        hspi->Instance->TXDR = pTxData[i];
        /* Wait until RXP (Rx Packet) */
        while (!(hspi->Instance->SR & (1 << 0))) {
            if (Timeout != HAL_MAX_DELAY && (HAL_GetTick() - start) >= Timeout) {
                return HAL_TIMEOUT;
            }
        }
        pRxData[i] = (uint8_t)hspi->Instance->RXDR;
    }
    /* End of transfer: wait EOT so the caller may release CS. */
    while (!(hspi->Instance->SR & (1 << 3))) {
        if (Timeout != HAL_MAX_DELAY && (HAL_GetTick() - start) >= Timeout) {
            return HAL_TIMEOUT;
        }
    }
    return HAL_OK;
}
