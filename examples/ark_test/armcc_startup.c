/* armcc version of startup - mirrors ark_startup.c but uses armcc syntax */
extern void SystemInit(void);
extern int main(void);
extern unsigned int SystemCoreClock;

void Reset_Handler(void) {
    /* armcc handles BSS init via __rt_entry, but to mirror arkcc behavior
     * we zero BSS manually since we use a minimal startup (no C runtime) */
    volatile unsigned int *p = (volatile unsigned int *)0x20000000u;
    while (p < (volatile unsigned int *)0x20004000u) {
        *p = 0u;
        p++;
    }
    SystemCoreClock = 16000000u;
    SystemInit();
    main();
    while (1) {}
}

void Default_Handler(void) {
    while (1) {}
}
