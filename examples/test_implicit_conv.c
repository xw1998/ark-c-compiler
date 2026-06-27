/* test_implicit_conv.c — C99 隐式类型转换 + 整型提升
 *
 * 覆盖：
 *   1) unsigned char 与 int 比较：整型提升后按有符号 int 比较
 *      unsigned char c = 0xff; c > 0xfe 应为真（255 > 254）
 *   2) int 与 unsigned 比较：通常算术转换后按 unsigned 比较
 *      int a = -1; unsigned b = 1; a < b 应为假
 *      （-1 转为 unsigned 后为 0xFFFFFFFF = 4294967295，大于 1）
 *   3) short 算术提升为 int，结果可表示负数
 *
 * 期望退出码：每个用例通过置一位，全过 = 1|2|4 = 7 */
int main(void) {
    int result = 0;

    /* 用例 1：unsigned char 与 int 字面量比较，整型提升后按 int 比较 */
    {
        unsigned char c = 0xff;
        if (c > 0xfe) result |= 1;
    }

    /* 用例 2：int 与 unsigned 混合比较，通常算术转换转 unsigned */
    {
        int a = -1;
        unsigned b = 1;
        if (!(a < b)) result |= 2;
    }

    /* 用例 3：short - short 提升为 int，能表示负差值 */
    {
        short s1 = 100;
        short s2 = 130;
        int diff = s1 - s2;   /* 提升为 int：100 - 130 = -30 */
        if (diff == -30) result |= 4;
    }

    return result;  /* 期望 7 */
}
