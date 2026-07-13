# Ark C Compiler Bug 报告（供修复用）

> 生成日期：2026-07-11
> 基线提交：`ce826c8` + getenv 修复（已合入工作区）
> 编码：UTF-8（无 BOM）
> 目的：列出当前代码中所有已确认的 bug，供后续 AI/开发者逐一修复

---

## 0 修复优先级总览

| 优先级 | 编号 | 简述 | 模块 |
| --- | --- | --- | --- |
| P0-阻断 | B01 | x86_64 后端需改为 x86 32 位（明确要求） | backend/x86_64 |
| P0-阻断 | B02 | sb_putf 对极小浮点数输出 "0.0"，数值完全丢失 | irgen.c |
| P0-阻断 | B03 | sb_putf 对大浮点数输出非法 `0x<位模式>` | irgen.c |
| P1-高 | B04 | STM32 ark_log 不支持 `%08X` 等带宽度/标志的格式 | platform_stm32.c |
| P1-高 | B05 | 测试脚本不验证运行退出码，9 个崩溃被误报通过 | run_tests.ps1 |
| P1-高 | B06 | C 后端 9 个测试崩溃（0xC0000005 访问违规） | backend/c |
| P2-中 | B07 | scatter.c 大文件静默截断无检测 | scatter.c |
| P2-中 | B08 | g_arm_dump_syms 未声明 extern 且从未被设置 | backend_arm.c |
| P2-中 | B09 | scatter.c 依赖 strstr/ctype 函数，freestanding 缺实现 | scatter.c |
| P2-中 | B10 | STM32 上 scatter 解析消耗 50% 内存池 | scatter.c |
| P3-低 | B11 | sb_putf 无科学记数法，中等大小数精度丢失 | irgen.c |
| P3-低 | B12 | put_fmt 的 %d 对 INT_MIN 未定义行为 | scatter.c |
| P3-低 | B13 | fs_list_files 使用 ark_log 不支持的格式 | flash_fs_stm32.c |

---

## B01 [P0-阻断] x86_64 后端需改为 x86 32 位

### 要求
> "不实现 x64，只实现 x86 即可，不需要 64 位"

### 当前状态
- 文件：`src/backend/x86_64/backend_x86_64.c`（1467 行）
- 注册名：`"x86_64"`，triple：`"x86_64-linux-sysv"` / `"x86_64-pc-windows-msvc"`
- `pointer_size = 8`
- **实验性状态**：能发射汇编文本，但 assemble/link 都是 pass-through stub，从未被实际组装/执行验证
- 测试仅做 `-S` 语法检查（`run_tests_x86.ps1`、`Makefile test-x86`），不组装不运行

### 64 位特有依赖统计
- 64 位寄存器引用（rax/rbx/.../r15）：423 次
- `movabs`（64 位立即数）：41 次
- `rip` 相对寻址：含在上 41 次中
- `r8`-`r15` 寄存器：32 位 x86 不存在
- `.quad` 数据指令：16 次（指针尺寸）
- `qword ptr` 尺寸前缀：16 次

### 改造方案（二选一）

#### 方案 A：原地改造为 x86 32 位（工作量中等偏大）
需修改的点：
1. 后端注册：`name`→`"x86"`，`triple`→`"i386-linux-cdecl"`，`pointer_size`→`4`
2. 删除 MSVC x64 变体（`g_x86_backend_msvc`、`ark_backend_x86_64_msvc()`、`ARK_ABI_MSVC`）
3. 重写 `arg_reg()`/`arg_reg_count()`：32 位 cdecl 无寄存器传参，返回 0
4. 重写 `stack_arg_offset()`：栈参数从 `[ebp+8]` 开始
5. 重写函数序言：`push ebp; mov ebp, esp; sub esp, N`
6. 全局寄存器重命名：`rax`→`eax`、`rdi`→`edi`、`rsi`→`esi`、`rdx`→`edx`、`rcx`→`ecx`、`rbp`→`ebp`、`rsp`→`esp`
7. `qword ptr` → `dword ptr`（指针尺寸操作）
8. 重写全局变量访问：`mov rax, [rip+sym]` → `mov eax, [sym]`（绝对寻址）
9. 重写 IR_CALL 参数传递：所有参数 `push`（右到左），调用后 `add esp, N`
10. 重写浮点：`movq xmm, rax` → 栈中转或 x87 `fld`/`fstp`
11. 替换 64 位指令：`movabs`→拆分、`cqo`→`cdq`、`movsxd`→删除、`.quad`→`.long`
12. 重写 sret：通过栈首位置传递而非寄存器
13. 更新所有引用：Makefile、registry.c、backend.h、main.c、arkcc_config.h、README.md、docs/MANUAL.md、run_tests_x86.ps1、bootstrap_x86/
14. 添加实际组装+执行测试（`gcc -m32` 或 `as --32`）

