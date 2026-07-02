/* test_global_init_expr.c - Global variable non-literal expression initializer
 * Expected: (1+2+3) + sizeof(int)*2 = 6 + 8 = 14 */
int g_size   = 1 + 2 + 3;
int g_sizeof = sizeof(int) * 2;

int main(void) {
    return g_size + g_sizeof;
}
