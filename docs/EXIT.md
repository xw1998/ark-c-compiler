# 退出路径上的帧维护消解（`-fopt-exit`）

[English](EXIT.en.md) | 中文

> 0.9.1 的第八块优化。一句话：**函数体既然一次都没碰过 sp，返回点的 sp 就还等于帧基址，
> 那么 `MOV sp, <base>` 写进去的正是它已经持有的值——删掉；连帧基址都从没被当地址用过时，
> 建基址的那条 `MOV <base>, sp` 也一起删掉。**
>
> 实现位置：`src/backend/arm/backend_arm.c`，`ark_exit_function()`（ARM 后端文本行级 pass，
> 紧跟在 `ark_frame_function()` 之后、`ark_fix_far_offset()` 之前）
> 门禁：`tests/run_exit_tests.py`（`make test-exit`）
> 开关：`-fopt-exit` / `-fno-opt-exit`，INI `opt-exit=` / `exit=`
> 可裁切：`ARKCC_FEATURE_OPT_EXIT`（`STM32_MIN` 剖面为 0，被裁掉后按名字拒绝）

---

## 1. 现象：每个返回点都在重写一个没变过的寄存器

带帧的函数长这样：

```asm
PUSH  {r5, r6, r7, lr}
SUB   sp, sp, #16
MOV   r6, sp            ; 建帧基址
...
MOV   r6, sp            ; ← 冗余（E2）
...
MOV   sp, r6            ; ← 冗余（E1）
ADD   sp, sp, #16       ; 走回帧顶（必须留）
POP   {r5, r6, r7, pc}
```

`MOV sp, r6` 是**安全的默认**：一旦某个 `if` 的某条臂里漏掉了一对 `PUSH`/`POP`，
函数体末尾的 sp 就不再等于帧基址，`POP {...,pc}` 会读到错的字。此时用基址把 sp
重建一遍，返回路径就与「函数体是否收支平衡」解耦。

但代价是：**每条返回路径都要付一条指令**，哪怕函数体从头到尾没动过 sp。语料里
这种函数占绝大多数——凡是被 `-fopt-vstack` 把值栈搬进寄存器、或者干脆没有局部变量的
函数，函数体里一个 sp 的提法都没有。

## 2. 两条规则

整段逻辑在**文本行级**，只做删除：不加标签、不改分支目标、不改帧大小，因此
`ark_fix_far_offset`、字面量池偏移、控制流都看到与之前同一个函数。

### E1 —— 删掉 `MOV sp, <base>`

判据是「整个函数体可证明不移动 sp」，等价于：prologue 之后到函数结束，
除下面三类之外**没有任何一行提到 `sp`**：

| 可接受 | 说明 |
| --- | --- |
| `POP {…, pc}` | 返回路径，原样保留 |
| `MOV sp, <base>` | E1 自己的候选 |
| `MOV sp, <base>` 紧跟的 `ADD sp, sp, #N` 或 `SUB sp, sp, #N` | 收尾走回帧顶的那条，**保留** |

第三条是关键细节：`ADD sp, sp, #16` 不是 no-op——sp 必须越过帧才能让 `POP` 读到
callee-saved 那几个字。所以删的只有它前面那条 `MOV sp, r6`，`ADD` 原样留着。
而「紧跟」这个位置约束是必要的：sp 调整出现在别处（VLA 的 `SUB sp, sp, r0`、
内联汇编的 `sub sp, sp, #4`）意味着函数体在动栈，基址就是承重的，整函数拒绝。

### E2 —— 再删掉 prologue 的 `MOV <base>, sp`

前提是 E1 已经成立，且基址寄存器在**整函数其余位置一次都没被提到**：
建出来的基址从没被当作 `[r6, #off]` 读过，那么它就是一个建完即弃的值。
`PUSH {…, r6, …}` / `POP {…, r6, …}` 里的 r6 是保存槽、不算使用（它们本来就在
prologue 与 epilogue 里，行级判定只看「提到」）。只要函数体里出现一次 `r6`，
就只取消 E2 资格，E1 照做。

### 保守拒绝

出现下列任一项，**整个函数一个字都不动**：

- 任何 `PUSH`（值栈泄漏会让 POP 读到错的字，正是 `MOV sp, base` 存在的原因）
- 任何不含 `pc` 的 `POP`
- 任何别处出现的 sp 提法（`LDR sp` / `STR sp` / 位置不对的 `ADD|SUB sp, sp, …`）
- 超长行、超过 8192 行的函数（表容量护栏）
- 找不到唯一的 prologue 形状 `MOV <base>, sp`（基址不是 r4–r11）

