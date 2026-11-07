/* bsp_sdram.h -- FMC SDRAM bring-up for the FK743M5-XIH6 core board
 * (STM32H743XIH6 + W9825G6, 32 MB, 16-bit, FMC SDRAM bank1 @ 0xC0000000).
 *
 * Pure register level: this project has no HAL SDRAM driver, and pulling one
 * in would drag the whole HAL_Init/NVIC chain along for four registers.
 */
#ifndef BSP_SDRAM_H
#define BSP_SDRAM_H

#include <stdint.h>

/* FMC SDRAM bank1 window.  The part is 4 internal banks x 8192 rows x
 * 512 columns x 2 bytes = 32 MB. */
#define SDRAM_BANK_ADDR   ((uint32_t)0xC0000000UL)
#define SDRAM_SIZE_BYTES  ((uint32_t)32UL * 1024UL * 1024UL)

/* Returns 0 on success, negative when a command never completed (BUSY stuck)
 * or the part did not answer the 8-bit byte-lane probe.  Never "returns OK
 * anyway": the whole point of the bring-up is that a wrong timing shows up as
 * a mismatch here and not as a silent garbage read later. */
int bsp_sdram_init(void);

/* Register snapshot for the shell (SDCR1/SDTR1/SDRTR/SDSR + the SDCLK the
 * refresh counter was derived from, in kHz). */
void bsp_sdram_info(uint32_t *sdcr, uint32_t *sdtr, uint32_t *sdrtr,
                    uint32_t *sdsr, uint32_t *sdclk_khz);

/* Pattern = word index, 16-bit accesses.  Both return 0 when every word
 * matched; a mismatch returns -1 and reports where. */
int bsp_sdram_write16(uint32_t nwords);
int bsp_sdram_check16(uint32_t nwords, uint32_t *bad_off,
                      uint32_t *got, uint32_t *exp);

/* Byte-lane probe: writes 0..n-1 with 8-bit stores and reads them back.  A
 * failure here means NBL0/NBL1 are not doing their job, which a 16-bit-only
 * test cannot see. */
int bsp_sdram_check8(uint32_t n, uint32_t *bad_off,
                     uint32_t *got, uint32_t *exp);

#endif /* BSP_SDRAM_H */
