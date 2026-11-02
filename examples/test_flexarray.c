/* test_flexarray.c - Flexible array member (C99)
 * Expected exit code: 4   (sizeof(struct Packet); data[] is not counted)
 */
struct Packet {
    int len;
    char data[];
};

int main(void) {
    return sizeof(struct Packet);  /* 4 */
}
