; QEMU semihosting trampoline.
;
; AAPCS already puts the operation in r0 and the report-block pointer in r1,
; which is exactly what the semihosting trap expects, so the call body is a
; bare BKPT 0xAB.
;
; BKPT, not SVC: on Cortex-M the semihosting monitor is entered through
; BKPT 0xAB. QEMU only intercepts SVC 0xAB on A/R profile cores, so an
; SVC-based trap vectors to the SVCall handler instead and never exits.
        .text
        .global ark_sh_call
        .thumb
ark_sh_call:
        BKPT    0xAB
        BX      lr
