/* armcc 5 compatibility test - simplified
 * Compile with armcc:  armcc --c99 --cpu Cortex-M7.fp.dp -S test_armcc_compat.c
 * Compile with arkCC:   arkcc -target arm -S test_armcc_compat.c
 */
#include <stdint.h>

/* === 1. armcc 5 keywords (Cortex-M supported) === */
__weak void weak_func(void) { }
__irq void irq_handler(void) { }
__packed struct PackedS { uint8_t a; uint32_t b; };
__packed typedef struct { uint8_t a; uint16_t b; } PackedT;
__value_in_regs struct RetStruct { uint32_t a; uint32_t b; } return_pair(void) {
    struct RetStruct r = { 1, 2 };
    return r;
}
__pure int pure_func(int x) { return x * 2; }

/* === 2. __attribute__ forms (armcc5 supported) === */
__attribute__((weak)) void attr_weak(void) { }
__attribute__((section(".mysec"))) int mysec_var = 42;
__attribute__((used)) int used_var = 1;
__attribute__((unused)) int unused_var = 2;
__attribute__((deprecated)) int dep_var = 3;
__attribute__((constructor)) void ctor_func(void) { }
__attribute__((destructor))  void dtor_func(void) { }
__attribute__((aligned(8))) int aligned_var = 4;
__attribute__((noreturn)) void noreturn_func(void) { while(1); }

/* === 3. Inline assembly (armcc5 string form) === */
static inline void nop(void) { __asm volatile("nop"); }
static inline void wfi(void)  { __asm volatile("wfi"); }
static inline void cpsie_i(void) { __asm volatile("cpsie i"); }
static inline void cpsid_i(void) { __asm volatile("cpsid i"); }
static inline void dsb(void)  { __asm volatile("dsb"); }
static inline void isb(void)  { __asm volatile("isb"); }
static inline void dmb(void)  { __asm volatile("dmb"); }

/* === 4. #pragma (armcc5 supported) === */
#pragma pack(push, 1)
struct P1 { uint8_t a; uint32_t b; };
#pragma pack(pop)

#pragma push
#pragma pop
#pragma once

/* === 5. CMSIS register access patterns === */
#define REG32(addr) (*(volatile uint32_t *)(addr))
#define RCC_BASE     0x58024400U
#define RCC_AHB4ENR  REG32(RCC_BASE + 0xE0U)

/* === 6. Interrupt vector table pattern (weak handlers) === */
void Reset_Handler(void);
void NMI_Handler(void)        __attribute__((weak));
void HardFault_Handler(void)  __attribute__((weak));
void SysTick_Handler(void)    __attribute__((weak));

typedef void (*pHandler)(void);
__attribute__((section(".isr_vector"), used))
pHandler vector_table[] = {
    (pHandler)0x20020000,
    Reset_Handler,
    NMI_Handler,
    HardFault_Handler,
};

int main(void) {
    volatile uint32_t x = 0;
    RCC_AHB4ENR |= (1U << 1);
    cpsie_i();
    cpsid_i();
    dsb();
    isb();
    nop();
    return (int)x;
}
