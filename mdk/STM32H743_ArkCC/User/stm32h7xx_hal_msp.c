/* Ark C Compiler - MDK STM32H743 - stm32h7xx_hal_msp
 * HAL MSP 钩子（最小化占位）。
 *
 * STM32CubeMX 生成的工程会在此文件中实现外设引脚/时钟/NVIC 的初始化。
 * 当前为最小占位，仅保留函数体，避免链接错误。
 */
#include "stm32h7xx.h"

void HAL_MspInit(void) {
#warning "HAL_MspInit 为空，请由 STM32CubeMX 生成"
}

void HAL_UART_MspInit(UART_HandleTypeDef *huart) {
    (void)huart;
#warning "HAL_UART_MspInit 为空，请补充 GPIO/RCC/NVIC 配置"
}

void HAL_UART_MspDeInit(UART_HandleTypeDef *huart) {
    (void)huart;
}

void HAL_SPI_MspInit(SPI_HandleTypeDef *hspi) {
    (void)hspi;
#warning "HAL_SPI_MspInit 为空，请补充 GPIO/RCC/NVIC 配置"
}

void HAL_SPI_MspDeInit(SPI_HandleTypeDef *hspi) {
    (void)hspi;
}
