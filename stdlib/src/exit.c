/* Ark C Compiler stdlib - exit.c
 * C99 7.20.4.3 atexit / 7.20.4.4 exit / _Exit / 7.20.4.1 abort.
 *
 * 这里只做标准要求的事, 真正的"离开"交给端口钩子 _ark_exit(int),
 * 它的弱定义在 exit_default.c (死循环). 板端/宿主门禁提供强定义即可
 * 把退出码变成可观测的量 (例如 unicorn 里把 status 写到一个已知地址).
 *
 * 顺序: C99 7.20.4.3p2 要求 atexit 注册的函数按注册的逆序调用.
 * atexit 的容量是编译期常量, 满了返回非 0 (C99 允许失败), 不静默丢.
 */
#include <stdlib.h>
#include <signal.h>

#define ARK_ATEXIT_MAX 8

static void (*ark_atexit_tab[ARK_ATEXIT_MAX])(void);
static int ark_atexit_n = 0;

/* 端口钩子: 由目标工程提供. 弱定义在 exit_default.c. */
extern void _ark_exit(int status);

int atexit(void (*func)(void))
{
    if (ark_atexit_n >= ARK_ATEXIT_MAX) return -1;
    ark_atexit_tab[ark_atexit_n] = func;
    ark_atexit_n++;
    return 0;
}

void exit(int status)
{
    int i;
    /* 逆序; 置 NULL 之后再调, 这样 a handler 里再 exit() 不会重入同一个函数 */
    for (i = ark_atexit_n - 1; i >= 0; i--) {
        void (*f)(void) = ark_atexit_tab[i];
        ark_atexit_tab[i] = (void (*)(void))0;
        ark_atexit_n = i;
        if (f) f();
    }
    ark_atexit_n = 0;
    _ark_exit(status);
    /* _ark_exit 按约定不返回; 万一返回了, 至少不要继续跑下去 */
    for (;;) { }
}

void _Exit(int status)
{
    _ark_exit(status);
    for (;;) { }
}

void abort(void)
{
    /* C99 7.20.4.1: raise(SIGABRT); 只有 handler 返回时才会走到下一行 */
    raise(SIGABRT);
    /* 按 POSIX 惯例, 未捕获的 SIGABRT 退出码是 128+6 */
    _ark_exit(134);
    for (;;) { }
}
