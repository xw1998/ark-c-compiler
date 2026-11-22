# `-fopt-live`：用控制流图 + 活跃性删掉只有它看得见的拷贝

[English](LIVE.en.md) | 中文

> 一句话：`-fopt-copyprop` 只能看到一个直线块；真正多的那些拷贝是**绕过分支暂存**的、
> 和**地址先算进临时寄存器再搬进变量**的。`-fopt-live` 为每个函数建控制流图、
> 把寄存器活跃性迭代到不动点，然后按四条规则改写；HAL 全语料上再少
> **2,144 条指令（−9.58%）**、少 **4,818 字节（−9.04%）**。

---

## 1. 为什么做这个

`-fopt-copyprop`（见 `docs/COPYPROP.md`）的两条规则都**故意不看边界之外**：规则 A 只删
「同一块内可证明被覆写」的写，规则 B 只把拷贝推进到紧邻的唯一消费者。这是它能被证明
安全的原因，也是它的天花板。

剩下的拷贝在语料里长得很有规律：

```asm
    MOVW r0, #14384        ; 全局变量地址先算进 r0
    MOVT r0, #16386
    MOV  r5, r0            ; 再搬进值栈池寄存器 r5

    MOV  r7, #0            ; 索引 0 先搬进 r7
    MOV  r1, r7            ; 再搬进寻址用的 r1
    LDR  r0, [r5, r1, LSL #2]
```

判断「`r5` 后面还有没有人读」、「`r7` 是不是只当索引用」，都必须知道**这个值在这一点
之后是否活跃**，而活跃性需要控制流图。IAR 侧对应的是
`CgRegalPhase` / `CgLiverangePhase`（`c_compiler/iar/docs/06-optimizer.md` 与
`08-backend-passes.md`），arkc 这里只取它的第一层：**不分配寄存器，只用活跃性做删除与折叠**。

## 2. 四条规则

四条规则的共同前提是：`rD` 在**这条指令之后**不活跃（`la[j]` 为假），且不被它自己写回。

### L1 死拷贝

> `MOV rD, rS` 或 `MOV rD, #imm`，且 `rD` 之后不活跃 ⇒ 整行删除。

`MOV` 不写条件标志，删掉它不改变任何值与标志。与 copyprop 规则 A 的区别只在
**判定范围**：那里的「之后」严格限制在同一直线块内，这里的「之后」是全函数，
所以能删掉**绕过标签/分支的**暂存：

```asm
    MOV r1, r7          ; 跨过 .L_f_2 之后再没人读 r1
.L_f_2:
    ...
    MOV r0, r5          ; 函数出口前的一次无用搬运
    B   .L_f_0
```

### L2 拷贝推进到消费者

> `MOV rD, rS` 之后**窗口内**（`LV_WINDOW` = 4，含紧邻）出现读 `rD` 的指令；窗口里
> 没有别的指令写过 `rD` 或 `rS`，也没跨基本块；消费者不写 `rD`，且 `rD` 在它之后
> 不活跃 ⇒ 把消费者里的 `rD` 改读 `rS`，删掉拷贝。

与 copyprop 规则 B 的区别：这里**不要求消费者是三操作数 ALU 形**，只要求它是
「读 `rD` 但不写 `rD`」的一条指令 —— 所以 `LDR rD, [rD, ...]`（把 `rD` 当地址基址）、
`CMP rD, X`、`STR rD, [...]` 都可以接；而且消费者的位置**不要求紧邻**。

要窗口的理由：常量材料化与取帧地址常常夹在拷贝和它唯一的消费者之间 ——

```asm
    MOV r1, r4
    MOVW r2, #14384          ; 夹在中间的两条
    MOVT r2, #16386
    LDR r7, [r7, r1, LSL #2]     →     LDR r7, [r7, r4, LSL #2]
```

三条放弃条件，任何一条不满足就这一处整体不动：① 窗口里出现 `rD` 或 `rS` 的写
（`rS` 被改写后就不再是那个值）；② 跨出基本块；③ 窗口满了还没见到读 `rD` 的指令。
窗口长度是宏 `LV_WINDOW`，门禁按 `LV_WINDOW` = 4 的形态校准。

### L3 零索引从寻址模式里去掉

