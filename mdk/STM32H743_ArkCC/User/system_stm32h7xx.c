/* Ark C Compiler - MDK STM32H743 - system_stm32h7xx
 * Placeholder implementation of system clock init, called by Reset_Handler in the startup file.
 *
 * For a real project, use the system_stm32h7xx.c provided by STM32CubeH7.
 * Here we only provide the minimal symbols SystemInit / SystemCoreClock so linking succeeds.
 */
#include "stm32h7xx.h"

#warning "system_stm32h7xx.c is a placeholder; replace with the official version"

/* After reset HSI defaults to 64MHz; the placeholder does not switch clocks and keeps a safe value. */
uint32_t SystemCoreClock = 64000000U;

void SystemInit(void) {
    /* A real implementation needs: enable PWR voltage scaling, configure FLASH wait states,
     * HSE/PLL1, etc. The placeholder does the simplest thing: nothing.
     */
}

/* Simple tick that HAL_Init may use internally; placeholder so linking succeeds. */
static volatile uint32_t s_tick = 0;

HAL_StatusTypeDef HAL_Init(void) {
    /* A real implementation enables SysTick to tick every 1ms. */
    return HAL_OK;
}

void HAL_IncTick(void) {
    s_tick++;
}

uint32_t HAL_GetTick(void) {
    return s_tick;
}

void HAL_Delay(uint32_t Delay) {
    uint32_t start = s_tick;
    while ((s_tick - start) < Delay) {
        /* busy wait (under the placeholder the tick never increments; this is just a symbol stub) */
    }
}

/* === HAL_UART/SPI placeholder implementations ===
 * Just return HAL_OK to avoid link errors; replace with the official HAL for real hardware.
 */
HAL_StatusTypeDef HAL_UART_Transmit(UART_HandleTypeDef *huart,
                                    const uint8_t *pData, uint16_t Size,
                                    uint32_t Timeout) {
    (void)huart; (void)pData; (void)Size; (void)Timeout;
    return HAL_OK;
}

HAL_StatusTypeDef HAL_SPI_TransmitReceive(SPI_HandleTypeDef *hspi,
                                          uint8_t *pTxData, uint8_t *pRxData,
                                          uint16_t Size, uint32_t Timeout) {
    (void)hspi; (void)pTxData; (void)Size; (void)Timeout;
    if (pRxData) {
        uint16_t i;
        for (i = 0; i < Size; i++) pRxData[i] = 0xFFU;
    }
    return HAL_OK;
}
