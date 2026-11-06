# 从零写一个 C 编译器（arkc 逐代码实现教程）

> 目标读者：会写 C，但没写过编译器。
> 读完你应该能从空目录开始，写出一个能编译 `int main(void){ return 42; }` 的编译器，
> 然后按同一套骨架一路加到本仓库 arkc 的完整形态：C99 实用子集 → Thumb-2 机器码 →
> 可装载的镜像 → 以及最后把编译器自己编成固件跑在 STM32 上。
>
> 本文所有代码片段都来自本仓库（`src/`、`include/`），标注了文件与行号区间；
> 所有"输出"都是**真跑出来的**，标注了产生它的命令。
> 少数为了讲清概念而写的极简示意代码会明确标【示意代码】，不要当成仓库源码。

---

## 目录

- [第 0 章 先想清楚：编译器是什么、不是什么](#第-0-章-先想清楚编译器是什么不是什么)
- [第 1 章 全景：一条流水线与它的五种中间表示](#第-1-章-全景一条流水线与它的五种中间表示)
- [第 2 章 地基：内存池、诊断、平台层、开关](#第-2-章-地基内存池诊断平台层开关)
- [第 3 章 词法分析](#第-3-章-词法分析)
- [第 4 章 预处理器](#第-4-章-预处理器)
- [第 5 章 类型系统](#第-5-章-类型系统)
- [第 6 章 符号表与作用域](#第-6-章-符号表与作用域)
- [第 7 章 语法分析](#第-7-章-语法分析)
- [第 8 章 语义分析](#第-8-章-语义分析)
- [第 9 章 生成 IR](#第-9-章-生成-ir)
- [第 10 章 优化](#第-10-章-优化)
- [第 11 章 ARM 后端：IR → Thumb-2 汇编](#第-11-章-arm-后端ir--thumb-2-汇编)
- [第 12 章 汇编器：汇编文本 → 机器码](#第-12-章-汇编器汇编文本--机器码)
- [第 13 章 目标文件与链接](#第-13-章-目标文件与链接)
- [第 14 章 分散加载与镜像布局](#第-14-章-分散加载与镜像布局)
- [第 15 章 命令行驱动](#第-15-章-命令行驱动)
- [第 16 章 自托管：把编译器编成固件跑在板子上](#第-16-章-自托管把编译器编成固件跑在板子上)
- [第 17 章 怎么知道自己写对了](#第-17-章-怎么知道自己写对了)
- [第 18 章 练习路线：从 30 行到 3 万行](#第-18-章-练习路线从-30-行到-3-万行)
- [附录 A TokenKind / AST / IrOp 全表](#附录-a-tokenkind--ast--irop-全表)
- [附录 B 本编译器用到的 Thumb-2 编码速查](#附录-b-本编译器用到的-thumb-2-编码速查)
- [附录 C 术语表](#附录-c-术语表)
- [附录 D 已知限制（写文档时顺带查出来的）](#附录-d-已知限制写文档时顺带查出来的)

---

## 第 0 章 先想清楚：编译器是什么、不是什么

### 0.1 一句话定义

编译器是**一个把"字符串"变成"另一种字符串（或字节）"的纯函数**：

```
输入的 .c 文本  ──►  [ 你的编译器 ]  ──►  输出的 .s 文本 / .bin 字节
```

它没有魔法。它不"理解"程序，它只做三步：

1. **按规则切分并重组文本**（词法、语法）——得到一个结构（树）；
2. **按 C 标准给这个结构补上"没说出口的东西"**（隐式类型转换、隐式声明、对齐填充）；
3. **按目标 CPU 的编码手册，把结构翻译成一串字节**。

写完第 1 章你就会发现：本仓库 3 万行里，真正"聪明"的算法不超过 300 行，
其余全是**边界情况**。这也是为什么本教程强调"逐代码"——难点从来不是思路，
而是"`int *a[3]` 和 `int (*a)[3]` 到底哪个是数组"这种细节。

### 0.2 arkc 的三个约束（它们决定了后面所有设计）

这三个约束不是我想出来的，是项目要求倒推出来的，先接受它们，后面很多"奇怪"的
设计就都能解释了：

| 约束 | 后果 |
|---|---|
| **要能跑在 STM32H743 上**（1 MB RAM 的一部分、无操作系统、无 `stdio.h` 的 `printf`） | 不能依赖宿主 libc；内存要用自管池；不能有 `FILE*`；错误必须"报出来"而不是 `assert` |
| **要生成能直接在 Cortex-M 上跑的机器码**（不是汇编文本就完事） | 必须自带汇编器（文本→字节）、重定位、链接器、镜像布局 |
| **要和 armcc 5 的行为对齐**（老工程能不改代码编过） | 必须有 armcc 方言关键字（`__irq`/`__weak`/`__svc`/`__value_in_regs`…）、分散加载文件解析、诊断编码对齐 |

第三条会给你带来大量"看起来毫无必要"的代码。它们是真实需求，不是洁癖：
一个 2013 年写的 CMSIS 工程，改一行就会连锁失败。

### 0.3 本仓库的规模（心里有个数）

```
$ wc -l src/*.c src/backend/*/*.c include/*.h port/host/*.c | tail -1
  29697 total
```

| 文件 | 行数 | 干什么 |
|---|---:|---|
| `src/backend/arm/backend_arm.c` | 6284 | IR → Thumb-2 文本 + 汇编器 + 重定位表 |
| `src/irgen.c` | 3132 | AST → 栈式 IR（本项目最大的一块"业务逻辑"） |
| `src/parser.c` | 2597 | 递归下降语法分析 |
| `src/backend/x86_64/backend_x86_64.c` | 2515 | 第二个后端（用来在 PC 上验证前端） |
| `src/backend/c/backend_c.c` | 2251 | 第三个后端：把 IR 输出回 C（最强的调试手段） |
| `src/preproc.c` | 1740 | 预处理器 |
| `src/compiler.c` | 1704 | 驱动 + 目标文件写出 + 链接器 |
| `src/diag.c` | 1012 | 诊断系统（一条错误怎么变成那几个字节） |
| `src/lexer.c` | 1003 | 词法分析 |
| `src/scatter.c` | 935 | ARM 分散加载文件（.sct）解析 |
| `src/sema.c` | 798 | 语义分析 |
| `src/opt.c` | 753 | IR 优化 |
| `src/main.c` | 586 | 命令行 |
| `src/type.c` | 414 | 类型系统 |
| `src/config.c` | 388 | 运行期开关 |
| `src/ir.c` | 270 | IR 数据结构 |
| `src/ast.c` | 170 | AST 构造 |
| `src/memory.c` | 149 | bump 分配器 |
| `src/symtab.c` | 136 | 符号表 |

注意这个比例：**后端 > IR 生成 > 语法分析 > 其它**。这和教科书给人的印象相反
（教科书总把 parsing 当主角）。真实编译器里，前端解析只占 10%，剩下的都在
"生成正确的机器码"。

---

## 第 1 章 全景：一条流水线与它的五种中间表示

### 1.1 流水线长什么样

```
┌─────────┐   ┌────────┐   ┌───────┐   ┌──────┐   ┌───────┐   ┌─────────┐   ┌──────────┐
│ 源文件   │──►│预处理   │──►│词法   │──►│语法   │──►│语义   │──►│ IR 生成 │──►│ 优化      │
│ a.c     │   │preproc │   │lexer  │   │parser│   │sema  │   │ irgen  │   │ opt      │
└─────────┘   └────────┘   └───────┘   └──────┘   └───────┘   └─────────┘   └──────────┘
                   │            │          │          │           │              │
                文本            Token      AST        AST(带类型)  IrProgram      IrProgram
                   ▼            ▼          ▼          ▼           ▼              ▼
              ┌────────────────────────────────────────────────────────────────────┐
              │ 后端 backend：emit_asm → assemble → link                            │
              │   IR ──► .s 文本 ──► 机器码字节 ──► 镜像（+向量表/段布局）           │
              └────────────────────────────────────────────────────────────────────┘
```

五种中间表示，每个阶段只认上一种：

| 表示 | 数据类型 | 它回答了什么问题 |
|---|---|---|
| 文本 | `char *` | 用户写了什么 |
| Token 流 | `Token`（`include/lexer.h`） | 有哪些"词" |
| 语法树 | `AstNode`（`include/ast.h`） | 这些词怎么组成结构 |
| IR | `IrProgram`/`IrFunc`/`IrInst`（`include/ir.h`） | 计算步骤是什么顺序 |
| 机器码 | `unsigned char[]` | CPU 该执行哪些字节 |

**关键设计决策**：阶段之间只用**数据结构**通信，不共享全局状态。所以
`parse_program(Lexer*)` 只吃 Lexer 吐 AST；`irgen_program(AstNode*)` 只吃 AST 吐 IR。
这条纪律让你能单独测试任何一段。

### 1.2 主流程逐行

编译一个文件的全过程在 `src/compiler.c` 的 `ark_compile()`（第 618 行起）。
去掉链接模式和选项处理后，骨架就是下面这些（原样摘录，删掉了注释）：

```c
type_set_ptr_size(be->pointer_size);
irgen_set_64bit_slots(ark_streq(be->name, "c"));
lexer_init(&lex, preprocessed);
ast = parse_program(&lex);
if (!ast) return ARK_ERR_PARSE;
if (diag_errors() > 0) return ARK_ERR_PARSE;
sema_errs = sema_check(ast);
if (sema_errs > 0) return ARK_ERR_SEMA;
if (diag_errors() > 0) return ARK_ERR_SEMA;
ir = irgen_program(ast);
if (!ir) return ARK_ERR_IRGEN;
...
opt_run(ir, lvl);
asm_len = be->emit_asm(ir, g_asm, ARK_ASM_BUF_SIZE);
...
code_size = be->assemble(g_asm, g_code, ARK_CODE_BUF_SIZE);
...
if (be->link) { rc = be->link(g_code, code_size, 0); if (rc > 0) code_size = rc; }
...写文件
```

请逐行体会这四件事，它们是你以后一定会后悔没早做的事：

**① 每个阶段后面都有两道闸门。** 不只是"函数返回非空"，还要
`diag_errors() > 0` 就停。原因写在源码注释里（`src/compiler.c:1516` 附近）：
语法错误之后的树**不是用户写的那个程序**，继续跑只会产出一串"找不到符号"
"这个构造无法降级"的派生错误，把真正的原因埋掉。armcc 也是在这里停的。

**② 后端的指针大小必须在解析之前设。** `type_set_ptr_size(be->pointer_size)`
之所以在这一步（而不是在 codegen 里），是因为结构体布局、数组下标缩放、`sizeof`
全部在**解析期**就要算出确定的数字。C 后端跑在 64 位宿主上，指针是 8 字节；
ARM 是 4 字节。选错，`sizeof(void*)` 就错，后面全错。

**③ 每个 IR op 都带源码行号。** `ir_emit()` 里最后一句是
`I->line = g_ir_cur_line;`（`src/ir.c:270`）。行号不是给调试器用的装饰，
它是**唯一能把"机器码出问题"追溯回"哪一行 C"的线索**。没有它，调试后端会让你崩溃。

**④ 失败必须是"报错"，不能是"输出一个错的镜像"。** 后面第 9 章会专门讲
`g_irgen_errors`：IR 生成没能降级某个构造时，记数并让驱动返回失败，
而不是产出一个"能跑但算错"的镜像。这条纪律在本仓库里出现频率极高，
因为**静默算错比崩溃难查一百倍**。

### 1.3 亲手跑一次：三种输出

有了 `arkcc.exe`，你可以用同一份源码看到流水线不同深度的样子。

**输入**（`add3.c`）：

```c
int add3(int a, int b, int c)
{
    return a + b + c;
}
```

**① `-S`：停在"汇编文本"**（ARM 后端）

```bash
$ arkcc add3.c -target arm -S -o add3.s
```

```asm
; Ark C Compiler - generated Thumb-2 assembly
.thumb
.text

.file 1 "add3.c"
.global add3
.type add3, %function
add3:
    .cfi_startproc
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #24
    MOV r6, sp
    STR r0, [r6, #0]
    STR r1, [r6, #8]
    STR r2, [r6, #16]
.loc 1 3
    LDR r0, [r6, #0]
    PUSH {r0}
    LDR r0, [r6, #8]
    PUSH {r0}
    POP {r1}
    POP {r0}
    ADD r0, r0, r1
    ...
```

看到什么就说明什么，别美化它：

- 函数序言把 `r0/r1/r2`（前三个参数）**各存进一个 8 字节槽**（偏移 0/8/16），
  而不是 4 字节。这是 `alloc_local()` 的决定（第 9.2 节），为了 `double`/`long long`
  的高位不被压掉；
- 每次二元运算都是 `PUSH 左 → PUSH 右 → POP 右 → POP 左 → 算`。**很笨**，
  但它和 IR 的栈语义一一对应，正确性容易证明。优化是第 10 章的事，
  而且本项目刻意把优化放在 IR 层而不是后端层；
- 末尾那段 `MOV r0,#0 / PUSH / POP / ... / POP {r5,r6,r7,pc}` 是**不可达的**
  兜底返回（每个函数都发一份），`-O1` 会把它删掉（第 10 章的实证）。

**② `-c`：停在"目标文件"**

```bash
$ arkcc add3.c -target arm -c -o add3.ark_obj
$ ls -l add3.ark_obj
-rw-r--r-- 1 14905 197609 2528 Nov  6 09:36 add3.ark_obj
```

2528 字节，其中 1578 字节是代码——因为 ARM 后端会把 `__aeabi_*` 软浮点运行时
**一起编进每个目标文件**（第 11.7 节解释为什么这么设计）。目标文件的结构
在第 13 章逐字节拆开。

**③ `-target c`：把 IR 输出回 C**

这是本项目最好用的调试手段：C 后端把 IR **逐条翻译成 C 语句**，于是"IR 到底长什么样"
变成了能读的代码，还能拿去用 gcc 编、和原程序对拍。

```bash
$ arkcc t1.c -target c -o t1.gen.c
```

其中函数体（省略了 C 后端的运行时前导）：

```c
long long ark_add3(...) {
    char frame[8704] = {0};
    ark_slot stk[256]; int sp = 0; long long ark_a, ark_c; ...
    /* fn boundary */
    ark_fst(frame, 0, 8, a0);       /* 参数落地：帧内 8 字节槽 */
    ark_fst(frame, 8, 8, a1);
    ark_fst(frame, 16, 8, a2);
    stk[sp++].i = ark_fld(frame, 0, 4, 0);     /* PUSH_VAR a */
    stk[sp++].i = ark_fld(frame, 8, 4, 0);     /* PUSH_VAR b */
    ark_c = stk[--sp].i; ark_a = stk[--sp].i;  /* POP r / POP l  */
    stk[sp++].i = (ark_a + ark_c);             /* ADD            */
    ark_fst(frame, 24, 4, stk[--sp].i);        /* STORE t        */
    ...
}
```

`stk[]` + `sp` 就是 IR 的"虚拟栈"`；`frame[]` 就是栈帧；`ark_fld(frame,24,4,0)` 的
`4` 是宽度、`0` 是有无符号。**你现在可以直接读到 IR 的每一条指令**，
这就是第 9 章要用它当教材的原因。

### 1.4 为什么中间表示是"栈式"而不是 SSA

教科书会告诉你现代编译器用 SSA（每个值只赋值一次）。本仓库选了**栈式三地址码**，
理由完全是工程性的：

| | 栈式 IR（本仓库） | SSA |
|---|---|---|
| 生成难度 | 后序遍历 AST 即可，天然正确 | 要先建 CFG、插 φ 函数 |
| 后端难度 | 虚拟栈 → 真实寄存器/栈，一对一 | 要寄存器分配（图着色/线性扫描） |
| 优化能力 | 弱（只能做局部模式匹配） | 强 |
| 代码量 | `irgen.c` 3132 行（含所有方言） | 通常要 +3000 行 |
| 在 80 KB 内存的 MCU 上 | 可行 | 吃紧 |

结论：**先正确，再快**。这个选择让第 11 章的后端可以写成"一个巨大 switch"，
每条 IR 指令对应 2~5 条汇编，README 里也承认生成代码"明显比 armcc 差"——
但它能跑，而且能编自己。

### 1.5 目录职责一览

```
include/            接口（先读这些，它们比实现更能说明设计）
  common.h          TokenKind / AstNodeKind / IrOp 三个大枚举 + 错误码
  arkcc_config.h    编译期特性开关（profile 裁剪）
  memory.h          内存池
  diag.h            诊断
  lexer.h preproc.h parser.h ast.h type.h symtab.h sema.h
  ir.h irgen.h opt.h codegen.h backend.h
  config.h          运行期开关 g_config
  scatter.h         分散加载
  platform.h        平台层（宿主/裸机）
src/                实现
  lexer.c preproc.c parser.c ast.c type.c symtab.c sema.c
  ir.c irgen.c opt.c
  compiler.c        驱动 + 目标文件 + 链接器
  diag.c diag_msg_table.c   诊断与 armcc 编码表
  memory.c config.c cpu.c scatter.c main.c
  backend/registry.c        后端注册表
  backend/arm/              真正的目标后端
  backend/c/                调试用（IR→C）
  backend/x86_64/ backend/riscv32/   验证前端用
port/host/          宿主平台实现（文件、控制台、debug）
port/…              STM32 平台实现（在 Ark RTOS 仓库侧）
```

---

## 第 2 章 地基：内存池、诊断、平台层、开关

写编译器之前先写这四样。它们看起来和"编译 C"无关，但决定了后面 3 万行能不能维护。

### 2.1 bump 分配器：为什么编译器可以完全不 free

`src/memory.c` 全文 149 行，核心就是一个指针：

```c
static unsigned char g_pool[ARK_POOL_SIZE] __attribute__((section(".ark_buf")));
static int           g_offset = 0;

void *mem_pool_alloc(int size) {
    if (size <= 0) size = 1;
    size = (size + 7) & ~7;                    /* 8 字节对齐，兼容 64 位宿主的指针 */
    if (g_offset + size > ARK_POOL_SIZE) {
        ark_abort("memory pool exhausted");    /* 注意：不是返回 0 */
        return 0;
    }
    void *p = &g_pool[g_offset];
    g_offset += size;
    if (g_offset > g_high) g_high = g_offset;  /* 记录水位 */
    { /* 清零 */ for (i = 0; i < size; i++) q[i] = 0; }
    return p;
}
```

四个要点：

**① 一次编译 = 一次 `mem_pool_reset()`。** 编译结束（或开始下一轮）时把
`g_offset` 归零，所有 AST 节点、类型、符号、IR 指令**同时回收**。为什么可以这么粗暴？
因为编译器的生命周期是"批处理"：一个翻译单元处理完，它的所有数据结构同时作废。
不需要 `free` 也就不需要引用计数、不需要防 double-free——这是编译器相比普通程序
最奢侈的地方，要用足。

**② 只有最后一次分配能真正回收。** `include/memory.h` 里把这条写成了契约：

```c
/* Release an allocation. This is a bump allocator: only the most recent
 * allocation can actually be reclaimed (by rolling back the bump pointer);
 * freeing an older allocation is a silent no-op because other allocations
 * sit above it. */
void mem_pool_free(void *ptr, int size);
```

`ir.c` 里扩容数组时就用这个特性：`mem_realloc` 发现"旧块正好在栈顶"就原地延长，
否则另开一块、拷过去、旧块浪费掉。省内存但不需要通用堆。

**③ 池要能被链接脚本放到指定 RAM。** `__attribute__((section(".ark_buf")))`
让 STM32 的链接脚本把池放进 AXI SRAM（0x24000000），和内核的其它大缓冲分开。
宿主上这个属性是无害的（第 16 章会用到）。

**④ 分配时清零。** 所以每个 `AstNode`/`Type`/`IrInst` 一开始都是全 0，
"忘了初始化某个字段"不会变成随机值。代价是每次分配都要写一遍内存
（在 MCU 上不算免费），收益是把"未初始化"这一类 bug 从项目里彻底删掉。

**⑤ 池大小是 profile 相关的**：STM32 128 KB / 宿主 64 MB（`arkcc_config.h`）。
而"板子到底够不够"这个数字，不是靠猜——`mem_pool_high()` 记录历史最高水位，
`-v` 打出来。源码注释里写着：

```c
/* Peak of the bump pointer since the last mem_pool_reset(): how much arena the
 * translation unit actually needed.  Lets the RAM budget be set from data
 * instead of from the number in a failed build's error message. */
```

这句话值得抄在本子上：**预算要用数据定，不要用"上次失败时看到的数字"定。**

### 2.2 诊断系统：一条错误怎么变成那几个字节

`src/diag.c` 开头的注释把设计意图说得比任何解释都清楚：

```
Layout pipeline (one direction, no callbacks):
  report()  --policy-->  count()  --layout-->  emit_diag()  --bytes-->  out_*()
Only report() decides *whether* to print; only emit_diag() decides *shape*;
only out_*() decides *where*. Each step is independently testable.
```

拆开看这四步各自在管什么：

| 函数 | 唯一的职责 | 为什么必须独立 |
|---|---|---|
| `report()` | 该不该打印（`--diag_suppress`、`--diag_error`、severity 门槛） | 策略会变（IDE 要 suppress，CI 要升级），排版不该跟着变 |
| `count()` | 累计 error/warning 数 | 驱动靠它决定"要不要中止流水线"（§1.2 的闸门） |
| `emit_diag()` | 决定形状：armcc 风格还是 IDE 风格、要不要源码回显与 `^` 尖号 | 同一个错误在两种风格下字节完全不同，但**语义相同** |
| `out_*()` | 决定去哪：控制台 / `--errors` 文件 / 板上串口 | 裸机上没有 `FILE*`，但诊断一模一样 |

armcc 风格的实样（真实输出，来自本仓库诊断测试）：

```
pp.c", line 8: Error:  #35: #error directive: "should be predefined"
  #error "should be predefined"
   ^
pp.c: 0 warnings, 1 error
```

三个细节决定了"能不能和老工程对上"：

1. **错误码 `#35`** 必须和 armcc 一致，因为团队的 grep 脚本、IDE 的过滤规则
   都是按码匹配的。`src/diag_msg_table.c` 就是那张"条件 → 码"的表。
2. **源码回显 + 尖号**要指向真正出问题的那一列。所以 `Token` 里带着 `col`，
   `AstNode` 里也带着 `col`（`include/ast.h` 有注释说明只有直接由标识符构造的
   节点才盖这个章），`Loc` 一路传到 `emit_diag()`。
3. **结尾的统计行**（`0 warnings, 1 error`）不是装饰：构建系统靠它判断成败。

为什么值得为"打印错误"写 1012 行？因为编译器 90% 的用户体验就是它。
一个报错指向错误列、错误码对得上 armcc 的编译器，才会被真正用起来。

### 2.3 平台层：把"宿主"和"裸机"隔开

`include/platform.h` 只有三件事：

```c
void ark_log(const char *fmt, ...);                 /* 调试输出 */
void ark_abort(const char *msg);                    /* 致命错误 */
void ark_get_date_time(char *date_buf, char *time_buf);  /* __DATE__/__TIME__ */
```

注意第三项为什么在这里：C99 要求 `__DATE__`/`__TIME__` 是 `"Mmm dd yyyy"` /
`"hh:mm:ss"` 形式，而裸机上**没有 `<time.h>`**。把这个查询放进平台层，
`preproc.c` 就永远不需要 `#include <time.h>`——

```c
/* Kept here so freestanding builds need no <time.h>
 * (permitted by C99 7.1.1). */
```

同理，文件读写也有一层抽象（`port/host/flash_fs_host.c` 提供
`fs_read_file`/`fs_write_file`/`fs_file_size`/`fs_last_error`），宿主上是
`fopen/fread`，板上是 littlefs + QSPI。**`compiler.c` 里没有一处 `#include <stdio.h>`**，
所以同一份驱动代码能两边编译。

这就是"可移植"的真实含义：不是加一堆 `#ifdef`，而是**把差异收敛到一层薄接口**，
让上层代码不知道自己在哪。

### 2.4 两层开关：编译期裁剪，运行期细调

`include/arkcc_config.h` 第 1 节就写了 profile 机制：

```c
#ifndef ARKCC_PROFILE
#define ARKCC_PROFILE ARKCC_PROFILE_HOST_FULL
#endif
#define ARKCC_PROFILE_HOST_FULL      0
#define ARKCC_PROFILE_STM32_MIN      1
#define ARKCC_PROFILE_CROSS_COMPILE  2
```

三个 profile 分别裁掉什么（节选原文注释）：

| profile | 后端 | 用途 |
|---|---|---|
| `HOST_FULL` | ARM + C + x86_64 + RISC-V32 | 宿主全功能（默认） |
| `STM32_MIN` | 只 ARM | 板上自托管：砍掉用不到的后端，省 flash/RAM |
| `CROSS_COMPILE` | ARM + C | Windows 上给 STM32 交叉编译 |

关键注释（这段是整份配置文件的灵魂）：

```
 * IMPORTANT: Trimming only affects arkcc's own compilation. The trimmed arkcc still
 *   compiles STM32 user code correctly because core armcc compatibility (keywords,
 *   pragmas, scatter parsing) is always retained. The trim removes unused backends
 *   and optional optimizations, NOT language features needed for STM32 code.
```

运行期开关在 `include/config.h` 的 `g_config` 里（`enable_fpu_hw`、
`enable_opt_constfold`、`split_sections`…），从命令行灌进去。

**为什么两层都要？** 编译期决定"这份二进制里有没有这个功能"（体积/内存），
运行期决定"这次编译用不用这个功能"（行为）。只有编译期开关，用户就没法
`-O0` 关掉优化；只有运行期开关，板上就装不下四个后端。这是个便宜的教训，
但很多项目到后期才发现。

---

## 第 3 章 词法分析

### 3.1 输入是一个字符串，不是文件

```c
void lexer_init(Lexer *lex, const char *input);
```

注意参数是 `const char *`。为什么不是文件？因为**预处理已经跑完了**
（第 4 章），它把 `#include`/`#define` 全部展开，交给词法器的是一整块连续文本。
这样词法器完全不需要处理"文件切换"和"行号重映射"——

除了一个例外，见 §3.6。

`Lexer` 结构（`include/lexer.h`）的核心字段：

```c
typedef struct {
    const char *input;
    const char *p;          /* 当前扫描位置 */
    int         line;
    const char *line_start; /* 本行第一个字节：列号 = token起点 - line_start + 1 */
    Token       current;    /* 已识别的当前 token（供 peek） */
    Token       ahead;      /* 再往前一个（供 peek2） */
    ...
} Lexer;
```

`peek2` 很有必要：`(*name)` 和 `(type)expr` 只能靠两个 token 才分得清（第 7 章）。

### 3.2 Token 结构逐字段（每个字段都对应一个曾经踩过的坑）

```c
typedef struct {
    TokenKind kind;
    long long value;        /* 整数字面量的值 */
    double    fvalue;       /* 浮点字面量的值 */
    char     *str;          /* 标识符名字 / 字符串内容（已解转义） */
    int       line;
    int       col;          /* 1-based 显示列；0 = 未知 */
    const char *src_start;  /* token 在源文本里的起点（__asm 函数体要用） */
    int       is_imag;      /* C99 虚数字面量后缀 i/j */
    int       is_float;     /* f/F 后缀 */
    int       lit_unsigned; /* u/U 后缀 */
    int       lit_long;     /* l/L */
    int       lit_llong;    /* ll/LL */
} Token;
```

为什么整数字面量要记三个后缀位？`include/lexer.h` 里写得很直白：

```c
/* Integer literal suffix flags (C99 6.4.4.1). Dropping them made
 * `-1 < 1u` compare as signed and gave 0xFFFFFFFFu / 1u<<31 the wrong
 * type, so the lexer now records them and the parser types the literal. */
```

`-1 < 1u` 该是**假**（因为 `1u` 让两边变成无符号，`-1` 变成 0xFFFFFFFF）。
如果丢弃后缀，两边都按 `int` 比较，结果是真——**一个看着能跑、答案错的 bug**。
这类"类型由一个字符决定"的地方是 C 编译器最常见的错误来源。

### 3.3 主循环：最长匹配 + 跳过空白

词法分析的本质是"每次吃最长的那个合法词"。结构一定是这样：

```c
static Token lexer_read_token(Lexer *lex) {
    skip_ws_and_comments(lex);
    char c = *lex->p;
    /* 1. 标识符/关键字 */
    /* 2. 数字 */
    /* 3. 字符/字符串 */
    /* 4. 运算符（两字符优先于单字符） */
    /* 5. 其它单字符 */
}
```

`skip_ws_and_comments()` 是唯一维护行号的地方：

```c
static void skip_ws_and_comments(Lexer *lex) {
    while (*lex->p) {
        char c = *lex->p;
        if (c == ' ' || c == '\t' || c == '\r') {
            lex->p++;
        } else if (c == '\n') {
            lex->line++;
            lex->p++;
            lex->line_start = lex->p;
        } else if (c == '/' && lex->p[1] == '/') {
            while (*lex->p && *lex->p != '\n') lex->p++;
        } else if (c == '/' && lex->p[1] == '*') {
            lex->p += 2;
            while (*lex->p && !(lex->p[0]=='*' && lex->p[1]=='/')) {
                if (*lex->p == '\n') { lex->line++; lex->line_start = lex->p + 1; }
                lex->p++;
            }
            if (*lex->p) lex->p += 2;
        } else {
            break;
        }
    }
}
```

三个容易写错的地方，这里都照顾到了：

1. **块注释里的换行也要计行号**（否则一个 20 行的注释会让后面所有报错行号偏移）；
2. **`\r` 当空白吃掉**（Windows 换行是 `\r\n`，只处理 `\n` 会让 `\r` 变成一个"非法字符"）；
3. **注释掉到文件尾没有 `*/` 时不越界**（`*lex->p` 是 `'\0'` 就停）。

### 3.4 数字字面量

C 的数字有六种形态，必须**按顺序**判断，否则 `0x` 和 `0` 会打架：

```c
if (c == '0' && (p[1]=='x' || p[1]=='X'))       /* 十六进制，可能是 hex float 0x1.8p3 */
else if (c == '0' && is_oct(p[1]))              /* 八进制 0755 */
else                                             /* 十进制，可能是 1.5e-3 */
```

十六进制浮点（`0x1.8p3`）是最容易被忘的：

```c
if (*lex->p == '.') { is_hfloat = 1; ... fpart = fpart*16 + hex_val(...); fscale *= 16.0; }
if (*lex->p == 'p' || *lex->p == 'P') { ... 指数按 2 的幂 ... }
```

然后统一扫描后缀：

```c
static void scan_int_suffix(Lexer *lex, int *uns, int *lng, int *llng);
```

**写这一段时的自检清单**（每一条都对应一个真实 bug）：

- `0` 单独出现是十进制 0，不是"空八进制"；
- `0x` 后面没有数字要报错（而不是当成 0）；
- `1e` 后面没有数字要报错；
- `1.5f` 是 `float`，`1.5` 是 `double`，`1.5L` 是 `long double`（本项目映射到 double）；
- 后缀可以乱序组合（`1UL`、`1lu`、`1ULL`），但 `1lul` 非法；
- 值溢出 `long long` 时要报错而不是静默截断。

### 3.5 字符串、转义、UCN

```c
static int read_escape(const char **pp) {
    char e = **pp;
    if (e == 'x') {                      /* \xNN：任意长度十六进制 */
        (*pp)++;
        v = 0;
        while (is_hex(**pp)) { v = v * 16 + hex_val(**pp); (*pp)++; }
        return v & 0xFF;
    }
    if (e >= '0' && e <= '7') { ... }    /* \NNN：最多 3 位八进制 */
    ...                                   /* \n \t \r \\ \' \" \0 \a \b \f \v */
}
```

注意 `\x` 是**贪婪**的：`"\x41BC"` 里 `\x41BC` 是一个十六进制数（45628）再 `& 0xFF`
得 0x9C，不是 `'A'` 后跟 `"BC"`。这是 C 标准的规定，也是新手最常误解的地方。

UCN（`\u00E9` 这种通用字符名）要转成 UTF-8 字节写进字符串：

```c
} else if (ch == '\\' && (lex->p[1] == 'u' || lex->p[1] == 'U')) {
    unsigned int cp = 0;
    int ndigits = (kind == 'u') ? 4 : 8;
    ...
    if (cp < 0x80u)      { buf[blen++] = (char)cp; }
    else if (cp < 0x800u){ buf[blen++] = (char)(0xC0 | (cp >> 6)); ... }
```

**为什么标识符里也要处理 UCN？** 因为 C99 允许中文变量名（`int 变量;`）。
识别规则是 `is_ident_start()`：字母、`_`、`$`（armcc 方言允许）、以及
**≥0x80 的字节**——UTF-8 多字节字符的每个字节都 ≥0x80，所以整串会被一起吃掉。

### 3.6 列号：为什么需要"显示列"而不是"字节偏移"

`lexer.h` 里有个字段专门干这个：

```c
~~  int       col;          /* 1-based display column */
```

因为终端里一个汉字占**两格**，一个 UTF-8 汉字是**三个字节**。如果按字节算列，
`printf("中文")` 的尖号会指到"文"的第二个字节上，视觉上偏两格。

`lex_col()` 因此按 UTF-8 首字节判断宽度（`0xC0`→1 格，`0xE0`→2 格，`0xF0`→2 格）。
这种细节不影响正确性，只影响"用户觉不觉得你的编译器靠谱"——
但它是**唯一**能让中文注释工程不抱怨的那条路。

### 3.7 关键字表

```c
static Keyword g_keywords[] = {
    /* C89 */
    {"int",      TOK_INT},
    {"char",     TOK_CHAR},
    ...
    /* C99 */
    {"_Bool",    TOK_BOOL},
    ...
```

查表而不是 `switch` 字符串比较。注意 `check_keyword()` 是在**标识符扫描完之后**调的：
先按标识符规则扫出一个完整串，再查表——否则 `intx` 会被误认成 `int` + `x`。

`common.h` 里那条注释是整个枚举的宪法：

```c
/* Note: In TokenKind, the numeric values of TOK_PLUS..TOK_SHR_ASSIGN are used by
 * codegen/irgen as operator op-ids. New tokens MUST be appended to the end of the
 * enum; never insert into the middle. */
```

因为 `IR_BINARY` 的 `aux` 字段直接存 `TokenKind` 的数值。往中间插一个新 token
会让所有已生成的目标文件、所有硬编码的操作符编号**一起错位**——
这种"枚举值即协议"的设计必须写死在注释里。

---

## 第 4 章 预处理器

### 4.1 为什么预处理在词法之前

因为宏展开是**文本替换**，不是 token 替换。`#define TWO 2`，然后
`x = TWO##3;` 得到 `x = 23;`——两个 token 粘成一个。如果先做词法再展开，
`##` 就没有意义了（粘出来的 `23` 需要重新分词）。

所以顺序是：`preproc_process(src) -> char *`，再 `lexer_init(&lex, 结果)`。
代价是**行号会对不上原始文件**，于是 `compiler.c` 里有一句专门的补救：

```c
/* Line numbers in every later diagnostic refer to the *preprocessed* buffer
 * (that is what the lexer counts), so the echo buffer must be the same text
 * or the caret would point at a different line. */
diag_set_source(preprocessed);
```

注意它没有"想办法映射回原文件"，而是**把诊断的源码回显也切到预处理后的文本**。
这是个诚实的取舍：宁可让用户看到展开后的行，也不要让尖号指错行。
（要做得更好就得像 gcc 那样维护 linemarker 表，那是另一个量级的工程量。）

### 4.2 宏表与展开

宏记录（`src/preproc.c`）：

```c
typedef struct Macro {
    char  *name;
    char  *body;        /* 展开文本 */
    int    is_func;     /* 是否函数式宏 */
    char **params;
    int    param_count;
    int    is_variadic;
    struct Macro *next;
} Macro;
```

展开的核心难点只有一个：**什么时候停**。`#define A B` + `#define B A` 会无限循环。
C 标准用"蓝漆"（blue paint）描述：**正在展开的宏名被涂蓝，本次展开期间不再展开它**。

```c
m = find_macro(name);
if (m && is_blue_painted(name)) {
    /* C99 blue paint: do not re-expand a macro already being expanded. */
    m = 0;
}
```

配套的停止集（stop set）用来处理参数的边界：
`#define f(x) x`，调用 `f(f(1))` 时内层 `f` 的展开不能跨过外层参数的右括号。

`#` 与 `##`：

- `#x` 把参数变成**字符串字面量**，规则包括：去掉首尾空白、中间连续空白压成一个空格、
  内部 `"` 和 `\` 前面加反斜杠；
- `a ## b` 把两个 token 粘成一个，若结果不是合法 token 则报错（本实现按
  "尽量粘、粘不上就保留原文"处理，见下）；

真实输出（`arkcc pp.c -E -o -`）：

```c
#define MAX(a,b) ((a) > (b) ? (a) : (b))
#define SQUARE(x) ((x) * (x))
#define CAT(a,b) a##b
#define STR(x) #x
#define IDENT(x) x

int CAT(my, var) = MAX(1, 2);
const char *s = STR(hello world);
int nested = IDENT(SQUARE(3));
```

```c
int myvar = ((1) > (2) ? (1) : (2));
const char *s = "hello world";
int nested = ((3) * (3));
```

三点值得注意：

1. `CAT(my, var)` → `myvar`，粘接发生在参数替换之后；
2. `STR(hello world)` → `"hello world"`，参数**不再展开**（`#` 抑制展开）；
3. `IDENT(SQUARE(3))` → 参数先展开成 `((3) * (3))`，再被 `IDENT` 吐出来
   ——顺序反了就会得到 `SQUARE(3)`（未展开的原文）。

### 4.3 条件编译与 `#if` 求值

`#if` 的表达式要按 C 的整数规则求值，但有两个特殊规则：

- `defined(X)` 和 `defined X` 两种写法都要支持，且**在宏展开之前**处理
  （否则 `#define X 1` 会让 `defined(X)` 变成 `defined(1)`）；
- 未定义的标识符按 `0` 处理（C99 6.10.1），**不是**报错。

```c
if (ark_streq(nm, "defined")) { ... return find_macro(arg) ? 1 : 0; }
/* Undefined identifier evaluates to 0 per C99 6.10.1. */
```

### 4.4 这次写文档时修掉的一个真 bug：预定义宏的两副面孔

`__STDC__`、`__ARK_CC__` 这类"编译器自己定义的宏"在本项目里原来是**内联特判**的：
在标识符展开循环里直接替换成 `1`（`src/preproc.c` 的 "Predefined macros" 段），
没有进宏表。

结果是一个**只在某些语境下才暴露**的错误。实测（修复前）：

```c
int a = __ARK_CC__;        /* 展开成 int a = 1;            ✓ */
#ifdef __ARK_CC__          /* 判为未定义，走 else 分支      ✗ */
#if __ARK_CC__ == 1        /* 求值为 0，走 else 分支        ✗ */
#ifdef __STDC__            /* 判为未定义（C99 要求为真）    ✗ */
```

根因：`#ifdef` 和 `#if` 的标识符求值只看宏表 `find_macro()`，而内联特判只在
"文本展开"这条路上生效。**同一个名字活在两条不同的代码路径上，只有一条认识它。**

修法是把这三个"值是常量"的名字同时注册进宏表（`__FILE__`/`__LINE__` 是动态值，
不能注册，否则会被冻结成一编译期常量）：

```c
if (!find_macro("__STDC__"))            add_object_macro("__STDC__", "1");
if (!find_macro("__ARK_CC__"))          add_object_macro("__ARK_CC__", "1");
if (!find_macro("__ARK_VERSION__"))     add_object_macro("__ARK_VERSION__", "\"" ARK_VERSION "\"");
```

修完三个用例全部转对：

```c
#ifdef __ARK_CC__   ->  int yes;
#if __ARK_CC__ == 1 ->  int yes;
#ifdef __STDC__     ->  int stdc_yes;
#if __STDC__        ->  int stdc_if_yes;
const char *v = __ARK_VERSION__;   ->  "0.7.0"
```

同时发现另一处"文档与实现不符"：`preproc.c` 头部注释把 `__ARK_VERSION__`
列进预定义宏，但整个文件里根本没有它的实现——用户写 `__ARK_VERSION__`
会原样漏到词法层变成未声明标识符。现在它是真的了。

**这一节的重点不是那个 bug，而是它的形状**：一个名字如果在两处实现
（展开器 + 条件求值器），就一定会分叉。要么只有一个实现，要么两处共享同一个表。
这是编译器里最常见的缺陷模式，你写自己的编译器时一定会遇到。

### 4.5 `#include` 的搜索顺序

```
当前文件所在目录 -> -I 目录（按命令行顺序） -> 内置 stdlib/include
```

为什么"当前文件目录"要**最先**加、而不是只加主文件目录？C99 6.10.2 规定
`#include "x.h"` 要从**包含它的那个文件**所在目录找起。老工程里经常出现
`Drivers/xxx/foo.c` 里写 `#include "Drivers/xxx/bar.h"`（相对工程根、
也相对自身），两种都能命中的唯一办法是把源文件目录加进搜索链且优先级最高。
`compiler.c` 里为此写了 20 行注释（第 1276 行附近），因为这条一旦错，
整个 `--uvprojx` 自动构建就全废。

---
## 第 5 章 类型系统

### 5.1 一个结构体装下所有类型

C 的类型系统看着复杂，落到实现上就是一个带 `kind` 和 `base` 指针的节点：

```c
typedef struct Type {
    ValueType    kind;            /* 16 种之一 */
    struct Type *base;            /* 指针/数组的元素类型；函数的返回类型 */
    int          size;            /* 数组长度；结构体/联合体总字节数 */
    int          is_unsigned;
    int          is_variadic;     /* 函数：是否变参 */
    char        *tag;             /* struct/union/enum 的标签名 */
    StructField *fields;          /* 成员链表 */
    struct Type **params;         /* 函数参数类型数组 */
    int          param_count;
    int          is_packed;       /* __attribute__((packed)) */
    int          align_override;  /* __attribute__((aligned(N))) */
    int          is_vla;          /* 变长数组 */
    int          is_volatile;
    int          is_const;
    int          is_func_ptr;     /* 由 (*name)(...) 声明出来的函数指针 */
    int          bf_break;        /* 位域宽度为 0 时的"换一个存储单元"标记 */
} Type;
```

`kind` 的全部取值（`include/type.h`）：

```
TYPE_VOID  TYPE_CHAR  TYPE_SHORT  TYPE_INT  TYPE_LONG  TYPE_LLONG
TYPE_BOOL  TYPE_FLOAT TYPE_DOUBLE TYPE_PTR  TYPE_ARRAY TYPE_STRUCT
TYPE_UNION TYPE_FUNC  TYPE_ENUM   TYPE_WCHAR TYPE_COMPLEX
```

注意 `TYPE_LONG` 和 `TYPE_INT` 都是 4 字节（ARM/Windows LLP64）。这不是偷懒，
是目标平台的真实情况：`sizeof(long)==4` 在 ARM 32 位是硬事实。
一旦你为"POSIX 上 long=8"写代码，移植到 STM32 就会错。

### 5.2 基础类型是单例，复合类型才分配

```c
static Type ty_void   = { TYPE_VOID,   0, 0, 0, ... };
static Type ty_int    = { TYPE_INT,    0, 0, 0, ... };
...
Type *type_int(void) { return &ty_int; }
Type *type_pointer(Type *base) {
    Type *t = (Type *)mem_pool_alloc(sizeof(Type));
    ...
}
```

为什么基础类型要单例？因为**类型相等可以直接比指针**：

```c
int type_equal(Type *a, Type *b) { ... }
```

如果每次 `type_int()` 都新分配，`a == b` 就永远不成立，你就得写一个逐字段
比较的函数（慢且易漏）。

### 5.3 size 与 align

```c
int type_align(Type *t) {
    if (!t) return 4;
    if (t->align_override > 0) return t->align_override;
    if (t->is_packed) return 1;
    switch (t->kind) {
        case TYPE_CHAR:
        case TYPE_BOOL:   return 1;
        case TYPE_SHORT:  return 2;
        case TYPE_LLONG:
        case TYPE_DOUBLE: return 8;
        case TYPE_PTR:    return g_ptr_size;      /* 指针宽度可配！ */
        case TYPE_ARRAY:  return type_align(t->base);
        case TYPE_STRUCT:
        case TYPE_UNION: {
            int max_align = 1;
            for (f = t->fields; f; f = f->next) {
                int al = type_align(f->type);
                if (al > max_align) max_align = al;
            }
            return max_align;
        }
        default:          return 4;
    }
}
```

两个非教科书的点：

**① `TYPE_PTR` 返回 `g_ptr_size`。** 它由 `type_set_ptr_size()` 在解析前设置
（§1.2 提到过）。这让你可以用同一份前端分别生成 32 位 ARM 代码和 64 位宿主代码。

**② struct 的对齐取成员对齐的最大值**，这是 C 的规则。而 `TYPE_DOUBLE` 是 8：
在 ARM 上 `double` 必须 8 字节对齐，否则 `LDRD/STRD` 会 UsageFault。

`type_size()` 里 struct 分支的尾部填充（`src/type.c:304` 起）：

```c
int max_align = 1, s = t->size;
for (f = t->fields; f; f = f->next) {
    int al = type_align(f->type);
    if (al > max_align) max_align = al;
}
if (max_align < 1) max_align = 1;
if (t->align_override > 0 && t->align_override < max_align)
    max_align = t->align_override;                 /* pack 收紧 */
s = (s + max_align - 1) & ~(max_align - 1);        /* 向上取整到尾对齐 */
return s;
```

`(s + a - 1) & ~(a - 1)` 这个式子在全仓库出现十几次，记住它：**向上对齐到 2 的幂**。
它只在 `a` 是 2 的幂时成立——所以 `__attribute__((aligned(3)))` 这种要求必须提前拒绝。

### 5.4 结构体字段布局：逐行

```c
void type_struct_add_field(Type *st, const char *name, Type *ft) {
    StructField *f = (StructField *)mem_pool_alloc(sizeof(StructField));
    int al = type_align(ft);
    int fs = type_size(ft);
    int cur = st->size;
    int pack_val = 0;
    int is_flex = 0;

    if (st->kind == TYPE_UNION) cur = 0;              /* 联合体全部从 0 开始 */
    if (g_pack_align > 0) pack_val = g_pack_align;    /* #pragma pack(n) */
    if (st->is_packed)    pack_val = 1;               /* packed 优先 */
    if (pack_val > 0 && al > pack_val) al = pack_val; /* 字段对齐 = min(自然, pack) */
    if (al < 1) al = 1;

    if (ft && ft->kind == TYPE_ARRAY && ft->size == 0) is_flex = 1;  /* 柔性数组 */
    if (pack_val > 0 && st->align_override == 0) st->align_override = pack_val;

    cur = (cur + al - 1) & ~(al - 1);                 /* 把当前末尾对齐 */
    f->offset = cur;
    ...
    if (st->kind == TYPE_UNION) {
        if (!is_flex && fs > st->size) st->size = fs;  /* 取最大 */
    } else {
        if (!is_flex) st->size = cur + fs;             /* 累加 */
    }
}
```

四种特殊情况都在这一段里，逐个说：

**① 联合体**：每个成员都从 0 开始，size 取最大值。

**② 柔性数组**（`struct S { int n; char data[]; }`）：`data` 占 0 字节，
但 `offset` 仍要记录（`n` 之后的位置），因为用户会 `malloc(sizeof(S)+len)`
然后往 `data` 写。如果把它算进 `sizeof`，分配就会多出一份。

**③ `#pragma pack(n)` 与 `packed`**：`pack_val` 取两者中更严格的。
注意这里**同时**改了字段对齐和 `st->align_override`，后者影响 `type_size` 的尾部填充。
漏掉后者是最常见的错误：字段偏移对了，但 `sizeof` 多出几个字节，于是数组
排布全错。

**④ 位域**走另一个函数（§5.5）。

实测（`arkcc lay.c -target arm -S`，读 `MOV r0,#imm` 里的立即数）：

```c
struct S        { char c; int i; short s; };                  // sizeof = 12
struct __attribute__((packed)) P { char c; int i; short s; };// sizeof = 7
union  U        { char c; int i; };                           // sizeof = 4
struct B        { unsigned a:3; unsigned b:5; unsigned c:8; };// sizeof = 4
sizeof(int*)                                                  // 4（ARM 目标）
```

`struct S` 是 12 而不是 7：`char` 后补 3 字节到 4 的对齐，`short` 后补 2 字节到
整体 4 的对齐。这就是"内存布局"类 bug 的全部来源。

### 5.5 位域：一个必须写进注释的历史 bug

```c
void type_struct_add_bitfield(Type *st, const char *name, Type *ft, int width) {
    int unit_sz   = type_size(ft);      /* 存储单元大小（如 unsigned int → 4） */
    int unit_bits = unit_sz * 8;
    ...
    /* 试图与上一个位域共用一个存储单元 */
    if (last && last->bit_width > 0 &&
        type_size(last->type) == unit_sz && type_align(last->type) == unit_al &&
        last->bit_offset + last->bit_width + width <= unit_bits &&
        !st->bf_break) {
        cur_off = last->offset;
        bit_off = last->bit_offset + last->bit_width;
    } else {
        /* 开新单元 */
    }
}
```

注释里记着一次真实的翻车：

```c
/* Share the current storage unit with the previous bit-field when the two
 * have the same container size and alignment. Comparing the Type pointer
 * (the previous rule) split `unsigned a:3; int c:4;` into two units even
 * though armcc/gcc pack both into one 32-bit word: an int and an unsigned
 * int are distinct Type singletons but the same container class. Signedness
 * is irrelevant to packing (only to extraction), so it is not compared. */
```

按**指针**比较类型相等看起来"更严格"，实际上错：`unsigned` 和 `int` 是两个不同的
`Type` 单例，但它们是同一个存储单元类别。判据必须是**容器大小 + 对齐**，
而不是类型身份。这条经验可以推广：判断"能不能共用/合并"时，比**性质**，别比**身份**。

宽度为 0 的位域（C99 6.7.2.1）用来强制换单元：

```c
if (width == 0) { st->bf_break = 1; return; }   /* 不加字段，只置标记 */
```

### 5.6 匿名结构体/联合体

CMSIS 里大量使用：

```c
typedef struct {
    union {
        struct { uint32_t a, b; };
        uint32_t v[2];
    };
} Foo;
```

实现方式很直接：把子结构体的所有具名字段**复制**到父结构体，偏移加上
父当前的 size（`type_struct_add_anonymous()`）。没有做"路径解析"，
所以 `foo.a` 能找到；`foo.<匿名>.a` 这种写法本来也不合法。

代价是内存：每个匿名成员都多一份 `StructField` 节点。在 128 KB 池里编 CMSIS
头文件时这笔开销是真实的，所以池大小要按实际峰值定（§2.1）。

---

## 第 6 章 符号表与作用域

### 6.1 哈希 + 链表，没有删除

```c
#define SYM_HASH_SIZE 256   /* 实际值见 src/symtab.c */

void sym_enter_scope(void) { g_current_scope++; }

void sym_leave_scope(void) {
    int i;
    for (i = 0; i < SYM_HASH_SIZE; i++) {
        Symbol **pp = &g_table[i];
        while (*pp) {
            if ((*pp)->scope_level >= g_current_scope) {
                *pp = (*pp)->next;          /* 从链表里摘掉 */
            } else {
                pp = &(*pp)->next;
            }
        }
    }
    if (g_current_scope > 0) g_current_scope--;
}
```

出作用域时**从头扫整张表**，把 `scope_level >= 当前` 的节点全摘掉。
复杂度 O(表大小)，但表只有几百个节点、嵌套只有几层——够用，而且不需要
"记住这一层加了哪些"的栈。这是个典型的"用常数换简单"的取舍。

`Symbol` 结构与 `Type` 分开（`include/symtab.h`）：

```c
typedef struct Symbol {
    SymKind        kind;        /* SYM_VAR/FUNC/PARAM/GLOBAL/TYPEDEF/ENUM_CONST/…_TAG */
    char          *name;
    Type          *type;
    int            scope_level;
    int            offset;      /* 局部变量：相对帧指针的偏移 */
    int            is_defined;
    ...
    int            svc_num;     /* __svc(n) */
    int            is_irq;      /* __irq */
    int            is_weak;
    int            is_naked;
    char          *alias_target;
    struct Symbol *next;
} Symbol;
```

注意 `svc_num`/`is_irq`/`is_weak` 这些"方言属性"挂在符号上，而不是挂在
`Type` 上。理由：它们描述的是**这个声明**，不是类型。同一个签名可以是
`__irq` 也可以不是。

### 6.2 三个命名空间（C 的真实规则）

C 有四个独立的命名空间：普通标识符、标签（`goto`）、成员名、以及
`struct/union/enum` 的 tag。本实现把前三个分开处理，tag 用单独的查找：

```c
Symbol *sym_find(const char *name);          /* 普通标识符：由内向外 */
Symbol *sym_find_current(const char *name);  /* 只查当前作用域（判重定义） */
Symbol *sym_find_typedef(const char *name);  /* 只找 typedef 名 */
Symbol *sym_find_tag(const char *name);      /* 只找 tag */
int     sym_is_typedef(const char *name);
```

为什么 `sym_find_typedef` 要单独存在？因为**解析歧义**（第 7.2 节）：

```c
foo * bar;      /* foo 是 typedef 名 → 声明 bar；否则 → 乘法表达式 */
```

解析器在遇到 `IDENT *` 时，必须能问一句"`foo` 是不是 typedef 名"。
这就是 C 语法里著名的"lexer hack"（词法器需要符号表信息）。
本项目的做法是把 typedef 单独存一类，查询时只在这个类别里找。

### 6.3 局部变量的 offset 谁决定

初学最容易搞混的一点：`Symbol.offset` 不是解析器分配的，是 **irgen** 分配的
（§9.2 的 `alloc_local()`）。解析阶段只建符号、算类型；到底放栈上哪一格，
要到生成 IR 时才知道（因为临时变量、复合字面量、VLA 都在那个时候才出现）。

分工记牢：

| 阶段 | 它管什么 |
|---|---|
| parser | 名字、类型、作用域、初始化表达式 |
| irgen | 帧布局、偏移、临时槽 |
| backend | 寄存器、栈的物理增长方向 |

---

## 第 7 章 语法分析

### 7.1 递归下降的骨架

`src/parser.c` 的最外层：

```c
AstNode *parse_program(Lexer *lex) {
    Parser p;
    p.lex = lex;
    p.error_count = 0;
    ...
    while (lexer_peek(lex).kind != TOK_EOF) {
        AstNode *decl = parse_top_decl(&p);
        if (decl) program_add(prog, decl);
        else     /* 错误恢复：至少吃掉一个 token，避免死循环 */;
    }
    return prog;
}
```

递归下降 = **每个语法规则写成一个函数**，函数之间互相调用。优点是可以任意
回溯一点（用 `peek2`）、错误信息能说人话；缺点是左递归规则要改写成循环。

### 7.2 声明 vs 语句：typedef 歧义

```c
{
    t * x;      /* t 是 typedef → 声明一个指针变量 */
    a * b;      /* a 是普通变量 → 乘法表达式语句 */
}
```

判断依据只有符号表。所以 `parse_block_item()` 的第一步是：

```c
if (is_decl_start(token))      → 走声明
else if (token == IDENT && sym_is_typedef(token))  → 走声明
else                            → 走语句
```

`is_decl_start()` 认的是存储类、类型关键字、`const/volatile/restrict`、
`struct/union/enum`、`__attribute__`、以及 armcc 方言关键字
（`__irq`/`__weak`/`__svc`/`__packed`…）。

**坑**：`t * x;` 也可能是"把 t 乘以 x 然后丢弃"。C 标准用"如果有歧义就按声明处理"
解决，代价是用户写不出 `t * x;` 这种无副作用表达式。这不是你实现的问题，是语言规定。

### 7.3 声明符（declarator）：全篇最难的一段

C 的声明语法是**从里往外**读的：

```
        int * a[3]        int (* a)[3]
        ───┬───┬─┬          ───┬───┬─┬
           │   │ └ 数组      │   │ └ 数组
           │   └ 元素是指针   │   └ 先看括号里
           └ int            └ 指针 → 指向数组
        "3 个元素的数组，元素是 int*"
                          "指针，指向 3 个 int 的数组"
```

实现上，`parse_declarator(p, base, &name)` 返回"已经套好壳的类型"：

```c
static Type *parse_declarator(Parser *p, Type *base, char **out_name) {
    Type *t = base;

    /* ① 前置星号：每颗星套一层 pointer */
    while (lexer_peek(p->lex).kind == TOK_MUL) {
        lexer_advance(p->lex);
        skip_qualifiers(p, &ptr_vol, &ptr_const);   /* int *const p */
        t = type_pointer(t);
        if (g_decl_packed_ptr) t->is_packed = 1;
    }

    /* ② 括号包起来的指针：(*name)(args) —— 函数指针 */
    if (lexer_peek(p->lex).kind == TOK_LPAREN &&
        lexer_peek2(p->lex).kind == TOK_MUL) {
        ...
        t = type_pointer(t);
        t->is_func_ptr = 1;
        return t;
    }

    /* ③ 名字 */
    if (lexer_peek(p->lex).kind == TOK_IDENT) {
        if (out_name) *out_name = mem_strdup(lexer_peek(p->lex).str);
        p->name_line = lexer_peek(p->lex).line;
        p->name_col  = lexer_peek(p->lex).col;
        lexer_advance(p->lex);
    }

    /* ④ 后缀：数组维度 / 参数表，从内到外一层层包 */
    ...
}
```

顺序是**先星号、再名字、最后后缀**，而后缀里的数组维度要**倒着套**
（`int a[2][3]` 是"2 个元素、每个是 3 个 int 的数组"）：

```c
/* 收集维度，再构造 array(array(...)) */
int dims[8];
int dim_count = 0;
while (lexer_peek(p->lex).kind == TOK_LBRACKET) { ... dims[dim_count++] = n; ... }
while (dim_count > 0) t = type_array(t, dims[--dim_count]);
```

注意 `[ ]` 里没写数字（`int a[]`）时 `size=0`，由初始化式推断；
这在函数参数里等价于指针，在柔性数组里就是"0 长度"。

`peek2` 在这里是必需的：看到 `(` 之后，必须知道再下一个是不是 `*`，
否则 `(a)` 和 `(*p)` 分不开。

### 7.4 表达式：用宏生成十层优先级

手写十层函数会疯。项目用了一个宏（`src/parser.c:2215`）：

```c
#define DEFINE_BINOP_LAYER(fn, next, cond_expr) \
static AstNode *fn(Parser *p) {                                  \
    AstNode *left = next(p);                                      \
    while (1) {                                                   \
        TokenKind k = lexer_peek(p->lex).kind;                    \
        if (cond_expr) {                                          \
            Token op = lexer_peek(p->lex);                        \
            AstNode *right;                                       \
            lexer_advance(p->lex);                                \
            right = next(p);                                      \
            left = anchor(ast_binary((int)k, left, right, op.line), \
                          left && left->col > 0 ? left->col : op.col); \
        } else break;                                             \
    }                                                             \
    return left;                                                  \
}

DEFINE_BINOP_LAYER(parse_or_expr,     parse_and_expr,    (k == TOK_OR))
DEFINE_BINOP_LAYER(parse_and_expr,    parse_bitor_expr,  (k == TOK_AND))
DEFINE_BINOP_LAYER(parse_bitor_expr,  parse_bitxor_expr, (k == TOK_BOR))
DEFINE_BINOP_LAYER(parse_bitxor_expr, parse_bitand_expr, (k == TOK_BXOR))
DEFINE_BINOP_LAYER(parse_bitand_expr, parse_eq_expr,     (k == TOK_BAND))
DEFINE_BINOP_LAYER(parse_eq_expr,     parse_rel_expr,    (k == TOK_EQ || k == TOK_NE))
DEFINE_BINOP_LAYER(parse_rel_expr,    parse_shift_expr,  (k == TOK_LT || k == TOK_GT || k == TOK_LE || k == TOK_GE))
DEFINE_BINOP_LAYER(parse_shift_expr,  parse_add_expr,    (k == TOK_SHL || k == TOK_SHR))
DEFINE_BINOP_LAYER(parse_add_expr,    parse_mul_expr,    (k == TOK_PLUS || k == TOK_MINUS))
DEFINE_BINOP_LAYER(parse_mul_expr,    parse_cast_expr,   (k == TOK_MUL || k == TOK_DIV || k == TOK_MOD))
```

这十行就是 C 的整张优先级表，从低到高。**左结合**由 `while` 循环自然实现；
**右结合**的赋值单独写：

```c
static AstNode *parse_assign_expr(Parser *p) {
    AstNode *left = parse_cond_expr(p);
    if (是赋值运算符) {
        right = parse_assign_expr(p);   /* 递归调用自己 → 右结合 */
        return ast_assign(op, left, right, t.line);
    }
    return left;
}
```

`a = b = c` 因此是 `a = (b = c)`。

### 7.5 `anchor()`：为什么每个节点都带列号

```c
static AstNode *anchor(AstNode *n, int col) {
    if (n && n->col <= 0) n->col = col;
    return n;
}
```

规则是"**由子表达式继承列号，只有第一个能盖章**"。这样 `a + b * c` 的顶层
`+` 节点的列号落在 `a` 上，报错时尖号指向表达式的开头而不是行首。
`include/ast.h` 里对此有明确说明：只有直接从标识符 token 构造的节点才真正盖这个章。

### 7.6 错误恢复：不许死循环

递归下降最容易写出的 bug 是"遇到不认识的 token 不进也不退，while 转圈"。
两条铁律：

1. **每个 `parse_*` 出错后必须至少消费一个 token**（或在行/分号处同步）；
2. **`error_count` 上限**，超过就放弃这个翻译单元（否则一个缺 `}` 会产出一千条报错）。

`ark_compile()` 在 `parse_program()` 之后立刻检查 `diag_errors() > 0`（§1.2 的闸门①），
就是为了不让半成品 AST 继续往下走。

---

## 第 8 章 语义分析

### 8.1 它做与不做什么

`sema.c` 的头部注释很坦率：

```c
/* Ark C Compiler - sema
 * Semantic analysis: undefined / redefinition checks and basic type inference.
 * Relaxed vs the original: > 4 parameters, variadic declarations, typedefs ignored, full node walk.
 */
```

也就是说：**它不做作用域检查之外的严格诊断，也不做类型推导的全套**。
它主要干三件事：

1. 走一遍 AST，给每个表达式节点**填上 `type`**（谁都不知道自己类型的树没法生成代码）；
2. 在需要的地方**插入显式 cast 节点**（C 的隐式转换在这里变成树的一部分）；
3. 报告未定义标识符、重复定义、`break` 在循环外之类的错误。

**为什么不把类型推导放进 parser？** 因为 parser 是上下文无关的：它不知道
`a + b` 的类型，那取决于 `a`/`b` 的声明，而声明可能在后文（`extern`、函数原型）。
分层是必须的。

### 8.2 隐式转换：只在"表示形式真的变了"时插节点

```c
static AstNode *sema_implicit_cast(AstNode *node, Type *target) {
    if (!node || !target) return node;
    if (!node->type) return node;
    if (!cast_changes_repr(node->type, target)) return node;
    return ast_cast(target, node, node->line);
}
```

`cast_changes_repr()` 是关键：`char → int` 要插（要符号扩展），
`int → int` 不插，`int → long`（同为 4 字节）**也不插**——因为在 ARM 上它们
表示相同，插了只会让后端多干活。

这条规则有个直接好处：第 9 章的 IR 生成可以假定"该转换的地方树上已经有 CAST 节点"，
不用在每个运算里重复判断类型。**把隐式的东西显式化，是编译器分层唯一有效的办法。**

### 8.3 常用算术转换（usual_arith_conv）

C99 6.3.1.8 的规则，逐分支：

```c
Type *usual_arith_conv(Type *lt, Type *rt) {
    /* ① _Complex 最大 */
    if (lt && lt->kind == TYPE_COMPLEX) return type_complex(type_double());
    if (rt && rt->kind == TYPE_COMPLEX) return type_complex(type_double());

    /* ② 浮点优先 */
    if (lt && lt->kind == TYPE_DOUBLE) return type_double();
    if (rt && rt->kind == TYPE_DOUBLE) return type_double();
    if (lt && lt->kind == TYPE_FLOAT)  return type_float();
    if (rt && rt->kind == TYPE_FLOAT)  return type_float();

    /* ③ 整型提升：char/short/_Bool/enum → int */
    lt = promote_integer(lt);
    rt = promote_integer(rt);

    /* ④ 类型相同 */
    if (lt->kind == rt->kind && lt->is_unsigned == rt->is_unsigned) return lt;

    /* ⑤ 同 rank：无符号胜 */
    if (rl == rr) { ... take_uns ? type_uint() : type_int(); }

    /* ⑥ 不同 rank：看"更高 rank 能不能装下更低的所有值" —— 按字节宽判断，不按 rank */
    if (hi_uns || !lo_uns) return hi;
    if (hi_bytes > lo_bytes) return hi;      /* long long 8B 装得下 uint 4B */
    return 无符号版本(hi);
}
```

第 ⑥ 步的注释是本文件最有价值的一段：

```c
/* Step 5: different rank -- can the higher rank represent all lower values?
 * Judge by byte width, not by rank: int=long=4B and llong=8B here, so
 * long (rank 2) and int (rank 1) are the same width; a higher rank is not
 * necessarily wider. */
```

标准说"rank 更高且能表示所有值"，但**rank 高不等于宽**（`long` rank 比 `int` 高，
但都是 4 字节）。如果照字面实现，`int + long` 会得到 `long`——这里恰好没差，
但 `unsigned int + long` 就会出现"以为 long 能装下 unsigned int，其实不能"的错误。
按字节宽判是唯一正确的做法。

### 8.4 常量折叠

```c
/* Fold a constant expression: returns 1 and writes the value through
 * *out_value on success, 0 otherwise. Handles unary -/~/!, binary arithmetic/
 * shift/compare/bitwise, ?:, enum constants and result types on AST_CAST. */
int eval_const_expr(AstNode *node, long long *out_value);
```

它被三处用：

1. **case 标签**必须是常量；
2. **数组维度**必须是常量（VLA 除外）；
3. **全局变量初值**必须是常量（否则没法在 .data 里放）。

注意它和 `opt.c` 的常量折叠**不是一回事**：这个作用于 AST（语法层面，
在生成 IR 之前，为了满足语法要求）；那个作用于 IR（代码优化，为了跑得快）。
两份实现看着重复，但它们的**约束不同**：AST 版必须能处理 `? :` 和枚举，
IR 版只需要处理 `PUSH_INT+PUSH_INT+BINARY`。硬合并只会让两边都难受。

### 8.5 检查清单

写自己的编译器时，按这个顺序加检查（本项目就是逐步长成这样的）：

- [ ] 未声明的标识符
- [ ] 同一作用域重复定义（函数原型可以重复，变量不行）
- [ ] 函数调用的实参个数 / 类型
- [ ] `break`/`continue` 在循环外、`case` 在 `switch` 外
- [ ] `return` 值的类型 vs 返回类型
- [ ] 结构体成员是否存在、是否对非结构体用 `.`
- [ ] 对非常量取模 / 除零（只有常量情况能查出）
- [ ] 左值检查：`1 = 2`、`f() = 3` 报错

---

## 第 9 章 生成 IR

### 9.1 栈式 IR 的语义：只有一种数据结构

```c
typedef struct IrInst {
    IrOp  op;
    long long val;      /* 立即数 / 偏移 / label 编号 */
    const char *name;   /* label 名 / 函数名 / 字符串引用 / 变量名 */
    int   aux;          /* 附加信息：操作符 / 宽度 / 有符号 / volatile 位 */
    int   line;         /* 源码行号（调试与优化都要用） */
} IrInst;
```

一条指令 + 一个**虚拟栈**。约定极简：

- 求值顺序 = 指令顺序；
- 每个"表达式"生成的代码，结束时在栈顶留下**一个值**；
- 二元运算：栈顶是右操作数，次顶是左操作数。

节选几条核心指令的栈效应（完整表见附录 C）：

| 指令 | 栈效应 | 说明 |
|---|---|---|
| `IR_PUSH_INT v` | `[] → [v]` | 立即数入栈 |
| `IR_PUSH_VAR off,aux` | `[] → [x]` | 读局部变量；aux 编码宽度与符号 |
| `IR_PUSH_ADDR off` | `[] → [&x]` | 取局部变量地址 |
| `IR_PUSH_GLOBAL name` | `[] → [x]` | 读全局变量 |
| `IR_PUSH_GLOBAL_ADDR name` | `[] → [&x]` | 取全局地址（数组/结构体必须走这条） |
| `IR_STORE off,aux` | `[v] → []` | 写局部变量 |
| `IR_PUSH v; IR_PUSH w; IR_BINARY op` | `[v,w] → [v op w]` | 二元运算 |
| `IR_DUP` | `[a] → [a,a]` | 复制栈顶 |
| `IR_LABEL n` / `IR_JMP n` / `IR_JZ n` | `[] → []` / `[c] → []` | 控制流 |
| `IR_CALL n,name` | `[a0..a(n-1)] → [ret]` | 调用 |
| `IR_RETURN` | `[v] → []` | 返回 |

**为什么这个设计让人放心**：每条指令的栈效应是**局部**的。你可以在任何一条
指令前打印"当前虚拟栈深度"，一旦为负就是 IR 生成写错了。这比 SSA 的
"某个 φ 函数的操作数来自哪个块"好查一个数量级。

### 9.2 帧布局：为什么每个槽都按 8 字节对齐

```c
static int alloc_local(IrGen *g, int size) {
    /* Always align slots to 8 bytes so long long / double bit patterns fit intact;
     * avoids losing the high half of a double when long=4 (LLP64) shares a union. */
    int s = (size + 7) & ~7;
    int off;
    if (s <= 0) s = 8;
    off = g->bp;
    g->bp += s;
    if (g->bp > g->max_size) g->max_size = g->bp;
    return off;
}
```

注释里的理由值得展开：`double` 是 8 字节，如果两个 `int` 槽（4+4）紧挨着放，
一个 `double` 就可能跨在这两个槽的边界上；后端用 `LDRD/STRD`（要求 8 字节对齐）
就会 UsageFault。**统一 8 字节对齐**是花内存换"少一类硬件异常"。
实测代价：`int add3(int a,int b,int c)` 的帧是 24 字节而不是 12（§1.3 的汇编里
`SUB sp, sp, #24`），以及参数各占 8 字节。

帧的结构（ARM 后端，`r6` 是帧基址）：

```
        ┌──────────────────┐ ← r6 = 帧基址（低地址端）
  +0    │ 参数 a（8 字节）  │
  +8    │ 参数 b（8 字节）  │
  +16   │ 参数 c（8 字节）  │
  +24   │ 局部变量 t         │
  +32   │ 临时槽 / 复合字面量 │
        └──────────────────┘ ← sp
```

函数序言把寄存器参数**存进帧**（而不是一直留在寄存器里）：
`STR r0,[r6,#0]`、`STR r1,[r6,#8]`…… 这样"变量"在 IR 层就统一成了
"帧偏移"，irgen 不需要关心"这个变量到底在寄存器还是栈上"。
代价是慢（每次读写都过内存），收益是**IR 与后端解耦**。

### 9.3 表达式生成：以 `AST_VAR` 为例

一个变量引用看着简单，实际要分五种情况（`src/irgen.c:1981`）：

```c
case AST_VAR: {
    Symbol *s = sym_find(node->u.name);
    if (!s) { ir_emit(g->fn, IR_PUSH_INT, 0, node->u.name, 0); break; }   /* 未定义，兜底 */

    /* ① 函数名出现在值上下文：退化成函数指针 */
    if (s->kind == SYM_FUNC) { ir_emit(g->fn, IR_PUSH_FUNC, 0, node->u.name, 0); break; }

    /* ② 全局变量 */
    if (s->kind == SYM_GLOBAL) {
        const char *gname = s->is_static ? static_local_name(g->fn->name, node->u.name)
                                         : node->u.name;
        /* 数组/结构体/联合体必须取地址，不能"读值" */
        if (s->type->kind == TYPE_ARRAY || s->type->kind == TYPE_STRUCT ||
            s->type->kind == TYPE_UNION)
            ir_emit(g->fn, IR_PUSH_GLOBAL_ADDR, 0, gname, 0);
        else
            ir_emit(g->fn, IR_PUSH_GLOBAL, 0, gname, 0);
    }
    /* ③ 枚举常量就是立即数 */
    else if (s->kind == SYM_ENUM_CONST) { ir_emit(g->fn, IR_PUSH_INT, s->enum_value, 0, 0); }
    /* ④ 局部数组：取地址（数组名退化为首元素指针） */
    else if (s->type->kind == TYPE_ARRAY) { ir_emit(g->fn, IR_PUSH_ADDR, s->offset, node->u.name, 0); }
    /* ⑤ 普通局部变量：读值，aux 编码宽度 + 符号 + volatile */
    else {
        int aux = 0;
        int uns = s->type->is_unsigned ? 0x100 : 0;
        switch (s->type->kind) {
            case TYPE_CHAR:  aux = 1 | uns; break;
            case TYPE_SHORT: aux = 2 | uns; break;
            case TYPE_INT:
            case TYPE_ENUM:  aux = 4 | uns; break;
            case TYPE_LLONG: aux = 8 | uns; break;
            case TYPE_DOUBLE: aux = 8; break;
            case TYPE_COMPLEX: aux = 16; break;
            default: aux = 0; break;
        }
        if (s->type->is_volatile) aux |= IR_AUX_VOLATILE;
        ir_emit(g->fn, IR_PUSH_VAR, s->offset, node->u.name, aux);
    }
    break;
}
```

第 ② 步的注释是个经典陷阱，原文保留：

```c
/* Array/struct/union globals must push their base address (no
 * dereference): arrays decay to a pointer to their first element,
 * and structs/unions are accessed via member operations on their
 * address. PUSH_GLOBAL would emit LDR r0,[r0] which loads 4
 * bytes of the aggregate's storage as a bogus pointer. */
```

**聚合类型的"值"就是它的地址。** 这条如果搞错，`int g[10]; g[0]=1;` 会往
`g` 的前 4 个字节所表示的地址写数据——一个随机地址，通常在 HardFault 里结束。

`aux` 的位分配（自己写编译器时建议照抄这个约定）：

```
bit 0..7   : 宽度（1 / 2 / 4 / 8 / 16）
bit 8      : 无符号（0x100）
bit 0x10000: volatile（IR_AUX_VOLATILE）
```

因为宽度和符号挤在一个 int 里，后端可以用 `aux & 0xFF` 和 `aux & 0x100` 两行
取出来，不必新增字段。

### 9.4 指针算术：缩放发生在生成 IR 的那一刻

```c
/* C99 6.5.6 pointer arithmetic. Both operands are already on the stack
 * with rhs on top, so `ptr +/- int` can scale rhs by sizeof(*ptr) right
 * here, and `ptr - ptr` can divide the byte difference after the sub. */
if (!lf && !rf && les && (op == TOK_PLUS || op == TOK_MINUS)) {
    if (!res) {                                  /* int + ptr / ptr + int */
        ir_emit(g->fn, IR_PUSH_INT, les, 0, 0);
        ir_emit(g->fn, IR_BINARY, 0, 0, (int)TOK_MUL);
    } else if (op == TOK_MINUS) {                /* ptr - ptr */
        ptr_div = les;                           /* 减法之后再除 */
    }
}
...
if (ptr_div > 0) {
    ir_emit(g->fn, IR_PUSH_INT, ptr_div, 0, 0);
    ir_emit(g->fn, IR_DIV, 0, 0, 0);
}
```

`p + 1` 在 IR 里变成 `p + 1*4`（`int*`）。为什么在 IR 层做而不是在后端？
因为后端只认识"两个整数相加"，不该知道 `p` 是不是指针。**语义尽早展开成机械操作**
是整个项目的核心手法。

### 9.5 调用约定

`irgen.c` 头部写死了约定：

```c
/* Calling convention (coordinated with the backends):
 *   - Arguments 0..N-1 are PUSHed onto the virtual stack before the call;
 *     IR_CALL n makes the backend take the top n values into the matching
 *     registers / stack arguments, in the order arg0..argN-1.
 *   - String literals are referenced through the string pool + IR_PUSH_STR.
 *   - Globals are referenced through IR_PUSH_GLOBAL / IR_STORE_GLOBAL.
 */
```

后端侧（ARM）：前 4 个参数进 `r0..r3`，多的压栈。

```
生成顺序：push a0, push a1, push a2, ...  →  IR_CALL n
后端侧：  把栈顶的 n 个值按 arg0..argN-1 分配（第 5 个起走栈）
```

注意**从左到右压栈**，所以栈顶是**最后一个**参数。后端必须知道这个顺序，
否则 `f(a,b)` 会变成 `f(b,a)`。这类错误在单参数函数上根本看不出来，
一上双参数就全错——写后端时第一件事就是拿 `printf("%d %d", 1, 2)` 验证参数顺序。

返回值的传递：整数/指针用 `r0`；`long long`/`double` 用 `r0:r1`；
结构体按值返回走"调用者传隐藏指针"（源码里 `sret_lookup` 就是查这个表）。

### 9.6 控制流：label 编号 + 三种跳转

```c
static int alloc_label(IrGen *g) { return g->fn->label_count++; }
```

`if/while/for` 全部拆成"标签 + 条件跳转"。以 `while` 为例：

```
L_cond:
   <求 cond>          ; 栈顶 = 条件
   IR_JZ L_end
   <body>
   IR_JMP L_cond
L_end:
```

`&&` 和 `||` 的**短路语义**必须显式生成（不能用位运算代替）：

```
a && b:   <a>; JZ L_false; <b>; JZ L_false; PUSH 1; JMP L_end; L_false: PUSH 0; L_end:
```

`switch` 走另一条路：`collect_cases()` 先把所有 `case` 常量收集成表，
再生成"逐个比较 + 相等则跳转"（`IR_CMP_JMP_EQ`），没有跳转表。
在 MCU 上这是合理取舍：跳转表要占 rodata，而且 Cortex-M 的间接跳转不便宜。

### 9.7 四类"麻烦值"的处理

**① 位域**：`IR_LOAD_FLD off,bit_off,bit_width` / `IR_STORE_FLD`。
后端负责"读一个单元 → 移位 → 掩码"。irgen 只传三个数字（节选）：

```c
static int member_bitfield_info(AstNode *node, int *pbit_off, int *pbit_width);
```

**② volatile**：`aux |= IR_AUX_VOLATILE`。后端看到这一位会插 `DMB SY`
（`backend_arm.c` 的 `IR_PUSH_VAR` 分支）。优化器看到这一位必须放弃折叠
（`opt.c` 里有专门的防御性检查，§10.1）。

**③ 64 位**：栈上占两个槽，**低字在下面、高字在上面**：
`PUSH 低 → PUSH 高`。`IR_64BINARY/IR_64CMP/IR_64PUSH` 专门处理。
为什么不用"一个 8 字节槽"？因为虚拟栈是 `long long` 数组还不够——
在多目标后端里，x86 的栈是 4 字节单位，`cdecl` 要求低字在**低地址**
（即栈顶），和 ARM 的约定相反。于是有了 `IR_CDECL64` 这条"转换栈序"的指令。
**同一个 IR 要喂多个后端时，ABI 差异必须变成显式指令，不能藏在后端里。**

**④ 浮点**：`IR_FADD/FSUB/FMUL/FDIV/FCMP/F2I/I2F/F2F`，
`aux` 高位编码"是不是 double"（`0x200`）和"是不是无符号"（`0x400`）。
ARM 后端在无 FPU 的配置下会调用 `__aeabi_f*` 软浮点（§11.7），
有 FPU 时直接发 `VADD.F32`（`emit_vfp_f32_binop()`）。

### 9.8 `g_irgen_errors`：宁可编不过，不可编错

```c
/* Number of AST constructs IR generation could not lower. Non-zero means the
 * emitted IR is incomplete, so the driver must fail the compilation instead of
 * writing an image that silently computes the wrong answer. */
extern int g_irgen_errors;
```

驱动侧（`src/compiler.c`）：

```c
int diag_before_irgen = diag_errors();
ir = irgen_program(ast);
if (g_irgen_errors > diag_before_irgen) {
    /* IR generation could not lower part of the program; the emitted
     * code would be silently wrong, so refuse to produce an image. */
    ...
    return ARK_ERR_IRGEN;
}
```

这是本仓库最值得学的一条工程纪律：**"我不支持这个构造"必须表现为编译失败，
不能表现为"跳过它继续生成"**。因为跳过之后，产出的镜像语法正确、能加载、能运行，
只是某个语句没执行——这种 bug 你在板子上会查三天。

---

## 第 10 章 优化

### 10.1 常量折叠：三指令窗口 + 定点迭代

```c
void opt_constfold_func(IrFunc *f) {
    int changed = 1;
    int iter = 0;
    while (changed && iter < 8) {          /* 定点迭代：级联折叠需要多轮 */
        changed = 0;
        iter++;
        for (i = 0; i + 2 < f->code_count; i++) {
            IrInst *a = &f->code[i];        /* 必须是 PUSH_INT */
            IrInst *b = &f->code[i + 1];    /* 必须是 PUSH_INT */
            IrInst *c = &f->code[i + 2];    /* 必须是 BINARY   */
            if (a->op != IR_PUSH_INT) continue;
            if (b->op != IR_PUSH_INT) continue;
            if (c->op != IR_BINARY) continue;
            /* 不折叠涉 volatle 的序列（防御性检查 + 记录不变量） */
            if ((a->aux | b->aux | c->aux) & IR_AUX_VOLATILE) continue;
            if (!eval_binary(a->val, b->val, c->aux, &result)) continue;
            a->val = result;                /* 第一条变成结果 */
            b->op = IR_NOP;                 /* 后两条置空 */
            c->op = IR_NOP;
            changed = 1;
        }
        if (changed) compact_func(f);       /* 压实，去掉 NOP */
    }
}
```

为什么需要迭代？`1 + 2 * 3` 生成的是

```
PUSH 1; PUSH 2; PUSH 3; MUL; ADD
```

第一轮只能折 `PUSH 2; PUSH 3; MUL` → `PUSH 6`，得到 `PUSH 1; PUSH 6; ADD`；
第二轮才能折成 `PUSH 7`。`iter < 8` 是保险丝（防止意外的无限循环）。

**"改成 NOP 再压实"而不是"就地删除"**：因为 `IrInst` 是按数组下标被 `IR_JMP`/`IR_LABEL`
引用的，插入/删除会打乱所有 label 编号。置空 + 压实（重编号）是唯一安全的做法。

`eval_binary()` 要处理的边界：

- 除零、模零 → 不折叠（C 里是 UB，折叠成任何值都是"假装知道答案"）；
- 移位量 ≥ 位宽 → 不折叠；
- 有符号溢出 → 严格说是 UB，但实践中折叠（gcc 也这么干），**必须在文档里写明**；
- 有符号/无符号比较（`aux & 0x100`）→ 必须分开算。

### 10.2 死代码消除：删除不可达区间

```c
/* Dead code elimination: code after IR_RETURN / IR_JMP / IR_JMP_NAMED and
 * before the next IR_LABEL / IR_LABEL_NAMED is unreachable -> IR_NOP. */
```

这段逻辑直接对应 §1.3 里 `add3` 末尾那坨"不可达的兜底返回"。

### 10.3 优化必须"只在用户要求时"发生

`opt.c` 里有一条注释，是我见过最贵的教训之一（原文保留）：

```c
/* Bug-I8 FIX: Constant folding must NOT run at -O0. Previously the
 * condition was `g_config.enable_opt_constfold || level >= 1`, and
 * since enable_opt_constfold defaults to 1 (ARKCC_FEATURE_OPT_CONSTFOLD),
 * constfold ran even at -O0. This altered -O0 codegen expectations
 * (folding 1+2 into 3, eliminating dead constant computations) and
 * could also fold UB expressions (e.g. 1/0, 1<<40) to wrong values.
 * Now constfold only runs when the user explicitly requests -O1 or
 * above via `level >= 1`. */
```

三个知识点：

1. **`-O0` 是契约**：用户拿 `-O0` 就是为了"你生成的代码和我写的一一对应"。
   偷偷优化会让调试时断点错位、和参考编译器的输出对不上。
2. **折 UB 等于编造答案**：`1/0` 在 C 里是未定义行为，编译器**无权**决定它等于什么。
   折叠它就是在"猜"，而猜错的表现是"同一份代码在不同优化级别下结果不同"。
3. **开关的默认值会咬人**：`enable_opt_constfold` 默认 1 是合理的（想在 -O1 时默认开），
   但判断条件写成 `||` 就让"默认开"越权到了 -O0。正确的条件是
   `level >= 1 && 其它开关`。

### 10.4 内联与向量化

```c
/* Auto inlining: inlines small function bodies into call sites.
 * Threshold: IR instruction count <= ARK_INLINE_THRESHOLD (default 12).
 * Excludes: recursion, variadic, irq, naked, asm_func, >4 params. */
void opt_inline(IrProgram *prog);

/* Auto vectorization: recognizes simple counted loops (a[i]=b[i] +/- c[i])
 * and parallelizes them with SIMD instructions.
 * Only truly accelerates on the ARM backend; C backend falls back to scalar. */
void opt_vectorize(IrProgram *prog);
```

内联的约束列表（递归/变参/中断/裸函数/asm 函数/参数过多）不是保守，是**必需**：
- 递归内联会无限展开；
- 变参函数的栈帧形状特殊，内联后 `va_arg` 会读错位置；
- `__irq` 的入口寄存器现场由硬件/手写代码决定，内联等于破坏它。

向量化只认一个形状（`a[i] = b[i] ± c[i]` 的计数循环）——这是"看得见的收益，
写得出的判据"的取舍。它在 Cortex-M4/M7 上映射到 `SADD16/SSUB8` 这类 SIMD 指令
（IR 层是 `IR_SIMD_ADD16/ADD8…`）。

### 10.5 真跑一次看看

**常量折叠**：

```bash
$ cat cf.c
int f(void) { return 2 * 3 + 4; }
$ arkcc cf.c -target arm -S -o -            # 默认 -O0
    MOV r0, #2
    PUSH {r0}
    MOV r0, #3
    PUSH {r0}
    POP {r1}
    POP {r0}
    MUL r0, r1
    PUSH {r0}
    MOV r0, #4
    ...
$ arkcc cf.c -target arm -O1 -S -o -
    MOV r0, #10
    PUSH {r0}
    POP {r0}
```

`2*3+4` 折成 `#10`，八条指令变一条。

**死代码消除**（同一份 `t1.c`，用 C 后端看 IR 更直观）：

```
-O0:  return (long long)stk[--sp].i;
      stk[sp++].i = 0LL;              ← 不可达
      return (long long)stk[--sp].i;
-O1:  return (long long)stk[--sp].i;
```

两条实测合起来说明一件事：**优化器不改语义，只删"确定不需要"的东西**。
如果你发现优化后结果变了，那是优化器有 bug，不是"优化嘛，总会有点差别"。

---

## 第 11 章 ARM 后端：IR → Thumb-2 汇编

### 11.1 为什么先输出"文本汇编"而不是直接出字节

代价是多走一遍"文本→字节"（第 12 章），收益有四个：

1. **可读、可 diff**：`-S` 的输出能直接和 armcc 的输出并排看，这是唯一能把
   "代码生成错了"和"汇编器错了"分开的办法；
2. **可以用外部工具交叉验证**：`arm-none-eabi-as` 能吃这份文本，
   于是"我的汇编器有没有编错"有了独立参照（仓库里 `Makefile` 的 `test-arm`
   目标就是拿它过一遍）；
3. **调试信息能加**（`.loc 1 <line>` 就是这样插进去的）；
4. **后端代码可以写得很笨**——字符串拼接，不需要管理缓冲区大小、不需要回填。

一句话：**中间多一层文本，换来了可观测性。** 当你半夜三点在查"为什么这个
`if` 跳错了地方"，可观测性比性能重要一万倍。

### 11.2 寄存器约定与函数序言

`backend_arm.c` 头部写死了约定：

```c
/* Calling convention (used together with this compiler):
 *   - Arguments 0..3 passed in r0..r3; extra arguments go on the stack.
 *   - r6 = local variable base (fp, pointing to the low address of the local var area).
 *   - Prologue:  PUSH {r5,r6,r7,lr}; SUB sp,sp,#N; MOV r6, sp
 *   - Epilogue:  POP {r0}; MOV sp,r6; ADD sp,sp,#N; POP {r5,r6,r7,pc}
 */
```

序言/尾声（`emit_prologue` / `emit_epilogue_return`）：

```c
static void emit_prologue(AsmBuffer *b, const char *fn_name, int local_size,
                          int is_irq, int is_naked, int dbg) {
    asmbuf_puts(b, fn_name); asmbuf_puts(b, ":\n");
    if (dbg) emit_line(b, ".cfi_startproc");
    if (is_naked) return;                      /* __naked：一个字节都不发 */
    emit_line(b, "PUSH {r5, r6, r7, lr}");
    if (local_size > 0) { asmbuf_puts(b, "    SUB sp, sp, #") ... }
    emit_line(b, "MOV r6, sp");
}

static void emit_epilogue_return(AsmBuffer *b, int local_size,
                                 int is_irq, int is_naked) {
    if (is_naked) { emit_line(b, "BX lr"); return; }
    emit_pop_r0(b);                            /* 返回值已在 [sp]，先弹回 r0 */
    emit_line(b, "MOV sp, r6");
    if (local_size > 0) { ... "ADD sp, sp, #N" ... }
    emit_line(b, "POP {r5, r6, r7, pc}");      /* 弹到 pc = 返回 */
}
```

四个必须理解的细节：

**① `MOV r6, sp` 之后 `r6` 就是帧基址。** 为什么不用 `r11`（AAPCS 的 fp）？
因为本项目选 `r6`，和 armcc 的 `--apcs` 默认不完全一致，但**在自洽的运行时里
自洽**。这种"选哪个寄存器"的决定本身不重要，重要的是**全程一致**。

**② 返回值先 `POP {r0}` 再拆栈。** 顺序反过来会先把返回值那块内存释放掉。

**③ `POP {..., pc}` 是 Thumb 的"返回并恢复"**：从栈里弹出到 pc 就是跳转，
而且会自动带上 Thumb 位（因为弹出值的最低位是 1）。比 `BX lr` 少一条指令。

**④ `__irq` / `__naked` 各有一条特殊路径。** `__naked` 一个字节都不发（序言、
尾声全交给用户）；`__irq` 的返回必须靠 `POP {..., pc}` 触发异常返回
（源码注释里解释了 Cortex-M 自动保存 r0-r3/r12/lr/pc/xpsr，所以只需要保存
我们自己用的 r5/r6/r7）。

### 11.3 IR → 汇编：一张巨大的 switch

后端主干就是一个 `for (每条 IR) switch (op)`（`src/backend/arm/backend_arm.c:1019` 起）。
挑几条看：

```c
case IR_PUSH_INT:
    emit_mov_imm(&buf, 0, I->val);
    emit_push_r0(&buf);
    break;

case IR_PUSH_STR:
    asmbuf_puts(&buf, "    LDR r0, =.L_str_");
    asmbuf_int(&buf, I->val);
    asmbuf_putc(&buf, '\n');
    emit_push_r0(&buf);
    break;

case IR_PUSH_VAR: {
    /* aux 编码宽度 + 符号：
     *   1 = char (LDRSB/LDRB)   2 = short (LDRSH/LDRH)
     *   4 或 0 = int/ptr (LDR)  8 = 64 位（读两个字，都压栈）
     *   0x100 = 无符号          0x10000 = volatile（前后插 DMB SY） */
    int width = I->aux & 0xFF;
    int is_unsigned = (I->aux & 0x100) != 0;
    int is_volatile = (I->aux & IR_AUX_VOLATILE) != 0;
    if (is_volatile) emit_line(&buf, "DMB SY");
    if (width == 1) { ... "LDRB/LDRSB r0, [r6, #off]" ... }
    ...
}
```

二元运算在辅助函数里（`emit_binary`），一张小表：

```c
case TOK_PLUS:  emit_line(b, "ADD r0, r0, r1"); break;
case TOK_MINUS: emit_line(b, "SUB r0, r0, r1"); break;
case TOK_MUL:   emit_line(b, "MUL r0, r1");     break;
case TOK_DIV:   emit_line(b, "SDIV r0, r0, r1"); break;
case TOK_MOD:
    emit_line(b, "SDIV r2, r0, r1");
    emit_line(b, "MUL r2, r1");
    emit_line(b, "SUB r0, r0, r2");            /* r0 - (r0/r1)*r1 */
    break;
case TOK_SHR:
    emit_line(b, is_unsigned ? "LSR r0, r1" : "ASR r0, r1");   /* 无符号用逻辑右移 */
    break;
case TOK_LT:
    emit_line(b, "CMP r0, r1");
    if (is_unsigned) { emit_line(b, "ITE LO"); emit_line(b, "MOVLO r0, #1"); ... }
    else             { emit_line(b, "ITE LT"); emit_line(b, "MOVLT r0, #1"); ... }
    break;
```

注意 `TOK_SHR`：**有符号右移是 `ASR`（算术，补符号位），无符号是 `LSR`（逻辑）**。
用错这一个字母，`-8 >> 1` 就从 `-4` 变成 `2147483644`。这是 C 语义里最容易
在机器码层丢掉的一个区别（IR 层用 `aux` 的 `0x100` 位传下来）。

### 11.4 立即数：`MOV` 还是 `MOVW/MOVT`

```c
static void emit_mov_imm(AsmBuffer *b, int rd, int imm) {
    if (imm >= 0 && imm <= 255) {
        ... "MOV rD, #imm" ...
    } else {
        /* Always emit MOVW + MOVT pair. MOVW only sets bits[15:0];
         * without MOVT, bits[31:16] retain stale values from previous
         * operations, causing incorrect constants (e.g., 0x40022000
         * instead of 0x00002000 for 1u<<13). */
        ... "MOVW rD, #(imm & 0xFFFF)" ...
        ... "MOVT rD, #((imm >> 16) & 0xFFFF)" ...
    }
}
```

注释里的那次 bug 很典型：`1u << 13` = `0x2000`，用 `MOVW` 只写低 15 位，
高 16 位保留寄存器里**上一次的垃圾**，于是算出来 `0x40022000`。
这类"高位残留"错误在寄存器复用的后端正则地出现，**必须成对使用 MOVW/MOVT**。

（Thumb-2 的 `MOV` 立即数其实有 12 位编码限制和多种形式，本实现的简化是
"0..255 用 MOV，其余一律 MOVW+MOVT"——两条指令总能成立，代价是代码大一点点。）

### 11.5 条件执行与 IT 块

Cortex-M 只有 Thumb，**几乎所有指令都可以带条件，但必须放在 IT 块里**：

```asm
    CMP r0, r1
    ITE EQ            ; if-then-else：一条 EQ，一条 NE
    MOVEQ r0, #1
    MOVNE r0, #0
```

`ITE` 后面的两条指令必须严格按 `T`（then）/`E`（else）的顺序配对，
否则硬件行为未定义（或触发 UsageFault）。这是**手写汇编最容易出错的地方之一**，
因为写错了往往"大部分时候能跑"。

### 11.6 全局变量：先分配地址，再生成代码

```c
static char *codegen_arm(IrProgram *prog) {
    ...
    arm_scatter_load();
    /* Assign SRAM addresses to all non-extern, non-__at globals.
     * This must happen before generating function code so IR_PUSH_GLOBAL etc.
     * can emit MOVW/MOVT with the correct SRAM address. */
    gvar_assign(prog);
    ...
}
```

为什么必须**先**分配？因为后端把全局变量地址**直接编码进指令**
（`MOVW/MOVT`），不生成重定位。这是个有意的取舍：

- 好处：单文件编译产物自包含，不需要链接器就能跑（§13 的 `-c` 才有意义）；
- 代价：**跨目标文件的全局变量引用无法自动重定位**，`-link` 因此只能合并代码、
  不能搬数据段（§13.4 会详述这条限制，以及它现在会**报错**而不是静默出错）。

`gvar_assign` 干的事就是"从 .data 基址开始往后排，再排 .bss"，并把每个变量的
`[名字, 地址, 大小]` 记进三张并行数组（`g_gvar_names/addrs/sizes`）。

### 11.7 为什么要内联发射整个 `__aeabi_*` 软浮点运行时

`add3.c` 只有 3 行，生成的目标文件却有 **1578 字节代码**，其中 1500 多用在了
`__aeabi_fadd`、`__aeabi_dmul`、`__aeabi_uldivmod` 这些函数上（§13.1 的真实符号表）。

原因是设计约束：**产物必须能在裸板上一跑起来就有浮点/64 位运算**，
而项目里没有一份"链接时提供的 ARM 运行时库"。于是 ARM 后端把用得到的
`__aeabi_*` 实现**直接当汇编文本发射进每个翻译单元**。

代价很真实：

- 每个目标文件都带同一份运行时，链接时靠"重复符号合并"处理
  （`compiler.c` 里有个 `ld_rt_dup_count` 专门数这个，打印 `note: N duplicate
  compiler-runtime symbols merged`）；
- 单文件体积大（一个 `hello world` 也是 1.5 KB）。

收益也很真实：**自包含**。板上编出来的 `.svcm` 不需要任何外部 `.a`，
不需要"这个库有没有跟着走"的配置地狱。

如果要做工程化改进，正确方向是"运行时单独一个目标文件，只引用需要的符号"
（像 libgcc 那样）。这条已登记在 §附录 D。

### 11.8 后端也必须"宁可失败不产出错码"

`ark_compile()` 在 `emit_asm()` 前后各取一次错误计数：

```c
int diag_before_codegen = diag_errors();
asm_len = be->emit_asm(ir, g_asm, ARK_ASM_BUF_SIZE);
if (asm_len < 0) return ARK_ERR_CODEGEN;
if (diag_errors() > diag_before_codegen) {
    if (g_config.scatter_file && g_config.scatter_file[0]) {
        diag_tool(DIAG_SEV_ERROR, opts->input_path,
                  "the requested layout in %s could not be applied; "
                  "refusing to fall back to the built-in layout "
                  "0x08000000 / 0x20020000",
                  g_config.scatter_file, 0,0,0,0,0);
    }
    return ARK_ERR_CODEGEN;
}
```

注释里说明了动机：分散加载文件解析失败时，后端**曾经**会安静地退回内置地址
（0x08000000 / 0x20020000），产出一个"能编译、能烧、但跑在不该在的地址上"的镜像。
只有"按文件放置"和"编译失败"两种可接受结果——这条哲学在本项目里出现得
如此频繁，值得单独记一句：

> **无法满足的请求必须失败，不能降级成另一个请求。**

---

## 第 12 章 汇编器：汇编文本 → 机器码

### 12.1 为什么必须自己写

板上没有 `armasm`，也没有 `arm-none-eabi-as`。而"自托管"意味着编译器要在
**没有任何工具链**的 MCU 上产出可执行代码。所以后端输出的文本必须能被
自己的汇编器吃下去。

这也解释了为什么第 11 章"输出文本"不是浪费：如果直接出字节，就没有文本可汇编了。
链条是：

```
IR --(backend)--> 文本汇编 --(assembler)--> 字节 --(linker)--> 镜像
                    ↑ 可读可 diff        ↑ 两遍扫描         ↑ 重定位
```

### 12.2 两遍扫描

```c
static int arm_assemble(const char *asm_text, unsigned char *out, int cap) {
    ArmAsm a;
    ...
    pass1_a(&a);      /* 只处理"定义"：标签、.set、.section、字面量池位置 */
    a.pc = g_arm_vt_reserve ? ARM_VT_SIZE : 0;   /* 向量表预留 */
    pass2_a(&a);      /* 真正发指令，遇到未定义标签就记一条 ref */
    resolve_refs_a(&a);   /* 回填所有前向引用 */
    arm_save_syms(&a);    /* 给链接器用的符号表 */
    arm_save_relocs(&a);  /* 跨目标文件的重定位表 */
    ...
}
```

**为什么必须两遍**：汇编里的标签可以**先用后定义**（`B .L_loop_end` 之后才出现
`.L_loop_end:`）。一遍扫描时你不知道跳转距离，也就不知道用 16 位还是 32 位编码。

两遍的经典做法是：pass1 只累计"每条指令会占多少字节"从而算出所有标签地址；
pass2 输出并记录"这个位置引用了哪个符号"。

```c
static void out16(ArmAsm *a, unsigned v) {
    if (a->pc + 2 > a->out_cap) { a->error_count++; return; }
    a->out[a->pc++] = (unsigned char)(v & 0xFF);
    a->out[a->pc++] = (unsigned char)((v >> 8) & 0xFF);
}
```

**小端**：低字节先写。Cortex-M 是 little-endian，写反了整个镜像都是乱的。

### 12.3 指令宽度：必须先知道，才能算地址

pass1 必须知道每条指令是 2 字节还是 4 字节。判断逻辑就是一张表（节选）：

```c
if (strieq_a(op, "MOVW")) return 4;
if (strieq_a(op, "SDIV")) return 4;
if (strieq_a(op, "B.W"))  return 4;
/* Unconditional B uses 32-bit B.W (T4, +-1MB) to avoid +-2KB range
 * truncation in large functions (e.g. HAL_GPIO_Init is ~3.5KB;
 * 16-bit B T2 silently truncates imm11 causing the loop back-edge
 * to jump to a wrong address, breaking GPIO config). */
if (strieq_a(op, "B"))    return 4;
/* Conditional branches use 32-bit B<cond>.W (T3, +-1MB) to avoid
 * +-256B range truncation in large functions (e.g. HAL_RCC_OscConfig
 * is 8632 bytes; 16-bit B<cond> T1 silently truncates imm8 causing
 * branches to jump to wrong locations). T3 lo word bit12=0 (0x8000 base). */
if (strieq_a(op, "BEQ") || strieq_a(op, "BNE") || ...) return 4;
/* Barriers DMB/DSB/ISB use 32-bit T1 encoding (0xF3BF 0x8F4x/5x/6x).
 * 16-bit T2 (0xBF50/60/70) is not standard ARMv7-M; use 32-bit form. */
if (strieq_a(op, "DMB") || ...) return 4;
```

这三段注释是**三个真实的火灾现场**：

1. 16 位 `B` 的跳转范围只有 ±2 KB。`HAL_GPIO_Init` 有 3.5 KB，循环回边一跳
   就飞到错误地址——**表现是 GPIO 配不上，但代码"看起来"没错**。
   解决办法：无条件分支一律用 32 位 `B.W`（±1 MB）。
2. 16 位条件分支只有 ±256 B。`HAL_RCC_OscConfig` 8.6 KB，同样越界。
3. 16 位的 `DMB` 编码（`0xBF50`）**不是 ARMv7-M 的标准形式**，必须用 32 位 T1。

一句话总结：**当"省 2 字节"会导致静默跳错时，一律用 4 字节版本。**

### 12.4 重定位：跨文件引用留给链接器

汇编器遇到"我认识这个名字但不知道它在本文件哪个地址"时，记一条 ref
（`add_ref_a(a, a->pc, name, type)`），最后 `resolve_refs_a()` 尝试本地解析。
本地解析不了（比如 `bl printf`，`printf` 在别的目标文件里），就转成
**重定位表条目**写进目标文件：

```c
static void add_ref_a(ArmAsm *a, int pc, const char *name, int type);
```

类型编号（`compiler.c` 的 `ld_patch_ref` 里逐条实现）：

| type | 含义 | 编码方式 |
|---:|---|---|
| 1 | `BL`（Thumb T1） | 两条 halfword，拼 25 位有符号偏移 |
| 2 | `B.W`（T4） | 同上，lo 基址 `0x9000` |
| 3 | `B<cond>.W`（T3） | 21 位偏移，cond 从原指令里取 |
| 4 | `R_ARM_ABS32`（32 位绝对地址） | 直接写 4 字节 |
| 5 | `R_386_PC32`（x86 相对位移） | 写 `target - (pc+4)` |

补丁数学（`ld_patch_ref`，原文）：

```c
int offset = target - pc - 4;      /* PC 相对：PC 指向"下一条指令" */
int off2 = offset >> 1;            /* Thumb 偏移以 halfword 为单位 */
if (type == 1) {                   /* BL T1 */
    int s  = (off2 >> 23) & 1;
    int i1 = (off2 >> 22) & 1;
    int i2 = (off2 >> 21) & 1;
    int imm10 = (off2 >> 11) & 0x3FF;
    int imm11 = off2 & 0x7FF;
    int j1 = (~(i1 ^ s)) & 1;      /* J1/J2 是"取反的 i1/i2 异或 s" */
    int j2 = (~(i2 ^ s)) & 1;
    hi = 0xF000u | (s << 10) | imm10;
    lo = 0xD000u | (j1 << 13) | (j2 << 11) | imm11;
}
```

`J1 = ~(I1 ^ S)`、`J2 = ~(I2 ^ S)` 这种"位域拆开再拼回去"的写法看着绕，
原因是 ARM 的 Thumb-2 分支编码把 25 位偏移**打散**成 S/I1/I2/imm10/imm11 五段，
而且 J1/J2 存的是**反码**。抄这一段时不要试图"理解成算术"，就按位对表实现，
然后**用 arm-none-eabi-as 或真实 CPU 验证**。

### 12.5 符号表：谁会被记录

`arm_save_syms()` 把每一处标签变成符号条目 `[名字, 偏移, 类型]`。
关键是**哪些标签是"对外"的**：

- `.global name` 之后的标签 → 全局符号；
- `.weak` → 弱符号（链接时被强符号覆盖）；
- 其它（`.L_` 开头）→ 本地符号，不进符号表。

`arm_save_relocs()` 把 `resolve_refs_a()` 没能本地解决的那些 ref 转成重定位条目。
顺序很重要（源码注释里写了）：**必须先 `arm_save_syms` 再 `arm_save_relocs`**，
因为后者需要前者建立的"已知符号"集合来区分"跨文件引用"和"真的没有定义"。

---

## 第 13 章 目标文件与链接

### 13.1 `ARKOBJ2` 的字节布局

`-c` 产出的不是 ELF，是自定义的 `ARKOBJ2`。理由很实际：**解析器也要跑在板上**，
而 ELF 的段表/符号字符串表对"80 KB 池"来说太重了。自定义格式只保留三样东西：
代码、符号、重定位。

```
┌────────────────────────────────────────────────────────────┐
│ "ARKOBJ2\n"                                     8 字节      │
├────────────────────────────────────────────────────────────┤
│ code_size                                      4 字节 LE   │
├────────────────────────────────────────────────────────────┤
│ code body                                   code_size 字节 │
├────────────────────────────────────────────────────────────┤
│ sym_count                                      4 字节 LE   │
├────────────────────────────────────────────────────────────┤
│ 每个符号：                                                 │
│   name_len(4, 含结尾 NUL) + name(name_len) + offset(4)     │
│   + type(1) + is_weak(1)                                   │
├────────────────────────────────────────────────────────────┤
│ reloc_count                                    4 字节 LE   │
├────────────────────────────────────────────────────────────┤
│ 每条重定位：                                               │
│   name_len(4) + name(name_len) + offset(4) + type(1)       │
└────────────────────────────────────────────────────────────┘
```

真实文件（`arkcc add3.c -target arm -c -o add3.ark_obj`，2528 字节）：

```
$ python3 解析（脚本见下）
magic: b'ARKOBJ2\n'
code size: 1578
first 32 code bytes: e0 b5 86 b0 6e 46 30 60 b1 60 32 61 30 68 01 b4
                     b0 68 01 b4 02 bc 01 bc 40 18 01 b4 30 69 01 b4
symbols: 39
  sym add3            off=0x0000 type=0 weak=0
  sym __aeabi_ladd    off=0x003C type=0 weak=0
  sym __aeabi_lsub    off=0x0042 type=0 weak=0
  ...
  sym __arkcc_d2f_pair off=0x0610 type=0 weak=0
relocs: 0
```

前 32 字节就是 §1.3 那段汇编的前几条指令：

```
e0 b5        PUSH {r5,r6,r7,lr}
86 b0        SUB  sp, sp, #24
6e 46        MOV  r6, sp
30 60        STR  r0, [r6, #0]
b1 60        STR  r1, [r6, #8]
32 61        STR  r2, [r6, #16]
```

（小端：`0xB5E0` 读成 `e0 b5`。`0xB580|0x60` 这类编码规律见附录 B。）

用一段 Python 就能把这个格式读出来——**这是验证你自己写的目标文件最快的方法**：

```python
import struct
d = open("add3.ark_obj", "rb").read()
assert d[:8] == b"ARKOBJ2\n"
n = struct.unpack("<I", d[8:12])[0]        # 代码长度
p = 12 + n
sc = struct.unpack("<I", d[p:p+4])[0]; p += 4
for _ in range(sc):
    ln = struct.unpack("<I", d[p:p+4])[0]; p += 4
    name = d[p:p+ln-1].decode(); p += ln
    off = struct.unpack("<I", d[p:p+4])[0]; p += 4
    typ, weak = d[p], d[p+1]; p += 2
    print(name, hex(off), typ, weak)
```

### 13.2 为什么 RAM 窗口描述符要"追加在最后"

`compiler.c` 里：

```c
/* The RAM-footprint descriptor is appended after the real symbols so
 * that older readers that ignore trailing symbols still work. */
int sc_total = sc + ram_extra;
```

两个特殊符号 `__arkcc_ram_start` / `__arkcc_ram_end` 记录"这个目标文件的
.data/.bss 占了哪一段 SRAM"。把新字段**追加**在末尾而不是插在头部，
是为了让只认识旧格式的读取器（比如某些构建脚本）仍然能工作。

这是**格式演进**的通用手法：只加字段、不加在中间、用 magic 区分版本。

### 13.3 链接器在干什么

`-link` 的流程（`src/compiler.c` 的 link 分支）：

```
① mem_pool_reset()                     ← 见 §13.5，板端必须
② 读第一个文件，看 magic 是不是 "ARKOBJ2\n"
③ 逐个读入：把 code 追加到 out_buf（每个对象的 code 基址 = 追加前的长度）
             符号表逐条 ld_add_sym()（强 > 弱）
             重定位表逐条 ld_add_reloc()（偏移加 code 基址）
④ 检查 SRAM 窗口重叠（见 §13.4）
⑤ 对每条重定位：ld_find_global() 找目标地址 → ld_patch_ref() 打补丁
⑥ 写镜像
```

符号解析的规则（`ld_find_global` + `ld_add_sym`）：

```c
static int ld_find_global(const char *name) {
    int weak_idx = -1;
    for (i = 0; i < g_ld_sym_count; i++) {
        if (ark_streq(g_ld_syms[i].name, name)) {
            if (!g_ld_syms[i].is_weak) return i;   /* 强符号立刻返回 */
            if (weak_idx < 0) weak_idx = i;        /* 记住第一个弱符号 */
        }
    }
    return weak_idx;
}
```

强弱符号是 `__weak` 的实现基础（中断向量表里的默认处理函数用 `__weak`，
用户重定义就覆盖）。`ld_add_sym` 里还专门处理了一种噪音：

```c
/* Every object re-emits the private runtime helpers (__aeabi_*, __arkcc_*).
 * They are bit-identical, so "first definition wins" is correct and warning
 * once per helper per object is pure noise; keep a count and report it in one
 * line instead. */
if (name[0] == '_' && name[1] == '_') ld_rt_dup_count++;
```

§11.7 说过每个目标文件都带一份 `__aeabi_*`。链接时它们会全部"重复定义"，
所以这里必须按名字前缀豁免——**同一个设计决定（自包含运行时）在这里产生了
第二个后果，你必须提前想好它在链接阶段的样子**。

### 13.4 这条链接器的真实边界：它不搬数据段

这是本仓库最该被知道的一条限制，`compiler.c` 里用一大段注释写着：

```c
/* === Multi-object SRAM overlap check ===
 * -link concatenates code sections and resolves code relocations,
 * but it does not relocate .data/.bss: every object was laid out
 * from the same SRAM base (default 0x20000000, or the +RW/+ZI
 * region of the shared scatter file). Linking two objects that
 * both declare RAM objects therefore produces an image where the
 * two sets of globals alias the same addresses. That used to be
 * silent; fail loudly instead of shipping a wrong image. */
```

所以它现在的行为是：**发现两个对象的数据段重叠 → 直接报错，不出镜像**，
并给出可操作的建议（"链接单个对象，或者把翻译单元合并"）。

这体现的仍然是那条纪律：**做不到的事就报错**。一个"链接成功但全局变量互相踩"
的镜像，在板子上的表现是"某个变量莫名其妙变了值"，能查到人崩溃。

### 13.5 `-link` 前必须 `mem_pool_reset()`：一个只在板上现形的 bug

```c
/* The link phase allocates its symbol table, relocation table and
 * image buffer from the same bump pool the compiler uses, and this
 * branch returns before the mem_pool_reset() further down.  On the
 * host that was invisible: every run is a fresh process, so the pool
 * always started at zero.  On the board `cc --pack` runs several
 * compiles and links in one process, so the link inherited the peak
 * of the compile that preceded it and the 80 KB arena ran out at
 * link time (measured: 2 x ~450 B sources -> 'pass A aborted: memory
 * pool exhausted', pool 77400/81920 B, while the same link alone
 * needs 8.5 KB).  Nothing from the compile phase survives into the
 * linker -- it re-reads the objects -- so reset here is the fix.
 * Host reproductions cannot see this; the criterion has to come
 * from the board. */
```

这段注释本身就是一个完整的调试故事，值得逐句读：

1. **症状**：板上 `--pack` 报"内存池耗尽"，但宿主上同样的输入一切正常；
2. **为什么宿主正常**：每次运行都是新进程，池天然从 0 开始；
3. **为什么板上不正常**：`--pack` 在**一个进程里**连做四次编译 + 一次链接，
   池的 bump 指针一路累积；
4. **为什么"继承峰值"是错的**：链接阶段根本不需要编译阶段留下的任何东西
   （它重新读目标文件），所以在入口 reset 是**语义上正确**的，不只是省内存；
5. **结论**：宿主测试**永远**发现不了这类 bug，判据必须来自板端实测数字
   （它甚至把 77400/81920 和"单独链接只需 8.5 KB"都记下来了）。

### 13.6 实测一下目标文件与链接

```bash
$ arkcc add3.c -target arm -c -o add3.ark_obj -v
[arkcc] target=arm, source=56 bytes
[arkcc] wrote object 'add3.ark_obj' (1578 bytes code, 39 syms, 0 relocs)
[arkcc] arena peak 28688/67108864 B
```

`arena peak 28688` 是这次编译真实吃掉的内存池峰值（`-S` 时只要 12128 字节）。
这两个数字就是你在第 16 章给板上定池大小的依据。

---

## 第 14 章 分散加载与镜像布局

### 14.1 为什么需要 scatter 文件

一个 STM32 工程的"内存长什么样"不是编译器能猜的：

```
Flash 0x08000000  512 KB   放代码 + 只读数据 + 初值
SRAM  0x20000000   96 KB   放 .data（已初始化变量）+ .bss（未初始化）+ 栈
CCM   0x10000000   64 KB   放对访问速度敏感的东西
```

同一份源码，放到 STM32H743（有 AXI SRAM）和 F103（只有 20 KB）上，
`.data` 的地址、大小、甚至能不能放下都不同。所以 ARM 的工具链用
**scatter 文件（.sct）**描述这个布局，GCC 用 **linker script（.ld）**。

### 14.2 支持的语法子集

```
LR_IROM1 0x08000000 0x00080000  {          ; 加载域：从哪加载
  ER_IROM1 0x08000000 0x00080000  {        ; 执行域：在哪执行
   *.o (RESET, +First)                     ; 向量表放最前
   *(InRoot$$Sections)                     ; 库内部段
   .ANY (+RO)                              ; 其余只读
   .ANY (+XO)                              ; 只执行
  }
  RW_IRAM1 0x20000000 0x00018000  {        ; RW 数据
   .ANY (+RW +ZI)
  }
}
```

解析器（`src/scatter.c`，935 行）只认这几个属性：

```c
#define SCATTER_ATTR_RO     0x0001  /* +RO : .text/.rodata */
#define SCATTER_ATTR_RW     0x0002  /* +RW : .data */
#define SCATTER_ATTR_ZI     0x0004  /* +ZI : .bss */
#define SCATTER_ATTR_XO     0x0008  /* +XO : execute-only */
#define SCATTER_ATTR_FIRST  0x0010  /* +First: 放在区域开头 */
#define SCATTER_ATTR_LAST   0x0020  /* +Last : 放在区域末尾 */
```

解析结果的用途就三个（`include/scatter.h`）：

```c
unsigned scatter_get_flash_base(const ScatterDesc *desc);            /* 代码基址，缺省 0x08000000 */
unsigned scatter_get_data_base(const ScatterDesc *desc, unsigned attr); /* +RW/+ZI 基址，缺省 0x20000000 */
unsigned scatter_get_er_base_for_section(const ScatterDesc *desc, const char *section_name); /* 自定义段 */
```

为什么不支持完整语法（`OVERLAY`、`ABSOLUTE`、`+ZI` 之外的内存属性、表达式…）？
因为**只实现你用得到的部分**。支持的子集覆盖了 uVision 自动生成的绝大多数 .sct
和手写 STM32 布局；遇到不认识的语法，解析器记账（`error_count`），
然后 §11.8 那道闸门让编译失败而不是静默用默认地址。

### 14.3 向量表：为什么必须"预留"而不是"前插"

`include/backend.h` 里有一段非常长的注释，值得整段读：

```c
/* Why this exists: arm_link used to *prepend* the table and shift the whole
 * image right by 0x400 at link time.  Thumb-2 branches survive a uniform shift
 * (they are PC-relative), but absolute addresses baked in by the assembler do
 * not: a string literal linked at 0x24070000 stays encoded as 0x24070000 while
 * its bytes move to 0x24070400.  Reserving up front removes the shift, so both
 * kinds of reference stay correct. */
```

一句话：**链接期整体平移会破坏绝对地址**。因为 §11.6 说了，后端把全局变量地址
直接编进 `MOVW/MOVT`（不生成重定位），一旦镜像整体右移 0x400，这些常量全错。

解法：汇编时就从偏移 `ARM_VT_SIZE`（0x400）开始发码，把前面 0x400 字节
留给向量表（`g_arm_vt_reserve`）。`arm_assemble()` 里就是那几行：

```c
if (g_arm_vt_reserve) {
    for (k = 0; k < ARM_VT_SIZE; k++) out[k] = 0;   /* 先挖空 */
}
pass1_a(&a);
a.pc = g_arm_vt_reserve ? ARM_VT_SIZE : 0;          /* 从 0x400 开始发码 */
pass2_a(&a);
```

这条经验可以推广：**不要在链接期搬动"已经含有绝对地址"的东西**。
要么在编译期就知道最终地址（本项目的选择），要么在链接期把所有绝对引用
都变成重定位（ELF 的做法）。两者混着来，就是灾难。

### 14.4 `.sct` ↔ `.ld` 互转

`-S` 搭配 `--scatter` 时，arkcc 会把 `.sct` 转成同名 `.ld`（反之亦然），
方便你既用 keil 又用 gcc 验证。真实产物：

```bash
$ arkcc add3.c -target arm -S --scatter examples/ark_test/MDK-ARM/ark_test/ark_test.sct -o add3.s -v
[scatter] parsed .../ark_test.sct
[arkcc] wrote linker script add3.ld
```

```ld
MEMORY {
  LR_IROM1 (rx) : ORIGIN = 0x8000000, LENGTH = 0x80000
  ER_IROM1 (rwx) : ORIGIN = 0x8000000, LENGTH = 0x80000
  RW_IRAM1 (rwx) : ORIGIN = 0x20000000, LENGTH = 0x18000
}
SECTIONS {
  .text 0x8000000 : {   ; load address = execution address
   *.o (RESET, +First)
   *(InRoot$$Sections)
   .ANY (+RO)
   .ANY (+XO)
   } > ER_IROM1
  .bss 0x20000000 : {   ; RW data
   .ANY (+RW +ZI)
   } > RW_IRAM1
}
```

注意三点：

1. **十六进制被改写成 `0x8000000` 而不是 `0x08000000`**——数值相同，GCC 接受；
2. **选择器文本原样保留**（`*.o (RESET, +First)` 不是合法 ld 语法，
   所以这份 .ld 只适合"看地址"，不适合直接喂 `arm-none-eabi-ld`）；
3. 这个"互转"的定位是**给人看的翻译**，不是完备的双向编译器。
   要真用它当链接脚本，得手改选择器（把 `+RO` 换成 `.text .rodata` 之类）。

---

## 第 15 章 命令行驱动

### 15.1 选项结构

```c
typedef struct {
    const char *input_path;
    const char *output_path;      /* NULL = 按扩展名推导 */
    int   emit_asm;               /* -S */
    int   verbose;                /* -v */
    const char *target;           /* -target <name> */
    const char *include_dirs[16];
    int   include_dir_count;
    int   list_backends;
    int   compile_only;           /* -c */
    int   preprocess_only;        /* -E */
    int   link_mode;              /* -link */
    int   vector_table;           /* --vector-table */
    const char *link_inputs[32];
    int   link_input_count;
    int   opt_level;              /* -O0/-O1/-O2 */
    int   debug_info;             /* -g */
    ...
    const char *cpu;              /* --cpu/-mcpu */
    int   gen_depend;             /* -MMD */
    const char *depend_file;      /* -MF */
    int   split_sections;         /* -ffunction-sections */
    const char *scatter_file;     /* --scatter */
    const char *linker_script;    /* -T */
    const char *pre_defines[64];  /* -D */
    const char *uvprojx;          /* --uvprojx */
} ArkOptions;
```

**看到什么**：固定大小数组（`include_dirs[16]`、`link_inputs[32]`、`pre_defines[64]`）。
为什么不用动态数组？因为**板上没有 `malloc`**，而结构体在栈上分配。
这是嵌入式程序里非常常见的设计：**上限写死，超了报错**。

### 15.2 解析顺序：有些选项必须先扫

`src/main.c` 里有一句关键注释：

```c
/* 4) --diag_style describes how *every* diagnostic is printed, including
 * "-x --diag_style=ide" in IDE style). Scanning it first is cheaper and ...
 */
```

因为**诊断的输出格式必须先于任何诊断确定**。如果按正常顺序解析，
遇到"前面有语法错误"时风格还没读出来，前面几条错误就会用默认格式打印——
用户看到一半 arm 风格、一半 IDE 风格。

这叫**两趟解析**：第一趟只捞"全局设置"（`--diag_style`、`-config`），
第二趟按正常顺序处理其余参数。任何有"影响错误输出"的选项都需要这么处理
（gcc 的 `--color`、`-fdiagnostics-format` 同理）。

### 15.3 输出名推导与 `-MMD`

- 输入 `a.c`，`-S` → `a.s`；`-c` → `a.ark_obj`；不给 `-o` 且默认后端 → `a.bin`；
  `-target c` → `a.gen.c`。
- `-MMD` 生成 Makefile 风格的依赖文件：

```
<输出>: <源文件> <头文件1> <头文件2> ...
```

实现方式是让预处理器把每个 `#include` 过的路径记下来
（`preproc_get_included_files()`），驱动再拼成一行。
**这正是"预处理阶段必须记录包含链"的唯一原因**——它不是给编译器用的，
是给构建系统用的。

### 15.4 `--uvprojx`：把 Keil 工程直接喂进来

```
$ arkcc main.c --uvprojx project.uvprojx -target arm -c -o main.ark_obj
```

从 `.uvprojx`（XML）里自动提取 `-I` 包含路径和 `-D` 宏定义，省掉手工抄
几十条 include。为什么值得做？因为**迁移成本是工具链推广的唯一障碍**：
能直接吃现有工程，用户才愿意试。

代价是你得写一个 XML 扫描器（不引第三方库，因为裸机没有），
而且必须容忍各种 uVision 版本生成的差异。这类"胶水代码"通常占项目 5% 体量，
但决定了项目有没有人用。

---

## 第 16 章 自托管：把编译器编成固件跑在板子上

这一章是"鸡生蛋"的部分：**用 arkc 编出来的东西，包括 arkc 自己**。
它也是整份教程里最能检验你设计是否干净的一章——因为约束一下子全来了：
没有 `malloc`、没有文件系统、RAM 只有几百 KB、没有 `printf`。

### 16.1 先裁功能：profile

```bash
- DARKCC_PROFILE=ARKCC_PROFILE_STM32_MIN
```

这一行让 `arkcc_config.h` 把 x86_64 / RISC-V / C 三个后端全部关掉，
只留 ARM。四个后端各自的代码量：ARM 6284 行、x86_64 2515、C 2251、RISC-V 367
——砍掉 5000 多行对 flash 的意义是直接的。

**注意裁剪的边界**：只砍"用不到的后端"，不砍语言特性。因为板上编的是
STM32 用户代码，`__irq`/`__weak`/`__svc`/scatter 这些一条都不能少。
这条纪律写在配置文件里（§2.4 引过）。

### 16.2 再定内存：每个缓冲的尺寸都是量出来的

板端 `ARKC_DEFS`（Ark RTOS 的 Makefile 里）长这样：

```make
ARKC_DEFS := \
  -DARKCC_PROFILE=ARKCC_PROFILE_STM32_MIN \
  -DARK_POOL_SIZE=81920 \
  -DARK_SRC_BUF_SIZE=8192 \
  -DARK_ASM_BUF_SIZE=24576 \
  -DARK_CODE_BUF_SIZE=8192 \
  -DARK_LINK_BUF_SIZE=8192 \
  -DARK_OBJ_BUF_SIZE=4096 \
  -DPP_BUF_SIZE=24576 \
  -DPP_MAX_INC_DEPTH=4 \
  -DPP_INC_BUF=4096 \
  -DARK_LINK_MAX_SYMS=64 \
  -DARK_LINK_MAX_RELOCS=64
```

旁边那段注释是全项目最值得抄的"预算方法论"，摘录并解释：

```
# 预算怎么定的（2026-11-05 实测，不再靠猜）：
#  - link 缓冲 4KB -> 8KB：M2 多文件链接里单个对象已经 2.6~3.0KB，加 1KB
#    向量表就超 4KB。链接期有两个这样的缓冲（输入 buf + 输出 out_buf），
#    所以这条要 8KB。
#  - 池 72KB -> 80KB：板上实测 `cc --pack k.c` 在 72KB 上报
#    `memory pool exhausted`（用掉 72928/73728 B 还差一次分配），而同一份
#    源码在宿主 64 位版只要 62520 B——32 位下结构体变小反而让 mem_realloc 的
#    「是否为最后一次分配」判定更容易失败，多出来的就是这些不可回收的旧块。
#    所以池的标尺只能从板上读，不能从宿主读。
#  - 代码缓冲 16KB -> 8KB：这块只放**一个编译单元**的机器码（实测最小的 .bin
#    1552 B，k.c 编出 1916 B），8KB 已有 4 倍余量；放不下时汇编器会返回负码、
#    走上层 "assembly failed"，不会静默截断。
```

三个可以直接搬走的教训：

1. **缓冲大小要用"实测最大值 + 明确余量"定**，不是"先给 4 KB 试试"。
   注释里连"用掉 72928/73728 还差一次分配"这种细节都记下来，因为
   **差一次分配**和**差 8 KB** 是两种完全不同的信号。
2. **宿主的数字不能当板上的标尺。** 同一个文件宿主 62520 B、板上 72 KB 都不够，
   因为 32 位下 `sizeof(Struct)` 变小，`mem_realloc` 的"旧块是否在栈顶"判定
   更容易失败，旧块回收不了。**架构差异会让"同一份代码"的内存曲线变形。**
3. **缓冲不够时必须表现为明确错误**（`assembly failed`），不能截断。
   8 KB 的代码缓冲对 1.9 KB 的产物有 4 倍余量，但如果哪天不够了，
   用户看到的是"汇编失败"，不是"程序跑飞"。

### 16.3 平台移植：两处薄接口

主板（裸机）侧只需要实现 `port/` 的那两层：

```c
/* 文件层（宿主：fopen/fread；板上：littlefs + QSPI NOR） */
int  fs_read_file(const char *path, char *buf, int cap);
int  fs_write_file(const char *path, const unsigned char *data, int n);
int  fs_file_size(const char *path);
const char *fs_last_error(void);

/* 平台层（宿主：printf；板上：内核串口/日志） */
void ark_log(const char *fmt, ...);
void ark_abort(const char *msg);
void ark_get_date_time(char *date_buf, char *time_buf);
```

`compiler.c` / `preproc.c` / `lexer.c` 一行都不用改。**这就是"可移植"的判据**：
上层代码里搜不到目标平台的名字。

### 16.4 汇编文本太大：`-S` 在板上必然失败

一个容易被忽略的事实：**arkc 的 `-S` 输出包含整份 `__aeabi_*` 运行时**
（§11.7）。Ark RTOS 的板级 Makefile 里记着实测值：最小程序的 `.bin` 是 1552 B，
而同一份源码的 `.s` 是 **13727 B**；板上的 ramfs 单文件槽是 4096 B，所以：

```
$ cc k.c -target arm -S -o /tmp/k.s
→ 写满槽后返回 NOSPC（不会静默截断，但 -S -o 文件必然失败）
```

这不影响自托管（自托管走 `--pack`，产出的是紧凑镜像），但**如果你在板上
照着教程敲 `-S`，它一定失败**。知道原因就不会以为是自己写错了。

### 16.5 `--pack`：四遍差分把"可重定位"这件事找出来

板上产出的镜像要能被加载器搬到任意 RAM 块执行，所以必须知道**哪些字节是
绝对地址**（搬了要改）、哪些是相对偏移/指令（搬了不能动）。链接器原本知道，
但 `.svcm` 格式不保存重定位表。于是用了一个非常聪明的办法：**把同一份程序
链接四次，靠差分反推**：

| 遍 | 假设 | 用途 |
|---|---|---|
| A | 标称基址 | 基准镜像 |
| B | ROM 基址 + delta | 找出"ROM 侧绝对地址"的位置 |
| C | RAM 基址 + delta | 找出"RAM 侧绝对地址"的位置 |
| D | ROM/RAM 同时 + delta | 验证 |

差分出来的差异位置就是需要重定位的字节，连"是整字还是 MOVW/MOVT 成对"
都能区分（`KIND_ROM` / `KIND_RAM` / `KIND_ROM_MOVW` / `KIND_RAM_MOVW`）。

实现里的三条设计说明（`Ark RTOS/kernelsrc/src/arkrtos_apppack.c` 头部，原文摘录）：

```
*          1. **按 Thumb 指令长度扫描，而不是按 4 字节字扫描。**
*             Thumb-2 指令是半字对齐、长度 2 或 4 字节的；32 位绝对地址既可能
*             以整字形式躺在常量池里，也可能被拆成 MOVW（低 16 位）+ MOVT
*             （高 16 位）两条指令。按 4 字节字硬扫会跨过指令边界...
*
*          2. **表项的偏移先按「相对负载」记账，最后统一加表长。**
*             ...「绝对偏移」在差分阶段还不存在。先按相对偏移编码，
*             数完再整体加 (payload_offset / 2) << 2：编码里低 2 位是类型，
*             加一个 4 的倍数正好只动偏移字段，不会污染类型。
*
*          3. **验证不是「再算一遍」，而是把表真的应用到 A 上再逐字节比 D。**
*             同一份代码算两遍得到同样的表，只能证明算法是确定的，不能证明
*             表是对的；把表打回字节里跟 D 比，才证明「按这张表搬移后的镜像
*             就是换基址重新链接出来的那一份」。
```

第 3 条尤其值得记住：**"前后两次算得一样"不是正确性证明**，它只证明确定性。
正确性证明必须是"把结果应用回去，和独立得到的期望值逐字节比"。

### 16.6 自托管的完整链条

```
① 宿主上用 armcc5/gcc 把 arkc 编成 STM32 固件（阶段 1）
② 固件烧进板子，arkc 在板子的 RAM 里跑起来
③ 板上的 arkc 读 /mnt/nor 上的 .c 源码（QSPI NOR + littlefs）
④ 编译 → IR → Thumb-2 文本 → 自己汇编 → 目标文件
⑤ 多个目标文件 -link 成一个镜像
⑥ --pack 生成带重定位表的 .svcm（四遍差分）
⑦ 加载器把 .svcm 装进 RAM 池任意空块，跳转执行
⑧ 掉电后 .svcm 还在 NOR 上，复位再 run 一次照样跑
```

本仓库对应 `example/stm32_selfhost_build/`（两个源文件 + makefile），
判据是板上一句 `ARKMAKE: cross-file add3=6`——**两个翻译单元、跨文件调用、
结果正确**。只有这一个数字对得上，才说明"编译 + 汇编 + 链接 + 装载 + 执行"
整条链都通了。

### 16.7 自托管的边界（诚实记账）

"能编自己"这句话要拆开看：

| 说法 | 本仓库的实际状态 |
|---|---|
| arkc 的源码能被编成 ARM 固件并运行 | ✅（`ARKCC_PROFILE_STM32_MIN`） |
| 板上能编译 `.c` 成机器码 | ✅ |
| 多文件 → 一个可装载镜像 → 板上执行 | ✅（`add3=6` 判据） |
| 产物掉电保留 | ✅（QSPI NOR + littlefs） |
| **板上编出来的东西烧回内部 Flash 由引导跳转执行** | 🚧 未打通 |
| **板上 arkc 重新编译 arkc 源码并产出可用固件** | ❌ 未做（池/缓冲不够，见 §16.2） |

最后一行是"自举"（self-hosting）的严格定义。本项目做到了"自托管"（编译器
跑在目标上、产物在目标上执行），**没有**做到"板上重新构建自己"。
这两个词很容易混，写文章/做封面时不要混（这也是我在别处特意区分的原因）。

---

## 第 17 章 怎么知道自己写对了

编译器最恶心的地方是：**它能产出完全错误但看起来正常的输出**。所以你从第一天
就要建"多条互相独立的判据"。

### 17.1 差分测试：拿另一个编译器当尺子

```
同一份 .c → [arkc] → 行为 X
          → [gcc ] → 行为 Y
判据：X == Y
```

本仓库里有多层差分：

- **C 后端**（`-target c`）：把 IR 翻译回 C，用宿主 gcc 编译执行，和原程序对拍。
  这是定位"前端错了还是后端错了"的第一把刀——如果 `-target c` 的输出错了，
  问题在前端；如果它对了而 ARM 输出错，问题在后端。
- **x86_64 后端**：在 PC 上跑真实机器码（`tests/` 里那堆 `*.x86.s`）。
- **arm-none-eabi-as**：把 `-S` 的输出喂给 GNU 汇编器，验证"我的汇编器"和
  "它的汇编器"对同一份文本的理解是否一致。

### 17.2 诊断测试：逐字对齐 armcc

`tests/run_diag_tests.py` + `tests/run_diag_boundary.py`。它们比对的不是
"有没有报错"，而是**报错的形状**：错误码、行号、尖号位置、结尾统计行。

真实运行结果（本次改动后）：

```
[ ok ] sem_toofew
[ ok ] sem_toomany
[ ok ] parse_missing_semicolon
[ ok ] parse_missing_rbracket
[ ok ] parse_missing_rparen
[ ok ] parse_missing_rbrace
[ ok ] parse_noexpr
[ ok ] sink (sink)
[ ok ] badchar (shape)
[ ok ] dupvar (shape)

0 failure(s)
```

```
boundary diagnostics against ...\arkcc.exe
long_line
many_errors
same_line
cjk
tab
all boundary assertions held
```

注意 `cjk`（中文）和 `tab` 两条边界用例：它们检查的是**列号计算**在宽字符和
制表符下是否还对得上。这类测试看起来吹毛求疵，但它们是"用户觉得你的编译器
靠不靠谱"的全部来源。

### 17.3 自举测试：`bootstrap_x86/`

`bootstrap_x86/` 目录里有一整套"用 arkcc 编 arkcc 自己的前端"的产物
（`compiler.pp.c`、`main.preproc.c`、若干 `test_*.c`）。这是最狠的一条判据：
**编译器能处理自己写出来的代码**（宏、递归、函数指针、大 switch、位域全上）。

判据不是"能编过"，而是"编出来的程序行为一致"。所以 `test_42.c`、`test_call.c`
这些用例都在比**运行结果**，不是比汇编文本。

### 17.4 定位"跑通但算错"的四步法

这是本项目反复使用、也是最值得抄进笔记的流程：

```
① 复现最小化：把问题缩到 5 行以内（缩不下去说明还没找到根因）
② 分层定位：用 -E / -target c / -S / -c 四个出口，看错在哪一层
      -E 错了        → 预处理器
      -target c 错   → 前端（lexer/parser/sema/irgen）
      -target c 对、-S 错 → 后端
      -S 对、-c 错   → 汇编器/目标文件
      -c 对、镜像错  → 链接器/布局
③ 在那个阶段打"当前状态"：IR 打印、虚拟栈深度、帧偏移
④ 写一条能长期跑的判据（放进 tests/），然后才修
```

第 ④ 步是新手最容易跳过的：**修完不加测试，等于下次还会踩**。
本仓库里每条 `#N FIX` 注释背后都有一条判据。

### 17.5 一条容易被忽略的判据：体积

```
$ arkcc add3.c -target arm -c -o add3.ark_obj -v
[arkcc] arena peak 28688/67108864 B
```

内存池峰值是**唯一**能在开发期发现"这个功能吃太多 RAM"的读数。
板上池 80 KB，如果某次改动让 `add3.c` 的峰值从 28 KB 涨到 50 KB，
你还有余量；涨到 90 KB 就是"某天突然编不动了"。所以这个数字要**盯着看**，
不能等到板上报 `exhausted` 才知道。

---

## 第 18 章 练习路线：从 30 行到 3 万行

按这个顺序做，每一步都能跑出可验证的结果。**不要跳步**——跳过的每一步都会在
第 10 步以后变成查不出的 bug。

### 阶段 1：只会 `return N`（半天）

目标：`int main(void) { return 42; }` → 一段能返回 42 的 ARM 机器码。

- 词法：只认 `int` `void` `main` `(` `)` `{` `}` `return` `;` 数字
- 语法：只认"返回类型 + 名字 + (void) + { return 整数; }"
- 后端：直接发 `MOVS r0, #42` + `BX lr` 的字节（手算编码，见附录 B）
- **判据**：用 `arm-none-eabi-objdump -D -b binary -m arm --disassembler-options=force-thumb`
  反汇编，看到 `movs r0, #42`

【示意代码，非本仓库源码】

```c
/* 最小可用版本：能编 "int main(void){return N;}" */
int compile(const char *src, unsigned char *out) {
    const char *p = src;
    while (*p && *p != '{') p++;          /* 找函数体 */
    while (*p && *p != 'r') p++;          /* 找 return */
    while (*p && !isdigit(*p)) p++;
    int n = atoi(p);
    /* MOVS r0,#imm 的 16 位编码：0010 0 imm8 */
    out[0] = n & 0xFF; out[1] = 0x20;
    out[2] = 0x70; out[3] = 0x47;         /* BX lr */
    return 4;
}
```

### 阶段 2：表达式 + 优先级（1~2 天）

- 加 `+-*/`、括号、一元负号
- 用 §7.4 的宏生成优先级层
- 后端：虚拟栈 + `ADD/SUB/MUL`（照抄 §11.3 的 `emit_binary`）
- **判据**：`1+2*3` 编译出来是 `#7` 而不是 `#9`（这两种错误都很好犯）

### 阶段 3：变量、赋值、比较、`if`（2~3 天）

- 帧布局（先不做 8 字节对齐，只做 4 字节）
- `PUSH_VAR/STORE`、`CMP + ITE`
- **判据**：`fib(n)` 递归能算出正确值

### 阶段 4：循环、函数调用、参数传递（3~5 天）

- `while/for` + 标签
- 调用约定：前 4 个参数走 `r0..r3`
- **判据**：`printf("%d %d", 1, 2)` 打对了顺序（参数顺序错是最常见的 bug）

### 阶段 5：指针、数组、结构体（1 周）

- 指针算术缩放（§9.4）
- 结构体布局（§5.4）
- **判据**：`struct {char c; int i;} s;` 的 `sizeof` 是 8，`&s.i - &s.c == 4`

### 阶段 6：预处理器（1 周）

- `#define`（对象宏 + 函数宏）、`#include`、`#if/#ifdef`
- 蓝漆机制（§4.2）
- **判据**：能预处理 `<stdint.h>`、`<string.h>` 而不崩

### 阶段 7：真目标文件 + 链接器（1~2 周）

- 自定义对象格式（§13.1）
- 重定位（§12.4 的位域数学）
- **判据**：两个 `.c` 分别编成对象，链接成一个镜像，跨文件调用正确

### 阶段 8：优化（按需）

- 常量折叠 + DCE（§10.1-10.2）
- **判据**：`-O1` 后行为不变，且至少有一个可量化的体积/指令数下降

### 阶段 9：自托管（真正的硬仗）

- 先让"自己的编译器"能在宿主上编自己（`bootstrap_x86` 的路子）
- 再裁 profile、定缓冲、移植平台层
- **判据**：板上编出的跨文件程序运行结果正确（`add3=6`）

### 一张对照表：你会在哪一步踩什么

| 阶段 | 最可能卡住的地方 | 判据 |
|---|---|---|
| 1 | 机器码字节序、Thumb 位 | 用 objdump 反汇编对 |
| 2 | 优先级 / 左结合 | `1+2*3`、`1-2-3` |
| 3 | 帧偏移算错、`if` 条件没归一到 0/1 | `x = (a<b)` 的值域 |
| 4 | 参数顺序、返回值被压栈覆盖 | 双参数 + 返回值 |
| 5 | 指针缩放、结构体对齐 | `sizeof` / 偏移 |
| 6 | 宏展开终止、`#`/`##` | `CAT(a,b)` / `STR(x)` |
| 7 | 重定位位域、符号强弱 | 跨文件调用 + `__weak` |
| 8 | 优化改变语义（尤其 UB） | `-O0` vs `-O1` 结果一致 |
| 9 | 内存池、缓冲尺寸 | 池峰值 + 板上实跑 |

---

## 附录 A TokenKind / AST / IrOp 全表

### A.1 TokenKind（`include/common.h`）

```
TOK_EOF

C89 关键字     TOK_INT TOK_CHAR TOK_VOID TOK_RETURN TOK_IF TOK_ELSE
              TOK_WHILE TOK_FOR TOK_BREAK TOK_CONTINUE TOK_DO

字面量与标识符  TOK_NUM TOK_STR TOK_IDENT

运算符         TOK_PLUS TOK_MINUS TOK_MUL TOK_DIV TOK_MOD TOK_ASSIGN
              TOK_EQ TOK_NE TOK_LT TOK_GT TOK_LE TOK_GE
              TOK_AND TOK_OR TOK_NOT TOK_BAND TOK_BOR TOK_BXOR TOK_BNOT
              TOK_SHL TOK_SHR

复合赋值       TOK_ADD_ASSIGN TOK_SUB_ASSIGN TOK_MUL_ASSIGN TOK_DIV_ASSIGN
              TOK_MOD_ASSIGN TOK_AND_ASSIGN TOK_OR_ASSIGN TOK_XOR_ASSIGN
              TOK_SHL_ASSIGN TOK_SHR_ASSIGN

自增自减       TOK_INC TOK_DEC

标点           TOK_LPAREN TOK_RPAREN TOK_LBRACE TOK_RBRACE TOK_LBRACKET
              TOK_RBRACKET TOK_SEMICOLON TOK_COMMA TOK_COLON TOK_QUESTION TOK_HASH

C99 关键字     TOK_SHORT TOK_LONG TOK_SIGNED TOK_UNSIGNED TOK_FLOAT TOK_DOUBLE
              TOK_BOOL TOK_CONST TOK_VOLATILE TOK_RESTRICT TOK_INLINE
              TOK_STATIC TOK_EXTERN TOK_AUTO TOK_REGISTER
              TOK_STRUCT TOK_UNION TOK_ENUM TOK_TYPEDEF TOK_SIZEOF
              TOK_SWITCH TOK_CASE TOK_DEFAULT TOK_GOTO TOK_FCONST
              TOK_DOT TOK_ARROW TOK_ELLIPSIS

armcc 方言      TOK_ATTRIBUTE TOK_ASM TOK_FUNC_NAME TOK_SVC TOK_IRQ TOK_WEAK
              TOK_NAKED TOK_PACKED_KW TOK_ALIGN_KW TOK_AT TOK_SOFTFP
              TOK_FORCEINLINE TOK_ASM_FN
              TOK_VALUE_IN_REGS TOK_THREAD TOK_GLOBAL_REG TOK_PURE
              TOK_INTERWORK TOK_SMC TOK_INT64 TOK_INT32 TOK_INT16 TOK_INT8
              TOK_TYPEDEF_KW TOK_ARGS TOK_RETURN_KW TOK_TP_SOFT TOK_NOTHROW
              TOK_DEPRECATED_KW TOK_MAY_ALIAS TOK_DECLSPEC

其它           TOK_COMPLEX  TOK__SENTINEL
```

> 铁律（写在 `common.h` 注释里）：`TOK_PLUS..TOK_SHR_ASSIGN` 的**数值**被
> irgen/codegen 当操作符 id 用，新 token 只能追加到末尾。

### A.2 AstNodeKind

```
AST_PROGRAM AST_FUNC_DEF AST_FUNC_DECL AST_VAR_DECL AST_BLOCK AST_RETURN
AST_IF AST_WHILE AST_FOR AST_DO_WHILE AST_BREAK AST_CONTINUE
AST_BINARY AST_UNARY AST_TERNARY AST_ASSIGN AST_NUM AST_VAR
AST_ARRAY_ACCESS AST_FUNC_CALL AST_EXPR_STMT
AST_STR AST_CAST AST_MEMBER AST_SIZEOF AST_SWITCH AST_CASE AST_DEFAULT
AST_GOTO AST_LABEL AST_COMMA AST_TYPEDEF
AST_INIT_LIST AST_INIT_FIELD AST_ASM AST_COMPOUND_LITERAL
AST_ASM_FUNC
```

设计要点：一个 `struct AstNode` 用一个 `union u` 装下所有变体
（`include/ast.h`）。好处是节点只有一种类型、池分配只走一条路；
代价是 `union` 里最大的那个成员决定每个节点的体积。为了省内存，
把 `num_val`（8 字节）和一组指针并起来，同一时刻只有一个有效。

### A.3 IrOp

```
基本     IR_NOP IR_PUSH_INT IR_PUSH_VAR IR_PUSH_ADDR IR_POP IR_STORE
        IR_STORE_IDX IR_LOAD_IDX IR_BINARY IR_UNARY IR_CALL IR_RETURN
        IR_LABEL IR_JMP IR_JZ IR_JNZ IR_FUNC_BEGIN IR_FUNC_END
        IR_LOCAL_ALLOC IR_ARG IR_GETARG

字符串/全局  IR_PUSH_STR IR_PUSH_GLOBAL IR_STORE_GLOBAL IR_PUSH_GLOBAL_ADDR
栈操作      IR_DUP IR_SWAP
用户标签     IR_LABEL_NAMED IR_JMP_NAMED IR_CMP_JMP_EQ
浮点        IR_PUSH_FLOAT IR_FADD IR_FSUB IR_FMUL IR_FDIV IR_FCMP
           IR_F2I IR_I2F IR_F2F
内联汇编/系统调用 IR_ASM IR_SVC IR_SMC
整数除法    IR_DIV IR_MOD
64 位       IR_64BINARY IR_64PUSH IR_64CMP IR_64F2I IR_64I2F
           IR_SEXT IR_ZEXT IR_CDECL64 IR_TRUNC
聚合        IR_MEMCPY
位域        IR_STORE_FLD IR_LOAD_FLD
其它        IR_ALLOCA（VLA） IR_PUSH_FUNC
SIMD        IR_SIMD_ADD16 IR_SIMD_SUB16 IR_SIMD_ADD8 IR_SIMD_SUB8
```

`aux` 字段的约定汇总（这是本项目的"秘密协议"，写代码前先背下来）：

| 指令 | aux 的含义 |
|---|---|
| `IR_PUSH_VAR` / `IR_STORE` | bit0..7 宽度(1/2/4/8/16)；0x100 无符号；0x10000 volatile |
| `IR_BINARY` | 低 8 位 = TokenKind；0x100 = 无符号比较/移位 |
| `IR_DIV` / `IR_MOD` | 0 = 有符号，1 = 无符号 |
| `IR_64BINARY` / `IR_64CMP` | 同 IR_BINARY |
| `IR_FCMP` | 低 8 位 = 比较种类；0x200 = double |
| `IR_F2I` / `IR_I2F` | 0x200 = double；0x400 = 无符号；0x400/0x500 复数特例 |
| `IR_LOAD_FLD` / `IR_STORE_FLD` | val = 位偏移，aux = 位宽 |
| `IR_MEMCPY` | val = 字节数 |

---

## 附录 B 本编译器用到的 Thumb-2 编码速查

下面每一条都用本仓库**真实产出的字节**验证过（`add3.ark_obj` 的前 32 字节）。

### B.1 `PUSH {r5,r6,r7,lr}` = `e0 b5`

```
0xB5E0 = 1011 0101 1110 0000
         ^^^^ ^^^^
         |    └── 寄存器列表：r5=bit8(0x20) r6=bit9(0x40) r7=bit10(0x80) → 0xE0
         └────── PUSH，M=1 表示包含 lr
```

小端写成字节就是 `e0 b5`。`PUSH {r0}` = `0xB401` → `01 b4`。

### B.2 `SUB sp, sp, #24` = `86 b0`

```
0xB086 = 1011 0000 1000 0110
         ^^^^^^^^^^^^ ^^^^^^
         操作码        立即数/4 = 6 → 24
```

16 位形式只能表示 `imm/4`（0..508）。`ADD sp, sp, #N` 同理（`0xB0xx`）。

### B.3 `MOV r6, sp` = `6e 46`

```
0x466E = 0100 0110 0110 1110
         ^^^^^^^^^^^^^^^^^^^^^
         MOV(register) T1：Rm=sp(13) Rd=6
```

### B.4 `STR r0, [r6, #0]` = `30 60`

```
0x6030 = 0110 0 0 00000 110 000
         ^^^^^^ ^^^^^ ^^^ ^^^
         操作码  imm5  Rn  Rt
```

`imm5` 是**字节偏移/4**。所以 `STR r1,[r6,#8]` → imm5=2 → `0x60B1` → `b1 60`；
`STR r2,[r6,#16]` → imm5=4 → `0x6132` → `32 61`。**你可以用这个式子逐字核对
任何一条本编译器生成的存取指令。**

### B.5 `ADD r0, r0, r1` = `40 18`

```
0x1840 = 0001 100 001 000 000
         ^^^^^^^ ^^^ ^^^ ^^^
         操作码   Rm  Rn  Rd   → r0 = r0 + r1
```

### B.6 `POP {r1}` = `02 bc`

`0xBC02`：`1011 1100 0000 0010`，寄存器列表 bit1=1（r1），P=1 表示 POP。

### B.7 `BL` 与 `B.W`（32 位，两条 halfword）

```
BL  T1: hi = 11110 S imm10 ; lo = 11 J1 1 J2 imm11
B.W T4: hi = 11110 S imm10 ; lo = 10 J1 1 J2 imm11
B<cond>.W T3: hi = 11110 S cond imm6 ; lo = 10 I1 0 I2 imm11
```

`J1 = ~(I1 ^ S)`、`J2 = ~(I2 ^ S)`（§12.4 的代码就是这个式子）。注意
T1/T4 的低字里放的是**取反后**的 J1/J2，而 T3 放的是 I1/I2 本身——
这三条指令的位布局看起来相似，混淆一个位就会跳到错误的地址。

### B.8 `MOVW` / `MOVT`

```
MOVW: 11110 i 10 0100 imm4 | 0 imm3 Rd imm8
MOVT: 11110 i 10 1100 imm4 | 0 imm3 Rd imm8
```

本编译器只在"立即数 > 255"时用它们（§11.4），并且**总是成对使用**。

### B.9 `DMB SY` / `DSB SY` / `ISB SY`

`DMB SY` = `F3BF 8F5F`（32 位）。注意：16 位形式 `0xBF50` 在 ARMv7-M 上
**不成立**（§12.3 的注释），必须用 32 位 T1 编码。

---

## 附录 C 术语表

| 术语 | 这份文档里的含义 |
|---|---|
| **翻译单元 (TU)** | 一个 `.c` 加上它 include 的所有头文件，展开后的一整块文本 |
| **预处理** | 纯文本替换：展开宏、拼接 include、按条件删代码 |
| **Token** | 词法单位（关键字/标识符/字面量/运算符） |
| **AST** | 抽象语法树：去掉括号、分号之后的结构 |
| **IR** | 中间表示：与机器无关、但已经是"计算步骤"的形式 |
| **栈式 IR** | 用虚拟栈传递操作数；每条指令的栈效应是局部的 |
| **SSA** | 静态单赋值：每个值只定义一次（本仓库未使用） |
| **降级 (lower)** | 把高层构造翻译成低层表示的过程 |
| **帧 (frame)** | 函数私有的一小块栈空间，放参数、局部变量、临时量 |
| **序言/尾声** | 函数的进入/退出序列（保存寄存器、调整 sp） |
| **重定位** | 链接时"把这个位置的地址改成最终地址"的记录 |
| **scatter / 分散加载** | ARM 用文本描述"哪段代码/数据放到哪块内存" |
| **强/弱符号** | 同名时强符号胜；`__weak` 提供可覆盖的默认实现 |
| **自托管 (self-hosted)** | 编译器能跑在目标平台上并产出目标平台的可执行物 |
| **自举 (bootstrap)** | 编译器能（在目标上）重新编译自己 |
| **差分测试** | 用两个独立实现跑同一输入，比较行为 |
| **定点迭代** | 反复跑同一优化直到不再变化（处理级联） |
| **blue paint** | C 预处理器防止宏无限递归的机制 |

---

## 附录 D 已知限制（写文档时顺带查出来的）

按"影响 + 是否已修"分三类。**这一节存在的意义**：读到这里的人应该知道
"哪些坑我已经踩过、哪些还在"。

### D.1 本次写文档时发现并修掉的

| 缺陷 | 现象 | 状态 |
|---|---|---|
| `__STDC__` / `__ARK_CC__` 在 `#ifdef` / `#if` 中判为未定义 | `#ifdef __STDC__` 走 else 分支（C99 6.10.8.1 要求为真） | **已修**（`src/preproc.c`，见 §4.4）；诊断测试 0 失败 |
| `__ARK_VERSION__` 文档声称预定义、实际没实现 | 用户写 `__ARK_VERSION__` 会漏成未声明标识符 | **已修**（现展开为 `"0.7.0"`） |

### D.2 已知但未修的边界

| 限制 | 原因 / 影响 |
|---|---|
| `-link` **不搬数据段** | 各对象的数据段从同一基址排布；两个对象都带全局变量时地址会重叠。现在**报错**而不是静默产出错镜像（§13.4） |
| 汇编器不支持完整 Thumb-2 | 只支持本后端会发出的那些指令；手写 `.s` 里出现别的指令会报错 |
| 无条件/条件分支一律 32 位 | 体积换正确性（§12.3） |
| 每个目标文件内联一份 `__aeabi_*` | 自包含的代价；链接时靠前缀豁免去重（§11.7、§13.3） |
| `-S` 输出包含运行库，实测 13.7 KB/最小程序 | 板上 4 KB 文件槽写不下，`-S -o` 在板上必然失败（§16.4） |
| 无寄存器分配 | IR 层栈式 + 后端逐条翻译，生成的代码"每个操作数都过内存"（§1.3 的汇编就是证据） |
| 预处理后行号不再映射回原文件 | 诊断回显切换为预处理后文本（§4.1），尖号仍指向正确**列** |
| `-target c` 的运行时前导很大（约 30 KB 文本） | 它是调试工具，不追求产物体积 |
| 优化只有 constfold / DCE / 内联 / 一种循环向量化 | 没有循环优化、没有公共子表达式消除、没有寄存器分配 |
| `long double` 等同 `double` | ARM 上本来就是 8 字节 |

### D.3 本教程没覆盖到的部分

- **DWARF 调试信息**（`-g`）：`backend_arm.c` 里发 `.file`/`.loc`/`.cfi_*`，
  `compiler.c` 有段表拼装。它不影响"能不能跑"，只影响"能不能在调试器里单步"，
  所以留作进阶。
- **`__asm` 函数体与内联汇编**（`AST_ASM` / `AST_ASM_FUNC`）：本质是"原样透传
  文本到输出"，没有编译逻辑，但要注意寄存器和 clobber 语义。
- **`_Complex`**：IR 里用两个 long long 表示实部/虚部（16 字节），
  内置函数（`creal`/`cimag`/`conj`/`cabs`/`carg`）在 irgen 里被直接降级成
  `IR_F2I`/`IR_I2F` 的特例（aux 高位的 0x400/0x500）。
- **x86_64 与 RISC-V 后端**：结构与 ARM 后端同构，只是编码表不同。
  读懂了第 11/12 章，这两个就是"换一张表"。

---

## 后记：这份文档本身是怎么验证的

本文里出现的每一段代码、每一行输出、每一个字节，都可以用仓库里的工具重新跑出来：

```bash
# 环境
make                                   # 构建 arkcc（gcc，C99）

# 真实产物
arkcc add3.c -target arm -S -o add3.s            # §1.3 / §11 的汇编
arkcc add3.c -target arm -c -o add3.ark_obj -v   # §13 的目标文件 + 池峰值
arkcc t1.c -target c -o t1.gen.c                 # §1.3 / §10 的 IR 投影
arkcc cf.c -target arm -O1 -S -o -               # §10.5 的常量折叠
arkcc add3.c -target arm -S --scatter *.sct -o a.s -v   # §14.4 的 sct→ld

# 判据
make test
python tests/run_diag_tests.py
python tests/run_diag_boundary.py
```

如果你在自己实现时发现本文某段代码和你手上的源码对不上，**以源码为准**，
然后把这一节改掉——文档漂移比 bug 更耗人。