> `MOV rT, #0` 后面紧跟一条指令，其中 `rT` **只**作为地址索引出现，
> 且 `rT` 之后不活跃 ⇒ 把索引丢掉：`[rB, rT]` / `[rB, rT, LSL #n]` → `[rB]`。

```asm
    MOV r0, #0
    MOV r1, r0                   ← L2 已经把这一条折掉
    LDR r0, [r5, r1, LSL #2]     →     LDR r0, [r5]
```

语料里这两种规则总是连着触发：L2 先把 `MOV r1, r7` 折成 `LDR ..., [r5, r7, ...]`，
L3 再把 `r7` 这个零索引整体去掉。所以门禁里 `zero` 夹具一次少 4 条（两个 0 各 2 条）。

### L4 常量地址直接落进目标寄存器

> `MOVW rD, #lo` / `MOVT rD, #hi` / `MOV rX, rD`，且 `rD` 在这条拷贝之后不活跃
> ⇒ 变成 `MOVW rX, #lo` / `MOVT rX, #hi`（IAR 的 `DefIntoMove`）。

```asm
    MOVW r0, #14384
    MOVT r0, #16386
    MOV  r5, r0            →     MOVW r5, #14384
                                 MOVT r5, #16386
```

单条材料化也折：`MOVW rD, #k`（或 `MVN rD, #k`）后面紧跟 `MOV rX, rD`，且 `rD`
在这条拷贝之后不活跃 ⇒ 直接把目标寄存器换成 `rX`（`MOVW rX, #k` / `MVN rX, #k`）。
两者都是 4 字节、都不写标志位、任意寄存器都可用，所以这一步尺寸与语义都不变。
**`MOV rD, #imm` 不在此列**：16 位的 `MOVS` 换成 `MOVW` 会变宽，还会丢掉标志位。

这是语料里最大的一块：九个开关的基线里三连有 **681 处**、`MOVW`/`MVN` + `MOV` 的
二连有 **21 处**，每处少 1 条指令；跑完只剩 2 处三连、1 处二连（那些位置的 `rD`
在消费者之后仍然活跃）。

## 3. 分析怎么做

### 3.1 建图

以**已发射的函数文本**为单位（`from` = 本函数起始行，`b->len` 正好是函数末尾）：

1. 逐行解析成 `cp_ins`（复用 copyprop 的 `cp_parse`），跳过 `.loc` / `.file` / 空行；
2. 每个标签开一个新块，`B<cond>` / `CBZ` / `CBNZ` / `IT` 等按语义切块；
3. 每条边：无条件 `B` 只有跳转目标；条件跳转有「跳转目标 + 下一条」两条；
   `POP {..., pc}` / `BX lr` / `BL` 之后没有后继。

### 3.2 活跃性

`use` / `def` 逐块汇总后，按

```
out = ∪ succ.in
in  = use ∪ (out − def)
```

迭代到不动点（块数 ≤ `LV_MAX_BLOCKS` = 1024）。块内再把「某行之后哪些寄存器活跃」
倒着算一遍，得到逐行的 `la[j]`。

### 3.3 拒绝清单（安全边界）

| 情形 | 处理 | 理由 |
| --- | --- | --- |
| `BL` / `BLX` | 读 `r0–r3`，写 `r0–r3` / `r12` / `lr` | 参数与返回值是隐含的寄存器约定，操作数里看不见 |
| 无后继的块 | `out` = `r0–r3` | 函数出口，调用方读返回值 |
| `CBZ` / `CBNZ` | 第一个操作数是读 | 它们不以 `B<cond>` 的形式出现，容易漏 |
| `pc` / `lr` / `sp` | 15 / 14 / 13 | `POP {..., pc}` 是出口，`BX lr` 也是 |
| `IT` 块内的指令 | 一律不改写 | 条件执行，`la[j]` 为假只在「执行了」的那条路径上成立 |
| 改写目标 | 永不为 `r6` / `sp` / `lr` / `pc` | `r6` 是本后端的帧指针，被活框架依赖 |
| 两操作数 ALU 形 | 第一个操作数**同时是读** | 见 §4.1 |
| L2 窗口内的写 | 见到写 `rD`/`rS` 就放弃这一处 | `rS` 被重写后不再是那个值 |
| 每条改写行 | 先与原文逐字节比对（`lv_same`）再写入 | 解析截断的操作数永远到不了输出 |

