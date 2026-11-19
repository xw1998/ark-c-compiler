# MIR/CFG 与三条跨函数检查

[English](MIR_CFG.en.md) | 中文

0.8.5 之前 arkc 的中端是"在 `IrInst` 数组上就地扫"：`constfold`、`dce`、
`dce-cfg`、`inline` 各自需要什么结构就现搭什么结构。三条需要**图**的检查
（不可达代码、无人调用的 static 函数、递归）如果也照这个办法，就会变成三份
互相不知道对方存在的边遍历。

0.8.6 起这三条共用一份中端基底：`src/mir.c` 把 `IrFunc` 切成基本块、把
`IrProgram` 收成调用图；`src/mirpass.c` 只在这两张图上做判断和打印，
**一条 IR 都不改**。

开关是三个独立选项，默认**全关**：

```
--warn-unreachable      不可达代码
--warn-unused-static    static 函数无人调用
--warn-recursion        调用环（含自递归）
```

## 1. 两张图

### 1.1 基本块图（`MirFunc`）

- leader 规则：第 0 条指令、每个 `IR_LABEL` / `IR_LABEL_NAMED` 的目标、
  每条终止符（`JMP/JMP_NAMED/JZ/JNZ/CMP_JMP_EQ/RETURN/FUNC_END`）的下一条。
- 块按指令序排列，因此块区间 `[start,end)` 是连续的、覆盖全部指令。
- `succ[2]`：`JZ/JNZ` 两条、`CMP_JMP_EQ` 一条（保留 `CMP_JMP_EQ` 的
  "不等于则落空到下一块"契约由下一块的 leader 位置表达）、其余终止符最多一条。
- pred 列表扁平化成 `pred_start[]/pred_count[]`，不分配链表。
- `mir_inst_block()` 给每条指令反查所属块。

不变量（`mir_verify()` 逐条查）：

1. 块数与区间覆盖 `0..code_count`，`start<end`；
2. 除最后一块外，每块最后一条指令都是终止符；
3. 每条边的两端块存在，且目标块的 `start` 恰是该指令跳转目标；
4. `pred` 与 `succ` 互证——`b` 在 `succ[a]` 里当且仅当 `a` 在 `pred[b]` 里。

`mir_verify` 不是门禁里的独立用例，而是 `mir_build` 之后的开发期断言
（`#ifdef MIR_DEBUG_VERIFY` 打开）；它存在是为了让"图错了"和"判断错了"能分开。

### 1.2 调用图（`MirCallGraph`）

- 节点是 `IrProgram` 里的函数，一条 `IR_CALL` 能按名字解析到本 TU 的函数
  就加边；解析不到的（函数指针调用、外部符号）计入 `unresolved_calls`。
- `addr_taken[i]`：`IR_PUSH_FUNC`、全局初始化里的 `init_sym` /
  `init_refs[]`、`alias_target` 都算"地址被取"。
- `saw_inline_asm`：本 TU 里出现过 `IR_ASM` 或 `is_asm_func`。

## 2. 三条判据

### 2.1 `--warn-unreachable`

从块 0 做 BFS，把**不可达**的极大连续块段合并成一次报告，指令数只计
"真指令"（`mp_is_real_inst`：标签、`FUNC_BEGIN/END`、`NOP` 不算）。

**phantom 块规则**（关键取舍）：只含 push / `JMP` / `RETURN` / 标签 /
`FUNC_*` / `NOP` 的块不报告。原因不是它们不可达，而是 irgen 自己就会写出这种块：

- `if (x) return 1;` 分支体已经 return 之后仍会补一条 `JMP end_l`；
- 每个函数末尾都有隐式的 `PUSH_INT 0; RETURN`。

这两类形态与用户手写的死代码无法区分，而"给每个函数都报一条"会让检查失去
意义。代价是**漏报**：`return 1; return 2;` 里孤零零的 `return 2;` 不报。
这条取舍写在门禁断言里（`registered miss`），不是意外。

### 2.2 `--warn-unused-static`

判据（全部满足才报）：`is_static` 且没有入边、地址未被取、不是
`used`/`unused`/`weak`/`constructor`/`destructor`/`asm`、不是 `inline`
也不是 `__forceinline`。

