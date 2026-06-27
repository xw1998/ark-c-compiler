/* test_const_fold.c — 全局变量非字面量初值 / 常量表达式折叠
 *
 * 验证 eval_const_expr 在以下场景的编译期求值：
 *   - 全局标量初值：int g_x = 1 + 2 * 3;            -> 7
 *   - 宏展开后折叠：int g_dim = SIZE + 2;            -> 7
 *   - 数组维度含表达式：int g_buf[SIZE + 2];          -> 7 个 int
 *   - sizeof(type) 折叠：int g_sz = sizeof(int)*(SIZE+2); -> 28
 *   - 局部常量表达式：int local = (10 - 3) * 2;       -> 14
 *
 * 注意：不对变量取 sizeof（如 sizeof(g_buf)），因为解析期无法
 * 解析全局变量类型，arkcc 仅支持 sizeof(type) 与 sizeof(expr) 的
 * 类型已知情形。
 *
 * 期望退出码：7 + 7 + 14 + 99 = 127 */
#define SIZE 5

int g_x   = 1 + 2 * 3;                  /* 7：算术折叠 */
int g_dim = SIZE + 2;                    /* 7：宏展开后折叠 */
int g_sz  = sizeof(int) * (SIZE + 2);    /* 4 * 7 = 28：sizeof(type) + 折叠 */
int g_buf[SIZE + 2];                     /* 7 ints：数组维度常量表达式 */

int main(void) {
    int local = (10 - 3) * 2;           /* 14：局部常量表达式 */
    (void)g_sz;                          /* 仅验证其能编译期求值，不参与返回 */
    g_buf[g_dim - 1] = 99;              /* g_buf[6] = 99 */
    return g_x + g_dim + local + g_buf[6];  /* 7 + 7 + 14 + 99 = 127 */
}
