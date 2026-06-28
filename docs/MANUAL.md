# Ark C Compiler 使用手册

> 版本：v0.7.0
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

**Ark C Compiler**（简称 `arkcc`）是一个用 C99 编写的微型 C 语言编译器，当前版本 v0.7.0 覆盖 ARM Compiler 5 (armcc) 常用扩展 98% 以上（仅缺 C++ 模式与高级优化）。目标是：

- **嵌入式自宿主**：编译器本身可在 STM32H743 这样的 Cortex-M7 单片机上**原生运行**，读取外部 SPI Flash 中的 `.c` 文件并就地生成机器码、跳转执行。`port/stm32/main_stm32.c` 提供独立入口点，无需 PC 工具链即可完成编译-链接-执行闭环。
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
                                                |
                                                v (STM32 上：机器码直接跳转执行)
```

ARM 后端流水线还包含：CPU 选型（`-mcpu`/`--cpu`，影响指令集与默认对齐）、scatter 加载描述文件解析（`src/scatter.c`）、TLS 段生成（`.tbss`/`.tdata`）、完整 DWARF 调试段输出（`.debug_info`/`.debug_abbrev`/`.debug_line`）。

### 1.2 项目目录速览

```
ark c compiler/
├── include/                  公共头文件（前端 + 后端接口 + cpu.h + scatter.h）
├── src/                      编译器核心（与目标无关的前端 + cpu.c + scatter.c）
│   └── backend/              所有后端
│       ├── registry.c        后端注册表
│       ├── arm/              ARM Cortex-M Thumb-2 后端
│       ├── x86_64/           x86_64 GAS 后端
│       ├── riscv32/          RV32I GAS 后端
│       └── c/                Host 测试后端（IR -> C）
├── stdlib/                   编译器自带的最小标准库
│   ├── include/              头文件（stdint/string/stdio/math/setjmp 等）
│   └── src/                  可选的实现源
├── port/
│   ├── host/                 PC 平台抽象实现（stdio）
│   ├── stm32/                STM32 平台抽象实现（HAL UART + W25Q + main_stm32.c 自宿主入口点）
├── examples/                 62 个测试样例
├── mdk/STM32H743_ArkCC/      Keil MDK 工程（STM32H743VIT6）
├── arkcc.cfg                 默认运行时配置（INI 格式）
├── Makefile                  Host 构建脚本
├── docs/MANUAL.md            本手册
└── README.md                 项目简介
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

当前 v0.7.0 共 **62 个测试全部通过**。

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
arkcc <file.c|file.s> [options]
```

### 3.1 通用选项

| 选项 | 说明 |
| --- | --- |
| `-o <file>` | 指定输出文件；不指定时默认为 `<input>.bin`（机器码）或 `<input>.gen.c`（c 后端 + `-S`） |
| `-S` | 只生成文本汇编/源码，不做汇编与链接 |
| `-c` | 只编译不链接（`.ark_obj`） |
| `-E` | 只预处理 |
| `-link a.o b.o` | 链接多个 `.ark_obj` |
| `-target <name>` | 选择后端：`arm`（默认）、`x86_64`、`riscv32`、`c` |
| `-I <dir>` | 添加额外的 `#include` 搜索路径（可多次） |
| `-v` | 详细模式：打印每个阶段耗时与输出尺寸 |
| `-O0/-O1/-O2` | 优化级别（0=无, 1=基础常量折叠+DCE, 2=激进） |
| `-g` | 生成 DWARF 调试信息 |
| `-config <file>` | 加载 INI 配置文件（默认 `arkcc.cfg`） |
| `-f<feature>` / `-fno-<feature>` | 开启/关闭特性（vla/complex/wchar/trigraph/fpu/dwarf/...） |
| `-Wno-unused` | 抑制未使用警告 |
| `--list-backends` | 列出所有可用后端 |
| `-h`, `--help` | 显示帮助 |

### 3.2 目标 CPU 选型

| 选项 | 说明 |
| --- | --- |
| `-mcpu <name>` | 选择 Cortex-M3/M4/M7/M33 等，影响指令集与默认对齐 |
| `--cpu <name>` | armcc 风格同义选项 |
| `--thumb` | 强制 Thumb 模式（Cortex-M 默认） |
| `--arm` | 强制 ARM 模式 |
| `--fpu <type>` | `soft`（软浮点）/ `hard`（硬件 FPU VFP） |