### 3.4 `LV_MAX_BLOCKS` 与内存

`LvBlock` 表、行表、标签表都是 `static` 数组，合计约 **1.5 MB**，所以
`ARKCC_PROFILE_STM32_MIN` 档把 `ARKCC_FEATURE_OPT_LIVE` 置 0（见 §9）。

窗口长度与表的上界同属编译期常量：`LV_WINDOW` = 4（L2 的扫描窗口）、`PP_MAX_LINES` = 8192、
`LV_MAX_BLOCKS` = 1024、`LV_MAX_LABELS` = 256；任何一个上界被越过，**整个函数放弃改写**、
按原文输出，不会留下一半改过的文本。

## 4. 三个被测试抓出来的真缺陷

这三个都不是设计问题，是**实现能不能上生产**的问题。按顺序记下来，因为每一个都会
产出「能编译、但答案不同」或「一条规则都不触发」的静默结果。

### 4.1 两操作数 ALU 形：第一个操作数也是读

`LSL r0, r4` 在 16 位编码里是 `r0 = r0 << r4`，`AND` / `ORR` / `MUL` / `ADD` / `SUB` /
`LSR` / `NEG` 的双操作数形式同理。第一版把 `operands[0]` 一律当纯写目标，于是

```asm
    MOV r0, r5
    LSL r0, r7          ; 实际是 r0 = r0 << r7
```

被判成「`r0` 被覆写 ⇒ 前面的 `MOV r0, r5` 是死的」直接删掉 —— **错答案**。

修法：显式的纯写目标白名单 `lv_dest_only()`
（`MOV*` / `MVN` / `NEG` / `UXTB` / `UXTH` / `SXTB` / `SXTH` / `REV` / `REV16` / `REVSH` /
`RBIT` / `CLZ`），其余助记符的第一个操作数**既要当写也要当读**。

修完后语料上的删除量从 −474 条回落到 −98 条 —— 那 376 条里绝大多数都是这个错误删出来的。
门禁里 `shift` 夹具（`1 << (x & 31)`）就是这一条的永久对照：它必须逐字节不变。

### 4.2 `pp_trim` 会剥掉行首空白

文本工具里 `pp_trim` 返回的是**去掉行首空白**的内容。第一版 `lv_rebuild` 拼出
`"    MOV r0, r5"`（4 空格），再与 `pp_trim` 的结果逐字节比对 —— 恒不相等，于是
L2/L3/L4 一条都不触发，只有 L1 生效。表现是「数字有改善、但比预期小很多」，很容易
被当成「规则写得不好」。

修法：`lv_rebuild` 只拼指令本身（不带缩进），写回输出时再 `asmbuf_puts(&out, "    ")` 补上。

### 4.3 比对时机：必须先比后改

第一版在**改完操作数之后**才 rebuild 再与原文比对 ⇒ 同样恒不相等。修法是把比对拆成
独立函数 `lv_same()`，在修改前用原始操作数快照比对；L4 对三行各校验一次，
L2/L3 用 `cp_ins origj = iv[j]` 快照 + `samej = lv_same(...)`。

### 4.4 后补：`ADC` / `SBC` 不能折成三寄存器形式

`-fopt-live` 写完后跑 ARM 执行门禁，`stdlib/src/arm/aeabi.c`（64 位加法）报

```
arkcc: Error: ADC/SBC with three distinct registers (Rd=r1, Rn=r7)
        needs the 32-bit form, not supported
```

根因是同一类折叠在 `-fopt-copyprop` 规则 B 里也存在：`ADC rD, rD, X` 折成
`ADC rD, rS, X` 后变成三个互不相同的寄存器，而 16 位编码**要求 `Rd == Rn`**，本后端的
汇编器不发射 32 位形式。修法两处：`cp_op_ok()` 白名单里去掉 `ADC` / `SBC`；
`-fopt-live` 的 L2 增加 `lv_rd_eq_rn()` 判定，`ADC` / `SBC` / `RSC` 的消费者不被改写。

这条是**两处一起修**的：只修一处，另一处仍会在同一个源文件上失败。

## 5. 与 `-fopt-copyprop` 的分工

