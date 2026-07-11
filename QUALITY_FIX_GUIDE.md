# 代码质量审查：修复指导（供其他 AI 使用）

> 日期：2026-07-11
> 编码：UTF-8（无 BOM）
> 背景：有人提出 11 个疑似 bug，已逐条到源码验证，本文件指导后续修复

---

## 0 总览

| 编号 | 声称的问题 | 验证结果 | 严重程度 | 需要修吗 |
| --- | --- | --- | --- | --- |
| Q1a | 宏定义缓冲区溢出 | 部分存在（有长度检查不会溢出，但静默截断产生错误代码） | Medium | ✅ 修 |
| Q1b | 重定位写入越界 | 确实无边界检查 | Low | ✅ 修 |
| Q2a | LLONG_MIN 取反 UB | 确实是 UB | Low | ✅ 修 |
| Q2b | 分支偏移溢出 | 理论存在但不可触发（buf 最大 256KB，差值远不达 INT_MAX） | Not a bug | ❌ 不修 |
| Q3a | 间接 void 调用栈不平衡 | 误判（三后端均保守 push，POP 是必需的） | Not a bug | ❌ 不修 |
| Q3b | 重复符号静默忽略 | 确实无警告 | Low | ✅ 修 |
| Q3c | 除零静默处理 | 确实返回 0 | Low | 可选 |
| Q4a | 路径遍历 | 确实未过滤 `..` | Low | 可选 |
| Q4b | #pragma location 地址注入 | 误判（armcc 兼容的嵌入式标准功能） | Not a bug | ❌ 不修 |
| Q5a | 全局状态不可重入 | 确实约 70 个全局变量 | Low（设计权衡） | ❌ 不修 |
| Q5b | mem_pool_free LIFO | 确实仅 LIFO | Low（bump allocator 标准） | ❌ 不修 |

**结论：4 个需要修（Q1a/Q1b/Q2a/Q3b），2 个可选修（Q3c/Q4a），5 个不用修。**

---

## 1 需要修复的问题（按优先级排序）

### Q1a [Medium] 宏定义静默截断

#### 文件
`src/preproc.c` 第 695 行和第 732 行

#### 现状
```c
char body[16384];   /* line 695 */
int  bl = 0;
/* ... */
while (*q && *q != '\n' && bl < 16383) {   /* line 732: 有长度检查，不会溢出 */
    body[bl++] = *q++;
}
/* line 761: 截断后静默消费剩余部分，无警告 */
while (*q) { /* consume rest */ }
```

