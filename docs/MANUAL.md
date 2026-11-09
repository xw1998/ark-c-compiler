# Ark C Compiler 使用手册

> 版本：v0.8.0
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

**Ark C Compiler**（简称 `arkcc`）是一款用 C99 编写的极简 C 语言编译器。当前版本 v0.8.0 覆盖了 ARM Compiler 5（armcc）常用扩展中的 98% 以上（仅缺 C++ 模式与高级优化）。设计目标：

- **嵌入式自举**：编译器本身能在 STM32H743 等 Cortex-M7 微控制器上 **原生** 运行，从外部 SPI Flash 读取 `.c` 源码，就地生成机器码，然后直接跳转执行。`port/stm32/main_stm32.c` 提供了独立入口，构成"编译-链接-执行"的完整闭环，无需任何 PC 侧工具链。
- **多后端**：核心前端只产生与目标无关的栈式虚拟机中间代码（IR），后端可以在 `arm` / `x86`（i386 cdecl，别名 `x86_64`）/ `riscv32` / `c` 之间自由切换。
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
                          backend = arm | x86 | riscv32 | c
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
│       ├── x86_64/           x86（i386 cdecl）GAS 后端
│       ├── riscv32/          RV32I GAS 后端
│       └── c/                主机测试后端（IR -> C）
├── stdlib/                   编译器自带的极简标准库
│   ├── include/              头文件（stdint/string/stdio/math/setjmp 等）
│   └── src/                  可选的实现源码
├── port/
│   ├── host/                 PC 平台抽象（stdio）
│   └── stm32/                STM32 平台抽象（HAL UART + W25Q + main_stm32.c 自举入口）
├── examples/                 80 个测试样例（.c；回归脚本运行其中 75 个）
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
cd "<ark-cc-repo-path>"

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

**71 个断言用例全部通过、4 个用例跳过 C 后端运行、0 失败**（跳过的 4 个是 ARM 专属：内联汇编 2 个、STM32 硬件访问 2 个；脚本只对它们做 ARM 发射检查，**不计入 pass**）。每个样例头部的 `Expected exit code` 由脚本解析后与真实退出码比对，不匹配即判失败。

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
| `-c` | 只编译不链接，产出 `.ark_obj`（ARKOBJ2 容器）。C 源与 `.s/.S/.asm` 汇编源走同一条路径 |
| `-E` | 只做预处理 |
| `-link a.o b.o` | 链接多个 `.ark_obj`；任一对象带 `.data/.bss` 时做 SRAM 窗口重叠检查，重叠即报错不产出 |
| `-target <name>` | 选择后端：`arm`（默认）、`x86`、`riscv32`、`c`。`x86_64`/`x86-64`/`i386`/`i686` 是 `x86` 的别名 |
| `-I <dir>` | 添加额外的 `#include` 搜索路径（可多次使用） |
| `-v` | 详细模式：打印每一阶段耗时与输出大小 |
| `-O0/-O1/-O2` | 优化等级（0=无，1=基本常量折叠 + DCE，2=激进优化 + 内联） |
| `-g` | 输出 DWARF 调试信息，等价 `--dwarf2`；要 v3 需再加 `--dwarf3` |
| `-config <file>` | 加载 INI 配置文件（默认 `arkcc.cfg`） |
| `-f<feature>` / `-fno-<feature>` | 启用/关闭特性（vla/complex/wchar/trigraph/fpu/dwarf/opt-inline/opt-dce/opt-constfold/...） |
| `-Wno-unused` | 抑制未使用警告 |
| `--list-backends` | 列出所有可用后端 |
| `--diag_style <arm\|ide>` | 诊断排版：`arm`（默认，同 armcc 默认）或 `ide`（uVision 的 `文件(行,列) : error 码: 消息` 风格） |
| `--diag_suppress=<n>[,<n>]` | 抑制指定码的诊断（同 armcc：非数字或越界码静默忽略；无值时报 `C3901U`） |
| `--diag_remark=<n>[,<n>]` | 与 `--diag_suppress` 不可区分（实测 armcc 亦然），复用同一套抑制位 |
| `--diag_error=<n>[,<n>]` | 把指定码升级为 error；`-D` 后缀仍按该码的内在类别保留 |
| `--diag_warning=<n>[,<n>]` | 接受但无操作（实测 armcc 对同一条 error 也无任何可观察变化） |
| `--errors <file>` | 把整条诊断流写入文件，而不是 stderr |
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

**双精度 FPU 只跟 `-mcpu` 走**：`Cortex-M7` 的 FPU 是 VFPv5-**D16**（有双精度），
M4/M33 只有单精度。传 `-mcpu Cortex-M7` 时，`double`↔`float` 的隐式转换直接发
`VCVT.F64.F32` / `VCVT.F32.F64`；不传（或传 M4/M33）时编译器走保守路径，发
`BL __aeabi_f2d` / `BL __aeabi_d2f`，**这两个符号必须由运行库提供**（libgcc 或等价实现）。
在只有单精度硬件、又没有链接 libgcc 的裸机小程序里，后者就是链接期的
`unresolved symbol "__aeabi_f2d"`——此时正确做法是明确告诉编译器目标 CPU，而不是去补软浮 helper。
（这一条曾经是缺陷：`-mcpu` 算出的开关在后续初始化里被清零，`-mcpu Cortex-M7` 看着被接受、
实际仍发 `__aeabi_f2d`。已修复，另见本章 Q5。）

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

本节以 ISO/IEC 9899:1999（C99）为参照，列出 v0.8.0 编译器实际支持的内容。编译器实现了完整的 C99 集合，并覆盖了 98% 以上的常用 armcc 扩展；另有四个 C11 关键字
（`_Static_assert` / `_Alignof` / `_Alignas` / `_Generic`）见 4.9。

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
| VLA 可变长度数组 | 是 | `int a[n]` 运行期 VLA，通过 `IR_ALLOCA` 在栈上分配；向上取整对齐：ARM / x86_64 取 8，RV32I 取 16（psABI 要求每次调用前 sp 16 字节对齐）。RV32I 的函数只要含 `IR_ALLOCA`，尾声就先 `sub sp, s0, frame_size` 把 sp 重建回固定帧底再弹帧，否则 `return` 会从错位处读 `ra`/`s0`。门禁：`tests/run_rv_alloca_tests.py --rv-as <bin>` |
| `__packed` 非对齐访问 | 是 | 逐字节 load-and-stitch，1/2/4/8 字节全覆盖（ARM 与 RV32I）。8 字节即 `long long`/`double`：先装配低字压栈、再装配高字压栈，与对齐路径的入栈顺序一致。门禁：`tests/run_rv_packed_tests.py --rv-as <bin> [--arm-as <bin>]` |

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
| 变参 `...` | 是（四个后端都支持：ARM / RV32I 用 4 字节字槽，C / x86_64 用 8 字节槽位，见 §后端与「变参」条目） |
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

### 4.9 C11 关键字（子集）

v0.8.0 之后补上四个 C11 关键字，其余 C11 特性（`_Atomic`、`<threads.h>`、匿名结构体之外的写法等）
不在范围内。四个关键字的入口分别在 lexer（关键字表）、parser（折叠与建节点）、sema
（`_Generic` 选支）三处，下游 irgen / 全局初始化 / 各后端完全看不到它们。

| 关键字 | 支持 | 实现要点 |
| --- | :---: | --- |
| `_Static_assert(expr[, "msg"])` | 是 | 文件作用域 / 块作用域 / 结构体成员三处入口；`expr` 在解析期用 `eval_const_expr` 折叠，折不出整数常量表达式直接报错，条件为 0 时把 `msg` 打进诊断。没有 AST 节点——成功时什么也不产 |
| `_Alignof(type-name)` | 是 | 从**类型**折叠（`type_align()`），不是从表达式的默认 int；只接受类型名，`_Alignof(expr)` 报错（C11 本来也不允许） |
| `_Alignas(type-name)` / `_Alignas(const-expr)` | 是 | 非 2 的幂、非常量报错；**不弱化**自然对齐（C11 6.7.5p6）；全局走 `g_attr_align_bytes` 通路（ARM 平铺 SRAM 布局按 `align_bytes` 落位），成员改 `Type::align_override`，块作用域上限 8 字节（见下） |
| `_Generic(ctrl, T: e, ..., default: e)` | 是 | 控制表达式按 C11 6.5.1.1p2 做左值转换 + 数组退化 + 函数指示符退化；不做整型提升；无匹配无 `default` → 报错；重复 `default` → 报错；选中后 sema 里 `*node = *sel` squash 成普通表达式，irgen 另有防御分支（万一 sema 被跳过会报错而不是吐 0） |

三条**明写的限制**：

1. **块作用域 `_Alignas(> 8)` 报错**，不静默降级：帧是 `sp -= N; base = sp` 建的，AAPCS 只保证
   `sp` 8 字节对齐；要真支持 16/32/64 得改 prologue/epilogue 并处理变参序列占用 `r5` 存旧 `sp`
   的冲突。诊断文本：`block-scope _Alignas above 8 bytes is not supported (the frame is 8-byte aligned)`。
2. **`_Generic` 的关联类型不比较函数签名**：`parse_declarator` 解析 `(*fp)(params)` 时会把参数表
   保留在指针类型上（供调用点判断实参宽度，见 4.10），但类型同一性判定只比 `is_func_ptr` 标志与
   返回类型，不比参数列表。因此 `int (*)(int)` 与 `int (*)(double)` 在关联表里仍无法区分。
   `_Generic` 的匹配为此额外要求 `is_func_ptr` 标志一致（否则普通 `int *` 会匹配到函数指示符——
   这是本仓真踩过的错支）。
3. **控制表达式只对"标识符 / 一元 `*` / 一元 `&`"做函数指示符退化**：sema 是浅层解析，
   符号表里函数只存返回类型，所以退化逻辑在 `_Generic` 分支里按符号种类补做；更复杂的
   函数指示符表达式（如条件表达式两支都是函数）不在覆盖范围，会落到普通表达式类型上。

门禁：`python tests/run_c11_keywords_tests.py --arm-as <bin> [--rv-as <bin>]`，ARM + RV32I 双目标
共 30 项（11 个运行时用例 × 2 目标 + 8 个诊断用例），另含三条自检（静态断言真/假对照、
`_Alignof` 不得等于默认 4、期望值错配必须判红）。

### 4.10 复数类型（`_Complex`）

