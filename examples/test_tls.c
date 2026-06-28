/* test_tls.c — __thread 线程局部存储测试
 * 期望退出码：5
 */
__thread int counter = 0;
int main(void) {
    counter = 5;
    return counter;
}
