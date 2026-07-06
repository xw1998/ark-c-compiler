


typedef struct {
    unsigned int ctrl;
    unsigned int load;
    unsigned int val;
} SysTick_Type;



void test_macro_expand(void) {
    ((SysTick_Type *) ((0xE000E000UL) +  0x0010UL))->ctrl = 1;
    ((SysTick_Type *) ((0xE000E000UL) +  0x0010UL))->load = 2;
    ((SysTick_Type *) ((0xE000E000UL) +  0x0010UL))->val = 3;
}
