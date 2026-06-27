/* Ark C Compiler - MDK STM32H743 - system_stm32h7xx
 * 系统时钟初始化的占位实现，供启动文件 Reset_Handler 调用。
 *
 * 真实工程请使用 STM32CubeH7 提供的 system_stm32h7xx.c。
 * 这里只提供 SystemInit / SystemCoreClock 两个最少符号，让链接通过。
 */
#include "stm32h7xx.h"

#warning "system_stm32h7xx.c 为占位实现，请用官方版本替换"

/* 复位后 HSI 缺省 64MHz；占位时不切换时钟，保持安全值。 */
uint32_t SystemCoreClock = 64000000U;

void SystemInit(void) {
    /* 真实实现需要：使能 PWR 电压档位、配置 FLASH 等待周期、HSE/PLL1 等等。
     * 占位仅做最简单的事：什么都不做。
     */
}

/* HAL_Init 内部可能会用到的简单 tick；占位实现以让链接通过。 */
static volatile uint32_t s_tick = 0;

HAL_StatusTypeDef HAL_Init(void) {
    /* 真实实现会启用 SysTick，每 1ms tick。 */
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
        /* busy wait（占位实现下 tick 不会自增，仅作为符号占位） */
    }
}

/* === HAL_UART/SPI 占位实现 ===
 * 仅返回 HAL_OK，避免链接错误；真实硬件请用官方 HAL 替换。
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
