/* test_packed_ptr.c — __packed 指针未对齐访问语义测试
 * 验证 __packed 修饰指针时，解引用走字节逐个访问（LDRB+LSL+ORR）。
 * 期望退出码：0x78 (120)
 */
__packed int *p;
int main(void) {
    static int data = 0x12345678;
    p = (__packed int *)&data;
    return (*p) & 0xff;  /* 0x78 */
}
