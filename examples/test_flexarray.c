/* test_flexarray.c — 柔性数组成员（C99）
 * 期望退出码：4（sizeof(struct Packet) == 4，data[] 不计入）
 */
struct Packet {
    int len;
    char data[];
};

int main(void) {
    return sizeof(struct Packet);  /* 4 */
}
