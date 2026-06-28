/* test_cpu_macros.c — 无下划线预定义宏测试
 * 验证 armcc 兼容的 __arm / __thumb 无下划线宏存在。
 * 期望退出码：0
 */
int main(void) {
    /* 验证无下划线宏存在 */
#ifdef __arm
    return 0;
#else
    return 1;
#endif
}
