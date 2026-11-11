/* Ark C Compiler stdlib - exit_default.c
 * Weak default for the porting hook _ark_exit(int).
 *
 * 一个没有操作系统的裸板在 exit() 之后无事可做, 所以默认实现就是停机.
 * 目标工程/门禁只要提供一个强定义 (例如把 status 写进某个已知地址,
 * 或者在 unicorn 里触发一个 HLT), 链接器就会用强定义替换掉这一个,
 * 不需要改任何库源码 —— 这也是它被做成弱符号的全部原因.
 *
 * 注意: 这里不是 abort 语义, 也不做清理; 清理在 exit.c 已经做完了.
 */
__attribute__((weak)) void _ark_exit(int status)
{
    (void)status;
    for (;;) { }
}
