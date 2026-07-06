/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : main.c
  * @brief          : Main program body
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2026 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */
/* USER CODE END Header */
/* Includes ------------------------------------------------------------------*/
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : main.h
  * @brief          : Header for main.c file.
  *                   This file contains the common defines of the application.
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2026 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/






/* Includes ------------------------------------------------------------------*/
/**
  ******************************************************************************
  * @file    stm32f4xx_hal.h
  * @author  MCD Application Team
  * @brief   This file contains all the functions prototypes for the HAL 
  *          module driver.
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2017 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */ 

/* Define to prevent recursive inclusion -------------------------------------*/






/* Includes ------------------------------------------------------------------*/
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    stm32f4xx_hal_conf_template.h
  * @author  MCD Application Team
  * @brief   HAL configuration template file.
  *          This file should be copied to the application folder and renamed
  *          to stm32f4xx_hal_conf.h.
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2017 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/






/* Exported types ------------------------------------------------------------*/
/* Exported constants --------------------------------------------------------*/

/* ########################## Module Selection ############################## */
/**
  * @brief This is the list of modules to be used in the HAL driver
  */


  /* #define HAL_CRYP_MODULE_ENABLED */
/* #define HAL_ADC_MODULE_ENABLED */
/* #define HAL_CAN_MODULE_ENABLED */
/* #define HAL_CRC_MODULE_ENABLED */
/* #define HAL_CAN_LEGACY_MODULE_ENABLED */
/* #define HAL_DAC_MODULE_ENABLED */
/* #define HAL_DCMI_MODULE_ENABLED */
/* #define HAL_DMA2D_MODULE_ENABLED */
/* #define HAL_ETH_MODULE_ENABLED */
/* #define HAL_ETH_LEGACY_MODULE_ENABLED */
/* #define HAL_NAND_MODULE_ENABLED */
/* #define HAL_NOR_MODULE_ENABLED */
/* #define HAL_PCCARD_MODULE_ENABLED */
/* #define HAL_SRAM_MODULE_ENABLED */
/* #define HAL_SDRAM_MODULE_ENABLED */
/* #define HAL_HASH_MODULE_ENABLED */
/* #define HAL_I2C_MODULE_ENABLED */
/* #define HAL_I2S_MODULE_ENABLED */
/* #define HAL_IWDG_MODULE_ENABLED */
/* #define HAL_LTDC_MODULE_ENABLED */
/* #define HAL_RNG_MODULE_ENABLED */
/* #define HAL_RTC_MODULE_ENABLED */
/* #define HAL_SAI_MODULE_ENABLED */
/* #define HAL_SD_MODULE_ENABLED */
/* #define HAL_MMC_MODULE_ENABLED */
/* #define HAL_SPI_MODULE_ENABLED */
/* #define HAL_TIM_MODULE_ENABLED */
/* #define HAL_UART_MODULE_ENABLED */
/* #define HAL_USART_MODULE_ENABLED */
/* #define HAL_IRDA_MODULE_ENABLED */
/* #define HAL_SMARTCARD_MODULE_ENABLED */
/* #define HAL_SMBUS_MODULE_ENABLED */
/* #define HAL_WWDG_MODULE_ENABLED */
/* #define HAL_PCD_MODULE_ENABLED */
/* #define HAL_HCD_MODULE_ENABLED */
/* #define HAL_DSI_MODULE_ENABLED */
/* #define HAL_QSPI_MODULE_ENABLED */
/* #define HAL_QSPI_MODULE_ENABLED */
/* #define HAL_CEC_MODULE_ENABLED */
/* #define HAL_FMPI2C_MODULE_ENABLED */
/* #define HAL_FMPSMBUS_MODULE_ENABLED */
/* #define HAL_SPDIFRX_MODULE_ENABLED */
/* #define HAL_DFSDM_MODULE_ENABLED */
/* #define HAL_LPTIM_MODULE_ENABLED */








/* ########################## HSE/HSI Values adaptation ##################### */
/**
  * @brief Adjust the value of External High Speed oscillator (HSE) used in your application.
  *        This value is used by the RCC HAL module to compute the system frequency
  *        (when HSE is used as system clock source, directly or through the PLL).
  */








/**
  * @brief Internal High Speed oscillator (HSI) value.
  *        This value is used by the RCC HAL module to compute the system frequency
  *        (when HSI is used as system clock source, directly or through the PLL).
  */




/**
  * @brief Internal Low Speed oscillator (LSI) value.
  */



/**
  * @brief External Low Speed oscillator (LSE) value.
  */








/**
  * @brief External clock source for I2S peripheral
  *        This value is used by the I2S HAL module to compute the I2S clock source
  *        frequency, this source is inserted directly through I2S_CKIN pad.
  */




/* Tip: To avoid modifying this file each time you need to use different HSE,
   ===  you can define the HSE value in your toolchain compiler preprocessor. */

/* ########################### System Configuration ######################### */
/**
  * @brief This is the HAL system configuration section
  */















































/* ########################## Assert Selection ############################## */
/**
  * @brief Uncomment the line below to expanse the "assert_param" macro in the
  *        HAL drivers code
  */
/* #define USE_FULL_ASSERT    1U */

/* ################## Ethernet peripheral configuration ##################### */

/* Section 1 : Ethernet peripheral configuration */

/* MAC ADDRESS: MAC_ADDR0:MAC_ADDR1:MAC_ADDR2:MAC_ADDR3:MAC_ADDR4:MAC_ADDR5 */







/* Definition of the Ethernet driver buffers size and count */





/* Section 2: PHY configuration section */

/* DP83848_PHY_ADDRESS Address*/

/* PHY Reset delay these values are based on a 1 ms Systick interrupt*/

/* PHY Configuration delay */





/* Section 3: Common PHY Registers */



















/* Section 4: Extended PHY Registers */





/* ################## SPI peripheral configuration ########################## */

/* CRC FEATURE: Use to activate CRC feature inside HAL SPI Driver
* Activated: CRC code is present inside driver
* Deactivated: CRC code cleaned from driver
*/



/* Includes ------------------------------------------------------------------*/
/**
  * @brief Include module's header file
  */


/**
  ******************************************************************************
  * @file    stm32f4xx_hal_rcc.h
  * @author  MCD Application Team
  * @brief   Header file of RCC HAL module.
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2017 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file in
  * the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/






/* Includes ------------------------------------------------------------------*/
/**
  ******************************************************************************
  * @file    stm32f4xx_hal_def.h
  * @author  MCD Application Team
  * @brief   This file contains HAL common defines, enumeration, macros and 
  *          structures definitions. 
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2017 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/






/* Includes ------------------------------------------------------------------*/
/**
  ******************************************************************************
  * @file    stm32f4xx.h
  * @author  MCD Application Team
  * @brief   CMSIS STM32F4xx Device Peripheral Access Layer Header File.
  *
  *          The file is the unique include file that the application programmer
  *          is using in the C source code, usually in main.c. This file contains:
  *           - Configuration section that allows to select:
  *              - The STM32F4xx device used in the target application
  *              - To use or not the peripheral's drivers in application code(i.e.
  *                code will be based on direct access to peripheral's registers
  *                rather than drivers API), this option is controlled by
  *                "#define USE_HAL_DRIVER"
  *
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2017 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */

/** @addtogroup CMSIS
  * @{
  */

/** @addtogroup stm32f4xx
  * @{
  */







/** @addtogroup Library_configuration_section
  * @{
  */

/**
  * @brief STM32 Family
  */




/* Uncomment the line below according to the target STM32 device used in your
   application
  */



/*  Tip: To avoid modifying this file each time you need to switch between these
        devices, you can define the device in your toolchain compiler preprocessor.
  */



/**
  * @brief CMSIS version number V2.6.11
  */






/**
  * @}
  */

/** @addtogroup Device_Included
  * @{
  */




















/**
  ******************************************************************************
  * @file    stm32f401xe.h
  * @author  MCD Application Team
  * @brief   CMSIS STM32F401xE Device Peripheral Access Layer Header File.
  *
  *          This file contains:
  *           - Data structures and the address mapping for all peripherals
  *           - peripherals registers declarations and bits definition
  *           - Macros to access peripheral's registers hardware
  *
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2017 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */

/** @addtogroup CMSIS_Device
  * @{
  */

/** @addtogroup stm32f401xe
  * @{
  */







/** @addtogroup Configuration_section_for_CMSIS
  * @{
  */

/**
  * @brief Configuration of the Cortex-M4 Processor and Core Peripherals
  */






/**
  * @}
  */

/** @addtogroup Peripheral_interrupt_number_definition
  * @{
  */

/**
 * @brief STM32F4XX Interrupt Number Definition, according to the selected device
 *        in @ref Library_configuration_section
 */
typedef enum
{
  /******  Cortex-M4 Processor Exceptions Numbers ****************************************************************/
  NonMaskableInt_IRQn         = -14,    /*!< 2 Non Maskable Interrupt                                          */
  MemoryManagement_IRQn       = -12,    /*!< 4 Cortex-M4 Memory Management Interrupt                           */
  BusFault_IRQn               = -11,    /*!< 5 Cortex-M4 Bus Fault Interrupt                                   */
  UsageFault_IRQn             = -10,    /*!< 6 Cortex-M4 Usage Fault Interrupt                                 */
  SVCall_IRQn                 = -5,     /*!< 11 Cortex-M4 SV Call Interrupt                                    */
  DebugMonitor_IRQn           = -4,     /*!< 12 Cortex-M4 Debug Monitor Interrupt                              */
  PendSV_IRQn                 = -2,     /*!< 14 Cortex-M4 Pend SV Interrupt                                    */
  SysTick_IRQn                = -1,     /*!< 15 Cortex-M4 System Tick Interrupt                                */
  /******  STM32 specific Interrupt Numbers **********************************************************************/
  WWDG_IRQn                   = 0,      /*!< Window WatchDog Interrupt                                         */
  PVD_IRQn                    = 1,      /*!< PVD through EXTI Line detection Interrupt                         */
  TAMP_STAMP_IRQn             = 2,      /*!< Tamper and TimeStamp interrupts through the EXTI line             */
  RTC_WKUP_IRQn               = 3,      /*!< RTC Wakeup interrupt through the EXTI line                        */
  FLASH_IRQn                  = 4,      /*!< FLASH global Interrupt                                            */
  RCC_IRQn                    = 5,      /*!< RCC global Interrupt                                              */
  EXTI0_IRQn                  = 6,      /*!< EXTI Line0 Interrupt                                              */
  EXTI1_IRQn                  = 7,      /*!< EXTI Line1 Interrupt                                              */
  EXTI2_IRQn                  = 8,      /*!< EXTI Line2 Interrupt                                              */
  EXTI3_IRQn                  = 9,      /*!< EXTI Line3 Interrupt                                              */
  EXTI4_IRQn                  = 10,     /*!< EXTI Line4 Interrupt                                              */
  DMA1_Stream0_IRQn           = 11,     /*!< DMA1 Stream 0 global Interrupt                                    */
  DMA1_Stream1_IRQn           = 12,     /*!< DMA1 Stream 1 global Interrupt                                    */
  DMA1_Stream2_IRQn           = 13,     /*!< DMA1 Stream 2 global Interrupt                                    */
  DMA1_Stream3_IRQn           = 14,     /*!< DMA1 Stream 3 global Interrupt                                    */
  DMA1_Stream4_IRQn           = 15,     /*!< DMA1 Stream 4 global Interrupt                                    */
  DMA1_Stream5_IRQn           = 16,     /*!< DMA1 Stream 5 global Interrupt                                    */
  DMA1_Stream6_IRQn           = 17,     /*!< DMA1 Stream 6 global Interrupt                                    */
  ADC_IRQn                    = 18,     /*!< ADC1, ADC2 and ADC3 global Interrupts                             */
  EXTI9_5_IRQn                = 23,     /*!< External Line[9:5] Interrupts                                     */
  TIM1_BRK_TIM9_IRQn          = 24,     /*!< TIM1 Break interrupt and TIM9 global interrupt                    */
  TIM1_UP_TIM10_IRQn          = 25,     /*!< TIM1 Update Interrupt and TIM10 global interrupt                  */
  TIM1_TRG_COM_TIM11_IRQn     = 26,     /*!< TIM1 Trigger and Commutation Interrupt and TIM11 global interrupt */
  TIM1_CC_IRQn                = 27,     /*!< TIM1 Capture Compare Interrupt                                    */
  TIM2_IRQn                   = 28,     /*!< TIM2 global Interrupt                                             */
  TIM3_IRQn                   = 29,     /*!< TIM3 global Interrupt                                             */
  TIM4_IRQn                   = 30,     /*!< TIM4 global Interrupt                                             */
  I2C1_EV_IRQn                = 31,     /*!< I2C1 Event Interrupt                                              */
  I2C1_ER_IRQn                = 32,     /*!< I2C1 Error Interrupt                                              */
  I2C2_EV_IRQn                = 33,     /*!< I2C2 Event Interrupt                                              */
  I2C2_ER_IRQn                = 34,     /*!< I2C2 Error Interrupt                                              */
  SPI1_IRQn                   = 35,     /*!< SPI1 global Interrupt                                             */
  SPI2_IRQn                   = 36,     /*!< SPI2 global Interrupt                                             */
  USART1_IRQn                 = 37,     /*!< USART1 global Interrupt                                           */
  USART2_IRQn                 = 38,     /*!< USART2 global Interrupt                                           */
  EXTI15_10_IRQn              = 40,     /*!< External Line[15:10] Interrupts                                   */
  RTC_Alarm_IRQn              = 41,     /*!< RTC Alarm (A and B) through EXTI Line Interrupt                   */
  OTG_FS_WKUP_IRQn            = 42,     /*!< USB OTG FS Wakeup through EXTI line interrupt                     */
  DMA1_Stream7_IRQn           = 47,     /*!< DMA1 Stream7 Interrupt                                            */
  SDIO_IRQn                   = 49,     /*!< SDIO global Interrupt                                             */
  TIM5_IRQn                   = 50,     /*!< TIM5 global Interrupt                                             */
  SPI3_IRQn                   = 51,     /*!< SPI3 global Interrupt                                             */
  DMA2_Stream0_IRQn           = 56,     /*!< DMA2 Stream 0 global Interrupt                                    */
  DMA2_Stream1_IRQn           = 57,     /*!< DMA2 Stream 1 global Interrupt                                    */
  DMA2_Stream2_IRQn           = 58,     /*!< DMA2 Stream 2 global Interrupt                                    */
  DMA2_Stream3_IRQn           = 59,     /*!< DMA2 Stream 3 global Interrupt                                    */
  DMA2_Stream4_IRQn           = 60,     /*!< DMA2 Stream 4 global Interrupt                                    */
  OTG_FS_IRQn                 = 67,     /*!< USB OTG FS global Interrupt                                       */
  DMA2_Stream5_IRQn           = 68,     /*!< DMA2 Stream 5 global interrupt                                    */
  DMA2_Stream6_IRQn           = 69,     /*!< DMA2 Stream 6 global interrupt                                    */
  DMA2_Stream7_IRQn           = 70,     /*!< DMA2 Stream 7 global interrupt                                    */
  USART6_IRQn                 = 71,     /*!< USART6 global interrupt                                           */
  I2C3_EV_IRQn                = 72,     /*!< I2C3 event interrupt                                              */
  I2C3_ER_IRQn                = 73,     /*!< I2C3 error interrupt                                              */
  FPU_IRQn                    = 81,     /*!< FPU global interrupt                                              */
                                SPI4_IRQn                   = 84      /*!< SPI4 global Interrupt                                              */
} IRQn_Type;

/**
  * @}
  */

/**************************************************************************//**
 * @file     core_cm4.h
 * @brief    CMSIS Cortex-M4 Core Peripheral Access Layer Header File
 * @version  V5.1.2
 * @date     04. June 2021
 ******************************************************************************/
/*
 * Copyright (c) 2009-2020 Arm Limited. All rights reserved.
 *
 * SPDX-License-Identifier: Apache-2.0
 *
 * Licensed under the Apache License, Version 2.0 (the License); you may
 * not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an AS IS BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */










/* Ark C Compiler stdlib - stdint.h
 * C99 7.18???????????????
 * int ? 32 ????long long ? 64 ??????? 32 ????host???? */



/* ??????????? */
typedef signed char        int8_t;
typedef unsigned char      uint8_t;
typedef short              int16_t;
typedef unsigned short     uint16_t;
typedef int                int32_t;
typedef unsigned int       uint32_t;
typedef long long          int64_t;
typedef unsigned long long uint64_t;

/* ???????????? */
typedef signed char        int_least8_t;
typedef unsigned char      uint_least8_t;
typedef short              int_least16_t;
typedef unsigned short     uint_least16_t;
typedef int                int_least32_t;
typedef unsigned int       uint_least32_t;
typedef long long          int_least64_t;
typedef unsigned long long uint_least64_t;

/* ?????????? */
typedef signed char        int_fast8_t;
typedef unsigned char      uint_fast8_t;
typedef int                int_fast16_t;
typedef unsigned int       uint_fast16_t;
typedef int                int_fast32_t;
typedef unsigned int       uint_fast32_t;
typedef long long          int_fast64_t;
typedef unsigned long long uint_fast64_t;

/* ?????????? */
typedef int                intptr_t;
typedef unsigned int       uintptr_t;

/* ?????????? */
typedef long long          intmax_t;
typedef unsigned long long uintmax_t;

/* ?????????? */













/* ??????????????? */













/* ????????????? */













/* ?????????? */




/* ????????????? */




/* ????????????C99 7.18.3?? */




/* ??????????C99 7.18.4?? */

















/**
  \page CMSIS_MISRA_Exceptions  MISRA-C:2004 Compliance Exceptions
  CMSIS violates the following MISRA-C:2004 rules:

   \li Required Rule 8.5, object/function definition in header file.<br>
     Function definitions in header files are used to allow 'inlining'.

   \li Required Rule 18.4, declaration of union type or object of union type: '{...}'.<br>
     Unions are used for effective representation of core registers.

   \li Advisory Rule 19.7, Function-like macro defined.<br>
     Function-like macros are used to allow more efficient code.
 */


/*******************************************************************************
 *                 CMSIS definitions
 ******************************************************************************/
/**
  \ingroup Cortex_M4
  @{
 */

/**************************************************************************//**
 * @file     cmsis_version.h
 * @brief    CMSIS Core(M) Version definitions
 * @version  V5.0.5
 * @date     02. February 2022
 ******************************************************************************/
/*
 * Copyright (c) 2009-2022 ARM Limited. All rights reserved.
 *
 * SPDX-License-Identifier: Apache-2.0
 *
 * Licensed under the Apache License, Version 2.0 (the License); you may
 * not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an AS IS BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */










/*  CMSIS Version definitions */






/* CMSIS CM4 definitions */






/** __FPU_USED indicates whether an FPU is used or not.
    For this, __FPU_PRESENT has to be checked prior to making use of FPU specific registers and functions.
*/
















































































/**************************************************************************//**
 * @file     cmsis_compiler.h
 * @brief    CMSIS compiler generic header file
 * @version  V5.1.0
 * @date     09. October 2018
 ******************************************************************************/
/*
 * Copyright (c) 2009-2018 Arm Limited. All rights reserved.
 *
 * SPDX-License-Identifier: Apache-2.0
 *
 * Licensed under the Apache License, Version 2.0 (the License); you may
 * not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an AS IS BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */




/* Ark C Compiler stdlib - stdint.h
 * C99 7.18???????????????
 * int ? 32 ????long long ? 64 ??????? 32 ????host???? */




























































/*
 * Arm Compiler 4/5
 */

/**************************************************************************//**
 * @file     cmsis_armcc.h
 * @brief    CMSIS compiler ARMCC (Arm Compiler 5) header file
 * @version  V5.3.2
 * @date     27. May 2021
 ******************************************************************************/
/*
 * Copyright (c) 2009-2021 Arm Limited. All rights reserved.
 *
 * SPDX-License-Identifier: Apache-2.0
 *
 * Licensed under the Apache License, Version 2.0 (the License); you may
 * not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an AS IS BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */









/* CMSIS compiler control architecture macros */












  /* __ARM_ARCH_8M_BASE__  not applicable */
  /* __ARM_ARCH_8M_MAIN__  not applicable */
  /* __ARM_ARCH_8_1M_MAIN__  not applicable */

/* CMSIS compiler control DSP macros */




/* CMSIS compiler specific defines */























































/* #########################  Startup and Lowlevel Init  ######################## */





















/* ##########################  Core Instruction Access  ######################### */
/** \defgroup CMSIS_Core_InstructionInterface CMSIS Core Instruction Interface
  Access to dedicated instructions
  @{
*/

/**
  \brief   No Operation
  \details No Operation does nothing. This instruction can be used for code alignment purposes.
 */



/**
  \brief   Wait For Interrupt
  \details Wait For Interrupt is a hint instruction that suspends execution until one of a number of events occurs.
 */



/**
  \brief   Wait For Event
  \details Wait For Event is a hint instruction that permits the processor to enter
           a low-power state until one of a number of events occurs.
 */



/**
  \brief   Send Event
  \details Send Event is a hint instruction. It causes an event to be signaled to the CPU.
 */



/**
  \brief   Instruction Synchronization Barrier
  \details Instruction Synchronization Barrier flushes the pipeline in the processor,
           so that all instructions following the ISB are fetched from cache or memory,
           after the instruction has been completed.
 */


/**
  \brief   Data Synchronization Barrier
  \details Acts as a special kind of Data Memory Barrier.
           It completes when all explicit memory accesses before this instruction complete.
 */


/**
  \brief   Data Memory Barrier
  \details Ensures the apparent order of the explicit memory operations before
           and after the instruction, without ensuring their completion.
 */



/**
  \brief   Reverse byte order (32 bit)
  \details Reverses the byte order in unsigned integer value. For example, 0x12345678 becomes 0x78563412.
  \param [in]    value  Value to reverse
  \return               Reversed value
 */



/**
  \brief   Reverse byte order (16 bit)
  \details Reverses the byte order within each halfword of a word. For example, 0x12345678 becomes 0x34127856.
  \param [in]    value  Value to reverse
  \return               Reversed value
 */

__attribute__((section(".rev16_text"))) static __inline __asm uint32_t __REV16(uint32_t value)
{
  rev16 r0, r0
  bx lr
}



/**
  \brief   Reverse byte order (16 bit)
  \details Reverses the byte order in a 16-bit value and returns the signed 16-bit result. For example, 0x0080 becomes 0x8000.
  \param [in]    value  Value to reverse
  \return               Reversed value
 */

__attribute__((section(".revsh_text"))) static __inline __asm int16_t __REVSH(int16_t value)
{
  revsh r0, r0
  bx lr
}



/**
  \brief   Rotate Right in unsigned value (32 bit)
  \details Rotate Right (immediate) provides the value of the contents of a register rotated by a variable number of bits.
  \param [in]    op1  Value to rotate
  \param [in]    op2  Number of Bits to rotate
  \return               Rotated value
 */



/**
  \brief   Breakpoint
  \details Causes the processor to enter Debug state.
           Debug tools can use this to investigate system state when the instruction at a particular address is reached.
  \param [in]    value  is ignored by the processor.
                 If required, a debugger can use it to store additional information about the breakpoint.
 */



/**
  \brief   Reverse bit order of value
  \details Reverses the bit order of the given value.
  \param [in]    value  Value to reverse
  \return               Reversed value
 */






/**
  \brief   Count leading zeros
  \details Counts the number of leading zeros of a data value.
  \param [in]  value  Value to count the leading zeros
  \return             number of leading zeros in value
 */





/**
  \brief   LDR Exclusive (8 bit)
  \details Executes a exclusive LDR instruction for 8 bit value.
  \param [in]    ptr  Pointer to data
  \return             value of type uint8_t at (*ptr)
 */







/**
  \brief   LDR Exclusive (16 bit)
  \details Executes a exclusive LDR instruction for 16 bit values.
  \param [in]    ptr  Pointer to data
  \return        value of type uint16_t at (*ptr)
 */







/**
  \brief   LDR Exclusive (32 bit)
  \details Executes a exclusive LDR instruction for 32 bit values.
  \param [in]    ptr  Pointer to data
  \return        value of type uint32_t at (*ptr)
 */







/**
  \brief   STR Exclusive (8 bit)
  \details Executes a exclusive STR instruction for 8 bit values.
  \param [in]  value  Value to store
  \param [in]    ptr  Pointer to location
  \return          0  Function succeeded
  \return          1  Function failed
 */







/**
  \brief   STR Exclusive (16 bit)
  \details Executes a exclusive STR instruction for 16 bit values.
  \param [in]  value  Value to store
  \param [in]    ptr  Pointer to location
  \return          0  Function succeeded
  \return          1  Function failed
 */







/**
  \brief   STR Exclusive (32 bit)
  \details Executes a exclusive STR instruction for 32 bit values.
  \param [in]  value  Value to store
  \param [in]    ptr  Pointer to location
  \return          0  Function succeeded
  \return          1  Function failed
 */







/**
  \brief   Remove the exclusive lock
  \details Removes the exclusive lock which is created by LDREX.
 */



/**
  \brief   Signed Saturate
  \details Saturates a signed value.
  \param [in]  value  Value to be saturated
  \param [in]    sat  Bit position to saturate to (1..32)
  \return             Saturated value
 */



/**
  \brief   Unsigned Saturate
  \details Saturates an unsigned value.
  \param [in]  value  Value to be saturated
  \param [in]    sat  Bit position to saturate to (0..31)
  \return             Saturated value
 */



/**
  \brief   Rotate Right with Extend (32 bit)
  \details Moves each bit of a bitstring right by one bit.
           The carry input is shifted in at the left end of the bitstring.
  \param [in]    value  Value to rotate
  \return               Rotated value
 */

__attribute__((section(".rrx_text"))) static __inline __asm uint32_t __RRX(uint32_t value)
{
  rrx r0, r0
  bx lr
}



/**
  \brief   LDRT Unprivileged (8 bit)
  \details Executes a Unprivileged LDRT instruction for 8 bit value.
  \param [in]    ptr  Pointer to data
  \return             value of type uint8_t at (*ptr)
 */



/**
  \brief   LDRT Unprivileged (16 bit)
  \details Executes a Unprivileged LDRT instruction for 16 bit values.
  \param [in]    ptr  Pointer to data
  \return        value of type uint16_t at (*ptr)
 */



/**
  \brief   LDRT Unprivileged (32 bit)
  \details Executes a Unprivileged LDRT instruction for 32 bit values.
  \param [in]    ptr  Pointer to data
  \return        value of type uint32_t at (*ptr)
 */



/**
  \brief   STRT Unprivileged (8 bit)
  \details Executes a Unprivileged STRT instruction for 8 bit values.
  \param [in]  value  Value to store
  \param [in]    ptr  Pointer to location
 */



/**
  \brief   STRT Unprivileged (16 bit)
  \details Executes a Unprivileged STRT instruction for 16 bit values.
  \param [in]  value  Value to store
  \param [in]    ptr  Pointer to location
 */



/**
  \brief   STRT Unprivileged (32 bit)
  \details Executes a Unprivileged STRT instruction for 32 bit values.
  \param [in]  value  Value to store
  \param [in]    ptr  Pointer to location
 */





/*@}*/ /* end of group CMSIS_Core_InstructionInterface */


/* ###########################  Core Function Access  ########################### */
/** \ingroup  CMSIS_Core_FunctionInterface
    \defgroup CMSIS_Core_RegAccFunctions CMSIS Core Register Access Functions
  @{
 */

/**
  \brief   Enable IRQ Interrupts
  \details Enables IRQ interrupts by clearing special-purpose register PRIMASK.
           Can only be executed in Privileged modes.
 */
/* intrinsic void __enable_irq();     */


/**
  \brief   Disable IRQ Interrupts
  \details Disables IRQ interrupts by setting special-purpose register PRIMASK.
           Can only be executed in Privileged modes.
 */
/* intrinsic void __disable_irq();    */

/**
  \brief   Get Control Register
  \details Returns the content of the Control Register.
  \return               Control Register value
 */
static __inline uint32_t __get_CONTROL(void)
{
  register uint32_t __regControl         __asm("control");
  return(__regControl);
}


/**
  \brief   Set Control Register
  \details Writes the given value to the Control Register.
  \param [in]    control  Control Register value to set
 */
static __inline void __set_CONTROL(uint32_t control)
{
  register uint32_t __regControl         __asm("control");
  __regControl = control;
  __isb(0xF);
}


/**
  \brief   Get IPSR Register
  \details Returns the content of the IPSR Register.
  \return               IPSR Register value
 */
static __inline uint32_t __get_IPSR(void)
{
  register uint32_t __regIPSR          __asm("ipsr");
  return(__regIPSR);
}


/**
  \brief   Get APSR Register
  \details Returns the content of the APSR Register.
  \return               APSR Register value
 */
static __inline uint32_t __get_APSR(void)
{
  register uint32_t __regAPSR          __asm("apsr");
  return(__regAPSR);
}


/**
  \brief   Get xPSR Register
  \details Returns the content of the xPSR Register.
  \return               xPSR Register value
 */
static __inline uint32_t __get_xPSR(void)
{
  register uint32_t __regXPSR          __asm("xpsr");
  return(__regXPSR);
}


/**
  \brief   Get Process Stack Pointer
  \details Returns the current value of the Process Stack Pointer (PSP).
  \return               PSP Register value
 */
static __inline uint32_t __get_PSP(void)
{
  register uint32_t __regProcessStackPointer  __asm("psp");
  return(__regProcessStackPointer);
}


/**
  \brief   Set Process Stack Pointer
  \details Assigns the given value to the Process Stack Pointer (PSP).
  \param [in]    topOfProcStack  Process Stack Pointer value to set
 */
static __inline void __set_PSP(uint32_t topOfProcStack)
{
  register uint32_t __regProcessStackPointer  __asm("psp");
  __regProcessStackPointer = topOfProcStack;
}


/**
  \brief   Get Main Stack Pointer
  \details Returns the current value of the Main Stack Pointer (MSP).
  \return               MSP Register value
 */
static __inline uint32_t __get_MSP(void)
{
  register uint32_t __regMainStackPointer     __asm("msp");
  return(__regMainStackPointer);
}


/**
  \brief   Set Main Stack Pointer
  \details Assigns the given value to the Main Stack Pointer (MSP).
  \param [in]    topOfMainStack  Main Stack Pointer value to set
 */
static __inline void __set_MSP(uint32_t topOfMainStack)
{
  register uint32_t __regMainStackPointer     __asm("msp");
  __regMainStackPointer = topOfMainStack;
}


/**
  \brief   Get Priority Mask
  \details Returns the current state of the priority mask bit from the Priority Mask Register.
  \return               Priority Mask value
 */
static __inline uint32_t __get_PRIMASK(void)
{
  register uint32_t __regPriMask         __asm("primask");
  return(__regPriMask);
}


/**
  \brief   Set Priority Mask
  \details Assigns the given value to the Priority Mask Register.
  \param [in]    priMask  Priority Mask
 */
static __inline void __set_PRIMASK(uint32_t priMask)
{
  register uint32_t __regPriMask         __asm("primask");
  __regPriMask = (priMask);
}




/**
  \brief   Enable FIQ
  \details Enables FIQ interrupts by clearing special-purpose register FAULTMASK.
           Can only be executed in Privileged modes.
 */



/**
  \brief   Disable FIQ
  \details Disables FIQ interrupts by setting special-purpose register FAULTMASK.
           Can only be executed in Privileged modes.
 */



/**
  \brief   Get Base Priority
  \details Returns the current value of the Base Priority register.
  \return               Base Priority register value
 */
static __inline uint32_t  __get_BASEPRI(void)
{
  register uint32_t __regBasePri         __asm("basepri");
  return(__regBasePri);
}


/**
  \brief   Set Base Priority
  \details Assigns the given value to the Base Priority register.
  \param [in]    basePri  Base Priority value to set
 */
static __inline void __set_BASEPRI(uint32_t basePri)
{
  register uint32_t __regBasePri         __asm("basepri");
  __regBasePri = (basePri & 0xFFU);
}


/**
  \brief   Set Base Priority with condition
  \details Assigns the given value to the Base Priority register only if BASEPRI masking is disabled,
           or the new value increases the BASEPRI priority level.
  \param [in]    basePri  Base Priority value to set
 */
static __inline void __set_BASEPRI_MAX(uint32_t basePri)
{
  register uint32_t __regBasePriMax      __asm("basepri_max");
  __regBasePriMax = (basePri & 0xFFU);
}


/**
  \brief   Get Fault Mask
  \details Returns the current value of the Fault Mask register.
  \return               Fault Mask register value
 */
static __inline uint32_t __get_FAULTMASK(void)
{
  register uint32_t __regFaultMask       __asm("faultmask");
  return(__regFaultMask);
}


/**
  \brief   Set Fault Mask
  \details Assigns the given value to the Fault Mask register.
  \param [in]    faultMask  Fault Mask value to set
 */
static __inline void __set_FAULTMASK(uint32_t faultMask)
{
  register uint32_t __regFaultMask       __asm("faultmask");
  __regFaultMask = (faultMask & (uint32_t)1U);
}




/**
  \brief   Get FPSCR
  \details Returns the current value of the Floating Point Status/Control register.
  \return               Floating Point Status/Control register value
 */
static __inline uint32_t __get_FPSCR(void)
{

  register uint32_t __regfpscr         __asm("fpscr");
  return(__regfpscr);


}


/**
  \brief   Set FPSCR
  \details Assigns the given value to the Floating Point Status/Control register.
  \param [in]    fpscr  Floating Point Status/Control value to set
 */
static __inline void __set_FPSCR(uint32_t fpscr)
{

  register uint32_t __regfpscr         __asm("fpscr");
  __regfpscr = (fpscr);


}


/*@} end of CMSIS_Core_RegAccFunctions */


/* ###################  Compiler specific Intrinsics  ########################### */
/** \defgroup CMSIS_SIMD_intrinsics CMSIS SIMD Intrinsics
  Access to dedicated SIMD instructions
  @{
*/










































































/*@} end of group CMSIS_SIMD_intrinsics */






/*
 * Arm Compiler 6.6 LTM (armclang)
 */













































































































































































































/* check device defines and use defaults */



























/* IO definitions (access restrictions to peripheral registers) */
/**
    \defgroup CMSIS_glob_defs CMSIS Global Defines

    <strong>IO Type Qualifiers</strong> are used
    \li to specify the access to peripheral variables.
    \li for automatic generation of peripheral register debug information.
*/








/* following defines should be used for structure members */




/*@} end of group Cortex_M4 */



/*******************************************************************************
 *                 Register Abstraction
  Core Register contain:
  - Core Register
  - Core NVIC Register
  - Core SCB Register
  - Core SysTick Register
  - Core Debug Register
  - Core MPU Register
  - Core FPU Register
 ******************************************************************************/
/**
  \defgroup CMSIS_core_register Defines and Type Definitions
  \brief Type definitions and defines for Cortex-M processor based devices.
*/

/**
  \ingroup    CMSIS_core_register
  \defgroup   CMSIS_CORE  Status and Control Registers
  \brief      Core Register type definitions.
  @{
 */

/**
  \brief  Union type to access the Application Program Status Register (APSR).
 */
typedef union
{
  struct
  {
    uint32_t _reserved0:16;              /*!< bit:  0..15  Reserved */
    uint32_t GE:4;                       /*!< bit: 16..19  Greater than or Equal flags */
    uint32_t _reserved1:7;               /*!< bit: 20..26  Reserved */
    uint32_t Q:1;                        /*!< bit:     27  Saturation condition flag */
    uint32_t V:1;                        /*!< bit:     28  Overflow condition code flag */
    uint32_t C:1;                        /*!< bit:     29  Carry condition code flag */
    uint32_t Z:1;                        /*!< bit:     30  Zero condition code flag */
    uint32_t N:1;                        /*!< bit:     31  Negative condition code flag */
  } b;                                   /*!< Structure used for bit  access */
  uint32_t w;                            /*!< Type      used for word access */
} APSR_Type;

/* APSR Register Definitions */



















/**
  \brief  Union type to access the Interrupt Program Status Register (IPSR).
 */
typedef union
{
  struct
  {
    uint32_t ISR:9;                      /*!< bit:  0.. 8  Exception number */
    uint32_t _reserved0:23;              /*!< bit:  9..31  Reserved */
  } b;                                   /*!< Structure used for bit  access */
  uint32_t w;                            /*!< Type      used for word access */
} IPSR_Type;

/* IPSR Register Definitions */




/**
  \brief  Union type to access the Special-Purpose Program Status Registers (xPSR).
 */
typedef union
{
  struct
  {
    uint32_t ISR:9;                      /*!< bit:  0.. 8  Exception number */
    uint32_t _reserved0:1;               /*!< bit:      9  Reserved */
    uint32_t ICI_IT_1:6;                 /*!< bit: 10..15  ICI/IT part 1 */
    uint32_t GE:4;                       /*!< bit: 16..19  Greater than or Equal flags */
    uint32_t _reserved1:4;               /*!< bit: 20..23  Reserved */
    uint32_t T:1;                        /*!< bit:     24  Thumb bit */
    uint32_t ICI_IT_2:2;                 /*!< bit: 25..26  ICI/IT part 2 */
    uint32_t Q:1;                        /*!< bit:     27  Saturation condition flag */
    uint32_t V:1;                        /*!< bit:     28  Overflow condition code flag */
    uint32_t C:1;                        /*!< bit:     29  Carry condition code flag */
    uint32_t Z:1;                        /*!< bit:     30  Zero condition code flag */
    uint32_t N:1;                        /*!< bit:     31  Negative condition code flag */
  } b;                                   /*!< Structure used for bit  access */
  uint32_t w;                            /*!< Type      used for word access */
} xPSR_Type;

/* xPSR Register Definitions */































/**
  \brief  Union type to access the Control Registers (CONTROL).
 */
typedef union
{
  struct
  {
    uint32_t nPRIV:1;                    /*!< bit:      0  Execution privilege in Thread mode */
    uint32_t SPSEL:1;                    /*!< bit:      1  Stack to be used */
    uint32_t FPCA:1;                     /*!< bit:      2  FP extension active flag */
    uint32_t _reserved0:29;              /*!< bit:  3..31  Reserved */
  } b;                                   /*!< Structure used for bit  access */
  uint32_t w;                            /*!< Type      used for word access */
} CONTROL_Type;

/* CONTROL Register Definitions */









/*@} end of group CMSIS_CORE */


/**
  \ingroup    CMSIS_core_register
  \defgroup   CMSIS_NVIC  Nested Vectored Interrupt Controller (NVIC)
  \brief      Type definitions for the NVIC Registers
  @{
 */

