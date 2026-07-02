/* test_setjmp.c - setjmp/longjmp non-local jump
 * Expected exit code: 42
 */
#include <setjmp.h>

jmp_buf buf;

int main(void) {
    int r = setjmp(buf);
    if (r == 0) { longjmp(buf, 42); }
    return r;  /* 42 */
}
