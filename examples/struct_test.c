/* struct_test.c — struct、-> 与 sizeof
 * 期望退出码：3 + 4 = 7 + sizeof(Point)（=8）= 15
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
