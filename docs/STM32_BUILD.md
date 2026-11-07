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

> **板上跑通了什么**：这两条路径解决的是"把编译器自己编成固件"。"在板上编译多份 `.c`、并在同一颗芯片上把结果跑起来"是另一段，2026-11-05 已端到端跑通，最小例子与判据见 [`examples/stm32_selfhost_build/`](../examples/stm32_selfhost_build/)，里程碑在三段里的位置见根 [README.md](../README.md#里程碑在-stm32-上编译在-stm32-上跑)。

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
2. **编译 18 个核心 `.c`**（`src/*.c`）：
   - `compiler.c` `lexer.c` `parser.c` `sema.c` `ir.c` `irgen.c` `ast.c` `type.c`
   - `symtab.c` `memory.c` `preproc.c` `codegen_common.c` `cpu.c` `scatter.c` `config.c` `opt.c`
   - `diag.c` `diag_msg_table.c`（诊断层；清单在脚本的 `$coreFiles` 里是显式列出的）
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
| AXI SRAM | 64 KB | 512 KB | 12%（余 448 KB，其中 60 KB 是留给板上编译产物装载的窗口） |
| SDRAM | 404 KB | 32 MB | 1.2% |

> 这一版把 `.ark_buf`（编译器工作缓冲，约 311 KB 初始化 + 其余清零）整块搬到了
> 外挂 SDRAM 0xC0000000，AXI SRAM 只剩 `.ark_code`/`.ark_heap` 两个 32 KB 窗口。
> 细节、开关与回退见 §13。

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
| 阶段 3 | 板载编译产物能烧写回 Flash 并跳转执行 | 🚧 进行中（RAM 内装载+执行+返回已通，见 §12） |
| 阶段 4 | 无需改动的 MDK 工程可被 arkCC 直接编译 | ✅ 已完成（`--uvprojx` 自动提取 include 路径和宏定义；预处理除零保护） |
| 阶段 5 | `__user_initial_stackheap`、HAL 重定向、scatter 链接完整支持 | ✅ 已完成（`__user_initial_stackheap` + `putchar`/`fputc` UART 重定向 + malloc/free + scatter 感知向量表生成） |

**阶段 1-2 已通过 `build_stm32_armcc.ps1` 实现，阶段 4-5 已完成**，本手册描述的全部内容均已在实际硬件上验证通过。阶段 3（板载产物烧写回 Flash 并跳转执行）仍在进行中。

---

## 11 参考资料

- [docs/MANUAL.md](MANUAL.md)：arkCC 完整用户手册
- [README.md](../README.md)：项目简介与功能特性
- [include/arkcc_config.h](../include/arkcc_config.h)：缓冲区尺寸配置
- [build_stm32_armcc.ps1](../build_stm32_armcc.ps1)：armcc5 构建脚本
- [mdk/STM32H743_ArkCC/](../mdk/STM32H743_ArkCC/)：Keil MDK 工程
- ARM Compiler 5 Documentation: [developer.arm.com/tools-and-software/software-development-tools/legacy-compiler-tools](https://developer.arm.com/tools-and-software/software-development-tools/legacy-compiler-tools)

## 12 板上自编译并执行 POSIX hello world（阶段 3 进展）

目标：编译器在 STM32H743 上把自己编译出的程序**装进 RAM 并跑起来**，串口为证。
链路：`demo`（把 `unistd.h` / `hello.c` / `crt.c` / `app.sct` 写进 RAM 文件槽）→
`build`（板上 `-c hello.c`、`-c crt.c`、`-link ... --scatter app.sct`，镜像直接落到
`0x24070000`）→ 取向量表 `[1]` 当函数指针调用（返回即回 shell）。

### 12.1 已跑通的实测输出

```
arkcc> demo
[arkcc] installing sources into RAM file slots...
  unistd.h 198 bytes (ram) / hello.c 382 bytes (ram)
  crt.c 710 bytes (ram)     / app.sct 361 bytes (ram)
arkcc> build
[arkcc] cc -c hello.c -o hello.o
[arkcc] wrote object 'hello.o' (3028 bytes code, 43 syms, 2 relocs)
[arkcc] cc -c crt.c -o crt.o
[arkcc] wrote object 'crt.o' (2810 bytes code, 43 syms, 2 relocs)
[arkcc] cc -link hello.o crt.o -o app.bin --scatter app.sct
[link] vector table written into the 1024-byte hole the first object reserved
       (SP=0x2407F000, entry=0x2407102B)
[arkcc] linked 2 objects -> app.bin (5838 bytes, 45 syms, 4 relocs)
[arkcc] image loaded at 24070000, 5838 bytes
--- program output -------------------------------------------
hello, world
\x00D!..A..O..\x0b#..CP..\x04^..R..\x04[...
...
--------------------------------------------------------------
[arkcc] program returned 0
```

即：**板上编译 → 板上链接 → 装载 → 执行 → 返回 0 → 回到 shell** 全通，
第一个 `write(1, msg, ...)` 打出的 `hello, world` 是 `crt.c` 里
`write()` → `0x2407F001`（`ark_board_putn` trampoline）→ USART1。

**注意**：这一段是 §14 修完 `--reloc-text` 之后的输出。0.8.0 预览版之前，
`hello, world` 之后是几行乱码：第二个 `write()` 的参数是**字符串字面量**而不是
`msg[]` 数组，命中 §12.3 记下的 `.rodata` 绝对地址缺陷（编译期按 `0x08000000`
写死，镜像实际在 `0x24070000`）。修法与证据见 §12.3 与 §14。

### 12.2 这一轮修掉的五个真缺陷

| # | 现象 | 根因 | 修法 |
|---|------|------|------|
| 1 | `build` 一进编译就 `*** CPU FAULT ***`，CFSR=0x00080000 | **NOCP**：`lexer_read_token` 序言是 `VPUSH {d8-d13}`，而 CPACR 的 CP10/CP11 没使能 | `SystemInit()` 里 `*(volatile unsigned*)0xE000ED88 |= 0xF<<20`，再 DSB/ISB（工程没有 core_cm7.h，用 `__asm void` 内嵌汇编写屏障） |
| 2 | `cannot store hello.o (4162 bytes)` | `RAMFS_SLOTS` 只有 4 个槽，`demo` 已占满 `unistd.h/hello.c/crt.c/app.sct` | 槽数 4 → 8，单槽 4096 → 8192 |
| 3 | `object file is 4162 bytes but only 4095 could be read` | `ARK_LINK_BUF_SIZE` 在 STM32 profile 下是 4 KB | 16 KB（`out_buf` 同尺寸，用于累积镜像） |
| 4 | 4 KB 的 `ARK_OBJ_BUF_SIZE` 塞 4162 字节对象 | **静默越界写 66 字节**（符号表循环无边界检查） | STM32 profile 下 4 KB → 16 KB |
| 5 | 装载后一执行就 INVSTATE（CFSR=0x00020000） | `cmd_build` 调用入口前把 bit0 清掉（`entry & ~1u`），BLX 偶地址切 ARM 态 | 保留 Thumb 位：`fn = (int(*)(void))entry` |

另外修掉一个**语义错**（编译器本体）：`sizeof("字面量")` 被折叠成指针大小 4。C11 6.5.3.4
规定字符串字面量类型是 `char[n+1]`，所以 `sizeof("abc")==4`。原来
`sizeof("written by arkcc ...")-1` 求值成 **3**，`write()` 只发 3 字节。
`ast_str()` 先把节点类型设成 `char*`，因此判断 **必须排在通用 `e->type` 分支之前**
（排在后面就永远走不到，第一次改法就是这样失效的）。修后宿主编译输出 `MOV r0, #51`。

### 12.3 已收口：.rodata 的绝对地址在编译期就被写死

> **状态（0.8.0 预览版）**：走下面的**第 2 条路**做完了，开关是
> `--reloc-text`（默认关）。板上实测第二行已经正确打印
> `written by arkcc running on the STM32H743 itself`，见 §14。
> 原来写的"两条可选收敛路径"保留在这里，因为它记录了当时的判断依据。

修完 `sizeof` 后第二行长度的确变成 50，但内容仍是垃圾。反汇编定位：

```
24070474  movw r0, #0x400
24070478  movt r0, #0x800      ; -> 0x08000400，而不是 0x24070400
```

`.L_str_0` 在对象里被解析成 `g_flash_base(0x08000000) + 0x400`，而这条绝对地址
**不是重定位项**（hello.o 只有 2 条 reloc，都是 `BL write`），链接器无从修正；镜像真正
装在 `0x24070000`，于是读到的是固件自己 Flash 里 `0x08000400` 的内容。

RAM 侧同理：`static const char msg[]` 的地址被写成 `0x20000000`（`g_data_base` 默认值），
只是 `__arkcc_init_globals()` 也在向 `0x20000000` 写初值，两边正好自洽，所以在 DTCM 上
「碰巧对」。这也解释了为什么第一行正确、第二行错。

两条可选收敛路径（第 2 条已实现，第 1 条已否决）：

1. **两步都带上布局**：`build_object()` 也给 `-c` 传 `scatter_file`，让编译期的
   `g_flash_base / g_data_base` 与最终布局一致。改动最小，但要求编译期就知道布局
   （与 MDK 的「重定位」哲学不同）。
2. **让绝对引用成为重定位项**：后端为 `.L_str_N` 等 section 内绝对地址发 reloc，
   由链接器按 `LR` 加载地址修正。结构上更正确，但要动 ARKOBJ2 的 reloc 种类与
   链接器补丁逻辑。 ← **采用这一条**

第 1 条被否决的理由是它只对**第一个**目标文件成立：给 `-c` 传同一个 `--scatter`
以后，`hello.o` 的基址恰好等于 LR 基址，而 `crt.o` 是从 `hello.o` 之后开始拼的，
它内部所有偏移整体差一个 `hello.o` 的大小——看起来修好了，实际上是换了一种错法。
**判据**：修完之后必须能同时说清"第 N 个对象"的地址，见 §14.3 的第 3 项门禁。

---

## 13 阶段 4：外挂 SDRAM 调通，编译器工作缓冲搬进 SDRAM

板子：反客 FK743M5-XIH6（STM32H743XIH6 TFBGA240 + W9825G6 32 MB 16 位 SDRAM，
FMC SDRAM bank1 @ `0xC0000000`，HSE 25 MHz）。本固件仍跑 HSI 64 MHz，
所以 `fmc_ker_ck = HCLK = 64 MHz`、`SDCLK = HCLK/2 = 32 MHz`。

### 13.1 现象：SDRAM 一碰就 IMPRECISERR

第一版驱动（纯寄存器，`User/bsp_sdram.c`）`SDCMR` 的命令序列写完，
`FMC_SDSR` 恒为 0，`FMC_SDRTR` 写进去读回 0，第一次 `0xC0000006` 写入即

```
*** CPU FAULT ***   CFSR=0x00000400 (IMPRECISERR)  HFSR=0x40000000 (FORCED)
```

同一块板上把厂家例程烧进去却全过（32 MB 写 145 ms / 读 251 ms，8 位 NBL 也过）
⇒ 硬件没问题，是配置错。

### 13.2 定位手段：读"能工作"的那份固件的寄存器

不看文档、不猜，直接把厂家固件烧上去、跑到测试通过的位置停住读寄存器：

| 寄存器 | 厂家（能通过） | 第一版（失败） |
| --- | --- | --- |
| `FMC_SDCR1` | `0x000039D9` | `0x00003158` |
| `FMC_SDTR1` | `0x00126361` | `0x02237472` |
| `FMC_SDRTR` | `0x0000072C`（918<<1） | `0x00000000`（写不进去） |
| `RCC_D1CCIPR` | `0x00000000`（FMCSEL=00=HCLK） | 同 |
| `FMC_BCR1` | `0x800030DB`（FMCEN=1） | 复位值 `0x000030DB`（FMCEN=0） |

再用调试器逐级复现"什么时候 `SDRTR` 变成可写"：复位后不可写 → 开
`RCC_AHB3ENR.FMCEN` 仍不可写 → 置 `FMC_BCR1.FMCEN` 仍不可写。
而厂家状态下可写。差别只剩 `SDCR1`/`SDTR1` 的内容。

### 13.3 根因：`SDCR1.SDCLK = 00` 是"关时钟"，不是 HCLK/2

`stm32h7xx_ll_fmc.h` 的常量才是权威：

```
FMC_SDRAM_CLOCK_DISABLE  0x00000000   <-- 第一版用的就是这个
FMC_SDRAM_CLOCK_PERIOD_2 0x00000800   (= HCLK/2，厂家用的)
FMC_SDRAM_CLOCK_PERIOD_3 0x00000C00
```

SDRAM 时钟被关掉，命令发生器整块不干活：`SDCMR` 写了不算、`SDRTR` 收不下，
`0xC0000000` 照默认从设备返回 AXI error ⇒ 不精确总线错误。
顺带另外两个字段也是同一个错（按 `FMC_SDRAM_*` 常量核）：

| 字段 | 第一版 | 真值 | 后果 |
| --- | --- | --- | --- |
| `NC` | 00（= **8** 列） | 01（9 列） | 第 9 根列地址不参与译码，半行取不到 |
| `CAS` | 10（= **2**） | 11（3） | 延迟对不上 |
| `SDCLK` | 00（= **关**） | 10（HCLK/2） | 整块不工作 |

### 13.4 最终寄存器值（逐字段可核）

```
FMC_SDCR1 = 0x000039D9
  NC=01 NR=10 MWID=01 NB=1 CAS=11 WP=0 SDCLK=10 RBURST=1 RPIPE=01
FMC_SDTR1 = 0x00126361        // 字段是"周期数-1"（厂家 HAL 每项都减 1）
  TMRD=1 TXSR=6 TRAS=3 TRC=6 TWR=2 TRP=1 TRCD=0
FMC_SDRTR = 230 << 1 = 0x1CC  // 按真实 SDCLK 32 MHz 重算，不是照抄厂家的 918
```

刷新计数用 `(SDCLK_kHz × 64) / 8192 - 20`，32 MHz 得 230；厂家的 918 只对应
120 MHz，直接抄会算出 4.7 倍的刷新频率。

`SDTR1` 的字段**照抄工作板上的读数**而不是重新推导：在 32 MHz 下这些周期数
换算成 ns 只会更长（最短的 TRCD 1 周期 = 31 ns，W9825G6 要求 ≥18 ns），
所以一定合法；这样第一次点亮就不至于变成第二个实验。

### 13.5 实测（`sdram` 命令）

```
[sdram] SDCR1=0x000039D9 SDTR1=0x00126361 SDRTR=0x000001CC SDSR=0x00000000
[sdram] command ran: busy_seen=0, SDSR after LOAD_MODE=0x00000000
[sdram] SDCLK = 32000 kHz (HCLK/2), refresh count = 230
[sdram] BCR1 before=0x000030DB after=0x800030DB, D1CCIPR=0x00000000 AHB3ENR=0x00001000
[sdram] written in 1312 ms (24.39 MB/s)
[sdram] 16-bit verify OK in 7130 ms (4.48 MB/s)
[sdram] 8-bit probe OK (NBL0/NBL1 are wired correctly)
[sdram] SDRAM OK: 32 MB usable at 0xC0000000
```

`busy_seen=0` 是预期的：32 MHz 下一条 PALL 只有几个周期，CPU 读到 `SDSR` 时
`BUSY` 早就清了，所以这个探针证明不了"命令执行了"。真正证明执行的是**数据**：
32 MB 全片写回读一致 + 8 位字节道探针通过。

读比写慢 5 倍不是缺陷：这个窗口此时还是 ARMv7-M 默认的 **Device** 属性
（不缓存、不合并、不能非对齐），每次读都是一次独立 AXI 事务；§13.6 换成
Normal 之后仍是逐次读（D-Cache 没开），只是允许合并。

### 13.6 内存布局：`.ark_buf` 搬进 SDRAM

`Linker/STM32H743VITx_FLASH.sct`：

```
RW_AXI   0x24000000 0x00070000   { *(.ark_code)  *(.ark_heap) }   // 64 KB
ARK_TRAMP 0x2407F000 0x00000100  { *(.ark_tramp) }               // 固定地址
RW_SDRAM 0xC0000000 0x02000000   { *(.ark_buf) }                 // 404 KB
RW_SRAM  0x30000000 0x00048000   { .ANY (+RW +ZI) }
```

三处配套改动，缺一不可：

1. **`SystemInit()` 里初始化 SDRAM**（`bsp_sdram_init()` + `bsp_sdram_selftest()`
   + `bsp_sdram_mpu_config()`）。`__main` 在 `main()` 之前就要按 scatter
   搬/清零 `.ark_buf`，所以这件事只能发生在 `SystemInit()`。
   自检失败就停在这里（`for(;;)`），而不是让 scatter loader 吃一个不精确总线错误。
2. **MPU 区域**：`0xC0000000` 起 32 MB 设成 Normal, non-cacheable, full access
   （`RASR = 0x03080031`，region 0，`MPU_CTRL = 0x5`）。
   ARMv7-M 默认把这块当 Device，而 **Device 内存不允许非对齐访问**——
   编译器对自己的缓冲做字节/半字/字混合读写，一旦非对齐就是 UsageFault。
   这条不是性能优化，是正确性。
3. **`RW_AXI` 上限从 0x80000 收到 0x70000**：`0x24070000` 是板上编译产物装载
   的窗口，旧上限允许静态数据长到 `0x24080000`，正好压在它上面。

**开关**（两处必须一起翻）：

| 位置 | 值 | 说明 |
| --- | --- | --- |
| `system_stm32h7xx.c` | `#define ARK_SDRAM_BUFS 1` | 1=启动时初始化 SDRAM 并开 MPU；0=一句也不执行 |
| `ArkCC.uvprojx` `<ScatterFile>` | `STM32H743VITx_FLASH.sct` | 换成 `..._sram.sct` 即回到"全部缓冲在 AXI SRAM"的旧布局 |

`ARK_SDRAM_BUFS 1` + 旧的 `_sram.sct` 仍能启动（SDRAM 初始化后闲置，行为不变）；
反过来 0 + 新 sct 会在 scatter 阶段就 fault —— 所以两个必须成对翻。

**防假绿**：布局不是靠"我相信链接器"，启动横幅直接把它读出来：

```
=== Ark C Compiler on STM32H743 ===
Heap @ 24008000, Code @ 24000000
Bufs @ c0012000 (compiler work buffers in SDRAM)
Type 'help' for commands.
```

`Bufs @` 打印的是 `arkcc_buf_addr()`（`src/compiler.c` 里 `g_src` 的地址），
并按 `0xC0000000..0xC2000000` 判定落在哪个区；换回 `_sram.sct` 会自己打出
`in on-chip RAM`。

搬完之后 `demo` + `build` 仍然跑通（板上编译、链接、装载、执行、返回 0），
说明"编译器整个工作集放在外部 SDRAM 上"是可用的，不再是纸面结论。

### 13.7 当时的遗留项（已在 §14 收口）

`hello.c` 第二个 `write()` 的**字符串字面量**参数依旧是坏地址（§12.3）：
编译期按 `g_flash_base + offset` 把 `.rodata` 地址写死成 `0x08000400` 一类，
而镜像实际在 `0x24070000`。搬内存布局不影响它——它是**代码地址**没有重定位项，
不是数据地址。两条候选修法在 §12.3 里；**已按第二种做完**（后端为 section 内绝对地址发 reloc，
链接器按实际基址修正），开关 `--reloc-text`，机制与门禁见 §14。

---

## 14 阶段 5：段内绝对地址交给链接器修正（`--reloc-text`）

### 14.1 问题重述

后端为"取某个 label 的地址"发射 `MOVW rd,#lo16` + `MOVT rd,#hi16`，值是
`g_flash_base + offset`。其中 `g_flash_base` 是**编译期**假设的基址（默认
`0x08000000`，或 `--scatter` 给的 LR 基址）。这个值不是重定位项，链接器看不见它：

* 单对象、且对象基址正好等于 LR 基址 → 数字是对的；
* 多对象（第二个对象从第一个之后开始）→ 第二个对象整体偏一个对象的大小；
* 镜像被装到别处（板上 `0x24070000`）→ 全部偏，字符串字面量最明显。

### 14.2 机制：对象带基址，链接器自己算差值

| 环节 | 做什么 |
| --- | --- |
| 后端 | `LDR rd, =label` 解析到**本对象内**的 label 时，发射 MOVW/MOVT 的同时记一条 `type 12` 重定位（`.arktext`），偏移 = MOVW 指令位置 |
| 对象 | 尾部追加一个 `__arkcc_text_base` 符号，值 = 编译期基址（与 `__arkcc_ram_start/end` 同一模式，占的仍是"符号 offset 字段当绝对地址用"） |
| 链接器 | 装载时记下每个对象在合并缓冲区里的起点 `g_ld_code_base[i]` 与描述符；scatter 解析出镜像基址后，对每个对象算 `delta = (image_base + code_base) - text_base`，用 `arm_patch_movw_movt()` 加进那对 MOVW/MOVT |

`delta` **必须按对象算**：先算出一个全局差、再套给所有对象，对象 0 对、对象 1 就错
——这正是 §14.3 第 3 项门禁专门盯的形态。

判据放在链接器而不是在编译期对齐，是因为只有链接器知道对象最后落在哪；让编译期
去猜（第 1 条候选路）等于把"两边规则必须一致"变成一条没人检查的隐式约定。

### 14.3 门禁（`make test` 里的一条）

`tests/run_reloc_text_tests.py`，两个对象、镜像基址离编译基址 `0x1C070000`：

```
PASS  object carries __arkcc_text_base with --reloc-text
PASS  object carries no descriptor without --reloc-text
PASS  object #0 literal address corrected  [24070400]
PASS  object #1 literal address corrected  [24070BD4]
PASS  without the flag the old base is still baked in  [08000400]
PASS  image size unchanged by the pass  [4940 vs 4940]
PASS  object #1 really is linked after object #0  [+0xBD4 vs +0x400]
```

五项各自防一种假通过：

1. 没有描述符 → 链接器无从修正，必须能被看见；
2. 关闭时**不能**有描述符 → 默认产物逐字节不变；
3. 对象 0 与对象 1 **都要**正确 → 全局 delta 只能过前一项；
4. 关掉开关必须复现**旧错**（`0x08000400`）→ 证明测的是功能本身，不是巧合；
5. 镜像大小不变 → 这一步只改立即数，不挪布局；
6. 对象 1 确实排在对象 0 之后 → 否则第 3 项是在重复检查同一个东西。

### 14.4 默认关闭 = 逐字节不变（实测）

用 `git worktree` 把上一个提交编成基准 `arkcc`，同一组源、同参数（不开开关）：

```
IDENTICAL  hello.o  (4162 bytes)
IDENTICAL  crt.o    (2874 bytes)
IDENTICAL  app.bin  (4814 bytes)
```

开启与关闭的镜像大小也相同（`4940` vs `4940`），差别只在 `+0x474` / `+0xC9C`
那两个立即数：

| | 对象 0 字面量 | 对象 1 字面量 |
| --- | --- | --- |
| 关 | `0x08000400`（错） | `0x08000000`（错） |
| 开 | `0x24070400` ✓ | `0x24070BD4` ✓ |

### 14.5 板上实测

`cmd_build()` 显式打开 `g_config.enable_reloc_text = 1`（板上这个链接必然是
"多对象 + 位移"，而且开在这里不会影响 `cc -S` / 单对象这些老用法）：

```
[arkcc] wrote object 'hello.o' (3028 bytes code, 43 syms, 3 relocs)   <- 2 -> 3，多的是 type 12
[arkcc] wrote object 'crt.o'   (2810 bytes code, 43 syms, 2 relocs)
[link] vector table written into the 1024-byte hole the first object reserved (SP=0x2407F000, entry=0x2407102A)
[arkcc] linked 2 objects -> app.bin (5838 bytes, 45 syms, 5 relocs)   <- 4 -> 5
[arkcc] image loaded at 24070000, 5838 bytes
--- program output -------------------------------------------
hello, world
written by arkcc running on the STM32H743 itself
--------------------------------------------------------------
[arkcc] program returned 0
```

镜像大小与修之前一样（5838），只是指令里的立即数变了。

### 14.6 顺带修掉的一个真缺陷（`opts_reset`）

板上 `opts_reset()` 漏了 `vector_table`、`build_date`、`build_time`、`build_epoch`
四个字段。`vector_table` 决定链接器要不要把向量表写进第一个对象预留的 0x400 洞里：
它此前**从未被赋过值**，板上一直能跑是因为那块栈恰好非 0——加一个局部变量就可能
让它变成 0，链接器随即改走"镜像必须自带向量表"的分支，行为在没有任何代码改动的
情况下变了。现在 `vector_table = 1`（板上链接永远要写这张表），另外三个显式置 0。

同一类问题的第二次出现：本次 `--reloc-text` 的"对象描述符"一开始也算在
`p_text_base` 赋值之前，结果对象里没有描述符、链接器拒绝链接（拒绝是对的，
但错误来得太晚）。这类"顺序依赖 + 无报错"的组合只能靠门禁兜住。