#### 方案 B：删除 x86_64 后端（推荐，如果聚焦嵌入式）
- 删除 `src/backend/x86_64/` 目录
- 从 registry.c、backend.h、arkcc_config.h、Makefile 中移除引用
- 更新文档
- 保留 ARM + C + RISC-V 三个后端
- 理由：当前从未实际工作，STM32 部署已禁用，维护负担大于价值

### 建议
**方案 B（删除）** 更符合用户"不需要 64 位"的意图和项目聚焦嵌入式 ARM 的方向。如果未来需要 x86 主机自举，建议从头编写干净的 32 位后端，而非改造这个 1467 行的实验性 64 位代码。

### 涉及文件
- `src/backend/x86_64/backend_x86_64.c`
- `src/backend/registry.c:38-43`
- `include/backend.h:24-30,42,51-52`
- `include/arkcc_config.h:50`
- `src/main.c:26`
- `Makefile:37-40,56,62`
- `README.md`（多处）
- `docs/MANUAL.md`（多处）
- `run_tests_x86.ps1`
- `bootstrap_x86/`（整个目录）

---

## B02 [P0-阻断] sb_putf 对极小浮点数输出 "0.0"

### 文件
`src/irgen.c` 第 76-104 行（`sb_putf` 函数）

### 问题描述
`sb_putf` 不使用科学记数法。对于 `v = 1e-300`：
- `ip = (long long)1e-300 = 0`
- `frac = 1e-300`
- 17 次循环 `frac *= 10` 后值依次为 `1e-299 ... 1e-283`，全部 < 1.0，`d = 0`，输出 17 个 '0'
- 尾部零裁剪后变为 `"0.0"`

**全局 `double x = 1e-300;` 会被序列化为 `"0.0"`，数值完全丢失。**

### 影响范围
`sb_putf` 被 `serialize_const_expr`（irgen.c:133-142）调用，用于全局浮点变量初始化的 IR 文本序列化。影响所有 `< 1e-17` 的全局浮点常量。

### 修复建议
为极小值添加科学记数法分支：
```c
if (v != 0.0 && v < 1e-4) {
    /* 用科学记数法: e 之前的尾数用定点，指数用 e±N */
    /* 或者直接回退到十六进制浮点: 0x1.xxxxp-yyy */
}
```
或更简单：当 `ip == 0 && frac > 0 && 第一位小数 == 0` 时，切换到 `%.17e` 等价逻辑。

### 验证用例
```c
double a = 1e-300;
double b = 1e-20;
double c = 0.00001;
```
这些全局变量序列化后应能正确往返。

---

## B03 [P0-阻断] sb_putf 对大浮点数输出非法 `0x<位模式>`

### 文件
`src/irgen.c` 第 61-74 行

### 问题描述
对于 `v >= 9.2e18`（超出 `long long` 范围），函数输出 `0x` 后跟 IEEE 754 原始位模式的十六进制（如 `0x7e37e2c63bc8f`）。这**不是合法的 C 浮点常量**：
- C 十六进制浮点字面量格式为 `0x1.fp10`（带 `p` 指数）
- 当前输出会被解析为**整型常量**，导致类型错误

### 影响范围
全局 `double big = 1e20;` 等大数值初始化。

### 修复建议
对大数值使用科学记数法：
```c
if (v >= 9.2e18) {
    /* 输出科学记数法: <mantissa>e+<exp> */
    int exp = 0;
    while (v >= 10.0) { v /= 10.0; exp++; }
    /* 此时 1.0 <= v < 10.0，用定点输出尾数，再追加 e+exp */
}
```

### 验证用例
```c
double big = 1e20;
double bigger = 1e300;
double max = 1.7976931348623157e308;
```

---

## B04 [P1-高] STM32 ark_log 不支持带宽度/标志的格式说明符