/**
  \brief  Structure type to access the Nested Vectored Interrupt Controller (NVIC).
 */
typedef struct
{
  volatile uint32_t ISER[8U];               /*!< Offset: 0x000 (R/W)  Interrupt Set Enable Register */
        uint32_t RESERVED0[24U];
  volatile uint32_t ICER[8U];               /*!< Offset: 0x080 (R/W)  Interrupt Clear Enable Register */
        uint32_t RESERVED1[24U];
  volatile uint32_t ISPR[8U];               /*!< Offset: 0x100 (R/W)  Interrupt Set Pending Register */
        uint32_t RESERVED2[24U];
  volatile uint32_t ICPR[8U];               /*!< Offset: 0x180 (R/W)  Interrupt Clear Pending Register */
        uint32_t RESERVED3[24U];
  volatile uint32_t IABR[8U];               /*!< Offset: 0x200 (R/W)  Interrupt Active bit Register */
        uint32_t RESERVED4[56U];
  volatile uint8_t  IP[240U];               /*!< Offset: 0x300 (R/W)  Interrupt Priority Register (8Bit wide) */
        uint32_t RESERVED5[644U];
  volatile  uint32_t STIR;                   /*!< Offset: 0xE00 ( /W)  Software Trigger Interrupt Register */
}  NVIC_Type;

/* Software Triggered Interrupt Register Definitions */



/*@} end of group CMSIS_NVIC */


/**
  \ingroup  CMSIS_core_register
  \defgroup CMSIS_SCB     System Control Block (SCB)
  \brief    Type definitions for the System Control Block Registers
  @{
 */

/**
  \brief  Structure type to access the System Control Block (SCB).
 */
typedef struct
{
  volatile const  uint32_t CPUID;                  /*!< Offset: 0x000 (R/ )  CPUID Base Register */
  volatile uint32_t ICSR;                   /*!< Offset: 0x004 (R/W)  Interrupt Control and State Register */
  volatile uint32_t VTOR;                   /*!< Offset: 0x008 (R/W)  Vector Table Offset Register */
  volatile uint32_t AIRCR;                  /*!< Offset: 0x00C (R/W)  Application Interrupt and Reset Control Register */
  volatile uint32_t SCR;                    /*!< Offset: 0x010 (R/W)  System Control Register */
  volatile uint32_t CCR;                    /*!< Offset: 0x014 (R/W)  Configuration Control Register */
  volatile uint8_t  SHP[12U];               /*!< Offset: 0x018 (R/W)  System Handlers Priority Registers (4-7, 8-11, 12-15) */
  volatile uint32_t SHCSR;                  /*!< Offset: 0x024 (R/W)  System Handler Control and State Register */
  volatile uint32_t CFSR;                   /*!< Offset: 0x028 (R/W)  Configurable Fault Status Register */
  volatile uint32_t HFSR;                   /*!< Offset: 0x02C (R/W)  HardFault Status Register */
  volatile uint32_t DFSR;                   /*!< Offset: 0x030 (R/W)  Debug Fault Status Register */
  volatile uint32_t MMFAR;                  /*!< Offset: 0x034 (R/W)  MemManage Fault Address Register */
  volatile uint32_t BFAR;                   /*!< Offset: 0x038 (R/W)  BusFault Address Register */
  volatile uint32_t AFSR;                   /*!< Offset: 0x03C (R/W)  Auxiliary Fault Status Register */
  volatile const  uint32_t PFR[2U];                /*!< Offset: 0x040 (R/ )  Processor Feature Register */
  volatile const  uint32_t DFR;                    /*!< Offset: 0x048 (R/ )  Debug Feature Register */
  volatile const  uint32_t ADR;                    /*!< Offset: 0x04C (R/ )  Auxiliary Feature Register */
  volatile const  uint32_t MMFR[4U];               /*!< Offset: 0x050 (R/ )  Memory Model Feature Register */
  volatile const  uint32_t ISAR[5U];               /*!< Offset: 0x060 (R/ )  Instruction Set Attributes Register */
        uint32_t RESERVED0[5U];
  volatile uint32_t CPACR;                  /*!< Offset: 0x088 (R/W)  Coprocessor Access Control Register */
} SCB_Type;

/* SCB CPUID Register Definitions */















/* SCB Interrupt Control State Register Definitions */






























/* SCB Vector Table Offset Register Definitions */



/* SCB Application Interrupt and Reset Control Register Definitions */





















/* SCB System Control Register Definitions */









/* SCB Configuration Control Register Definitions */


















/* SCB System Handler Control and State Register Definitions */










































/* SCB Configurable Fault Status Register Definitions */









/* MemManage Fault Status Register (part of SCB Configurable Fault Status Register) */


















/* BusFault Status Register (part of SCB Configurable Fault Status Register) */





















/* UsageFault Status Register (part of SCB Configurable Fault Status Register) */


















/* SCB Hard Fault Status Register Definitions */









/* SCB Debug Fault Status Register Definitions */















/*@} end of group CMSIS_SCB */


/**
  \ingroup  CMSIS_core_register
  \defgroup CMSIS_SCnSCB System Controls not in SCB (SCnSCB)
  \brief    Type definitions for the System Control and ID Register not in the SCB
  @{
 */

/**
  \brief  Structure type to access the System Control and ID Register not in the SCB.
 */
typedef struct
{
        uint32_t RESERVED0[1U];
  volatile const  uint32_t ICTR;                   /*!< Offset: 0x004 (R/ )  Interrupt Controller Type Register */
  volatile uint32_t ACTLR;                  /*!< Offset: 0x008 (R/W)  Auxiliary Control Register */
} SCnSCB_Type;

/* Interrupt Controller Type Register Definitions */



/* Auxiliary Control Register Definitions */















/*@} end of group CMSIS_SCnotSCB */


/**
  \ingroup  CMSIS_core_register
  \defgroup CMSIS_SysTick     System Tick Timer (SysTick)
  \brief    Type definitions for the System Timer Registers.
  @{
 */

/**
  \brief  Structure type to access the System Timer (SysTick).
 */
typedef struct
{
  volatile uint32_t CTRL;                   /*!< Offset: 0x000 (R/W)  SysTick Control and Status Register */
  volatile uint32_t LOAD;                   /*!< Offset: 0x004 (R/W)  SysTick Reload Value Register */
  volatile uint32_t VAL;                    /*!< Offset: 0x008 (R/W)  SysTick Current Value Register */
  volatile const  uint32_t CALIB;                  /*!< Offset: 0x00C (R/ )  SysTick Calibration Register */
} SysTick_Type;

/* SysTick Control / Status Register Definitions */












/* SysTick Reload Register Definitions */



/* SysTick Current Register Definitions */



/* SysTick Calibration Register Definitions */









/*@} end of group CMSIS_SysTick */


/**
  \ingroup  CMSIS_core_register
  \defgroup CMSIS_ITM     Instrumentation Trace Macrocell (ITM)
  \brief    Type definitions for the Instrumentation Trace Macrocell (ITM)
  @{
 */

/**
  \brief  Structure type to access the Instrumentation Trace Macrocell Register (ITM).
 */
typedef struct
{
  volatile  union
  {
    volatile  uint8_t    u8;                 /*!< Offset: 0x000 ( /W)  ITM Stimulus Port 8-bit */
    volatile  uint16_t   u16;                /*!< Offset: 0x000 ( /W)  ITM Stimulus Port 16-bit */
    volatile  uint32_t   u32;                /*!< Offset: 0x000 ( /W)  ITM Stimulus Port 32-bit */
  }  PORT [32U];                         /*!< Offset: 0x000 ( /W)  ITM Stimulus Port Registers */
        uint32_t RESERVED0[864U];
  volatile uint32_t TER;                    /*!< Offset: 0xE00 (R/W)  ITM Trace Enable Register */
        uint32_t RESERVED1[15U];
  volatile uint32_t TPR;                    /*!< Offset: 0xE40 (R/W)  ITM Trace Privilege Register */
        uint32_t RESERVED2[15U];
  volatile uint32_t TCR;                    /*!< Offset: 0xE80 (R/W)  ITM Trace Control Register */
        uint32_t RESERVED3[32U];
        uint32_t RESERVED4[43U];
  volatile  uint32_t LAR;                    /*!< Offset: 0xFB0 ( /W)  ITM Lock Access Register */
  volatile const  uint32_t LSR;                    /*!< Offset: 0xFB4 (R/ )  ITM Lock Status Register */
        uint32_t RESERVED5[6U];
  volatile const  uint32_t PID4;                   /*!< Offset: 0xFD0 (R/ )  ITM Peripheral Identification Register #4 */
  volatile const  uint32_t PID5;                   /*!< Offset: 0xFD4 (R/ )  ITM Peripheral Identification Register #5 */
  volatile const  uint32_t PID6;                   /*!< Offset: 0xFD8 (R/ )  ITM Peripheral Identification Register #6 */
  volatile const  uint32_t PID7;                   /*!< Offset: 0xFDC (R/ )  ITM Peripheral Identification Register #7 */
  volatile const  uint32_t PID0;                   /*!< Offset: 0xFE0 (R/ )  ITM Peripheral Identification Register #0 */
  volatile const  uint32_t PID1;                   /*!< Offset: 0xFE4 (R/ )  ITM Peripheral Identification Register #1 */
  volatile const  uint32_t PID2;                   /*!< Offset: 0xFE8 (R/ )  ITM Peripheral Identification Register #2 */
  volatile const  uint32_t PID3;                   /*!< Offset: 0xFEC (R/ )  ITM Peripheral Identification Register #3 */
  volatile const  uint32_t CID0;                   /*!< Offset: 0xFF0 (R/ )  ITM Component  Identification Register #0 */
  volatile const  uint32_t CID1;                   /*!< Offset: 0xFF4 (R/ )  ITM Component  Identification Register #1 */
  volatile const  uint32_t CID2;                   /*!< Offset: 0xFF8 (R/ )  ITM Component  Identification Register #2 */
  volatile const  uint32_t CID3;                   /*!< Offset: 0xFFC (R/ )  ITM Component  Identification Register #3 */
} ITM_Type;

/* ITM Trace Privilege Register Definitions */



/* ITM Trace Control Register Definitions */



























/* ITM Lock Status Register Definitions */









/*@}*/ /* end of group CMSIS_ITM */


/**
  \ingroup  CMSIS_core_register
  \defgroup CMSIS_DWT     Data Watchpoint and Trace (DWT)
  \brief    Type definitions for the Data Watchpoint and Trace (DWT)
  @{
 */

/**
  \brief  Structure type to access the Data Watchpoint and Trace Register (DWT).
 */
typedef struct
{
  volatile uint32_t CTRL;                   /*!< Offset: 0x000 (R/W)  Control Register */
  volatile uint32_t CYCCNT;                 /*!< Offset: 0x004 (R/W)  Cycle Count Register */
  volatile uint32_t CPICNT;                 /*!< Offset: 0x008 (R/W)  CPI Count Register */
  volatile uint32_t EXCCNT;                 /*!< Offset: 0x00C (R/W)  Exception Overhead Count Register */
  volatile uint32_t SLEEPCNT;               /*!< Offset: 0x010 (R/W)  Sleep Count Register */
  volatile uint32_t LSUCNT;                 /*!< Offset: 0x014 (R/W)  LSU Count Register */
  volatile uint32_t FOLDCNT;                /*!< Offset: 0x018 (R/W)  Folded-instruction Count Register */
  volatile const  uint32_t PCSR;                   /*!< Offset: 0x01C (R/ )  Program Counter Sample Register */
  volatile uint32_t COMP0;                  /*!< Offset: 0x020 (R/W)  Comparator Register 0 */
  volatile uint32_t MASK0;                  /*!< Offset: 0x024 (R/W)  Mask Register 0 */
  volatile uint32_t FUNCTION0;              /*!< Offset: 0x028 (R/W)  Function Register 0 */
        uint32_t RESERVED0[1U];
  volatile uint32_t COMP1;                  /*!< Offset: 0x030 (R/W)  Comparator Register 1 */
  volatile uint32_t MASK1;                  /*!< Offset: 0x034 (R/W)  Mask Register 1 */
  volatile uint32_t FUNCTION1;              /*!< Offset: 0x038 (R/W)  Function Register 1 */
        uint32_t RESERVED1[1U];
  volatile uint32_t COMP2;                  /*!< Offset: 0x040 (R/W)  Comparator Register 2 */
  volatile uint32_t MASK2;                  /*!< Offset: 0x044 (R/W)  Mask Register 2 */
  volatile uint32_t FUNCTION2;              /*!< Offset: 0x048 (R/W)  Function Register 2 */
        uint32_t RESERVED2[1U];
  volatile uint32_t COMP3;                  /*!< Offset: 0x050 (R/W)  Comparator Register 3 */
  volatile uint32_t MASK3;                  /*!< Offset: 0x054 (R/W)  Mask Register 3 */
  volatile uint32_t FUNCTION3;              /*!< Offset: 0x058 (R/W)  Function Register 3 */
} DWT_Type;

/* DWT Control Register Definitions */






















































/* DWT CPI Count Register Definitions */



/* DWT Exception Overhead Count Register Definitions */



/* DWT Sleep Count Register Definitions */



/* DWT LSU Count Register Definitions */



/* DWT Folded-instruction Count Register Definitions */



/* DWT Comparator Mask Register Definitions */



/* DWT Comparator Function Register Definitions */



























/*@}*/ /* end of group CMSIS_DWT */


/**
  \ingroup  CMSIS_core_register
  \defgroup CMSIS_TPI     Trace Port Interface (TPI)
  \brief    Type definitions for the Trace Port Interface (TPI)
  @{
 */

/**
  \brief  Structure type to access the Trace Port Interface Register (TPI).
 */
typedef struct
{
  volatile const  uint32_t SSPSR;                  /*!< Offset: 0x000 (R/ )  Supported Parallel Port Size Register */
  volatile uint32_t CSPSR;                  /*!< Offset: 0x004 (R/W)  Current Parallel Port Size Register */
        uint32_t RESERVED0[2U];
  volatile uint32_t ACPR;                   /*!< Offset: 0x010 (R/W)  Asynchronous Clock Prescaler Register */
        uint32_t RESERVED1[55U];
  volatile uint32_t SPPR;                   /*!< Offset: 0x0F0 (R/W)  Selected Pin Protocol Register */
        uint32_t RESERVED2[131U];
  volatile const  uint32_t FFSR;                   /*!< Offset: 0x300 (R/ )  Formatter and Flush Status Register */
  volatile uint32_t FFCR;                   /*!< Offset: 0x304 (R/W)  Formatter and Flush Control Register */
  volatile const  uint32_t FSCR;                   /*!< Offset: 0x308 (R/ )  Formatter Synchronization Counter Register */
        uint32_t RESERVED3[759U];
  volatile const  uint32_t TRIGGER;                /*!< Offset: 0xEE8 (R/ )  TRIGGER Register */
  volatile const  uint32_t FIFO0;                  /*!< Offset: 0xEEC (R/ )  Integration ETM Data */
  volatile const  uint32_t ITATBCTR2;              /*!< Offset: 0xEF0 (R/ )  ITATBCTR2 */
        uint32_t RESERVED4[1U];
  volatile const  uint32_t ITATBCTR0;              /*!< Offset: 0xEF8 (R/ )  ITATBCTR0 */
  volatile const  uint32_t FIFO1;                  /*!< Offset: 0xEFC (R/ )  Integration ITM Data */
  volatile uint32_t ITCTRL;                 /*!< Offset: 0xF00 (R/W)  Integration Mode Control */
        uint32_t RESERVED5[39U];
  volatile uint32_t CLAIMSET;               /*!< Offset: 0xFA0 (R/W)  Claim tag set */
  volatile uint32_t CLAIMCLR;               /*!< Offset: 0xFA4 (R/W)  Claim tag clear */
        uint32_t RESERVED7[8U];
  volatile const  uint32_t DEVID;                  /*!< Offset: 0xFC8 (R/ )  TPIU_DEVID */
  volatile const  uint32_t DEVTYPE;                /*!< Offset: 0xFCC (R/ )  TPIU_DEVTYPE */
} TPI_Type;

/* TPI Asynchronous Clock Prescaler Register Definitions */



/* TPI Selected Pin Protocol Register Definitions */



/* TPI Formatter and Flush Status Register Definitions */












/* TPI Formatter and Flush Control Register Definitions */






/* TPI TRIGGER Register Definitions */



/* TPI Integration ETM Data Register Definitions (FIFO0) */





















/* TPI ITATBCTR2 Register Definitions */






/* TPI Integration ITM Data Register Definitions (FIFO1) */





















/* TPI ITATBCTR0 Register Definitions */






/* TPI Integration Mode Control Register Definitions */



/* TPI DEVID Register Definitions */


















/* TPI DEVTYPE Register Definitions */






/*@}*/ /* end of group CMSIS_TPI */



/**
  \ingroup  CMSIS_core_register
  \defgroup CMSIS_MPU     Memory Protection Unit (MPU)
  \brief    Type definitions for the Memory Protection Unit (MPU)
  @{
 */

/**
  \brief  Structure type to access the Memory Protection Unit (MPU).
 */
typedef struct
{
  volatile const  uint32_t TYPE;                   /*!< Offset: 0x000 (R/ )  MPU Type Register */
  volatile uint32_t CTRL;                   /*!< Offset: 0x004 (R/W)  MPU Control Register */
  volatile uint32_t RNR;                    /*!< Offset: 0x008 (R/W)  MPU Region RNRber Register */
  volatile uint32_t RBAR;                   /*!< Offset: 0x00C (R/W)  MPU Region Base Address Register */
  volatile uint32_t RASR;                   /*!< Offset: 0x010 (R/W)  MPU Region Attribute and Size Register */
  volatile uint32_t RBAR_A1;                /*!< Offset: 0x014 (R/W)  MPU Alias 1 Region Base Address Register */
  volatile uint32_t RASR_A1;                /*!< Offset: 0x018 (R/W)  MPU Alias 1 Region Attribute and Size Register */
  volatile uint32_t RBAR_A2;                /*!< Offset: 0x01C (R/W)  MPU Alias 2 Region Base Address Register */
  volatile uint32_t RASR_A2;                /*!< Offset: 0x020 (R/W)  MPU Alias 2 Region Attribute and Size Register */
  volatile uint32_t RBAR_A3;                /*!< Offset: 0x024 (R/W)  MPU Alias 3 Region Base Address Register */
  volatile uint32_t RASR_A3;                /*!< Offset: 0x028 (R/W)  MPU Alias 3 Region Attribute and Size Register */
} MPU_Type;



/* MPU Type Register Definitions */









/* MPU Control Register Definitions */









/* MPU Region Number Register Definitions */



/* MPU Region Base Address Register Definitions */









/* MPU Region Attribute and Size Register Definitions */






























/*@} end of group CMSIS_MPU */



/**
  \ingroup  CMSIS_core_register
  \defgroup CMSIS_FPU     Floating Point Unit (FPU)
  \brief    Type definitions for the Floating Point Unit (FPU)
  @{
 */

/**
  \brief  Structure type to access the Floating Point Unit (FPU).
 */
typedef struct
{
        uint32_t RESERVED0[1U];
  volatile uint32_t FPCCR;                  /*!< Offset: 0x004 (R/W)  Floating-Point Context Control Register */
  volatile uint32_t FPCAR;                  /*!< Offset: 0x008 (R/W)  Floating-Point Context Address Register */
  volatile uint32_t FPDSCR;                 /*!< Offset: 0x00C (R/W)  Floating-Point Default Status Control Register */
  volatile const  uint32_t MVFR0;                  /*!< Offset: 0x010 (R/ )  Media and FP Feature Register 0 */
  volatile const  uint32_t MVFR1;                  /*!< Offset: 0x014 (R/ )  Media and FP Feature Register 1 */
  volatile const  uint32_t MVFR2;                  /*!< Offset: 0x018 (R/ )  Media and FP Feature Register 2 */
} FPU_Type;

/* Floating-Point Context Control Register Definitions */



























/* Floating-Point Context Address Register Definitions */



/* Floating-Point Default Status Control Register Definitions */












/* Media and FP Feature Register 0 Definitions */
























/* Media and FP Feature Register 1 Definitions */












/* Media and FP Feature Register 2 Definitions */




/*@} end of group CMSIS_FPU */


/**
  \ingroup  CMSIS_core_register
  \defgroup CMSIS_CoreDebug       Core Debug Registers (CoreDebug)
  \brief    Type definitions for the Core Debug Registers
  @{
 */

/**
  \brief  Structure type to access the Core Debug Register (CoreDebug).
 */
typedef struct
{
  volatile uint32_t DHCSR;                  /*!< Offset: 0x000 (R/W)  Debug Halting Control and Status Register */
  volatile  uint32_t DCRSR;                  /*!< Offset: 0x004 ( /W)  Debug Core Register Selector Register */
  volatile uint32_t DCRDR;                  /*!< Offset: 0x008 (R/W)  Debug Core Register Data Register */
  volatile uint32_t DEMCR;                  /*!< Offset: 0x00C (R/W)  Debug Exception and Monitor Control Register */
} CoreDebug_Type;

/* Debug Halting Control and Status Register Definitions */




































/* Debug Core Register Selector Register Definitions */






/* Debug Exception and Monitor Control Register Definitions */







































/*@} end of group CMSIS_CoreDebug */


/**
  \ingroup    CMSIS_core_register
  \defgroup   CMSIS_core_bitfield     Core register bit field macros
  \brief      Macros for use with bit field definitions (xxx_Pos, xxx_Msk).
  @{
 */

/**
  \brief   Mask and shift a bit field value for use in a register bit range.
  \param[in] field  Name of the register bit field.
  \param[in] value  Value of the bit field. This parameter is interpreted as an uint32_t type.
  \return           Masked and shifted value.
*/


/**
  \brief     Mask and shift a register value to extract a bit filed value.
  \param[in] field  Name of the register bit field.
  \param[in] value  Value of register. This parameter is interpreted as an uint32_t type.
  \return           Masked and shifted bit field value.
*/


/*@} end of group CMSIS_core_bitfield */


/**
  \ingroup    CMSIS_core_register
  \defgroup   CMSIS_core_base     Core Definitions
  \brief      Definitions for base addresses, unions, and structures.
  @{
 */

/* Memory mapping of Core Hardware */


























/*@} */



/*******************************************************************************
 *                Hardware Abstraction Layer
  Core Function Interface contains:
  - Core NVIC Functions
  - Core SysTick Functions
  - Core Debug Functions
  - Core Register Access Functions
 ******************************************************************************/
/**
  \defgroup CMSIS_Core_FunctionInterface Functions and Instructions Reference
*/



/* ##########################   NVIC functions  #################################### */
/**
  \ingroup  CMSIS_Core_FunctionInterface
  \defgroup CMSIS_Core_NVICFunctions NVIC Functions
  \brief    Functions that manage interrupts and exceptions via the NVIC.
  @{
 */


































/* The following EXC_RETURN values are saved the LR on exception entry */








/**
  \brief   Set Priority Grouping
  \details Sets the priority grouping field using the required unlock sequence.
           The parameter PriorityGroup is assigned to the field SCB->AIRCR [10:8] PRIGROUP field.
           Only values from 0..7 are used.
           In case of a conflict between priority grouping and available
           priority bits (__NVIC_PRIO_BITS), the smallest possible priority group is set.
  \param [in]      PriorityGroup  Priority grouping field.
 */
static __inline void __NVIC_SetPriorityGrouping(uint32_t PriorityGroup)
{
  uint32_t reg_value;
  uint32_t PriorityGroupTmp = (PriorityGroup & (uint32_t)0x07UL);             /* only values 0..7 are used          */

  reg_value  =  ((SCB_Type       *)     ((0xE000E000UL) +  0x0D00UL)      )->AIRCR;                                                   /* read old register configuration    */
  reg_value &= ~((uint32_t)((0xFFFFUL << 16U) | (7UL << 8U))); /* clear bits to change               */
  reg_value  =  (reg_value                                   |
                ((uint32_t)0x5FAUL << 16U) |
                (PriorityGroupTmp << 8U)  );              /* Insert write key and priority group */
  ((SCB_Type       *)     ((0xE000E000UL) +  0x0D00UL)      )->AIRCR =  reg_value;
}


/**
  \brief   Get Priority Grouping
  \details Reads the priority grouping field from the NVIC Interrupt Controller.
  \return                Priority grouping field (SCB->AIRCR [10:8] PRIGROUP field).
 */
static __inline uint32_t __NVIC_GetPriorityGrouping(void)
{
  return ((uint32_t)((((SCB_Type       *)     ((0xE000E000UL) +  0x0D00UL)      )->AIRCR & (7UL << 8U)) >> 8U));
}


/**
  \brief   Enable Interrupt
  \details Enables a device specific interrupt in the NVIC interrupt controller.
  \param [in]      IRQn  Device specific interrupt number.
  \note    IRQn must not be negative.
 */
static __inline void __NVIC_EnableIRQ(IRQn_Type IRQn)
{
  if ((int32_t)(IRQn) >= 0)
  {
    __memory_changed();
    ((NVIC_Type      *)     ((0xE000E000UL) +  0x0100UL)     )->ISER[(((uint32_t)IRQn) >> 5UL)] = (uint32_t)(1UL << (((uint32_t)IRQn) & 0x1FUL));
    __memory_changed();
  }
}


/**
  \brief   Get Interrupt Enable status
  \details Returns a device specific interrupt enable status from the NVIC interrupt controller.
  \param [in]      IRQn  Device specific interrupt number.
  \return             0  Interrupt is not enabled.
  \return             1  Interrupt is enabled.
  \note    IRQn must not be negative.
 */
static __inline uint32_t __NVIC_GetEnableIRQ(IRQn_Type IRQn)
{
  if ((int32_t)(IRQn) >= 0)
  {
    return((uint32_t)(((((NVIC_Type      *)     ((0xE000E000UL) +  0x0100UL)     )->ISER[(((uint32_t)IRQn) >> 5UL)] & (1UL << (((uint32_t)IRQn) & 0x1FUL))) != 0UL) ? 1UL : 0UL));
  }
  else
  {
    return(0U);
  }
}


/**
  \brief   Disable Interrupt
  \details Disables a device specific interrupt in the NVIC interrupt controller.
  \param [in]      IRQn  Device specific interrupt number.
  \note    IRQn must not be negative.
 */
static __inline void __NVIC_DisableIRQ(IRQn_Type IRQn)
{
  if ((int32_t)(IRQn) >= 0)
  {
    ((NVIC_Type      *)     ((0xE000E000UL) +  0x0100UL)     )->ICER[(((uint32_t)IRQn) >> 5UL)] = (uint32_t)(1UL << (((uint32_t)IRQn) & 0x1FUL));
    __dsb(0xF);
    __isb(0xF);
  }
}


/**
  \brief   Get Pending Interrupt
  \details Reads the NVIC pending register and returns the pending bit for the specified device specific interrupt.
  \param [in]      IRQn  Device specific interrupt number.
  \return             0  Interrupt status is not pending.
  \return             1  Interrupt status is pending.
  \note    IRQn must not be negative.
 */
static __inline uint32_t __NVIC_GetPendingIRQ(IRQn_Type IRQn)
{
  if ((int32_t)(IRQn) >= 0)
  {
    return((uint32_t)(((((NVIC_Type      *)     ((0xE000E000UL) +  0x0100UL)     )->ISPR[(((uint32_t)IRQn) >> 5UL)] & (1UL << (((uint32_t)IRQn) & 0x1FUL))) != 0UL) ? 1UL : 0UL));
  }
  else
  {
    return(0U);
  }
}


/**
  \brief   Set Pending Interrupt
  \details Sets the pending bit of a device specific interrupt in the NVIC pending register.
  \param [in]      IRQn  Device specific interrupt number.
  \note    IRQn must not be negative.
 */
static __inline void __NVIC_SetPendingIRQ(IRQn_Type IRQn)
{
  if ((int32_t)(IRQn) >= 0)
  {
    ((NVIC_Type      *)     ((0xE000E000UL) +  0x0100UL)     )->ISPR[(((uint32_t)IRQn) >> 5UL)] = (uint32_t)(1UL << (((uint32_t)IRQn) & 0x1FUL));
  }
}


/**
  \brief   Clear Pending Interrupt
  \details Clears the pending bit of a device specific interrupt in the NVIC pending register.
  \param [in]      IRQn  Device specific interrupt number.
  \note    IRQn must not be negative.
 */
static __inline void __NVIC_ClearPendingIRQ(IRQn_Type IRQn)
{
  if ((int32_t)(IRQn) >= 0)
  {
    ((NVIC_Type      *)     ((0xE000E000UL) +  0x0100UL)     )->ICPR[(((uint32_t)IRQn) >> 5UL)] = (uint32_t)(1UL << (((uint32_t)IRQn) & 0x1FUL));
  }
}


/**
  \brief   Get Active Interrupt
  \details Reads the active register in the NVIC and returns the active bit for the device specific interrupt.
  \param [in]      IRQn  Device specific interrupt number.
  \return             0  Interrupt status is not active.
  \return             1  Interrupt status is active.
  \note    IRQn must not be negative.
 */
static __inline uint32_t __NVIC_GetActive(IRQn_Type IRQn)
{
  if ((int32_t)(IRQn) >= 0)
  {
    return((uint32_t)(((((NVIC_Type      *)     ((0xE000E000UL) +  0x0100UL)     )->IABR[(((uint32_t)IRQn) >> 5UL)] & (1UL << (((uint32_t)IRQn) & 0x1FUL))) != 0UL) ? 1UL : 0UL));
  }
  else
  {
    return(0U);
  }
}


/**
  \brief   Set Interrupt Priority
  \details Sets the priority of a device specific interrupt or a processor exception.
           The interrupt number can be positive to specify a device specific interrupt,
           or negative to specify a processor exception.
  \param [in]      IRQn  Interrupt number.
  \param [in]  priority  Priority to set.
  \note    The priority cannot be set for every processor exception.
 */
static __inline void __NVIC_SetPriority(IRQn_Type IRQn, uint32_t priority)
{
  if ((int32_t)(IRQn) >= 0)
  {
    ((NVIC_Type      *)     ((0xE000E000UL) +  0x0100UL)     )->IP[((uint32_t)IRQn)]               = (uint8_t)((priority << (8U - 4U)) & (uint32_t)0xFFUL);
  }
  else
  {
    ((SCB_Type       *)     ((0xE000E000UL) +  0x0D00UL)      )->SHP[(((uint32_t)IRQn) & 0xFUL)-4UL] = (uint8_t)((priority << (8U - 4U)) & (uint32_t)0xFFUL);
  }
}


/**
  \brief   Get Interrupt Priority
  \details Reads the priority of a device specific interrupt or a processor exception.
           The interrupt number can be positive to specify a device specific interrupt,
           or negative to specify a processor exception.
  \param [in]   IRQn  Interrupt number.
  \return             Interrupt Priority.
                      Value is aligned automatically to the implemented priority bits of the microcontroller.
 */
static __inline uint32_t __NVIC_GetPriority(IRQn_Type IRQn)
{

  if ((int32_t)(IRQn) >= 0)
  {
    return(((uint32_t)((NVIC_Type      *)     ((0xE000E000UL) +  0x0100UL)     )->IP[((uint32_t)IRQn)]               >> (8U - 4U)));
  }
  else
  {
    return(((uint32_t)((SCB_Type       *)     ((0xE000E000UL) +  0x0D00UL)      )->SHP[(((uint32_t)IRQn) & 0xFUL)-4UL] >> (8U - 4U)));
  }
}


/**
  \brief   Encode Priority
  \details Encodes the priority for an interrupt with the given priority group,
           preemptive priority value, and subpriority value.
           In case of a conflict between priority grouping and available
           priority bits (__NVIC_PRIO_BITS), the smallest possible priority group is set.
  \param [in]     PriorityGroup  Used priority group.
  \param [in]   PreemptPriority  Preemptive priority value (starting from 0).
  \param [in]       SubPriority  Subpriority value (starting from 0).
  \return                        Encoded priority. Value can be used in the function \ref NVIC_SetPriority().
 */
static __inline uint32_t NVIC_EncodePriority (uint32_t PriorityGroup, uint32_t PreemptPriority, uint32_t SubPriority)
{
  uint32_t PriorityGroupTmp = (PriorityGroup & (uint32_t)0x07UL);   /* only values 0..7 are used          */
  uint32_t PreemptPriorityBits;
  uint32_t SubPriorityBits;

  PreemptPriorityBits = ((7UL - PriorityGroupTmp) > (uint32_t)(4U)) ? (uint32_t)(4U) : (uint32_t)(7UL - PriorityGroupTmp);
  SubPriorityBits     = ((PriorityGroupTmp + (uint32_t)(4U)) < (uint32_t)7UL) ? (uint32_t)0UL : (uint32_t)((PriorityGroupTmp - 7UL) + (uint32_t)(4U));

  return (
           ((PreemptPriority & (uint32_t)((1UL << (PreemptPriorityBits)) - 1UL)) << SubPriorityBits) |
           ((SubPriority     & (uint32_t)((1UL << (SubPriorityBits    )) - 1UL)))
         );
}


/**
  \brief   Decode Priority
  \details Decodes an interrupt priority value with a given priority group to
           preemptive priority value and subpriority value.
           In case of a conflict between priority grouping and available
           priority bits (__NVIC_PRIO_BITS) the smallest possible priority group is set.
  \param [in]         Priority   Priority value, which can be retrieved with the function \ref NVIC_GetPriority().
  \param [in]     PriorityGroup  Used priority group.
  \param [out] pPreemptPriority  Preemptive priority value (starting from 0).
  \param [out]     pSubPriority  Subpriority value (starting from 0).
 */
static __inline void NVIC_DecodePriority (uint32_t Priority, uint32_t PriorityGroup, uint32_t* const pPreemptPriority, uint32_t* const pSubPriority)
{
  uint32_t PriorityGroupTmp = (PriorityGroup & (uint32_t)0x07UL);   /* only values 0..7 are used          */
  uint32_t PreemptPriorityBits;
  uint32_t SubPriorityBits;

  PreemptPriorityBits = ((7UL - PriorityGroupTmp) > (uint32_t)(4U)) ? (uint32_t)(4U) : (uint32_t)(7UL - PriorityGroupTmp);
  SubPriorityBits     = ((PriorityGroupTmp + (uint32_t)(4U)) < (uint32_t)7UL) ? (uint32_t)0UL : (uint32_t)((PriorityGroupTmp - 7UL) + (uint32_t)(4U));

  *pPreemptPriority = (Priority >> SubPriorityBits) & (uint32_t)((1UL << (PreemptPriorityBits)) - 1UL);
  *pSubPriority     = (Priority                   ) & (uint32_t)((1UL << (SubPriorityBits    )) - 1UL);
}


/**
  \brief   Set Interrupt Vector
  \details Sets an interrupt vector in SRAM based interrupt vector table.
           The interrupt number can be positive to specify a device specific interrupt,
           or negative to specify a processor exception.
           VTOR must been relocated to SRAM before.
  \param [in]   IRQn      Interrupt number
  \param [in]   vector    Address of interrupt handler function
 */
static __inline void __NVIC_SetVector(IRQn_Type IRQn, uint32_t vector)
{
  uint32_t *vectors = (uint32_t *)((SCB_Type       *)     ((0xE000E000UL) +  0x0D00UL)      )->VTOR;
  vectors[(int32_t)IRQn + 16] = vector;
  /* ARM Application Note 321 states that the M4 does not require the architectural barrier */
}


/**
  \brief   Get Interrupt Vector
  \details Reads an interrupt vector from interrupt vector table.
           The interrupt number can be positive to specify a device specific interrupt,
           or negative to specify a processor exception.
  \param [in]   IRQn      Interrupt number.
  \return                 Address of interrupt handler function
 */
static __inline uint32_t __NVIC_GetVector(IRQn_Type IRQn)
{
  uint32_t *vectors = (uint32_t *)((SCB_Type       *)     ((0xE000E000UL) +  0x0D00UL)      )->VTOR;
  return vectors[(int32_t)IRQn + 16];
}


/**
  \brief   System Reset
  \details Initiates a system reset request to reset the MCU.
 */
__declspec(noreturn) static __inline void __NVIC_SystemReset(void)
{
  __dsb(0xF);                                                          /* Ensure all outstanding memory accesses included
                                                                       buffered write are completed before reset */
  ((SCB_Type       *)     ((0xE000E000UL) +  0x0D00UL)      )->AIRCR  = (uint32_t)((0x5FAUL << 16U)    |
                           (((SCB_Type       *)     ((0xE000E000UL) +  0x0D00UL)      )->AIRCR & (7UL << 8U)) |
                            (1UL << 2U)    );         /* Keep priority group unchanged */
  __dsb(0xF);                                                          /* Ensure completion of memory access */

  for(;;)                                                           /* wait until reset */
  {
    __nop();
  }
}

/*@} end of CMSIS_Core_NVICFunctions */


/* ##########################  MPU functions  #################################### */



/******************************************************************************
 * @file     mpu_armv7.h
 * @brief    CMSIS MPU API for Armv7-M MPU
 * @version  V5.1.2
 * @date     25. May 2020
 ******************************************************************************/
/*
 * Copyright (c) 2017-2020 Arm Limited. All rights reserved.
 *
 * SPDX-License-Identifier: Apache-2.0
 *
 * Licensed under the Apache License, Version 2.0 (the License); you may
 * not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an AS IS BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
 





 







































/** MPU Region Base Address Register Value
*
* \param Region The region to be configured, number 0 to 15.
* \param BaseAddress The base address for the region.
*/


/**
* MPU Memory Access Attributes
* 
* \param TypeExtField      Type extension field, allows you to configure memory access type, for example strongly ordered, peripheral.
* \param IsShareable       Region is shareable between multiple bus masters.
* \param IsCacheable       Region is cacheable, i.e. its value may be kept in cache.
* \param IsBufferable      Region is bufferable, i.e. using write-back caching. Cacheable but non-bufferable regions use write-through policy.
*/  


/**
* MPU Region Attribute and Size Register Value
* 
* \param DisableExec       Instruction access disable bit, 1= disable instruction fetches.
* \param AccessPermission  Data access permissions, allows you to configure read/write access for User and Privileged mode.
* \param AccessAttributes  Memory access attribution, see \ref ARM_MPU_ACCESS_.
* \param SubRegionDisable  Sub-region disable field.
* \param Size              Region size of the region to be configured, for example 4K, 8K.
*/


