/* Ark C Compiler - MDK STM32H743 - stm32h7xx_hal_msp
 * HAL MSP hooks (minimal placeholder).
 *
 * STM32CubeMX-generated projects implement peripheral pin/clock/NVIC init here.
 * Currently a minimal placeholder that only keeps the function bodies to avoid link errors.
 */
#include "stm32h7xx.h"

void HAL_MspInit(void) {
#warning "HAL_MspInit is empty; generate with STM32CubeMX"
}

void HAL_UART_MspInit(UART_HandleTypeDef *huart) {
    (void)huart;
#warning "HAL_UART_MspInit is empty; add GPIO/RCC/NVIC configuration"
}

void HAL_UART_MspDeInit(UART_HandleTypeDef *huart) {
    (void)huart;
}

void HAL_SPI_MspInit(SPI_HandleTypeDef *hspi) {
    (void)hspi;
#warning "HAL_SPI_MspInit is empty; add GPIO/RCC/NVIC configuration"
}

void HAL_SPI_MspDeInit(SPI_HandleTypeDef *hspi) {
    (void)hspi;
}
