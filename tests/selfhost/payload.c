/* Payload for the x86_64 self-host probe: compiled once by the host-built
 * arkcc and once by the arkcc that arkcc itself produced.  Both objects must
 * come out byte-identical.  It is written to touch the parts of the pipeline
 * that a "hello world" would not: aggregate layout, initialised globals,
 * pointer arithmetic, a switch table, unsigned/char conversions, nested
 * calls and a string literal. */
typedef struct {
    int   id;
    short flags;
    char  name[8];
    long long total;
} Item;

static const char *const g_names[3] = { "alpha", "beta", "gamma" };

static Item g_items[3] = {
    { 1, 0x0001, "one",   10 },
    { 2, 0x0002, "two",   20 },
    { 3, 0x0004, "three", 30 }
};

int g_bias = 7;

static int classify(unsigned int v) {
    switch (v) {
    case 0:  return 11;
    case 1:  return 22;
    case 7:  return 33;
    case 9:  return 44;
    default: return 55;
    }
}

static long long accumulate(const Item *base, int n) {
    long long sum = 0;
    int i;
    for (i = 0; i < n; i++) {
        sum += (long long)base[i].id * 1000 + base[i].total;
        sum += classify((unsigned int)i);
    }
    return sum;
}

int main(void) {
    int i;
    long long acc = accumulate(g_items, 3);
    unsigned char narrow = (unsigned char)0x1FF;   /* 0xFF */
    char signed_narrow = (char)200;                /* -56 */
    for (i = 0; i < 3; i++) {
        g_items[i].flags = (short)(g_items[i].flags | (narrow & 0x0F));
        acc += (int)signed_narrow + g_bias;
    }
    acc += g_names[1][2] - g_names[2][0];
    return (int)(acc & 0xFFFF);
}