/**
* MPU Region Attribute and Size Register Value
* 
* \param DisableExec       Instruction access disable bit, 1= disable instruction fetches.
* \param AccessPermission  Data access permissions, allows you to configure read/write access for User and Privileged mode.
* \param TypeExtField      Type extension field, allows you to configure memory access type, for example strongly ordered, peripheral.
* \param IsShareable       Region is shareable between multiple bus masters.
* \param IsCacheable       Region is cacheable, i.e. its value may be kept in cache.
* \param IsBufferable      Region is bufferable, i.e. using write-back caching. Cacheable but non-bufferable regions use write-through policy.
* \param SubRegionDisable  Sub-region disable field.
* \param Size              Region size of the region to be configured, for example 4K, 8K.
*/                         


/**
* MPU Memory Access Attribute for strongly ordered memory.
*  - TEX: 000b
*  - Shareable
*  - Non-cacheable
*  - Non-bufferable
*/ 


/**
* MPU Memory Access Attribute for device memory.
*  - TEX: 000b (if shareable) or 010b (if non-shareable)
*  - Shareable or non-shareable
*  - Non-cacheable
*  - Bufferable (if shareable) or non-bufferable (if non-shareable)
*
* \param IsShareable Configures the device memory as shareable or non-shareable.
*/ 


/**
* MPU Memory Access Attribute for normal memory.
*  - TEX: 1BBb (reflecting outer cacheability rules)
*  - Shareable or non-shareable
*  - Cacheable or non-cacheable (reflecting inner cacheability rules)
*  - Bufferable or non-bufferable (reflecting inner cacheability rules)
*
* \param OuterCp Configures the outer cache policy.
* \param InnerCp Configures the inner cache policy.
* \param IsShareable Configures the memory as shareable or non-shareable.
*/ 


/**
* MPU Memory Access Attribute non-cacheable policy.
*/


/**
* MPU Memory Access Attribute write-back, write and read allocate policy.
*/


/**
* MPU Memory Access Attribute write-through, no write allocate policy.
*/


/**
* MPU Memory Access Attribute write-back, no write allocate policy.
*/



/**
* Struct for a single MPU Region
*/
typedef struct {
  uint32_t RBAR; //!< The region base address register value (RBAR)
  uint32_t RASR; //!< The region attribute and size register value (RASR) \ref MPU_RASR
} ARM_MPU_Region_t;
    
/** Enable the MPU.
* \param MPU_Control Default access permissions for unconfigured regions.
*/
static __inline void ARM_MPU_Enable(uint32_t MPU_Control)
{
  __dmb(0xF);
  ((MPU_Type       *)     ((0xE000E000UL) +  0x0D90UL)      )->CTRL = MPU_Control | (1UL  );

  ((SCB_Type       *)     ((0xE000E000UL) +  0x0D00UL)      )->SHCSR |= (1UL << 16U);

  __dsb(0xF);
  __isb(0xF);
}

/** Disable the MPU.
*/
static __inline void ARM_MPU_Disable(void)
{
  __dmb(0xF);

  ((SCB_Type       *)     ((0xE000E000UL) +  0x0D00UL)      )->SHCSR &= ~(1UL << 16U);

  ((MPU_Type       *)     ((0xE000E000UL) +  0x0D90UL)      )->CTRL  &= ~(1UL  );
  __dsb(0xF);
  __isb(0xF);
}

/** Clear and disable the given MPU region.
* \param rnr Region number to be cleared.
*/
static __inline void ARM_MPU_ClrRegion(uint32_t rnr)
{
  ((MPU_Type       *)     ((0xE000E000UL) +  0x0D90UL)      )->RNR = rnr;
  ((MPU_Type       *)     ((0xE000E000UL) +  0x0D90UL)      )->RASR = 0U;
}

/** Configure an MPU region.
* \param rbar Value for RBAR register.
* \param rasr Value for RASR register.
*/   
static __inline void ARM_MPU_SetRegion(uint32_t rbar, uint32_t rasr)
{
  ((MPU_Type       *)     ((0xE000E000UL) +  0x0D90UL)      )->RBAR = rbar;
  ((MPU_Type       *)     ((0xE000E000UL) +  0x0D90UL)      )->RASR = rasr;
}

/** Configure the given MPU region.
* \param rnr Region number to be configured.
* \param rbar Value for RBAR register.
* \param rasr Value for RASR register.
*/   
static __inline void ARM_MPU_SetRegionEx(uint32_t rnr, uint32_t rbar, uint32_t rasr)
{
  ((MPU_Type       *)     ((0xE000E000UL) +  0x0D90UL)      )->RNR = rnr;
  ((MPU_Type       *)     ((0xE000E000UL) +  0x0D90UL)      )->RBAR = rbar;
  ((MPU_Type       *)     ((0xE000E000UL) +  0x0D90UL)      )->RASR = rasr;
}

/** Memcpy with strictly ordered memory access, e.g. used by code in ARM_MPU_Load().
* \param dst Destination data is copied to.
* \param src Source data is copied from.
* \param len Amount of data words to be copied.
*/
static __inline void ARM_MPU_OrderedMemcpy(volatile uint32_t* dst, const uint32_t* __restrict src, uint32_t len)
{
  uint32_t i;
  for (i = 0U; i < len; ++i) 
  {
    dst[i] = src[i];
  }
}

/** Load the given number of MPU regions from a table.
* \param table Pointer to the MPU configuration table.
* \param cnt Amount of regions to be configured.
*/
static __inline void ARM_MPU_Load(ARM_MPU_Region_t const* table, uint32_t cnt) 
{
  const uint32_t rowWordSize = sizeof(ARM_MPU_Region_t)/4U;
  while (cnt > 4U) {
    ARM_MPU_OrderedMemcpy(&(((MPU_Type       *)     ((0xE000E000UL) +  0x0D90UL)      )->RBAR), &(table->RBAR), 4U*rowWordSize);
    table += 4U;
    cnt -= 4U;
  }
  ARM_MPU_OrderedMemcpy(&(((MPU_Type       *)     ((0xE000E000UL) +  0x0D90UL)      )->RBAR), &(table->RBAR), cnt*rowWordSize);
}







/* ##########################  FPU functions  #################################### */
/**
  \ingroup  CMSIS_Core_FunctionInterface
  \defgroup CMSIS_Core_FpuFunctions FPU Functions
  \brief    Function that provides FPU type.
  @{
 */

/**
  \brief   get FPU type
  \details returns the FPU type
  \returns
   - \b  0: No FPU
   - \b  1: Single precision FPU
   - \b  2: Double + Single precision FPU
 */
static __inline uint32_t SCB_GetFPUType(void)
{
  uint32_t mvfr0;

  mvfr0 = ((FPU_Type       *)     ((0xE000E000UL) +  0x0F30UL)      )->MVFR0;
  if      ((mvfr0 & ((0xFUL << 4U) | (0xFUL << 8U))) == 0x020U)
  {
    return 1U;           /* Single precision FPU */
  }
  else
  {
    return 0U;           /* No FPU */
  }
}


/*@} end of CMSIS_Core_FpuFunctions */



/* ##################################    SysTick function  ############################################ */
/**
  \ingroup  CMSIS_Core_FunctionInterface
  \defgroup CMSIS_Core_SysTickFunctions SysTick Functions
  \brief    Functions that configure the System.
  @{
 */



/**
  \brief   System Tick Configuration
  \details Initializes the System Timer and its interrupt, and starts the System Tick Timer.
           Counter is in free running mode to generate periodic interrupts.
  \param [in]  ticks  Number of ticks between two interrupts.
  \return          0  Function succeeded.
  \return          1  Function failed.
  \note    When the variable <b>__Vendor_SysTickConfig</b> is set to 1, then the
           function <b>SysTick_Config</b> is not included. In this case, the file <b><i>device</i>.h</b>
           must contain a vendor-specific implementation of this function.
 */
static __inline uint32_t SysTick_Config(uint32_t ticks)
{
  if ((ticks - 1UL) > (0xFFFFFFUL  ))
  {
    return (1UL);                                                   /* Reload value impossible */
  }

  ((SysTick_Type   *)     ((0xE000E000UL) +  0x0010UL)  )->LOAD  = (uint32_t)(ticks - 1UL);                         /* set reload register */
  __NVIC_SetPriority (SysTick_IRQn, (1UL << 4U) - 1UL); /* set Priority for Systick Interrupt */
  ((SysTick_Type   *)     ((0xE000E000UL) +  0x0010UL)  )->VAL   = 0UL;                                             /* Load the SysTick Counter Value */
  ((SysTick_Type   *)     ((0xE000E000UL) +  0x0010UL)  )->CTRL  = (1UL << 2U) |
                   (1UL << 1U)   |
                   (1UL  );                         /* Enable SysTick IRQ and SysTick Timer */
  return (0UL);                                                     /* Function successful */
}



/*@} end of CMSIS_Core_SysTickFunctions */



/* ##################################### Debug In/Output function ########################################### */
/**
  \ingroup  CMSIS_Core_FunctionInterface
  \defgroup CMSIS_core_DebugFunctions ITM Functions
  \brief    Functions that access the ITM debug interface.
  @{
 */

extern volatile int32_t ITM_RxBuffer;                              /*!< External variable to receive characters. */



/**
  \brief   ITM Send Character
  \details Transmits a character via the ITM channel 0, and
           \li Just returns when no debugger is connected that has booked the output.
           \li Is blocking when a debugger is connected, but the previous character sent has not been transmitted.
  \param [in]     ch  Character to transmit.
  \returns            Character to transmit.
 */
static __inline uint32_t ITM_SendChar (uint32_t ch)
{
  if (((((ITM_Type       *)     (0xE0000000UL)      )->TCR & (1UL  )) != 0UL) &&      /* ITM enabled */
      ((((ITM_Type       *)     (0xE0000000UL)      )->TER & 1UL               ) != 0UL)   )     /* ITM Port #0 enabled */
  {
    while (((ITM_Type       *)     (0xE0000000UL)      )->PORT[0U].u32 == 0UL)
    {
      __nop();
    }
    ((ITM_Type       *)     (0xE0000000UL)      )->PORT[0U].u8 = (uint8_t)ch;
  }
  return (ch);
}


/**
  \brief   ITM Receive Character
  \details Inputs a character via the external variable \ref ITM_RxBuffer.
  \return             Received character.
  \return         -1  No character pending.
 */
static __inline int32_t ITM_ReceiveChar (void)
{
  int32_t ch = -1;                           /* no character available */

  if (ITM_RxBuffer != ((int32_t)0x5AA55AA5U))
  {
    ch = ITM_RxBuffer;
    ITM_RxBuffer = ((int32_t)0x5AA55AA5U);       /* ready for next character */
  }

  return (ch);
}


/**
  \brief   ITM Check Character
  \details Checks whether a character is pending for reading in the variable \ref ITM_RxBuffer.
  \return          0  No character available.
  \return          1  Character available.
 */
static __inline int32_t ITM_CheckChar (void)
{

  if (ITM_RxBuffer == ((int32_t)0x5AA55AA5U))
  {
    return (0);                              /* no character available */
  }
  else
  {
    return (1);                              /*    character available */
  }
}

/*@} end of CMSIS_core_DebugFunctions */











/**
  ******************************************************************************
  * @file    system_stm32f4xx.h
  * @author  MCD Application Team
  * @brief   CMSIS Cortex-M4 Device System Source File for STM32F4xx devices.
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2017 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */

/** @addtogroup CMSIS
  * @{
  */

/** @addtogroup stm32f4xx_system
  * @{
  */

/**
  * @brief Define to prevent recursive inclusion
  */






/** @addtogroup STM32F4xx_System_Includes
  * @{
  */

/**
  * @}
  */


/** @addtogroup STM32F4xx_System_Exported_types
  * @{
  */
/* This variable is updated in three ways:
    1) by calling CMSIS function SystemCoreClockUpdate()
    2) by calling HAL API function HAL_RCC_GetSysClockFreq()
    3) each time HAL_RCC_ClockConfig() is called to configure the system clock frequency
       Note: If you use this function to configure the system clock; then there
             is no need to call the 2 first functions listed above, since SystemCoreClock
             variable is updated automatically.
*/
extern uint32_t SystemCoreClock;          /*!< System Clock Frequency (Core Clock) */

extern const uint8_t  AHBPrescTable[16];    /*!< AHB prescalers table values */
extern const uint8_t  APBPrescTable[8];     /*!< APB prescalers table values */

/**
  * @}
  */

/** @addtogroup STM32F4xx_System_Exported_Constants
  * @{
  */

/**
  * @}
  */

/** @addtogroup STM32F4xx_System_Exported_Macros
  * @{
  */

/**
  * @}
  */

/** @addtogroup STM32F4xx_System_Exported_Functions
  * @{
  */

extern void SystemInit(void);
extern void SystemCoreClockUpdate(void);
/**
  * @}
  */






/**
  * @}
  */

/**
  * @}
  */

/* Ark C Compiler stdlib - stdint.h
 * C99 7.18???????????????
 * int ? 32 ????long long ? 64 ??????? 32 ????host???? */




























































/** @addtogroup Peripheral_registers_structures
  * @{
  */

/**
  * @brief Analog to Digital Converter
  */

typedef struct
{
  volatile uint32_t SR;     /*!< ADC status register,                         Address offset: 0x00 */
  volatile uint32_t CR1;    /*!< ADC control register 1,                      Address offset: 0x04 */
  volatile uint32_t CR2;    /*!< ADC control register 2,                      Address offset: 0x08 */
  volatile uint32_t SMPR1;  /*!< ADC sample time register 1,                  Address offset: 0x0C */
  volatile uint32_t SMPR2;  /*!< ADC sample time register 2,                  Address offset: 0x10 */
  volatile uint32_t JOFR1;  /*!< ADC injected channel data offset register 1, Address offset: 0x14 */
  volatile uint32_t JOFR2;  /*!< ADC injected channel data offset register 2, Address offset: 0x18 */
  volatile uint32_t JOFR3;  /*!< ADC injected channel data offset register 3, Address offset: 0x1C */
  volatile uint32_t JOFR4;  /*!< ADC injected channel data offset register 4, Address offset: 0x20 */
  volatile uint32_t HTR;    /*!< ADC watchdog higher threshold register,      Address offset: 0x24 */
  volatile uint32_t LTR;    /*!< ADC watchdog lower threshold register,       Address offset: 0x28 */
  volatile uint32_t SQR1;   /*!< ADC regular sequence register 1,             Address offset: 0x2C */
  volatile uint32_t SQR2;   /*!< ADC regular sequence register 2,             Address offset: 0x30 */
  volatile uint32_t SQR3;   /*!< ADC regular sequence register 3,             Address offset: 0x34 */
  volatile uint32_t JSQR;   /*!< ADC injected sequence register,              Address offset: 0x38*/
  volatile uint32_t JDR1;   /*!< ADC injected data register 1,                Address offset: 0x3C */
  volatile uint32_t JDR2;   /*!< ADC injected data register 2,                Address offset: 0x40 */
  volatile uint32_t JDR3;   /*!< ADC injected data register 3,                Address offset: 0x44 */
  volatile uint32_t JDR4;   /*!< ADC injected data register 4,                Address offset: 0x48 */
  volatile uint32_t DR;     /*!< ADC regular data register,                   Address offset: 0x4C */
} ADC_TypeDef;

typedef struct
{
  volatile uint32_t CSR;    /*!< ADC Common status register,                  Address offset: ADC1 base address + 0x300 */
  volatile uint32_t CCR;    /*!< ADC common control register,                 Address offset: ADC1 base address + 0x304 */
  volatile uint32_t CDR;    /*!< ADC common regular data register for dual
                             AND triple modes,                            Address offset: ADC1 base address + 0x308 */
} ADC_Common_TypeDef;

/**
  * @brief CRC calculation unit
  */

typedef struct
{
  volatile uint32_t DR;         /*!< CRC Data register,             Address offset: 0x00 */
  volatile uint8_t  IDR;        /*!< CRC Independent data register, Address offset: 0x04 */
  uint8_t       RESERVED0;  /*!< Reserved, 0x05                                      */
  uint16_t      RESERVED1;  /*!< Reserved, 0x06                                      */
  volatile uint32_t CR;         /*!< CRC Control register,          Address offset: 0x08 */
} CRC_TypeDef;

/**
  * @brief Debug MCU
  */

typedef struct
{
  volatile uint32_t IDCODE;  /*!< MCU device ID code,               Address offset: 0x00 */
  volatile uint32_t CR;      /*!< Debug MCU configuration register, Address offset: 0x04 */
  volatile uint32_t APB1FZ;  /*!< Debug MCU APB1 freeze register,   Address offset: 0x08 */
  volatile uint32_t APB2FZ;  /*!< Debug MCU APB2 freeze register,   Address offset: 0x0C */
} DBGMCU_TypeDef;


/**
  * @brief DMA Controller
  */

typedef struct
{
  volatile uint32_t CR;     /*!< DMA stream x configuration register      */
  volatile uint32_t NDTR;   /*!< DMA stream x number of data register     */
  volatile uint32_t PAR;    /*!< DMA stream x peripheral address register */
  volatile uint32_t M0AR;   /*!< DMA stream x memory 0 address register   */
  volatile uint32_t M1AR;   /*!< DMA stream x memory 1 address register   */
  volatile uint32_t FCR;    /*!< DMA stream x FIFO control register       */
} DMA_Stream_TypeDef;

typedef struct
{
  volatile uint32_t LISR;   /*!< DMA low interrupt status register,      Address offset: 0x00 */
  volatile uint32_t HISR;   /*!< DMA high interrupt status register,     Address offset: 0x04 */
  volatile uint32_t LIFCR;  /*!< DMA low interrupt flag clear register,  Address offset: 0x08 */
  volatile uint32_t HIFCR;  /*!< DMA high interrupt flag clear register, Address offset: 0x0C */
} DMA_TypeDef;

/**
  * @brief External Interrupt/Event Controller
  */

typedef struct
{
  volatile uint32_t IMR;    /*!< EXTI Interrupt mask register,            Address offset: 0x00 */
  volatile uint32_t EMR;    /*!< EXTI Event mask register,                Address offset: 0x04 */
  volatile uint32_t RTSR;   /*!< EXTI Rising trigger selection register,  Address offset: 0x08 */
  volatile uint32_t FTSR;   /*!< EXTI Falling trigger selection register, Address offset: 0x0C */
  volatile uint32_t SWIER;  /*!< EXTI Software interrupt event register,  Address offset: 0x10 */
  volatile uint32_t PR;     /*!< EXTI Pending register,                   Address offset: 0x14 */
} EXTI_TypeDef;

/**
  * @brief FLASH Registers
  */

typedef struct
{
  volatile uint32_t ACR;      /*!< FLASH access control register,   Address offset: 0x00 */
  volatile uint32_t KEYR;     /*!< FLASH key register,              Address offset: 0x04 */
  volatile uint32_t OPTKEYR;  /*!< FLASH option key register,       Address offset: 0x08 */
  volatile uint32_t SR;       /*!< FLASH status register,           Address offset: 0x0C */
  volatile uint32_t CR;       /*!< FLASH control register,          Address offset: 0x10 */
  volatile uint32_t OPTCR;    /*!< FLASH option control register ,  Address offset: 0x14 */
  volatile uint32_t OPTCR1;   /*!< FLASH option control register 1, Address offset: 0x18 */
} FLASH_TypeDef;

/**
  * @brief General Purpose I/O
  */

typedef struct
{
  volatile uint32_t MODER;    /*!< GPIO port mode register,               Address offset: 0x00      */
  volatile uint32_t OTYPER;   /*!< GPIO port output type register,        Address offset: 0x04      */
  volatile uint32_t OSPEEDR;  /*!< GPIO port output speed register,       Address offset: 0x08      */
  volatile uint32_t PUPDR;    /*!< GPIO port pull-up/pull-down register,  Address offset: 0x0C      */
  volatile uint32_t IDR;      /*!< GPIO port input data register,         Address offset: 0x10      */
  volatile uint32_t ODR;      /*!< GPIO port output data register,        Address offset: 0x14      */
  volatile uint32_t BSRR;     /*!< GPIO port bit set/reset register,      Address offset: 0x18      */
  volatile uint32_t LCKR;     /*!< GPIO port configuration lock register, Address offset: 0x1C      */
  volatile uint32_t AFR[2];   /*!< GPIO alternate function registers,     Address offset: 0x20-0x24 */
} GPIO_TypeDef;

/**
  * @brief System configuration controller
  */

typedef struct
{
  volatile uint32_t MEMRMP;       /*!< SYSCFG memory remap register,                      Address offset: 0x00      */
  volatile uint32_t PMC;          /*!< SYSCFG peripheral mode configuration register,     Address offset: 0x04      */
  volatile uint32_t EXTICR[4];    /*!< SYSCFG external interrupt configuration registers, Address offset: 0x08-0x14 */
  uint32_t      RESERVED[2];  /*!< Reserved, 0x18-0x1C                                                          */
  volatile uint32_t CMPCR;        /*!< SYSCFG Compensation cell control register,         Address offset: 0x20      */
} SYSCFG_TypeDef;

/**
  * @brief Inter-integrated Circuit Interface
  */

typedef struct
{
  volatile uint32_t CR1;        /*!< I2C Control register 1,     Address offset: 0x00 */
  volatile uint32_t CR2;        /*!< I2C Control register 2,     Address offset: 0x04 */
  volatile uint32_t OAR1;       /*!< I2C Own address register 1, Address offset: 0x08 */
  volatile uint32_t OAR2;       /*!< I2C Own address register 2, Address offset: 0x0C */
  volatile uint32_t DR;         /*!< I2C Data register,          Address offset: 0x10 */
  volatile uint32_t SR1;        /*!< I2C Status register 1,      Address offset: 0x14 */
  volatile uint32_t SR2;        /*!< I2C Status register 2,      Address offset: 0x18 */
  volatile uint32_t CCR;        /*!< I2C Clock control register, Address offset: 0x1C */
  volatile uint32_t TRISE;      /*!< I2C TRISE register,         Address offset: 0x20 */
  volatile uint32_t FLTR;       /*!< I2C FLTR register,          Address offset: 0x24 */
} I2C_TypeDef;

/**
  * @brief Independent WATCHDOG
  */

typedef struct
{
  volatile uint32_t KR;   /*!< IWDG Key register,       Address offset: 0x00 */
  volatile uint32_t PR;   /*!< IWDG Prescaler register, Address offset: 0x04 */
  volatile uint32_t RLR;  /*!< IWDG Reload register,    Address offset: 0x08 */
  volatile uint32_t SR;   /*!< IWDG Status register,    Address offset: 0x0C */
} IWDG_TypeDef;


/**
  * @brief Power Control
  */

typedef struct
{
  volatile uint32_t CR;   /*!< PWR power control register,        Address offset: 0x00 */
  volatile uint32_t CSR;  /*!< PWR power control/status register, Address offset: 0x04 */
} PWR_TypeDef;

/**
  * @brief Reset and Clock Control
  */

typedef struct
{
  volatile uint32_t CR;            /*!< RCC clock control register,                                  Address offset: 0x00 */
  volatile uint32_t PLLCFGR;       /*!< RCC PLL configuration register,                              Address offset: 0x04 */
  volatile uint32_t CFGR;          /*!< RCC clock configuration register,                            Address offset: 0x08 */
  volatile uint32_t CIR;           /*!< RCC clock interrupt register,                                Address offset: 0x0C */
  volatile uint32_t AHB1RSTR;      /*!< RCC AHB1 peripheral reset register,                          Address offset: 0x10 */
  volatile uint32_t AHB2RSTR;      /*!< RCC AHB2 peripheral reset register,                          Address offset: 0x14 */
  volatile uint32_t AHB3RSTR;      /*!< RCC AHB3 peripheral reset register,                          Address offset: 0x18 */
  uint32_t      RESERVED0;     /*!< Reserved, 0x1C                                                                    */
  volatile uint32_t APB1RSTR;      /*!< RCC APB1 peripheral reset register,                          Address offset: 0x20 */
  volatile uint32_t APB2RSTR;      /*!< RCC APB2 peripheral reset register,                          Address offset: 0x24 */
  uint32_t      RESERVED1[2];  /*!< Reserved, 0x28-0x2C                                                               */
  volatile uint32_t AHB1ENR;       /*!< RCC AHB1 peripheral clock register,                          Address offset: 0x30 */
  volatile uint32_t AHB2ENR;       /*!< RCC AHB2 peripheral clock register,                          Address offset: 0x34 */
  volatile uint32_t AHB3ENR;       /*!< RCC AHB3 peripheral clock register,                          Address offset: 0x38 */
  uint32_t      RESERVED2;     /*!< Reserved, 0x3C                                                                    */
  volatile uint32_t APB1ENR;       /*!< RCC APB1 peripheral clock enable register,                   Address offset: 0x40 */
  volatile uint32_t APB2ENR;       /*!< RCC APB2 peripheral clock enable register,                   Address offset: 0x44 */
  uint32_t      RESERVED3[2];  /*!< Reserved, 0x48-0x4C                                                               */
  volatile uint32_t AHB1LPENR;     /*!< RCC AHB1 peripheral clock enable in low power mode register, Address offset: 0x50 */
  volatile uint32_t AHB2LPENR;     /*!< RCC AHB2 peripheral clock enable in low power mode register, Address offset: 0x54 */
  volatile uint32_t AHB3LPENR;     /*!< RCC AHB3 peripheral clock enable in low power mode register, Address offset: 0x58 */
  uint32_t      RESERVED4;     /*!< Reserved, 0x5C                                                                    */
  volatile uint32_t APB1LPENR;     /*!< RCC APB1 peripheral clock enable in low power mode register, Address offset: 0x60 */
  volatile uint32_t APB2LPENR;     /*!< RCC APB2 peripheral clock enable in low power mode register, Address offset: 0x64 */
  uint32_t      RESERVED5[2];  /*!< Reserved, 0x68-0x6C                                                               */
  volatile uint32_t BDCR;          /*!< RCC Backup domain control register,                          Address offset: 0x70 */
  volatile uint32_t CSR;           /*!< RCC clock control & status register,                         Address offset: 0x74 */
  uint32_t      RESERVED6[2];  /*!< Reserved, 0x78-0x7C                                                               */
  volatile uint32_t SSCGR;         /*!< RCC spread spectrum clock generation register,               Address offset: 0x80 */
  volatile uint32_t PLLI2SCFGR;    /*!< RCC PLLI2S configuration register,                           Address offset: 0x84 */
  uint32_t      RESERVED7[1];  /*!< Reserved, 0x88                                                                    */
  volatile uint32_t DCKCFGR;       /*!< RCC Dedicated Clocks configuration register,                 Address offset: 0x8C */
} RCC_TypeDef;

/**
  * @brief Real-Time Clock
  */

typedef struct
{
  volatile uint32_t TR;      /*!< RTC time register,                                        Address offset: 0x00 */
  volatile uint32_t DR;      /*!< RTC date register,                                        Address offset: 0x04 */
  volatile uint32_t CR;      /*!< RTC control register,                                     Address offset: 0x08 */
  volatile uint32_t ISR;     /*!< RTC initialization and status register,                   Address offset: 0x0C */
  volatile uint32_t PRER;    /*!< RTC prescaler register,                                   Address offset: 0x10 */
  volatile uint32_t WUTR;    /*!< RTC wakeup timer register,                                Address offset: 0x14 */
  volatile uint32_t CALIBR;  /*!< RTC calibration register,                                 Address offset: 0x18 */
  volatile uint32_t ALRMAR;  /*!< RTC alarm A register,                                     Address offset: 0x1C */
  volatile uint32_t ALRMBR;  /*!< RTC alarm B register,                                     Address offset: 0x20 */
  volatile uint32_t WPR;     /*!< RTC write protection register,                            Address offset: 0x24 */
  volatile uint32_t SSR;     /*!< RTC sub second register,                                  Address offset: 0x28 */
  volatile uint32_t SHIFTR;  /*!< RTC shift control register,                               Address offset: 0x2C */
  volatile uint32_t TSTR;    /*!< RTC time stamp time register,                             Address offset: 0x30 */
  volatile uint32_t TSDR;    /*!< RTC time stamp date register,                             Address offset: 0x34 */
  volatile uint32_t TSSSR;   /*!< RTC time-stamp sub second register,                       Address offset: 0x38 */
  volatile uint32_t CALR;    /*!< RTC calibration register,                                 Address offset: 0x3C */
  volatile uint32_t TAFCR;   /*!< RTC tamper and alternate function configuration register, Address offset: 0x40 */
  volatile uint32_t ALRMASSR;/*!< RTC alarm A sub second register,                          Address offset: 0x44 */
  volatile uint32_t ALRMBSSR;/*!< RTC alarm B sub second register,                          Address offset: 0x48 */
  uint32_t RESERVED7;    /*!< Reserved, 0x4C                                                                 */
  volatile uint32_t BKP0R;   /*!< RTC backup register 1,                                    Address offset: 0x50 */
  volatile uint32_t BKP1R;   /*!< RTC backup register 1,                                    Address offset: 0x54 */
  volatile uint32_t BKP2R;   /*!< RTC backup register 2,                                    Address offset: 0x58 */
  volatile uint32_t BKP3R;   /*!< RTC backup register 3,                                    Address offset: 0x5C */
  volatile uint32_t BKP4R;   /*!< RTC backup register 4,                                    Address offset: 0x60 */
  volatile uint32_t BKP5R;   /*!< RTC backup register 5,                                    Address offset: 0x64 */
  volatile uint32_t BKP6R;   /*!< RTC backup register 6,                                    Address offset: 0x68 */
  volatile uint32_t BKP7R;   /*!< RTC backup register 7,                                    Address offset: 0x6C */
  volatile uint32_t BKP8R;   /*!< RTC backup register 8,                                    Address offset: 0x70 */
  volatile uint32_t BKP9R;   /*!< RTC backup register 9,                                    Address offset: 0x74 */
  volatile uint32_t BKP10R;  /*!< RTC backup register 10,                                   Address offset: 0x78 */
  volatile uint32_t BKP11R;  /*!< RTC backup register 11,                                   Address offset: 0x7C */
  volatile uint32_t BKP12R;  /*!< RTC backup register 12,                                   Address offset: 0x80 */
  volatile uint32_t BKP13R;  /*!< RTC backup register 13,                                   Address offset: 0x84 */
  volatile uint32_t BKP14R;  /*!< RTC backup register 14,                                   Address offset: 0x88 */
  volatile uint32_t BKP15R;  /*!< RTC backup register 15,                                   Address offset: 0x8C */
  volatile uint32_t BKP16R;  /*!< RTC backup register 16,                                   Address offset: 0x90 */
  volatile uint32_t BKP17R;  /*!< RTC backup register 17,                                   Address offset: 0x94 */
  volatile uint32_t BKP18R;  /*!< RTC backup register 18,                                   Address offset: 0x98 */
  volatile uint32_t BKP19R;  /*!< RTC backup register 19,                                   Address offset: 0x9C */
} RTC_TypeDef;

/**
  * @brief SD host Interface
  */

typedef struct
{
  volatile uint32_t POWER;                 /*!< SDIO power control register,    Address offset: 0x00 */
  volatile uint32_t CLKCR;                 /*!< SDI clock control register,     Address offset: 0x04 */
  volatile uint32_t ARG;                   /*!< SDIO argument register,         Address offset: 0x08 */
  volatile uint32_t CMD;                   /*!< SDIO command register,          Address offset: 0x0C */
  volatile const uint32_t  RESPCMD;        /*!< SDIO command response register, Address offset: 0x10 */
  volatile const uint32_t  RESP1;          /*!< SDIO response 1 register,       Address offset: 0x14 */
  volatile const uint32_t  RESP2;          /*!< SDIO response 2 register,       Address offset: 0x18 */
  volatile const uint32_t  RESP3;          /*!< SDIO response 3 register,       Address offset: 0x1C */
  volatile const uint32_t  RESP4;          /*!< SDIO response 4 register,       Address offset: 0x20 */
  volatile uint32_t DTIMER;                /*!< SDIO data timer register,       Address offset: 0x24 */
  volatile uint32_t DLEN;                  /*!< SDIO data length register,      Address offset: 0x28 */
  volatile uint32_t DCTRL;                 /*!< SDIO data control register,     Address offset: 0x2C */
  volatile const uint32_t  DCOUNT;         /*!< SDIO data counter register,     Address offset: 0x30 */
  volatile const uint32_t  STA;            /*!< SDIO status register,           Address offset: 0x34 */
  volatile uint32_t ICR;                   /*!< SDIO interrupt clear register,  Address offset: 0x38 */
  volatile uint32_t MASK;                  /*!< SDIO mask register,             Address offset: 0x3C */
  uint32_t      RESERVED0[2];          /*!< Reserved, 0x40-0x44                                  */
  volatile const uint32_t  FIFOCNT;        /*!< SDIO FIFO counter register,     Address offset: 0x48 */
  uint32_t      RESERVED1[13];         /*!< Reserved, 0x4C-0x7C                                  */
  volatile uint32_t FIFO;                  /*!< SDIO data FIFO register,        Address offset: 0x80 */
} SDIO_TypeDef;

/**
  * @brief Serial Peripheral Interface
  */

typedef struct
{
  volatile uint32_t CR1;        /*!< SPI control register 1 (not used in I2S mode),      Address offset: 0x00 */
  volatile uint32_t CR2;        /*!< SPI control register 2,                             Address offset: 0x04 */
  volatile uint32_t SR;         /*!< SPI status register,                                Address offset: 0x08 */
  volatile uint32_t DR;         /*!< SPI data register,                                  Address offset: 0x0C */
  volatile uint32_t CRCPR;      /*!< SPI CRC polynomial register (not used in I2S mode), Address offset: 0x10 */
  volatile uint32_t RXCRCR;     /*!< SPI RX CRC register (not used in I2S mode),         Address offset: 0x14 */
  volatile uint32_t TXCRCR;     /*!< SPI TX CRC register (not used in I2S mode),         Address offset: 0x18 */
  volatile uint32_t I2SCFGR;    /*!< SPI_I2S configuration register,                     Address offset: 0x1C */
  volatile uint32_t I2SPR;      /*!< SPI_I2S prescaler register,                         Address offset: 0x20 */
} SPI_TypeDef;


/**
  * @brief TIM
  */

typedef struct
{
  volatile uint32_t CR1;         /*!< TIM control register 1,              Address offset: 0x00 */
  volatile uint32_t CR2;         /*!< TIM control register 2,              Address offset: 0x04 */
  volatile uint32_t SMCR;        /*!< TIM slave mode control register,     Address offset: 0x08 */
  volatile uint32_t DIER;        /*!< TIM DMA/interrupt enable register,   Address offset: 0x0C */
  volatile uint32_t SR;          /*!< TIM status register,                 Address offset: 0x10 */
  volatile uint32_t EGR;         /*!< TIM event generation register,       Address offset: 0x14 */
  volatile uint32_t CCMR1;       /*!< TIM capture/compare mode register 1, Address offset: 0x18 */
  volatile uint32_t CCMR2;       /*!< TIM capture/compare mode register 2, Address offset: 0x1C */
  volatile uint32_t CCER;        /*!< TIM capture/compare enable register, Address offset: 0x20 */
  volatile uint32_t CNT;         /*!< TIM counter register,                Address offset: 0x24 */
  volatile uint32_t PSC;         /*!< TIM prescaler,                       Address offset: 0x28 */
  volatile uint32_t ARR;         /*!< TIM auto-reload register,            Address offset: 0x2C */
  volatile uint32_t RCR;         /*!< TIM repetition counter register,     Address offset: 0x30 */
  volatile uint32_t CCR1;        /*!< TIM capture/compare register 1,      Address offset: 0x34 */
  volatile uint32_t CCR2;        /*!< TIM capture/compare register 2,      Address offset: 0x38 */
  volatile uint32_t CCR3;        /*!< TIM capture/compare register 3,      Address offset: 0x3C */
  volatile uint32_t CCR4;        /*!< TIM capture/compare register 4,      Address offset: 0x40 */
  volatile uint32_t BDTR;        /*!< TIM break and dead-time register,    Address offset: 0x44 */
  volatile uint32_t DCR;         /*!< TIM DMA control register,            Address offset: 0x48 */
  volatile uint32_t DMAR;        /*!< TIM DMA address for full transfer,   Address offset: 0x4C */
  volatile uint32_t OR;          /*!< TIM option register,                 Address offset: 0x50 */
} TIM_TypeDef;

/**
  * @brief Universal Synchronous Asynchronous Receiver Transmitter
  */

typedef struct
{
  volatile uint32_t SR;         /*!< USART Status register,                   Address offset: 0x00 */
  volatile uint32_t DR;         /*!< USART Data register,                     Address offset: 0x04 */
  volatile uint32_t BRR;        /*!< USART Baud rate register,                Address offset: 0x08 */
  volatile uint32_t CR1;        /*!< USART Control register 1,                Address offset: 0x0C */
  volatile uint32_t CR2;        /*!< USART Control register 2,                Address offset: 0x10 */
  volatile uint32_t CR3;        /*!< USART Control register 3,                Address offset: 0x14 */
  volatile uint32_t GTPR;       /*!< USART Guard time and prescaler register, Address offset: 0x18 */
} USART_TypeDef;

/**
  * @brief Window WATCHDOG
  */

typedef struct
{
  volatile uint32_t CR;   /*!< WWDG Control register,       Address offset: 0x00 */
  volatile uint32_t CFR;  /*!< WWDG Configuration register, Address offset: 0x04 */
  volatile uint32_t SR;   /*!< WWDG Status register,        Address offset: 0x08 */
} WWDG_TypeDef;
/**
  * @brief USB_OTG_Core_Registers
  */
typedef struct
{
  volatile uint32_t GOTGCTL;              /*!< USB_OTG Control and Status Register          000h */
  volatile uint32_t GOTGINT;              /*!< USB_OTG Interrupt Register                   004h */
  volatile uint32_t GAHBCFG;              /*!< Core AHB Configuration Register              008h */
  volatile uint32_t GUSBCFG;              /*!< Core USB Configuration Register              00Ch */
  volatile uint32_t GRSTCTL;              /*!< Core Reset Register                          010h */
  volatile uint32_t GINTSTS;              /*!< Core Interrupt Register                      014h */
  volatile uint32_t GINTMSK;              /*!< Core Interrupt Mask Register                 018h */
  volatile uint32_t GRXSTSR;              /*!< Receive Sts Q Read Register                  01Ch */
  volatile uint32_t GRXSTSP;              /*!< Receive Sts Q Read & POP Register            020h */
  volatile uint32_t GRXFSIZ;              /*!< Receive FIFO Size Register                   024h */
  volatile uint32_t DIEPTXF0_HNPTXFSIZ;   /*!< EP0 / Non Periodic Tx FIFO Size Register     028h */
  volatile uint32_t HNPTXSTS;             /*!< Non Periodic Tx FIFO/Queue Sts reg           02Ch */
  uint32_t Reserved30[2];             /*!< Reserved                                     030h */
  volatile uint32_t GCCFG;                /*!< General Purpose IO Register                  038h */
  volatile uint32_t CID;                  /*!< User ID Register                             03Ch */
  uint32_t  Reserved40[48];           /*!< Reserved                                0x40-0xFF */
  volatile uint32_t HPTXFSIZ;             /*!< Host Periodic Tx FIFO Size Reg               100h */
  volatile uint32_t DIEPTXF[0x0F];        /*!< dev Periodic Transmit FIFO                        */
} USB_OTG_GlobalTypeDef;

