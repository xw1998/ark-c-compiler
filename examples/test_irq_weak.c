/* test_irq_weak.c - __irq/__weak function attribute propagation
 * __weak emits __attribute__((weak)) on the C backend; __irq emits a comment only.
 * Expected exit code: 30 (10 + 20)
 */
__weak int weak_fn(void) { return 10; }
__irq  int irq_fn(void)  { return 20; }

int main(void) {
    return weak_fn() + irq_fn();  /* 10 + 20 = 30 */
}
