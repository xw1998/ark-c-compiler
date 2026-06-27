# Ark C Compiler - STM32H743 MDK 工程

本目录提供把 **Ark C Compiler** 作为 **STM32H743VIT6** 自宿主编译器运行的
Keil MDK-ARM 5.x 工程模板。

> 工程路径：`mdk/STM32H743_ArkCC/ArkCC.uvprojx`
> 目标编译器：ARM Compiler 6（armclang）
> 目标芯片：STM32H743VITx（Cortex-M7，2 MB Flash，1 MB RAM）

## 1. 目录结构

```
mdk/STM32H743_ArkCC/
├── ArkCC.uvprojx                       Keil 工程文件
├── ArkCC.uvoptx                        Keil 选项文件
├── RTE/_ArkCC/RTE_Components.h         RTE 占位头
├── Drivers/
│   ├── CMSIS/
│   │   ├── Device/ST/STM32H7xx/Include/   最小化 stm32h7xx.h / stm32h743xx.h
│   │   └── Include/                        最小化 core_cm7.h / cmsis_compiler.h
│   └── STM32H7xx_HAL_Driver/README.txt    HAL 留空目录说明
├── User/
│   ├── main.c                          应用入口
│   ├── stm32h7xx_it.c                  中断向量
│   ├── stm32h7xx_hal_msp.c             HAL MSP 钩子
│   ├── system_stm32h7xx.c              SystemInit / HAL 占位
│   ├── bsp_w25q.c                      W25Q128 SPI Flash 驱动
│   └── Inc/bsp_w25q.h
├── Startup/startup_stm32h743xx.s       启动文件（armclang asm）
└── Linker/STM32H743VITx_FLASH.sct      scatter 文件
```

编译器核心源代码 **不被拷贝**，而是通过相对路径直接引用：

| Keil 组          | 引用路径                                 |
|------------------|------------------------------------------|
| ArkCC/Core       | `..\..\src\*.c`                          |
| ArkCC/Backend    | `..\..\src\backend\registry.c` 与 `..\..\src\backend\arm\backend_arm.c` |
| ArkCC/Port       | `..\..\port\stm32\platform_stm32.c` 与 `..\..\port\stm32\flash_fs_stm32.c` |

修改仓库根目录下的源代码后，Keil 重新构建即可同步。

## 2. 编译器/链接器配置要点

| 项目              | 取值                                                     |
|-------------------|----------------------------------------------------------|
| 编译器            | ARM Compiler 6（`uAC6=1`）                                |
| 语言标准          | C99（`uC99=1`）                                          |
| 优化              | `-O2`（`Optim=3`）+ `-fno-common -ffunction-sections -fdata-sections` |
| FPU               | 双精度（`RvdsVP=2`）                                     |
| 预处理宏          | `USE_HAL_DRIVER, STM32H743xx, ARK_TARGET_STM32H7`         |
| Include 路径      | `..\..\include; ..\..\stdlib\include; .\User\Inc; .\Drivers\CMSIS\Device\ST\STM32H7xx\Include; .\Drivers\CMSIS\Include; .\Drivers\STM32H7xx_HAL_Driver\Inc; .\RTE\_ArkCC` |
| 链接 scatter      | `.\Linker\STM32H743VITx_FLASH.sct`                       |
| 调试器            | ST-Link（`BIN\STLink.dll`）                              |

scatter 文件把 ArkCC 的堆/代码缓冲单独放到 AXI SRAM：

- DTCM `0x20000000 + 128KB` → 普通 RW/ZI/stack
- AXI  `0x24000000 + 512KB` → `.ark_heap`、`.ark_code` 专用段
- Flash `0x08000000 + 2MB`  → 程序代码

`User/main.c` 中：

```c
__attribute__((section(".ark_heap"))) unsigned char ark_heap_buffer[64 * 1024];
__attribute__((section(".ark_code"))) unsigned char ark_code_buffer[32 * 1024];
```

## 3. 用户使用流程（5 步）

