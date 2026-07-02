/* Ark C Compiler - MDK STM32H743 - bsp_w25q
 * W25Q128 SPI Flash driver implementation (based on HAL_SPI_TransmitReceive).
 *
 * Wiring (default SPI1):
 *   PA5  -> SCK
 *   PA6  -> MISO
 *   PA7  -> MOSI
 *   PA4  -> CS (manually controlled by this driver)
 *
 * Note: this file only handles SPI transfers; enabling the SPI1/GPIO clocks,
 * pin alternate-function setup, and SPI mode parameters are done in MX_SPI1_Init in main.c.
 */
#include "bsp_w25q.h"
#include "stm32h7xx.h"

/* Provided by main.c */
extern SPI_HandleTypeDef hspi1;

/* W25Q command bytes */
#define W25Q_CMD_READ_DATA   0x03U
#define W25Q_CMD_JEDEC_ID    0x9FU
#define W25Q_CMD_READ_STATUS 0x05U

/* CS pin control -- set/reset PA4 directly via BSRR.
 * For real projects, HAL_GPIO_WritePin is recommended.
 */
static void W25Q_CS_Low(void)  { GPIOA->BSRR = (uint32_t)(1U << (4 + 16)); }
static void W25Q_CS_High(void) { GPIOA->BSRR = (uint32_t)(1U << 4); }

static int spi_xfer(uint8_t *tx, uint8_t *rx, uint16_t n) {
    HAL_StatusTypeDef st;
    st = HAL_SPI_TransmitReceive(&hspi1, tx, rx, n, 1000);
    return (st == HAL_OK) ? 0 : -1;
}

int W25Q_Init(void) {
    /* Pull CS high, then read the JEDEC ID once for verification */
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

    /* Receive data in chunks to avoid an overly long single DMA transfer */
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
