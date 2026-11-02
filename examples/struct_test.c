/* struct_test.c - struct, -> and sizeof
 * Expected exit code: 15   (3 + 4 + sizeof(struct Point)(=8))
 */
struct Point {
    int x;
    int y;
};

int main(void) {
    struct Point p;
    struct Point *pp;
    p.x = 3;
    p.y = 4;
    pp = &p;
    return pp->x + pp->y + sizeof(struct Point);
}
