; Ark C Compiler - generated Thumb-2 assembly
.thumb
.text

.file 1 "test_macro.c"
.global test_macro_expand
.type test_macro_expand, %function
test_macro_expand:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 13
    MOVW r0, #57360
    MOVT r0, #57344
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 14
    MOVW r0, #57364
    MOVT r0, #57344
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 15
    MOVW r0, #57368
    MOVT r0, #57344
    PUSH {r0}
    MOV r0, #3
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size test_macro_expand, .-test_macro_expand

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