### 文件
- `port/stm32/platform_stm32.c`（ark_log 实现）
- 调用方：`src/scatter.c:249,251`、`src/backend/arm/backend_arm.c:4482-4483`、`port/stm32/flash_fs_stm32.c:65`

### 问题描述
STM32 的 `ark_log` 仅支持 `%d`、`%x`、`%s`、`%c`。遇到以下格式时行为错误：
- `%08X`：`c='0'` 不匹配已知说明符，输出字面 `'0'`，**不消费参数**，后续 `'8'`、`'X'` 作普通字符
- `%-40s`：`c='-'` 输出字面 `'-'`，**不消费**字符串参数
- `%04X`：同 `%08X`
- `%u`：不支持
- `%-24s`：同 `%-40s`

### 具体错误位置

| 文件:行号 | 格式字符串 | STM32 输出 |
| --- | --- | --- |
| scatter.c:249 | `"LR %s @0x%08X\n"` | `"LR <name> @008X\n"`（地址缺失） |
| scatter.c:251 | `"  ER %s @0x%08X\n"` | 同上 |
| backend_arm.c:4482 | `"  %-40s 0x%04X (%d)\n"` | `"  -40s 004X (...)`（符号名/地址全错位） |
| flash_fs_stm32.c:65 | `"  %-24s  %u bytes\r\n"` | `"  -24s  u bytes\r\n"` |

### 修复建议（二选一）

#### 方案 A：增强 ark_log 支持宽度/标志
在 `platform_stm32.c` 的 `ark_log` 中解析宽度说明符（如 `%08X`、`%-40s`、`%04X`）和 `%u`。

#### 方案 B：修改调用方避免使用复杂格式
把 `%08X` 改为 `%X`，`%-40s` 改为 `%s`，`%u` 改为 `%d`。这是更简单的修复，但输出不规整。

### 涉及文件
- `port/stm32/platform_stm32.c`
- `src/scatter.c`（多处 ark_log 调用）
- `src/backend/arm/backend_arm.c:4482`
- `port/stm32/flash_fs_stm32.c:65`

---

## B05 [P1-高] 测试脚本不验证运行退出码

### 文件
`examples/run_tests.ps1` 第 57-61 行

### 问题描述
```powershell
& ".\$exe"
$rc = $LASTEXITCODE
Write-Host "  [c]   exit code = $rc"
$passed++   # <-- 无条件计为通过
```
9 个测试崩溃（退出码 `-1073741819` = 0xC0000005 访问违规）被误报为通过。

### 崩溃测试列表
1. test_fpu_hw.c
2. test_inline.c
3. test_many_args.c
4. test_printf_fix.c
5. test_pure.c
6. test_struct_byval.c
7. test_vla.c
8. typedef_test.c
9. va_test.c

### 修复建议
测试脚本应检查每个测试的期望退出码（通常在测试文件中用注释或约定标记），或至少把崩溃（负退出码）计为失败：
```powershell
if ($rc -lt 0 -or $rc -eq -1073741819) {
    Write-Host "  [c]   CRASHED"
    $failed++
    continue
}
```
更好的做法是每个测试文件配套一个 `.expected` 文件记录期望退出码。

---

## B06 [P1-高] C 后端 9 个测试崩溃（访问违规）

### 文件
`src/backend/c/backend_c.c`

### 问题描述
9 个测试用 `-target c` 生成 `.gen.c` 后用 gcc 编译运行，崩溃于 0xC0000005（访问违规）。全部与 sb_putf/put_fmt 无关（已验证：8 个零浮点，1 个仅局部 float）。

### 崩溃原因分类

| 测试 | 崩溃原因 |
| --- | --- |
| test_fpu_hw.c | C 后端 float 单精度函数 ABI（参数/返回值） |
| test_inline.c | C 后端内联/static 函数 codegen |
| test_many_args.c | C 后端 >4 栈参数传递 |
| test_printf_fix.c | C 后端 long long / 64 位 IR_CALL |
| test_pure.c | C 后端 `__pure` 属性处理 |
| test_struct_byval.c | C 后端 struct 按值传递/返回 |
| test_vla.c | C 后端 VLA 栈分配 |
| typedef_test.c | C 后端 typedef 复合类型 |
| va_test.c | C 后端变参 / 外部调用 |