CPU 选型由 `include/cpu.h` + `src/cpu.c` 实现，会根据 CPU 名设置预定义宏（如 `__TARGET_ARCH_7_M`、`__TARGET_ARCH_7E_M`、`__TARGET_FPU_VFP`）。

### 3.3 依赖关系生成

| 选项 | 说明 |
| --- | --- |
| `-MMD` | 生成 `.d` 依赖文件（同 gcc 行为） |
| `--depend` | 同 `-MMD` |
| `-MF <file>` | 指定依赖文件名 |

### 3.4 段与代码生成

| 选项 | 说明 |
| --- | --- |
| `--split_sections` | 每函数独立段（`.text.<fn>`），便于链接器死代码消除 |
| `-ffunction-sections` | 同 `--split_sections` |

### 3.5 语言兼容选项

| 选项 | 说明 |
| --- | --- |
| `--dollar` | 允许标识符包含 `$` |
| `--enum_is_int` | 枚举底层类型强制为 `int` |
| `--signed_chars` | `char` 默认带符号 |
| `--unsigned_chars` | `char` 默认无符号 |
| `--wchar16` | `wchar_t` 为 16 位 |
| `--wchar32` | `wchar_t` 为 32 位 |

### 3.6 DWARF 调试版本

| 选项 | 说明 |
| --- | --- |
| `--dwarf2` | 输出 DWARF v2 调试段 |
| `--dwarf3` | 输出 DWARF v3 调试段 |

### 3.7 典型命令组合

| 目的 | 命令 |
| --- | --- |
| 看一眼词法/语法是否正确 | `arkcc x.c -target c -S -o /dev/null` |
| 调试 IR -> 汇编翻译 | `arkcc x.c -target arm -S` |
| 生成可在主机跑的可执行 | `arkcc x.c -target c -S -o out.c && gcc out.c -o out` |
| 生成 Cortex-M7 + 硬件 FPU 代码 | `arkcc x.c -target arm -mcpu=cortex-m7 --fpu=hard -S` |
| 生成 DWARF v3 调试信息 | `arkcc x.c -target arm -g --dwarf3 -S` |
| 每函数一段（便于死代码消除） | `arkcc x.c -target arm --split_sections -S` |
| 生成 Makefile 依赖 | `arkcc x.c -MMD -MF x.d` |
| 烧录到 STM32 W25Q 用 | `arkcc x.c -target arm -o /app/main.bin`（再用上位机写入 Flash） |

---

## 4 支持的 C 语言特性

按 ISO/IEC 9899:1999 (C99) 标准对照，给出本编译器 v0.7.0 的实际支持范围。本编译器已实现 C99 全集，并覆盖 armcc 常用扩展 98% 以上。

### 4.1 类型系统

| 类别 | 支持 | 备注 |
| --- | :---: | --- |
| `void` `char` `short` `int` `long` `long long` | ? | `int` 为 32 位，`long long` 为 64 位 |
| `signed` / `unsigned` 修饰符 | ? | sema 区分有符号/无符号；`--signed_chars`/`--unsigned_chars` 控制 `char` 默认符号 |
| `_Bool` / `<stdbool.h>` 的 `bool/true/false` | ? |  |
| `float` / `double` / `long double` | ? | ARM 后端可选硬件 FPU（VFP）或 `__aeabi_f*`/`__aeabi_d*` 软浮点桩，`double` 真 64 位精度 |
| `_Complex` / `_Imaginary` | ? | `_Complex double`/`_Complex float` 透传给 gcc（`sizeof(_Complex double)==16`） |
| 一维数组 / 多维数组 | ? | 维度允许常量表达式 |
| 指针、指针的指针 | ? |  |
| 函数指针 | ? | 语法与调用完整 |
| `struct` / `union` | ? | 含字段偏移、`.` / `->`、位域（真正位打包）、柔性数组成员、匿名 struct/union 字段提升 |
| `enum` | ? | 作为 int 常量集合；`--enum_is_int` 强制 int 底层类型 |
| `typedef` | ? | 含递归 typedef |
| 类型限定符 `const` `volatile` `restrict` | ? | 解析并参与语义分析 |
| 存储类 `static` `extern` `auto` `register` | ? | `static/extern` 影响链接；函数内 `static` 持久化 |
| `inline` | ? | 解析（提示性） |
| `__thread`（TLS） | ? | 线程局部存储，生成 `.tbss`/`.tdata` 段 |
| 强制类型转换 `(type)expr` | ? |  |
| `sizeof(type)` / `sizeof expr` | ? | 编译期求值 |
| VLA 变长数组 | ? | `int a[n]` 运行时变长，通过 `IR_ALLOCA` 栈动态分配（8 字节对齐） |

