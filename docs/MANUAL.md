# Ark C Compiler 使用手册

> 版本：1.0
> 适用对象：嵌入式开发者、编译原理学习者、想在 STM32 上跑"自宿主 C 编译器"的玩家
> 作者：Ark C Compiler 项目组

---

## 目录

1. [项目简介](#1-项目简介)
2. [快速上手](#2-快速上手)
3. [命令行参考](#3-命令行参考)
4. [支持的 C 语言特性](#4-支持的-c-语言特性)
5. [多后端架构](#5-多后端架构)
6. [在 Windows 上做测试](#6-在-windows-上做测试)
7. [STM32H743 + Keil MDK 工程](#7-stm32h743--keil-mdk-工程)
8. [代码组织与移植指南](#8-代码组织与移植指南)
9. [扩展开发指南](#9-扩展开发指南)
10. [标准库子集](#10-标准库子集)
11. [常见问题 FAQ](#11-常见问题-faq)
12. [已知限制](#12-已知限制)
13. [附录 A：内部数据流](#附录-a内部数据流)
14. [附录 B：术语表](#附录-b术语表)

---

## 1 项目简介

**Ark C Compiler**（简称 `arkcc`）是一个用 C99 编写的微型 C 语言编译器，目标是：

- **嵌入式自宿主**：编译器本身可在 STM32H743 这样的 Cortex-M7 单片机上运行，读取外部 SPI Flash 中的 `.c` 文件并就地生成机器码、跳转执行。
- **多后端**：核心前端只输出与目标无关的栈式中间码（IR）；后端可在 `arm` / `x86_64` / `riscv32` / `c` 之间切换。
- **方便扩展**：每一层（lexer/parser/sema/irgen/codegen/asm/linker）独立成文件，新增关键字、AST 节点或目标平台都有清晰的扩展点。
- **方便在 Windows 上测试**：内置 `c` 后端会把 IR 翻译回可读 C 代码，立刻可以用主机 gcc 编译运行，无需仿真器或硬件。

### 1.1 整体流水线

```
   源代码 .c
      |
      v
+----------+    +--------+    +--------+    +--------+
| preproc  |--> | lexer  |--> | parser |--> |  sema  |
+----------+    +--------+    +--------+    +--------+
                                                |
                                                v
                                            +--------+
                                            | irgen  |
                                            +--------+
                                                |
                                                v
                          backend = arm | x86_64 | riscv32 | c
                                                |
                                                v
                           +---------------+--------------+
                           |    emit_asm   |  assemble    |  link
                           +---------------+--------------+
                                                |
                                                v
                                  .S（汇编）或 .bin（机器码）或 .gen.c
```

### 1.2 项目目录速览

```
ark c compiler/
├── include/                  公共头文件（前端 + 后端接口）
├── src/                      编译器核心（与目标无关的前端）
│   └── backend/              所有后端
│       ├── registry.c        后端注册表
│       ├── arm/              ARM Cortex-M Thumb-2 后端
│       ├── x86_64/           x86_64 GAS 后端
│       ├── riscv32/          RV32I GAS 后端
│       └── c/                Host 测试后端（IR -> C）
├── stdlib/                   编译器自带的最小标准库
│   ├── include/              头文件（stdint/string/stdio 等）
│   └── src/                  可选的实现源
├── port/
│   ├── host/                 PC 平台抽象实现（stdio）
│   └── stm32/                STM32 平台抽象实现（HAL UART + W25Q）
├── examples/                 测试样例（hello/arith/func/struct 等）
├── mdk/STM32H743_ArkCC/      Keil MDK 工程（STM32H743VIT6）
├── Makefile                  Host 构建脚本
├── README.md                 项目简介
└── MANUAL.md                 本手册
```

---

## 2 快速上手

### 2.1 环境准备（Windows）

1. 安装 **MSYS2** 或 **MinGW-w64**，确保 `gcc` 在 PATH 中：
   ```powershell
   gcc --version
   ```
2. 可选：**STM32 嵌入式部分**需要 **Keil MDK-ARM 5.36+**，可选 ST-Link 调试器和一块 STM32H743 板卡。

### 2.2 三分钟构建 + 测试

```powershell
cd "d:\工作\git_project\ark c compiler"

# 1. 编译 arkcc 本体
make
# 等价：gcc -Wall -Wextra -O2 -std=c99 -Iinclude -Istdlib/include `
#         src/*.c src/backend/*/*.c port/host/*.c -o arkcc.exe

# 2. 跑示例（输出 Thumb-2 汇编）
.\arkcc.exe examples\hello.c -target arm -S

# 3. 用 c 后端跑全测试（推荐）
powershell -ExecutionPolicy Bypass -File examples\run_tests.ps1
```

跑测试脚本时，每个示例会：
1. 用 `-target arm -S` 检查 ARM 后端没有崩溃；
2. 用 `-target c -S` 生成 `*.gen.c`；
3. 用宿主 gcc 编译并运行 `*.gen.exe`，校验退出码。

输出类似：
```
[arm] hello.c
[c]   hello.c   exit=42
[arm] arith.c
[c]   arith.c   exit=900
...
```

### 2.3 编译你自己的 .c

新建 `myprog.c`：
```c
int factorial(int n) {
    if (n <= 1) return 1;
    return n * factorial(n - 1);
}
int main(void) {
    return factorial(6);
}
```

编译并跑：
```powershell
.\arkcc.exe myprog.c -target c -S -o myprog.gen.c
gcc myprog.gen.c -o myprog.exe
.\myprog.exe; echo $LASTEXITCODE   # 应输出 720
```

---

## 3 命令行参考

```
arkcc <file.c> [options]
```

| 选项 | 说明 |
| --- | --- |
| `-o <file>` | 指定输出文件；不指定时默认为 `<input>.bin`（机器码）或 `<input>.gen.c`（c 后端 + `-S`） |
| `-S` | 只生成文本汇编/源码，不做汇编与链接 |
| `-target <name>` | 选择后端：`arm`（默认）、`x86_64`、`riscv32`、`c` |
| `-I <dir>` | 添加额外的 `#include` 搜索路径（可多次） |
| `-v` | 详细模式：打印每个阶段耗时与输出尺寸 |
| `--list-backends` | 列出所有可用后端 |
| `-h`, `--help` | 显示帮助 |

### 3.1 典型命令组合

| 目的 | 命令 |
| --- | --- |
| 看一眼词法/语法是否正确 | `arkcc x.c -target c -S -o /dev/null` |
| 调试 IR -> 汇编翻译 | `arkcc x.c -target arm -S` |
| 生成可在主机跑的可执行 | `arkcc x.c -target c -S -o out.c && gcc out.c -o out` |
| 烧录到 STM32 W25Q 用 | `arkcc x.c -target arm -o /app/main.bin`（再用上位机写入 Flash） |

---

## 4 支持的 C 语言特性

按照 ISO/IEC 9899:1999 (C99) 标准对照，给出本编译器的实际支持范围。

### 4.1 类型系统

| 类别 | 支持 | 备注 |
| --- | :---: | --- |
| `void` `char` `short` `int` `long` `long long` | ? | 全部按 32 位（host 后端按 host 实际宽度） |
| `signed` / `unsigned` 修饰符 | ? | sema 区分；运算暂用有符号语义 |
| `_Bool` / `<stdbool.h>` 的 `bool/true/false` | ? |  |
| `float` / `double` / `long double` | △ | lexer/parser 完整，sema 暂按 int |
| `_Complex` / `_Imaginary` | ? | 不支持 |
| 一维数组 / 多维数组 | ? | 维度允许常量表达式 |
| 指针、指针的指针 | ? |  |
| 函数指针 | ? | 语法完整 |
| `struct` / `union` | ? | 含字段偏移、`.` / `->` |
| `enum` | ? | 作为 int 常量集合 |
| `typedef` | ? | 含递归 typedef |
| 类型限定符 `const` `volatile` `restrict` | △ | 解析但忽略 |
| 存储类 `static` `extern` `auto` `register` | △ | 解析；`static/extern` 影响链接（同翻译单元内有效） |
| `inline` | △ | 解析但忽略 |
| 强制类型转换 `(type)expr` | ? |  |
| `sizeof(type)` / `sizeof expr` | ? | 编译期求值 |
| VLA 变长数组 | △ | 解析允许，仅当维度常量时分配；非常量退化为固定大小 |

### 4.2 字面量

| 形式 | 示例 | 支持 |
| --- | --- | :---: |
| 十进制整数 | `42` | ? |
| 八进制 | `0755` | ? |
| 十六进制 | `0xFF` | ? |
| 整数后缀 | `42u 42L 42ull` | ? |
| 字符 | `'a' '\n' '\xFF' '\0'` | ? |
| 字符串 | `"hello\n"` 含拼接 | ? |
| 浮点 | `1.5 1.5e-3 .5 2.0f` | △ lex/parse |
| 宽字符/宽串 | `L'a' L"..."` | ? |

### 4.3 运算符

| 类别 | 支持 |
| --- | :---: |
| 算术 `+ - * / %` | ? |
| 比较 `== != < > <= >=` | ? |
| 逻辑 `&& \|\| !`（短路） | ? |
| 位 `& \| ^ ~ << >>` | ? |
| 赋值 `=` 与全部复合赋值 `+= -= *= /= %= &= \|= ^= <<= >>=` | ? |
| 自增/减 `++ --`（前缀+后缀） | ? |
| 三目 `?:` | ? |
| 逗号 `,`（表达式语境） | ? |
| 取地址 `&` / 解引用 `*` | ? |
| 成员 `.` / `->` | ? |
| `sizeof` | ? |

### 4.4 语句

| 语句 | 支持 |
| --- | :---: |
| 表达式语句、声明语句 | ? |
| `if / else` | ? |
| `while / do-while / for` | ? |
| `switch / case / default` | ? |
| `break / continue / return` | ? |
| `goto` + 标签 | ? |
| 块内任意位置声明（C99 放宽） | ? |
| `for (int i = 0; ...; ...)` 内声明 | ? |

### 4.5 函数

| 特性 | 支持 |
| --- | :---: |
| 定义、声明、调用、递归 | ? |
| 多于 4 个参数 | ?（多余走栈） |
| 函数原型与参数个数检查 | ? |
| 变参 `...` | △ 声明可用；运行时依赖后端实现 |
| 函数指针调用 | ? |
| 内联 `inline` | △ 解析忽略 |
| K&R 旧式参数 | ? |

### 4.6 预处理器

| 指令 | 支持 |
| --- | :---: |
| 对象宏 `#define NAME body` | ? |
| 函数宏 `#define MAX(a,b) ((a)>(b)?(a):(b))` | ? |
| `#` 字符串化、`##` 串接 | ? |
| 续行 `\` | ? |
| `#if / #elif / #else / #endif` | ? |
| `#ifdef / #ifndef` | ? |
| `#undef / #error / #warning` | ? |
| `#pragma`（忽略） | ? |
| 嵌套 `#include`（≤8 层） | ? |
| 搜索路径 `-I` | ? |
| 预定义宏 `__FILE__` `__LINE__` `__STDC__` `__ARK_CC__` | ? |
| `__func__` `__DATE__` `__TIME__` | △ |
| 可变参数宏 `__VA_ARGS__` | ? |

### 4.7 初始化与链接

| 特性 | 支持 |
| --- | :---: |
| 全局变量、内部/外部链接 | ? |
| 局部变量带初始化器 | ? |
| 数组聚合初始化 `{1,2,3}` | △ 解析；本版仅持久化第一个 |
| 指定初始化 `.x=1` `[2]=5` | △ 仅解析 |
| 字符串初始化 `char s[]="hi"` | △ 仅解析 |

> "△" 表示当前版本"语法层接受、语义层简化"。详见 [12 已知限制](#12-已知限制)。

---

## 5 多后端架构

### 5.1 后端接口

文件：[include/backend.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/backend.h)

```c
typedef struct ArkBackend {
    const char *name;
    const char *triple;
    int pointer_size;
    int (*emit_asm)(IrProgram *m, char *out, int cap);
    int (*assemble)(const char *asm_text, unsigned char *out, int cap);
    int (*link)(unsigned char *code, int size, struct LinkContext *lc);
} ArkBackend;
```

- `emit_asm`：把 IR 翻译成文本汇编（或目标 C 代码），写入 `out`，返回字节数。
- `assemble`：把文本汇编编码为机器码。软件后端（c/x86_64/riscv32）可以直接把汇编文本透传，让宿主工具链继续处理。
- `link`：跨函数符号重定位（ARM 后端用于回填 `BL` 偏移）。

### 5.2 已实现的后端

| 后端 | 目录 | 入口符号 | 主要用途 |
| --- | --- | --- | --- |
| `arm` | [src/backend/arm/](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/backend/arm) | `ark_backend_arm()` | STM32 Cortex-M4/M7（Thumb-2） |
| `x86_64` | [src/backend/x86_64/](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/backend/x86_64) | `ark_backend_x86_64()` | 输出 GAS 汇编，宿主 `as` 可用 |
| `riscv32` | [src/backend/riscv32/](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/backend/riscv32) | `ark_backend_riscv32()` | 输出 RV32I 汇编（GAS） |
| `c` | [src/backend/c/](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/backend/c) | `ark_backend_c()` | IR -> 可读 C 源（host 测试主路径） |

注册表：[src/backend/registry.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/backend/registry.c)。新增后端时，在此处加一行注册即可。

### 5.3 选择后端

```powershell
.\arkcc.exe --list-backends
.\arkcc.exe foo.c -target x86_64 -S -o foo.s
.\arkcc.exe foo.c -target riscv32 -S -o foo.s
.\arkcc.exe foo.c -target c -S -o foo.gen.c
```

---

## 6 在 Windows 上做测试

### 6.1 推荐工作流：c 后端

`c` 后端把 IR 翻译为标准 C 源代码。这是**离硬件最远但反馈最快**的测试通道，强烈推荐用它做日常开发：

```powershell
.\arkcc.exe examples\struct_test.c -target c -S -o out.gen.c
gcc out.gen.c -o out.exe
.\out.exe
echo $LASTEXITCODE
```

`examples\run_tests.ps1` 已经把上述步骤自动化了：

```powershell
powershell -ExecutionPolicy Bypass -File examples\run_tests.ps1
```

### 6.2 验证 ARM 后端而无需硬件

要检查"在 STM32 上编译出来的汇编对不对"，可以用 QEMU 或 ARM 模拟器：

```powershell
# 用 ARM GNU 工具链汇编+链接
.\arkcc.exe foo.c -target arm -S -o foo.s
arm-none-eabi-as foo.s -mcpu=cortex-m7 -mthumb -o foo.o
arm-none-eabi-ld foo.o -Ttext=0x00 -o foo.elf
qemu-arm foo.elf
```

> 项目本身不依赖 QEMU；这只是验证后端正确性的常用方法。

### 6.3 测试 x86_64/RISC-V 后端

```powershell
.\arkcc.exe foo.c -target x86_64 -S -o foo.s
gcc foo.s -o foo.exe          # 注意 foo.s 必须符合 GAS 语法
```

```powershell
.\arkcc.exe foo.c -target riscv32 -S -o foo.s
riscv32-unknown-elf-gcc foo.s -o foo.elf
```

---

## 7 STM32H743 + Keil MDK 工程

工程位于 [mdk/STM32H743_ArkCC/](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/mdk/STM32H743_ArkCC)。

### 7.1 工程概况

| 项 | 值 |
| --- | --- |
| 芯片 | STM32H743VIT6（Cortex-M7, 2 MB Flash, 1 MB SRAM, 480 MHz） |
| 编译器 | ARM Compiler 6 (armclang) |
| Scatter | [Linker/STM32H743VITx_FLASH.sct](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/mdk/STM32H743_ArkCC/Linker/STM32H743VITx_FLASH.sct) |
| 启动文件 | [Startup/startup_stm32h743xx.s](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/mdk/STM32H743_ArkCC/Startup/startup_stm32h743xx.s) |
| 用户应用 | [User/main.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/mdk/STM32H743_ArkCC/User/main.c) |
| Flash 段 | `0x08000000 0x00200000` |
| DTCM 段 | `0x20000000 0x00020000` |
| AXI SRAM | `0x24000000 0x00080000`，放 `.ark_heap` + `.ark_code` |
| 仅集成 ARM 后端 | 为节省 Flash |

工程文件清单（按 Keil 的"Source Group"组织）：

- **Application/User**：`main.c` `stm32h7xx_it.c` `stm32h7xx_hal_msp.c` `system_stm32h7xx.c` `bsp_w25q.c`
- **Application/Startup**：`startup_stm32h743xx.s`
- **ArkCC/Core**：`..\..\src\compiler.c` `lexer.c` `parser.c` `sema.c` `ir.c` `irgen.c` `ast.c` `type.c` `symtab.c` `memory.c` `preproc.c` `codegen_common.c`
- **ArkCC/Backend**：`..\..\src\backend\registry.c` `..\..\src\backend\arm\backend_arm.c`
- **ArkCC/Port**：`..\..\port\stm32\platform_stm32.c` `..\..\port\stm32\flash_fs_stm32.c`
- **Drivers/HAL**：空，用户填入官方 HAL `.c`

> 因为 src 是通过相对路径引用的，PC 端改动 src 后只需在 Keil 里 Rebuild。

### 7.2 五步起跑

1. **填入官方 CMSIS / HAL**
   从 STM32CubeH7 包拷贝官方 `Drivers/CMSIS/**` 与 `Drivers/STM32H7xx_HAL_Driver/**` 覆盖工程占位文件，然后在 Keil 中把要用的 `stm32h7xx_hal_*.c` 加进 `Drivers/HAL` 组。
2. **补全初始化代码**
   用 STM32CubeMX 生成或手写以下函数（位于 `User/`）：
   - `SystemClock_Config`（480 MHz PLL）
   - `MX_GPIO_Init`
   - `MX_USART1_UART_Init`（115200 8N1，PA9/PA10）
   - `MX_SPI1_Init`（SCK PA5, MISO PA6, MOSI PA7, CS PA4）
   - 在 `stm32h7xx_hal_msp.c` 中补 MSP 钩子。
3. **准备 W25Q 上的源文件**
   见 [7.3 烧录文件到 W25Q](#73-烧录文件到-w25q)。
4. **编译并烧录**
   Keil 打开 `mdk/STM32H743_ArkCC/ArkCC.uvprojx`，Build → Download。
5. **串口看输出**
   115200 接 PA9/PA10，应看到：
   ```
   === Ark C Compiler on STM32H743 ===
   Compiling /app/main.c from W25Q...
   Exit code: <int>
   ```

### 7.3 烧录文件到 W25Q

W25Q128 上需要一张极简文件索引表 + 文件数据。

```text
0x000000   FileEntry[32]   每项 32 B = char name[24] + uint32 offset + uint32 size
0x010000   /app/main.c     由用户源代码烧录
0x050000   /app/lib.h      ...
```

`FileEntry` 结构见 [port/stm32/flash_fs_stm32.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/port/stm32/flash_fs_stm32.c)。

最简单的上位机脚本（Python，可自行扩展）：

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
```

再通过 ST-Link/串口写入 W25Q（注意 4 KB 扇区擦除）。

### 7.4 内存与缓冲

- `.ark_heap`：64 KB Bump 内存池，存 AST / IR / 符号表
- `.ark_code`：32 KB 代码缓冲区，存生成的 Thumb-2 机器码
- 跳转执行前请 `SCB_CleanDCache_by_Addr` + `SCB_InvalidateICache`（在 [User/main.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/mdk/STM32H743_ArkCC/User/main.c) 中有调用模板）。

### 7.5 调试器与串口

- 调试器：ST-Link（Keil 选项 `Debug → ST-Link Debugger`）
- 串口：USART1, 115200, 8N1，PA9-TX / PA10-RX
- 推荐工具：MobaXterm、Tabby、串口调试助手

---

## 8 代码组织与移植指南

### 8.1 文件清单

| 路径 | 角色 |
| --- | --- |
| [include/common.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/common.h) | TokenKind / AstKind / IrOp 总枚举 |
| [include/platform.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/platform.h) | `ark_log` / `ark_logf` / `ark_abort` |
| [include/flash_fs.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/flash_fs.h) | `fs_read_file(path, buf, cap)` |
| [include/memory.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/memory.h) | Bump Allocator |
| [include/lexer.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/lexer.h) | Lexer |
| [include/ast.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/ast.h) | AST 节点 |
| [include/type.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/type.h) | 类型系统 |
| [include/symtab.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/symtab.h) | 符号表 |
| [include/parser.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/parser.h) | Parser |
| [include/sema.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/sema.h) | 语义分析 |
| [include/ir.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/ir.h) | IR 数据结构 |
| [include/irgen.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/irgen.h) | AST -> IR |
| [include/backend.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/backend.h) | 后端接口 |
| [include/preproc.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/preproc.h) | 预处理器 |
| [include/compiler.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/compiler.h) | 顶层入口 `ark_compile` / `ark_compile_and_run` |
| [src/main.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/main.c) | PC 端 CLI |
| [src/compiler.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/compiler.c) | 流水线编排 |
| [src/backend/registry.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/backend/registry.c) | 后端注册表 |

### 8.2 平台抽象层

仅两个接口需要为每个目标平台实现：

```c
/* platform.h */
void ark_log(const char *s);
void ark_logf(const char *fmt, ...);
void ark_abort(const char *msg);

/* flash_fs.h */
int fs_read_file(const char *path, char *buf, int cap);
```

PC 端在 [port/host/platform_host.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/port/host/platform_host.c) / [port/host/flash_fs_host.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/port/host/flash_fs_host.c)；STM32 端在 [port/stm32/](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/port/stm32)。

### 8.3 移植到其它平台

要把编译器移植到 Linux/ESP32/RISC-V 板子，只要：

1. 复制 [port/host/](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/port/host) 为 `port/<myplat>/`
2. 改 `platform_<myplat>.c` 中的输出到自己的 UART/syscall
3. 改 `flash_fs_<myplat>.c` 中的文件读取到本地 FS、SD 卡或网络
4. 把 `port/<myplat>/*.c` 加入构建脚本

不需要碰 `src/` 任何文件。

---

## 9 扩展开发指南

### 9.1 新增关键字 / Token

文件 [include/common.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/common.h):
1. 在 `TokenKind` 枚举里加 `TOK_XXX`。
2. 在 [src/lexer.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/lexer.c) 的 `check_keyword()` 里把字符串和 `TOK_XXX` 关联。
3. 必要时在 [src/parser.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/parser.c) 接住这个 token。

### 9.2 新增 AST 节点

1. [include/common.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/common.h) 加 `AST_XXX`。
2. [include/ast.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/ast.h) 在 `AstNode.u` 联合里加字段。
3. [src/ast.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/ast.c) 实现 `ast_xxx_new(...)` 构造函数。
4. [src/parser.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/parser.c) 在产生式里调用构造函数。
5. [src/sema.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/sema.c) 加类型检查。
6. [src/irgen.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/irgen.c) 翻译为 IR。

### 9.3 新增 IR 指令

1. [include/common.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/common.h) 加 `IR_XXX`。
2. 修改各后端 `emit_asm` 的 switch case。

### 9.4 新增后端（例：mips）

5 步模板：

1. `mkdir src/backend/mips`
2. 新建 `src/backend/mips/backend_mips.c`：
   ```c
   #include "backend.h"
   static int mips_emit_asm(IrProgram *m, char *out, int cap) { /* ... */ }
   static int mips_assemble(const char *s, unsigned char *o, int c) { /* ... */ }
   static int mips_link(unsigned char *c, int s, struct LinkContext *l) { return 0; }
   static const ArkBackend g_mips_backend = {
       "mips", "mips32-elf", 4, mips_emit_asm, mips_assemble, mips_link
   };
   const ArkBackend *ark_backend_mips(void) { return &g_mips_backend; }
   ```
3. 在 [include/backend.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/backend.h) 声明 `ark_backend_mips()`。
4. 在 [src/backend/registry.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/backend/registry.c) 注册。
5. `make` 自动包含（Makefile 用通配符）。

完成后：`arkcc foo.c -target mips -S`。

---

## 10 标准库子集

目录：[stdlib/include/](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/stdlib/include)

| 头文件 | 提供 |
| --- | --- |
| `stdint.h` | `int8_t..int64_t / uint8_t..uint64_t / intptr_t / uintptr_t` |
| `stdbool.h` | `bool true false` |
| `stddef.h` | `size_t NULL ptrdiff_t offsetof` |
| `stdarg.h` | `va_list va_start va_arg va_end` |
| `string.h` | `strlen strcmp strcpy strncpy memset memcpy memmove` |
| `stdio.h` | `printf puts putchar` |
| `stdlib.h` | `abort exit malloc free`（声明） |

> 在 `c` 后端下，这些函数直接路由到宿主 libc；在 `arm` 后端下，需要在 STM32 用户代码中提供实现，或者链接到 newlib-nano。

---

## 11 常见问题 FAQ

**Q1：为什么 `-target c` 编译出来的 `.gen.c` 不是漂亮的人类代码？**
A：c 后端是从 IR 翻译，不是从 AST 翻译。它的目标是"语义等价"，不是"风格优美"。它非常适合做回归测试。

**Q2：在 Windows 上没有 gcc，能跑 arkcc 吗？**
A：编译 arkcc 本体需要 gcc / MinGW / MSVC。如果用 MSVC，需要把 Makefile 改成 `cl.exe`。VS Code + clangd 也是常见选择。

**Q3：能编译 Keil/MDK 写的 STM32 工程吗？**
A：能编译 C99 子集（参见 §4），但 HAL/CMSIS 大量使用 `__attribute__`、内联汇编、宏游戏，arkcc 不支持。建议先把 HAL/CMSIS 用官方编译器编好，再用 arkcc 编译应用层代码。

**Q4：如何让被编译的程序在 STM32 上调用 HAL？**
A：通过外部声明 + 链接重定位。被编译代码声明 `extern void HAL_Delay(uint32_t)`，运行时由 ARM 后端的 linker 把 `BL HAL_Delay` 的目标地址回填为 HAL 函数的实际地址（需要你提供地址表）。简化做法：把这些函数地址硬编码成一张数组，arkcc 调用时通过函数指针跳转。

**Q5：ARM 后端会用 FPU 吗？**
A：当前不会。浮点字面量已能被 lex/parse 接受，但 sema/irgen 暂按整数处理。手册第 18 章给出了软浮点桩的接入方案。

**Q6：编译大文件时报"out of memory"怎么办？**
A：Bump Allocator 默认 256 KB。把 [include/memory.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/memory.h) 中的 `ARK_POOL_SIZE` 调大，或在 STM32 端把 `.ark_heap` 段扩到 128 KB+（注意 H743 AXI SRAM 共 512 KB）。

**Q7：能像 GCC 一样跨编译单元链接吗？**
A：当前是"单翻译单元"模型，多个 `.c` 之间靠 `#include` 合并。完整多文件链接需要扩展 ARM 后端的 `link` 钩子来处理 `.o` 文件，是 Roadmap。

---

## 12 已知限制

按"完全不支持 / 仅语法层 / 部分支持"三档列出，便于踩雷规避。

### 完全不支持

- `_Complex / _Imaginary`
- 宽字符 / 宽串（`L'a' L"..."`）
- 三连字符 / 二连字符
- VLA 在运行时真正变长（仅当维度是常量时才正常）
- K&R 旧式函数定义
- 跨翻译单元链接（多 `.o` 链接）
- 函数按值传/返结构体（用指针）
- 复合字面量 `(int[]){1,2,3}` 的求值
- 浮点运算（仅 lex/parse）
- 内联汇编 `asm("...")`
- C11 之后的特性（`_Generic / _Atomic / _Static_assert / _Alignas` 等）

### 仅语法层（解析但忽略 / 警告）

- `const / volatile / restrict / inline`
- `register / auto`
- 数组聚合初始化（仅取第一个初值或忽略）
- 指定初始化 `.x =` / `[i] =`
- 字符串初始化 `char s[]="hi"`

### 部分支持

- 浮点字面量：词法识别但语义按 int
- 函数指针：调用语法可用，作为参数传递可能受限
- 变参函数：声明可用，运行时依赖后端
- 全局变量：单文件内可用，跨文件 `extern` 需手工保证

---

## 附录 A：内部数据流

```
源代码 .c
   |
   v
+--------+      含 #include 展开、#define 替换、条件编译
| preproc|
+--------+
   |
   v
+--------+      字符 -> Token，行号跟踪
| lexer  |
+--------+
   |
   v
+--------+      递归下降，建 AST，全部节点从 Bump 池分配
| parser |
+--------+
   |
   v
+--------+      符号表、类型推导、重定义/未定义检测
|  sema  |
+--------+
   |
   v
+--------+      AST -> 栈式四元式 IR（与目标无关）
| irgen  |
+--------+
   |
   v
+-----------+
| backend.* |--- emit_asm  -> 文本汇编 / .gen.c
|           |--- assemble  -> 16/32 位机器码（仅 arm 完整实现）
|           |--- link      -> BL 重定位（仅 arm）
+-----------+
   |
   v
.bin / .S / .gen.c / 跳转执行
```

---

## 附录 B：术语表

| 术语 | 含义 |
| --- | --- |
| AST | Abstract Syntax Tree，抽象语法树 |
| IR | Intermediate Representation，中间表示 |
| Bump Allocator | 一次性向上累加分配，整体释放，无碎片 |
| Thumb-2 | ARM 32 位混合长度指令集，Cortex-M3/M4/M7 主用 |
| AXI SRAM | STM32H7 上挂在 AXI 总线的 512 KB SRAM，地址 `0x24000000` 起 |
| Scatter file | ARM Compiler 的链接脚本（`.sct`），定义内存映射 |
| MSP | MCU Support Package，STM32 HAL 的硬件初始化钩子 |
| FileEntry | 本工程自定义的 Flash 极简文件索引项（32 字节） |

---

如对手册或代码有疑问，欢迎对照源码逐文件阅读。设计上每个文件不超过 1000 行，所有阶段彼此独立，便于"挑一个模块单独看"。
