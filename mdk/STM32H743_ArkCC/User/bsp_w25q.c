/* Ark C Compiler - MDK STM32H743 - bsp_w25q
 * W25Q128 SPI Flash 驱动实现（基于 HAL_SPI_TransmitReceive）。
 *
 * 接线（默认 SPI1）:
 *   PA5  -> SCK
 *   PA6  -> MISO
 *   PA7  -> MOSI
 *   PA4  -> CS（由本驱动手动控制）
 *
 * 注意：本文件只关心 SPI 收发；SPI1 与 GPIO 的时钟使能、引脚
 * 复用、SPI 模式参数由 main.c 的 MX_SPI1_Init 完成。
 */
#include "bsp_w25q.h"
#include "stm32h7xx.h"

/* 由 main.c 提供 */
extern SPI_HandleTypeDef hspi1;

/* W25Q 命令字 */
#define W25Q_CMD_READ_DATA   0x03U
#define W25Q_CMD_JEDEC_ID    0x9FU
#define W25Q_CMD_READ_STATUS 0x05U

/* CS 引脚控制 —— 使用 BSRR 直接置/复位 PA4。
 * 真实工程建议用 HAL_GPIO_WritePin。
 */
static void W25Q_CS_Low(void)  { GPIOA->BSRR = (uint32_t)(1U << (4 + 16)); }
static void W25Q_CS_High(void) { GPIOA->BSRR = (uint32_t)(1U << 4); }

static int spi_xfer(uint8_t *tx, uint8_t *rx, uint16_t n) {
    HAL_StatusTypeDef st;
    st = HAL_SPI_TransmitReceive(&hspi1, tx, rx, n, 1000);
    return (st == HAL_OK) ? 0 : -1;
}

int W25Q_Init(void) {
    /* 拉高 CS，读一次 JEDEC ID 用于验证 */
    W25Q_CS_High();
    HAL_Delay(1);
    (void)W25Q_ReadJedecID();
    return 0;
}

uint32_t W25Q_ReadJedecID(void) {
    uint8_t tx[4]; uint8_t rx[4];
    uint32_t id;
    tx[0] = W25Q_CMD_JEDEC_ID;
    tx[1] = 0; tx[2] = 0; tx[3] = 0;
    W25Q_CS_Low();
    (void)spi_xfer(tx, rx, 4);
    W25Q_CS_High();
    id = ((uint32_t)rx[1] << 16) | ((uint32_t)rx[2] << 8) | (uint32_t)rx[3];
    return id;
}

void W25Q_Read(unsigned int addr, unsigned char *buf, unsigned int len) {
    uint8_t hdr_tx[4]; uint8_t hdr_rx[4];
    unsigned int remain;
    if (!buf || len == 0U) return;

    hdr_tx[0] = W25Q_CMD_READ_DATA;
    hdr_tx[1] = (uint8_t)((addr >> 16) & 0xFFU);
    hdr_tx[2] = (uint8_t)((addr >> 8)  & 0xFFU);
    hdr_tx[3] = (uint8_t)( addr        & 0xFFU);

    W25Q_CS_Low();
    (void)spi_xfer(hdr_tx, hdr_rx, 4);

    /* 分块收数据，避免一次 DMA 超长 */
    remain = len;
    while (remain > 0U) {
        unsigned int chunk = (remain > 256U) ? 256U : remain;
        uint8_t dummy[256];
        unsigned int i;
        for (i = 0; i < chunk; i++) dummy[i] = 0xFFU;
        (void)spi_xfer(dummy, buf, (uint16_t)chunk);
        buf    += chunk;
        remain -= chunk;
    }

    W25Q_CS_High();
}
