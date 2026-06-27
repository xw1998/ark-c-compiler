/* macro_test.c — 函数宏 + 条件编译
 * 期望：MAX(3,7) + MIN(3,7) = 7 + 3 = 10
 */
#define MAX(a, b) ((a) > (b) ? (a) : (b))
#define MIN(a, b) ((a) < (b) ? (a) : (b))

#define USE_BIG 1

int main(void) {
    int v;
#if USE_BIG
    v = MAX(3, 7) + MIN(3, 7);
#else
    v = 0;
#endif
    return v;
}
