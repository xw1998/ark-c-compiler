# `-fopt-copyprop`：删掉死拷贝、把拷贝推进到消费者

[English](COPYPROP.en.md) | 中文

> 一句话：寄存器之间那些「搬了、但一次都没被读」或「搬完紧接着就被同一个寄存器算回去」
> 的 `MOV` 是纯开销；`-fopt-copyprop` 在一个函数的已发射文本上删/折它们，
> HAL 全语料上少 **388 条指令（−1.64%）**、少 **776 字节（−1.38%）**，
> 而 `MOV` 的计数从 6,180 掉到 5,792，其余助记符一条不动。

---

## 1. 为什么做这个

0.9.1 之后又按 `D:/工作/git_project/c_compiler/iar/docs/` 里逆向出的 IAR 优化器逐层对照，
`08-backend-passes.md` 与 `06-optimizer.md` 里就有一族以「拷贝」为对象的 pass：

- `ECT CopyPropagation candidate` —— 判定哪些拷贝是候选；
- `DefIntoMove` —— 把定义直接落成 `MOV`（IAR 侧的表达方式）；
- `Dead MOV` —— 删掉没人读的 `MOV`。

按 L1/L2 近似（`backend_arm.c` 里把它并进了 `ARKCC_FEATURE_OPT_COPYPROP`），对应到
arkc 的文本后端就是两条**不需要活跃性分析就能证明安全**的规则。

语料上 `MOV` 是数量第三的助记符（开全部优化后 6,180 条，占 26%），其中一大块是
值栈机的产物：

```asm
    MOV  r0, #15        ; barrier 的参数，指令本体不读它
    DSB  SY

    MOV  r0, r5         ; 值栈池寄存器搬进 r0
    ADD  r0, r0, r7     ; 紧接着又用 r0 自己算
```

前者（规则 A）整条是死的；后者（规则 B）两条能压成一条
`ADD r0, r5, r7`。

## 2. 两条规则

### 2.1 规则 A：死拷贝

> `MOV rD, rS`（或 `MOV rD, #imm`）在**同一个直线块内**、在任何读取 `rD` 之前被
> **完全覆写**，则这条 `MOV` 是死的，删除它不改变任何值与标志。

为什么标志一定不变：`MOV` 不写条件标志。为什么值一定不变：在它被读之前就已经被
另一条写覆盖了。

直线块在以下位置结束（越过它就放弃判定）：

- 标签（`.L...:` / 函数名）；
- 任何分支：`B` / `BL` / `BX` / `BLX` / `B<cond>` 十种条件跳转；
- `PUSH` / `POP` / `LDM` / `STM`（含 `LDMIA` / `STMIA`）；
- `IT` 系列（`IT` / `ITE` / `ITT` / `ITTE` …）——其中的指令是条件执行的，
  「一定被读」这个判断不成立；
- `CPS` / `BKPT`；
- 函数结束。

`.loc`、`.file` 之类的伪指令与空行视为 padding，可以越过。

**读的判定**是这条规则唯一的真陷阱，见 §4。

### 2.2 规则 B：拷贝推进到消费者

> `MOV rD, rS` 后面（中间只有 padding）紧跟 `OP rD, rD, X`，且 `rD != rS`、`X != rD`，
> 则两条合成 `OP rD, rS, X`。

安全性是逐项对得上的：

- 新指令读的正是原来两条读的值（`rS` 与 `X`）；
- 新指令保留自己的后缀（`s` 后缀、条件码），所以写的标志与原来 `OP` 那一条完全相同；
- 原来是两条指令、新是一条，中间的 `MOV` 不写标志，删掉它不改变标志序列。

`OP` 只接受三个操作数的普通 ALU 形：

```
LSL LSR ASR ADD SUB AND ORR EOR RSB SBC ADC MUL UDIV SDIV BIC
```

**故意排除 `CMP` / `CMN` / `TST`**：它们不写寄存器，把前面的 `MOV` 删掉以后 `rD`
里留下的是旧值，与原来不同。

也不接受 `MOVT` —— 它只写高半字，不构成「完全覆写」。

## 3. 为什么不需要活跃性分析

这是这个 pass 能在文本层做、而且**正确性无争议**的原因：

- 规则 A 只删「可证明被覆盖」的写，不推理「后面还读不读」；
- 规则 B 只把拷贝推进到**唯一的、紧邻的**消费者，不移动、不跨越。

两者都不需要知道「某个值在某个点是否活跃」。真正的寄存器分配（`CgRegalPhase` /
`CgLiverangePhase`）需要活跃性，那是另一件事（见 `docs/COMPARISON.md` §4 与
`docs/OPTIMIZER_PLAN.md`）。

## 4. 一个被 emulator 抓出来的错误：第一个操作数也可能读

第一版把「读」判定成「第一个顶层逗号之后的任何操作数提到 `rD`」，即默认
`operands[0]` 是纯写目标。这个假设对三操作数 ALU 成立，但构造上完全错：