`_Complex float` 是 8 字节、`_Complex double` 是 16 字节，两者在**对象里**都是实部在前、虚部在后，
每部分按各自的浮点宽度逐字节存放（小端，所以 `double` 的实部是 `[lo, hi]` 四个字节在前）：

| 类型 | 偏移 0 | 偏移 4 | 偏移 8 | 偏移 12 |
| --- | --- | --- | --- | --- |
| `_Complex float` (8 B) | `re_f32` | `im_f32` | — | — |
| `_Complex double` (16 B) | `re_lo` | `re_hi` | `im_lo` | `im_hi` |

`sizeof`/`_Alignof` 与 gcc 一致（8/16，对齐 4/8）；静态初值（如 `double _Complex g = 3.0 - 2.0i;`）由前端
常量折叠求值后写进 `.data`，两个机器后端共用同一份填充实现。

**IR 值栈形状**：机器后端里一个复数值占 4 个 IR 字，栈顶在低地址，
`sp+0 = re_hi, sp+4 = re_lo, sp+8 = im_hi, sp+12 = im_lo`（`_Complex float` 只用其中的 re/im 槽）。
取实部/虚部、`float <-> double` 加宽、复共轭等由 `IR_AUX_COMPLEX` 系列 aux 编码在单条 IR 内完成，
不经过函数调用。

**返回值 ABI**：16 字节的 `_Complex double` **不进 sret**，直接用返回值寄存器：

| 目标 | `_Complex float` (8 B) | `_Complex double` (16 B) |
| --- | --- | --- |
| ARM (Thumb-2, 软浮点) | `r0 = re_f32`, `r1 = im_f32` | `r0:r1 = re(lo,hi)`, `r2:r3 = im(lo,hi)` |
| RV32I | `a0 = re_f32`, `a1 = im_f32` | `a0..a3 = re_lo, re_hi, im_lo, im_hi` |
| x86_64 / C 后端 | 拒绝（见下） | 拒绝（见下） |

这与 arm-none-eabi-gcc 的软浮点 AAPCS 一致（软浮点下 16 字节复合类型就是两个寄存器对），所以 arkc
编的函数与 gcc 编的库函数可以互相调用。**sret 只用于 struct/union（size > 8）**。复数选返回值
寄存器而不选 sret 的直接理由：不需要调用者为返回值准备缓冲区，于是"通过声明调用""通过函数指针
调用""跨翻译单元调用"三种形态自动全部可用——sret 下这三条都要各自的簿记，任何一条漏了就是静默
错值（struct/union 原先正是这样漏的，见下面那段）。

**实参 ABI**：C99 6.5.2.2 要求先把实参转换成形参类型。转换后若是 16 字节复数值，`irgen` 把它物化进
临时对象、只压**一个地址字**，被调方 `IR_GETARG` 见 `aux` 上标的尺寸（> 8）就按地址 `memcpy` 进帧。
两点注意：

- 8 字节的 `_Complex float` 走"两字值"，不是地址字（与 `long long` 同形）；
- 函数指针调用同样适用：`parse_declarator` 现在把 `(*fp)(参数表)` 的参数类型保留在指针类型上，
  所以 `double _Complex (*fp)(double _Complex);` 的调用知道形参是 16 字节（更早的版本把参数表当
  平衡括号跳过，这类调用会被诚实拒绝）。

**明确拒绝（宁可报错，不给错答案）**：

- x86_64 后端对复数全局对象与复数操作一律报错（`_Complex value not supported by the x86 backend`），
  不产镜像；C 后端把初值原样输出成 C 源码，交给宿主 gcc。
- 穿过 `...` 传复数：`va_arg` 只能按连续参数**字**走、被调方没有类型信息，所以调用点直接报
  `passing a _Complex value without a _Complex parameter type ...`，而不是只物化一半。
- 全局地址常量初值（函数指针、对象指针、数组/成员地址）已支持，见下面「全局地址常量初值（C11 6.6p9）」
  一节；不具该形式的初值一律报错，不写零充数。

**函数类型 typedef（`typedef Ret F(args);`）**

typedef 名记录的是真正的 `TYPE_FUNC` 类型（C99 6.7.1 + 6.7.5：声明出来的类型是"返回 Ret 的函数"），
不是一个函数。于是：

- `F *p` 是指向该函数类型的普通指针，`sizeof(F *)` 是目标指针大小；
- `F name;` 是函数**声明**——返回类型、形参表、`...` 标记、块作用域链接（C99 6.2.2p5）与调用点的
  实参转换，全都和把原型写全一样；
- `F name { ... }` 不是合法 C（6.9.1 要求定义里出现标识符声明符），报错而不是猜；
- `sizeof(F)` / `_Alignof(F)` 报错（6.5.3.4p1 禁止对函数类型取 sizeof / 对齐），不再返回默认的 4。

旧版本把 `typedef Ret F(args);` 名字后面的 `(` 交给"函数定义/声明"分支，typedef 被丢弃、名字被
登记成函数，症状是 `sizeof(F *)` 报 `expected an expression`、`F *p;` 报 `expected declaration at
top level`、`sizeof(F)` 静默返回 4。回归门禁：`tests/run_func_typedef_tests.py`（每个机器后端 10 例运行时 + 2 例"必须报错"）。


**全局地址常量初值（C11 6.6p9）**

文件作用域的指针对象可以用「静态存储期对象的地址 ± 整型常量」或函数地址初始化。实现上不把地址
烘成字节（函数地址在链接前根本不存在），而是记成 `(symbol, 字节偏移)` 三元组
（`IrGlobal.init_sym / init_sym_off / init_sym_is_func`），由后端各自发符号引用：

| 初值形态 | ARM (Thumb-2) | RV32I | 说明 |
| --- | --- | --- | --- |
| `int (*p)(int,int) = add;` | `LDR r0,=add` | `.word add` | 函数设计符 |
| `int (*p)(int,int) = &add;` | 同上 | 同上 | `&` 不改变函数地址语义 |
| `typedef int binop(int,int); binop *p = sub;` | 同上 | 同上 | typedef 的 `TYPE_FUNC` 与 `is_func_ptr` 两种表示都认 |
| `int gv; int *p = &gv;` | `MOVW/MOVT addr` | `.word gv` | 本 TU 对象 |
| `int a[4]; int *p = &a[2];` | `addr + 8` | `.word a + 8` | 按元素步长 |
| `int *p = &a[1] + 2;` | `addr + 12` | `.word a + 12` | 地址 ± 整型常量 |
| `int *p = a;` | `addr` | `.word a` | 数组退化到首元素 |
| `char c[8]; char *p = &c[1];` | `addr + 1` | `.word c + 1` | 步长按元素类型（char 为 1） |
| `struct S{int k,j;} s; int *p = &s.j;` | `addr + 4` | `.word s + 4` | 成员地址 |
| `int *p = (int*)&a[3];` | `addr + 12` | `.word a + 12` | cast 不改变地址值 |
| `int *p=&gv; int **pp=&p;` | `addr` | `.word p` | 指针对象自身的地址 |
| `static int sv; int *p=&sv;` | `addr` | `.word sv` | 静态对象 |
| `static int h(void); int (*q)(void)=h;` | `LDR r0,=h` | `.word h` | 静态函数 |

**必须拒绝的形态（已实现，均报错不产镜像）：**

- `int (*p)(int,int) = add + 1;` —— 函数类型没有步长（C11 6.5.6p2 要求指针指向完整对象类型），报
  `is an address that is not a constant expression (C11 6.6p9)`；
- `int x = f();` —— 函数调用不是常量表达式，报 `the initialiser of the global '...' is not a constant
  expression this build can place in data`（旧版会静默写 0）；
- **ARM 跨翻译单元的对象地址**（`extern int other; int *p = &other;`）——ARM 全局对象不在 ELF 符号表里，
  数据段按固定基址 `0x20000000` 顺序分配，另一个单元的对象在链接前无法命名，报 `another unit's object
  cannot be named here`。跨 TU 的**函数**地址不受此限（走 `R_ARM_ABS32` 重定位）。
- **RV32I 对象模式的「重定位 + 非零偏移」**——ARKOBJ2 的重定位表没有 addend 字段，`-c` 下
  `.word ext + 4` 报 `ARKOBJ2 relocation carries no addend; define the symbol in this translation unit`；
  汇编/flat 模式（`.s`/`-S`/直出 `.bin`）不受限，跨 TU 的 `.word ext` 本身可用。

回归门禁：`tests/run_func_ptr_global_tests.py`（16 例运行时 × 2 后端，与宿主 gcc 双校验 + 3 例"必须
报错" + 2 组跨 TU `-c`/`-link`）。

**聚合初始化器里的地址元素（C11 6.6p9）**

聚合初值里也可以放地址常量，只要**花括号逐层写全**：

| 形态 | ARM (Thumb-2) | RV32I |
| --- | --- | --- |
| `int (*tab[2])(int,int) = { add, sub };` | 每元素 `LDR r0,=add` 再 `STR` | `.word add` / `.word sub` |
| `int gv; int *pa[2] = { &gv, &gv };` | 同上（`MOVW/MOVT`） | `.word gv` |
| `struct S{int n; int (*f)(int,int); int *p;} s = {3, add, &gv};` | 按成员偏移写 | 按成员偏移分段 `.byte` / `.word` |
| `struct C t[2] = { {1, add}, {2, sub} };` | 同上 | 同上 |
| `char c[8]; char *cs[2] = { &c[1], &c[2] };` | 步长按元素类型（char 为 1） | 同左 |

实现是**两条独立推导的交叉校验**，不是重复劳动：

1. `src/irgen.c` 再走一遍 AST（`IrGlobal.init_refs`，每项 `(字节偏移, 符号, 加数, 是否函数)`），
   偏移由类型树算出；
2. `src/agginit.c` 仍按「文本 + 类型」填字节；凡读不出数字、而类型是指针或函数的元素，问后端
   hook（`ark_agg_fill_ex()` 的 `addr_hook`），后端按偏移在 `init_refs` 里查：查到就写零占位、
   随后由后端覆盖成真地址；查不到就拒绝（`cannot turn the initialiser ... into data`），
   不会把地址静默写成 0。

**指派器与 `union` 也支持**（`int *pa[2] = { [1] = &gv };`、`struct S s = { .a = 3, .p = &gv };`、
`union U u = { .p = &gv };`）：走查（`irgen_agg_addr_walk`）是**两个游标**在推偏移——数组一个
`cur`（`[k]=` 直接设 `cur=k`，每放一个值 `cur++`），结构一个 `f`（按声明顺序走，`.name` 时重定位到
该成员）——语义与填字节用的 `ark_agg_fill()` 完全一致。两处游标只要有一处不同步，hook 就会在
填字节方问到的偏移上查不到，`ark_agg_fill_ex()` 返回 -1 并拒绝，所以**偏移对账本身就是安全网**，
不会静默写零。`union` 只允许一个活跃成员（多于一个仍是拒绝），因为它只有一个偏移。