/**
  * @brief USB_OTG_device_Registers
  */
typedef struct
{
  volatile uint32_t DCFG;            /*!< dev Configuration Register   800h */
  volatile uint32_t DCTL;            /*!< dev Control Register         804h */
  volatile uint32_t DSTS;            /*!< dev Status Register (RO)     808h */
  uint32_t Reserved0C;           /*!< Reserved                     80Ch */
  volatile uint32_t DIEPMSK;         /*!< dev IN Endpoint Mask         810h */
  volatile uint32_t DOEPMSK;         /*!< dev OUT Endpoint Mask        814h */
  volatile uint32_t DAINT;           /*!< dev All Endpoints Itr Reg    818h */
  volatile uint32_t DAINTMSK;        /*!< dev All Endpoints Itr Mask   81Ch */
  uint32_t  Reserved20;          /*!< Reserved                     820h */
  uint32_t Reserved9;            /*!< Reserved                     824h */
  volatile uint32_t DVBUSDIS;        /*!< dev VBUS discharge Register  828h */
  volatile uint32_t DVBUSPULSE;      /*!< dev VBUS Pulse Register      82Ch */
  volatile uint32_t DTHRCTL;         /*!< dev threshold                830h */
  volatile uint32_t DIEPEMPMSK;      /*!< dev empty msk                834h */
  volatile uint32_t DEACHINT;        /*!< dedicated EP interrupt       838h */
  volatile uint32_t DEACHMSK;        /*!< dedicated EP msk             83Ch */
  uint32_t Reserved40;           /*!< dedicated EP mask            840h */
  volatile uint32_t DINEP1MSK;       /*!< dedicated EP mask            844h */
  uint32_t  Reserved44[15];      /*!< Reserved                 844-87Ch */
  volatile uint32_t DOUTEP1MSK;      /*!< dedicated EP msk             884h */
} USB_OTG_DeviceTypeDef;

/**
  * @brief USB_OTG_IN_Endpoint-Specific_Register
  */
typedef struct
{
  volatile uint32_t DIEPCTL;           /*!< dev IN Endpoint Control Reg    900h + (ep_num * 20h) + 00h */
  uint32_t Reserved04;             /*!< Reserved                       900h + (ep_num * 20h) + 04h */
  volatile uint32_t DIEPINT;           /*!< dev IN Endpoint Itr Reg        900h + (ep_num * 20h) + 08h */
  uint32_t Reserved0C;             /*!< Reserved                       900h + (ep_num * 20h) + 0Ch */
  volatile uint32_t DIEPTSIZ;          /*!< IN Endpoint Txfer Size         900h + (ep_num * 20h) + 10h */
  volatile uint32_t DIEPDMA;           /*!< IN Endpoint DMA Address Reg    900h + (ep_num * 20h) + 14h */
  volatile uint32_t DTXFSTS;           /*!< IN Endpoint Tx FIFO Status Reg 900h + (ep_num * 20h) + 18h */
  uint32_t Reserved18;             /*!< Reserved  900h+(ep_num*20h)+1Ch-900h+ (ep_num * 20h) + 1Ch */
} USB_OTG_INEndpointTypeDef;

/**
  * @brief USB_OTG_OUT_Endpoint-Specific_Registers
  */
typedef struct
{
  volatile uint32_t DOEPCTL;       /*!< dev OUT Endpoint Control Reg           B00h + (ep_num * 20h) + 00h */
  uint32_t Reserved04;         /*!< Reserved                               B00h + (ep_num * 20h) + 04h */
  volatile uint32_t DOEPINT;       /*!< dev OUT Endpoint Itr Reg               B00h + (ep_num * 20h) + 08h */
  uint32_t Reserved0C;         /*!< Reserved                               B00h + (ep_num * 20h) + 0Ch */
  volatile uint32_t DOEPTSIZ;      /*!< dev OUT Endpoint Txfer Size            B00h + (ep_num * 20h) + 10h */
  volatile uint32_t DOEPDMA;       /*!< dev OUT Endpoint DMA Address           B00h + (ep_num * 20h) + 14h */
  uint32_t Reserved18[2];      /*!< Reserved B00h + (ep_num * 20h) + 18h - B00h + (ep_num * 20h) + 1Ch */
} USB_OTG_OUTEndpointTypeDef;

/**
  * @brief USB_OTG_Host_Mode_Register_Structures
  */
typedef struct
{
  volatile uint32_t HCFG;             /*!< Host Configuration Register          400h */
  volatile uint32_t HFIR;             /*!< Host Frame Interval Register         404h */
  volatile uint32_t HFNUM;            /*!< Host Frame Nbr/Frame Remaining       408h */
  uint32_t Reserved40C;           /*!< Reserved                             40Ch */
  volatile uint32_t HPTXSTS;          /*!< Host Periodic Tx FIFO/ Queue Status  410h */
  volatile uint32_t HAINT;            /*!< Host All Channels Interrupt Register 414h */
  volatile uint32_t HAINTMSK;         /*!< Host All Channels Interrupt Mask     418h */
} USB_OTG_HostTypeDef;

/**
  * @brief USB_OTG_Host_Channel_Specific_Registers
  */
typedef struct
{
  volatile uint32_t HCCHAR;           /*!< Host Channel Characteristics Register    500h */
  volatile uint32_t HCSPLT;           /*!< Host Channel Split Control Register      504h */
  volatile uint32_t HCINT;            /*!< Host Channel Interrupt Register          508h */
  volatile uint32_t HCINTMSK;         /*!< Host Channel Interrupt Mask Register     50Ch */
  volatile uint32_t HCTSIZ;           /*!< Host Channel Transfer Size Register      510h */
  volatile uint32_t HCDMA;            /*!< Host Channel DMA Address Register        514h */
  uint32_t Reserved[2];           /*!< Reserved                                      */
} USB_OTG_HostChannelTypeDef;

/**
  * @}
  */

/** @addtogroup Peripheral_memory_map
  * @{
  */










/* Legacy defines */



/*!< Peripheral memory map */





/*!< APB1 peripherals */

















/*!< APB2 peripherals */





/* Legacy define */










/*!< AHB1 peripherals */





























/*!< Debug MCU registers base address */

/*!< USB registers base address */


















/**
  * @}
  */

/** @addtogroup Peripheral_declaration
  * @{
  */





















/* Legacy define */







































/**
  * @}
  */

/** @addtogroup Exported_constants
  * @{
  */

/** @addtogroup Hardware_Constant_Definition
  * @{
  */

/**
  * @}
  */

/** @addtogroup Peripheral_Registers_Bits_Definition
* @{
*/

/******************************************************************************/
/*                         Peripheral Registers_Bits_Definition               */
/******************************************************************************/

/******************************************************************************/
/*                                                                            */
/*                        Analog to Digital Converter                         */
/*                                                                            */
/******************************************************************************/

/********************  Bit definition for ADC_SR register  ********************/



















/*******************  Bit definition for ADC_CR1 register  ********************/





















































/*******************  Bit definition for ADC_CR2 register  ********************/

















































/******************  Bit definition for ADC_SMPR1 register  *******************/























































/******************  Bit definition for ADC_SMPR2 register  *******************/





























































/******************  Bit definition for ADC_JOFR1 register  *******************/




/******************  Bit definition for ADC_JOFR2 register  *******************/




/******************  Bit definition for ADC_JOFR3 register  *******************/




/******************  Bit definition for ADC_JOFR4 register  *******************/




/*******************  Bit definition for ADC_HTR register  ********************/




/*******************  Bit definition for ADC_LTR register  ********************/




/*******************  Bit definition for ADC_SQR1 register  *******************/








































/*******************  Bit definition for ADC_SQR2 register  *******************/

















































/*******************  Bit definition for ADC_SQR3 register  *******************/

















































/*******************  Bit definition for ADC_JSQR register  *******************/






































/*******************  Bit definition for ADC_JDR1 register  *******************/




/*******************  Bit definition for ADC_JDR2 register  *******************/




/*******************  Bit definition for ADC_JDR3 register  *******************/




/*******************  Bit definition for ADC_JDR4 register  *******************/




/********************  Bit definition for ADC_DR register  ********************/







/*******************  Bit definition for ADC_CSR register  ********************/



















/* Legacy defines */


/*******************  Bit definition for ADC_CCR register  ********************/



































/*******************  Bit definition for ADC_CDR register  ********************/







/* Legacy defines */



/******************************************************************************/
/*                                                                            */
/*                          CRC calculation unit                              */
/*                                                                            */
/******************************************************************************/
/*******************  Bit definition for CRC_DR register  *********************/





/*******************  Bit definition for CRC_IDR register  ********************/





/********************  Bit definition for CRC_CR register  ********************/





/******************************************************************************/
/*                                                                            */
/*                             DMA Controller                                 */
/*                                                                            */
/******************************************************************************/
/********************  Bits definition for DMA_SxCR register  *****************/









































































/* Legacy defines */




/********************  Bits definition for DMA_SxCNDTR register  **************/




















/********************  Bits definition for DMA_SxFCR register  ****************/


















/********************  Bits definition for DMA_LISR register  *****************/





























































/********************  Bits definition for DMA_HISR register  *****************/





























































/********************  Bits definition for DMA_LIFCR register  ****************/





























































/********************  Bits definition for DMA_HIFCR  register  ****************/





























































/******************  Bit definition for DMA_SxPAR register  ********************/




/******************  Bit definition for DMA_SxM0AR register  ********************/




/******************  Bit definition for DMA_SxM1AR register  ********************/





/******************************************************************************/
/*                                                                            */
/*                    External Interrupt/Event Controller                     */
/*                                                                            */
/******************************************************************************/
/*******************  Bit definition for EXTI_IMR register  *******************/






































































/* Reference Defines */



























/*******************  Bit definition for EXTI_EMR register  *******************/






































































/* Reference Defines */
























/******************  Bit definition for EXTI_RTSR register  *******************/






































































/******************  Bit definition for EXTI_FTSR register  *******************/






































































/******************  Bit definition for EXTI_SWIER register  ******************/






































































/*******************  Bit definition for EXTI_PR register  ********************/






































































/******************************************************************************/
/*                                                                            */
/*                                    FLASH                                   */
/*                                                                            */
/******************************************************************************/
/*******************  Bits definition for FLASH_ACR register  *****************/





























/*******************  Bits definition for FLASH_SR register  ******************/

























/*******************  Bits definition for FLASH_CR register  ******************/



































/*******************  Bits definition for FLASH_OPTCR register  ***************/
















































/******************  Bits definition for FLASH_OPTCR1 register  ***************/















/* Legacy defines */










/******************************************************************************/
/*                                                                            */
/*                            General Purpose I/O                             */
/*                                                                            */
/******************************************************************************/
/******************  Bits definition for GPIO_MODER register  *****************/

















































































/* Legacy defines */

















































































/******************  Bits definition for GPIO_OTYPER register  ****************/

















































/* Legacy defines */

















/******************  Bits definition for GPIO_OSPEEDR register  ***************/

















































































/* Legacy defines */

















































/******************  Bits definition for GPIO_PUPDR register  *****************/

















































































/* Legacy defines */

















































/******************  Bits definition for GPIO_IDR register  *******************/

















































/* Legacy defines */

















/******************  Bits definition for GPIO_ODR register  *******************/
















































/* Legacy defines */

















/******************  Bits definition for GPIO_BSRR register  ******************/

































































































/* Legacy defines */
















































































/****************** Bit definition for GPIO_LCKR register *********************/



















































/****************** Bit definition for GPIO_AFRL register *********************/

























































/* Legacy defines */









































/****************** Bit definition for GPIO_AFRH register *********************/

























































/* Legacy defines */










































/******************************************************************************/
/*                                                                            */
/*                      Inter-integrated Circuit Interface                    */
/*                                                                            */
/******************************************************************************/
/*******************  Bit definition for I2C_CR1 register  ********************/











































/*******************  Bit definition for I2C_CR2 register  ********************/


























/*******************  Bit definition for I2C_OAR1 register  *******************/






































/*******************  Bit definition for I2C_OAR2 register  *******************/







/********************  Bit definition for I2C_DR register  ********************/




/*******************  Bit definition for I2C_SR1 register  ********************/











































/*******************  Bit definition for I2C_SR2 register  ********************/

























/*******************  Bit definition for I2C_CCR register  ********************/










/******************  Bit definition for I2C_TRISE register  *******************/




/******************  Bit definition for I2C_FLTR register  *******************/







/******************************************************************************/
/*                                                                            */
/*                           Independent WATCHDOG                             */
/*                                                                            */
/******************************************************************************/
/*******************  Bit definition for IWDG_KR register  ********************/




/*******************  Bit definition for IWDG_PR register  ********************/







/*******************  Bit definition for IWDG_RLR register  *******************/




/*******************  Bit definition for IWDG_SR register  ********************/









/******************************************************************************/
/*                                                                            */
/*                             Power Control                                  */
/*                                                                            */
/******************************************************************************/
/********************  Bit definition for PWR_CR register  ********************/























/*!< PVD level configuration */





























/* Legacy define */


/*******************  Bit definition for PWR_CSR register  ********************/






















/* Legacy define */


/******************************************************************************/
/*                                                                            */
/*                         Reset and Clock Control                            */
/*                                                                            */
/******************************************************************************/
/********************  Bit definition for RCC_CR register  ********************/














































/*
 * @brief Specific device feature definitions (not present on all devices in the STM32F4 series)
 */









/********************  Bit definition for RCC_PLLCFGR register  ***************/














































/********************  Bit definition for RCC_CFGR register  ******************/
/*!< SW configuration */










/*!< SWS configuration */










/*!< HPRE configuration */


















/*!< PPRE1 configuration */













/*!< PPRE2 configuration */













/*!< RTCPRE configuration */









/*!< MCO1 configuration */






























/********************  Bit definition for RCC_CIR register  *******************/
































































/********************  Bit definition for RCC_AHB1RSTR register  **************/




























/********************  Bit definition for RCC_AHB2RSTR register  **************/



/********************  Bit definition for RCC_AHB3RSTR register  **************/


/********************  Bit definition for RCC_APB1RSTR register  **************/





































/********************  Bit definition for RCC_APB2RSTR register  **************/


































/* Old SPI1RST bit definition, maintained for legacy purpose */


/********************  Bit definition for RCC_AHB1ENR register  ***************/



























/********************  Bit definition for RCC_AHB2ENR register  ***************/
/*
 * @brief Specific device feature definitions (not present on all devices in the STM32F4 series)
 */






/********************  Bit definition for RCC_APB1ENR register  ***************/





































/********************  Bit definition for RCC_APB2ENR register  ***************/


































/********************  Bit definition for RCC_AHB1LPENR register  *************/



































/********************  Bit definition for RCC_AHB2LPENR register  *************/




/********************  Bit definition for RCC_AHB3LPENR register  *************/

/********************  Bit definition for RCC_APB1LPENR register  *************/





































/********************  Bit definition for RCC_APB2LPENR register  *************/


































/********************  Bit definition for RCC_BDCR register  ******************/























/********************  Bit definition for RCC_CSR register  *******************/






























/* Legacy defines */



/********************  Bit definition for RCC_SSCGR register  *****************/













/********************  Bit definition for RCC_PLLI2SCFGR register  ************/




















/********************  Bit definition for RCC_DCKCFGR register  ***************/






/******************************************************************************/
/*                                                                            */
/*                           Real-Time Clock (RTC)                            */
/*                                                                            */
/******************************************************************************/
/********************  Bits definition for RTC_TR register  *******************/










































/********************  Bits definition for RTC_DR register  *******************/











































/********************  Bits definition for RTC_CR register  *******************/





































































/* Legacy defines */


/********************  Bits definition for RTC_ISR register  ******************/

















































/********************  Bits definition for RTC_PRER register  *****************/







/********************  Bits definition for RTC_WUTR register  *****************/




/********************  Bits definition for RTC_CALIBR register  ***************/







/********************  Bits definition for RTC_ALRMAR register  ***************/





































































/********************  Bits definition for RTC_ALRMBR register  ***************/





































































/********************  Bits definition for RTC_WPR register  ******************/




/********************  Bits definition for RTC_SSR register  ******************/




/********************  Bits definition for RTC_SHIFTR register  ***************/







/********************  Bits definition for RTC_TSTR register  *****************/










































/********************  Bits definition for RTC_TSDR register  *****************/





























/********************  Bits definition for RTC_TSSSR register  ****************/




/********************  Bits definition for RTC_CAL register  *****************/






















/********************  Bits definition for RTC_TAFCR register  ****************/















































/* Legacy defines */


/********************  Bits definition for RTC_ALRMASSR register  *************/











/********************  Bits definition for RTC_ALRMBSSR register  *************/











/********************  Bits definition for RTC_BKP0R register  ****************/




/********************  Bits definition for RTC_BKP1R register  ****************/




/********************  Bits definition for RTC_BKP2R register  ****************/




/********************  Bits definition for RTC_BKP3R register  ****************/




/********************  Bits definition for RTC_BKP4R register  ****************/




/********************  Bits definition for RTC_BKP5R register  ****************/




/********************  Bits definition for RTC_BKP6R register  ****************/




/********************  Bits definition for RTC_BKP7R register  ****************/




/********************  Bits definition for RTC_BKP8R register  ****************/




/********************  Bits definition for RTC_BKP9R register  ****************/




/********************  Bits definition for RTC_BKP10R register  ***************/




/********************  Bits definition for RTC_BKP11R register  ***************/




/********************  Bits definition for RTC_BKP12R register  ***************/




/********************  Bits definition for RTC_BKP13R register  ***************/




/********************  Bits definition for RTC_BKP14R register  ***************/




/********************  Bits definition for RTC_BKP15R register  ***************/




/********************  Bits definition for RTC_BKP16R register  ***************/




/********************  Bits definition for RTC_BKP17R register  ***************/




/********************  Bits definition for RTC_BKP18R register  ***************/




/********************  Bits definition for RTC_BKP19R register  ***************/




/******************** Number of backup registers ******************************/



/******************************************************************************/
/*                                                                            */
/*                          SD host Interface                                 */
/*                                                                            */
/******************************************************************************/
/******************  Bit definition for SDIO_POWER register  ******************/






/******************  Bit definition for SDIO_CLKCR register  ******************/


























/*******************  Bit definition for SDIO_ARG register  *******************/




/*******************  Bit definition for SDIO_CMD register  *******************/
































/*****************  Bit definition for SDIO_RESPCMD register  *****************/




/******************  Bit definition for SDIO_RESP0 register  ******************/




/******************  Bit definition for SDIO_RESP1 register  ******************/




/******************  Bit definition for SDIO_RESP2 register  ******************/




/******************  Bit definition for SDIO_RESP3 register  ******************/




/******************  Bit definition for SDIO_RESP4 register  ******************/




/******************  Bit definition for SDIO_DTIMER register  *****************/




/******************  Bit definition for SDIO_DLEN register  *******************/




/******************  Bit definition for SDIO_DCTRL register  ******************/


































/******************  Bit definition for SDIO_DCOUNT register  *****************/




/******************  Bit definition for SDIO_STA register  ********************/









































































/*******************  Bit definition for SDIO_ICR register  *******************/








































/******************  Bit definition for SDIO_MASK register  *******************/









































































/*****************  Bit definition for SDIO_FIFOCNT register  *****************/




/******************  Bit definition for SDIO_FIFO register  *******************/




/******************************************************************************/
/*                                                                            */
/*                        Serial Peripheral Interface                         */
/*                                                                            */
/******************************************************************************/


/*******************  Bit definition for SPI_CR1 register  ********************/
















































/*******************  Bit definition for SPI_CR2 register  ********************/






















/********************  Bit definition for SPI_SR register  ********************/




























/********************  Bit definition for SPI_DR register  ********************/




/*******************  Bit definition for SPI_CRCPR register  ******************/




/******************  Bit definition for SPI_RXCRCR register  ******************/




/******************  Bit definition for SPI_TXCRCR register  ******************/




/******************  Bit definition for SPI_I2SCFGR register  *****************/





































/******************  Bit definition for SPI_I2SPR register  *******************/










/******************************************************************************/
/*                                                                            */
/*                                 SYSCFG                                     */
/*                                                                            */
/******************************************************************************/
/******************  Bit definition for SYSCFG_MEMRMP register  ***************/





/******************  Bit definition for SYSCFG_PMC register  ******************/




/*****************  Bit definition for SYSCFG_EXTICR1 register  ***************/












/**
  * @brief   EXTI0 configuration
  */







/**
  * @brief   EXTI1 configuration
  */







/**
  * @brief   EXTI2 configuration
  */







/**
  * @brief   EXTI3 configuration
  */







/*****************  Bit definition for SYSCFG_EXTICR2 register  ***************/













/**
  * @brief   EXTI4 configuration
  */







/**
  * @brief   EXTI5 configuration
  */







/**
  * @brief   EXTI6 configuration
  */







/**
  * @brief   EXTI7 configuration
  */







/*****************  Bit definition for SYSCFG_EXTICR3 register  ***************/













/**
  * @brief   EXTI8 configuration
  */







/**
  * @brief   EXTI9 configuration
  */







/**
  * @brief   EXTI10 configuration
  */







/**
  * @brief   EXTI11 configuration
  */







/*****************  Bit definition for SYSCFG_EXTICR4 register  ***************/













/**
  * @brief   EXTI12 configuration
  */







/**
  * @brief   EXTI13 configuration
  */







/**
  * @brief   EXTI14 configuration
  */







/**
  * @brief   EXTI15 configuration
  */







/******************  Bit definition for SYSCFG_CMPCR register  ****************/







/******************************************************************************/
/*                                                                            */
/*                                    TIM                                     */
/*                                                                            */
/******************************************************************************/
/*******************  Bit definition for TIM_CR1 register  ********************/
































/*******************  Bit definition for TIM_CR2 register  ********************/










































/*******************  Bit definition for TIM_SMCR register  *******************/







































/*******************  Bit definition for TIM_DIER register  *******************/














































/********************  Bit definition for TIM_SR register  ********************/





































/*******************  Bit definition for TIM_EGR register  ********************/

























/******************  Bit definition for TIM_CCMR1 register  *******************/
















































/*----------------------------------------------------------------------------*/





























/******************  Bit definition for TIM_CCMR2 register  *******************/
















































/*----------------------------------------------------------------------------*/





























/*******************  Bit definition for TIM_CCER register  *******************/














































/*******************  Bit definition for TIM_CNT register  ********************/




/*******************  Bit definition for TIM_PSC register  ********************/




/*******************  Bit definition for TIM_ARR register  ********************/




/*******************  Bit definition for TIM_RCR register  ********************/




/*******************  Bit definition for TIM_CCR1 register  *******************/




/*******************  Bit definition for TIM_CCR2 register  *******************/




/*******************  Bit definition for TIM_CCR3 register  *******************/




/*******************  Bit definition for TIM_CCR4 register  *******************/




/*******************  Bit definition for TIM_BDTR register  *******************/





































/*******************  Bit definition for TIM_DCR register  ********************/


















/*******************  Bit definition for TIM_DMAR register  *******************/




/*******************  Bit definition for TIM_OR register  *********************/


















/******************************************************************************/
/*                                                                            */
/*         Universal Synchronous Asynchronous Receiver Transmitter            */
/*                                                                            */
/******************************************************************************/
/*******************  Bit definition for USART_SR register  *******************/































/*******************  Bit definition for USART_DR register  *******************/




/******************  Bit definition for USART_BRR register  *******************/







/******************  Bit definition for USART_CR1 register  *******************/














































/******************  Bit definition for USART_CR2 register  *******************/
































/******************  Bit definition for USART_CR3 register  *******************/





































/******************  Bit definition for USART_GTPR register  ******************/
















/******************************************************************************/
/*                                                                            */
/*                            Window WATCHDOG                                 */
/*                                                                            */
/******************************************************************************/
/*******************  Bit definition for WWDG_CR register  ********************/










/* Legacy defines */












/*******************  Bit definition for WWDG_CFR register  *******************/










/* Legacy defines */













/* Legacy defines */







/*******************  Bit definition for WWDG_SR register  ********************/





/******************************************************************************/
/*                                                                            */
/*                                DBG                                         */
/*                                                                            */
/******************************************************************************/
/********************  Bit definition for DBGMCU_IDCODE register  *************/







/********************  Bit definition for DBGMCU_CR register  *****************/



















/********************  Bit definition for DBGMCU_APB1_FZ register  ************/






























/* Old IWDGSTOP bit definition, maintained for legacy purpose */


/********************  Bit definition for DBGMCU_APB2_FZ register  ************/













/******************************************************************************/
/*                                                                            */
/*                                       USB_OTG                              */
/*                                                                            */
/******************************************************************************/
/********************  Bit definition for USB_OTG_GOTGCTL register  ***********/































/********************  Bit definition forUSB_OTG_HCFG register  ********************/










/********************  Bit definition for USB_OTG_DCFG register  ********************/









































/********************  Bit definition for USB_OTG_PCGCR register  ********************/










/********************  Bit definition for USB_OTG_GOTGINT register  ********************/



















/********************  Bit definition for USB_OTG_DCTL register  ********************/



































/********************  Bit definition for USB_OTG_HFIR register  ********************/




/********************  Bit definition for USB_OTG_HFNUM register  ********************/







/********************  Bit definition for USB_OTG_DSTS register  ********************/
















/********************  Bit definition for USB_OTG_GAHBCFG register  ********************/





















/********************  Bit definition for USB_OTG_GUSBCFG register  ********************/































































/********************  Bit definition for USB_OTG_GRSTCTL register  ********************/
































/********************  Bit definition for USB_OTG_DIEPMSK register  ********************/

























/********************  Bit definition for USB_OTG_HPTXSTS register  ********************/



























/********************  Bit definition for USB_OTG_HAINT register  ********************/




/********************  Bit definition for USB_OTG_DOEPMSK register  ********************/




































/********************  Bit definition for USB_OTG_GINTSTS register  ********************/















































































/********************  Bit definition for USB_OTG_GINTMSK register  ********************/















































































/********************  Bit definition for USB_OTG_DAINT register  ********************/







/********************  Bit definition for USB_OTG_HAINTMSK register  ********************/




/********************  Bit definition for USB_OTG_GRXSTSP register  ********************/













/********************  Bit definition for USB_OTG_DAINTMSK register  ********************/







/********************  Bit definition for USB_OTG_GRXFSIZ register  ********************/




/********************  Bit definition for USB_OTG_DVBUSDIS register  ********************/




/********************  Bit definition for OTG register  ********************/













/********************  Bit definition forUSB_OTG_DVBUSPULSE register  ********************/




/********************  Bit definition for USB_OTG_GNPTXSTS register  ********************/



























/********************  Bit definition for USB_OTG_DTHRCTL register  ********************/







































/********************  Bit definition for USB_OTG_DIEPEMPMSK register  ********************/




/********************  Bit definition for USB_OTG_DEACHINT register  ********************/







/********************  Bit definition for USB_OTG_GCCFG register  ********************/



















/********************  Bit definition forUSB_OTG_DEACHINTMSK register  ********************/







/********************  Bit definition for USB_OTG_CID register  ********************/




/********************  Bit definition for USB_OTG_DIEPEACHMSK1 register  ********************/




























/********************  Bit definition for USB_OTG_HPRT register  ********************/



















































/********************  Bit definition for USB_OTG_DOEPEACHMSK1 register  ********************/


































/********************  Bit definition for USB_OTG_HPTXFSIZ register  ********************/







/********************  Bit definition for USB_OTG_DIEPCTL register  ********************/
















































/********************  Bit definition for USB_OTG_HCCHAR register  ********************/


















































/********************  Bit definition for USB_OTG_HCSPLT register  ********************/



































/********************  Bit definition for USB_OTG_HCINT register  ********************/


































/********************  Bit definition for USB_OTG_DIEPINT register  ********************/








































/********************  Bit definition forUSB_OTG_HCINTMSK register  ********************/


































/********************  Bit definition for USB_OTG_DIEPTSIZ register  ********************/










/********************  Bit definition for USB_OTG_HCTSIZ register  ********************/















/********************  Bit definition for USB_OTG_DIEPDMA register  ********************/




/********************  Bit definition for USB_OTG_HCDMA register  ********************/




/********************  Bit definition for USB_OTG_DTXFSTS register  ********************/




/********************  Bit definition for USB_OTG_DIEPTXF register  ********************/







/********************  Bit definition for USB_OTG_DOEPCTL register  ********************/








































/********************  Bit definition for USB_OTG_DOEPINT register  ********************/

































/********************  Bit definition for USB_OTG_DOEPTSIZ register  ********************/














/********************  Bit definition for PCGCCTL register  ********************/










/* Legacy define */
/********************  Bit definition for OTG register  ********************/








































/**
  * @}
  */

/**
  * @}
  */

/** @addtogroup Exported_macros
  * @{
  */

/******************************* ADC Instances ********************************/



/******************************* CRC Instances ********************************/



/******************************** DMA Instances *******************************/


/******************************* GPIO Instances *******************************/


/******************************** I2C Instances *******************************/


/******************************* SMBUS Instances ******************************/


/******************************** I2S Instances *******************************/



/*************************** I2S Extended Instances ***************************/

/* Legacy Defines */



/****************************** RTC Instances *********************************/



/******************************** SPI Instances *******************************/



/****************** TIM Instances : All supported instances *******************/



/************* TIM Instances : at least 1 capture/compare channel *************/


/************ TIM Instances : at least 2 capture/compare channels *************/


/************ TIM Instances : at least 3 capture/compare channels *************/


/************ TIM Instances : at least 4 capture/compare channels *************/


/******************** TIM Instances : Advanced-control timers *****************/


/******************* TIM Instances : Timer input XOR function *****************/


/****************** TIM Instances : DMA requests generation (UDE) *************/


/************ TIM Instances : DMA requests generation (CCxDE) *****************/


/************ TIM Instances : DMA requests generation (COMDE) *****************/


/******************** TIM Instances : DMA burst feature ***********************/


/****** TIM Instances : master mode available (TIMx_CR2.MMS available )********/


/*********** TIM Instances : Slave mode available (TIMx_SMCR available )*******/

/********************** TIM Instances : 32 bit Counter ************************/


/***************** TIM Instances : external trigger input available ************/


/****************** TIM Instances : remapping capability **********************/


/******************* TIM Instances : output(s) available **********************/


/************ TIM Instances : complementary output(s) available ***************/


/****************** TIM Instances : supporting counting mode selection ********/


/****************** TIM Instances : supporting clock division *****************/



/****************** TIM Instances : supporting commutation event generation ***/



/****************** TIM Instances : supporting OCxREF clear *******************/


/****** TIM Instances : supporting external clock mode 1 for ETRF input *******/


/****** TIM Instances : supporting external clock mode 2 for ETRF input *******/


/****** TIM Instances : supporting external clock mode 1 for TIX inputs ******/


/********** TIM Instances : supporting internal trigger inputs(ITRX) *********/


/****************** TIM Instances : supporting repetition counter *************/


/****************** TIM Instances : supporting encoder interface **************/

/****************** TIM Instances : supporting Hall sensor interface **********/

/****************** TIM Instances : supporting the break function *************/


/******************** USART Instances : Synchronous mode **********************/


/******************** UART Instances : Half-Duplex mode **********************/


/* Legacy defines */


/****************** UART Instances : Hardware Flow control ********************/

/******************** UART Instances : LIN mode **********************/


/********************* UART Instances : Smart card mode ***********************/


/*********************** UART Instances : IRDA mode ***************************/


/*********************** PCD Instances ****************************************/


/*********************** HCD Instances ****************************************/


/****************************** SDIO Instances ********************************/


/****************************** IWDG Instances ********************************/


/****************************** WWDG Instances ********************************/


/****************************** USB Exported Constants ************************/





/*
 * @brief Specific devices reset values definitions
 */





















/**
  * @}
  */

/**
  * @}
  */

/**
  * @}
  */




































/**
  * @}
  */

/** @addtogroup Exported_types
  * @{
  */
typedef enum
{
  RESET = 0U,
  SET = !RESET
} FlagStatus, ITStatus;

typedef enum
{
  DISABLE = 0U,
  ENABLE = !DISABLE
} FunctionalState;


typedef enum
{
  SUCCESS = 0U,
  ERROR = !SUCCESS
} ErrorStatus;

/**
  * @}
  */


/** @addtogroup Exported_macro
  * @{
  */
















/* Use of CMSIS compiler intrinsics for register exclusive access */
/* Atomic 32-bit register access macro to set one or several bits */


/* Atomic 32-bit register access macro to clear one or several bits */


/* Atomic 32-bit register access macro to clear and set one or several bits */


/* Atomic 16-bit register access macro to set one or several bits */


/* Atomic 16-bit register access macro to clear one or several bits */


/* Atomic 16-bit register access macro to clear and set one or several bits */


/**
  * @}
  */


/**
  ******************************************************************************
  * @file    stm32f4xx_hal.h
  * @author  MCD Application Team
  * @brief   This file contains all the functions prototypes for the HAL 
  *          module driver.
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2017 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */ 

/* Define to prevent recursive inclusion -------------------------------------*/














































































/**
  * @}
  */

/**
  * @}
  */

/**
  ******************************************************************************
  * @file    stm32_hal_legacy.h
  * @author  MCD Application Team
  * @brief   This file contains aliases definition for the STM32Cube HAL constants
  *          macros and functions maintained for legacy purpose.
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2021 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/






/* Includes ------------------------------------------------------------------*/
/* Exported types ------------------------------------------------------------*/
/* Exported constants --------------------------------------------------------*/

/** @defgroup HAL_AES_Aliased_Defines HAL CRYP Aliased Defines maintained for legacy purpose
  * @{
  */











/**
  * @}
  */

/** @defgroup HAL_ADC_Aliased_Defines HAL ADC Aliased Defines maintained for legacy purpose
  * @{
  */






























































/**
  * @}
  */

/** @defgroup HAL_CEC_Aliased_Defines HAL CEC Aliased Defines maintained for legacy purpose
  * @{
  */



/**
  * @}
  */

/** @defgroup HAL_COMP_Aliased_Defines HAL COMP Aliased Defines maintained for legacy purpose
  * @{
  */













































































/**
  * @}
  */

/** @defgroup HAL_CORTEX_Aliased_Defines HAL CORTEX Aliased Defines maintained for legacy purpose
  * @{
  */






/**
  * @}
  */

/** @defgroup CRC_Aliases CRC API aliases
  * @{
  */





/**
  * @}
  */

/** @defgroup HAL_CRC_Aliased_Defines HAL CRC Aliased Defines maintained for legacy purpose
  * @{
  */




/**
  * @}
  */

/** @defgroup HAL_DAC_Aliased_Defines HAL DAC Aliased Defines maintained for legacy purpose
  * @{
  */

































/**
  * @}
  */

/** @defgroup HAL_DMA_Aliased_Defines HAL DMA Aliased Defines maintained for legacy purpose
  * @{
  */

























































































































/**
  * @}
  */

/** @defgroup HAL_FLASH_Aliased_Defines HAL FLASH Aliased Defines maintained for legacy purpose
  * @{
  */






















































































































/**
  * @}
  */

/** @defgroup HAL_JPEG_Aliased_Macros HAL JPEG Aliased Macros maintained for legacy purpose
  * @{
  */










/**
  * @}
  */

/** @defgroup HAL_SYSCFG_Aliased_Defines HAL SYSCFG Aliased Defines maintained for legacy purpose
  * @{
  */








































































































/**
  * @}
  */


/** @defgroup LL_FMC_Aliased_Defines LL FMC Aliased Defines maintained for compatibility purpose
  * @{
  */











/**
  * @}
  */

/** @defgroup LL_FSMC_Aliased_Defines LL FSMC Aliased Defines maintained for legacy purpose
  * @{
  */



/**
  * @}
  */

/** @defgroup HAL_GPIO_Aliased_Macros HAL GPIO Aliased Macros maintained for legacy purpose
  * @{
  */
















































































/**
  * @}
  */

/** @defgroup HAL_GTZC_Aliased_Defines HAL GTZC Aliased Defines maintained for legacy purpose
  * @{
  */





















/**
  * @}
  */

/** @defgroup HAL_HRTIM_Aliased_Macros HAL HRTIM Aliased Macros maintained for legacy purpose
  * @{
  */




























































































































































/**
  * @}
  */

/** @defgroup HAL_I2C_Aliased_Defines HAL I2C Aliased Defines maintained for legacy purpose
  * @{
  */
















/**
  * @}
  */

/** @defgroup HAL_IRDA_Aliased_Defines HAL IRDA Aliased Defines maintained for legacy purpose
  * @{
  */



/**
  * @}
  */

/** @defgroup HAL_IWDG_Aliased_Defines HAL IWDG Aliased Defines maintained for legacy purpose
  * @{
  */




/**
  * @}
  */

/** @defgroup HAL_LPTIM_Aliased_Defines HAL LPTIM Aliased Defines maintained for legacy purpose
  * @{
  */















/* The following 3 definition have also been present in a temporary version of lptim.h */
/* They need to be renamed also to the right name, just in case */





/** @defgroup HAL_LPTIM_Aliased_Defines HAL LPTIM Aliased Defines maintained for legacy purpose
  * @{
  */

/**
  * @}
  */






/**
  * @}
  */

/** @defgroup HAL_NAND_Aliased_Defines HAL NAND Aliased Defines maintained for legacy purpose
  * @{
  */












/**
  * @}
  */

/** @defgroup HAL_NOR_Aliased_Defines HAL NOR Aliased Defines maintained for legacy purpose
  * @{
  */








/**
  * @}
  */

/** @defgroup HAL_OPAMP_Aliased_Defines HAL OPAMP Aliased Defines maintained for legacy purpose
  * @{
  */





































/**
  * @}
  */

/** @defgroup HAL_I2S_Aliased_Defines HAL I2S Aliased Defines maintained for legacy purpose
  * @{
  */