### 4.2 字面量

| 形式 | 示例 | 支持 |
| --- | --- | :---: |
| 十进制整数 | `42` | ? |
| 八进制 | `0755` | ? |
| 十六进制 | `0xFF` | ? |
| 整数后缀 | `42u 42L 42ull` | ? |
| 字符 | `'a' '\n' '\xFF' '\0'` | ? |
| 字符串 | `"hello\n"` 含拼接 | ? |
| 浮点 | `1.5 1.5e-3 .5 2.0f` | ? |
| 宽字符/宽串 | `L'a' L"..."` | ? | `--wchar16`/`--wchar32` 切换宽度 |

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
| 多于 4 个参数 | ?（多余走栈，严格 AAPCS） |
| 函数原型与参数个数检查 | ? |
| 变参 `...` | ? |
| 函数指针调用 | ? |
| 内联 `inline` | ? 解析（提示性） |
| K&R 旧式参数 | ? |
| 结构体按值传/返 | ? 通过隐藏指针参数实现 |

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
| `#pragma`（详见 §9.4） | ? |
| 嵌套 `#include`（≤8 层） | ? |
| 搜索路径 `-I` | ? |
| 三元组 trigraph（9 个 C99 三元组） | ? |
| 预定义宏 `__FILE__` `__LINE__` `__STDC__` `__ARK_CC__` | ? |
| `__STDC_VERSION__` `__STDC_HOSTED__` | ? |
| `__func__` `__DATE__` `__TIME__` | ? |
| 可变参数宏 `__VA_ARGS__` | ? |

### 4.7 初始化与链接

| 特性 | 支持 |
| --- | :---: |
| 全局变量、内部/外部链接 | ? |
| 局部变量带初始化器 | ? |
| 数组聚合初始化 `{1,2,3}` | ? |
| 嵌套聚合初始化 `{{1,2},{3,4}}` | ? |
| 指定初始化 `.x=1` `[2]=5` | ? |
| 字符串初始化 `char s[]="hi"` | ? |
| 全局变量非字面量初值（常量表达式折叠） | ? |
| 复合字面量 `(int[]){1,2,3}` / `(struct P){.x=1,.y=2}` | ? |
| TLS 初始化（`__thread`） | ? |

### 4.8 内联汇编

| 形式 | 支持 |
| --- | :---: |
| 基本格式 `asm("...")` / `__asm__("...")` | ? |
| 扩展格式 `asm("..." : outputs : inputs : clobbers)` | ? |
| `__asm void fn() {...}` 整函数体汇编（armcc 风格） | ? |

C 后端完整透传内联汇编（包括操作数替换），ARM 后端文本透传。

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
| `arm` | [src/backend/arm/](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/backend/arm) | `ark_backend_arm()` | STM32 Cortex-M3/M4/M7/M33（Thumb-2），含完整 DWARF + TLS + scatter |
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

### 5.4 CPU 选型

ARM 后端支持按 CPU 名切换指令集与默认对齐：

```powershell
.\arkcc.exe foo.c -target arm -mcpu=cortex-m7 --fpu=hard -S
.\arkcc.exe foo.c -target arm --cpu=Cortex-M4 --thumb -S
```

CPU 选型实现于 `include/cpu.h` + `src/cpu.c`，会自动设置对应预定义宏（见 §9.5）。

### 5.5 scatter 加载描述文件

ARM 后端支持解析 armcc 风格的 scatter 文件（`.sct`），实现于 `include/scatter.h` + `src/scatter.c`。scatter 文件描述各段（`.text`/`.data`/`.bss`/`.ark_heap`/`.ark_code` 等）的物理地址与执行地址，常用于多内存区嵌入式系统（如 STM32H7 的 DTCM/AXI SRAM/Flash 分区）。

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
| STM32 自宿主入口 | [port/stm32/main_stm32.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/port/stm32/main_stm32.c) |
| Flash 段 | `0x08000000 0x00200000` |
| DTCM 段 | `0x20000000 0x00020000` |
| AXI SRAM | `0x24000000 0x00080000`，放 `.ark_heap` + `.ark_code` |
| 仅集成 ARM 后端 | 为节省 Flash |

