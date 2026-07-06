; Ark C Compiler - generated Thumb-2 assembly
.thumb
.text

.file 1 "phase_diag_all.c"
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
.loc 1 1511
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
.loc 1 1511
    STR r0, [r6, #0]
.loc 1 1523
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 1524
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
.loc 1 1524
.loc 1 1536
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
.loc 1 1536
.loc 1 1548
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
.loc 1 1548
.loc 1 1560
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
.loc 1 1560
.loc 1 1572
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
.loc 1 1572
    STR r0, [r6, #0]
.loc 1 1584
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
.loc 1 1584
.loc 1 1596
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
.loc 1 1596
    STR r0, [r6, #0]
.loc 1 1608
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
.loc 1 1608
.loc 1 1620
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
.loc 1 1620
    STR r0, [r6, #0]
.loc 1 1632
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
.loc 1 1632
.loc 1 1662
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
.loc 1 1662
    STR r0, [r6, #0]
.loc 1 1674
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
.loc 1 1674
    STR r0, [r6, #0]
.loc 1 1687
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
.loc 1 1687
.loc 1 1699
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
.loc 1 1699
    STR r0, [r6, #0]
.loc 1 1711
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
.loc 1 1711
.loc 1 1726
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
.loc 1 1726
    STR r0, [r6, #0]
.loc 1 1741
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
.loc 1 1741
    STR r0, [r6, #0]
.loc 1 3515
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
.loc 1 3517
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
.loc 1 3518
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
.loc 1 3519
    LDR r0, [r6, #8]
    PUSH {r0}
.loc 1 3520
    MOVW r0, #0
    MOVT r0, #1530
    PUSH {r0}
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
.loc 1 3521
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
.loc 1 3522
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
.loc 1 3522
.loc 1 3533
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
.loc 1 3533
    STR r0, [r6, #0]
.loc 1 3545
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
.loc 1 3547
    PUSH {r0}
    POP {r0}
.loc 1 3548
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
.loc 1 3549
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
.loc 1 3549
    STR r0, [r6, #0]
.loc 1 3564
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
.loc 1 3566
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
.loc 1 3570
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
.loc 1 3570
    STR r0, [r6, #0]
.loc 1 3583
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
.loc 1 3585
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
.loc 1 3586
    MOV r0, #15
    PUSH {r0}
    POP {r0}
    DSB SY
    PUSH {r0}
    POP {r0}
.loc 1 3587
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
.loc 1 3587
    STR r0, [r6, #0]
.loc 1 3602
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
.loc 1 3604
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
.loc 1 3608
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
.loc 1 3608
    STR r0, [r6, #0]
.loc 1 3621
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
.loc 1 3623
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
.loc 1 3623
    STR r0, [r6, #0]
.loc 1 3636
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
.loc 1 3638
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
.loc 1 3638
    STR r0, [r6, #0]
.loc 1 3653
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
.loc 1 3655
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
.loc 1 3659
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
.loc 1 3659
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 3675
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
.loc 1 3677
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
.loc 1 3681
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
.loc 1 3681
    STR r0, [r6, #0]
.loc 1 3698
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
.loc 1 3700
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
.loc 1 3704
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
.loc 1 3704
    STR r0, [r6, #0]
    STR r1, [r6, #8]
    STR r2, [r6, #16]
.loc 1 3722
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
.loc 1 3726
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
.loc 1 3727
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
.loc 1 3730
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
.loc 1 3731
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
.loc 1 3731
    STR r0, [r6, #0]
    STR r1, [r6, #8]
    STR r2, [r6, #16]
    STR r3, [r6, #24]
.loc 1 3749
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
.loc 1 3753
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
.loc 1 3754
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
.loc 1 3756
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
.loc 1 3757
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
.loc 1 3757
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 3772
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
.loc 1 3773
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
.loc 1 3773
    STR r0, [r6, #0]
.loc 1 3788
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
.loc 1 3789
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
.loc 1 3789
.loc 1 3799
    MOV r0, #15
    PUSH {r0}
    POP {r0}
    DSB SY
    PUSH {r0}
    POP {r0}
.loc 1 3801
    MOVW r0, #60684
    MOVT r0, #57344
    PUSH {r0}
    MOVW r0, #0
    MOVT r0, #1530
    PUSH {r0}
.loc 1 3802
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
.loc 1 3803
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
.loc 1 3804
    MOV r0, #15
    PUSH {r0}
    POP {r0}
    DSB SY
    PUSH {r0}
    POP {r0}
.loc 1 3806
.L___NVIC_SystemReset_0:
.loc 1 3808
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
.loc 1 3808
    STR r0, [r6, #0]
.loc 1 3997
    MOV r0, #15
    PUSH {r0}
    POP {r0}
    DMB SY
    PUSH {r0}
    POP {r0}
.loc 1 3998
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
.loc 1 4000
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
.loc 1 4002
    MOV r0, #15
    PUSH {r0}
    POP {r0}
    DSB SY
    PUSH {r0}
    POP {r0}
.loc 1 4003
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
.loc 1 4003
.loc 1 4010
    MOV r0, #15
    PUSH {r0}
    POP {r0}
    DMB SY
    PUSH {r0}
    POP {r0}
.loc 1 4012
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
.loc 1 4014
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
.loc 1 4015
    MOV r0, #15
    PUSH {r0}
    POP {r0}
    DSB SY
    PUSH {r0}
    POP {r0}
.loc 1 4016
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
.loc 1 4016
    STR r0, [r6, #0]
.loc 1 4024
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
.loc 1 4025
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
.loc 1 4025
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 4034
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
.loc 1 4035
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
.loc 1 4035
    STR r0, [r6, #0]
    STR r1, [r6, #8]
    STR r2, [r6, #16]
.loc 1 4045
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
.loc 1 4046
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
.loc 1 4047
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
.loc 1 4047
    STR r0, [r6, #0]
    STR r1, [r6, #8]
    STR r2, [r6, #16]
.loc 1 4058
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
.loc 1 4060
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
.loc 1 4058
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
.loc 1 4058
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 4070
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
.loc 1 4071
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
.loc 1 4072
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
.loc 1 4073
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
.loc 1 4074
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
.loc 1 4076
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
.loc 1 4076
.loc 1 4105
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
.loc 1 4106
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
.loc 1 4108
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
.L_SCB_GetFPUType_0:
.loc 1 4112
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
.loc 1 4112
    STR r0, [r6, #0]
.loc 1 4144
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
.loc 1 4146
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
.L_SysTick_Config_0:
.L_SysTick_Config_1:
.loc 1 4149
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
.loc 1 4150
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
.loc 1 4151
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
.loc 1 4152
    MOVW r0, #57360
    MOVT r0, #57344
    PUSH {r0}
    MOV r0, #7
    PUSH {r0}
.loc 1 4154
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 4155
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
.loc 1 4155
    STR r0, [r6, #0]
.loc 1 4186
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
.loc 1 4187
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
.loc 1 4189
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
.loc 1 4191
    NOP
    PUSH {r0}
    POP {r0}
    B .L_ITM_SendChar_4
.L_ITM_SendChar_5:
.loc 1 4193
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
.loc 1 4195
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
.loc 1 4195
.loc 1 4207
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    NEG r0, r0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
.loc 1 4209
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
.loc 1 4211
    MOV r0, #0
    LDR r0, [r0]
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
.loc 1 4212
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
.loc 1 4215
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
.loc 1 4215
.loc 1 4228
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
.loc 1 4230
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
.L_ITM_CheckChar_0:
.loc 1 4234
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
.loc 1 4234
.loc 1 27860
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
.loc 1 27864
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
.loc 1 27868
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
.loc 1 27872
    MOV r0, #3
    PUSH {r0}
    POP {r0}
    BL HAL_NVIC_SetPriorityGrouping
    PUSH {r0}
    POP {r0}
.loc 1 27875
    MOV r0, #15
    PUSH {r0}
    POP {r0}
    BL HAL_InitTick
    PUSH {r0}
    POP {r0}
.loc 1 27878
    BL HAL_MspInit
    PUSH {r0}
    POP {r0}
.loc 1 27881
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
.loc 1 27881
.loc 1 27892
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
.loc 1 27893
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
.loc 1 27895
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
.loc 1 27896
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
.loc 1 27898
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
.loc 1 27899
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
.loc 1 27901
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
.loc 1 27902
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
.loc 1 27904
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
.loc 1 27905
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
.loc 1 27908
    BL HAL_MspDeInit
    PUSH {r0}
    POP {r0}
.loc 1 27911
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
.loc 1 27911
.loc 1 27930
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
.loc 1 27930
    STR r0, [r6, #0]
.loc 1 27955
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
.loc 1 27957
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
.L_HAL_InitTick_0:
.L_HAL_InitTick_1:
.loc 1 27961
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
.loc 1 27963
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
.loc 1 27964
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
.loc 1 27968
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
.L_HAL_InitTick_3:
.loc 1 27972
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
.loc 1 27972
.loc 1 28013
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
.loc 1 28013
.loc 1 28024
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
.loc 1 28024
.loc 1 28033
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
.loc 1 28033
    STR r0, [r6, #0]
.loc 1 28042
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
.loc 1 28045
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 28047
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
.loc 1 28050
    MOVW r0, #32
    MOVT r0, #8192
    LDR r0, [r0]
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
.loc 1 28053
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
.loc 1 28056
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
.loc 1 28058
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
.loc 1 28061
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
.loc 1 28065
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
.loc 1 28065
.loc 1 28075
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
.loc 1 28075
    STR r0, [r6, #0]
.loc 1 28091
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
.loc 1 28092
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
.loc 1 28095
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
.loc 1 28097
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
.loc 1 28100
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
.loc 1 28101
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
.loc 1 28101
.loc 1 28118
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
.loc 1 28118
.loc 1 28134
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
.loc 1 28134
.loc 1 28143
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
.loc 1 28143
.loc 1 28152
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
.loc 1 28152
.loc 1 28161
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
.loc 1 28161
.loc 1 28170
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
.loc 1 28170
.loc 1 28179
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
.loc 1 28179
.loc 1 28188
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
.loc 1 28188
.loc 1 28197
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
.loc 1 28197
.loc 1 28206
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
.loc 1 28206
.loc 1 28215
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
.loc 1 28215
.loc 1 28226
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
.loc 1 28226
.loc 1 28237
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
.loc 1 28237
.loc 1 28246
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
.loc 1 28246
.loc 1 28255
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
.loc 1 28255
.loc 1 28264
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
.loc 1 28264
    STR r0, [r6, #0]
.loc 1 28521
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 28524
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
.loc 1 28524
    STR r0, [r6, #0]
    STR r1, [r6, #8]
    STR r2, [r6, #16]
.loc 1 28542
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
.loc 1 28545
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 28546
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 28548
    BL __NVIC_GetPriorityGrouping
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
.loc 1 28550
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
.loc 1 28550
    STR r0, [r6, #0]
.loc 1 28565
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 28568
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
.loc 1 28568
    STR r0, [r6, #0]
.loc 1 28581
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 28584
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
.loc 1 28584
.loc 1 28594
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
.loc 1 28594
    STR r0, [r6, #0]
.loc 1 28606
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
.loc 1 28606
.loc 1 28636
    MOV r0, #15
    PUSH {r0}
    POP {r0}
    DMB SY
    PUSH {r0}
    POP {r0}
.loc 1 28639
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
.loc 1 28642
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
.loc 1 28642
    STR r0, [r6, #0]
.loc 1 28659
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
.loc 1 28662
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
.loc 1 28665
    MOV r0, #15
    PUSH {r0}
    POP {r0}
    DSB SY
    PUSH {r0}
    POP {r0}
.loc 1 28666
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
.loc 1 28666
    STR r0, [r6, #0]
.loc 1 28676
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 28679
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
.loc 1 28682
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
.loc 1 28682
    STR r0, [r6, #0]
.loc 1 28692
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 28695
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
.loc 1 28698
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
.loc 1 28698
    STR r0, [r6, #0]
.loc 1 28710
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 28711
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 28712
    MOV r0, #0
    PUSH {r0}
    POP {r0}
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
.loc 1 28722
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
.loc 1 28725
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
.loc 1 28728
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
.loc 1 28729
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
.loc 1 28730
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
.loc 1 28731
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
.loc 1 28732
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
.loc 1 28733
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
.loc 1 28734
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
.loc 1 28735
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
.loc 1 28736
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
.loc 1 28737
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
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
.loc 1 28737
.loc 1 28747
    SEV
    PUSH {r0}
    POP {r0}
.loc 1 28748
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
.loc 1 28748
.loc 1 28758
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
.loc 1 28758
    STR r0, [r6, #0]
    STR r1, [r6, #8]
    STR r2, [r6, #16]
    STR r3, [r6, #24]
.loc 1 28785
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 28787
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
.loc 1 28787
    STR r0, [r6, #0]
.loc 1 28800
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 28803
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
.loc 1 28803
    STR r0, [r6, #0]
.loc 1 28818
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 28821
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
.loc 1 28821
    STR r0, [r6, #0]
.loc 1 28834
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 28837
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
.loc 1 28837
    STR r0, [r6, #0]
.loc 1 28851
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 28854
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
.loc 1 28854
    STR r0, [r6, #0]
.loc 1 28868
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 28869
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
.loc 1 28871
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
.loc 1 28875
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
.loc 1 28875
.loc 1 28885
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
.loc 1 28885
.loc 1 28893
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
.loc 1 28893
    STR r0, [r6, #0]
.loc 1 29231
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
.loc 1 29233
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #40
    POP {r5, r6, r7, pc}
.L_HAL_RCC_OscConfig_0:
.L_HAL_RCC_OscConfig_1:
.loc 1 29237
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 29239
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 29242
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 29244
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
.loc 1 29246
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
.loc 1 29248
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
.loc 1 29254
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
.loc 1 29257
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
.loc 1 29260
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 29263
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
.loc 1 29265
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
.loc 1 29267
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
.loc 1 29274
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 29277
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
.loc 1 29279
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
.loc 1 29281
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
.loc 1 29288
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 29291
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 29292
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 29295
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
.loc 1 29298
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
.loc 1 29300
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #40
    POP {r5, r6, r7, pc}
.L_HAL_RCC_OscConfig_63:
.loc 1 29306
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
.loc 1 29312
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
.loc 1 29315
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
.loc 1 29318
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 29321
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
.loc 1 29323
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
.loc 1 29325
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
.loc 1 29330
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
.loc 1 29335
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
.loc 1 29338
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 29341
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
.loc 1 29343
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
.loc 1 29345
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
.loc 1 29352
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 29355
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 29358
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
.loc 1 29361
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
.loc 1 29364
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 29367
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
.loc 1 29369
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
.loc 1 29371
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
.loc 1 29378
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
.loc 1 29381
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 29384
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
.loc 1 29386
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
.loc 1 29388
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
.loc 1 29394
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 29396
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
.loc 1 29399
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 29403
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
.loc 1 29405
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
.loc 1 29406
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
.loc 1 29409
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
.loc 1 29412
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
.loc 1 29415
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 29417
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
.loc 1 29419
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
.loc 1 29421
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
.loc 1 29427
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
.loc 1 29429
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
.loc 1 29432
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 29435
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
.loc 1 29437
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
.loc 1 29439
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
.loc 1 29446
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 29449
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
.loc 1 29451
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
.loc 1 29453
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
.loc 1 29459
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
.loc 1 29461
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
.loc 1 29466
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 29467
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
.loc 1 29470
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
.loc 1 29472
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
.loc 1 29475
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 29476
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 29477
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 29478
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 29479
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 29482
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
.loc 1 29485
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 29488
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
.loc 1 29490
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
.loc 1 29492
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
.loc 1 29497
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
.loc 1 29499
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
.loc 1 29502
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 29505
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
.loc 1 29507
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
.loc 1 29509
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
.loc 1 29516
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
.loc 1 29519
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 29522
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
.loc 1 29524
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
.loc 1 29526
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
.loc 1 29534
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
.loc 1 29536
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #40
    POP {r5, r6, r7, pc}
.L_HAL_RCC_OscConfig_219:
.loc 1 29541
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
.loc 1 29544
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
.loc 1 29545
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
.loc 1 29546
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
.loc 1 29547
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
.loc 1 29548
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
.loc 1 29549
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
.loc 1 29552
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
.loc 1 29557
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
.loc 1 29557
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 29590
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
.loc 1 29592
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #24
    POP {r5, r6, r7, pc}
.L_HAL_RCC_ClockConfig_0:
.L_HAL_RCC_ClockConfig_1:
.loc 1 29596
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 29597
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 29604
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
.loc 1 29607
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
.loc 1 29611
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
.loc 1 29613
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
.loc 1 29618
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 29622
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 29624
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
.loc 1 29627
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 29629
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
.loc 1 29632
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 29633
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
.loc 1 29637
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 29639
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 29642
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
.loc 1 29645
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
.loc 1 29647
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
.loc 1 29651
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
.loc 1 29652
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
.loc 1 29655
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
.loc 1 29657
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
.loc 1 29664
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
.loc 1 29666
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
.loc 1 29670
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
.loc 1 29673
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
.loc 1 29675
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
.loc 1 29677
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
.loc 1 29679
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
.loc 1 29685
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
.loc 1 29688
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
.loc 1 29692
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
.loc 1 29694
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
.loc 1 29699
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 29701
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 29702
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
.loc 1 29706
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 29708
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 29709
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
.loc 1 29713
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
.loc 1 29716
    MOVW r0, #28
    MOVT r0, #8192
    LDR r0, [r0]
    PUSH {r0}
    POP {r0}
    BL HAL_InitTick
    PUSH {r0}
    POP {r0}
.loc 1 29718
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
.loc 1 29718
    STR r0, [r6, #0]
    STR r1, [r6, #8]
    STR r2, [r6, #16]
.loc 1 29773
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 29774
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 29776
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
.loc 1 29778
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 29781
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
.loc 1 29784
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
.loc 1 29785
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
.loc 1 29786
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
.loc 1 29787
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
.loc 1 29788
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
.loc 1 29789
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
.loc 1 29792
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
.loc 1 29801
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 29804
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
.loc 1 29807
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
.loc 1 29808
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
.loc 1 29809
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
.loc 1 29810
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
.loc 1 29811
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
.loc 1 29812
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
.loc 1 29815
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
.loc 1 29815
.loc 1 29835
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
.loc 1 29835
.loc 1 29844
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
.loc 1 29844
.loc 1 29879
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
.loc 1 29880
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
.loc 1 29881
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
.loc 1 29882
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
.loc 1 29885
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
.loc 1 29887
.L_HAL_RCC_GetSysClockFreq_1:
.loc 1 29889
    MOVW r0, #9216
    MOVT r0, #244
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
.loc 1 29890
    B .L_HAL_RCC_GetSysClockFreq_0
.loc 1 29892
.L_HAL_RCC_GetSysClockFreq_2:
.loc 1 29894
    MOVW r0, #30784
    MOVT r0, #381
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
.loc 1 29895
    B .L_HAL_RCC_GetSysClockFreq_0
.loc 1 29897
.L_HAL_RCC_GetSysClockFreq_3:
.loc 1 29901
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
.loc 1 29902
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
.loc 1 29905
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
.loc 1 29910
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
.loc 1 29912
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
.loc 1 29914
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
.loc 1 29915
    B .L_HAL_RCC_GetSysClockFreq_0
.loc 1 29917
.L_HAL_RCC_GetSysClockFreq_4:
.loc 1 29919
    MOVW r0, #9216
    MOVT r0, #244
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
.loc 1 29920
    B .L_HAL_RCC_GetSysClockFreq_0
.L_HAL_RCC_GetSysClockFreq_0:
.loc 1 29923
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
.loc 1 29923
.loc 1 29937
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
.loc 1 29937
.loc 1 29949
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
.loc 1 29949
.loc 1 29961
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
.loc 1 29961
    STR r0, [r6, #0]
.loc 1 29974
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
.loc 1 29977
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
.loc 1 29979
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
.loc 1 29981
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
.loc 1 29983
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
.loc 1 29987
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
.loc 1 29991
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
.loc 1 29993
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
.loc 1 29997
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
.loc 1 30000
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
.loc 1 30003
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
.loc 1 30005
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
.loc 1 30007
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
.loc 1 30009
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
.loc 1 30013
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
.loc 1 30017
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
.loc 1 30019
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
.loc 1 30023
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
.loc 1 30027
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
.loc 1 30029
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
.loc 1 30033
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
.loc 1 30035
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
.loc 1 30036
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
.loc 1 30037
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
.loc 1 30038
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
.loc 1 30039
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
.loc 1 30039
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 30053
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
.loc 1 30056
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
.loc 1 30059
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
.loc 1 30062
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
.loc 1 30065
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
.loc 1 30068
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
.loc 1 30068
.loc 1 30079
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
.loc 1 30082
    BL HAL_RCC_CSSCallback
    PUSH {r0}
    POP {r0}
.loc 1 30085
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
.loc 1 30085
.loc 1 30094
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
.loc 1 30094
    STR r0, [r6, #0]
.loc 1 30325
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
.loc 1 30326
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
.loc 1 30329
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 30332
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 30333
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 30336
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 30337
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 30341
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
.loc 1 30343
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 30345
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
.loc 1 30347
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
.loc 1 30350
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
.loc 1 30359
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
.loc 1 30363
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
.loc 1 30365
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 30367
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
.loc 1 30369
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
.loc 1 30372
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
.loc 1 30378
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 30381
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 30384
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
.loc 1 30387
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
.loc 1 30390
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 30392
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
.loc 1 30394
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
.loc 1 30396
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
.loc 1 30400
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
.loc 1 30401
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
.loc 1 30404
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
.loc 1 30406
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
.loc 1 30407
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
.loc 1 30409
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
.loc 1 30412
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
.loc 1 30415
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 30418
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
.loc 1 30420
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
.loc 1 30422
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
.loc 1 30427
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
.loc 1 30431
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 30433
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
.loc 1 30436
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
.loc 1 30436
    STR r0, [r6, #0]
.loc 1 30451
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
.loc 1 30454
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
.loc 1 30455
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
.loc 1 30459
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
.loc 1 30460
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
.loc 1 30464
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
.loc 1 30466
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
.loc 1 30470
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
.loc 1 30470
    STR r0, [r6, #0]
.loc 1 30486
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
.loc 1 30488
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
.loc 1 30489
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
.loc 1 30491
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #32]
.loc 1 30492
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
.loc 1 30494
.L_HAL_RCCEx_GetPeriphCLKFreq_1:
.loc 1 30497
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
.loc 1 30498
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
.loc 1 30501
.L_HAL_RCCEx_GetPeriphCLKFreq_4:
.loc 1 30504
    MOVW r0, #32768
    MOVT r0, #187
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 30505
    B .L_HAL_RCCEx_GetPeriphCLKFreq_3
.loc 1 30508
.L_HAL_RCCEx_GetPeriphCLKFreq_5:
.loc 1 30514
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
.loc 1 30517
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
.loc 1 30522
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
.loc 1 30526
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
.loc 1 30528
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
.loc 1 30529
    B .L_HAL_RCCEx_GetPeriphCLKFreq_3
.loc 1 30532
.L_HAL_RCCEx_GetPeriphCLKFreq_6:
.loc 1 30534
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 30535
    B .L_HAL_RCCEx_GetPeriphCLKFreq_3
.L_HAL_RCCEx_GetPeriphCLKFreq_3:
.loc 1 30538
    B .L_HAL_RCCEx_GetPeriphCLKFreq_0
.loc 1 30540
.L_HAL_RCCEx_GetPeriphCLKFreq_2:
.loc 1 30542
    B .L_HAL_RCCEx_GetPeriphCLKFreq_0
.L_HAL_RCCEx_GetPeriphCLKFreq_0:
.loc 1 30545
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
.loc 1 30545
    STR r0, [r6, #0]
.loc 1 30578
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 30579
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 30588
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
.loc 1 30591
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 30592
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
.loc 1 30594
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
.loc 1 30597
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
.loc 1 30609
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
.loc 1 30613
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
.loc 1 30616
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 30617
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
.loc 1 30619
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
.loc 1 30622
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
.loc 1 30626
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
.loc 1 30626
.loc 1 30638
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
.loc 1 30641
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
.loc 1 30642
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
.loc 1 30644
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
.loc 1 30647
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
.loc 1 30651
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
.loc 1 30651
.loc 1 30702
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
.loc 1 30705
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
.loc 1 30708
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
.loc 1 30710
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
.loc 1 30712
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
.loc 1 30717
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
.loc 1 30720
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
.loc 1 30723
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
.loc 1 30726
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
.loc 1 30728
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
.loc 1 30730
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
.loc 1 30735
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
.loc 1 30738
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
.loc 1 30741
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
.loc 1 30743
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
.loc 1 30745
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
.loc 1 30750
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
.loc 1 30753
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
.loc 1 30756
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
.loc 1 30758
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
.loc 1 30760
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
.loc 1 30766
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
.loc 1 30769
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
.loc 1 30772
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
.loc 1 30774
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
.loc 1 30776
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
.loc 1 30788
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
.loc 1 30794
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
.loc 1 30805
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
.loc 1 30815
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
.loc 1 30816
    POP {r1}
    POP {r0}
    ORR r0, r1
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 30819
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
.loc 1 30826
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
.loc 1 30832
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
.loc 1 30835
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
.loc 1 30837
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
.L_HAL_RCC_DeInit_20:
.loc 1 30841
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
.loc 1 30841
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 31124
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
.loc 1 31125
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #32]
.loc 1 31126
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #40]
.loc 1 31129
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 31130
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 31131
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 31134
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
.loc 1 31137
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
.loc 1 31139
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
.loc 1 31141
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
.loc 1 31145
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
.loc 1 31148
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 31150
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
.loc 1 31151
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
.loc 1 31152
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
.loc 1 31153
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
.loc 1 31156
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
.loc 1 31157
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
.loc 1 31158
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
.loc 1 31159
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
.loc 1 31162
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
.loc 1 31165
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 31168
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
.loc 1 31169
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
.loc 1 31170
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
.loc 1 31171
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
.loc 1 31175
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
.loc 1 31178
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 31180
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
.loc 1 31181
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
.loc 1 31182
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
.loc 1 31187
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 31188
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
.loc 1 31189
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
.loc 1 31190
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
.loc 1 31194
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
.loc 1 31197
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
.loc 1 31199
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
.loc 1 31200
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
.loc 1 31201
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
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 31205
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
.loc 1 31206
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
.loc 1 31207
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
.loc 1 31209
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
.loc 1 31211
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
.loc 1 31213
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
.loc 1 31214
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
.loc 1 31215
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
.loc 1 31217
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
.loc 1 31219
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
.loc 1 31221
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
.loc 1 31222
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
.loc 1 31223
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
.loc 1 31225
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
.loc 1 31227
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
.loc 1 31230
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
.loc 1 31231
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
.loc 1 31232
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
.loc 1 31234
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
.loc 1 31236
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
.loc 1 31134
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
.loc 1 31134
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 31253
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
.loc 1 31254
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #32]
.loc 1 31255
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #40]
.loc 1 31258
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 31261
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
.loc 1 31264
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
.loc 1 31266
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
.loc 1 31268
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
.loc 1 31271
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
.loc 1 31272
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
.loc 1 31273
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
.loc 1 31276
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
.loc 1 31277
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
.loc 1 31280
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
.loc 1 31281
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
.loc 1 31284
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
.loc 1 31285
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
.loc 1 31290
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
.loc 1 31293
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
.loc 1 31296
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
.loc 1 31299
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
.loc 1 31302
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
.loc 1 31261
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
.loc 1 31261
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 31336
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 31338
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
.loc 1 31340
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
    B .L_HAL_GPIO_ReadPin_1
.L_HAL_GPIO_ReadPin_0:
.loc 1 31344
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
.L_HAL_GPIO_ReadPin_1:
.loc 1 31346
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
.loc 1 31346
    STR r0, [r6, #0]
    STR r1, [r6, #8]
    STR r2, [r6, #16]
.loc 1 31369
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 31370
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 31372
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
.loc 1 31374
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
.loc 1 31378
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
.loc 1 31378
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 31394
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 31397
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
.loc 1 31400
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
.loc 1 31400
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 31416
    MOVW r0, #0
    MOVT r0, #1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
.loc 1 31419
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 31422
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
.loc 1 31424
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
.loc 1 31426
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
.loc 1 31428
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
.loc 1 31430
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
.loc 1 31435
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #24
    POP {r5, r6, r7, pc}
.L_HAL_GPIO_LockPin_0:
.loc 1 31439
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
.loc 1 31439
    STR r0, [r6, #0]
.loc 1 31451
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
.loc 1 31453
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
.loc 1 31454
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
.loc 1 31454
    STR r0, [r6, #0]
.loc 1 31466
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
.loc 1 31466
.loc 1 31673
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
.loc 1 31674
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
.loc 1 31674
.loc 1 31692
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
.loc 1 31693
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
.loc 1 31694
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
.loc 1 31694
.loc 1 31712
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
.loc 1 31713
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
.loc 1 31714
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
.loc 1 31714
    STR r0, [r6, #0]
.loc 1 31859
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 31860
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 31863
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
.loc 1 31866
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
.loc 1 31867
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
.loc 1 31868
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
.loc 1 31869
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
.loc 1 31872
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
.loc 1 31874
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
.loc 1 31878
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
.loc 1 31880
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
.loc 1 31884
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
.loc 1 31886
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
.loc 1 31889
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
.loc 1 31891
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
.loc 1 31891
.loc 1 31901
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
.loc 1 31901
.loc 1 31910
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
.loc 1 31910
    STR r0, [r6, #0]
.loc 1 31925
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 31928
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
.loc 1 31928
    STR r0, [r6, #0]
.loc 1 31943
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 31946
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
.loc 1 31946
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 31975
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
.loc 1 31978
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 31979
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 31982
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
.loc 1 31985
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
.loc 1 31988
    WFI
    PUSH {r0}
    POP {r0}
    B .L_HAL_PWR_EnterSLEEPMode_1
.L_HAL_PWR_EnterSLEEPMode_0:
.loc 1 31992
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
.loc 1 31995
    SEV
    PUSH {r0}
    POP {r0}
.loc 1 31996
    WFE
    PUSH {r0}
    POP {r0}
    B .L_HAL_PWR_EnterSLEEPMode_3
.L_HAL_PWR_EnterSLEEPMode_2:
.L_HAL_PWR_EnterSLEEPMode_3:
.loc 1 32000
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
.loc 1 32000
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 32029
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 32030
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 32033
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
.loc 1 32036
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
.loc 1 32039
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
.loc 1 32042
    WFI
    PUSH {r0}
    POP {r0}
    B .L_HAL_PWR_EnterSTOPMode_1
.L_HAL_PWR_EnterSTOPMode_0:
.loc 1 32046
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
.loc 1 32049
    SEV
    PUSH {r0}
    POP {r0}
.loc 1 32050
    WFE
    PUSH {r0}
    POP {r0}
    B .L_HAL_PWR_EnterSTOPMode_3
.L_HAL_PWR_EnterSTOPMode_2:
.L_HAL_PWR_EnterSTOPMode_3:
.loc 1 32053
    WFE
    PUSH {r0}
    POP {r0}
.L_HAL_PWR_EnterSTOPMode_1:
.loc 1 32056
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
.loc 1 32056
.loc 1 32072
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
.loc 1 32075
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
.loc 1 32079
    BL __force_stores
    PUSH {r0}
    POP {r0}
.loc 1 32082
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
.loc 1 32082
.loc 1 32093
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
.loc 1 32096
    BL HAL_PWR_PVDCallback
    PUSH {r0}
    POP {r0}
.loc 1 32099
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
.loc 1 32099
.loc 1 32108
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
.loc 1 32108
.loc 1 32125
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
.loc 1 32125
.loc 1 32137
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
.loc 1 32137
.loc 1 32149
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
.loc 1 32149
.loc 1 32161
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
.loc 1 32161
.loc 1 32414
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
.loc 1 32416
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
.loc 1 32419
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
.loc 1 32422
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
.loc 1 32424
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
.loc 1 32426
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
.loc 1 32429
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
.loc 1 32429
.loc 1 32438
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
.loc 1 32440
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
.loc 1 32443
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
.loc 1 32446
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
.loc 1 32448
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
.loc 1 32450
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
.loc 1 32453
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
.loc 1 32453
.loc 1 32462
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
.loc 1 32462
.loc 1 32471
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
.loc 1 32471
.loc 1 32484
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
.loc 1 32484
    STR r0, [r6, #0]
.loc 1 32517
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
.loc 1 32519
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 32522
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
.loc 1 32525
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
.loc 1 32528
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
.loc 1 32531
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 32533
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
.loc 1 32535
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
.loc 1 32537
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
.loc 1 32542
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
.loc 1 32545
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
.loc 1 32548
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 32550
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
.loc 1 32552
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
.loc 1 32554
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
.loc 1 32559
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 32560
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
.loc 1 32562
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
.loc 1 32564
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
.loc 1 32570
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #24
    POP {r5, r6, r7, pc}
.L_HAL_PWREx_ControlVoltageScaling_4:
.loc 1 32573
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
.loc 1 32573
.loc 1 32586
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
.loc 1 32586
.loc 1 32597
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
.loc 1 32597
.loc 1 32608
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
.loc 1 32608
.loc 1 32619
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
.loc 1 32619
    STR r0, [r6, #0]
.loc 1 32905
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
.loc 1 32906
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
.loc 1 32910
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
.loc 1 32912
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #32
    POP {r5, r6, r7, pc}
.L_HAL_DMA_Init_0:
.L_HAL_DMA_Init_1:
.loc 1 32916
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 32917
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 32918
    MOV r0, #0
    PUSH {r0}
    POP {r0}
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
.loc 1 32928
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
.loc 1 32930
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 32931
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 32932
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    B .L_HAL_DMA_Init_3
.L_HAL_DMA_Init_2:
.L_HAL_DMA_Init_3:
.loc 1 32936
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
.loc 1 32939
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
.loc 1 32942
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 32945
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
.loc 1 32948
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
.loc 1 32951
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
.loc 1 32954
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
.loc 1 32956
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
.loc 1 32961
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 32964
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
.loc 1 32967
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
.loc 1 32968
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
.loc 1 32969
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
.loc 1 32970
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
.loc 1 32973
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
.loc 1 32976
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
.loc 1 32980
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 32986
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
.loc 1 32989
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
.loc 1 32992
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
.loc 1 32995
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
.loc 1 32999
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
.loc 1 33001
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
.loc 1 33004
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
.loc 1 33007
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
.loc 1 33009
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
.loc 1 33015
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 33019
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
.loc 1 33022
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
.loc 1 33025
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
.loc 1 33028
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
.loc 1 33030
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
.loc 1 33030
    STR r0, [r6, #0]
.loc 1 33044
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
.loc 1 33046
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #16
    POP {r5, r6, r7, pc}
.L_HAL_DMA_DeInit_0:
.L_HAL_DMA_DeInit_1:
.loc 1 33050
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
.loc 1 33053
    MOV r0, #2
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #16
    POP {r5, r6, r7, pc}
.L_HAL_DMA_DeInit_2:
.L_HAL_DMA_DeInit_3:
.loc 1 33057
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 33060
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
    MOV r0, #0
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
.loc 1 33081
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
.loc 1 33084
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
.loc 1 33085
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
.loc 1 33086
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
.loc 1 33087
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
.loc 1 33088
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
.loc 1 33089
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
.loc 1 33092
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
.loc 1 33095
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
.loc 1 33098
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
.loc 1 33101
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
.loc 1 33103
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
.loc 1 33103
    STR r0, [r6, #0]
    STR r1, [r6, #8]
    STR r2, [r6, #16]
    STR r3, [r6, #24]
.loc 1 33139
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #32]
.loc 1 33142
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 33145
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
.loc 1 33147
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
.loc 1 33150
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
.loc 1 33153
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
.loc 1 33156
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
.loc 1 33159
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 33164
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
.loc 1 33167
    MOV r0, #2
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #32]
    LDR r0, [r6, #32]
    PUSH {r0}
    POP {r0}
.L_HAL_DMA_Start_6:
.loc 1 33169
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
.loc 1 33169
    STR r0, [r6, #0]
    STR r1, [r6, #8]
    STR r2, [r6, #16]
    STR r3, [r6, #24]
.loc 1 33183
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #32]
.loc 1 33186
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
.loc 1 33189
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 33192
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
.loc 1 33194
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
.loc 1 33197
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
.loc 1 33200
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
.loc 1 33203
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
.loc 1 33206
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
.loc 1 33209
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 33211
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
.loc 1 33213
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 33217
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 33222
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
.loc 1 33225
    MOV r0, #2
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #32]
    LDR r0, [r6, #32]
    PUSH {r0}
    POP {r0}
.L_HAL_DMA_Start_IT_6:
.loc 1 33228
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
.loc 1 33228
    STR r0, [r6, #0]
.loc 1 33246
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
.loc 1 33248
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
.loc 1 33250
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
.loc 1 33252
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
.loc 1 33255
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
.loc 1 33257
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #24
    POP {r5, r6, r7, pc}
.L_HAL_DMA_Abort_0:
.loc 1 33262
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 33263
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 33265
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
.loc 1 33267
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 33271
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 33274
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
.loc 1 33277
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
.loc 1 33280
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
.loc 1 33283
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
.loc 1 33286
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
.loc 1 33288
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
.loc 1 33293
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
.loc 1 33296
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
.loc 1 33299
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
.loc 1 33301
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
.loc 1 33301
    STR r0, [r6, #0]
.loc 1 33312
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
.loc 1 33314
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
.loc 1 33315
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #8
    POP {r5, r6, r7, pc}
.L_HAL_DMA_Abort_IT_0:
.loc 1 33320
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
.loc 1 33323
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 33326
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
.loc 1 33326
    STR r0, [r6, #0]
    STR r1, [r6, #8]
    STR r2, [r6, #16]
.loc 1 33342
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
.loc 1 33344
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #40]
.loc 1 33350
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
.loc 1 33353
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
.loc 1 33354
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
.loc 1 33355
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #64
    POP {r5, r6, r7, pc}
.L_HAL_DMA_PollForTransfer_0:
.L_HAL_DMA_PollForTransfer_1:
.loc 1 33359
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 33361
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
.loc 1 33362
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #64
    POP {r5, r6, r7, pc}
.L_HAL_DMA_PollForTransfer_5:
.L_HAL_DMA_PollForTransfer_6:
.loc 1 33366
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
.loc 1 33369
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
.loc 1 33374
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
.loc 1 33377
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
.loc 1 33378
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
.loc 1 33380
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
.loc 1 33383
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
.loc 1 33385
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
.loc 1 33388
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
.loc 1 33391
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
.loc 1 33394
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
.loc 1 33396
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
.loc 1 33401
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
.loc 1 33403
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
.loc 1 33406
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
.loc 1 33409
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
.loc 1 33412
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
.loc 1 33415
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
.loc 1 33418
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
.loc 1 33421
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
.loc 1 33424
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
.loc 1 33427
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
.loc 1 33431
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
.loc 1 33433
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
.loc 1 33435
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    BL HAL_DMA_Abort
    PUSH {r0}
    POP {r0}
.loc 1 33438
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
.loc 1 33441
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
.loc 1 33444
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
.loc 1 33446
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
.loc 1 33451
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
.loc 1 33454
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
.loc 1 33456
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
.loc 1 33459
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
.loc 1 33464
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
.loc 1 33467
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
.loc 1 33467
    STR r0, [r6, #0]
.loc 1 33479
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
.loc 1 33480
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
.loc 1 33483
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
.loc 1 33485
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
.loc 1 33488
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
.loc 1 33490
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
.loc 1 33493
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 33496
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
.loc 1 33499
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
.loc 1 33503
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
.loc 1 33505
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
.loc 1 33508
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
.loc 1 33511
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
.loc 1 33515
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
.loc 1 33517
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
.loc 1 33520
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
.loc 1 33523
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
.loc 1 33527
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
.loc 1 33529
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
.loc 1 33532
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
.loc 1 33535
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 33540
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
.loc 1 33543
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
.loc 1 33549
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
.loc 1 33552
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
.loc 1 33559
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 33565
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
.loc 1 33568
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
.loc 1 33574
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
.loc 1 33576
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
.loc 1 33579
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
.loc 1 33581
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
.loc 1 33584
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 33585
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 33587
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
.loc 1 33589
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 33593
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
.loc 1 33596
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
.loc 1 33599
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
.loc 1 33601
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
.loc 1 33603
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
.loc 1 33605
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #40
    POP {r5, r6, r7, pc}
.L_HAL_DMA_IRQHandler_42:
.L_HAL_DMA_IRQHandler_43:
.loc 1 33608
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 33613
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
.loc 1 33616
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
.loc 1 33622
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
.loc 1 33625
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
.loc 1 33632
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 33638
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
.loc 1 33641
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
.loc 1 33644
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
.loc 1 33647
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
.loc 1 33654
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
.loc 1 33656
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
.loc 1 33658
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
.loc 1 33661
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 33663
.L_HAL_DMA_IRQHandler_72:
.loc 1 33665
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
.loc 1 33667
    B .L_HAL_DMA_IRQHandler_73
.L_HAL_DMA_IRQHandler_75:
.L_HAL_DMA_IRQHandler_76:
.L_HAL_DMA_IRQHandler_74:
.loc 1 33670
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 33673
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
.loc 1 33676
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
.loc 1 33679
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
.loc 1 33682
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
.loc 1 33682
    STR r0, [r6, #0]
    STR r1, [r6, #8]
    STR r2, [r6, #16]
.loc 1 33700
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
.loc 1 33703
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
.loc 1 33705
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
.loc 1 33707
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
.loc 1 33709
.L_HAL_DMA_RegisterCallback_8:
.loc 1 33710
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
.loc 1 33711
    B .L_HAL_DMA_RegisterCallback_7
.loc 1 33713
.L_HAL_DMA_RegisterCallback_9:
.loc 1 33714
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
.loc 1 33715
    B .L_HAL_DMA_RegisterCallback_7
.loc 1 33717
.L_HAL_DMA_RegisterCallback_10:
.loc 1 33718
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
.loc 1 33719
    B .L_HAL_DMA_RegisterCallback_7
.loc 1 33721
.L_HAL_DMA_RegisterCallback_11:
.loc 1 33722
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
.loc 1 33723
    B .L_HAL_DMA_RegisterCallback_7
.loc 1 33725
.L_HAL_DMA_RegisterCallback_12:
.loc 1 33726
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
.loc 1 33727
    B .L_HAL_DMA_RegisterCallback_7
.loc 1 33729
.L_HAL_DMA_RegisterCallback_13:
.loc 1 33730
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
.loc 1 33731
    B .L_HAL_DMA_RegisterCallback_7
.loc 1 33733
.L_HAL_DMA_RegisterCallback_14:
.loc 1 33735
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
.loc 1 33736
    B .L_HAL_DMA_RegisterCallback_7
.L_HAL_DMA_RegisterCallback_7:
    B .L_HAL_DMA_RegisterCallback_6
.L_HAL_DMA_RegisterCallback_5:
.loc 1 33742
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
.L_HAL_DMA_RegisterCallback_6:
.loc 1 33746
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
.loc 1 33748
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
.loc 1 33748
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 33761
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
.loc 1 33764
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
.loc 1 33766
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
.loc 1 33768
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
.loc 1 33770
.L_HAL_DMA_UnRegisterCallback_8:
.loc 1 33771
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
.loc 1 33772
    B .L_HAL_DMA_UnRegisterCallback_7
.loc 1 33774
.L_HAL_DMA_UnRegisterCallback_9:
.loc 1 33775
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
.loc 1 33776
    B .L_HAL_DMA_UnRegisterCallback_7
.loc 1 33778
.L_HAL_DMA_UnRegisterCallback_10:
.loc 1 33779
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
.loc 1 33780
    B .L_HAL_DMA_UnRegisterCallback_7
.loc 1 33782
.L_HAL_DMA_UnRegisterCallback_11:
.loc 1 33783
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
.loc 1 33784
    B .L_HAL_DMA_UnRegisterCallback_7
.loc 1 33786
.L_HAL_DMA_UnRegisterCallback_12:
.loc 1 33787
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
.loc 1 33788
    B .L_HAL_DMA_UnRegisterCallback_7
.loc 1 33790
.L_HAL_DMA_UnRegisterCallback_13:
.loc 1 33791
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
.loc 1 33792
    B .L_HAL_DMA_UnRegisterCallback_7
.loc 1 33794
.L_HAL_DMA_UnRegisterCallback_14:
.loc 1 33795
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
.loc 1 33796
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
.loc 1 33797
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
.loc 1 33798
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
.loc 1 33799
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
.loc 1 33800
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
.loc 1 33801
    B .L_HAL_DMA_UnRegisterCallback_7
.loc 1 33803
.L_HAL_DMA_UnRegisterCallback_15:
.loc 1 33804
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
.loc 1 33805
    B .L_HAL_DMA_UnRegisterCallback_7
.L_HAL_DMA_UnRegisterCallback_7:
    B .L_HAL_DMA_UnRegisterCallback_6
.L_HAL_DMA_UnRegisterCallback_5:
.loc 1 33810
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
.L_HAL_DMA_UnRegisterCallback_6:
.loc 1 33814
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
.loc 1 33816
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
.loc 1 33816
    STR r0, [r6, #0]
.loc 1 33846
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
.loc 1 33846
    STR r0, [r6, #0]
.loc 1 33857
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
.loc 1 33857
    STR r0, [r6, #0]
    STR r1, [r6, #8]
    STR r2, [r6, #16]
    STR r3, [r6, #24]
.loc 1 33884
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 33890
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
.loc 1 33893
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 33902
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 33905
    STR r0, [r6, #0]
.loc 1 33917
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 33921
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
.loc 1 33923
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
.loc 1 33926
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
.loc 1 33931
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
.loc 1 33934
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
.loc 1 33934
    STR r0, [r6, #0]
.loc 1 33945
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
.loc 1 33946
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
.loc 1 33949
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
.loc 1 33951
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
.loc 1 33953
.L_DMA_CheckFifoParam_3:
.loc 1 33954
.L_DMA_CheckFifoParam_4:
.loc 1 33955
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
.loc 1 33957
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
.loc 1 33959
    B .L_DMA_CheckFifoParam_2
.loc 1 33960
.L_DMA_CheckFifoParam_5:
.loc 1 33961
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
.loc 1 33963
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
.loc 1 33965
    B .L_DMA_CheckFifoParam_2
.loc 1 33966
.L_DMA_CheckFifoParam_6:
.loc 1 33967
    B .L_DMA_CheckFifoParam_2
.loc 1 33968
.L_DMA_CheckFifoParam_7:
.loc 1 33969
    B .L_DMA_CheckFifoParam_2
.L_DMA_CheckFifoParam_2:
    B .L_DMA_CheckFifoParam_1
.L_DMA_CheckFifoParam_0:
.loc 1 33974
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
.loc 1 33976
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
.loc 1 33978
.L_DMA_CheckFifoParam_15:
.loc 1 33979
.L_DMA_CheckFifoParam_16:
.loc 1 33980
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 33981
    B .L_DMA_CheckFifoParam_14
.loc 1 33982
.L_DMA_CheckFifoParam_17:
.loc 1 33983
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
.loc 1 33985
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
.loc 1 33987
    B .L_DMA_CheckFifoParam_14
.loc 1 33988
.L_DMA_CheckFifoParam_18:
.loc 1 33989
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
.loc 1 33991
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
.loc 1 33993
    B .L_DMA_CheckFifoParam_14
.loc 1 33994
.L_DMA_CheckFifoParam_19:
.loc 1 33995
    B .L_DMA_CheckFifoParam_14
.L_DMA_CheckFifoParam_14:
    B .L_DMA_CheckFifoParam_13
.L_DMA_CheckFifoParam_12:
.loc 1 34002
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
.loc 1 34004
.L_DMA_CheckFifoParam_25:
.loc 1 34005
.L_DMA_CheckFifoParam_26:
.loc 1 34006
.L_DMA_CheckFifoParam_27:
.loc 1 34007
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 34008
    B .L_DMA_CheckFifoParam_24
.loc 1 34009
.L_DMA_CheckFifoParam_28:
.loc 1 34010
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
.loc 1 34012
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
.loc 1 34014
    B .L_DMA_CheckFifoParam_24
.loc 1 34015
.L_DMA_CheckFifoParam_29:
.loc 1 34016
    B .L_DMA_CheckFifoParam_24
.L_DMA_CheckFifoParam_24:
.L_DMA_CheckFifoParam_13:
.L_DMA_CheckFifoParam_1:
.loc 1 34020
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
.loc 1 34020
    STR r0, [r6, #0]
    STR r1, [r6, #8]
    STR r2, [r6, #16]
    STR r3, [r6, #24]
    LDR r0, [r6, #64]
    STR r0, [r6, #32]
.loc 1 34229
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #40]
.loc 1 34232
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 34235
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
.loc 1 34237
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
.loc 1 34238
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #40]
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
    B .L_HAL_DMAEx_MultiBufferStart_1
.L_HAL_DMAEx_MultiBufferStart_0:
.loc 1 34243
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
.loc 1 34245
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
.loc 1 34248
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
.loc 1 34251
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 34257
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
.loc 1 34260
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 34265
    MOV r0, #2
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #40]
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
.L_HAL_DMAEx_MultiBufferStart_8:
.L_HAL_DMAEx_MultiBufferStart_1:
.loc 1 34268
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
.loc 1 34268
    STR r0, [r6, #0]
    STR r1, [r6, #8]
    STR r2, [r6, #16]
    STR r3, [r6, #24]
    LDR r0, [r6, #64]
    STR r0, [r6, #32]
.loc 1 34283
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #40]
.loc 1 34286
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 34289
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
.loc 1 34291
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
.loc 1 34292
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #48
    POP {r5, r6, r7, pc}
.L_HAL_DMAEx_MultiBufferStart_IT_0:
.L_HAL_DMAEx_MultiBufferStart_IT_1:
.loc 1 34296
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
.loc 1 34298
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
.loc 1 34299
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #48
    POP {r5, r6, r7, pc}
.L_HAL_DMAEx_MultiBufferStart_IT_2:
.L_HAL_DMAEx_MultiBufferStart_IT_3:
.loc 1 34303
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
.loc 1 34305
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
.loc 1 34308
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
.loc 1 34311
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
.loc 1 34314
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 34320
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
.loc 1 34323
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 34324
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 34325
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 34331
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 34333
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
.loc 1 34335
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 34339
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 34344
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
.loc 1 34347
    MOV r0, #2
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #40]
    LDR r0, [r6, #40]
    PUSH {r0}
    POP {r0}
.L_HAL_DMAEx_MultiBufferStart_IT_14:
.loc 1 34349
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
.loc 1 34349
    STR r0, [r6, #0]
    STR r1, [r6, #8]
    STR r2, [r6, #16]
.loc 1 34368
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
.loc 1 34371
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 34376
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 34379
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
.loc 1 34379
    STR r0, [r6, #0]
    STR r1, [r6, #8]
    STR r2, [r6, #16]
    STR r3, [r6, #24]
.loc 1 34406
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 34409
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
.loc 1 34412
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 34421
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 34424
    STR r0, [r6, #0]
    STR r1, [r6, #8]
    STR r2, [r6, #16]
.loc 1 34698
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
.loc 1 34701
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 34704
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
.loc 1 34706
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
.loc 1 34708
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
.loc 1 34711
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
.loc 1 34713
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
.loc 1 34716
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
.loc 1 34718
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
.loc 1 34721
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
.loc 1 34726
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
.loc 1 34730
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
.loc 1 34733
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
.loc 1 34737
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
.loc 1 34739
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
.loc 1 34739
    STR r0, [r6, #0]
    STR r1, [r6, #8]
    STR r2, [r6, #16]
.loc 1 34753
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
.loc 1 34756
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 34759
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
.loc 1 34764
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
.loc 1 34765
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
.loc 1 34767
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
.loc 1 34770
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
.loc 1 34772
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
.loc 1 34775
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
.loc 1 34777
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
.loc 1 34780
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
.loc 1 34785
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
.loc 1 34788
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
.loc 1 34788
.loc 1 34797
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
.loc 1 34801
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
.loc 1 34805
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
.loc 1 34808
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
.loc 1 34809
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
.loc 1 34811
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
.loc 1 34814
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
.loc 1 34819
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
.loc 1 34823
    BL FLASH_SetErrorCode
    PUSH {r0}
    POP {r0}
.loc 1 34826
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    BL HAL_FLASH_OperationErrorCallback
    PUSH {r0}
    POP {r0}
.loc 1 34829
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
.loc 1 34833
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
.loc 1 34836
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
.loc 1 34838
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
.loc 1 34841
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
.loc 1 34846
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
.loc 1 34848
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    BL HAL_FLASH_EndOfOperationCallback
    PUSH {r0}
    POP {r0}
.loc 1 34851
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
.loc 1 34852
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
.loc 1 34853
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
.loc 1 34859
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
.loc 1 34860
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
.loc 1 34863
    BL FLASH_FlushCaches
    PUSH {r0}
    POP {r0}
.loc 1 34866
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    BL HAL_FLASH_EndOfOperationCallback
    PUSH {r0}
    POP {r0}
.L_HAL_FLASH_IRQHandler_11:
    B .L_HAL_FLASH_IRQHandler_9
.L_HAL_FLASH_IRQHandler_8:
.loc 1 34871
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
.loc 1 34875
    BL FLASH_FlushCaches
    PUSH {r0}
    POP {r0}
.loc 1 34878
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
.loc 1 34884
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
.loc 1 34886
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
.loc 1 34890
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
.loc 1 34893
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
.loc 1 34899
    STR r0, [r6, #0]
.loc 1 34915
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
.loc 1 34915
    STR r0, [r6, #0]
.loc 1 34932
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
.loc 1 34932
.loc 1 34963
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
.loc 1 34965
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
.loc 1 34968
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
.loc 1 34969
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
.loc 1 34972
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
.loc 1 34974
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
.loc 1 34978
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
.loc 1 34978
.loc 1 34988
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
.loc 1 34990
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
.loc 1 34990
.loc 1 34999
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
.loc 1 35002
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
.loc 1 35003
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
.loc 1 35007
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
.L_HAL_FLASH_OB_Unlock_1:
.loc 1 35010
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
.loc 1 35010
.loc 1 35020
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
.loc 1 35022
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
.loc 1 35022
.loc 1 35032
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
.loc 1 35035
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
.loc 1 35035
.loc 1 35068
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
.loc 1 35068
    STR r0, [r6, #0]
.loc 1 35082
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
.loc 1 35085
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
.loc 1 35091
    BL HAL_GetTick
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 35093
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
.loc 1 35095
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
.loc 1 35097
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
.loc 1 35099
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
.loc 1 35105
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
.loc 1 35108
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
.loc 1 35111
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
.loc 1 35116
    BL FLASH_SetErrorCode
    PUSH {r0}
    POP {r0}
.loc 1 35117
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #16
    POP {r5, r6, r7, pc}
.L_FLASH_WaitForLastOperation_10:
.L_FLASH_WaitForLastOperation_11:
.loc 1 35121
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
.loc 1 35121
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 35140
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 35143
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
.loc 1 35144
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
.loc 1 35145
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
.loc 1 35148
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
.loc 1 35152
    MOV r0, #15
    PUSH {r0}
    POP {r0}
    ISB SY
    PUSH {r0}
    POP {r0}
.loc 1 35155
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
.loc 1 35155
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 35174
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 35177
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
.loc 1 35178
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
.loc 1 35179
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
.loc 1 35181
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
.loc 1 35181
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 35199
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 35202
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
.loc 1 35203
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
.loc 1 35204
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
.loc 1 35206
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
.loc 1 35206
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 35224
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 35227
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
.loc 1 35228
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
.loc 1 35229
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
.loc 1 35231
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
.loc 1 35231
.loc 1 35240
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
.loc 1 35242
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
.loc 1 35245
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
.loc 1 35248
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
.loc 1 35250
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
.loc 1 35253
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
.loc 1 35256
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
.loc 1 35258
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
.loc 1 35261
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
.loc 1 35264
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
.loc 1 35266
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
.loc 1 35269
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
.loc 1 35272
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
.loc 1 35274
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
.loc 1 35277
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
.loc 1 35280
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
.loc 1 35282
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
.loc 1 35285
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
.loc 1 35285
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 35551
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
.loc 1 35554
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
.loc 1 35557
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 35560
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
.loc 1 35562
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
.loc 1 35565
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
.loc 1 35567
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 35570
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
.loc 1 35573
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
.loc 1 35576
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
.loc 1 35581
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 35584
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
.loc 1 35586
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
.loc 1 35589
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
.loc 1 35592
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
.loc 1 35594
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
.loc 1 35597
    LDR r0, [r6, #8]
    PUSH {r0}
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 35598
    B .L_HAL_FLASHEx_Erase_10
.L_HAL_FLASHEx_Erase_12:
.L_HAL_FLASHEx_Erase_13:
.L_HAL_FLASHEx_Erase_11:
.loc 1 35584
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
.loc 1 35603
    BL FLASH_FlushCaches
    PUSH {r0}
    POP {r0}
    B .L_HAL_FLASHEx_Erase_6
.L_HAL_FLASHEx_Erase_5:
.L_HAL_FLASHEx_Erase_6:
.loc 1 35607
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
.loc 1 35609
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
.loc 1 35609
    STR r0, [r6, #0]
.loc 1 35621
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
.loc 1 35624
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 35627
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
.loc 1 35633
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
.loc 1 35635
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 35638
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
.loc 1 35639
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
.loc 1 35640
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
.loc 1 35647
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 35649
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
.loc 1 35650
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
.loc 1 35651
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
.loc 1 35652
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
.loc 1 35655
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
.loc 1 35658
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
.loc 1 35658
    STR r0, [r6, #0]
.loc 1 35670
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
.loc 1 35673
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
.loc 1 35676
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 35679
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 35681
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 35682
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
.loc 1 35685
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
.loc 1 35690
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
.loc 1 35695
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 35697
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
.loc 1 35701
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 35705
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
.loc 1 35704
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
.loc 1 35703
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
.loc 1 35709
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 35711
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
.loc 1 35715
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
.loc 1 35717
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
.loc 1 35717
    STR r0, [r6, #0]
.loc 1 35729
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
.loc 1 35732
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
.loc 1 35735
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
.loc 1 35738
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
.loc 1 35741
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
.loc 1 35741
    STR r0, [r6, #0]
.loc 1 35754
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
.loc 1 35757
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 35760
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 35763
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 35764
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
.loc 1 35768
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
.loc 1 35776
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
.loc 1 35785
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
.loc 1 35785
    STR r0, [r6, #0]
.loc 1 35799
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
.loc 1 35799
.loc 1 35821
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
.loc 1 35824
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
.loc 1 35826
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
.loc 1 35826
.loc 1 35846
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
.loc 1 35849
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
.loc 1 35851
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
.loc 1 35851
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 35888
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 35889
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 35892
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
.loc 1 35893
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
.loc 1 35894
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
.loc 1 35894
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 35916
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
.loc 1 35919
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 35920
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 35922
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
.loc 1 35924
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
    B .L_FLASH_Erase_Sector_1
.L_FLASH_Erase_Sector_0:
.loc 1 35926
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
.loc 1 35928
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
.loc 1 35930
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
.loc 1 35932
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
.loc 1 35936
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
.loc 1 35940
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
.loc 1 35941
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
.loc 1 35942
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
.loc 1 35944
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 35966
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
.loc 1 35969
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 35970
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 35973
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
.loc 1 35975
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
.loc 1 35977
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
.loc 1 35980
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
.loc 1 35980
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 36002
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
.loc 1 36005
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 36006
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 36009
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
.loc 1 36011
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
.loc 1 36013
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
.loc 1 36016
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
.loc 1 36016
    STR r0, [r6, #0]
.loc 1 36032
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
.loc 1 36035
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 36038
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
.loc 1 36040
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
.loc 1 36042
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
.loc 1 36045
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
.loc 1 36045
    STR r0, [r6, #0]
.loc 1 36060
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
.loc 1 36063
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 36066
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
.loc 1 36068
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
.loc 1 36070
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
.loc 1 36073
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
.loc 1 36073
    STR r0, [r6, #0]
.loc 1 36092
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
.loc 1 36095
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 36098
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
.loc 1 36100
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
.loc 1 36102
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
.loc 1 36105
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
.loc 1 36105
    STR r0, [r6, #0]
    STR r1, [r6, #8]
    STR r2, [r6, #16]
.loc 1 36127
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #32]
.loc 1 36130
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 36131
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 36132
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 36135
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
.loc 1 36137
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
.loc 1 36140
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
.loc 1 36143
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
.loc 1 36146
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
.loc 1 36146
    STR r0, [r6, #0]
.loc 1 36162
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 36165
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
.loc 1 36166
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
.loc 1 36168
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
.loc 1 36168
.loc 1 36180
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
.loc 1 36180
.loc 1 36190
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
.loc 1 36190
.loc 1 36203
    MOV r0, #170
    PUSH {r0}
    POP {r0}
    STRB r0, [r6, #0]
.loc 1 36205
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
.loc 1 36207
    MOV r0, #204
    PUSH {r0}
    POP {r0}
    STRB r0, [r6, #0]
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    B .L_FLASH_OB_GetRDP_1
.L_FLASH_OB_GetRDP_0:
.loc 1 36209
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
.loc 1 36211
    MOV r0, #170
    PUSH {r0}
    POP {r0}
    STRB r0, [r6, #0]
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
    B .L_FLASH_OB_GetRDP_3
.L_FLASH_OB_GetRDP_2:
.loc 1 36215
    MOV r0, #85
    PUSH {r0}
    POP {r0}
    STRB r0, [r6, #0]
    LDR r0, [r6, #0]
    PUSH {r0}
    POP {r0}
.L_FLASH_OB_GetRDP_3:
.L_FLASH_OB_GetRDP_1:
.loc 1 36218
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
.loc 1 36218
.loc 1 36232
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
.loc 1 36232
.loc 1 36242
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
.loc 1 36245
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
.loc 1 36247
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
.loc 1 36249
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
.loc 1 36253
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
.loc 1 36256
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
.loc 1 36258
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
.loc 1 36260
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
.loc 1 36260
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 36678
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
.loc 1 36680
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #40
    POP {r5, r6, r7, pc}
.L_HAL_EXTI_SetConfigLine_0:
.L_HAL_EXTI_SetConfigLine_1:
.loc 1 36684
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 36685
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 36688
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
.loc 1 36691
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
.loc 1 36692
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
.loc 1 36695
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
.loc 1 36697
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 36701
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
.loc 1 36703
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
.loc 1 36707
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
.loc 1 36712
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
.loc 1 36714
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
.loc 1 36718
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
.loc 1 36723
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
.loc 1 36725
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 36726
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 36728
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
.loc 1 36729
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
.loc 1 36730
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
.loc 1 36737
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
.loc 1 36739
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
.loc 1 36743
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
.loc 1 36748
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
.loc 1 36750
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
.loc 1 36754
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
.loc 1 36757
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
.loc 1 36757
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 36773
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
.loc 1 36775
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #40
    POP {r5, r6, r7, pc}
.L_HAL_EXTI_GetConfigLine_0:
.L_HAL_EXTI_GetConfigLine_1:
.loc 1 36779
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 36782
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
.loc 1 36785
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
.loc 1 36786
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
.loc 1 36791
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
.loc 1 36793
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
.loc 1 36797
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
.loc 1 36802
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
.loc 1 36804
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
.loc 1 36808
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
.loc 1 36809
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
.loc 1 36812
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
.loc 1 36815
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
.loc 1 36817
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
.loc 1 36822
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
.loc 1 36824
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
.loc 1 36828
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
.loc 1 36830
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 36832
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
.loc 1 36833
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
.loc 1 36837
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
.loc 1 36837
    STR r0, [r6, #0]
.loc 1 36852
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
.loc 1 36854
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #32
    POP {r5, r6, r7, pc}
.L_HAL_EXTI_ClearConfigLine_0:
.L_HAL_EXTI_ClearConfigLine_1:
.loc 1 36858
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 36861
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 36862
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
.loc 1 36865
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
.loc 1 36868
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
.loc 1 36871
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 36873
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
.loc 1 36874
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
.loc 1 36877
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 36879
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 36881
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
.loc 1 36882
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
.loc 1 36883
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
.loc 1 36887
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
.loc 1 36887
    STR r0, [r6, #0]
    STR r1, [r6, #8]
    STR r2, [r6, #16]
.loc 1 36900
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
.loc 1 36902
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
.loc 1 36904
.L_HAL_EXTI_RegisterCallback_1:
.loc 1 36905
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
.loc 1 36906
    B .L_HAL_EXTI_RegisterCallback_0
.loc 1 36908
.L_HAL_EXTI_RegisterCallback_2:
.loc 1 36909
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #24]
    LDR r0, [r6, #24]
    PUSH {r0}
    POP {r0}
.loc 1 36910
    B .L_HAL_EXTI_RegisterCallback_0
.L_HAL_EXTI_RegisterCallback_0:
.loc 1 36913
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
.loc 1 36913
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 36926
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 36929
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
.loc 1 36931
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #16
    POP {r5, r6, r7, pc}
.L_HAL_EXTI_GetHandle_0:
.loc 1 36936
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
.loc 1 36938
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
.loc 1 36938
    STR r0, [r6, #0]
.loc 1 36969
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
.loc 1 36972
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
.loc 1 36973
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
.loc 1 36976
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
.loc 1 36979
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
.loc 1 36981
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
.loc 1 36981
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 37002
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 37005
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 37006
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 37007
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 37010
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
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
.loc 1 37011
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
.loc 1 37014
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
.loc 1 37015
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
.loc 1 37015
    STR r0, [r6, #0]
    STR r1, [r6, #8]
.loc 1 37032
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.loc 1 37035
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 37036
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 37037
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 37040
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
.loc 1 37043
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
.loc 1 37043
    STR r0, [r6, #0]
.loc 1 37056
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 37057
    MOV r0, #0
    PUSH {r0}
    POP {r0}
.loc 1 37060
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
.loc 1 37063
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
.loc 1 37063
.loc 1 37369
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
.loc 1 37369
.loc 1 37421
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
.loc 1 37423
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
.loc 1 37425
.L_SystemCoreClockUpdate_1:
.loc 1 37426
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
.loc 1 37427
    B .L_SystemCoreClockUpdate_0
.loc 1 37428
.L_SystemCoreClockUpdate_2:
.loc 1 37429
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
.loc 1 37430
    B .L_SystemCoreClockUpdate_0
.loc 1 37431
.L_SystemCoreClockUpdate_3:
.loc 1 37436
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
.loc 1 37437
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
.loc 1 37439
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
.loc 1 37442
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
.loc 1 37447
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
.loc 1 37450
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
.loc 1 37451
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
.loc 1 37452
    B .L_SystemCoreClockUpdate_0
.loc 1 37453
.L_SystemCoreClockUpdate_4:
.loc 1 37454
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
.loc 1 37455
    B .L_SystemCoreClockUpdate_0
.L_SystemCoreClockUpdate_0:
.loc 1 37459
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
.loc 1 37461
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
.loc 1 37461
.loc 1 37745
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
.loc 1 37746
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
.loc 1 37746
.loc 1 37926
.L_NMI_Handler_0:
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_NMI_Handler_1
.loc 1 37927
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
.loc 1 37927
.loc 1 37940
.L_HardFault_Handler_0:
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_HardFault_Handler_1
.loc 1 37941
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
.loc 1 37941
.loc 1 37955
.L_MemManage_Handler_0:
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_MemManage_Handler_1
.loc 1 37956
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
.loc 1 37956
.loc 1 37970
.L_BusFault_Handler_0:
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_BusFault_Handler_1
.loc 1 37971
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
.loc 1 37971
.loc 1 37985
.L_UsageFault_Handler_0:
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_UsageFault_Handler_1
.loc 1 37986
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
.loc 1 37986
.loc 1 37996
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
.loc 1 37996
.loc 1 38009
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
.loc 1 38009
.loc 1 38022
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
.loc 1 38022
.loc 1 38039
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
.loc 1 38039
.loc 1 38176
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
.loc 1 38179
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
.loc 1 38180
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
.loc 1 38183
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
.loc 1 38186
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
.loc 1 38187
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
.loc 1 38188
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
.loc 1 38189
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
.loc 1 38190
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

.global blink_raw
.type blink_raw, %function
blink_raw:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #24
    MOV r6, sp
.loc 1 38190
    STR r0, [r6, #0]
.loc 1 38252
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r0}
.L_blink_raw_0:
    LDR r0, [r6, #8]
    PUSH {r0}
    LDR r0, [r6, #0]
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
    BEQ .L_blink_raw_1
.loc 1 38254
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
.loc 1 38255
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
.L_blink_raw_3:
    LDR r0, [r6, #16]
    PUSH {r0}
    MOVW r0, #3392
    MOVT r0, #3
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
    BEQ .L_blink_raw_4
.L_blink_raw_5:
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
    B .L_blink_raw_3
.L_blink_raw_4:
.loc 1 38256
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
.loc 1 38257
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
.L_blink_raw_6:
    LDR r0, [r6, #16]
    PUSH {r0}
    MOVW r0, #3392
    MOVT r0, #3
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
    BEQ .L_blink_raw_7
.L_blink_raw_8:
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
    B .L_blink_raw_6
.L_blink_raw_7:
.L_blink_raw_2:
.loc 1 38252
    LDR r0, [r6, #8]
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    MOV r0, #1
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #8]
    POP {r0}
    B .L_blink_raw_0
.L_blink_raw_1:
.loc 1 38260
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #16]
    LDR r0, [r6, #16]
    PUSH {r0}
    POP {r0}
.L_blink_raw_9:
    LDR r0, [r6, #16]
    PUSH {r0}
    MOVW r0, #10176
    MOVT r0, #9
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
    BEQ .L_blink_raw_10
.L_blink_raw_11:
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
    B .L_blink_raw_9
.L_blink_raw_10:
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    ADD sp, sp, #24
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size blink_raw, .-blink_raw

.global main
.type main, %function
main:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 38260
.loc 1 38264
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
.loc 1 38265
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
.loc 1 38267
    MOV r0, #3
    PUSH {r0}
    POP {r0}
    BL blink_raw
    PUSH {r0}
    POP {r0}
.loc 1 38269
    BL HAL_Init
    PUSH {r0}
    POP {r0}
.loc 1 38270
    MOV r0, #5
    PUSH {r0}
    POP {r0}
    BL blink_raw
    PUSH {r0}
    POP {r0}
.loc 1 38272
    BL SystemClock_Config
    PUSH {r0}
    POP {r0}
.loc 1 38273
    MOV r0, #7
    PUSH {r0}
    POP {r0}
    BL blink_raw
    PUSH {r0}
    POP {r0}
.loc 1 38275
    BL MX_GPIO_Init
    PUSH {r0}
    POP {r0}
.loc 1 38276
    MOV r0, #9
    PUSH {r0}
    POP {r0}
    BL blink_raw
    PUSH {r0}
    POP {r0}
.loc 1 38278
.L_main_0:
    MOV r0, #1
    PUSH {r0}
    POP {r0}
    CMP r0, #0
    BEQ .L_main_1
.loc 1 38279
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
.loc 1 38280
    MOVW r0, #500
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    BL HAL_Delay
    PUSH {r0}
    POP {r0}
.loc 1 38281
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
.loc 1 38282
    MOVW r0, #500
    MOVT r0, #0
    PUSH {r0}
    POP {r0}
    BL HAL_Delay
    PUSH {r0}
    POP {r0}
    B .L_main_0
.L_main_1:
.loc 1 38284
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    MOV sp, r6
    POP {r5, r6, r7, pc}
    .cfi_endproc
.size main, .-main

.global __force_stores
.type __force_stores, %function
__force_stores:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    MOV r6, sp
.loc 1 38284
.loc 1 38294
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
.loc 1 38294
.loc 1 38295
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
.loc 1 38295
.loc 1 38296
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
.loc 1 38296
.loc 1 38297
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
    SUB sp, sp, #8
    MOV r6, sp
    BL __arkcc_init_globals
.loc 1 38297
.loc 1 38311
    MOVW r0, #0
    MOVT r0, #8192
    PUSH {r0}
    POP {r0}
    STR r0, [r6, #0]
.loc 1 38312
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
.loc 1 38313
    LDR r0, [r6, #0]
    PUSH {r0}
    MOV r0, #0
    PUSH {r0}
    POP {r0}
    POP {r1}
    STR r0, [r1, #0]
    PUSH {r0}
    POP {r0}
.loc 1 38314
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
.loc 1 38316
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
.loc 1 38317
    BL SystemInit
    PUSH {r0}
    POP {r0}
.loc 1 38318
    BL main
    PUSH {r0}
    POP {r0}
.loc 1 38319
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
.loc 1 38319
.loc 1 38323
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

