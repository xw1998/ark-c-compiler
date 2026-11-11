/* Ark C Compiler stdlib - signal.c
 * C99 7.14 signal / raise.
 *
 * 裸板上没有内核投递信号, 所以这里是一个"自包含的信号表": raise() 是唯一
 * 的投递源, 也是唯一会走分发的地方. 这仍然是有意义的标准语义 ——
 * abort() 靠 raise(SIGABRT) 找到 handler, 用户可以给 SIGABRT 装一个
 * 长跳转/记录现场的函数, 而不会把库代码写死成"直接停机".
 *
 * 默认动作按 C99 7.14p4: SIGABRT/SIGFPE/SIGILL/SIGSEGV/SIGTERM 的实现
 * 定义动作在这里取"异常终止", 退出码取 POSIX 的 128+sig; 其余信号的
 * 默认动作是实现定义, 这里取"忽略".
 *
 * 注意 <signal.h> 的声明用的是 POSIX 的 sighandler_t, 因为
 * `void (*signal(int, void (*)(int)))(int)` 这种"返回函数指针"的写法
 * arkcc 目前解析不了 (见头文件注释).
 */
#include <signal.h>

#define ARK_NSIG 32

static sighandler_t ark_sig_tab[ARK_NSIG];
static int ark_sig_ready = 0;

extern void _ark_exit(int status);

static void ark_sig_init(void)
{
    int i;
    for (i = 0; i < ARK_NSIG; i++) ark_sig_tab[i] = SIG_DFL;
    ark_sig_ready = 1;
}

static int ark_sig_fatal(int sig)
{
    return sig == SIGABRT || sig == SIGFPE || sig == SIGILL ||
           sig == SIGSEGV || sig == SIGTERM || sig == SIGKILL ||
           sig == SIGHUP;
}

sighandler_t signal(int sig, sighandler_t func)
{
    sighandler_t old;
    if (!ark_sig_ready) ark_sig_init();
    if (sig <= 0 || sig >= ARK_NSIG) return SIG_ERR;
    /* SIGKILL 不可被捕获 (POSIX); 这里明确拒绝而不是静默接受 */
    if (sig == SIGKILL) return SIG_ERR;
    old = ark_sig_tab[sig];
    ark_sig_tab[sig] = func;
    return old;
}

int raise(int sig)
{
    sighandler_t h;
    if (!ark_sig_ready) ark_sig_init();
    if (sig <= 0 || sig >= ARK_NSIG) return -1;
    h = ark_sig_tab[sig];
    if (h == SIG_IGN) return 0;
    if (h == SIG_DFL) {
        if (ark_sig_fatal(sig) && sig != SIGKILL) {
            _ark_exit(128 + sig);
            return 0;
        }
        return 0;               /* 默认动作 = 忽略 */
    }
    h(sig);
    return 0;
}
