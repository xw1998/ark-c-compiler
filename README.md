# Ark C Compiler

一个面向多目标的 C99 编译器，可在 Windows / Linux / macOS 上用 gcc 编译运行，
也能移植到 STM32 上自宿主编译外部 Flash 中的 `.c` 文件。兼容 ARM Compiler 5 (armcc) 常用扩展。

## 特性（v0.6.0）

### C99 标准语言特性

| 维度 | 支持 | 备注 |
| --- | :---: | --- |
| 基本类型 | ? | `void/char/short/int/long/long long/_Bool/float/double` + `signed/unsigned` |
| 指针与数组 | ? | 一维/多维数组、指针、函数指针、数组退化；数组维度支持常量表达式 `int arr[SIZE+2]` |
| 变长数组 VLA | ? | `int a[n]` 运行时变长数组，通过 `IR_ALLOCA` 栈动态分配（8 字节对齐） |
| 复合类型 | ? | `struct`/`union`/`enum`/`typedef`、位域（真正位打包）、柔性数组成员 `data[]`、匿名 struct/union 字段提升 |
| 复数类型 | ? | `_Complex double`/`_Complex float`，透传给 gcc（`sizeof(_Complex double)==16`） |
| 宽字符 | ? | `wchar_t` + `L"..."` 宽字符串 + `L'...'` 宽字符字面量 |
| 三元组 trigraph | ? | 9 个 C99 三元组（`??=`→`#`、`??(`→`[`、`??/`→`\`、`??)`→`]`、`??'`→`^`、`??<`→`{`、`??>`→`}`、`??!`→`|`、`??-`→`~`） |
| 限定符 | ? | `const/volatile/restrict/inline` |
| 存储类 | ? | `static/extern/auto/register`；函数内 `static` 持久化 |
| 控制流 | ? | `if/else/while/for/do-while/switch/case/default/break/continue/goto/label/return` |
| 运算符 | ? | 全部 C99 运算符（算术/比较/逻辑短路/位运算/移位/复合赋值/三目/逗号/sizeof/强制转换） |
| 函数 | ? | 多参数(>4 走栈，严格 AAPCS)、原型检查、变参 `...`、递归、多文件分别编译+链接 |
| 字面量 | ? | 整数(十/八/十六+后缀)、字符+转义、字符串拼接、浮点 |
| 浮点 | ? | `float/double` 四则运算/比较/转换；ARM 后端可选硬件 FPU（VFP `VADD/VMUL/VCVT/VCMP`）或 `__aeabi_f*`/`__aeabi_d*` 软浮点桩，`double` 真 64 位精度 |
| 64 位整数 | ? | `long long` 运算通过 `__aeabi_l*` 桩；`printf` 参数不截断（64 位 long long 正确传递） |
| 除法/取模 | ? | 有符号/无符号 `__aeabi_idiv/uidiv/idivmod/uidivmod` |
| 隐式类型转换 | ? | 完整 usual arithmetic conversions + 整数提升 |
| 初始化 | ? | 标量、聚合 `{1,2,3}`、嵌套 `{{1,2},{3,4}}`、指定 `.x=1/[2]=5`、字符串 `char s[]="hi"`、全局变量非字面量初值（常量表达式折叠） |
| 复合字面量 | ? | `(int[]){1,2,3}` / `(struct P){.x=1,.y=2}` |
| 结构体按值传递 | ? | 通过隐藏指针参数实现 |
| 预处理 | ? | 对象/函数宏(`#/##`)、`#if/#elif/#else/#endif/#ifdef/#ifndef/#undef/#error/#warning/#pragma`、嵌套 `#include`(≤8层)、`__VA_ARGS__`、`-I` 路径、三元组替换 |
| 注释 | ? | `//` 与 `/* */` |

### ARM Compiler 5 (armcc) 兼容扩展

| 扩展 | 支持 | 生成 |
| --- | :---: | --- |
| `__svc(n)` | ? | `SVC #n` |
| `__irq` | ? | 中断序言 `PUSH {r0-r3,r12,lr}` / 结语 `POP {r0-r3,r12,pc}` |
| `__weak` | ? | `.weak <name>` |
| `__naked` | ? | 无序言/结语 |
| `__packed` | ? | 独立关键字形式 + `__attribute__((packed))` |
| `__align(n)` | ? | 真正生效的对齐控制 |
| `__at(addr)` | ? | 绝对地址（同 `__attribute__((at(addr)))` / `#pragma location=`） |
| `__forceinline` | ? | 解析（强制内联提示） |
| `__asm void fn() {...}` | ? | 整函数体汇编（armcc 风格） |
| `__attribute__((section))` | ? | `.section` 指令 |
| `__attribute__((aligned/packed/noreturn))` | ? | |
| `__attribute__((used/unused))` | ? | 防裁剪 / 抑制警告 |
| `__attribute__((alias("target")))` | ? | 函数别名 |
| `__attribute__((constructor/destructor))` | ? | ARM 后端生成 `.init_array`/`.fini_array` |
| `__attribute__((deprecated/format(printf,...)))` | ? | 透传 |
| `asm/__asm__` 内联汇编 | ? | 基本格式 + 扩展格式（操作数/约束/clobber）；C 后端完整透传，ARM 后端文本透传 |
| `#pragma pack(n)` | ? | 结构体对齐控制 |
| `#pragma anon_unions` | ? | 匿名 union 兼容 |
| `#pragma location=addr` | ? | 绝对地址 |
| `#pragma diag_suppress` | ? | 诊断抑制 |
| `#pragma arm/thumb` | ? | 指令集切换提示 |
| `#pragma import(__use_no_semihosting)` | ? | 半主机禁用 |
| `#pragma push/pop` | ? | 编译选项栈 |
| `#pragma O0/O2/O3`、`#pragma optimize` | ? | 优化等级提示 |

