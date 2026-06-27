/* test_irq_weak.c — __irq/__weak 函数属性传播
 * __weak 在 C 后端生成 __attribute__((weak))；__irq 仅生成注释。
 * 期望退出码：30 (10 + 20)
 */
__weak int weak_fn(void) { return 10; }
__irq  int irq_fn(void)  { return 20; }

int main(void) {
    return weak_fn() + irq_fn();  /* 10 + 20 = 30 */
}