### 修复建议
需系统性排查 `backend_c.c` 的栈帧管理、参数传递、函数返回值 codegen。建议：
1. 先修 test_inline.c（最简单：纯整数 static 函数）
2. 再修 test_many_args.c（栈参数）
3. 再修 test_struct_byval.c（struct byval）
4. test_vla.c 和 va_test.c 涉及栈动态调整，最后处理

### 证明与本次 semihosting 修改无关
`test_double_precision.c` 使用全局 `double pi = 3.14159265358979;`（直接经过 sb_putf）却正确返回 3141，反向证明 sb_putf 对正常范围 double 工作正常。

---

## B07 [P2-中] scatter.c 大文件静默截断无检测

### 文件
`src/scatter.c` 第 128-137 行（`scatter_parse_file`）、第 489-498 行（`linker_script_parse_file`）

### 问题描述
```c
int cap = ARK_SRC_BUF_SIZE;       // STM32: 32KB
src = (char *)mem_pool_alloc(cap);
read = fs_read_file(path, src, cap);
if (read <= 0) { ... return 1; }
src[read] = 0;
```
`fs_read_file` 在文件大于 `max_len - 1` 时静默截断。代码不检查 `read == cap - 1` 来判断是否截断。STM32 上 `ARK_SRC_BUF_SIZE` 为 32KB，大 scatter/ld 文件会被截断后解析器看到不完整脚本。

### 修复建议
添加截断检测：
```c
if (read >= cap - 1) {
    ark_log("[scatter] file too large (>= %d), truncated\n", cap - 1);
    return 1;
}
```

---

## B08 [P2-中] g_arm_dump_syms 未声明 extern 且从未被设置

### 文件
`src/backend/arm/backend_arm.c` 第 4444 行（定义）、第 4475 行（使用）

### 问题描述
1. `int g_arm_dump_syms = 0;` 是非 static 全局变量，但未在任何 `.h` 文件中 `extern` 声明
2. 整个代码库中没有任何地方将其设为非零值，STM32 符号表转储功能永远不可用（死代码）

### 修复建议
1. 在 `include/backend.h` 或新建头文件中添加 `extern int g_arm_dump_syms;`
2. 在 `mdk/STM32H743_ArkCC/User/main.c` 的 UART 命令处理中添加：
```c
if (strcmp(cmd, "debug syms") == 0) {
    g_arm_dump_syms = 1;
    ark_log("symbol dump enabled\n");
}
```

---

## B09 [P2-中] scatter.c 依赖 strstr/ctype 函数，freestanding 缺实现

### 文件
`src/scatter.c` 第 28-29 行（`#include <string.h>` 和 `<ctype.h>`）

### 问题描述
`scatter.c` 在 STM32 上被编译，且 `#include <string.h>` 和 `<ctype.h>` 未被 `#if` 保护：
- 使用 `strstr`（scatter.c:679,713,834-843）— 项目自带 `stdlib/src/string.c` 不提供
- 使用 `isspace`/`isalnum`/`isdigit`/`toupper`（共 22 处）

在 armcc5/MDK 路径下，Keil ARM C 库提供这些函数（通过 `__user_initial_stackheap` 重定向解决 semihosting）。但在纯 `ffreestanding-nostdlib` 的 gcc STM32 构建路径中，这些符号无定义。

### 修复建议
1. 在 `stdlib/src/string.c` 中添加 `strstr` 实现
2. 在 `stdlib/src/` 中新建 `ctype.c` 提供 `isspace`/`isalnum`/`isdigit`/`toupper`
3. 或在 `scatter.c` 中用内联实现替代这些函数

---

## B10 [P2-中] STM32 上 scatter 解析消耗 50% 内存池

### 文件
`src/scatter.c` 第 130 行

### 问题描述
STM32 上 `ARK_POOL_SIZE` 为 64KB，`ARK_SRC_BUF_SIZE` 为 32KB。单次 `scatter_parse_file` 调用 `mem_pool_alloc(32KB)` 消耗池的 50%。`mem_pool_alloc` 是 bump allocator 不释放内存。如果 `scatter_parse_file` 和 `linker_script_parse_file` 都被调用，仅源文件缓冲就消耗 64KB，立即耗尽内存池，触发 `ark_abort`。

### 修复建议
1. 减小 `ARK_SRC_BUF_SIZE`（STM32 profile）到 16KB 或 8KB
2. 或在 `scatter_free` 中真正归还内存（需要把 bump allocator 改为支持释放，或用独立缓冲区）
3. 或让 scatter 解析复用 `g_src` 缓冲区（compiler.c 中已有）而非新分配

