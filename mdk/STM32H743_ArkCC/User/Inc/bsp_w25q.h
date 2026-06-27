/* Ark C Compiler - MDK STM32H743 - bsp_w25q.h
 * W25Q128 SPI Flash 驱动接口。
 */
#ifndef BSP_W25Q_H
#define BSP_W25Q_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

/* 初始化 SPI Flash（要求 SPI1 已先初始化）。
 * 成功返回 0，失败返回负值。
 */
int  W25Q_Init(void);

/* 从 Flash 读取 len 字节到 buf。
 * 与 flash_fs_stm32.c 的 extern 声明保持一致。
 */
void W25Q_Read(unsigned int addr, unsigned char *buf, unsigned int len);

/* 读取 JEDEC ID（调试用）。 */
uint32_t W25Q_ReadJedecID(void);

#ifdef __cplusplus
}
#endif

#endif /* BSP_W25Q_H */
