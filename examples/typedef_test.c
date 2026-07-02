/* typedef_test.c - typedef + composite type alias + sizeof
 * Expected: 11 + 22 = 33
 */
typedef int i32;
typedef struct Pair {
    i32 a;
    i32 b;
} Pair;

i32 sum_pair(Pair *p) {
    return p->a + p->b;
}

int main(void) {
    Pair p;
    p.a = 11;
    p.b = 22;
    return sum_pair(&p);
}