| 维度 | `-fopt-copyprop` | `-fopt-live` |
| --- | --- | --- |
| 视野 | 一个直线块 | 整个函数（控制流图） |
| 依据 | 局部覆写 / 紧邻消费者 | 活跃性（`in`/`out` 不动点） |
| 能删的拷贝 | 同块内死拷贝、三操作数 ALU 的推进 | 跨块死拷贝、任意单指令消费者的推进、零索引、常量地址三连 |
| 成本 | 一次扫描，无表 | 约 1.5 MB 静态表 + 迭代 |
| 裁切档 | `STM32_MIN` 关 | `STM32_MIN` 关（表太大） |

顺序上 copyprop 在前、live 在后：copyprop 把能在一眼之内解决的先做掉，live 看到的
是更干净的文本，迭代更快收敛（每个函数最多 4 轮）。

## 6. 实测（HAL 全语料，95 TU 有效，Cortex-M4，`-O2 --reloc-data`）

基线 = 0.9.1 的九个开关
（`vstack addr strength cbz branch imm peep cbranch copyprop`），22,378 条 / 53,284 字节：

| 构建 | 指令数 | 代码字节 | 变化 |
| --- | ---: | ---: | ---: |
| 基线（九开关） | 22,378 | 53,284 | — |
| + `-fopt-live` | **20,234** | **48,466** | **−2,144（−9.58%）/ −4,818（−9.04%）** |

相对最初的五开关基线（34,625 / 80,320）累计为 −13,325（−38.5%）/ −29,672（−36.9%）。

形状账：基线文本里 `MOVW/MOVT/MOV` 三连 **681 处**、`MOVW`/`MVN` + `MOV` 二连 **21 处**
（L4 全部命中，每处 −1 条），剩下的 978 条来自 L2 的消费者推进与随之触发的 L3 零索引折叠。

两个典型函数的完整对比（`D:/tmp/cbrLV/all_000.s` 与 `lv_000.s`）：

```asm
                              ┌─ 基线 ─────────────────────────────
                              │    MOVW r0, #14384
                              │    MOVT r0, #16386
                              │    MOV r5, r0
                              │    MOV r7, #0
                              │    MOV r1, r7
                              │    LDR r0, [r5, r1, LSL #2]
                              ├─ -fopt-live ───────────────────────
                              │    MOVW r5, #14384
                              │    MOVT r5, #16386
                              │    LDR r0, [r5]
```

六行变三行，语义完全一致：`r5` 是地址、`r0` 是被读出的值。

## 7. 实现位置

`src/backend/arm/backend_arm.c`，独立的 `#if ARKCC_FEATURE_OPT_LIVE` 段
（文本工具与 `cp_parse` 等仍与 peep / copyprop 共用同一段守卫）。

| 函数 | 作用 |
| --- | --- |
| `lv_bit` | 寄存器号 → 位掩码 |
| `lv_regs` | 一段文本里的寄存器集合（整 token，`lr`/`pc`/`sp` 认得，`str0` 不认） |
| `lv_dest_only` | 第一个操作数是不是纯写目标（§4.1） |
| `lv_rd_eq_rn` | 该助记符是否要求 `Rd == Rn`（§4.4） |
| `lv_branch_kind` | 0 无 / 1 无条件 / 2 条件 / 3 调用 / 4 `BX`·`BLX` |
| `lv_rw` | 一条指令的读集与写集 |
| `lv_ends_block` | 该行之后是否没有后继 |
| `lv_has_writeback` | 寻址模式里是否有 `!` 写回 |
| `lv_rebuild` | 指令 → 文本（不带缩进，§4.2） |
| `lv_same` | 改写前与原文逐字节比对（§4.3） |
| `lv_repl_reg` | 把操作数里的 `rA` 换成 `rB` |
| `lv_drop_index` | 把 `, rT` / `, rT, LSL #n` 从地址操作数里去掉 |
| `lv_pass` | 建图 + 活跃性 + 四条规则，返回改动数 |
| `ark_live_function` | 最多 4 轮，直到 `lv_pass` 返回 0 |

## 8. 门禁（`tests/run_live_tests.py`，`make test-live`）

