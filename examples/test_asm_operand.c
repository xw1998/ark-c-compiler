/* test_asm_operand.c - 扩展内联汇编操作数透传验证（仅 C 后端有效）。
 * ARM 后端只能解析模板，操作数被忽略，无法运行。
 *
 * read_x(42) 期望返回 42：__asm__ 把 x 拷到 result 通过 mov 指令。
 */

static int read_x(int x) {
    int result;
    __asm__ volatile("mov %0, %1" : "=r"(result) : "r"(x));
    return result;
}

int main(void) {
    return read_x(42);
}