/**
  * @}
  */

/** @defgroup HAL_PCCARD_Aliased_Defines HAL PCCARD Aliased Defines maintained for legacy purpose
  * @{
  */

/* Compact Flash-ATA registers description */










/* Compact Flash-ATA commands */










/**
  * @}
  */

/** @defgroup HAL_RTC_Aliased_Defines HAL RTC Aliased Defines maintained for legacy purpose
  * @{
  */

































































/**
  * @}
  */


/** @defgroup HAL_SMARTCARD_Aliased_Defines HAL SMARTCARD Aliased Defines maintained for legacy purpose
  * @{
  */













/**
  * @}
  */


/** @defgroup HAL_SMBUS_Aliased_Defines HAL SMBUS Aliased Defines maintained for legacy purpose
  * @{
  */











/**
  * @}
  */

/** @defgroup HAL_SPI_Aliased_Defines HAL SPI Aliased Defines maintained for legacy purpose
  * @{
  */




















/**
  * @}
  */

/** @defgroup HAL_TIM_Aliased_Defines HAL TIM Aliased Defines maintained for legacy purpose
  * @{
  */



























































































/**
  * @}
  */

/** @defgroup HAL_TSC_Aliased_Defines HAL TSC Aliased Defines maintained for legacy purpose
  * @{
  */


/**
  * @}
  */

/** @defgroup HAL_UART_Aliased_Defines HAL UART Aliased Defines maintained for legacy purpose
  * @{
  */























/**
  * @}
  */


/** @defgroup HAL_USART_Aliased_Defines HAL USART Aliased Defines maintained for legacy purpose
  * @{
  */






/**
  * @}
  */

/** @defgroup HAL_WWDG_Aliased_Defines HAL WWDG Aliased Defines maintained for legacy purpose
  * @{
  */


/**
  * @}
  */

/** @defgroup HAL_CAN_Aliased_Defines HAL CAN Aliased Defines maintained for legacy purpose
  * @{
  */











/**
  * @}
  */

/** @defgroup HAL_ETH_Aliased_Defines HAL ETH Aliased Defines maintained for legacy purpose
  * @{
  */























































/**
  * @}
  */

/** @defgroup HAL_DCMI_Aliased_Defines HAL DCMI Aliased Defines maintained for legacy purpose
  * @{
  */









/**
  * @}
  */
























/** @defgroup HAL_PPP_Aliased_Defines HAL PPP Aliased Defines maintained for legacy purpose
  * @{
  */

/**
  * @}
  */

/* Exported functions --------------------------------------------------------*/

/** @defgroup HAL_CRYP_Aliased_Functions HAL CRYP Aliased Functions maintained for legacy purpose
  * @{
  */

/**
  * @}
  */

/** @defgroup HAL_DCACHE_Aliased_Functions HAL DCACHE Aliased Functions maintained for legacy purpose
  * @{
  */






/**
  * @}
  */


/** @defgroup HASH_alias HASH API alias
  * @{
  */

/**
  *
  * @}
  */

/** @defgroup HAL_HASH_Aliased_Functions HAL HASH Aliased Functions maintained for legacy purpose
  * @{
  */







/*HASH Algorithm Selection*/



































/**
  * @}
  */

/** @defgroup HAL_Aliased_Functions HAL Generic Aliased Functions maintained for legacy purpose
  * @{
  */






















/**
  * @}
  */

/** @defgroup HAL_FLASH_Aliased_Functions HAL FLASH Aliased Functions maintained for legacy purpose
  * @{
  */








/**
  * @}
 */

/** @defgroup HAL_I2C_Aliased_Functions HAL I2C Aliased Functions maintained for legacy purpose
  * @{
  */






























/**
  * @}
 */

/** @defgroup HAL_PWR_Aliased HAL PWR Aliased maintained for legacy purpose
  * @{
  */






























































































































/**
  * @}
 */

/** @defgroup HAL_RTC_Aliased_Functions HAL RTC Aliased Functions maintained for legacy purpose
  * @{
  */







/**
  * @}
  */

/** @defgroup HAL_SMBUS_Aliased_Functions HAL SMBUS Aliased Functions maintained for legacy purpose
  * @{
  */



/**
  * @}
  */

/** @defgroup HAL_SPI_Aliased_Functions HAL SPI Aliased Functions maintained for legacy purpose
  * @{
  */

/**
  * @}
  */

/** @defgroup HAL_TIM_Aliased_Functions HAL TIM Aliased Functions maintained for legacy purpose
  * @{
  */












/**
  * @}
  */

/** @defgroup HAL_UART_Aliased_Functions HAL UART Aliased Functions maintained for legacy purpose
  * @{
  */

/**
  * @}
  */

/** @defgroup HAL_LTDC_Aliased_Functions HAL LTDC Aliased Functions maintained for legacy purpose
  * @{
  */




/**
  * @}
  */


/** @defgroup HAL_PPP_Aliased_Functions HAL PPP Aliased Functions maintained for legacy purpose
  * @{
  */

/**
  * @}
  */

/* Exported macros ------------------------------------------------------------*/

/** @defgroup HAL_AES_Aliased_Macros HAL CRYP Aliased Macros maintained for legacy purpose
  * @{
  */



/**
  * @}
  */

/** @defgroup HAL_Aliased_Macros HAL Generic Aliased Macros maintained for legacy purpose
  * @{
  */





















/**
  * @}
  */


/** @defgroup HAL_ADC_Aliased_Macros HAL ADC Aliased Macros maintained for legacy purpose
  * @{
  */













































































/**
  * @}
  */

/** @defgroup HAL_DAC_Aliased_Macros HAL DAC Aliased Macros maintained for legacy purpose
  * @{
  */





/**
  * @}
  */

/** @defgroup HAL_DBGMCU_Aliased_Macros HAL DBGMCU Aliased Macros maintained for legacy purpose
  * @{
  */

































































/**
  * @}
  */

/** @defgroup HAL_COMP_Aliased_Macros HAL COMP Aliased Macros maintained for legacy purpose
  * @{
  */




























































/**
  * @}
  */






/** @defgroup HAL_DAC_Aliased_Macros HAL DAC Aliased Macros maintained for legacy purpose
  * @{
  */



/**
  * @}
  */

/** @defgroup HAL_FLASH_Aliased_Macros HAL FLASH Aliased Macros maintained for legacy purpose
  * @{
  */








/**
  * @}
  */

/** @defgroup HAL_I2C_Aliased_Macros HAL I2C Aliased Macros maintained for legacy purpose
  * @{
  */




















/**
  * @}
  */

/** @defgroup HAL_I2S_Aliased_Macros HAL I2S Aliased Macros maintained for legacy purpose
  * @{
  */








/**
  * @}
  */

/** @defgroup HAL_IRDA_Aliased_Macros HAL IRDA Aliased Macros maintained for legacy purpose
  * @{
  */












/**
  * @}
  */


/** @defgroup HAL_IWDG_Aliased_Macros HAL IWDG Aliased Macros maintained for legacy purpose
  * @{
  */


/**
  * @}
  */


/** @defgroup HAL_LPTIM_Aliased_Macros HAL LPTIM Aliased Macros maintained for legacy purpose
  * @{
  */





/**
  * @}
  */


/** @defgroup HAL_OPAMP_Aliased_Macros HAL OPAMP Aliased Macros maintained for legacy purpose
  * @{
  */














/**
  * @}
  */


/** @defgroup HAL_PWR_Aliased_Macros HAL PWR Aliased Macros maintained for legacy purpose
  * @{
  */

















































/**
  * @}
  */


/** @defgroup HAL_RCC_Aliased HAL RCC Aliased maintained for legacy purpose
  * @{
  */























































































































































































































































































































































































































































































































































































































































































































/* alias define maintained for legacy */




























































































































































































































































































































































































































































































































/**
  * @}
  */

/** @defgroup HAL_RNG_Aliased_Macros HAL RNG Aliased Macros maintained for legacy purpose
  * @{
  */


/**
  * @}
  */

/** @defgroup HAL_RTC_Aliased_Macros HAL RTC Aliased Macros maintained for legacy purpose
  * @{
  */
















































/**
  * @}
  */

/** @defgroup HAL_SD_Aliased_Macros HAL SD/MMC Aliased Macros maintained for legacy purpose
  * @{
  */

































/* alias CMSIS */















































/**
  * @}
  */

/** @defgroup HAL_SMARTCARD_Aliased_Macros HAL SMARTCARD Aliased Macros maintained for legacy purpose
  * @{
  */













/**
  * @}
  */

/** @defgroup HAL_SMBUS_Aliased_Macros HAL SMBUS Aliased Macros maintained for legacy purpose
  * @{
  */








/**
  * @}
  */

/** @defgroup HAL_SPI_Aliased_Macros HAL SPI Aliased Macros maintained for legacy purpose
  * @{
  */





/**
  * @}
  */

/** @defgroup HAL_UART_Aliased_Macros HAL UART Aliased Macros maintained for legacy purpose
  * @{
  */











/**
  * @}
  */


/** @defgroup HAL_USART_Aliased_Macros HAL USART Aliased Macros maintained for legacy purpose
  * @{
  */














/**
  * @}
  */

/** @defgroup HAL_USB_Aliased_Macros HAL USB Aliased Macros maintained for legacy purpose
  * @{
  */






































































/**
  * @}
  */

/** @defgroup HAL_TIM_Aliased_Macros HAL TIM Aliased Macros maintained for legacy purpose
  * @{
  */

























/**
  * @}
  */

/** @defgroup HAL_ETH_Aliased_Macros HAL ETH Aliased Macros maintained for legacy purpose
  * @{
  */












/**
  * @}
  */

/** @defgroup HAL_LTDC_Aliased_Macros HAL LTDC Aliased Macros maintained for legacy purpose
  * @{
  */


/**
  * @}
  */

/** @defgroup HAL_SAI_Aliased_Macros HAL SAI Aliased Macros maintained for legacy purpose
  * @{
  */














/**
  * @}
  */

/** @defgroup HAL_SPDIFRX_Aliased_Macros HAL SPDIFRX Aliased Macros maintained for legacy purpose
  * @{
  */





/**
  * @}
  */

/** @defgroup HAL_HRTIM_Aliased_Functions HAL HRTIM Aliased Functions maintained for legacy purpose
  * @{
  */








/**
  * @}
  */

/** @defgroup HAL_QSPI_Aliased_Macros HAL QSPI Aliased Macros maintained for legacy purpose
  * @{
  */



/**
  * @}
  */

/** @defgroup HAL_Generic_Aliased_Macros HAL Generic Aliased Macros maintained for legacy purpose
  * @{
  */



/**
  * @}
  */

/** @defgroup HAL_PPP_Aliased_Macros HAL PPP Aliased Macros maintained for legacy purpose
  * @{
  */

/**
  * @}
  */








/* Ark C Compiler stdlib - stddef.h */







typedef unsigned int size_t;
typedef int          ptrdiff_t;

/* B2: wchar_t wide-character type. The C backend re-includes <wchar.h>,
 * where gcc's wchar.h redefines wchar_t; this definition is for arkcc's own
 * type deduction. Matches the ARM platform: 32-bit unsigned integer. */

typedef unsigned int wchar_t;







/* Exported types ------------------------------------------------------------*/

/** 
  * @brief  HAL Status structures definition  
  */  
typedef enum 
{
  HAL_OK       = 0x00U,
  HAL_ERROR    = 0x01U,
  HAL_BUSY     = 0x02U,
  HAL_TIMEOUT  = 0x03U
} HAL_StatusTypeDef;

/** 
  * @brief  HAL Lock structures definition  
  */
typedef enum 
{
  HAL_UNLOCKED = 0x00U,
  HAL_LOCKED   = 0x01U  
} HAL_LockTypeDef;

/* Exported macro ------------------------------------------------------------*/












/** @brief Reset the Handle's State field.
  * @param __HANDLE__ specifies the Peripheral Handle.
  * @note  This macro can be used for the following purpose: 
  *          - When the Handle is declared as local variable; before passing it as parameter
  *            to HAL_PPP_Init() for the first time, it is mandatory to use this macro 
  *            to set to 0 the Handle's "State" field.
  *            Otherwise, "State" field may have any random value and the first time the function 
  *            HAL_PPP_Init() is called, the low level hardware initialization will be missed
  *            (i.e. HAL_PPP_MspInit() will not be executed).
  *          - When there is a need to reconfigure the low level hardware: instead of calling
  *            HAL_PPP_DeInit() then HAL_PPP_Init(), user can make a call to this macro then HAL_PPP_Init().
  *            In this later function, when the Handle's "State" field is set to 0, it will execute the function
  *            HAL_PPP_MspInit() which will reconfigure the low level hardware.
  * @retval None
  */



























/* Macro to get variable aligned on 4-bytes, for __ICCARM__ the directive "#pragma data_alignment=4" must be used instead */




























/** 
  * @brief  __RAM_FUNC definition
  */ 

/* ARM Compiler V4/V5 and V6
   --------------------------
   RAM functions are defined using the toolchain options. 
   Functions that are executed in RAM should reside in a separate source module.
   Using the 'Options for File' dialog you can simply change the 'Code / Const' 
   area of a module to a memory space in physical RAM.
   Available memory areas are declared in the 'Target' tab of the 'Options for Target'
   dialog. 
*/








/** 
  * @brief  __NOINLINE definition
  */ 

/* ARM V4/V5 and V6 & GNU Compiler
   -------------------------------
*/














/* Include RCC HAL Extended module */
/* (include on top of file since RCC structures are defined in extended file) */
/**
  ******************************************************************************
  * @file    stm32f4xx_hal_rcc_ex.h
  * @author  MCD Application Team
  * @brief   Header file of RCC HAL Extension module.
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2017 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file in
  * the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/






/* Includes ------------------------------------------------------------------*/
/**
  ******************************************************************************
  * @file    stm32f4xx_hal_def.h
  * @author  MCD Application Team
  * @brief   This file contains HAL common defines, enumeration, macros and 
  *          structures definitions. 
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2017 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/

















































































/** @addtogroup STM32F4xx_HAL_Driver
  * @{
  */

/** @addtogroup RCCEx
  * @{
  */

/* Exported types ------------------------------------------------------------*/
/** @defgroup RCCEx_Exported_Types RCCEx Exported Types
  * @{
  */

/**
  * @brief  RCC PLL configuration structure definition
  */
typedef struct
{
  uint32_t PLLState;   /*!< The new state of the PLL.
                            This parameter can be a value of @ref RCC_PLL_Config                      */

  uint32_t PLLSource;  /*!< RCC_PLLSource: PLL entry clock source.
                            This parameter must be a value of @ref RCC_PLL_Clock_Source               */

  uint32_t PLLM;       /*!< PLLM: Division factor for PLL VCO input clock.
                            This parameter must be a number between Min_Data = 0 and Max_Data = 63    */

  uint32_t PLLN;       /*!< PLLN: Multiplication factor for PLL VCO output clock.
                            This parameter must be a number between Min_Data = 50 and Max_Data = 432
                            except for STM32F411xE devices where the Min_Data = 192 */

  uint32_t PLLP;       /*!< PLLP: Division factor for main system clock (SYSCLK).
                            This parameter must be a value of @ref RCC_PLLP_Clock_Divider             */

  uint32_t PLLQ;       /*!< PLLQ: Division factor for OTG FS, SDIO and RNG clocks.
                            This parameter must be a number between Min_Data = 2 and Max_Data = 15    */


} RCC_PLLInitTypeDef;






















/**
  * @brief  PLLI2S Clock structure definition
  */
typedef struct
{



  uint32_t PLLI2SN;    /*!< Specifies the multiplication factor for PLLI2S VCO output clock.
                            This parameter must be a number between Min_Data = 50 and Max_Data = 432
                            Except for STM32F411xE devices where the Min_Data = 192.
                            This parameter will be used only when PLLI2S is selected as Clock Source I2S or SAI */

  uint32_t PLLI2SR;    /*!< Specifies the division factor for I2S clock.
                            This parameter must be a number between Min_Data = 2 and Max_Data = 7.
                            This parameter will be used only when PLLI2S is selected as Clock Source I2S or SAI */

} RCC_PLLI2SInitTypeDef;

/**
  * @brief  RCC extended clocks structure definition
  */
typedef struct
{
  uint32_t PeriphClockSelection; /*!< The Extended Clock to be configured.
                                      This parameter can be a value of @ref RCCEx_Periph_Clock_Selection */

  RCC_PLLI2SInitTypeDef PLLI2S;  /*!< PLL I2S structure parameters.
                                      This parameter will be used only when PLLI2S is selected as Clock Source I2S or SAI */

  uint32_t RTCClockSelection;      /*!< Specifies RTC Clock Prescalers Selection.
                                       This parameter can be a value of @ref RCC_RTC_Clock_Source */

  uint8_t TIMPresSelection;        /*!< Specifies TIM Clock Source Selection.
                                      This parameter can be a value of @ref RCCEx_TIM_PRescaler_Selection */

} RCC_PeriphCLKInitTypeDef;

/**
  * @}
  */

/* Exported constants --------------------------------------------------------*/
/** @defgroup RCCEx_Exported_Constants RCCEx Exported Constants
  * @{
  */

/** @defgroup RCCEx_Periph_Clock_Selection RCC Periph Clock Selection
  * @{
  */
/* Peripheral Clock source for STM32F412Zx/STM32F412Vx/STM32F412Rx/STM32F412Cx */



















/*----------------------------------------------------------------------------*/

/*------------------- Peripheral Clock source for STM32F410xx ----------------*/







/*----------------------------------------------------------------------------*/

/*------------------- Peripheral Clock source for STM32F446xx ----------------*/














/*-----------------------------------------------------------------------------*/

/*----------- Peripheral Clock source for STM32F469xx/STM32F479xx -------------*/











/*----------------------------------------------------------------------------*/

/*-------- Peripheral Clock source for STM32F42xxx/STM32F43xxx ---------------*/









/*----------------------------------------------------------------------------*/

/*-------- Peripheral Clock source for STM32F40xxx/STM32F41xxx ---------------*/








/*----------------------------------------------------------------------------*/
/**
  * @}
  */

/** @defgroup RCCEx_I2S_Clock_Source I2S Clock Source
  * @{
  */


/**
  * @}
  */


/** @defgroup RCCEx_PLLSAI_DIVR RCC PLLSAI DIVR
  * @{
  */






/**
  * @}
  */

/** @defgroup RCCEx_PLLI2SP_Clock_Divider RCC PLLI2SP Clock Divider
  * @{
  */






/**
  * @}
  */

/** @defgroup RCCEx_PLLSAIP_Clock_Divider RCC PLLSAIP Clock Divider
  * @{
  */






/**
  * @}
  */










































































































/** @defgroup RCCEx_TIM_PRescaler_Selection  RCC TIM PRescaler Selection
  * @{
  */


/**
  * @}
  */








/** @defgroup RCC_MCO2_Clock_Source MCO2 Clock Source
  * @{
  */




/**
  * @}
  */









/**
  * @}
  */

/* Exported macro ------------------------------------------------------------*/
/** @defgroup RCCEx_Exported_Macros RCCEx Exported Macros
  * @{
  */
/*------------------- STM32F42xxx/STM32F43xxx/STM32F469xx/STM32F479xx --------*/





























































































































































































































































































































































































































































































/*----------------------------------------------------------------------------*/

/*----------------------------------- STM32F40xxx/STM32F41xxx-----------------*/















































































































































































































































































































































































/*----------------------------------------------------------------------------*/

/*------------------------- STM32F401xE/STM32F401xC --------------------------*/

/** @defgroup RCCEx_AHB1_Clock_Enable_Disable AHB1 Peripheral Clock Enable Disable
  * @brief  Enable or disable the AHB1 peripheral clock.
  * @note   After reset, the peripheral clock (used for registers read/write access)
  *         is disabled and the application software has to enable this clock before
  *         using it.
  * @{
  */









/**
  * @}
  */

/** @defgroup RCCEx_AHB1_Peripheral_Clock_Enable_Disable_Status AHB1 Peripheral Clock Enable Disable Status
  * @brief  Get the enable or disable status of the AHB1 peripheral clock.
  * @note   After reset, the peripheral clock (used for registers read/write access)
  *         is disabled and the application software has to enable this clock before
  *         using it.
  * @{
  */









/**
  * @}
  */

/** @defgroup RCCEx_AHB2_Clock_Enable_Disable AHB2 Peripheral Clock Enable Disable
  * @brief  Enable or disable the AHB2 peripheral clock.
  * @note   After reset, the peripheral clock (used for registers read/write access)
  *         is disabled and the application software has to enable this clock before
  *         using it.
  * @{
  */



/**
  * @}
  */

/** @defgroup RCCEx_AHB2_Peripheral_Clock_Enable_Disable_Status AHB2 Peripheral Clock Enable Disable Status
  * @brief  Get the enable or disable status of the AHB2 peripheral clock.
  * @note   After reset, the peripheral clock (used for registers read/write access)
  *         is disabled and the application software has to enable this clock before
  *         using it.
  * @{
  */


/**
  * @}
  */

/** @defgroup RCC_APB1_Clock_Enable_Disable APB1 Peripheral Clock Enable Disable
  * @brief  Enable or disable the Low Speed APB (APB1) peripheral clock.
  * @note   After reset, the peripheral clock (used for registers read/write access)
  *         is disabled and the application software has to enable this clock before
  *         using it.
  * @{
  */










/**
  * @}
  */

/** @defgroup RCCEx_APB1_Peripheral_Clock_Enable_Disable_Status APB1 Peripheral Clock Enable Disable Status
  * @brief  Get the enable or disable status of the APB1 peripheral clock.
  * @note   After reset, the peripheral clock (used for registers read/write access)
  *         is disabled and the application software has to enable this clock before
  *         using it.
  * @{
  */











/**
  * @}
  */

/** @defgroup RCCEx_APB2_Clock_Enable_Disable APB2 Peripheral Clock Enable Disable
  * @brief  Enable or disable the High Speed APB (APB2) peripheral clock.
  * @note   After reset, the peripheral clock (used for registers read/write access)
  *         is disabled and the application software has to enable this clock before
  *         using it.
  * @{
  */







/**
  * @}
  */

/** @defgroup RCCEx_APB2_Peripheral_Clock_Enable_Disable_Status APB2 Peripheral Clock Enable Disable Status
  * @brief  Get the enable or disable status of the APB2 peripheral clock.
  * @note   After reset, the peripheral clock (used for registers read/write access)
  *         is disabled and the application software has to enable this clock before
  *         using it.
  * @{
  */







/**
  * @}
  */
/** @defgroup RCCEx_AHB1_Force_Release_Reset AHB1 Force Release Reset
  * @brief  Force or release AHB1 peripheral reset.
  * @{
  */









/**
  * @}
  */

/** @defgroup RCCEx_AHB2_Force_Release_Reset AHB2 Force Release Reset
  * @brief  Force or release AHB2 peripheral reset.
  * @{
  */





/**
  * @}
  */

/** @defgroup RCCEx_APB1_Force_Release_Reset APB1 Force Release Reset
  * @brief  Force or release APB1 peripheral reset.
  * @{
  */













/**
  * @}
  */

/** @defgroup RCCEx_APB2_Force_Release_Reset APB2 Force Release Reset
  * @brief  Force or release APB2 peripheral reset.
  * @{
  */









/**
  * @}
  */

/** @defgroup RCCEx_AHB3_Force_Release_Reset AHB3 Force Release Reset
  * @brief  Force or release AHB3 peripheral reset.
  * @{
  */


/**
  * @}
  */

/** @defgroup RCCEx_AHB1_LowPower_Enable_Disable AHB1 Peripheral Low Power Enable Disable
  * @brief  Enable or disable the AHB1 peripheral clock during Low Power (Sleep) mode.
  * @note   Peripheral clock gating in SLEEP mode can be used to further reduce
  *         power consumption.
  * @note   After wake-up from SLEEP mode, the peripheral clock is enabled again.
  * @note   By default, all peripheral clocks are enabled during SLEEP mode.
  * @{
  */











/**
  * @}
  */

/** @defgroup RCCEx_AHB2_LowPower_Enable_Disable AHB2 Peripheral Low Power Enable Disable
  * @brief  Enable or disable the AHB2 peripheral clock during Low Power (Sleep) mode.
  * @note   Peripheral clock gating in SLEEP mode can be used to further reduce
  *         power consumption.
  * @note   After wake-up from SLEEP mode, the peripheral clock is enabled again.
  * @note   By default, all peripheral clocks are enabled during SLEEP mode.
  * @{
  */



/**
  * @}
  */

/** @defgroup RCCEx_APB1_LowPower_Enable_Disable APB1 Peripheral Low Power Enable Disable
  * @brief  Enable or disable the APB1 peripheral clock during Low Power (Sleep) mode.
  * @note   Peripheral clock gating in SLEEP mode can be used to further reduce
  *         power consumption.
  * @note   After wake-up from SLEEP mode, the peripheral clock is enabled again.
  * @note   By default, all peripheral clocks are enabled during SLEEP mode.
  * @{
  */











/**
  * @}
  */

/** @defgroup RCCEx_APB2_LowPower_Enable_Disable APB2 Peripheral Low Power Enable Disable
  * @brief  Enable or disable the APB2 peripheral clock during Low Power (Sleep) mode.
  * @note   Peripheral clock gating in SLEEP mode can be used to further reduce
  *         power consumption.
  * @note   After wake-up from SLEEP mode, the peripheral clock is enabled again.
  * @note   By default, all peripheral clocks are enabled during SLEEP mode.
  * @{
  */







/**
  * @}
  */

/*----------------------------------------------------------------------------*/

/*-------------------------------- STM32F410xx -------------------------------*/



























































































/*----------------------------------------------------------------------------*/

/*-------------------------------- STM32F411xx -------------------------------*/

























































































































/*----------------------------------------------------------------------------*/

/*---------------------------------- STM32F446xx -----------------------------*/











































































































































































































































































































































/*----------------------------------------------------------------------------*/

/*-------STM32F412Zx || STM32F412Vx || STM32F412Rx || STM32F412Cx || STM32F413xx || STM32F423xx-------*/




























































































































































































































































































































































































































































































































































/*----------------------------------------------------------------------------*/

/*------------------------------- PLL Configuration --------------------------*/



/** @brief  Macro to configure the main PLL clock source, multiplication and division factors.
  * @note   This function must be used only when the main PLL is disabled.
  * @param  __RCC_PLLSource__ specifies the PLL entry clock source.
  *         This parameter can be one of the following values:
  *            @arg RCC_PLLSOURCE_HSI: HSI oscillator clock selected as PLL clock entry
  *            @arg RCC_PLLSOURCE_HSE: HSE oscillator clock selected as PLL clock entry
  * @note   This clock source (RCC_PLLSource) is common for the main PLL and PLLI2S.
  * @param  __PLLM__ specifies the division factor for PLL VCO input clock
  *         This parameter must be a number between Min_Data = 2 and Max_Data = 63.
  * @note   You have to set the PLLM parameter correctly to ensure that the VCO input
  *         frequency ranges from 1 to 2 MHz. It is recommended to select a frequency
  *         of 2 MHz to limit PLL jitter.
  * @param  __PLLN__ specifies the multiplication factor for PLL VCO output clock
  *         This parameter must be a number between Min_Data = 50 and Max_Data = 432
  *         Except for STM32F411xE devices where Min_Data = 192.
  * @note   You have to set the PLLN parameter correctly to ensure that the VCO
  *         output frequency is between 100 and 432 MHz, Except for STM32F411xE devices
  *         where frequency is between 192 and 432 MHz.
  * @param  __PLLP__ specifies the division factor for main system clock (SYSCLK)
  *         This parameter must be a number in the range {2, 4, 6, or 8}.
  *
  * @param  __PLLQ__ specifies the division factor for OTG FS, SDIO and RNG clocks
  *         This parameter must be a number between Min_Data = 2 and Max_Data = 15.
  * @note   If the USB OTG FS is used in your application, you have to set the
  *         PLLQ parameter correctly to have 48 MHz clock for the USB. However,
  *         the SDIO and RNG need a frequency lower than or equal to 48 MHz to work
  *         correctly.
  *
  */


/*----------------------------------------------------------------------------*/

/*----------------------------PLLI2S Configuration ---------------------------*/


/** @brief Macros to enable or disable the PLLI2S.
  * @note  The PLLI2S is disabled by hardware when entering STOP and STANDBY modes.
  */









/** @brief  Macro to configure the PLLI2S clock multiplication and division factors .
  * @note   This macro must be used only when the PLLI2S is disabled.
  * @note   PLLI2S clock source is common with the main PLL (configured in
  *         HAL_RCC_ClockConfig() API).
  * @param  __PLLI2SN__ specifies the multiplication factor for PLLI2S VCO output clock
  *         This parameter must be a number between Min_Data = 50 and Max_Data = 432.
  * @note   You have to set the PLLI2SN parameter correctly to ensure that the VCO
  *         output frequency is between Min_Data = 100 and Max_Data = 432 MHz.
  *
  * @param  __PLLI2SR__ specifies the division factor for I2S clock
  *         This parameter must be a number between Min_Data = 2 and Max_Data = 7.
  * @note   You have to set the PLLI2SR parameter correctly to not exceed 192 MHz
  *         on the I2S clock frequency.
  *
  */










/*----------------------------------------------------------------------------*/

/*------------------------------ PLLSAI Configuration ------------------------*/













/*----------------------------------------------------------------------------*/

/*------------------- PLLSAI/PLLI2S Dividers Configuration -------------------*/













/*----------------------------------------------------------------------------*/

/*------------------------- Peripheral Clock selection -----------------------*/

/** @brief  Macro to configure the I2S clock source (I2SCLK).
  * @note   This function must be called before enabling the I2S APB clock.
  * @param  __SOURCE__ specifies the I2S clock source.
  *         This parameter can be one of the following values:
  *            @arg RCC_I2SCLKSOURCE_PLLI2S: PLLI2S clock used as I2S clock source.
  *            @arg RCC_I2SCLKSOURCE_EXT: External clock mapped on the I2S_CKIN pin
  *                                       used as I2S clock source.
  */



/** @brief  Macro to get the I2S clock source (I2SCLK).
  * @retval The clock source can be one of the following values:
  *            @arg @ref RCC_I2SCLKSOURCE_PLLI2S: PLLI2S clock used as I2S clock source.
  *            @arg @ref RCC_I2SCLKSOURCE_EXT External clock mapped on the I2S_CKIN pin
  *                                        used as I2S clock source
  */














































































/** @brief  Macro to configure the Timers clocks prescalers
  * @note   This feature is only available with STM32F429x/439x Devices.
  * @param  __PRESC__  specifies the Timers clocks prescalers selection
  *         This parameter can be one of the following values:
  *            @arg RCC_TIMPRES_DESACTIVATED: The Timers kernels clocks prescaler is
  *                 equal to HPRE if PPREx is corresponding to division by 1 or 2,
  *                 else it is equal to [(HPRE * PPREx) / 2] if PPREx is corresponding to
  *                 division by 4 or more.
  *            @arg RCC_TIMPRES_ACTIVATED: The Timers kernels clocks prescaler is
  *                 equal to HPRE if PPREx is corresponding to division by 1, 2 or 4,
  *                 else it is equal to [(HPRE * PPREx) / 4] if PPREx is corresponding
  *                 to division by 8 or more.
  */




/*----------------------------------------------------------------------------*/
















/**
  * @}
  */

/* Exported functions --------------------------------------------------------*/
/** @addtogroup RCCEx_Exported_Functions
  *  @{
  */

/** @addtogroup RCCEx_Exported_Functions_Group1
  *  @{
  */
HAL_StatusTypeDef HAL_RCCEx_PeriphCLKConfig(RCC_PeriphCLKInitTypeDef  *PeriphClkInit);
void HAL_RCCEx_GetPeriphCLKConfig(RCC_PeriphCLKInitTypeDef  *PeriphClkInit);

uint32_t HAL_RCCEx_GetPeriphCLKFreq(uint32_t PeriphClk);




HAL_StatusTypeDef HAL_RCCEx_EnablePLLI2S(RCC_PLLI2SInitTypeDef  *PLLI2SInit);
HAL_StatusTypeDef HAL_RCCEx_DisablePLLI2S(void);



/**
  * @}
  */

/**
  * @}
  */
/* Private types -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private constants ---------------------------------------------------------*/
/** @defgroup RCCEx_Private_Constants RCCEx Private Constants
  * @{
  */

/** @defgroup RCCEx_BitAddress_AliasRegion RCC BitAddress AliasRegion
  * @brief RCC registers bit address in the alias region
  * @{
  */
/* --- CR Register ---*/







/* Alias word address of PLLI2SON bit */




/* --- DCKCFGR Register ---*/

/* Alias word address of TIMPRE bit */





/* --- CFGR Register ---*/


/* Alias word address of I2SSRC bit */





















/**
  * @}
  */

/**
  * @}
  */

/* Private macros ------------------------------------------------------------*/
/** @defgroup RCCEx_Private_Macros RCCEx Private Macros
  * @{
  */
/** @defgroup RCCEx_IS_RCC_Definitions RCC Private macros to check input parameters
  * @{
  */




















































































































/**
  * @}
  */

/**
  * @}
  */

/**
  * @}
  */

/**
  * @}
  */







/** @addtogroup STM32F4xx_HAL_Driver
  * @{
  */

/** @addtogroup RCC
  * @{
  */

/* Exported types ------------------------------------------------------------*/
/** @defgroup RCC_Exported_Types RCC Exported Types
  * @{
  */

/**
  * @brief  RCC Internal/External Oscillator (HSE, HSI, LSE and LSI) configuration structure definition
  */
typedef struct
{
  uint32_t OscillatorType;       /*!< The oscillators to be configured.
                                      This parameter can be a value of @ref RCC_Oscillator_Type                   */

  uint32_t HSEState;             /*!< The new state of the HSE.
                                      This parameter can be a value of @ref RCC_HSE_Config                        */

  uint32_t LSEState;             /*!< The new state of the LSE.
                                      This parameter can be a value of @ref RCC_LSE_Config                        */

  uint32_t HSIState;             /*!< The new state of the HSI.
                                      This parameter can be a value of @ref RCC_HSI_Config                        */

  uint32_t HSICalibrationValue;  /*!< The HSI calibration trimming value (default is RCC_HSICALIBRATION_DEFAULT).
                                       This parameter must be a number between Min_Data = 0x00 and Max_Data = 0x1F */

  uint32_t LSIState;             /*!< The new state of the LSI.
                                      This parameter can be a value of @ref RCC_LSI_Config                        */

  RCC_PLLInitTypeDef PLL;        /*!< PLL structure parameters                                                    */
} RCC_OscInitTypeDef;

/**
  * @brief  RCC System, AHB and APB busses clock configuration structure definition
  */
typedef struct
{
  uint32_t ClockType;             /*!< The clock to be configured.
                                       This parameter can be a value of @ref RCC_System_Clock_Type      */

  uint32_t SYSCLKSource;          /*!< The clock source (SYSCLKS) used as system clock.
                                       This parameter can be a value of @ref RCC_System_Clock_Source    */

  uint32_t AHBCLKDivider;         /*!< The AHB clock (HCLK) divider. This clock is derived from the system clock (SYSCLK).
                                       This parameter can be a value of @ref RCC_AHB_Clock_Source       */

  uint32_t APB1CLKDivider;        /*!< The APB1 clock (PCLK1) divider. This clock is derived from the AHB clock (HCLK).
                                       This parameter can be a value of @ref RCC_APB1_APB2_Clock_Source */

  uint32_t APB2CLKDivider;        /*!< The APB2 clock (PCLK2) divider. This clock is derived from the AHB clock (HCLK).
                                       This parameter can be a value of @ref RCC_APB1_APB2_Clock_Source */

} RCC_ClkInitTypeDef;

/**
  * @}
  */

/* Exported constants --------------------------------------------------------*/
/** @defgroup RCC_Exported_Constants RCC Exported Constants
  * @{
  */

/** @defgroup RCC_Oscillator_Type Oscillator Type
  * @{
  */





/**
  * @}
  */

/** @defgroup RCC_HSE_Config HSE Config
  * @{
  */



/**
  * @}
  */

/** @defgroup RCC_LSE_Config LSE Config
  * @{
  */



/**
  * @}
  */

/** @defgroup RCC_HSI_Config HSI Config
  * @{
  */




/**
  * @}
  */

/** @defgroup RCC_LSI_Config LSI Config
  * @{
  */


/**
  * @}
  */

/** @defgroup RCC_PLL_Config PLL Config
  * @{
  */



/**
  * @}
  */

/** @defgroup RCC_PLLP_Clock_Divider PLLP Clock Divider
  * @{
  */




/**
  * @}
  */

/** @defgroup RCC_PLL_Clock_Source PLL Clock Source
  * @{
  */


/**
  * @}
  */

/** @defgroup RCC_System_Clock_Type System Clock Type
  * @{
  */




/**
  * @}
  */

/** @defgroup RCC_System_Clock_Source System Clock Source
  * @note     The RCC_SYSCLKSOURCE_PLLRCLK parameter is available only for
  *           STM32F446xx devices.
  * @{
  */




/**
  * @}
  */

/** @defgroup RCC_System_Clock_Source_Status System Clock Source Status
  * @note     The RCC_SYSCLKSOURCE_STATUS_PLLRCLK parameter is available only for
  *           STM32F446xx devices.
  * @{
  */




/**
  * @}
  */

/** @defgroup RCC_AHB_Clock_Source AHB Clock Source
  * @{
  */









/**
  * @}
  */

/** @defgroup RCC_APB1_APB2_Clock_Source APB1/APB2 Clock Source
  * @{
  */





/**
  * @}
  */

/** @defgroup RCC_RTC_Clock_Source RTC Clock Source
  * @{
  */


































/**
  * @}
  */

/** @defgroup RCC_MCO_Index MCO Index
  * @{
  */


/**
  * @}
  */

/** @defgroup RCC_MCO1_Clock_Source MCO1 Clock Source
  * @{
  */




/**
  * @}
  */

/** @defgroup RCC_MCOx_Clock_Prescaler MCOx Clock Prescaler
  * @{
  */





/**
  * @}
  */

/** @defgroup RCC_Interrupt Interrupts
  * @{
  */







/**
  * @}
  */

/** @defgroup RCC_Flag Flags
  *        Elements values convention: 0XXYYYYYb
  *           - YYYYY  : Flag position in the register
  *           - 0XX  : Register index
  *                 - 01: CR register
  *                 - 10: BDCR register
  *                 - 11: CSR register
  * @{
  */
/* Flags in the CR register */





