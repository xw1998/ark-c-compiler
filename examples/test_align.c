/* test_align.c — __align(n) 对齐测试
 * 期望退出码：1（即对齐生效）
 */
__align(16) static int aligned_buf[4];

int main(void) {
    unsigned long addr = (unsigned long)aligned_buf;
    return (addr & 0xF) == 0;  /* 1 */
}
