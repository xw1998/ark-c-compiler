/* VFP multi-register load/store: VLDMIA/VLDMDB/VSTMIA/VSTMDB, plus the
 * VPUSH/VPOP aliases.
 *
 * The encoding names only "first register + count", so the list has to be one
 * contiguous run -- and every row here is a case where a gap or a wrong
 * precision would still assemble to *something*.  d16-d31 are left out on
 * purpose: they are reachable through the D bit, but an fpv5-d16 core has only
 * d0-d15, and arm-none-eabi-as refuses them for this FPU, so there is no
 * independent encoder to agree with.
 */
.syntax unified
.thumb
.text
    vldmia r0!, {s0-s3}
    vstmia r0, {s0}
    vldmia r0!, {d0-d3}
    vstmia r1!, {d8-d9}
    vldmdb r2!, {s16-s19}
    vstmdb r3!, {d14-d15}
    vpush {s16-s19}
    vpop {d8-d9}
    vldmia r0, {s1}
    vldmia r0!, {s31}
    vldmia r0!, {d15}
    vldmia r0!, {s8-s11}
    vstmia r0!, {d1-d2}
    vpop {s0}
    vpush {d0}
    vldmia r0!, {s30-s31}
    vldmia r0!, {s0, s1, s2}
    vstmia r5!, {d2, d3}
    vldmia sp!, {s0-s1}
    vpush {s0-s7}