```asm
    STR  r0, [r6, #8]     ; 存 —— r0 是被读的
    CMP  r0, r1           ; 比较 —— 两个操作数都是读
    MOV  r0, r1           ; 拷贝 —— 源在 operands[1]
    MUL  r0, r1           ; 双操作数形式，operands[0] 同时是读
    UXTB r0, r0           ; 自我更新，operands[0] 是读
```

于是「`MOV r0, #15` 之后紧跟 `STR r0, [...]`」被误判为死拷贝删掉，
`tests/arm_exec` 直接报出 **9 个失败**：

```
struct_cond    3221225560 (want 46)
longlong_args  48/50      shift64      11/50
longlong64     4/50       struct_byval 1/50
big_frame      218/82     aeabi_runtime 4/50
fconv_rne      105/0      atomic_wide  5032707/6
```

修法是把「纯写目标」显式列出来（`cp_dest_only()`）：

- 操作数个数 ≥ 3 ⇒ 第一个是纯写目标；
- 否则只有确实以裸目标出现的助记符才算：
  `MOV MOVW MVN LDR LDRB LDRH LDRSB LDRSH REV REV16 REVSH RRX CLZ UXTB UXTH SXTB SXTH`。

`cp_reads()` 于是变成：

> `operands[1..]` 任一提到 ⇒ 读；`operands[0]` 提到且它**不是**上表里的纯写目标 ⇒ 读。

修完 `arm_exec` 0 failure。这条修正也说明为什么门禁里必须有「反过度删除」的对照夹具
（§8 第 4 组）：没有它，一个「见 `MOV` 就删」的实现同样能通过「四条 barrier 参数消失」。

## 5. 与 `-fopt-peep` 的分工

| 维度 | `-fopt-peep` | `-fopt-copyprop` |
| --- | --- | --- |
| 对象 | 内存往返：`PUSH {rX}` / `POP {rX}` 配对、`STR`+`LDR` 同址 | 寄存器拷贝：`MOV rD, rS` / `MOV rD, #imm` |
| 生成 | 把两条换成一条 `MOV`（**产生**拷贝） | 删掉死拷贝、把拷贝推进到消费者（**消化**拷贝） |
| 依赖 | 需要配对与固定窗口 | 需要直线块扫描 |

顺序上 peep 在前：peep 先把 `PUSH/POP` 折成 `MOV`，copyprop 才有更多拷贝可删/可折。
反过来做也行（数学上两条规则都保语义），但数字会变小。

## 6. 实测（HAL 全语料，96 TU / 93 有效，Cortex-M4，`-O2 --reloc-data`）

基线 = 0.9.1 的八个开关（`vstack addr strength cbz branch imm peep cbranch`），
23,692 条 / 56,384 字节：

| 构建 | 指令数 | 代码字节 | 变化 |
| --- | ---: | ---: | ---: |
| 基线（八开关） | 23,692 | 56,384 | — |
| + `-fopt-copyprop` | **23,304** | **55,608** | **−388（−1.64%）/ −776（−1.38%）** |

相对最初的五开关基线（35,211 / 82,404）累计为 −11,907（−33.8%）/ −26,796（−32.5%）。

助记符账（同一批 `.s` 上逐行统计）：

| 助记符 | 基线 | + copyprop | 差 |
| --- | ---: | ---: | ---: |
| `MOV` | 6,180 | 5,792 | **−388** |
| 其它全部 | 17,512 | 17,512 | 0 |

**一条不多一条不少**——只动 `MOV`，正是两条规则的定义域。

### 6.1 388 怎么分成 147 + 241

用一个与 C 实现同语义的模型在基线 `.s` 上重放过一遍：

| 规则 | 命中 | 主要形状 |
| --- | ---: | --- |
| A（死拷贝） | **147** | 全部是 `MOV rD, #imm` 后紧跟另一条写 `rD`：`MOV r0, #15` + `DSB SY`、`MOV r0, #0` + `MOVW r0, #4` |
| B（推进） | **241** | `LSL` 207、`SUB` 16、`UDIV` 11、`ADD` 5、`ORR` 2 |

规则 B 里 `LSL` 占绝大多数，是因为值栈池寄存器做移位/缩放时恒定发
`MOV r0, r5` + `LSL r0, r0, r7`（`-fopt-strength` 把 `*2^k` 换成左移之后更常见）。

### 6.2 为什么最初的 1,141 条估算错了

第一版扫描脚本的判定顺序是**先看「写」再看「读」**，于是把自我更新指令
（`LSL rD, rD, X`、`UXTB rD, rD`、`AND rD, rD, X`、`ORR rD, rD, X` …）当成
「`rD` 被覆盖」的杀手，统计出 900 条死 `MOV`。按正确语义重扫是 **601 条**上界，
再扣掉被边界（`PUSH`/`POP`/标签）截断的，模型可复现的命中就是 **147 条**。
旧数字全部作废，本文的 388 是与编译器实测逐条对齐的。

`MOVW` 也做过候选评估：死 `MOVW` 候选实测 **0** 条，所以实现里没有为它加代码。

## 7. 实现位置

