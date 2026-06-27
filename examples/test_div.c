/* test_div.c — 有符号/无符号除法与取模
 * 验证 IR_DIV/IR_MOD 的 aux 位（有符号 vs 无符号）。
 * 期望退出码：100
 *   17/5 = 3, 17%5 = 2, 17u/3u = 5, 合计 3+2+5+90 = 100
 */
int main(void) {
    int a = 17;
    int b = 5;
    int q = a / b;     /* 3 */
    int r = a % b;     /* 2 */
    unsigned u = 17u;
    unsigned v = 3u;
    unsigned uq = u / v;  /* 5 */
    return q + r + (int)uq + 90;  /* 3 + 2 + 5 + 90 = 100 */
}
