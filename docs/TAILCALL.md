# 尾调用 → 跳转（`--tailcall`）

> 0.9.1 的第二条优化。一句话：**`return g(args);` 在实参全部装进 r0–r3、且返回值原样
> 交还给调用者时，先把本帧拆掉、再把 `BL g` 换成 `B g`**。两帧由此并成一帧。
>
> 实现位置：`src/backend/arm/backend_arm.c`（**发射期**，不是新的 pass）
> 门禁：`tests/run_tailcall_tests.py`（`make test-tailcall`）
> 开关：`--tailcall` / `--no-tailcall`，INI `tailcall=` / `tail-call=`

---

## 1. 为什么放在发射期，而不是新增一个 IR opcode

`IR_CALL` 后面**紧跟** `IR_RETURN`，语义上就已经是「这个调用的结果就是本函数的结果」——
任何要转换的情况（`int → long long` 加宽、截断、`_Complex` 重排、结构体拷贝）都会在两者
之间**插入指令**，于是「相邻」这个判据不需要额外的正确性证明。

反过来，加一个 `IR_TAILCALL` opcode 要同步改 4 个后端、`irser`、`MIR`，还要在 irgen 里
证明每个可能插入指令的位置都不漏。风险与收益不成比例。发射期判定的好处是**天然满足
「宁可报错」**：条件不成立就一个字节都不改。

## 2. 识别的两种形状

`f->code` 是线性的，`i` 是当前 `IR_CALL` 的下标。

| 形状 | C 源码 | IR 形态 | `tail_call_skip` |
| --- | --- | --- | --- |
| A | `int f(int x) { return g(x + 1); }` | `IR_CALL` → `IR_RETURN` | 1 |
| B | `void f(int x) { g(x); }` | `IR_CALL` → `IR_PUSH_INT 0` → `IR_RETURN` | 2 |

形状 B 之所以要单列，是因为 **irgen 给每个函数体末尾都补一条 `PUSH_INT 0 / IR_RETURN`**
（`return;` 与「函数体自然结束」走同一条路）。被调方是 `void` 时它不压栈，于是 IR 里留下
一个只为满足「RETURN 要有一个栈顶」而存在的假值。

识别依据是 `IR_CALL` 的 `val` 第 33 位——**irgen 从调用表达式的类型打上去的「这个调用是
void」标记**，取的是原型，所以只有声明没有定义的被调方也能覆盖。这里不靠猜。

跳过后续指令用计数器 `tail_return_pending`（主循环顶部 `if (tail_return_pending) { --; continue; }`），
而不是在 `case IR_RETURN:` 里做条件抑制——因为要跳过的可能是**两条**指令，且中间那条
`PUSH_INT` 走的是另一个 case。计数器在关掉开关的构建里恒为 0。

## 3. 拒绝条件（每条都有具体后果）

公共前置：`g_config.enable_tailcall && !is_indirect && !is_sret_call && cplx_ret == 0 &&
!f->is_naked && !f->is_irq && !f->is_variadic && g_va_epilogue_pad == 0`。

| 拒绝 | 后果 |
| --- | --- |
| `stack_args > 0`（实参超过 4 个字，有栈参） | 栈参要搬到**调用者的**栈参数区，而那块正在被 `MOV sp, r6` 拆掉；写进去会踩到本帧保存的寄存器区/调用者参数区 |
| 间接调用（`is_indirect`） | 被调地址本身活在本帧里，先拆帧再取地址就读到垃圾 |
| sret（返回结构体缓冲区） | 缓冲区由调用者在本帧里分配，跳走后没人能填 |
| `_Complex` 返回 | 同上，四个字走调用者缓冲区 |
| `__naked` / `__irq` | 它们的帧形状不是下面第 4 节恢复的那一种 |
| 变参函数（`is_variadic`） | va 区在本帧内，且 `g_va_epilogue_pad` 会给收尾额外腾地方 |
| 调用后还要用返回值 | IR 里两者不相邻，形状本身不成立 |

**只做 `stack_args == 0` 这个安全子集**，其余一律原样输出并在本文写清，不做半吊子版。

## 4. 发射序列

```asm
    MOV sp, r6            ; 拆掉 locals，与 epilogue 第一步完全一致
    ADD sp, sp, #N        ; local_size > 0 时
    POP {r5, r6, r7, lr}  ; 恢复 callee-saved；lr 仍是被调方的返回地址
    B   g                 ; 普通 B 不覆盖 lr，被调方的 POP {.., pc} 直接回到我们的调用者
```

两点必须留意：

- **`lr` 必须留着**。这里刻意用 `POP {r5, r6, r7, lr}` 而不是 epilogue 的
  `POP {r5, r6, r7, pc}`——`pc` 变体等于当场返回，跳转就不会发生。
- **`ark_regalloc_function` 会重写 PUSH/POP 行**。它的规则是「保留 lr 的变体会保留 lr 并加宽」，
  与本 pass 发射的形态兼容（门禁里 `tf keeps lr live in its tail-call epilogue` 一条专门盯这个）。

## 5. 裁剪（三层，默认关时零变化）

