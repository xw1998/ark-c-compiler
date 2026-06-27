/* test_armcc_macros.c — armcc 兼容预定义宏测试
 * 期望退出码：8 (__sizeof_int + __sizeof_ptr = 4+4)
 */
#if defined(__arm__) && defined(__thumb__)
int main(void) { return __sizeof_int + __sizeof_ptr; }
#else
int main(void) { return 0; }
#endif