- `inline` / `__forceinline` 一律沉默，对齐 GCC 的 `-Wunused-function`
  （`<stdarg.h>` 的 `_Generic` 助手就是这种形态：只有被选中的分支才会产生
  调用，未被选中的名字在 sema 之后消失）。为此 0.8.6 给 `IrFunc` 补了
  `is_inline`——此前 parser 把 `inline` 当噪声丢掉。
- 整份 TU 里出现 inline asm 时**整体沉默**：asm 文本里的符号这张图读不到，
  猜边就是给错答案。

### 2.3 `--warn-recursion`

对调用图做 Tarjan（迭代实现，显式帧栈——递归的 SCC 算法在 4 KB 栈的板端
会溢出），每个"成环的 SCC"报一次：

- `size > 1` → `'a' is in a call cycle with 1 other function(s) ...`；
- `size == 1` 且有自环 → `'self' calls itself ...`。

报告位置取该 SCC 的最小索引成员（与 GCC 打在同一处，便于对照）。
函数指针调用（`unresolved_calls`）只会让环**少看见一条边**，因此只导致漏报，
不会误报，不需要沉默。

## 3. 刻意不做的事

| 形状 | 行为 | 为什么 |
| --- | --- | --- |
| 孤立的 `return 2;` / 纯 `JMP` 死块 | 沉默 | phantom 块规则，见 2.1 |
| `static` 无人调用的变量 | 不报 | 属 `ast` 层与链接层，不是调用图的事 |
| `(void)` 之外的值丢弃 | 不报 | 那是 `--warn-unused-result` 的职责 |
| 函数指针 / 外部符号调用 | 只漏报 | 图上没有边，宁可漏不可猜 |
| 含 inline asm 的 TU 的 unused-static | 整单元沉默 | asm 里的符号不可见 |
| 递归但被内联 / 被 tail-call 优化 | 仍报 | 这是源码层事实，与后端是否优化无关 |

## 4. 位置与可裁减

三条都排在 IR 阶段表**最前**（`constfold` 之前），理由是：lint 必须描述
**源码**。`constfold` 会把 `if (0)` 折成无条件跳转，此后看到的"不可达"是
优化器的产物，不是用户写的东西。

它们共用 `ARKCC_FEATURE_MIR`（都在 `src/mir.c` 上，拆开关只会让构建带上
一份用不到的图构造器）：

```c
/* include/arkcc_config.h */
#ifndef ARKCC_FEATURE_MIR
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_MIR 0      /* 板上裁掉 */
# else
#   define ARKCC_FEATURE_MIR 1
# endif
#endif
```

开关不在的构建里：三个正选项与三个 INI key 以 `C3900U` 拒绝并给出重建方法，
三个 `--no-` 形式永远接受。

## 5. 门禁

`tests/run_mir_tests.py`（`make test-mir`），覆盖：

1. 不可达：真死代码报一次、行号正确；`if/else`、`while`、`switch`、`goto`
   孪生全部沉默；`registered miss`（孤立 `return`）沉默；
2. unused-static：只报无调用的那个；被调用 / 地址被取 / `unused` /
   `inline` / `__forceinline` 全部沉默；含 inline asm 的单元整体沉默；
3. recursion：互递归与自递归各报一次、文案区分、非递归沉默；
4. 反假绿：不带开关同一文件零输出、`--no-` 能关、正形式能再点亮；
5. `--print-pipeline` 列出三条阶段名与开关名；
6. **零变化**：同一源在三条全开与全关下产出的 `.o` 逐字节相同（sha256）；
7. 裁减：`-DARKCC_FEATURE_MIR=0` 现场重建后，三个正选项都必须被拒，
   同一文件仍能正常编译；
8. `arkcc.cfg` 的三个 key 能打开对应检查。

## 6. 已知局限

- 基本块按指令序线性编号，报告位置用"死段首块的起始行"；若死段跨多行，
  只报一次（不是逐行报）。
- 调用图不区分"调用点是否可达"：`#if 0` 之外、永不被调用的函数仍会被当作
  调用者，这只会让 unused-static 漏报。
- `alias_target` 视为地址被取，但不建"别名调用"反向边——别名函数的调用点
  写的是别名，原函数因此可能漏报。
- 不是数据流分析：不可达只按控制流判定，`while (0)` 里的活代码会被正确
  报告，但 `if (0)` 常量折叠发生在 IR 生成期，`constfold` 之前就已不可达，
  这一点与编译器之前的版本行为一致。
