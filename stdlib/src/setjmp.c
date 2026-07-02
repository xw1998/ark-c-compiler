/* Ark C Compiler - stdlib/src/setjmp.c
 * Portable simplified setjmp/longjmp implementation (host test reference only).
 *
 * Notes:
 *   - setjmp/longjmp cannot, strictly speaking, be implemented in pure C;
 *     compiler builtins or assembly are required. This file leverages the
 *     host <setjmp.h> setjmp/longjmp, reinterpreting the upper jmp_buf
 *     (int[20]) pointer as the host jmp_buf and forwarding.
 *   - Host jmp_buf size (mingw-w64/glibc) is <= 80 bytes; int[20]=80B suffices.
 *   - Bare-metal ARM targets require an assembly implementation: save
 *     r4-r11, sp, lr, etc. into jmp_buf; longjmp restores them and jumps.
 *     This file does not cover the ARM scenario.
 *   - This file is not compiled by the Makefile by default; host tests
 *     expand host setjmp/longjmp calls directly in the .gen.c produced by
 *     the C backend, without linking this file.
 *   - Code style follows C99 and can be compiled directly by gcc.
 */
#include <setjmp.h>

int setjmp(jmp_buf env) {
    /* Forward to host setjmp; env is already jmp_buf type, call directly. */
    return setjmp(env);
}

void longjmp(jmp_buf env, int val) {
    /* val==0 is changed to 1 per the C standard; host longjmp does this. */
    longjmp(env, val);
}
