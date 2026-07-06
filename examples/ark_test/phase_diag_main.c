/* Phase diagnostic - blink between each HAL step to find where it hangs.
 * LED blink pattern:
 *   3 blinks  -> GPIO configured (baseline)
 *   HAL_Init() ...
 *   5 blinks  -> HAL_Init returned OK
 *   SystemClock_Config() ...
 *   7 blinks  -> SystemClock_Config returned OK
 *   MX_GPIO_Init() ...
 *   9 blinks  -> MX_GPIO_Init returned OK
 *   then HAL_Delay loop
 * If LED stops at 3 blinks -> HAL_Init hangs
 * If LED stops at 5 blinks -> SystemClock_Config hangs
 * If LED stops at 7 blinks -> MX_GPIO_Init hangs
 * If LED stops at 9 blinks -> HAL_Delay hangs
 */
#include "main.h"

#define RCC_AHB1ENR   (*(volatile unsigned int *)0x40023830)
#define GPIOC_MODER   (*(volatile unsigned int *)0x40020800)
#define GPIOC_BSRR    (*(volatile unsigned int *)0x40020818)

extern unsigned int SystemCoreClock;

static void blink_raw(int count) {
    int n;
    for (n = 0; n < count; n++) {
        volatile int i;
        GPIOC_BSRR = (1u << 29);  /* ON */
        for (i = 0; i < 200000; i++) {}
        GPIOC_BSRR = (1u << 13);  /* OFF */
        for (i = 0; i < 200000; i++) {}
    }
    volatile int i;
    for (i = 0; i < 600000; i++) {}  /* long pause between groups */
}

int main(void) {
    RCC_AHB1ENR |= (1u << 2);
    GPIOC_MODER = (GPIOC_MODER & ~(3u << 26)) | (1u << 26);

    blink_raw(3);  /* baseline: 3 blinks */

    HAL_Init();
    blink_raw(5);  /* if we get here, HAL_Init returned */

    SystemClock_Config();
    blink_raw(7);  /* if we get here, SystemClock_Config returned */

    MX_GPIO_Init();
    blink_raw(9);  /* if we get here, MX_GPIO_Init returned */

    while (1) {
        GPIOC_BSRR = (1u << 29);  /* ON */
        HAL_Delay(500);
        GPIOC_BSRR = (1u << 13);  /* OFF */
        HAL_Delay(500);
    }
    return 0;
}

void SystemClock_Config(void);
void MX_GPIO_Init(void);