## 3. 为什么排在 `-fopt-frame` 之后

放在 frame **之前** 也有好处：`-fopt-frame` 看到 r6 没被用过，可以顺手把
`PUSH {…, r6, …}` 里的 r6 保存槽和 4 字节对齐 padding 一起去掉，理论上再多省一点
（E2 的 48 个函数上限）。

代价是 frame **整体放弃**：`ark_frame_function` 靠扫 `MOV <base>, sp` 定位帧基址，
基址被提前删掉它就不认这个函数了，于是连它本来能省的 `SUB sp`/`ADD sp` 都省不到。
两相权衡，收益明确的只有后者，所以次序是 **frame → exit → fix_far_offset**。

## 4. 实测（95 个 HAL/Core TU，`-O2` + 24 个 `-fopt-*`）

| 指标 | 关 | 开 | 差 |
| --- | --- | --- | --- |
| 指令数 | 12,146 | 11,913 | **−233** |
| 汇编字节 | 403,994 | 400,499 | **−3,495** |
| 未定义标签 / 失败 TU | 0 / 0 | 0 / 0 | — |

逐 TU 有 18 个变短、**没有一个变长**（`stm32f4xx_hal.c −33`、`hal_cortex −31`、
`hal_dma −28`、`stm32f4xx_it.c −18`、`hal_pwr_ex −18`、`hal_flash_ex −17`、
`hal_flash −15`、`hal_rcc −13`、`hal_rcc_ex −13`、`hal_pwr −12`……）。

删除量的构成（语料统计，与上面 −233 对得上）：

| 规则 | 触发的函数 | 删除行数 |
| --- | --- | --- |
| E1 | 166 个带帧基址的函数中 139 个 | 185 |
| E2 | 其中再 48 个（基址从未被读过） | 48 |
| 合计 | — | **233（约 1.9%）** |

剩下那 27 个带帧函数为什么拒绝：函数体里有 `PUSH`（没被 `-fopt-vstack` 收干净的
值栈），或者 sp 在体内被调整（VLA / `alloca` / 内联汇编）。
**这是设计：宁可少省，也不给错答案。**

## 5. 门禁

`tests/run_exit_tests.py`（`make test-exit`）逐条钉死 18 项：

| 检查 | 内容 |
| --- | --- |
| OFF IS OFF | `-O2 <passes>` 与再加 `-fno-opt-exit` 的汇编与镜像**逐字节相同** |
| E1 会触发 | 有局部的函数：`MOV sp, <base>` 计数 1 → 0，指令数下降（下降量非 0） |
| E2 会触发 | 无参数无局部的 `void` 函数：`MOV <base>, sp` 也 1 → 0，且「每函数恰好少两条」 |
| 基址真被读 | 同一条 E1 夹具里，`MOV <base>, sp` 计数不变（E2 必须退让） |
| 收尾要留 | 每个函数的 `ADD sp, sp, #N` 与 `POP {…, pc}` 计数都**不变** |
| 镜像不增 | 每个臂的镜像字节数 ≤ 关掉的臂 |
| 标签完整 | 所有分支目标都有定义 |
| 必须不动 | VLA（`SUB sp, sp, r0`）与内联 `sub sp, sp, #4` 的函数**逐字节相同** |
| 答案不变 | 递归帧函数 + 两条返回的 epilogue + 无帧使用的 `void` 函数 + VLA：四个臂（`base`/`off`/`on`/`all`）在 unicorn 上返回 48，与 Python 独立算出的期望值一致 |
| 裁切拒绝 | `-DARKCC_FEATURE_OPT_EXIT=0` 的构建对 `-fopt-exit` 报 `C3900U` 并点出旗标名；不带旗标照常编译 |

## 6. 归属

- 与 `-fopt-frame` **互补不重叠**：frame 处理 `SUB sp`/`ADD sp`/保存槽这三样，
  exit 处理返回路径上的 `MOV sp, base` 与没被用的 `MOV base, sp`。两者都开时
  语料上 frame 只留 `MOV sp, base` + `POP {…, pc}`，exit 正好把前面那条删掉。
- 与 `-fopt-vstack` **强相关**：值栈进寄存器之后函数体才「不碰 sp」，E1 才有资格触发。
  语料里被拒的 27 个函数基本都是值栈没收回来的。
- 与 `-fopt-litpool`、`-fopt-addr` 无耦合：纯删除，`ark_fix_far_offset` 之后照常跑。
