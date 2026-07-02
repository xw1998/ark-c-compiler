/* Ark C Compiler stdlib - setjmp.h
 * Non-local jump interface.
 *
 * Notes:
 *   - The compiler treats setjmp/longjmp as ordinary function calls; no
 *     special IR is required.
 *   - On ARM, assembly is required to correctly save/restore caller-saved
 *     registers (r4-r11, sp, lr, etc.); this header only provides the
 *     declarations and the jmp_buf type.
 *   - Host tests can link the portable simplified implementation in
 *     stdlib/src/setjmp.c.
 *   - jmp_buf is 20 ints (80 bytes): enough to save ARM r4-r11, sp, lr, pc
 *     plus additional flag/sign state.
 */
#ifndef ARK_SETJMP_H
#define ARK_SETJMP_H

typedef int jmp_buf[20];

int  setjmp(jmp_buf env);
void longjmp(jmp_buf env, int val);

#endif /* ARK_SETJMP_H */
