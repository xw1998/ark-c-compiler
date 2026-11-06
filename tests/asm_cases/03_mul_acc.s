.syntax unified
.thumb
.text
    mla r0, r1, r2, r3
    mls r0, r1, r2, r3
    mla r8, r9, r10, r11
    smull r0, r1, r2, r3
    smlal r4, r5, r6, r7
    smull r10, r11, r8, r9
