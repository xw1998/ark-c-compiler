/* test_pure.c — __pure 纯函数测试
 * 期望退出码：9
 */
__pure int square(int x) { return x * x; }
int main(void) { return square(3); }  /* 9 */
