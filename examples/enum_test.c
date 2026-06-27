/* enum_test.c ¡ª enum + switch/case + break
 * ÆÚÍûÍË³öÂë£º21
 */
enum Color {
    RED = 1,
    GREEN = 5,
    BLUE = 10
};

int weight(int c) {
    switch (c) {
        case RED:   return 7;
        case GREEN: return 14;
        case BLUE:  return 21;
        default:    return 0;
    }
}

int main(void) {
    int c = BLUE;
    return weight(c);
}
