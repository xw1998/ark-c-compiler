# Ark C Compiler 使用手册

> 版本：0.6.0
> 一个完整的 C99 编译器，兼容 ARM Compiler 5 常用扩展，可在 STM32 上自宿主编译

---

## 目录

1. [项目简介](#1-项目简介)
2. [快速上手](#2-快速上手)
3. [命令行参考](#3-命令行参考)
4. [C99 语言特性支持](#4-c99-语言特性支持)
5. [ARM Compiler 5 兼容扩展](#5-arm-compiler-5-兼容扩展)
6. [多后端架构](#6-多后端架构)
7. [配置系统](#7-配置系统)
8. [优化 Pass](#8-优化-pass)
9. [在 Windows 上做测试](#9-在-windows-上做测试)
10. [STM32H743 + Keil MDK 工程](#10-stm32h743--keil-mdk-工程)
11. [代码组织与移植指南](#11-代码组织与移植指南)
12. [扩展开发指南](#12-扩展开发指南)
13. [标准库子集](#13-标准库子集)
14. [常见问题 FAQ](#14-常见问题-faq)
15. [已知限制](#15-已知限制)
16. [附录：内部数据流](#16-附录内部数据流)

---

## 1 项目简介

**Ark C Compiler**（简称 `arkcc`）是一个用 C99 编写的 C 语言编译器，目标是：

- **完整 C99**：支持 C99 标准的全部常用语法，含 VLA 变长数组、宽字符 `wchar_t`、三元组 trigraph、`_Complex` 复数、完整隐式类型转换、整数提升、`double` 真 64 位精度
- **嵌入式自宿主**：编译器本身可在 STM32H743 上运行
- **多后端**：`arm` / `x86_64` / `riscv32` / `c` 四个后端可切换
- **ARM Compiler 5 兼容**：支持 `__svc`/`__irq`/`__weak`/`__naked`/`__packed`/`__align`/`__at`/`__forceinline`/`__asm` 函数体/`__attribute__` 全套属性/`#pragma` 全套指令/预定义宏等嵌入式常用扩展
- **可配置**：三层配置系统（编译期宏 + INI 配置文件 + 命令行），可裁切前端特性、硬件 FPU、DWARF 调试信息、优化 Pass
- **IR 级优化**：`-O1` 启用常量折叠 + 死代码消除
- **方便 Windows 测试**：`c` 后端把 IR 翻译回 C 代码，用主机 gcc 编译运行

### 整体流水线

```
   源代码 .c / .s
      |
      v
  .s 文件? --Yes--> 直接 assemble --> .bin
      |
      No
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
                                            +--------+      -O1: 常量折叠 + DCE
                                            |  opt   |
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
                                  .S / .bin / .gen.c
```

---

## 2 快速上手

### 2.1 环境准备

- **Windows**：MinGW-w64 / MSYS2，确保 `gcc` 在 PATH
- **STM32**：Keil MDK-ARM 5.36+

### 2.2 三分钟构建 + 测试

```powershell
cd "d:\工作\git_project\ark c compiler"

# 1. 编译 arkcc
make

# 2. 跑全部测试
powershell -ExecutionPolicy Bypass -File examples\run_tests.ps1

# 3. 编译你自己的程序
.\arkcc.exe myprog.c -target c -S -o myprog.gen.c
gcc myprog.gen.c -o myprog.exe
.\myprog.exe
```

---

## 3 命令行参考

```
arkcc <file.c|file.s> [options]
```

| 选项 | 说明 |
| --- | --- |
| `-o <file>` | 输出文件 |
| `-S` | 只生成文本汇编/源码 |
| `-c` | 只编译不链接（生成 `.ark_obj`） |
| `-E` | 只预处理，输出展开后的源码 |
| `-link a.o b.o` | 链接多个 `.ark_obj`（与 `-o` 配合） |
| `-target <name>` | `arm`（默认）、`x86_64`、`riscv32`、`c` |
| `-I <dir>` | `#include` 搜索路径（可多次） |
| `-O0` / `-O1` / `-O2` | 优化级别（0=无, 1=常量折叠+DCE, 2=激进，详见第 8 章） |
| `-g` | 生成 DWARF 调试信息（`.file/.loc/.cfi/.size`） |
| `-config <file>` | 加载 INI 配置文件（默认 `arkcc.cfg`，详见第 7 章） |
| `-f<feature>` | 开启特性（`vla/complex/wchar/trigraph/fpu_hw/dwarf/opt_constfold/opt_dce/...`） |
| `-fno-<feature>` | 关闭特性 |
| `-Wno-unused` | 抑制未使用警告 |
| `-v` | 详细模式（打印当前 `g_config`） |
| `--list-backends` | 列出后端 |

`.s`/`.S` 汇编文件直接编译为二进制，跳过前端流水线。

配置类参数（`-O/-g/-f/-fno-/-config`）的优先级为：**命令行 > 配置文件 > 编译期默认**（详见第 7 章）。

---

## 4 C99 语言特性支持

### 4.1 类型系统

| 特性 | 状态 |
| --- | :---: |
| `void/char/short/int/long/long long` + `signed/unsigned` | ? |
| `_Bool` / `<stdbool.h>` | ? |
| `float` / `double`（四则运算、比较、转换；`double` 真 64 位精度） | ? |
| `_Complex` 复数（`_Complex double`/`_Complex float`，透传 gcc，`sizeof(_Complex double)==16`） | ? |
| 宽字符 `wchar_t` + `L"..."` 宽字符串 + `L'...'` 宽字符字面量 | ? |
| 一维/多维数组、指针、函数指针 | ? |
| 数组退化为指针 | ? |
| 数组维度支持常量表达式 `int arr[SIZE+2]` / `int arr[3*sizeof(int)]` | ? |
| 变长数组 VLA `int a[n]`（`IR_ALLOCA` 栈动态分配，8 字节对齐） | ? |
| `struct` / `union`（含 `.`/`->`） | ? |
| 匿名 struct/union 字段提升（CMSIS 寄存器定义） | ? |
| 位域 `int flag:3;`（真正位打包/解包） | ? |
| 柔性数组成员 `char data[];` | ? |
| `enum` / `typedef` | ? |
| `const/volatile/restrict/inline` | ? |
| `static/extern/auto/register` | ? |
| 函数内 `static` 局部变量持久化 | ? |
| 强制类型转换 `(type)expr` | ? |
| `sizeof(type)` / `sizeof expr` | ? |
| 完整隐式类型转换 + 整数提升（usual arithmetic conversions） | ? |

### 4.2 运算符

全部 C99 运算符：算术 `+ - * / %`、比较 `== != < > <= >=`、逻辑 `&& || !`（短路）、位 `& | ^ ~ << >>`、赋值 `=` 与全部复合赋值、`++ --`、`?:`、`,`、`&`取地址 / `*`解引用、`.`/`->`、`sizeof`。

**除法/取模**：有符号走 `__aeabi_idiv/idivmod`，无符号走 `__aeabi_uidiv/uidivmod`。

**64 位运算**：`long long` 运算走 `__aeabi_ladd/lsub/lmul/ldiv/ldivmod`。

**隐式类型转换**：完整实现 usual arithmetic conversions 与整数提升，unsigned/signed 混合按 ARM ABI 规则处理。

### 4.3 语句

`if/else`、`while/do-while/for`、`switch/case/default`（支持 `case` 常量表达式）、`break/continue/return`、`goto`+标签、C99 块内任意位置声明、`for(int i=0;...)`。

### 4.4 函数

定义、声明、调用、递归、多于 4 个参数（严格 AAPCS，多余走栈）、原型检查、变参 `...`、多文件分别编译+链接、**结构体按值传递/返回**（通过隐藏指针参数）、`printf` 参数不截断（64 位 `long long` 正确传递）。

### 4.5 初始化

| 初始化方式 | 状态 |
| --- | :---: |
| 标量 `int x = 42;` | ? |
| 聚合 `int a[] = {1,2,3};` | ? |
| 嵌套聚合 `int m[2][3] = {{1,2,3},{4,5,6}};` | ? |
| 指定初始化 `.x=1, [2]=5` | ? |
| 字符串 `char s[] = "hi";` | ? |
| 复合字面量 `(int[]){1,2,3}` | ? |
| 结构体按值 `struct P p = {1, 2};` | ? |
| 全局变量非字面量初值（常量表达式折叠 `eval_const_expr`） | ? |

### 4.6 预处理

对象宏、函数宏（`#` 字符串化、`##` 串接）、`#if/#elif/#else/#endif/#ifdef/#ifndef`、`#undef/#error/#warning/#pragma`、嵌套 `#include`（≤8 层）、`-I` 搜索路径、`__VA_ARGS__`、预定义宏 `__FILE__/__LINE__/__STDC__/__ARK_CC__`、**三元组 trigraph**（9 个 C99 三元组：`??=`→`#`、`??(`→`[`、`??/`→`\`、`??)`→`]`、`??'`→`^`、`??<`→`{`、`??>`→`}`、`??!`→`|`、`??-`→`~`，在词法分析前替换）。

`#pragma pack(n)` / `#pragma pack(push,n)` / `#pragma pack(pop)` 控制结构体对齐。

armcc 兼容预定义宏：`__ARMCC_VERSION`、`__arm__`、`__thumb__`、`__TARGET_ARCH_7_M`、`__TARGET_ARCH_7E_M`、`__TARGET_FPU_VFP`、`__BIG_ENDIAN`、`__LITTLE_ENDIAN__`、`__sizeof_int`、`__sizeof_ptr`（详见第 5 章）。

---

## 5 ARM Compiler 5 兼容扩展

arkcc 兼容 ARM Compiler 5 (armcc) 的常用关键字、`__attribute__`、`#pragma`、预定义宏与内联汇编，便于直接编译 CMSIS/HAL 风格的嵌入式源码。

### 5.1 关键字总览

| 关键字 | 支持 | 说明 |
| --- | :---: | --- |
| `__svc(n)` | ? | 生成 `SVC #n` |
| `__irq` | ? | 中断序言 `PUSH {r0-r3,r12,lr}` / 结语 `POP {r0-r3,r12,pc}` |
| `__weak` | ? | 弱符号 `.weak <name>` |
| `__naked` | ? | 无序言/结语 |
| `__packed` | ? | 独立关键字形式（紧凑布局） |
| `__align(n)` | ? | 真正生效的对齐控制 |
| `__at(addr)` | ? | 绝对地址 |
| `__forceinline` | ? | 解析（强制内联提示） |
| `__softfp` | ? | 解析（软浮点调用约定提示） |
| `__asm` | ? | 整函数体汇编（见 5.8） |

### 5.2 `__svc(n)` SVC 声明

```c
int32  __svc ( 0x10 ) svcrt_call_dev_io(uint32 *p);
void   __svc ( 0x11 ) svcrt_call_task_ctrl(uint32 fn, uint32 p);
uint32 __svc ( 0x12 ) svcrt_call_sys_info(uint32 fn);
```

ARM 后端生成 `SVC #n`（参数走 r0，返回值 r0）。

### 5.3 `__irq` 中断函数

```c
__irq void TIM2_IRQHandler(void) {
    /* 自动生成 PUSH {r0-r3,r12,lr} / POP {r0-r3,r12,pc} */
}
```

### 5.4 `__weak` 弱符号

```c
__weak void Default_Handler(void) { }
```

ARM 后端生成 `.weak Default_Handler`。

### 5.5 `__naked` 裸函数

```c
__naked void boot_jump(void) {
    /* 无序言/结语，不生成 PUSH/POP */
}
```

### 5.6 `__packed` 与 `__align`

`__packed` 可作为独立关键字使用（与 `__attribute__((packed))` 等价）：

```c
__packed struct P { char a; int b; };   /* sizeof = 5 */
```

`__align(n)` 与 `__attribute__((aligned(n)))` 均真正生效：

```c
__align(8) int buf[4];                  /* 8 字节对齐 */
struct S { int x; } __attribute__((aligned(16)));
```

### 5.7 `__at(addr)` 绝对地址

三种等价写法，把变量/函数放到指定地址：

```c
__at(0x20000000) int shared_flag;                       /* 关键字形式 */
__attribute__((at(0x20000004))) int ring_buf[8];        /* 属性形式 */
#pragma location=0x0800F000
const char boot_sig[16] = "ARKCC-BOOT";                 /* pragma 形式 */
```

### 5.8 `__asm` 整函数体汇编

armcc 风格的整函数体汇编，函数体由汇编字符串构成，直接透传到生成的 `.s`：

```c
__asm void NOP(void) {
    NOP
    BX lr
}

__asm void enable_irq(void) {
    CPSIE i
    BX lr
}
```

适用于 startup 文件、向量表、底层原子操作等无法用 C 表达的场景。

### 5.9 `__forceinline` / `__softfp`

```c
__forceinline static int add(int a, int b) { return a + b; }
__softfp float fast_fma(float a, float b, float c);
```

两者均被解析并透传，`__forceinline` 作为内联提示，`__softfp` 标记软浮点调用约定。

### 5.10 `__attribute__` 扩展

| 属性 | 支持 | 说明 |
| --- | :---: | --- |
| `section("name")` | ? | `.section` 指令 |
| `aligned(n)` | ? | 对齐控制 |
| `packed` | ? | 紧凑布局 |
| `noreturn` | ? | 不返回 |
| `weak` | ? | 弱符号 |
| `naked` | ? | 裸函数 |
| `interrupt` | ? | 中断函数 |
| `used` | ? | 防止符号被链接器裁掉 |
| `unused` | ? | 抑制未使用警告 |
| `alias("target")` | ? | 函数别名 |
| `constructor` | ? | ARM 后端生成 `.init_array`，main 前执行 |
| `destructor` | ? | ARM 后端生成 `.fini_array`，main 后执行 |
| `deprecated` | ? | 透传弃用标记 |
| `format(printf,...)` | ? | 透传 printf 格式检查 |

示例：

```c
__attribute__((used)) int retain_me = 1;             /* 防裁剪 */
__attribute__((unused)) static int dbg;              /* 抑制警告 */
void foo(void) __attribute__((alias("foo_impl")));   /* 别名 */
__attribute__((constructor)) void early_init(void) { /* main 前运行 */
    /* 初始化硬件 */
}
__attribute__((deprecated("use new_api"))) void old_api(void);
__attribute__((format(printf, 1, 2))) void logf(const char *fmt, ...);
```

### 5.11 内联汇编

支持基本格式与扩展格式（操作数/约束/clobber）：

```c
/* 基本格式 */
asm volatile("nop");
asm("bkpt #0");

/* 扩展格式：操作数/约束/clobber */
asm volatile("msr control,%0" : : "r"(val) : "memory");
asm volatile("mrs %0, primask" : "=r"(primask));
```

后端处理：

- **C 后端**：完整支持操作数透传，把内联汇编原样嵌入生成的 `.gen.c`，由 host gcc 汇编。
- **ARM 后端**：文本透传，把汇编字符串直接写入 `.s`。

### 5.12 `#pragma` 指令

| pragma | 支持 | 说明 |
| --- | :---: | --- |
| `pack(n)` / `pack(push,n)` / `pack(pop)` | ? | 结构体对齐控制 |
| `anon_unions` | ? | 匿名 union 兼容 |
| `location=addr` | ? | 绝对地址 |
| `diag_suppress` | ? | 诊断抑制 |
| `arm` / `thumb` | ? | 指令集切换提示 |
| `import(__use_no_semihosting)` | ? | 半主机禁用 |
| `push` / `pop` | ? | 编译选项栈 |
| `O0` / `O2` / `O3` | ? | 优化等级提示 |
| `optimize` | ? | 优化控制 |

示例：

```c
#pragma pack(1)
struct Packed { char a; int b; };   /* sizeof = 5 */
#pragma pack()

#pragma anon_unions
struct Reg {
    union { struct { unsigned a:1; unsigned b:1; }; unsigned v; };
};
#pragma anon_unions   /* 默认即支持，pragma 用于显式兼容 armcc */

#pragma diag_suppress 1, 2, 3
#pragma arm
#pragma thumb
#pragma import(__use_no_semihosting)
#pragma push
#pragma O3
#pragma pop
```

### 5.13 预定义宏

| 宏 | 值/说明 |
| --- | --- |
| `__ARMCC_VERSION` | armcc 版本号 |
| `__arm__` | ARM 模式标识 |
| `__thumb__` | Thumb 模式标识 |
| `__TARGET_ARCH_7_M` | Cortex-M 架构标识（v7-M） |
| `__TARGET_ARCH_7E_M` | Cortex-M 架构标识（v7E-M，含 DSP） |
| `__TARGET_FPU_VFP` | VFP 标识 |
| `__BIG_ENDIAN` | 大端模式 |
| `__LITTLE_ENDIAN__` | 小端模式 |
| `__sizeof_int` | `int` 字节数 |
| `__sizeof_ptr` | 指针字节数 |

另外 arkcc 自身提供 `__ARK_CC__`、`__FILE__`、`__LINE__`、`__STDC__` 等标准预定义宏。

### 5.14 匿名 struct/union 字段提升

支持 CMSIS 寄存器定义常用的匿名 struct/union，字段直接提升到外层作用域：

```c
typedef struct {
    union {
        __IO uint32_t SR;          /* 整体访问 */
        struct {
            __IO uint32_t CTS:1;   /* 位访问 */
            __IO uint32_t TXE:1;
        };
    };
} USART_TypeDef;

USART_Type* uart = (USART_TypeDef*)0x40011000;
uart->SR = 0;        /* 直接访问 union 成员 */
uart->TXE = 1;       /* 直接访问匿名 struct 成员 */
```

---

## 6 多后端架构

### 6.1 后端接口（`include/backend.h`）

```c
typedef struct ArkBackend {
    const char *name;
    int (*emit_asm)(IrProgram *m, char *out, int cap);
    int (*assemble)(const char *asm_text, unsigned char *out, int cap);
    int (*link)(unsigned char *code, int size, struct LinkContext *lc);
} ArkBackend;
```

### 6.2 已实现的后端

| 后端 | 目录 | 用途 |
| --- | --- | --- |
| `arm` | `src/backend/arm/` | STM32 Cortex-M（Thumb-2 + 软浮点/硬件 FPU + 段分离 + 位域 + DWARF） |
| `c` | `src/backend/c/` | IR → C 源（host 测试） |
| `x86_64` | `src/backend/x86_64/` | GAS 汇编 |
| `riscv32` | `src/backend/riscv32/` | RV32I 汇编 |

注册表：`src/backend/registry.c`。

### 6.3 ARM 后端代码生成

| 功能 | 生成方式 |
| --- | --- |
| 32 位立即数 | `MOVW` + `MOVT` |
| 整数除法 | `BL __aeabi_idiv/uidiv/idivmod/uidivmod` |
| 64 位运算 | `BL __aeabi_ladd/lsub/lmul/ldiv/ldivmod` |
| 单精度浮点（软浮点） | `BL __aeabi_fadd/fsub/fmul/fdiv/f2iz/i2f/fcmpeq/...` |
| 双精度浮点（软浮点） | `BL __aeabi_dadd/dsub/dmul/ddiv/...`（`double` 真 64 位精度） |
| 硬件 FPU（`enable_fpu_hw=1`） | VFP 原生指令 `VADD.F32/F64`、`VSUB`、`VMUL`、`VDIV`、`VCVT`、`VCMP` 等，替代 `__aeabi_*` 软浮点桩 |
| VLA 动态栈分配 | `IR_ALLOCA` → `ADD/BIC sp` 8 字节对齐 + `SUB sp, sp, r0` 分配，压入首地址 |
| 位域存取 | `LDR/STR + LSL/LSR/AND/BIC/ORR` |
| 内存拷贝 | `BL memcpy`（结构体赋值/按值传递） |
| 中断函数 | `PUSH {r0-r3,r12,lr}` / `POP {r0-r3,r12,pc}` |
| 弱符号 | `.weak <name>` |
| 严格 AAPCS | >4 参数走栈（GETARG/CALL 正确处理） |
| constructor/destructor | `.init_array` / `.fini_array` 段 |
| 绝对地址 | `__at` / `__attribute__((at))` / `#pragma location` |
| 全局变量 | `.data` / `.bss` / `.rodata` 段分离 |
| DWARF 调试信息（`-g` 或 `enable_dwarf=1`） | `.file`、`.type fn, %function`、`.cfi_startproc/.cfi_endproc`、`.loc 1 <line>`、`.size fn, .-fn` |

硬件 FPU 与软浮点二选一：当 `g_config.enable_fpu_hw=1`（默认）时，浮点四则运算/比较/转换直接用 VFP 指令；否则回退到 `__aeabi_*` 软浮点桩。详见第 7 章配置系统。

---

## 7 配置系统

arkcc 引入三层配置系统，可在编译期、运行时配置文件、命令行三个层面裁切特性与开关。优先级：**命令行 > 配置文件 > 编译期默认**。

### 7.1 三层配置与优先级

| 层级 | 载体 | 作用 | 文件 |
| --- | --- | --- | --- |
| 编译期 | `ARKCC_FEATURE_*` 宏 | 决定 arkcc 自身编译进哪些功能 | `include/arkcc_config.h` |
| 运行时 | INI 配置文件 | 编译用户代码时进一步开关 | `arkcc.cfg`（或 `-config <file>`） |
| 命令行 | `-O/-g/-f/-fno-` | 覆盖文件设置 | `src/main.c` 调用 `config_apply_args` |

启动流程（`src/main.c`）：

1. `config_init()` 用 `ARKCC_FEATURE_*` 宏初始化 `g_config` 为编译期默认；
2. 查找 `-config <file>` 或默认 `arkcc.cfg`，存在则 `config_load_file()` 解析覆盖；
3. `config_apply_args()` 扫描 `-O/-g/-fxxx/-fno-xxx`，覆盖文件设置。

`-v` 详细模式会调用 `config_print()` 打印当前 `g_config` 全部字段到 stderr。

### 7.2 编译期特性开关（`include/arkcc_config.h`）

12 个 `ARKCC_FEATURE_*` 宏，值为 1 表示编译进 arkcc：

| 宏 | 默认 | 说明 |
| --- | :---: | --- |
| `ARKCC_FEATURE_VLA` | 1 | 变长数组 `int a[n]` |
| `ARKCC_FEATURE_COMPLEX` | 1 | `_Complex` 复数 |
| `ARKCC_FEATURE_WCHAR` | 1 | 宽字符 `wchar_t` / `L"..."` |
| `ARKCC_FEATURE_TRIGRAPH` | 1 | 三元组 `??=` 等 |
| `ARKCC_FEATURE_FPU_HW` | 1 | 硬件 FPU 指令（VFP） |
| `ARKCC_FEATURE_DWARF` | 1 | DWARF 调试信息 |
| `ARKCC_FEATURE_OPT_CONSTFOLD` | 1 | 常量折叠 |
| `ARKCC_FEATURE_OPT_DCE` | 1 | 死代码消除 |
| `ARKCC_FEATURE_OPT_REGALLOC` | 0 | 寄存器分配（实验性，默认关） |
| `ARKCC_FEATURE_ARMCC_ASM_FUNC` | 1 | `__asm` 函数体 |
| `ARKCC_FEATURE_ARMCC_PRAGMA` | 1 | `#pragma` 兼容 |
| `ARKCC_FEATURE_ARMCC_KEYWORDS` | 1 | `__irq/__weak/__naked` 等 |

裁切方法：在编译 arkcc 时把对应宏改为 0 即可，相关代码用 `#if ARKCC_FEATURE_XXX` 守护。

### 7.3 运行时配置文件（`arkcc.cfg`，INI 格式）

启动时自动加载当前目录下的 `arkcc.cfg`，也可用 `-config <file>` 指定。格式为 `[features]` 与 `[general]` 两个段，键值 `key = value`，布尔值接受 `0/1/true/false`（非零数字视为真）。

```ini
# Ark C Compiler 默认运行时配置
# 优先级：命令行 > 配置文件 > 编译期默认（ARKCC_FEATURE_*）

[features]
# 前端语言特性
vla          = 1
complex      = 1
wchar        = 1
trigraph     = 1

# 后端代码生成
fpu_hw       = 1
dwarf        = 1

# 优化 Pass
opt_constfold = 1
opt_dce       = 1
opt_regalloc  = 0

[general]
# 优化级别：0=无, 1=基础, 2=激进
opt_level   = 0
# 调试信息：0=无, 1=DWARF
debug_info  = 0
```

| 段 | 键 | 对应 `g_config` 字段 |
| --- | --- | --- |
| `[features]` | `vla` | `enable_vla` |
| | `complex` | `enable_complex` |
| | `wchar` | `enable_wchar` |
| | `trigraph` | `enable_trigraph` |
| | `fpu_hw` | `enable_fpu_hw` |
| | `dwarf` | `enable_dwarf` |
| | `opt_constfold` | `enable_opt_constfold` |
| | `opt_dce` | `enable_opt_dce` |
| | `opt_regalloc` | `enable_opt_regalloc` |
| `[general]` | `opt_level` | `opt_level`（0/1/2） |
| | `debug_info` | `debug_info`（0/1） |

### 7.4 命令行参数

| 参数 | 作用 |
| --- | --- |
| `-O0` / `-O1` / `-O2` | 优化级别，覆盖 `opt_level` |
| `-g` | 开启 DWARF 调试信息，等价 `debug_info=1` |
| `-f<feature>` | 开启特性，`<feature>` 取 `vla/complex/wchar/trigraph/fpu_hw/dwarf/opt_constfold/opt_dce/...` |
| `-fno-<feature>` | 关闭特性 |
| `-config <file>` | 指定配置文件路径 |

示例：

```bash
# 关闭硬件 FPU，开启 -O1 优化
arkcc app.c -target arm -fno-fpu_hw -O1 -S -o app.s

# 用自定义配置文件并生成调试信息
arkcc app.c -config myarkcc.cfg -g -target arm -o app.bin

# 只开常量折叠，关 DCE
arkcc app.c -target c -fopt_constfold -fno-opt_dce -o app.gen.c
```

### 7.5 `ArkccConfig` 结构体（`include/config.h`）

运行时配置集中存于全局 `g_config`：

```c
typedef struct {
    int enable_vla;
    int enable_complex;
    int enable_wchar;
    int enable_trigraph;
    int enable_fpu_hw;
    int enable_dwarf;
    int enable_opt_constfold;
    int enable_opt_dce;
    int enable_opt_regalloc;
    int opt_level;          /* 0=无优化, 1=基础, 2=激进 */
    int debug_info;         /* 0=无, 1=DWARF */
    const char *config_file; /* 配置文件路径 */
} ArkccConfig;

extern ArkccConfig g_config;
```

API：`config_init()` / `config_load_file(path)` / `config_apply_args(argc,argv)` / `config_print()`，实现见 `src/config.c`。

---

## 8 优化 Pass

`src/opt.c` + `include/opt.h` 实现 IR 级优化，运行时机为 irgen 完成后、后端代码生成前。各 Pass 同时受编译期 `ARKCC_FEATURE_OPT_*` 宏与运行时 `g_config.enable_opt_*` / `opt_level` 守护。

入口：

```c
void opt_run(IrProgram *prog, int level);
```

`level` 取自 `g_config.opt_level`（`-O0/-O1/-O2`）。`level >= 1` 时启用常量折叠 + DCE；`level == 2` 目前同 1。各 Pass 内部再按 `g_config.enable_opt_*` 二次守护。

### 8.1 常量折叠（`opt_constfold_func`）

匹配栈式 IR 中的三连模式：

```
PUSH_INT a
PUSH_INT b
BINARY op      ; aux 低 8 位为 TOK_xxx，0x100 位为无符号标记
```

折叠为单条 `PUSH_INT (a op b)`，后两条置 `IR_NOP`，再统一压缩。

- 支持全部算术/比较/逻辑/位运算符；
- **除零/模零不折叠**（保留运行时行为）；
- 多趟扫描至不动点（上限 8 趟），支持级联折叠 `(1+2)*3`。

### 8.2 死代码消除（`opt_dce_func`）

删除不可达指令：遇到 `IR_RETURN` / `IR_JMP` / `IR_JMP_NAMED` 后，到下一个 `IR_LABEL` / `IR_LABEL_NAMED` 之前的指令全部置 `IR_NOP`，再压缩。保留 `IR_FUNC_BEGIN` / `IR_FUNC_END` 不动。

### 8.3 使用方法

```bash
# 默认（opt_level=0）不优化
arkcc app.c -target c -o app.gen.c

# -O1 启用常量折叠 + DCE
arkcc app.c -target c -O1 -o app.gen.c

# 仅常量折叠，关 DCE
arkcc app.c -target c -O1 -fno-opt_dce -o app.gen.c
```

验证测试：`examples/test_opt.c`（期望退出码 42）。

---

## 9 在 Windows 上做测试

### 7.1 c 后端工作流

```powershell
.\arkcc.exe examples\struct_test.c -target c -S -o out.gen.c
gcc out.gen.c -o out.exe
.\out.exe
```

### 9.2 多文件链接

```powershell
.\arkcc.exe main.c -target c -S -o main.gen.c
.\arkcc.exe lib.c -target c -S -o lib.gen.c
gcc main.gen.c lib.gen.c -o app.exe
```

### 7.3 汇编文件

```powershell
.\arkcc.exe examples\test_hello.s -target arm -o hello.bin
```

### 7.4 自动化测试

```powershell
powershell -ExecutionPolicy Bypass -File examples\run_tests.ps1
```

56 个测试：ARM 汇编生成 + C 后端编译运行，全部通过。

---

## 10 STM32H743 + Keil MDK 工程

工程位于 `mdk/STM32H743_ArkCC/`。

| 项 | 值 |
| --- | --- |
| 芯片 | STM32H743VIT6（Cortex-M7, 2 MB Flash, 1 MB SRAM） |
| 编译器 | ARM Compiler 6 (armclang) |
| 仅集成 ARM 后端 | 节省 Flash |
| Scatter | `.ark_heap`/`.ark_code` 段映射到 AXI SRAM |

详见工程目录下的 `README.md`。

---

## 11 代码组织与移植指南

### 11.1 平台抽象层

仅两个接口：
- `platform.h`：`ark_log()` / `ark_abort()`
- `flash_fs.h`：`fs_read_file()`

### 11.2 移植到新平台

1. 复制 `port/host/` 为 `port/<myplat>/`
2. 实现输出和文件读取
3. 加入构建脚本

不需要碰 `src/`。

---

## 12 扩展开发指南

### 12.1 新增关键字

1. `common.h` 加 `TOK_XXX`
2. `lexer.c` 的 `g_keywords[]` 加映射
3. `parser.c` 接住

### 10.2 新增 IR 指令

1. `common.h` 加 `IR_XXX`
2. `ir.c` 的 `ir_op_name()` 加名字
3. `irgen.c` 发出
4. 各后端的 switch case 加处理

### 12.3 新增后端

1. `mkdir src/backend/<name>`
2. 实现 `backend_<name>.c`
3. `backend.h` 声明
4. `registry.c` 注册
5. `make`

---

## 13 标准库子集

目录：`stdlib/include/` 与 `stdlib/src/`

| 头文件 | 提供 |
| --- | --- |
| `stdint.h` | `int8_t..int64_t / uint8_t..uint64_t` |
| `stdbool.h` | `bool true false` |
| `stddef.h` | `size_t NULL ptrdiff_t` |
| `stdarg.h` | `va_list va_start va_arg va_end` |
| `string.h` | `strlen strcmp strcpy memset memcpy memmove memcmp` |
| `stdio.h` | `printf puts putchar` |
| `stdlib.h` | `abort exit malloc free` |
| `math.h` | `M_PI` 等常量 + `fabs sqrt floor ceil fmod sin cos pow` |
| `setjmp.h` | `jmp_buf setjmp longjmp` |

### 13.1 STM32 工程链接 `printf` / `putchar`

C 后端走宿主 libc，无需额外文件。**ARM 后端在 STM32 等裸机平台**需要把
以下源文件加入工程：

| 源文件 | 作用 |
| --- | --- |
| `stdlib/src/printf.c` | 精简版 `printf`，支持 `%d/%u/%x/%X/%s/%c/%p/%%` + 宽度/0 填充；64 位 `long long` 参数不截断 |
| `stdlib/src/putchar_default.c` | `putchar` 弱默认实现（什么也不做） |
| `stdlib/src/string.c` | `memcpy/memset/memmove/memcmp/strlen/strcpy/strcmp` |
| `stdlib/src/math.c` | 可选，提供 `sin/cos/sqrt/pow/fabs/floor/ceil/fmod` |
| `stdlib/src/setjmp.c` | host 测试用可移植简化实现；ARM 裸机需汇编实现 |

`putchar` 重定向到 UART 的示例：

```c
/* main.c 中提供强符号，覆盖 putchar_default.c 中的弱定义 */
int putchar(int c) {
    while (!(USART1->SR & USART_SR_TXE)) ;
    USART1->DR = (uint8_t)c;
    return c;
}
```

### 13.2 `math.c` 精度说明

`stdlib/src/math.c` 提供控制算法常用的基础函数：

- `fabs`：精确
- `sqrt`：牛顿迭代 20 次，相对误差 < 1e-12
- `floor/ceil`：仅对 `[-LONG_MAX, LONG_MAX]` 范围有效
- `fmod`：仅对常用范围有效
- `sin/cos`：泰勒展开，适用于控制算法常规精度场景
- `pow`：基于 `exp/log` 的简化实现

`M_PI` 等常用常量在 `math.h` 中显式定义。需要 `tan/exp/log/atan` 等更高精度函数，请改用 **newlib** 或 **CMSIS DSP**。

### 13.3 `setjmp.c` 说明

- `setjmp.h` 定义 `jmp_buf`（`int[20]`，80 字节，足够保存 ARM 的 r4-r11、sp、lr、pc）。
- `stdlib/src/setjmp.c` 是 host 测试用的可移植简化实现，转发到宿主 `setjmp/longjmp`。
- **ARM 裸机目标**需要汇编实现：保存 r4-r11、sp、lr 等到 `jmp_buf`，`longjmp` 时恢复并跳转。`stdlib/src/setjmp.c` 不覆盖 ARM 场景。
- 编译器把 `setjmp/longjmp` 当作普通函数调用处理，无需特殊 IR。

---

## 14 常见问题 FAQ

**Q1：能编译 Keil/MDK 写的 STM32 工程吗？**
A：支持 C99 + 完整 armcc 兼容扩展（`__svc/__irq/__weak/__naked/__packed/__align/__at/__forceinline/__asm` 函数体/全套 `__attribute__`/全套 `#pragma`/预定义宏/匿名 union）。HAL/CMSIS 寄存器定义、startup 文件、中断向量表均可直接编译。

**Q2：`__irq` 函数怎么生成？**
A：ARM 后端自动生成中断序言 `PUSH {r0-r3,r12,lr}` 和结语 `POP {r0-r3,r12,pc}`。

**Q3：浮点在 STM32 上怎么工作？**
A：默认走硬件 FPU（VFP 指令 `VADD.F32/F64`/`VMUL`/`VCVT`/`VCMP` 等）；用 `-fno-fpu_hw` 或配置 `fpu_hw=0` 可回退到 `__aeabi_f*`/`__aeabi_d*` 软浮点桩（`double` 真 64 位精度），需链接 newlib 软浮点库或自行实现桩函数。

**Q4：`.s` 文件怎么编译？**
A：`arkcc file.s -target arm -o file.bin`，跳过前端直接汇编。

**Q5：结构体按值传递怎么实现？**
A：通过隐藏指针参数——调用方在栈上分配空间，传地址给被调方。

**Q6：`__asm void fn() {...}` 整函数体汇编怎么用？**
A：函数体由汇编字符串构成，直接透传到生成的 `.s`。适用于 startup、向量表、底层原子操作。详见 5.8。

**Q7：`constructor`/`destructor` 属性怎么生效？**
A：ARM 后端把 `constructor` 函数指针放入 `.init_array` 段，`destructor` 放入 `.fini_array` 段。C 运行时（如 `__libc_init_array`）会在 `main` 前后遍历执行。

**Q8：多于 4 个参数的函数调用符合 AAPCS 吗？**
A：符合。严格 AAPCS，前 4 个参数走 r0-r3，多余参数走栈，GETARG/CALL 正确处理。

**Q9：怎么开启优化？**
A：`-O1` 启用 IR 级常量折叠 + 死代码消除（`src/opt.c`）；`-O0` 关闭。也可在 `arkcc.cfg` 中设 `opt_level=1`。详见第 8 章。

**Q10：怎么生成调试信息？**
A：加 `-g`，ARM 后端会发射 DWARF 伪指令（`.file/.loc/.cfi_startproc/.cfi_endproc/.size`）。也可在 `arkcc.cfg` 中设 `debug_info=1` 或 `dwarf=1`。

**Q11：怎么裁切特性？**
A：三层配置（详见第 7 章）：编译期改 `include/arkcc_config.h` 的 `ARKCC_FEATURE_*` 宏；运行时改 `arkcc.cfg`；命令行用 `-fno-<feature>`。例如 `-fno-fpu_hw` 关硬件 FPU，`-fno-vla` 关变长数组。

**Q12：VLA 变长数组怎么实现？**
A：`int a[n]` 通过 `IR_ALLOCA` 在栈上动态分配（8 字节对齐，`SUB sp, sp, r0`），压入首地址供后续访问。

**Q13：`_Complex` 复数怎么处理？**
A：解析 `_Complex double`/`_Complex float` 类型并透传给后端（C 后端交给 host gcc，`sizeof(_Complex double)==16`）。

---

## 15 已知限制

arkcc v0.6.0 已实现完整 C99 + armcc 兼容，剩余限制均为边缘场景：

- 扩展内联汇编的操作数替换：C 后端完整透传，ARM 后端仅文本透传
- ARM 后端聚合全局初始化：预留 `.zero` 空间，运行时由 main 中代码初始化
- `setjmp/longjmp` 在 ARM 裸机目标需汇编实现（host 测试用 `stdlib/src/setjmp.c` 可移植版本）
- `_Imaginary` 虚数类型：未实现（`_Complex` 复数已支持）
- 寄存器分配 Pass：实验性，默认关闭（`ARKCC_FEATURE_OPT_REGALLOC=0`）

v0.6.0 已解决的旧限制（仅供参考）：

- ~~VLA（运行时变长数组）~~：已支持，`IR_ALLOCA` 栈动态分配
- ~~硬件 FPU 指令（VFP）~~：已支持，`VADD/VMUL/VCVT/VCMP` 等原生指令，默认开启
- ~~`_Complex` 复数~~：已支持，透传给 gcc
- ~~宽字符 / trigraph~~：已支持 `wchar_t`/`L"..."`/`L'...'` + 9 个 C99 三元组
- ~~DWARF 调试信息~~：已支持 `-g` 生成 `.file/.loc/.cfi/.size`
- ~~优化 Pass~~：已支持 `-O1` 常量折叠 + 死代码消除（`src/opt.c`）

v0.5.0 已解决的旧限制（仅供参考）：

- ~~ARM 后端 `double` 精度~~：已支持 `__aeabi_d*` 双精度桩，`double` 真 64 位精度
- ~~隐式类型转换~~：已完整实现 usual arithmetic conversions + 整数提升
- ~~全局变量初值常量表达式~~：已支持常量表达式折叠（`eval_const_expr`），含字面量算术、`sizeof`、一元/二元/三目、enum
- ~~数组维度仅支持字面量~~：已支持常量表达式维度（`int arr[SIZE+2]`、`int arr[3*sizeof(int)]`）
- ~~`printf` 64 位参数截断~~：已修复，`long long` 正确传递
- ~~`>4` 参数调用约定~~：已实现严格 AAPCS，多余参数走栈

---

## 16 附录：内部数据流

```
源代码 .c / .s
   |
   v
(.s? ----> 直接 assemble ----> .bin)
   |
   v
+--------+      #include 展开、#define 替换、条件编译、#pragma pack、trigraph 替换
| preproc|
+--------+
   |
   v
+--------+      字符 -> Token
| lexer  |
+--------+
   |
   v
+--------+      递归下降，建 AST（含 __irq/__weak/__svc/__packed/__align/__at/__asm/__attribute__）
| parser |
+--------+
   |
   v
+--------+      符号表、类型推导、位域布局、属性注册
|  sema  |
+--------+
   |
   v
+--------+      AST -> 栈式 IR（IR_DIV/IR_64BINARY/IR_MEMCPY/IR_SVC/IR_ALLOCA 等）
| irgen  |
+--------+
   |
   v
+--------+      IR 级优化（-O1）：常量折叠 + 死代码消除
|  opt   |
+--------+
   |
   v
+-----------+
| backend.* |--- emit_asm  -> 文本汇编 / .gen.c（可选 DWARF 调试信息 + 硬件 FPU）
|           |--- assemble  -> 机器码（arm 完整实现）
|           |--- link      -> BL 重定位（arm）
+-----------+
   |
   v
.bin / .S / .gen.c / 跳转执行
```
