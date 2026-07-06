#define SCS_BASE            (0xE000E000UL)
#define SysTick_BASE        (SCS_BASE +  0x0010UL)

typedef struct {
    unsigned int ctrl;
    unsigned int load;
    unsigned int val;
} SysTick_Type;

#define SysTick ((SysTick_Type *) SysTick_BASE)

void test_macro_expand(void) {
    SysTick->ctrl = 1;
    SysTick->load = 2;
    SysTick->val = 3;
}