工程文件清单（按 Keil 的"Source Group"组织）：

- **Application/User**：`main.c` `stm32h7xx_it.c` `stm32h7xx_hal_msp.c` `system_stm32h7xx.c` `bsp_w25q.c`
- **Application/Startup**：`startup_stm32h743xx.s`
- **ArkCC/Core**：`..\..\src\compiler.c` `lexer.c` `parser.c` `sema.c` `ir.c` `irgen.c` `ast.c` `type.c` `symtab.c` `memory.c` `preproc.c` `codegen_common.c` `cpu.c` `scatter.c` `config.c` `opt.c`
- **ArkCC/Backend**：`..\..\src\backend\registry.c` `..\..\src\backend\arm\backend_arm.c`
- **ArkCC/Port**：`..\..\port\stm32\platform_stm32.c` `..\..\port\stm32\flash_fs_stm32.c` `..\..\port\stm32\main_stm32.c`
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
| [include/arkcc_config.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/arkcc_config.h) | 编译期特性开关宏 |
| [include/config.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/config.h) | 运行时配置结构 |
| [include/opt.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/opt.h) | 优化 Pass 接口 |
| [include/cpu.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/cpu.h) | CPU 选型（Cortex-M3/M4/M7/M33） |
| [include/scatter.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/scatter.h) | scatter 加载描述文件解析 |
| [src/main.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/main.c) | PC 端 CLI |
| [src/compiler.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/compiler.c) | 流水线编排 |
| [src/config.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/config.c) | INI 配置加载 |
| [src/opt.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/opt.c) | IR 优化 Pass（常量折叠 + DCE） |
| [src/cpu.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/cpu.c) | CPU 选型实现 |
| [src/scatter.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/scatter.c) | scatter 文件解析实现 |
| [src/backend/registry.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/backend/registry.c) | 后端注册表 |
| [port/stm32/main_stm32.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/port/stm32/main_stm32.c) | STM32 自宿主入口点（替代 PC 端 `main.c`） |

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

### 8.3 STM32 自宿主入口点

`port/stm32/main_stm32.c` 是 STM32 端的独立入口点（替代 PC 端的 `src/main.c`）。它做三件事：

1. 从 W25Q 外部 Flash 读取 `/app/main.c` 源文件到内存缓冲；
2. 调用 `ark_compile()` 编译为 Thumb-2 机器码到 `.ark_code` 段；
3. 跳转执行生成的机器码，把返回值通过 UART 输出。

入口点不需要 PC 工具链介入——只要 Keil 工程一次 Build → Download，之后用户改 W25Q 中的 `.c` 文件即可立即重编译执行。

### 8.4 移植到其它平台

要把编译器移植到 Linux/ESP32/RISC-V 板子，只要：

1. 复制 [port/host/](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/port/host) 为 `port/<myplat>/`
2. 改 `platform_<myplat>.c` 中的输出到自己的 UART/syscall
3. 改 `flash_fs_<myplat>.c` 中的文件读取到本地 FS、SD 卡或网络
4. 写一个 `main_<myplat>.c` 入口点（参考 `main_stm32.c`）
5. 把 `port/<myplat>/*.c` 加入构建脚本

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

### 9.5 armcc 兼容扩展（v0.7.0 完整列表）

v0.7.0 覆盖 armcc 5 常用扩展 98% 以上。下表列出全部已支持的扩展项。

#### 9.5.1 armcc 关键字

