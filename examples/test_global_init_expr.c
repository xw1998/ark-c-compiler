/* test_global_init_expr.c — 全局变量非字面量表达式初值
 * 期望：(1+2+3) + sizeof(int)*2 = 6 + 8 = 14 */
int g_size   = 1 + 2 + 3;
int g_sizeof = sizeof(int) * 2;

int main(void) {
    return g_size + g_sizeof;
}