指派器的下标必须是**整型常量表达式**（C99 6.6p6），`[0 + 1]`、`[1 << 2]` 这类可以折常量；
`[i]`（变量）、`[]`（空）、`[-1]`（负）分别报 `a designator index must be an integer constant
expression` / 同上 / `a designator index must not be negative`。此处曾经只认裸字面量
（`lexer_peek(...).kind == TOK_NUM`），非字面量时 `has_index` 留 0 却仍然 `expect "]"`，
接着在错位的 token 上反复递归，最后以 `[arkcc] FATAL: memory pool exhausted` 收场——那是
崩溃级失败，违反"宁可报错"；现在的 `parse_designator_index()` 折常量失败就报一条清晰错误、
把 token 跳到 `]` 为止，初始值解析继续走，构建按 `error_count` 失败。

**必须拒绝的形态（已实现，均报错不产镜像）：**

- **自动变量的地址**：`static int *pa[2] = { &local, &gv };` —— 报 `is an address that is not a
  constant expression (C11 6.6p9)`（该信息里的对象名是内部符号名，例如 `ark_sl_main_pa`）；
- **函数 + 偏移**：`int (*t[2])(int,int) = { add + 1, sub };` —— 同上。

**字符串字面量元素也支持**（`char *cs[2] = { "xy", "cd" };`）：元素存的是字面量的**地址**，
不是它的字符。每个元素需要一个**独立**的池化字面量标签，按元素字节偏移命名——否则两个元素会
指向同一个字符串（`cs[1][0]` 读出 `'x'` 而不是 `'c'`），这种错能编译能跑、只在数值上错。

| 目标 | 标签名 | 数据侧 |
| --- | --- | --- |
| ARM (Thumb-2) | `.L_gstr_<全局号>_<偏移>` | `LDR r0,=.L_gstr_<gi>_<off>` 再 `STR` |
| RV32I | `.Lgstr_<对象名>_<偏移>` | `.word .Lgstr_<name>_<off>` |

注意标签命名沿用各后端**既有**的两套前缀（ARM 是 `.L_gstr_` 带下划线，RV 是 `.Lgstr_` 不带），
不要统一——它们分别与 `char *p = "hi";` 的标量池化字面量共用前缀，改名会撞标号。

**只收窄字符串**：`char *cs[2] = { L"xy", "cd" };` 报 `is a wide string literal; only narrow
string literals can be pooled as address constants here`——宽字面量要逐字节展宽，初值文本不携带该信息。
指派器形态（`{ [1] = "x" }`）同样支持，且**标签偏移跟着指派器走**：`char *cs[2] = { [1] = "x" };`
的池化标签是 `.L_gstr_<gi>_4` / `.Lgstr_cs_4`（偏移 4），不是 `_0`——写成 `_0` 也能汇编也能跑，
只是 `cs[1][0]` 读出错的字节，所以 RV 汇编断言专门钉了这一条。

实现上字符串元素与符号元素**共用同一张 `init_refs` 表**：每一项要么有 `sym`，要么有 `str`
（`IrSymRef.str`），后端按偏移查表时分派。这样不必新增并行表，偏移对账机制原样复用。

**函数指针数组声明符**也一并支持：`int (*tab[2])(int,int);` 的 `[2]` 写在括号内层（`(*tab[2])`），
旧版解析器在名字后直接 `expect ")"`，报 `#18: expected a ")"`；现在先解析括号内的数组维度
（只接受整型常量维，否则报 `the dimension of an array of function pointers must be an integer
constant expression`），再把外层形参表挂到指针类型上。

回归门禁：`tests/run_agg_addr_tests.py`（32 例运行时 × 2 后端，与宿主 gcc 双校验，其中 9 例是花括号省略；
8 例"必须报错"；
3 例 RV 汇编断言：`.word add`/`.word sub`、字符串例必须同时出现两个 `.asciz` 与两条不同的
`.word .Lgstr_cs_<off>`、指派器例必须是 `.word .Lgstr_cs_4`——防"把地址折成数字"、"两个元素共用
一个标签"、"下标读了却没落到偏移上"这三种能跑但错的假绿。末尾 SELFCHECK 对 `fp_array`（46）、
`str_ptr_array`（240）、`ptr_designator`（0）、`ptr_designator_gap`（17）各验一次"错答案会被判据逮住"）。

**花括号省略（brace elision，C99 6.7.9p20）已支持**

内层的花括号可以省，值按展平后的布局依次填：

| 形态 | 结果 |
| --- | --- |
| `int a[2][2] = {1, 2, 3, 4};` | `a[1][1] == 4`（放满一行后游标要回卷到下一行） |
| `struct T { int a, b; } t[1] = { 1, 2 };` | `t[0].b == 2` |
| `struct T { int *p, *q; } t[1] = { &gv, &gv };` | 两个成员各得一个地址 |
| `char m[2][6] = { "ab", "cd" };` | 一行一个字符串（字符串本身就是一个元素） |
| `int x = { 5 };` | 标量的冗余花括号（C99 6.7.9p11） |
| `int a[][2] = { 1, 2, 3, 4 };` | 推出 2 行（按"每个元素几个值"推，不是按 item 个数） |
| `struct B { int a:3, b:5; } x = { 1, 2 };`（块作用域） | `a==1`、`b==2`（位域走 `IR_STORE_FLD`） |

三处走查必须同时改，缺一处就变成"某些形态能过、某些报错"：

- `src/agginit.c`（全局数据，文本驱动）、`src/irgen.c` 的两条 AST 走查（全局地址元素 `AaggWalk`、
  块作用域 `LocalAggWalk`）都是**每层一个游标 + 子对象填满就把剩余值交还调用方**：满了 `return`
  （不是报错），由拥有右花括号的那一层检查"没吃完的值"。写成 `return -1` 会让
  `int a[2][2] = {1,2,3,4}` 在第二行处误报；写成"继续吃下一层的值"则会把 3、4 写进 `a[0]`。
- 结构分支 `if (!f) return;`（非花括号的 run 交还调用方）与块作用域
  `if (!braced) return;` 是同一条规则的两种写法；局部侧此处若改成 `w->i++` 继续，就会把调用方的
  值吃掉，`t[0].b` 得 0。
- `ark_agg_object()` 里字符串只在**元素类型是数组**时才当作"自带一层花括号"；无条件短路会让
  `struct S { char n[4]; } s[] = {"ab"}` 以"缺花括号"失败。
- `walk` 里遇到字符串元素要**跳过但不 bail**（字节归 `ark_agg_fill`），否则"同一聚合里既有字符串
  又有地址"的用例就记录不到地址。
- 块作用域的字符串初始化展开成 `memcpy` 调用，所以门禁启动（`examples/run_va_gate.py` 的
  `ARM_START` / `RV_START`）必须提供 `memcpy`——缺它这类用例在链接期就失败，等于从来没被测过。

仍拒绝的边界（报错不产镜像）：

- **指派器 + 省略花括号**：数组顶层 `int a[2] = { [0] = 1, 2 };`（gcc 也拒）；
- **字符串与裸标量混在同一 struct 元素、且数组维度未给**：`struct S { char n[4]; int *p; } s[] =
  {"ab", &gv};` —— 一个元素消耗几个值取决于字符串落在哪个成员，猜错就是 `sizeof` 错，宁可报错；
- **标量给了多个值**：`int x = { 5, 6 };` 报 `has too many values: a scalar takes exactly one`
  （块作用域同）；`double _Complex z = {3.0, 4.0};` 报 `is a scalar; '{re, im}' is not a
  brace-elided form` —— 标量初值只能是一个表达式，GCC 只警告并丢掉虚部，这个错答案不照抄；
- **数组／结构给了多余的值**：块作用域以前**静默丢弃**多余元素、没有任何诊断；现已改为
  GCC 风格的警告 `excess elements in the initialiser are ignored: the array holds only 2`
  （结构体为 `the object holds only N`），只警告一次、`rc=0`，**写入的字节不变**（新增诊断代价
  官方计账：宿主 `text 556 740 → 557 100`，H743 固件 `text 438 812 → 439 060`）。
  全局 `int a[2] = {1,2,3}` 仍报 `cannot turn the initialiser ... into data`
  （诊断正确但不是最贴切的文案，属已知项）。

**struct/union（> 8 字节）返回值：两个机器后端都走 sret（隐藏缓冲指针）**

| 目标 | 谁开缓冲 | 传入 / 回传 | 实参起点 | 栈上实参 |
| --- | --- | --- | --- | --- |
| ARM (Thumb-2, 软浮点) | 调用者帧（`r6` 相对偏移） | `r0` 传入、`r0` 回传 | `r1` | 不移位 |
| RV32I (psABI) | 调用者帧 | `a0` 传入、`a0` 回传 | `a1` | 整体后移一个字 |

缓冲**每个调用站点一块**，不是每函数一块、也不是一块共用：`f(mk(1), mk(2))`、
`struct S a = f(), b = g();`、`mk(1).field` 都要求同时有多个结果活着；共用一块会让后一个
覆盖前一个，而把缓冲放在 `sp` 以下又会被被调方自己的帧踩掉。每块按 **8 字节对齐**——被调方
可能用 `STRD` 存 `double`/`long long` 成员，未对齐地址在 ARMv7-M 上直接 fault。

**调用站点是不是 sret，由 `IR_CALL` 的 `val` 位决定**：bit 36 = 该调用返回 struct/union 且
`size > 8`；bits 37..52 = 载荷字节数（> 0xFFFF 在 `irgen` 报错，不静默截断）。这些位是 `irgen`
从**调用表达式的类型**盖的（C99 6.5.2.2：调用表达式的类型就是被调函数的返回类型），所以
三种"调用点看得见、定义看不见"的形态自动都对：

- 只有声明、定义在**另一个翻译单元**；
- 通过**函数指针**调用（被调方名字在调用点根本不存在）；
- 只在前向声明里出现过、从未在本单元定义。