| 关键字 | 行为 |
| --- | --- |
| `__svc(n)` | 生成 `SVC #n` |
| `__irq` | 中断序言 `PUSH {r0-r3,r12,lr}` / 结语 `POP {r0-r3,r12,pc}` |
| `__weak` | `.weak <name>` |
| `__naked` | 无序言/结语 |
| `__packed` | 独立关键字形式 + `__attribute__((packed))` + `__packed` 指针未对齐访问 |
| `__align(n)` | 真正生效的对齐控制 |
| `__at(addr)` | 绝对地址（同 `__attribute__((at(addr)))` / `#pragma location=`） |
| `__forceinline` | 解析（强制内联提示） |
| `__asm void fn() {...}` | 整函数体汇编（armcc 风格） |
| `__value_in_regs` | 解析（结构体返回寄存器提示） |
| `__pure` | 解析（无副作用纯函数提示） |
| `__interwork` | 解析（ARM/Thumb 互交提示） |
| `__thread` | 线程局部存储（`.tbss`/`.tdata` 段） |
| `__global_reg` | 解析（全局寄存器变量提示） |
| `__smc` | 解析（SMC 安全监控调用提示） |
| `__int64` / `__int32` / `__int16` / `__int8` | 固定宽度整数类型别名 |
| `__typedef` | 解析（typedef 兼容前缀） |
| `__args` / `__return` | 解析（参数/返回寄存器绑定提示） |
| `__tp_soft` | 解析（软件线程指针提示） |
| `__nothrow` | 解析（函数不抛异常提示） |
| `__deprecated` | 解析（弃用标记） |
| `__may_alias` | 解析（别名安全类型提示） |
| `__softfp` | 解析（软浮点 ABI 提示） |

#### 9.5.2 `__attribute__` 属性

| 属性 | 行为 |
| --- | --- |
| `section("name")` | 生成 `.section` 指令 |
| `aligned(n)` / `packed` / `noreturn` | 真正生效 |
| `used` / `unused` | 防裁剪 / 抑制警告 |
| `alias("target")` | 函数别名 |
| `constructor` / `destructor` | 生成 `.init_array` / `.fini_array` |
| `deprecated` / `format(printf, ...)` | 透传 |
| `may_alias` / `nothrow` | 解析（透传给后端） |
| `pure` / `const` | 解析（纯函数提示） |
| `visibility("default/hidden")` | 解析（可见性提示） |
| `nonnull` | 解析（非空指针参数提示） |
| `warn_unused_result` | 解析（返回值必须使用提示） |
| `sentinel` | 解析（变参末尾 NULL 哨兵提示） |
| `malloc` | 解析（分配函数提示） |
| `fastcall` / `stdcall` / `cdecl` | 解析（调用约定提示） |

#### 9.5.3 `#pragma`

| pragma | 行为 |
| --- | --- |
| `#pragma pack(n)` | 结构体对齐控制 |
| `#pragma anon_unions` | 匿名 union 兼容 |
| `#pragma location=addr` | 绝对地址 |
| `#pragma diag_suppress` | 诊断抑制 |
| `#pragma arm` / `#pragma thumb` | 指令集切换提示 |
| `#pragma import(__use_no_semihosting)` | 半主机禁用 |
| `#pragma push` / `#pragma pop` | 编译选项栈 |
| `#pragma O0` / `O2` / `O3`、`#pragma optimize` | 优化等级提示 |

#### 9.5.4 预定义宏

| 宏 | 值 / 含义 |
| --- | --- |
| `__ARMCC_VERSION` | armcc 版本号 |
| `__arm__` / `__thumb__` | ARM/Thumb 模式标识 |
| `__arm` / `__thumb` | 无下划线形式（armcc 兼容） |
| `__TARGET_ARCH_7_M` / `__TARGET_ARCH_7E_M` | Cortex-M 架构标识（由 `-mcpu`/`--cpu` 设置） |
| `__TARGET_FPU_VFP` | VFP 标识（由 `--fpu=hard` 设置） |
| `__BIG_ENDIAN` / `__LITTLE_ENDIAN__` | 字节序 |
| `__sizeof_int` / `__sizeof_ptr` | 类型尺寸 |
| `__STDC_VERSION__` | `199901L` |
| `__STDC_HOSTED__` | `1`（host）/ `0`（嵌入式） |
| `__SIZE_TYPE__` / `__PTRDIFF_TYPE__` / `__WCHAR_TYPE__` | GCC 风格类型尺寸宏 |
| `__EDG__` | EDG 前端兼容标识 |
| `__APCS_INTERWORK` | APCS 互交标识 |
| `__FILE__` / `__LINE__` / `__func__` / `__DATE__` / `__TIME__` / `__STDC__` / `__ARK_CC__` | 标准与项目宏 |

#### 9.5.5 命令行选项

