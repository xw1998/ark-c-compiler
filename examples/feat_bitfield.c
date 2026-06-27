/* feat_bitfield.c — 位域结构体
 * 期望：b.flag=1 + b.kind=3 = 4
 */
struct Bits {
    unsigned int flag : 1;
    unsigned int kind : 3;
    unsigned int pad  : 4;
};

int main(void) {
    struct Bits b;
    b.flag = 1;
    b.kind = 3;
    b.pad  = 5;
    return (int)(b.flag + b.kind);  /* 1 + 3 = 4 */
}
