.syntax unified
.thumb
.text
    tbb [r0, r1]
    tbh [r0, r1, lsl #1]
    tbb [r7, r12]
    tbh [r10, r2, lsl #1]
    ldrd r0, r1, [r2]
    ldrd r0, r1, [r2, #8]
    strd r0, r1, [r2, #8]
    ldrd r4, r5, [r6, #-16]
    strd r4, r5, [r6, #-16]
    ldrd r8, r9, [r10, #1020]
    strd r8, r9, [r10, #-1020]
    ldrd r0, r1, [r11]
    strd r2, r3, [r12, #4]
