# Ark C Compiler 使用手册

> 版本：v0.7.0
> 读者：嵌入式开发者、编译原理学习者，以及任何希望在 STM32 上运行"自举 C 编译器"的人
> 作者：Ark C Compiler 项目组

---

## 目录

1. [项目概述](#1-项目概述)
2. [快速上手](#2-快速上手)
3. [命令行参考](#3-命令行参考)
4. [支持的 C 语言特性](#4-支持的-c-语言特性)
5. [多后端架构](#5-多后端架构)
6. [在 Windows 上测试](#6-在-windows-上测试)
7. [STM32H743 + Keil MDK 工程](#7-stm32h743--keil-mdk-工程)
8. [代码组织与移植指南](#8-代码组织与移植指南)
9. [扩展开发指南](#9-扩展开发指南)
10. [标准库子集](#10-标准库子集)
11. [常见问题](#11-常见问题)
12. [已知限制](#12-已知限制)
13. [附录 A：内部数据流](#附录-a内部数据流)
14. [附录 B：术语表](#附录-b术语表)
15. [附录 C：源码与文档编码规范](#附录-c源码与文档编码规范)
16. [附录 D：armcc5 工具链与 MDK 构建详解](#附录-darmcc5-工具链与-mdk-构建详解)

---

## 1 项目概述

**Ark C Compiler**（简称 `arkcc`）是一款用 C99 编写的极简 C 语言编译器。当前版本 v0.7.0 覆盖了 ARM Compiler 5（armcc）常用扩展中的 98% 以上（仅缺 C++ 模式与高级优化）。设计目标：

- **嵌入式自举**：编译器本身能在 STM32H743 等 Cortex-M7 微控制器上 **原生** 运行，从外部 SPI Flash 读取 `.c` 源码，就地生成机器码，然后直接跳转执行。`port/stm32/main_stm32.c` 提供了独立入口，构成"编译-链接-执行"的完整闭环，无需任何 PC 侧工具链。
- **多后端**：核心前端只产生与目标无关的栈式虚拟机中间代码（IR），后端可以在 `arm` / `x86_64` / `riscv32` / `c` 之间自由切换。
- **易于扩展**：各层（lexer/parser/sema/irgen/codegen/asm/linker）独立成文件，添加关键字、AST 节点或目标平台都有清晰的扩展点。
- **易于在 Windows 上测试**：内置的 `c` 后端把 IR 翻译回可读的 C 代码，可直接用主机 gcc 编译执行，无需模拟器或真实硬件。

### 1.1 整体流水线

```
   source .c
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
                                  .S(汇编)/.bin(机器码)/.gen.c
                                                |
                                                v （STM32 上：直接跳转到机器码执行）
```

ARM 后端流水线还包括：CPU 选择（`-mcpu`/`--cpu`，影响指令集与默认对齐）、Scatter 描述文件解析（`src/scatter.c`）、TLS 段生成（`.tbss`/`.tdata`）以及完整的 DWARF 调试段输出（`.debug_info`/`.debug_abbrev`/`.debug_line`）。

### 1.2 目录一览

```
ark c compiler/
├── include/                  公开头文件（前端 + 后端接口 + cpu.h + scatter.h）
├── src/                      编译器核心（与目标无关的前端 + cpu.c + scatter.c）
│   └── backend/              所有后端
│       ├── registry.c        后端注册表
│       ├── arm/              ARM Cortex-M Thumb-2 后端
│       ├── x86_64/           x86_64 GAS 后端
│       ├── riscv32/          RV32I GAS 后端
│       └── c/                主机测试后端（IR -> C）
├── stdlib/                   编译器自带的极简标准库
│   ├── include/              头文件（stdint/string/stdio/math/setjmp 等）
│   └── src/                  可选的实现源码
├── port/
│   ├── host/                 PC 平台抽象（stdio）
│   └── stm32/                STM32 平台抽象（HAL UART + W25Q + main_stm32.c 自举入口）
├── examples/                 62 个测试样例
├── mdk/STM32H743_ArkCC/      Keil MDK 工程（STM32H743VIT6）
├── arkcc.cfg                 默认运行时配置（INI 格式）
├── Makefile                  主机构建脚本
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
2. 可选：**STM32 嵌入式部分** 需要 **Keil MDK-ARM 5.36+**，可选 ST-Link 调试器与 STM32H743 开发板。

### 2.2 三分钟构建 + 测试

```powershell
cd "<your-ark-cc-repo-path>"

# 1. 构建 arkcc 本身
make
# 等价于：gcc -Wall -Wextra -O2 -std=c99 -Iinclude -Istdlib/include `
#         src/*.c src/backend/*/*.c port/host/*.c -o arkcc.exe

# 2. 运行一个样例（输出 Thumb-2 汇编）
.\arkcc.exe examples\hello.c -target arm -S

# 3. 使用 c 后端跑完整测试集（推荐）
powershell -ExecutionPolicy Bypass -File examples\run_tests.ps1
```

运行测试脚本时，每个样例会：
1. 用 `-target arm -S` 检查 ARM 后端不崩溃；
2. 用 `-target c -S` 生成 `*.gen.c`；
3. 用主机 gcc 编译并运行 `*.gen.exe`，检查退出码。

输出形如：
```
[arm] hello.c
[c]   hello.c   exit=42
[arm] arith.c
[c]   arith.c   exit=900
...
```

截至 v0.7.0，**62 个测试全部通过**。

### 2.3 编译自己的 .c 文件

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

编译并运行：
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
| `-o <file>` | 输出文件；未指定时默认为 `<input>.bin`（机器码）或 `<input>.gen.c`（c 后端 + `-S`） |
| `-S` | 只输出文本汇编/源码，不做汇编与链接 |
| `-c` | 只编译不链接（`.ark_obj`） |
| `-E` | 只做预处理 |
| `-link a.o b.o` | 链接多个 `.ark_obj` 文件 |
| `-target <name>` | 选择后端：`arm`（默认）、`x86_64`、`riscv32`、`c` |
| `-I <dir>` | 添加额外的 `#include` 搜索路径（可多次使用） |
| `-v` | 详细模式：打印每一阶段耗时与输出大小 |
| `-O0/-O1/-O2` | 优化等级（0=无，1=基本常量折叠 + DCE，2=激进优化 + 内联） |
| `-g` | 输出 DWARF 调试信息 |
| `-config <file>` | 加载 INI 配置文件（默认 `arkcc.cfg`） |
| `-f<feature>` / `-fno-<feature>` | 启用/关闭特性（vla/complex/wchar/trigraph/fpu/dwarf/opt-inline/opt-dce/opt-constfold/...） |
| `-Wno-unused` | 抑制未使用警告 |
| `--list-backends` | 列出所有可用后端 |
| `-h`, `--help` | 显示帮助 |

### 3.2 目标 CPU 选择

| 选项 | 说明 |
| --- | --- |
| `-mcpu <name>` | 选择 Cortex-M3/M4/M7/M33 等；影响指令集与默认对齐 |
| `--cpu <name>` | armcc 风格的同义词 |
| `--thumb` | 强制 Thumb 模式（Cortex-M 默认） |
| `--arm` | 强制 ARM 模式 |
| `--fpu <type>` | `soft`（软浮点）/ `hard`（硬件 FPU，VFP） |

CPU 选择的实现位于 `include/cpu.h` + `src/cpu.c`，会根据 CPU 名字自动设置相应预定义宏（如 `__TARGET_ARCH_7_M`、`__TARGET_ARCH_7E_M`、`__TARGET_FPU_VFP`）。

### 3.3 依赖生成

| 选项 | 说明 |
| --- | --- |
| `-MMD` | 生成 `.d` 依赖文件（行为与 gcc 一致） |
| `--depend` | 同 `-MMD` |
| `-MF <file>` | 指定依赖文件名 |

### 3.4 分段与代码生成

| 选项 | 说明 |
| --- | --- |
| `--split_sections` | 每函数一段（`.text.<fn>`），有助于链接器剔除死代码 |
| `-ffunction-sections` | 同 `--split_sections` |

### 3.5 语言兼容性选项

| 选项 | 说明 |
| --- | --- |
| `--dollar` | 允许标识符中包含 `$` |
| `--enum_is_int` | 强制枚举底层类型为 `int` |
| `--signed_chars` | `char` 默认有符号 |
| `--unsigned_chars` | `char` 默认无符号 |
| `--wchar16` | `wchar_t` 为 16 位 |
| `--wchar32` | `wchar_t` 为 32 位 |

### 3.6 DWARF 调试版本

| 选项 | 说明 |
| --- | --- |
| `--dwarf2` | 输出 DWARF v2 调试段 |
| `--dwarf3` | 输出 DWARF v3 调试段 |

### 3.7 常见命令组合

| 目标 | 命令 |
| --- | --- |
| 快速检查词法/语法是否正确 | `arkcc x.c -target c -S -o /dev/null` |
| 调试 IR -> 汇编翻译 | `arkcc x.c -target arm -S` |
| 生成主机可运行的可执行文件 | `arkcc x.c -target c -S -o out.c && gcc out.c -o out` |
| 生成 Cortex-M7 + 硬件 FPU 代码 | `arkcc x.c -target arm -mcpu=cortex-m7 --fpu=hard -S` |
| 输出 DWARF v3 调试信息 | `arkcc x.c -target arm -g --dwarf3 -S` |
| 每函数一段（便于死代码剔除） | `arkcc x.c -target arm --split_sections -S` |
| 生成 Makefile 依赖 | `arkcc x.c -MMD -MF x.d` |
| 写入 STM32 W25Q 供执行 | `arkcc x.c -target arm -o /app/main.bin`（再用主机工具写入 Flash） |

---

## 4 支持的 C 语言特性

本节以 ISO/IEC 9899:1999（C99）为参照，列出 v0.7.0 编译器实际支持的内容。编译器实现了完整的 C99 集合，并覆盖了 98% 以上的常用 armcc 扩展。

### 4.1 类型系统

| 分类 | 支持 | 备注 |
| --- | :---: | --- |
| `void` `char` `short` `int` `long` `long long` | 是 | `int` 为 32 位，`long long` 为 64 位 |
| `signed` / `unsigned` 修饰符 | 是 | sema 会区分有符号/无符号；`--signed_chars`/`--unsigned_chars` 控制 `char` 默认符号性 |
| `_Bool` / `<stdbool.h>` 中的 `bool/true/false` | 是 | |
| `float` / `double` / `long double` | 是 | ARM 后端支持硬件 FPU（VFP）或 `__aeabi_f*`/`__aeabi_d*` 软浮点桩；`double` 为真正的 64 位精度 |
| `_Complex` / `_Imaginary` | 是 | `_Complex double`/`_Complex float` 直传给 gcc（`sizeof(_Complex double)==16`） |
| 一维/多维数组 | 是 | 维度允许常量表达式 |
| 指针、多级指针 | 是 | |
| 函数指针 | 是 | 完整的语法与调用支持 |
| `struct` / `union` | 是 | 字段偏移、`.`/`->`、位域（真正按位打包）、柔性数组成员、匿名 struct/union 字段提升 |
| `enum` | 是 | 视为一组 int 常量；`--enum_is_int` 强制 int 底层类型 |
| `typedef` | 是 | 包含递归 typedef |
| 类型限定符 `const` `volatile` `restrict` | 是 | 解析并用于语义分析 |
| 存储类 `static` `extern` `auto` `register` | 是 | `static/extern` 影响链接；函数内 `static` 具有持久生命周期 |
| `inline` | 是 | 解析（作为提示） |
| `__thread`（TLS） | 是 | 线程本地存储，输出 `.tbss`/`.tdata` 段 |
| 强制类型转换 `(type)expr` | 是 | |
| `sizeof(type)` / `sizeof expr` | 是 | 编译期求值 |
| VLA 可变长度数组 | 是 | `int a[n]` 运行期 VLA，通过 `IR_ALLOCA` 在栈上分配（8 字节对齐） |

### 4.2 字面量

| 形式 | 示例 | 支持 |
| --- | --- | :---: |
| 十进制整数 | `42` | 是 |
| 八进制 | `0755` | 是 |
| 十六进制 | `0xFF` | 是 |
| 整数后缀 | `42u 42L 42ull` | 是 |
| 字符 | `'a' '\n' '\xFF' '\0'` | 是 |
| 字符串 | `"hello\n"` 支持相邻拼接 | 是 |
| 浮点 | `1.5 1.5e-3 .5 2.0f` | 是 |
| 宽字符 / 宽字符串 | `L'a' L"..."` | 是（`--wchar16`/`--wchar32` 切换宽度） |

### 4.3 运算符

| 分类 | 支持 |
| --- | :---: |
| 算术 `+ - * / %` | 是 |
| 比较 `== != < > <= >=` | 是 |
| 逻辑 `&& \|\| !`（短路求值） | 是 |
| 位运算 `& \| ^ ~ << >>` | 是 |
| 赋值 `=` 及全部复合赋值 `+= -= *= /= %= &= \|= ^= <<= >>=` | 是 |
| 自增自减 `++ --`（前缀 + 后缀） | 是 |
| 三目 `?:` | 是 |
| 逗号 `,`（表达式上下文中） | 是 |
| 取地址 `&` / 解引用 `*` | 是 |
| 成员访问 `.` / `->` | 是 |
| `sizeof` | 是 |

### 4.4 语句

| 语句 | 支持 |
| --- | :---: |
| 表达式语句、声明语句 | 是 |
| `if / else` | 是 |
| `while / do-while / for` | 是 |
| `switch / case / default` | 是 |
| `break / continue / return` | 是 |
| `goto` + 标签 | 是 |
| 块内任意位置声明（C99 放宽） | 是 |
| `for (int i = 0; ...; ...)` 中声明 | 是 |

### 4.5 函数

| 特性 | 支持 |
| --- | :---: |
| 定义、声明、调用、递归 | 是 |
| 参数超过 4 个 | 是（多余的进栈，严格 AAPCS） |
| 函数原型与参数个数检查 | 是 |
| 变参 `...` | 是 |
| 函数指针调用 | 是 |
| `inline` | 是（作为提示） |
| K&R 风格旧式参数 | 是 |
| 结构体按值传递/返回 | 是（通过隐藏指针参数） |

### 4.6 预处理器

| 指令 | 支持 |
| --- | :---: |
| 对象宏 `#define NAME body` | 是 |
| 函数宏 `#define MAX(a,b) ((a)>(b)?(a):(b))` | 是 |
| `#` 字符串化，`##` 拼接 | 是 |
| 续行符 `\` | 是 |
| `#if / #elif / #else / #endif` | 是 |
| `#ifdef / #ifndef` | 是 |
| `#undef / #error / #warning` | 是 |
| `#pragma`（详见 9.4） | 是 |
| 嵌套 `#include`（<=8 层） | 是 |
| 搜索路径 `-I` | 是 |
| 三字符组（C99 全部 9 种） | 是 |
| 预定义宏 `__FILE__` `__LINE__` `__STDC__` `__ARK_CC__` | 是 |
| `__STDC_VERSION__` `__STDC_HOSTED__` | 是 |
| `__func__` `__DATE__` `__TIME__` | 是 |
| 变参宏 `__VA_ARGS__` | 是 |

### 4.7 初始化与链接

| 特性 | 支持 |
| --- | :---: |
| 全局变量、内部/外部链接 | 是 |
| 带初始化的局部变量 | 是 |
| 聚合数组初始化 `{1,2,3}` | 是 |
| 嵌套聚合初始化 `{{1,2},{3,4}}` | 是 |
| 指派初始化 `.x=1` `[2]=5` | 是 |
| 字符串初始化 `char s[]="hi"` | 是 |
| 全局非字面量初始化（常量表达式折叠） | 是 |
| 复合字面量 `(int[]){1,2,3}` / `(struct P){.x=1,.y=2}` | 是 |
| TLS 初始化（`__thread`） | 是 |

### 4.8 内联汇编

| 形式 | 支持 |
| --- | :---: |
| 基本形式 `asm("...")` / `__asm__("...")` | 是 |
| 扩展形式 `asm("..." : outputs : inputs : clobbers)` | 是 |
| `__asm void fn() {...}` 整函数体汇编（armcc 风格） | 是 |

C 后端完整透传内联汇编（含操作数替换）；ARM 后端做文本透传。

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
- `assemble`：把文本汇编编码为机器码。软件后端（c/x86_64/riscv32）可直接透传汇编文本，交给主机工具链处理。
- `link`：跨函数符号重定位（ARM 后端用它回填 `BL` 偏移）。

### 5.2 已实现的后端

| 后端 | 目录 | 入口符号 | 主要用途 |
| --- | --- | --- | --- |
| `arm` | [src/backend/arm/](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/backend/arm) | `ark_backend_arm()` | STM32 Cortex-M3/M4/M7/M33（Thumb-2），完整 DWARF + TLS + Scatter |
| `x86_64` | [src/backend/x86_64/](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/backend/x86_64) | `ark_backend_x86_64()` | 生成主机 `as` 可用的 GAS 汇编 |
| `riscv32` | [src/backend/riscv32/](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/backend/riscv32) | `ark_backend_riscv32()` | 生成 RV32I 汇编（GAS） |
| `c` | [src/backend/c/](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/backend/c) | `ark_backend_c()` | IR -> 可读 C 源码（主机测试主路径） |

注册表：[src/backend/registry.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/backend/registry.c)。新增后端只需在此增加一行注册。

### 5.3 选择后端

```powershell
.\arkcc.exe --list-backends
.\arkcc.exe foo.c -target x86_64 -S -o foo.s
.\arkcc.exe foo.c -target riscv32 -S -o foo.s
.\arkcc.exe foo.c -target c -S -o foo.gen.c
```

### 5.4 CPU 选择

ARM 后端可按 CPU 名字切换指令集与默认对齐：

```powershell
.\arkcc.exe foo.c -target arm -mcpu=cortex-m7 --fpu=hard -S
.\arkcc.exe foo.c -target arm --cpu=Cortex-M4 --thumb -S
```

CPU 选择在 `include/cpu.h` + `src/cpu.c` 中实现，会自动设置相应预定义宏（详见 9.5）。

### 5.5 Scatter 描述文件

ARM 后端可解析 armcc 风格的 Scatter 文件（`.sct`），实现位于 `include/scatter.h` + `src/scatter.c`。Scatter 文件描述各段（`.text`/`.data`/`.bss`/`.ark_heap`/`.ark_code` 等）的物理与执行地址，常用于多存储区域嵌入式系统（例如 STM32H7 的 DTCM/AXI SRAM/Flash 分区）。

**当前支持范围**：
- ✅ 解析 `.sct`（`scatter_parse_file`）和 GNU `.ld`（`linker_script_parse_file`）
- ✅ 互转：`.sct` ↔ `.ld`（在 `-S` 模式下）
- ✅ 按段名查找执行地址（`scatter_lookup_addr`）
- ❌ **不参与实际段放置/链接**：ARM 后端不查询 `ScatterDesc`，`arm_link()` 为空实现
- 命令行：`--scatter <file>`、`-T <file>`、`--linker-script <file>`、`--script <file>`

**实际段放置由谁负责？** 在 armcc5 路径下由 armlink 负责（通过 `--scatter=<sct>` 选项），arkCC 只输出汇编/对象代码。在自托管路径下（STM32 板上运行 arkCC），生成的机器码放入 `.ark_code` 段，由 scatter 文件路由到 AXI SRAM。

### 5.6 汇编文件（`.s`/`.S`）输入

arkCC 可直接编译 `.s`/`.S` 汇编文件为机器码，ARM 后端有完整的 Thumb-2 文本汇编器（`arm_assemble()`）：

```powershell
.\arkcc.exe startup.s -target arm -o startup.bin
.\arkcc.exe myfunc.S -target arm -c -o myfunc.ark_obj
```

**触发规则**：由文件扩展名决定（`.s` 或 `.S`，2 字符扩展名），**不支持 `.asm`**。检测到 `.s`/`.S` 后跳过前端流程（preproc/lex/parse/sema/irgen），直接调用 `be->assemble()`。

**汇编器能力**：两遍汇编 + 重定位，识别 `.thumb`/`.thumb_func`/`.global`/`.section`/`.text`/`.data`/`.bss`/`.type`/`.size`/`.word` 等伪指令，并把 Thumb-2 指令编码为 16/32 位二进制。

**与 `-S` 的区别**：`-S` 是**输出**模式（生成汇编文本），而 `.s` 文件输入是"汇编→机器码"路径。若同时给 `.s` 输入加 `-S`，则原样输出汇编文本（相当于 copy）。

---

## 6 在 Windows 上测试

### 6.1 推荐流程：c 后端

`c` 后端把 IR 翻译成标准 C 源码。这是**离硬件最远、反馈最快**的测试通道，日常开发强烈推荐：

```powershell
.\arkcc.exe examples\struct_test.c -target c -S -o out.gen.c
gcc out.gen.c -o out.exe
.\out.exe
echo $LASTEXITCODE
```

`examples\run_tests.ps1` 已把上述步骤自动化：

```powershell
powershell -ExecutionPolicy Bypass -File examples\run_tests.ps1
```

### 6.2 无硬件情况下验证 ARM 后端

要检查"STM32 上产生的汇编是否正确"，可使用 QEMU 或 ARM 模拟器：

```powershell
# 用 ARM GNU 工具链汇编 + 链接
.\arkcc.exe foo.c -target arm -S -o foo.s
arm-none-eabi-as foo.s -mcpu=cortex-m7 -mthumb -o foo.o
arm-none-eabi-ld foo.o -Ttext=0x00 -o foo.elf
qemu-arm foo.elf
```

> 项目本身不依赖 QEMU；这只是验证后端正确性的常用方式。

### 6.3 测试 x86_64/RISC-V 后端

```powershell
.\arkcc.exe foo.c -target x86_64 -S -o foo.s
gcc foo.s -o foo.exe          # 注意：foo.s 需符合 GAS 语法
```

```powershell
.\arkcc.exe foo.c -target riscv32 -S -o foo.s
riscv32-unknown-elf-gcc foo.s -o foo.elf
```

---

## 7 STM32H743 + Keil MDK 工程

工程位于 [mdk/STM32H743_ArkCC/](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/mdk/STM32H743_ArkCC)。

### 7.1 工程概览

| 项目 | 取值 |
| --- | --- |
| 芯片 | STM32H743VIT6（Cortex-M7，2 MB Flash，1 MB SRAM，480 MHz） |
| 编译器 | **ARM Compiler 5（armcc 5.06 update 7，build 960）**；亦可使用 armclang |
| Scatter | [Linker/STM32H743VITx_FLASH.sct](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/mdk/STM32H743_ArkCC/Linker/STM32H743VITx_FLASH.sct) |
| 启动文件 | [Startup/startup_stm32h743xx.s](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/mdk/STM32H743_ArkCC/Startup/startup_stm32h743xx.s) |
| 用户程序 | [User/main.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/mdk/STM32H743_ArkCC/User/main.c) |
| STM32 自举入口 | [port/stm32/main_stm32.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/port/stm32/main_stm32.c) |
| Flash 区域 | `0x08000000 0x00200000` |
| DTCM 区域 | `0x20000000 0x00020000`（128 KB） |
| AXI SRAM | `0x24000000 0x00080000`（512 KB），用于放置 `.ark_heap` + `.ark_code` + `.ark_buf` |
| armcc5 构建脚本 | [build_stm32_armcc.ps1](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/build_stm32_armcc.ps1) |
| 仅集成 ARM 后端 | 为节省 Flash |

#### 7.1.1 armcc5 命令行关键参数

`build_stm32_armcc.ps1` 使用以下 armcc5 编译选项：

| 选项 | 说明 |
| --- | --- |
| `--cpu=Cortex-M7` | 目标 CPU 选择 |
| `--thumb` | Thumb-2 模式 |
| `-O0` | 关闭优化（便于调试） |
| `-g` | 生成调试信息 |
| `--c99` | C99 模式（armcc5 默认 C90，arkCC 源码需要 C99 的混合声明） |
| `--apcs=interwork` | ARM/Thumb 互操作 ABI |
| `-DARKCC_PROFILE=ARKCC_PROFILE_STM32_MIN` | 启用 STM32 最小配置 profile |

armlink 关键选项：`--scatter=<sct>`，并通过 `system_stm32h7xx.c` 中的 `__user_initial_stackheap` 重定向消除 semihosting 依赖。

工程文件列表（按 Keil "Source Group" 组织）：

- **Application/User**：`main.c` `stm32h7xx_it.c` `stm32h7xx_hal_msp.c` `system_stm32h7xx.c` `bsp_w25q.c`
- **Application/Startup**：`startup_stm32h743xx.s`
- **ArkCC/Core**：`..\..\src\compiler.c` `lexer.c` `parser.c` `sema.c` `ir.c` `irgen.c` `ast.c` `type.c` `symtab.c` `memory.c` `preproc.c` `codegen_common.c` `cpu.c` `scatter.c` `config.c` `opt.c`
- **ArkCC/Backend**：`..\..\src\backend\registry.c` `..\..\src\backend\arm\backend_arm.c`
- **ArkCC/Port**：`..\..\port\stm32\platform_stm32.c` `..\..\port\stm32\flash_fs_stm32.c`
- **Drivers/HAL**：占位头文件位于 `Drivers/CMSIS/Device/ST/STM32H7xx/Include/`

> 注意：在 armcc5 路径下，`port/stm32/main_stm32.c` 不参与编译；MDK `User/main.c` 提供独立的 `main()`，调用 `ark_compile()` 后把生成的机器码通过 `arkcc_on_output()` 输出到 UART。

### 7.2 五步启动

#### 方式 A：用 armcc5 命令行构建（推荐）

无需 Keil IDE，一行 PowerShell 脚本即可完成全部构建：

1. **安装 Keil MDK 5.x（含 armcc 5.06 update 7）**
   确认 `D:\Keil_v5\ARM\ARMCC\bin\armcc.exe`、`armlink.exe`、`fromelf.exe`、`armasm.exe` 存在，并加入 PATH（脚本支持自动探测该路径）。
2. **运行构建脚本**
   ```powershell
   cd "<your-ark-cc-repo-path>"
   powershell -ExecutionPolicy Bypass -File build_stm32_armcc.ps1
   ```
   脚本会：编译 16 个核心 `.c` + 2 个 ARM 后端 + 2 个 STM32 port + 5 个 MDK 用户 `.c` + 1 个启动 `.s`，链接生成：
   - `bootstrap_x86\armcc_objs\arkcc_stm32.elf`
   - `bootstrap_x86\armcc_objs\arkcc_stm32.hex`
   - `bootstrap_x86\armcc_objs\arkcc_stm32.bin`
3. **烧录固件**：用 ST-Link Utility / Keil FlashTool / openocd 把 `arkcc_stm32.hex` 烧到 0x08000000。
4. **准备 W25Q 上的源文件**（参见 [7.3 烧录文件到 W25Q](#73-烧录文件到-w25q)）。
5. **在串口查看输出**：连接 PA9/PA10，115200 波特率，应看到：
   ```
   === Ark C Compiler on STM32H743 ===
   Compiling /app/main.c from W25Q...
   Exit code: <int>
   ```

#### 方式 B：用 Keil MDK IDE 构建

1. **填入官方 CMSIS / HAL**
   将 STM32CubeH7 中的 `Drivers/CMSIS/**` 与 `Drivers/STM32H7xx_HAL_Driver/**` 覆盖工程占位文件；随后在 Keil 中将需要使用的 `stm32h7xx_hal_*.c` 加入 `Drivers/HAL` 分组。
2. **完成初始化代码**
   使用 STM32CubeMX 生成，或手写以下函数（位于 `User/`）：
   - `SystemClock_Config`（480 MHz PLL）
   - `MX_GPIO_Init`
   - `MX_USART1_UART_Init`（115200 8N1，PA9/PA10）
   - `MX_SPI1_Init`（SCK PA5，MISO PA6，MOSI PA7，CS PA4）
   - 在 `stm32h7xx_hal_msp.c` 中添加 MSP 钩子。
3. **准备 W25Q 上的源文件**
   参见 [7.3 烧录文件到 W25Q](#73-烧录文件到-w25q)。
4. **构建并烧录**
   用 Keil 打开 `mdk/STM32H743_ArkCC/ArkCC.uvprojx`，Build -> Download。
5. **在串口查看输出**
   连接 PA9/PA10，115200 波特率，应看到：
   ```
   === Ark C Compiler on STM32H743 ===
   Compiling /app/main.c from W25Q...
   Exit code: <int>
   ```

### 7.3 烧录文件到 W25Q

W25Q128 需要一个极简文件索引表 + 文件数据：

```text
0x000000   FileEntry[32]   每项 32 B = char name[24] + uint32 offset + uint32 size
0x010000   /app/main.c     用户源代码
0x050000   /app/lib.h      ...
```

`FileEntry` 结构位于 [port/stm32/flash_fs_stm32.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/port/stm32/flash_fs_stm32.c)。

主机侧极简脚本（Python，可自行扩展）：

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

然后通过 ST-Link/串口把镜像写入 W25Q（注意 4 KB 扇区擦除）。

### 7.4 内存与缓冲区

arkCC 在 STM32 上使用三层内存区域：

| 段 | 区域 | 大小 | 用途 |
| --- | --- | --- | --- |
| `.text` (含 `.rodata`) | Flash @ 0x08000000 | ~148 KB | 代码段（约 7.3% Flash 占用） |
| `.data` + `.bss` (DTCM) | DTCM @ 0x20000000 | ~19 KB | 全局变量、栈（约 15% DTCM 占用） |
| `.ark_buf` + `.ark_code` + `.ark_heap` | AXI SRAM @ 0x24000000 | ~440 KB | 大型静态缓冲区、代码缓冲、内存池 |

**AXI SRAM 详细布局**（512 KB 总容量，当前占用 ~440 KB，余 72 KB）：

| 段 | 大小 | 内容 |
| --- | --- | --- |
| `.ark_buf`（compiler.o） | 160 KB | `g_src`(32K) + `g_asm`(64K) + `g_code`(32K) + `dep/ld/sct`(24K) + 其他(8K) |
| `.ark_buf`（memory.o） | 64 KB | `g_pool` 内存池（原 128K，为适配 512KB 已减半） |
| `.ark_buf`（preproc.o） | 64 KB | `g_inc_bufs`(4×8K=32K) + `out_buf`(32K)（原 8×16K=128K 已减） |
| `.ark_buf`（backend_arm.o） | 24 KB | `g_arm_syms`(12K) + `g_arm_relocs`(12K) |
| `.ark_code` | 32 KB | 生成的 Thumb-2 机器码缓冲 |
| `.ark_heap` | 32 KB | armcc5 C 库堆（通过 `__user_initial_stackheap` 重定向） |

**关键设计：semihosting 消除**
- arkCC 源码中所有 `fopen/fread/fclose/vsnprintf/snprintf/getenv` 等 semihosting 依赖均已被移除或重定向：
  - `scatter.c` 使用 `fs_read_file()` 抽象层替代 `fopen/fread`
  - `irgen.c` 自定义 `sb_putf` 替代 `snprintf("%.17g")`
  - `scatter.c` 自定义 `put_fmt` 替代 `vsnprintf`
  - `backend_arm.c` 用 `g_arm_dump_syms` 全局标志替代 `getenv("ARKCC_DUMP_SYMS")`
- `system_stm32h7xx.c` 提供 `__user_initial_stackheap` 重定向，将 C 库堆指向 `ark_heap_buffer`

**缓冲区尺寸自适应**：[include/arkcc_config.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/arkcc_config.h) 通过 `ARKCC_PROFILE` 宏区分 `ARKCC_PROFILE_STM32_MIN` 与 `ARKCC_PROFILE_HOST_FULL`，所有大型缓冲区尺寸都按 profile 自动选择。命令行加 `-DARKCC_PROFILE=ARKCC_PROFILE_STM32_MIN` 即启用 STM32 配置。

跳转执行前需调用 `SCB_CleanDCache_by_Addr` + `SCB_InvalidateICache`（[User/main.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/mdk/STM32H743_ArkCC/User/main.c) 中有调用模板）。

### 7.5 调试器与串口

- 调试器：ST-Link（Keil 选项 `Debug -> ST-Link Debugger`）
- 串口：USART1，115200，8N1，PA9-TX / PA10-RX
- 推荐工具：MobaXterm、Tabby、各种串口助手

---

## 8 代码组织与移植指南

### 8.1 文件清单

| 路径 | 作用 |
| --- | --- |
| [include/common.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/common.h) | TokenKind / AstKind / IrOp 主枚举 |
| [include/platform.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/platform.h) | `ark_log` / `ark_logf` / `ark_abort` |
| [include/flash_fs.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/flash_fs.h) | `fs_read_file(path, buf, cap)` |
| [include/memory.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/memory.h) | Bump 分配器 |
| [include/lexer.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/lexer.h) | 词法分析 |
| [include/ast.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/ast.h) | AST 节点 |
| [include/type.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/type.h) | 类型系统 |
| [include/symtab.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/symtab.h) | 符号表 |
| [include/parser.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/parser.h) | 语法分析 |
| [include/sema.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/sema.h) | 语义分析 |
| [include/ir.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/ir.h) | IR 数据结构 |
| [include/irgen.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/irgen.h) | AST -> IR |
| [include/backend.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/backend.h) | 后端接口 |
| [include/preproc.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/preproc.h) | 预处理器 |
| [include/compiler.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/compiler.h) | 顶层入口 `ark_compile` / `ark_compile_and_run` |
| [include/arkcc_config.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/arkcc_config.h) | 编译期特性开关宏 |
| [include/config.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/config.h) | 运行时配置结构 |
| [include/opt.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/opt.h) | 优化 pass 接口 |
| [include/cpu.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/cpu.h) | CPU 选择（Cortex-M3/M4/M7/M33） |
| [include/scatter.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/scatter.h) | Scatter 描述文件解析器 |
| [src/main.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/main.c) | PC 命令行入口 |
| [src/compiler.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/compiler.c) | 流水线调度 |
| [src/config.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/config.c) | INI 配置加载 |
| [src/opt.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/opt.c) | IR 优化 pass（常量折叠 + DCE + 内联） |
| [src/cpu.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/cpu.c) | CPU 选择实现 |
| [src/scatter.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/scatter.c) | Scatter 文件解析实现 |
| [src/backend/registry.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/backend/registry.c) | 后端注册表 |
| [port/stm32/main_stm32.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/port/stm32/main_stm32.c) | STM32 自举入口（替代 PC 的 `main.c`） |

### 8.2 平台抽象层

每个目标平台只需实现两个接口：

```c
/* platform.h */
void ark_log(const char *s);
void ark_logf(const char *fmt, ...);
void ark_abort(const char *msg);

/* flash_fs.h */
int fs_read_file(const char *path, char *buf, int cap);
```

PC 侧：[port/host/platform_host.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/port/host/platform_host.c) / [port/host/flash_fs_host.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/port/host/flash_fs_host.c)；STM32 侧：[port/stm32/](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/port/stm32)。

### 8.3 STM32 自举入口

`port/stm32/main_stm32.c` 是 STM32 侧的独立入口（替代 PC 的 `src/main.c`）。它完成三件事：

1. 从 W25Q 外部 Flash 把 `/app/main.c` 源文件读入内存缓冲区；
2. 调用 `ark_compile()` 编译为 `.ark_code` 段中的 Thumb-2 机器码；
3. 跳转执行生成的机器码，并把返回值通过 UART 输出。

该入口无需任何 PC 工具链——Keil 工程构建下载完成后，用户只需修改 W25Q 中的 `.c` 文件即可立即重新编译并执行。

### 8.4 移植到其他平台

将编译器移植到 Linux/ESP32/RISC-V 开发板，只需：

1. 复制 [port/host/](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/port/host) 到 `port/<myplat>/`
2. 修改 `platform_<myplat>.c` 中的输出实现，改为你自己的 UART/syscall
3. 修改 `flash_fs_<myplat>.c` 中的文件读取实现，改为本地文件系统/SD 卡/网络
4. 编写 `main_<myplat>.c` 入口（参考 `main_stm32.c`）
5. 把 `port/<myplat>/*.c` 加入构建脚本

无需触碰 `src/` 中的任何文件。

---

## 9 扩展开发指南

### 9.1 增加关键字/Token

文件 [include/common.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/common.h)：
1. 在 `TokenKind` 枚举中增加 `TOK_XXX`。
2. 在 [src/lexer.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/lexer.c) 的 `check_keyword()` 中把字符串关联到 `TOK_XXX`。
3. 如有必要，在 [src/parser.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/parser.c) 中处理该 token。

### 9.2 增加 AST 节点

1. 在 [include/common.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/common.h) 中新增 `AST_XXX`。
2. 在 [include/ast.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/ast.h) 的 `AstNode.u` 联合中新增字段。
3. 在 [src/ast.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/ast.c) 中实现 `ast_xxx_new(...)` 构造器。
4. 在 [src/parser.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/parser.c) 的相应产生式中调用构造器。
5. 在 [src/sema.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/sema.c) 中增加类型检查。
6. 在 [src/irgen.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/irgen.c) 中翻译为 IR。

### 9.3 增加 IR 指令

1. 在 [include/common.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/common.h) 中新增 `IR_XXX`。
2. 修改各后端 `emit_asm` 中的 switch case。

### 9.4 增加后端（以 mips 为例）

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
3. 在 [include/backend.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/backend.h) 中声明 `ark_backend_mips()`。
4. 在 [src/backend/registry.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/backend/registry.c) 中注册。
5. `make` 会自动纳入（Makefile 使用通配符）。

完成后：`arkcc foo.c -target mips -S`。

### 9.5 armcc 兼容扩展（v0.7.0 完整清单）

v0.7.0 覆盖了 armcc 5 常用扩展的 98% 以上。下表列出全部支持项。

#### 9.5.1 armcc 关键字

| 关键字 | 行为 |
| --- | --- |
| `__svc(n)` | 输出 `SVC #n` |
| `__irq` | 中断序言 `PUSH {r0-r3,r12,lr}` / 尾声 `POP {r0-r3,r12,pc}` |
| `__weak` | `.weak <name>` |
| `__naked` | 无序言与尾声 |
| `__packed` | 独立关键字形式 + `__attribute__((packed))` + `__packed` 指针的非对齐访问 |
| `__align(n)` | 真正生效的对齐控制 |
| `__at(addr)` | 绝对地址（同 `__attribute__((at(addr)))` / `#pragma location=`） |
| `__forceinline` | 解析（强制内联提示） |
| `__asm void fn() {...}` | 整函数体汇编（armcc 风格） |
| `__value_in_regs` | 解析（结构体寄存器返回提示） |
| `__pure` | 解析（无副作用纯函数提示） |
| `__interwork` | 解析（ARM/Thumb 互通提示） |
| `__thread` | 线程本地存储（`.tbss`/`.tdata` 段） |
| `__global_reg` | 解析（全局寄存器变量提示） |
| `__smc` | 解析（SMC 安全监视器调用提示） |
| `__int64` / `__int32` / `__int16` / `__int8` | 定宽整型别名 |
| `__typedef` | 解析（typedef 兼容前缀） |
| `__args` / `__return` | 解析（参数/返回寄存器绑定提示） |
| `__tp_soft` | 解析（软件线程指针提示） |
| `__nothrow` | 解析（函数不抛异常提示） |
| `__deprecated` | 解析（废弃标记） |
| `__may_alias` | 解析（别名安全类型提示） |
| `__softfp` | 解析（软浮点 ABI 提示） |

#### 9.5.2 `__attribute__` 属性

| 属性 | 行为 |
| --- | --- |
| `section("name")` | 输出 `.section` 指令 |
| `aligned(n)` / `packed` / `noreturn` | 真正生效 |
| `used` / `unused` | 防止裁剪 / 抑制警告 |
| `alias("target")` | 函数别名 |
| `constructor` / `destructor` | 输出 `.init_array` / `.fini_array` |
| `deprecated` / `format(printf, ...)` | 透传 |
| `may_alias` / `nothrow` | 解析（透传至后端） |
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
| `#pragma pack(n)` | struct 对齐控制 |
| `#pragma anon_unions` | 匿名 union 兼容 |
| `#pragma location=addr` | 绝对地址 |
| `#pragma diag_suppress` | 诊断抑制 |
| `#pragma arm` / `#pragma thumb` | 指令集切换提示 |
| `#pragma import(__use_no_semihosting)` | 禁用 semihosting |
| `#pragma push` / `#pragma pop` | 编译选项栈 |
| `#pragma O0` / `O2` / `O3`、`#pragma optimize` | 优化级别提示 |

#### 9.5.4 预定义宏

| 宏 | 取值/含义 |
| --- | --- |
| `__ARMCC_VERSION` | armcc 版本号 |
| `__arm__` / `__thumb__` | ARM/Thumb 模式标志 |
| `__arm` / `__thumb` | 无下划线形式（armcc 兼容） |
| `__TARGET_ARCH_7_M` / `__TARGET_ARCH_7E_M` | Cortex-M 架构标志（由 `-mcpu`/`--cpu` 设置） |
| `__TARGET_FPU_VFP` | VFP 标志（由 `--fpu=hard` 设置） |
| `__BIG_ENDIAN` / `__LITTLE_ENDIAN__` | 字节序 |
| `__sizeof_int` / `__sizeof_ptr` | 类型大小 |
| `__STDC_VERSION__` | `199901L` |
| `__STDC_HOSTED__` | `1`（主机）/ `0`（嵌入式） |
| `__SIZE_TYPE__` / `__PTRDIFF_TYPE__` / `__WCHAR_TYPE__` | GCC 风格类型大小宏 |
| `__EDG__` | EDG 前端兼容标志 |
| `__APCS_INTERWORK` | APCS 互通标志 |
| `__FILE__` / `__LINE__` / `__func__` / `__DATE__` / `__TIME__` / `__STDC__` / `__ARK_CC__` | 标准与项目宏 |

#### 9.5.5 命令行选项

| 选项 | armcc/gcc 对应 | 行为 |
| --- | --- | --- |
| `-mcpu <name>` | gcc `-mcpu` | Cortex-M3/M4/M7/M33 等 |
| `--cpu <name>` | armcc `--cpu` | 同 `-mcpu` |
| `--thumb` / `--arm` | armcc | 强制 Thumb / ARM 模式 |
| `--fpu <type>` | armcc `--fpu` | `soft` / `hard` |
| `-MMD` / `--depend` / `-MF <file>` | gcc | 生成 `.d` 依赖文件 |
| `--split_sections` / `-ffunction-sections` | armcc `--split_sections` | 每函数一段 |
| `--dollar` | armcc `--dollar` | 标识符可含 `$` |
| `--enum_is_int` | armcc `--enum_is_int` | 枚举底层类型为 int |
| `--signed_chars` / `--unsigned_chars` | armcc | char 默认符号性 |
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
| `math.h` | `sin cos sqrt pow fabs floor ceil fmod` + `M_PI` 等常量（实现在 `stdlib/src/math.c`） |
| `setjmp.h` | `jmp_buf setjmp longjmp`（实现在 `stdlib/src/setjmp.c`，可移植的简化主机实现） |

> `c` 后端下，这些函数直接路由到主机 libc；`arm` 后端下，需要在 STM32 用户代码中提供实现，或链接 newlib-nano，或直接使用 `stdlib/src/` 中的实现源码。

---

## 11 常见问题

**Q1：为什么 `-target c` 输出的 `.gen.c` 不是好看的人类代码？**
A：c 后端是从 IR 翻译，而不是从 AST；它追求的是"语义等价"，而不是"美观风格"。它非常适合做回归测试。

**Q2：Windows 上没有 gcc，还能运行 arkcc 吗？**
A：构建 arkcc 本身需要 gcc / MinGW / MSVC。若使用 MSVC，需修改 Makefile 使用 `cl.exe`。VS Code + clangd 也是常见选择。

**Q3：能编译用 Keil/MDK 写的 STM32 工程吗？**
A：v0.7.0 已覆盖 armcc 常用扩展的 98% 以上。HAL/CMSIS 中常见的 `__attribute__`、`__packed`、`__align`、内联汇编、`#pragma pack/anon_unions/location/...`、`__irq`/`__weak`/`__naked` 等均已支持。**armcc5 路径已打通**：`build_stm32_armcc.ps1` 可用 armcc 5.06 直接编译 arkCC 源码生成 `arkcc_stm32.hex/.bin` 烧录到 STM32H743（见 [附录 D](#附录-darmcc5-工具链与-mdk-构建详解)）。少数极端的宏戏法或 C++ 模式仍不支持；建议先用官方编译器编译 HAL/CMSIS，再用 arkcc 编译应用层代码。

**Q3.1：arkCC 能解析 MDK 的 .sct 文件吗？**
A：能解析与互转（`.sct` ↔ `.ld`），但**不参与实际段放置**。在 armcc5 路径下，段放置由 armlink 根据 `.sct` 完成（见 [5.5](#55-scatter-描述文件) 与 [附录 D.5](#d5-sct-文件与-armlink)）。在自托管路径下（STM32 上跑 arkCC），机器码固定放入 `.ark_code` 段，由 scatter 文件路由到 AXI SRAM。

**Q3.2：arkCC 能编译 .s 汇编文件吗？**
A：能。ARM 后端有完整的 Thumb-2 文本汇编器（`arm_assemble()`）。由文件扩展名触发：`.s` 或 `.S` 会被识别为汇编输入，跳过前端流程直接汇编为机器码。**不支持 `.asm`**（详见 [5.6](#56-汇编文件ss输入)）。

**Q4：如何让编译出的程序在 STM32 上调用 HAL？**
A：通过外部声明 + 链接重定位。编译后的代码声明 `extern void HAL_Delay(uint32_t)`；运行时 ARM 后端链接器把 `BL HAL_Delay` 的目标地址回填为 HAL 函数的实际地址（需要你提供地址表）。更简单的做法：把这些函数地址硬编码到一个数组里，让 arkcc 通过函数指针调用。

**Q5：ARM 后端会使用 FPU 吗？**
A：会。使用 `--fpu=hard`，或在 `arkcc.cfg` 中设置 `fpu_hw=1`，ARM 后端会直接输出 VFP 指令（`VADD/VMUL/VCVT/VCMP`），替代 `__aeabi_f*`/`__aeabi_d*` 软浮点桩；默认情况下使用软浮点桩以兼容不带 FPU 的 Cortex-M3。`double` 始终为真正的 64 位精度。

**Q6：编译大文件时报 "out of memory" 怎么办？**
A：Bump 分配器默认 256 KB。可增大 [include/memory.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/memory.h) 中的 `ARK_POOL_SIZE`；或在 STM32 侧把 `.ark_heap` 段扩大到 128 KB+（注意 H743 AXI SRAM 总容量为 512 KB）。

**Q7：能像 GCC 一样跨翻译单元链接吗？**
A：目前仍是"单翻译单元"模型——多个 `.c` 文件通过 `#include` 合并。`-link a.o b.o` 只在 ARM 后端做 `BL` 偏移回填，并不解析 ELF `.o` 文件。完整跨翻译单元链接（多 `.o` 链接）在路线图中，详见 [12 已知限制](#12-已知限制)。

**Q8：DWARF 调试信息能被 GDB/LLDB 识别吗？**
A：v0.7.0 已输出完整的 DWARF 段（`.debug_info`/`.debug_abbrev`/`.debug_line` + `.file/.loc/.cfi_startproc/.size`），可通过 `--dwarf2` 或 `--dwarf3` 选择版本。基本的行级调试可被 GDB 识别；变量值查看（`-print var`）暂未完全支持。

**Q9：`__packed` 指针真的做非对齐访问吗？**
A：是的。在 v0.7.0 中，`__packed` 指针（如 `__packed int *p`）会生成逐字节 load-and-stitch 代码，正确处理非对齐地址；违反对齐的普通指针属未定义行为。

**Q10：如何自举验证编译器？**
A：项目提供 `bootstrap_build.ps1` 自举脚本：用 arkcc 编译自身 24 个源文件为 `.gen.c`，再用 gcc 编译为 `.o` 并链接得到 `arkcc_bootstrap.exe`；随后可继续用 `arkcc_bootstrap.exe` 编译一次自身，形成 bootstrap13/14/15 三代稳定自举。v0.7.0 已通过完整三代自举验证。

---

## 12 已知限制

v0.7.0 已实现完整的 C99 集合 + 98% 以上的 armcc 常用扩展，仅剩以下限制：

### 完全不支持

- **C++ 模式**（`--cpp`）：本项目是 C99 编译器，不解析 `class`/模板/异常等 C++ 语法。
- **自动向量化**（`--vectorize`）：无 SIMD 指令自动识别与重排。

### 实验性（默认关闭）

- **寄存器分配**：栈式 IR 目前默认为每个变量一个栈槽；实验性线性扫描寄存器分配器可通过 `opt_regalloc=1` 启用，默认关闭以保稳定。

### 部分支持

- **跨翻译单元链接**：目前是"单翻译单元"模型——多个 `.c` 文件通过 `#include` 合并。`-link a.o b.o` 仅在 ARM 后端做 `BL` 偏移回填，不解析 ELF `.o` 文件格式。完整多 `.o` 链接在路线图中。

### 兼容性说明

- 部分高级优化（循环展开、循环不变量外提、PHI 节点合并等）暂未实现；对性能敏感的代码，建议使用 `__forceinline` 手动控制。
- 少数罕见的 armcc 内建函数（`__builtin_*` 系列）尚未覆盖；如需要可用 `__asm` 内联汇编替代。

---

## 附录 A：内部数据流

```
source .c
   |
   v
+--------+      #include 展开、#define 替换、条件编译、三字符组替换
| preproc|
+--------+
   |
   v
+--------+      字符 -> token，行号跟踪
| lexer  |
+--------+
   |
   v
+--------+      递归下降，构建 AST，所有节点从 bump 池分配
| parser |
+--------+
   |
   v
+--------+      符号表、类型推断、重定义/未定义检测
|  sema  |
+--------+
   |
   v
+--------+      AST -> 栈式虚拟机四元组 IR（与目标无关）
| irgen  |
+--------+
   |
   v
+--------+      可选：常量折叠 + 死代码剔除 + 函数内联（src/opt.c）
|  opt   |
+--------+
   |
   v
+-----------+    选择 CPU/Scatter/FPU/DWARF 版本
| backend.* |--- emit_asm  -> 文本汇编 / .gen.c
|           |--- assemble  -> 16/32 位机器码（arm 完整实现）
|           |--- link      -> BL 重定位（arm）
+-----------+
   |
   v
.bin / .S / .gen.c / 直接跳转执行（STM32 上跳转到 .ark_code 段）
```

---

## 附录 B：术语表

| 术语 | 含义 |
| --- | --- |
| AST | 抽象语法树（Abstract Syntax Tree） |
| IR | 中间表示（Intermediate Representation） |
| Bump 分配器 | 指针递增式分配，一次性释放，无碎片 |
| Thumb-2 | ARM 32 位混长指令集，Cortex-M3/M4/M7 主指令集 |
| AAPCS | ARM 架构过程调用标准，ARM 调用约定 |
| AXI SRAM | STM32H7 AXI 总线上 512 KB SRAM，起始 `0x24000000` |
| Scatter 文件 | ARM Compiler 链接脚本（`.sct`），定义内存布局 |
| TLS | 线程本地存储（Thread-Local Storage），对应 `.tbss`/`.tdata` 段 |
| DWARF | 调试信息格式标准，v2/v3 由 `--dwarf2`/`--dwarf3` 选择 |
| MSP | MCU 支持包（MCU Support Package），STM32 HAL 的硬件初始化钩子 |
| FileEntry | 本项目自定义的极简 Flash 文件索引项（32 字节） |
| APCS | ARM 过程调用标准，早期 ARM 调用约定 |
| EDG | Edison Design Group，早期 armcc 前端厂商；`__EDG__` 为兼容宏 |

---

## 附录 C：源码与文档编码规范

为便于在多操作系统与多编辑器之间协作，本项目对文件编码做如下约定：

### C.1 文档文件

- 所有 `docs/*.md` 与 `README.md` 使用 **UTF-8**（无 BOM）编码。
- 文档正文用中文编写，代码块与命令行示例保持原样（英文/ASCII）。

### C.2 源代码文件

- 所有 `src/**/*.c`、`src/**/*.h`、`include/*.h`、`port/**/*.c` 等源码文件使用 **GB2312 兼容编码**，即**纯 ASCII 内容**。
- 由于纯 ASCII 是 GB2312 与 UTF-8 的公共子集，此约定同时满足两种编辑器视图。
- **禁止在源代码中出现任何非 ASCII 字节**（含中文标点、全角空格、UTF-8 BOM、以及乱码遗留字节）。
- 所有源码注释必须使用**纯英文**。可用工具校验：
  ```powershell
  $files = Get-ChildItem -Recurse -Include *.c,*.h -Path src,include,port
  foreach ($f in $files) {
      $bytes = [System.IO.File]::ReadAllBytes($f.FullName)
      foreach ($b in $bytes) { if ($b -gt 127) { Write-Host "Non-ASCII in $($f.FullName)"; break } }
  }
  ```

### C.3 为什么这样规定

- 编译器本身作为 v0.7.0 的自举目标，需要在 STM32 等嵌入式环境中运行，那里的编辑器/终端往往不支持 UTF-8；纯 ASCII 源码保证了跨平台可读性与可编辑性。
- 中文文档采用 UTF-8 是 Markdown 生态与 Web 渲染的通行做法，便于在 GitHub、VS Code、Obsidian 等工具中正常显示。
- 源码注释坚持英文，避免因编辑器编码识别错误导致注释乱码进而污染合并、diff、grep 等工作流。

---

## 附录 D：armcc5 工具链与 MDK 构建详解

本附录详细说明如何在 Windows 上使用 ARM Compiler 5（armcc 5.06）编译 arkCC 源码生成可烧录的 STM32 固件，以及如何编译 MDK 工程。完整教程见 [docs/STM32_BUILD.md](STM32_BUILD.md)。

### D.1 工具链准备

| 工具 | 位置（默认安装） | 用途 |
| --- | --- | --- |
| `armcc.exe` | `D:\Keil_v5\ARM\ARMCC\bin\` | C 源码编译 |
| `armlink.exe` | 同上 | 链接 |
| `fromelf.exe` | 同上 | ELF → hex/bin 转换 |
| `armasm.exe` | 同上 | 启动汇编 `startup_stm32h743xx.s` |

确认 armcc5 版本：
```powershell
& "D:\Keil_v5\ARM\ARMCC\bin\armcc.exe" --version
# 输出应包含 "ARM Compiler 5.06 update 7 (build 960)"
```

如未加入系统 PATH，`build_stm32_armcc.ps1` 会自动探测上述默认路径。

### D.2 一键构建

```powershell
cd "<your-ark-cc-repo-path>"
powershell -ExecutionPolicy Bypass -File build_stm32_armcc.ps1
```

脚本执行流程：
1. 编译 16 个核心 `.c`（`src/*.c`）
2. 编译 2 个 ARM 后端（`src/backend/arm/backend_arm.c` + `src/backend/registry.c`）
3. 编译 2 个 STM32 port（`port/stm32/platform_stm32.c` + `port/stm32/flash_fs_stm32.c`）
4. 编译 5 个 MDK 用户文件（`mdk/STM32H743_ArkCC/User/*.c`）
5. 汇编启动文件（`Startup/startup_stm32h743xx.s`）
6. armlink 链接 + fromelf 生成 `.hex` / `.bin`

输出目录：`bootstrap_x86\armcc_objs\`

| 文件 | 用途 |
| --- | --- |
| `arkcc_stm32.elf` | 完整 ELF（含符号表，调试用） |
| `arkcc_stm32.hex` | Intel HEX 格式（ST-Link Utility 烧录用） |
| `arkcc_stm32.bin` | 纯二进制（openocd 烧录用） |
| `*.map` | 链接 map 文件（内存布局分析） |

### D.3 编译 MDK 工程（uvprojx）

若要使用 Keil IDE 而非脚本：

1. 打开 `mdk/STM32H743_ArkCC/ArkCC.uvprojx`
2. Project → Options for Target：
   - **Device**：STM32H743VIT6
   - **Target**：ARM Compiler 5（注意：默认可能是 V5.06，可在 Keil → Components → Manage → Project Components 切换）
   - **C/C++**：勾选 C99，添加宏 `ARKCC_PROFILE=ARKCC_PROFILE_STM32_MIN`，Include Paths 添加 `..\..\include;..\..\include\..\stdlib\include`
   - **Link**：Scatter File 指向 `Linker\STM32H743VITx_FLASH.sct`
3. Build → Build Target（F7）
4. Build → Download（F8）烧录到 Flash

### D.4 常见构建错误

#### L6915E: The semihosting __user_initial_stackheap cannot reliably set up...

**原因**：armcc5 C 库默认使用 semihosting 初始化堆/栈，与 scatter loading 冲突。

**解决**：`system_stm32h7xx.c` 已提供 `__user_initial_stackheap` 重定向实现，把 C 库堆指向 `ark_heap_buffer`（AXI SRAM）。确认该文件参与编译，并使用 `--c99` 而非 C90 编译。

#### L6220E: Load region RW_AXI size exceeds limit

**原因**：AXI SRAM（512 KB）溢出。map 文件会显示 RW_AXI Size > 0x80000。

**解决**：减小 [include/arkcc_config.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/arkcc_config.h) 中的 STM32 profile 缓冲区尺寸：
- `ARK_POOL_SIZE`（默认 64K）
- `PP_INC_BUF` × `PP_MAX_INC_DEPTH`（默认 8K × 4 = 32K）
- `PP_BUF_SIZE`（默认 32K）
- `ark_heap_buffer`（[User/main.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/mdk/STM32H743_ArkCC/User/main.c)，默认 32K）

#### #268: declaration may not appear after executable statement

**原因**：armcc5 默认 C90 模式，不允许混合声明与语句。

**解决**：`build_stm32_armcc.ps1` 已加 `--c99`。若在 Keil IDE 中构建，需在 Options → C/C++ → Language 选 C99。

#### Undefined symbol arkcc_on_output

**原因**：`flash_fs_stm32.c` 调用 `arkcc_on_output()` 但未提供定义。

**解决**：已在 `flash_fs_stm32.c` 提供 `__attribute__((weak))` 默认实现，用户可在 `main.c` 中提供强定义覆盖。

### D.5 .sct 文件与 armlink

arkCC 自身**不参与实际段放置/链接**（见 [5.5](#55-scatter-描述文件)）。在 armcc5 路径下，段放置由 armlink 根据 `.sct` 文件完成：

```text
LR_IROM1 0x08000000 0x00200000  {
  ER_IROM1 0x08000000 0x00200000 {        /* Flash: 代码 + 只读数据 */
    *.o (RESET, +First)
    *(InRoot$$Sections)
    .ANY (+RO)
    .ANY (+XO)
  }
  RW_IRAM1 0x20000000 0x00020000 {        /* DTCM 128K: 全局变量 */
    .ANY (+RW +ZI)
  }
  RW_AXI 0x24000000 0x00080000 {          /* AXI SRAM 512K: 大缓冲区 */
    *(.ark_heap)
    *(.ark_code)
    *(.ark_buf)
  }
}
```

**段到区域的映射**：
- `.text` + `.rodata` → ER_IROM1（Flash）
- `.data` + `.bss` → RW_IRAM1（DTCM）
- `.ark_heap` + `.ark_code` + `.ark_buf` → RW_AXI（AXI SRAM）

arkCC 在生成汇编/对象时使用 `.section` 指令标记段归属；armlink 根据这些段名将内容路由到正确的内存区域。

### D.6 自托管验证：在 STM32 上编译 STM32 程序

arkCC 固件烧录后，目标板会自动从 W25Q Flash 读取 `/app/main.c` 并就地编译执行。验证步骤：

1. 准备一个测试程序，例如 `/app/main.c`：
   ```c
   int main(void) {
       volatile int *led = (int *)0x48000014;  /* GPIOA ODR */
       *led = 1;  /* 点亮 LED */
       return 42;
   }
   ```
2. 用主机端工具把该 `.c` 写入 W25Q Flash（见 [7.3](#73-烧录文件到-w25q)）。
3. 复位 STM32，串口应输出：
   ```
   === Ark C Compiler on STM32H743 ===
   Compiling /app/main.c from W25Q...
   Exit code: 42
   ```
4. 验证 LED 是否点亮。

---

有关手册或代码的问题，欢迎逐一阅读源码。按照设计，任何文件都不超过 1000 行，各阶段互相独立，方便"挑一个模块单独看"。