| 组 | 断言 |
| --- | --- |
| 1 | **OFF IS OFF**：`-O2` 与 `-O2 -fno-opt-live` 逐字节相同（1,208/1,208 B、文本逐字节相同） |
| 2 | `dead`（L1）：指令 81 → 76（−5）、`MOV rX, rY` 8 → 3、`MOVT` 1/1、纯 `LDR` 3/3、标签 8/8 |
| 3 | `fwd`（L2）：指令 85 → 83（−2）、`MOV rX, rY` 4 → 3、索引 `LDR` 1 → 0、纯 `LDR` 0 → 1（消费者隔着两条指令也接） |
| 4 | `zero`（L3）：指令 75 → 70（−5）、索引 `LDR` 2 → 0、纯 `LDR rX, [rB]` 0 → 2、`MOV rX, rY` 5 → 2 |
| 5 | `addr`（L4）：指令 66 → 63（−3）、`MOV rX, rY` 3 → 1、`MOVT` 4/4 不变 |
| 6 | **反过度删除**：`shift`（`MOV r0, r5` + `LSL r0, r7`）71 → 69 只删两条「非返回寄存器的比较暂存」，`MOV rX, rY` 7 → 5、`LSL rX, rY` 2/2 不变 —— §4.1 的永久对照 |
| 6b | **返回寄存器掩码跟随返回类型**：`vstage` 在 `void` 与 `int` 两个函数里都比较参数，`void` 侧的比较暂存必须 3 → 0、`MOV rX, rY` 14 → 4（121 → 110 条），`int` 侧真正被返回的值要留下 |
| 7 | 六个夹具 × 三臂（off / on / on-alone 不带其它 pass）在 emulator 上返回 Python 答案（0 / 7 / 12 / 0 / 35 / 1） |
| 8 | 标签计数在所有夹具上不变 |
| 9 | 裁切构建（`-DARKCC_FEATURE_OPT_LIVE=0`）按名拒绝 `-fopt-live`（`C3900U`，rc=1） |
| 10 | 同一裁切构建不带该旗标仍能正常编译（rc=0） |

夹具必须带完整的九开关：L3/L4 的形状来自值栈池寄存器与地址物化，
不带 `-fopt-vstack` / `-fopt-copyprop` 时不会出现。

另外 `tests/arm_exec` 用 `--extra=-fopt-live`（连同其余九开关）跑全部执行用例：
**0 failure**。这一步是 §4.4 那个缺陷被发现的唯一途径 —— 门禁夹具本身不会碰到 64 位加法。

## 9. 裁切

`ARKCC_FEATURE_OPT_LIVE` 在 `include/arkcc_config.h` 里按档位给值：

- `ARKCC_PROFILE_STM32_MIN` ⇒ `0`；
- 宿主 / 交叉档 ⇒ `1`。

裁切构建里传 `-fopt-live` 会得到
`Fatal error: C3900U: -fopt-live is not compiled into this build (rebuild with -DARKCC_FEATURE_OPT_LIVE=1)`
并返回 1 —— 与其余 `-fopt-*` 同一套拒绝语义。

## 10. 在流水线里的位置

```
vstack → addr → strength → cbz → peep → copyprop → live → regalloc → fix_far_offset
```

放在 `regalloc` 之前：`regalloc` 的槽位重写器按「访问次数」排序，已经死掉的拷贝
不应再被计入。live 与 copyprop 都只改文本，不改帧形状，所以两者顺序可以互换
（数学上都保语义），但让 copyprop 先跑能让 live 的迭代更快收敛。

## 11. 没做（登记）

- **真正的局部变量寄存器分配**：现在只做「删 / 折」，不做「把变量常驻某个寄存器」。
  这是下一步最大的一块，需要活跃区间（`CgLiverangePhase`）与冲突图着色
  （AC5 的 `LSregalloc` + `graph_colour_twoclash`）。
- **跨函数（`cross-jump` / `cross-call`）**：IAR 的
  `EbkInterproceduralCrossJumpHelper` / `EbkCrossCallHandler`
  （`c_compiler/iar/docs/07-crossjump-and-tbaa.md`），是「更小」的最大一块，需 IPO 级分析。
- **`LDRD` / `STRD` 合并**：两条相邻 32 位访问合成 64 位访问，16 位编码下无字节收益，不立项。
- **别名分析 / TBAA**：本后端没有循环向量化，收益不足以付复杂度。
