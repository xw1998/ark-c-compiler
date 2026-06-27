/* test_printf_fix.c — 函数调用（含 printf 变参）参数不被截断到 32 位 int
 *
 * 此前 C 后端 IR_CALL 把参数截断为 int，导致 long long 高 32 位丢失。
 * printf 与普通函数调用共用同一条 IR_CALL 参数传递路径，
 * 故用 long long 函数往返即可覆盖 printf 修复。
 *
 * 词法分析器仅支持 32 位整数字面量，故用 INT_MAX + INT_MAX 构造 64 位大数。
 *   2147483647 + 2147483647 = 4294967294，超过 32 位 unsigned 上界的一半，
 *   必须以 64 位存放。若被截断为 32 位 int，r 会变成 -2。
 *
 * 期望退出码：66 */
long long echo(long long v) { return v; }

int main(void) {
    long long big = 2147483647;   /* INT_MAX，词法分析器按 32 位 int 解析 */
    long long r;
    big = big + big;              /* 4294967294，需要 64 位存放 */
    r = echo(big);                /* 经 IR_CALL 往返 */
    /* 未截断：r = 4294967294，r / 1000000000 = 4；
     * 被截断到 32 位 int：r 变成 -2，-2 / 1000000000 = 0。 */
    if ((int)(r / 1000000000) == 4) return 66;
    return 1;
}