这条通路取代了 ARM 后端原先"扫描本翻译单元的函数定义、建名字表、按名字查"的做法。查表对上面
三种形态全部落空，于是它们被当作 AAPCS 默认（**不带**隐藏指针）发出去，而被调方按 sret 往 `r0`
写——实测跨 TU 的 `tu1.s` 里 `BL mk` 前面没有任何 `ADD r0, r6, #N`，`r0` 里装的是第一个实参 `3`。
RV32I 早先的做法更隐蔽：把**被调方帧里的地址**放进 `a0`。单线程下调用者紧接着就 `memcpy`
出去，被调方那段栈还没被复用，实测能对（`struct S{a,b,c}` 返回 345，掩码后 89）；但被调方
`ret` 之后这个地址已经失效，**一旦有中断/信号复用同一段栈就读到脏值**。这条欠账已按 psABI
实现并撤账。

上限与诊断：每个函数最多 64 个 sret 调用站点（`sret_call_buf_off[64]`），超了报
`sret call sites ... at most 64` 而不是悄悄少开一块缓冲。复数不走这条通路（它用返回寄存器
`r0/r1/(r2/r3)` 或 `a0..a3` 直接回传）。

门禁：
- `python tests/run_rv_sret_tests.py --rv-as <bin>` —— 13 例 RV32I 真跑（0/4/9 个实参、
  by-value 入参、`f().m`、`f(g(),k())`、递归、变参、函数指针、同深度栈复用、160 字节载荷）
  + 期望值自检；
- `python tests/arm_exec/run_arm_exec.py --selfcheck` —— ARM 真跑，其中
  `sret_cross_tu` / `sret_indirect` / `sret_live_results` / `sret_recur` 四例专盯上表。
  每个用例都会再用 `--reg-top` 重编一遍，值必须不随代码路径变。

门禁：`python tests/run_complex_tests.py --arm-as <bin> --arm-libgcc <libgcc.a> --rv-as <bin>`，
38 个用例 × 2 目标（ARM 与 RV32I 各自 as→链接→unicorn 真跑，比的是**运行退出码**而不是"有没有报错"）。
软浮 helper（ARM `__aeabi_f2d`/`__aeabi_d2f`，RV `__extendsfdf2`/`__truncdfsf2`）来自 libgcc，**必须链运行库**。
裁剪档门禁：`python tests/run_complex_gate.py --arkcc <全量二进制> --arkcc-off <ARKCC_FEATURE_COMPLEX=0 的二进制>` ——
同时验"全量接受 / 裁剪档带原因地拒绝 / 裁剪档照收普通 C / 不含 `_Complex` 的源两档汇编逐字节相同 / `-fno-complex` 报错"。

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
- `assemble`：把文本汇编编码为机器码。c/riscv32 后端直接透传汇编文本交给主机工具链；`x86` 后端走自己的编码器（`%N` 操作数会被拒绝）。
- `link`：跨函数符号重定位（ARM 后端用它回填 `BL` 偏移）。

### 5.2 已实现的后端

| 后端 | 目录 | 入口符号 | 主要用途 |
| --- | --- | --- | --- |
| `arm` | [src/backend/arm/](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/backend/arm) | `ark_backend_arm()` | STM32 Cortex-M3/M4/M7/M33（Thumb-2），完整 DWARF + TLS + Scatter |
| `x86` | [src/backend/x86_64/](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/backend/x86_64) | `ark_backend_x86_64()` | i386（32 位、cdecl）GAS 汇编；`-target` 亦接受 `x86_64`/`x86-64`/`x86_64-msvc`/`x86-msvc`/`i386`/`i686` |
| `riscv32` | [src/backend/riscv32/](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/backend/riscv32) | `ark_backend_riscv32()` | 生成 RV32I 汇编（GAS） |
| `c` | [src/backend/c/](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/backend/c) | `ark_backend_c()` | IR -> 可读 C 源码（主机测试主路径） |

注册表：[src/backend/registry.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/backend/registry.c)。新增后端只需在此增加一行注册。别名（`g_backend_aliases[]`）只在精确匹配失败后回退解析，不额外占用注册位，因此 `--list-backends` 每个后端仍只出现一次，并把该后端的别名打在 `aliases:` 行里。

### 5.3 选择后端

```powershell
.\arkcc.exe --list-backends
.\arkcc.exe foo.c -target x86 -S -o foo.s
.\arkcc.exe foo.c -target x86_64 -S -o foo.s      # 别名，等价上一行
.\arkcc.exe foo.c -target riscv32 -S -o foo.s
.\arkcc.exe foo.c -target c -S -o foo.gen.c
```

`--list-backends` 同时打印每个后端的别名，例如：

```
Available targets:
  arm        armv7m-thumb2-eabi
    aliases: thumb, thumb2, cortex-m
  x86        i386-pc-linux-cdecl
    aliases: x86_64, x86-64, x86_64-msvc, x86-msvc, i386, i686
  riscv32    riscv32-unknown-elf
  c          host-c-source
```

未知后端名直接 `exit 1` 并打印 `[arkcc] unknown target '...'`。

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
- ✅ 按段名查找执行地址（`scatter_lookup_addr`、`scatter_get_er_base_for_section`）
- ✅ **scatter 感知链接**：`-link` 模式解析 `.sct`/`.ld` → 提取 flash_base/initial_sp → 生成 256 条目 Cortex-M 向量表 → 移动代码 → 调整符号/重定位偏移
- ✅ 单文件 `.bin` 模式：`arm_link()` 实现向量表生成与偏移调整
- 命令行：`--scatter <file>`、`-T <file>`、`--linker-script <file>`、`--script <file>`、`--uvprojx <file>`

**实际段放置由谁负责？** 在 armcc5 路径下由 armlink 负责（通过 `--scatter=<sct>` 选项），arkCC 只输出汇编/对象代码。在自托管路径下（STM32 板上运行 arkCC，`-link` 模式或单文件 `-c`/`-o .bin`），arkCC 自身的 `arm_link()` 解析 scatter 文件，生成 Cortex-M 向量表并完成符号/重定位偏移调整，机器码放入 `.ark_code` 段由 scatter 文件路由到 AXI SRAM。

### 5.6 汇编文件（`.s`/`.S`/`.asm`）输入

arkCC 可直接编译 `.s`/`.S`/`.asm` 汇编文件为机器码，ARM 后端有完整的 Thumb-2 文本汇编器（`arm_assemble()`）：

```powershell
.\arkcc.exe startup.s -target arm -o startup.bin
.\arkcc.exe myfunc.S -target arm -c -o myfunc.ark_obj
.\arkcc.exe main_asm.asm -target arm -o main_asm.bin   # armasm / MSVC 写法，等价
```

**触发规则**：由文件扩展名决定，接受 `.s`、`.S`（传统写法）以及 `.asm`、`.ASM`（armasm / MSVC 写法），扩展名大小写不敏感，判定逻辑集中在 `is_asm_input()`（`src/compiler.c`）。命中后跳过前端流程（preproc/lex/parse/sema/irgen），直接调用 `be->assemble()`。

**汇编器能力**：两遍汇编 + 重定位，识别 `.thumb`/`.thumb_func`/`.global`/`.section`/`.text`/`.data`/`.bss`/`.type`/`.size`/`.word` 等伪指令，并把 Thumb-2 指令编码为 16/32 位二进制。

**与 `-S` 的区别**：`-S` 是**输出**模式（生成汇编文本），而 `.s` 文件输入是"汇编→机器码"路径。若同时给 `.s` 输入加 `-S`，则原样输出汇编文本（相当于 copy）。

**汇编错误不静默**：遇到未知助记符、非法寄存器操作数、无法编码的立即数时，汇编器打印 `[asm-arm] error: ...` 并以非 0 退出，**不写出任何产物**（仅内部发 NOP 占位以继续扫描后续行，避免一次只报一个错）。这样"汇编通过"不会变成一句空话。

### 5.7 对象格式（`-c` / `-link`）

`-c` 产出 ARKOBJ2 容器：`"ARKOBJ2\n"`(8B) + u32 代码长度 + 代码体 + u32 符号数 + 符号（name_len/name/offset/type/weak）+ u32 重定位数 + 重定位。C 源和汇编源都走这一个写出函数，因此两条路径的对象格式完全一致。

`.c` 与 `.s` 两种输入在 `-c` 下产出的对象可直接混合交给 `-link`：

```powershell
.\arkcc.exe a.c     -target arm -c -o a.ark_obj
.\arkcc.exe b.s     -target arm -c -o b.ark_obj
.\arkcc.exe -link a.ark_obj b.ark_obj -target arm -o ab.bin
```

链接期三条口径：

1. **每个翻译单元各自放置自己的 `.data`/`.bss`**，对象尾部用保留符号 `__arkcc_ram_start`/`__arkcc_ram_end`（`type=2`，值是绝对地址）声明本单元占用的 SRAM 窗口。旧读者忽略符号表尾部这两条即可，头部格式不变。
2. **两个对象都带 RAM 窗口时直接报错**：数据区不参与重定位，`[start,end)` 一旦重叠就打印 `[link] error: SRAM overlap between objects #i and #j` 并 `exit -8`，不产出镜像——因为静默出图会得到一个"两套全局变量压在同一个地址"的错误二进制。只有一个对象带 RAM（或都不带）时可以正常链接。
3. **编译器私有运行时符号（名字以 `__` 开头，如 `__aeabi_*`）的重复定义静默合并**，链接结束打印一行 `[link] note: N duplicate compiler-runtime symbols merged`；用户符号的同名强定义仍逐条告警。

### 5.8 多对象链接的基址契约（`--reloc-data` / `--reloc-text`）

arkc 把 `.data`/`.bss`/`.rodata` 的**绝对地址烤进指令流**（`MOVW`+`MOVT`），所以一个
对象只对它编译时假定的那份布局成立。多对象链接的正确姿势因此不是"随手编、链接器搞定"：

```sh
# 每个对象都按同一份 .sct 编（数据基址 = 该 .sct 的 +RW 区）
.rkcc.exe a.c -target arm --scatter app.sct --reloc-data --reloc-text --vector-table -c -o a.obj
.rkcc.exe b.c -target arm --scatter app.sct --reloc-data --reloc-text -c -o b.obj
# 链接：--reloc-data 把 b 的数据窗口挪到 a 之后并改写 b 的地址；
#       --reloc-text 逐个对象修正段内绝对地址（字符串字面量等）
.rkcc.exe -link a.obj b.obj -target arm --scatter app.sct --reloc-data --reloc-text --vector-table -o app.bin
```

两条开关都是"**编译期记录站点 + 链接期按 delta 改写**"，关掉时产物逐字节不变（即旧行为）。

