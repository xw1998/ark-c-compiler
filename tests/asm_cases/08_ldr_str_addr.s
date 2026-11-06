/* LDR/STR family: every address form ARMv7-M actually has.
 *
 * The four shapes are [Rn], [Rn,#imm], [Rn,Rm] (with an optional LSL #0..3)
 * and the two writebacks [Rn,#imm]! / [Rn],#imm.  Register-indexed writeback
 * ([Rn,Rm]! / [Rn],Rm) is absent from Thumb -- arm-none-eabi-as refuses the
 * same lines, so refusing them here is the architecture agreeing with us.
 *
 * The high-register rows are here because the previous 16-bit encoder masked
 * Rd and Rn with &7: "ldr r8,[r0,#4]" used to assemble to "ldr r0,[r0,#4]"
 * and "ldr r0,[r8,#4]" to a base of r0 -- wrong answers, not errors.
 * The wide-offset rows pin the 32-bit imm12 down: it is a plain byte offset
 * (0..4095), it is NOT scaled by the access width.
 */
.syntax unified
.thumb
.text
    ldr r0, [r1]
    ldr r0, [r1, #4]
    ldr r7, [r1, #124]
    ldr r0, [r1, #128]
    ldr r8, [r0, #4]
    ldr r0, [r8, #4]
    ldr r0, [r1, #-4]
    ldr.w r0, [r1, #4095]
    ldr.w r0, [r1, #2048]
    str r0, [r1]
    str r9, [r1, r2]
    str r0, [r11, r12, lsl #3]
    ldr r0, [r1, r2]
    ldr r3, [r4, r5, lsl #2]
    strb r0, [r1, #31]
    strb r0, [r1, #32]
    ldrb r2, [r3, r4]
    ldrb.w r7, [r8, #300]
    ldrh r0, [r1, #62]
    ldrh r0, [r1, #64]
    strh r6, [r7, r0]
    strh.w r9, [r10, r11, lsl #1]
    ldrsb r0, [r1, #3]
    ldrsb r8, [r1]
    ldrsb.w r9, [r10, r11]
    ldrsh r0, [r1, #2]
    ldrsh r9, [r10, r11]
    ldrsh.w r2, [r3, #1000]
    ldr r0, [r1, #4]!
    ldr r0, [r1, #-4]!
    str r0, [r1], #8
    str r0, [r1, #8]!
    ldrb r0, [r1], #-1
    ldrh r5, [r6, #6]!
    strb.w r6, [r7], #255
    ldr r0, [sp, #12]
    str r0, [sp], #4
    ldr r0, [pc, #16]
    nop
