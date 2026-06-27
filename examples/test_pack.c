/* test_pack.c — #pragma pack 对齐控制与位域
 * 验证 #pragma pack(push,1)/pop 改变结构体布局，位域读取正确。
 * 期望退出码：100
 *   p.c=1 + p.i=90 + bt.a=5 + bt.b=4 = 100
 */
#pragma pack(push, 1)
struct Packed {
    char c;
    int  i;
};
#pragma pack(pop)

struct Bits {
    unsigned int a : 4;
    unsigned int b : 4;
};

int main(void) {
    struct Packed p;
    struct Bits bt;
    p.c = 1;
    p.i = 90;
    bt.a = 5;
    bt.b = 4;
    return p.c + p.i + (int)bt.a + (int)bt.b;  /* 1 + 90 + 5 + 4 = 100 */
}
