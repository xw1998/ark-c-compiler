# arkCC + armcc5 STM32 构建手册

> 目标读者：想在 Windows 上用 ARM Compiler 5（armcc 5.06）把 arkCC 编译成 STM32 固件，并在 STM32H743 板上跑自托管编译器的人
> 编码：UTF-8（无 BOM）

---

## 1 概述

arkCC 是一款用 C99 编写的自托管 C 编译器。本手册描述两种构建路径：

| 路径 | 工具链 | 输入 | 输出 | 用途 |
| --- | --- | --- | --- | --- |
| **A. armcc5 命令行**（推荐） | armcc 5.06 + armlink + fromelf + armasm | arkCC 全部 `.c` 源码 + MDK 用户文件 + 启动汇编 | `arkcc_stm32.{elf,hex,bin}` | 烧录到 STM32H743 后板载编译 C 源码 |
| **B. Keil MDK IDE** | 同上，但通过 `.uvprojx` 工程文件 | 同上 | 同上 | 在 Keil 集成环境中构建调试 |

路径 A 是一行 PowerShell 脚本即可完成的"最简流程"；路径 B 适合需要 ST-Link 单步调试的场景。

---

## 2 环境准备

### 2.1 安装 Keil MDK 5.x

1. 从 [keil.com](https://www.keil.com/download/) 下载 MDK-ARM 5.36+（含 armcc 5.06 update 7）。
2. 默认安装路径：`D:\Keil_v5\`，armcc 工具链位于 `D:\Keil_v5\ARM\ARMCC\bin\`。
3. 安装 STM32H7 系列 Device Pack：Keil → Pack Installer → 搜索 `Keil.STM32H7_DFP`。

### 2.2 验证工具链

打开 PowerShell：

```powershell
& "D:\Keil_v5\ARM\ARMCC\bin\armcc.exe" --version
# 输出应包含：ARM Compiler 5.06 update 7 (build 960)

& "D:\Keil_v5\ARM\ARMCC\bin\armlink.exe" --help | Select-String "scatter"
# 应看到 --scatter 选项说明
```

如果 `armcc.exe` 不在 PATH，`build_stm32_armcc.ps1` 会自动探测 `D:\Keil_v5\ARM\ARMCC\bin\` 路径。

### 2.3 硬件准备

| 设备 | 用途 |
| --- | --- |
| STM32H743VIT6 开发板 | 运行 arkCC 固件 |
| ST-Link V2/V3 调试器 | 烧录 + 调试 |
| W25Q128 SPI Flash（板载或外接） | 存放待编译的 `.c` 源码 |
| USB-TTL 串口模块 | 查看 UART 输出（PA9/PA10，115200 8N1） |

---

## 3 路径 A：一键脚本构建

### 3.1 运行脚本

```powershell
cd "<ark-cc-repo-path>"
powershell -ExecutionPolicy Bypass -File build_stm32_armcc.ps1
```

### 3.2 脚本做了什么

1. **探测 armcc5**：先尝试 PATH，再尝试 `D:\Keil_v5\ARM\ARMCC\bin\`。
2. **编译 16 个核心 `.c`**（`src/*.c`）：
   - `compiler.c` `lexer.c` `parser.c` `sema.c` `ir.c` `irgen.c` `ast.c` `type.c`
   - `symtab.c` `memory.c` `preproc.c` `codegen_common.c` `cpu.c` `scatter.c` `config.c` `opt.c`
3. **编译 2 个 ARM 后端**：`backend/arm/backend_arm.c` + `backend/registry.c`
4. **编译 2 个 STM32 port**：`port/stm32/platform_stm32.c` + `port/stm32/flash_fs_stm32.c`
5. **编译 5 个 MDK 用户文件**：`mdk/STM32H743_ArkCC/User/{main,stm32h7xx_it,stm32h7xx_hal_msp,system_stm32h7xx,bsp_w25q}.c`
6. **汇编启动文件**：`Startup/startup_stm32h743xx.s`（用 `armasm`）
7. **armlink 链接**：用 `--scatter=Linker/STM32H743VITx_FLASH.sct` 链接所有 `.o`
8. **fromelf 转换**：生成 `.hex` 与 `.bin`

### 3.3 armcc5 关键编译选项

| 选项 | 说明 |
| --- | --- |
| `--cpu=Cortex-M7` | 目标 CPU 选择 |
| `--thumb` | Thumb-2 模式（Cortex-M 强制） |
| `-O0` | 关闭优化（便于调试；如要缩小代码体积可换 `-O2` 或 `-O3`） |
| `-g` | 生成调试信息 |
| `--c99` | **必须**。armcc5 默认 C90，arkCC 源码需要 C99 的混合声明与语句 |
| `--apcs=interwork` | ARM/Thumb 互操作 ABI |
| `-DARKCC_PROFILE=ARKCC_PROFILE_STM32_MIN` | 启用 STM32 最小配置 profile，把缓冲区尺寸从主机 GB 级降到 KB 级 |
| `-I..\..\include -I..\..\include\..\stdlib\include` | 头文件搜索路径 |

### 3.4 armlink 关键选项

| 选项 | 说明 |
| --- | --- |
| `--scatter=<sct>` | scatter 加载描述文件，定义内存布局 |
| `--map` | 输出 map 文件 |
| `--symbols` | 输出符号表 |
| `--info=totals,sizes,unused,summarysizes` | 各段大小汇总 |

**semihosting 处理**：armcc5 C 库默认使用 semihosting，但 scatter loading 与 semihosting 的 `__user_initial_stackheap` 冲突。解决方法是在 `system_stm32h7xx.c` 中提供自定义 `__user_initial_stackheap`，把 C 库堆指向 `ark_heap_buffer`（AXI SRAM 中的 32 KB 缓冲区）。详见 [6.1](#61-l6915e-the-semihosting-__user_initial_stackheap-cannot-reliably-set-up)。

### 3.5 输出文件

输出目录：`bootstrap_x86\armcc_objs\`

| 文件 | 大小（典型） | 用途 |
| --- | --- | --- |
| `arkcc_stm32.elf` | ~458 KB | 完整 ELF（含符号表，调试用） |
| `arkcc_stm32.hex` | ~428 KB | Intel HEX 格式（ST-Link Utility 烧录用） |
| `arkcc_stm32.bin` | ~152 KB | 纯二进制（openocd 烧录用） |
| `arkcc_stm32.map` | - | 链接 map 文件（内存布局分析） |

### 3.6 验证构建结果

```powershell
# 检查入口点
& "D:\Keil_v5\ARM\ARMCC\bin\fromelf.exe" --text -s bootstrap_x86\armcc_objs\arkcc_stm32.elf | Select-String "Reset_Handler|main"
# 应看到 Reset_Handler @ 0x080xxxxx 和 main @ 0x080xxxxx

# 检查文件大小
Get-ChildItem bootstrap_x86\armcc_objs\arkcc_stm32.* | Select-Object Name, Length
```

---

## 4 路径 B：Keil MDK IDE 构建

### 4.1 打开工程

用 Keil µVision 打开 `mdk/STM32H743_ArkCC/ArkCC.uvprojx`。

### 4.2 配置选项

Project → Options for Target（Alt+F7）：

| 选项卡 | 设置 |
| --- | --- |
| **Device** | STM32H743VIT6（从 STM32H7 DFP 选择） |
| **Target** | ARM Compiler：**V5.06**（重要：不要选 V6，V6 是 armclang） |
| **Target** | Read/Only Memory Areas：按 scatter 文件配置（一般默认即可） |
| **Output** | Name of Executable：`arkcc_stm32` |
| **Listing** | 勾选 `Map File` |
| **C/C++** | Optimization：`-O0`（调试）或 `-O2`（发布） |
| **C/C++** | C/C++ Language：选 **C99** |
| **C/C++** | Preprocessor Symbols：Define `ARKCC_PROFILE=ARKCC_PROFILE_STM32_MIN` |
| **C/C++** | Include Paths：`..\..\include;..\..\include\..\stdlib\include;..\..\port\stm32;Drivers\CMSIS\Device\ST\STM32H7xx\Include;Drivers\CMSIS\Include` |
| **Asm** | 同 C/C++ Include Paths |
| **Linker** | Use Memory Layout from Target Dialog：**取消勾选** |
| **Linker** | Scatter File：`Linker\STM32H743VITx_FLASH.sct` |
| **Linker** | 勾选 `Use Linker Script` |
| **Debug** | ST-Link Debugger |

### 4.3 构建与烧录

1. **Build**：Project → Build Target（F7）
2. **Download**：Flash → Download（F8）
3. **调试**：Debug → Start/Stop Debug Session（Ctrl+F5）

### 4.4 HAL 替换

工程自带的 `Drivers/CMSIS/Device/ST/STM32H7xx/Include/` 是占位头文件。若要用真正的 HAL：

1. 从 STM32CubeH7 仓库复制 `Drivers/CMSIS/**` 与 `Drivers/STM32H7xx_HAL_Driver/**` 覆盖。
2. 在 Keil → Project → Manage → Project Items → Groups 中，把需要的 `stm32h7xx_hal_*.c` 加入 `Drivers/HAL` 分组。
3. 在 `stm32h7xx_hal_conf.h` 中启用需要的 HAL 模块。

> 注意：当前 `system_stm32h7xx.c` 与 `stm32h7xx_hal_msp.c` 提供了**寄存器级**的 UART/SPI 实现，无需 HAL 即可工作。替换 HAL 是可选的。

---

## 5 内存布局与 .sct 文件

### 5.1 STM32H743 内存区域

| 区域 | 起始地址 | 大小 | 用途 |
| --- | --- | --- | --- |
| Flash | `0x08000000` | 2 MB | 代码 + 只读数据 |
| DTCM | `0x20000000` | 128 KB | 全局变量 + 栈 |
| AXI SRAM | `0x24000000` | 512 KB | arkCC 大型缓冲区 |
| ITCM | `0x00000000` | 64 KB | （未使用） |
| SRAM1/2/3 | `0x30000000` | 288 KB | （未使用） |

### 5.2 Scatter 文件结构

文件：`mdk/STM32H743_ArkCC/Linker/STM32H743VITx_FLASH.sct`

```text
LR_IROM1 0x08000000 0x00200000  {
  ER_IROM1 0x08000000 0x00200000 {        /* Flash: 代码 + 只读数据 */
    *.o (RESET, +First)                   /* 向量表必须在前 */
    *(InRoot$$Sections)                  /* C 库内部段 */
    .ANY (+RO)                           /* 其余 .text/.rodata */
    .ANY (+XO)                           /* 执行段（如有） */
  }
  RW_IRAM1 0x20000000 0x00020000 {        /* DTCM 128K: 全局变量 */
    .ANY (+RW +ZI)                       /* .data + .bss */
  }
  RW_AXI 0x24000000 0x00080000 {          /* AXI SRAM 512K: 大缓冲区 */
    *(.ark_heap)                         /* arkCC 内存池 */
    *(.ark_code)                          /* 生成的机器码 */
    *(.ark_buf)                          /* 大型静态数组 */
  }
}
```

### 5.3 段到区域的映射

arkCC 源码中用 `__attribute__((section(".ark_buf")))` 把大型静态数组路由到 AXI SRAM：

| 段 | 来源 | 区域 |
| --- | --- | --- |
| `.text` + `.rodata` | 代码 + 常量 | Flash |
| `.data` + `.bss` | 全局变量 | DTCM |
| `.ark_buf` | `compiler.c`/`memory.c`/`preproc.c`/`backend_arm.c` 的大型数组 | AXI SRAM |
| `.ark_code` | `User/main.c` 的 `ark_code_buffer[32K]` | AXI SRAM |
| `.ark_heap` | `User/main.c` 的 `ark_heap_buffer[32K]` | AXI SRAM |

### 5.4 当前内存占用

| 区域 | 占用 | 容量 | 利用率 |
| --- | --- | --- | --- |
| Flash | 148.59 KB | 2 MB | 7.3% |
| DTCM | 19.3 KB | 128 KB | 15% |
| AXI SRAM | 440 KB | 512 KB | 86%（余 72 KB） |

**AXI SRAM 明细**：

| 段 | 大小 | 内容 |
| --- | --- | --- |
| `.ark_buf`（compiler.o） | 160 KB | `g_src`(32K) + `g_asm`(64K) + `g_code`(32K) + `dep/ld/sct`(24K) + 其他(8K) |
| `.ark_buf`（memory.o） | 64 KB | `g_pool` 内存池 |
| `.ark_buf`（preproc.o） | 64 KB | `g_inc_bufs`(4×8K) + `out_buf`(32K) |
| `.ark_buf`（backend_arm.o） | 24 KB | `g_arm_syms`(12K) + `g_arm_relocs`(12K) |
| `.ark_code` | 32 KB | 生成的 Thumb-2 机器码缓冲 |
| `.ark_heap` | 32 KB | armcc5 C 库堆 |

---

## 6 常见构建错误

### 6.1 L6915E: The semihosting __user_initial_stackheap cannot reliably set up...

**原因**：armcc5 C 库默认使用 semihosting 初始化堆/栈，与 scatter loading 冲突。

**解决**：`mdk/STM32H743_ArkCC/User/system_stm32h7xx.c` 已提供 `__user_initial_stackheap` 重定向：

```c
__value_in_regs struct __initial_stackheap __user_initial_stackheap(
        unsigned R0, unsigned SP, unsigned R2, unsigned SL) {
    struct __initial_stackheap config;
    config.heap_base  = ark_heap_buffer;
    config.heap_limit = ark_heap_buffer + 32 * 1024;
    config.stack_base  = (unsigned char *)(0x20000000 + 0x20000);
    config.stack_limit = (unsigned char *)(0x20000000 + 0x20000 - 0x8000);
    return config;
}
```

确认该文件参与编译，且用 `--c99` 编译。

### 6.2 L6220E: Load region RW_AXI size exceeds limit

**原因**：AXI SRAM（512 KB）溢出。

**解决**：减小 `include/arkcc_config.h` 中 STM32 profile 的缓冲区尺寸：

```c
#ifndef ARK_POOL_SIZE
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARK_POOL_SIZE          (64 * 1024)     /* 可减到 32K */
# else
#   define ARK_POOL_SIZE          (64 * 1024 * 1024)
# endif
#endif
```

可调项：
- `ARK_POOL_SIZE`（默认 64K）
- `PP_INC_BUF` × `PP_MAX_INC_DEPTH`（默认 8K × 4 = 32K）
- `PP_BUF_SIZE`（默认 32K）
- `ARK_ASM_BUF_SIZE`（默认 64K）
- `ARK_CODE_BUF_SIZE`（默认 32K）
- `ark_heap_buffer`（[User/main.c](../mdk/STM32H743_ArkCC/User/main.c)，默认 32K）

### 6.3 #268: declaration may not appear after executable statement

**原因**：armcc5 默认 C90 模式，不允许混合声明与语句。

**解决**：`build_stm32_armcc.ps1` 已加 `--c99`。若在 Keil IDE 中构建，需在 Options → C/C++ → Language 选 C99。

### 6.4 Undefined symbol arkcc_on_output

**原因**：`flash_fs_stm32.c` 调用 `arkcc_on_output()` 但未提供定义。

**解决**：已在 `flash_fs_stm32.c` 提供 `__attribute__((weak))` 默认实现（把字节以 hex 形式输出到 UART）。用户可在 `main.c` 中提供强定义覆盖。

### 6.5 Undefined symbol HAL_UART_Receive

**原因**：MDK `main.c` 调用 `HAL_UART_Receive()` 但占位头文件未声明。

**解决**：已在 `stm32h743xx.h` 添加声明，在 `system_stm32h7xx.c` 添加寄存器级实现。

### 6.6 Multiply defined symbols (HAL_Init, HAL_UART_Transmit, ...)

**原因**：HAL 函数实现同时出现在 `stm32h7xx_hal_msp.c` 和 `system_stm32h7xx.c`。

**解决**：`stm32h7xx_hal_msp.c` 已回退为只包含 MSP 钩子空函数，所有 HAL 实现集中在 `system_stm32h7xx.c`。

### 6.7 Chinese path encoding (PowerShell)

**原因**：PowerShell 脚本使用绝对路径含中文字符（`d:\工作\...`）导致编码乱码。

**解决**：`build_stm32_armcc.ps1` 已改为相对路径，从项目根目录运行。

---

## 7 semihosting 依赖移除

armcc5 C 库默认使用 semihosting（通过 BKPT 指令陷入调试器）。在无调试器的 STM32 上运行会触发 HardFault。arkCC 源码已移除所有 semihosting 依赖：

| 原始依赖 | 替换 | 文件 |
| --- | --- | --- |
| `fopen/fread/fclose` | `fs_read_file()` 抽象层（host=stdio，STM32=W25Q） | `src/scatter.c` |
| `vsnprintf` | 自定义 `put_fmt()`（支持 `%s`/`%X`/`%d`/`%c`/`%%`） | `src/scatter.c` |
| `snprintf("%.17g")` | 自定义 `sb_putf()` double-to-string | `src/irgen.c` |
| `getenv("ARKCC_DUMP_SYMS")` | profile-aware `g_arm_dump_syms` 全局标志 | `src/backend/arm/backend_arm.c` |
| `<stdio.h>` include | 移除（无需） | `src/compiler.c` `src/ir.c` `src/type.c` |
| `<stdlib.h>` include | 移除（用 `mem_realloc` 替代 `realloc`） | `src/backend/arm/backend_arm.c` |

加上 `__user_initial_stackheap` 重定向，arkCC 固件完全脱离 semihosting，可在无调试器的目标板上独立运行。

---

## 8 烧录与验证

### 8.1 用 ST-Link Utility 烧录

1. 打开 STM32 ST-LINK Utility
2. Target → Connect
3. File → Open File：选择 `arkcc_stm32.hex`
4. Target → Program & Verify
5. 复位开发板

### 8.2 用 openocd 烧录

```bash
openocd -f interface/stlink.cfg -f target/stm32h7x.cfg \
    -c "program arkcc_stm32.bin 0x08000000 verify reset exit"
