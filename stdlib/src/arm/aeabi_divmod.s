@ stdlib/src/arm/aeabi_divmod.s - the two AEABI entry points that no C function can express
@
@ __aeabi_ldivmod / __aeabi_uldivmod return FOUR registers: quotient in r0:r1
@ and remainder in r2:r3.  A C function can return at most one pair, so these
@ two have to be written in assembly -- but only the register marshalling is
@ assembly.  The actual division is the C code in aeabi.c (__ark_ldiv64 /
@ __ark_udiv64), and the remainder is recomputed here as n - q*d with the C
@ __aeabi_lmul, so no arithmetic lives in this file that is not already
@ covered by tests/arm_exec and tests/run_arm_int64_tests.py.
@
@ Calling convention (backend IR_64BINARY): a in r0:r1, b in r2:r3, result in
@ r0:r1 (quotient) and r2:r3 (remainder).  r4-r7 are callee-saved, so the
@ two 64-bit inputs survive the intermediate calls.
@
@   arkcc -target arm -c stdlib/src/arm/aeabi_divmod.s -o aeabi_div.obj

    .syntax unified
    .text

    .global __aeabi_ldivmod
__aeabi_ldivmod:
    push {r4-r7, lr}
    mov r4, r0                  @ n low
    mov r5, r1                  @ n high
    mov r6, r2                  @ d low
    mov r7, r3                  @ d high
    bl __ark_ldiv64             @ r0:r1 = quotient (arguments are already in r0:r3)
    push {r0, r1}               @ park the quotient
    mov r2, r6                  @ d low
    mov r3, r7                  @ d high
    bl __aeabi_lmul             @ r0:r1 = quotient * d
    mov r2, r4                  @ remainder = n - q*d, both halves: the
    mov r3, r5                  @ 16-bit SUB/SBC only have the two-operand
    sub r2, r2, r0              @ shape (Rd = Rd - Rm, flags from the same
    sbc r3, r3, r1              @ instruction), so copy n first, then subtract
    pop {r0, r1}                @ quotient back into the return pair
    pop {r4-r7, pc}

    .global __aeabi_uldivmod
__aeabi_uldivmod:
    push {r4-r7, lr}
    mov r4, r0
    mov r5, r1
    mov r6, r2
    mov r7, r3
    bl __ark_udiv64
    push {r0, r1}
    mov r2, r6
    mov r3, r7
    bl __aeabi_lmul
    mov r2, r4
    mov r3, r5
    sub r2, r2, r0
    sbc r3, r3, r1
    pop {r0, r1}
    pop {r4-r7, pc}