`src/backend/arm/backend_arm.c`，与 peep 共用同一段源码守卫
（`ARKCC_FEATURE_OPT_PEEP || ARKCC_FEATURE_OPT_COPYPROP`），复用文本层工具
`pp_split_lines` / `pp_trim` / `pp_copy_line` / `pp_splice` / `pp_pad` / `PP_MAX_LINES`。

| 函数 | 作用 |
| --- | --- |
| `cp_parse` | 把一行拆成「助记符 + 最多 4 个顶层逗号分隔的操作数」（`[...]` 内的逗号不切） |
| `cp_reg` | `rN` 且只有 `rN` ⇒ 寄存器号（`r6,` / `[r6]` 不算） |
| `cp_mentions` | 作为完整 token 出现（排除 `lr`、`str0` 这类前后缀） |
| `cp_writes` | 该行是否**完全覆写**第一个操作数（`MOVT` 不算） |
| `cp_dest_only` | 第一个操作数是否是纯写目标（§4） |
| `cp_reads` | 该行是否读某个寄存器（§4 的判定） |
| `cp_is_boundary` | 是否结束直线块 |
| `cp_op_ok` | 规则 B 可吸收的 ALU 白名单 |
| `cp_pass` | 单次遍历，返回改动数 |
| `ark_copyprop_function` | 最多 4 轮，直到 `cp_pass` 返回 0（折一条可能暴露另一条） |

每条被改写的行都用 `snprintf` 重新拼成 `    OP rD, rS, X\n`，缩进固定 4 空格，
与发射器一致；标签与伪指令永远走 `pp_copy_line` 原样复制，所以**标签不会被改名或删掉**。

## 8. 门禁（`tests/run_copyprop_tests.py`，`make test-copyprop`，17 项）

| 组 | 断言 |
| --- | --- |
| 1 | **OFF IS OFF**：`-O2` 与 `-O2 -fno-opt-copyprop` 逐字节相同（1,194/1,194 B） |
| 2 | `bar`：四条 barrier 参数消失（`MOV #imm` 计数差 4）、`DSB/ISB` 仍是 4 条、指令 −4、镜像变小、标签 3/3 |
| 3 | `fuse`：两个池拷贝折进 `ADD`（`MOV rX, rY` 6 → 4）、指令 −2、镜像不增、立即数拷贝未被误伤 |
| 4 | **反过度删除**：`keep` 夹具（指针改指再索引，拷贝全部被读）逐行不变（135/135 行） |
| 5 | 三个夹具 × 三臂（off / on / on-alone 不带其它 pass）在 emulator 上返回与 Python 相同的值（11 / 20 / 18） |
| 6 | 裁切构建（`-DARKCC_FEATURE_OPT_COPYPROP=0`）按名拒绝 `-fopt-copyprop`（rc=1） |
| 7 | 同一裁切构建不带该旗标仍能正常编译（rc=0） |

第 4 组是这次唯一容易「假绿」的点，理由见 §4 末尾。

**注意**：夹具必须带 `-fopt-vstack`。规则 B 的形状来自值栈池寄存器
（`MOV r0, r5` + `ADD r0, r0, r7`）；不带它时发射器直接 `PUSH/POP`，`POP` 是边界，
规则 B 无从触发。同理 `fuse` 夹具的所有语句写在**一行**里，分行写会改变发射形状
（中间会插入 `PUSH {r0}`）。

## 9. 裁切

`ARKCC_FEATURE_OPT_COPYPROP` 在 `include/arkcc_config.h` 里按档位给值：

- `ARKCC_PROFILE_STM32_MIN` ⇒ `0`，整段 copyprop 与 `cp_pass` 的调用都不编译；
- 宿主 / 交叉档 ⇒ `1`。

裁切构建里传 `-fopt-copyprop` 会得到
`Fatal error: C3900U: -fopt-copyprop is not compiled into this build (rebuild with -DARKCC_FEATURE_OPT_COPYPROP=1)`
并返回 1 —— 与 `-fopt-imm` / `-fopt-peep` / `-fopt-cbranch` 同一套拒绝语义。

## 10. 在流水线里的位置

```
vstack → addr → cbz → peep → copyprop → regalloc → fix_far_offset
```

放在 `regalloc` 之前，与 peep 同理：让槽位重写器看到更短的文本，
「访问次数」统计不被已经死掉的拷贝污染。

## 11. 没做（登记）

- **跨基本块的死拷贝**：需要活跃性（或至少 CFG）才能判断另一条路径上是否读过。
- **`MOV` 合并成 `MOVW/MOVT` 之外的更大重写**：`MOVW` 死候选实测 0，不立项。
- **`LDR`/`STR` 的拷贝传播**：把「存进去又原样读回」当拷贝需要别名分析，
  当前 `-fopt-peep` 只做同址、相邻的严格情形。
- **IAR 的 cross-jump / cross-call**：那是跨基本块、跨函数的跳转合并
  （`EbkInterproceduralCrossJumpHelper` / `EbkCrossCallHandler`，
  见 `c_compiler/iar/docs/07-crossjump-and-tbaa.md`），与拷贝不是一回事，
  单独立项（见 `docs/OPTIMIZER_PLAN.md`）。
