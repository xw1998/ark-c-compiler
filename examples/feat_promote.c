/* feat_promote.c — char/short 隐式提升
 * 期望：50
 */
int main(void) {
    char c = 10;
    short s = 20;
    int  i = 5;
    /* c + s 提升为 int，结果 30 */
    int sum = c + s + i + 15;  /* 50 */
    return sum;
}
