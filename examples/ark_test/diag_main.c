/* Minimal HAL diagnostic - bypass SystemClock_Config and MX_GPIO_Init.
 * Directly configures GPIO and tests HAL_Delay.
 * LED behavior tells us where it hangs:
 *   - LED OFF          : Reset_Handler or BSS clear failed
 *   - LED ON solid     : HAL_Delay stuck (SysTick not firing)
 *   - LED blinking     : everything works
 */
#include "main.h"

#define RCC_AHB1ENR   (*(volatile unsigned int *)0x40023830)
#define GPIOC_MODER   (*(volatile unsigned int *)0x40020800)
#define GPIOC_BSRR    (*(volatile unsigned int *)0x40020818)

extern unsigned int SystemCoreClock;

int main(void) {
    /* Direct GPIO config (bypass MX_GPIO_Init) */
    RCC_AHB1ENR |= (1u << 2);
    GPIOC_MODER = (GPIOC_MODER & ~(3u << 26)) | (1u << 26);

    /* Test 1: blink without HAL_Delay (raw loop) */
    {
        int n;
        for (n = 0; n < 3; n++) {
            volatile int i;
            GPIOC_BSRR = (1u << 29);  /* ON */
            for (i = 0; i < 200000; i++) {}
            GPIOC_BSRR = (1u << 13);  /* OFF */
            for (i = 0; i < 200000; i++) {}
        }
    }

    /* Test 2: call HAL_Init (sets up SysTick) */
    HAL_Init();

    /* Test 3: blink with HAL_Delay */
    while (1) {
        GPIOC_BSRR = (1u << 29);  /* ON */
        HAL_Delay(500);
        GPIOC_BSRR = (1u << 13);  /* OFF */
        HAL_Delay(500);
    }
    return 0;
}

void SystemClock_Config(void) {
    /* Stub - not called, HSI 16MHz default */
}

void MX_GPIO_Init(void) {
    /* Stub - GPIO already configured in main */
}