### armcc 兼容预定义宏

| 宏 | 值 |
| --- | --- |
| `__ARMCC_VERSION` | armcc 版本号 |
| `__arm__` / `__thumb__` | ARM/Thumb 模式标识 |
| `__TARGET_ARCH_7_M` / `__TARGET_ARCH_7E_M` | Cortex-M 架构标识 |
| `__TARGET_FPU_VFP` | VFP 标识 |
| `__BIG_ENDIAN` / `__LITTLE_ENDIAN__` | 字节序 |
| `__sizeof_int` / `__sizeof_ptr` | 类型尺寸 |

### 代码生成

| 特性 | 支持 |
| --- | :---: |
| 32 位立即数 MOVW/MOVT | ? |
| 整数除法 SDIV / `__aeabi_idiv` | ? |
| 64 位运算 `__aeabi_lmul/ldiv` | ? |
| 软浮点 `__aeabi_f*`（单精度） | ? |
| 软浮点 `__aeabi_d*`（双精度，`double` 真 64 位） | ? |
| 硬件 FPU 指令（VFP `VADD/VMUL/VCVT/VCMP`，替代软浮点桩） | ? |
| VLA 动态栈分配 `IR_ALLOCA` | ? |
| `.data/.bss/.rodata` 段分离 | ? |
| 位域位打包/解包 | ? |
| `.s` 汇编文件直接编译 | ? |
| 严格 AAPCS（>4 参数走栈） | ? |
| `setjmp/longjmp` 支持 | ? |
| `.init_array`/`.fini_array`（constructor/destructor） | ? |
| DWARF 调试信息（`.file/.loc/.cfi_startproc/.size`） | ? |

### 标准库子集

| 源文件 | 提供 |
| --- | --- |
| `stdlib/src/printf.c` | 精简 `printf`（`%d/%u/%x/%X/%s/%c/%p/%%` + 宽度/0 填充，64 位 long long 不截断） |
| `stdlib/src/string.c` | `memcpy/memset/memmove/memcmp/strlen/strcpy/strcmp` |
| `stdlib/src/math.c` | `sin/cos/sqrt/pow/fabs/floor/ceil/fmod` |
| `stdlib/src/setjmp.c` | `setjmp/longjmp`（host 可移植简化实现） |
| `stdlib/src/putchar_default.c` | `putchar` 弱默认实现 |

头文件 `stdlib/include/`：`stdint.h`/`stdbool.h`/`stddef.h`/`stdarg.h`/`string.h`/`stdio.h`/`stdlib.h`/`math.h`（含 `M_PI` 等常量）/`setjmp.h`。

### 后端

| 后端 | 用途 |
| --- | --- |
| **ARM Thumb-2** | STM32 Cortex-M（默认，含软浮点/硬件 FPU+段分离+双精度桩+AAPCS+DWARF） |
| **C 源代码** | host 测试主路径（IR→可读 C，完整支持内联汇编操作数透传） |
| **x86_64** | 输出 GAS 汇编 |
| **RV32I** | 输出 RV32I 汇编 |

## 目录结构

```
ark c compiler/
├── include/                公共头文件（含 arkcc_config.h/config.h/opt.h）
├── src/                    编译器核心（lexer/parser/sema/ir/irgen/preproc/config/opt）
├── src/backend/arm/        ARM Thumb-2 后端（codegen + 汇编器 + 链接 + 软浮点/硬件 FPU + DWARF）
├── src/backend/c/          C 源代码后端（host 测试）
├── src/backend/x86_64/     x86_64 汇编后端
├── src/backend/riscv32/    RV32I 汇编后端
├── stdlib/include/         内置标准库头文件
├── port/host/              PC 平台层
├── port/stm32/             STM32 平台层
├── examples/               56 个测试（.c + .s）
├── mdk/STM32H743_ArkCC/    Keil MDK 工程
├── arkcc.cfg               默认运行时配置（INI 格式）
├── Makefile
├── MANUAL.md               使用手册
└── README.md
```

## 构建

```bash
make            # 生成 arkcc.exe
make test       # 编译示例
make clean
```

## 命令行

