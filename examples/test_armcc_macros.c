/* test_armcc_macros.c - armcc-compatible predefined macro test
 * Expected exit code: 8   (the preprocessor reports the ARM target even for -target c,
 * so the __arm__ branch runs: __sizeof_int + __sizeof_ptr = 4 + 4)
 */
#if defined(__arm__) && defined(__thumb__)
int main(void) { return __sizeof_int + __sizeof_ptr; }
#else
int main(void) { return 0; }
#endif