---

## B11 [P3-低] sb_putf 无科学记数法，中等大小数精度丢失

### 文件
`src/irgen.c` 第 76-104 行

### 问题描述
原 `%.17g` 会在适当时候切换到科学记数法（如 `1.2345678901234567e+16`）。自定义版本始终使用定点表示。对于 `1.0000000000000001e16`：
- `ip = 10000000000000000`，`frac ≈ 0`（精度在 long long 转换中丢失）
- 输出 `"10000000000000000.0"` 而非精确值

不保证 double 往返精度。注释承认了这一点，但对于需要序列化-反序列化的场景是数据丢失。

### 修复建议
与 B02/B03 一起修复：为 sb_putf 添加完整的科学记数法支持，或回退到 `%.17g`（host 路径可用 snprintf，STM32 路径需自定义实现）。

---

## B12 [P3-低] put_fmt 的 %d 对 INT_MIN 未定义行为

### 文件
`src/scatter.c` 第 572 行

### 问题描述
```c
if (v < 0) { neg = 1; u = (unsigned int)(-v); } else u = (unsigned int)v;
```
当 `v == INT_MIN`（-2147483648）时，`-v` 是未定义行为。

### 修复建议
```c
if (v < 0) { neg = 1; u = (unsigned int)(-(unsigned int)v); }
```
当前所有 `put_fmt` 调用均不使用 `%d`（仅用 `%s` 和 `%X`），所以是理论性 bug。

---

## B13 [P3-低] fs_list_files 使用 ark_log 不支持的格式

### 文件
`port/stm32/flash_fs_stm32.c` 第 65 行

### 问题描述
```c
ark_log("  %-24s  %u bytes\r\n", (int)s_table[i].name, (int)s_table[i].size);
```
`%-24s` 和 `%u` 均不被 STM32 `ark_log` 支持。此外 `(int)s_table[i].name` 将 `char *` 指针截断为 `int`。

### 修复建议
改为 `ark_log("  %s  %d bytes\r\n", s_table[i].name, s_table[i].size);`
（与 B04 一起修复）

---

## 附录 A：已修复的 Bug

| 编号 | 简述 | 状态 |
| --- | --- | --- |
| B00 | getenv 隐式声明（移除 stdlib.h 但 host 路径仍调用 getenv） | ✅ 已修复：添加条件编译 `#if ARKCC_PROFILE != ARKCC_PROFILE_STM32_MIN #include <stdlib.h> #endif` |

---

## 附录 B：semihosting 扫描结论

STM32 编译路径中**没有未被 `#if` 保护的 semihosting 触发调用**。所有 stdio/stdlib 危险调用都通过以下三种机制之一隔离：
1. 文件级隔离：`main.c`、`backend/c/backend_c.c`、`port/host/*.c` 不参与 STM32 编译
2. `#if ARKCC_PROFILE` 保护：`backend_arm.c` 的 `getenv` 和 `<stdlib.h>`
3. 自定义替代实现：`scatter.c` 的 `put_fmt`、`irgen.c` 的 `sb_putf`

唯一残留依赖点：`scatter.c` 依赖 `strstr`/`<ctype.h>` 函数（见 B09）。

---

## 附录 C：验证方法

### 主机构建验证
```powershell
make clean; make
# 应无 warning，生成 arkcc.exe
```

### armcc5 STM32 构建验证
```powershell
powershell -ExecutionPolicy Bypass -File build_stm32_armcc.ps1
# 应输出 BUILD SUCCESSFUL
# Flash 148.59KB / DTCM 19.3KB / AXI 440KB
```

### 测试集验证
```powershell
powershell -ExecutionPolicy Bypass -File examples\run_tests.ps1
# 注意：当前 9 个崩溃被误报通过（见 B05）
# 修复 B05 后应显示真实失败数
```

### sb_putf 验证用例
```powershell
# 全局浮点初始化测试
echo 'double x = 1e-300; int main(void){ return (int)(x == 0.0); }' > test_small.c
.\arkcc.exe test_small.c -target c -S -o test_small.gen.c
gcc test_small.gen.c -o test_small.exe
.\test_small.exe; echo $LASTEXITCODE
# 若返回 0，说明 1e-300 没有被序列化为 0.0（正确）
# 若返回 1，说明 B02 仍存在
```
