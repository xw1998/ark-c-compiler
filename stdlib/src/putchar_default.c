/* stdlib/src/putchar_default.c - weak default putchar implementation
 *
 * When an STM32/ARM project does not provide a custom putchar, linking this
 * weak definition avoids link failure. It does nothing and just returns the
 * input character.
 *
 * A user project can provide its own strong putchar (pointing at UART/ITM)
 * to override it:
 *   int putchar(int c) { while (!(USART1->SR & TXE)) ; USART1->DR = c; return c; }
 */
__attribute__((weak)) int putchar(int c) {
    (void)c;
    return c;
}
