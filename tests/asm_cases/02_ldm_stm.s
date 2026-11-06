.syntax unified
.thumb
.text
    ldmia r0!, {r1, r2}
    stmia r3!, {r4, r5}
    ldm r6!, {r0}
    stm r7!, {r0, r1, r2, r3}
    stmia r1!, {r2}
