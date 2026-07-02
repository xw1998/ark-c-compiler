/* /app/blink.c - Sample project for ArkCC STM32 shell
 *
 * This file demonstrates a complete STM32H743 program that can be
 * compiled on-device using the ArkCC shell:
 *   arkcc> compile /app/blink.c
 *
 * The program blinks LED on PB0 using direct register access.
 * Compatible with the STM32H743 memory map.
 */

/* STM32H743 register addresses (simplified, no HAL needed) */
#define RCC_BASE        (0x58024400u)
#define RCC_AHB4ENR     (*((volatile unsigned int*)(RCC_BASE + 0xE0)))
#define GPIOB_BASE      (0x58020400u)
#define GPIOB_MODER     (*((volatile unsigned int*)(GPIOB_BASE + 0x00)))
#define GPIOB_ODR       (*((volatile unsigned int*)(GPIOB_BASE + 0x14)))

/* Simple delay loop */
static void delay(volatile int count) {
    while (count-- > 0) {
        /* wait */
    }
}

/* Main entry point - called by ArkCC runtime */
int main(void) {
    int i;

    /* Enable GPIOB clock (bit 1 of AHB4ENR) */
    RCC_AHB4ENR |= (1u << 1);

    /* Set PB0 to output mode (MODER = 01) */
    GPIOB_MODER &= ~(3u << 0);
    GPIOB_MODER |=  (1u << 0);

    /* Blink loop */
    for (i = 0; i < 10; i++) {
        GPIOB_ODR |=  (1u << 0);   /* LED on */
        delay(500000);
        GPIOB_ODR &= ~(1u << 0);   /* LED off */
        delay(500000);
    }

    return 0;
}
