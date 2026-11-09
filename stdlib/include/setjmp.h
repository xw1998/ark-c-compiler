/* Ark C Compiler stdlib - setjmp.h
 * Non-local jump interface.
 *
 * Notes:
 *   - The compiler treats setjmp/longjmp as ordinary function calls; no
 *     special IR is required.
 *   - On ARM the implementation is stdlib/src/arm/setjmp.s -- real Thumb-2
 *     functions, because setjmp has to capture its *caller's* sp and lr and
 *     a C wrapper can only ever capture its own frame.  It is exercised by
 *     tests/arm_exec (unicorn) and on hardware at 0x80A0000; the same bytes
 *     are mirrored into the board SDK at
 *     kernelsrc/sdk/mini_sdk/arkc/setjmp.s (Ark RTOS).  Change one, change
 *     the other.
 *   - Host tests can link the portable simplified implementation in
 *     stdlib/src/setjmp.c (forwards to the host <setjmp.h>).
 *   - jmp_buf is 20 ints (80 bytes) so that the ARM implementation can hold
 *     r4-r11 + sp + lr + pc.  Only [0..9] are written today; the rest is
 *     reserved and must not be read.
 */
#ifndef ARK_SETJMP_H
#define ARK_SETJMP_H

typedef int jmp_buf[20];

int  setjmp(jmp_buf env);
void longjmp(jmp_buf env, int val);

#endif /* ARK_SETJMP_H */
