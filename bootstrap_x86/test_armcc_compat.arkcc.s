; Ark C Compiler - generated Thumb-2 assembly
.thumb
.text

.file 1 "bootstrap_x86\test_armcc_compat.c"
.global weak_func
.weak weak_func
.type weak_func, %function
weak_func:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 122
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size weak_func, .-weak_func

.global irq_handler
.type irq_handler, %function
irq_handler:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 122
.loc 1 123
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size irq_handler, .-irq_handler

.global return_pair
@ __value_in_regs
.type return_pair, %function
return_pair:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 123
.loc 1 127
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #4]
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
    MOV r0, #2
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #4]
.loc 1 128
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size return_pair, .-return_pair

.global pure_func
@ __pure
.type pure_func, %function
pure_func:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 128
    MOV r3, r0
    LDR r0, [r3, #0]
    STR r0, [r6, #0]
.loc 1 130
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size pure_func, .-pure_func

.global attr_weak
.weak attr_weak
.type attr_weak, %function
attr_weak:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 130
.loc 1 133
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size attr_weak, .-attr_weak

.global ctor_func
.type ctor_func, %function
ctor_func:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 133
.loc 1 138
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size ctor_func, .-ctor_func

.section .init_array, "aw"
.align 2
.word ctor_func
.text
.global dtor_func
.type dtor_func, %function
dtor_func:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 138
.loc 1 139
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size dtor_func, .-dtor_func

.section .fini_array, "aw"
.align 2
.word dtor_func
.text
.global noreturn_func
.type noreturn_func, %function
noreturn_func:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 139
.loc 1 141
.L_noreturn_func_0:
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_noreturn_func_1
    B .L_noreturn_func_0
.L_noreturn_func_1:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size noreturn_func, .-noreturn_func

.global nop
.type nop, %function
nop:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 141
.loc 1 144
    nop
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size nop, .-nop

.global wfi
.type wfi, %function
wfi:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 144
.loc 1 145
    wfi
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size wfi, .-wfi

.global cpsie_i
.type cpsie_i, %function
cpsie_i:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 145
.loc 1 146
    cpsie i
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size cpsie_i, .-cpsie_i

.global cpsid_i
.type cpsid_i, %function
cpsid_i:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 146
.loc 1 147
    cpsid i
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size cpsid_i, .-cpsid_i

.global dsb
.type dsb, %function
dsb:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 147
.loc 1 148
    dsb
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size dsb, .-dsb

.global isb
.type isb, %function
isb:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 148
.loc 1 149
    isb
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size isb, .-isb

.global dmb
.type dmb, %function
dmb:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 149
.loc 1 150
    dmb
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size dmb, .-dmb

.global main
.type main, %function
main:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 150
.loc 1 182
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
.loc 1 183
    MOVW r0, #17632
    MOVT r0, #22530
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
    MOV r0, #2
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
.loc 1 184
    BL cpsie_i
    PUSH {r0}
    POP {r0}
.loc 1 185
    BL cpsid_i
    PUSH {r0}
    POP {r0}
.loc 1 186
    BL dsb
    PUSH {r0}
    POP {r0}
.loc 1 187
    BL isb
    PUSH {r0}
    POP {r0}
.loc 1 188
    BL nop
    PUSH {r0}
    POP {r0}
.loc 1 189
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size main, .-main

.global __arkcc_init_globals
.thumb_func
__arkcc_init_globals:
    PUSH {lr}
    MOV r0, #42
    MOVW r1, #0
    MOVT r1, #8192
    STR r0, [r1]
    MOV r0, #1
    MOVW r1, #4
    MOVT r1, #8192
    STR r0, [r1]
    MOV r0, #2
    MOVW r1, #8
    MOVT r1, #8192
    STR r0, [r1]
    MOV r0, #3
    MOVW r1, #12
    MOVT r1, #8192
    STR r0, [r1]
    MOV r0, #4
    MOVW r1, #16
    MOVT r1, #8192
    STR r0, [r1]
    MOVW r0, #0
    MOVT r0, #8194
    MOVW r1, #20
    MOVT r1, #8192
    STR r0, [r1]
    MOV r0, #0
    MOVW r1, #24
    MOVT r1, #8192
    STR r0, [r1]
    MOV r0, #0
    MOVW r1, #28
    MOVT r1, #8192
    STR r0, [r1]
    MOV r0, #0
    MOVW r1, #32
    MOVT r1, #8192
    STR r0, [r1]
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

.global __aeabi_f2iz
.thumb_func
__aeabi_f2iz:
    LSR r1, r0, #23
    LSL r1, r1, #1
    LSR r1, r1, #1
    CMP r1, #150
    BGE .L_f2iz_shl
    CMP r1, #126
    BLT .L_f2iz_zero
    SUB r2, r1, #127
    LSL r0, r0, #9
    LSR r0, r0, r2
    B .L_f2iz_sign
.L_f2iz_shl:
    SUB r2, r1, #150
    MOV r0, #0x800000
    LSL r0, r0, r2
.L_f2iz_sign:
    LSR r1, r0, #31
    CMP r1, #0
    BEQ .L_f2iz_done
    RSB r0, r0, #0
.L_f2iz_done:
    BX lr
.L_f2iz_zero:
    MOV r0, #0
    BX lr

.global __aeabi_f2uiz
.thumb_func
__aeabi_f2uiz:
    PUSH {lr}
    BL __aeabi_f2iz
    POP {r0}
    BX r0

.global __aeabi_i2f
.thumb_func
__aeabi_i2f:
    PUSH {lr}
    CMP r0, #0
    BGE .L_i2f_pos
    RSB r0, r0, #0
    MOV r1, #1
    B .L_i2f_conv
.L_i2f_pos:
    MOV r1, #0
.L_i2f_conv:
    CLZ r2, r0
    RSB r2, r2, #31
    MOV r3, #127
    ADD r3, r3, r2
    LSL r3, r3, #23
    LSL r0, r0, r2
    LSL r0, r0, #1
    LSR r0, r0, #9
    ORR r0, r0, r3
    CMP r1, #0
    BEQ .L_i2f_done
    MOV r1, #1
    LSL r1, r1, #31
    ORR r0, r0, r1
.L_i2f_done:
    POP {r0}
    BX r0

.global __aeabi_ui2f
.thumb_func
__aeabi_ui2f:
    PUSH {lr}
    MOV r1, #0
    B .L_i2f_conv

.global __aeabi_fadd
.thumb_func
__aeabi_fadd:
    BX lr

.global __aeabi_fsub
.thumb_func
__aeabi_fsub:
    BX lr

.global __aeabi_fmul
.thumb_func
__aeabi_fmul:
    BX lr

.global __aeabi_fdiv
.thumb_func
__aeabi_fdiv:
    BX lr

.global __aeabi_d2iz
.thumb_func
__aeabi_d2iz:
    POP {r1}
    PUSH {lr}
    BL __aeabi_f2iz
    POP {r0}
    BX r0

.global __aeabi_d2uiz
.thumb_func
__aeabi_d2uiz:
    POP {r1}
    PUSH {lr}
    BL __aeabi_f2uiz
    POP {r0}
    BX r0

.global __aeabi_i2d
.thumb_func
__aeabi_i2d:
    PUSH {lr}
    BL __aeabi_i2f
    MOV r1, #0
    POP {r0}
    BX r0

.global __aeabi_ui2d
.thumb_func
__aeabi_ui2d:
    PUSH {lr}
    BL __aeabi_ui2f
    MOV r1, #0
    POP {r0}
    BX r0

.global __aeabi_dadd
.thumb_func
__aeabi_dadd:
    BX lr

.global __aeabi_dsub
.thumb_func
__aeabi_dsub:
    BX lr

.global __aeabi_dmul
.thumb_func
__aeabi_dmul:
    BX lr

.global __aeabi_ddiv
.thumb_func
__aeabi_ddiv:
    BX lr

.global __aeabi_fcmpeq
.thumb_func
__aeabi_fcmpeq:
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    BX lr

.global __aeabi_fcmplt
.thumb_func
__aeabi_fcmplt:
    CMP r0, r1
    ITE LT
    MOVLT r0, #1
    MOVGE r0, #0
    BX lr

.global __aeabi_fcmpgt
.thumb_func
__aeabi_fcmpgt:
    CMP r0, r1
    ITE GT
    MOVGT r0, #1
    MOVLE r0, #0
    BX lr

.global __aeabi_fcmple
.thumb_func
__aeabi_fcmple:
    CMP r0, r1
    ITE LE
    MOVLE r0, #1
    MOVGT r0, #0
    BX lr

.global __aeabi_fcmpge
.thumb_func
__aeabi_fcmpge:
    CMP r0, r1
    ITE GE
    MOVGE r0, #1
    MOVLT r0, #0
    BX lr

