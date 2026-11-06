/* armasm spellings for the four block-transfer shapes.  They are the same
 * instructions under a different name, and each one has a size trap: LDMFD is
 * LDMIA (16-bit form possible), STMFD is STMDB and LDMEA is LDMDB (32-bit only),
 * STMEA is STMIA.  A canonicalising pass keeps the size pass and the emit pass
 * from disagreeing about which one they are looking at.
 *
 * Single-register lists are left out on purpose: GAS rewrites "stmea r3, {r4}"
 * into "str r4, [r3]", which is the same memory effect under a different
 * mnemonic, so it would look like an encoder difference when it is not.
 */
.syntax unified
.thumb
.text
    ldmfd r0!, {r1, r2}
    stmfd r0!, {r1, r2}
    ldmea r0!, {r1, r2}
    stmea r0, {r1, r2}
    ldmfd sp!, {r0, pc}
    stmfd sp!, {r0-r3, lr}
    ldmea r8!, {r9, r10}
    stmea r3, {r4, r5}
    ldmfd r6, {r0, r1, r2, r3}
    stmfd r1, {r2, r3}
