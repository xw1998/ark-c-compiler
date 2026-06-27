/* test_setjmp.c — setjmp/longjmp 非局部跳转
 * 期望退出码：42
 */
#include <setjmp.h>

jmp_buf buf;

int main(void) {
    int r = setjmp(buf);
    if (r == 0) { longjmp(buf, 42); }
    return r;  /* 42 */
}
