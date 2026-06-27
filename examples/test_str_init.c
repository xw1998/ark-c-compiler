/* test_str_init.c — 字符串初始化数组
 * 期望退出码：'h' + 'i' + 0 = 104 + 105 + 0 = 209
 */
char greeting[] = "hello";   /* sizeof = 6 */
char buf[10] = "hi";         /* 其余 = 0 */

int main(void) {
    int a = greeting[0];      /* 'h' = 104 */
    int b = greeting[1];      /* 'e' = 101 */
    int c = greeting[5];      /* '\0' = 0 */
    int d = buf[0];           /* 'h' = 104 */
    int e = buf[2];           /* 0 */
    /* a + b - 'h'(104) - 'e'(101) + 'h'(104) + 0 = 104 */
    return a + b - 101 + d + e - 104;  /* 104 */
}
