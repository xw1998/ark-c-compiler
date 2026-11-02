/* Semihosting startup for the QEMU ARM execution gate.
 *
 * Reset_Handler is the Cortex-M reset vector target. It runs main(), then asks
 * the QEMU semihosting monitor to terminate the emulator with main()'s return
 * value as the process exit code (SYS_EXIT_EXTENDED, subcode
 * ADP_Stopped_ApplicationExit = 0x20026). The report block lives on the stack
 * so this file needs no initialized data.
 */

int main(void);

/* Implemented in sh_call.s: r0 = op, r1 = block pointer, then SVC 0xAB. */
void ark_sh_call(unsigned op, unsigned *blk);

int Reset_Handler(void)
{
    unsigned blk[2];
    int rc = main();

    blk[0] = 0x20026u;         /* ADP_Stopped_ApplicationExit */
    blk[1] = (unsigned)rc;     /* application exit code */
    ark_sh_call(0x20u, blk);   /* SYS_EXIT_EXTENDED      */

    return rc;                 /* not reached */
}
