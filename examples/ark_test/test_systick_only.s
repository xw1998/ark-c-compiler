; Ark C Compiler - generated Thumb-2 assembly
.thumb
.text

.file 1 "test_systick_only.c"
.global Reset_Handler
.type Reset_Handler, %function
Reset_Handler:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
    BL __arkcc_init_globals
.loc 1 18
    MOVW r0, #0
    MOVT r0, #8192
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
.loc 1 19
.L_Reset_Handler_0:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOVW r0, #16384
    MOVT r0, #8192
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE LT
    MOVLT r0, #1
    MOVGE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_Reset_Handler_1
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
    POP {r0}
    B .L_Reset_Handler_0
.L_Reset_Handler_1:
.loc 1 22
    MOVW r0, #14384
    MOVT r0, #16386
    PUSH {r0}
    POP {r0}
    PUSH {r0}
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    MOV r2, #4
    MUL r1, r2
    ADD r0, r0, r1
    LDR r0, [r0, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 23
    MOVW r0, #2048
    MOVT r0, #16386
    PUSH {r0}
    MOVW r0, #2048
    MOVT r0, #16386
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    MOV r2, #4
    MUL r1, r2
    ADD r0, r0, r1
    LDR r0, [r0, #0]
    PUSH {r0}
    MOVW r0, #0
    MOVT r0, #3072
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOVW r0, #0
    MOVT r0, #1024
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 26
    MOVW r0, #57364
    MOVT r0, #57344
    PUSH {r0}
    MOVW r0, #15999
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 27
    MOVW r0, #57368
    MOVT r0, #57344
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 28
    MOVW r0, #57360
    MOVT r0, #57344
    PUSH {r0}
    MOV r0, #7
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 30
.L_Reset_Handler_2:
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_Reset_Handler_3
    B .L_Reset_Handler_2
.L_Reset_Handler_3:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size Reset_Handler, .-Reset_Handler

.global Default_Handler
.type Default_Handler, %function
Default_Handler:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 30
.loc 1 33
.L_Default_Handler_0:
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_Default_Handler_1
    B .L_Default_Handler_0
.L_Default_Handler_1:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size Default_Handler, .-Default_Handler

.global SysTick_Handler
.type SysTick_Handler, %function
SysTick_Handler:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 33
.loc 1 38
    MOVW r0, #0
    MOVT r0, #8192
    LDR r0, [r0]
    PUSH {r0}
    MOVW r0, #0
    MOVT r0, #8192
    LDR r0, [r0]
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    POP {r0}
    MOVW r1, #0
    MOVT r1, #8192
    STR r0, [r1]
    POP {r0}
.loc 1 39
    MOVW r0, #0
    MOVT r0, #8192
    LDR r0, [r0]
    PUSH {r0}
    MOVW r0, #500
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HS
    MOVHS r0, #1
    MOVLO r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_SysTick_Handler_0
.loc 1 40
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    PUSH {r0}
    PUSH {r0}
    POP {r0}
    MOVW r1, #0
    MOVT r1, #8192
    STR r0, [r1]
    POP {r0}
.loc 1 42
    MOVW r0, #2072
    MOVT r0, #16386
    PUSH {r0}
    MOVW r0, #8192
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 43
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
.L_SysTick_Handler_2:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOVW r0, #10000
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE LT
    MOVLT r0, #1
    MOVGE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_SysTick_Handler_3
.L_SysTick_Handler_4:
    LDR r0, [r6, #0]
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
    POP {r0}
    B .L_SysTick_Handler_2
.L_SysTick_Handler_3:
.loc 1 44
    MOVW r0, #2072
    MOVT r0, #16386
    PUSH {r0}
    MOVW r0, #0
    MOVT r0, #8192
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 45
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
.L_SysTick_Handler_5:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOVW r0, #10000
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE LT
    MOVLT r0, #1
    MOVGE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_SysTick_Handler_6
.L_SysTick_Handler_7:
    LDR r0, [r6, #0]
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
    POP {r0}
    B .L_SysTick_Handler_5
.L_SysTick_Handler_6:
.loc 1 46
    MOVW r0, #2072
    MOVT r0, #16386
    PUSH {r0}
    MOVW r0, #8192
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_SysTick_Handler_1
.L_SysTick_Handler_0:
.L_SysTick_Handler_1:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size SysTick_Handler, .-SysTick_Handler

.global main
.type main, %function
main:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 46
.loc 1 50
.L_main_0:
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_main_1
    B .L_main_0
.L_main_1:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size main, .-main

.global SystemInit
.type SystemInit, %function
SystemInit:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 50
.loc 1 51
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size SystemInit, .-SystemInit

.global SystemClock_Config
.type SystemClock_Config, %function
SystemClock_Config:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 51
.loc 1 52
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size SystemClock_Config, .-SystemClock_Config

.global MX_GPIO_Init
.type MX_GPIO_Init, %function
MX_GPIO_Init:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 52
.loc 1 53
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size MX_GPIO_Init, .-MX_GPIO_Init

.global __arkcc_init_globals
.thumb_func
__arkcc_init_globals:
    PUSH {lr}
    MOVW r0, #0
    MOVT r0, #8192
    MOVW r1, #4
    MOVT r1, #8192
    CMP r0, r1
    BEQ .L_bss_done
    MOV r2, #0
.L_bss_loop:
    STR r2, [r0]
    ADD r0, r0, #4
    CMP r0, r1
    BNE .L_bss_loop
.L_bss_done:
    POP {r0}
    BX r0

.global __aeabi_ladd
.thumb_func
__aeabi_ladd:
    ADD r0, r0, r2
    ADC r1, r3
    BX lr

.global __aeabi_lsub
.thumb_func
__aeabi_lsub:
    SUB r0, r0, r2
    SBC r1, r3
    BX lr

.global __aeabi_lmul
.thumb_func
__aeabi_lmul:
    PUSH {r4, r5, lr}
    MOV r4, r3
    MUL r4, r0
    MOV r5, r1
    MUL r5, r2
    UMULL r0, r1, r0, r2
    ADD r1, r4
    ADD r1, r5
    POP {r4, r5, pc}

.global __aeabi_lcmp
.thumb_func
__aeabi_lcmp:
    CMP r1, r3
    BGT .L_lcmp_gt
    BLT .L_lcmp_lt
    CMP r0, r2
    BHI .L_lcmp_gt
    BCC .L_lcmp_lt
    MOV r0, #0
    BX lr
.L_lcmp_lt:
    MOV r0, #0
    MVN r0, r0
    BX lr
.L_lcmp_gt:
    MOV r0, #1
    BX lr

.global __aeabi_ulcmp
.thumb_func
__aeabi_ulcmp:
    CMP r1, r3
    BHI .L_ulcmp_gt
    BCC .L_ulcmp_lt
    CMP r0, r2
    BHI .L_ulcmp_gt
    BCC .L_ulcmp_lt
    MOV r0, #0
    BX lr
.L_ulcmp_lt:
    MOV r0, #0
    MVN r0, r0
    BX lr
.L_ulcmp_gt:
    MOV r0, #1
    BX lr

.global __aeabi_uldivmod
.thumb_func
__aeabi_uldivmod:
    Push {r4, r5, r6, r7, lr}
    MOV r6, r2
    MOV r7, r3
    MOV r2, #0
    MOV r3, #0
    MOV r4, #64
    MOV r5, r6
    ORR r5, r7
    CMP r5, #0
    BEQ .L_uldiv_zero
.L_uldiv_loop:
    LSR r5, r1, #31
    Push {r5}
    LSR r5, r0, #31
    LSL r0, r0, #1
    LSL r1, r1, #1
    ORR r1, r5
    Pop {r5}
    Push {r4}
    LSR r4, r2, #31
    LSL r2, r2, #1
    ORR r2, r5
    LSL r3, r3, #1
    ORR r3, r4
    Pop {r4}
    CMP r3, r7
    BHI .L_uldiv_sub
    BCC .L_uldiv_skip
    CMP r2, r6
    BCC .L_uldiv_skip
.L_uldiv_sub:
    SUB r2, r2, r6
    SBC r3, r7
    MOV r5, #1
    ORR r0, r5
.L_uldiv_skip:
    SUB r4, r4, #1
    BNE .L_uldiv_loop
    Pop {r4, r5, r6, r7, pc}
.L_uldiv_zero:
    MOV r0, #0
    MOV r1, #0
    MOV r2, #0
    MOV r3, #0
    Pop {r4, r5, r6, r7, pc}

.global __aeabi_ldivmod
.thumb_func
__aeabi_ldivmod:
    Push {r4, r5, r6, r7, lr}
    ASR r5, r1, #31
    MOV r6, r5
    CMP r5, #0
    BEQ .L_ldiv_posd
    CMP r0, #0
    BEQ .L_ldiv_neg_d_hi
    RSB r0, r0
    MVN r1, r1
    B .L_ldiv_posd
.L_ldiv_neg_d_hi:
    RSB r1, r1
.L_ldiv_posd:
    ASR r5, r3, #31
    CMP r5, #0
    BEQ .L_ldiv_posb
    CMP r2, #0
    BEQ .L_ldiv_neg_b_hi
    RSB r2, r2
    MVN r3, r3
    B .L_ldiv_posb
.L_ldiv_neg_b_hi:
    RSB r3, r3
.L_ldiv_posb:
    BL __aeabi_uldivmod
    MOV r4, r6
    EOR r4, r5
    CMP r4, #0
    BEQ .L_ldiv_qpos
    CMP r0, #0
    BEQ .L_ldiv_neg_q_hi
    RSB r0, r0
    MVN r1, r1
    B .L_ldiv_qpos
.L_ldiv_neg_q_hi:
    RSB r1, r1
.L_ldiv_qpos:
    CMP r6, #0
    BEQ .L_ldiv_rpos
    CMP r2, #0
    BEQ .L_ldiv_neg_r_hi
    RSB r2, r2
    MVN r3, r3
    B .L_ldiv_rpos
.L_ldiv_neg_r_hi:
    RSB r3, r3
.L_ldiv_rpos:
    Pop {r4, r5, r6, r7, pc}

