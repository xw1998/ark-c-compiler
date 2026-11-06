.syntax unified
.thumb
.text
    ldmia r0!, {r1, r2}
    stmia r3!, {r4, r5}
    ldm r6!, {r0}
    stm r7!, {r0, r1, r2, r3}
    stmia r1!, {r2}
    ldmia r0, {r1, r2}
    stmia r3, {r4, r5}
    ldm r6, {r0, r2}
    stm r7, {r0, r1}
    ldmia r8!, {r9, r10}
    stmia r9, {r8, r10}
    ldmia r0!, {r1, r8, r9}
    ldmia r10, {r1, r2, lr}
    ldmia r0!, {r1, r12}
    ldmdb r0!, {r9, r10}
    stmdb r0!, {r9, r10}
    ldmdb r5, {r0, r1}
    stmdb r12, {r0, r1, r2}
    ldmdb r3, {r4, r5, r6, r7}
