/* Ark C Compiler - MDK STM32H743 - core_cm7 (占位) */
#ifndef __CORE_CM7_H_GENERIC
#define __CORE_CM7_H_GENERIC

#warning "core_cm7.h 当前是占位实现，请用 ARM 官方 CMSIS 5/6 覆盖"

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

/* 占位的 NVIC / SCB 接口；真正使用时必须替换为官方 CMSIS。 */
typedef struct {
    volatile uint32_t ISER[8];
    uint32_t  RESERVED0[24];
    volatile uint32_t ICER[8];
    uint32_t  RSERVED1[24];
} NVIC_Type;

#define SCS_BASE        (0xE000E000UL)
#define NVIC_BASE       (SCS_BASE + 0x0100UL)
#define NVIC            ((NVIC_Type *) NVIC_BASE)

static __inline void __DSB(void) { __asm volatile ("dsb 0xF":::"memory"); }
static __inline void __ISB(void) { __asm volatile ("isb 0xF":::"memory"); }
static __inline void __NOP(void) { __asm volatile ("nop"); }
static __inline void __WFI(void) { __asm volatile ("wfi"); }

#ifdef __cplusplus
}
#endif

#endif /* __CORE_CM7_H_GENERIC */