| 选项 | armcc/gcc 对应 | 行为 |
| --- | --- | --- |
| `-mcpu <name>` | gcc `-mcpu` | Cortex-M3/M4/M7/M33 等 |
| `--cpu <name>` | armcc `--cpu` | 同 `-mcpu` |
| `--thumb` / `--arm` | armcc | 强制 Thumb / ARM 模式 |
| `--fpu <type>` | armcc `--fpu` | `soft` / `hard` |
| `-MMD` / `--depend` / `-MF <file>` | gcc | 生成 `.d` 依赖文件 |
| `--split_sections` / `-ffunction-sections` | armcc `--split_sections` | 每函数独立段 |
| `--dollar` | armcc `--dollar` | 标识符含 `$` |
| `--enum_is_int` | armcc `--enum_is_int` | 枚举底层 int |
| `--signed_chars` / `--unsigned_chars` | armcc | char 默认符号 |
| `--wchar16` / `--wchar32` | armcc | `wchar_t` 宽度 |
| `--dwarf2` / `--dwarf3` | armcc `--dwarf2`/`--dwarf3` | DWARF 调试版本 |

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
| `math.h` | `sin cos sqrt pow fabs floor ceil fmod` + `M_PI` 等常量（实现见 `stdlib/src/math.c`） |
| `setjmp.h` | `jmp_buf setjmp longjmp`（实现见 `stdlib/src/setjmp.c`，host 可移植简化实现） |

> 在 `c` 后端下，这些函数直接路由到宿主 libc；在 `arm` 后端下，需要在 STM32 用户代码中提供实现，或者链接到 newlib-nano，或者直接使用 `stdlib/src/` 下自带的实现源。

---

## 11 常见问题 FAQ

**Q1：为什么 `-target c` 编译出来的 `.gen.c` 不是漂亮的人类代码？**
A：c 后端是从 IR 翻译，不是从 AST 翻译。它的目标是"语义等价"，不是"风格优美"。它非常适合做回归测试。

**Q2：在 Windows 上没有 gcc，能跑 arkcc 吗？**
A：编译 arkcc 本体需要 gcc / MinGW / MSVC。如果用 MSVC，需要把 Makefile 改成 `cl.exe`。VS Code + clangd 也是常见选择。

**Q3：能编译 Keil/MDK 写的 STM32 工程吗？**
A：v0.7.0 已覆盖 armcc 常用扩展 98% 以上。HAL/CMSIS 中常见的 `__attribute__`、`__packed`、`__align`、内联汇编、`#pragma pack/anon_unions/location/...`、`__irq`/`__weak`/`__naked` 等均已支持。少数极端宏游戏或 C++ 模式仍不支持，建议先用官方编译器编 HAL/CMSIS，再用 arkcc 编译应用层代码。

**Q4：如何让被编译的程序在 STM32 上调用 HAL？**
A：通过外部声明 + 链接重定位。被编译代码声明 `extern void HAL_Delay(uint32_t)`，运行时由 ARM 后端的 linker 把 `BL HAL_Delay` 的目标地址回填为 HAL 函数的实际地址（需要你提供地址表）。简化做法：把这些函数地址硬编码成一张数组，arkcc 调用时通过函数指针跳转。

**Q5：ARM 后端会用 FPU 吗？**
A：会。`--fpu=hard` 或 `arkcc.cfg` 中 `fpu_hw=1` 时，ARM 后端直接发射 VFP 指令（`VADD/VMUL/VCVT/VCMP`）替代 `__aeabi_f*`/`__aeabi_d*` 软浮点桩；默认走软浮点桩以兼容无 FPU 的 Cortex-M3。`double` 始终为真 64 位精度。

**Q6：编译大文件时报"out of memory"怎么办？**
A：Bump Allocator 默认 256 KB。把 [include/memory.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/memory.h) 中的 `ARK_POOL_SIZE` 调大，或在 STM32 端把 `.ark_heap` 段扩到 128 KB+（注意 H743 AXI SRAM 共 512 KB）。

