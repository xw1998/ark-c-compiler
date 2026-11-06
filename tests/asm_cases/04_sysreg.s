.syntax unified
.thumb
.text
    mrs r0, primask
    msr primask, r0
    mrs r1, faultmask
    msr faultmask, r1
    mrs r2, basepri
    msr basepri, r2
    mrs r3, control
    msr control, r3
    mrs r4, msp
    msr msp, r4
    mrs r5, psp
    msr psp, r5
