/* test_asm_operand.c - Extended inline-asm operand pass-through verification (C backend only).
 * The ARM backend only parses the template and ignores operands, so it cannot run.
 *
 * read_x(42) is expected to return 42: __asm__ copies x to result via a mov insn.
 */

static int read_x(int x) {
    int result;
    __asm__ volatile("mov %0, %1" : "=r"(result) : "r"(x));
    return result;
}

int main(void) {
    return read_x(42);
}