```

### 8.3 验证串口输出

连接 PA9(TX) / PA10(RX) 到 USB-TTL，115200 8N1：

```
=== Ark C Compiler on STM32H743 ===
Compiling /app/main.c from W25Q...
Exit code: 42
```

如果看到上述输出，说明 arkCC 在 STM32 上成功自托管编译了 `/app/main.c`。

### 8.4 准备 W25Q 上的源文件

W25Q128 需要一个极简文件索引表 + 文件数据：

```text
0x000000   FileEntry[32]   每项 32 B = char name[24] + uint32 offset + uint32 size
0x010000   /app/main.c     用户源代码
```

主机侧 Python 脚本生成镜像：

```python
import struct
def make_image(files):
    table = bytearray(32 * 32)
    body = bytearray()
    base = 0x010000
    for i, (name, data) in enumerate(files):
        n = name.encode()[:24].ljust(24, b'\0')
        struct.pack_into('<24sII', table, i*32, n, base, len(data))
        body += data
        base += (len(data) + 4095) & ~4095
    return bytes(table) + bytes(0x10000 - len(table)) + bytes(body)

with open('w25q_image.bin', 'wb') as f:
    f.write(make_image([('/app/main.c', b'int main(void){return 42;}\n')]))
```

然后用 ST-Link / 串口 / USB 把镜像写入 W25Q（注意 4 KB 扇区擦除）。

---

## 9 缓冲区尺寸调优

所有大型缓冲区尺寸由 [include/arkcc_config.h](../include/arkcc_config.h) 的 `ARKCC_PROFILE` 宏控制：

| 宏 | STM32_MIN | HOST_FULL | 用途 |
| --- | --- | --- | --- |
| `ARK_POOL_SIZE` | 64 KB | 64 MB | AST/IR/符号表内存池 |
| `ARK_ASM_BUF_SIZE` | 64 KB | 1 MB | 汇编文本缓冲 |
| `ARK_CODE_BUF_SIZE` | 32 KB | 1 MB | 机器码缓冲 |
| `ARK_OBJ_BUF_SIZE` | 4 KB | 256 KB | 对象文件缓冲 |
| `ARK_LINK_BUF_SIZE` | 4 KB | 256 KB | 链接缓冲 |
| `ARK_SRC_BUF_SIZE` | 32 KB | 1 MB | 源码读入缓冲 |
| `PP_BUF_SIZE` | 32 KB | 4 MB | 预处理输出缓冲 |
| `PP_INC_BUF` | 8 KB | 1 MB | 每个 include 文件缓冲 |
| `PP_MAX_INC_DEPTH` | 4 | 32 | include 嵌套深度 |
| `ARM_MAX_SYMBOLS` | 1024 | 4096 | 符号表项数 |
| `ARM_MAX_RELOCS` | 1024 | 4096 | 重定位项数 |
| `ARM_MAX_GVARS` | 512 | 2048 | 全局变量项数 |

**STM32 总占用公式**：
```
AXI = ARK_POOL_SIZE + ARK_ASM_BUF_SIZE + ARK_CODE_BUF_SIZE + ARK_OBJ_BUF_SIZE
    + ARK_LINK_BUF_SIZE + ARK_SRC_BUF_SIZE + PP_BUF_SIZE
    + PP_INC_BUF * PP_MAX_INC_DEPTH
    + ARM_MAX_SYMBOLS * 12 + ARM_MAX_RELOCS * 12
    + ark_heap_buffer + ark_code_buffer
