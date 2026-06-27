/* Ark C Compiler - MDK STM32H743 - stm32h7xx_it
 * 最小化中断向量处理：除 SysTick 外都死循环。
 */
#include "stm32h7xx.h"

/* 由启动文件 weak 声明，可被本文件覆盖。 */
void NMI_Handler(void)        { while (1) { } }
void HardFault_Handler(void)  { while (1) { } }
void MemManage_Handler(void)  { while (1) { } }
void BusFault_Handler(void)   { while (1) { } }
void UsageFault_Handler(void) { while (1) { } }
void SVC_Handler(void)        { /* 不使用 RTOS，留空 */ }
void DebugMon_Handler(void)   { }
void PendSV_Handler(void)     { }

/* SysTick：交给 HAL_IncTick 维护 systick 计数 */
extern void HAL_IncTick(void);
void SysTick_Handler(void) {
    HAL_IncTick();
}