```
arkcc <file.c|file.s> [options]
  -o <file>          输出文件
  -S                 只输出汇编文本
  -c                 只编译不链接（.ark_obj）
  -E                 只预处理
  -link a.o b.o      链接多个 .ark_obj
  -v                 详细模式
  -target <name>     arm | x86_64 | riscv32 | c（默认 arm）
  -I <dir>           include 搜索路径
  -O0/-O1/-O2        优化级别（0=无, 1=基础常量折叠+DCE, 2=激进）
  -g                 生成 DWARF 调试信息
  -config <file>     加载 INI 配置文件（默认 arkcc.cfg）
  -f<feature>        开启特性（vla/complex/wchar/trigraph/fpu/dwarf/...）
  -fno-<feature>     关闭特性
  -Wno-unused        抑制未使用警告
  --list-backends    列出后端
```

## 配置系统

arkcc 支持三层配置，优先级：**命令行 > 配置文件 > 编译期默认**。

- **编译期开关**（`include/arkcc_config.h`）：12 个 `ARKCC_FEATURE_*` 宏，决定 arkcc 自身编译进哪些功能。
- **运行时配置文件**（`arkcc.cfg`，INI 格式）：`[features]` 段控制各特性开关，`[general]` 段控制优化级别与调试信息。启动时自动加载当前目录下的 `arkcc.cfg`，也可用 `-config <file>` 指定。
- **命令行覆盖**：`-O0/-O1/-O2`、`-g`、`-f<feature>`、`-fno-<feature>` 覆盖文件设置。

`arkcc.cfg` 示例：

```ini
[features]
vla           = 1
complex       = 1
wchar         = 1
trigraph      = 1
fpu_hw        = 1
dwarf         = 1
opt_constfold = 1
opt_dce       = 1
opt_regalloc  = 0

[general]
opt_level   = 0
debug_info  = 0
```

## 优化

`-O1` 及以上启用 IR 级优化 Pass（`src/opt.c`）：

- **常量折叠**：`PUSH_INT a; PUSH_INT b; BINARY op` 三连折叠为 `PUSH_INT (a op b)`，多趟扫描至不动点（上限 8 趟），支持级联折叠。除零/模零不折叠以保留运行时行为。
- **死代码消除**：删除 `RETURN/JMP/JMP_NAMED` 之后、下一个标签之前的不可达指令。

各 Pass 同时受编译期 `ARKCC_FEATURE_OPT_*` 宏与运行时 `g_config.enable_opt_*` 守护。

## 调试信息

`-g` 或 `g_config.debug_info=1` 时，ARM 后端在汇编输出中发射 GNU as 风格的 DWARF 伪指令：

- `.file 1 "<src>.c"` 源文件登记
- `.cfi_startproc` / `.cfi_endproc` 函数帧信息
- `.loc 1 <line>` 行号映射
- `.size <fn>, .-<fn>` 函数尺寸
- `.type <fn>, %function` 类型标注

## 测试

```powershell
powershell -ExecutionPolicy Bypass -File examples\run_tests.ps1
```

56 个测试全部通过（ARM 汇编生成 + C 后端编译运行）。

## 移植到 STM32

仅需替换 `port/host/*.c` 为 `port/stm32/*.c`，MDK 工程见 `mdk/STM32H743_ArkCC/`。
详细说明见 [MANUAL.md](MANUAL.md)。

## 版本

- v0.6.0：配置系统 + 优化 Pass + 调试信息 + 前端/后端补强。新增：三层配置系统（`arkcc_config.h` 编译期宏 + `arkcc.cfg` INI 运行时配置 + `-O/-g/-f/-fno-/-config` 命令行）、VLA 变长数组（`IR_ALLOCA`）、宽字符 `wchar_t`/`L"..."`/`L'...'`、三元组 trigraph（9 个 C99 三元组）、`_Complex` 复数类型、硬件 FPU 指令（VFP `VADD/VMUL/VCVT/VCMP` 替代软浮点桩）、DWARF 调试信息（`.file/.loc/.cfi_startproc/.size`）、IR 级常量折叠 + 死代码消除（`src/opt.c`）、逗号分隔局部声明作用域 bug 修复。56 个测试全部通过。
- v0.5.0：四波刚需特性（startup/中断向量、HAL/DMA/MMIO、控制算法/printf调试、RTOS/完整工程）。新增：`__asm` 整函数体汇编、`__attribute__((used/unused/alias/constructor/destructor/deprecated/format))`、`__align`/`__at`/`__packed`/`__forceinline` 真正生效、匿名 union 字段提升、`#pragma anon_unions/location/diag_suppress/arm/thumb/import/push/pop/O0-O3/optimize`、armcc 预定义宏、完整隐式类型转换与整数提升、`double` 真 64 位精度、全局变量常量表达式初值、数组维度常量表达式、`printf` 64 位不截断、严格 AAPCS、`setjmp/longjmp`、标准库 string.c/math.c/setjmp.c
- v0.4.0：完整 C99 + armcc 兼容（__irq/__weak/__naked/位域打包/64位/除法/段分离/复合字面量/柔性数组/结构体按值/pragma pack）
- v0.3.0：浮点运算、`__svc`、`.s` 编译、static 局部变量、多文件链接
- v0.2.0：多后端架构、C99 子集、标准库子集
- v0.1.0：单 ARM 后端最小 C 子集