- `--reloc-data`：让**第二个及以后**的对象各自占一段 SRAM（8 字节对齐接在前一个之后），
  把它的 `.data`/`.bss` 地址改成新基址；同时把各对象的 `__arkcc_init_globals` **串成一条链**
  ——否则同名符号合并只留第一份，后面对象的初值永远不会被写进去（症状是全局变量停在 0，
  程序算出一个错答案却不报错）。
- `--reloc-text`：逐个对象修正在代码段内部、指向**自己这段代码/只读数据**的绝对地址。
  第一个对象保持原基址，所以单对象链接不受影响。

**基址一致是有守卫的**：如果对象声明的 SRAM 窗口落在 scatter 的 `+RW` 区之外——典型情形是
编译时忘了带 `--scatter`，还停在默认的 `0x20000000`——`-link` 不再出图，而是报

```
object #0 puts .data/.bss at 0x20000000 but the scatter file puts RW at 0x24072000: ...
```

这条错误值钱：它对应的坏镜像在实机上表现为第一次写全局就 `CFSR=0x82`（`DACCVIOL`）、
`MMFAR=0x20000000`。**只在只有一个对象带 RAM 时**它才抓得到（两个对象都带时，重叠检查
本来就会先报错），恰好是最容易漏的一种。

板端 `cc` 的默认值跟着命令行走：只要出现 `-link` 或 `--scatter`，`--reloc-data` /
`--reloc-text` 默认**打开**；`--no-reloc-data` / `--no-reloc-text` 退回旧输出。

### 5.x 平铺镜像的 64 位/AEABI 运行时要自己链

后端把 64 位加/减内联成 `ADDS`/`ADC`、`SUBS`/`SBC`（不依赖运行库），其余 64 位运算（`*`、`/`、`%`、`<<`、`>>`、比较）发射标准 AEABI 符号（`__aeabi_lmul`、`__aeabi_ldivmod`、`__aeabi_uldivmod`、`__aeabi_llsl`、`__aeabi_llsr`、`__aeabi_lasr`、`__aeabi_lcmp`、`__aeabi_ulcmp`）。**编译器不会隐式把这些实现塞进镜像**，平铺镜像要自己链：

```sh
./arkcc -target arm -c stdlib/src/arm/aeabi.c          -o aeabi.obj
./arkcc -target arm -c stdlib/src/arm/aeabi_divmod.s   -o aeabi_div.obj
./arkcc app.c -target arm -c --vector-table -o app.obj
./arkcc -link app.obj aeabi.obj aeabi_div.obj --vector-table -o app.bin
```

`aeabi_divmod.s` 必须是汇编：`__aeabi_ldivmod`/`__aeabi_uldivmod` 要返回四个寄存器（商 `r0:r1`、余 `r2:r3`），而 `__value_in_regs` 在本编译器里只做解析、不参与 codegen。除零返回 0；移位计数 ≥ 64 返回 0（算术右移按符号填充）——都是显式约定，不会给出随机值。

代价口径：`udivmod64` 是 64 次 restoring 除法，实测**一次 64 位除法约 12.8k 条指令**（`shift64` 整例 9.26M 条）。这是"正确优先"的选择，不是缺陷；需要性能时应避免在内层循环里做 64 位除。

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

**仓库里的六套门禁**（都是可直接重跑、失败即非 0 退出的脚本；数字是 2026-11-02 的实测值）：

| 门禁 | 覆盖什么 | 判据 | 实测 |
| --- | --- | --- | --- |
| `run_full_test.ps1` | 73 个样例 ARM 发射 + C 后端执行 | 每个样例的退出码不得为负（崩溃），并自检 IR 生成门 | `PASS=73 FAIL=0 CRASH=0`，`SELFCHECK irgen-gate: OK` |
| `examples\run_tests.ps1` | 75 个样例的 ARM 发射 + C 后端执行 | 退出码必须等于样例头部 `Expected exit code: N`；skip 与 pass 分开计数 | `asserted pass 71 / failed 0 / skipped 4` |
| `run_asm_test.ps1` | `.s/.asm` 输入路径 | 产物尺寸 + ARKOBJ2 头 + 与 armasm 黄金字节逐字节相同（含 `BKPT` 与三操作数 `MUL`）+ 未知助记符与三寄存器 `MUL` 都必须失败 | `pass=17 fail=0` |
| `run_tests_x86.ps1` | `x86` 后端 | emit 成功、GAS 语法接受、别名逐字节等价、三条负向对照 | `pass=158 fail=0 skip=0` |
| `run_link_test.ps1` | `-c` + `-link` 多对象 | ARKOBJ2 头、RAM 描述符、**输出不是原始对象拼接**、镜像长度 == 两对象代码长度之和、重叠必须报错且不留产物 | `pass=17 fail=0` |
| `run_arm_exec_test.ps1` | ARM **执行级**（编译→链接→QEMU 真跑） | 向量表 SP/reset 向量合法（reset 向量必须带 Thumb 位）、两个不同负载分别返回 8 与 3、负向对照必须被拒；QEMU 缺失时 `exit 2` | `pass=13 fail=0` |

### 6.2 无硬件情况下验证 ARM 后端

**本机可用的验证手段**（开发机上没有 `arm-none-eabi-*`，WSL 也被禁用；QEMU 需另行安装，见第 4 层），所以 ARM 侧靠以下四层，全部是仓库内可重跑的门禁：

1. **汇编层冒烟**：`examples/run_tests.ps1` 对每个样例跑 `-target arm -S`，只要后端发不出汇编就算失败。
2. **汇编码逐字节取证**：`run_asm_test.ps1` 里内置一段 22 条指令（TST/CLZ/SXTB/SXTH/UXTB/UXTH/SVC/MOVS/SADD16/BKPT/MUL，含高寄存器形式）在 armcc5 `armasm` 上取到的**黄金字节串**，要求 arkCC 的二进制输出与之逐字节相同。取证方法（可复现）：

```powershell
# Keil 装在 D:\Keil_v5（不是 C:\Keil_v5）；AREA 行不要写 THUMB 属性，
# thumb 由命令行 --thumb 决定，否则报 A1221E。
& "D:\Keil_v5\ARM\ARMCC\bin\armasm.exe" --thumb --cpu Cortex-M4 ref.s -o ref.o
& "D:\Keil_v5\ARM\ARMCC\bin\fromelf.exe" -c ref.o    # --bin 对 ET_REL 不产出文件
```

   `fromelf -c` 反汇编清单的 hex 列就是黄金字节（小端半字序）。该校验**不依赖**本机是否装 Keil，因为黄金字节已固化在脚本里。
3. **汇编输入门禁**：`run_asm_test.ps1` 同时验证 `.s` 输入的产物尺寸、ARKOBJ2 头、以及"未知助记符必须大声失败"（负向对照）。
4. **执行级验证**：`run_arm_exec_test.ps1` 把三个对象（C 启动代码 / 汇编 semihosting 陷门 / C 工作负载）用 `-c` 编译、`-link --scatter` 链接成裸镜像，再交给 `qemu-system-arm` **真的跑起来**，工作负载结果由 semihosting 退出码取回。判据是向量表合法（SP=0x20040000、reset 向量带 Thumb 位）加两个**不同**负载分别返回 8 与 3（常数或忽略退出码都过不了），外加一条负向对照（拿 9 去比必须被判失败）。QEMU 缺失时脚本 `exit 2` 并打印 `SKIP cannot verify`，不会静默变绿。

```powershell
$env:ARKCC_QEMU = 'D:\qemu\mingw64\bin\qemu-system-arm.exe'   # 或者用 -Qemu 参数
powershell -ExecutionPolicy Bypass -File run_arm_exec_test.ps1
```

**QEMU 侧的四个硬事实**（本轮实测或查源码确认）：

- MSYS2 的 `qemu` 包**只有** `qemu-system-*`，没有用户态 `qemu-arm.exe`。裸机执行级验证本来就要 system 模式，`-machine mps2-an385`（Cortex-M3，代码基址 0）足够：`-kernel <raw.bin>` 把裸二进制放到 0，配 `-nographic -semihosting-config enable=on,target=native`。
- **Cortex-M 的 semihosting 陷阱是 `BKPT 0xAB`，不是 `SVC 0xAB`**：QEMU 只在 `!ARM_FEATURE_M` 时把 SVC 交给 semihosting，M-profile 走 `trans_BKPT` 的 `imm==0xab`（`target/arm/tcg/translate.c`）。夹具 `tests/arm_exec/sh_call.s` 因此用 `BKPT 0xAB`。
- **向量表里的地址必须置 Thumb 位**：异常入口从向量 bit0 装载 EPSR.T，偶数地址进 INVSTATE UsageFault 直接 lockup。真实 STM32 的向量表本来也是奇数地址，所以这条修在编译器里（`arm_link()` 与 `ld_build_vector_table()` 两处），不是修在夹具里。
- 退出码用 `SYS_EXIT_EXTENDED(0x20)` + `{reason=0x20026, code}`；`SYS_EXIT(0x18)` 在部分版本上会退化成 0，不能用。

**这一层抓到的三个编译器缺陷**（都已修复，回归已进对应门禁）：① 向量表未置 Thumb 位——任何真实板子都启动不了；② 汇编器 `SVC`/`BKPT` 遇到不带 `#` 的立即数（`SVC 0xAB`）静默编成 0；③ 汇编器 `MUL` 只解析两个操作数，`MUL r2, r2, r1` 被编成 `MUL r2, r2, r2`，使**所有整数取模都算成 q\*q**（`308 % 61` 返回 27 而不是 3）。

**仍是缺口**：没有 STM32 硬件，所以"板载产物烧回 Flash 再跳转执行"这一层未验；x86 侧仍不跑程序（MinGW `gcc -m32` 只能汇编不能链接），见 6.3。

### 6.3 测试 x86 / RISC-V 后端

`x86` 后端产出的是 **i386（32 位）cdecl** GAS 汇编，不是 x86-64：

```powershell
.\arkcc.exe foo.c -target x86 -S -o foo.s
gcc -m32 -c foo.s -o foo.o    # 只校验 GAS 是否接受（本机 MinGW 没有 32 位 CRT，无法链接执行）
```

`-target x86_64` 是同一后端的别名（历史名字），字节输出完全相同——`run_tests_x86.ps1` 里有逐字节等价断言。

