/* arkcc stubs for armcc compiler intrinsic functions.
 * These are only called by HAL_PWR_EnterSLEEPMode/STOPMode which our
 * blinky application never invokes. Real implementations would emit
 * WFI/WFE/SEV instructions, but stubs are sufficient for compilation. */
void __force_stores(void) {}
void __wfi(void) {}
void __wfe(void) {}
void __sev(void) {}
