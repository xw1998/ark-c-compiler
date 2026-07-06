; Ark C Compiler - generated Thumb-2 assembly
.thumb
.text

.file 1 "ark_test_all.c"
.global __REV16
__REV16:

    rev16 r0, r0
    bx lr

.global __REVSH
__REVSH:

    revsh r0, r0
    bx lr

.global __RRX
__RRX:

    rrx r0, r0
    bx lr

.global __get_CONTROL
.type __get_CONTROL, %function
__get_CONTROL:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 1514
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size __get_CONTROL, .-__get_CONTROL

.global __set_CONTROL
.type __set_CONTROL, %function
__set_CONTROL:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #16
    MOV r6, sp
.loc 1 1514
    STR r0, [r6, #0]
.loc 1 1526
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 1527
    MOV r0, #15
    PUSH {r0}
    POP {r0}
    ISB SY
    PUSH {r0}
    POP {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #16
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size __set_CONTROL, .-__set_CONTROL

.global __get_IPSR
.type __get_IPSR, %function
__get_IPSR:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 1527
.loc 1 1539
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size __get_IPSR, .-__get_IPSR

.global __get_APSR
.type __get_APSR, %function
__get_APSR:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 1539
.loc 1 1551
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size __get_APSR, .-__get_APSR

.global __get_xPSR
.type __get_xPSR, %function
__get_xPSR:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 1551
.loc 1 1563
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size __get_xPSR, .-__get_xPSR

.global __get_PSP
.type __get_PSP, %function
__get_PSP:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 1563
.loc 1 1575
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size __get_PSP, .-__get_PSP

.global __set_PSP
.type __set_PSP, %function
__set_PSP:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #16
    MOV r6, sp
.loc 1 1575
    STR r0, [r6, #0]
.loc 1 1587
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #16
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size __set_PSP, .-__set_PSP

.global __get_MSP
.type __get_MSP, %function
__get_MSP:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 1587
.loc 1 1599
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size __get_MSP, .-__get_MSP

.global __set_MSP
.type __set_MSP, %function
__set_MSP:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #16
    MOV r6, sp
.loc 1 1599
    STR r0, [r6, #0]
.loc 1 1611
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #16
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size __set_MSP, .-__set_MSP

.global __get_PRIMASK
.type __get_PRIMASK, %function
__get_PRIMASK:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 1611
.loc 1 1623
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size __get_PRIMASK, .-__get_PRIMASK

.global __set_PRIMASK
.type __set_PRIMASK, %function
__set_PRIMASK:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #16
    MOV r6, sp
.loc 1 1623
    STR r0, [r6, #0]
.loc 1 1635
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #16
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size __set_PRIMASK, .-__set_PRIMASK

.global __get_BASEPRI
.type __get_BASEPRI, %function
__get_BASEPRI:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 1635
.loc 1 1665
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size __get_BASEPRI, .-__get_BASEPRI

.global __set_BASEPRI
.type __set_BASEPRI, %function
__set_BASEPRI:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #16
    MOV r6, sp
.loc 1 1665
    STR r0, [r6, #0]
.loc 1 1677
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #255
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #16
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size __set_BASEPRI, .-__set_BASEPRI

.global __set_BASEPRI_MAX
.type __set_BASEPRI_MAX, %function
__set_BASEPRI_MAX:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #16
    MOV r6, sp
.loc 1 1677
    STR r0, [r6, #0]
.loc 1 1690
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #255
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #16
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size __set_BASEPRI_MAX, .-__set_BASEPRI_MAX

.global __get_FAULTMASK
.type __get_FAULTMASK, %function
__get_FAULTMASK:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 1690
.loc 1 1702
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size __get_FAULTMASK, .-__get_FAULTMASK

.global __set_FAULTMASK
.type __set_FAULTMASK, %function
__set_FAULTMASK:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #16
    MOV r6, sp
.loc 1 1702
    STR r0, [r6, #0]
.loc 1 1714
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #16
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size __set_FAULTMASK, .-__set_FAULTMASK

.global __get_FPSCR
.type __get_FPSCR, %function
__get_FPSCR:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 1714
.loc 1 1729
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size __get_FPSCR, .-__get_FPSCR

.global __set_FPSCR
.type __set_FPSCR, %function
__set_FPSCR:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #16
    MOV r6, sp
.loc 1 1729
    STR r0, [r6, #0]
.loc 1 1744
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #16
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size __set_FPSCR, .-__set_FPSCR

.global __NVIC_SetPriorityGrouping
.type __NVIC_SetPriorityGrouping, %function
__NVIC_SetPriorityGrouping:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #24
    MOV r6, sp
.loc 1 1744
    STR r0, [r6, #0]
.loc 1 3518
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #7
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
.loc 1 3520
    MOVW r0, #60684
    MOVT r0, #57344
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
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 3521
    LDR r0, [r6, #8]
    PUSH {r0}
    MOVW r0, #1792
    MOVT r0, #65535
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 3522
    LDR r0, [r6, #8]
    PUSH {r0}
.loc 1 3523
    MOVW r0, #0
    MOVT r0, #1530
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
.loc 1 3524
    LDR r0, [r6, #16]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 3525
    MOVW r0, #60684
    MOVT r0, #57344
    PUSH {r0}
    LDR r0, [r6, #8]
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
    ADD sp, sp, #24
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size __NVIC_SetPriorityGrouping, .-__NVIC_SetPriorityGrouping

.global __NVIC_GetPriorityGrouping
.type __NVIC_GetPriorityGrouping, %function
__NVIC_GetPriorityGrouping:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 3525
.loc 1 3536
    MOVW r0, #60684
    MOVT r0, #57344
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
    MOVW r0, #1792
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size __NVIC_GetPriorityGrouping, .-__NVIC_GetPriorityGrouping

.global __NVIC_EnableIRQ
.type __NVIC_EnableIRQ, %function
__NVIC_EnableIRQ:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 3536
    STR r0, [r6, #0]
.loc 1 3548
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE GE
    MOVGE r0, #1
    MOVLT r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L___NVIC_EnableIRQ_0
.loc 1 3550
    PUSH {r0}
    POP {r0}
.loc 1 3551
    MOVW r0, #57600
    MOVT r0, #57344
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #5
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #31
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 3552
    PUSH {r0}
    POP {r0}
    B .L___NVIC_EnableIRQ_1
.L___NVIC_EnableIRQ_0:
.L___NVIC_EnableIRQ_1:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size __NVIC_EnableIRQ, .-__NVIC_EnableIRQ

.global __NVIC_GetEnableIRQ
.type __NVIC_GetEnableIRQ, %function
__NVIC_GetEnableIRQ:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 3552
    STR r0, [r6, #0]
.loc 1 3567
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE GE
    MOVGE r0, #1
    MOVLT r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L___NVIC_GetEnableIRQ_0
.loc 1 3569
    MOVW r0, #57600
    MOVT r0, #57344
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #5
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #31
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L___NVIC_GetEnableIRQ_2
    MOV r0, #1
    PUSH {r0}
    B .L___NVIC_GetEnableIRQ_3
.L___NVIC_GetEnableIRQ_2:
    MOV r0, #0
    PUSH {r0}
.L___NVIC_GetEnableIRQ_3:
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
.L___NVIC_GetEnableIRQ_0:
.loc 1 3573
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
.L___NVIC_GetEnableIRQ_1:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size __NVIC_GetEnableIRQ, .-__NVIC_GetEnableIRQ

.global __NVIC_DisableIRQ
.type __NVIC_DisableIRQ, %function
__NVIC_DisableIRQ:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 3573
    STR r0, [r6, #0]
.loc 1 3586
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE GE
    MOVGE r0, #1
    MOVLT r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L___NVIC_DisableIRQ_0
.loc 1 3588
    MOVW r0, #57728
    MOVT r0, #57344
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #5
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #31
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 3589
    MOV r0, #15
    PUSH {r0}
    POP {r0}
    DSB SY
    PUSH {r0}
    POP {r0}
.loc 1 3590
    MOV r0, #15
    PUSH {r0}
    POP {r0}
    ISB SY
    PUSH {r0}
    POP {r0}
    B .L___NVIC_DisableIRQ_1
.L___NVIC_DisableIRQ_0:
.L___NVIC_DisableIRQ_1:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size __NVIC_DisableIRQ, .-__NVIC_DisableIRQ

.global __NVIC_GetPendingIRQ
.type __NVIC_GetPendingIRQ, %function
__NVIC_GetPendingIRQ:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 3590
    STR r0, [r6, #0]
.loc 1 3605
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE GE
    MOVGE r0, #1
    MOVLT r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L___NVIC_GetPendingIRQ_0
.loc 1 3607
    MOVW r0, #57856
    MOVT r0, #57344
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #5
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #31
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L___NVIC_GetPendingIRQ_2
    MOV r0, #1
    PUSH {r0}
    B .L___NVIC_GetPendingIRQ_3
.L___NVIC_GetPendingIRQ_2:
    MOV r0, #0
    PUSH {r0}
.L___NVIC_GetPendingIRQ_3:
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
.L___NVIC_GetPendingIRQ_0:
.loc 1 3611
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
.L___NVIC_GetPendingIRQ_1:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size __NVIC_GetPendingIRQ, .-__NVIC_GetPendingIRQ

.global __NVIC_SetPendingIRQ
.type __NVIC_SetPendingIRQ, %function
__NVIC_SetPendingIRQ:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 3611
    STR r0, [r6, #0]
.loc 1 3624
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE GE
    MOVGE r0, #1
    MOVLT r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L___NVIC_SetPendingIRQ_0
.loc 1 3626
    MOVW r0, #57856
    MOVT r0, #57344
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #5
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #31
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L___NVIC_SetPendingIRQ_1
.L___NVIC_SetPendingIRQ_0:
.L___NVIC_SetPendingIRQ_1:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size __NVIC_SetPendingIRQ, .-__NVIC_SetPendingIRQ

.global __NVIC_ClearPendingIRQ
.type __NVIC_ClearPendingIRQ, %function
__NVIC_ClearPendingIRQ:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 3626
    STR r0, [r6, #0]
.loc 1 3639
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE GE
    MOVGE r0, #1
    MOVLT r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L___NVIC_ClearPendingIRQ_0
.loc 1 3641
    MOVW r0, #57984
    MOVT r0, #57344
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #5
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #31
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L___NVIC_ClearPendingIRQ_1
.L___NVIC_ClearPendingIRQ_0:
.L___NVIC_ClearPendingIRQ_1:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size __NVIC_ClearPendingIRQ, .-__NVIC_ClearPendingIRQ

.global __NVIC_GetActive
.type __NVIC_GetActive, %function
__NVIC_GetActive:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 3641
    STR r0, [r6, #0]
.loc 1 3656
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE GE
    MOVGE r0, #1
    MOVLT r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L___NVIC_GetActive_0
.loc 1 3658
    MOVW r0, #58112
    MOVT r0, #57344
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #5
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #31
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L___NVIC_GetActive_2
    MOV r0, #1
    PUSH {r0}
    B .L___NVIC_GetActive_3
.L___NVIC_GetActive_2:
    MOV r0, #0
    PUSH {r0}
.L___NVIC_GetActive_3:
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
.L___NVIC_GetActive_0:
.loc 1 3662
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
.L___NVIC_GetActive_1:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size __NVIC_GetActive, .-__NVIC_GetActive

.global __NVIC_SetPriority
.type __NVIC_SetPriority, %function
__NVIC_SetPriority:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #16
    MOV r6, sp
.loc 1 3662
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 3678
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE GE
    MOVGE r0, #1
    MOVLT r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L___NVIC_SetPriority_0
.loc 1 3680
    MOVW r0, #58368
    MOVT r0, #57344
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    MOV r0, #255
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STRB r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L___NVIC_SetPriority_1
.L___NVIC_SetPriority_0:
.loc 1 3684
    MOVW r0, #60696
    MOVT r0, #57344
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #15
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    MOV r0, #255
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STRB r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L___NVIC_SetPriority_1:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #16
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size __NVIC_SetPriority, .-__NVIC_SetPriority

.global __NVIC_GetPriority
.type __NVIC_GetPriority, %function
__NVIC_GetPriority:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 3684
    STR r0, [r6, #0]
.loc 1 3701
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE GE
    MOVGE r0, #1
    MOVLT r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L___NVIC_GetPriority_0
.loc 1 3703
    MOVW r0, #58368
    MOVT r0, #57344
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    LDRB r0, [r0, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
.L___NVIC_GetPriority_0:
.loc 1 3707
    MOVW r0, #60696
    MOVT r0, #57344
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #15
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    LDRB r0, [r0, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
.L___NVIC_GetPriority_1:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size __NVIC_GetPriority, .-__NVIC_GetPriority

.global NVIC_EncodePriority
.type NVIC_EncodePriority, %function
NVIC_EncodePriority:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #48
    MOV r6, sp
.loc 1 3707
    STR r0, [r6, #0]
    STR r1, [r6, #8]
    STR r2, [r6, #16]
.loc 1 3725
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #7
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
.loc 1 3729
    MOV r0, #7
    PUSH {r0}
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_NVIC_EncodePriority_0
    MOV r0, #4
    PUSH {r0}
    B .L_NVIC_EncodePriority_1
.L_NVIC_EncodePriority_0:
    MOV r0, #7
    PUSH {r0}
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
.L_NVIC_EncodePriority_1:
    POP {r0}
    STR r0, [r6, #32]
    LDR r0, [r6, #32]
    PUSH {r0}
    POP {r0}
.loc 1 3730
    LDR r0, [r6, #24]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #7
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE LO
    MOVLO r0, #1
    MOVHS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_NVIC_EncodePriority_2
    MOV r0, #0
    PUSH {r0}
    B .L_NVIC_EncodePriority_3
.L_NVIC_EncodePriority_2:
    LDR r0, [r6, #24]
    PUSH {r0}
    MOV r0, #7
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
.L_NVIC_EncodePriority_3:
    POP {r0}
    STR r0, [r6, #40]
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
.loc 1 3733
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    LDR r0, [r6, #32]
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
.loc 1 3734
    LDR r0, [r6, #16]
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #48
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size NVIC_EncodePriority, .-NVIC_EncodePriority

.global NVIC_DecodePriority
.type NVIC_DecodePriority, %function
NVIC_DecodePriority:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #56
    MOV r6, sp
.loc 1 3734
    STR r0, [r6, #0]
    STR r1, [r6, #8]
    STR r2, [r6, #16]
    STR r3, [r6, #24]
.loc 1 3752
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #7
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #32]
.loc 1 3756
    MOV r0, #7
    PUSH {r0}
    LDR r0, [r6, #32]
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_NVIC_DecodePriority_0
    MOV r0, #4
    PUSH {r0}
    B .L_NVIC_DecodePriority_1
.L_NVIC_DecodePriority_0:
    MOV r0, #7
    PUSH {r0}
    LDR r0, [r6, #32]
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
.L_NVIC_DecodePriority_1:
    POP {r0}
    STR r0, [r6, #40]
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
.loc 1 3757
    LDR r0, [r6, #32]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #7
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE LO
    MOVLO r0, #1
    MOVHS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_NVIC_DecodePriority_2
    MOV r0, #0
    PUSH {r0}
    B .L_NVIC_DecodePriority_3
.L_NVIC_DecodePriority_2:
    LDR r0, [r6, #32]
    PUSH {r0}
    MOV r0, #7
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
.L_NVIC_DecodePriority_3:
    POP {r0}
    STR r0, [r6, #48]
    LDR r0, [r6, #48]
    PUSH {r0}
    POP {r0}
.loc 1 3759
    LDR r0, [r6, #16]
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    LDR r0, [r6, #48]
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 3760
    LDR r0, [r6, #24]
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    LDR r0, [r6, #48]
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
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
    ADD sp, sp, #56
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size NVIC_DecodePriority, .-NVIC_DecodePriority

.global __NVIC_SetVector
.type __NVIC_SetVector, %function
__NVIC_SetVector:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #24
    MOV r6, sp
.loc 1 3760
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 3775
    MOVW r0, #60680
    MOVT r0, #57344
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
    POP {r0}
    STR r0, [r6, #16]
.loc 1 3776
    LDR r0, [r6, #16]
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #8]
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
    ADD sp, sp, #24
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size __NVIC_SetVector, .-__NVIC_SetVector

.global __NVIC_GetVector
.type __NVIC_GetVector, %function
__NVIC_GetVector:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #16
    MOV r6, sp
.loc 1 3776
    STR r0, [r6, #0]
.loc 1 3791
    MOVW r0, #60680
    MOVT r0, #57344
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
    POP {r0}
    STR r0, [r6, #8]
.loc 1 3792
    LDR r0, [r6, #8]
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #16
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size __NVIC_GetVector, .-__NVIC_GetVector

.global __NVIC_SystemReset
.type __NVIC_SystemReset, %function
__NVIC_SystemReset:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 3792
.loc 1 3802
    MOV r0, #15
    PUSH {r0}
    POP {r0}
    DSB SY
    PUSH {r0}
    POP {r0}
.loc 1 3804
    MOVW r0, #60684
    MOVT r0, #57344
    PUSH {r0}
    MOVW r0, #0
    MOVT r0, #1530
    PUSH {r0}
.loc 1 3805
    MOVW r0, #60684
    MOVT r0, #57344
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
    MOVW r0, #1792
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
.loc 1 3806
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
.loc 1 3807
    MOV r0, #15
    PUSH {r0}
    POP {r0}
    DSB SY
    PUSH {r0}
    POP {r0}
.loc 1 3809
.L___NVIC_SystemReset_0:
.loc 1 3811
    NOP
    PUSH {r0}
    POP {r0}
.L___NVIC_SystemReset_2:
    B .L___NVIC_SystemReset_0
.L___NVIC_SystemReset_1:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size __NVIC_SystemReset, .-__NVIC_SystemReset

.global ARM_MPU_Enable
.type ARM_MPU_Enable, %function
ARM_MPU_Enable:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 3811
    STR r0, [r6, #0]
.loc 1 4000
    MOV r0, #15
    PUSH {r0}
    POP {r0}
    DMB SY
    PUSH {r0}
    POP {r0}
.loc 1 4001
    MOVW r0, #60820
    MOVT r0, #57344
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #1
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
.loc 1 4003
    MOVW r0, #60708
    MOVT r0, #57344
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
    MOVW r0, #0
    MOVT r0, #1
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
.loc 1 4005
    MOV r0, #15
    PUSH {r0}
    POP {r0}
    DSB SY
    PUSH {r0}
    POP {r0}
.loc 1 4006
    MOV r0, #15
    PUSH {r0}
    POP {r0}
    ISB SY
    PUSH {r0}
    POP {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size ARM_MPU_Enable, .-ARM_MPU_Enable

.global ARM_MPU_Disable
.type ARM_MPU_Disable, %function
ARM_MPU_Disable:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 4006
.loc 1 4013
    MOV r0, #15
    PUSH {r0}
    POP {r0}
    DMB SY
    PUSH {r0}
    POP {r0}
.loc 1 4015
    MOVW r0, #60708
    MOVT r0, #57344
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
    MOVW r0, #0
    MOVT r0, #1
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 4017
    MOVW r0, #60820
    MOVT r0, #57344
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
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 4018
    MOV r0, #15
    PUSH {r0}
    POP {r0}
    DSB SY
    PUSH {r0}
    POP {r0}
.loc 1 4019
    MOV r0, #15
    PUSH {r0}
    POP {r0}
    ISB SY
    PUSH {r0}
    POP {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size ARM_MPU_Disable, .-ARM_MPU_Disable

.global ARM_MPU_ClrRegion
.type ARM_MPU_ClrRegion, %function
ARM_MPU_ClrRegion:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 4019
    STR r0, [r6, #0]
.loc 1 4027
    MOVW r0, #60824
    MOVT r0, #57344
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 4028
    MOVW r0, #60832
    MOVT r0, #57344
    PUSH {r0}
    MOV r0, #0
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
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size ARM_MPU_ClrRegion, .-ARM_MPU_ClrRegion

.global ARM_MPU_SetRegion
.type ARM_MPU_SetRegion, %function
ARM_MPU_SetRegion:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #16
    MOV r6, sp
.loc 1 4028
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 4037
    MOVW r0, #60828
    MOVT r0, #57344
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 4038
    MOVW r0, #60832
    MOVT r0, #57344
    PUSH {r0}
    LDR r0, [r6, #8]
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
    ADD sp, sp, #16
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size ARM_MPU_SetRegion, .-ARM_MPU_SetRegion

.global ARM_MPU_SetRegionEx
.type ARM_MPU_SetRegionEx, %function
ARM_MPU_SetRegionEx:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #24
    MOV r6, sp
.loc 1 4038
    STR r0, [r6, #0]
    STR r1, [r6, #8]
    STR r2, [r6, #16]
.loc 1 4048
    MOVW r0, #60824
    MOVT r0, #57344
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 4049
    MOVW r0, #60828
    MOVT r0, #57344
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 4050
    MOVW r0, #60832
    MOVT r0, #57344
    PUSH {r0}
    LDR r0, [r6, #16]
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
    ADD sp, sp, #24
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size ARM_MPU_SetRegionEx, .-ARM_MPU_SetRegionEx

.global ARM_MPU_OrderedMemcpy
.type ARM_MPU_OrderedMemcpy, %function
ARM_MPU_OrderedMemcpy:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #32
    MOV r6, sp
.loc 1 4050
    STR r0, [r6, #0]
    STR r1, [r6, #8]
    STR r2, [r6, #16]
.loc 1 4061
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
.L_ARM_MPU_OrderedMemcpy_0:
    LDR r0, [r6, #24]
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE LO
    MOVLO r0, #1
    MOVHS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_ARM_MPU_OrderedMemcpy_1
.loc 1 4063
    LDR r0, [r6, #0]
    PUSH {r0}
    LDR r0, [r6, #24]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    LDR r0, [r6, #24]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_ARM_MPU_OrderedMemcpy_2:
.loc 1 4061
    LDR r0, [r6, #24]
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
    B .L_ARM_MPU_OrderedMemcpy_0
.L_ARM_MPU_OrderedMemcpy_1:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #32
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size ARM_MPU_OrderedMemcpy, .-ARM_MPU_OrderedMemcpy

.global ARM_MPU_Load
.type ARM_MPU_Load, %function
ARM_MPU_Load:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #24
    MOV r6, sp
.loc 1 4061
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 4073
    MOV r0, #8
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    SDIV r0, r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
.loc 1 4074
.L_ARM_MPU_Load_0:
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_ARM_MPU_Load_1
.loc 1 4075
    MOV r0, #4
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOVW r0, #60828
    MOVT r0, #57344
    PUSH {r0}
    POP {r0}
    POP {r1}
    POP {r2}
    BL ARM_MPU_OrderedMemcpy
    PUSH {r0}
    POP {r0}
.loc 1 4076
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
.loc 1 4077
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    B .L_ARM_MPU_Load_0
.L_ARM_MPU_Load_1:
.loc 1 4079
    LDR r0, [r6, #8]
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOVW r0, #60828
    MOVT r0, #57344
    PUSH {r0}
    POP {r0}
    POP {r1}
    POP {r2}
    BL ARM_MPU_OrderedMemcpy
    PUSH {r0}
    POP {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #24
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size ARM_MPU_Load, .-ARM_MPU_Load

.global SCB_GetFPUType
.type SCB_GetFPUType, %function
SCB_GetFPUType:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 4079
.loc 1 4108
    MOVW r0, #61248
    MOVT r0, #57344
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
    POP {r0}
    STR r0, [r6, #0]
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
.loc 1 4109
    LDR r0, [r6, #0]
    PUSH {r0}
    MOVW r0, #4080
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #32
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_SCB_GetFPUType_0
.loc 1 4111
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
.L_SCB_GetFPUType_0:
.loc 1 4115
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
.L_SCB_GetFPUType_1:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size SCB_GetFPUType, .-SCB_GetFPUType

.global SysTick_Config
.type SysTick_Config, %function
SysTick_Config:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 4115
    STR r0, [r6, #0]
.loc 1 4147
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    MOVW r0, #65535
    MOVT r0, #255
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_SysTick_Config_0
.loc 1 4149
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
.L_SysTick_Config_0:
.L_SysTick_Config_1:
.loc 1 4152
    MOVW r0, #57364
    MOVT r0, #57344
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 4153
    MOV r0, #15
    PUSH {r0}
    MOVW r0, #65535
    MOVT r0, #65535
    PUSH {r0}
    POP {r0}
    POP {r1}
    BL __NVIC_SetPriority
    PUSH {r0}
    POP {r0}
.loc 1 4154
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
.loc 1 4155
    MOVW r0, #57360
    MOVT r0, #57344
    PUSH {r0}
    MOV r0, #7
    PUSH {r0}
.loc 1 4157
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 4158
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size SysTick_Config, .-SysTick_Config

.global ITM_SendChar
.type ITM_SendChar, %function
ITM_SendChar:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 4158
    STR r0, [r6, #0]
.loc 1 4189
    MOVW r0, #3712
    MOVT r0, #57344
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
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_ITM_SendChar_2
.loc 1 4190
    MOVW r0, #3584
    MOVT r0, #57344
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
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    B .L_ITM_SendChar_3
.L_ITM_SendChar_2:
    MOV r0, #0
    PUSH {r0}
.L_ITM_SendChar_3:
    POP {r0}
    CMP r0, #0
    BEQ .L_ITM_SendChar_0
.loc 1 4192
.L_ITM_SendChar_4:
    MOVW r0, #0
    MOVT r0, #57344
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_ITM_SendChar_5
.loc 1 4194
    NOP
    PUSH {r0}
    POP {r0}
    B .L_ITM_SendChar_4
.L_ITM_SendChar_5:
.loc 1 4196
    MOVW r0, #0
    MOVT r0, #57344
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STRB r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_ITM_SendChar_1
.L_ITM_SendChar_0:
.L_ITM_SendChar_1:
.loc 1 4198
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size ITM_SendChar, .-ITM_SendChar

.global ITM_ReceiveChar
.type ITM_ReceiveChar, %function
ITM_ReceiveChar:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 4198
.loc 1 4210
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    NEG r0, r0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
.loc 1 4212
    MOV r0, #0
    LDR r0, [r0]
    PUSH {r0}
    MOVW r0, #23205
    MOVT r0, #23205
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_ITM_ReceiveChar_0
.loc 1 4214
    MOV r0, #0
    LDR r0, [r0]
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
.loc 1 4215
    MOVW r0, #23205
    MOVT r0, #23205
    PUSH {r0}
    POP {r0}
    PUSH {r0}
    PUSH {r0}
    POP {r0}
    MOV r1, #0
    STR r0, [r1]
    POP {r0}
    B .L_ITM_ReceiveChar_1
.L_ITM_ReceiveChar_0:
.L_ITM_ReceiveChar_1:
.loc 1 4218
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size ITM_ReceiveChar, .-ITM_ReceiveChar

.global ITM_CheckChar
.type ITM_CheckChar, %function
ITM_CheckChar:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 4218
.loc 1 4231
    MOV r0, #0
    LDR r0, [r0]
    PUSH {r0}
    MOVW r0, #23205
    MOVT r0, #23205
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_ITM_CheckChar_0
.loc 1 4233
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
.L_ITM_CheckChar_0:
.loc 1 4237
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
.L_ITM_CheckChar_1:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size ITM_CheckChar, .-ITM_CheckChar

.global HAL_Init
.type HAL_Init, %function
HAL_Init:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 4237
.loc 1 27863
    MOVW r0, #15360
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
    MOVW r0, #512
    MOVT r0, #0
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
.loc 1 27867
    MOVW r0, #15360
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
    MOVW r0, #1024
    MOVT r0, #0
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
.loc 1 27871
    MOVW r0, #15360
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
    MOVW r0, #256
    MOVT r0, #0
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
.loc 1 27875
    MOV r0, #3
    PUSH {r0}
    POP {r0}
    BL HAL_NVIC_SetPriorityGrouping
    PUSH {r0}
    POP {r0}
.loc 1 27878
    MOV r0, #15
    PUSH {r0}
    POP {r0}
    BL HAL_InitTick
    PUSH {r0}
    POP {r0}
.loc 1 27881
    BL HAL_MspInit
    PUSH {r0}
    POP {r0}
.loc 1 27884
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_Init, .-HAL_Init

.global HAL_DeInit
.type HAL_DeInit, %function
HAL_DeInit:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 27884
.loc 1 27895
    MOVW r0, #14368
    MOVT r0, #16386
    PUSH {r0}
    MOVW r0, #51215
    MOVT r0, #4322
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 27896
    MOVW r0, #14368
    MOVT r0, #16386
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 27898
    MOVW r0, #14372
    MOVT r0, #16386
    PUSH {r0}
    MOVW r0, #31025
    MOVT r0, #7
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 27899
    MOVW r0, #14372
    MOVT r0, #16386
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 27901
    MOVW r0, #14352
    MOVT r0, #16386
    PUSH {r0}
    MOVW r0, #4255
    MOVT r0, #96
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 27902
    MOVW r0, #14352
    MOVT r0, #16386
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 27904
    MOVW r0, #14356
    MOVT r0, #16386
    PUSH {r0}
    MOV r0, #128
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 27905
    MOVW r0, #14356
    MOVT r0, #16386
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 27907
    MOVW r0, #14360
    MOVT r0, #16386
    PUSH {r0}
    MOVW r0, #65535
    MOVT r0, #65535
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 27908
    MOVW r0, #14360
    MOVT r0, #16386
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 27911
    BL HAL_MspDeInit
    PUSH {r0}
    POP {r0}
.loc 1 27914
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_DeInit, .-HAL_DeInit

.global HAL_MspDeInit
.weak HAL_MspDeInit
.type HAL_MspDeInit, %function
HAL_MspDeInit:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 27914
.loc 1 27933
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_MspDeInit, .-HAL_MspDeInit

.global HAL_InitTick
.weak HAL_InitTick
.type HAL_InitTick, %function
HAL_InitTick:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 27933
    STR r0, [r6, #0]
.loc 1 27958
    MOVW r0, #0
    MOVT r0, #8192
    LDR r0, [r0]
    PUSH {r0}
    MOVW r0, #1000
    MOVT r0, #0
    PUSH {r0}
    MOVW r0, #32
    MOVT r0, #8192
    LDR r0, [r0]
    PUSH {r0}
    POP {r1}
    POP {r0}
    SDIV r0, r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    UDIV r0, r0, r1
    PUSH {r0}
    POP {r0}
    BL HAL_SYSTICK_Config
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_InitTick_0
.loc 1 27960
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
.L_HAL_InitTick_0:
.L_HAL_InitTick_1:
.loc 1 27964
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE LO
    MOVLO r0, #1
    MOVHS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_InitTick_2
.loc 1 27966
    MOV r0, #0
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOVW r0, #65535
    MOVT r0, #65535
    PUSH {r0}
    POP {r0}
    POP {r1}
    POP {r2}
    BL HAL_NVIC_SetPriority
    PUSH {r0}
    POP {r0}
.loc 1 27967
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    PUSH {r0}
    PUSH {r0}
    POP {r0}
    MOVW r1, #28
    MOVT r1, #8192
    STR r0, [r1]
    POP {r0}
    B .L_HAL_InitTick_3
.L_HAL_InitTick_2:
.loc 1 27971
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
.L_HAL_InitTick_3:
.loc 1 27975
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_InitTick, .-HAL_InitTick

.global HAL_IncTick
.weak HAL_IncTick
.type HAL_IncTick, %function
HAL_IncTick:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 27975
.loc 1 28016
    MOVW r0, #76
    MOVT r0, #8192
    LDR r0, [r0]
    PUSH {r0}
    MOVW r0, #32
    MOVT r0, #8192
    LDR r0, [r0]
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    POP {r0}
    PUSH {r0}
    PUSH {r0}
    POP {r0}
    MOVW r1, #76
    MOVT r1, #8192
    STR r0, [r1]
    POP {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_IncTick, .-HAL_IncTick

.global HAL_GetTick
.weak HAL_GetTick
.type HAL_GetTick, %function
HAL_GetTick:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 28016
.loc 1 28027
    MOVW r0, #76
    MOVT r0, #8192
    LDR r0, [r0]
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_GetTick, .-HAL_GetTick

.global HAL_GetTickPrio
.type HAL_GetTickPrio, %function
HAL_GetTickPrio:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 28027
.loc 1 28036
    MOVW r0, #28
    MOVT r0, #8192
    LDR r0, [r0]
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_GetTickPrio, .-HAL_GetTickPrio

.global HAL_SetTickFreq
.type HAL_SetTickFreq, %function
HAL_SetTickFreq:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #24
    MOV r6, sp
.loc 1 28036
    STR r0, [r6, #0]
.loc 1 28045
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
.loc 1 28048
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 28050
    MOVW r0, #32
    MOVT r0, #8192
    LDR r0, [r0]
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_SetTickFreq_0
.loc 1 28053
    MOVW r0, #32
    MOVT r0, #8192
    LDR r0, [r0]
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
.loc 1 28056
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    PUSH {r0}
    PUSH {r0}
    POP {r0}
    MOVW r1, #32
    MOVT r1, #8192
    STR r0, [r1]
    POP {r0}
.loc 1 28059
    MOVW r0, #28
    MOVT r0, #8192
    LDR r0, [r0]
    PUSH {r0}
    POP {r0}
    BL HAL_InitTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 28061
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_SetTickFreq_2
.loc 1 28064
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
    PUSH {r0}
    PUSH {r0}
    POP {r0}
    MOVW r1, #32
    MOVT r1, #8192
    STR r0, [r1]
    POP {r0}
    B .L_HAL_SetTickFreq_3
.L_HAL_SetTickFreq_2:
.L_HAL_SetTickFreq_3:
    B .L_HAL_SetTickFreq_1
.L_HAL_SetTickFreq_0:
.L_HAL_SetTickFreq_1:
.loc 1 28068
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #24
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_SetTickFreq, .-HAL_SetTickFreq

.global HAL_GetTickFreq
.type HAL_GetTickFreq, %function
HAL_GetTickFreq:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 28068
.loc 1 28078
    MOVW r0, #32
    MOVT r0, #8192
    LDR r0, [r0]
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_GetTickFreq, .-HAL_GetTickFreq

.global HAL_Delay
.weak HAL_Delay
.type HAL_Delay, %function
HAL_Delay:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #24
    MOV r6, sp
.loc 1 28078
    STR r0, [r6, #0]
.loc 1 28094
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
.loc 1 28095
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
.loc 1 28098
    LDR r0, [r6, #16]
    PUSH {r0}
    MOVW r0, #65535
    MOVT r0, #65535
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE LO
    MOVLO r0, #1
    MOVHS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_Delay_0
.loc 1 28100
    LDR r0, [r6, #16]
    PUSH {r0}
    MOVW r0, #32
    MOVT r0, #8192
    LDR r0, [r0]
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
    B .L_HAL_Delay_1
.L_HAL_Delay_0:
.L_HAL_Delay_1:
.loc 1 28103
.L_HAL_Delay_2:
    BL HAL_GetTick
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE LO
    MOVLO r0, #1
    MOVHS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_Delay_3
.loc 1 28104
    B .L_HAL_Delay_2
.L_HAL_Delay_3:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #24
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_Delay, .-HAL_Delay

.global HAL_SuspendTick
.weak HAL_SuspendTick
.type HAL_SuspendTick, %function
HAL_SuspendTick:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 28104
.loc 1 28121
    MOVW r0, #57360
    MOVT r0, #57344
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
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
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
.size HAL_SuspendTick, .-HAL_SuspendTick

.global HAL_ResumeTick
.weak HAL_ResumeTick
.type HAL_ResumeTick, %function
HAL_ResumeTick:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 28121
.loc 1 28137
    MOVW r0, #57360
    MOVT r0, #57344
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
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_ResumeTick, .-HAL_ResumeTick

.global HAL_GetHalVersion
.type HAL_GetHalVersion, %function
HAL_GetHalVersion:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 28137
.loc 1 28146
    MOVW r0, #1280
    MOVT r0, #264
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_GetHalVersion, .-HAL_GetHalVersion

.global HAL_GetREVID
.type HAL_GetREVID, %function
HAL_GetREVID:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 28146
.loc 1 28155
    MOVW r0, #8192
    MOVT r0, #57348
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
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_GetREVID, .-HAL_GetREVID

.global HAL_GetDEVID
.type HAL_GetDEVID, %function
HAL_GetDEVID:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 28155
.loc 1 28164
    MOVW r0, #8192
    MOVT r0, #57348
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
    MOVW r0, #4095
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_GetDEVID, .-HAL_GetDEVID

.global HAL_DBGMCU_EnableDBGSleepMode
.type HAL_DBGMCU_EnableDBGSleepMode, %function
HAL_DBGMCU_EnableDBGSleepMode:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 28164
.loc 1 28173
    MOVW r0, #8196
    MOVT r0, #57348
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
    MOV r0, #1
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
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_DBGMCU_EnableDBGSleepMode, .-HAL_DBGMCU_EnableDBGSleepMode

.global HAL_DBGMCU_DisableDBGSleepMode
.type HAL_DBGMCU_DisableDBGSleepMode, %function
HAL_DBGMCU_DisableDBGSleepMode:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 28173
.loc 1 28182
    MOVW r0, #8196
    MOVT r0, #57348
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
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
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
.size HAL_DBGMCU_DisableDBGSleepMode, .-HAL_DBGMCU_DisableDBGSleepMode

.global HAL_DBGMCU_EnableDBGStopMode
.type HAL_DBGMCU_EnableDBGStopMode, %function
HAL_DBGMCU_EnableDBGStopMode:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 28182
.loc 1 28191
    MOVW r0, #8196
    MOVT r0, #57348
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
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_DBGMCU_EnableDBGStopMode, .-HAL_DBGMCU_EnableDBGStopMode

.global HAL_DBGMCU_DisableDBGStopMode
.type HAL_DBGMCU_DisableDBGStopMode, %function
HAL_DBGMCU_DisableDBGStopMode:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 28191
.loc 1 28200
    MOVW r0, #8196
    MOVT r0, #57348
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
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
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
.size HAL_DBGMCU_DisableDBGStopMode, .-HAL_DBGMCU_DisableDBGStopMode

.global HAL_DBGMCU_EnableDBGStandbyMode
.type HAL_DBGMCU_EnableDBGStandbyMode, %function
HAL_DBGMCU_EnableDBGStandbyMode:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 28200
.loc 1 28209
    MOVW r0, #8196
    MOVT r0, #57348
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
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_DBGMCU_EnableDBGStandbyMode, .-HAL_DBGMCU_EnableDBGStandbyMode

.global HAL_DBGMCU_DisableDBGStandbyMode
.type HAL_DBGMCU_DisableDBGStandbyMode, %function
HAL_DBGMCU_DisableDBGStandbyMode:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 28209
.loc 1 28218
    MOVW r0, #8196
    MOVT r0, #57348
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
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
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
.size HAL_DBGMCU_DisableDBGStandbyMode, .-HAL_DBGMCU_DisableDBGStandbyMode

.global HAL_EnableCompensationCell
.type HAL_EnableCompensationCell, %function
HAL_EnableCompensationCell:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 28218
.loc 1 28229
    MOVW r0, #1024
    MOVT r0, #16935
    PUSH {r0}
    MOV r0, #1
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
.size HAL_EnableCompensationCell, .-HAL_EnableCompensationCell

.global HAL_DisableCompensationCell
.type HAL_DisableCompensationCell, %function
HAL_DisableCompensationCell:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 28229
.loc 1 28240
    MOVW r0, #1024
    MOVT r0, #16935
    PUSH {r0}
    MOV r0, #0
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
.size HAL_DisableCompensationCell, .-HAL_DisableCompensationCell

.global HAL_GetUIDw0
.type HAL_GetUIDw0, %function
HAL_GetUIDw0:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 28240
.loc 1 28249
    MOVW r0, #31248
    MOVT r0, #8191
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
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_GetUIDw0, .-HAL_GetUIDw0

.global HAL_GetUIDw1
.type HAL_GetUIDw1, %function
HAL_GetUIDw1:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 28249
.loc 1 28258
    MOVW r0, #31252
    MOVT r0, #8191
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
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_GetUIDw1, .-HAL_GetUIDw1

.global HAL_GetUIDw2
.type HAL_GetUIDw2, %function
HAL_GetUIDw2:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 28258
.loc 1 28267
    MOVW r0, #31256
    MOVT r0, #8191
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
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_GetUIDw2, .-HAL_GetUIDw2

.global HAL_NVIC_SetPriorityGrouping
.type HAL_NVIC_SetPriorityGrouping, %function
HAL_NVIC_SetPriorityGrouping:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 28267
    STR r0, [r6, #0]
.loc 1 28524
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 28527
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    BL __NVIC_SetPriorityGrouping
    PUSH {r0}
    POP {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_NVIC_SetPriorityGrouping, .-HAL_NVIC_SetPriorityGrouping

.global HAL_NVIC_SetPriority
.type HAL_NVIC_SetPriority, %function
HAL_NVIC_SetPriority:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #32
    MOV r6, sp
.loc 1 28527
    STR r0, [r6, #0]
    STR r1, [r6, #8]
    STR r2, [r6, #16]
.loc 1 28545
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
.loc 1 28548
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 28549
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 28551
    BL __NVIC_GetPriorityGrouping
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
.loc 1 28553
    LDR r0, [r6, #16]
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
    POP {r1}
    POP {r2}
    BL NVIC_EncodePriority
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    POP {r1}
    BL __NVIC_SetPriority
    PUSH {r0}
    POP {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #32
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_NVIC_SetPriority, .-HAL_NVIC_SetPriority

.global HAL_NVIC_EnableIRQ
.type HAL_NVIC_EnableIRQ, %function
HAL_NVIC_EnableIRQ:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 28553
    STR r0, [r6, #0]
.loc 1 28568
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 28571
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    BL __NVIC_EnableIRQ
    PUSH {r0}
    POP {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_NVIC_EnableIRQ, .-HAL_NVIC_EnableIRQ

.global HAL_NVIC_DisableIRQ
.type HAL_NVIC_DisableIRQ, %function
HAL_NVIC_DisableIRQ:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 28571
    STR r0, [r6, #0]
.loc 1 28584
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 28587
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    BL __NVIC_DisableIRQ
    PUSH {r0}
    POP {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_NVIC_DisableIRQ, .-HAL_NVIC_DisableIRQ

.global HAL_NVIC_SystemReset
.type HAL_NVIC_SystemReset, %function
HAL_NVIC_SystemReset:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 28587
.loc 1 28597
    BL __NVIC_SystemReset
    PUSH {r0}
    POP {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_NVIC_SystemReset, .-HAL_NVIC_SystemReset

.global HAL_SYSTICK_Config
.type HAL_SYSTICK_Config, %function
HAL_SYSTICK_Config:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 28597
    STR r0, [r6, #0]
.loc 1 28609
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    BL SysTick_Config
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_SYSTICK_Config, .-HAL_SYSTICK_Config

.global HAL_MPU_Disable
.type HAL_MPU_Disable, %function
HAL_MPU_Disable:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 28609
.loc 1 28639
    MOV r0, #15
    PUSH {r0}
    POP {r0}
    DMB SY
    PUSH {r0}
    POP {r0}
.loc 1 28642
    MOVW r0, #60708
    MOVT r0, #57344
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
    MOVW r0, #0
    MOVT r0, #1
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 28645
    MOVW r0, #60820
    MOVT r0, #57344
    PUSH {r0}
    MOV r0, #0
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
.size HAL_MPU_Disable, .-HAL_MPU_Disable

.global HAL_MPU_Enable
.type HAL_MPU_Enable, %function
HAL_MPU_Enable:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 28645
    STR r0, [r6, #0]
.loc 1 28662
    MOVW r0, #60820
    MOVT r0, #57344
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #1
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
.loc 1 28665
    MOVW r0, #60708
    MOVT r0, #57344
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
    MOVW r0, #0
    MOVT r0, #1
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
.loc 1 28668
    MOV r0, #15
    PUSH {r0}
    POP {r0}
    DSB SY
    PUSH {r0}
    POP {r0}
.loc 1 28669
    MOV r0, #15
    PUSH {r0}
    POP {r0}
    ISB SY
    PUSH {r0}
    POP {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_MPU_Enable, .-HAL_MPU_Enable

.global HAL_MPU_EnableRegion
.type HAL_MPU_EnableRegion, %function
HAL_MPU_EnableRegion:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 28669
    STR r0, [r6, #0]
.loc 1 28679
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 28682
    MOVW r0, #60824
    MOVT r0, #57344
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 28685
    MOVW r0, #60832
    MOVT r0, #57344
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
    MOV r0, #1
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
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_MPU_EnableRegion, .-HAL_MPU_EnableRegion

.global HAL_MPU_DisableRegion
.type HAL_MPU_DisableRegion, %function
HAL_MPU_DisableRegion:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 28685
    STR r0, [r6, #0]
.loc 1 28695
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 28698
    MOVW r0, #60824
    MOVT r0, #57344
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 28701
    MOVW r0, #60832
    MOVT r0, #57344
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
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
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
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_MPU_DisableRegion, .-HAL_MPU_DisableRegion

.global HAL_MPU_ConfigRegion
.type HAL_MPU_ConfigRegion, %function
HAL_MPU_ConfigRegion:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 28701
    STR r0, [r6, #0]
.loc 1 28713
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 28714
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 28715
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 28716
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 28717
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 28718
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 28719
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 28720
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 28721
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 28722
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 28725
    MOVW r0, #60824
    MOVT r0, #57344
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    LDRB r0, [r0, #0]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 28728
    MOVW r0, #60832
    MOVT r0, #57344
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
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 28731
    MOVW r0, #60828
    MOVT r0, #57344
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 28732
    MOVW r0, #60832
    MOVT r0, #57344
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    LDRB r0, [r0, #0]
    PUSH {r0}
    MOV r0, #28
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
.loc 1 28733
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #11
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    LDRB r0, [r0, #0]
    PUSH {r0}
    MOV r0, #24
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
.loc 1 28734
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #10
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    LDRB r0, [r0, #0]
    PUSH {r0}
    MOV r0, #19
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
.loc 1 28735
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #13
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    LDRB r0, [r0, #0]
    PUSH {r0}
    MOV r0, #18
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
.loc 1 28736
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #14
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    LDRB r0, [r0, #0]
    PUSH {r0}
    MOV r0, #17
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
.loc 1 28737
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #15
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    LDRB r0, [r0, #0]
    PUSH {r0}
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
.loc 1 28738
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #9
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    LDRB r0, [r0, #0]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
.loc 1 28739
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    LDRB r0, [r0, #0]
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
.loc 1 28740
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    LDRB r0, [r0, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_MPU_ConfigRegion, .-HAL_MPU_ConfigRegion

.global HAL_CORTEX_ClearEvent
.type HAL_CORTEX_ClearEvent, %function
HAL_CORTEX_ClearEvent:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 28740
.loc 1 28750
    SEV
    PUSH {r0}
    POP {r0}
.loc 1 28751
    WFE
    PUSH {r0}
    POP {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_CORTEX_ClearEvent, .-HAL_CORTEX_ClearEvent

.global HAL_NVIC_GetPriorityGrouping
.type HAL_NVIC_GetPriorityGrouping, %function
HAL_NVIC_GetPriorityGrouping:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 28751
.loc 1 28761
    BL __NVIC_GetPriorityGrouping
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_NVIC_GetPriorityGrouping, .-HAL_NVIC_GetPriorityGrouping

.global HAL_NVIC_GetPriority
.type HAL_NVIC_GetPriority, %function
HAL_NVIC_GetPriority:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #32
    MOV r6, sp
.loc 1 28761
    STR r0, [r6, #0]
    STR r1, [r6, #8]
    STR r2, [r6, #16]
    STR r3, [r6, #24]
.loc 1 28788
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 28790
    LDR r0, [r6, #24]
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    BL __NVIC_GetPriority
    PUSH {r0}
    POP {r0}
    POP {r1}
    POP {r2}
    POP {r3}
    BL NVIC_DecodePriority
    PUSH {r0}
    POP {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #32
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_NVIC_GetPriority, .-HAL_NVIC_GetPriority

.global HAL_NVIC_SetPendingIRQ
.type HAL_NVIC_SetPendingIRQ, %function
HAL_NVIC_SetPendingIRQ:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 28790
    STR r0, [r6, #0]
.loc 1 28803
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 28806
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    BL __NVIC_SetPendingIRQ
    PUSH {r0}
    POP {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_NVIC_SetPendingIRQ, .-HAL_NVIC_SetPendingIRQ

.global HAL_NVIC_GetPendingIRQ
.type HAL_NVIC_GetPendingIRQ, %function
HAL_NVIC_GetPendingIRQ:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 28806
    STR r0, [r6, #0]
.loc 1 28821
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 28824
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    BL __NVIC_GetPendingIRQ
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_NVIC_GetPendingIRQ, .-HAL_NVIC_GetPendingIRQ

.global HAL_NVIC_ClearPendingIRQ
.type HAL_NVIC_ClearPendingIRQ, %function
HAL_NVIC_ClearPendingIRQ:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 28824
    STR r0, [r6, #0]
.loc 1 28837
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 28840
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    BL __NVIC_ClearPendingIRQ
    PUSH {r0}
    POP {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_NVIC_ClearPendingIRQ, .-HAL_NVIC_ClearPendingIRQ

.global HAL_NVIC_GetActive
.type HAL_NVIC_GetActive, %function
HAL_NVIC_GetActive:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 28840
    STR r0, [r6, #0]
.loc 1 28854
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 28857
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    BL __NVIC_GetActive
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_NVIC_GetActive, .-HAL_NVIC_GetActive

.global HAL_SYSTICK_CLKSourceConfig
.type HAL_SYSTICK_CLKSourceConfig, %function
HAL_SYSTICK_CLKSourceConfig:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 28857
    STR r0, [r6, #0]
.loc 1 28871
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 28872
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_SYSTICK_CLKSourceConfig_0
.loc 1 28874
    MOVW r0, #57360
    MOVT r0, #57344
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
    B .L_HAL_SYSTICK_CLKSourceConfig_1
.L_HAL_SYSTICK_CLKSourceConfig_0:
.loc 1 28878
    MOVW r0, #57360
    MOVT r0, #57344
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
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_SYSTICK_CLKSourceConfig_1:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_SYSTICK_CLKSourceConfig, .-HAL_SYSTICK_CLKSourceConfig

.global HAL_SYSTICK_IRQHandler
.type HAL_SYSTICK_IRQHandler, %function
HAL_SYSTICK_IRQHandler:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 28878
.loc 1 28888
    BL HAL_SYSTICK_Callback
    PUSH {r0}
    POP {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_SYSTICK_IRQHandler, .-HAL_SYSTICK_IRQHandler

.global HAL_SYSTICK_Callback
.weak HAL_SYSTICK_Callback
.type HAL_SYSTICK_Callback, %function
HAL_SYSTICK_Callback:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 28888
.loc 1 28896
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_SYSTICK_Callback, .-HAL_SYSTICK_Callback

.global HAL_RCC_OscConfig
.weak HAL_RCC_OscConfig
.type HAL_RCC_OscConfig, %function
HAL_RCC_OscConfig:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #40
    MOV r6, sp
.loc 1 28896
    STR r0, [r6, #0]
.loc 1 29234
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_0
.loc 1 29236
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #40
    POP {r5, r6, r7, pc}
.L_HAL_RCC_OscConfig_0:
.L_HAL_RCC_OscConfig_1:
.loc 1 29240
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 29242
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_2
.loc 1 29245
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 29247
    MOVW r0, #14344
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
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_RCC_OscConfig_6
    MOVW r0, #14344
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
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_8
    MOVW r0, #14340
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
    MOVT r0, #64
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOVW r0, #0
    MOVT r0, #64
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    B .L_HAL_RCC_OscConfig_9
.L_HAL_RCC_OscConfig_8:
    MOV r0, #0
    PUSH {r0}
.L_HAL_RCC_OscConfig_9:
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    B .L_HAL_RCC_OscConfig_7
.L_HAL_RCC_OscConfig_6:
    MOV r0, #1
    PUSH {r0}
.L_HAL_RCC_OscConfig_7:
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_4
.loc 1 29249
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_16
    MOVW r0, #14336
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
    B .L_HAL_RCC_OscConfig_17
.L_HAL_RCC_OscConfig_16:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_18
    MOVW r0, #14448
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
    B .L_HAL_RCC_OscConfig_19
.L_HAL_RCC_OscConfig_18:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_20
    MOVW r0, #14452
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
    B .L_HAL_RCC_OscConfig_21
.L_HAL_RCC_OscConfig_20:
    MOVW r0, #14348
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
.L_HAL_RCC_OscConfig_21:
.L_HAL_RCC_OscConfig_19:
.L_HAL_RCC_OscConfig_17:
    MOVW r0, #0
    MOVT r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_14
    MOV r0, #1
    PUSH {r0}
    B .L_HAL_RCC_OscConfig_15
.L_HAL_RCC_OscConfig_14:
    MOV r0, #0
    PUSH {r0}
.L_HAL_RCC_OscConfig_15:
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_12
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    B .L_HAL_RCC_OscConfig_13
.L_HAL_RCC_OscConfig_12:
    MOV r0, #0
    PUSH {r0}
.L_HAL_RCC_OscConfig_13:
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_10
.loc 1 29251
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #40
    POP {r5, r6, r7, pc}
.L_HAL_RCC_OscConfig_10:
.L_HAL_RCC_OscConfig_11:
    B .L_HAL_RCC_OscConfig_5
.L_HAL_RCC_OscConfig_4:
.loc 1 29257
.L_HAL_RCC_OscConfig_22:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVT r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_25
    MOVW r0, #14336
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
    MOVW r0, #0
    MOVT r0, #1
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
    B .L_HAL_RCC_OscConfig_26
.L_HAL_RCC_OscConfig_25:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVT r0, #5
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_27
    MOVW r0, #14336
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
    MOVW r0, #0
    MOVT r0, #4
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
    MOVW r0, #14336
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
    MOVW r0, #0
    MOVT r0, #1
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
    B .L_HAL_RCC_OscConfig_28
.L_HAL_RCC_OscConfig_27:
    MOVW r0, #14336
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
    MOVW r0, #0
    MOVT r0, #1
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    MOVW r0, #14336
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
    MOVW r0, #0
    MOVT r0, #4
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_RCC_OscConfig_28:
.L_HAL_RCC_OscConfig_26:
.L_HAL_RCC_OscConfig_24:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_RCC_OscConfig_22
.L_HAL_RCC_OscConfig_23:
.loc 1 29260
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_29
.loc 1 29263
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 29266
.L_HAL_RCC_OscConfig_31:
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_35
    MOVW r0, #14336
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
    B .L_HAL_RCC_OscConfig_36
.L_HAL_RCC_OscConfig_35:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_37
    MOVW r0, #14448
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
    B .L_HAL_RCC_OscConfig_38
.L_HAL_RCC_OscConfig_37:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_39
    MOVW r0, #14452
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
    B .L_HAL_RCC_OscConfig_40
.L_HAL_RCC_OscConfig_39:
    MOVW r0, #14348
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
.L_HAL_RCC_OscConfig_40:
.L_HAL_RCC_OscConfig_38:
.L_HAL_RCC_OscConfig_36:
    MOVW r0, #0
    MOVT r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_33
    MOV r0, #1
    PUSH {r0}
    B .L_HAL_RCC_OscConfig_34
.L_HAL_RCC_OscConfig_33:
    MOV r0, #0
    PUSH {r0}
.L_HAL_RCC_OscConfig_34:
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_32
.loc 1 29268
    BL HAL_GetTick
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    MOV r0, #100
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_41
.loc 1 29270
    MOV r0, #3
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #40
    POP {r5, r6, r7, pc}
.L_HAL_RCC_OscConfig_41:
.L_HAL_RCC_OscConfig_42:
    B .L_HAL_RCC_OscConfig_31
.L_HAL_RCC_OscConfig_32:
    B .L_HAL_RCC_OscConfig_30
.L_HAL_RCC_OscConfig_29:
.loc 1 29277
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 29280
.L_HAL_RCC_OscConfig_43:
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_47
    MOVW r0, #14336
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
    B .L_HAL_RCC_OscConfig_48
.L_HAL_RCC_OscConfig_47:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_49
    MOVW r0, #14448
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
    B .L_HAL_RCC_OscConfig_50
.L_HAL_RCC_OscConfig_49:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_51
    MOVW r0, #14452
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
    B .L_HAL_RCC_OscConfig_52
.L_HAL_RCC_OscConfig_51:
    MOVW r0, #14348
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
.L_HAL_RCC_OscConfig_52:
.L_HAL_RCC_OscConfig_50:
.L_HAL_RCC_OscConfig_48:
    MOVW r0, #0
    MOVT r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_45
    MOV r0, #1
    PUSH {r0}
    B .L_HAL_RCC_OscConfig_46
.L_HAL_RCC_OscConfig_45:
    MOV r0, #0
    PUSH {r0}
.L_HAL_RCC_OscConfig_46:
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_44
.loc 1 29282
    BL HAL_GetTick
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    MOV r0, #100
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_53
.loc 1 29284
    MOV r0, #3
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #40
    POP {r5, r6, r7, pc}
.L_HAL_RCC_OscConfig_53:
.L_HAL_RCC_OscConfig_54:
    B .L_HAL_RCC_OscConfig_43
.L_HAL_RCC_OscConfig_44:
.L_HAL_RCC_OscConfig_30:
.L_HAL_RCC_OscConfig_5:
    B .L_HAL_RCC_OscConfig_3
.L_HAL_RCC_OscConfig_2:
.L_HAL_RCC_OscConfig_3:
.loc 1 29291
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    AND r0, r1
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_55
.loc 1 29294
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 29295
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 29298
    MOVW r0, #14344
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
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_RCC_OscConfig_59
    MOVW r0, #14344
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
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_61
    MOVW r0, #14340
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
    MOVT r0, #64
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    B .L_HAL_RCC_OscConfig_62
.L_HAL_RCC_OscConfig_61:
    MOV r0, #0
    PUSH {r0}
.L_HAL_RCC_OscConfig_62:
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    B .L_HAL_RCC_OscConfig_60
.L_HAL_RCC_OscConfig_59:
    MOV r0, #1
    PUSH {r0}
.L_HAL_RCC_OscConfig_60:
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_57
.loc 1 29301
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_69
    MOVW r0, #14336
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
    B .L_HAL_RCC_OscConfig_70
.L_HAL_RCC_OscConfig_69:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_71
    MOVW r0, #14448
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
    B .L_HAL_RCC_OscConfig_72
.L_HAL_RCC_OscConfig_71:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_73
    MOVW r0, #14452
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
    B .L_HAL_RCC_OscConfig_74
.L_HAL_RCC_OscConfig_73:
    MOVW r0, #14348
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
.L_HAL_RCC_OscConfig_74:
.L_HAL_RCC_OscConfig_72:
.L_HAL_RCC_OscConfig_70:
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_67
    MOV r0, #1
    PUSH {r0}
    B .L_HAL_RCC_OscConfig_68
.L_HAL_RCC_OscConfig_67:
    MOV r0, #0
    PUSH {r0}
.L_HAL_RCC_OscConfig_68:
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_65
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    B .L_HAL_RCC_OscConfig_66
.L_HAL_RCC_OscConfig_65:
    MOV r0, #0
    PUSH {r0}
.L_HAL_RCC_OscConfig_66:
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_63
.loc 1 29303
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #40
    POP {r5, r6, r7, pc}
.L_HAL_RCC_OscConfig_63:
.loc 1 29309
    MOVW r0, #14336
    MOVT r0, #16386
    PUSH {r0}
    MOVW r0, #14336
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
    MOV r0, #248
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #3
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
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
.L_HAL_RCC_OscConfig_64:
    B .L_HAL_RCC_OscConfig_58
.L_HAL_RCC_OscConfig_57:
.loc 1 29315
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_75
.loc 1 29318
    MOVW r0, #0
    MOVT r0, #16967
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 29321
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 29324
.L_HAL_RCC_OscConfig_77:
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_81
    MOVW r0, #14336
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
    B .L_HAL_RCC_OscConfig_82
.L_HAL_RCC_OscConfig_81:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_83
    MOVW r0, #14448
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
    B .L_HAL_RCC_OscConfig_84
.L_HAL_RCC_OscConfig_83:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_85
    MOVW r0, #14452
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
    B .L_HAL_RCC_OscConfig_86
.L_HAL_RCC_OscConfig_85:
    MOVW r0, #14348
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
.L_HAL_RCC_OscConfig_86:
.L_HAL_RCC_OscConfig_84:
.L_HAL_RCC_OscConfig_82:
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_79
    MOV r0, #1
    PUSH {r0}
    B .L_HAL_RCC_OscConfig_80
.L_HAL_RCC_OscConfig_79:
    MOV r0, #0
    PUSH {r0}
.L_HAL_RCC_OscConfig_80:
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_78
.loc 1 29326
    BL HAL_GetTick
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_87
.loc 1 29328
    MOV r0, #3
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #40
    POP {r5, r6, r7, pc}
.L_HAL_RCC_OscConfig_87:
.L_HAL_RCC_OscConfig_88:
    B .L_HAL_RCC_OscConfig_77
.L_HAL_RCC_OscConfig_78:
.loc 1 29333
    MOVW r0, #14336
    MOVT r0, #16386
    PUSH {r0}
    MOVW r0, #14336
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
    MOV r0, #248
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #3
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
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
    B .L_HAL_RCC_OscConfig_76
.L_HAL_RCC_OscConfig_75:
.loc 1 29338
    MOVW r0, #0
    MOVT r0, #16967
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 29341
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 29344
.L_HAL_RCC_OscConfig_89:
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_93
    MOVW r0, #14336
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
    B .L_HAL_RCC_OscConfig_94
.L_HAL_RCC_OscConfig_93:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_95
    MOVW r0, #14448
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
    B .L_HAL_RCC_OscConfig_96
.L_HAL_RCC_OscConfig_95:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_97
    MOVW r0, #14452
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
    B .L_HAL_RCC_OscConfig_98
.L_HAL_RCC_OscConfig_97:
    MOVW r0, #14348
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
.L_HAL_RCC_OscConfig_98:
.L_HAL_RCC_OscConfig_96:
.L_HAL_RCC_OscConfig_94:
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_91
    MOV r0, #1
    PUSH {r0}
    B .L_HAL_RCC_OscConfig_92
.L_HAL_RCC_OscConfig_91:
    MOV r0, #0
    PUSH {r0}
.L_HAL_RCC_OscConfig_92:
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_90
.loc 1 29346
    BL HAL_GetTick
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_99
.loc 1 29348
    MOV r0, #3
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #40
    POP {r5, r6, r7, pc}
.L_HAL_RCC_OscConfig_99:
.L_HAL_RCC_OscConfig_100:
    B .L_HAL_RCC_OscConfig_89
.L_HAL_RCC_OscConfig_90:
.L_HAL_RCC_OscConfig_76:
.L_HAL_RCC_OscConfig_58:
    B .L_HAL_RCC_OscConfig_56
.L_HAL_RCC_OscConfig_55:
.L_HAL_RCC_OscConfig_56:
.loc 1 29355
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_101
.loc 1 29358
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 29361
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #20
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_103
.loc 1 29364
    MOVW r0, #3712
    MOVT r0, #16967
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 29367
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 29370
.L_HAL_RCC_OscConfig_105:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_109
    MOVW r0, #14336
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
    B .L_HAL_RCC_OscConfig_110
.L_HAL_RCC_OscConfig_109:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_111
    MOVW r0, #14448
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
    B .L_HAL_RCC_OscConfig_112
.L_HAL_RCC_OscConfig_111:
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_113
    MOVW r0, #14452
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
    B .L_HAL_RCC_OscConfig_114
.L_HAL_RCC_OscConfig_113:
    MOVW r0, #14348
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
.L_HAL_RCC_OscConfig_114:
.L_HAL_RCC_OscConfig_112:
.L_HAL_RCC_OscConfig_110:
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_107
    MOV r0, #1
    PUSH {r0}
    B .L_HAL_RCC_OscConfig_108
.L_HAL_RCC_OscConfig_107:
    MOV r0, #0
    PUSH {r0}
.L_HAL_RCC_OscConfig_108:
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_106
.loc 1 29372
    BL HAL_GetTick
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_115
.loc 1 29374
    MOV r0, #3
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #40
    POP {r5, r6, r7, pc}
.L_HAL_RCC_OscConfig_115:
.L_HAL_RCC_OscConfig_116:
    B .L_HAL_RCC_OscConfig_105
.L_HAL_RCC_OscConfig_106:
    B .L_HAL_RCC_OscConfig_104
.L_HAL_RCC_OscConfig_103:
.loc 1 29381
    MOVW r0, #3712
    MOVT r0, #16967
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 29384
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 29387
.L_HAL_RCC_OscConfig_117:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_121
    MOVW r0, #14336
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
    B .L_HAL_RCC_OscConfig_122
.L_HAL_RCC_OscConfig_121:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_123
    MOVW r0, #14448
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
    B .L_HAL_RCC_OscConfig_124
.L_HAL_RCC_OscConfig_123:
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_125
    MOVW r0, #14452
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
    B .L_HAL_RCC_OscConfig_126
.L_HAL_RCC_OscConfig_125:
    MOVW r0, #14348
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
.L_HAL_RCC_OscConfig_126:
.L_HAL_RCC_OscConfig_124:
.L_HAL_RCC_OscConfig_122:
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_119
    MOV r0, #1
    PUSH {r0}
    B .L_HAL_RCC_OscConfig_120
.L_HAL_RCC_OscConfig_119:
    MOV r0, #0
    PUSH {r0}
.L_HAL_RCC_OscConfig_120:
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_118
.loc 1 29389
    BL HAL_GetTick
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_127
.loc 1 29391
    MOV r0, #3
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #40
    POP {r5, r6, r7, pc}
.L_HAL_RCC_OscConfig_127:
.L_HAL_RCC_OscConfig_128:
    B .L_HAL_RCC_OscConfig_117
.L_HAL_RCC_OscConfig_118:
.L_HAL_RCC_OscConfig_104:
    B .L_HAL_RCC_OscConfig_102
.L_HAL_RCC_OscConfig_101:
.L_HAL_RCC_OscConfig_102:
.loc 1 29397
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    AND r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_129
.loc 1 29399
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
.loc 1 29402
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 29406
    MOVW r0, #14400
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
    MOVT r0, #4096
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_131
.loc 1 29408
.L_HAL_RCC_OscConfig_133:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #32]
    MOVW r0, #14400
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
    MOVW r0, #0
    MOVT r0, #4096
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
    MOVW r0, #14400
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
    MOVT r0, #4096
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #32]
    LDR r0, [r6, #32]
    PUSH {r0}
    POP {r0}
    LDR r0, [r6, #32]
    PUSH {r0}
    POP {r0}
.L_HAL_RCC_OscConfig_135:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_RCC_OscConfig_133
.L_HAL_RCC_OscConfig_134:
.loc 1 29409
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
    B .L_HAL_RCC_OscConfig_132
.L_HAL_RCC_OscConfig_131:
.L_HAL_RCC_OscConfig_132:
.loc 1 29412
    MOVW r0, #28672
    MOVT r0, #16384
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
    MOVW r0, #256
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_136
.loc 1 29415
    MOVW r0, #28672
    MOVT r0, #16384
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
    MOVW r0, #256
    MOVT r0, #0
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
.loc 1 29418
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 29420
.L_HAL_RCC_OscConfig_138:
    MOVW r0, #28672
    MOVT r0, #16384
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
    MOVW r0, #256
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_139
.loc 1 29422
    BL HAL_GetTick
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_140
.loc 1 29424
    MOV r0, #3
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #40
    POP {r5, r6, r7, pc}
.L_HAL_RCC_OscConfig_140:
.L_HAL_RCC_OscConfig_141:
    B .L_HAL_RCC_OscConfig_138
.L_HAL_RCC_OscConfig_139:
    B .L_HAL_RCC_OscConfig_137
.L_HAL_RCC_OscConfig_136:
.L_HAL_RCC_OscConfig_137:
.loc 1 29430
.L_HAL_RCC_OscConfig_142:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_145
    MOVW r0, #14448
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
    MOV r0, #1
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
    B .L_HAL_RCC_OscConfig_146
.L_HAL_RCC_OscConfig_145:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #5
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_147
    MOVW r0, #14448
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
    MOVW r0, #14448
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
    MOV r0, #1
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
    B .L_HAL_RCC_OscConfig_148
.L_HAL_RCC_OscConfig_147:
    MOVW r0, #14448
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
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    MOVW r0, #14448
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
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_RCC_OscConfig_148:
.L_HAL_RCC_OscConfig_146:
.L_HAL_RCC_OscConfig_144:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_RCC_OscConfig_142
.L_HAL_RCC_OscConfig_143:
.loc 1 29432
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_149
.loc 1 29435
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 29438
.L_HAL_RCC_OscConfig_151:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_155
    MOVW r0, #14336
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
    B .L_HAL_RCC_OscConfig_156
.L_HAL_RCC_OscConfig_155:
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_157
    MOVW r0, #14448
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
    B .L_HAL_RCC_OscConfig_158
.L_HAL_RCC_OscConfig_157:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_159
    MOVW r0, #14452
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
    B .L_HAL_RCC_OscConfig_160
.L_HAL_RCC_OscConfig_159:
    MOVW r0, #14348
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
.L_HAL_RCC_OscConfig_160:
.L_HAL_RCC_OscConfig_158:
.L_HAL_RCC_OscConfig_156:
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_153
    MOV r0, #1
    PUSH {r0}
    B .L_HAL_RCC_OscConfig_154
.L_HAL_RCC_OscConfig_153:
    MOV r0, #0
    PUSH {r0}
.L_HAL_RCC_OscConfig_154:
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_152
.loc 1 29440
    BL HAL_GetTick
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    MOVW r0, #5000
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_161
.loc 1 29442
    MOV r0, #3
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #40
    POP {r5, r6, r7, pc}
.L_HAL_RCC_OscConfig_161:
.L_HAL_RCC_OscConfig_162:
    B .L_HAL_RCC_OscConfig_151
.L_HAL_RCC_OscConfig_152:
    B .L_HAL_RCC_OscConfig_150
.L_HAL_RCC_OscConfig_149:
.loc 1 29449
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 29452
.L_HAL_RCC_OscConfig_163:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_167
    MOVW r0, #14336
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
    B .L_HAL_RCC_OscConfig_168
.L_HAL_RCC_OscConfig_167:
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_169
    MOVW r0, #14448
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
    B .L_HAL_RCC_OscConfig_170
.L_HAL_RCC_OscConfig_169:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_171
    MOVW r0, #14452
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
    B .L_HAL_RCC_OscConfig_172
.L_HAL_RCC_OscConfig_171:
    MOVW r0, #14348
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
.L_HAL_RCC_OscConfig_172:
.L_HAL_RCC_OscConfig_170:
.L_HAL_RCC_OscConfig_168:
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_165
    MOV r0, #1
    PUSH {r0}
    B .L_HAL_RCC_OscConfig_166
.L_HAL_RCC_OscConfig_165:
    MOV r0, #0
    PUSH {r0}
.L_HAL_RCC_OscConfig_166:
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_164
.loc 1 29454
    BL HAL_GetTick
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    MOVW r0, #5000
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_173
.loc 1 29456
    MOV r0, #3
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #40
    POP {r5, r6, r7, pc}
.L_HAL_RCC_OscConfig_173:
.L_HAL_RCC_OscConfig_174:
    B .L_HAL_RCC_OscConfig_163
.L_HAL_RCC_OscConfig_164:
.L_HAL_RCC_OscConfig_150:
.loc 1 29462
    LDR r0, [r6, #24]
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_175
.loc 1 29464
    MOVW r0, #14400
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
    MOVW r0, #0
    MOVT r0, #4096
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_HAL_RCC_OscConfig_176
.L_HAL_RCC_OscConfig_175:
.L_HAL_RCC_OscConfig_176:
    B .L_HAL_RCC_OscConfig_130
.L_HAL_RCC_OscConfig_129:
.L_HAL_RCC_OscConfig_130:
.loc 1 29469
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 29470
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #24
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_177
.loc 1 29473
    MOVW r0, #14344
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
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_179
.loc 1 29475
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #24
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_181
.loc 1 29478
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 29479
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 29480
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 29481
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 29482
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 29485
    MOVW r0, #96
    MOVT r0, #16967
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 29488
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 29491
.L_HAL_RCC_OscConfig_183:
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_187
    MOVW r0, #14336
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
    B .L_HAL_RCC_OscConfig_188
.L_HAL_RCC_OscConfig_187:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_189
    MOVW r0, #14448
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
    B .L_HAL_RCC_OscConfig_190
.L_HAL_RCC_OscConfig_189:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_191
    MOVW r0, #14452
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
    B .L_HAL_RCC_OscConfig_192
.L_HAL_RCC_OscConfig_191:
    MOVW r0, #14348
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
.L_HAL_RCC_OscConfig_192:
.L_HAL_RCC_OscConfig_190:
.L_HAL_RCC_OscConfig_188:
    MOVW r0, #0
    MOVT r0, #512
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_185
    MOV r0, #1
    PUSH {r0}
    B .L_HAL_RCC_OscConfig_186
.L_HAL_RCC_OscConfig_185:
    MOV r0, #0
    PUSH {r0}
.L_HAL_RCC_OscConfig_186:
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_184
.loc 1 29493
    BL HAL_GetTick
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_193
.loc 1 29495
    MOV r0, #3
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #40
    POP {r5, r6, r7, pc}
.L_HAL_RCC_OscConfig_193:
.L_HAL_RCC_OscConfig_194:
    B .L_HAL_RCC_OscConfig_183
.L_HAL_RCC_OscConfig_184:
.loc 1 29500
    MOVW r0, #14340
    MOVT r0, #16386
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #24
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #24
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #24
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #6
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #24
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #24
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #20
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #24
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
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
.loc 1 29502
    MOVW r0, #96
    MOVT r0, #16967
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 29505
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 29508
.L_HAL_RCC_OscConfig_195:
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_199
    MOVW r0, #14336
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
    B .L_HAL_RCC_OscConfig_200
.L_HAL_RCC_OscConfig_199:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_201
    MOVW r0, #14448
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
    B .L_HAL_RCC_OscConfig_202
.L_HAL_RCC_OscConfig_201:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_203
    MOVW r0, #14452
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
    B .L_HAL_RCC_OscConfig_204
.L_HAL_RCC_OscConfig_203:
    MOVW r0, #14348
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
.L_HAL_RCC_OscConfig_204:
.L_HAL_RCC_OscConfig_202:
.L_HAL_RCC_OscConfig_200:
    MOVW r0, #0
    MOVT r0, #512
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_197
    MOV r0, #1
    PUSH {r0}
    B .L_HAL_RCC_OscConfig_198
.L_HAL_RCC_OscConfig_197:
    MOV r0, #0
    PUSH {r0}
.L_HAL_RCC_OscConfig_198:
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_196
.loc 1 29510
    BL HAL_GetTick
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_205
.loc 1 29512
    MOV r0, #3
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #40
    POP {r5, r6, r7, pc}
.L_HAL_RCC_OscConfig_205:
.L_HAL_RCC_OscConfig_206:
    B .L_HAL_RCC_OscConfig_195
.L_HAL_RCC_OscConfig_196:
    B .L_HAL_RCC_OscConfig_182
.L_HAL_RCC_OscConfig_181:
.loc 1 29519
    MOVW r0, #96
    MOVT r0, #16967
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 29522
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 29525
.L_HAL_RCC_OscConfig_207:
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_211
    MOVW r0, #14336
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
    B .L_HAL_RCC_OscConfig_212
.L_HAL_RCC_OscConfig_211:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_213
    MOVW r0, #14448
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
    B .L_HAL_RCC_OscConfig_214
.L_HAL_RCC_OscConfig_213:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_215
    MOVW r0, #14452
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
    B .L_HAL_RCC_OscConfig_216
.L_HAL_RCC_OscConfig_215:
    MOVW r0, #14348
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
.L_HAL_RCC_OscConfig_216:
.L_HAL_RCC_OscConfig_214:
.L_HAL_RCC_OscConfig_212:
    MOVW r0, #0
    MOVT r0, #512
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_209
    MOV r0, #1
    PUSH {r0}
    B .L_HAL_RCC_OscConfig_210
.L_HAL_RCC_OscConfig_209:
    MOV r0, #0
    PUSH {r0}
.L_HAL_RCC_OscConfig_210:
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_208
.loc 1 29527
    BL HAL_GetTick
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_217
.loc 1 29529
    MOV r0, #3
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #40
    POP {r5, r6, r7, pc}
.L_HAL_RCC_OscConfig_217:
.L_HAL_RCC_OscConfig_218:
    B .L_HAL_RCC_OscConfig_207
.L_HAL_RCC_OscConfig_208:
.L_HAL_RCC_OscConfig_182:
    B .L_HAL_RCC_OscConfig_180
.L_HAL_RCC_OscConfig_179:
.loc 1 29537
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #24
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_219
.loc 1 29539
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #40
    POP {r5, r6, r7, pc}
.L_HAL_RCC_OscConfig_219:
.loc 1 29544
    MOVW r0, #14340
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
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
.loc 1 29547
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #24
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_RCC_OscConfig_231
.loc 1 29548
    LDR r0, [r6, #16]
    PUSH {r0}
    MOVW r0, #0
    MOVT r0, #64
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #24
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    B .L_HAL_RCC_OscConfig_232
.L_HAL_RCC_OscConfig_231:
    MOV r0, #1
    PUSH {r0}
.L_HAL_RCC_OscConfig_232:
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_RCC_OscConfig_229
.loc 1 29549
    LDR r0, [r6, #16]
    PUSH {r0}
    MOV r0, #63
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #24
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    B .L_HAL_RCC_OscConfig_230
.L_HAL_RCC_OscConfig_229:
    MOV r0, #1
    PUSH {r0}
.L_HAL_RCC_OscConfig_230:
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_RCC_OscConfig_227
.loc 1 29550
    LDR r0, [r6, #16]
    PUSH {r0}
    MOVW r0, #32704
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #24
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #6
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    B .L_HAL_RCC_OscConfig_228
.L_HAL_RCC_OscConfig_227:
    MOV r0, #1
    PUSH {r0}
.L_HAL_RCC_OscConfig_228:
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_RCC_OscConfig_225
.loc 1 29551
    LDR r0, [r6, #16]
    PUSH {r0}
    MOVW r0, #0
    MOVT r0, #3
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #24
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    B .L_HAL_RCC_OscConfig_226
.L_HAL_RCC_OscConfig_225:
    MOV r0, #1
    PUSH {r0}
.L_HAL_RCC_OscConfig_226:
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_RCC_OscConfig_223
.loc 1 29552
    LDR r0, [r6, #16]
    PUSH {r0}
    MOVW r0, #0
    MOVT r0, #3840
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #24
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #20
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #24
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    B .L_HAL_RCC_OscConfig_224
.L_HAL_RCC_OscConfig_223:
    MOV r0, #1
    PUSH {r0}
.L_HAL_RCC_OscConfig_224:
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_OscConfig_221
.loc 1 29555
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #40
    POP {r5, r6, r7, pc}
.L_HAL_RCC_OscConfig_221:
.L_HAL_RCC_OscConfig_222:
.L_HAL_RCC_OscConfig_220:
.L_HAL_RCC_OscConfig_180:
    B .L_HAL_RCC_OscConfig_178
.L_HAL_RCC_OscConfig_177:
.L_HAL_RCC_OscConfig_178:
.loc 1 29560
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #40
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_RCC_OscConfig, .-HAL_RCC_OscConfig

.global HAL_RCC_ClockConfig
.type HAL_RCC_ClockConfig, %function
HAL_RCC_ClockConfig:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #24
    MOV r6, sp
.loc 1 29560
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 29593
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_ClockConfig_0
.loc 1 29595
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #24
    POP {r5, r6, r7, pc}
.L_HAL_RCC_ClockConfig_0:
.L_HAL_RCC_ClockConfig_1:
.loc 1 29599
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 29600
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 29607
    LDR r0, [r6, #8]
    PUSH {r0}
    MOVW r0, #15360
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
    MOV r0, #7
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_ClockConfig_2
.loc 1 29610
    MOVW r0, #15360
    MOVT r0, #16386
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STRB r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 29614
    MOVW r0, #15360
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
    MOV r0, #7
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_ClockConfig_4
.loc 1 29616
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #24
    POP {r5, r6, r7, pc}
.L_HAL_RCC_ClockConfig_4:
.L_HAL_RCC_ClockConfig_5:
    B .L_HAL_RCC_ClockConfig_3
.L_HAL_RCC_ClockConfig_2:
.L_HAL_RCC_ClockConfig_3:
.loc 1 29621
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    AND r0, r1
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_ClockConfig_6
.loc 1 29625
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    AND r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_ClockConfig_8
.loc 1 29627
    MOVW r0, #14344
    MOVT r0, #16386
    PUSH {r0}
    MOVW r0, #14344
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
    MOVW r0, #7168
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOVW r0, #7168
    MOVT r0, #0
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
    B .L_HAL_RCC_ClockConfig_9
.L_HAL_RCC_ClockConfig_8:
.L_HAL_RCC_ClockConfig_9:
.loc 1 29630
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_ClockConfig_10
.loc 1 29632
    MOVW r0, #14344
    MOVT r0, #16386
    PUSH {r0}
    MOVW r0, #14344
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
    MOVW r0, #57344
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOVW r0, #57344
    MOVT r0, #0
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
    B .L_HAL_RCC_ClockConfig_11
.L_HAL_RCC_ClockConfig_10:
.L_HAL_RCC_ClockConfig_11:
.loc 1 29635
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 29636
    MOVW r0, #14344
    MOVT r0, #16386
    PUSH {r0}
    MOVW r0, #14344
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
    MOV r0, #240
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_HAL_RCC_ClockConfig_7
.L_HAL_RCC_ClockConfig_6:
.L_HAL_RCC_ClockConfig_7:
.loc 1 29640
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_ClockConfig_12
.loc 1 29642
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 29645
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_ClockConfig_14
.loc 1 29648
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_ClockConfig_20
    MOVW r0, #14336
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
    B .L_HAL_RCC_ClockConfig_21
.L_HAL_RCC_ClockConfig_20:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_ClockConfig_22
    MOVW r0, #14448
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
    B .L_HAL_RCC_ClockConfig_23
.L_HAL_RCC_ClockConfig_22:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_ClockConfig_24
    MOVW r0, #14452
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
    B .L_HAL_RCC_ClockConfig_25
.L_HAL_RCC_ClockConfig_24:
    MOVW r0, #14348
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
.L_HAL_RCC_ClockConfig_25:
.L_HAL_RCC_ClockConfig_23:
.L_HAL_RCC_ClockConfig_21:
    MOVW r0, #0
    MOVT r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_ClockConfig_18
    MOV r0, #1
    PUSH {r0}
    B .L_HAL_RCC_ClockConfig_19
.L_HAL_RCC_ClockConfig_18:
    MOV r0, #0
    PUSH {r0}
.L_HAL_RCC_ClockConfig_19:
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_ClockConfig_16
.loc 1 29650
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #24
    POP {r5, r6, r7, pc}
.L_HAL_RCC_ClockConfig_16:
.L_HAL_RCC_ClockConfig_17:
    B .L_HAL_RCC_ClockConfig_15
.L_HAL_RCC_ClockConfig_14:
.loc 1 29654
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_RCC_ClockConfig_28
.loc 1 29655
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #3
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    B .L_HAL_RCC_ClockConfig_29
.L_HAL_RCC_ClockConfig_28:
    MOV r0, #1
    PUSH {r0}
.L_HAL_RCC_ClockConfig_29:
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_ClockConfig_26
.loc 1 29658
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_ClockConfig_34
    MOVW r0, #14336
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
    B .L_HAL_RCC_ClockConfig_35
.L_HAL_RCC_ClockConfig_34:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_ClockConfig_36
    MOVW r0, #14448
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
    B .L_HAL_RCC_ClockConfig_37
.L_HAL_RCC_ClockConfig_36:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_ClockConfig_38
    MOVW r0, #14452
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
    B .L_HAL_RCC_ClockConfig_39
.L_HAL_RCC_ClockConfig_38:
    MOVW r0, #14348
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
.L_HAL_RCC_ClockConfig_39:
.L_HAL_RCC_ClockConfig_37:
.L_HAL_RCC_ClockConfig_35:
    MOVW r0, #0
    MOVT r0, #512
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_ClockConfig_32
    MOV r0, #1
    PUSH {r0}
    B .L_HAL_RCC_ClockConfig_33
.L_HAL_RCC_ClockConfig_32:
    MOV r0, #0
    PUSH {r0}
.L_HAL_RCC_ClockConfig_33:
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_ClockConfig_30
.loc 1 29660
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #24
    POP {r5, r6, r7, pc}
.L_HAL_RCC_ClockConfig_30:
.L_HAL_RCC_ClockConfig_31:
    B .L_HAL_RCC_ClockConfig_27
.L_HAL_RCC_ClockConfig_26:
.loc 1 29667
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_ClockConfig_44
    MOVW r0, #14336
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
    B .L_HAL_RCC_ClockConfig_45
.L_HAL_RCC_ClockConfig_44:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_ClockConfig_46
    MOVW r0, #14448
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
    B .L_HAL_RCC_ClockConfig_47
.L_HAL_RCC_ClockConfig_46:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_ClockConfig_48
    MOVW r0, #14452
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
    B .L_HAL_RCC_ClockConfig_49
.L_HAL_RCC_ClockConfig_48:
    MOVW r0, #14348
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
.L_HAL_RCC_ClockConfig_49:
.L_HAL_RCC_ClockConfig_47:
.L_HAL_RCC_ClockConfig_45:
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_ClockConfig_42
    MOV r0, #1
    PUSH {r0}
    B .L_HAL_RCC_ClockConfig_43
.L_HAL_RCC_ClockConfig_42:
    MOV r0, #0
    PUSH {r0}
.L_HAL_RCC_ClockConfig_43:
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_ClockConfig_40
.loc 1 29669
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #24
    POP {r5, r6, r7, pc}
.L_HAL_RCC_ClockConfig_40:
.L_HAL_RCC_ClockConfig_41:
.L_HAL_RCC_ClockConfig_27:
.L_HAL_RCC_ClockConfig_15:
.loc 1 29673
    MOVW r0, #14344
    MOVT r0, #16386
    PUSH {r0}
    MOVW r0, #14344
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
    MOV r0, #3
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 29676
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
.loc 1 29678
.L_HAL_RCC_ClockConfig_50:
    MOVW r0, #14344
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
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    LSL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_ClockConfig_51
.loc 1 29680
    BL HAL_GetTick
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    MOVW r0, #5000
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_ClockConfig_52
.loc 1 29682
    MOV r0, #3
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #24
    POP {r5, r6, r7, pc}
.L_HAL_RCC_ClockConfig_52:
.L_HAL_RCC_ClockConfig_53:
    B .L_HAL_RCC_ClockConfig_50
.L_HAL_RCC_ClockConfig_51:
    B .L_HAL_RCC_ClockConfig_13
.L_HAL_RCC_ClockConfig_12:
.L_HAL_RCC_ClockConfig_13:
.loc 1 29688
    LDR r0, [r6, #8]
    PUSH {r0}
    MOVW r0, #15360
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
    MOV r0, #7
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE LO
    MOVLO r0, #1
    MOVHS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_ClockConfig_54
.loc 1 29691
    MOVW r0, #15360
    MOVT r0, #16386
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STRB r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 29695
    MOVW r0, #15360
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
    MOV r0, #7
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_ClockConfig_56
.loc 1 29697
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #24
    POP {r5, r6, r7, pc}
.L_HAL_RCC_ClockConfig_56:
.L_HAL_RCC_ClockConfig_57:
    B .L_HAL_RCC_ClockConfig_55
.L_HAL_RCC_ClockConfig_54:
.L_HAL_RCC_ClockConfig_55:
.loc 1 29702
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    AND r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_ClockConfig_58
.loc 1 29704
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 29705
    MOVW r0, #14344
    MOVT r0, #16386
    PUSH {r0}
    MOVW r0, #14344
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
    MOVW r0, #7168
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_HAL_RCC_ClockConfig_59
.L_HAL_RCC_ClockConfig_58:
.L_HAL_RCC_ClockConfig_59:
.loc 1 29709
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_ClockConfig_60
.loc 1 29711
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 29712
    MOVW r0, #14344
    MOVT r0, #16386
    PUSH {r0}
    MOVW r0, #14344
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
    MOVW r0, #57344
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #3
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
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
    B .L_HAL_RCC_ClockConfig_61
.L_HAL_RCC_ClockConfig_60:
.L_HAL_RCC_ClockConfig_61:
.loc 1 29716
    BL HAL_RCC_GetSysClockFreq
    PUSH {r0}
    MOVW r0, #4
    MOVT r0, #8192
    PUSH {r0}
    MOVW r0, #14344
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
    MOV r0, #240
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    LDRB r0, [r0, #0]
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    POP {r0}
    PUSH {r0}
    PUSH {r0}
    POP {r0}
    MOVW r1, #0
    MOVT r1, #8192
    STR r0, [r1]
    POP {r0}
.loc 1 29719
    MOVW r0, #28
    MOVT r0, #8192
    LDR r0, [r0]
    PUSH {r0}
    POP {r0}
    BL HAL_InitTick
    PUSH {r0}
    POP {r0}
.loc 1 29721
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #24
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_RCC_ClockConfig, .-HAL_RCC_ClockConfig

.global HAL_RCC_MCOConfig
.type HAL_RCC_MCOConfig, %function
HAL_RCC_MCOConfig:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #56
    MOV r6, sp
.loc 1 29721
    STR r0, [r6, #0]
    STR r1, [r6, #8]
    STR r2, [r6, #16]
.loc 1 29776
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 29777
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 29779
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_MCOConfig_0
.loc 1 29781
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 29784
.L_HAL_RCC_MCOConfig_2:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #48]
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
    MOV r0, #1
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
    MOVW r0, #14384
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
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #48]
    LDR r0, [r6, #48]
    PUSH {r0}
    POP {r0}
    LDR r0, [r6, #48]
    PUSH {r0}
    POP {r0}
.L_HAL_RCC_MCOConfig_4:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_RCC_MCOConfig_2
.L_HAL_RCC_MCOConfig_3:
.loc 1 29787
    ADD r0, r6, #24
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOVW r0, #256
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 29788
    ADD r0, r6, #24
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 29789
    ADD r0, r6, #24
    PUSH {r0}
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #3
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 29790
    ADD r0, r6, #24
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 29791
    ADD r0, r6, #24
    PUSH {r0}
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 29792
    ADD r0, r6, #24
    PUSH {r0}
    MOVW r0, #0
    MOVT r0, #16386
    PUSH {r0}
    POP {r0}
    POP {r1}
    BL HAL_GPIO_Init
    PUSH {r0}
    POP {r0}
.loc 1 29795
    MOVW r0, #14344
    MOVT r0, #16386
    PUSH {r0}
    MOVW r0, #14344
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
    MOVT r0, #1888
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
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
    B .L_HAL_RCC_MCOConfig_1
.L_HAL_RCC_MCOConfig_0:
.loc 1 29804
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 29807
.L_HAL_RCC_MCOConfig_5:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #48]
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
    MOVW r0, #14384
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
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #48]
    LDR r0, [r6, #48]
    PUSH {r0}
    POP {r0}
    LDR r0, [r6, #48]
    PUSH {r0}
    POP {r0}
.L_HAL_RCC_MCOConfig_7:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_RCC_MCOConfig_5
.L_HAL_RCC_MCOConfig_6:
.loc 1 29810
    ADD r0, r6, #24
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOVW r0, #512
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 29811
    ADD r0, r6, #24
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 29812
    ADD r0, r6, #24
    PUSH {r0}
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #3
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 29813
    ADD r0, r6, #24
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 29814
    ADD r0, r6, #24
    PUSH {r0}
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 29815
    ADD r0, r6, #24
    PUSH {r0}
    MOVW r0, #2048
    MOVT r0, #16386
    PUSH {r0}
    POP {r0}
    POP {r1}
    BL HAL_GPIO_Init
    PUSH {r0}
    POP {r0}
.loc 1 29818
    MOVW r0, #14344
    MOVT r0, #16386
    PUSH {r0}
    MOVW r0, #14344
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
    MOVT r0, #63488
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    MOV r0, #3
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
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
.L_HAL_RCC_MCOConfig_1:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #56
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_RCC_MCOConfig, .-HAL_RCC_MCOConfig

.global HAL_RCC_EnableCSS
.type HAL_RCC_EnableCSS, %function
HAL_RCC_EnableCSS:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 29818
.loc 1 29838
    MOVW r0, #76
    MOVT r0, #16967
    PUSH {r0}
    MOV r0, #1
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
.size HAL_RCC_EnableCSS, .-HAL_RCC_EnableCSS

.global HAL_RCC_DisableCSS
.type HAL_RCC_DisableCSS, %function
HAL_RCC_DisableCSS:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 29838
.loc 1 29847
    MOVW r0, #76
    MOVT r0, #16967
    PUSH {r0}
    MOV r0, #0
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
.size HAL_RCC_DisableCSS, .-HAL_RCC_DisableCSS

.global HAL_RCC_GetSysClockFreq
.weak HAL_RCC_GetSysClockFreq
.type HAL_RCC_GetSysClockFreq, %function
HAL_RCC_GetSysClockFreq:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #40
    MOV r6, sp
.loc 1 29847
.loc 1 29882
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
.loc 1 29883
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
.loc 1 29884
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
.loc 1 29885
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
.loc 1 29888
    MOVW r0, #14344
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
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #32]
    LDR r0, [r6, #32]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_RCC_GetSysClockFreq_1
    LDR r0, [r6, #32]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_RCC_GetSysClockFreq_2
    LDR r0, [r6, #32]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_RCC_GetSysClockFreq_3
    B .L_HAL_RCC_GetSysClockFreq_4
.loc 1 29890
.L_HAL_RCC_GetSysClockFreq_1:
.loc 1 29892
    MOVW r0, #9216
    MOVT r0, #244
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
.loc 1 29893
    B .L_HAL_RCC_GetSysClockFreq_0
.loc 1 29895
.L_HAL_RCC_GetSysClockFreq_2:
.loc 1 29897
    MOVW r0, #30784
    MOVT r0, #381
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
.loc 1 29898
    B .L_HAL_RCC_GetSysClockFreq_0
.loc 1 29900
.L_HAL_RCC_GetSysClockFreq_3:
.loc 1 29904
    MOVW r0, #14340
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
    MOV r0, #63
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
.loc 1 29905
    MOVW r0, #14340
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
    MOVT r0, #64
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_GetSysClockFreq_5
.loc 1 29908
    MOVW r0, #30784
    MOVT r0, #381
    PUSH {r0}
    POP {r0}
    PUSH {r0}
    PUSH {r0}
    MOV r0, #31
    PUSH {r0}
    POP {r1}
    POP {r0}
    ASR r0, r1
    PUSH {r0}
    MOVW r0, #14340
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
    MOVW r0, #32704
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #6
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r3}
    POP {r2}
    POP {r1}
    POP {r0}
    BL __aeabi_lmul
    PUSH {r0}
    PUSH {r1}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r3}
    POP {r2}
    POP {r1}
    POP {r0}
    BL __aeabi_uldivmod
    PUSH {r0}
    PUSH {r1}
    POP {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    B .L_HAL_RCC_GetSysClockFreq_6
.L_HAL_RCC_GetSysClockFreq_5:
.loc 1 29913
    MOVW r0, #9216
    MOVT r0, #244
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    MOVW r0, #14340
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
    MOVW r0, #32704
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #6
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r3}
    POP {r2}
    POP {r1}
    POP {r0}
    BL __aeabi_lmul
    PUSH {r0}
    PUSH {r1}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r3}
    POP {r2}
    POP {r1}
    POP {r0}
    BL __aeabi_uldivmod
    PUSH {r0}
    PUSH {r1}
    POP {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.L_HAL_RCC_GetSysClockFreq_6:
.loc 1 29915
    MOVW r0, #14340
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
    MOVT r0, #3
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
.loc 1 29917
    LDR r0, [r6, #8]
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r1}
    POP {r0}
    UDIV r0, r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
.loc 1 29918
    B .L_HAL_RCC_GetSysClockFreq_0
.loc 1 29920
.L_HAL_RCC_GetSysClockFreq_4:
.loc 1 29922
    MOVW r0, #9216
    MOVT r0, #244
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
.loc 1 29923
    B .L_HAL_RCC_GetSysClockFreq_0
.L_HAL_RCC_GetSysClockFreq_0:
.loc 1 29926
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #40
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_RCC_GetSysClockFreq, .-HAL_RCC_GetSysClockFreq

.global HAL_RCC_GetHCLKFreq
.type HAL_RCC_GetHCLKFreq, %function
HAL_RCC_GetHCLKFreq:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 29926
.loc 1 29940
    MOVW r0, #0
    MOVT r0, #8192
    LDR r0, [r0]
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_RCC_GetHCLKFreq, .-HAL_RCC_GetHCLKFreq

.global HAL_RCC_GetPCLK1Freq
.type HAL_RCC_GetPCLK1Freq, %function
HAL_RCC_GetPCLK1Freq:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 29940
.loc 1 29952
    BL HAL_RCC_GetHCLKFreq
    PUSH {r0}
    MOVW r0, #20
    MOVT r0, #8192
    PUSH {r0}
    MOVW r0, #14344
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
    MOVW r0, #7168
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #10
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    LDRB r0, [r0, #0]
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_RCC_GetPCLK1Freq, .-HAL_RCC_GetPCLK1Freq

.global HAL_RCC_GetPCLK2Freq
.type HAL_RCC_GetPCLK2Freq, %function
HAL_RCC_GetPCLK2Freq:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 29952
.loc 1 29964
    BL HAL_RCC_GetHCLKFreq
    PUSH {r0}
    MOVW r0, #20
    MOVT r0, #8192
    PUSH {r0}
    MOVW r0, #14344
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
    MOVW r0, #57344
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #13
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    LDRB r0, [r0, #0]
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_RCC_GetPCLK2Freq, .-HAL_RCC_GetPCLK2Freq

.global HAL_RCC_GetOscConfig
.weak HAL_RCC_GetOscConfig
.type HAL_RCC_GetOscConfig, %function
HAL_RCC_GetOscConfig:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 29964
    STR r0, [r6, #0]
.loc 1 29977
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #15
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 29980
    MOVW r0, #14336
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
    MOVT r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOVW r0, #0
    MOVT r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_GetOscConfig_0
.loc 1 29982
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOVW r0, #0
    MOVT r0, #5
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_HAL_RCC_GetOscConfig_1
.L_HAL_RCC_GetOscConfig_0:
.loc 1 29984
    MOVW r0, #14336
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
    MOVT r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOVW r0, #0
    MOVT r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_GetOscConfig_2
.loc 1 29986
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOVW r0, #0
    MOVT r0, #1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_HAL_RCC_GetOscConfig_3
.L_HAL_RCC_GetOscConfig_2:
.loc 1 29990
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_RCC_GetOscConfig_3:
.L_HAL_RCC_GetOscConfig_1:
.loc 1 29994
    MOVW r0, #14336
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
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_GetOscConfig_4
.loc 1 29996
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_HAL_RCC_GetOscConfig_5
.L_HAL_RCC_GetOscConfig_4:
.loc 1 30000
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_RCC_GetOscConfig_5:
.loc 1 30003
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOVW r0, #14336
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
    MOV r0, #248
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #3
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 30006
    MOVW r0, #14448
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
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_GetOscConfig_6
.loc 1 30008
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #5
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_HAL_RCC_GetOscConfig_7
.L_HAL_RCC_GetOscConfig_6:
.loc 1 30010
    MOVW r0, #14448
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
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_GetOscConfig_8
.loc 1 30012
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_HAL_RCC_GetOscConfig_9
.L_HAL_RCC_GetOscConfig_8:
.loc 1 30016
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_RCC_GetOscConfig_9:
.L_HAL_RCC_GetOscConfig_7:
.loc 1 30020
    MOVW r0, #14452
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
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_GetOscConfig_10
.loc 1 30022
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #20
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_HAL_RCC_GetOscConfig_11
.L_HAL_RCC_GetOscConfig_10:
.loc 1 30026
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #20
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_RCC_GetOscConfig_11:
.loc 1 30030
    MOVW r0, #14336
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
    MOVT r0, #256
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOVW r0, #0
    MOVT r0, #256
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_GetOscConfig_12
.loc 1 30032
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #24
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_HAL_RCC_GetOscConfig_13
.L_HAL_RCC_GetOscConfig_12:
.loc 1 30036
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #24
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_RCC_GetOscConfig_13:
.loc 1 30038
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #24
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOVW r0, #14340
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
    MOVT r0, #64
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 30039
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #24
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOVW r0, #14340
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
    MOV r0, #63
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 30040
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #24
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOVW r0, #14340
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
    MOVW r0, #32704
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #6
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 30041
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #24
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOVW r0, #14340
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
    MOVT r0, #3
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOVW r0, #0
    MOVT r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 30042
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #24
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #20
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOVW r0, #14340
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
    MOVT r0, #3840
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #24
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
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
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_RCC_GetOscConfig, .-HAL_RCC_GetOscConfig

.global HAL_RCC_GetClockConfig
.type HAL_RCC_GetClockConfig, %function
HAL_RCC_GetClockConfig:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #16
    MOV r6, sp
.loc 1 30042
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 30056
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #15
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 30059
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOVW r0, #14344
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
    MOV r0, #3
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 30062
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOVW r0, #14344
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
    MOV r0, #240
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 30065
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOVW r0, #14344
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
    MOVW r0, #7168
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 30068
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOVW r0, #14344
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
    MOVW r0, #57344
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #3
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 30071
    LDR r0, [r6, #8]
    PUSH {r0}
    MOVW r0, #15360
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
    MOV r0, #7
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
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
    ADD sp, sp, #16
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_RCC_GetClockConfig, .-HAL_RCC_GetClockConfig

.global HAL_RCC_NMI_IRQHandler
.type HAL_RCC_NMI_IRQHandler, %function
HAL_RCC_NMI_IRQHandler:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 30071
.loc 1 30082
    MOVW r0, #14348
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
    MOV r0, #128
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #128
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_NMI_IRQHandler_0
.loc 1 30085
    BL HAL_RCC_CSSCallback
    PUSH {r0}
    POP {r0}
.loc 1 30088
    MOVW r0, #14350
    MOVT r0, #16386
    PUSH {r0}
    MOV r0, #128
    PUSH {r0}
    POP {r0}
    POP {r1}
    STRB r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_HAL_RCC_NMI_IRQHandler_1
.L_HAL_RCC_NMI_IRQHandler_0:
.L_HAL_RCC_NMI_IRQHandler_1:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_RCC_NMI_IRQHandler, .-HAL_RCC_NMI_IRQHandler

.global HAL_RCC_CSSCallback
.weak HAL_RCC_CSSCallback
.type HAL_RCC_CSSCallback, %function
HAL_RCC_CSSCallback:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 30088
.loc 1 30097
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_RCC_CSSCallback, .-HAL_RCC_CSSCallback

.global HAL_RCCEx_PeriphCLKConfig
.type HAL_RCCEx_PeriphCLKConfig, %function
HAL_RCCEx_PeriphCLKConfig:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #32
    MOV r6, sp
.loc 1 30097
    STR r0, [r6, #0]
.loc 1 30328
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
.loc 1 30329
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
.loc 1 30332
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 30335
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_RCCEx_PeriphCLKConfig_2
.loc 1 30336
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    AND r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    B .L_HAL_RCCEx_PeriphCLKConfig_3
.L_HAL_RCCEx_PeriphCLKConfig_2:
    MOV r0, #1
    PUSH {r0}
.L_HAL_RCCEx_PeriphCLKConfig_3:
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCCEx_PeriphCLKConfig_0
.loc 1 30339
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 30340
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 30344
    MOVW r0, #104
    MOVT r0, #16967
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 30346
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 30348
.L_HAL_RCCEx_PeriphCLKConfig_4:
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCCEx_PeriphCLKConfig_8
    MOVW r0, #14336
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
    B .L_HAL_RCCEx_PeriphCLKConfig_9
.L_HAL_RCCEx_PeriphCLKConfig_8:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCCEx_PeriphCLKConfig_10
    MOVW r0, #14448
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
    B .L_HAL_RCCEx_PeriphCLKConfig_11
.L_HAL_RCCEx_PeriphCLKConfig_10:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCCEx_PeriphCLKConfig_12
    MOVW r0, #14452
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
    B .L_HAL_RCCEx_PeriphCLKConfig_13
.L_HAL_RCCEx_PeriphCLKConfig_12:
    MOVW r0, #14348
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
.L_HAL_RCCEx_PeriphCLKConfig_13:
.L_HAL_RCCEx_PeriphCLKConfig_11:
.L_HAL_RCCEx_PeriphCLKConfig_9:
    MOVW r0, #0
    MOVT r0, #2048
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCCEx_PeriphCLKConfig_6
    MOV r0, #1
    PUSH {r0}
    B .L_HAL_RCCEx_PeriphCLKConfig_7
.L_HAL_RCCEx_PeriphCLKConfig_6:
    MOV r0, #0
    PUSH {r0}
.L_HAL_RCCEx_PeriphCLKConfig_7:
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCCEx_PeriphCLKConfig_5
.loc 1 30350
    BL HAL_GetTick
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCCEx_PeriphCLKConfig_14
.loc 1 30353
    MOV r0, #3
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #32
    POP {r5, r6, r7, pc}
.L_HAL_RCCEx_PeriphCLKConfig_14:
.L_HAL_RCCEx_PeriphCLKConfig_15:
    B .L_HAL_RCCEx_PeriphCLKConfig_4
.L_HAL_RCCEx_PeriphCLKConfig_5:
.loc 1 30362
    MOVW r0, #14468
    MOVT r0, #16386
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #6
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #28
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
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
.loc 1 30366
    MOVW r0, #104
    MOVT r0, #16967
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 30368
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 30370
.L_HAL_RCCEx_PeriphCLKConfig_16:
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCCEx_PeriphCLKConfig_20
    MOVW r0, #14336
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
    B .L_HAL_RCCEx_PeriphCLKConfig_21
.L_HAL_RCCEx_PeriphCLKConfig_20:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCCEx_PeriphCLKConfig_22
    MOVW r0, #14448
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
    B .L_HAL_RCCEx_PeriphCLKConfig_23
.L_HAL_RCCEx_PeriphCLKConfig_22:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCCEx_PeriphCLKConfig_24
    MOVW r0, #14452
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
    B .L_HAL_RCCEx_PeriphCLKConfig_25
.L_HAL_RCCEx_PeriphCLKConfig_24:
    MOVW r0, #14348
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
.L_HAL_RCCEx_PeriphCLKConfig_25:
.L_HAL_RCCEx_PeriphCLKConfig_23:
.L_HAL_RCCEx_PeriphCLKConfig_21:
    MOVW r0, #0
    MOVT r0, #2048
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCCEx_PeriphCLKConfig_18
    MOV r0, #1
    PUSH {r0}
    B .L_HAL_RCCEx_PeriphCLKConfig_19
.L_HAL_RCCEx_PeriphCLKConfig_18:
    MOV r0, #0
    PUSH {r0}
.L_HAL_RCCEx_PeriphCLKConfig_19:
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCCEx_PeriphCLKConfig_17
.loc 1 30372
    BL HAL_GetTick
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCCEx_PeriphCLKConfig_26
.loc 1 30375
    MOV r0, #3
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #32
    POP {r5, r6, r7, pc}
.L_HAL_RCCEx_PeriphCLKConfig_26:
.L_HAL_RCCEx_PeriphCLKConfig_27:
    B .L_HAL_RCCEx_PeriphCLKConfig_16
.L_HAL_RCCEx_PeriphCLKConfig_17:
    B .L_HAL_RCCEx_PeriphCLKConfig_1
.L_HAL_RCCEx_PeriphCLKConfig_0:
.L_HAL_RCCEx_PeriphCLKConfig_1:
.loc 1 30381
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    AND r0, r1
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCCEx_PeriphCLKConfig_28
.loc 1 30384
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 30387
.L_HAL_RCCEx_PeriphCLKConfig_30:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
    MOVW r0, #14400
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
    MOVW r0, #0
    MOVT r0, #4096
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
    MOVW r0, #14400
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
    MOVT r0, #4096
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
.L_HAL_RCCEx_PeriphCLKConfig_32:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_RCCEx_PeriphCLKConfig_30
.L_HAL_RCCEx_PeriphCLKConfig_31:
.loc 1 30390
    MOVW r0, #28672
    MOVT r0, #16384
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
    MOVW r0, #256
    MOVT r0, #0
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
.loc 1 30393
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 30395
.L_HAL_RCCEx_PeriphCLKConfig_33:
    MOVW r0, #28672
    MOVT r0, #16384
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
    MOVW r0, #256
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCCEx_PeriphCLKConfig_34
.loc 1 30397
    BL HAL_GetTick
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCCEx_PeriphCLKConfig_35
.loc 1 30399
    MOV r0, #3
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #32
    POP {r5, r6, r7, pc}
.L_HAL_RCCEx_PeriphCLKConfig_35:
.L_HAL_RCCEx_PeriphCLKConfig_36:
    B .L_HAL_RCCEx_PeriphCLKConfig_33
.L_HAL_RCCEx_PeriphCLKConfig_34:
.loc 1 30403
    MOVW r0, #14448
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
    MOVW r0, #768
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
.loc 1 30404
    LDR r0, [r6, #16]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCCEx_PeriphCLKConfig_39
    LDR r0, [r6, #16]
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #768
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    B .L_HAL_RCCEx_PeriphCLKConfig_40
.L_HAL_RCCEx_PeriphCLKConfig_39:
    MOV r0, #0
    PUSH {r0}
.L_HAL_RCCEx_PeriphCLKConfig_40:
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCCEx_PeriphCLKConfig_37
.loc 1 30407
    MOVW r0, #14448
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
    MOVW r0, #768
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
.loc 1 30409
    MOVW r0, #3648
    MOVT r0, #16967
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 30410
    MOVW r0, #3648
    MOVT r0, #16967
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 30412
    MOVW r0, #14448
    MOVT r0, #16386
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 30415
    MOVW r0, #14448
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
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCCEx_PeriphCLKConfig_41
.loc 1 30418
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 30421
.L_HAL_RCCEx_PeriphCLKConfig_43:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCCEx_PeriphCLKConfig_47
    MOVW r0, #14336
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
    B .L_HAL_RCCEx_PeriphCLKConfig_48
.L_HAL_RCCEx_PeriphCLKConfig_47:
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCCEx_PeriphCLKConfig_49
    MOVW r0, #14448
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
    B .L_HAL_RCCEx_PeriphCLKConfig_50
.L_HAL_RCCEx_PeriphCLKConfig_49:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCCEx_PeriphCLKConfig_51
    MOVW r0, #14452
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
    B .L_HAL_RCCEx_PeriphCLKConfig_52
.L_HAL_RCCEx_PeriphCLKConfig_51:
    MOVW r0, #14348
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
.L_HAL_RCCEx_PeriphCLKConfig_52:
.L_HAL_RCCEx_PeriphCLKConfig_50:
.L_HAL_RCCEx_PeriphCLKConfig_48:
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCCEx_PeriphCLKConfig_45
    MOV r0, #1
    PUSH {r0}
    B .L_HAL_RCCEx_PeriphCLKConfig_46
.L_HAL_RCCEx_PeriphCLKConfig_45:
    MOV r0, #0
    PUSH {r0}
.L_HAL_RCCEx_PeriphCLKConfig_46:
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCCEx_PeriphCLKConfig_44
.loc 1 30423
    BL HAL_GetTick
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    MOVW r0, #5000
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCCEx_PeriphCLKConfig_53
.loc 1 30425
    MOV r0, #3
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #32
    POP {r5, r6, r7, pc}
.L_HAL_RCCEx_PeriphCLKConfig_53:
.L_HAL_RCCEx_PeriphCLKConfig_54:
    B .L_HAL_RCCEx_PeriphCLKConfig_43
.L_HAL_RCCEx_PeriphCLKConfig_44:
    B .L_HAL_RCCEx_PeriphCLKConfig_42
.L_HAL_RCCEx_PeriphCLKConfig_41:
.L_HAL_RCCEx_PeriphCLKConfig_42:
    B .L_HAL_RCCEx_PeriphCLKConfig_38
.L_HAL_RCCEx_PeriphCLKConfig_37:
.L_HAL_RCCEx_PeriphCLKConfig_38:
.loc 1 30430
.L_HAL_RCCEx_PeriphCLKConfig_55:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #768
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOVW r0, #768
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCCEx_PeriphCLKConfig_58
    MOVW r0, #14344
    MOVT r0, #16386
    PUSH {r0}
    MOVW r0, #14344
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
    MOVT r0, #31
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #64767
    MOVT r0, #4095
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    B .L_HAL_RCCEx_PeriphCLKConfig_59
.L_HAL_RCCEx_PeriphCLKConfig_58:
    MOVW r0, #14344
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
    MOVW r0, #0
    MOVT r0, #31
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
.L_HAL_RCCEx_PeriphCLKConfig_59:
    POP {r0}
    MOVW r0, #14448
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
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #4095
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
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
.L_HAL_RCCEx_PeriphCLKConfig_57:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_RCCEx_PeriphCLKConfig_55
.L_HAL_RCCEx_PeriphCLKConfig_56:
    B .L_HAL_RCCEx_PeriphCLKConfig_29
.L_HAL_RCCEx_PeriphCLKConfig_28:
.L_HAL_RCCEx_PeriphCLKConfig_29:
.loc 1 30434
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCCEx_PeriphCLKConfig_60
.loc 1 30436
    MOVW r0, #4576
    MOVT r0, #16967
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    LDRB r0, [r0, #0]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_HAL_RCCEx_PeriphCLKConfig_61
.L_HAL_RCCEx_PeriphCLKConfig_60:
.L_HAL_RCCEx_PeriphCLKConfig_61:
.loc 1 30439
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #32
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_RCCEx_PeriphCLKConfig, .-HAL_RCCEx_PeriphCLKConfig

.global HAL_RCCEx_GetPeriphCLKConfig
.type HAL_RCCEx_GetPeriphCLKConfig, %function
HAL_RCCEx_GetPeriphCLKConfig:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #16
    MOV r6, sp
.loc 1 30439
    STR r0, [r6, #0]
.loc 1 30454
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #3
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 30457
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOVW r0, #14468
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
    MOVW r0, #32704
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #6
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 30458
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOVW r0, #14468
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
    MOVT r0, #28672
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #28
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 30462
    MOVW r0, #14344
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
    MOVT r0, #31
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 30463
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    MOVW r0, #14448
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
    MOVW r0, #768
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
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
.loc 1 30467
    MOVW r0, #14476
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
    MOVT r0, #256
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCCEx_GetPeriphCLKConfig_0
.loc 1 30469
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STRB r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_HAL_RCCEx_GetPeriphCLKConfig_1
.L_HAL_RCCEx_GetPeriphCLKConfig_0:
.loc 1 30473
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STRB r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_RCCEx_GetPeriphCLKConfig_1:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #16
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_RCCEx_GetPeriphCLKConfig, .-HAL_RCCEx_GetPeriphCLKConfig

.global HAL_RCCEx_GetPeriphCLKFreq
.type HAL_RCCEx_GetPeriphCLKFreq, %function
HAL_RCCEx_GetPeriphCLKFreq:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #56
    MOV r6, sp
.loc 1 30473
    STR r0, [r6, #0]
.loc 1 30489
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
.loc 1 30491
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
.loc 1 30492
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
.loc 1 30494
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #32]
.loc 1 30495
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #40]
    LDR r0, [r6, #40]
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_RCCEx_GetPeriphCLKFreq_1
    B .L_HAL_RCCEx_GetPeriphCLKFreq_2
.loc 1 30497
.L_HAL_RCCEx_GetPeriphCLKFreq_1:
.loc 1 30500
    MOVW r0, #14344
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
    MOVT r0, #128
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
.loc 1 30501
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #48]
    LDR r0, [r6, #48]
    PUSH {r0}
    MOVW r0, #0
    MOVT r0, #128
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_RCCEx_GetPeriphCLKFreq_4
    LDR r0, [r6, #48]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_RCCEx_GetPeriphCLKFreq_5
    B .L_HAL_RCCEx_GetPeriphCLKFreq_6
.loc 1 30504
.L_HAL_RCCEx_GetPeriphCLKFreq_4:
.loc 1 30507
    MOVW r0, #32768
    MOVT r0, #187
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 30508
    B .L_HAL_RCCEx_GetPeriphCLKFreq_3
.loc 1 30511
.L_HAL_RCCEx_GetPeriphCLKFreq_5:
.loc 1 30517
    MOVW r0, #14340
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
    MOVT r0, #64
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOVW r0, #0
    MOVT r0, #64
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCCEx_GetPeriphCLKFreq_7
.loc 1 30520
    MOVW r0, #30784
    MOVT r0, #381
    PUSH {r0}
    MOVW r0, #14340
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
    MOV r0, #63
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    UDIV r0, r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
    B .L_HAL_RCCEx_GetPeriphCLKFreq_8
.L_HAL_RCCEx_GetPeriphCLKFreq_7:
.loc 1 30525
    MOVW r0, #9216
    MOVT r0, #244
    PUSH {r0}
    MOVW r0, #14340
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
    MOV r0, #63
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    UDIV r0, r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
.L_HAL_RCCEx_GetPeriphCLKFreq_8:
.loc 1 30529
    LDR r0, [r6, #16]
    PUSH {r0}
    MOVW r0, #14468
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
    MOVW r0, #32704
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #6
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    MOVW r0, #511
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #32]
    LDR r0, [r6, #32]
    PUSH {r0}
    POP {r0}
.loc 1 30531
    LDR r0, [r6, #32]
    PUSH {r0}
    MOVW r0, #14468
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
    MOVT r0, #28672
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #28
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    MOV r0, #7
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    UDIV r0, r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 30532
    B .L_HAL_RCCEx_GetPeriphCLKFreq_3
.loc 1 30535
.L_HAL_RCCEx_GetPeriphCLKFreq_6:
.loc 1 30537
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 30538
    B .L_HAL_RCCEx_GetPeriphCLKFreq_3
.L_HAL_RCCEx_GetPeriphCLKFreq_3:
.loc 1 30541
    B .L_HAL_RCCEx_GetPeriphCLKFreq_0
.loc 1 30543
.L_HAL_RCCEx_GetPeriphCLKFreq_2:
.loc 1 30545
    B .L_HAL_RCCEx_GetPeriphCLKFreq_0
.L_HAL_RCCEx_GetPeriphCLKFreq_0:
.loc 1 30548
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #56
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_RCCEx_GetPeriphCLKFreq, .-HAL_RCCEx_GetPeriphCLKFreq

.global HAL_RCCEx_EnablePLLI2S
.type HAL_RCCEx_EnablePLLI2S, %function
HAL_RCCEx_EnablePLLI2S:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #16
    MOV r6, sp
.loc 1 30548
    STR r0, [r6, #0]
.loc 1 30581
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 30582
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 30591
    MOVW r0, #104
    MOVT r0, #16967
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 30594
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 30595
.L_HAL_RCCEx_EnablePLLI2S_0:
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCCEx_EnablePLLI2S_4
    MOVW r0, #14336
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
    B .L_HAL_RCCEx_EnablePLLI2S_5
.L_HAL_RCCEx_EnablePLLI2S_4:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCCEx_EnablePLLI2S_6
    MOVW r0, #14448
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
    B .L_HAL_RCCEx_EnablePLLI2S_7
.L_HAL_RCCEx_EnablePLLI2S_6:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCCEx_EnablePLLI2S_8
    MOVW r0, #14452
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
    B .L_HAL_RCCEx_EnablePLLI2S_9
.L_HAL_RCCEx_EnablePLLI2S_8:
    MOVW r0, #14348
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
.L_HAL_RCCEx_EnablePLLI2S_9:
.L_HAL_RCCEx_EnablePLLI2S_7:
.L_HAL_RCCEx_EnablePLLI2S_5:
    MOVW r0, #0
    MOVT r0, #2048
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCCEx_EnablePLLI2S_2
    MOV r0, #1
    PUSH {r0}
    B .L_HAL_RCCEx_EnablePLLI2S_3
.L_HAL_RCCEx_EnablePLLI2S_2:
    MOV r0, #0
    PUSH {r0}
.L_HAL_RCCEx_EnablePLLI2S_3:
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCCEx_EnablePLLI2S_1
.loc 1 30597
    BL HAL_GetTick
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCCEx_EnablePLLI2S_10
.loc 1 30600
    MOV r0, #3
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #16
    POP {r5, r6, r7, pc}
.L_HAL_RCCEx_EnablePLLI2S_10:
.L_HAL_RCCEx_EnablePLLI2S_11:
    B .L_HAL_RCCEx_EnablePLLI2S_0
.L_HAL_RCCEx_EnablePLLI2S_1:
.loc 1 30612
    MOVW r0, #14468
    MOVT r0, #16386
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #6
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #28
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
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
.loc 1 30616
    MOVW r0, #104
    MOVT r0, #16967
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 30619
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 30620
.L_HAL_RCCEx_EnablePLLI2S_12:
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCCEx_EnablePLLI2S_16
    MOVW r0, #14336
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
    B .L_HAL_RCCEx_EnablePLLI2S_17
.L_HAL_RCCEx_EnablePLLI2S_16:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCCEx_EnablePLLI2S_18
    MOVW r0, #14448
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
    B .L_HAL_RCCEx_EnablePLLI2S_19
.L_HAL_RCCEx_EnablePLLI2S_18:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCCEx_EnablePLLI2S_20
    MOVW r0, #14452
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
    B .L_HAL_RCCEx_EnablePLLI2S_21
.L_HAL_RCCEx_EnablePLLI2S_20:
    MOVW r0, #14348
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
.L_HAL_RCCEx_EnablePLLI2S_21:
.L_HAL_RCCEx_EnablePLLI2S_19:
.L_HAL_RCCEx_EnablePLLI2S_17:
    MOVW r0, #0
    MOVT r0, #2048
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCCEx_EnablePLLI2S_14
    MOV r0, #1
    PUSH {r0}
    B .L_HAL_RCCEx_EnablePLLI2S_15
.L_HAL_RCCEx_EnablePLLI2S_14:
    MOV r0, #0
    PUSH {r0}
.L_HAL_RCCEx_EnablePLLI2S_15:
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCCEx_EnablePLLI2S_13
.loc 1 30622
    BL HAL_GetTick
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCCEx_EnablePLLI2S_22
.loc 1 30625
    MOV r0, #3
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #16
    POP {r5, r6, r7, pc}
.L_HAL_RCCEx_EnablePLLI2S_22:
.L_HAL_RCCEx_EnablePLLI2S_23:
    B .L_HAL_RCCEx_EnablePLLI2S_12
.L_HAL_RCCEx_EnablePLLI2S_13:
.loc 1 30629
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #16
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_RCCEx_EnablePLLI2S, .-HAL_RCCEx_EnablePLLI2S

.global HAL_RCCEx_DisablePLLI2S
.type HAL_RCCEx_DisablePLLI2S, %function
HAL_RCCEx_DisablePLLI2S:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 30629
.loc 1 30641
    MOVW r0, #104
    MOVT r0, #16967
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 30644
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
.loc 1 30645
.L_HAL_RCCEx_DisablePLLI2S_0:
    MOVW r0, #14336
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
    MOVT r0, #2048
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCCEx_DisablePLLI2S_1
.loc 1 30647
    BL HAL_GetTick
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCCEx_DisablePLLI2S_2
.loc 1 30650
    MOV r0, #3
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
.L_HAL_RCCEx_DisablePLLI2S_2:
.L_HAL_RCCEx_DisablePLLI2S_3:
    B .L_HAL_RCCEx_DisablePLLI2S_0
.L_HAL_RCCEx_DisablePLLI2S_1:
.loc 1 30654
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_RCCEx_DisablePLLI2S, .-HAL_RCCEx_DisablePLLI2S

.global HAL_RCC_DeInit
.type HAL_RCC_DeInit, %function
HAL_RCC_DeInit:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 30654
.loc 1 30705
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
.loc 1 30708
    MOVW r0, #14336
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
    MOV r0, #1
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
.loc 1 30711
.L_HAL_RCC_DeInit_0:
    MOVW r0, #14336
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
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_DeInit_1
.loc 1 30713
    BL HAL_GetTick
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_DeInit_2
.loc 1 30715
    MOV r0, #3
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
.L_HAL_RCC_DeInit_2:
.L_HAL_RCC_DeInit_3:
    B .L_HAL_RCC_DeInit_0
.L_HAL_RCC_DeInit_1:
.loc 1 30720
    MOVW r0, #14336
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
    MOV r0, #128
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
.loc 1 30723
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
.loc 1 30726
    MOVW r0, #14344
    MOVT r0, #16386
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 30729
.L_HAL_RCC_DeInit_4:
    MOVW r0, #14344
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
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_DeInit_5
.loc 1 30731
    BL HAL_GetTick
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    MOVW r0, #5000
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_DeInit_6
.loc 1 30733
    MOV r0, #3
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
.L_HAL_RCC_DeInit_6:
.L_HAL_RCC_DeInit_7:
    B .L_HAL_RCC_DeInit_4
.L_HAL_RCC_DeInit_5:
.loc 1 30738
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
.loc 1 30741
    MOVW r0, #14336
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
    MOVW r0, #0
    MOVT r0, #13
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 30744
.L_HAL_RCC_DeInit_8:
    MOVW r0, #14336
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
    MOVT r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_DeInit_9
.loc 1 30746
    BL HAL_GetTick
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    MOV r0, #100
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_DeInit_10
.loc 1 30748
    MOV r0, #3
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
.L_HAL_RCC_DeInit_10:
.L_HAL_RCC_DeInit_11:
    B .L_HAL_RCC_DeInit_8
.L_HAL_RCC_DeInit_9:
.loc 1 30753
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
.loc 1 30756
    MOVW r0, #14336
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
    MOVW r0, #0
    MOVT r0, #256
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 30759
.L_HAL_RCC_DeInit_12:
    MOVW r0, #14336
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
    MOVT r0, #512
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_DeInit_13
.loc 1 30761
    BL HAL_GetTick
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_DeInit_14
.loc 1 30763
    MOV r0, #3
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
.L_HAL_RCC_DeInit_14:
.L_HAL_RCC_DeInit_15:
    B .L_HAL_RCC_DeInit_12
.L_HAL_RCC_DeInit_13:
.loc 1 30769
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
.loc 1 30772
    MOVW r0, #14336
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
    MOVW r0, #0
    MOVT r0, #1024
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 30775
.L_HAL_RCC_DeInit_16:
    MOVW r0, #14336
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
    MOVT r0, #2048
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_DeInit_17
.loc 1 30777
    BL HAL_GetTick
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_DeInit_18
.loc 1 30779
    MOV r0, #3
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
.L_HAL_RCC_DeInit_18:
.L_HAL_RCC_DeInit_19:
    B .L_HAL_RCC_DeInit_16
.L_HAL_RCC_DeInit_17:
.loc 1 30791
    MOVW r0, #14340
    MOVT r0, #16386
    PUSH {r0}
    MOVW r0, #12304
    MOVT r0, #1024
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 30797
    MOVW r0, #14468
    MOVT r0, #16386
    PUSH {r0}
    MOVW r0, #12288
    MOVT r0, #8192
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 30808
    MOVW r0, #14348
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
    MOVW r0, #7936
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 30811
    MOVW r0, #14348
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
    MOVW r0, #8192
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 30818
    MOVW r0, #14348
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
    MOVW r0, #0
    MOVT r0, #159
    PUSH {r0}
.loc 1 30819
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 30822
    MOVW r0, #14348
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
    MOVW r0, #0
    MOVT r0, #32
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
.loc 1 30829
    MOVW r0, #14452
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
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 30832
    MOVW r0, #14452
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
    MOVW r0, #0
    MOVT r0, #256
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
.loc 1 30835
    MOVW r0, #9216
    MOVT r0, #244
    PUSH {r0}
    POP {r0}
    PUSH {r0}
    PUSH {r0}
    POP {r0}
    MOVW r1, #0
    MOVT r1, #8192
    STR r0, [r1]
    POP {r0}
.loc 1 30838
    MOVW r0, #28
    MOVT r0, #8192
    LDR r0, [r0]
    PUSH {r0}
    POP {r0}
    BL HAL_InitTick
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_RCC_DeInit_20
.loc 1 30840
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
.L_HAL_RCC_DeInit_20:
.loc 1 30844
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
.L_HAL_RCC_DeInit_21:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_RCC_DeInit, .-HAL_RCC_DeInit

.global HAL_GPIO_Init
.type HAL_GPIO_Init, %function
HAL_GPIO_Init:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #56
    MOV r6, sp
.loc 1 30844
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 31127
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
.loc 1 31128
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #32]
.loc 1 31129
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #40]
.loc 1 31132
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 31133
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 31134
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 31137
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
.L_HAL_GPIO_Init_0:
    LDR r0, [r6, #16]
    PUSH {r0}
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE LO
    MOVLO r0, #1
    MOVHS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_GPIO_Init_1
.loc 1 31140
    MOV r0, #1
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
.loc 1 31142
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #32]
    LDR r0, [r6, #32]
    PUSH {r0}
    POP {r0}
.loc 1 31144
    LDR r0, [r6, #32]
    PUSH {r0}
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_GPIO_Init_3
.loc 1 31148
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #3
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_GPIO_Init_7
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #3
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    B .L_HAL_GPIO_Init_8
.L_HAL_GPIO_Init_7:
    MOV r0, #1
    PUSH {r0}
.L_HAL_GPIO_Init_8:
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_GPIO_Init_5
.loc 1 31151
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 31153
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    STR r0, [r6, #40]
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
.loc 1 31154
    LDR r0, [r6, #40]
    PUSH {r0}
    MOV r0, #3
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #40]
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
.loc 1 31155
    LDR r0, [r6, #40]
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    LDR r0, [r6, #16]
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #40]
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
.loc 1 31156
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 31159
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    STR r0, [r6, #40]
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
.loc 1 31160
    LDR r0, [r6, #40]
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #40]
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
.loc 1 31161
    LDR r0, [r6, #40]
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #40]
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
.loc 1 31162
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_HAL_GPIO_Init_6
.L_HAL_GPIO_Init_5:
.L_HAL_GPIO_Init_6:
.loc 1 31165
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #3
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #3
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_GPIO_Init_9
.loc 1 31168
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 31171
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    STR r0, [r6, #40]
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
.loc 1 31172
    LDR r0, [r6, #40]
    PUSH {r0}
    MOV r0, #3
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #40]
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
.loc 1 31173
    LDR r0, [r6, #40]
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    LDR r0, [r6, #16]
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #40]
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
.loc 1 31174
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_HAL_GPIO_Init_10
.L_HAL_GPIO_Init_9:
.L_HAL_GPIO_Init_10:
.loc 1 31178
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #3
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_GPIO_Init_11
.loc 1 31181
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 31183
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #32
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    MOV r0, #3
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    STR r0, [r6, #40]
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
.loc 1 31184
    LDR r0, [r6, #40]
    PUSH {r0}
    MOV r0, #15
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    MOV r0, #7
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #40]
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
.loc 1 31185
    LDR r0, [r6, #40]
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    LDR r0, [r6, #16]
    PUSH {r0}
    MOV r0, #7
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #40]
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
.loc 1 31186
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #32
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    MOV r0, #3
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_HAL_GPIO_Init_12
.L_HAL_GPIO_Init_11:
.L_HAL_GPIO_Init_12:
.loc 1 31190
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    STR r0, [r6, #40]
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
.loc 1 31191
    LDR r0, [r6, #40]
    PUSH {r0}
    MOV r0, #3
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #40]
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
.loc 1 31192
    LDR r0, [r6, #40]
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #3
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #40]
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
.loc 1 31193
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 31197
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVT r0, #3
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_GPIO_Init_13
.loc 1 31200
.L_HAL_GPIO_Init_15:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #48]
    MOVW r0, #14404
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
    MOVW r0, #16384
    MOVT r0, #0
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
    MOVW r0, #14404
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
    MOVW r0, #16384
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #48]
    LDR r0, [r6, #48]
    PUSH {r0}
    POP {r0}
    LDR r0, [r6, #48]
    PUSH {r0}
    POP {r0}
.L_HAL_GPIO_Init_17:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_GPIO_Init_15
.L_HAL_GPIO_Init_16:
.loc 1 31202
    MOVW r0, #14344
    MOVT r0, #16385
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    STR r0, [r6, #40]
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
.loc 1 31203
    LDR r0, [r6, #40]
    PUSH {r0}
    MOV r0, #15
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    MOV r0, #3
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #40]
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
.loc 1 31204
    LDR r0, [r6, #40]
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOVW r0, #0
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_GPIO_Init_18
    MOV r0, #0
    PUSH {r0}
    B .L_HAL_GPIO_Init_19
.L_HAL_GPIO_Init_18:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOVW r0, #1024
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_GPIO_Init_20
    MOV r0, #1
    PUSH {r0}
    B .L_HAL_GPIO_Init_21
.L_HAL_GPIO_Init_20:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOVW r0, #2048
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_GPIO_Init_22
    MOV r0, #2
    PUSH {r0}
    B .L_HAL_GPIO_Init_23
.L_HAL_GPIO_Init_22:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOVW r0, #3072
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_GPIO_Init_24
    MOV r0, #3
    PUSH {r0}
    B .L_HAL_GPIO_Init_25
.L_HAL_GPIO_Init_24:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOVW r0, #4096
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_GPIO_Init_26
    MOV r0, #4
    PUSH {r0}
    B .L_HAL_GPIO_Init_27
.L_HAL_GPIO_Init_26:
    MOV r0, #7
    PUSH {r0}
.L_HAL_GPIO_Init_27:
.L_HAL_GPIO_Init_25:
.L_HAL_GPIO_Init_23:
.L_HAL_GPIO_Init_21:
.L_HAL_GPIO_Init_19:
    MOV r0, #4
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    MOV r0, #3
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #40]
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
.loc 1 31205
    MOVW r0, #14344
    MOVT r0, #16385
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 31208
    MOVW r0, #15368
    MOVT r0, #16385
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
    POP {r0}
    STR r0, [r6, #40]
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
.loc 1 31209
    LDR r0, [r6, #40]
    PUSH {r0}
    LDR r0, [r6, #32]
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #40]
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
.loc 1 31210
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVT r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_GPIO_Init_28
.loc 1 31212
    LDR r0, [r6, #40]
    PUSH {r0}
    LDR r0, [r6, #32]
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #40]
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
    B .L_HAL_GPIO_Init_29
.L_HAL_GPIO_Init_28:
.L_HAL_GPIO_Init_29:
.loc 1 31214
    MOVW r0, #15368
    MOVT r0, #16385
    PUSH {r0}
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 31216
    MOVW r0, #15372
    MOVT r0, #16385
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
    POP {r0}
    STR r0, [r6, #40]
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
.loc 1 31217
    LDR r0, [r6, #40]
    PUSH {r0}
    LDR r0, [r6, #32]
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #40]
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
.loc 1 31218
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVT r0, #32
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_GPIO_Init_30
.loc 1 31220
    LDR r0, [r6, #40]
    PUSH {r0}
    LDR r0, [r6, #32]
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #40]
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
    B .L_HAL_GPIO_Init_31
.L_HAL_GPIO_Init_30:
.L_HAL_GPIO_Init_31:
.loc 1 31222
    MOVW r0, #15372
    MOVT r0, #16385
    PUSH {r0}
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 31224
    MOVW r0, #15364
    MOVT r0, #16385
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
    POP {r0}
    STR r0, [r6, #40]
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
.loc 1 31225
    LDR r0, [r6, #40]
    PUSH {r0}
    LDR r0, [r6, #32]
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #40]
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
.loc 1 31226
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVT r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_GPIO_Init_32
.loc 1 31228
    LDR r0, [r6, #40]
    PUSH {r0}
    LDR r0, [r6, #32]
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #40]
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
    B .L_HAL_GPIO_Init_33
.L_HAL_GPIO_Init_32:
.L_HAL_GPIO_Init_33:
.loc 1 31230
    MOVW r0, #15364
    MOVT r0, #16385
    PUSH {r0}
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 31233
    MOVW r0, #15360
    MOVT r0, #16385
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
    POP {r0}
    STR r0, [r6, #40]
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
.loc 1 31234
    LDR r0, [r6, #40]
    PUSH {r0}
    LDR r0, [r6, #32]
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #40]
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
.loc 1 31235
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVT r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_GPIO_Init_34
.loc 1 31237
    LDR r0, [r6, #40]
    PUSH {r0}
    LDR r0, [r6, #32]
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #40]
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
    B .L_HAL_GPIO_Init_35
.L_HAL_GPIO_Init_34:
.L_HAL_GPIO_Init_35:
.loc 1 31239
    MOVW r0, #15360
    MOVT r0, #16385
    PUSH {r0}
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_HAL_GPIO_Init_14
.L_HAL_GPIO_Init_13:
.L_HAL_GPIO_Init_14:
    B .L_HAL_GPIO_Init_4
.L_HAL_GPIO_Init_3:
.L_HAL_GPIO_Init_4:
.L_HAL_GPIO_Init_2:
.loc 1 31137
    LDR r0, [r6, #16]
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    POP {r0}
    B .L_HAL_GPIO_Init_0
.L_HAL_GPIO_Init_1:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #56
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_GPIO_Init, .-HAL_GPIO_Init

.global HAL_GPIO_DeInit
.type HAL_GPIO_DeInit, %function
HAL_GPIO_DeInit:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #48
    MOV r6, sp
.loc 1 31137
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 31256
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
.loc 1 31257
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #32]
.loc 1 31258
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #40]
.loc 1 31261
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 31264
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
.L_HAL_GPIO_DeInit_0:
    LDR r0, [r6, #16]
    PUSH {r0}
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE LO
    MOVLO r0, #1
    MOVHS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_GPIO_DeInit_1
.loc 1 31267
    MOV r0, #1
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
.loc 1 31269
    LDR r0, [r6, #8]
    PUSH {r0}
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #32]
    LDR r0, [r6, #32]
    PUSH {r0}
    POP {r0}
.loc 1 31271
    LDR r0, [r6, #32]
    PUSH {r0}
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_GPIO_DeInit_3
.loc 1 31274
    MOVW r0, #14344
    MOVT r0, #16385
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    STR r0, [r6, #40]
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
.loc 1 31275
    LDR r0, [r6, #40]
    PUSH {r0}
    MOV r0, #15
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    MOV r0, #3
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #40]
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
.loc 1 31276
    LDR r0, [r6, #40]
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOVW r0, #0
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_GPIO_DeInit_7
    MOV r0, #0
    PUSH {r0}
    B .L_HAL_GPIO_DeInit_8
.L_HAL_GPIO_DeInit_7:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOVW r0, #1024
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_GPIO_DeInit_9
    MOV r0, #1
    PUSH {r0}
    B .L_HAL_GPIO_DeInit_10
.L_HAL_GPIO_DeInit_9:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOVW r0, #2048
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_GPIO_DeInit_11
    MOV r0, #2
    PUSH {r0}
    B .L_HAL_GPIO_DeInit_12
.L_HAL_GPIO_DeInit_11:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOVW r0, #3072
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_GPIO_DeInit_13
    MOV r0, #3
    PUSH {r0}
    B .L_HAL_GPIO_DeInit_14
.L_HAL_GPIO_DeInit_13:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOVW r0, #4096
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_GPIO_DeInit_15
    MOV r0, #4
    PUSH {r0}
    B .L_HAL_GPIO_DeInit_16
.L_HAL_GPIO_DeInit_15:
    MOV r0, #7
    PUSH {r0}
.L_HAL_GPIO_DeInit_16:
.L_HAL_GPIO_DeInit_14:
.L_HAL_GPIO_DeInit_12:
.L_HAL_GPIO_DeInit_10:
.L_HAL_GPIO_DeInit_8:
    MOV r0, #4
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    MOV r0, #3
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_GPIO_DeInit_5
.loc 1 31279
    MOVW r0, #15360
    MOVT r0, #16385
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
    LDR r0, [r6, #32]
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 31280
    MOVW r0, #15364
    MOVT r0, #16385
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
    LDR r0, [r6, #32]
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 31283
    MOVW r0, #15372
    MOVT r0, #16385
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
    LDR r0, [r6, #32]
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 31284
    MOVW r0, #15368
    MOVT r0, #16385
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
    LDR r0, [r6, #32]
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 31287
    MOV r0, #15
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    MOV r0, #3
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #40]
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
.loc 1 31288
    MOVW r0, #14344
    MOVT r0, #16385
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_HAL_GPIO_DeInit_6
.L_HAL_GPIO_DeInit_5:
.L_HAL_GPIO_DeInit_6:
.loc 1 31293
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #3
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 31296
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #32
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    MOV r0, #3
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #15
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    MOV r0, #7
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 31299
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #3
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 31302
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 31305
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #3
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_HAL_GPIO_DeInit_4
.L_HAL_GPIO_DeInit_3:
.L_HAL_GPIO_DeInit_4:
.L_HAL_GPIO_DeInit_2:
.loc 1 31264
    LDR r0, [r6, #16]
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    POP {r0}
    B .L_HAL_GPIO_DeInit_0
.L_HAL_GPIO_DeInit_1:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #48
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_GPIO_DeInit, .-HAL_GPIO_DeInit

.global HAL_GPIO_ReadPin
.type HAL_GPIO_ReadPin, %function
HAL_GPIO_ReadPin:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #24
    MOV r6, sp
.loc 1 31264
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 31339
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 31341
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    LDRH r0, [r6, #8]
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_GPIO_ReadPin_0
.loc 1 31343
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
    B .L_HAL_GPIO_ReadPin_1
.L_HAL_GPIO_ReadPin_0:
.loc 1 31347
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
.L_HAL_GPIO_ReadPin_1:
.loc 1 31349
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #24
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_GPIO_ReadPin, .-HAL_GPIO_ReadPin

.global HAL_GPIO_WritePin
.type HAL_GPIO_WritePin, %function
HAL_GPIO_WritePin:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #24
    MOV r6, sp
.loc 1 31349
    STR r0, [r6, #0]
    STR r1, [r6, #8]
    STR r2, [r6, #16]
.loc 1 31372
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 31373
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 31375
    LDR r0, [r6, #16]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_GPIO_WritePin_0
.loc 1 31377
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #24
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDRH r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_HAL_GPIO_WritePin_1
.L_HAL_GPIO_WritePin_0:
.loc 1 31381
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #24
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDRH r0, [r6, #8]
    PUSH {r0}
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_GPIO_WritePin_1:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #24
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_GPIO_WritePin, .-HAL_GPIO_WritePin

.global HAL_GPIO_TogglePin
.type HAL_GPIO_TogglePin, %function
HAL_GPIO_TogglePin:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #24
    MOV r6, sp
.loc 1 31381
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 31397
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 31400
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #20
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
.loc 1 31403
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #24
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    LDRH r0, [r6, #8]
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    LDRH r0, [r6, #8]
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #24
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_GPIO_TogglePin, .-HAL_GPIO_TogglePin

.global HAL_GPIO_LockPin
.type HAL_GPIO_LockPin, %function
HAL_GPIO_LockPin:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #24
    MOV r6, sp
.loc 1 31403
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 31419
    MOVW r0, #0
    MOVT r0, #1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
.loc 1 31422
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 31425
    LDR r0, [r6, #16]
    PUSH {r0}
    LDRH r0, [r6, #8]
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
.loc 1 31427
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #28
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 31429
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #28
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDRH r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 31431
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #28
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 31433
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #28
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
.loc 1 31436
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #28
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVT r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_GPIO_LockPin_0
.loc 1 31438
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #24
    POP {r5, r6, r7, pc}
.L_HAL_GPIO_LockPin_0:
.loc 1 31442
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #24
    POP {r5, r6, r7, pc}
.L_HAL_GPIO_LockPin_1:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #24
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_GPIO_LockPin, .-HAL_GPIO_LockPin

.global HAL_GPIO_EXTI_IRQHandler
.type HAL_GPIO_EXTI_IRQHandler, %function
HAL_GPIO_EXTI_IRQHandler:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 31442
    STR r0, [r6, #0]
.loc 1 31454
    MOVW r0, #15380
    MOVT r0, #16385
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
    LDRH r0, [r6, #0]
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_GPIO_EXTI_IRQHandler_0
.loc 1 31456
    MOVW r0, #15380
    MOVT r0, #16385
    PUSH {r0}
    LDRH r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 31457
    LDRH r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    BL HAL_GPIO_EXTI_Callback
    PUSH {r0}
    POP {r0}
    B .L_HAL_GPIO_EXTI_IRQHandler_1
.L_HAL_GPIO_EXTI_IRQHandler_0:
.L_HAL_GPIO_EXTI_IRQHandler_1:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_GPIO_EXTI_IRQHandler, .-HAL_GPIO_EXTI_IRQHandler

.global HAL_GPIO_EXTI_Callback
.weak HAL_GPIO_EXTI_Callback
.type HAL_GPIO_EXTI_Callback, %function
HAL_GPIO_EXTI_Callback:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 31457
    STR r0, [r6, #0]
.loc 1 31469
    LDRH r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_GPIO_EXTI_Callback, .-HAL_GPIO_EXTI_Callback

.global HAL_PWR_DeInit
.type HAL_PWR_DeInit, %function
HAL_PWR_DeInit:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 31469
.loc 1 31676
    MOVW r0, #14368
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
    MOVW r0, #0
    MOVT r0, #4096
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
.loc 1 31677
    MOVW r0, #14368
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
    MOVW r0, #0
    MOVT r0, #4096
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
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
.size HAL_PWR_DeInit, .-HAL_PWR_DeInit

.global HAL_PWR_EnableBkUpAccess
.type HAL_PWR_EnableBkUpAccess, %function
HAL_PWR_EnableBkUpAccess:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 31677
.loc 1 31695
    MOVW r0, #32
    MOVT r0, #16910
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 31696
    MOVW r0, #28672
    MOVT r0, #16384
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
    POP {r0}
    STR r0, [r6, #0]
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
.loc 1 31697
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_PWR_EnableBkUpAccess, .-HAL_PWR_EnableBkUpAccess

.global HAL_PWR_DisableBkUpAccess
.type HAL_PWR_DisableBkUpAccess, %function
HAL_PWR_DisableBkUpAccess:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 31697
.loc 1 31715
    MOVW r0, #32
    MOVT r0, #16910
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 31716
    MOVW r0, #28672
    MOVT r0, #16384
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
    POP {r0}
    STR r0, [r6, #0]
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
.loc 1 31717
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_PWR_DisableBkUpAccess, .-HAL_PWR_DisableBkUpAccess

.global HAL_PWR_ConfigPVD
.type HAL_PWR_ConfigPVD, %function
HAL_PWR_ConfigPVD:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 31717
    STR r0, [r6, #0]
.loc 1 31862
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 31863
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 31866
    MOVW r0, #28672
    MOVT r0, #16384
    PUSH {r0}
    MOVW r0, #28672
    MOVT r0, #16384
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
    MOV r0, #224
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 31869
    MOVW r0, #15364
    MOVT r0, #16385
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
    MOVW r0, #0
    MOVT r0, #1
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 31870
    MOVW r0, #15360
    MOVT r0, #16385
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
    MOVW r0, #0
    MOVT r0, #1
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 31871
    MOVW r0, #15368
    MOVT r0, #16385
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
    MOVW r0, #0
    MOVT r0, #1
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 31872
    MOVW r0, #15372
    MOVT r0, #16385
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
    MOVW r0, #0
    MOVT r0, #1
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 31875
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVT r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOVW r0, #0
    MOVT r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_PWR_ConfigPVD_0
.loc 1 31877
    MOVW r0, #15360
    MOVT r0, #16385
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
    MOVW r0, #0
    MOVT r0, #1
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
    B .L_HAL_PWR_ConfigPVD_1
.L_HAL_PWR_ConfigPVD_0:
.L_HAL_PWR_ConfigPVD_1:
.loc 1 31881
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVT r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOVW r0, #0
    MOVT r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_PWR_ConfigPVD_2
.loc 1 31883
    MOVW r0, #15364
    MOVT r0, #16385
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
    MOVW r0, #0
    MOVT r0, #1
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
    B .L_HAL_PWR_ConfigPVD_3
.L_HAL_PWR_ConfigPVD_2:
.L_HAL_PWR_ConfigPVD_3:
.loc 1 31887
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_PWR_ConfigPVD_4
.loc 1 31889
    MOVW r0, #15368
    MOVT r0, #16385
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
    MOVW r0, #0
    MOVT r0, #1
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
    B .L_HAL_PWR_ConfigPVD_5
.L_HAL_PWR_ConfigPVD_4:
.L_HAL_PWR_ConfigPVD_5:
.loc 1 31892
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    AND r0, r1
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_PWR_ConfigPVD_6
.loc 1 31894
    MOVW r0, #15372
    MOVT r0, #16385
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
    MOVW r0, #0
    MOVT r0, #1
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
    B .L_HAL_PWR_ConfigPVD_7
.L_HAL_PWR_ConfigPVD_6:
.L_HAL_PWR_ConfigPVD_7:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_PWR_ConfigPVD, .-HAL_PWR_ConfigPVD

.global HAL_PWR_EnablePVD
.type HAL_PWR_EnablePVD, %function
HAL_PWR_EnablePVD:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 31894
.loc 1 31904
    MOVW r0, #16
    MOVT r0, #16910
    PUSH {r0}
    MOV r0, #1
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
.size HAL_PWR_EnablePVD, .-HAL_PWR_EnablePVD

.global HAL_PWR_DisablePVD
.type HAL_PWR_DisablePVD, %function
HAL_PWR_DisablePVD:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 31904
.loc 1 31913
    MOVW r0, #16
    MOVT r0, #16910
    PUSH {r0}
    MOV r0, #0
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
.size HAL_PWR_DisablePVD, .-HAL_PWR_DisablePVD

.global HAL_PWR_EnableWakeUpPin
.type HAL_PWR_EnableWakeUpPin, %function
HAL_PWR_EnableWakeUpPin:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 31913
    STR r0, [r6, #0]
.loc 1 31928
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 31931
    MOVW r0, #28676
    MOVT r0, #16384
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
    LDR r0, [r6, #0]
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
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_PWR_EnableWakeUpPin, .-HAL_PWR_EnableWakeUpPin

.global HAL_PWR_DisableWakeUpPin
.type HAL_PWR_DisableWakeUpPin, %function
HAL_PWR_DisableWakeUpPin:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 31931
    STR r0, [r6, #0]
.loc 1 31946
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 31949
    MOVW r0, #28676
    MOVT r0, #16384
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
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
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
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_PWR_DisableWakeUpPin, .-HAL_PWR_DisableWakeUpPin

.global HAL_PWR_EnterSLEEPMode
.type HAL_PWR_EnterSLEEPMode, %function
HAL_PWR_EnterSLEEPMode:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #16
    MOV r6, sp
.loc 1 31949
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 31978
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
.loc 1 31981
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 31982
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 31985
    MOVW r0, #60688
    MOVT r0, #57344
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
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 31988
    LDRB r0, [r6, #8]
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_PWR_EnterSLEEPMode_0
.loc 1 31991
    WFI
    PUSH {r0}
    POP {r0}
    B .L_HAL_PWR_EnterSLEEPMode_1
.L_HAL_PWR_EnterSLEEPMode_0:
.loc 1 31995
    LDRB r0, [r6, #8]
    PUSH {r0}
    MOV r0, #3
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_PWR_EnterSLEEPMode_2
.loc 1 31998
    SEV
    PUSH {r0}
    POP {r0}
.loc 1 31999
    WFE
    PUSH {r0}
    POP {r0}
    B .L_HAL_PWR_EnterSLEEPMode_3
.L_HAL_PWR_EnterSLEEPMode_2:
.L_HAL_PWR_EnterSLEEPMode_3:
.loc 1 32003
    WFE
    PUSH {r0}
    POP {r0}
.L_HAL_PWR_EnterSLEEPMode_1:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #16
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_PWR_EnterSLEEPMode, .-HAL_PWR_EnterSLEEPMode

.global HAL_PWR_EnterSTOPMode
.type HAL_PWR_EnterSTOPMode, %function
HAL_PWR_EnterSTOPMode:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #16
    MOV r6, sp
.loc 1 32003
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 32032
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 32033
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 32036
    MOVW r0, #28672
    MOVT r0, #16384
    PUSH {r0}
    MOVW r0, #28672
    MOVT r0, #16384
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
    MOV r0, #3
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    LDR r0, [r6, #0]
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
.loc 1 32039
    MOVW r0, #60688
    MOVT r0, #57344
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
.loc 1 32042
    LDRB r0, [r6, #8]
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_PWR_EnterSTOPMode_0
.loc 1 32045
    WFI
    PUSH {r0}
    POP {r0}
    B .L_HAL_PWR_EnterSTOPMode_1
.L_HAL_PWR_EnterSTOPMode_0:
.loc 1 32049
    LDRB r0, [r6, #8]
    PUSH {r0}
    MOV r0, #3
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_PWR_EnterSTOPMode_2
.loc 1 32052
    SEV
    PUSH {r0}
    POP {r0}
.loc 1 32053
    WFE
    PUSH {r0}
    POP {r0}
    B .L_HAL_PWR_EnterSTOPMode_3
.L_HAL_PWR_EnterSTOPMode_2:
.L_HAL_PWR_EnterSTOPMode_3:
.loc 1 32056
    WFE
    PUSH {r0}
    POP {r0}
.L_HAL_PWR_EnterSTOPMode_1:
.loc 1 32059
    MOVW r0, #60688
    MOVT r0, #57344
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
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
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
    ADD sp, sp, #16
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_PWR_EnterSTOPMode, .-HAL_PWR_EnterSTOPMode

.global HAL_PWR_EnterSTANDBYMode
.type HAL_PWR_EnterSTANDBYMode, %function
HAL_PWR_EnterSTANDBYMode:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 32059
.loc 1 32075
    MOVW r0, #28672
    MOVT r0, #16384
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
.loc 1 32078
    MOVW r0, #60688
    MOVT r0, #57344
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
.loc 1 32082
    BL __force_stores
    PUSH {r0}
    POP {r0}
.loc 1 32085
    WFI
    PUSH {r0}
    POP {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_PWR_EnterSTANDBYMode, .-HAL_PWR_EnterSTANDBYMode

.global HAL_PWR_PVD_IRQHandler
.type HAL_PWR_PVD_IRQHandler, %function
HAL_PWR_PVD_IRQHandler:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 32085
.loc 1 32096
    MOVW r0, #15380
    MOVT r0, #16385
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
    MOVT r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_PWR_PVD_IRQHandler_0
.loc 1 32099
    BL HAL_PWR_PVDCallback
    PUSH {r0}
    POP {r0}
.loc 1 32102
    MOVW r0, #15380
    MOVT r0, #16385
    PUSH {r0}
    MOVW r0, #0
    MOVT r0, #1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_HAL_PWR_PVD_IRQHandler_1
.L_HAL_PWR_PVD_IRQHandler_0:
.L_HAL_PWR_PVD_IRQHandler_1:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_PWR_PVD_IRQHandler, .-HAL_PWR_PVD_IRQHandler

.global HAL_PWR_PVDCallback
.weak HAL_PWR_PVDCallback
.type HAL_PWR_PVDCallback, %function
HAL_PWR_PVDCallback:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 32102
.loc 1 32111
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_PWR_PVDCallback, .-HAL_PWR_PVDCallback

.global HAL_PWR_EnableSleepOnExit
.type HAL_PWR_EnableSleepOnExit, %function
HAL_PWR_EnableSleepOnExit:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 32111
.loc 1 32128
    MOVW r0, #60688
    MOVT r0, #57344
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
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_PWR_EnableSleepOnExit, .-HAL_PWR_EnableSleepOnExit

.global HAL_PWR_DisableSleepOnExit
.type HAL_PWR_DisableSleepOnExit, %function
HAL_PWR_DisableSleepOnExit:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 32128
.loc 1 32140
    MOVW r0, #60688
    MOVT r0, #57344
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
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
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
.size HAL_PWR_DisableSleepOnExit, .-HAL_PWR_DisableSleepOnExit

.global HAL_PWR_EnableSEVOnPend
.type HAL_PWR_EnableSEVOnPend, %function
HAL_PWR_EnableSEVOnPend:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 32140
.loc 1 32152
    MOVW r0, #60688
    MOVT r0, #57344
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
    MOV r0, #16
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
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_PWR_EnableSEVOnPend, .-HAL_PWR_EnableSEVOnPend

.global HAL_PWR_DisableSEVOnPend
.type HAL_PWR_DisableSEVOnPend, %function
HAL_PWR_DisableSEVOnPend:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 32152
.loc 1 32164
    MOVW r0, #60688
    MOVT r0, #57344
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
    MOV r0, #16
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
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
.size HAL_PWR_DisableSEVOnPend, .-HAL_PWR_DisableSEVOnPend

.global HAL_PWREx_EnableBkUpReg
.type HAL_PWREx_EnableBkUpReg, %function
HAL_PWREx_EnableBkUpReg:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 32164
.loc 1 32417
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
.loc 1 32419
    MOVW r0, #164
    MOVT r0, #16910
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 32422
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
.loc 1 32425
.L_HAL_PWREx_EnableBkUpReg_0:
    MOVW r0, #28676
    MOVT r0, #16384
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
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_PWREx_EnableBkUpReg_1
.loc 1 32427
    BL HAL_GetTick
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    MOVW r0, #1000
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_PWREx_EnableBkUpReg_2
.loc 1 32429
    MOV r0, #3
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
.L_HAL_PWREx_EnableBkUpReg_2:
.L_HAL_PWREx_EnableBkUpReg_3:
    B .L_HAL_PWREx_EnableBkUpReg_0
.L_HAL_PWREx_EnableBkUpReg_1:
.loc 1 32432
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_PWREx_EnableBkUpReg, .-HAL_PWREx_EnableBkUpReg

.global HAL_PWREx_DisableBkUpReg
.type HAL_PWREx_DisableBkUpReg, %function
HAL_PWREx_DisableBkUpReg:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 32432
.loc 1 32441
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
.loc 1 32443
    MOVW r0, #164
    MOVT r0, #16910
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 32446
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
.loc 1 32449
.L_HAL_PWREx_DisableBkUpReg_0:
    MOVW r0, #28676
    MOVT r0, #16384
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
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_PWREx_DisableBkUpReg_1
.loc 1 32451
    BL HAL_GetTick
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    MOVW r0, #1000
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_PWREx_DisableBkUpReg_2
.loc 1 32453
    MOV r0, #3
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
.L_HAL_PWREx_DisableBkUpReg_2:
.L_HAL_PWREx_DisableBkUpReg_3:
    B .L_HAL_PWREx_DisableBkUpReg_0
.L_HAL_PWREx_DisableBkUpReg_1:
.loc 1 32456
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_PWREx_DisableBkUpReg, .-HAL_PWREx_DisableBkUpReg

.global HAL_PWREx_EnableFlashPowerDown
.type HAL_PWREx_EnableFlashPowerDown, %function
HAL_PWREx_EnableFlashPowerDown:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 32456
.loc 1 32465
    MOVW r0, #36
    MOVT r0, #16910
    PUSH {r0}
    MOV r0, #1
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
.size HAL_PWREx_EnableFlashPowerDown, .-HAL_PWREx_EnableFlashPowerDown

.global HAL_PWREx_DisableFlashPowerDown
.type HAL_PWREx_DisableFlashPowerDown, %function
HAL_PWREx_DisableFlashPowerDown:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 32465
.loc 1 32474
    MOVW r0, #36
    MOVT r0, #16910
    PUSH {r0}
    MOV r0, #0
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
.size HAL_PWREx_DisableFlashPowerDown, .-HAL_PWREx_DisableFlashPowerDown

.global HAL_PWREx_GetVoltageRange
.type HAL_PWREx_GetVoltageRange, %function
HAL_PWREx_GetVoltageRange:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 32474
.loc 1 32487
    MOVW r0, #28672
    MOVT r0, #16384
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
    MOVW r0, #49152
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_PWREx_GetVoltageRange, .-HAL_PWREx_GetVoltageRange

.global HAL_PWREx_ControlVoltageScaling
.type HAL_PWREx_ControlVoltageScaling, %function
HAL_PWREx_ControlVoltageScaling:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #24
    MOV r6, sp
.loc 1 32487
    STR r0, [r6, #0]
.loc 1 32520
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
.loc 1 32522
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 32525
.L_HAL_PWREx_ControlVoltageScaling_0:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    MOVW r0, #14400
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
    MOVW r0, #0
    MOVT r0, #4096
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
    MOVW r0, #14400
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
    MOVT r0, #4096
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
.L_HAL_PWREx_ControlVoltageScaling_2:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_PWREx_ControlVoltageScaling_0
.L_HAL_PWREx_ControlVoltageScaling_1:
.loc 1 32528
    MOVW r0, #14344
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
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_PWREx_ControlVoltageScaling_3
.loc 1 32531
    MOVW r0, #96
    MOVT r0, #16967
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 32534
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 32536
.L_HAL_PWREx_ControlVoltageScaling_5:
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_PWREx_ControlVoltageScaling_9
    MOVW r0, #14336
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
    B .L_HAL_PWREx_ControlVoltageScaling_10
.L_HAL_PWREx_ControlVoltageScaling_9:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_PWREx_ControlVoltageScaling_11
    MOVW r0, #14448
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
    B .L_HAL_PWREx_ControlVoltageScaling_12
.L_HAL_PWREx_ControlVoltageScaling_11:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_PWREx_ControlVoltageScaling_13
    MOVW r0, #14452
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
    B .L_HAL_PWREx_ControlVoltageScaling_14
.L_HAL_PWREx_ControlVoltageScaling_13:
    MOVW r0, #14348
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
.L_HAL_PWREx_ControlVoltageScaling_14:
.L_HAL_PWREx_ControlVoltageScaling_12:
.L_HAL_PWREx_ControlVoltageScaling_10:
    MOVW r0, #0
    MOVT r0, #512
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_PWREx_ControlVoltageScaling_7
    MOV r0, #1
    PUSH {r0}
    B .L_HAL_PWREx_ControlVoltageScaling_8
.L_HAL_PWREx_ControlVoltageScaling_7:
    MOV r0, #0
    PUSH {r0}
.L_HAL_PWREx_ControlVoltageScaling_8:
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_PWREx_ControlVoltageScaling_6
.loc 1 32538
    BL HAL_GetTick
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_PWREx_ControlVoltageScaling_15
.loc 1 32540
    MOV r0, #3
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #24
    POP {r5, r6, r7, pc}
.L_HAL_PWREx_ControlVoltageScaling_15:
.L_HAL_PWREx_ControlVoltageScaling_16:
    B .L_HAL_PWREx_ControlVoltageScaling_5
.L_HAL_PWREx_ControlVoltageScaling_6:
.loc 1 32545
.L_HAL_PWREx_ControlVoltageScaling_17:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    MOVW r0, #28672
    MOVT r0, #16384
    PUSH {r0}
    MOVW r0, #28672
    MOVT r0, #16384
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
    MOVW r0, #49152
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    LDR r0, [r6, #0]
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
    MOVW r0, #28672
    MOVT r0, #16384
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
    MOVW r0, #49152
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
.L_HAL_PWREx_ControlVoltageScaling_19:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_PWREx_ControlVoltageScaling_17
.L_HAL_PWREx_ControlVoltageScaling_18:
.loc 1 32548
    MOVW r0, #96
    MOVT r0, #16967
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 32551
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 32553
.L_HAL_PWREx_ControlVoltageScaling_20:
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_PWREx_ControlVoltageScaling_24
    MOVW r0, #14336
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
    B .L_HAL_PWREx_ControlVoltageScaling_25
.L_HAL_PWREx_ControlVoltageScaling_24:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_PWREx_ControlVoltageScaling_26
    MOVW r0, #14448
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
    B .L_HAL_PWREx_ControlVoltageScaling_27
.L_HAL_PWREx_ControlVoltageScaling_26:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_PWREx_ControlVoltageScaling_28
    MOVW r0, #14452
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
    B .L_HAL_PWREx_ControlVoltageScaling_29
.L_HAL_PWREx_ControlVoltageScaling_28:
    MOVW r0, #14348
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
.L_HAL_PWREx_ControlVoltageScaling_29:
.L_HAL_PWREx_ControlVoltageScaling_27:
.L_HAL_PWREx_ControlVoltageScaling_25:
    MOVW r0, #0
    MOVT r0, #512
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_PWREx_ControlVoltageScaling_22
    MOV r0, #1
    PUSH {r0}
    B .L_HAL_PWREx_ControlVoltageScaling_23
.L_HAL_PWREx_ControlVoltageScaling_22:
    MOV r0, #0
    PUSH {r0}
.L_HAL_PWREx_ControlVoltageScaling_23:
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_PWREx_ControlVoltageScaling_21
.loc 1 32555
    BL HAL_GetTick
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_PWREx_ControlVoltageScaling_30
.loc 1 32557
    MOV r0, #3
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #24
    POP {r5, r6, r7, pc}
.L_HAL_PWREx_ControlVoltageScaling_30:
.L_HAL_PWREx_ControlVoltageScaling_31:
    B .L_HAL_PWREx_ControlVoltageScaling_20
.L_HAL_PWREx_ControlVoltageScaling_21:
.loc 1 32562
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 32563
.L_HAL_PWREx_ControlVoltageScaling_32:
    MOVW r0, #28676
    MOVT r0, #16384
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
    MOVW r0, #16384
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOVW r0, #16384
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_PWREx_ControlVoltageScaling_33
.loc 1 32565
    BL HAL_GetTick
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    MOVW r0, #1000
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_PWREx_ControlVoltageScaling_34
.loc 1 32567
    MOV r0, #3
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #24
    POP {r5, r6, r7, pc}
.L_HAL_PWREx_ControlVoltageScaling_34:
.L_HAL_PWREx_ControlVoltageScaling_35:
    B .L_HAL_PWREx_ControlVoltageScaling_32
.L_HAL_PWREx_ControlVoltageScaling_33:
    B .L_HAL_PWREx_ControlVoltageScaling_4
.L_HAL_PWREx_ControlVoltageScaling_3:
.loc 1 32573
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #24
    POP {r5, r6, r7, pc}
.L_HAL_PWREx_ControlVoltageScaling_4:
.loc 1 32576
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #24
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_PWREx_ControlVoltageScaling, .-HAL_PWREx_ControlVoltageScaling

.global HAL_PWREx_EnableMainRegulatorLowVoltage
.type HAL_PWREx_EnableMainRegulatorLowVoltage, %function
HAL_PWREx_EnableMainRegulatorLowVoltage:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 32576
.loc 1 32589
    MOVW r0, #44
    MOVT r0, #16910
    PUSH {r0}
    MOV r0, #1
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
.size HAL_PWREx_EnableMainRegulatorLowVoltage, .-HAL_PWREx_EnableMainRegulatorLowVoltage

.global HAL_PWREx_DisableMainRegulatorLowVoltage
.type HAL_PWREx_DisableMainRegulatorLowVoltage, %function
HAL_PWREx_DisableMainRegulatorLowVoltage:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 32589
.loc 1 32600
    MOVW r0, #44
    MOVT r0, #16910
    PUSH {r0}
    MOV r0, #0
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
.size HAL_PWREx_DisableMainRegulatorLowVoltage, .-HAL_PWREx_DisableMainRegulatorLowVoltage

.global HAL_PWREx_EnableLowRegulatorLowVoltage
.type HAL_PWREx_EnableLowRegulatorLowVoltage, %function
HAL_PWREx_EnableLowRegulatorLowVoltage:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 32600
.loc 1 32611
    MOVW r0, #40
    MOVT r0, #16910
    PUSH {r0}
    MOV r0, #1
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
.size HAL_PWREx_EnableLowRegulatorLowVoltage, .-HAL_PWREx_EnableLowRegulatorLowVoltage

.global HAL_PWREx_DisableLowRegulatorLowVoltage
.type HAL_PWREx_DisableLowRegulatorLowVoltage, %function
HAL_PWREx_DisableLowRegulatorLowVoltage:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 32611
.loc 1 32622
    MOVW r0, #40
    MOVT r0, #16910
    PUSH {r0}
    MOV r0, #0
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
.size HAL_PWREx_DisableLowRegulatorLowVoltage, .-HAL_PWREx_DisableLowRegulatorLowVoltage

.global HAL_DMA_Init
.type HAL_DMA_Init, %function
HAL_DMA_Init:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #32
    MOV r6, sp
.loc 1 32622
    STR r0, [r6, #0]
.loc 1 32908
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
.loc 1 32909
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
.loc 1 32913
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_Init_0
.loc 1 32915
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #32
    POP {r5, r6, r7, pc}
.L_HAL_DMA_Init_0:
.L_HAL_DMA_Init_1:
.loc 1 32919
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 32920
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 32921
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 32922
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 32923
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 32924
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 32925
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 32926
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 32927
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 32928
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 32931
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #32
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_Init_2
.loc 1 32933
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 32934
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 32935
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    B .L_HAL_DMA_Init_3
.L_HAL_DMA_Init_2:
.L_HAL_DMA_Init_3:
.loc 1 32939
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #56
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 32942
.L_HAL_DMA_Init_4:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #52
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_DMA_Init_6:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_DMA_Init_4
.L_HAL_DMA_Init_5:
.loc 1 32945
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 32948
.L_HAL_DMA_Init_7:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_Init_8
.loc 1 32951
    BL HAL_GetTick
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    MOV r0, #5
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_Init_9
.loc 1 32954
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #88
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #32
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 32957
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #56
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #3
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 32959
    MOV r0, #3
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #32
    POP {r5, r6, r7, pc}
.L_HAL_DMA_Init_9:
.L_HAL_DMA_Init_10:
    B .L_HAL_DMA_Init_7
.L_HAL_DMA_Init_8:
.loc 1 32964
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 32967
    LDR r0, [r6, #8]
    PUSH {r0}
    MOVW r0, #32256
    MOVT r0, #4067
    PUSH {r0}
    MOVW r0, #256
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    MOV r0, #192
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    MOVW r0, #0
    MOVT r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    MOVW r0, #0
    MOVT r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 32970
    LDR r0, [r6, #8]
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
.loc 1 32971
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
.loc 1 32972
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #20
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
.loc 1 32973
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #24
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #28
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 32976
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #32
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_Init_11
.loc 1 32979
    LDR r0, [r6, #8]
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #40
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #44
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    B .L_HAL_DMA_Init_12
.L_HAL_DMA_Init_11:
.L_HAL_DMA_Init_12:
.loc 1 32983
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 32986
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #20
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 32989
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #7
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 32992
    LDR r0, [r6, #8]
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #32
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 32995
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #32
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_Init_13
.loc 1 32998
    LDR r0, [r6, #8]
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #36
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 33002
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #40
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_Init_15
.loc 1 33004
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    BL DMA_CheckFifoParam
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_Init_17
.loc 1 33007
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #88
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #64
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33010
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #56
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33012
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #32
    POP {r5, r6, r7, pc}
.L_HAL_DMA_Init_17:
.L_HAL_DMA_Init_18:
    B .L_HAL_DMA_Init_16
.L_HAL_DMA_Init_15:
.L_HAL_DMA_Init_16:
    B .L_HAL_DMA_Init_14
.L_HAL_DMA_Init_13:
.L_HAL_DMA_Init_14:
.loc 1 33018
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #20
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33022
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    BL DMA_CalcBaseAndBitshift
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
.loc 1 33025
    LDR r0, [r6, #24]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #63
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #96
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33028
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #88
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33031
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #56
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33033
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #32
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_DMA_Init, .-HAL_DMA_Init

.global HAL_DMA_DeInit
.type HAL_DMA_DeInit, %function
HAL_DMA_DeInit:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #16
    MOV r6, sp
.loc 1 33033
    STR r0, [r6, #0]
.loc 1 33047
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_DeInit_0
.loc 1 33049
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #16
    POP {r5, r6, r7, pc}
.L_HAL_DMA_DeInit_0:
.L_HAL_DMA_DeInit_1:
.loc 1 33053
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #56
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_DeInit_2
.loc 1 33056
    MOV r0, #2
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #16
    POP {r5, r6, r7, pc}
.L_HAL_DMA_DeInit_2:
.L_HAL_DMA_DeInit_3:
.loc 1 33060
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 33063
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33066
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33069
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33072
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33075
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33078
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33081
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #20
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #33
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33084
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    BL DMA_CalcBaseAndBitshift
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 33087
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #64
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33088
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #68
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33089
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #72
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33090
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #76
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33091
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #80
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33092
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #84
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33095
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #63
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #96
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33098
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #88
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33101
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #56
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33104
.L_HAL_DMA_DeInit_4:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #52
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_DMA_DeInit_6:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_DMA_DeInit_4
.L_HAL_DMA_DeInit_5:
.loc 1 33106
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #16
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_DMA_DeInit, .-HAL_DMA_DeInit

.global HAL_DMA_Start
.type HAL_DMA_Start, %function
HAL_DMA_Start:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #40
    MOV r6, sp
.loc 1 33106
    STR r0, [r6, #0]
    STR r1, [r6, #8]
    STR r2, [r6, #16]
    STR r3, [r6, #24]
.loc 1 33142
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #32]
.loc 1 33145
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 33148
.L_HAL_DMA_Start_0:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #52
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_Start_3
    MOV r0, #2
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #40
    POP {r5, r6, r7, pc}
.L_HAL_DMA_Start_3:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #52
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_DMA_Start_4:
.L_HAL_DMA_Start_2:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_DMA_Start_0
.L_HAL_DMA_Start_1:
.loc 1 33150
    MOV r0, #1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #56
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_Start_5
.loc 1 33153
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #56
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33156
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #88
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33159
    LDR r0, [r6, #24]
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    POP {r1}
    POP {r2}
    POP {r3}
    BL DMA_SetConfig
    PUSH {r0}
    POP {r0}
.loc 1 33162
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
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
    B .L_HAL_DMA_Start_6
.L_HAL_DMA_Start_5:
.loc 1 33167
.L_HAL_DMA_Start_7:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #52
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_DMA_Start_9:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_DMA_Start_7
.L_HAL_DMA_Start_8:
.loc 1 33170
    MOV r0, #2
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #32]
    LDR r0, [r6, #32]
    PUSH {r0}
    POP {r0}
.L_HAL_DMA_Start_6:
.loc 1 33172
    LDR r0, [r6, #32]
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #40
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_DMA_Start, .-HAL_DMA_Start

.global HAL_DMA_Start_IT
.type HAL_DMA_Start_IT, %function
HAL_DMA_Start_IT:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #48
    MOV r6, sp
.loc 1 33172
    STR r0, [r6, #0]
    STR r1, [r6, #8]
    STR r2, [r6, #16]
    STR r3, [r6, #24]
.loc 1 33186
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #32]
.loc 1 33189
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #92
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    STR r0, [r6, #40]
.loc 1 33192
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 33195
.L_HAL_DMA_Start_IT_0:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #52
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_Start_IT_3
    MOV r0, #2
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #48
    POP {r5, r6, r7, pc}
.L_HAL_DMA_Start_IT_3:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #52
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_DMA_Start_IT_4:
.L_HAL_DMA_Start_IT_2:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_DMA_Start_IT_0
.L_HAL_DMA_Start_IT_1:
.loc 1 33197
    MOV r0, #1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #56
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_Start_IT_5
.loc 1 33200
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #56
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33203
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #88
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33206
    LDR r0, [r6, #24]
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    POP {r1}
    POP {r2}
    POP {r3}
    BL DMA_SetConfig
    PUSH {r0}
    POP {r0}
.loc 1 33209
    LDR r0, [r6, #40]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #63
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #96
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33212
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #22
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
.loc 1 33214
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #68
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_Start_IT_7
.loc 1 33216
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #8
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
    B .L_HAL_DMA_Start_IT_8
.L_HAL_DMA_Start_IT_7:
.L_HAL_DMA_Start_IT_8:
.loc 1 33220
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
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
    B .L_HAL_DMA_Start_IT_6
.L_HAL_DMA_Start_IT_5:
.loc 1 33225
.L_HAL_DMA_Start_IT_9:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #52
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_DMA_Start_IT_11:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_DMA_Start_IT_9
.L_HAL_DMA_Start_IT_10:
.loc 1 33228
    MOV r0, #2
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #32]
    LDR r0, [r6, #32]
    PUSH {r0}
    POP {r0}
.L_HAL_DMA_Start_IT_6:
.loc 1 33231
    LDR r0, [r6, #32]
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #48
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_DMA_Start_IT, .-HAL_DMA_Start_IT

.global HAL_DMA_Abort
.type HAL_DMA_Abort, %function
HAL_DMA_Abort:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #24
    MOV r6, sp
.loc 1 33231
    STR r0, [r6, #0]
.loc 1 33249
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #92
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    STR r0, [r6, #8]
.loc 1 33251
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
.loc 1 33253
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #56
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_Abort_0
.loc 1 33255
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #88
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #128
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33258
.L_HAL_DMA_Abort_2:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #52
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_DMA_Abort_4:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_DMA_Abort_2
.L_HAL_DMA_Abort_3:
.loc 1 33260
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #24
    POP {r5, r6, r7, pc}
.L_HAL_DMA_Abort_0:
.loc 1 33265
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #22
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33266
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #20
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #128
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33268
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #68
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_DMA_Abort_7
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #76
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    B .L_HAL_DMA_Abort_8
.L_HAL_DMA_Abort_7:
    MOV r0, #1
    PUSH {r0}
.L_HAL_DMA_Abort_8:
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_Abort_5
.loc 1 33270
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #8
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_HAL_DMA_Abort_6
.L_HAL_DMA_Abort_5:
.L_HAL_DMA_Abort_6:
.loc 1 33274
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33277
.L_HAL_DMA_Abort_9:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_Abort_10
.loc 1 33280
    BL HAL_GetTick
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    MOV r0, #5
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_Abort_11
.loc 1 33283
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #88
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #32
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33286
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #56
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #3
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33289
.L_HAL_DMA_Abort_13:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #52
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_DMA_Abort_15:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_DMA_Abort_13
.L_HAL_DMA_Abort_14:
.loc 1 33291
    MOV r0, #3
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #24
    POP {r5, r6, r7, pc}
.L_HAL_DMA_Abort_11:
.L_HAL_DMA_Abort_12:
    B .L_HAL_DMA_Abort_9
.L_HAL_DMA_Abort_10:
.loc 1 33296
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #63
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #96
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33299
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #56
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33302
.L_HAL_DMA_Abort_16:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #52
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_DMA_Abort_18:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_DMA_Abort_16
.L_HAL_DMA_Abort_17:
.L_HAL_DMA_Abort_1:
.loc 1 33304
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #24
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_DMA_Abort, .-HAL_DMA_Abort

.global HAL_DMA_Abort_IT
.type HAL_DMA_Abort_IT, %function
HAL_DMA_Abort_IT:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 33304
    STR r0, [r6, #0]
.loc 1 33315
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #56
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_Abort_IT_0
.loc 1 33317
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #88
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #128
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33318
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
.L_HAL_DMA_Abort_IT_0:
.loc 1 33323
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #56
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #5
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33326
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_DMA_Abort_IT_1:
.loc 1 33329
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_DMA_Abort_IT, .-HAL_DMA_Abort_IT

.global HAL_DMA_PollForTransfer
.type HAL_DMA_PollForTransfer, %function
HAL_DMA_PollForTransfer:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #64
    MOV r6, sp
.loc 1 33329
    STR r0, [r6, #0]
    STR r1, [r6, #8]
    STR r2, [r6, #16]
.loc 1 33345
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
.loc 1 33347
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #40]
.loc 1 33353
    MOV r0, #2
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #56
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_PollForTransfer_0
.loc 1 33356
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #88
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #128
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33357
.L_HAL_DMA_PollForTransfer_2:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #52
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_DMA_PollForTransfer_4:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_DMA_PollForTransfer_2
.L_HAL_DMA_PollForTransfer_3:
.loc 1 33358
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #64
    POP {r5, r6, r7, pc}
.L_HAL_DMA_PollForTransfer_0:
.L_HAL_DMA_PollForTransfer_1:
.loc 1 33362
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #256
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_PollForTransfer_5
.loc 1 33364
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #88
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOVW r0, #256
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33365
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #64
    POP {r5, r6, r7, pc}
.L_HAL_DMA_PollForTransfer_5:
.L_HAL_DMA_PollForTransfer_6:
.loc 1 33369
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_PollForTransfer_7
.loc 1 33372
    MOV r0, #32
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #96
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #32]
    LDR r0, [r6, #32]
    PUSH {r0}
    POP {r0}
    B .L_HAL_DMA_PollForTransfer_8
.L_HAL_DMA_PollForTransfer_7:
.loc 1 33377
    MOV r0, #16
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #96
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #32]
    LDR r0, [r6, #32]
    PUSH {r0}
    POP {r0}
.L_HAL_DMA_PollForTransfer_8:
.loc 1 33380
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #92
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    STR r0, [r6, #56]
    LDR r0, [r6, #56]
    PUSH {r0}
    POP {r0}
.loc 1 33381
    LDR r0, [r6, #56]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    STR r0, [r6, #48]
    LDR r0, [r6, #48]
    PUSH {r0}
    POP {r0}
.loc 1 33383
.L_HAL_DMA_PollForTransfer_9:
    LDR r0, [r6, #48]
    PUSH {r0}
    LDR r0, [r6, #32]
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_PollForTransfer_11
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #88
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    B .L_HAL_DMA_PollForTransfer_12
.L_HAL_DMA_PollForTransfer_11:
    MOV r0, #0
    PUSH {r0}
.L_HAL_DMA_PollForTransfer_12:
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_PollForTransfer_10
.loc 1 33386
    LDR r0, [r6, #16]
    PUSH {r0}
    MOVW r0, #65535
    MOVT r0, #65535
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_PollForTransfer_13
.loc 1 33388
    LDR r0, [r6, #16]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_DMA_PollForTransfer_17
    BL HAL_GetTick
    PUSH {r0}
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    B .L_HAL_DMA_PollForTransfer_18
.L_HAL_DMA_PollForTransfer_17:
    MOV r0, #1
    PUSH {r0}
.L_HAL_DMA_PollForTransfer_18:
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_PollForTransfer_15
.loc 1 33391
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #88
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #32
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33394
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #56
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33397
.L_HAL_DMA_PollForTransfer_19:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #52
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_DMA_PollForTransfer_21:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_DMA_PollForTransfer_19
.L_HAL_DMA_PollForTransfer_20:
.loc 1 33399
    MOV r0, #3
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #64
    POP {r5, r6, r7, pc}
.L_HAL_DMA_PollForTransfer_15:
.L_HAL_DMA_PollForTransfer_16:
    B .L_HAL_DMA_PollForTransfer_14
.L_HAL_DMA_PollForTransfer_13:
.L_HAL_DMA_PollForTransfer_14:
.loc 1 33404
    LDR r0, [r6, #56]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    STR r0, [r6, #48]
    LDR r0, [r6, #48]
    PUSH {r0}
    POP {r0}
.loc 1 33406
    LDR r0, [r6, #48]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #96
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_PollForTransfer_22
.loc 1 33409
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #88
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
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
.loc 1 33412
    LDR r0, [r6, #56]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #96
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_HAL_DMA_PollForTransfer_23
.L_HAL_DMA_PollForTransfer_22:
.L_HAL_DMA_PollForTransfer_23:
.loc 1 33415
    LDR r0, [r6, #48]
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #96
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_PollForTransfer_24
.loc 1 33418
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #88
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
.loc 1 33421
    LDR r0, [r6, #56]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #96
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_HAL_DMA_PollForTransfer_25
.L_HAL_DMA_PollForTransfer_24:
.L_HAL_DMA_PollForTransfer_25:
.loc 1 33424
    LDR r0, [r6, #48]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #96
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_PollForTransfer_26
.loc 1 33427
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #88
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
.loc 1 33430
    LDR r0, [r6, #56]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #96
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_HAL_DMA_PollForTransfer_27
.L_HAL_DMA_PollForTransfer_26:
.L_HAL_DMA_PollForTransfer_27:
    B .L_HAL_DMA_PollForTransfer_9
.L_HAL_DMA_PollForTransfer_10:
.loc 1 33434
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #88
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_PollForTransfer_28
.loc 1 33436
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #88
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_PollForTransfer_30
.loc 1 33438
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    BL HAL_DMA_Abort
    PUSH {r0}
    POP {r0}
.loc 1 33441
    LDR r0, [r6, #56]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #48
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #96
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33444
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #56
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33447
.L_HAL_DMA_PollForTransfer_32:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #52
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_DMA_PollForTransfer_34:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_DMA_PollForTransfer_32
.L_HAL_DMA_PollForTransfer_33:
.loc 1 33449
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #64
    POP {r5, r6, r7, pc}
.L_HAL_DMA_PollForTransfer_30:
.L_HAL_DMA_PollForTransfer_31:
    B .L_HAL_DMA_PollForTransfer_29
.L_HAL_DMA_PollForTransfer_28:
.L_HAL_DMA_PollForTransfer_29:
.loc 1 33454
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_PollForTransfer_35
.loc 1 33457
    LDR r0, [r6, #56]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #48
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #96
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33459
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #56
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33462
.L_HAL_DMA_PollForTransfer_37:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #52
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_DMA_PollForTransfer_39:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_DMA_PollForTransfer_37
.L_HAL_DMA_PollForTransfer_38:
    B .L_HAL_DMA_PollForTransfer_36
.L_HAL_DMA_PollForTransfer_35:
.loc 1 33467
    LDR r0, [r6, #56]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #16
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #96
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_DMA_PollForTransfer_36:
.loc 1 33470
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #64
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_DMA_PollForTransfer, .-HAL_DMA_PollForTransfer

.global HAL_DMA_IRQHandler
.type HAL_DMA_IRQHandler, %function
HAL_DMA_IRQHandler:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #40
    MOV r6, sp
.loc 1 33470
    STR r0, [r6, #0]
.loc 1 33482
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
.loc 1 33483
    MOVW r0, #0
    MOVT r0, #8192
    LDR r0, [r0]
    PUSH {r0}
    MOVW r0, #9600
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    UDIV r0, r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
.loc 1 33486
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #92
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    STR r0, [r6, #32]
.loc 1 33488
    LDR r0, [r6, #32]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 33491
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #96
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_IRQHandler_0
.loc 1 33493
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_IRQHandler_4
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    AND r0, r1
    PUSH {r0}
    B .L_HAL_DMA_IRQHandler_5
.L_HAL_DMA_IRQHandler_4:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #20
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    AND r0, r1
    PUSH {r0}
.L_HAL_DMA_IRQHandler_5:
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_IRQHandler_2
.loc 1 33496
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33499
    LDR r0, [r6, #32]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #96
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33502
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #88
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
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
    B .L_HAL_DMA_IRQHandler_3
.L_HAL_DMA_IRQHandler_2:
.L_HAL_DMA_IRQHandler_3:
    B .L_HAL_DMA_IRQHandler_1
.L_HAL_DMA_IRQHandler_0:
.L_HAL_DMA_IRQHandler_1:
.loc 1 33506
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #96
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_IRQHandler_6
.loc 1 33508
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_IRQHandler_10
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #128
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    B .L_HAL_DMA_IRQHandler_11
.L_HAL_DMA_IRQHandler_10:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #20
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #128
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
.L_HAL_DMA_IRQHandler_11:
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_IRQHandler_8
.loc 1 33511
    LDR r0, [r6, #32]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #96
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33514
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #88
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    B .L_HAL_DMA_IRQHandler_9
.L_HAL_DMA_IRQHandler_8:
.L_HAL_DMA_IRQHandler_9:
    B .L_HAL_DMA_IRQHandler_7
.L_HAL_DMA_IRQHandler_6:
.L_HAL_DMA_IRQHandler_7:
.loc 1 33518
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #96
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_IRQHandler_12
.loc 1 33520
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_IRQHandler_16
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    AND r0, r1
    PUSH {r0}
    B .L_HAL_DMA_IRQHandler_17
.L_HAL_DMA_IRQHandler_16:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #20
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    AND r0, r1
    PUSH {r0}
.L_HAL_DMA_IRQHandler_17:
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_IRQHandler_14
.loc 1 33523
    LDR r0, [r6, #32]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #96
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33526
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #88
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    B .L_HAL_DMA_IRQHandler_15
.L_HAL_DMA_IRQHandler_14:
.L_HAL_DMA_IRQHandler_15:
    B .L_HAL_DMA_IRQHandler_13
.L_HAL_DMA_IRQHandler_12:
.L_HAL_DMA_IRQHandler_13:
.loc 1 33530
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #16
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #96
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_IRQHandler_18
.loc 1 33532
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_IRQHandler_22
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    B .L_HAL_DMA_IRQHandler_23
.L_HAL_DMA_IRQHandler_22:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #20
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
.L_HAL_DMA_IRQHandler_23:
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_IRQHandler_20
.loc 1 33535
    LDR r0, [r6, #32]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #16
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #96
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33538
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVT r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_IRQHandler_24
.loc 1 33541
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVT r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_IRQHandler_26
.loc 1 33543
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #68
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_IRQHandler_28
.loc 1 33546
    LDR r0, [r6, #0]
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #68
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {ip}
    ORR ip, ip, #1
    POP {r0}
    BLX ip
    PUSH {r0}
    POP {r0}
    B .L_HAL_DMA_IRQHandler_29
.L_HAL_DMA_IRQHandler_28:
.L_HAL_DMA_IRQHandler_29:
    B .L_HAL_DMA_IRQHandler_27
.L_HAL_DMA_IRQHandler_26:
.loc 1 33552
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #76
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_IRQHandler_30
.loc 1 33555
    LDR r0, [r6, #0]
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #76
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {ip}
    ORR ip, ip, #1
    POP {r0}
    BLX ip
    PUSH {r0}
    POP {r0}
    B .L_HAL_DMA_IRQHandler_31
.L_HAL_DMA_IRQHandler_30:
.L_HAL_DMA_IRQHandler_31:
.L_HAL_DMA_IRQHandler_27:
    B .L_HAL_DMA_IRQHandler_25
.L_HAL_DMA_IRQHandler_24:
.loc 1 33562
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #256
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_IRQHandler_32
.loc 1 33565
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #8
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_HAL_DMA_IRQHandler_33
.L_HAL_DMA_IRQHandler_32:
.L_HAL_DMA_IRQHandler_33:
.loc 1 33568
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #68
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_IRQHandler_34
.loc 1 33571
    LDR r0, [r6, #0]
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #68
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {ip}
    ORR ip, ip, #1
    POP {r0}
    BLX ip
    PUSH {r0}
    POP {r0}
    B .L_HAL_DMA_IRQHandler_35
.L_HAL_DMA_IRQHandler_34:
.L_HAL_DMA_IRQHandler_35:
.L_HAL_DMA_IRQHandler_25:
    B .L_HAL_DMA_IRQHandler_21
.L_HAL_DMA_IRQHandler_20:
.L_HAL_DMA_IRQHandler_21:
    B .L_HAL_DMA_IRQHandler_19
.L_HAL_DMA_IRQHandler_18:
.L_HAL_DMA_IRQHandler_19:
.loc 1 33577
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #32
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #96
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_IRQHandler_36
.loc 1 33579
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_IRQHandler_40
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    B .L_HAL_DMA_IRQHandler_41
.L_HAL_DMA_IRQHandler_40:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #20
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
.L_HAL_DMA_IRQHandler_41:
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_IRQHandler_38
.loc 1 33582
    LDR r0, [r6, #32]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #32
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #96
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33584
    MOV r0, #5
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #56
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_IRQHandler_42
.loc 1 33587
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #22
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33588
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #20
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #128
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33590
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #68
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_DMA_IRQHandler_46
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #76
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    B .L_HAL_DMA_IRQHandler_47
.L_HAL_DMA_IRQHandler_46:
    MOV r0, #1
    PUSH {r0}
.L_HAL_DMA_IRQHandler_47:
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_IRQHandler_44
.loc 1 33592
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #8
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_HAL_DMA_IRQHandler_45
.L_HAL_DMA_IRQHandler_44:
.L_HAL_DMA_IRQHandler_45:
.loc 1 33596
    LDR r0, [r6, #32]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #63
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #96
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33599
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #56
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33602
.L_HAL_DMA_IRQHandler_48:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #52
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_DMA_IRQHandler_50:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_DMA_IRQHandler_48
.L_HAL_DMA_IRQHandler_49:
.loc 1 33604
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #84
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_IRQHandler_51
.loc 1 33606
    LDR r0, [r6, #0]
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #84
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {ip}
    ORR ip, ip, #1
    POP {r0}
    BLX ip
    PUSH {r0}
    POP {r0}
    B .L_HAL_DMA_IRQHandler_52
.L_HAL_DMA_IRQHandler_51:
.L_HAL_DMA_IRQHandler_52:
.loc 1 33608
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #40
    POP {r5, r6, r7, pc}
.L_HAL_DMA_IRQHandler_42:
.L_HAL_DMA_IRQHandler_43:
.loc 1 33611
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVT r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_IRQHandler_53
.loc 1 33614
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVT r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_IRQHandler_55
.loc 1 33616
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #72
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_IRQHandler_57
.loc 1 33619
    LDR r0, [r6, #0]
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #72
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {ip}
    ORR ip, ip, #1
    POP {r0}
    BLX ip
    PUSH {r0}
    POP {r0}
    B .L_HAL_DMA_IRQHandler_58
.L_HAL_DMA_IRQHandler_57:
.L_HAL_DMA_IRQHandler_58:
    B .L_HAL_DMA_IRQHandler_56
.L_HAL_DMA_IRQHandler_55:
.loc 1 33625
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #64
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_IRQHandler_59
.loc 1 33628
    LDR r0, [r6, #0]
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #64
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {ip}
    ORR ip, ip, #1
    POP {r0}
    BLX ip
    PUSH {r0}
    POP {r0}
    B .L_HAL_DMA_IRQHandler_60
.L_HAL_DMA_IRQHandler_59:
.L_HAL_DMA_IRQHandler_60:
.L_HAL_DMA_IRQHandler_56:
    B .L_HAL_DMA_IRQHandler_54
.L_HAL_DMA_IRQHandler_53:
.loc 1 33635
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #256
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_IRQHandler_61
.loc 1 33638
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #16
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33641
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #56
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33644
.L_HAL_DMA_IRQHandler_63:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #52
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_DMA_IRQHandler_65:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_DMA_IRQHandler_63
.L_HAL_DMA_IRQHandler_64:
    B .L_HAL_DMA_IRQHandler_62
.L_HAL_DMA_IRQHandler_61:
.L_HAL_DMA_IRQHandler_62:
.loc 1 33647
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #64
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_IRQHandler_66
.loc 1 33650
    LDR r0, [r6, #0]
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #64
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {ip}
    ORR ip, ip, #1
    POP {r0}
    BLX ip
    PUSH {r0}
    POP {r0}
    B .L_HAL_DMA_IRQHandler_67
.L_HAL_DMA_IRQHandler_66:
.L_HAL_DMA_IRQHandler_67:
.L_HAL_DMA_IRQHandler_54:
    B .L_HAL_DMA_IRQHandler_39
.L_HAL_DMA_IRQHandler_38:
.L_HAL_DMA_IRQHandler_39:
    B .L_HAL_DMA_IRQHandler_37
.L_HAL_DMA_IRQHandler_36:
.L_HAL_DMA_IRQHandler_37:
.loc 1 33657
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #88
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_IRQHandler_68
.loc 1 33659
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #88
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_IRQHandler_70
.loc 1 33661
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #56
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #5
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33664
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33666
.L_HAL_DMA_IRQHandler_72:
.loc 1 33668
    LDR r0, [r6, #16]
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_IRQHandler_75
.loc 1 33670
    B .L_HAL_DMA_IRQHandler_73
.L_HAL_DMA_IRQHandler_75:
.L_HAL_DMA_IRQHandler_76:
.L_HAL_DMA_IRQHandler_74:
.loc 1 33673
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_DMA_IRQHandler_72
.L_HAL_DMA_IRQHandler_73:
.loc 1 33676
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #56
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33679
.L_HAL_DMA_IRQHandler_77:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #52
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_DMA_IRQHandler_79:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_DMA_IRQHandler_77
.L_HAL_DMA_IRQHandler_78:
    B .L_HAL_DMA_IRQHandler_71
.L_HAL_DMA_IRQHandler_70:
.L_HAL_DMA_IRQHandler_71:
.loc 1 33682
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #80
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_IRQHandler_80
.loc 1 33685
    LDR r0, [r6, #0]
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #80
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {ip}
    ORR ip, ip, #1
    POP {r0}
    BLX ip
    PUSH {r0}
    POP {r0}
    B .L_HAL_DMA_IRQHandler_81
.L_HAL_DMA_IRQHandler_80:
.L_HAL_DMA_IRQHandler_81:
    B .L_HAL_DMA_IRQHandler_69
.L_HAL_DMA_IRQHandler_68:
.L_HAL_DMA_IRQHandler_69:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #40
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_DMA_IRQHandler, .-HAL_DMA_IRQHandler

.global HAL_DMA_RegisterCallback
.type HAL_DMA_RegisterCallback, %function
HAL_DMA_RegisterCallback:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #40
    MOV r6, sp
.loc 1 33685
    STR r0, [r6, #0]
    STR r1, [r6, #8]
    STR r2, [r6, #16]
.loc 1 33703
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
.loc 1 33706
.L_HAL_DMA_RegisterCallback_0:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #52
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_RegisterCallback_3
    MOV r0, #2
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #40
    POP {r5, r6, r7, pc}
.L_HAL_DMA_RegisterCallback_3:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #52
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_DMA_RegisterCallback_4:
.L_HAL_DMA_RegisterCallback_2:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_DMA_RegisterCallback_0
.L_HAL_DMA_RegisterCallback_1:
.loc 1 33708
    MOV r0, #1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #56
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_RegisterCallback_5
.loc 1 33710
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #32]
    LDR r0, [r6, #32]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_DMA_RegisterCallback_8
    LDR r0, [r6, #32]
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_DMA_RegisterCallback_9
    LDR r0, [r6, #32]
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_DMA_RegisterCallback_10
    LDR r0, [r6, #32]
    PUSH {r0}
    MOV r0, #3
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_DMA_RegisterCallback_11
    LDR r0, [r6, #32]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_DMA_RegisterCallback_12
    LDR r0, [r6, #32]
    PUSH {r0}
    MOV r0, #5
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_DMA_RegisterCallback_13
    B .L_HAL_DMA_RegisterCallback_14
.loc 1 33712
.L_HAL_DMA_RegisterCallback_8:
.loc 1 33713
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #64
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33714
    B .L_HAL_DMA_RegisterCallback_7
.loc 1 33716
.L_HAL_DMA_RegisterCallback_9:
.loc 1 33717
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #68
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33718
    B .L_HAL_DMA_RegisterCallback_7
.loc 1 33720
.L_HAL_DMA_RegisterCallback_10:
.loc 1 33721
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #72
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33722
    B .L_HAL_DMA_RegisterCallback_7
.loc 1 33724
.L_HAL_DMA_RegisterCallback_11:
.loc 1 33725
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #76
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33726
    B .L_HAL_DMA_RegisterCallback_7
.loc 1 33728
.L_HAL_DMA_RegisterCallback_12:
.loc 1 33729
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #80
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33730
    B .L_HAL_DMA_RegisterCallback_7
.loc 1 33732
.L_HAL_DMA_RegisterCallback_13:
.loc 1 33733
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #84
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33734
    B .L_HAL_DMA_RegisterCallback_7
.loc 1 33736
.L_HAL_DMA_RegisterCallback_14:
.loc 1 33738
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
.loc 1 33739
    B .L_HAL_DMA_RegisterCallback_7
.L_HAL_DMA_RegisterCallback_7:
    B .L_HAL_DMA_RegisterCallback_6
.L_HAL_DMA_RegisterCallback_5:
.loc 1 33745
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
.L_HAL_DMA_RegisterCallback_6:
.loc 1 33749
.L_HAL_DMA_RegisterCallback_15:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #52
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_DMA_RegisterCallback_17:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_DMA_RegisterCallback_15
.L_HAL_DMA_RegisterCallback_16:
.loc 1 33751
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #40
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_DMA_RegisterCallback, .-HAL_DMA_RegisterCallback

.global HAL_DMA_UnRegisterCallback
.type HAL_DMA_UnRegisterCallback, %function
HAL_DMA_UnRegisterCallback:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #32
    MOV r6, sp
.loc 1 33751
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 33764
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
.loc 1 33767
.L_HAL_DMA_UnRegisterCallback_0:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #52
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_UnRegisterCallback_3
    MOV r0, #2
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #32
    POP {r5, r6, r7, pc}
.L_HAL_DMA_UnRegisterCallback_3:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #52
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_DMA_UnRegisterCallback_4:
.L_HAL_DMA_UnRegisterCallback_2:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_DMA_UnRegisterCallback_0
.L_HAL_DMA_UnRegisterCallback_1:
.loc 1 33769
    MOV r0, #1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #56
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMA_UnRegisterCallback_5
.loc 1 33771
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
    LDR r0, [r6, #24]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_DMA_UnRegisterCallback_8
    LDR r0, [r6, #24]
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_DMA_UnRegisterCallback_9
    LDR r0, [r6, #24]
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_DMA_UnRegisterCallback_10
    LDR r0, [r6, #24]
    PUSH {r0}
    MOV r0, #3
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_DMA_UnRegisterCallback_11
    LDR r0, [r6, #24]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_DMA_UnRegisterCallback_12
    LDR r0, [r6, #24]
    PUSH {r0}
    MOV r0, #5
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_DMA_UnRegisterCallback_13
    LDR r0, [r6, #24]
    PUSH {r0}
    MOV r0, #6
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_DMA_UnRegisterCallback_14
    B .L_HAL_DMA_UnRegisterCallback_15
.loc 1 33773
.L_HAL_DMA_UnRegisterCallback_8:
.loc 1 33774
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #64
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33775
    B .L_HAL_DMA_UnRegisterCallback_7
.loc 1 33777
.L_HAL_DMA_UnRegisterCallback_9:
.loc 1 33778
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #68
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33779
    B .L_HAL_DMA_UnRegisterCallback_7
.loc 1 33781
.L_HAL_DMA_UnRegisterCallback_10:
.loc 1 33782
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #72
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33783
    B .L_HAL_DMA_UnRegisterCallback_7
.loc 1 33785
.L_HAL_DMA_UnRegisterCallback_11:
.loc 1 33786
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #76
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33787
    B .L_HAL_DMA_UnRegisterCallback_7
.loc 1 33789
.L_HAL_DMA_UnRegisterCallback_12:
.loc 1 33790
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #80
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33791
    B .L_HAL_DMA_UnRegisterCallback_7
.loc 1 33793
.L_HAL_DMA_UnRegisterCallback_13:
.loc 1 33794
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #84
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33795
    B .L_HAL_DMA_UnRegisterCallback_7
.loc 1 33797
.L_HAL_DMA_UnRegisterCallback_14:
.loc 1 33798
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #64
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33799
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #68
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33800
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #72
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33801
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #76
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33802
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #80
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33803
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #84
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33804
    B .L_HAL_DMA_UnRegisterCallback_7
.loc 1 33806
.L_HAL_DMA_UnRegisterCallback_15:
.loc 1 33807
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
.loc 1 33808
    B .L_HAL_DMA_UnRegisterCallback_7
.L_HAL_DMA_UnRegisterCallback_7:
    B .L_HAL_DMA_UnRegisterCallback_6
.L_HAL_DMA_UnRegisterCallback_5:
.loc 1 33813
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
.L_HAL_DMA_UnRegisterCallback_6:
.loc 1 33817
.L_HAL_DMA_UnRegisterCallback_16:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #52
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_DMA_UnRegisterCallback_18:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_DMA_UnRegisterCallback_16
.L_HAL_DMA_UnRegisterCallback_17:
.loc 1 33819
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #32
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_DMA_UnRegisterCallback, .-HAL_DMA_UnRegisterCallback

.global HAL_DMA_GetState
.type HAL_DMA_GetState, %function
HAL_DMA_GetState:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 33819
    STR r0, [r6, #0]
.loc 1 33849
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #56
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_DMA_GetState, .-HAL_DMA_GetState

.global HAL_DMA_GetError
.type HAL_DMA_GetError, %function
HAL_DMA_GetError:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 33849
    STR r0, [r6, #0]
.loc 1 33860
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #88
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_DMA_GetError, .-HAL_DMA_GetError

.global DMA_SetConfig
.type DMA_SetConfig, %function
DMA_SetConfig:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #32
    MOV r6, sp
.loc 1 33860
    STR r0, [r6, #0]
    STR r1, [r6, #8]
    STR r2, [r6, #16]
    STR r3, [r6, #24]
.loc 1 33887
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #0
    MOVT r0, #4
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33890
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33893
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #64
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_DMA_SetConfig_0
.loc 1 33896
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33899
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_DMA_SetConfig_1
.L_DMA_SetConfig_0:
.loc 1 33905
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33908
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_DMA_SetConfig_1:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #32
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size DMA_SetConfig, .-DMA_SetConfig

.global DMA_CalcBaseAndBitshift
.type DMA_CalcBaseAndBitshift, %function
DMA_CalcBaseAndBitshift:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #16
    MOV r6, sp
.loc 1 33908
    STR r0, [r6, #0]
.loc 1 33920
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #255
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    MOV r0, #24
    PUSH {r0}
    POP {r1}
    POP {r0}
    UDIV r0, r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
.loc 1 33924
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #96
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOVW r0, #68
    MOVT r0, #8192
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    LDRB r0, [r0, #0]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 33926
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #3
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_DMA_CalcBaseAndBitshift_0
.loc 1 33929
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #92
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #1023
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_DMA_CalcBaseAndBitshift_1
.L_DMA_CalcBaseAndBitshift_0:
.loc 1 33934
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #92
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #1023
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_DMA_CalcBaseAndBitshift_1:
.loc 1 33937
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #92
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #16
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size DMA_CalcBaseAndBitshift, .-DMA_CalcBaseAndBitshift

.global DMA_CheckFifoParam
.type DMA_CheckFifoParam, %function
DMA_CheckFifoParam:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #32
    MOV r6, sp
.loc 1 33937
    STR r0, [r6, #0]
.loc 1 33948
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
.loc 1 33949
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #36
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    STR r0, [r6, #16]
.loc 1 33952
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #20
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_DMA_CheckFifoParam_0
.loc 1 33954
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
    LDR r0, [r6, #24]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_DMA_CheckFifoParam_3
    LDR r0, [r6, #24]
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_DMA_CheckFifoParam_4
    LDR r0, [r6, #24]
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_DMA_CheckFifoParam_5
    LDR r0, [r6, #24]
    PUSH {r0}
    MOV r0, #3
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_DMA_CheckFifoParam_6
    B .L_DMA_CheckFifoParam_7
.loc 1 33956
.L_DMA_CheckFifoParam_3:
.loc 1 33957
.L_DMA_CheckFifoParam_4:
.loc 1 33958
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #40
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVT r0, #256
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOVW r0, #0
    MOVT r0, #256
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_DMA_CheckFifoParam_8
.loc 1 33960
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    B .L_DMA_CheckFifoParam_9
.L_DMA_CheckFifoParam_8:
.L_DMA_CheckFifoParam_9:
.loc 1 33962
    B .L_DMA_CheckFifoParam_2
.loc 1 33963
.L_DMA_CheckFifoParam_5:
.loc 1 33964
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #40
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVT r0, #384
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_DMA_CheckFifoParam_10
.loc 1 33966
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    B .L_DMA_CheckFifoParam_11
.L_DMA_CheckFifoParam_10:
.L_DMA_CheckFifoParam_11:
.loc 1 33968
    B .L_DMA_CheckFifoParam_2
.loc 1 33969
.L_DMA_CheckFifoParam_6:
.loc 1 33970
    B .L_DMA_CheckFifoParam_2
.loc 1 33971
.L_DMA_CheckFifoParam_7:
.loc 1 33972
    B .L_DMA_CheckFifoParam_2
.L_DMA_CheckFifoParam_2:
    B .L_DMA_CheckFifoParam_1
.L_DMA_CheckFifoParam_0:
.loc 1 33977
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #20
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #8192
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_DMA_CheckFifoParam_12
.loc 1 33979
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
    LDR r0, [r6, #24]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_DMA_CheckFifoParam_15
    LDR r0, [r6, #24]
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_DMA_CheckFifoParam_16
    LDR r0, [r6, #24]
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_DMA_CheckFifoParam_17
    LDR r0, [r6, #24]
    PUSH {r0}
    MOV r0, #3
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_DMA_CheckFifoParam_18
    B .L_DMA_CheckFifoParam_19
.loc 1 33981
.L_DMA_CheckFifoParam_15:
.loc 1 33982
.L_DMA_CheckFifoParam_16:
.loc 1 33983
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 33984
    B .L_DMA_CheckFifoParam_14
.loc 1 33985
.L_DMA_CheckFifoParam_17:
.loc 1 33986
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #40
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVT r0, #256
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOVW r0, #0
    MOVT r0, #256
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_DMA_CheckFifoParam_20
.loc 1 33988
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    B .L_DMA_CheckFifoParam_21
.L_DMA_CheckFifoParam_20:
.L_DMA_CheckFifoParam_21:
.loc 1 33990
    B .L_DMA_CheckFifoParam_14
.loc 1 33991
.L_DMA_CheckFifoParam_18:
.loc 1 33992
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #40
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVT r0, #384
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_DMA_CheckFifoParam_22
.loc 1 33994
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    B .L_DMA_CheckFifoParam_23
.L_DMA_CheckFifoParam_22:
.L_DMA_CheckFifoParam_23:
.loc 1 33996
    B .L_DMA_CheckFifoParam_14
.loc 1 33997
.L_DMA_CheckFifoParam_19:
.loc 1 33998
    B .L_DMA_CheckFifoParam_14
.L_DMA_CheckFifoParam_14:
    B .L_DMA_CheckFifoParam_13
.L_DMA_CheckFifoParam_12:
.loc 1 34005
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
    LDR r0, [r6, #24]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_DMA_CheckFifoParam_25
    LDR r0, [r6, #24]
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_DMA_CheckFifoParam_26
    LDR r0, [r6, #24]
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_DMA_CheckFifoParam_27
    LDR r0, [r6, #24]
    PUSH {r0}
    MOV r0, #3
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_DMA_CheckFifoParam_28
    B .L_DMA_CheckFifoParam_29
.loc 1 34007
.L_DMA_CheckFifoParam_25:
.loc 1 34008
.L_DMA_CheckFifoParam_26:
.loc 1 34009
.L_DMA_CheckFifoParam_27:
.loc 1 34010
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 34011
    B .L_DMA_CheckFifoParam_24
.loc 1 34012
.L_DMA_CheckFifoParam_28:
.loc 1 34013
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #40
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVT r0, #256
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOVW r0, #0
    MOVT r0, #256
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_DMA_CheckFifoParam_30
.loc 1 34015
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    B .L_DMA_CheckFifoParam_31
.L_DMA_CheckFifoParam_30:
.L_DMA_CheckFifoParam_31:
.loc 1 34017
    B .L_DMA_CheckFifoParam_24
.loc 1 34018
.L_DMA_CheckFifoParam_29:
.loc 1 34019
    B .L_DMA_CheckFifoParam_24
.L_DMA_CheckFifoParam_24:
.L_DMA_CheckFifoParam_13:
.L_DMA_CheckFifoParam_1:
.loc 1 34023
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #32
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size DMA_CheckFifoParam, .-DMA_CheckFifoParam

.global HAL_DMAEx_MultiBufferStart
.type HAL_DMAEx_MultiBufferStart, %function
HAL_DMAEx_MultiBufferStart:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #48
    MOV r6, sp
.loc 1 34023
    STR r0, [r6, #0]
    STR r1, [r6, #8]
    STR r2, [r6, #16]
    STR r3, [r6, #24]
    LDR r0, [r6, #64]
    STR r0, [r6, #32]
.loc 1 34232
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #40]
.loc 1 34235
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 34238
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #128
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_0
.loc 1 34240
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #88
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOVW r0, #256
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 34241
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #40]
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
    B .L_HAL_DMAEx_MultiBufferStart_1
.L_HAL_DMAEx_MultiBufferStart_0:
.loc 1 34246
.L_HAL_DMAEx_MultiBufferStart_2:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #52
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_5
    MOV r0, #2
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #48
    POP {r5, r6, r7, pc}
.L_HAL_DMAEx_MultiBufferStart_5:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #52
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_DMAEx_MultiBufferStart_6:
.L_HAL_DMAEx_MultiBufferStart_4:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_DMAEx_MultiBufferStart_2
.L_HAL_DMAEx_MultiBufferStart_3:
.loc 1 34248
    MOV r0, #1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #56
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_7
.loc 1 34251
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #56
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 34254
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #0
    MOVT r0, #4
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
.loc 1 34257
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 34260
    LDR r0, [r6, #32]
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    POP {r1}
    POP {r2}
    POP {r3}
    BL DMA_MultiBufferSetConfig
    PUSH {r0}
    POP {r0}
.loc 1 34263
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
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
    B .L_HAL_DMAEx_MultiBufferStart_8
.L_HAL_DMAEx_MultiBufferStart_7:
.loc 1 34268
    MOV r0, #2
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #40]
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
.L_HAL_DMAEx_MultiBufferStart_8:
.L_HAL_DMAEx_MultiBufferStart_1:
.loc 1 34271
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #48
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_DMAEx_MultiBufferStart, .-HAL_DMAEx_MultiBufferStart

.global HAL_DMAEx_MultiBufferStart_IT
.type HAL_DMAEx_MultiBufferStart_IT, %function
HAL_DMAEx_MultiBufferStart_IT:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #48
    MOV r6, sp
.loc 1 34271
    STR r0, [r6, #0]
    STR r1, [r6, #8]
    STR r2, [r6, #16]
    STR r3, [r6, #24]
    LDR r0, [r6, #64]
    STR r0, [r6, #32]
.loc 1 34286
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #40]
.loc 1 34289
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 34292
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #128
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_0
.loc 1 34294
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #88
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOVW r0, #256
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 34295
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #48
    POP {r5, r6, r7, pc}
.L_HAL_DMAEx_MultiBufferStart_IT_0:
.L_HAL_DMAEx_MultiBufferStart_IT_1:
.loc 1 34299
    MOV r0, #0
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #64
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_DMAEx_MultiBufferStart_IT_6
    MOV r0, #0
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #72
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_7
.L_HAL_DMAEx_MultiBufferStart_IT_6:
    MOV r0, #1
    PUSH {r0}
.L_HAL_DMAEx_MultiBufferStart_IT_7:
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_DMAEx_MultiBufferStart_IT_4
    MOV r0, #0
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #80
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_5
.L_HAL_DMAEx_MultiBufferStart_IT_4:
    MOV r0, #1
    PUSH {r0}
.L_HAL_DMAEx_MultiBufferStart_IT_5:
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_2
.loc 1 34301
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #88
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #64
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 34302
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #48
    POP {r5, r6, r7, pc}
.L_HAL_DMAEx_MultiBufferStart_IT_2:
.L_HAL_DMAEx_MultiBufferStart_IT_3:
.loc 1 34306
.L_HAL_DMAEx_MultiBufferStart_IT_8:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #52
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_11
    MOV r0, #2
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #48
    POP {r5, r6, r7, pc}
.L_HAL_DMAEx_MultiBufferStart_IT_11:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #52
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_DMAEx_MultiBufferStart_IT_12:
.L_HAL_DMAEx_MultiBufferStart_IT_10:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_DMAEx_MultiBufferStart_IT_8
.L_HAL_DMAEx_MultiBufferStart_IT_9:
.loc 1 34308
    MOV r0, #1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #56
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_13
.loc 1 34311
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #56
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 34314
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #88
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 34317
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #0
    MOVT r0, #4
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
.loc 1 34320
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 34323
    LDR r0, [r6, #32]
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    POP {r1}
    POP {r2}
    POP {r3}
    BL DMA_MultiBufferSetConfig
    PUSH {r0}
    POP {r0}
.loc 1 34326
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25688
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_15
    MOVW r0, #25612
    MOVT r0, #16386
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24592
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_17
    MOV r0, #32
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_18
.L_HAL_DMAEx_MultiBufferStart_IT_17:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25616
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_19
    MOV r0, #32
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_20
.L_HAL_DMAEx_MultiBufferStart_IT_19:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24688
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_21
    MOV r0, #32
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_22
.L_HAL_DMAEx_MultiBufferStart_IT_21:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25712
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_23
    MOV r0, #32
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_24
.L_HAL_DMAEx_MultiBufferStart_IT_23:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24616
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_25
    MOVW r0, #2048
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_26
.L_HAL_DMAEx_MultiBufferStart_IT_25:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25640
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_27
    MOVW r0, #2048
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_28
.L_HAL_DMAEx_MultiBufferStart_IT_27:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24712
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_29
    MOVW r0, #2048
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_30
.L_HAL_DMAEx_MultiBufferStart_IT_29:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25736
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_31
    MOVW r0, #2048
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_32
.L_HAL_DMAEx_MultiBufferStart_IT_31:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24640
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_33
    MOVW r0, #0
    MOVT r0, #32
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_34
.L_HAL_DMAEx_MultiBufferStart_IT_33:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25664
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_35
    MOVW r0, #0
    MOVT r0, #32
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_36
.L_HAL_DMAEx_MultiBufferStart_IT_35:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24736
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_37
    MOVW r0, #0
    MOVT r0, #32
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_38
.L_HAL_DMAEx_MultiBufferStart_IT_37:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25760
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_39
    MOVW r0, #0
    MOVT r0, #32
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_40
.L_HAL_DMAEx_MultiBufferStart_IT_39:
    MOVW r0, #0
    MOVT r0, #2048
    PUSH {r0}
.L_HAL_DMAEx_MultiBufferStart_IT_40:
.L_HAL_DMAEx_MultiBufferStart_IT_38:
.L_HAL_DMAEx_MultiBufferStart_IT_36:
.L_HAL_DMAEx_MultiBufferStart_IT_34:
.L_HAL_DMAEx_MultiBufferStart_IT_32:
.L_HAL_DMAEx_MultiBufferStart_IT_30:
.L_HAL_DMAEx_MultiBufferStart_IT_28:
.L_HAL_DMAEx_MultiBufferStart_IT_26:
.L_HAL_DMAEx_MultiBufferStart_IT_24:
.L_HAL_DMAEx_MultiBufferStart_IT_22:
.L_HAL_DMAEx_MultiBufferStart_IT_20:
.L_HAL_DMAEx_MultiBufferStart_IT_18:
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_16
.L_HAL_DMAEx_MultiBufferStart_IT_15:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24760
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_41
    MOVW r0, #25608
    MOVT r0, #16386
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24592
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_43
    MOV r0, #32
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_44
.L_HAL_DMAEx_MultiBufferStart_IT_43:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25616
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_45
    MOV r0, #32
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_46
.L_HAL_DMAEx_MultiBufferStart_IT_45:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24688
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_47
    MOV r0, #32
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_48
.L_HAL_DMAEx_MultiBufferStart_IT_47:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25712
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_49
    MOV r0, #32
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_50
.L_HAL_DMAEx_MultiBufferStart_IT_49:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24616
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_51
    MOVW r0, #2048
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_52
.L_HAL_DMAEx_MultiBufferStart_IT_51:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25640
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_53
    MOVW r0, #2048
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_54
.L_HAL_DMAEx_MultiBufferStart_IT_53:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24712
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_55
    MOVW r0, #2048
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_56
.L_HAL_DMAEx_MultiBufferStart_IT_55:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25736
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_57
    MOVW r0, #2048
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_58
.L_HAL_DMAEx_MultiBufferStart_IT_57:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24640
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_59
    MOVW r0, #0
    MOVT r0, #32
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_60
.L_HAL_DMAEx_MultiBufferStart_IT_59:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25664
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_61
    MOVW r0, #0
    MOVT r0, #32
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_62
.L_HAL_DMAEx_MultiBufferStart_IT_61:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24736
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_63
    MOVW r0, #0
    MOVT r0, #32
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_64
.L_HAL_DMAEx_MultiBufferStart_IT_63:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25760
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_65
    MOVW r0, #0
    MOVT r0, #32
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_66
.L_HAL_DMAEx_MultiBufferStart_IT_65:
    MOVW r0, #0
    MOVT r0, #2048
    PUSH {r0}
.L_HAL_DMAEx_MultiBufferStart_IT_66:
.L_HAL_DMAEx_MultiBufferStart_IT_64:
.L_HAL_DMAEx_MultiBufferStart_IT_62:
.L_HAL_DMAEx_MultiBufferStart_IT_60:
.L_HAL_DMAEx_MultiBufferStart_IT_58:
.L_HAL_DMAEx_MultiBufferStart_IT_56:
.L_HAL_DMAEx_MultiBufferStart_IT_54:
.L_HAL_DMAEx_MultiBufferStart_IT_52:
.L_HAL_DMAEx_MultiBufferStart_IT_50:
.L_HAL_DMAEx_MultiBufferStart_IT_48:
.L_HAL_DMAEx_MultiBufferStart_IT_46:
.L_HAL_DMAEx_MultiBufferStart_IT_44:
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_42
.L_HAL_DMAEx_MultiBufferStart_IT_41:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24664
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_67
    MOVW r0, #24588
    MOVT r0, #16386
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24592
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_69
    MOV r0, #32
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_70
.L_HAL_DMAEx_MultiBufferStart_IT_69:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25616
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_71
    MOV r0, #32
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_72
.L_HAL_DMAEx_MultiBufferStart_IT_71:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24688
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_73
    MOV r0, #32
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_74
.L_HAL_DMAEx_MultiBufferStart_IT_73:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25712
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_75
    MOV r0, #32
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_76
.L_HAL_DMAEx_MultiBufferStart_IT_75:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24616
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_77
    MOVW r0, #2048
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_78
.L_HAL_DMAEx_MultiBufferStart_IT_77:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25640
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_79
    MOVW r0, #2048
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_80
.L_HAL_DMAEx_MultiBufferStart_IT_79:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24712
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_81
    MOVW r0, #2048
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_82
.L_HAL_DMAEx_MultiBufferStart_IT_81:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25736
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_83
    MOVW r0, #2048
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_84
.L_HAL_DMAEx_MultiBufferStart_IT_83:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24640
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_85
    MOVW r0, #0
    MOVT r0, #32
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_86
.L_HAL_DMAEx_MultiBufferStart_IT_85:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25664
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_87
    MOVW r0, #0
    MOVT r0, #32
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_88
.L_HAL_DMAEx_MultiBufferStart_IT_87:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24736
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_89
    MOVW r0, #0
    MOVT r0, #32
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_90
.L_HAL_DMAEx_MultiBufferStart_IT_89:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25760
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_91
    MOVW r0, #0
    MOVT r0, #32
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_92
.L_HAL_DMAEx_MultiBufferStart_IT_91:
    MOVW r0, #0
    MOVT r0, #2048
    PUSH {r0}
.L_HAL_DMAEx_MultiBufferStart_IT_92:
.L_HAL_DMAEx_MultiBufferStart_IT_90:
.L_HAL_DMAEx_MultiBufferStart_IT_88:
.L_HAL_DMAEx_MultiBufferStart_IT_86:
.L_HAL_DMAEx_MultiBufferStart_IT_84:
.L_HAL_DMAEx_MultiBufferStart_IT_82:
.L_HAL_DMAEx_MultiBufferStart_IT_80:
.L_HAL_DMAEx_MultiBufferStart_IT_78:
.L_HAL_DMAEx_MultiBufferStart_IT_76:
.L_HAL_DMAEx_MultiBufferStart_IT_74:
.L_HAL_DMAEx_MultiBufferStart_IT_72:
.L_HAL_DMAEx_MultiBufferStart_IT_70:
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_68
.L_HAL_DMAEx_MultiBufferStart_IT_67:
    MOVW r0, #24584
    MOVT r0, #16386
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24592
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_93
    MOV r0, #32
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_94
.L_HAL_DMAEx_MultiBufferStart_IT_93:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25616
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_95
    MOV r0, #32
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_96
.L_HAL_DMAEx_MultiBufferStart_IT_95:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24688
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_97
    MOV r0, #32
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_98
.L_HAL_DMAEx_MultiBufferStart_IT_97:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25712
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_99
    MOV r0, #32
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_100
.L_HAL_DMAEx_MultiBufferStart_IT_99:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24616
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_101
    MOVW r0, #2048
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_102
.L_HAL_DMAEx_MultiBufferStart_IT_101:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25640
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_103
    MOVW r0, #2048
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_104
.L_HAL_DMAEx_MultiBufferStart_IT_103:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24712
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_105
    MOVW r0, #2048
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_106
.L_HAL_DMAEx_MultiBufferStart_IT_105:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25736
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_107
    MOVW r0, #2048
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_108
.L_HAL_DMAEx_MultiBufferStart_IT_107:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24640
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_109
    MOVW r0, #0
    MOVT r0, #32
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_110
.L_HAL_DMAEx_MultiBufferStart_IT_109:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25664
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_111
    MOVW r0, #0
    MOVT r0, #32
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_112
.L_HAL_DMAEx_MultiBufferStart_IT_111:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24736
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_113
    MOVW r0, #0
    MOVT r0, #32
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_114
.L_HAL_DMAEx_MultiBufferStart_IT_113:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25760
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_115
    MOVW r0, #0
    MOVT r0, #32
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_116
.L_HAL_DMAEx_MultiBufferStart_IT_115:
    MOVW r0, #0
    MOVT r0, #2048
    PUSH {r0}
.L_HAL_DMAEx_MultiBufferStart_IT_116:
.L_HAL_DMAEx_MultiBufferStart_IT_114:
.L_HAL_DMAEx_MultiBufferStart_IT_112:
.L_HAL_DMAEx_MultiBufferStart_IT_110:
.L_HAL_DMAEx_MultiBufferStart_IT_108:
.L_HAL_DMAEx_MultiBufferStart_IT_106:
.L_HAL_DMAEx_MultiBufferStart_IT_104:
.L_HAL_DMAEx_MultiBufferStart_IT_102:
.L_HAL_DMAEx_MultiBufferStart_IT_100:
.L_HAL_DMAEx_MultiBufferStart_IT_98:
.L_HAL_DMAEx_MultiBufferStart_IT_96:
.L_HAL_DMAEx_MultiBufferStart_IT_94:
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
.L_HAL_DMAEx_MultiBufferStart_IT_68:
.L_HAL_DMAEx_MultiBufferStart_IT_42:
.L_HAL_DMAEx_MultiBufferStart_IT_16:
    POP {r0}
.loc 1 34327
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25688
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_117
    MOVW r0, #25612
    MOVT r0, #16386
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24592
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_119
    MOV r0, #16
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_120
.L_HAL_DMAEx_MultiBufferStart_IT_119:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25616
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_121
    MOV r0, #16
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_122
.L_HAL_DMAEx_MultiBufferStart_IT_121:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24688
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_123
    MOV r0, #16
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_124
.L_HAL_DMAEx_MultiBufferStart_IT_123:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25712
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_125
    MOV r0, #16
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_126
.L_HAL_DMAEx_MultiBufferStart_IT_125:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24616
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_127
    MOVW r0, #1024
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_128
.L_HAL_DMAEx_MultiBufferStart_IT_127:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25640
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_129
    MOVW r0, #1024
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_130
.L_HAL_DMAEx_MultiBufferStart_IT_129:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24712
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_131
    MOVW r0, #1024
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_132
.L_HAL_DMAEx_MultiBufferStart_IT_131:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25736
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_133
    MOVW r0, #1024
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_134
.L_HAL_DMAEx_MultiBufferStart_IT_133:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24640
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_135
    MOVW r0, #0
    MOVT r0, #16
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_136
.L_HAL_DMAEx_MultiBufferStart_IT_135:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25664
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_137
    MOVW r0, #0
    MOVT r0, #16
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_138
.L_HAL_DMAEx_MultiBufferStart_IT_137:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24736
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_139
    MOVW r0, #0
    MOVT r0, #16
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_140
.L_HAL_DMAEx_MultiBufferStart_IT_139:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25760
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_141
    MOVW r0, #0
    MOVT r0, #16
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_142
.L_HAL_DMAEx_MultiBufferStart_IT_141:
    MOVW r0, #0
    MOVT r0, #1024
    PUSH {r0}
.L_HAL_DMAEx_MultiBufferStart_IT_142:
.L_HAL_DMAEx_MultiBufferStart_IT_140:
.L_HAL_DMAEx_MultiBufferStart_IT_138:
.L_HAL_DMAEx_MultiBufferStart_IT_136:
.L_HAL_DMAEx_MultiBufferStart_IT_134:
.L_HAL_DMAEx_MultiBufferStart_IT_132:
.L_HAL_DMAEx_MultiBufferStart_IT_130:
.L_HAL_DMAEx_MultiBufferStart_IT_128:
.L_HAL_DMAEx_MultiBufferStart_IT_126:
.L_HAL_DMAEx_MultiBufferStart_IT_124:
.L_HAL_DMAEx_MultiBufferStart_IT_122:
.L_HAL_DMAEx_MultiBufferStart_IT_120:
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_118
.L_HAL_DMAEx_MultiBufferStart_IT_117:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24760
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_143
    MOVW r0, #25608
    MOVT r0, #16386
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24592
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_145
    MOV r0, #16
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_146
.L_HAL_DMAEx_MultiBufferStart_IT_145:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25616
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_147
    MOV r0, #16
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_148
.L_HAL_DMAEx_MultiBufferStart_IT_147:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24688
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_149
    MOV r0, #16
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_150
.L_HAL_DMAEx_MultiBufferStart_IT_149:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25712
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_151
    MOV r0, #16
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_152
.L_HAL_DMAEx_MultiBufferStart_IT_151:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24616
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_153
    MOVW r0, #1024
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_154
.L_HAL_DMAEx_MultiBufferStart_IT_153:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25640
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_155
    MOVW r0, #1024
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_156
.L_HAL_DMAEx_MultiBufferStart_IT_155:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24712
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_157
    MOVW r0, #1024
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_158
.L_HAL_DMAEx_MultiBufferStart_IT_157:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25736
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_159
    MOVW r0, #1024
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_160
.L_HAL_DMAEx_MultiBufferStart_IT_159:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24640
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_161
    MOVW r0, #0
    MOVT r0, #16
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_162
.L_HAL_DMAEx_MultiBufferStart_IT_161:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25664
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_163
    MOVW r0, #0
    MOVT r0, #16
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_164
.L_HAL_DMAEx_MultiBufferStart_IT_163:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24736
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_165
    MOVW r0, #0
    MOVT r0, #16
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_166
.L_HAL_DMAEx_MultiBufferStart_IT_165:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25760
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_167
    MOVW r0, #0
    MOVT r0, #16
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_168
.L_HAL_DMAEx_MultiBufferStart_IT_167:
    MOVW r0, #0
    MOVT r0, #1024
    PUSH {r0}
.L_HAL_DMAEx_MultiBufferStart_IT_168:
.L_HAL_DMAEx_MultiBufferStart_IT_166:
.L_HAL_DMAEx_MultiBufferStart_IT_164:
.L_HAL_DMAEx_MultiBufferStart_IT_162:
.L_HAL_DMAEx_MultiBufferStart_IT_160:
.L_HAL_DMAEx_MultiBufferStart_IT_158:
.L_HAL_DMAEx_MultiBufferStart_IT_156:
.L_HAL_DMAEx_MultiBufferStart_IT_154:
.L_HAL_DMAEx_MultiBufferStart_IT_152:
.L_HAL_DMAEx_MultiBufferStart_IT_150:
.L_HAL_DMAEx_MultiBufferStart_IT_148:
.L_HAL_DMAEx_MultiBufferStart_IT_146:
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_144
.L_HAL_DMAEx_MultiBufferStart_IT_143:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24664
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_169
    MOVW r0, #24588
    MOVT r0, #16386
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24592
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_171
    MOV r0, #16
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_172
.L_HAL_DMAEx_MultiBufferStart_IT_171:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25616
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_173
    MOV r0, #16
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_174
.L_HAL_DMAEx_MultiBufferStart_IT_173:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24688
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_175
    MOV r0, #16
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_176
.L_HAL_DMAEx_MultiBufferStart_IT_175:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25712
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_177
    MOV r0, #16
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_178
.L_HAL_DMAEx_MultiBufferStart_IT_177:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24616
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_179
    MOVW r0, #1024
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_180
.L_HAL_DMAEx_MultiBufferStart_IT_179:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25640
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_181
    MOVW r0, #1024
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_182
.L_HAL_DMAEx_MultiBufferStart_IT_181:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24712
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_183
    MOVW r0, #1024
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_184
.L_HAL_DMAEx_MultiBufferStart_IT_183:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25736
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_185
    MOVW r0, #1024
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_186
.L_HAL_DMAEx_MultiBufferStart_IT_185:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24640
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_187
    MOVW r0, #0
    MOVT r0, #16
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_188
.L_HAL_DMAEx_MultiBufferStart_IT_187:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25664
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_189
    MOVW r0, #0
    MOVT r0, #16
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_190
.L_HAL_DMAEx_MultiBufferStart_IT_189:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24736
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_191
    MOVW r0, #0
    MOVT r0, #16
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_192
.L_HAL_DMAEx_MultiBufferStart_IT_191:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25760
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_193
    MOVW r0, #0
    MOVT r0, #16
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_194
.L_HAL_DMAEx_MultiBufferStart_IT_193:
    MOVW r0, #0
    MOVT r0, #1024
    PUSH {r0}
.L_HAL_DMAEx_MultiBufferStart_IT_194:
.L_HAL_DMAEx_MultiBufferStart_IT_192:
.L_HAL_DMAEx_MultiBufferStart_IT_190:
.L_HAL_DMAEx_MultiBufferStart_IT_188:
.L_HAL_DMAEx_MultiBufferStart_IT_186:
.L_HAL_DMAEx_MultiBufferStart_IT_184:
.L_HAL_DMAEx_MultiBufferStart_IT_182:
.L_HAL_DMAEx_MultiBufferStart_IT_180:
.L_HAL_DMAEx_MultiBufferStart_IT_178:
.L_HAL_DMAEx_MultiBufferStart_IT_176:
.L_HAL_DMAEx_MultiBufferStart_IT_174:
.L_HAL_DMAEx_MultiBufferStart_IT_172:
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_170
.L_HAL_DMAEx_MultiBufferStart_IT_169:
    MOVW r0, #24584
    MOVT r0, #16386
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24592
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_195
    MOV r0, #16
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_196
.L_HAL_DMAEx_MultiBufferStart_IT_195:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25616
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_197
    MOV r0, #16
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_198
.L_HAL_DMAEx_MultiBufferStart_IT_197:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24688
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_199
    MOV r0, #16
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_200
.L_HAL_DMAEx_MultiBufferStart_IT_199:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25712
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_201
    MOV r0, #16
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_202
.L_HAL_DMAEx_MultiBufferStart_IT_201:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24616
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_203
    MOVW r0, #1024
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_204
.L_HAL_DMAEx_MultiBufferStart_IT_203:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25640
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_205
    MOVW r0, #1024
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_206
.L_HAL_DMAEx_MultiBufferStart_IT_205:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24712
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_207
    MOVW r0, #1024
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_208
.L_HAL_DMAEx_MultiBufferStart_IT_207:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25736
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_209
    MOVW r0, #1024
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_210
.L_HAL_DMAEx_MultiBufferStart_IT_209:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24640
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_211
    MOVW r0, #0
    MOVT r0, #16
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_212
.L_HAL_DMAEx_MultiBufferStart_IT_211:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25664
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_213
    MOVW r0, #0
    MOVT r0, #16
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_214
.L_HAL_DMAEx_MultiBufferStart_IT_213:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24736
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_215
    MOVW r0, #0
    MOVT r0, #16
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_216
.L_HAL_DMAEx_MultiBufferStart_IT_215:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25760
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_217
    MOVW r0, #0
    MOVT r0, #16
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_218
.L_HAL_DMAEx_MultiBufferStart_IT_217:
    MOVW r0, #0
    MOVT r0, #1024
    PUSH {r0}
.L_HAL_DMAEx_MultiBufferStart_IT_218:
.L_HAL_DMAEx_MultiBufferStart_IT_216:
.L_HAL_DMAEx_MultiBufferStart_IT_214:
.L_HAL_DMAEx_MultiBufferStart_IT_212:
.L_HAL_DMAEx_MultiBufferStart_IT_210:
.L_HAL_DMAEx_MultiBufferStart_IT_208:
.L_HAL_DMAEx_MultiBufferStart_IT_206:
.L_HAL_DMAEx_MultiBufferStart_IT_204:
.L_HAL_DMAEx_MultiBufferStart_IT_202:
.L_HAL_DMAEx_MultiBufferStart_IT_200:
.L_HAL_DMAEx_MultiBufferStart_IT_198:
.L_HAL_DMAEx_MultiBufferStart_IT_196:
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
.L_HAL_DMAEx_MultiBufferStart_IT_170:
.L_HAL_DMAEx_MultiBufferStart_IT_144:
.L_HAL_DMAEx_MultiBufferStart_IT_118:
    POP {r0}
.loc 1 34328
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25688
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_219
    MOVW r0, #25612
    MOVT r0, #16386
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24592
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_221
    MOV r0, #8
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_222
.L_HAL_DMAEx_MultiBufferStart_IT_221:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25616
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_223
    MOV r0, #8
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_224
.L_HAL_DMAEx_MultiBufferStart_IT_223:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24688
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_225
    MOV r0, #8
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_226
.L_HAL_DMAEx_MultiBufferStart_IT_225:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25712
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_227
    MOV r0, #8
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_228
.L_HAL_DMAEx_MultiBufferStart_IT_227:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24616
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_229
    MOVW r0, #512
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_230
.L_HAL_DMAEx_MultiBufferStart_IT_229:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25640
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_231
    MOVW r0, #512
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_232
.L_HAL_DMAEx_MultiBufferStart_IT_231:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24712
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_233
    MOVW r0, #512
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_234
.L_HAL_DMAEx_MultiBufferStart_IT_233:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25736
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_235
    MOVW r0, #512
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_236
.L_HAL_DMAEx_MultiBufferStart_IT_235:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24640
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_237
    MOVW r0, #0
    MOVT r0, #8
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_238
.L_HAL_DMAEx_MultiBufferStart_IT_237:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25664
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_239
    MOVW r0, #0
    MOVT r0, #8
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_240
.L_HAL_DMAEx_MultiBufferStart_IT_239:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24736
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_241
    MOVW r0, #0
    MOVT r0, #8
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_242
.L_HAL_DMAEx_MultiBufferStart_IT_241:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25760
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_243
    MOVW r0, #0
    MOVT r0, #8
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_244
.L_HAL_DMAEx_MultiBufferStart_IT_243:
    MOVW r0, #0
    MOVT r0, #512
    PUSH {r0}
.L_HAL_DMAEx_MultiBufferStart_IT_244:
.L_HAL_DMAEx_MultiBufferStart_IT_242:
.L_HAL_DMAEx_MultiBufferStart_IT_240:
.L_HAL_DMAEx_MultiBufferStart_IT_238:
.L_HAL_DMAEx_MultiBufferStart_IT_236:
.L_HAL_DMAEx_MultiBufferStart_IT_234:
.L_HAL_DMAEx_MultiBufferStart_IT_232:
.L_HAL_DMAEx_MultiBufferStart_IT_230:
.L_HAL_DMAEx_MultiBufferStart_IT_228:
.L_HAL_DMAEx_MultiBufferStart_IT_226:
.L_HAL_DMAEx_MultiBufferStart_IT_224:
.L_HAL_DMAEx_MultiBufferStart_IT_222:
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_220
.L_HAL_DMAEx_MultiBufferStart_IT_219:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24760
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_245
    MOVW r0, #25608
    MOVT r0, #16386
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24592
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_247
    MOV r0, #8
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_248
.L_HAL_DMAEx_MultiBufferStart_IT_247:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25616
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_249
    MOV r0, #8
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_250
.L_HAL_DMAEx_MultiBufferStart_IT_249:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24688
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_251
    MOV r0, #8
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_252
.L_HAL_DMAEx_MultiBufferStart_IT_251:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25712
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_253
    MOV r0, #8
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_254
.L_HAL_DMAEx_MultiBufferStart_IT_253:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24616
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_255
    MOVW r0, #512
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_256
.L_HAL_DMAEx_MultiBufferStart_IT_255:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25640
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_257
    MOVW r0, #512
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_258
.L_HAL_DMAEx_MultiBufferStart_IT_257:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24712
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_259
    MOVW r0, #512
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_260
.L_HAL_DMAEx_MultiBufferStart_IT_259:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25736
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_261
    MOVW r0, #512
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_262
.L_HAL_DMAEx_MultiBufferStart_IT_261:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24640
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_263
    MOVW r0, #0
    MOVT r0, #8
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_264
.L_HAL_DMAEx_MultiBufferStart_IT_263:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25664
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_265
    MOVW r0, #0
    MOVT r0, #8
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_266
.L_HAL_DMAEx_MultiBufferStart_IT_265:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24736
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_267
    MOVW r0, #0
    MOVT r0, #8
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_268
.L_HAL_DMAEx_MultiBufferStart_IT_267:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25760
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_269
    MOVW r0, #0
    MOVT r0, #8
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_270
.L_HAL_DMAEx_MultiBufferStart_IT_269:
    MOVW r0, #0
    MOVT r0, #512
    PUSH {r0}
.L_HAL_DMAEx_MultiBufferStart_IT_270:
.L_HAL_DMAEx_MultiBufferStart_IT_268:
.L_HAL_DMAEx_MultiBufferStart_IT_266:
.L_HAL_DMAEx_MultiBufferStart_IT_264:
.L_HAL_DMAEx_MultiBufferStart_IT_262:
.L_HAL_DMAEx_MultiBufferStart_IT_260:
.L_HAL_DMAEx_MultiBufferStart_IT_258:
.L_HAL_DMAEx_MultiBufferStart_IT_256:
.L_HAL_DMAEx_MultiBufferStart_IT_254:
.L_HAL_DMAEx_MultiBufferStart_IT_252:
.L_HAL_DMAEx_MultiBufferStart_IT_250:
.L_HAL_DMAEx_MultiBufferStart_IT_248:
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_246
.L_HAL_DMAEx_MultiBufferStart_IT_245:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24664
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_271
    MOVW r0, #24588
    MOVT r0, #16386
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24592
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_273
    MOV r0, #8
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_274
.L_HAL_DMAEx_MultiBufferStart_IT_273:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25616
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_275
    MOV r0, #8
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_276
.L_HAL_DMAEx_MultiBufferStart_IT_275:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24688
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_277
    MOV r0, #8
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_278
.L_HAL_DMAEx_MultiBufferStart_IT_277:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25712
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_279
    MOV r0, #8
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_280
.L_HAL_DMAEx_MultiBufferStart_IT_279:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24616
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_281
    MOVW r0, #512
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_282
.L_HAL_DMAEx_MultiBufferStart_IT_281:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25640
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_283
    MOVW r0, #512
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_284
.L_HAL_DMAEx_MultiBufferStart_IT_283:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24712
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_285
    MOVW r0, #512
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_286
.L_HAL_DMAEx_MultiBufferStart_IT_285:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25736
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_287
    MOVW r0, #512
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_288
.L_HAL_DMAEx_MultiBufferStart_IT_287:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24640
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_289
    MOVW r0, #0
    MOVT r0, #8
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_290
.L_HAL_DMAEx_MultiBufferStart_IT_289:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25664
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_291
    MOVW r0, #0
    MOVT r0, #8
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_292
.L_HAL_DMAEx_MultiBufferStart_IT_291:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24736
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_293
    MOVW r0, #0
    MOVT r0, #8
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_294
.L_HAL_DMAEx_MultiBufferStart_IT_293:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25760
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_295
    MOVW r0, #0
    MOVT r0, #8
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_296
.L_HAL_DMAEx_MultiBufferStart_IT_295:
    MOVW r0, #0
    MOVT r0, #512
    PUSH {r0}
.L_HAL_DMAEx_MultiBufferStart_IT_296:
.L_HAL_DMAEx_MultiBufferStart_IT_294:
.L_HAL_DMAEx_MultiBufferStart_IT_292:
.L_HAL_DMAEx_MultiBufferStart_IT_290:
.L_HAL_DMAEx_MultiBufferStart_IT_288:
.L_HAL_DMAEx_MultiBufferStart_IT_286:
.L_HAL_DMAEx_MultiBufferStart_IT_284:
.L_HAL_DMAEx_MultiBufferStart_IT_282:
.L_HAL_DMAEx_MultiBufferStart_IT_280:
.L_HAL_DMAEx_MultiBufferStart_IT_278:
.L_HAL_DMAEx_MultiBufferStart_IT_276:
.L_HAL_DMAEx_MultiBufferStart_IT_274:
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_272
.L_HAL_DMAEx_MultiBufferStart_IT_271:
    MOVW r0, #24584
    MOVT r0, #16386
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24592
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_297
    MOV r0, #8
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_298
.L_HAL_DMAEx_MultiBufferStart_IT_297:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25616
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_299
    MOV r0, #8
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_300
.L_HAL_DMAEx_MultiBufferStart_IT_299:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24688
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_301
    MOV r0, #8
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_302
.L_HAL_DMAEx_MultiBufferStart_IT_301:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25712
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_303
    MOV r0, #8
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_304
.L_HAL_DMAEx_MultiBufferStart_IT_303:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24616
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_305
    MOVW r0, #512
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_306
.L_HAL_DMAEx_MultiBufferStart_IT_305:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25640
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_307
    MOVW r0, #512
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_308
.L_HAL_DMAEx_MultiBufferStart_IT_307:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24712
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_309
    MOVW r0, #512
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_310
.L_HAL_DMAEx_MultiBufferStart_IT_309:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25736
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_311
    MOVW r0, #512
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_312
.L_HAL_DMAEx_MultiBufferStart_IT_311:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24640
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_313
    MOVW r0, #0
    MOVT r0, #8
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_314
.L_HAL_DMAEx_MultiBufferStart_IT_313:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25664
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_315
    MOVW r0, #0
    MOVT r0, #8
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_316
.L_HAL_DMAEx_MultiBufferStart_IT_315:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24736
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_317
    MOVW r0, #0
    MOVT r0, #8
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_318
.L_HAL_DMAEx_MultiBufferStart_IT_317:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25760
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_319
    MOVW r0, #0
    MOVT r0, #8
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_320
.L_HAL_DMAEx_MultiBufferStart_IT_319:
    MOVW r0, #0
    MOVT r0, #512
    PUSH {r0}
.L_HAL_DMAEx_MultiBufferStart_IT_320:
.L_HAL_DMAEx_MultiBufferStart_IT_318:
.L_HAL_DMAEx_MultiBufferStart_IT_316:
.L_HAL_DMAEx_MultiBufferStart_IT_314:
.L_HAL_DMAEx_MultiBufferStart_IT_312:
.L_HAL_DMAEx_MultiBufferStart_IT_310:
.L_HAL_DMAEx_MultiBufferStart_IT_308:
.L_HAL_DMAEx_MultiBufferStart_IT_306:
.L_HAL_DMAEx_MultiBufferStart_IT_304:
.L_HAL_DMAEx_MultiBufferStart_IT_302:
.L_HAL_DMAEx_MultiBufferStart_IT_300:
.L_HAL_DMAEx_MultiBufferStart_IT_298:
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
.L_HAL_DMAEx_MultiBufferStart_IT_272:
.L_HAL_DMAEx_MultiBufferStart_IT_246:
.L_HAL_DMAEx_MultiBufferStart_IT_220:
    POP {r0}
.loc 1 34329
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25688
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_321
    MOVW r0, #25612
    MOVT r0, #16386
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24592
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_323
    MOV r0, #4
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_324
.L_HAL_DMAEx_MultiBufferStart_IT_323:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25616
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_325
    MOV r0, #4
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_326
.L_HAL_DMAEx_MultiBufferStart_IT_325:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24688
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_327
    MOV r0, #4
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_328
.L_HAL_DMAEx_MultiBufferStart_IT_327:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25712
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_329
    MOV r0, #4
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_330
.L_HAL_DMAEx_MultiBufferStart_IT_329:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24616
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_331
    MOVW r0, #256
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_332
.L_HAL_DMAEx_MultiBufferStart_IT_331:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25640
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_333
    MOVW r0, #256
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_334
.L_HAL_DMAEx_MultiBufferStart_IT_333:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24712
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_335
    MOVW r0, #256
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_336
.L_HAL_DMAEx_MultiBufferStart_IT_335:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25736
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_337
    MOVW r0, #256
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_338
.L_HAL_DMAEx_MultiBufferStart_IT_337:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24640
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_339
    MOVW r0, #0
    MOVT r0, #4
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_340
.L_HAL_DMAEx_MultiBufferStart_IT_339:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25664
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_341
    MOVW r0, #0
    MOVT r0, #4
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_342
.L_HAL_DMAEx_MultiBufferStart_IT_341:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24736
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_343
    MOVW r0, #0
    MOVT r0, #4
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_344
.L_HAL_DMAEx_MultiBufferStart_IT_343:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25760
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_345
    MOVW r0, #0
    MOVT r0, #4
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_346
.L_HAL_DMAEx_MultiBufferStart_IT_345:
    MOVW r0, #0
    MOVT r0, #256
    PUSH {r0}
.L_HAL_DMAEx_MultiBufferStart_IT_346:
.L_HAL_DMAEx_MultiBufferStart_IT_344:
.L_HAL_DMAEx_MultiBufferStart_IT_342:
.L_HAL_DMAEx_MultiBufferStart_IT_340:
.L_HAL_DMAEx_MultiBufferStart_IT_338:
.L_HAL_DMAEx_MultiBufferStart_IT_336:
.L_HAL_DMAEx_MultiBufferStart_IT_334:
.L_HAL_DMAEx_MultiBufferStart_IT_332:
.L_HAL_DMAEx_MultiBufferStart_IT_330:
.L_HAL_DMAEx_MultiBufferStart_IT_328:
.L_HAL_DMAEx_MultiBufferStart_IT_326:
.L_HAL_DMAEx_MultiBufferStart_IT_324:
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_322
.L_HAL_DMAEx_MultiBufferStart_IT_321:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24760
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_347
    MOVW r0, #25608
    MOVT r0, #16386
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24592
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_349
    MOV r0, #4
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_350
.L_HAL_DMAEx_MultiBufferStart_IT_349:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25616
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_351
    MOV r0, #4
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_352
.L_HAL_DMAEx_MultiBufferStart_IT_351:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24688
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_353
    MOV r0, #4
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_354
.L_HAL_DMAEx_MultiBufferStart_IT_353:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25712
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_355
    MOV r0, #4
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_356
.L_HAL_DMAEx_MultiBufferStart_IT_355:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24616
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_357
    MOVW r0, #256
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_358
.L_HAL_DMAEx_MultiBufferStart_IT_357:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25640
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_359
    MOVW r0, #256
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_360
.L_HAL_DMAEx_MultiBufferStart_IT_359:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24712
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_361
    MOVW r0, #256
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_362
.L_HAL_DMAEx_MultiBufferStart_IT_361:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25736
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_363
    MOVW r0, #256
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_364
.L_HAL_DMAEx_MultiBufferStart_IT_363:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24640
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_365
    MOVW r0, #0
    MOVT r0, #4
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_366
.L_HAL_DMAEx_MultiBufferStart_IT_365:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25664
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_367
    MOVW r0, #0
    MOVT r0, #4
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_368
.L_HAL_DMAEx_MultiBufferStart_IT_367:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24736
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_369
    MOVW r0, #0
    MOVT r0, #4
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_370
.L_HAL_DMAEx_MultiBufferStart_IT_369:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25760
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_371
    MOVW r0, #0
    MOVT r0, #4
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_372
.L_HAL_DMAEx_MultiBufferStart_IT_371:
    MOVW r0, #0
    MOVT r0, #256
    PUSH {r0}
.L_HAL_DMAEx_MultiBufferStart_IT_372:
.L_HAL_DMAEx_MultiBufferStart_IT_370:
.L_HAL_DMAEx_MultiBufferStart_IT_368:
.L_HAL_DMAEx_MultiBufferStart_IT_366:
.L_HAL_DMAEx_MultiBufferStart_IT_364:
.L_HAL_DMAEx_MultiBufferStart_IT_362:
.L_HAL_DMAEx_MultiBufferStart_IT_360:
.L_HAL_DMAEx_MultiBufferStart_IT_358:
.L_HAL_DMAEx_MultiBufferStart_IT_356:
.L_HAL_DMAEx_MultiBufferStart_IT_354:
.L_HAL_DMAEx_MultiBufferStart_IT_352:
.L_HAL_DMAEx_MultiBufferStart_IT_350:
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_348
.L_HAL_DMAEx_MultiBufferStart_IT_347:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24664
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_373
    MOVW r0, #24588
    MOVT r0, #16386
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24592
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_375
    MOV r0, #4
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_376
.L_HAL_DMAEx_MultiBufferStart_IT_375:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25616
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_377
    MOV r0, #4
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_378
.L_HAL_DMAEx_MultiBufferStart_IT_377:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24688
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_379
    MOV r0, #4
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_380
.L_HAL_DMAEx_MultiBufferStart_IT_379:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25712
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_381
    MOV r0, #4
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_382
.L_HAL_DMAEx_MultiBufferStart_IT_381:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24616
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_383
    MOVW r0, #256
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_384
.L_HAL_DMAEx_MultiBufferStart_IT_383:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25640
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_385
    MOVW r0, #256
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_386
.L_HAL_DMAEx_MultiBufferStart_IT_385:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24712
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_387
    MOVW r0, #256
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_388
.L_HAL_DMAEx_MultiBufferStart_IT_387:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25736
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_389
    MOVW r0, #256
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_390
.L_HAL_DMAEx_MultiBufferStart_IT_389:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24640
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_391
    MOVW r0, #0
    MOVT r0, #4
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_392
.L_HAL_DMAEx_MultiBufferStart_IT_391:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25664
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_393
    MOVW r0, #0
    MOVT r0, #4
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_394
.L_HAL_DMAEx_MultiBufferStart_IT_393:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24736
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_395
    MOVW r0, #0
    MOVT r0, #4
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_396
.L_HAL_DMAEx_MultiBufferStart_IT_395:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25760
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_397
    MOVW r0, #0
    MOVT r0, #4
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_398
.L_HAL_DMAEx_MultiBufferStart_IT_397:
    MOVW r0, #0
    MOVT r0, #256
    PUSH {r0}
.L_HAL_DMAEx_MultiBufferStart_IT_398:
.L_HAL_DMAEx_MultiBufferStart_IT_396:
.L_HAL_DMAEx_MultiBufferStart_IT_394:
.L_HAL_DMAEx_MultiBufferStart_IT_392:
.L_HAL_DMAEx_MultiBufferStart_IT_390:
.L_HAL_DMAEx_MultiBufferStart_IT_388:
.L_HAL_DMAEx_MultiBufferStart_IT_386:
.L_HAL_DMAEx_MultiBufferStart_IT_384:
.L_HAL_DMAEx_MultiBufferStart_IT_382:
.L_HAL_DMAEx_MultiBufferStart_IT_380:
.L_HAL_DMAEx_MultiBufferStart_IT_378:
.L_HAL_DMAEx_MultiBufferStart_IT_376:
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_374
.L_HAL_DMAEx_MultiBufferStart_IT_373:
    MOVW r0, #24584
    MOVT r0, #16386
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24592
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_399
    MOV r0, #4
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_400
.L_HAL_DMAEx_MultiBufferStart_IT_399:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25616
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_401
    MOV r0, #4
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_402
.L_HAL_DMAEx_MultiBufferStart_IT_401:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24688
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_403
    MOV r0, #4
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_404
.L_HAL_DMAEx_MultiBufferStart_IT_403:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25712
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_405
    MOV r0, #4
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_406
.L_HAL_DMAEx_MultiBufferStart_IT_405:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24616
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_407
    MOVW r0, #256
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_408
.L_HAL_DMAEx_MultiBufferStart_IT_407:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25640
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_409
    MOVW r0, #256
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_410
.L_HAL_DMAEx_MultiBufferStart_IT_409:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24712
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_411
    MOVW r0, #256
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_412
.L_HAL_DMAEx_MultiBufferStart_IT_411:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25736
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_413
    MOVW r0, #256
    MOVT r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_414
.L_HAL_DMAEx_MultiBufferStart_IT_413:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24640
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_415
    MOVW r0, #0
    MOVT r0, #4
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_416
.L_HAL_DMAEx_MultiBufferStart_IT_415:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25664
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_417
    MOVW r0, #0
    MOVT r0, #4
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_418
.L_HAL_DMAEx_MultiBufferStart_IT_417:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24736
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_419
    MOVW r0, #0
    MOVT r0, #4
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_420
.L_HAL_DMAEx_MultiBufferStart_IT_419:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25760
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_421
    MOVW r0, #0
    MOVT r0, #4
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_422
.L_HAL_DMAEx_MultiBufferStart_IT_421:
    MOVW r0, #0
    MOVT r0, #256
    PUSH {r0}
.L_HAL_DMAEx_MultiBufferStart_IT_422:
.L_HAL_DMAEx_MultiBufferStart_IT_420:
.L_HAL_DMAEx_MultiBufferStart_IT_418:
.L_HAL_DMAEx_MultiBufferStart_IT_416:
.L_HAL_DMAEx_MultiBufferStart_IT_414:
.L_HAL_DMAEx_MultiBufferStart_IT_412:
.L_HAL_DMAEx_MultiBufferStart_IT_410:
.L_HAL_DMAEx_MultiBufferStart_IT_408:
.L_HAL_DMAEx_MultiBufferStart_IT_406:
.L_HAL_DMAEx_MultiBufferStart_IT_404:
.L_HAL_DMAEx_MultiBufferStart_IT_402:
.L_HAL_DMAEx_MultiBufferStart_IT_400:
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
.L_HAL_DMAEx_MultiBufferStart_IT_374:
.L_HAL_DMAEx_MultiBufferStart_IT_348:
.L_HAL_DMAEx_MultiBufferStart_IT_322:
    POP {r0}
.loc 1 34330
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25688
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_423
    MOVW r0, #25612
    MOVT r0, #16386
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24592
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_425
    MOV r0, #1
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_426
.L_HAL_DMAEx_MultiBufferStart_IT_425:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25616
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_427
    MOV r0, #1
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_428
.L_HAL_DMAEx_MultiBufferStart_IT_427:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24688
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_429
    MOV r0, #1
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_430
.L_HAL_DMAEx_MultiBufferStart_IT_429:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25712
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_431
    MOV r0, #1
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_432
.L_HAL_DMAEx_MultiBufferStart_IT_431:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24616
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_433
    MOV r0, #64
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_434
.L_HAL_DMAEx_MultiBufferStart_IT_433:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25640
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_435
    MOV r0, #64
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_436
.L_HAL_DMAEx_MultiBufferStart_IT_435:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24712
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_437
    MOV r0, #64
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_438
.L_HAL_DMAEx_MultiBufferStart_IT_437:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25736
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_439
    MOV r0, #64
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_440
.L_HAL_DMAEx_MultiBufferStart_IT_439:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24640
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_441
    MOVW r0, #0
    MOVT r0, #1
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_442
.L_HAL_DMAEx_MultiBufferStart_IT_441:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25664
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_443
    MOVW r0, #0
    MOVT r0, #1
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_444
.L_HAL_DMAEx_MultiBufferStart_IT_443:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24736
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_445
    MOVW r0, #0
    MOVT r0, #1
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_446
.L_HAL_DMAEx_MultiBufferStart_IT_445:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25760
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_447
    MOVW r0, #0
    MOVT r0, #1
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_448
.L_HAL_DMAEx_MultiBufferStart_IT_447:
    MOVW r0, #0
    MOVT r0, #64
    PUSH {r0}
.L_HAL_DMAEx_MultiBufferStart_IT_448:
.L_HAL_DMAEx_MultiBufferStart_IT_446:
.L_HAL_DMAEx_MultiBufferStart_IT_444:
.L_HAL_DMAEx_MultiBufferStart_IT_442:
.L_HAL_DMAEx_MultiBufferStart_IT_440:
.L_HAL_DMAEx_MultiBufferStart_IT_438:
.L_HAL_DMAEx_MultiBufferStart_IT_436:
.L_HAL_DMAEx_MultiBufferStart_IT_434:
.L_HAL_DMAEx_MultiBufferStart_IT_432:
.L_HAL_DMAEx_MultiBufferStart_IT_430:
.L_HAL_DMAEx_MultiBufferStart_IT_428:
.L_HAL_DMAEx_MultiBufferStart_IT_426:
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_424
.L_HAL_DMAEx_MultiBufferStart_IT_423:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24760
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_449
    MOVW r0, #25608
    MOVT r0, #16386
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24592
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_451
    MOV r0, #1
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_452
.L_HAL_DMAEx_MultiBufferStart_IT_451:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25616
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_453
    MOV r0, #1
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_454
.L_HAL_DMAEx_MultiBufferStart_IT_453:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24688
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_455
    MOV r0, #1
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_456
.L_HAL_DMAEx_MultiBufferStart_IT_455:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25712
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_457
    MOV r0, #1
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_458
.L_HAL_DMAEx_MultiBufferStart_IT_457:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24616
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_459
    MOV r0, #64
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_460
.L_HAL_DMAEx_MultiBufferStart_IT_459:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25640
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_461
    MOV r0, #64
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_462
.L_HAL_DMAEx_MultiBufferStart_IT_461:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24712
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_463
    MOV r0, #64
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_464
.L_HAL_DMAEx_MultiBufferStart_IT_463:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25736
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_465
    MOV r0, #64
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_466
.L_HAL_DMAEx_MultiBufferStart_IT_465:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24640
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_467
    MOVW r0, #0
    MOVT r0, #1
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_468
.L_HAL_DMAEx_MultiBufferStart_IT_467:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25664
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_469
    MOVW r0, #0
    MOVT r0, #1
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_470
.L_HAL_DMAEx_MultiBufferStart_IT_469:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24736
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_471
    MOVW r0, #0
    MOVT r0, #1
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_472
.L_HAL_DMAEx_MultiBufferStart_IT_471:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25760
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_473
    MOVW r0, #0
    MOVT r0, #1
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_474
.L_HAL_DMAEx_MultiBufferStart_IT_473:
    MOVW r0, #0
    MOVT r0, #64
    PUSH {r0}
.L_HAL_DMAEx_MultiBufferStart_IT_474:
.L_HAL_DMAEx_MultiBufferStart_IT_472:
.L_HAL_DMAEx_MultiBufferStart_IT_470:
.L_HAL_DMAEx_MultiBufferStart_IT_468:
.L_HAL_DMAEx_MultiBufferStart_IT_466:
.L_HAL_DMAEx_MultiBufferStart_IT_464:
.L_HAL_DMAEx_MultiBufferStart_IT_462:
.L_HAL_DMAEx_MultiBufferStart_IT_460:
.L_HAL_DMAEx_MultiBufferStart_IT_458:
.L_HAL_DMAEx_MultiBufferStart_IT_456:
.L_HAL_DMAEx_MultiBufferStart_IT_454:
.L_HAL_DMAEx_MultiBufferStart_IT_452:
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_450
.L_HAL_DMAEx_MultiBufferStart_IT_449:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24664
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_475
    MOVW r0, #24588
    MOVT r0, #16386
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24592
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_477
    MOV r0, #1
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_478
.L_HAL_DMAEx_MultiBufferStart_IT_477:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25616
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_479
    MOV r0, #1
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_480
.L_HAL_DMAEx_MultiBufferStart_IT_479:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24688
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_481
    MOV r0, #1
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_482
.L_HAL_DMAEx_MultiBufferStart_IT_481:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25712
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_483
    MOV r0, #1
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_484
.L_HAL_DMAEx_MultiBufferStart_IT_483:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24616
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_485
    MOV r0, #64
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_486
.L_HAL_DMAEx_MultiBufferStart_IT_485:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25640
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_487
    MOV r0, #64
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_488
.L_HAL_DMAEx_MultiBufferStart_IT_487:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24712
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_489
    MOV r0, #64
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_490
.L_HAL_DMAEx_MultiBufferStart_IT_489:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25736
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_491
    MOV r0, #64
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_492
.L_HAL_DMAEx_MultiBufferStart_IT_491:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24640
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_493
    MOVW r0, #0
    MOVT r0, #1
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_494
.L_HAL_DMAEx_MultiBufferStart_IT_493:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25664
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_495
    MOVW r0, #0
    MOVT r0, #1
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_496
.L_HAL_DMAEx_MultiBufferStart_IT_495:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24736
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_497
    MOVW r0, #0
    MOVT r0, #1
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_498
.L_HAL_DMAEx_MultiBufferStart_IT_497:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25760
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_499
    MOVW r0, #0
    MOVT r0, #1
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_500
.L_HAL_DMAEx_MultiBufferStart_IT_499:
    MOVW r0, #0
    MOVT r0, #64
    PUSH {r0}
.L_HAL_DMAEx_MultiBufferStart_IT_500:
.L_HAL_DMAEx_MultiBufferStart_IT_498:
.L_HAL_DMAEx_MultiBufferStart_IT_496:
.L_HAL_DMAEx_MultiBufferStart_IT_494:
.L_HAL_DMAEx_MultiBufferStart_IT_492:
.L_HAL_DMAEx_MultiBufferStart_IT_490:
.L_HAL_DMAEx_MultiBufferStart_IT_488:
.L_HAL_DMAEx_MultiBufferStart_IT_486:
.L_HAL_DMAEx_MultiBufferStart_IT_484:
.L_HAL_DMAEx_MultiBufferStart_IT_482:
.L_HAL_DMAEx_MultiBufferStart_IT_480:
.L_HAL_DMAEx_MultiBufferStart_IT_478:
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_476
.L_HAL_DMAEx_MultiBufferStart_IT_475:
    MOVW r0, #24584
    MOVT r0, #16386
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24592
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_501
    MOV r0, #1
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_502
.L_HAL_DMAEx_MultiBufferStart_IT_501:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25616
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_503
    MOV r0, #1
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_504
.L_HAL_DMAEx_MultiBufferStart_IT_503:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24688
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_505
    MOV r0, #1
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_506
.L_HAL_DMAEx_MultiBufferStart_IT_505:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25712
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_507
    MOV r0, #1
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_508
.L_HAL_DMAEx_MultiBufferStart_IT_507:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24616
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_509
    MOV r0, #64
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_510
.L_HAL_DMAEx_MultiBufferStart_IT_509:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25640
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_511
    MOV r0, #64
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_512
.L_HAL_DMAEx_MultiBufferStart_IT_511:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24712
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_513
    MOV r0, #64
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_514
.L_HAL_DMAEx_MultiBufferStart_IT_513:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25736
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_515
    MOV r0, #64
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_516
.L_HAL_DMAEx_MultiBufferStart_IT_515:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24640
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_517
    MOVW r0, #0
    MOVT r0, #1
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_518
.L_HAL_DMAEx_MultiBufferStart_IT_517:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25664
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_519
    MOVW r0, #0
    MOVT r0, #1
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_520
.L_HAL_DMAEx_MultiBufferStart_IT_519:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #24736
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_521
    MOVW r0, #0
    MOVT r0, #1
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_522
.L_HAL_DMAEx_MultiBufferStart_IT_521:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVW r0, #25760
    MOVT r0, #16386
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_523
    MOVW r0, #0
    MOVT r0, #1
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_524
.L_HAL_DMAEx_MultiBufferStart_IT_523:
    MOVW r0, #0
    MOVT r0, #64
    PUSH {r0}
.L_HAL_DMAEx_MultiBufferStart_IT_524:
.L_HAL_DMAEx_MultiBufferStart_IT_522:
.L_HAL_DMAEx_MultiBufferStart_IT_520:
.L_HAL_DMAEx_MultiBufferStart_IT_518:
.L_HAL_DMAEx_MultiBufferStart_IT_516:
.L_HAL_DMAEx_MultiBufferStart_IT_514:
.L_HAL_DMAEx_MultiBufferStart_IT_512:
.L_HAL_DMAEx_MultiBufferStart_IT_510:
.L_HAL_DMAEx_MultiBufferStart_IT_508:
.L_HAL_DMAEx_MultiBufferStart_IT_506:
.L_HAL_DMAEx_MultiBufferStart_IT_504:
.L_HAL_DMAEx_MultiBufferStart_IT_502:
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
.L_HAL_DMAEx_MultiBufferStart_IT_476:
.L_HAL_DMAEx_MultiBufferStart_IT_450:
.L_HAL_DMAEx_MultiBufferStart_IT_424:
    POP {r0}
.loc 1 34333
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #22
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
.loc 1 34334
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #20
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #128
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
.loc 1 34336
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #68
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_DMAEx_MultiBufferStart_IT_527
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #76
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    B .L_HAL_DMAEx_MultiBufferStart_IT_528
.L_HAL_DMAEx_MultiBufferStart_IT_527:
    MOV r0, #1
    PUSH {r0}
.L_HAL_DMAEx_MultiBufferStart_IT_528:
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_MultiBufferStart_IT_525
.loc 1 34338
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #8
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
    B .L_HAL_DMAEx_MultiBufferStart_IT_526
.L_HAL_DMAEx_MultiBufferStart_IT_525:
.L_HAL_DMAEx_MultiBufferStart_IT_526:
.loc 1 34342
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
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
    B .L_HAL_DMAEx_MultiBufferStart_IT_14
.L_HAL_DMAEx_MultiBufferStart_IT_13:
.loc 1 34347
.L_HAL_DMAEx_MultiBufferStart_IT_529:
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #52
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_DMAEx_MultiBufferStart_IT_531:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_DMAEx_MultiBufferStart_IT_529
.L_HAL_DMAEx_MultiBufferStart_IT_530:
.loc 1 34350
    MOV r0, #2
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #40]
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
.L_HAL_DMAEx_MultiBufferStart_IT_14:
.loc 1 34352
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #48
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_DMAEx_MultiBufferStart_IT, .-HAL_DMAEx_MultiBufferStart_IT

.global HAL_DMAEx_ChangeMemory
.type HAL_DMAEx_ChangeMemory, %function
HAL_DMAEx_ChangeMemory:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #24
    MOV r6, sp
.loc 1 34352
    STR r0, [r6, #0]
    STR r1, [r6, #8]
    STR r2, [r6, #16]
.loc 1 34371
    LDR r0, [r6, #16]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_DMAEx_ChangeMemory_0
.loc 1 34374
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_HAL_DMAEx_ChangeMemory_1
.L_HAL_DMAEx_ChangeMemory_0:
.loc 1 34379
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_DMAEx_ChangeMemory_1:
.loc 1 34382
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #24
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_DMAEx_ChangeMemory, .-HAL_DMAEx_ChangeMemory

.global DMA_MultiBufferSetConfig
.type DMA_MultiBufferSetConfig, %function
DMA_MultiBufferSetConfig:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #32
    MOV r6, sp
.loc 1 34382
    STR r0, [r6, #0]
    STR r1, [r6, #8]
    STR r2, [r6, #16]
    STR r3, [r6, #24]
.loc 1 34409
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 34412
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #64
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_DMA_MultiBufferSetConfig_0
.loc 1 34415
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 34418
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_DMA_MultiBufferSetConfig_1
.L_DMA_MultiBufferSetConfig_0:
.loc 1 34424
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 34427
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_DMA_MultiBufferSetConfig_1:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #32
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size DMA_MultiBufferSetConfig, .-DMA_MultiBufferSetConfig

.global HAL_FLASH_Program
.type HAL_FLASH_Program, %function
HAL_FLASH_Program:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #32
    MOV r6, sp
.loc 1 34427
    STR r0, [r6, #0]
    STR r1, [r6, #8]
    STR r2, [r6, #16]
.loc 1 34701
.L_HAL_FLASH_Program_0:
    MOVW r0, #36
    MOVT r0, #8192
    PUSH {r0}
    MOV r0, #24
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_FLASH_Program_3
    MOV r0, #2
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #32
    POP {r5, r6, r7, pc}
.L_HAL_FLASH_Program_3:
    MOVW r0, #36
    MOVT r0, #8192
    PUSH {r0}
    MOV r0, #24
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_FLASH_Program_4:
.L_HAL_FLASH_Program_2:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_FLASH_Program_0
.L_HAL_FLASH_Program_1:
.loc 1 34704
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 34707
    MOVW r0, #50000
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    BL FLASH_WaitForLastOperation
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
.loc 1 34709
    LDR r0, [r6, #24]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_FLASH_Program_5
.loc 1 34711
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_FLASH_Program_7
.loc 1 34714
    LDR r0, [r6, #16]
    LDR r1, [r6, #20]
    PUSH {r0}
    PUSH {r1}
    POP {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    POP {r1}
    BL FLASH_Program_Byte
    PUSH {r0}
    POP {r0}
    B .L_HAL_FLASH_Program_8
.L_HAL_FLASH_Program_7:
.loc 1 34716
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_FLASH_Program_9
.loc 1 34719
    LDR r0, [r6, #16]
    LDR r1, [r6, #20]
    PUSH {r0}
    PUSH {r1}
    POP {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    POP {r1}
    BL FLASH_Program_HalfWord
    PUSH {r0}
    POP {r0}
    B .L_HAL_FLASH_Program_10
.L_HAL_FLASH_Program_9:
.loc 1 34721
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_FLASH_Program_11
.loc 1 34724
    LDR r0, [r6, #16]
    LDR r1, [r6, #20]
    PUSH {r0}
    PUSH {r1}
    POP {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    POP {r1}
    BL FLASH_Program_Word
    PUSH {r0}
    POP {r0}
    B .L_HAL_FLASH_Program_12
.L_HAL_FLASH_Program_11:
.loc 1 34729
    LDR r0, [r6, #16]
    LDR r1, [r6, #20]
    PUSH {r0}
    PUSH {r1}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    POP {r1}
    BL FLASH_Program_DoubleWord
    PUSH {r0}
    POP {r0}
.L_HAL_FLASH_Program_12:
.L_HAL_FLASH_Program_10:
.L_HAL_FLASH_Program_8:
.loc 1 34733
    MOVW r0, #50000
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    BL FLASH_WaitForLastOperation
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
.loc 1 34736
    MOVW r0, #15376
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
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_HAL_FLASH_Program_6
.L_HAL_FLASH_Program_5:
.L_HAL_FLASH_Program_6:
.loc 1 34740
.L_HAL_FLASH_Program_13:
    MOVW r0, #36
    MOVT r0, #8192
    PUSH {r0}
    MOV r0, #24
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_FLASH_Program_15:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_FLASH_Program_13
.L_HAL_FLASH_Program_14:
.loc 1 34742
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #32
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_FLASH_Program, .-HAL_FLASH_Program

.global HAL_FLASH_Program_IT
.type HAL_FLASH_Program_IT, %function
HAL_FLASH_Program_IT:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #32
    MOV r6, sp
.loc 1 34742
    STR r0, [r6, #0]
    STR r1, [r6, #8]
    STR r2, [r6, #16]
.loc 1 34756
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
.loc 1 34759
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 34762
    MOVW r0, #15376
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
    MOVW r0, #0
    MOVT r0, #256
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
.loc 1 34765
    MOVW r0, #15376
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
    MOVW r0, #0
    MOVT r0, #512
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
.loc 1 34767
    MOVW r0, #36
    MOVT r0, #8192
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #3
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 34768
    MOVW r0, #36
    MOVT r0, #8192
    PUSH {r0}
    MOV r0, #20
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 34770
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_FLASH_Program_IT_0
.loc 1 34773
    LDR r0, [r6, #16]
    LDR r1, [r6, #20]
    PUSH {r0}
    PUSH {r1}
    POP {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    POP {r1}
    BL FLASH_Program_Byte
    PUSH {r0}
    POP {r0}
    B .L_HAL_FLASH_Program_IT_1
.L_HAL_FLASH_Program_IT_0:
.loc 1 34775
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_FLASH_Program_IT_2
.loc 1 34778
    LDR r0, [r6, #16]
    LDR r1, [r6, #20]
    PUSH {r0}
    PUSH {r1}
    POP {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    POP {r1}
    BL FLASH_Program_HalfWord
    PUSH {r0}
    POP {r0}
    B .L_HAL_FLASH_Program_IT_3
.L_HAL_FLASH_Program_IT_2:
.loc 1 34780
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_FLASH_Program_IT_4
.loc 1 34783
    LDR r0, [r6, #16]
    LDR r1, [r6, #20]
    PUSH {r0}
    PUSH {r1}
    POP {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    POP {r1}
    BL FLASH_Program_Word
    PUSH {r0}
    POP {r0}
    B .L_HAL_FLASH_Program_IT_5
.L_HAL_FLASH_Program_IT_4:
.loc 1 34788
    LDR r0, [r6, #16]
    LDR r1, [r6, #20]
    PUSH {r0}
    PUSH {r1}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    POP {r1}
    BL FLASH_Program_DoubleWord
    PUSH {r0}
    POP {r0}
.L_HAL_FLASH_Program_IT_5:
.L_HAL_FLASH_Program_IT_3:
.L_HAL_FLASH_Program_IT_1:
.loc 1 34791
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #32
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_FLASH_Program_IT, .-HAL_FLASH_Program_IT

.global HAL_FLASH_IRQHandler
.type HAL_FLASH_IRQHandler, %function
HAL_FLASH_IRQHandler:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 34791
.loc 1 34800
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
.loc 1 34804
    MOVW r0, #15372
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
    MOVW r0, #498
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_FLASH_IRQHandler_0
.loc 1 34808
    MOVW r0, #36
    MOVT r0, #8192
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_FLASH_IRQHandler_2
.loc 1 34811
    MOVW r0, #36
    MOVT r0, #8192
    PUSH {r0}
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    STR r0, [r6, #0]
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
.loc 1 34812
    MOVW r0, #36
    MOVT r0, #8192
    PUSH {r0}
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOVW r0, #65535
    MOVT r0, #65535
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_HAL_FLASH_IRQHandler_3
.L_HAL_FLASH_IRQHandler_2:
.loc 1 34814
    MOVW r0, #36
    MOVT r0, #8192
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_FLASH_IRQHandler_4
.loc 1 34817
    MOVW r0, #36
    MOVT r0, #8192
    PUSH {r0}
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    STR r0, [r6, #0]
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    B .L_HAL_FLASH_IRQHandler_5
.L_HAL_FLASH_IRQHandler_4:
.loc 1 34822
    MOVW r0, #36
    MOVT r0, #8192
    PUSH {r0}
    MOV r0, #20
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    STR r0, [r6, #0]
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_FLASH_IRQHandler_5:
.L_HAL_FLASH_IRQHandler_3:
.loc 1 34826
    BL FLASH_SetErrorCode
    PUSH {r0}
    POP {r0}
.loc 1 34829
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    BL HAL_FLASH_OperationErrorCallback
    PUSH {r0}
    POP {r0}
.loc 1 34832
    MOVW r0, #36
    MOVT r0, #8192
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_HAL_FLASH_IRQHandler_1
.L_HAL_FLASH_IRQHandler_0:
.L_HAL_FLASH_IRQHandler_1:
.loc 1 34836
    MOVW r0, #15372
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
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_FLASH_IRQHandler_6
.loc 1 34839
    MOVW r0, #15372
    MOVT r0, #16386
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 34841
    MOVW r0, #36
    MOVT r0, #8192
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_FLASH_IRQHandler_8
.loc 1 34844
    MOVW r0, #36
    MOVT r0, #8192
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    POP {r1}
    PUSH {r0}
    PUSH {r1}
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
    MOVW r0, #65535
    MOVT r0, #65535
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    POP {r0}
.loc 1 34847
    MOVW r0, #36
    MOVT r0, #8192
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_FLASH_IRQHandler_10
.loc 1 34849
    MOVW r0, #36
    MOVT r0, #8192
    PUSH {r0}
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    STR r0, [r6, #0]
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
.loc 1 34851
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    BL HAL_FLASH_EndOfOperationCallback
    PUSH {r0}
    POP {r0}
.loc 1 34854
    MOVW r0, #36
    MOVT r0, #8192
    PUSH {r0}
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    POP {r1}
    PUSH {r0}
    PUSH {r1}
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
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    POP {r0}
.loc 1 34855
    MOVW r0, #36
    MOVT r0, #8192
    PUSH {r0}
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    STR r0, [r6, #0]
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
.loc 1 34856
    MOVW r0, #36
    MOVT r0, #8192
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    LDRB r0, [r0, #0]
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    POP {r1}
    BL FLASH_Erase_Sector
    PUSH {r0}
    POP {r0}
    B .L_HAL_FLASH_IRQHandler_11
.L_HAL_FLASH_IRQHandler_10:
.loc 1 34862
    MOVW r0, #36
    MOVT r0, #8192
    PUSH {r0}
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOVW r0, #65535
    MOVT r0, #65535
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 34863
    MOVW r0, #36
    MOVT r0, #8192
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 34866
    BL FLASH_FlushCaches
    PUSH {r0}
    POP {r0}
.loc 1 34869
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    BL HAL_FLASH_EndOfOperationCallback
    PUSH {r0}
    POP {r0}
.L_HAL_FLASH_IRQHandler_11:
    B .L_HAL_FLASH_IRQHandler_9
.L_HAL_FLASH_IRQHandler_8:
.loc 1 34874
    MOVW r0, #36
    MOVT r0, #8192
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_FLASH_IRQHandler_12
.loc 1 34878
    BL FLASH_FlushCaches
    PUSH {r0}
    POP {r0}
.loc 1 34881
    MOVW r0, #36
    MOVT r0, #8192
    PUSH {r0}
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    BL HAL_FLASH_EndOfOperationCallback
    PUSH {r0}
    POP {r0}
    B .L_HAL_FLASH_IRQHandler_13
.L_HAL_FLASH_IRQHandler_12:
.loc 1 34887
    MOVW r0, #36
    MOVT r0, #8192
    PUSH {r0}
    MOV r0, #20
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    BL HAL_FLASH_EndOfOperationCallback
    PUSH {r0}
    POP {r0}
.L_HAL_FLASH_IRQHandler_13:
.loc 1 34889
    MOVW r0, #36
    MOVT r0, #8192
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_FLASH_IRQHandler_9:
    B .L_HAL_FLASH_IRQHandler_7
.L_HAL_FLASH_IRQHandler_6:
.L_HAL_FLASH_IRQHandler_7:
.loc 1 34893
    MOVW r0, #36
    MOVT r0, #8192
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_FLASH_IRQHandler_14
.loc 1 34896
    MOVW r0, #15376
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
    MOV r0, #255
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 34899
    MOVW r0, #15376
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
    MOVW r0, #0
    MOVT r0, #256
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 34902
    MOVW r0, #15376
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
    MOVW r0, #0
    MOVT r0, #512
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_HAL_FLASH_IRQHandler_15
.L_HAL_FLASH_IRQHandler_14:
.L_HAL_FLASH_IRQHandler_15:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_FLASH_IRQHandler, .-HAL_FLASH_IRQHandler

.global HAL_FLASH_EndOfOperationCallback
.weak HAL_FLASH_EndOfOperationCallback
.type HAL_FLASH_EndOfOperationCallback, %function
HAL_FLASH_EndOfOperationCallback:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 34902
    STR r0, [r6, #0]
.loc 1 34918
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_FLASH_EndOfOperationCallback, .-HAL_FLASH_EndOfOperationCallback

.global HAL_FLASH_OperationErrorCallback
.weak HAL_FLASH_OperationErrorCallback
.type HAL_FLASH_OperationErrorCallback, %function
HAL_FLASH_OperationErrorCallback:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 34918
    STR r0, [r6, #0]
.loc 1 34935
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_FLASH_OperationErrorCallback, .-HAL_FLASH_OperationErrorCallback

.global HAL_FLASH_Unlock
.type HAL_FLASH_Unlock, %function
HAL_FLASH_Unlock:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 34935
.loc 1 34966
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
.loc 1 34968
    MOVW r0, #15376
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
    MOVT r0, #32768
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_FLASH_Unlock_0
.loc 1 34971
    MOVW r0, #15364
    MOVT r0, #16386
    PUSH {r0}
    MOVW r0, #291
    MOVT r0, #17767
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 34972
    MOVW r0, #15364
    MOVT r0, #16386
    PUSH {r0}
    MOVW r0, #35243
    MOVT r0, #52719
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 34975
    MOVW r0, #15376
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
    MOVT r0, #32768
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_FLASH_Unlock_2
.loc 1 34977
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    B .L_HAL_FLASH_Unlock_3
.L_HAL_FLASH_Unlock_2:
.L_HAL_FLASH_Unlock_3:
    B .L_HAL_FLASH_Unlock_1
.L_HAL_FLASH_Unlock_0:
.L_HAL_FLASH_Unlock_1:
.loc 1 34981
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_FLASH_Unlock, .-HAL_FLASH_Unlock

.global HAL_FLASH_Lock
.type HAL_FLASH_Lock, %function
HAL_FLASH_Lock:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 34981
.loc 1 34991
    MOVW r0, #15376
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
    MOVW r0, #0
    MOVT r0, #32768
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
.loc 1 34993
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_FLASH_Lock, .-HAL_FLASH_Lock

.global HAL_FLASH_OB_Unlock
.type HAL_FLASH_OB_Unlock, %function
HAL_FLASH_OB_Unlock:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 34993
.loc 1 35002
    MOVW r0, #15380
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
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_FLASH_OB_Unlock_0
.loc 1 35005
    MOVW r0, #15368
    MOVT r0, #16386
    PUSH {r0}
    MOVW r0, #10811
    MOVT r0, #2073
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 35006
    MOVW r0, #15368
    MOVT r0, #16386
    PUSH {r0}
    MOVW r0, #28287
    MOVT r0, #19549
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_HAL_FLASH_OB_Unlock_1
.L_HAL_FLASH_OB_Unlock_0:
.loc 1 35010
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
.L_HAL_FLASH_OB_Unlock_1:
.loc 1 35013
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_FLASH_OB_Unlock, .-HAL_FLASH_OB_Unlock

.global HAL_FLASH_OB_Lock
.type HAL_FLASH_OB_Lock, %function
HAL_FLASH_OB_Lock:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 35013
.loc 1 35023
    MOVW r0, #15380
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
    MOV r0, #1
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
.loc 1 35025
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_FLASH_OB_Lock, .-HAL_FLASH_OB_Lock

.global HAL_FLASH_OB_Launch
.type HAL_FLASH_OB_Launch, %function
HAL_FLASH_OB_Launch:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 35025
.loc 1 35035
    MOVW r0, #15380
    MOVT r0, #16386
    PUSH {r0}
    POP {r0}
    PUSH {r0}
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    LDRB r0, [r0, #0]
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STRB r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 35038
    MOVW r0, #50000
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    BL FLASH_WaitForLastOperation
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_FLASH_OB_Launch, .-HAL_FLASH_OB_Launch

.global HAL_FLASH_GetError
.type HAL_FLASH_GetError, %function
HAL_FLASH_GetError:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 35038
.loc 1 35071
    MOVW r0, #36
    MOVT r0, #8192
    PUSH {r0}
    MOV r0, #28
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_FLASH_GetError, .-HAL_FLASH_GetError

.global FLASH_WaitForLastOperation
.type FLASH_WaitForLastOperation, %function
FLASH_WaitForLastOperation:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #16
    MOV r6, sp
.loc 1 35071
    STR r0, [r6, #0]
.loc 1 35085
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
.loc 1 35088
    MOVW r0, #36
    MOVT r0, #8192
    PUSH {r0}
    MOV r0, #28
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 35094
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 35096
.L_FLASH_WaitForLastOperation_0:
    MOVW r0, #15372
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
    MOVT r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_FLASH_WaitForLastOperation_1
.loc 1 35098
    LDR r0, [r6, #0]
    PUSH {r0}
    MOVW r0, #65535
    MOVT r0, #65535
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_FLASH_WaitForLastOperation_2
.loc 1 35100
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_FLASH_WaitForLastOperation_6
    BL HAL_GetTick
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r1}
    POP {r0}
    SUB r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE HI
    MOVHI r0, #1
    MOVLS r0, #0
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    B .L_FLASH_WaitForLastOperation_7
.L_FLASH_WaitForLastOperation_6:
    MOV r0, #1
    PUSH {r0}
.L_FLASH_WaitForLastOperation_7:
    POP {r0}
    CMP r0, #0
    BEQ .L_FLASH_WaitForLastOperation_4
.loc 1 35102
    MOV r0, #3
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #16
    POP {r5, r6, r7, pc}
.L_FLASH_WaitForLastOperation_4:
.L_FLASH_WaitForLastOperation_5:
    B .L_FLASH_WaitForLastOperation_3
.L_FLASH_WaitForLastOperation_2:
.L_FLASH_WaitForLastOperation_3:
    B .L_FLASH_WaitForLastOperation_0
.L_FLASH_WaitForLastOperation_1:
.loc 1 35108
    MOVW r0, #15372
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
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_FLASH_WaitForLastOperation_8
.loc 1 35111
    MOVW r0, #15372
    MOVT r0, #16386
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_FLASH_WaitForLastOperation_9
.L_FLASH_WaitForLastOperation_8:
.L_FLASH_WaitForLastOperation_9:
.loc 1 35114
    MOVW r0, #15372
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
    MOVW r0, #498
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_FLASH_WaitForLastOperation_10
.loc 1 35119
    BL FLASH_SetErrorCode
    PUSH {r0}
    POP {r0}
.loc 1 35120
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #16
    POP {r5, r6, r7, pc}
.L_FLASH_WaitForLastOperation_10:
.L_FLASH_WaitForLastOperation_11:
.loc 1 35124
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #16
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size FLASH_WaitForLastOperation, .-FLASH_WaitForLastOperation

.global FLASH_Program_DoubleWord
.type FLASH_Program_DoubleWord, %function
FLASH_Program_DoubleWord:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #16
    MOV r6, sp
.loc 1 35124
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 35143
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 35146
    MOVW r0, #15376
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
    MOVW r0, #768
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 35147
    MOVW r0, #15376
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
    MOVW r0, #768
    MOVT r0, #0
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
.loc 1 35148
    MOVW r0, #15376
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
    MOV r0, #1
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
.loc 1 35151
    LDR r0, [r6, #0]
    PUSH {r0}
    LDR r0, [r6, #8]
    LDR r1, [r6, #12]
    PUSH {r0}
    PUSH {r1}
    POP {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 35155
    MOV r0, #15
    PUSH {r0}
    POP {r0}
    ISB SY
    PUSH {r0}
    POP {r0}
.loc 1 35158
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #8]
    LDR r1, [r6, #12]
    PUSH {r0}
    PUSH {r1}
    MOV r0, #32
    PUSH {r0}
    POP {r0}
    PUSH {r0}
    PUSH {r0}
    MOV r0, #31
    PUSH {r0}
    POP {r1}
    POP {r0}
    ASR r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    POP {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #16
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size FLASH_Program_DoubleWord, .-FLASH_Program_DoubleWord

.global FLASH_Program_Word
.type FLASH_Program_Word, %function
FLASH_Program_Word:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #16
    MOV r6, sp
.loc 1 35158
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 35177
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 35180
    MOVW r0, #15376
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
    MOVW r0, #768
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 35181
    MOVW r0, #15376
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
    MOVW r0, #512
    MOVT r0, #0
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
.loc 1 35182
    MOVW r0, #15376
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
    MOV r0, #1
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
.loc 1 35184
    LDR r0, [r6, #0]
    PUSH {r0}
    LDR r0, [r6, #8]
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
    ADD sp, sp, #16
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size FLASH_Program_Word, .-FLASH_Program_Word

.global FLASH_Program_HalfWord
.type FLASH_Program_HalfWord, %function
FLASH_Program_HalfWord:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #16
    MOV r6, sp
.loc 1 35184
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 35202
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 35205
    MOVW r0, #15376
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
    MOVW r0, #768
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 35206
    MOVW r0, #15376
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
    MOVW r0, #256
    MOVT r0, #0
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
.loc 1 35207
    MOVW r0, #15376
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
    MOV r0, #1
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
.loc 1 35209
    LDR r0, [r6, #0]
    PUSH {r0}
    LDRH r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STRH r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #16
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size FLASH_Program_HalfWord, .-FLASH_Program_HalfWord

.global FLASH_Program_Byte
.type FLASH_Program_Byte, %function
FLASH_Program_Byte:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #16
    MOV r6, sp
.loc 1 35209
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 35227
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 35230
    MOVW r0, #15376
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
    MOVW r0, #768
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 35231
    MOVW r0, #15376
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
    MOV r0, #0
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
.loc 1 35232
    MOVW r0, #15376
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
    MOV r0, #1
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
.loc 1 35234
    LDR r0, [r6, #0]
    PUSH {r0}
    LDRB r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STRB r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #16
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size FLASH_Program_Byte, .-FLASH_Program_Byte

.global FLASH_SetErrorCode
.type FLASH_SetErrorCode, %function
FLASH_SetErrorCode:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 35234
.loc 1 35243
    MOVW r0, #15372
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
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_FLASH_SetErrorCode_0
.loc 1 35245
    MOVW r0, #36
    MOVT r0, #8192
    PUSH {r0}
    MOV r0, #28
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #16
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
.loc 1 35248
    MOVW r0, #15372
    MOVT r0, #16386
    PUSH {r0}
    MOV r0, #16
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_FLASH_SetErrorCode_1
.L_FLASH_SetErrorCode_0:
.L_FLASH_SetErrorCode_1:
.loc 1 35251
    MOVW r0, #15372
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
    MOV r0, #32
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_FLASH_SetErrorCode_2
.loc 1 35253
    MOVW r0, #36
    MOVT r0, #8192
    PUSH {r0}
    MOV r0, #28
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #8
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
.loc 1 35256
    MOVW r0, #15372
    MOVT r0, #16386
    PUSH {r0}
    MOV r0, #32
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_FLASH_SetErrorCode_3
.L_FLASH_SetErrorCode_2:
.L_FLASH_SetErrorCode_3:
.loc 1 35259
    MOVW r0, #15372
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
    MOV r0, #64
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_FLASH_SetErrorCode_4
.loc 1 35261
    MOVW r0, #36
    MOVT r0, #8192
    PUSH {r0}
    MOV r0, #28
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
.loc 1 35264
    MOVW r0, #15372
    MOVT r0, #16386
    PUSH {r0}
    MOV r0, #64
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_FLASH_SetErrorCode_5
.L_FLASH_SetErrorCode_4:
.L_FLASH_SetErrorCode_5:
.loc 1 35267
    MOVW r0, #15372
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
    MOV r0, #128
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_FLASH_SetErrorCode_6
.loc 1 35269
    MOVW r0, #36
    MOVT r0, #8192
    PUSH {r0}
    MOV r0, #28
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
.loc 1 35272
    MOVW r0, #15372
    MOVT r0, #16386
    PUSH {r0}
    MOV r0, #128
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_FLASH_SetErrorCode_7
.L_FLASH_SetErrorCode_6:
.L_FLASH_SetErrorCode_7:
.loc 1 35275
    MOVW r0, #15372
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
    MOVW r0, #256
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_FLASH_SetErrorCode_8
.loc 1 35277
    MOVW r0, #36
    MOVT r0, #8192
    PUSH {r0}
    MOV r0, #28
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
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
.loc 1 35280
    MOVW r0, #15372
    MOVT r0, #16386
    PUSH {r0}
    MOVW r0, #256
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_FLASH_SetErrorCode_9
.L_FLASH_SetErrorCode_8:
.L_FLASH_SetErrorCode_9:
.loc 1 35283
    MOVW r0, #15372
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
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_FLASH_SetErrorCode_10
.loc 1 35285
    MOVW r0, #36
    MOVT r0, #8192
    PUSH {r0}
    MOV r0, #28
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #32
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
.loc 1 35288
    MOVW r0, #15372
    MOVT r0, #16386
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_FLASH_SetErrorCode_11
.L_FLASH_SetErrorCode_10:
.L_FLASH_SetErrorCode_11:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size FLASH_SetErrorCode, .-FLASH_SetErrorCode

.global HAL_FLASHEx_Erase
.type HAL_FLASHEx_Erase, %function
HAL_FLASHEx_Erase:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #32
    MOV r6, sp
.loc 1 35288
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 35554
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
.loc 1 35557
.L_HAL_FLASHEx_Erase_0:
    MOVW r0, #36
    MOVT r0, #8192
    PUSH {r0}
    MOV r0, #24
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_FLASHEx_Erase_3
    MOV r0, #2
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #32
    POP {r5, r6, r7, pc}
.L_HAL_FLASHEx_Erase_3:
    MOVW r0, #36
    MOVT r0, #8192
    PUSH {r0}
    MOV r0, #24
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_FLASHEx_Erase_4:
.L_HAL_FLASHEx_Erase_2:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_FLASHEx_Erase_0
.L_HAL_FLASHEx_Erase_1:
.loc 1 35560
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 35563
    MOVW r0, #50000
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    BL FLASH_WaitForLastOperation
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
.loc 1 35565
    LDR r0, [r6, #16]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_FLASHEx_Erase_5
.loc 1 35568
    LDR r0, [r6, #8]
    PUSH {r0}
    MOVW r0, #65535
    MOVT r0, #65535
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 35570
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_FLASHEx_Erase_7
.loc 1 35573
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    POP {r1}
    BL FLASH_MassErase
    PUSH {r0}
    POP {r0}
.loc 1 35576
    MOVW r0, #50000
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    BL FLASH_WaitForLastOperation
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
.loc 1 35579
    MOVW r0, #15376
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
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_HAL_FLASHEx_Erase_8
.L_HAL_FLASHEx_Erase_7:
.loc 1 35584
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 35587
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    STR r0, [r6, #24]
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
.L_HAL_FLASHEx_Erase_9:
    LDR r0, [r6, #24]
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE LO
    MOVLO r0, #1
    MOVHS r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_FLASHEx_Erase_10
.loc 1 35589
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
    POP {r1}
    BL FLASH_Erase_Sector
    PUSH {r0}
    POP {r0}
.loc 1 35592
    MOVW r0, #50000
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    BL FLASH_WaitForLastOperation
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
.loc 1 35595
    MOVW r0, #15376
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
    MOV r0, #250
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 35597
    LDR r0, [r6, #16]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_FLASHEx_Erase_12
.loc 1 35600
    LDR r0, [r6, #8]
    PUSH {r0}
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 35601
    B .L_HAL_FLASHEx_Erase_10
.L_HAL_FLASHEx_Erase_12:
.L_HAL_FLASHEx_Erase_13:
.L_HAL_FLASHEx_Erase_11:
.loc 1 35587
    LDR r0, [r6, #24]
    PUSH {r0}
    LDR r0, [r6, #24]
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
    POP {r0}
    B .L_HAL_FLASHEx_Erase_9
.L_HAL_FLASHEx_Erase_10:
.L_HAL_FLASHEx_Erase_8:
.loc 1 35606
    BL FLASH_FlushCaches
    PUSH {r0}
    POP {r0}
    B .L_HAL_FLASHEx_Erase_6
.L_HAL_FLASHEx_Erase_5:
.L_HAL_FLASHEx_Erase_6:
.loc 1 35610
.L_HAL_FLASHEx_Erase_14:
    MOVW r0, #36
    MOVT r0, #8192
    PUSH {r0}
    MOV r0, #24
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_FLASHEx_Erase_16:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_FLASHEx_Erase_14
.L_HAL_FLASHEx_Erase_15:
.loc 1 35612
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #32
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_FLASHEx_Erase, .-HAL_FLASHEx_Erase

.global HAL_FLASHEx_Erase_IT
.type HAL_FLASHEx_Erase_IT, %function
HAL_FLASHEx_Erase_IT:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #16
    MOV r6, sp
.loc 1 35612
    STR r0, [r6, #0]
.loc 1 35624
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
.loc 1 35627
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 35630
    MOVW r0, #15376
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
    MOVW r0, #0
    MOVT r0, #256
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
.loc 1 35633
    MOVW r0, #15376
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
    MOVW r0, #0
    MOVT r0, #512
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
.loc 1 35636
    MOVW r0, #15372
    MOVT r0, #16386
    PUSH {r0}
    MOV r0, #243
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 35638
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_FLASHEx_Erase_IT_0
.loc 1 35641
    MOVW r0, #36
    MOVT r0, #8192
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 35642
    MOVW r0, #36
    MOVT r0, #8192
    PUSH {r0}
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 35643
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    POP {r1}
    BL FLASH_MassErase
    PUSH {r0}
    POP {r0}
    B .L_HAL_FLASHEx_Erase_IT_1
.L_HAL_FLASHEx_Erase_IT_0:
.loc 1 35650
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 35652
    MOVW r0, #36
    MOVT r0, #8192
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 35653
    MOVW r0, #36
    MOVT r0, #8192
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 35654
    MOVW r0, #36
    MOVT r0, #8192
    PUSH {r0}
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 35655
    MOVW r0, #36
    MOVT r0, #8192
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    POP {r1}
    STRB r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 35658
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    POP {r1}
    BL FLASH_Erase_Sector
    PUSH {r0}
    POP {r0}
.L_HAL_FLASHEx_Erase_IT_1:
.loc 1 35661
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #16
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_FLASHEx_Erase_IT, .-HAL_FLASHEx_Erase_IT

.global HAL_FLASHEx_OBProgram
.type HAL_FLASHEx_OBProgram, %function
HAL_FLASHEx_OBProgram:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #16
    MOV r6, sp
.loc 1 35661
    STR r0, [r6, #0]
.loc 1 35673
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
.loc 1 35676
.L_HAL_FLASHEx_OBProgram_0:
    MOVW r0, #36
    MOVT r0, #8192
    PUSH {r0}
    MOV r0, #24
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_FLASHEx_OBProgram_3
    MOV r0, #2
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #16
    POP {r5, r6, r7, pc}
.L_HAL_FLASHEx_OBProgram_3:
    MOVW r0, #36
    MOVT r0, #8192
    PUSH {r0}
    MOV r0, #24
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_FLASHEx_OBProgram_4:
.L_HAL_FLASHEx_OBProgram_2:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_FLASHEx_OBProgram_0
.L_HAL_FLASHEx_OBProgram_1:
.loc 1 35679
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 35682
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_FLASHEx_OBProgram_5
.loc 1 35684
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 35685
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_FLASHEx_OBProgram_7
.loc 1 35688
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    POP {r1}
    BL FLASH_OB_EnableWRP
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    B .L_HAL_FLASHEx_OBProgram_8
.L_HAL_FLASHEx_OBProgram_7:
.loc 1 35693
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    POP {r1}
    BL FLASH_OB_DisableWRP
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.L_HAL_FLASHEx_OBProgram_8:
    B .L_HAL_FLASHEx_OBProgram_6
.L_HAL_FLASHEx_OBProgram_5:
.L_HAL_FLASHEx_OBProgram_6:
.loc 1 35698
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    AND r0, r1
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_FLASHEx_OBProgram_9
.loc 1 35700
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    BL FLASH_OB_RDP_LevelConfig
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    B .L_HAL_FLASHEx_OBProgram_10
.L_HAL_FLASHEx_OBProgram_9:
.L_HAL_FLASHEx_OBProgram_10:
.loc 1 35704
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    AND r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_FLASHEx_OBProgram_11
.loc 1 35708
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #24
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    LDRB r0, [r0, #0]
    PUSH {r0}
    MOV r0, #128
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
.loc 1 35707
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #24
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    LDRB r0, [r0, #0]
    PUSH {r0}
    MOV r0, #64
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
.loc 1 35706
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #24
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    LDRB r0, [r0, #0]
    PUSH {r0}
    MOV r0, #32
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    POP {r2}
    BL FLASH_OB_UserConfig
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    B .L_HAL_FLASHEx_OBProgram_12
.L_HAL_FLASHEx_OBProgram_11:
.L_HAL_FLASHEx_OBProgram_12:
.loc 1 35712
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_FLASHEx_OBProgram_13
.loc 1 35714
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #20
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    BL FLASH_OB_BOR_LevelConfig
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    B .L_HAL_FLASHEx_OBProgram_14
.L_HAL_FLASHEx_OBProgram_13:
.L_HAL_FLASHEx_OBProgram_14:
.loc 1 35718
.L_HAL_FLASHEx_OBProgram_15:
    MOVW r0, #36
    MOVT r0, #8192
    PUSH {r0}
    MOV r0, #24
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_FLASHEx_OBProgram_17:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_FLASHEx_OBProgram_15
.L_HAL_FLASHEx_OBProgram_16:
.loc 1 35720
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #16
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_FLASHEx_OBProgram, .-HAL_FLASHEx_OBProgram

.global HAL_FLASHEx_OBGetConfig
.type HAL_FLASHEx_OBGetConfig, %function
HAL_FLASHEx_OBGetConfig:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 35720
    STR r0, [r6, #0]
.loc 1 35732
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #15
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 35735
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    BL FLASH_OB_GetWRP
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 35738
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    BL FLASH_OB_GetRDP
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 35741
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #24
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    BL FLASH_OB_GetUser
    PUSH {r0}
    POP {r0}
    POP {r1}
    STRB r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 35744
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #20
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    BL FLASH_OB_GetBOR
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
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_FLASHEx_OBGetConfig, .-HAL_FLASHEx_OBGetConfig

.global HAL_FLASHEx_AdvOBProgram
.type HAL_FLASHEx_AdvOBProgram, %function
HAL_FLASHEx_AdvOBProgram:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #16
    MOV r6, sp
.loc 1 35744
    STR r0, [r6, #0]
.loc 1 35757
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
.loc 1 35760
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 35763
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_FLASHEx_AdvOBProgram_0
.loc 1 35766
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 35767
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_FLASHEx_AdvOBProgram_2
.loc 1 35771
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    MOV r2, #2
    MUL r1, r2
    ADD r0, r0, r1
    LDRSH r0, [r0, #0]
    PUSH {r0}
    POP {r0}
    BL FLASH_OB_EnablePCROP
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    B .L_HAL_FLASHEx_AdvOBProgram_3
.L_HAL_FLASHEx_AdvOBProgram_2:
.loc 1 35779
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    MOV r2, #2
    MUL r1, r2
    ADD r0, r0, r1
    LDRSH r0, [r0, #0]
    PUSH {r0}
    POP {r0}
    BL FLASH_OB_DisablePCROP
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.L_HAL_FLASHEx_AdvOBProgram_3:
    B .L_HAL_FLASHEx_AdvOBProgram_1
.L_HAL_FLASHEx_AdvOBProgram_0:
.L_HAL_FLASHEx_AdvOBProgram_1:
.loc 1 35788
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #16
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_FLASHEx_AdvOBProgram, .-HAL_FLASHEx_AdvOBProgram

.global HAL_FLASHEx_AdvOBGetConfig
.type HAL_FLASHEx_AdvOBGetConfig, %function
HAL_FLASHEx_AdvOBGetConfig:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 35788
    STR r0, [r6, #0]
.loc 1 35802
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOVW r0, #15382
    MOVT r0, #16386
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    MOV r2, #2
    MUL r1, r2
    ADD r0, r0, r1
    LDRSH r0, [r0, #0]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STRH r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_FLASHEx_AdvOBGetConfig, .-HAL_FLASHEx_AdvOBGetConfig

.global HAL_FLASHEx_OB_SelectPCROP
.type HAL_FLASHEx_OB_SelectPCROP, %function
HAL_FLASHEx_OB_SelectPCROP:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 35802
.loc 1 35824
    MOVW r0, #15383
    MOVT r0, #16386
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    LDRB r0, [r0, #0]
    PUSH {r0}
    MOV r0, #127
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STRB r0, [r6, #0]
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
.loc 1 35827
    MOVW r0, #15383
    MOVT r0, #16386
    PUSH {r0}
    MOV r0, #128
    PUSH {r0}
    LDRB r0, [r6, #0]
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STRB r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 35829
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_FLASHEx_OB_SelectPCROP, .-HAL_FLASHEx_OB_SelectPCROP

.global HAL_FLASHEx_OB_DeSelectPCROP
.type HAL_FLASHEx_OB_DeSelectPCROP, %function
HAL_FLASHEx_OB_DeSelectPCROP:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 35829
.loc 1 35849
    MOVW r0, #15383
    MOVT r0, #16386
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    LDRB r0, [r0, #0]
    PUSH {r0}
    MOV r0, #127
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STRB r0, [r6, #0]
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
.loc 1 35852
    MOVW r0, #15383
    MOVT r0, #16386
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    LDRB r0, [r6, #0]
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STRB r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 35854
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_FLASHEx_OB_DeSelectPCROP, .-HAL_FLASHEx_OB_DeSelectPCROP

.global FLASH_MassErase
.type FLASH_MassErase, %function
FLASH_MassErase:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #16
    MOV r6, sp
.loc 1 35854
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 35891
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 35892
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 35895
    MOVW r0, #15376
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
    MOVW r0, #768
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 35896
    MOVW r0, #15376
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
.loc 1 35897
    MOVW r0, #15376
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
    MOVW r0, #0
    MOVT r0, #1
    PUSH {r0}
    LDRB r0, [r6, #0]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #16
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size FLASH_MassErase, .-FLASH_MassErase

.global FLASH_Erase_Sector
.type FLASH_Erase_Sector, %function
FLASH_Erase_Sector:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #24
    MOV r6, sp
.loc 1 35897
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 35919
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
.loc 1 35922
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 35923
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 35925
    LDRB r0, [r6, #8]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_FLASH_Erase_Sector_0
.loc 1 35927
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
    B .L_FLASH_Erase_Sector_1
.L_FLASH_Erase_Sector_0:
.loc 1 35929
    LDRB r0, [r6, #8]
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_FLASH_Erase_Sector_2
.loc 1 35931
    MOVW r0, #256
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
    B .L_FLASH_Erase_Sector_3
.L_FLASH_Erase_Sector_2:
.loc 1 35933
    LDRB r0, [r6, #8]
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_FLASH_Erase_Sector_4
.loc 1 35935
    MOVW r0, #512
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
    B .L_FLASH_Erase_Sector_5
.L_FLASH_Erase_Sector_4:
.loc 1 35939
    MOVW r0, #768
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
.L_FLASH_Erase_Sector_5:
.L_FLASH_Erase_Sector_3:
.L_FLASH_Erase_Sector_1:
.loc 1 35943
    MOVW r0, #15376
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
    MOVW r0, #768
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 35944
    MOVW r0, #15376
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
    LDR r0, [r6, #16]
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
.loc 1 35945
    MOVW r0, #15376
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
    MOV r0, #248
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 35946
    MOVW r0, #15376
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
    MOV r0, #2
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #3
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
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
.loc 1 35947
    MOVW r0, #15376
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
    MOVW r0, #0
    MOVT r0, #1
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
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #24
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size FLASH_Erase_Sector, .-FLASH_Erase_Sector

.global FLASH_OB_EnableWRP
.type FLASH_OB_EnableWRP, %function
FLASH_OB_EnableWRP:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #24
    MOV r6, sp
.loc 1 35947
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 35969
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
.loc 1 35972
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 35973
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 35976
    MOVW r0, #50000
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    BL FLASH_WaitForLastOperation
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
.loc 1 35978
    LDR r0, [r6, #16]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_FLASH_OB_EnableWRP_0
.loc 1 35980
    MOVW r0, #15382
    MOVT r0, #16386
    PUSH {r0}
    POP {r0}
    PUSH {r0}
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    MOV r2, #2
    MUL r1, r2
    ADD r0, r0, r1
    LDRSH r0, [r0, #0]
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STRH r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_FLASH_OB_EnableWRP_1
.L_FLASH_OB_EnableWRP_0:
.L_FLASH_OB_EnableWRP_1:
.loc 1 35983
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #24
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size FLASH_OB_EnableWRP, .-FLASH_OB_EnableWRP

.global FLASH_OB_DisableWRP
.type FLASH_OB_DisableWRP, %function
FLASH_OB_DisableWRP:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #24
    MOV r6, sp
.loc 1 35983
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 36005
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
.loc 1 36008
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 36009
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 36012
    MOVW r0, #50000
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    BL FLASH_WaitForLastOperation
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
.loc 1 36014
    LDR r0, [r6, #16]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_FLASH_OB_DisableWRP_0
.loc 1 36016
    MOVW r0, #15382
    MOVT r0, #16386
    PUSH {r0}
    POP {r0}
    PUSH {r0}
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    MOV r2, #2
    MUL r1, r2
    ADD r0, r0, r1
    LDRSH r0, [r0, #0]
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STRH r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_FLASH_OB_DisableWRP_1
.L_FLASH_OB_DisableWRP_0:
.L_FLASH_OB_DisableWRP_1:
.loc 1 36019
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #24
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size FLASH_OB_DisableWRP, .-FLASH_OB_DisableWRP

.global FLASH_OB_EnablePCROP
.type FLASH_OB_EnablePCROP, %function
FLASH_OB_EnablePCROP:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #16
    MOV r6, sp
.loc 1 36019
    STR r0, [r6, #0]
.loc 1 36035
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
.loc 1 36038
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 36041
    MOVW r0, #50000
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    BL FLASH_WaitForLastOperation
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 36043
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_FLASH_OB_EnablePCROP_0
.loc 1 36045
    MOVW r0, #15382
    MOVT r0, #16386
    PUSH {r0}
    POP {r0}
    PUSH {r0}
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    MOV r2, #2
    MUL r1, r2
    ADD r0, r0, r1
    LDRSH r0, [r0, #0]
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STRH r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_FLASH_OB_EnablePCROP_1
.L_FLASH_OB_EnablePCROP_0:
.L_FLASH_OB_EnablePCROP_1:
.loc 1 36048
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #16
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size FLASH_OB_EnablePCROP, .-FLASH_OB_EnablePCROP

.global FLASH_OB_DisablePCROP
.type FLASH_OB_DisablePCROP, %function
FLASH_OB_DisablePCROP:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #16
    MOV r6, sp
.loc 1 36048
    STR r0, [r6, #0]
.loc 1 36063
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
.loc 1 36066
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 36069
    MOVW r0, #50000
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    BL FLASH_WaitForLastOperation
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 36071
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_FLASH_OB_DisablePCROP_0
.loc 1 36073
    MOVW r0, #15382
    MOVT r0, #16386
    PUSH {r0}
    POP {r0}
    PUSH {r0}
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    MOV r2, #2
    MUL r1, r2
    ADD r0, r0, r1
    LDRSH r0, [r0, #0]
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STRH r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_FLASH_OB_DisablePCROP_1
.L_FLASH_OB_DisablePCROP_0:
.L_FLASH_OB_DisablePCROP_1:
.loc 1 36076
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #16
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size FLASH_OB_DisablePCROP, .-FLASH_OB_DisablePCROP

.global FLASH_OB_RDP_LevelConfig
.type FLASH_OB_RDP_LevelConfig, %function
FLASH_OB_RDP_LevelConfig:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #16
    MOV r6, sp
.loc 1 36076
    STR r0, [r6, #0]
.loc 1 36095
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
.loc 1 36098
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 36101
    MOVW r0, #50000
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    BL FLASH_WaitForLastOperation
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 36103
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_FLASH_OB_RDP_LevelConfig_0
.loc 1 36105
    MOVW r0, #15381
    MOVT r0, #16386
    PUSH {r0}
    LDRB r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STRB r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_FLASH_OB_RDP_LevelConfig_1
.L_FLASH_OB_RDP_LevelConfig_0:
.L_FLASH_OB_RDP_LevelConfig_1:
.loc 1 36108
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #16
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size FLASH_OB_RDP_LevelConfig, .-FLASH_OB_RDP_LevelConfig

.global FLASH_OB_UserConfig
.type FLASH_OB_UserConfig, %function
FLASH_OB_UserConfig:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #40
    MOV r6, sp
.loc 1 36108
    STR r0, [r6, #0]
    STR r1, [r6, #8]
    STR r2, [r6, #16]
.loc 1 36130
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #32]
.loc 1 36133
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 36134
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 36135
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 36138
    MOVW r0, #50000
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    BL FLASH_WaitForLastOperation
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #32]
    LDR r0, [r6, #32]
    PUSH {r0}
    POP {r0}
.loc 1 36140
    LDR r0, [r6, #32]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_FLASH_OB_UserConfig_0
.loc 1 36143
    MOVW r0, #15380
    MOVT r0, #16386
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    LDRB r0, [r0, #0]
    PUSH {r0}
    MOV r0, #31
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STRB r0, [r6, #24]
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
.loc 1 36146
    MOVW r0, #15380
    MOVT r0, #16386
    PUSH {r0}
    LDRB r0, [r6, #0]
    PUSH {r0}
    LDRB r0, [r6, #16]
    PUSH {r0}
    LDRB r0, [r6, #8]
    PUSH {r0}
    LDRB r0, [r6, #24]
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STRB r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_FLASH_OB_UserConfig_1
.L_FLASH_OB_UserConfig_0:
.L_FLASH_OB_UserConfig_1:
.loc 1 36149
    LDR r0, [r6, #32]
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #40
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size FLASH_OB_UserConfig, .-FLASH_OB_UserConfig

.global FLASH_OB_BOR_LevelConfig
.type FLASH_OB_BOR_LevelConfig, %function
FLASH_OB_BOR_LevelConfig:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 36149
    STR r0, [r6, #0]
.loc 1 36165
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 36168
    MOVW r0, #15380
    MOVT r0, #16386
    PUSH {r0}
    POP {r0}
    PUSH {r0}
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    LDRB r0, [r0, #0]
    PUSH {r0}
    MOV r0, #12
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STRB r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 36169
    MOVW r0, #15380
    MOVT r0, #16386
    PUSH {r0}
    POP {r0}
    PUSH {r0}
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    LDRB r0, [r0, #0]
    PUSH {r0}
    LDRB r0, [r6, #0]
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STRB r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 36171
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size FLASH_OB_BOR_LevelConfig, .-FLASH_OB_BOR_LevelConfig

.global FLASH_OB_GetUser
.type FLASH_OB_GetUser, %function
FLASH_OB_GetUser:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 36171
.loc 1 36183
    MOVW r0, #15380
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
    MOV r0, #224
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size FLASH_OB_GetUser, .-FLASH_OB_GetUser

.global FLASH_OB_GetWRP
.type FLASH_OB_GetWRP, %function
FLASH_OB_GetWRP:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 36183
.loc 1 36193
    MOVW r0, #15382
    MOVT r0, #16386
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    MOV r2, #2
    MUL r1, r2
    ADD r0, r0, r1
    LDRSH r0, [r0, #0]
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size FLASH_OB_GetWRP, .-FLASH_OB_GetWRP

.global FLASH_OB_GetRDP
.type FLASH_OB_GetRDP, %function
FLASH_OB_GetRDP:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 36193
.loc 1 36206
    MOV r0, #170
    PUSH {r0}
    POP {r0}
    STRB r0, [r6, #0]
.loc 1 36208
    MOVW r0, #15381
    MOVT r0, #16386
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    LDRB r0, [r0, #0]
    PUSH {r0}
    MOV r0, #204
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_FLASH_OB_GetRDP_0
.loc 1 36210
    MOV r0, #204
    PUSH {r0}
    POP {r0}
    STRB r0, [r6, #0]
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    B .L_FLASH_OB_GetRDP_1
.L_FLASH_OB_GetRDP_0:
.loc 1 36212
    MOVW r0, #15381
    MOVT r0, #16386
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    LDRB r0, [r0, #0]
    PUSH {r0}
    MOV r0, #170
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_FLASH_OB_GetRDP_2
.loc 1 36214
    MOV r0, #170
    PUSH {r0}
    POP {r0}
    STRB r0, [r6, #0]
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    B .L_FLASH_OB_GetRDP_3
.L_FLASH_OB_GetRDP_2:
.loc 1 36218
    MOV r0, #85
    PUSH {r0}
    POP {r0}
    STRB r0, [r6, #0]
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
.L_FLASH_OB_GetRDP_3:
.L_FLASH_OB_GetRDP_1:
.loc 1 36221
    LDRB r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size FLASH_OB_GetRDP, .-FLASH_OB_GetRDP

.global FLASH_OB_GetBOR
.type FLASH_OB_GetBOR, %function
FLASH_OB_GetBOR:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 36221
.loc 1 36235
    MOVW r0, #15380
    MOVT r0, #16386
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    LDRB r0, [r0, #0]
    PUSH {r0}
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size FLASH_OB_GetBOR, .-FLASH_OB_GetBOR

.global FLASH_FlushCaches
.type FLASH_FlushCaches, %function
FLASH_FlushCaches:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 36235
.loc 1 36245
    MOVW r0, #15360
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
    MOVW r0, #512
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_FLASH_FlushCaches_0
.loc 1 36248
    MOVW r0, #15360
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
    MOVW r0, #512
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 36250
.L_FLASH_FlushCaches_2:
    MOVW r0, #15360
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
    MOVW r0, #2048
    MOVT r0, #0
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
    MOVW r0, #15360
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
    MOVW r0, #2048
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_FLASH_FlushCaches_4:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_FLASH_FlushCaches_2
.L_FLASH_FlushCaches_3:
.loc 1 36252
    MOVW r0, #15360
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
    MOVW r0, #512
    MOVT r0, #0
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
    B .L_FLASH_FlushCaches_1
.L_FLASH_FlushCaches_0:
.L_FLASH_FlushCaches_1:
.loc 1 36256
    MOVW r0, #15360
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
    MOVW r0, #1024
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_FLASH_FlushCaches_5
.loc 1 36259
    MOVW r0, #15360
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
    MOVW r0, #1024
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 36261
.L_FLASH_FlushCaches_7:
    MOVW r0, #15360
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
    MOVW r0, #4096
    MOVT r0, #0
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
    MOVW r0, #15360
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
    MOVW r0, #4096
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_FLASH_FlushCaches_9:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_FLASH_FlushCaches_7
.L_FLASH_FlushCaches_8:
.loc 1 36263
    MOVW r0, #15360
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
    MOVW r0, #1024
    MOVT r0, #0
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
    B .L_FLASH_FlushCaches_6
.L_FLASH_FlushCaches_5:
.L_FLASH_FlushCaches_6:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size FLASH_FlushCaches, .-FLASH_FlushCaches

.global HAL_EXTI_SetConfigLine
.type HAL_EXTI_SetConfigLine, %function
HAL_EXTI_SetConfigLine:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #40
    MOV r6, sp
.loc 1 36263
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 36681
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_EXTI_SetConfigLine_2
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    B .L_HAL_EXTI_SetConfigLine_3
.L_HAL_EXTI_SetConfigLine_2:
    MOV r0, #1
    PUSH {r0}
.L_HAL_EXTI_SetConfigLine_3:
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_EXTI_SetConfigLine_0
.loc 1 36683
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #40
    POP {r5, r6, r7, pc}
.L_HAL_EXTI_SetConfigLine_0:
.L_HAL_EXTI_SetConfigLine_1:
.loc 1 36687
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 36688
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 36691
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 36694
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #31
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
.loc 1 36695
    MOV r0, #1
    PUSH {r0}
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #32]
    LDR r0, [r6, #32]
    PUSH {r0}
    POP {r0}
.loc 1 36698
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVT r0, #512
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_EXTI_SetConfigLine_4
.loc 1 36700
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 36704
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_EXTI_SetConfigLine_6
.loc 1 36706
    MOVW r0, #15368
    MOVT r0, #16385
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
    LDR r0, [r6, #32]
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
    B .L_HAL_EXTI_SetConfigLine_7
.L_HAL_EXTI_SetConfigLine_6:
.loc 1 36710
    MOVW r0, #15368
    MOVT r0, #16385
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
    LDR r0, [r6, #32]
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_EXTI_SetConfigLine_7:
.loc 1 36715
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_EXTI_SetConfigLine_8
.loc 1 36717
    MOVW r0, #15372
    MOVT r0, #16385
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
    LDR r0, [r6, #32]
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
    B .L_HAL_EXTI_SetConfigLine_9
.L_HAL_EXTI_SetConfigLine_8:
.loc 1 36721
    MOVW r0, #15372
    MOVT r0, #16385
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
    LDR r0, [r6, #32]
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_EXTI_SetConfigLine_9:
.loc 1 36726
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVT r0, #1536
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOVW r0, #0
    MOVT r0, #1536
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_EXTI_SetConfigLine_10
.loc 1 36728
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 36729
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 36731
    MOVW r0, #14344
    MOVT r0, #16385
    PUSH {r0}
    LDR r0, [r6, #24]
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
.loc 1 36732
    LDR r0, [r6, #16]
    PUSH {r0}
    MOV r0, #15
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    LDR r0, [r6, #24]
    PUSH {r0}
    MOV r0, #3
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
.loc 1 36733
    LDR r0, [r6, #16]
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    LDR r0, [r6, #24]
    PUSH {r0}
    MOV r0, #3
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
.loc 1 36734
    MOVW r0, #14344
    MOVT r0, #16385
    PUSH {r0}
    LDR r0, [r6, #24]
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_HAL_EXTI_SetConfigLine_11
.L_HAL_EXTI_SetConfigLine_10:
.L_HAL_EXTI_SetConfigLine_11:
    B .L_HAL_EXTI_SetConfigLine_5
.L_HAL_EXTI_SetConfigLine_4:
.L_HAL_EXTI_SetConfigLine_5:
.loc 1 36740
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_EXTI_SetConfigLine_12
.loc 1 36742
    MOVW r0, #15360
    MOVT r0, #16385
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
    LDR r0, [r6, #32]
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
    B .L_HAL_EXTI_SetConfigLine_13
.L_HAL_EXTI_SetConfigLine_12:
.loc 1 36746
    MOVW r0, #15360
    MOVT r0, #16385
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
    LDR r0, [r6, #32]
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_EXTI_SetConfigLine_13:
.loc 1 36751
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_EXTI_SetConfigLine_14
.loc 1 36753
    MOVW r0, #15364
    MOVT r0, #16385
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
    LDR r0, [r6, #32]
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
    B .L_HAL_EXTI_SetConfigLine_15
.L_HAL_EXTI_SetConfigLine_14:
.loc 1 36757
    MOVW r0, #15364
    MOVT r0, #16385
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
    LDR r0, [r6, #32]
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_EXTI_SetConfigLine_15:
.loc 1 36760
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #40
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_EXTI_SetConfigLine, .-HAL_EXTI_SetConfigLine

.global HAL_EXTI_GetConfigLine
.type HAL_EXTI_GetConfigLine, %function
HAL_EXTI_GetConfigLine:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #40
    MOV r6, sp
.loc 1 36760
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 36776
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_EXTI_GetConfigLine_2
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    B .L_HAL_EXTI_GetConfigLine_3
.L_HAL_EXTI_GetConfigLine_2:
    MOV r0, #1
    PUSH {r0}
.L_HAL_EXTI_GetConfigLine_3:
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_EXTI_GetConfigLine_0
.loc 1 36778
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #40
    POP {r5, r6, r7, pc}
.L_HAL_EXTI_GetConfigLine_0:
.L_HAL_EXTI_GetConfigLine_1:
.loc 1 36782
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 36785
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 36788
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #31
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
.loc 1 36789
    MOV r0, #1
    PUSH {r0}
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #32]
    LDR r0, [r6, #32]
    PUSH {r0}
    POP {r0}
.loc 1 36794
    MOVW r0, #15360
    MOVT r0, #16385
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
    LDR r0, [r6, #32]
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_EXTI_GetConfigLine_4
.loc 1 36796
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_HAL_EXTI_GetConfigLine_5
.L_HAL_EXTI_GetConfigLine_4:
.loc 1 36800
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_EXTI_GetConfigLine_5:
.loc 1 36805
    MOVW r0, #15364
    MOVT r0, #16385
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
    LDR r0, [r6, #32]
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_EXTI_GetConfigLine_6
.loc 1 36807
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    B .L_HAL_EXTI_GetConfigLine_7
.L_HAL_EXTI_GetConfigLine_6:
.L_HAL_EXTI_GetConfigLine_7:
.loc 1 36811
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 36812
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 36815
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVT r0, #512
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_EXTI_GetConfigLine_8
.loc 1 36818
    MOVW r0, #15368
    MOVT r0, #16385
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
    LDR r0, [r6, #32]
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_EXTI_GetConfigLine_10
.loc 1 36820
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_HAL_EXTI_GetConfigLine_11
.L_HAL_EXTI_GetConfigLine_10:
.L_HAL_EXTI_GetConfigLine_11:
.loc 1 36825
    MOVW r0, #15372
    MOVT r0, #16385
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
    LDR r0, [r6, #32]
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_EXTI_GetConfigLine_12
.loc 1 36827
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    B .L_HAL_EXTI_GetConfigLine_13
.L_HAL_EXTI_GetConfigLine_12:
.L_HAL_EXTI_GetConfigLine_13:
.loc 1 36831
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVT r0, #1536
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOVW r0, #0
    MOVT r0, #1536
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_EXTI_GetConfigLine_14
.loc 1 36833
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 36835
    MOVW r0, #14344
    MOVT r0, #16385
    PUSH {r0}
    LDR r0, [r6, #24]
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
.loc 1 36836
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    LDR r0, [r6, #24]
    PUSH {r0}
    MOV r0, #3
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    MOV r0, #15
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_HAL_EXTI_GetConfigLine_15
.L_HAL_EXTI_GetConfigLine_14:
.L_HAL_EXTI_GetConfigLine_15:
    B .L_HAL_EXTI_GetConfigLine_9
.L_HAL_EXTI_GetConfigLine_8:
.L_HAL_EXTI_GetConfigLine_9:
.loc 1 36840
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #40
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_EXTI_GetConfigLine, .-HAL_EXTI_GetConfigLine

.global HAL_EXTI_ClearConfigLine
.type HAL_EXTI_ClearConfigLine, %function
HAL_EXTI_ClearConfigLine:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #32
    MOV r6, sp
.loc 1 36840
    STR r0, [r6, #0]
.loc 1 36855
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_EXTI_ClearConfigLine_0
.loc 1 36857
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #32
    POP {r5, r6, r7, pc}
.L_HAL_EXTI_ClearConfigLine_0:
.L_HAL_EXTI_ClearConfigLine_1:
.loc 1 36861
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 36864
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #31
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
.loc 1 36865
    MOV r0, #1
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
.loc 1 36868
    MOVW r0, #15360
    MOVT r0, #16385
    PUSH {r0}
    MOVW r0, #15360
    MOVT r0, #16385
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
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 36871
    MOVW r0, #15364
    MOVT r0, #16385
    PUSH {r0}
    MOVW r0, #15364
    MOVT r0, #16385
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
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 36874
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVT r0, #512
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_EXTI_ClearConfigLine_2
.loc 1 36876
    MOVW r0, #15368
    MOVT r0, #16385
    PUSH {r0}
    MOVW r0, #15368
    MOVT r0, #16385
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
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 36877
    MOVW r0, #15372
    MOVT r0, #16385
    PUSH {r0}
    MOVW r0, #15372
    MOVT r0, #16385
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
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 36880
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOVT r0, #1536
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOVW r0, #0
    MOVT r0, #1536
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_EXTI_ClearConfigLine_4
.loc 1 36882
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 36884
    MOVW r0, #14344
    MOVT r0, #16385
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 36885
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #15
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    MOV r0, #3
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 36886
    MOVW r0, #14344
    MOVT r0, #16385
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
    B .L_HAL_EXTI_ClearConfigLine_5
.L_HAL_EXTI_ClearConfigLine_4:
.L_HAL_EXTI_ClearConfigLine_5:
    B .L_HAL_EXTI_ClearConfigLine_3
.L_HAL_EXTI_ClearConfigLine_2:
.L_HAL_EXTI_ClearConfigLine_3:
.loc 1 36890
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #32
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_EXTI_ClearConfigLine, .-HAL_EXTI_ClearConfigLine

.global HAL_EXTI_RegisterCallback
.type HAL_EXTI_RegisterCallback, %function
HAL_EXTI_RegisterCallback:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #40
    MOV r6, sp
.loc 1 36890
    STR r0, [r6, #0]
    STR r1, [r6, #8]
    STR r2, [r6, #16]
.loc 1 36903
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
.loc 1 36905
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #32]
    LDR r0, [r6, #32]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_EXTI_RegisterCallback_1
    B .L_HAL_EXTI_RegisterCallback_2
.loc 1 36907
.L_HAL_EXTI_RegisterCallback_1:
.loc 1 36908
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 36909
    B .L_HAL_EXTI_RegisterCallback_0
.loc 1 36911
.L_HAL_EXTI_RegisterCallback_2:
.loc 1 36912
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
.loc 1 36913
    B .L_HAL_EXTI_RegisterCallback_0
.L_HAL_EXTI_RegisterCallback_0:
.loc 1 36916
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #40
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_EXTI_RegisterCallback, .-HAL_EXTI_RegisterCallback

.global HAL_EXTI_GetHandle
.type HAL_EXTI_GetHandle, %function
HAL_EXTI_GetHandle:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #16
    MOV r6, sp
.loc 1 36916
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 36929
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 36932
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_EXTI_GetHandle_0
.loc 1 36934
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #16
    POP {r5, r6, r7, pc}
.L_HAL_EXTI_GetHandle_0:
.loc 1 36939
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 36941
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #16
    POP {r5, r6, r7, pc}
.L_HAL_EXTI_GetHandle_1:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #16
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_EXTI_GetHandle, .-HAL_EXTI_GetHandle

.global HAL_EXTI_IRQHandler
.type HAL_EXTI_IRQHandler, %function
HAL_EXTI_IRQHandler:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #24
    MOV r6, sp
.loc 1 36941
    STR r0, [r6, #0]
.loc 1 36972
    MOV r0, #1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #31
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
.loc 1 36975
    MOVW r0, #15380
    MOVT r0, #16385
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
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 36976
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_EXTI_IRQHandler_0
.loc 1 36979
    MOVW r0, #15380
    MOVT r0, #16385
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 36982
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HAL_EXTI_IRQHandler_2
.loc 1 36984
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    POP {ip}
    ORR ip, ip, #1
    BLX ip
    PUSH {r0}
    POP {r0}
    B .L_HAL_EXTI_IRQHandler_3
.L_HAL_EXTI_IRQHandler_2:
.L_HAL_EXTI_IRQHandler_3:
    B .L_HAL_EXTI_IRQHandler_1
.L_HAL_EXTI_IRQHandler_0:
.L_HAL_EXTI_IRQHandler_1:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #24
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_EXTI_IRQHandler, .-HAL_EXTI_IRQHandler

.global HAL_EXTI_GetPending
.type HAL_EXTI_GetPending, %function
HAL_EXTI_GetPending:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #40
    MOV r6, sp
.loc 1 36984
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 37005
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 37008
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 37009
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 37010
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 37013
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #31
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
.loc 1 37014
    MOV r0, #1
    PUSH {r0}
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #32]
    LDR r0, [r6, #32]
    PUSH {r0}
    POP {r0}
.loc 1 37017
    MOVW r0, #15380
    MOVT r0, #16385
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
    LDR r0, [r6, #32]
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
.loc 1 37018
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #40
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_EXTI_GetPending, .-HAL_EXTI_GetPending

.global HAL_EXTI_ClearPending
.type HAL_EXTI_ClearPending, %function
HAL_EXTI_ClearPending:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #24
    MOV r6, sp
.loc 1 37018
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 37035
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 37038
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 37039
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 37040
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 37043
    MOV r0, #1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #31
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
.loc 1 37046
    MOVW r0, #15380
    MOVT r0, #16385
    PUSH {r0}
    LDR r0, [r6, #16]
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
    ADD sp, sp, #24
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_EXTI_ClearPending, .-HAL_EXTI_ClearPending

.global HAL_EXTI_GenerateSWI
.type HAL_EXTI_GenerateSWI, %function
HAL_EXTI_GenerateSWI:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #16
    MOV r6, sp
.loc 1 37046
    STR r0, [r6, #0]
.loc 1 37059
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 37060
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 37063
    MOV r0, #1
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
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
    MOV r0, #31
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSL r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 37066
    MOVW r0, #15376
    MOVT r0, #16385
    PUSH {r0}
    LDR r0, [r6, #8]
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
    ADD sp, sp, #16
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_EXTI_GenerateSWI, .-HAL_EXTI_GenerateSWI

.global SystemInit
.type SystemInit, %function
SystemInit:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 37066
.loc 1 37372
    MOVW r0, #60808
    MOVT r0, #57344
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
    MOVW r0, #0
    MOVT r0, #240
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
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size SystemInit, .-SystemInit

.global SystemCoreClockUpdate
.type SystemCoreClockUpdate, %function
SystemCoreClockUpdate:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #48
    MOV r6, sp
.loc 1 37372
.loc 1 37424
    MOVW r0, #14344
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
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
.loc 1 37426
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #40]
    LDR r0, [r6, #40]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_SystemCoreClockUpdate_1
    LDR r0, [r6, #40]
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_SystemCoreClockUpdate_2
    LDR r0, [r6, #40]
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_SystemCoreClockUpdate_3
    B .L_SystemCoreClockUpdate_4
.loc 1 37428
.L_SystemCoreClockUpdate_1:
.loc 1 37429
    MOVW r0, #9216
    MOVT r0, #244
    PUSH {r0}
    POP {r0}
    PUSH {r0}
    PUSH {r0}
    POP {r0}
    MOVW r1, #0
    MOVT r1, #8192
    STR r0, [r1]
    POP {r0}
.loc 1 37430
    B .L_SystemCoreClockUpdate_0
.loc 1 37431
.L_SystemCoreClockUpdate_2:
.loc 1 37432
    MOVW r0, #30784
    MOVT r0, #381
    PUSH {r0}
    POP {r0}
    PUSH {r0}
    PUSH {r0}
    POP {r0}
    MOVW r1, #0
    MOVT r1, #8192
    STR r0, [r1]
    POP {r0}
.loc 1 37433
    B .L_SystemCoreClockUpdate_0
.loc 1 37434
.L_SystemCoreClockUpdate_3:
.loc 1 37439
    MOVW r0, #14340
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
    MOVT r0, #64
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #22
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
.loc 1 37440
    MOVW r0, #14340
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
    MOV r0, #63
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #32]
    LDR r0, [r6, #32]
    PUSH {r0}
    POP {r0}
.loc 1 37442
    LDR r0, [r6, #24]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_SystemCoreClockUpdate_5
.loc 1 37445
    MOVW r0, #30784
    MOVT r0, #381
    PUSH {r0}
    LDR r0, [r6, #32]
    PUSH {r0}
    POP {r1}
    POP {r0}
    UDIV r0, r0, r1
    PUSH {r0}
    MOVW r0, #14340
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
    MOVW r0, #32704
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #6
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
    B .L_SystemCoreClockUpdate_6
.L_SystemCoreClockUpdate_5:
.loc 1 37450
    MOVW r0, #9216
    MOVT r0, #244
    PUSH {r0}
    LDR r0, [r6, #32]
    PUSH {r0}
    POP {r1}
    POP {r0}
    UDIV r0, r0, r1
    PUSH {r0}
    MOVW r0, #14340
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
    MOVW r0, #32704
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #6
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.L_SystemCoreClockUpdate_6:
.loc 1 37453
    MOVW r0, #14340
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
    MOVT r0, #3
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
.loc 1 37454
    LDR r0, [r6, #8]
    PUSH {r0}
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r1}
    POP {r0}
    UDIV r0, r0, r1
    PUSH {r0}
    POP {r0}
    PUSH {r0}
    PUSH {r0}
    POP {r0}
    MOVW r1, #0
    MOVT r1, #8192
    STR r0, [r1]
    POP {r0}
.loc 1 37455
    B .L_SystemCoreClockUpdate_0
.loc 1 37456
.L_SystemCoreClockUpdate_4:
.loc 1 37457
    MOVW r0, #9216
    MOVT r0, #244
    PUSH {r0}
    POP {r0}
    PUSH {r0}
    PUSH {r0}
    POP {r0}
    MOVW r1, #0
    MOVT r1, #8192
    STR r0, [r1]
    POP {r0}
.loc 1 37458
    B .L_SystemCoreClockUpdate_0
.L_SystemCoreClockUpdate_0:
.loc 1 37462
    MOVW r0, #4
    MOVT r0, #8192
    PUSH {r0}
    MOVW r0, #14344
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
    MOV r0, #240
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    LSR r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    LDRB r0, [r0, #0]
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
.loc 1 37464
    MOVW r0, #0
    MOVT r0, #8192
    LDR r0, [r0]
    PUSH {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r1}
    POP {r0}
    ASR r0, r1
    PUSH {r0}
    POP {r0}
    PUSH {r0}
    PUSH {r0}
    POP {r0}
    MOVW r1, #0
    MOVT r1, #8192
    STR r0, [r1]
    POP {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #48
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size SystemCoreClockUpdate, .-SystemCoreClockUpdate

.global HAL_MspInit
.type HAL_MspInit, %function
HAL_MspInit:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8
    MOV r6, sp
.loc 1 37464
.loc 1 37748
.L_HAL_MspInit_0:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
    MOVW r0, #14404
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
    MOVW r0, #16384
    MOVT r0, #0
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
    MOVW r0, #14404
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
    MOVW r0, #16384
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_MspInit_2:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_MspInit_0
.L_HAL_MspInit_1:
.loc 1 37749
.L_HAL_MspInit_3:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
    MOVW r0, #14400
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
    MOVW r0, #0
    MOVT r0, #4096
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
    MOVW r0, #14400
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
    MOVT r0, #4096
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
.L_HAL_MspInit_5:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_HAL_MspInit_3
.L_HAL_MspInit_4:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HAL_MspInit, .-HAL_MspInit

.global NMI_Handler
.type NMI_Handler, %function
NMI_Handler:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 37749
.loc 1 37929
.L_NMI_Handler_0:
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_NMI_Handler_1
.loc 1 37930
    B .L_NMI_Handler_0
.L_NMI_Handler_1:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size NMI_Handler, .-NMI_Handler

.global HardFault_Handler
.type HardFault_Handler, %function
HardFault_Handler:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 37930
.loc 1 37943
.L_HardFault_Handler_0:
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HardFault_Handler_1
.loc 1 37944
    B .L_HardFault_Handler_0
.L_HardFault_Handler_1:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size HardFault_Handler, .-HardFault_Handler

.global MemManage_Handler
.type MemManage_Handler, %function
MemManage_Handler:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 37944
.loc 1 37958
.L_MemManage_Handler_0:
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_MemManage_Handler_1
.loc 1 37959
    B .L_MemManage_Handler_0
.L_MemManage_Handler_1:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size MemManage_Handler, .-MemManage_Handler

.global BusFault_Handler
.type BusFault_Handler, %function
BusFault_Handler:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 37959
.loc 1 37973
.L_BusFault_Handler_0:
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_BusFault_Handler_1
.loc 1 37974
    B .L_BusFault_Handler_0
.L_BusFault_Handler_1:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size BusFault_Handler, .-BusFault_Handler

.global UsageFault_Handler
.type UsageFault_Handler, %function
UsageFault_Handler:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 37974
.loc 1 37988
.L_UsageFault_Handler_0:
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_UsageFault_Handler_1
.loc 1 37989
    B .L_UsageFault_Handler_0
.L_UsageFault_Handler_1:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size UsageFault_Handler, .-UsageFault_Handler

.global SVC_Handler
.type SVC_Handler, %function
SVC_Handler:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 37989
.loc 1 37999
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size SVC_Handler, .-SVC_Handler

.global DebugMon_Handler
.type DebugMon_Handler, %function
DebugMon_Handler:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 37999
.loc 1 38012
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size DebugMon_Handler, .-DebugMon_Handler

.global PendSV_Handler
.type PendSV_Handler, %function
PendSV_Handler:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 38012
.loc 1 38025
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size PendSV_Handler, .-PendSV_Handler

.global SysTick_Handler
.type SysTick_Handler, %function
SysTick_Handler:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 38025
.loc 1 38042
    BL HAL_IncTick
    PUSH {r0}
    POP {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size SysTick_Handler, .-SysTick_Handler

.global MX_GPIO_Init
.type MX_GPIO_Init, %function
MX_GPIO_Init:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #32
    MOV r6, sp
.loc 1 38042
.loc 1 38179
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #4]
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #12]
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
.loc 1 38182
.L_MX_GPIO_Init_0:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
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
    MOVW r0, #14384
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
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
.L_MX_GPIO_Init_2:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_MX_GPIO_Init_0
.L_MX_GPIO_Init_1:
.loc 1 38183
.L_MX_GPIO_Init_3:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
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
    MOV r0, #128
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
    MOVW r0, #14384
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
    MOV r0, #128
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
.L_MX_GPIO_Init_5:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_MX_GPIO_Init_3
.L_MX_GPIO_Init_4:
.loc 1 38186
    MOV r0, #0
    PUSH {r0}
    MOVW r0, #8192
    MOVT r0, #0
    PUSH {r0}
    MOVW r0, #2048
    MOVT r0, #16386
    PUSH {r0}
    POP {r0}
    POP {r1}
    POP {r2}
    BL HAL_GPIO_WritePin
    PUSH {r0}
    POP {r0}
.loc 1 38189
    ADD r0, r6, #0
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOVW r0, #8192
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 38190
    ADD r0, r6, #0
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 38191
    ADD r0, r6, #0
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 38192
    ADD r0, r6, #0
    PUSH {r0}
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 38193
    ADD r0, r6, #0
    PUSH {r0}
    MOVW r0, #2048
    MOVT r0, #16386
    PUSH {r0}
    POP {r0}
    POP {r1}
    BL HAL_GPIO_Init
    PUSH {r0}
    POP {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #32
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size MX_GPIO_Init, .-MX_GPIO_Init

.global main
.type main, %function
main:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 38193
.loc 1 38332
    BL HAL_Init
    PUSH {r0}
    POP {r0}
.loc 1 38339
    BL SystemClock_Config
    PUSH {r0}
    POP {r0}
.loc 1 38346
    BL MX_GPIO_Init
    PUSH {r0}
    POP {r0}
.loc 1 38353
.L_main_0:
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_main_1
.loc 1 38355
    MOV r0, #0
    PUSH {r0}
    MOVW r0, #8192
    MOVT r0, #0
    PUSH {r0}
    MOVW r0, #2048
    MOVT r0, #16386
    PUSH {r0}
    POP {r0}
    POP {r1}
    POP {r2}
    BL HAL_GPIO_WritePin
    PUSH {r0}
    POP {r0}
.loc 1 38356
    MOVW r0, #500
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    BL HAL_Delay
    PUSH {r0}
    POP {r0}
.loc 1 38357
    MOV r0, #1
    PUSH {r0}
    MOVW r0, #8192
    MOVT r0, #0
    PUSH {r0}
    MOVW r0, #2048
    MOVT r0, #16386
    PUSH {r0}
    POP {r0}
    POP {r1}
    POP {r2}
    BL HAL_GPIO_WritePin
    PUSH {r0}
    POP {r0}
.loc 1 38358
    MOVW r0, #500
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    BL HAL_Delay
    PUSH {r0}
    POP {r0}
    B .L_main_0
.L_main_1:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size main, .-main

.global SystemClock_Config
.type SystemClock_Config, %function
SystemClock_Config:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #80
    MOV r6, sp
.loc 1 38358
.loc 1 38372
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #4]
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #12]
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #20]
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #28]
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #32]
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #36]
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #40]
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #44]
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
.loc 1 38373
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #48]
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #52]
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #56]
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #60]
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #64]
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #48]
.loc 1 38377
.L_SystemClock_Config_0:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #72]
    MOVW r0, #14400
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
    MOVW r0, #0
    MOVT r0, #4096
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
    MOVW r0, #14400
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
    MOVT r0, #4096
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #72]
    LDR r0, [r6, #72]
    PUSH {r0}
    POP {r0}
    LDR r0, [r6, #72]
    PUSH {r0}
    POP {r0}
.L_SystemClock_Config_2:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_SystemClock_Config_0
.L_SystemClock_Config_1:
.loc 1 38378
.L_SystemClock_Config_3:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #72]
    MOVW r0, #28672
    MOVT r0, #16384
    PUSH {r0}
    MOVW r0, #28672
    MOVT r0, #16384
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
    MOVW r0, #49152
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    MVN r0, r0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    MOVW r0, #32768
    MOVT r0, #0
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
    MOVW r0, #28672
    MOVT r0, #16384
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
    MOVW r0, #49152
    MOVT r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    AND r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #72]
    LDR r0, [r6, #72]
    PUSH {r0}
    POP {r0}
    LDR r0, [r6, #72]
    PUSH {r0}
    POP {r0}
.L_SystemClock_Config_5:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BNE .L_SystemClock_Config_3
.L_SystemClock_Config_4:
.loc 1 38383
    ADD r0, r6, #0
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #2
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 38384
    ADD r0, r6, #0
    PUSH {r0}
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 38385
    ADD r0, r6, #0
    PUSH {r0}
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #16
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 38386
    ADD r0, r6, #0
    PUSH {r0}
    MOV r0, #24
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 38387
    ADD r0, r6, #0
    PUSH {r0}
    POP {r0}
    BL HAL_RCC_OscConfig
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_SystemClock_Config_6
.loc 1 38389
    BL Error_Handler
    PUSH {r0}
    POP {r0}
    B .L_SystemClock_Config_7
.L_SystemClock_Config_6:
.L_SystemClock_Config_7:
.loc 1 38394
    ADD r0, r6, #48
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #15
    PUSH {r0}
.loc 1 38395
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 38396
    ADD r0, r6, #48
    PUSH {r0}
    MOV r0, #4
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 38397
    ADD r0, r6, #48
    PUSH {r0}
    MOV r0, #8
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 38398
    ADD r0, r6, #48
    PUSH {r0}
    MOV r0, #12
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 38399
    ADD r0, r6, #48
    PUSH {r0}
    MOV r0, #16
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 38401
    MOV r0, #0
    PUSH {r0}
    ADD r0, r6, #48
    PUSH {r0}
    POP {r0}
    POP {r1}
    BL HAL_RCC_ClockConfig
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    CMP r0, r1
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_SystemClock_Config_8
.loc 1 38403
    BL Error_Handler
    PUSH {r0}
    POP {r0}
    B .L_SystemClock_Config_9
.L_SystemClock_Config_8:
.L_SystemClock_Config_9:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #80
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size SystemClock_Config, .-SystemClock_Config

.global Error_Handler
.type Error_Handler, %function
Error_Handler:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 38403
.loc 1 38419
    CPSID i
    PUSH {r0}
    POP {r0}
.loc 1 38420
.L_Error_Handler_0:
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_Error_Handler_1
.loc 1 38421
    B .L_Error_Handler_0
.L_Error_Handler_1:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size Error_Handler, .-Error_Handler

.global __force_stores
.type __force_stores, %function
__force_stores:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 38421
.loc 1 38432
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size __force_stores, .-__force_stores

.global __wfi
.type __wfi, %function
__wfi:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 38432
.loc 1 38433
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size __wfi, .-__wfi

.global __wfe
.type __wfe, %function
__wfe:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 38433
.loc 1 38434
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size __wfe, .-__wfe

.global __sev
.type __sev, %function
__sev:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 38434
.loc 1 38435
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size __sev, .-__sev

.global Reset_Handler
.type Reset_Handler, %function
Reset_Handler:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
    BL __arkcc_init_globals
.loc 1 38435
.loc 1 38451
    BL SystemInit
    PUSH {r0}
    POP {r0}
.loc 1 38452
    BL main
    PUSH {r0}
    POP {r0}
.loc 1 38453
.L_Reset_Handler_0:
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_Reset_Handler_1
    B .L_Reset_Handler_0
.L_Reset_Handler_1:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size Reset_Handler, .-Reset_Handler

.global Default_Handler
.type Default_Handler, %function
Default_Handler:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 38453
.loc 1 38457
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

.global __arkcc_init_globals
.thumb_func
__arkcc_init_globals:
    PUSH {lr}
    MOVW r0, #9216
    MOVT r0, #244
    MOVW r1, #0
    MOVT r1, #8192
    STR r0, [r1]
    MOV r0, #0
    MOVW r1, #4
    MOVT r1, #8192
    STRB r0, [r1]
    MOV r0, #0
    MOVW r1, #5
    MOVT r1, #8192
    STRB r0, [r1]
    MOV r0, #0
    MOVW r1, #6
    MOVT r1, #8192
    STRB r0, [r1]
    MOV r0, #0
    MOVW r1, #7
    MOVT r1, #8192
    STRB r0, [r1]
    MOV r0, #0
    MOVW r1, #8
    MOVT r1, #8192
    STRB r0, [r1]
    MOV r0, #0
    MOVW r1, #9
    MOVT r1, #8192
    STRB r0, [r1]
    MOV r0, #0
    MOVW r1, #10
    MOVT r1, #8192
    STRB r0, [r1]
    MOV r0, #0
    MOVW r1, #11
    MOVT r1, #8192
    STRB r0, [r1]
    MOV r0, #1
    MOVW r1, #12
    MOVT r1, #8192
    STRB r0, [r1]
    MOV r0, #2
    MOVW r1, #13
    MOVT r1, #8192
    STRB r0, [r1]
    MOV r0, #3
    MOVW r1, #14
    MOVT r1, #8192
    STRB r0, [r1]
    MOV r0, #4
    MOVW r1, #15
    MOVT r1, #8192
    STRB r0, [r1]
    MOV r0, #6
    MOVW r1, #16
    MOVT r1, #8192
    STRB r0, [r1]
    MOV r0, #7
    MOVW r1, #17
    MOVT r1, #8192
    STRB r0, [r1]
    MOV r0, #8
    MOVW r1, #18
    MOVT r1, #8192
    STRB r0, [r1]
    MOV r0, #9
    MOVW r1, #19
    MOVT r1, #8192
    STRB r0, [r1]
    MOV r0, #0
    MOVW r1, #20
    MOVT r1, #8192
    STRB r0, [r1]
    MOV r0, #0
    MOVW r1, #21
    MOVT r1, #8192
    STRB r0, [r1]
    MOV r0, #0
    MOVW r1, #22
    MOVT r1, #8192
    STRB r0, [r1]
    MOV r0, #0
    MOVW r1, #23
    MOVT r1, #8192
    STRB r0, [r1]
    MOV r0, #1
    MOVW r1, #24
    MOVT r1, #8192
    STRB r0, [r1]
    MOV r0, #2
    MOVW r1, #25
    MOVT r1, #8192
    STRB r0, [r1]
    MOV r0, #3
    MOVW r1, #26
    MOVT r1, #8192
    STRB r0, [r1]
    MOV r0, #4
    MOVW r1, #27
    MOVT r1, #8192
    STRB r0, [r1]
    MOV r0, #16
    MOVW r1, #28
    MOVT r1, #8192
    STR r0, [r1]
    MOV r0, #1
    MOVW r1, #32
    MOVT r1, #8192
    STR r0, [r1]
    MOV r0, #0
    MOVW r1, #36
    MOVT r1, #8192
    STR r0, [r1]
    MOV r0, #0
    MOVW r1, #40
    MOVT r1, #8192
    STR r0, [r1]
    MOV r0, #0
    MOVW r1, #44
    MOVT r1, #8192
    STR r0, [r1]
    MOV r0, #0
    MOVW r1, #48
    MOVT r1, #8192
    STR r0, [r1]
    MOV r0, #1
    MOVW r1, #52
    MOVT r1, #8192
    STR r0, [r1]
    MOV r0, #0
    MOVW r1, #56
    MOVT r1, #8192
    STR r0, [r1]
    MOV r0, #0
    MOVW r1, #60
    MOVT r1, #8192
    STR r0, [r1]
    MOV r0, #0
    MOVW r1, #64
    MOVT r1, #8192
    STR r0, [r1]
    MOV r0, #0
    MOVW r1, #68
    MOVT r1, #8192
    STRB r0, [r1]
    MOV r0, #6
    MOVW r1, #69
    MOVT r1, #8192
    STRB r0, [r1]
    MOV r0, #16
    MOVW r1, #70
    MOVT r1, #8192
    STRB r0, [r1]
    MOV r0, #22
    MOVW r1, #71
    MOVT r1, #8192
    STRB r0, [r1]
    MOV r0, #0
    MOVW r1, #72
    MOVT r1, #8192
    STRB r0, [r1]
    MOV r0, #6
    MOVW r1, #73
    MOVT r1, #8192
    STRB r0, [r1]
    MOV r0, #16
    MOVW r1, #74
    MOVT r1, #8192
    STRB r0, [r1]
    MOV r0, #22
    MOVW r1, #75
    MOVT r1, #8192
    STRB r0, [r1]
    MOVW r0, #76
    MOVT r0, #8192
    MOVW r1, #80
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

