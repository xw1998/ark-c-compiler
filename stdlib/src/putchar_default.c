/* stdlib/src/putchar_default.c - putchar 弱默认实现
 *
 * 当 STM32/ARM 工程未提供自定义 putchar 时，链接此弱定义避免链接失败。
 * 它什么也不做，仅返回输入字符。
 *
 * 用户工程提供自己的强 putchar（指向 UART/ITM）即可覆盖：
 *   int putchar(int c) { while (!(USART1->SR & TXE)) ; USART1->DR = c; return c; }
 */
__attribute__((weak)) int putchar(int c) {
    (void)c;
    return c;
}