/* Flags in the BDCR register */


/* Flags in the CSR register */








/**
  * @}
  */

/**
  * @}
  */

/* Exported macro ------------------------------------------------------------*/
/** @defgroup RCC_Exported_Macros RCC Exported Macros
  * @{
  */

/** @defgroup RCC_AHB1_Clock_Enable_Disable AHB1 Peripheral Clock Enable Disable
  * @brief  Enable or disable the AHB1 peripheral clock.
  * @note   After reset, the peripheral clock (used for registers read/write access)
  *         is disabled and the application software has to enable this clock before
  *         using it.
  * @{
  */













/**
  * @}
  */

/** @defgroup RCC_AHB1_Peripheral_Clock_Enable_Disable_Status AHB1 Peripheral Clock Enable Disable Status
  * @brief  Get the enable or disable status of the AHB1 peripheral clock.
  * @note   After reset, the peripheral clock (used for registers read/write access)
  *         is disabled and the application software has to enable this clock before
  *         using it.
  * @{
  */













/**
  * @}
  */

/** @defgroup RCC_APB1_Clock_Enable_Disable APB1 Peripheral Clock Enable Disable
  * @brief  Enable or disable the Low Speed APB (APB1) peripheral clock.
  * @note   After reset, the peripheral clock (used for registers read/write access)
  *         is disabled and the application software has to enable this clock before
  *         using it.
  * @{
  */















/**
  * @}
  */

/** @defgroup RCC_APB1_Peripheral_Clock_Enable_Disable_Status APB1 Peripheral Clock Enable Disable Status
  * @brief  Get the enable or disable status of the APB1 peripheral clock.
  * @note   After reset, the peripheral clock (used for registers read/write access)
  *         is disabled and the application software has to enable this clock before
  *         using it.
  * @{
  */















/**
  * @}
  */

/** @defgroup RCC_APB2_Clock_Enable_Disable APB2 Peripheral Clock Enable Disable
  * @brief  Enable or disable the High Speed APB (APB2) peripheral clock.
  * @note   After reset, the peripheral clock (used for registers read/write access)
  *         is disabled and the application software has to enable this clock before
  *         using it.
  * @{
  */

















/**
  * @}
  */

/** @defgroup RCC_APB2_Peripheral_Clock_Enable_Disable_Status APB2 Peripheral Clock Enable Disable Status
  * @brief  Get the enable or disable status of the APB2 peripheral clock.
  * @note   After reset, the peripheral clock (used for registers read/write access)
  *         is disabled and the application software has to enable this clock before
  *         using it.
  * @{
  */

















/**
  * @}
  */

/** @defgroup RCC_AHB1_Force_Release_Reset AHB1 Force Release Reset
  * @brief  Force or release AHB1 peripheral reset.
  * @{
  */














/**
  * @}
  */

/** @defgroup RCC_APB1_Force_Release_Reset APB1 Force Release Reset
  * @brief  Force or release APB1 peripheral reset.
  * @{
  */
















/**
  * @}
  */

/** @defgroup RCC_APB2_Force_Release_Reset APB2 Force Release Reset
  * @brief  Force or release APB2 peripheral reset.
  * @{
  */


















/**
  * @}
  */

/** @defgroup RCC_AHB1_LowPower_Enable_Disable AHB1 Peripheral Low Power Enable Disable
  * @brief  Enable or disable the AHB1 peripheral clock during Low Power (Sleep) mode.
  * @note   Peripheral clock gating in SLEEP mode can be used to further reduce
  *         power consumption.
  * @note   After wake-up from SLEEP mode, the peripheral clock is enabled again.
  * @note   By default, all peripheral clocks are enabled during SLEEP mode.
  * @{
  */













/**
  * @}
  */

/** @defgroup RCC_APB1_LowPower_Enable_Disable APB1 Peripheral Low Power Enable Disable
  * @brief  Enable or disable the APB1 peripheral clock during Low Power (Sleep) mode.
  * @note   Peripheral clock gating in SLEEP mode can be used to further reduce
  *         power consumption.
  * @note   After wake-up from SLEEP mode, the peripheral clock is enabled again.
  * @note   By default, all peripheral clocks are enabled during SLEEP mode.
  * @{
  */















/**
  * @}
  */

/** @defgroup RCC_APB2_LowPower_Enable_Disable APB2 Peripheral Low Power Enable Disable
  * @brief  Enable or disable the APB2 peripheral clock during Low Power (Sleep) mode.
  * @note   Peripheral clock gating in SLEEP mode can be used to further reduce
  *         power consumption.
  * @note   After wake-up from SLEEP mode, the peripheral clock is enabled again.
  * @note   By default, all peripheral clocks are enabled during SLEEP mode.
  * @{
  */

















/**
  * @}
  */

/** @defgroup RCC_HSI_Configuration HSI Configuration
  * @{
  */

/** @brief  Macros to enable or disable the Internal High Speed oscillator (HSI).
  * @note   The HSI is stopped by hardware when entering STOP and STANDBY modes.
  *         It is used (enabled by hardware) as system clock source after startup
  *         from Reset, wake-up from STOP and STANDBY mode, or in case of failure
  *         of the HSE used directly or indirectly as system clock (if the Clock
  *         Security System CSS is enabled).
  * @note   HSI can not be stopped if it is used as system clock source. In this case,
  *         you have to select another source of the system clock then stop the HSI.
  * @note   After enabling the HSI, the application software should wait on HSIRDY
  *         flag to be set indicating that HSI clock is stable and can be used as
  *         system clock source.
  *         This parameter can be: ENABLE or DISABLE.
  * @note   When the HSI is stopped, HSIRDY flag goes low after 6 HSI oscillator
  *         clock cycles.
  */



/** @brief  Macro to adjust the Internal High Speed oscillator (HSI) calibration value.
  * @note   The calibration is used to compensate for the variations in voltage
  *         and temperature that influence the frequency of the internal HSI RC.
  * @param  __HSICalibrationValue__ specifies the calibration trimming value.
  *         (default is RCC_HSICALIBRATION_DEFAULT).
  *         This parameter must be a number between 0 and 0x1F.
  */

/**
  * @}
  */

/** @defgroup RCC_LSI_Configuration LSI Configuration
  * @{
  */

/** @brief  Macros to enable or disable the Internal Low Speed oscillator (LSI).
  * @note   After enabling the LSI, the application software should wait on
  *         LSIRDY flag to be set indicating that LSI clock is stable and can
  *         be used to clock the IWDG and/or the RTC.
  * @note   LSI can not be disabled if the IWDG is running.
  * @note   When the LSI is stopped, LSIRDY flag goes low after 6 LSI oscillator
  *         clock cycles.
  */


/**
  * @}
  */

/** @defgroup RCC_HSE_Configuration HSE Configuration
  * @{
  */

/**
  * @brief  Macro to configure the External High Speed oscillator (HSE).
  * @note   Transition HSE Bypass to HSE On and HSE On to HSE Bypass are not supported by this macro.
  *         User should request a transition to HSE Off first and then HSE On or HSE Bypass.
  * @note   After enabling the HSE (RCC_HSE_ON or RCC_HSE_Bypass), the application
  *         software should wait on HSERDY flag to be set indicating that HSE clock
  *         is stable and can be used to clock the PLL and/or system clock.
  * @note   HSE state can not be changed if it is used directly or through the
  *         PLL as system clock. In this case, you have to select another source
  *         of the system clock then change the HSE state (ex. disable it).
  * @note   The HSE is stopped by hardware when entering STOP and STANDBY modes.
  * @note   This function reset the CSSON bit, so if the clock security system(CSS)
  *         was previously enabled you have to enable it again after calling this
  *         function.
  * @param  __STATE__ specifies the new state of the HSE.
  *         This parameter can be one of the following values:
  *            @arg RCC_HSE_OFF: turn OFF the HSE oscillator, HSERDY flag goes low after
  *                              6 HSE oscillator clock cycles.
  *            @arg RCC_HSE_ON: turn ON the HSE oscillator.
  *            @arg RCC_HSE_BYPASS: HSE oscillator bypassed with external clock.
  */

/**
  * @}
  */

/** @defgroup RCC_LSE_Configuration LSE Configuration
  * @{
  */

/**
  * @brief  Macro to configure the External Low Speed oscillator (LSE).
  * @note   Transition LSE Bypass to LSE On and LSE On to LSE Bypass are not supported by this macro.
  *         User should request a transition to LSE Off first and then LSE On or LSE Bypass.
  * @note   As the LSE is in the Backup domain and write access is denied to
  *         this domain after reset, you have to enable write access using
  *         HAL_PWR_EnableBkUpAccess() function before to configure the LSE
  *         (to be done once after reset).
  * @note   After enabling the LSE (RCC_LSE_ON or RCC_LSE_BYPASS), the application
  *         software should wait on LSERDY flag to be set indicating that LSE clock
  *         is stable and can be used to clock the RTC.
  * @param  __STATE__ specifies the new state of the LSE.
  *         This parameter can be one of the following values:
  *            @arg RCC_LSE_OFF: turn OFF the LSE oscillator, LSERDY flag goes low after
  *                              6 LSE oscillator clock cycles.
  *            @arg RCC_LSE_ON: turn ON the LSE oscillator.
  *            @arg RCC_LSE_BYPASS: LSE oscillator bypassed with external clock.
  */

/**
  * @}
  */

/** @defgroup RCC_Internal_RTC_Clock_Configuration RTC Clock Configuration
  * @{
  */

/** @brief  Macros to enable or disable the RTC clock.
  * @note   These macros must be used only after the RTC clock source was selected.
  */



/** @brief  Macros to configure the RTC clock (RTCCLK).
  * @note   As the RTC clock configuration bits are in the Backup domain and write
  *         access is denied to this domain after reset, you have to enable write
  *         access using the Power Backup Access macro before to configure
  *         the RTC clock source (to be done once after reset).
  * @note   Once the RTC clock is configured it can't be changed unless the
  *         Backup domain is reset using __HAL_RCC_BackupReset_RELEASE() macro, or by
  *         a Power On Reset (POR).
  * @param  __RTCCLKSource__ specifies the RTC clock source.
  *         This parameter can be one of the following values:
  *            @arg @ref RCC_RTCCLKSOURCE_NO_CLK : No clock selected as RTC clock.
  *            @arg @ref RCC_RTCCLKSOURCE_LSE : LSE selected as RTC clock.
  *            @arg @ref RCC_RTCCLKSOURCE_LSI : LSI selected as RTC clock.
  *            @arg @ref RCC_RTCCLKSOURCE_HSE_DIVX HSE divided by X selected as RTC clock (X can be retrieved thanks to @ref __HAL_RCC_GET_RTC_HSE_PRESCALER()
  * @note   If the LSE or LSI is used as RTC clock source, the RTC continues to
  *         work in STOP and STANDBY modes, and can be used as wake-up source.
  *         However, when the HSE clock is used as RTC clock source, the RTC
  *         cannot be used in STOP and STANDBY modes.
  * @note   The maximum input clock frequency for RTC is 1MHz (when using HSE as
  *         RTC clock source).
  */




/** @brief Macro to get the RTC clock source.
  * @retval The clock source can be one of the following values:
  *            @arg @ref RCC_RTCCLKSOURCE_NO_CLK No clock selected as RTC clock
  *            @arg @ref RCC_RTCCLKSOURCE_LSE LSE selected as RTC clock
  *            @arg @ref RCC_RTCCLKSOURCE_LSI LSI selected as RTC clock
  *            @arg @ref RCC_RTCCLKSOURCE_HSE_DIVX HSE divided by X selected as RTC clock (X can be retrieved thanks to @ref __HAL_RCC_GET_RTC_HSE_PRESCALER()
  */


/**
  * @brief   Get the RTC and HSE clock divider (RTCPRE).
  * @retval Returned value can be one of the following values:
  *            @arg @ref RCC_RTCCLKSOURCE_HSE_DIVX HSE divided by X selected as RTC clock (X can be retrieved thanks to @ref __HAL_RCC_GET_RTC_HSE_PRESCALER()
  */


/** @brief  Macros to force or release the Backup domain reset.
  * @note   This function resets the RTC peripheral (including the backup registers)
  *         and the RTC clock source selection in RCC_CSR register.
  * @note   The BKPSRAM is not affected by this reset.
  */


/**
  * @}
  */

/** @defgroup RCC_PLL_Configuration PLL Configuration
  * @{
  */

/** @brief  Macros to enable or disable the main PLL.
  * @note   After enabling the main PLL, the application software should wait on
  *         PLLRDY flag to be set indicating that PLL clock is stable and can
  *         be used as system clock source.
  * @note   The main PLL can not be disabled if it is used as system clock source
  * @note   The main PLL is disabled by hardware when entering STOP and STANDBY modes.
  */



/** @brief  Macro to configure the PLL clock source.
  * @note   This function must be used only when the main PLL is disabled.
  * @param  __PLLSOURCE__ specifies the PLL entry clock source.
  *         This parameter can be one of the following values:
  *            @arg RCC_PLLSOURCE_HSI: HSI oscillator clock selected as PLL clock entry
  *            @arg RCC_PLLSOURCE_HSE: HSE oscillator clock selected as PLL clock entry
  *
  */


/** @brief  Macro to configure the PLL multiplication factor.
  * @note   This function must be used only when the main PLL is disabled.
  * @param  __PLLM__ specifies the division factor for PLL VCO input clock
  *         This parameter must be a number between Min_Data = 2 and Max_Data = 63.
  * @note   You have to set the PLLM parameter correctly to ensure that the VCO input
  *         frequency ranges from 1 to 2 MHz. It is recommended to select a frequency
  *         of 2 MHz to limit PLL jitter.
  *
  */

/**
  * @}
  */

/** @defgroup RCC_Get_Clock_source Get Clock source
  * @{
  */
/**
  * @brief Macro to configure the system clock source.
  * @param __RCC_SYSCLKSOURCE__ specifies the system clock source.
  * This parameter can be one of the following values:
  *              - RCC_SYSCLKSOURCE_HSI: HSI oscillator is used as system clock source.
  *              - RCC_SYSCLKSOURCE_HSE: HSE oscillator is used as system clock source.
  *              - RCC_SYSCLKSOURCE_PLLCLK: PLL output is used as system clock source.
  *              - RCC_SYSCLKSOURCE_PLLRCLK: PLLR output is used as system clock source. This
  *                parameter is available only for STM32F446xx devices.
  */


/** @brief  Macro to get the clock source used as system clock.
  * @retval The clock source used as system clock. The returned value can be one
  *         of the following:
  *              - RCC_SYSCLKSOURCE_STATUS_HSI: HSI used as system clock.
  *              - RCC_SYSCLKSOURCE_STATUS_HSE: HSE used as system clock.
  *              - RCC_SYSCLKSOURCE_STATUS_PLLCLK: PLL used as system clock.
  *              - RCC_SYSCLKSOURCE_STATUS_PLLRCLK: PLLR used as system clock. This parameter
  *                is available only for STM32F446xx devices.
  */


/** @brief  Macro to get the oscillator used as PLL clock source.
  * @retval The oscillator used as PLL clock source. The returned value can be one
  *         of the following:
  *              - RCC_PLLSOURCE_HSI: HSI oscillator is used as PLL clock source.
  *              - RCC_PLLSOURCE_HSE: HSE oscillator is used as PLL clock source.
  */

/**
  * @}
  */

/** @defgroup RCCEx_MCOx_Clock_Config RCC Extended MCOx Clock Config
  * @{
  */

/** @brief  Macro to configure the MCO1 clock.
  * @param  __MCOCLKSOURCE__ specifies the MCO clock source.
  *          This parameter can be one of the following values:
  *            @arg RCC_MCO1SOURCE_HSI: HSI clock selected as MCO1 source
  *            @arg RCC_MCO1SOURCE_LSE: LSE clock selected as MCO1 source
  *            @arg RCC_MCO1SOURCE_HSE: HSE clock selected as MCO1 source
  *            @arg RCC_MCO1SOURCE_PLLCLK: main PLL clock selected as MCO1 source
  * @param  __MCODIV__ specifies the MCO clock prescaler.
  *          This parameter can be one of the following values:
  *            @arg RCC_MCODIV_1: no division applied to MCOx clock
  *            @arg RCC_MCODIV_2: division by 2 applied to MCOx clock
  *            @arg RCC_MCODIV_3: division by 3 applied to MCOx clock
  *            @arg RCC_MCODIV_4: division by 4 applied to MCOx clock
  *            @arg RCC_MCODIV_5: division by 5 applied to MCOx clock
  */


/** @brief  Macro to configure the MCO2 clock.
  * @param  __MCOCLKSOURCE__ specifies the MCO clock source.
  *          This parameter can be one of the following values:
  *            @arg RCC_MCO2SOURCE_SYSCLK: System clock (SYSCLK) selected as MCO2 source
  *            @arg RCC_MCO2SOURCE_PLLI2SCLK: PLLI2S clock selected as MCO2 source, available for all STM32F4 devices except STM32F410xx
  *            @arg RCC_MCO2SOURCE_I2SCLK: I2SCLK clock selected as MCO2 source, available only for STM32F410Rx devices
  *            @arg RCC_MCO2SOURCE_HSE: HSE clock selected as MCO2 source
  *            @arg RCC_MCO2SOURCE_PLLCLK: main PLL clock selected as MCO2 source
  * @param  __MCODIV__ specifies the MCO clock prescaler.
  *          This parameter can be one of the following values:
  *            @arg RCC_MCODIV_1: no division applied to MCOx clock
  *            @arg RCC_MCODIV_2: division by 2 applied to MCOx clock
  *            @arg RCC_MCODIV_3: division by 3 applied to MCOx clock
  *            @arg RCC_MCODIV_4: division by 4 applied to MCOx clock
  *            @arg RCC_MCODIV_5: division by 5 applied to MCOx clock
  * @note  For STM32F410Rx devices, to output I2SCLK clock on MCO2, you should have
  *        at least one of the SPI clocks enabled (SPI1, SPI2 or SPI5).
  */

/**
  * @}
  */

/** @defgroup RCC_Flags_Interrupts_Management Flags Interrupts Management
  * @brief macros to manage the specified RCC Flags and interrupts.
  * @{
  */

/** @brief  Enable RCC interrupt (Perform Byte access to RCC_CIR[14:8] bits to enable
  *         the selected interrupts).
  * @param  __INTERRUPT__ specifies the RCC interrupt sources to be enabled.
  *         This parameter can be any combination of the following values:
  *            @arg RCC_IT_LSIRDY: LSI ready interrupt.
  *            @arg RCC_IT_LSERDY: LSE ready interrupt.
  *            @arg RCC_IT_HSIRDY: HSI ready interrupt.
  *            @arg RCC_IT_HSERDY: HSE ready interrupt.
  *            @arg RCC_IT_PLLRDY: Main PLL ready interrupt.
  *            @arg RCC_IT_PLLI2SRDY: PLLI2S ready interrupt.
  */


/** @brief Disable RCC interrupt (Perform Byte access to RCC_CIR[14:8] bits to disable
  *        the selected interrupts).
  * @param  __INTERRUPT__ specifies the RCC interrupt sources to be disabled.
  *         This parameter can be any combination of the following values:
  *            @arg RCC_IT_LSIRDY: LSI ready interrupt.
  *            @arg RCC_IT_LSERDY: LSE ready interrupt.
  *            @arg RCC_IT_HSIRDY: HSI ready interrupt.
  *            @arg RCC_IT_HSERDY: HSE ready interrupt.
  *            @arg RCC_IT_PLLRDY: Main PLL ready interrupt.
  *            @arg RCC_IT_PLLI2SRDY: PLLI2S ready interrupt.
  */


/** @brief  Clear the RCC's interrupt pending bits (Perform Byte access to RCC_CIR[23:16]
  *         bits to clear the selected interrupt pending bits.
  * @param  __INTERRUPT__ specifies the interrupt pending bit to clear.
  *         This parameter can be any combination of the following values:
  *            @arg RCC_IT_LSIRDY: LSI ready interrupt.
  *            @arg RCC_IT_LSERDY: LSE ready interrupt.
  *            @arg RCC_IT_HSIRDY: HSI ready interrupt.
  *            @arg RCC_IT_HSERDY: HSE ready interrupt.
  *            @arg RCC_IT_PLLRDY: Main PLL ready interrupt.
  *            @arg RCC_IT_PLLI2SRDY: PLLI2S ready interrupt.
  *            @arg RCC_IT_CSS: Clock Security System interrupt
  */


/** @brief  Check the RCC's interrupt has occurred or not.
  * @param  __INTERRUPT__ specifies the RCC interrupt source to check.
  *         This parameter can be one of the following values:
  *            @arg RCC_IT_LSIRDY: LSI ready interrupt.
  *            @arg RCC_IT_LSERDY: LSE ready interrupt.
  *            @arg RCC_IT_HSIRDY: HSI ready interrupt.
  *            @arg RCC_IT_HSERDY: HSE ready interrupt.
  *            @arg RCC_IT_PLLRDY: Main PLL ready interrupt.
  *            @arg RCC_IT_PLLI2SRDY: PLLI2S ready interrupt.
  *            @arg RCC_IT_CSS: Clock Security System interrupt
  * @retval The new state of __INTERRUPT__ (TRUE or FALSE).
  */


/** @brief Set RMVF bit to clear the reset flags: RCC_FLAG_PINRST, RCC_FLAG_PORRST,
  *        RCC_FLAG_SFTRST, RCC_FLAG_IWDGRST, RCC_FLAG_WWDGRST and RCC_FLAG_LPWRRST.
  */


/** @brief  Check RCC flag is set or not.
  * @param  __FLAG__ specifies the flag to check.
  *         This parameter can be one of the following values:
  *            @arg RCC_FLAG_HSIRDY: HSI oscillator clock ready.
  *            @arg RCC_FLAG_HSERDY: HSE oscillator clock ready.
  *            @arg RCC_FLAG_PLLRDY: Main PLL clock ready.
  *            @arg RCC_FLAG_PLLI2SRDY: PLLI2S clock ready.
  *            @arg RCC_FLAG_LSERDY: LSE oscillator clock ready.
  *            @arg RCC_FLAG_LSIRDY: LSI oscillator clock ready.
  *            @arg RCC_FLAG_BORRST: POR/PDR or BOR reset.
  *            @arg RCC_FLAG_PINRST: Pin reset.
  *            @arg RCC_FLAG_PORRST: POR/PDR reset.
  *            @arg RCC_FLAG_SFTRST: Software reset.
  *            @arg RCC_FLAG_IWDGRST: Independent Watchdog reset.
  *            @arg RCC_FLAG_WWDGRST: Window Watchdog reset.
  *            @arg RCC_FLAG_LPWRRST: Low Power reset.
  * @retval The new state of __FLAG__ (TRUE or FALSE).
  */



/**
  * @}
  */

/**
  * @}
  */

/* Exported functions --------------------------------------------------------*/
/** @addtogroup RCC_Exported_Functions
  * @{
 */

/** @addtogroup RCC_Exported_Functions_Group1
  * @{
  */
/* Initialization and de-initialization functions  ******************************/
HAL_StatusTypeDef HAL_RCC_DeInit(void);
HAL_StatusTypeDef HAL_RCC_OscConfig(const RCC_OscInitTypeDef *RCC_OscInitStruct);
HAL_StatusTypeDef HAL_RCC_ClockConfig(const RCC_ClkInitTypeDef *RCC_ClkInitStruct, uint32_t FLatency);
/**
  * @}
  */

/** @addtogroup RCC_Exported_Functions_Group2
  * @{
  */
/* Peripheral Control functions  ************************************************/
void     HAL_RCC_MCOConfig(uint32_t RCC_MCOx, uint32_t RCC_MCOSource, uint32_t RCC_MCODiv);
void     HAL_RCC_EnableCSS(void);
void     HAL_RCC_DisableCSS(void);
uint32_t HAL_RCC_GetSysClockFreq(void);
uint32_t HAL_RCC_GetHCLKFreq(void);
uint32_t HAL_RCC_GetPCLK1Freq(void);
uint32_t HAL_RCC_GetPCLK2Freq(void);
void     HAL_RCC_GetOscConfig(RCC_OscInitTypeDef *RCC_OscInitStruct);
void     HAL_RCC_GetClockConfig(RCC_ClkInitTypeDef *RCC_ClkInitStruct, uint32_t *pFLatency);

/* CSS NMI IRQ handler */
void HAL_RCC_NMI_IRQHandler(void);

/* User Callbacks in non blocking mode (IT mode) */
void HAL_RCC_CSSCallback(void);

/**
  * @}
  */

/**
  * @}
  */

/* Private types -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private constants ---------------------------------------------------------*/
/** @defgroup RCC_Private_Constants RCC Private Constants
  * @{
  */

/** @defgroup RCC_BitAddress_AliasRegion RCC BitAddress AliasRegion
  * @brief RCC registers bit address in the alias region
  * @{
  */

/* --- CR Register --- */
/* Alias word address of HSION bit */



/* Alias word address of CSSON bit */


/* Alias word address of PLLON bit */



/* --- BDCR Register --- */
/* Alias word address of RTCEN bit */



/* Alias word address of BDRST bit */



/* --- CSR Register --- */
/* Alias word address of LSION bit */




/* CR register byte 3 (Bits[23:16]) base address */


/* CIR register byte 2 (Bits[15:8]) base address */


/* CIR register byte 3 (Bits[23:16]) base address */


/* BDCR register base address */










/**
  * @}
  */

/**
  * @}
  */

/* Private macros ------------------------------------------------------------*/
/** @defgroup RCC_Private_Macros RCC Private Macros
  * @{
  */

/** @defgroup RCC_IS_RCC_Definitions RCC Private macros to check input parameters
  * @{
  */





































/**
  * @}
  */

/**
  * @}
  */

/**
  * @}
  */

/**
  * @}
  */










/**
  ******************************************************************************
  * @file    stm32f4xx_hal_gpio.h
  * @author  MCD Application Team
  * @brief   Header file of GPIO HAL module.
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2017 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */ 

/* Define to prevent recursive inclusion -------------------------------------*/






/* Includes ------------------------------------------------------------------*/
/**
  ******************************************************************************
  * @file    stm32f4xx_hal_def.h
  * @author  MCD Application Team
  * @brief   This file contains HAL common defines, enumeration, macros and 
  *          structures definitions. 
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2017 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/

















































































/** @addtogroup STM32F4xx_HAL_Driver
  * @{
  */

/** @addtogroup GPIO
  * @{
  */ 

/* Exported types ------------------------------------------------------------*/
/** @defgroup GPIO_Exported_Types GPIO Exported Types
  * @{
  */

/** 
  * @brief GPIO Init structure definition  
  */ 
typedef struct
{
  uint32_t Pin;       /*!< Specifies the GPIO pins to be configured.
                           This parameter can be any value of @ref GPIO_pins_define */

  uint32_t Mode;      /*!< Specifies the operating mode for the selected pins.
                           This parameter can be a value of @ref GPIO_mode_define */

  uint32_t Pull;      /*!< Specifies the Pull-up or Pull-Down activation for the selected pins.
                           This parameter can be a value of @ref GPIO_pull_define */

  uint32_t Speed;     /*!< Specifies the speed for the selected pins.
                           This parameter can be a value of @ref GPIO_speed_define */

  uint32_t Alternate;  /*!< Peripheral to be connected to the selected pins. 
                            This parameter can be a value of @ref GPIO_Alternate_function_selection */
}GPIO_InitTypeDef;

/** 
  * @brief  GPIO Bit SET and Bit RESET enumeration 
  */
typedef enum
{
  GPIO_PIN_RESET = 0,
  GPIO_PIN_SET
}GPIO_PinState;
/**
  * @}
  */

/* Exported constants --------------------------------------------------------*/

/** @defgroup GPIO_Exported_Constants GPIO Exported Constants
  * @{
  */ 

/** @defgroup GPIO_pins_define GPIO pins define
  * @{
  */



















/**
  * @}
  */

/** @defgroup GPIO_mode_define GPIO mode define
  * @brief GPIO Configuration Mode
  *        Elements values convention: 0x00WX00YZ
  *           - W  : EXTI trigger detection on 3 bits
  *           - X  : EXTI mode (IT or Event) on 2 bits
  *           - Y  : Output type (Push Pull or Open Drain) on 1 bit
  *           - Z  : GPIO mode (Input, Output, Alternate or Analog) on 2 bits
  * @{
  */ 







    



 




/**
  * @}
  */

/** @defgroup GPIO_speed_define  GPIO speed define
  * @brief GPIO Output Maximum frequency
  * @{
  */




/**
  * @}
  */

 /** @defgroup GPIO_pull_define GPIO pull define
   * @brief GPIO Pull-Up or Pull-Down Activation
   * @{
   */  



/**
  * @}
  */
  
/**
  * @}
  */

/* Exported macro ------------------------------------------------------------*/
/** @defgroup GPIO_Exported_Macros GPIO Exported Macros
  * @{
  */

/**
  * @brief  Checks whether the specified EXTI line flag is set or not.
  * @param  __EXTI_LINE__ specifies the EXTI line flag to check.
  *         This parameter can be GPIO_PIN_x where x can be(0..15)
  * @retval The new state of __EXTI_LINE__ (SET or RESET).
  */


/**
  * @brief  Clears the EXTI's line pending flags.
  * @param  __EXTI_LINE__ specifies the EXTI lines flags to clear.
  *         This parameter can be any combination of GPIO_PIN_x where x can be (0..15)
  * @retval None
  */


/**
  * @brief  Checks whether the specified EXTI line is asserted or not.
  * @param  __EXTI_LINE__ specifies the EXTI line to check.
  *          This parameter can be GPIO_PIN_x where x can be(0..15)
  * @retval The new state of __EXTI_LINE__ (SET or RESET).
  */


/**
  * @brief  Clears the EXTI's line pending bits.
  * @param  __EXTI_LINE__ specifies the EXTI lines to clear.
  *          This parameter can be any combination of GPIO_PIN_x where x can be (0..15)
  * @retval None
  */


/**
  * @brief  Generates a Software interrupt on selected EXTI line.
  * @param  __EXTI_LINE__ specifies the EXTI line to check.
  *          This parameter can be GPIO_PIN_x where x can be(0..15)
  * @retval None
  */

/**
  * @}
  */

/* Include GPIO HAL Extension module */
/**
  ******************************************************************************
  * @file    stm32f4xx_hal_gpio_ex.h
  * @author  MCD Application Team
  * @brief   Header file of GPIO HAL Extension module.
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2017 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */ 

/* Define to prevent recursive inclusion -------------------------------------*/






/* Includes ------------------------------------------------------------------*/
/**
  ******************************************************************************
  * @file    stm32f4xx_hal_def.h
  * @author  MCD Application Team
  * @brief   This file contains HAL common defines, enumeration, macros and 
  *          structures definitions. 
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2017 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/

















































































/** @addtogroup STM32F4xx_HAL_Driver
  * @{
  */

/** @defgroup GPIOEx GPIOEx
  * @{
  */ 

/* Exported types ------------------------------------------------------------*/
/* Exported constants --------------------------------------------------------*/
/** @defgroup GPIOEx_Exported_Constants GPIO Exported Constants
  * @{
  */
  
/** @defgroup GPIO_Alternate_function_selection GPIO Alternate Function Selection
  * @{
  */

/*------------------------------------------ STM32F429xx/STM32F439xx ---------*/





















































/*----------------------------------------------------------------------------*/

/*---------------------------------- STM32F427xx/STM32F437xx------------------*/



















































/*----------------------------------------------------------------------------*/

/*---------------------------------- STM32F407xx/STM32F417xx------------------*/












































/*----------------------------------------------------------------------------*/

/*---------------------------------- STM32F405xx/STM32F415xx------------------*/











































/*----------------------------------------------------------------------------*/

/*---------------------------------------- STM32F401xx------------------------*/

/** 
  * @brief   AF 0 selection  
  */ 






/** 
  * @brief   AF 1 selection  
  */ 



/** 
  * @brief   AF 2 selection  
  */ 




/** 
  * @brief   AF 3 selection  
  */ 




/** 
  * @brief   AF 4 selection  
  */ 




/** 
  * @brief   AF 5 selection  
  */ 






/** 
  * @brief   AF 6 selection  
  */ 



/** 
  * @brief   AF 7 selection  
  */ 




/** 
  * @brief   AF 8 selection  
  */ 


/** 
  * @brief   AF 9 selection 
  */ 




/** 
  * @brief   AF 10 selection  
  */ 


/** 
  * @brief   AF 12 selection  
  */ 


/** 
  * @brief   AF 15 selection  
  */ 


/*----------------------------------------------------------------------------*/

/*--------------- STM32F412Zx/STM32F412Vx/STM32F412Rx/STM32F412Cx-------------*/

























































/*----------------------------------------------------------------------------*/

/*--------------- STM32F413xx/STM32F423xx-------------------------------------*/









































































/*---------------------------------------- STM32F411xx------------------------*/








































/*---------------------------------------- STM32F410xx------------------------*/































/*---------------------------------------- STM32F446xx -----------------------*/


























































/*----------------------------------------------------------------------------*/

/*-------------------------------- STM32F469xx/STM32F479xx--------------------*/
























































/*----------------------------------------------------------------------------*/
/**
  * @}
  */ 

/**
  * @}
  */

/* Exported macro ------------------------------------------------------------*/
/** @defgroup GPIOEx_Exported_Macros GPIO Exported Macros
  * @{
  */
/**
  * @}
  */

/* Exported functions --------------------------------------------------------*/
/** @defgroup GPIOEx_Exported_Functions GPIO Exported Functions
  * @{
  */
/**
  * @}
  */

/* Private types -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private constants ---------------------------------------------------------*/
/** @defgroup GPIOEx_Private_Constants GPIO Private Constants
  * @{
  */
/**
  * @}
  */

/* Private macros ------------------------------------------------------------*/
/** @defgroup GPIOEx_Private_Macros GPIO Private Macros
  * @{
  */
/** @defgroup GPIOEx_Get_Port_Index GPIO Get Port Index
  * @{
  */





























/**
  * @}
  */

/** @defgroup GPIOEx_IS_Alternat_function_selection GPIO Check Alternate Function
  * @{
  */  
/*------------------------- STM32F429xx/STM32F439xx---------------------------*/



/*----------------------------------------------------------------------------*/

/*---------------------------------- STM32F427xx/STM32F437xx------------------*/



/*----------------------------------------------------------------------------*/

/*---------------------------------- STM32F407xx/STM32F417xx------------------*/



/*----------------------------------------------------------------------------*/

/*---------------------------------- STM32F405xx/STM32F415xx------------------*/




/*----------------------------------------------------------------------------*/

/*---------------------------------------- STM32F401xx------------------------*/



/*----------------------------------------------------------------------------*/
/*---------------------------------------- STM32F410xx------------------------*/




/*---------------------------------------- STM32F411xx------------------------*/



/*----------------------------------------------------------------------------*/

/*----------------------------------------------- STM32F446xx ----------------*/



/*----------------------------------------------------------------------------*/

/*------------------------------------------- STM32F469xx/STM32F479xx --------*/



/*----------------------------------------------------------------------------*/

/*------------------STM32F412Zx/STM32F412Vx/STM32F412Rx/STM32F412Cx-----------*/



/*----------------------------------------------------------------------------*/

/*------------------STM32F413xx/STM32F423xx-----------------------------------*/



/*----------------------------------------------------------------------------*/

/**
  * @}
  */ 

/**
  * @}
  */

/* Private functions ---------------------------------------------------------*/
/** @defgroup GPIOEx_Private_Functions GPIO Private Functions
  * @{
  */

/**
  * @}
  */

/**
  * @}
  */ 

/**
  * @}
  */ 
  







/* Exported functions --------------------------------------------------------*/
/** @addtogroup GPIO_Exported_Functions
  * @{
  */

/** @addtogroup GPIO_Exported_Functions_Group1
  * @{
  */
/* Initialization and de-initialization functions *****************************/
void  HAL_GPIO_Init(GPIO_TypeDef  *GPIOx, GPIO_InitTypeDef *GPIO_Init);
void  HAL_GPIO_DeInit(GPIO_TypeDef  *GPIOx, uint32_t GPIO_Pin);
/**
  * @}
  */

/** @addtogroup GPIO_Exported_Functions_Group2
  * @{
  */
/* IO operation functions *****************************************************/
GPIO_PinState HAL_GPIO_ReadPin(GPIO_TypeDef* GPIOx, uint16_t GPIO_Pin);
void HAL_GPIO_WritePin(GPIO_TypeDef* GPIOx, uint16_t GPIO_Pin, GPIO_PinState PinState);
void HAL_GPIO_TogglePin(GPIO_TypeDef* GPIOx, uint16_t GPIO_Pin);
HAL_StatusTypeDef HAL_GPIO_LockPin(GPIO_TypeDef* GPIOx, uint16_t GPIO_Pin);
void HAL_GPIO_EXTI_IRQHandler(uint16_t GPIO_Pin);
void HAL_GPIO_EXTI_Callback(uint16_t GPIO_Pin);

/**
  * @}
  */ 

/**
  * @}
  */ 
/* Private types -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private constants ---------------------------------------------------------*/
/** @defgroup GPIO_Private_Constants GPIO Private Constants
  * @{
  */



















/**
  * @}
  */

/* Private macros ------------------------------------------------------------*/
/** @defgroup GPIO_Private_Macros GPIO Private Macros
  * @{
  */





/**
  * @}
  */

/* Private functions ---------------------------------------------------------*/
/** @defgroup GPIO_Private_Functions GPIO Private Functions
  * @{
  */

/**
  * @}
  */

/**
  * @}
  */ 

/**
  * @}
  */










/**
  ******************************************************************************
  * @file    stm32f4xx_hal_exti.h
  * @author  MCD Application Team
  * @brief   Header file of EXTI HAL module.
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2018 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.Clause
  *
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/






/* Includes ------------------------------------------------------------------*/
/**
  ******************************************************************************
  * @file    stm32f4xx_hal_def.h
  * @author  MCD Application Team
  * @brief   This file contains HAL common defines, enumeration, macros and 
  *          structures definitions. 
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2017 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/

















































































/** @addtogroup STM32F4xx_HAL_Driver
  * @{
  */

/** @defgroup EXTI EXTI
  * @brief EXTI HAL module driver
  * @{
  */

/* Exported types ------------------------------------------------------------*/

/** @defgroup EXTI_Exported_Types EXTI Exported Types
  * @{
  */
typedef enum
{
  HAL_EXTI_COMMON_CB_ID          = 0x00U
} EXTI_CallbackIDTypeDef;

/**
  * @brief  EXTI Handle structure definition
  */
