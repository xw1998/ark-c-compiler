/* test_opt.c — IR 级优化 Pass 验证
 *
 * 当 g_config.enable_opt_constfold=1 时，IR 中的
 *   PUSH_INT a; PUSH_INT b; BINARY op
 * 三连会被折叠为单条 PUSH_INT (a op b)。
 *
 * 当 g_config.enable_opt_dce=1 时，RETURN/JMP 之后不可达的
 * 指令会被删除。
 *
 * 本测试依赖常量折叠：1+2 -> 3; 3*0 -> 0; 0+42 -> 42。
 * 注意：arkcc 的 IR 折叠要求两个操作数都是字面量 PUSH_INT，
 * 而 a/b/c 是局部变量（PUSH_VAR），所以仅最内层 1+2 会折叠；
 * 外层运算仍在运行时执行。最终结果仍是 42。
 *
 * 期望退出码：42
 */
int main(void) {
    int a = 1 + 2;       /* 折叠为 3 */
    int b = a * 0;       /* 运行时: 3 * 0 = 0 */
    int c = b + 42;      /* 运行时: 0 + 42 = 42 */
    return c;            /* 42 */
}
