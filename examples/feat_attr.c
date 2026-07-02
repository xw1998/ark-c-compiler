/* feat_attr.c - __attribute__((packed/aligned))
 * Expected exit code: 7
 */
struct __attribute__((packed)) PackedS {
    char a;
    int  b;
};

static int weak_func(void) __attribute__((unused));
static int weak_func(void) { return 99; }

int main(void) {
    struct PackedS p;
    p.a = 1;
    p.b = 6;
    return (int)(p.a + p.b);  /* 7 */
}
