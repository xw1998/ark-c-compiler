/* test_used_alias.c ¡ª __attribute__((used / alias)) ²âÊÔ
 * ÆÚÍûÍË³öÂë£º42
 */
void Default_Handler(void) __attribute__((used));
void Default_Handler(void) { }
void TIM2_IRQHandler(void) __attribute__((alias("Default_Handler")));
__attribute__((used)) static int dummy_var = 42;

int main(void) {
    Default_Handler();
    TIM2_IRQHandler();
    return dummy_var;  /* 42 */
}