```

要进一步缩小 AXI 占用，可减少 `ARK_POOL_SIZE`（影响可编译源码大小）或 `PP_INC_BUF * PP_MAX_INC_DEPTH`（影响 include 嵌套深度）。

---

## 10 armcc5 兼容路线图

**目标**：在装有 armcc5 的电脑上，arkCC 完全兼容 armcc5，能不对 MDK 工程做任何改动编译出可执行文件，然后能在 STM32 上运行 arkCC，实现 STM32 上编译 STM32 的程序。

| 阶段 | 目标 | 状态 |
| --- | --- | :---: |
| 阶段 1 | arkCC 自身用 armcc5 编译为 STM32 固件 | ✅ 已完成 |
| 阶段 2 | STM32 板载 arkCC 能编译 `.c` 源码生成 `.bin` | ✅ 已完成 |
| 阶段 3 | 板载编译产物能烧写回 Flash 并跳转执行 | 🚧 进行中 |
| 阶段 4 | 无需改动的 MDK 工程可被 arkCC 直接编译 | 📋 路线图 |
| 阶段 5 | `__user_initial_stackheap`、HAL 重定向、scatter 链接完整支持 | 📋 路线图 |

**阶段 1-2 已通过 `build_stm32_armcc.ps1` 实现**，本手册描述的全部内容均已在实际硬件上验证通过。阶段 3-5 为后续工作。

---

## 11 参考资料

- [docs/MANUAL.md](MANUAL.md)：arkCC 完整用户手册
- [README.md](../README.md)：项目简介与功能特性
- [include/arkcc_config.h](../include/arkcc_config.h)：缓冲区尺寸配置
- [build_stm32_armcc.ps1](../build_stm32_armcc.ps1)：armcc5 构建脚本
- [mdk/STM32H743_ArkCC/](../mdk/STM32H743_ArkCC/)：Keil MDK 工程
- ARM Compiler 5 Documentation: [developer.arm.com/tools-and-software/software-development-tools/legacy-compiler-tools](https://developer.arm.com/tools-and-software/software-development-tools/legacy-compiler-tools)