typedef struct
{
  uint32_t Line;                    /*!<  Exti line number */
  void (* PendingCallback)(void);   /*!<  Exti pending callback */
} EXTI_HandleTypeDef;

/**
  * @brief  EXTI Configuration structure definition
  */
typedef struct
{
  uint32_t Line;      /*!< The Exti line to be configured. This parameter
                           can be a value of @ref EXTI_Line */
  uint32_t Mode;      /*!< The Exit Mode to be configured for a core.
                           This parameter can be a combination of @ref EXTI_Mode */
  uint32_t Trigger;   /*!< The Exti Trigger to be configured. This parameter
                           can be a value of @ref EXTI_Trigger */
  uint32_t GPIOSel;   /*!< The Exti GPIO multiplexer selection to be configured.
                           This parameter is only possible for line 0 to 15. It
                           can be a value of @ref EXTI_GPIOSel */
} EXTI_ConfigTypeDef;

/**
  * @}
  */

/* Exported constants --------------------------------------------------------*/
/** @defgroup EXTI_Exported_Constants EXTI Exported Constants
  * @{
  */

/** @defgroup EXTI_Line  EXTI Line
  * @{
  */







































/**
  * @}
  */

/** @defgroup EXTI_Mode  EXTI Mode
  * @{
  */



/**
  * @}
  */

/** @defgroup EXTI_Trigger  EXTI Trigger
  * @{
  */





/**
  * @}
  */

/** @defgroup EXTI_GPIOSel  EXTI GPIOSel
  * @brief
  * @{
  */




























/**
  * @}
  */

/**
  * @}
  */

/* Exported macro ------------------------------------------------------------*/
/** @defgroup EXTI_Exported_Macros EXTI Exported Macros
  * @{
  */

/**
  * @}
  */

/* Private constants --------------------------------------------------------*/
/** @defgroup EXTI_Private_Constants EXTI Private Constants
  * @{
  */
/**
  * @brief  EXTI Line property definition
  */






/**
  * @brief  EXTI bit usage
  */


/**
  * @brief  EXTI Mask for interrupt & event mode
  */


/**
  * @brief  EXTI Mask for trigger possibilities
  */


/**
  * @brief  EXTI Line number
  */






/**
  * @}
  */

/* Private macros ------------------------------------------------------------*/
/** @defgroup EXTI_Private_Macros EXTI Private Macros
  * @{
  */

























/**
  * @}
  */

/* Exported functions --------------------------------------------------------*/
/** @defgroup EXTI_Exported_Functions EXTI Exported Functions
  * @brief    EXTI Exported Functions
  * @{
  */

/** @defgroup EXTI_Exported_Functions_Group1 Configuration functions
  * @brief    Configuration functions
  * @{
  */
/* Configuration functions ****************************************************/
HAL_StatusTypeDef HAL_EXTI_SetConfigLine(EXTI_HandleTypeDef *hexti, EXTI_ConfigTypeDef *pExtiConfig);
HAL_StatusTypeDef HAL_EXTI_GetConfigLine(EXTI_HandleTypeDef *hexti, EXTI_ConfigTypeDef *pExtiConfig);
HAL_StatusTypeDef HAL_EXTI_ClearConfigLine(EXTI_HandleTypeDef *hexti);
HAL_StatusTypeDef HAL_EXTI_RegisterCallback(EXTI_HandleTypeDef *hexti, EXTI_CallbackIDTypeDef CallbackID, void (*pPendingCbfn)(void));
HAL_StatusTypeDef HAL_EXTI_GetHandle(EXTI_HandleTypeDef *hexti, uint32_t ExtiLine);
/**
  * @}
  */

/** @defgroup EXTI_Exported_Functions_Group2 IO operation functions
  * @brief    IO operation functions
  * @{
  */
/* IO operation functions *****************************************************/
void HAL_EXTI_IRQHandler(EXTI_HandleTypeDef *hexti);
uint32_t HAL_EXTI_GetPending(EXTI_HandleTypeDef *hexti, uint32_t Edge);
void HAL_EXTI_ClearPending(EXTI_HandleTypeDef *hexti, uint32_t Edge);
void HAL_EXTI_GenerateSWI(EXTI_HandleTypeDef *hexti);

/**
  * @}
  */

/**
  * @}
  */

/**
  * @}
  */

/**
  * @}
  */










/**
  ******************************************************************************
  * @file    stm32f4xx_hal_dma.h
  * @author  MCD Application Team
  * @brief   Header file of DMA HAL module.
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2017 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file in
  * the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */ 

/* Define to prevent recursive inclusion -------------------------------------*/






/* Includes ------------------------------------------------------------------*/
/**
  ******************************************************************************
  * @file    stm32f4xx_hal_def.h
  * @author  MCD Application Team
  * @brief   This file contains HAL common defines, enumeration, macros and 
  *          structures definitions. 
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2017 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/

















































































/** @addtogroup STM32F4xx_HAL_Driver
  * @{
  */

/** @addtogroup DMA
  * @{
  */ 

/* Exported types ------------------------------------------------------------*/

/** @defgroup DMA_Exported_Types DMA Exported Types
  * @brief    DMA Exported Types 
  * @{
  */
   
/** 
  * @brief  DMA Configuration Structure definition
  */
typedef struct
{
  uint32_t Channel;              /*!< Specifies the channel used for the specified stream. 
                                      This parameter can be a value of @ref DMA_Channel_selection                    */

  uint32_t Direction;            /*!< Specifies if the data will be transferred from memory to peripheral, 
                                      from memory to memory or from peripheral to memory.
                                      This parameter can be a value of @ref DMA_Data_transfer_direction              */

  uint32_t PeriphInc;            /*!< Specifies whether the Peripheral address register should be incremented or not.
                                      This parameter can be a value of @ref DMA_Peripheral_incremented_mode          */

  uint32_t MemInc;               /*!< Specifies whether the memory address register should be incremented or not.
                                      This parameter can be a value of @ref DMA_Memory_incremented_mode              */

  uint32_t PeriphDataAlignment;  /*!< Specifies the Peripheral data width.
                                      This parameter can be a value of @ref DMA_Peripheral_data_size                 */

  uint32_t MemDataAlignment;     /*!< Specifies the Memory data width.
                                      This parameter can be a value of @ref DMA_Memory_data_size                     */

  uint32_t Mode;                 /*!< Specifies the operation mode of the DMAy Streamx.
                                      This parameter can be a value of @ref DMA_mode
                                      @note The circular buffer mode cannot be used if the memory-to-memory
                                            data transfer is configured on the selected Stream                        */

  uint32_t Priority;             /*!< Specifies the software priority for the DMAy Streamx.
                                      This parameter can be a value of @ref DMA_Priority_level                       */

  uint32_t FIFOMode;             /*!< Specifies if the FIFO mode or Direct mode will be used for the specified stream.
                                      This parameter can be a value of @ref DMA_FIFO_direct_mode
                                      @note The Direct mode (FIFO mode disabled) cannot be used if the 
                                            memory-to-memory data transfer is configured on the selected stream       */

  uint32_t FIFOThreshold;        /*!< Specifies the FIFO threshold level.
                                      This parameter can be a value of @ref DMA_FIFO_threshold_level                  */

  uint32_t MemBurst;             /*!< Specifies the Burst transfer configuration for the memory transfers. 
                                      It specifies the amount of data to be transferred in a single non interruptible
                                      transaction.
                                      This parameter can be a value of @ref DMA_Memory_burst 
                                      @note The burst mode is possible only if the address Increment mode is enabled. */

  uint32_t PeriphBurst;          /*!< Specifies the Burst transfer configuration for the peripheral transfers. 
                                      It specifies the amount of data to be transferred in a single non interruptible 
                                      transaction. 
                                      This parameter can be a value of @ref DMA_Peripheral_burst
                                      @note The burst mode is possible only if the address Increment mode is enabled. */
}DMA_InitTypeDef;


/** 
  * @brief  HAL DMA State structures definition
  */
typedef enum
{
  HAL_DMA_STATE_RESET             = 0x00U,  /*!< DMA not yet initialized or disabled */
  HAL_DMA_STATE_READY             = 0x01U,  /*!< DMA initialized and ready for use   */
  HAL_DMA_STATE_BUSY              = 0x02U,  /*!< DMA process is ongoing              */
  HAL_DMA_STATE_TIMEOUT           = 0x03U,  /*!< DMA timeout state                   */
  HAL_DMA_STATE_ERROR             = 0x04U,  /*!< DMA error state                     */
  HAL_DMA_STATE_ABORT             = 0x05U,  /*!< DMA Abort state                     */
}HAL_DMA_StateTypeDef;

/** 
  * @brief  HAL DMA Error Code structure definition
  */
typedef enum
{
  HAL_DMA_FULL_TRANSFER           = 0x00U,  /*!< Full transfer     */
  HAL_DMA_HALF_TRANSFER           = 0x01U   /*!< Half Transfer     */
}HAL_DMA_LevelCompleteTypeDef;

/** 
  * @brief  HAL DMA Error Code structure definition
  */
typedef enum
{
  HAL_DMA_XFER_CPLT_CB_ID         = 0x00U,  /*!< Full transfer     */
  HAL_DMA_XFER_HALFCPLT_CB_ID     = 0x01U,  /*!< Half Transfer     */
  HAL_DMA_XFER_M1CPLT_CB_ID       = 0x02U,  /*!< M1 Full Transfer  */
  HAL_DMA_XFER_M1HALFCPLT_CB_ID   = 0x03U,  /*!< M1 Half Transfer  */
  HAL_DMA_XFER_ERROR_CB_ID        = 0x04U,  /*!< Error             */
  HAL_DMA_XFER_ABORT_CB_ID        = 0x05U,  /*!< Abort             */
  HAL_DMA_XFER_ALL_CB_ID          = 0x06U   /*!< All               */
}HAL_DMA_CallbackIDTypeDef;

/** 
  * @brief  DMA handle Structure definition
  */
typedef struct __DMA_HandleTypeDef
{
  DMA_Stream_TypeDef         *Instance;                                                        /*!< Register base address                  */

  DMA_InitTypeDef            Init;                                                             /*!< DMA communication parameters           */ 

  HAL_LockTypeDef            Lock;                                                             /*!< DMA locking object                     */  

  volatile HAL_DMA_StateTypeDef  State;                                                            /*!< DMA transfer state                     */

  void                       *Parent;                                                          /*!< Parent object state                    */ 

  void                       (* XferCpltCallback)( struct __DMA_HandleTypeDef * hdma);         /*!< DMA transfer complete callback         */

  void                       (* XferHalfCpltCallback)( struct __DMA_HandleTypeDef * hdma);     /*!< DMA Half transfer complete callback    */

  void                       (* XferM1CpltCallback)( struct __DMA_HandleTypeDef * hdma);       /*!< DMA transfer complete Memory1 callback */
  
  void                       (* XferM1HalfCpltCallback)( struct __DMA_HandleTypeDef * hdma);   /*!< DMA transfer Half complete Memory1 callback */
  
  void                       (* XferErrorCallback)( struct __DMA_HandleTypeDef * hdma);        /*!< DMA transfer error callback            */
  
  void                       (* XferAbortCallback)( struct __DMA_HandleTypeDef * hdma);        /*!< DMA transfer Abort callback            */  

  volatile uint32_t              ErrorCode;                                                        /*!< DMA Error code                          */
  
  uint32_t                   StreamBaseAddress;                                                /*!< DMA Stream Base Address                */

  uint32_t                   StreamIndex;                                                      /*!< DMA Stream Index                       */
 
}DMA_HandleTypeDef;

/**
  * @}
  */

/* Exported constants --------------------------------------------------------*/

/** @defgroup DMA_Exported_Constants DMA Exported Constants
  * @brief    DMA Exported constants 
  * @{
  */

/** @defgroup DMA_Error_Code DMA Error Code
  * @brief    DMA Error Code 
  * @{
  */ 








/**
  * @}
  */

/** @defgroup DMA_Channel_selection DMA Channel selection
  * @brief    DMA channel selection 
  * @{
  */ 


















/**
  * @}
  */

/** @defgroup DMA_Data_transfer_direction DMA Data transfer direction
  * @brief    DMA data transfer direction 
  * @{
  */ 



/**
  * @}
  */
        
/** @defgroup DMA_Peripheral_incremented_mode DMA Peripheral incremented mode
  * @brief    DMA peripheral incremented mode 
  * @{
  */ 


/**
  * @}
  */ 

/** @defgroup DMA_Memory_incremented_mode DMA Memory incremented mode
  * @brief    DMA memory incremented mode 
  * @{
  */ 


/**
  * @}
  */

/** @defgroup DMA_Peripheral_data_size DMA Peripheral data size
  * @brief    DMA peripheral data size 
  * @{
  */ 



/**
  * @}
  */ 

/** @defgroup DMA_Memory_data_size DMA Memory data size
  * @brief    DMA memory data size 
  * @{ 
  */



/**
  * @}
  */

/** @defgroup DMA_mode DMA mode
  * @brief    DMA mode 
  * @{
  */ 



/**
  * @}
  */

/** @defgroup DMA_Priority_level DMA Priority level
  * @brief    DMA priority levels 
  * @{
  */




/**
  * @}
  */ 

/** @defgroup DMA_FIFO_direct_mode DMA FIFO direct mode
  * @brief    DMA FIFO direct mode
  * @{
  */


/**
  * @}
  */ 

/** @defgroup DMA_FIFO_threshold_level DMA FIFO threshold level
  * @brief    DMA FIFO level 
  * @{
  */




/**
  * @}
  */ 

/** @defgroup DMA_Memory_burst DMA Memory burst
  * @brief    DMA memory burst 
  * @{
  */ 




/**
  * @}
  */ 

/** @defgroup DMA_Peripheral_burst DMA Peripheral burst
  * @brief    DMA peripheral burst 
  * @{
  */ 




/**
  * @}
  */

/** @defgroup DMA_interrupt_enable_definitions DMA interrupt enable definitions
  * @brief    DMA interrupts definition 
  * @{
  */





/**
  * @}
  */

/** @defgroup DMA_flag_definitions DMA flag definitions
  * @brief    DMA flag definitions 
  * @{
  */ 




















/**
  * @}
  */

/**
  * @}
  */
 
/* Exported macro ------------------------------------------------------------*/

/** @brief Reset DMA handle state
  * @param  __HANDLE__ specifies the DMA handle.
  * @retval None
  */


/**
  * @brief  Return the current DMA Stream FIFO filled level.
  * @param  __HANDLE__ DMA handle
  * @retval The FIFO filling state.
  *           - DMA_FIFOStatus_Less1QuarterFull: when FIFO is less than 1 quarter-full 
  *                                              and not empty.
  *           - DMA_FIFOStatus_1QuarterFull: if more than 1 quarter-full.
  *           - DMA_FIFOStatus_HalfFull: if more than 1 half-full.
  *           - DMA_FIFOStatus_3QuartersFull: if more than 3 quarters-full.
  *           - DMA_FIFOStatus_Empty: when FIFO is empty
  *           - DMA_FIFOStatus_Full: when FIFO is full
  */


/**
  * @brief  Enable the specified DMA Stream.
  * @param  __HANDLE__ DMA handle
  * @retval None
  */


/**
  * @brief  Disable the specified DMA Stream.
  * @param  __HANDLE__ DMA handle
  * @retval None
  */


/* Interrupt & Flag management */

/**
  * @brief  Return the current DMA Stream transfer complete flag.
  * @param  __HANDLE__ DMA handle
  * @retval The specified transfer complete flag index.
  */


/**
  * @brief  Return the current DMA Stream half transfer complete flag.
  * @param  __HANDLE__ DMA handle
  * @retval The specified half transfer complete flag index.
  */      


/**
  * @brief  Return the current DMA Stream transfer error flag.
  * @param  __HANDLE__ DMA handle
  * @retval The specified transfer error flag index.
  */


/**
  * @brief  Return the current DMA Stream FIFO error flag.
  * @param  __HANDLE__ DMA handle
  * @retval The specified FIFO error flag index.
  */


/**
  * @brief  Return the current DMA Stream direct mode error flag.
  * @param  __HANDLE__ DMA handle
  * @retval The specified direct mode error flag index.
  */


/**
  * @brief  Get the DMA Stream pending flags.
  * @param  __HANDLE__ DMA handle
  * @param  __FLAG__ Get the specified flag.
  *          This parameter can be any combination of the following values:
  *            @arg DMA_FLAG_TCIFx: Transfer complete flag.
  *            @arg DMA_FLAG_HTIFx: Half transfer complete flag.
  *            @arg DMA_FLAG_TEIFx: Transfer error flag.
  *            @arg DMA_FLAG_DMEIFx: Direct mode error flag.
  *            @arg DMA_FLAG_FEIFx: FIFO error flag.
  *         Where x can be 0_4, 1_5, 2_6 or 3_7 to select the DMA Stream flag.   
  * @retval The state of FLAG (SET or RESET).
  */


/**
  * @brief  Clear the DMA Stream pending flags.
  * @param  __HANDLE__ DMA handle
  * @param  __FLAG__ specifies the flag to clear.
  *          This parameter can be any combination of the following values:
  *            @arg DMA_FLAG_TCIFx: Transfer complete flag.
  *            @arg DMA_FLAG_HTIFx: Half transfer complete flag.
  *            @arg DMA_FLAG_TEIFx: Transfer error flag.
  *            @arg DMA_FLAG_DMEIFx: Direct mode error flag.
  *            @arg DMA_FLAG_FEIFx: FIFO error flag.
  *         Where x can be 0_4, 1_5, 2_6 or 3_7 to select the DMA Stream flag.   
  * @retval None
  */


/**
  * @brief  Enable the specified DMA Stream interrupts.
  * @param  __HANDLE__ DMA handle
  * @param  __INTERRUPT__ specifies the DMA interrupt sources to be enabled or disabled. 
  *        This parameter can be any combination of the following values:
  *           @arg DMA_IT_TC: Transfer complete interrupt mask.
  *           @arg DMA_IT_HT: Half transfer complete interrupt mask.
  *           @arg DMA_IT_TE: Transfer error interrupt mask.
  *           @arg DMA_IT_FE: FIFO error interrupt mask.
  *           @arg DMA_IT_DME: Direct mode error interrupt.
  * @retval None
  */


/**
  * @brief  Disable the specified DMA Stream interrupts.
  * @param  __HANDLE__ DMA handle
  * @param  __INTERRUPT__ specifies the DMA interrupt sources to be enabled or disabled. 
  *         This parameter can be any combination of the following values:
  *            @arg DMA_IT_TC: Transfer complete interrupt mask.
  *            @arg DMA_IT_HT: Half transfer complete interrupt mask.
  *            @arg DMA_IT_TE: Transfer error interrupt mask.
  *            @arg DMA_IT_FE: FIFO error interrupt mask.
  *            @arg DMA_IT_DME: Direct mode error interrupt.
  * @retval None
  */


/**
  * @brief  Check whether the specified DMA Stream interrupt is enabled or disabled.
  * @param  __HANDLE__ DMA handle
  * @param  __INTERRUPT__ specifies the DMA interrupt source to check.
  *         This parameter can be one of the following values:
  *            @arg DMA_IT_TC: Transfer complete interrupt mask.
  *            @arg DMA_IT_HT: Half transfer complete interrupt mask.
  *            @arg DMA_IT_TE: Transfer error interrupt mask.
  *            @arg DMA_IT_FE: FIFO error interrupt mask.
  *            @arg DMA_IT_DME: Direct mode error interrupt.
  * @retval The state of DMA_IT.
  */


/**
  * @brief  Writes the number of data units to be transferred on the DMA Stream.
  * @param  __HANDLE__ DMA handle
  * @param  __COUNTER__ Number of data units to be transferred (from 0 to 65535) 
  *          Number of data items depends only on the Peripheral data format.
  *            
  * @note   If Peripheral data format is Bytes: number of data units is equal 
  *         to total number of bytes to be transferred.
  *           
  * @note   If Peripheral data format is Half-Word: number of data units is  
  *         equal to total number of bytes to be transferred / 2.
  *           
  * @note   If Peripheral data format is Word: number of data units is equal 
  *         to total  number of bytes to be transferred / 4.
  *      
  * @retval The number of remaining data units in the current DMAy Streamx transfer.
  */


/**
  * @brief  Returns the number of remaining data units in the current DMAy Streamx transfer.
  * @param  __HANDLE__ DMA handle
  *   
  * @retval The number of remaining data units in the current DMA Stream transfer.
  */



/* Include DMA HAL Extension module */
/**
  ******************************************************************************
  * @file    stm32f4xx_hal_dma_ex.h
  * @author  MCD Application Team
  * @brief   Header file of DMA HAL extension module.
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2017 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file in
  * the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/






/* Includes ------------------------------------------------------------------*/
/**
  ******************************************************************************
  * @file    stm32f4xx_hal_def.h
  * @author  MCD Application Team
  * @brief   This file contains HAL common defines, enumeration, macros and 
  *          structures definitions. 
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2017 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/

















































































/** @addtogroup STM32F4xx_HAL_Driver
  * @{
  */

/** @addtogroup DMAEx
  * @{
  */ 

/* Exported types ------------------------------------------------------------*/
/** @defgroup DMAEx_Exported_Types DMAEx Exported Types
  * @brief DMAEx Exported types
  * @{
  */
   
/** 
  * @brief  HAL DMA Memory definition  
  */ 
typedef enum
{
  MEMORY0      = 0x00U,    /*!< Memory 0     */
  MEMORY1      = 0x01U     /*!< Memory 1     */
}HAL_DMA_MemoryTypeDef;

/**
  * @}
  */

/* Exported functions --------------------------------------------------------*/
/** @defgroup DMAEx_Exported_Functions DMAEx Exported Functions
  * @brief   DMAEx Exported functions
  * @{
  */

/** @defgroup DMAEx_Exported_Functions_Group1 Extended features functions
  * @brief   Extended features functions
  * @{
  */

/* IO operation functions *******************************************************/
HAL_StatusTypeDef HAL_DMAEx_MultiBufferStart(DMA_HandleTypeDef *hdma, uint32_t SrcAddress, uint32_t DstAddress, uint32_t SecondMemAddress, uint32_t DataLength);
HAL_StatusTypeDef HAL_DMAEx_MultiBufferStart_IT(DMA_HandleTypeDef *hdma, uint32_t SrcAddress, uint32_t DstAddress, uint32_t SecondMemAddress, uint32_t DataLength);
HAL_StatusTypeDef HAL_DMAEx_ChangeMemory(DMA_HandleTypeDef *hdma, uint32_t Address, HAL_DMA_MemoryTypeDef memory);

/**
  * @}
  */
/**
  * @}
  */
         
/* Private functions ---------------------------------------------------------*/
/** @defgroup DMAEx_Private_Functions DMAEx Private Functions
  * @brief DMAEx Private functions
  * @{
  */
/**
  * @}
  */

/**
  * @}
  */

/**
  * @}
  */








/* Exported functions --------------------------------------------------------*/

/** @defgroup DMA_Exported_Functions DMA Exported Functions
  * @brief    DMA Exported functions 
  * @{
  */

/** @defgroup DMA_Exported_Functions_Group1 Initialization and de-initialization functions
  * @brief   Initialization and de-initialization functions 
  * @{
  */
HAL_StatusTypeDef HAL_DMA_Init(DMA_HandleTypeDef *hdma); 
HAL_StatusTypeDef HAL_DMA_DeInit(DMA_HandleTypeDef *hdma);
/**
  * @}
  */

/** @defgroup DMA_Exported_Functions_Group2 I/O operation functions
  * @brief   I/O operation functions  
  * @{
  */
HAL_StatusTypeDef HAL_DMA_Start (DMA_HandleTypeDef *hdma, uint32_t SrcAddress, uint32_t DstAddress, uint32_t DataLength);
HAL_StatusTypeDef HAL_DMA_Start_IT(DMA_HandleTypeDef *hdma, uint32_t SrcAddress, uint32_t DstAddress, uint32_t DataLength);
HAL_StatusTypeDef HAL_DMA_Abort(DMA_HandleTypeDef *hdma);
HAL_StatusTypeDef HAL_DMA_Abort_IT(DMA_HandleTypeDef *hdma);
HAL_StatusTypeDef HAL_DMA_PollForTransfer(DMA_HandleTypeDef *hdma, HAL_DMA_LevelCompleteTypeDef CompleteLevel, uint32_t Timeout);
void              HAL_DMA_IRQHandler(DMA_HandleTypeDef *hdma);
HAL_StatusTypeDef HAL_DMA_CleanCallbacks(DMA_HandleTypeDef *hdma);
HAL_StatusTypeDef HAL_DMA_RegisterCallback(DMA_HandleTypeDef *hdma, HAL_DMA_CallbackIDTypeDef CallbackID, void (* pCallback)(DMA_HandleTypeDef *_hdma));
HAL_StatusTypeDef HAL_DMA_UnRegisterCallback(DMA_HandleTypeDef *hdma, HAL_DMA_CallbackIDTypeDef CallbackID);

/**
  * @}
  */ 

/** @defgroup DMA_Exported_Functions_Group3 Peripheral State functions
  * @brief    Peripheral State functions 
  * @{
  */
HAL_DMA_StateTypeDef HAL_DMA_GetState(DMA_HandleTypeDef *hdma);
uint32_t             HAL_DMA_GetError(DMA_HandleTypeDef *hdma);
/**
  * @}
  */ 
/**
  * @}
  */ 
/* Private Constants -------------------------------------------------------------*/
/** @defgroup DMA_Private_Constants DMA Private Constants
  * @brief    DMA private defines and constants 
  * @{
  */
/**
  * @}
  */ 

/* Private macros ------------------------------------------------------------*/
/** @defgroup DMA_Private_Macros DMA Private Macros
  * @brief    DMA private macros 
  * @{
  */





























/**
  * @}
  */ 

/* Private functions ---------------------------------------------------------*/
/** @defgroup DMA_Private_Functions DMA Private Functions
  * @brief    DMA private  functions 
  * @{
  */
/**
  * @}
  */

/**
  * @}
  */ 

/**
  * @}
  */










/**
  ******************************************************************************
  * @file    stm32f4xx_hal_cortex.h
  * @author  MCD Application Team
  * @brief   Header file of CORTEX HAL module.
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2017 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file in
  * the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  ******************************************************************************
  */ 

/* Define to prevent recursive inclusion -------------------------------------*/






/* Includes ------------------------------------------------------------------*/
/**
  ******************************************************************************
  * @file    stm32f4xx_hal_def.h
  * @author  MCD Application Team
  * @brief   This file contains HAL common defines, enumeration, macros and 
  *          structures definitions. 
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2017 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/

















































































/** @addtogroup STM32F4xx_HAL_Driver
  * @{
  */

/** @addtogroup CORTEX
  * @{
  */ 
/* Exported types ------------------------------------------------------------*/
/** @defgroup CORTEX_Exported_Types Cortex Exported Types
  * @{
  */


/** @defgroup CORTEX_MPU_Region_Initialization_Structure_definition MPU Region Initialization Structure Definition
  * @brief  MPU Region initialization structure 
  * @{
  */
typedef struct
{
  uint8_t                Enable;                /*!< Specifies the status of the region. 
                                                     This parameter can be a value of @ref CORTEX_MPU_Region_Enable                 */
  uint8_t                Number;                /*!< Specifies the number of the region to protect. 
                                                     This parameter can be a value of @ref CORTEX_MPU_Region_Number                 */
  uint32_t               BaseAddress;           /*!< Specifies the base address of the region to protect.                           */
  uint8_t                Size;                  /*!< Specifies the size of the region to protect. 
                                                     This parameter can be a value of @ref CORTEX_MPU_Region_Size                   */
  uint8_t                SubRegionDisable;      /*!< Specifies the number of the subregion protection to disable. 
                                                     This parameter must be a number between Min_Data = 0x00 and Max_Data = 0xFF    */         
  uint8_t                TypeExtField;          /*!< Specifies the TEX field level.
                                                     This parameter can be a value of @ref CORTEX_MPU_TEX_Levels                    */                 
  uint8_t                AccessPermission;      /*!< Specifies the region access permission type. 
                                                     This parameter can be a value of @ref CORTEX_MPU_Region_Permission_Attributes  */
  uint8_t                DisableExec;           /*!< Specifies the instruction access status. 
                                                     This parameter can be a value of @ref CORTEX_MPU_Instruction_Access            */
  uint8_t                IsShareable;           /*!< Specifies the shareability status of the protected region. 
                                                     This parameter can be a value of @ref CORTEX_MPU_Access_Shareable              */
  uint8_t                IsCacheable;           /*!< Specifies the cacheable status of the region protected. 
                                                     This parameter can be a value of @ref CORTEX_MPU_Access_Cacheable              */
  uint8_t                IsBufferable;          /*!< Specifies the bufferable status of the protected region. 
                                                     This parameter can be a value of @ref CORTEX_MPU_Access_Bufferable             */
}MPU_Region_InitTypeDef;
/**
  * @}
  */


/**
  * @}
  */

/* Exported constants --------------------------------------------------------*/

/** @defgroup CORTEX_Exported_Constants CORTEX Exported Constants
  * @{
  */

/** @defgroup CORTEX_Preemption_Priority_Group CORTEX Preemption Priority Group
  * @{
  */





/**
  * @}
  */

/** @defgroup CORTEX_SysTick_clock_source CORTEX _SysTick clock source 
  * @{
  */



/**
  * @}
  */


/** @defgroup CORTEX_MPU_HFNMI_PRIVDEF_Control MPU HFNMI and PRIVILEGED Access control
  * @{
  */





/**
  * @}
  */

/** @defgroup CORTEX_MPU_Region_Enable CORTEX MPU Region Enable
  * @{
  */


/**
  * @}
  */

/** @defgroup CORTEX_MPU_Instruction_Access CORTEX MPU Instruction Access
  * @{
  */


/**
  * @}
  */

/** @defgroup CORTEX_MPU_Access_Shareable CORTEX MPU Instruction Access Shareable
  * @{
  */


/**
  * @}
  */

/** @defgroup CORTEX_MPU_Access_Cacheable CORTEX MPU Instruction Access Cacheable
  * @{
  */


/**
  * @}
  */

/** @defgroup CORTEX_MPU_Access_Bufferable CORTEX MPU Instruction Access Bufferable
  * @{
  */


/**
  * @}
  */

/** @defgroup CORTEX_MPU_TEX_Levels MPU TEX Levels
  * @{
  */



/**
  * @}
  */

/** @defgroup CORTEX_MPU_Region_Size CORTEX MPU Region Size
  * @{
  */




























/**
  * @}
  */
   
/** @defgroup CORTEX_MPU_Region_Permission_Attributes CORTEX MPU Region Permission Attributes 
  * @{
  */






/**
  * @}
  */

/** @defgroup CORTEX_MPU_Region_Number CORTEX MPU Region Number
  * @{
  */








/**
  * @}
  */


/**
  * @}
  */


/* Exported Macros -----------------------------------------------------------*/

/* Exported functions --------------------------------------------------------*/
/** @addtogroup CORTEX_Exported_Functions
  * @{
  */
  
/** @addtogroup CORTEX_Exported_Functions_Group1
  * @{
  */
/* Initialization and de-initialization functions *****************************/
void HAL_NVIC_SetPriorityGrouping(uint32_t PriorityGroup);
void HAL_NVIC_SetPriority(IRQn_Type IRQn, uint32_t PreemptPriority, uint32_t SubPriority);
void HAL_NVIC_EnableIRQ(IRQn_Type IRQn);
void HAL_NVIC_DisableIRQ(IRQn_Type IRQn);
void HAL_NVIC_SystemReset(void);
uint32_t HAL_SYSTICK_Config(uint32_t TicksNumb);
/**
  * @}
  */

/** @addtogroup CORTEX_Exported_Functions_Group2
  * @{
  */
/* Peripheral Control functions ***********************************************/
uint32_t HAL_NVIC_GetPriorityGrouping(void);
void HAL_NVIC_GetPriority(IRQn_Type IRQn, uint32_t PriorityGroup, uint32_t* pPreemptPriority, uint32_t* pSubPriority);
uint32_t HAL_NVIC_GetPendingIRQ(IRQn_Type IRQn);
void HAL_NVIC_SetPendingIRQ(IRQn_Type IRQn);
void HAL_NVIC_ClearPendingIRQ(IRQn_Type IRQn);
uint32_t HAL_NVIC_GetActive(IRQn_Type IRQn);
void HAL_SYSTICK_CLKSourceConfig(uint32_t CLKSource);
void HAL_SYSTICK_IRQHandler(void);
void HAL_SYSTICK_Callback(void);


void HAL_MPU_Enable(uint32_t MPU_Control);
void HAL_MPU_Disable(void);
void HAL_MPU_EnableRegion(uint32_t RegionNumber);
void HAL_MPU_DisableRegion(uint32_t RegionNumber);
void HAL_MPU_ConfigRegion(MPU_Region_InitTypeDef *MPU_Init);

void HAL_CORTEX_ClearEvent(void);
/**
  * @}
  */

/**
  * @}
  */

/* Private types -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private constants ---------------------------------------------------------*/
/* Private macros ------------------------------------------------------------*/
/** @defgroup CORTEX_Private_Macros CORTEX Private Macros
  * @{
  */
































/**                                                                          
  * @}                                                                  
  */

/* Private functions ---------------------------------------------------------*/

/**
  * @}
  */ 

/**
  * @}
  */
  




 













































/**
  ******************************************************************************
  * @file    stm32f4xx_hal_flash.h
  * @author  MCD Application Team
  * @brief   Header file of FLASH HAL module.
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2017 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file in
  * the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/






/* Includes ------------------------------------------------------------------*/
/**
  ******************************************************************************
  * @file    stm32f4xx_hal_def.h
  * @author  MCD Application Team
  * @brief   This file contains HAL common defines, enumeration, macros and 
  *          structures definitions. 
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2017 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/

















































































/** @addtogroup STM32F4xx_HAL_Driver
  * @{
  */

/** @addtogroup FLASH
  * @{
  */

/* Exported types ------------------------------------------------------------*/
/** @defgroup FLASH_Exported_Types FLASH Exported Types
  * @{
  */

/**
  * @brief  FLASH Procedure structure definition
  */
typedef enum
{
  FLASH_PROC_NONE = 0U,
  FLASH_PROC_SECTERASE,
  FLASH_PROC_MASSERASE,
  FLASH_PROC_PROGRAM
} FLASH_ProcedureTypeDef;

/**
  * @brief  FLASH handle Structure definition
  */
typedef struct
{
  volatile FLASH_ProcedureTypeDef ProcedureOnGoing;   /*Internal variable to indicate which procedure is ongoing or not in IT context*/

  volatile uint32_t               NbSectorsToErase;   /*Internal variable to save the remaining sectors to erase in IT context*/

  volatile uint8_t                VoltageForErase;    /*Internal variable to provide voltage range selected by user in IT context*/

  volatile uint32_t               Sector;             /*Internal variable to define the current sector which is erasing*/

  volatile uint32_t               Bank;               /*Internal variable to save current bank selected during mass erase*/

  volatile uint32_t               Address;            /*Internal variable to save address selected for program*/

  HAL_LockTypeDef             Lock;               /* FLASH locking object                */

  volatile uint32_t               ErrorCode;          /* FLASH error code                    */

} FLASH_ProcessTypeDef;

/**
  * @}
  */

/* Exported constants --------------------------------------------------------*/
/** @defgroup FLASH_Exported_Constants FLASH Exported Constants
  * @{
  */
/** @defgroup FLASH_Error_Code FLASH Error Code
  * @brief    FLASH Error Code
  * @{
  */







/**
  * @}
  */

/** @defgroup FLASH_Type_Program FLASH Type Program
  * @{
  */




/**
  * @}
  */

/** @defgroup FLASH_Flag_definition FLASH Flag definition
  * @brief Flag definition
  * @{
  */










/**
  * @}
  */

/** @defgroup FLASH_Interrupt_definition FLASH Interrupt definition
  * @brief FLASH Interrupt definition
  * @{
  */


/**
  * @}
  */

/** @defgroup FLASH_Program_Parallelism FLASH Program Parallelism
  * @{
  */





/**
  * @}
  */

/** @defgroup FLASH_Keys FLASH Keys
  * @{
  */





/**
  * @}
  */

/**
  * @}
  */

/* Exported macro ------------------------------------------------------------*/
/** @defgroup FLASH_Exported_Macros FLASH Exported Macros
  * @{
  */
/**
  * @brief  Set the FLASH Latency.
  * @param  __LATENCY__ FLASH Latency
  *         The value of this parameter depend on device used within the same series
  * @retval none
  */


/**
  * @brief  Get the FLASH Latency.
  * @retval FLASH Latency
  *          The value of this parameter depend on device used within the same series
  */


/**
  * @brief  Enable the FLASH prefetch buffer.
  * @retval none
  */


/**
  * @brief  Disable the FLASH prefetch buffer.
  * @retval none
  */


/**
  * @brief  Enable the FLASH instruction cache.
  * @retval none
  */


/**
  * @brief  Disable the FLASH instruction cache.
  * @retval none
  */


/**
  * @brief  Enable the FLASH data cache.
  * @retval none
  */


/**
  * @brief  Disable the FLASH data cache.
  * @retval none
  */


/**
  * @brief  Resets the FLASH instruction Cache.
  * @note   This function must be used only when the Instruction Cache is disabled.
  * @retval None
  */


/**
  * @brief  Resets the FLASH data Cache.
  * @note   This function must be used only when the data Cache is disabled.
  * @retval None
  */

/**
  * @brief  Enable the specified FLASH interrupt.
  * @param  __INTERRUPT__  FLASH interrupt
  *         This parameter can be any combination of the following values:
  *     @arg FLASH_IT_EOP: End of FLASH Operation Interrupt
  *     @arg FLASH_IT_ERR: Error Interrupt
  * @retval none
  */


/**
  * @brief  Disable the specified FLASH interrupt.
  * @param  __INTERRUPT__  FLASH interrupt
  *         This parameter can be any combination of the following values:
  *     @arg FLASH_IT_EOP: End of FLASH Operation Interrupt
  *     @arg FLASH_IT_ERR: Error Interrupt
  * @retval none
  */


