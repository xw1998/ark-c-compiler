/* test_anon_union.c - Anonymous union/struct field promotion verification.
 * In Timer: CR / EN(bitfield) / IE(bitfield) are accessible at the outer level;
 * after writing EN=1, IE=1, CR should be 3.
 */
typedef struct {
    union {
        unsigned int CR;
        struct {
            unsigned int EN:1;
            unsigned int IE:1;
        };
    };
} Timer;

int main(void) {
    Timer t;
    t.CR = 0;
    t.EN = 1;
    t.IE = 1;
    return (int)t.CR;  /* 3 */
}
