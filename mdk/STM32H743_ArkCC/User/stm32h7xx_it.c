/* Ark C Compiler - MDK STM32H743 - stm32h7xx_it
 * Minimal interrupt vector handling: all handlers except SysTick enter an infinite loop.
 */
#include "stm32h7xx.h"

/* Declared weak by the startup file; can be overridden here. */
void NMI_Handler(void)        { while (1) { } }
void HardFault_Handler(void)  { while (1) { } }
void MemManage_Handler(void)  { while (1) { } }
void BusFault_Handler(void)   { while (1) { } }
void UsageFault_Handler(void) { while (1) { } }
void SVC_Handler(void)        { /* no RTOS used, left empty */ }
void DebugMon_Handler(void)   { }
void PendSV_Handler(void)     { }

/* SysTick: let HAL_IncTick maintain the systick counter */
extern void HAL_IncTick(void);
void SysTick_Handler(void) {
    HAL_IncTick();
}