/**
  * @brief  Get the specified FLASH flag status.
  * @param  __FLAG__ specifies the FLASH flags to check.
  *          This parameter can be any combination of the following values:
  *            @arg FLASH_FLAG_EOP   : FLASH End of Operation flag
  *            @arg FLASH_FLAG_OPERR : FLASH operation Error flag
  *            @arg FLASH_FLAG_WRPERR: FLASH Write protected error flag
  *            @arg FLASH_FLAG_PGAERR: FLASH Programming Alignment error flag
  *            @arg FLASH_FLAG_PGPERR: FLASH Programming Parallelism error flag
  *            @arg FLASH_FLAG_PGSERR: FLASH Programming Sequence error flag
  *            @arg FLASH_FLAG_RDERR : FLASH Read Protection error flag (PCROP) (*)
  *            @arg FLASH_FLAG_BSY   : FLASH Busy flag
  *           (*) FLASH_FLAG_RDERR is not available for STM32F405xx/407xx/415xx/417xx devices
  * @retval The new state of __FLAG__ (SET or RESET).
  */


/**
  * @brief  Clear the specified FLASH flags.
  * @param  __FLAG__ specifies the FLASH flags to clear.
  *          This parameter can be any combination of the following values:
  *            @arg FLASH_FLAG_EOP   : FLASH End of Operation flag
  *            @arg FLASH_FLAG_OPERR : FLASH operation Error flag
  *            @arg FLASH_FLAG_WRPERR: FLASH Write protected error flag
  *            @arg FLASH_FLAG_PGAERR: FLASH Programming Alignment error flag
  *            @arg FLASH_FLAG_PGPERR: FLASH Programming Parallelism error flag
  *            @arg FLASH_FLAG_PGSERR: FLASH Programming Sequence error flag
  *            @arg FLASH_FLAG_RDERR : FLASH Read Protection error flag (PCROP) (*)
  *           (*) FLASH_FLAG_RDERR is not available for STM32F405xx/407xx/415xx/417xx devices
  * @retval none
  */

/**
  * @}
  */

/* Include FLASH HAL Extension module */
/**
  ******************************************************************************
  * @file    stm32f4xx_hal_flash_ex.h
  * @author  MCD Application Team
  * @brief   Header file of FLASH HAL Extension module.
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2017 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file in
  * the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/






/* Includes ------------------------------------------------------------------*/
/**
  ******************************************************************************
  * @file    stm32f4xx_hal_def.h
  * @author  MCD Application Team
  * @brief   This file contains HAL common defines, enumeration, macros and 
  *          structures definitions. 
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2017 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/

















































































/** @addtogroup STM32F4xx_HAL_Driver
  * @{
  */

/** @addtogroup FLASHEx
  * @{
  */

/* Exported types ------------------------------------------------------------*/
/** @defgroup FLASHEx_Exported_Types FLASH Exported Types
  * @{
  */

/**
  * @brief  FLASH Erase structure definition
  */
typedef struct
{
  uint32_t TypeErase;   /*!< Mass erase or sector Erase.
                             This parameter can be a value of @ref FLASHEx_Type_Erase */

  uint32_t Banks;       /*!< Select banks to erase when Mass erase is enabled.
                             This parameter must be a value of @ref FLASHEx_Banks */

  uint32_t Sector;      /*!< Initial FLASH sector to erase when Mass erase is disabled
                             This parameter must be a value of @ref FLASHEx_Sectors */

  uint32_t NbSectors;   /*!< Number of sectors to be erased.
                             This parameter must be a value between 1 and (max number of sectors - value of Initial sector)*/

  uint32_t VoltageRange;/*!< The device voltage range which defines the erase parallelism
                             This parameter must be a value of @ref FLASHEx_Voltage_Range */

} FLASH_EraseInitTypeDef;

/**
  * @brief  FLASH Option Bytes Program structure definition
  */
typedef struct
{
  uint32_t OptionType;   /*!< Option byte to be configured.
                              This parameter can be a value of @ref FLASHEx_Option_Type */

  uint32_t WRPState;     /*!< Write protection activation or deactivation.
                              This parameter can be a value of @ref FLASHEx_WRP_State */

  uint32_t WRPSector;         /*!< Specifies the sector(s) to be write protected.
                              The value of this parameter depend on device used within the same series */

  uint32_t Banks;        /*!< Select banks for WRP activation/deactivation of all sectors.
                              This parameter must be a value of @ref FLASHEx_Banks */

  uint32_t RDPLevel;     /*!< Set the read protection level.
                              This parameter can be a value of @ref FLASHEx_Option_Bytes_Read_Protection */

  uint32_t BORLevel;     /*!< Set the BOR Level.
                              This parameter can be a value of @ref FLASHEx_BOR_Reset_Level */

  uint8_t  USERConfig;   /*!< Program the FLASH User Option Byte: IWDG_SW / RST_STOP / RST_STDBY. */

} FLASH_OBProgramInitTypeDef;

/**
  * @brief  FLASH Advanced Option Bytes Program structure definition
  */

typedef struct
{
  uint32_t OptionType;     /*!< Option byte to be configured for extension.
                                This parameter can be a value of @ref FLASHEx_Advanced_Option_Type */

  uint32_t PCROPState;     /*!< PCROP activation or deactivation.
                                This parameter can be a value of @ref FLASHEx_PCROP_State */


  uint16_t Sectors;        /*!< specifies the sector(s) set for PCROP.
                                This parameter can be a value of @ref FLASHEx_Option_Bytes_PC_ReadWrite_Protection */




} FLASH_AdvOBProgramInitTypeDef;

/**
  * @}
  */

/* Exported constants --------------------------------------------------------*/

/** @defgroup FLASHEx_Exported_Constants FLASH Exported Constants
  * @{
  */

/** @defgroup FLASHEx_Type_Erase FLASH Type Erase
  * @{
  */


/**
  * @}
  */

/** @defgroup FLASHEx_Voltage_Range FLASH Voltage Range
  * @{
  */




/**
  * @}
  */

/** @defgroup FLASHEx_WRP_State FLASH WRP State
  * @{
  */


/**
  * @}
  */

/** @defgroup FLASHEx_Option_Type FLASH Option Type
  * @{
  */




/**
  * @}
  */

/** @defgroup FLASHEx_Option_Bytes_Read_Protection FLASH Option Bytes Read Protection
  * @{
  */



/**
  * @}
  */

/** @defgroup FLASHEx_Option_Bytes_IWatchdog FLASH Option Bytes IWatchdog
  * @{
  */


/**
  * @}
  */

/** @defgroup FLASHEx_Option_Bytes_nRST_STOP FLASH Option Bytes nRST_STOP
  * @{
  */


/**
  * @}
  */


/** @defgroup FLASHEx_Option_Bytes_nRST_STDBY FLASH Option Bytes nRST_STDBY
  * @{
  */


/**
  * @}
  */

/** @defgroup FLASHEx_BOR_Reset_Level FLASH BOR Reset Level
  * @{
  */




/**
  * @}
  */


/** @defgroup FLASHEx_PCROP_State FLASH PCROP State
  * @{
  */


/**
  * @}
  */


/** @defgroup FLASHEx_Advanced_Option_Type FLASH Advanced Option Type
  * @{
  */








/**
  * @}
  */

/** @defgroup FLASH_Latency FLASH Latency
  * @{
  */
/*------------------------- STM32F42xxx/STM32F43xxx/STM32F446xx/STM32F469xx/STM32F479xx ----------------------*/


















/*--------------------------------------------------------------------------------------------------------------*/

/*-------------------------- STM32F40xxx/STM32F41xxx/STM32F401xx/STM32F411xx/STM32F423xx -----------------------*/











/*--------------------------------------------------------------------------------------------------------------*/

/**
  * @}
  */


/** @defgroup FLASHEx_Banks FLASH Banks
  * @{
  */









/**
  * @}
  */

/** @defgroup FLASHEx_MassErase_bit FLASH Mass Erase bit
  * @{
  */







/**
  * @}
  */

/** @defgroup FLASHEx_Sectors FLASH Sectors
  * @{
  */
/*-------------------------------------- STM32F42xxx/STM32F43xxx/STM32F469xx ------------------------------------*/


























/*-----------------------------------------------------------------------------------------------------*/

/*-------------------------------------- STM32F413xx/STM32F423xx --------------------------------------*/


















/*-----------------------------------------------------------------------------------------------------*/

/*--------------------------------------- STM32F40xxx/STM32F41xxx -------------------------------------*/














/*-----------------------------------------------------------------------------------------------------*/

/*--------------------------------------------- STM32F401xC -------------------------------------------*/








/*-----------------------------------------------------------------------------------------------------*/

/*--------------------------------------------- STM32F410xx -------------------------------------------*/







/*-----------------------------------------------------------------------------------------------------*/

/*---------------------------------- STM32F401xE/STM32F411xE/STM32F446xx ------------------------------*/










/*-----------------------------------------------------------------------------------------------------*/

/**
  * @}
  */

/** @defgroup FLASHEx_Option_Bytes_Write_Protection FLASH Option Bytes Write Protection
  * @{
  */
/*--------------------------- STM32F42xxx/STM32F43xxx/STM32F469xx/STM32F479xx -------------------------*/



























/*-----------------------------------------------------------------------------------------------------*/

/*--------------------------------------- STM32F413xx/STM32F423xx -------------------------------------*/



















/*-----------------------------------------------------------------------------------------------------*/

/*--------------------------------------- STM32F40xxx/STM32F41xxx -------------------------------------*/















/*-----------------------------------------------------------------------------------------------------*/

/*--------------------------------------------- STM32F401xC -------------------------------------------*/









/*-----------------------------------------------------------------------------------------------------*/

/*--------------------------------------------- STM32F410xx -------------------------------------------*/








/*-----------------------------------------------------------------------------------------------------*/

/*---------------------------------- STM32F401xE/STM32F411xE/STM32F446xx ------------------------------*/











/*-----------------------------------------------------------------------------------------------------*/
/**
  * @}
  */

/** @defgroup FLASHEx_Option_Bytes_PC_ReadWrite_Protection FLASH Option Bytes PC ReadWrite Protection
  * @{
  */
/*-------------------------------- STM32F42xxx/STM32F43xxx/STM32F469xx/STM32F479xx ---------------------------*/



























/*-----------------------------------------------------------------------------------------------------*/

/*------------------------------------- STM32F413xx/STM32F423xx ---------------------------------------*/



















/*-----------------------------------------------------------------------------------------------------*/

/*--------------------------------------------- STM32F401xC -------------------------------------------*/









/*-----------------------------------------------------------------------------------------------------*/

/*--------------------------------------------- STM32F410xx -------------------------------------------*/








/*-----------------------------------------------------------------------------------------------------*/

/*-------------- STM32F401xE/STM32F411xE/STM32F412Zx/STM32F412Vx/STM32F412Rx/STM32F412Cx/STM32F446xx --*/











/*-----------------------------------------------------------------------------------------------------*/

/**
  * @}
  */

/** @defgroup FLASHEx_Dual_Boot FLASH Dual Boot
  * @{
  */




/**
  * @}
  */

/** @defgroup  FLASHEx_Selection_Protection_Mode FLASH Selection Protection Mode
  * @{
  */




/**
  * @}
  */

/**
  * @}
  */

/* Exported macro ------------------------------------------------------------*/

/* Exported functions --------------------------------------------------------*/
/** @addtogroup FLASHEx_Exported_Functions
  * @{
  */

/** @addtogroup FLASHEx_Exported_Functions_Group1
  * @{
  */
/* Extension Program operation functions  *************************************/
HAL_StatusTypeDef HAL_FLASHEx_Erase(FLASH_EraseInitTypeDef *pEraseInit, uint32_t *SectorError);
HAL_StatusTypeDef HAL_FLASHEx_Erase_IT(FLASH_EraseInitTypeDef *pEraseInit);
HAL_StatusTypeDef HAL_FLASHEx_OBProgram(FLASH_OBProgramInitTypeDef *pOBInit);
void              HAL_FLASHEx_OBGetConfig(FLASH_OBProgramInitTypeDef *pOBInit);


HAL_StatusTypeDef HAL_FLASHEx_AdvOBProgram(FLASH_AdvOBProgramInitTypeDef *pAdvOBInit);
void              HAL_FLASHEx_AdvOBGetConfig(FLASH_AdvOBProgramInitTypeDef *pAdvOBInit);
HAL_StatusTypeDef HAL_FLASHEx_OB_SelectPCROP(void);
HAL_StatusTypeDef HAL_FLASHEx_OB_DeSelectPCROP(void);




/**
  * @}
  */

/**
  * @}
  */
/* Private types -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private constants ---------------------------------------------------------*/
/** @defgroup FLASHEx_Private_Constants FLASH Private Constants
  * @{
  */
/*--------------------------------- STM32F42xxx/STM32F43xxx/STM32F469xx/STM32F479xx---------------------*/




/*-------------------------------------- STM32F413xx/STM32F423xx ---------------------------------------*/




/*--------------------------------------- STM32F40xxx/STM32F41xxx -------------------------------------*/




/*--------------------------------------------- STM32F401xC -------------------------------------------*/




/*--------------------------------------------- STM32F410xx -------------------------------------------*/




/*--------------------------------- STM32F401xE/STM32F411xE/STM32F412xG/STM32F446xx -------------------*/




/**
  * @brief OPTCR1 register byte 2 (Bits[23:16]) base address
  */




/**
  * @}
  */

/* Private macros ------------------------------------------------------------*/
/** @defgroup FLASHEx_Private_Macros FLASH Private Macros
  * @{
  */

/** @defgroup FLASHEx_IS_FLASH_Definitions FLASH Private macros to check input parameters
  * @{
  */






























































































































/**
  * @}
  */

/**
  * @}
  */

/* Private functions ---------------------------------------------------------*/
/** @defgroup FLASHEx_Private_Functions FLASH Private Functions
  * @{
  */
void FLASH_Erase_Sector(uint32_t Sector, uint8_t VoltageRange);
void FLASH_FlushCaches(void);
/**
  * @}
  */

/**
  * @}
  */

/**
  * @}
  */







/**
  ******************************************************************************
  * @file    stm32f4xx_hal_flash_ramfunc.h
  * @author  MCD Application Team
  * @brief   Header file of FLASH RAMFUNC driver.
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2017 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file in
  * the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/
















/* Exported functions --------------------------------------------------------*/
/** @addtogroup FLASH_Exported_Functions
  * @{
  */
/** @addtogroup FLASH_Exported_Functions_Group1
  * @{
  */
/* Program operation functions  ***********************************************/
HAL_StatusTypeDef HAL_FLASH_Program(uint32_t TypeProgram, uint32_t Address, uint64_t Data);
HAL_StatusTypeDef HAL_FLASH_Program_IT(uint32_t TypeProgram, uint32_t Address, uint64_t Data);
/* FLASH IRQ handler method */
void HAL_FLASH_IRQHandler(void);
/* Callbacks in non blocking modes */
void HAL_FLASH_EndOfOperationCallback(uint32_t ReturnValue);
void HAL_FLASH_OperationErrorCallback(uint32_t ReturnValue);
/**
  * @}
  */

/** @addtogroup FLASH_Exported_Functions_Group2
  * @{
  */
/* Peripheral Control functions  **********************************************/
HAL_StatusTypeDef HAL_FLASH_Unlock(void);
HAL_StatusTypeDef HAL_FLASH_Lock(void);
HAL_StatusTypeDef HAL_FLASH_OB_Unlock(void);
HAL_StatusTypeDef HAL_FLASH_OB_Lock(void);
/* Option bytes control */
HAL_StatusTypeDef HAL_FLASH_OB_Launch(void);
/**
  * @}
  */

/** @addtogroup FLASH_Exported_Functions_Group3
  * @{
  */
/* Peripheral State functions  ************************************************/
uint32_t HAL_FLASH_GetError(void);
HAL_StatusTypeDef FLASH_WaitForLastOperation(uint32_t Timeout);
/**
  * @}
  */

/**
  * @}
  */
/* Private types -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/** @defgroup FLASH_Private_Variables FLASH Private Variables
  * @{
  */

/**
  * @}
  */
/* Private constants ---------------------------------------------------------*/
/** @defgroup FLASH_Private_Constants FLASH Private Constants
  * @{
  */

/**
  * @brief   ACR register byte 0 (Bits[7:0]) base address
  */

/**
  * @brief   OPTCR register byte 0 (Bits[7:0]) base address
  */

/**
  * @brief   OPTCR register byte 1 (Bits[15:8]) base address
  */

/**
  * @brief   OPTCR register byte 2 (Bits[23:16]) base address
  */

/**
  * @brief   OPTCR register byte 3 (Bits[31:24]) base address
  */


/**
  * @}
  */

/* Private macros ------------------------------------------------------------*/
/** @defgroup FLASH_Private_Macros FLASH Private Macros
  * @{
  */

/** @defgroup FLASH_IS_FLASH_Definitions FLASH Private macros to check input parameters
  * @{
  */

/**
  * @}
  */

/**
  * @}
  */

/* Private functions ---------------------------------------------------------*/
/** @defgroup FLASH_Private_Functions FLASH Private Functions
  * @{
  */

/**
  * @}
  */

/**
  * @}
  */

/**
  * @}
  */






















































/**
  ******************************************************************************
  * @file    stm32f4xx_hal_pwr.h
  * @author  MCD Application Team
  * @brief   Header file of PWR HAL module.
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2017 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file in
  * the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  ******************************************************************************
  */ 

/* Define to prevent recursive inclusion -------------------------------------*/






/* Includes ------------------------------------------------------------------*/
/**
  ******************************************************************************
  * @file    stm32f4xx_hal_def.h
  * @author  MCD Application Team
  * @brief   This file contains HAL common defines, enumeration, macros and 
  *          structures definitions. 
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2017 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/

















































































/** @addtogroup STM32F4xx_HAL_Driver
  * @{
  */

/** @addtogroup PWR
  * @{
  */ 

/* Exported types ------------------------------------------------------------*/

/** @defgroup PWR_Exported_Types PWR Exported Types
  * @{
  */
   
/**
  * @brief  PWR PVD configuration structure definition
  */
typedef struct
{
  uint32_t PVDLevel;   /*!< PVDLevel: Specifies the PVD detection level.
                            This parameter can be a value of @ref PWR_PVD_detection_level */

  uint32_t Mode;      /*!< Mode: Specifies the operating mode for the selected pins.
                           This parameter can be a value of @ref PWR_PVD_Mode */
}PWR_PVDTypeDef;

/**
  * @}
  */

/* Exported constants --------------------------------------------------------*/
/** @defgroup PWR_Exported_Constants PWR Exported Constants
  * @{
  */
  
/** @defgroup PWR_WakeUp_Pins PWR WakeUp Pins
  * @{
  */

/**
  * @}
  */

/** @defgroup PWR_PVD_detection_level PWR PVD detection level
  * @{
  */ 








/**
  * @}
  */   
 
/** @defgroup PWR_PVD_Mode PWR PVD Mode
  * @{
  */







/**
  * @}
  */


/** @defgroup PWR_Regulator_state_in_STOP_mode PWR Regulator state in SLEEP/STOP mode
  * @{
  */


/**
  * @}
  */
    
/** @defgroup PWR_SLEEP_mode_entry PWR SLEEP mode entry
  * @{
  */




/**
  * @}
  */

/** @defgroup PWR_STOP_mode_entry PWR STOP mode entry
  * @{
  */



/**
  * @}
  */

/** @defgroup PWR_Flag PWR Flag
  * @{
  */





/**
  * @}
  */

/**
  * @}
  */ 
  
/* Exported macro ------------------------------------------------------------*/
/** @defgroup PWR_Exported_Macro PWR Exported Macro
  * @{
  */

/** @brief  Check PWR flag is set or not.
  * @param  __FLAG__ specifies the flag to check.
  *           This parameter can be one of the following values:
  *            @arg PWR_FLAG_WU: Wake Up flag. This flag indicates that a wakeup event 
  *                  was received from the WKUP pin or from the RTC alarm (Alarm A 
  *                  or Alarm B), RTC Tamper event, RTC TimeStamp event or RTC Wakeup.
  *                  An additional wakeup event is detected if the WKUP pin is enabled 
  *                  (by setting the EWUP bit) when the WKUP pin level is already high.  
  *            @arg PWR_FLAG_SB: StandBy flag. This flag indicates that the system was
  *                  resumed from StandBy mode.    
  *            @arg PWR_FLAG_PVDO: PVD Output. This flag is valid only if PVD is enabled 
  *                  by the HAL_PWR_EnablePVD() function. The PVD is stopped by Standby mode 
  *                  For this reason, this bit is equal to 0 after Standby or reset
  *                  until the PVDE bit is set.
  *            @arg PWR_FLAG_BRR: Backup regulator ready flag. This bit is not reset 
  *                  when the device wakes up from Standby mode or by a system reset 
  *                  or power reset.  
  *            @arg PWR_FLAG_VOSRDY: This flag indicates that the Regulator voltage 
  *                 scaling output selection is ready.
  * @retval The new state of __FLAG__ (TRUE or FALSE).
  */


/** @brief  Clear the PWR's pending flags.
  * @param  __FLAG__ specifies the flag to clear.
  *          This parameter can be one of the following values:
  *            @arg PWR_FLAG_WU: Wake Up flag
  *            @arg PWR_FLAG_SB: StandBy flag
  */


/**
  * @brief Enable the PVD Exti Line 16.
  * @retval None.
  */


/**
  * @brief Disable the PVD EXTI Line 16.
  * @retval None.
  */


/**
  * @brief Enable event on PVD Exti Line 16.
  * @retval None.
  */


/**
  * @brief Disable event on PVD Exti Line 16.
  * @retval None.
  */


/**
  * @brief Enable the PVD Extended Interrupt Rising Trigger.
  * @retval None.
  */


/**
  * @brief Disable the PVD Extended Interrupt Rising Trigger.
  * @retval None.
  */


/**
  * @brief Enable the PVD Extended Interrupt Falling Trigger.
  * @retval None.
  */



/**
  * @brief Disable the PVD Extended Interrupt Falling Trigger.
  * @retval None.
  */



/**
  * @brief  PVD EXTI line configuration: set rising & falling edge trigger.
  * @retval None.
  */


/**
  * @brief Disable the PVD Extended Interrupt Rising & Falling Trigger.
  * This parameter can be:
  * @retval None.
  */


/**
  * @brief checks whether the specified PVD Exti interrupt flag is set or not.
  * @retval EXTI PVD Line Status.
  */


/**
  * @brief Clear the PVD Exti flag.
  * @retval None.
  */


/**
  * @brief  Generates a Software interrupt on PVD EXTI line.
  * @retval None
  */


/**
  * @}
  */

/* Include PWR HAL Extension module */
/**
  ******************************************************************************
  * @file    stm32f4xx_hal_pwr_ex.h
  * @author  MCD Application Team
  * @brief   Header file of PWR HAL Extension module.
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2017 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file in
  * the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  ******************************************************************************
  */ 

/* Define to prevent recursive inclusion -------------------------------------*/






/* Includes ------------------------------------------------------------------*/
/**
  ******************************************************************************
  * @file    stm32f4xx_hal_def.h
  * @author  MCD Application Team
  * @brief   This file contains HAL common defines, enumeration, macros and 
  *          structures definitions. 
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2017 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/

















































































/** @addtogroup STM32F4xx_HAL_Driver
  * @{
  */

/** @addtogroup PWREx
  * @{
  */ 

/* Exported types ------------------------------------------------------------*/ 
/* Exported constants --------------------------------------------------------*/
/** @defgroup PWREx_Exported_Constants PWREx Exported Constants
  * @{
  */








/** @defgroup PWREx_Regulator_Voltage_Scale PWREx Regulator Voltage Scale
  * @{
  */








/**
  * @}
  */







/**
  * @}
  */ 
  
/* Exported macro ------------------------------------------------------------*/
/** @defgroup PWREx_Exported_Constants PWREx Exported Constants
  *  @{
  */




/** @brief  macros configure the main internal regulator output voltage.
  * @param  __REGULATOR__ specifies the regulator output voltage to achieve
  *         a tradeoff between performance and power consumption when the device does
  *         not operate at the maximum frequency (refer to the datasheets for more details).
  *          This parameter can be one of the following values:
  *            @arg PWR_REGULATOR_VOLTAGE_SCALE1: Regulator voltage output Scale 1 mode
  *            @arg PWR_REGULATOR_VOLTAGE_SCALE2: Regulator voltage output Scale 2 mode
  *            @arg PWR_REGULATOR_VOLTAGE_SCALE3: Regulator voltage output Scale 3 mode
  * @retval None
  */













/**
  * @}
  */

/* Exported functions --------------------------------------------------------*/
/** @addtogroup PWREx_Exported_Functions PWREx Exported Functions
  *  @{
  */
 
/** @addtogroup PWREx_Exported_Functions_Group1
  * @{
  */
void HAL_PWREx_EnableFlashPowerDown(void);
void HAL_PWREx_DisableFlashPowerDown(void); 
HAL_StatusTypeDef HAL_PWREx_EnableBkUpReg(void);
HAL_StatusTypeDef HAL_PWREx_DisableBkUpReg(void); 
uint32_t HAL_PWREx_GetVoltageRange(void);
HAL_StatusTypeDef HAL_PWREx_ControlVoltageScaling(uint32_t VoltageScaling);


void HAL_PWREx_EnableMainRegulatorLowVoltage(void);
void HAL_PWREx_DisableMainRegulatorLowVoltage(void);
void HAL_PWREx_EnableLowRegulatorLowVoltage(void);
void HAL_PWREx_DisableLowRegulatorLowVoltage(void);





/**
  * @}
  */

/**
  * @}
  */
/* Private types -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private constants ---------------------------------------------------------*/
/** @defgroup PWREx_Private_Constants PWREx Private Constants
  * @{
  */

/** @defgroup PWREx_register_alias_address PWREx Register alias address
  * @{
  */
/* ------------- PWR registers bit address in the alias region ---------------*/
/* --- CR Register ---*/
/* Alias word address of FPDS bit */



/* Alias word address of ODEN bit   */



/* Alias word address of ODSWEN bit */


    
/* Alias word address of MRLVDS bit */



/* Alias word address of LPLVDS bit */



 /**
  * @}
  */

/** @defgroup PWREx_CSR_register_alias PWRx CSR Register alias address
  * @{
  */  
/* --- CSR Register ---*/
/* Alias word address of BRE bit */



/**
  * @}
  */

/**
  * @}
  */

/* Private macros ------------------------------------------------------------*/
/** @defgroup PWREx_Private_Macros PWREx Private Macros
  * @{
  */

/** @defgroup PWREx_IS_PWR_Definitions PWREx Private macros to check input parameters
  * @{
  */

















/**
  * @}
  */

/**
  * @}
  */

/**
  * @}
  */ 

/**
  * @}
  */
  







/* Exported functions --------------------------------------------------------*/
/** @addtogroup PWR_Exported_Functions PWR Exported Functions
  * @{
  */
  
/** @addtogroup PWR_Exported_Functions_Group1 Initialization and de-initialization functions 
  * @{
  */
/* Initialization and de-initialization functions *****************************/
void HAL_PWR_DeInit(void);
void HAL_PWR_EnableBkUpAccess(void);
void HAL_PWR_DisableBkUpAccess(void);
/**
  * @}
  */

/** @addtogroup PWR_Exported_Functions_Group2 Peripheral Control functions 
  * @{
  */
/* Peripheral Control functions  **********************************************/
/* PVD configuration */
void HAL_PWR_ConfigPVD(PWR_PVDTypeDef *sConfigPVD);
void HAL_PWR_EnablePVD(void);
void HAL_PWR_DisablePVD(void);

/* WakeUp pins configuration */
void HAL_PWR_EnableWakeUpPin(uint32_t WakeUpPinx);
void HAL_PWR_DisableWakeUpPin(uint32_t WakeUpPinx);

/* Low Power modes entry */
void HAL_PWR_EnterSTOPMode(uint32_t Regulator, uint8_t STOPEntry);
void HAL_PWR_EnterSLEEPMode(uint32_t Regulator, uint8_t SLEEPEntry);
void HAL_PWR_EnterSTANDBYMode(void);

/* Power PVD IRQ Handler */
void HAL_PWR_PVD_IRQHandler(void);
void HAL_PWR_PVDCallback(void);

/* Cortex System Control functions  *******************************************/
void HAL_PWR_EnableSleepOnExit(void);
void HAL_PWR_DisableSleepOnExit(void);
void HAL_PWR_EnableSEVOnPend(void);
void HAL_PWR_DisableSEVOnPend(void);
/**
  * @}
  */

/**
  * @}
  */

/* Private types -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private constants ---------------------------------------------------------*/
/** @defgroup PWR_Private_Constants PWR Private Constants
  * @{
  */

/** @defgroup PWR_PVD_EXTI_Line PWR PVD EXTI Line
  * @{
  */

/**
  * @}
  */

/** @defgroup PWR_register_alias_address PWR Register alias address
  * @{
  */
/* ------------- PWR registers bit address in the alias region ---------------*/





/**
  * @}
  */

/** @defgroup PWR_CR_register_alias PWR CR Register alias address
  * @{
  */
/* --- CR Register ---*/
/* Alias word address of DBP bit */



/* Alias word address of PVDE bit */



/* Alias word address of VOS bit */


/**
  * @}
  */

/** @defgroup PWR_CSR_register_alias PWR CSR Register alias address
  * @{
  */
/* --- CSR Register ---*/
/* Alias word address of EWUP bit */


/**
  * @}
  */

/**
  * @}
  */
/* Private macros ------------------------------------------------------------*/
/** @defgroup PWR_Private_Macros PWR Private Macros
  * @{
  */

/** @defgroup PWR_IS_PWR_Definitions PWR Private macros to check input parameters
  * @{
  */







/**
  * @}
  */

/**
  * @}
  */

/**
  * @}
  */ 

/**
  * @}
  */
  
































































































/* Exported macro ------------------------------------------------------------*/












/** @addtogroup STM32F4xx_HAL_Driver
  * @{
  */

/** @addtogroup HAL
  * @{
  */ 

/* Exported types ------------------------------------------------------------*/
/* Exported constants --------------------------------------------------------*/

/** @defgroup HAL_Exported_Constants HAL Exported Constants
  * @{
  */

/** @defgroup HAL_TICK_FREQ Tick Frequency
  * @{
  */
typedef enum
{
  HAL_TICK_FREQ_10HZ         = 100U,
  HAL_TICK_FREQ_100HZ        = 10U,
  HAL_TICK_FREQ_1KHZ         = 1U,
  HAL_TICK_FREQ_DEFAULT      = HAL_TICK_FREQ_1KHZ
} HAL_TickFreqTypeDef;
/**
  * @}
  */

/**
  * @}
  */
   
/* Exported macro ------------------------------------------------------------*/
/** @defgroup HAL_Exported_Macros HAL Exported Macros
  * @{
  */

/** @brief  Freeze/Unfreeze Peripherals in Debug mode 
  */














































/** @brief  Main Flash memory mapped at 0x00000000
  */


/** @brief  System Flash memory mapped at 0x00000000
  */


/** @brief  Embedded SRAM mapped at 0x00000000
  */















/**
  * @}
  */

/** @defgroup HAL_Private_Macros HAL Private Macros
  * @{
  */

/**
  * @}
  */

/* Exported variables --------------------------------------------------------*/

/** @addtogroup HAL_Exported_Variables
  * @{
  */
extern volatile uint32_t uwTick;
extern uint32_t uwTickPrio;
extern HAL_TickFreqTypeDef uwTickFreq;
/**
  * @}
  */

/* Exported functions --------------------------------------------------------*/
/** @addtogroup HAL_Exported_Functions
  * @{
  */
/** @addtogroup HAL_Exported_Functions_Group1
  * @{
  */
/* Initialization and Configuration functions  ******************************/
HAL_StatusTypeDef HAL_Init(void);
HAL_StatusTypeDef HAL_DeInit(void);
void HAL_MspInit(void);
void HAL_MspDeInit(void);
HAL_StatusTypeDef HAL_InitTick (uint32_t TickPriority);
/**
  * @}
  */

/** @addtogroup HAL_Exported_Functions_Group2
  * @{
  */
/* Peripheral Control functions  ************************************************/
void HAL_IncTick(void);
void HAL_Delay(uint32_t Delay);
uint32_t HAL_GetTick(void);
uint32_t HAL_GetTickPrio(void);
HAL_StatusTypeDef HAL_SetTickFreq(HAL_TickFreqTypeDef Freq);
HAL_TickFreqTypeDef HAL_GetTickFreq(void);
void HAL_SuspendTick(void);
void HAL_ResumeTick(void);
uint32_t HAL_GetHalVersion(void);
uint32_t HAL_GetREVID(void);
uint32_t HAL_GetDEVID(void);
void HAL_DBGMCU_EnableDBGSleepMode(void);
void HAL_DBGMCU_DisableDBGSleepMode(void);
void HAL_DBGMCU_EnableDBGStopMode(void);
void HAL_DBGMCU_DisableDBGStopMode(void);
void HAL_DBGMCU_EnableDBGStandbyMode(void);
void HAL_DBGMCU_DisableDBGStandbyMode(void);
void HAL_EnableCompensationCell(void);
void HAL_DisableCompensationCell(void);
uint32_t HAL_GetUIDw0(void);
uint32_t HAL_GetUIDw1(void);
uint32_t HAL_GetUIDw2(void);


/**
  * @}
  */

/**
  * @}
  */
/* Private types -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/** @defgroup HAL_Private_Variables HAL Private Variables
  * @{
  */
/**
  * @}
  */
/* Private constants ---------------------------------------------------------*/
/** @defgroup HAL_Private_Constants HAL Private Constants
  * @{
  */
/**
  * @}
  */
/* Private macros ------------------------------------------------------------*/
/* Private functions ---------------------------------------------------------*/
/**
  * @}
  */

/**
  * @}
  */ 
  








/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
void Error_Handler(void);

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

/* Private defines -----------------------------------------------------------*/

/* USER CODE BEGIN Private defines */

/* USER CODE END Private defines */






/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    gpio.h
  * @brief   This file contains all the function prototypes for
  *          the gpio.c file
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2026 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */
/* USER CODE END Header */
/* Define to prevent recursive inclusion -------------------------------------*/






/* Includes ------------------------------------------------------------------*/
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : main.h
  * @brief          : Header for main.c file.
  *                   This file contains the common defines of the application.
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2026 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/










/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* USER CODE BEGIN Private defines */

/* USER CODE END Private defines */

void MX_GPIO_Init(void);

/* USER CODE BEGIN Prototypes */

/* USER CODE END Prototypes */







/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/

/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
void SystemClock_Config(void);
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Private user code ---------------------------------------------------------*/
/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

/**
  * @brief  The application entry point.
  * @retval int
  */
int main(void)
{

  /* USER CODE BEGIN 1 */

  /* USER CODE END 1 */

  /* MCU Configuration--------------------------------------------------------*/

  /* Reset of all peripherals, Initializes the Flash interface and the Systick. */
  HAL_Init();

  /* USER CODE BEGIN Init */

  /* USER CODE END Init */

  /* Configure the system clock */
  SystemClock_Config();

  /* USER CODE BEGIN SysInit */

  /* USER CODE END SysInit */

  /* Initialize all configured peripherals */
  MX_GPIO_Init();
  /* USER CODE BEGIN 2 */

  /* USER CODE END 2 */

  /* Infinite loop */
  /* USER CODE BEGIN WHILE */
  while (1)
  {
	  HAL_GPIO_WritePin(((GPIO_TypeDef *) ((0x40000000UL + 0x00020000UL) + 0x0800UL)), ((uint16_t)0x2000), GPIO_PIN_RESET);
	  HAL_Delay(500);
	  HAL_GPIO_WritePin(((GPIO_TypeDef *) ((0x40000000UL + 0x00020000UL) + 0x0800UL)), ((uint16_t)0x2000), GPIO_PIN_SET);
	  HAL_Delay(500);
    /* USER CODE END WHILE */

    /* USER CODE BEGIN 3 */
  }
  /* USER CODE END 3 */
}

/**
  * @brief System Clock Configuration
  * @retval None
  */
void SystemClock_Config(void)
{
  RCC_OscInitTypeDef RCC_OscInitStruct = {0};
  RCC_ClkInitTypeDef RCC_ClkInitStruct = {0};

  /** Configure the main internal regulator output voltage
  */
  do {                                              volatile uint32_t tmpreg = 0x00U;                                              ((((RCC_TypeDef *) ((0x40000000UL + 0x00020000UL) + 0x3800UL))->APB1ENR) |= ((0x1UL << (28U))));                                                                                            tmpreg = ((((RCC_TypeDef *) ((0x40000000UL + 0x00020000UL) + 0x3800UL))->APB1ENR) & ((0x1UL << (28U))));                                             (void)tmpreg;                                            } while(0U);
  do {                                                                                                                  volatile uint32_t tmpreg = 0x00U;                                                                                     (((((PWR_TypeDef *) (0x40000000UL + 0x7000UL))->CR)) = ((((((((PWR_TypeDef *) (0x40000000UL + 0x7000UL))->CR))) & (~((0x3UL << (14U))))) | ((0x00008000U)))));                                                                                                                                tmpreg = ((((PWR_TypeDef *) (0x40000000UL + 0x7000UL))->CR) & ((0x3UL << (14U))));                                                                          (void)tmpreg;                                                                                                } while(0U);

  /** Initializes the RCC Oscillators according to the specified parameters
  * in the RCC_OscInitTypeDef structure.
  */
  RCC_OscInitStruct.OscillatorType = 0x00000002U;
  RCC_OscInitStruct.HSIState = ((uint8_t)0x01);
  RCC_OscInitStruct.HSICalibrationValue = 0x10U;
  RCC_OscInitStruct.PLL.PLLState = ((uint8_t)0x00);
  if (HAL_RCC_OscConfig(&RCC_OscInitStruct) != HAL_OK)
  {
    Error_Handler();
  }

  /** Initializes the CPU, AHB and APB buses clocks
  */
  RCC_ClkInitStruct.ClockType = 0x00000002U|0x00000001U
                              |0x00000004U|0x00000008U;
  RCC_ClkInitStruct.SYSCLKSource = 0x00000000U;
  RCC_ClkInitStruct.AHBCLKDivider = 0x00000000U;
  RCC_ClkInitStruct.APB1CLKDivider = 0x00000000U;
  RCC_ClkInitStruct.APB2CLKDivider = 0x00000000U;

  if (HAL_RCC_ClockConfig(&RCC_ClkInitStruct, 0x00000000U) != HAL_OK)
  {
    Error_Handler();
  }
}

/* USER CODE BEGIN 4 */

/* USER CODE END 4 */

/**
  * @brief  This function is executed in case of error occurrence.
  * @retval None
  */
void Error_Handler(void)
{
  /* USER CODE BEGIN Error_Handler_Debug */
  /* User can add his own implementation to report the HAL error return state */
  __disable_irq();
  while (1)
  {
  }
  /* USER CODE END Error_Handler_Debug */
}


