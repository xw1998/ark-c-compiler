/* test_constructor.c — __attribute__((constructor/destructor))
 * 验证编译器能解析并透传给 gcc / 生成 .init_array 条目。
 * 期望退出码：0（构造函数空实现，main 直接返回 0）
 */
__attribute__((constructor)) void my_init(void) { /* 空实现，验证编译通过 */ }
__attribute__((destructor))  void my_fini(void) { /* 空实现 */ }

int main(void) { return 0; }
