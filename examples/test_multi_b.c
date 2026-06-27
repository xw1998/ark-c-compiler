/* test_multi_b.c — 与 test_multi_a.c 一起验证多文件链接
 * 期望退出码：3
 */
extern int g_counter;
extern void inc_counter(void);

int main(void) {
    inc_counter();
    inc_counter();
    inc_counter();
    return g_counter;
}