1. **补全官方 CMSIS / HAL**
   - 从 [STM32CubeH7](https://github.com/STMicroelectronics/STM32CubeH7)
     拷贝 `Drivers/CMSIS/Device/ST/STM32H7xx/Include/*` 覆盖
     `Drivers/CMSIS/Device/ST/STM32H7xx/Include/`；
   - 拷贝 `Drivers/CMSIS/Include/core_cm7.h` 等覆盖
     `Drivers/CMSIS/Include/`；
   - 拷贝 `Drivers/STM32H7xx_HAL_Driver/Inc + Src` 覆盖
     `Drivers/STM32H7xx_HAL_Driver/`，并在 Keil 的 `Drivers/HAL` 组里
     添加需要的 `stm32h7xx_hal*.c`（至少：`stm32h7xx_hal.c`、
     `_hal_cortex.c`、`_hal_gpio.c`、`_hal_rcc.c`、`_hal_pwr_ex.c`、
     `_hal_uart.c`、`_hal_spi.c`）。
2. **替换占位代码**
   - 用 STM32CubeMX 重新生成 `User/system_stm32h7xx.c`、
     `User/stm32h7xx_hal_msp.c`、`User/main.c` 中的
     `HAL_Init / SystemClock_Config / MX_GPIO_Init / MX_USART1_UART_Init /
     MX_SPI1_Init`，或手动按以下要求实现：
       - HSE 25 MHz → PLL1 → SYSCLK **480 MHz**
       - USART1 = 115200 8N1，PA9 (TX) / PA10 (RX)
       - SPI1 主模式，PA5/PA6/PA7 + PA4 (CS)
3. **准备 W25Q128 数据**
   - 通过 USB 烧录器先在 SPI Flash 的 `0x000000` 写入
     `FileEntry[MAX_FILES]` 索引表（每项 32 字节：`name[24] + offset(u32) + size(u32)`）；
   - 紧接着追加各 `.c` 源代码（如 `/app/main.c`）。
   - 详见 `port/stm32/flash_fs_stm32.c`。
4. **打开工程并编译**
   - 用 Keil MDK 5.36+ 打开 `mdk/STM32H743_ArkCC/ArkCC.uvprojx`；
   - 选择 ARM Compiler 6.16+；
   - `Project → Build Target`，产物在 `Objects/ArkCC.axf / .hex`。
5. **烧录并观察输出**
   - 用 ST-Link 烧录；
   - 串口 115200 (PA9/PA10) 连 PC 串口工具，应看到：

     ```
     === Ark C Compiler on STM32H743 ===
     Heap @ 24000000, Code @ 24010000
     Compiling /app/main.c from W25Q...
     Exit code: <返回值>
     ```

## 4. 已知限制

- `Drivers/CMSIS/**`、`Drivers/STM32H7xx_HAL_Driver/**` 当前是 **最小化占位**，
  仅保证工程结构可打开、ArkCC 核心源可独立编译。**必须由用户补齐官方代码**。
- `system_stm32h7xx.c` 与 `stm32h7xx_hal_msp.c` 中的 `SystemInit` /
  `HAL_*MspInit` / `MX_*_Init` 均为占位，不会真正初始化 480 MHz PLL、
  USART1、SPI1。烧录后必须替换为 STM32CubeMX 生成或手写的初始化。
- 当前只编译 **ARM 后端**（`backend_arm.c`）。未启用 x86_64 / RISC-V / C
  后端以节省 Flash；如需启用，请把对应 `src/backend/<arch>/*.c` 添加到
  `ArkCC/Backend` 组。
- `startup_stm32h743xx.s` 只提供最小向量表（NMI~SysTick），未声明任何
  外设 IRQ。如需 USART1/SPI1 中断驱动，请补充向量表与 ISR。
- 工程文件中部分次要字段（Pack 版本号、Flash 算法 ID 等）采用通用默认
  值，Keil 首次打开时可能提示自动更新，按提示确认即可。
- 工程要求：Keil MDK 5.36+ / ARM Compiler 6.16+。

## 5. 编译器调用接口

```c
int ark_compile_and_run(const char *path);   /* 见 include/compiler.h */
```

`User/main.c` 默认调用 `ark_compile_and_run("/app/main.c")`，编译来自
`flash_fs_stm32.c` 提供的 SPI Flash 虚拟文件系统。

返回值含义见 `include/common.h`：`ARK_OK=0`、`ARK_ERR_LEX=-2` …。
