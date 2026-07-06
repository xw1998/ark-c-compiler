/* Minimal SysTick test - bypass HAL entirely.
 * Configure SysTick directly, toggle LED in SysTick_Handler.
 * If LED blinks -> SysTick interrupt works -> arkcc codegen is fine,
 *   problem is in HAL init sequence.
 * If LED solid -> SysTick interrupt never fires -> arkcc has a bug
 *   in interrupt handler setup or vector table.
 */
#define RCC_AHB1ENR   (*(volatile unsigned int *)0x40023830)
#define GPIOC_MODER   (*(volatile unsigned int *)0x40020800)
#define GPIOC_BSRR    (*(volatile unsigned int *)0x40020818)
#define SYSTICK_CTRL  (*(volatile unsigned int *)0xE000E010)
#define SYSTICK_LOAD  (*(volatile unsigned int *)0xE000E014)
#define SYSTICK_VAL   (*(volatile unsigned int *)0xE000E018)

extern unsigned int SystemCoreClock;

void Reset_Handler(void) {
    volatile unsigned int *p = (volatile unsigned int *)0x20000000u;
    while (p < (volatile unsigned int *)0x20004000u) { *p = 0u; p++; }

    /* Enable GPIOC */
    RCC_AHB1ENR |= (1u << 2);
    GPIOC_MODER = (GPIOC_MODER & ~(3u << 26)) | (1u << 26);

    /* Configure SysTick: 16000 cycles = 1ms @ 16MHz HSI */
    SYSTICK_LOAD = 16000 - 1;
    SYSTICK_VAL = 0;
    SYSTICK_CTRL = 7;  /* CLKSOURCE=HCLK, TICKINT=1, ENABLE=1 */

    while (1) {}
}

void Default_Handler(void) { while (1) {} }

volatile unsigned int tick_count = 0;

void SysTick_Handler(void) {
    tick_count++;
    if (tick_count >= 500) {
        tick_count = 0;
        /* Toggle LED */
        GPIOC_BSRR = (1u << 13);  /* OFF */
        for (volatile int i = 0; i < 10000; i++) {}
        GPIOC_BSRR = (1u << 29);  /* ON */
        for (volatile int i = 0; i < 10000; i++) {}
        GPIOC_BSRR = (1u << 13);  /* OFF */
    }
}

int main(void) { while (1) {} return 0; }
void SystemInit(void) {}
void SystemClock_Config(void) {}
void MX_GPIO_Init(void) {}
