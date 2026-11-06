.syntax unified
.fpu fpv5-sp-d16
.thumb
.text
    vldr s0, k1
    vldr d0, k2
    vldr.f32 s1, [r0, #4]
    vldr.f64 d1, [r1, #8]
    vstr.f32 s2, [r2, #12]
    vstr.f64 d3, [r3, #16]
    vstr s4, [r4]
k1:
    .word 0x3f800000
k2:
    .word 0
    .word 0x3ff00000
