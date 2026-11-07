/* Ark C Compiler - MDK STM32H743 - stm32h7xx_it
 * Minimal interrupt vector handling: all handlers except SysTick enter an infinite loop.
 */
#include "stm32h7xx.h"

/* Declared weak by the startup file; can be overridden here. */
void NMI_Handler(void)        { while (1) { } }

/* Fault handlers print the stacked frame before halting (ark_report_fault
 * lives in main.c).  `B .` alone made a board-side crash indistinguishable
 * from a board-side hang: nothing on the wire, nothing to go on. */
void ark_report_fault(unsigned *sp);

/* `__asm void` cannot come out of a macro (armcc rejects the attribute), so
 * the four handlers are written out.  Each one hands the stacked frame to
 * ark_report_fault() and then stops. */
__asm void HardFault_Handler(void)
{
    IMPORT  ark_report_fault
    MOV     r0, sp
    BL      ark_report_fault
    B       .
}

__asm void MemManage_Handler(void)
{
    IMPORT  ark_report_fault
    MOV     r0, sp
    BL      ark_report_fault
    B       .
}

__asm void BusFault_Handler(void)
{
    IMPORT  ark_report_fault
    MOV     r0, sp
    BL      ark_report_fault
    B       .
}

__asm void UsageFault_Handler(void)
{
    IMPORT  ark_report_fault
    MOV     r0, sp
    BL      ark_report_fault
    B       .
}

void SVC_Handler(void)        { /* no RTOS used, left empty */ }
void DebugMon_Handler(void)   { }
void PendSV_Handler(void)     { }

/* SysTick: let HAL_IncTick maintain the systick counter */
extern void HAL_IncTick(void);
void SysTick_Handler(void) {
    HAL_IncTick();
}
