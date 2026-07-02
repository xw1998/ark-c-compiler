/* test_constructor.c - __attribute__((constructor/destructor))
 * Verifies the compiler can parse these and pass them through to gcc /
 * generate .init_array entries.
 * Expected exit code: 0 (constructor body is empty; main returns 0)
 */
__attribute__((constructor)) void my_init(void) { /* empty body, verify it compiles */ }
__attribute__((destructor))  void my_fini(void) { /* empty body */ }

int main(void) { return 0; }