#### 问题
宏体通过 `\` 换行拼接超过 16KB 后，被静默截断。截断后的 body 直接注册为宏，会产生错误代码，但用户得不到任何提示。`buf[1024]`（第 420 行）有同样问题。

#### 修复方案
在第 732 行的 while 循环之后，添加截断检测和警告：
```c
while (*q && *q != '\n' && bl < 16383) {
    body[bl++] = *q++;
}
if (bl >= 16383 && *q && *q != '\n') {
    ark_log("[preproc] warning: macro body truncated at 16383 bytes\n");
    while (*q && *q != '\n') q++;  /* consume rest */
}
```
对 `buf[1024]`（第 420 行附近）做同样处理。

#### 验证
创建一个超过 16KB 的宏定义，编译时应看到警告。

---

### Q2a [Low] LLONG_MIN 取反未定义行为

#### 文件
`src/irgen.c` 第 41-43 行（`sb_putd` 函数）

#### 现状
```c
static void sb_putd(StrBuf *b, long long v) {
    char tmp[24]; int n = 0; unsigned long long u; int neg = 0; int i;
    if (v < 0) { neg = 1; u = (unsigned long long)(-v); } else u = (unsigned long long)v;
```

#### 问题
当 `v == LLONG_MIN`（-9223372036854775808）时，`-v` 是有符号整数溢出，属于 C 标准未定义行为。在二进制补码平台上实际结果正确，但严格来说是 UB。

#### 修复方案
先转无符号再取反：
```c
if (v < 0) { neg = 1; u = -(unsigned long long)v; } else u = (unsigned long long)v;
```

#### 验证
```c
long long x = -9223372036854775808LL;
int main(void) { return x < 0 ? 1 : 0; }
```
编译运行应返回 1，生成的 .gen.c 中应看到正确的负数序列化。

---

### Q3b [Low] 重复符号静默忽略

#### 文件
`src/compiler.c` 第 127 行（`ld_add_sym` 函数）

#### 现状
```c
static void ld_add_sym(const char *name, int offset, int is_weak) {
    /* ... */
    if (idx >= 0) return;  /* line 127: duplicate (same strength), keep first - 无警告 */
    /* ... */
}
```

#### 问题
两个同名 strong symbol 相遇时，直接 return 保留第一个，无任何警告。C 标准中多个外部定义是 UB，其他编译器（gcc/clang）会报 error。这掩盖了拼写错误导致的多重定义。

#### 修复方案
在第 127 行添加警告：
```c
if (idx >= 0) {
    if (!g_ld_syms[idx].is_weak && !is_weak) {
        ark_log("[link] warning: duplicate strong symbol '%s', using first definition\n", name);
    }
    return;
}
```

#### 验证
创建两个 .c 文件都定义 `int foo = 1;`，链接时应看到警告。

---

### Q1b [Low] 重定位写入越界

#### 文件
`src/compiler.c` 第 152 行（`ld_patch_ref` 函数）

#### 现状
```c
static void ld_patch_ref(unsigned char *code, int pc, int target, int type) {
    if (type == 4) {
        code[pc]     = (unsigned char)(target & 0xFF);        /* 无 pc 边界检查 */
        code[pc + 1] = (unsigned char)((target >> 8) & 0xFF);
        code[pc + 2] = (unsigned char)((target >> 16) & 0xFF);
        code[pc + 3] = (unsigned char)((target >> 24) & 0xFF);
        return;
    }
    /* ... */
}
```

#### 问题
`pc` 来自对象文件的重定位表（`reloc_off = rd_le32(up + pos)`），未经校验。恶意构造的 `.ark_obj` 文件可使 `pc` 越出 code 缓冲区。正常编译器自身产出的对象文件不会触发，但防御性编程应加检查。

#### 修复方案
添加 `pc` 边界检查。需要知道 code 缓冲区大小，可在函数参数中传入 `code_size`：
```c
static void ld_patch_ref(unsigned char *code, int code_size, int pc, int target, int type) {
    if (pc < 0 || pc + 4 > code_size) {
        ark_log("[link] error: relocation offset %d out of bounds (code size %d)\n", pc, code_size);
        return;
    }
    /* ... 原有写入逻辑 ... */
}
```
调用处（第 306 行）传入 `out_len`（已写入的代码长度）。

#### 验证
手动构造一个 reloc_off 超大的 .ark_obj 文件，应看到错误而非崩溃。

---

## 2 可选修复的问题

### Q3c [Low] 除零静默返回 0

#### 文件
`src/preproc.c` 第 385 行和第 391 行

#### 现状
```c
case 12: lhs = rhs ? lhs / rhs : 0; break;   /* 除零返回 0 */
case 18: lhs = rhs ? lhs % rhs : 0; break;   /* 模零返回 0 */
```

#### 问题
`#if` 表达式中除零/模零返回 0 而非报错。C99 6.10.1 规定这是 UB，gcc/clang 会报 error。

#### 修复方案（可选）
```c
case 12: if (rhs == 0) { ark_log("[preproc] error: division by zero in #if\n"); lhs = 0; } else lhs = lhs / rhs; break;
```
或者保持现状 -- 对嵌入式编译器来说，返回 0 不崩溃是可接受的便利性设计。

---

### Q4a [Low] 路径遍历

#### 文件
`src/preproc.c` 第 236-251 行（`read_include` 函数）

#### 现状
`#include` 路径直接传给 `fs_read_file`，未过滤 `..`。

#### 问题
`#include "../../../../etc/passwd"` 可读取任意用户可读文件。但编译器本身就需要以用户权限读取文件，这在编译不可信代码时才有安全意义。

#### 修复方案（可选）
如果需要处理不可信源代码：
```c
static int has_path_traversal(const char *path) {
    const char *p = path;
    while (p[0] == '.' && p[1] == '.') {
        if (p[2] == '/' || p[2] == '\\' || p[2] == '\0') return 1;
        p += 2;
    }
    return 0;
}
```
在 `read_include` 中调用此检查。如果只是编译自己的代码，可以不修。

---

## 3 不需要修复的问题（误判说明）

### Q2b 分支偏移溢出 -- 不可触发

`offset = target - pc - 4` 中，`target` 和 `pc` 都是 `out_buf` 内偏移量，`out_buf` 最大 256KB（host）/ 4KB（STM32）。差值绝对不可能接近 `INT_MAX`（约 2GB）。Thumb-2 的 BL 指令也只有 ±16MB 跳转范围。理论存在但实际不可达。

### Q3a 间接 void 调用栈不平衡 -- 误判

三个后端（ARM/x86/C）对间接调用（`name[0]=='?'`）都保守地 push 返回值：
- ARM 后端 `backend_arm.c:1944`：`is_void_ret` 仅在 `!is_indirect` 时设置
- x86 后端 `backend_x86_64.c:887`：同样逻辑
- C 后端 `backend_c.c:1882`：注释明确"indirect calls conservatively push"

因此 `irgen_discard_result` 中的 `IR_POP` 是必需的，栈是平衡的。irgen.c:1030 注释也说明："Indirect void calls still conservatively push, so they need the POP."

### Q4b #pragma location 地址注入 -- 正常功能

`#pragma location=addr` 是 armcc/Keil 兼容的嵌入式标准功能，用于将变量定位到外设寄存器地址（如 `0x40021000` GPIO）、Flash 扇区等。所有嵌入式编译器（armcc/GCC/IAR）都支持类似功能。这不是安全隐患，而是设计特性。

### Q5a 全局状态不可重入 -- 设计权衡

约 70 个 static 全局变量确实使编译器不可重入、不支持多线程。但这是嵌入式编译器的常见设计权衡（节省栈空间、避免动态分配），不能算 bug。

### Q5b mem_pool_free LIFO -- bump allocator 标准

bump allocator 仅支持 LIFO 释放是标准行为，对编译器这种"分配后不释放"的使用模式是合理设计。

---

## 4 修复后的验证步骤

```powershell
# 1. 构建
make clean; make
# 应无 warning

# 2. 全量测试
powershell -ExecutionPolicy Bypass -File examples\run_tests.ps1
# 应显示 70 passed, 0 failed

# 3. armcc5 构建
powershell -ExecutionPolicy Bypass -File build_stm32_armcc.ps1
# 应显示 BUILD SUCCESSFUL

# 4. 提交
git add -A
git commit -m "fix(quality): add truncation warning, fix LLONG_MIN UB, add duplicate symbol warning, add reloc bounds check"
git push
```

---

## 5 优先级总结

```
必须修（4 个，全部 Low/Medium）：
  Q1a  preproc.c   宏定义静默截断 -> 加 ark_log 警告
  Q2a  irgen.c     LLONG_MIN 取反 UB -> 先转无符号再取反
  Q3b  compiler.c  重复符号静默忽略 -> 加 ark_log 警告
  Q1b  compiler.c  重定位写入越界 -> 加 pc 边界检查

可选修（2 个，Low）：
  Q3c  preproc.c   除零静默返回 0 -> 可报 error 或保持现状
  Q4a  preproc.c   路径遍历 -> 仅在编译不可信代码时需要

不用修（5 个）：
  Q2b  分支偏移溢出 -- 不可触发
  Q3a  间接 void 调用 -- 误判，栈是平衡的
  Q4b  #pragma location -- 嵌入式标准功能
  Q5a  全局状态 -- 设计权衡
  Q5b  mem_pool_free LIFO -- bump allocator 标准
```
