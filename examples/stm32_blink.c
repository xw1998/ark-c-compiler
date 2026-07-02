/* Minimal STM32H743 program: blink LED on GPIOB0 via direct register access.
 * Compile with: arkcc examples/stm32_blink.c -target arm -mcpu Cortex-M7 -S -o stm32_blink.s
 * Or cross-compile to binary: arkcc examples/stm32_blink.c -target arm -mcpu Cortex-M7 -o stm32_blink.bin
 */
#include <stdint.h>

/* STM32H743 register base addresses */
#define RCC_AHB4ENR   (*(volatile uint32_t *)0x580244E0u)
#define GPIOB_MODER   (*(volatile uint32_t *)0x58020400u)
#define GPIOB_BSRR    (*(volatile uint32_t *)0x58020418u)

static void delay(volatile uint32_t count) {
    while (count--) __asm__ volatile("nop");
}

int main(void) {
    /* Enable GPIOB clock */
    RCC_AHB4ENR |= (1u << 1);
    /* Set PB0 as output */
    GPIOB_MODER = (GPIOB_MODER & ~(3u << 0)) | (1u << 0);
    /* Toggle PB0 forever */
    while (1) {
        GPIOB_BSRR = (1u << 0);         /* set PB0 */
        delay(500000);
        GPIOB_BSRR = (1u << 16);        /* reset PB0 */
        delay(500000);
    }
    return 0;
}