**执行级验证的缺口**：MinGW 的 `gcc -m32` 只能汇编不能链接（缺 32 位 crt 与 `_main`/`_printf` 前缀），所以 x86 侧不跑程序。`run_tests_x86.ps1` 用四段替代判据：emit 成功、GAS 语法接受、别名逐字节等价、三条负向对照（含内联汇编 `%N` 必须被拒）。这是"能保证语法与结构正确"，不是"能保证执行正确"。

```powershell
.\arkcc.exe foo.c -target riscv32 -S -o foo.s
riscv32-unknown-elf-gcc foo.s -o foo.elf    # 需自行安装对应工具链，本机未装
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
- **ArkCC/Core**：`..\..\src\compiler.c` `lexer.c` `parser.c` `sema.c` `ir.c` `irgen.c` `ast.c` `type.c` `symtab.c` `memory.c` `preproc.c` `codegen_common.c` `cpu.c` `scatter.c` `config.c` `opt.c` `diag.c` `diag_msg_table.c`
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
   cd "<ark-cc-repo-path>"
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
| [include/diag.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/diag.h) | 诊断层接口（各阶段只 include 这一个头） |
| [src/diag.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/diag.c) | 诊断排版：风格 / 源码回显 / caret / 汇总 / 抑制 / 上限 |
| [src/diag_msg_table.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/diag_msg_table.c) | 码 → 消息模板表（**生成物**，见 `tools/gen_diag_table.py`） |
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
2. 修改 `platform_<myplat>.c` 中的输出实现，改为目标平台的 UART/syscall
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

### 9.5 armcc 兼容扩展（v0.8.0 完整清单）

v0.8.0 覆盖了 armcc 5 常用扩展的 98% 以上。下表列出全部支持项。

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
| `stdarg.h` | `va_list va_start va_arg va_end va_copy ark_va_arg_d`。两套走法由驱动注入的宏选择：C / x86_64 是 8 字节槽位（`long long *`，按实参序号）；ARM / RV32I 是 4 字节字槽（`unsigned int *`，按 AAPCS 参数字），其中 ARM 在 64 位实参前把指针取整到 8 字节吃掉对齐空洞，RV32I（`__ARK_VA_PACKED_WORDS`）没有空洞所以不取整。`_ark_va_ptr` 这两个后端都不定义成变量，而是在引用处直接算帧地址 |
| `string.h` | `strlen strcmp strcpy strncpy memset memcpy memmove` |
| `stdio.h` | `printf puts putchar` |
| `stdlib.h` | `abort exit malloc free`（声明） |
| `math.h` | `sin cos sqrt pow fabs floor ceil fmod` + `M_PI` 等常量（实现在 `stdlib/src/math.c`） |
| `setjmp.h` | `jmp_buf setjmp longjmp`（ARM 实现是 `stdlib/src/arm/setjmp.s`：真 Thumb-2 函数，`jmp_buf[0..7]=r4-r11`、`[8]=sp`、`[9]=lr`；C 包装做不到，因为包装里拿到的 sp/lr 是自己那一帧。`stdlib/src/setjmp.c` 只是宿主测试的可移植简化实现，转发给宿主 `<setjmp.h>`） |

> `c` 后端下，这些函数直接路由到主机 libc；`arm` 后端下，需要在 STM32 用户代码中提供实现，或链接 newlib-nano，或直接使用 `stdlib/src/` 中的实现源码。

---

## 11 常见问题

**Q1：为什么 `-target c` 输出的 `.gen.c` 不是好看的人类代码？**
A：c 后端是从 IR 翻译，而不是从 AST；它追求的是"语义等价"，而不是"美观风格"。它非常适合做回归测试。

**Q2：Windows 上没有 gcc，还能运行 arkcc 吗？**
A：构建 arkcc 本身需要 gcc / MinGW / MSVC。若使用 MSVC，需修改 Makefile 使用 `cl.exe`。VS Code + clangd 也是常见选择。

**Q3：能编译用 Keil/MDK 写的 STM32 工程吗？**
A：v0.8.0 已覆盖 armcc 常用扩展的 98% 以上。HAL/CMSIS 中常见的 `__attribute__`、`__packed`、`__align`、内联汇编、`#pragma pack/anon_unions/location/...`、`__irq`/`__weak`/`__naked` 等均已支持。**armcc5 路径已打通**：`build_stm32_armcc.ps1` 可用 armcc 5.06 直接编译 arkCC 源码生成 `arkcc_stm32.hex/.bin` 烧录到 STM32H743（见 [附录 D](#附录-darmcc5-工具链与-mdk-构建详解)）。少数极端的宏戏法或 C++ 模式仍不支持；建议先用官方编译器编译 HAL/CMSIS，再用 arkcc 编译应用层代码。

