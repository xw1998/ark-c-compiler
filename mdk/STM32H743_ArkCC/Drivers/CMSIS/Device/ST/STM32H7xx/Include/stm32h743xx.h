/* Ark C Compiler - MDK STM32H743 - stm32h743xx (����ռλ) */
/*
 * ���ļ���Ϊ��С��ռλ��Ŀ�����ñ�������ȱ�ٹٷ� CMSIS �������
 * Ҳ������﷨����� ArkCC ����Դ����ı��롣
 *
 * ��ʽ�����û�Ӧ�� (HAL_Init, SystemClock_Config, USART1, SPI1...) ʱ��
 * ����� STM32CubeH7 �ֿ⿽���ٷ��汾���Ǵ��ļ���
 */
#ifndef __STM32H743xx_H
#define __STM32H743xx_H

#ifdef __cplusplus
extern "C" {
#endif

#warning "stm32h743xx.h ��ǰ��ռλʵ�֣����ùٷ� CMSIS ����"

#include <stdint.h>

/* ============ �������� ============ */
typedef int32_t  IRQn_Type;

typedef enum { RESET = 0U, SET = !RESET } FlagStatus, ITStatus;
typedef enum { DISABLE = 0U, ENABLE = !DISABLE } FunctionalState;
typedef enum {
    HAL_OK       = 0x00U,
    HAL_ERROR    = 0x01U,
    HAL_BUSY     = 0x02U,
    HAL_TIMEOUT  = 0x03U
} HAL_StatusTypeDef;

/* ============ Cortex-M7 ռλ�Ĵ���/����ṹ ============ */
typedef struct {
    volatile uint32_t MODER;
    volatile uint32_t OTYPER;
    volatile uint32_t OSPEEDR;
    volatile uint32_t PUPDR;
    volatile uint32_t IDR;
    volatile uint32_t ODR;
    volatile uint32_t BSRR;
    volatile uint32_t LCKR;
    volatile uint32_t AFR[2];
} GPIO_TypeDef;

typedef struct {
    volatile uint32_t CR1;
    volatile uint32_t CR2;
    volatile uint32_t CR3;
    volatile uint32_t BRR;
    volatile uint32_t GTPR;
    volatile uint32_t RTOR;
    volatile uint32_t RQR;
    volatile uint32_t ISR;
    volatile uint32_t ICR;
    volatile uint32_t RDR;
    volatile uint32_t TDR;
    volatile uint32_t PRESC;
} USART_TypeDef;

typedef struct {
    volatile uint32_t CR1;
    volatile uint32_t CR2;
    volatile uint32_t CFG1;
    volatile uint32_t CFG2;
    volatile uint32_t IER;
    volatile uint32_t SR;
    volatile uint32_t IFCR;
    uint32_t RESERVED0;
    volatile uint32_t TXDR;
    uint32_t RESERVED1[3];
    volatile uint32_t RXDR;
    uint32_t RESERVED2[3];
    volatile uint32_t CRCPOLY;
    volatile uint32_t TXCRC;
    volatile uint32_t RXCRC;
    volatile uint32_t UDRDR;
    volatile uint32_t I2SCFGR;
} SPI_TypeDef;

/* �ڴ��ַ (ʾ��ֵ������ռλ) */
#define PERIPH_BASE         (0x40000000UL)
#define D2_AHB1PERIPH_BASE  (PERIPH_BASE + 0x18020000UL)
#define GPIOA_BASE          (D2_AHB1PERIPH_BASE + 0x0000UL)
#define GPIOB_BASE          (D2_AHB1PERIPH_BASE + 0x0400UL)
#define USART1_BASE         (PERIPH_BASE + 0x11000UL)
#define SPI1_BASE           (PERIPH_BASE + 0x13000UL)

#define GPIOA   ((GPIO_TypeDef *) GPIOA_BASE)
#define GPIOB   ((GPIO_TypeDef *) GPIOB_BASE)
#define USART1  ((USART_TypeDef *) USART1_BASE)
#define SPI1    ((SPI_TypeDef *) SPI1_BASE)

/* HAL ���ռλ */
typedef struct {
    USART_TypeDef *Instance;
    uint32_t       BaudRate;
} UART_HandleTypeDef;

typedef struct {
    SPI_TypeDef   *Instance;
    uint32_t       Mode;
} SPI_HandleTypeDef;

/* ============ HAL ??? API ============ */
HAL_StatusTypeDef HAL_Init(void);
HAL_StatusTypeDef HAL_UART_Transmit(UART_HandleTypeDef *huart,
                                    const uint8_t *pData, uint16_t Size,
                                    uint32_t Timeout);
HAL_StatusTypeDef HAL_UART_Receive(UART_HandleTypeDef *huart,
                                   uint8_t *pData, uint16_t Size,
                                   uint32_t Timeout);
HAL_StatusTypeDef HAL_SPI_TransmitReceive(SPI_HandleTypeDef *hspi,
                                          uint8_t *pTxData, uint8_t *pRxData,
                                          uint16_t Size, uint32_t Timeout);
void HAL_Delay(uint32_t Delay);
uint32_t HAL_GetTick(void);

/* IRQ ���ռλ */
typedef enum {
    NonMaskableInt_IRQn   = -14,
    HardFault_IRQn        = -13,
    SysTick_IRQn          = -1,
    USART1_IRQn           = 37,
    SPI1_IRQn             = 35
} IRQn_Enum;

#ifdef __cplusplus
}
#endif

#endif /* __STM32H743xx_H */
