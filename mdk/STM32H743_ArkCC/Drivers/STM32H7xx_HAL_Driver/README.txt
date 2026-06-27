Ark C Compiler - MDK STM32H743 - HAL 驱动占位目录
==================================================

本目录留空，仅用于放置 STM32CubeH7 中的官方 HAL 驱动。

请按下面步骤填充：

  1. 从 https://github.com/STMicroelectronics/STM32CubeH7 拷贝
     Drivers/STM32H7xx_HAL_Driver/ 整个目录到此处；
  2. 在 Keil 工程的 "Drivers/HAL" 组中把需要的 *.c 添加进来
     （至少需要 stm32h7xx_hal.c / hal_cortex / hal_gpio /
      hal_rcc / hal_uart / hal_spi / hal_pwr）；
  3. 不要将原厂代码上传到本仓库，避免授权问题。

注意：本工程下提供的 stm32h7xx.h / stm32h743xx.h 仅为编译占位，
若同时启用官方 CMSIS，请用官方头文件覆盖。
