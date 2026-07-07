/* Ark C Compiler - MDK STM32H743 - stm32h7xx_hal_msp
 * HAL MSP hooks (minimal placeholder).
 *
 * STM32CubeMX-generated projects implement peripheral pin/clock/NVIC init here.
 * Currently a minimal placeholder that only keeps the function bodies to avoid link errors.
 * The actual HAL function implementations (HAL_Init, HAL_UART_Transmit/Receive, etc.)
 * are in system_stm32h7xx.c.
 */
#include "stm32h7xx.h"

void HAL_MspInit(void) {
}

void HAL_UART_MspInit(UART_HandleTypeDef *huart) {
    (void)huart;
}

void HAL_UART_MspDeInit(UART_HandleTypeDef *huart) {
    (void)huart;
}

void HAL_SPI_MspInit(SPI_HandleTypeDef *hspi) {
    (void)hspi;
}

void HAL_SPI_MspDeInit(SPI_HandleTypeDef *hspi) {
    (void)hspi;
}