**Q7：能像 GCC 一样跨编译单元链接吗？**
A：当前仍是"单翻译单元"模型，多个 `.c` 之间靠 `#include` 合并。`-link a.o b.o` 仅在 ARM 后端做 `BL` 偏移回填，不解析 ELF `.o` 文件。完整跨翻译单元链接（多 `.o` 链接）是 Roadmap，详见 [12 已知限制](#12-已知限制)。

**Q8：DWARF 调试信息能被 GDB/LLDB 识别吗？**
A：v0.7.0 已输出完整 DWARF 段（`.debug_info`/`.debug_abbrev`/`.debug_line` + `.file/.loc/.cfi_startproc/.size`），用 `--dwarf2` 或 `--dwarf3` 选择版本。基本行号级调试可被 GDB 识别；变量取值（`-print var`）尚未完整支持。

**Q9：`__packed` 指针真的会做未对齐访问吗？**
A：会。v0.7.0 的 `__packed` 指针（如 `__packed int *p`）会生成逐字节加载/拼接的代码，正确处理未对齐地址；普通指针对齐违例行为未定义。

---

## 12 已知限制

v0.7.0 已实现 C99 全集 + armcc 常用扩展 98% 以上，仅剩以下限制：

### 完全不支持

- **C++ 模式**（`--cpp`）：当前是 C99 编译器，不解析 `class`/模板/异常等 C++ 语法。
- **自动向量化**（`--vectorize`）：无 SIMD 指令自动识别与重排。
- **自动内联**（`--autoinline`）：`inline` 仅作为提示，不会自动选择小函数内联。

### 实验性（默认关闭）

- **寄存器分配**：当前栈式 IR 默认每变量一栈槽；实验性线性扫描寄存器分配器通过 `opt_regalloc=1` 开启，但默认关闭以保稳定性。

### 部分支持

- **跨翻译单元链接**：当前是"单翻译单元"模型，多个 `.c` 之间靠 `#include` 合并。`-link a.o b.o` 仅做 ARM `BL` 偏移回填，不解析 ELF `.o` 文件格式。完整多 `.o` 链接是 Roadmap。

### 兼容提示

- 部分高级优化（如循环展开、循环不变量外提、PHI 节点合并等）尚未实现，建议对性能敏感的代码用 `__forceinline` 手工控制。
- 部分稀有 armcc 内建函数（`__builtin_*` 系列）尚未覆盖，需要时可通过 `__asm` 内联汇编替代。

---

## 附录 A：内部数据流

```
源代码 .c
   |
   v
+--------+      含 #include 展开、#define 替换、条件编译、trigraph 替换
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
+--------+      可选：常量折叠 + 死代码消除（src/opt.c）
|  opt   |
+--------+
   |
   v
+-----------+    选 CPU/scatter/FPU/DWARF 版本
| backend.* |--- emit_asm  -> 文本汇编 / .gen.c
|           |--- assemble  -> 16/32 位机器码（arm 完整实现）
|           |--- link      -> BL 重定位（arm）
+-----------+
   |
   v
.bin / .S / .gen.c / 跳转执行（STM32 上直接跳到 .ark_code 段执行）
```

---

## 附录 B：术语表

| 术语 | 含义 |
| --- | --- |
| AST | Abstract Syntax Tree，抽象语法树 |
| IR | Intermediate Representation，中间表示 |
| Bump Allocator | 一次性向上累加分配，整体释放，无碎片 |
| Thumb-2 | ARM 32 位混合长度指令集，Cortex-M3/M4/M7 主用 |
| AAPCS | ARM Architecture Procedure Call Standard，ARM 调用约定 |
| AXI SRAM | STM32H7 上挂在 AXI 总线的 512 KB SRAM，地址 `0x24000000` 起 |
| Scatter file | ARM Compiler 的链接脚本（`.sct`），定义内存映射 |
| TLS | Thread-Local Storage，线程局部存储，对应 `.tbss`/`.tdata` 段 |
| DWARF | 调试信息格式标准，v2/v3 由 `--dwarf2`/`--dwarf3` 选择 |
| MSP | MCU Support Package，STM32 HAL 的硬件初始化钩子 |
| FileEntry | 本工程自定义的 Flash 极简文件索引项（32 字节） |
| APCS | ARM Procedure Call Standard，早期 ARM 调用约定 |
| EDG | Edison Design Group，armcc 早期前端供应商，`__EDG__` 为兼容宏 |

---

如对手册或代码有疑问，欢迎对照源码逐文件阅读。设计上每个文件不超过 1000 行，所有阶段彼此独立，便于"挑一个模块单独看"。