**Q3.1：arkCC 能解析 MDK 的 .sct 文件吗？**
A：能解析、互转（`.sct` ↔ `.ld`）并**参与实际段放置/链接**。在 armcc5 路径下，段放置由 armlink 根据 `.sct` 完成（见 [5.5](#55-scatter-描述文件) 与 [附录 D.5](#d5-sct-文件与-armlink)）。在自托管路径下（STM32 上跑 arkCC，`-link` 模式或单文件 `-c`/`-o .bin`），`arm_link()` 解析 scatter 文件，提取 flash_base/initial_sp，生成 Cortex-M 向量表并调整符号/重定位偏移（见 [5.5](#55-scatter-描述文件)）。

**Q3.2：arkCC 能编译 .s 汇编文件吗？**
A：能。ARM 后端有完整的 Thumb-2 文本汇编器（`arm_assemble()`）。由文件扩展名触发：`.s`/`.S`/`.asm`/`.ASM` 都会被识别为汇编输入，跳过前端流程直接汇编为机器码（详见 [5.6](#56-汇编文件ssasm输入)）。

**Q4：如何让编译出的程序在 STM32 上调用 HAL？**
A：通过外部声明 + 链接重定位。编译后的代码声明 `extern void HAL_Delay(uint32_t)`；运行时 ARM 后端链接器把 `BL HAL_Delay` 的目标地址回填为 HAL 函数的实际地址（需要提供地址表）。更简单的做法：把这些函数地址硬编码到一个数组里，让 arkcc 通过函数指针调用。

**Q5：ARM 后端会使用 FPU 吗？**
A：会。使用 `--fpu=hard`，或在 `arkcc.cfg` 中设置 `fpu_hw=1`，ARM 后端会直接输出 VFP 指令（`VADD/VMUL/VCVT/VCMP`），替代 `__aeabi_f*`/`__aeabi_d*` 软浮点桩；默认情况下使用软浮点桩以兼容不带 FPU 的 Cortex-M3。`double` 始终为真正的 64 位精度。

**双精度的 `double`↔`float` 转换另受 `-mcpu` 控制**（与 `--fpu` 无关）：`-mcpu Cortex-M7` 说明目标有 VFPv5-D16，转换直接发 `VCVT.F64.F32`/`VCVT.F32.F64`；不说明 CPU 时发 `BL __aeabi_f2d`/`BL __aeabi_d2f`，需要运行库提供这两个符号。在没链 libgcc 的裸机小程序上，后者会在链接期报 `unresolved symbol "__aeabi_f2d"`——补 `-mcpu` 而不是补软浮 helper（见 [3.2](#32-目标-cpu-选择)）。

**Q6：编译大文件时报 "out of memory" 怎么办？**
A：Bump 分配器默认 256 KB。可增大 [include/memory.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/memory.h) 中的 `ARK_POOL_SIZE`；或在 STM32 侧把 `.ark_heap` 段扩大到 128 KB+（注意 H743 AXI SRAM 总容量为 512 KB）。

**Q7：能像 GCC 一样跨翻译单元链接吗？**
A：能，只是对象格式是自有 ARKOBJ2，不是 ELF。`-c` 出对象，`-link a.obj b.obj` 做符号合并、跨对象分支回填、`--reloc-text`/`--reloc-data` 的地址改写与多对象 SRAM 重叠检查；RV32I 侧同样有 `-c`/`-link`。仍不支持的是直接喂 ELF `.o`（那要走 `arm-none-eabi-ld`），以及 RV32I 的跨对象分支与跨 TU 函数指针全局初始化器（会明确报错）。详见 5.7 / 5.8 与 [12 已知限制](#12-已知限制)。

**Q8：DWARF 调试信息能被 GDB/LLDB 识别吗？**
A：v0.8.0 已输出完整的 DWARF 段（`.debug_info`/`.debug_abbrev`/`.debug_line` + `.file/.loc/.cfi_startproc/.size`），可通过 `--dwarf2` 或 `--dwarf3` 选择版本。基本的行级调试可被 GDB 识别；变量值查看（`-print var`）暂未完全支持。

**Q9：`__packed` 指针真的做非对齐访问吗？**
A：是的。`__packed` 指针（如 `__packed int *p`）会生成逐字节 load-and-stitch 代码，正确处理非对齐地址，1/2/4/8 字节都覆盖（ARM 与 RV32I 都做全 8 字节——早先 ARM 对 8 字节只搬低 4 字节，是静默短值，已修）。违反对齐的普通指针属未定义行为。

**Q10：如何自举验证编译器？**
A：项目提供 `bootstrap_build.ps1` 自举脚本：用 arkcc 编译自身 24 个源文件为 `.gen.c`，再用 gcc 编译为 `.o` 并链接得到 `arkcc_bootstrap.exe`；随后可继续用 `arkcc_bootstrap.exe` 编译一次自身，形成 bootstrap13/14/15 三代稳定自举。v0.8.0 已通过完整三代自举验证。

---

## 12 已知限制

v0.8.0 已实现完整的 C99 集合 + 98% 以上的 armcc 常用扩展，仅剩以下限制：

### 完全不支持

- **C++ 模式**（`--cpp`）：本项目是 C99 编译器，不解析 `class`/模板/异常等 C++ 语法。
- **自动向量化**（`--vectorize`）：无 SIMD 指令自动识别与重排。

### 实验性（默认关闭）

- **寄存器分配**：栈式 IR 目前默认为每个变量一个栈槽；实验性线性扫描寄存器分配器可通过 `opt_regalloc=1` 启用，默认关闭以保稳定。；ARM 侧的两条帧规则：保存块是帧几何的锚点——保存块变宽时 `[r6, #N]`（N ≥ 局部区上界）与 `MOVW/ADD r6` 的立即数必须同步平移，且保存块宽度保持 8 的倍数（奇数个自动补一个空闲 `r8-r11`，零字节代价），否则变参函数读 `r0-r3` 镜像与调用者栈参数会整体错位；`examples/run_va_gate.py --opt-suite` 一次跑完五档开关并汇总判词

### 部分支持

- **必须链运行库（软浮 / 64 位乘除）**：后端**不再自带**`__aeabi_f*`/`__aeabi_d*`、`__aeabi_ldivmod`/`__aeabi_uldivmod`、`__aeabi_llsl` 这些 AEABI 辅助例程（[src/backend/arm/backend_arm.c](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/src/backend/arm/backend_arm.c) 里有逐条说明：`__aeabi_f2iz`、`__aeabi_fdiv`、`__aeabi_uldivmod`、`__aeabi_ldivmod`、`__aeabi_dadd` 五个自实现版本实测都是静默错值）。它们按 AEABI 的定义属于目标运行库——`arm-none-eabi-gcc` 的 `libgcc.a`、armcc 的 `armlib`。所以：**用到浮点、64 位除法或 64 位↔浮点转换的镜像必须链运行库**，否则链接期以 `undefined reference to __aeabi_...` 失败（刻意如此，把"算错"变成"链不上"）。RV32I 同理，软浮用 `__adddf3`/`__muldf3`/`__divdf3`/`__eqdf2` 一族、64 位乘除用 `__muldi3`/`__divdi3`，同样要链 `libgcc`。仍然自带的是 `__aeabi_memcpy`（结构体赋值/传参/数组初始化都用它，freestanding 目标没有 libc 的 `memcpy`）；64 位**加减**是内联的（ARM `ADDS/ADCS`，RV `sltu` 进位链），不需要库。硬件 FPU 模式（ARM `--fpu=hard`）把软浮换成 `VADD/VMUL/VCVT/VCMP`，那份依赖也就没了。
- **RV32I 的内联汇编、`__svc`/`__smc` 与打包车道运算**：`asm("...")` 原样输出，扩展形式（`asm("t" : outs : ins : clobbers)`）的 `%0..%3` 换成 `a0..a3`（ARM 是 `r0..r3`）——两个后端都**没有操作数分配器**，outs/ins/clobbers 被丢弃，操作数需要自己在模板里点名。`__svc(n)`/`__smc(n)` 在 RV32I 上都编成 `li a7, n` + `ecall`：RV 基础指令集只有一条 trap 指令，编号按 RISC-V syscall ABI / SBI 的约定进 `a7`，所以二者在 RV 上不可区分（ARM 侧仍是 `SVC #n` / `SMC #n`）。自动向量化产生的 `IR_SIMD_ADD16/SUB16/ADD8/SUB8` 在 RV 上用 SWAR 精确模拟（逐车道有符号回绕，不饱和），代价是每条车道运算要 10 条左右基础指令。门禁：`python tests/run_rv_misc_ir_tests.py --rv-as <bin> [--arm-as <bin> --arm-libgcc <libgcc.a>]`。
- **自动向量化的两条边界**：只处理"恰好两次 `LOAD_IDX` + 一次 `+`/`-` + 一次 `STORE_IDX`、元素 1 或 2 字节、循环次数是车道数整数倍"的循环；`volatile` 与 `__packed` 的循环**不进**向量化。宿主默认 `-O0` 也开（`ARKCC_FEATURE_OPT_VECTORIZE=1`），板端 profile 置 0，`--vectorize` / `--no_vectorize` 可显式开关。这一段曾经有静默错答案：宽度提升后元素窄化的 `IR_TRUNC` 没撤掉，四个车道只剩 lane 0，`char a[8]+b[8]` 算出 `{2,0,0,0,10,0,0,0}`（exit 0、无警告）。已修——相邻 `IR_TRUNC` 的目标位宽提到 32（即 no-op）。若日后改向量化，务必用 `examples/test_vectorize.c` 之外的形状再验一遍。
- **跨翻译单元链接（ARKOBJ2，不是 ELF）**：`-c` 产出 arkCC 自有对象容器 ARKOBJ2，`-link` 只认这个格式（`ELF .o` 不支持）。`-link` 做的是符号合并 + 重定位回填 + 多对象 SRAM 重叠检查，数据段默认**不**搬迁——因此每个对象的 `.data/.bss` 必须落在自己的窗口里，两个对象都带全局变量时直接报 SRAM 重叠并不产出，而不是悄悄叠在一起；要搬就给 `--reloc-data`（板端 `cc` 只要出现 `-link` 或 `--scatter` 就默认打开），它把第二个及以后的对象按 8 字节对齐接在前一个之后并就地改写 MOVW/MOVT 站点，各自仍留一条 `.data` 初始化体、镜像末尾拼成调用链。详见 5.7 / 5.8。RV32I 侧同样有 `-c`/`-link`（对象体装的是已汇编好的机器码，不是汇编文本）：对象内部全走 PC 相对量，因此可落在镜像任意偏移，链接器只按 16 字节对齐串联并回填 `RV_RELOC_AUIPC`(13) / `RV_RELOC_ABS32`(14)；导出边界由 `.globl`/`.weak` 决定，跨对象分支与跨 TU 的函数指针全局初始化器仍直接报错（详见 README 的「RV32I 的对象模式」）。
- **x86 内联汇编的 `%N` 操作数被拒绝**：ARM 后端把 `%0..%3` 粗映射到 `r0..r3`，x86 cdecl 没有对应的操作数→寄存器约定，粗映射会静默给出错值，所以 x86 后端在汇编文本里发现 `%0..%9` 时直接报错、不产出（`test_asm_operand.c` 就是这条的预期失败项）。
- **IR 生成不完整即失败**：`irgen` 遇到无法降级的赋值目标时会累计 `g_irgen_errors`，驱动看到非 0 就 `return ARK_ERR_IRGEN` 并不产出镜像（原先只打一行日志再 push 一个 0，会得到静默算错的二进制）。
- **`sizeof(long double)` 为 8**：本编译器采用 LLP64 数据模型（与 armcc 默认一致），`long double` 与 `double` 同为 8 字节，而 32 位 x86 宿主 GCC 上是 12。依赖 `sizeof(long double)` 区分精度的代码不可移植，跨平台比对 `sizeof` 结果时须按目标模型而非宿主模型来判断。
- **位域宽度上限 32 位**：`IR_LOAD_FLD`/`IR_STORE_FLD` 按 32 位容器读写，`long long x:40` 会读回错值。因此语法分析阶段直接报错（`bit-field width 40 exceeds 32`）、不生成代码，不做静默截断。
- **聚合初始化器只认能变成字节的东西（两个机器后端共用一份实现）**：全局聚合初始化走 [include/agginit.h](file:///d:/%E5%B7%A5%E4%BD%9C/git_project/ark%20c%20compiler/include/agginit.h) 的 `ark_agg_fill()`，类型驱动地按声明偏移写字节，所以支持整数/字符常量、字符串填充 `char` 数组（含 `char m[2][6] = {"ab","cd"}` 这种按行的）、嵌套 `{}`、`.field=` 与 `[idx]=` 指派器，以及**地址常量元素**（`int (*tab[2])(int,int) = {add,sub};`、`char *cs[2] = {"xy","cd"};`——文本里读不出数字、类型是指针/函数的元素交给后端 hook，按 `IrGlobal.init_refs` 的偏移对账，字符串元素额外在 `.rodata` 里按元素偏移各开一个标签，见「聚合初始化器里的地址元素」一节）。**读不出字节的初值一律显式报错**：聚合里的**浮点字面量**（`struct S{double d;} s = {1.5};` 报
`the arm backend cannot turn the initialiser of the global 's' into data ...`）以及不能用字面量表示的初值，
绝不写零充数。`union` 已支持：按 C99 6.7.8p10 只取**一个**活跃成员（无指派时取第一个，`.f=` 另指，
多于一个成员仍报错），成员本身既可以是指针（`union U u = { .p = &gv };`）也可以是字符数组
（`union U u = { .b = "abc" };`）；位域也支持（`struct B{int a:3; int b:5;} b = {1,2};` 按位落，位域数组同理）。两个后端调同一份实现，所以 ARM 与 RV32I 在这里给出的是同一组字节——曾经 ARM 自己那份"按逗号走"的解析器把字符串元素跳过存 0，`struct Q gq = {3, "abcd", 9}` 的成员全成了 NUL。
- **块作用域 `_Alignas` 上限 8 字节**：16/32/64 一律报错（`block-scope _Alignas above 8 bytes is not supported`），
  因为帧只保证 `sp` 8 字节对齐；文件作用域与结构体成员没有这个限制。
- **`va_arg` 依赖小端目标**：`stdlib/include/stdarg.h` 的 `va_arg` 按"槽位地址重解释"取值（`*(type *)(...)`），整数/指针/`double` 通吃，但要求目标为小端。ARM Thumb-2 与全部宿主均满足；大端目标需改为按类型分派。
- **变参的两种镜像形状不能混用**：C/x86_64 每个实参一个 8 字节槽位（`frame+8000` 起，
  序言里把 a0..a7 镜像进去，`irgen` 的 `g_ir_va_slot_region` 负责预留 8064 字节）；
  ARM / RV32I 用 4 字节字槽，而且**不镜像**：ARM 在序言里把"还可能装变参的寄存器"
  `r_k..r3` 压栈（`k = NCRN` 向下取偶数），让它们正好落在调用方栈参数块下方
  （区里 word j 接着栈块第 j 字，天然连续），代价随签名是 16 / 8 / 0 字节；
  RV32I 把 a0..a7 落到帧底那 32 字节里（用 `sp_size` 本来就留的余量），地址是
  `s0 - sp_size + 4*k`。`stdarg.h` 靠 `__ARK_VA_WORD_SLOTS` 选走法，靠
  `__ARK_VA_PACKED_WORDS` 区分"有对齐空洞（ARM）"与"平铺（RV32I）"。
  **这两个后端的变参帧必须保持小**：`irgen` 的 8064 字节预留由驱动按后端关掉
  （`g_ir_va_slot_region`），因为板上的小程序任务栈只有 4 KB——曾经 8 KB 的镜像区
  在宿主上全绿、到板上必然溢出。`examples/run_va_gate.py` 现在为每个用例断言帧大小
  （`FRAME_CAP = 1024`），并把同一份源码分别交给 gcc 和 arkcc→as→unicorn，比的是
  **运行结果**而不是"有没有报错"。
- **`_ark_va_ptr` 只在变参函数里有意义**：两个后端在非变参函数里引用它时直接报错
  （过去会从地址 0 取指针，静默给出错答案）。
- **ARM 的栈参数没有条数上限**：va 区就是调用方自己的参数镜像，`va_arg` 顺着栈参数往
  上走即可，不需要"够不够 28 个字"这类检查。代价按签名分档：一个命名参数字压 4 个字
  （16 B，返回前多一条 `ADD sp, sp, #16`）、两个或三个压 `{r2,r3}`（8 B）、四个命名字
  压 0 字节（尾声回到普通 `POP {..,pc}`）。非零档位要用 `POP {r5,r6,r7,lr}` 之后
  `BX lr`，因为 `POP {.., pc}` 后面没法再调栈。`run_va_gate.py` 里 `arm/many_stack`
  用 34 个参数字（30 个在栈上）钉住"没有上限"，`asm/region` 四条钉住"压哪几个寄存器"，
  `arm/s2_ll` / `arm/s3_ll` / `arm/s4_int` 钉住瘦身后的区里 64 位与 32 位读都对。
- **`k` 为什么必须取偶数**：压栈字节数要是 8 的倍数，否则帧顶变成 4 mod 8，8 字节局部量
  或 GCC 编译的被调方可能出错。注意"奇数 k 会让区遍历错"是**不成立**的——区里 word j 在
  `base+4j`，8 对齐当且仅当 `(j-k)` 为偶，正是 AAPCS 的"参数字为偶"，对任何 k 都成立。
  门禁的 `frame_align_problems` 把这条做成静态断言（序言的 PUSH+SUB 合计必须是 8 的倍数）。
- **float 实参会被提升成 double**（C99 6.5.2.2p6，`irgen` 发 `IR_F2F`），所以变参调用的
  形参宽度按 8 字节算；`argmask` 的 8 字节位由 `irgen` 一并置上。
- **RV32I 自己的边界**：只从 a0-a7 传参、没有两字值模型，所以超过 8 个参数字的调用与
  64 位实参都被明确拒绝，而不是留下错值。
- **穿过 `...` 的结构体按字内联**：命名形参里超过 8 字节的结构体压的是**地址字**
  （被调方 `IR_GETARG` 按 `aux` 高位的尺寸 memcpy），但变参不同——被调方没有类型，
  `va_arg` 只按连续参数字走，所以载荷必须在线上。调用点按 `ceil(size/4)` 个字压栈
  （word 0 在最上面），`aapcs_assign()` 对超过两个字的实参逐字分配（装得下进剩余寄存器，
  其余进栈）；地址用 `IR_DUP`/`IR_SWAP` 只算一次，最后 `IR_POP` 丢掉。
  5..8 字节的结构体仍是原来的两字规则。**只有 ARM 实现**，另外三个后端由 `irgen`
  报错拒绝（`passing a N-byte structure through '...' is implemented for the arm
  target only`）。
- **穿过 `...` 的复合体按 *alignment* 取偶，8 字节 align-4 复合体可拆分**：AAPCS32 的 NCRN
  取偶条件是实参**类型的 8 字节对齐**，不是 size。实测 `arm-none-eabi-gcc 12.3` 给出决定性
  证据：`struct A8{long long v;}`（8 B/align 8）从 r2:r3 起、`struct A4{int a,b;}`（8 B/align 4）
  从 r1:r2 起不取偶、`struct B8{double;int;}`（16 B/align 8）取偶、`struct B4{4×int}`
  （16 B/align 4）不取偶、`_Complex float`（8 B/align 4）不取偶。因此 `irgen` 在 `wires[i]`
  里额外置 **bit 16** 表示"该实参需 8 字节对齐"（低 16 位仍是字节数）；变参 `float` 已被
  提升成 `double`，所以这里按 8 判而不是按 `float` 的 4 判。`aapcs_assign()` 吃的是调用方与
  被调方共用的对齐数组 `aligns[]`，取偶只由它决定（不传该数组时退回旧的 `size == 8` 语义）。
  8 字节 align-4 复合体在只剩一个寄存器时**会拆分**（word 0 → 该寄存器、word 1 → 栈），
  不是 all-or-nothing：调用方用 `POP {r7}; POP {r<reg>}; PUSH {r7}` 把 word 0 从栈顶抽走、
  word 1 留在栈顶，块拷贝再按 `asplit[]` 只搬 word 1 到栈槽。
  `stdarg.h` 的 `ark_va__take` 因此改用 **`_Alignof(type) >= 8`** 判"这个槽是否落在 8 对齐
  位置"（旧代码用 `sizeof(type) == 8`，遇 A4 这种 8 B/align 4 的类型会多跳一格，与 gcc
  被调方混用时整体错位）。互操作由 `tests/run_arm_abi_mix_tests.py` 钉住：arkcc 与
  `arm-none-eabi-gcc` 各持一侧、unicorn 跑同一镜像，16 例（`a8/a4/b4/b8` × 三字内的奇偶、
  `a4_split` 拆分、`b8_hole` 寄存器/栈之间的空位）双向全通，并带 `SELFCHECK`——故意把期望值
  写错必须报错，否则判 harness 看不见差异。`_Complex` 穿 `...` 仍然拒绝（见下一条），
  所以这一族没有对应用例。
- **复数不走 sret、也不许穿过 `...`**：16 字节的 `_Complex double` 用返回值寄存器（ARM `r0-r3`、
  RV32I `a0-a3`），sret 只留给 size > 8 的 struct/union；穿过 `...` 传复数在调用点直接报错，
  因为 `va_arg` 只能按连续参数字走、被调方没有类型信息。完整矩阵见 4.10。
- **`_Complex` 现在是真的可以裁掉的**（`ARKCC_FEATURE_COMPLEX=0`）：
  早先 `+15 560 B` 的板端增量里，机器后端的四字值通路是无条件编入的，只有一个位标
  `IR_AUX_COMPLEX` 在标记它；那个位现在按档拼接——闸门关时 `IR_AUX_COMPLEX` 展开成
  常量 `0`，于是每一处 `I->aux & IR_AUX_COMPLEX` 都折成 `if (0)`，整块连同它调用的
  `arm_cplx_*` 静态辅助函数一起被丢弃。同理 `ARK_IS_CX(t)` 在闸门关时展开成常量 `0`，
  把 1700 行的 `irgen_expr` 与 3500 行的 `codegen_arm` 里 `kind == TYPE_COMPLEX` 的比较
  折掉，不必插 40 处 `#if`。剩下的 value 驱动路径（复数常量池、复数返回形状 `cplx_ret`、
  复数全局初值、`eval_const_cexpr`、`irgen_try_complex_init`）用 `#if` 直接包裹。
  闸门关时 parser 对 `_Complex` **硬报错**（`is not available in this build: it was
  configured out`），所以"闸门关时不可能出现 TYPE_COMPLEX"是闭合的，被折掉的块本来
  就不可达。
  - 实测（H743 固件，`ARKRTOS_TEST`，`-DARKCC_FEATURE_COMPLEX=0` 走 `OPTFLAGS`，
    其余编译选项逐字不变）：`text 438 812 → 424 988`（**−13 824 B**，FLASH 84.13% → 81.49%），
    `data 2 260`/`bss 463 532` 均不变。
  - 宿主 x86-64（四个后端全编）：`text 556 740 → 535 484`（−21 256 B）。
  - ARM 目标集（与固件同一套 `STM32_CFLAGS`，逐文件 `-c` 后 `size` 求和）：
    `246 554 → 232 926`（−13 628 B）；逐目标 `backend_arm.o −8 664`、`irgen.o −4 264`、
    `sema.o −608`、`parser.o −92`。
  - 与历史 `+15 560 B` 的差额（约 1.7 KB）是**共用的双精度通路与常量序列化**——
    它们同时服务 `double`，闸门关不掉；再加上 `init_is_complex` 字段的接线、
    以及本轮新增的运行期诊断（见下一条，+88 B）。这里不把"−13 824"说成"−15 560"。
  - **行为变化**：运行期 `-fno-complex` 以前是**忽略** `_Complex` 关键字，
    `double _Complex z` 静默变成 `double z`（错答案）；现在报
    `` `_Complex` is switched off by the run-time configuration (complex=0) ``。
    这 +88 B 是本轮有意新增的。
  - 默认值仍是 **1**（宿主 / 交叉 / 板端一致）。翻转默认属于行为变更，
    要与实测体积一起发布，所以这里只提供开关、不改默认。
  - 门禁：`tests/run_complex_gate.py --arkcc <全量> --arkcc-off <裁剪>` 同时钉住
    五件事——全量接受 `_Complex`、裁剪档**带原因地**拒绝、裁剪档照收普通 C、
    不含 `_Complex` 的源在两档下汇编文本**逐字节相同**、`-fno-complex` 报错而非忽略
    （另带一条"自检的自检"：普通源不得出现裁剪档的那句文案）。
- **一次调用的实参上限 64 个**：各后端的实参表停在 64，第 65 个起过去是静默丢弃，
  现在 `irgen` 直接报错；ARM 的总参数字上限 192（超过由后端报错，不截断）。

### 兼容性说明

### 验证边界

- **ARM 执行语义**：已由 `run_arm_exec_test.ps1` 在 `qemu-system-arm -machine mps2-an385` 上验证（编译→链接→真跑→semihosting 退出码，两个不同负载 8/3）；**仍未验**的是"板载产物烧回 Flash 再跳转"这一层（无硬件）。细节见 6.2。
- **x86 执行语义未验证**：本机 MinGW `gcc -m32` 只能汇编不能链接，x86 侧只验 emit/GAS 语法/别名等价/负向对照，见 6.3。
- **`__at` / `__global_reg` 在 `c` 后端降级为注释**：这两个是 ARM 特有的放置语义，C 后端只把 `__at(addr)` 输出成一条注释，`__global_reg` 仅做解析（提示性关键字），不改变生成代码。要它们真正生效请用 `-target arm`。

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

- 编译器本身作为 v0.8.0 的自举目标，需要在 STM32 等嵌入式环境中运行，那里的编辑器/终端往往不支持 UTF-8；纯 ASCII 源码保证了跨平台可读性与可编辑性。
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
cd "<ark-cc-repo-path>"
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

arkCC 已实现 **scatter 感知链接**（见 [5.5](#55-scatter-描述文件)）：
- **armcc5 路径**：arkCC 自身不参与段放置，段放置由 armlink 根据 `.sct` 文件完成；
- **自托管路径**（STM32 上跑 arkCC，`-link` 模式或单文件 `-c`/`-o .bin`）：`arm_link()` 解析 `.sct`/`.ld`，提取 flash_base/initial_sp，生成 256 条目 Cortex-M 向量表，移动代码并调整符号/重定位偏移。

armcc5 路径下的典型 `.sct` 示例：

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
