/* test_align.c - __align(n) alignment test
 * Expected exit code: 1   ((addr & 0xF) == 0, i.e. __align(16) took effect)
 */
__align(16) static int aligned_buf[4];

int main(void) {
    unsigned long addr = (unsigned long)aligned_buf;
    return (addr & 0xF) == 0;  /* 1 */
}
