/* test_multi_a.c — 多 .c 链接（C 后端）支持验证之一
 * 期望与 test_multi_b.c 一起链接后返回 3。
 */
int g_counter = 0;
void inc_counter(void) { g_counter++; }