| 层次 | 手段 | 关掉时的保证 |
| --- | --- | --- |
| 编译期 | `ARKCC_FEATURE_TAILCALL`（`include/arkcc_config.h`，`STM32_MIN` ⇒ 0） | 判定块整体消失（`tail_call_ok` / `tail_call_skip` 变成常 0，`if` 折叠），发射文本**逐字节相同** |
| 运行期 | `g_config.enable_tailcall`，`--tailcall` / `--no-tailcall`，INI `tailcall=` | 默认 0；打开与关闭的默认产物哈希相等（门禁实测） |
| 剖面 | （无需） | 本优化在发射期，不在 `--pipeline` 阶段表里，因此没有 `min_profile` |

裁剪构建**拒绝**选项而不是装作优化：`-DARKCC_FEATURE_TAILCALL=0` 时 `--tailcall` 与
INI `tailcall=1` 都以 `C3900U` 报错并指名该宏（两条路径各有守卫，门禁各一条检查）。

裁剪的实测代价（宿主 gcc -O2，只编 `backend_arm.c`）：`.text` 117084 → 118100 B，
即**这个特性占 1016 B 代码、0 B 数据**；符号表条数 186 → 186（不新增外部符号）。
板端工程 `mdk/STM32H743_ArkCC` 用 `ARKCC_PROFILE_STM32_MIN`（即 `ARKCC_FEATURE_TAILCALL=0`），
UV4 重建 0 Error，Program Size `Code=182820 RO-data=23696`。

## 6. 门禁（`tests/run_tailcall_tests.py`，29 项）

六组，每组可单独失败：

1. **开关真起作用**：`--tailcall` 前后汇编文本不同。
2. **三个正向形状**（`tf` / `tf64` / `vt`）：目标函数体里出现精确的一行 `B <callee>`
   （逐行比对，不用子串——`BL leaf` 含 `B leaf` 会是假绿），且同函数体里 `POP {r5, r6, r7, lr}`
   在 `B` 之前；并且**没有** `BL <callee>`。
3. **递归**：`tsum` 的递归调用变成 `B tsum`。内部标签 `.L_tsum_0:` 属于函数体，
   不能被当成函数边界（第一版测试就是这么截断的）。
4. **六种拒绝形状必须逐字节不变**：结果被后续使用 / 5 个字实参（有栈参）/
   `int → long long` 加宽 / sret / `_Complex` / 间接调用；并且全文没有为它们多出 `B`。
5. **同一 TU 里选择性**：`tn_fn` 被改写、`tn_use` 不动——排除「整个文件其实没跑过」的假绿。
6. **动态 + 字节账 + 裁剪**：模拟器上开关前后返回同一值且值非平凡；默认关闭（产物逐字节相同）；
   `--no-tailcall` 能退回；裁剪构建拒绝选项且默认产物与完整构建哈希相同；
   打开后对象严格变小并打印前后字节数。

## 7. 实测（0.9.1，宿主 gcc / MinGW，`Cortex-M7`）

| 用例 | 读数 |
| --- | --- |
| `tc.c`（`tf` / `tf64` / `vt` / `tsum` 可转；`neg_use` / `neg_args` 不可转） | 汇编 424 → 413 行；对象 1171 → 1157 B |
| `tf` | `BL leaf` + `PUSH {r0}` + `POP {r5,r6,r7,pc}` → `POP {r5,r6,r7,lr}` + `B leaf`（23 → 21 条） |
| `tf64` | 同上，另省掉两字结果的两次 `PUSH`/`POP`（23 → 19 条） |
| `vt` | 省掉 `MOV r0, #0` 与假值的 `PUSH`/`POP`（18 → 15 条） |
| `tsum`（自递归） | `POP {r1}` + `BL tsum` → `B tsum`（55 → 53 条） |
| `neg_use` / `neg_args` | 开关前后逐字节相同 |
| 模拟器 | `off=81 on=81`，且该值非平凡 |

## 8. 与路线图的差异（如实记录）

`docs/OPTIMIZER_PLAN.md` §P2 写的是「`-O1` 起」。实现**没有加 `-O` 级别闸门**，与
`--reg-top` 一致：显式开关本身就是意图表达，再叠一道级别判断只会在 `-O0 --tailcall` 时
造成「说了开却没开」的困惑。此处以本文为准，路线图那行已回填实测。

另一处差异在实现形态：路线图原写「标成 `IR_TAILCALL`」，实际落在发射期（见第 1 节）。

## 9. 刻意没做的事

- **不做栈参尾调用的搬移**：正确性论证要覆盖「新参数块与旧帧重叠」，收益只是多覆盖一个
  形状，先不做。
- **其它后端不实现**：x86-64 与 RISC-V 后端没有这个开关的语义，`--tailcall` 在那里是
  无害的空操作（它们不看 `g_config.enable_tailcall`）。要做必须各自按 ABI 重新论证。
- **不做 `musttail`/`[[clang::musttail]]` 类语义**：本 pass 是机会性的，不做保证。
- **不重排 `sp` 对齐**：`stack_args == 0` 时本帧不向调用者传栈参，`MOV sp, r6` 之后
  sp 与进入时同值，AAPCS 的 8 字节对齐由调用者负责，不在此处额外修正。