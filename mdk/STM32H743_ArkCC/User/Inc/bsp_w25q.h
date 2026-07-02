/* Ark C Compiler - MDK STM32H743 - bsp_w25q.h
 * W25Q128 SPI Flash driver interface.
 */
#ifndef BSP_W25Q_H
#define BSP_W25Q_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

/* Initialize the SPI Flash (requires SPI1 to be initialized first).
 * Returns 0 on success, negative on failure.
 */
int  W25Q_Init(void);

/* Read len bytes from Flash into buf.
 * Keep consistent with the extern declaration in flash_fs_stm32.c.
 */
void W25Q_Read(unsigned int addr, unsigned char *buf, unsigned int len);

/* Read the JEDEC ID (for debugging). */
uint32_t W25Q_ReadJedecID(void);

#ifdef __cplusplus
}
#endif

#endif /* BSP_W25Q_H */
