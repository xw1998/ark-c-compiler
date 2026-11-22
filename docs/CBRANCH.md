# `-fopt-cbranch`：比较结果直连条件跳转

[English](CBRANCH.en.md) | 中文

> 一句话：`if (a == b)` 在 arkc 里以前要付**两遍**比较——先 `CMP` + `ITE/MOVcc` 折成 0/1，
> 再在跳转处 `CMP r0, #0`；打开 `-fopt-cbranch` 后同一个程序点只剩 `CMP` + `B<cond>`，
> HAL 全语料上少 **2,601 条指令（−7.39%）**、少 **8,238 字节（−10.0%）**。

---

## 1. 为什么做这个

arkc 的 IR 是栈机，`if (a == b)` 被翻译成「压 `a`、压 `b`、`IR_BINARY(==)`、`IR_JZ`」。
`IR_BINARY` 的语义是**产生一个 int 值**（0 或 1），所以后端必须把它物化：

```asm
; 关闭（默认）
    CMP  r0, r1
    ITE  EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP  {r0}
    CMP  r0, #0
    BEQ  .L_f_0
```

**八条**。而这个 0/1 值的唯一消费者就是紧接着的 `IR_JZ`，于是「算出来再测一遍」
完全冗余：

```asm
; 打开
    CMP  r0, r1
    BNE  .L_f_0
```

**两条**。armcc 的等价实现也是 `CMP` + `B<cond>`（见 `docs/COMPARISON.md` §4）。
这就是 0.9.1 之后差距里最大的一笔结构性开销（`if (a == b)`、`if (p)`、`while (n)`
全部中招），也是 `docs/COMPARISON.md` §4 第 2 条说的「预计能吃下数千条」的那一项。

## 2. 为什么做在 IR 发射期，而不是文本 pass

文本层看不出「这个 0/1 值是不是只被下一条跳转消费」：`CMP` / `ITE` / `MOVcc` /
`PUSH` / `POP` 之后，那个值可能被存进变量、被别的表达式再用。而 IR 里形状是确定的：

```
IR_BINARY(比较, ...)     ; 或 IR_BINARY_imm
IR_JZ / IR_JNZ           ; 紧邻的下一条
```

判据只有一条：**比较指令的下一条就是 `IR_JZ` / `IR_JNZ`**（严格相邻）。
满足即说明这个值已死，可以直接把它们合成 `CMP` + `B<cond>`；不满足就原样走老路径。

## 3. 条件码表

`want_true` 指「跳转在比较为真时发生」（`IR_JNZ`），否则为假时发生（`IR_JZ`）。
无符号比较的 IR 会在 `base_op` 上带 `+0x100` 标记，`cbranch_mnemonic()` 据此选
`BLO/BHS/BHI/BLS` 而不是 `BLT/BGE/BGT/BLE`。

| 运算 | 真时跳 | 假时跳 |
| --- | --- | --- |
| `==` | `BEQ` | `BNE` |
| `!=` | `BNE` | `BEQ` |
| `<` （有符号 / 无符号） | `BLT` / `BLO` | `BGE` / `BHS` |
| `<=`（有符号 / 无符号） | `BLE` / `BLS` | `BGT` / `BHI` |
| `>` （有符号 / 无符号） | `BGT` / `BHI` | `BLE` / `BLS` |
| `>=`（有符号 / 无符号） | `BGE` / `BHS` | `BLT` / `BLO` |

注意 `<`/`<=` 的取反不是 `>`/`>=`（那会漏掉 NaN 型语义和相等情形），而是
`BGE`/`BGT`——这与 ARM 条件码本身一致，不需要额外的反转步骤。

## 4. 两条注入路径

### 4.1 立即数还在手上的形状

`-fopt-imm` 会把「压常数、比较」折成 `IR_BINARY_imm`，此时后端手里已经有
`imm_val`。这种形状发：

```asm
    POP  {r0}
    CMP  r0, #<imm>       ; 编不进 12 位立即数时退化为 MOV r1, #k; CMP r0, r1
    B<cond> .L_<fn>_<n>
```

**兜底**：如果 `thumb_imm12_a()` 判断这个常数编不进 `CMP` 的立即数字段，
就发 `MOV r1, #k` + `CMP r0, r1` 再跳。实际 `emit_binary_imm` 之前已经保证可编码，
这一层是「宁可多一条指令，不发错」的保险（0.9.1 起 `-fopt-imm` 的大常数本来就走
寄存器路径，这里只是同一策略的延伸）。

### 4.2 操作数还在栈上的一般形状

```asm
    POP  {r1}
    POP  {r0}
    CMP  r0, r1
    B<cond> .L_<fn>_<n>
```

`cbranch_mnemonic()` 返回 0（非比较运算）时不做任何事，原样走 `emit_binary`。

## 5. 互斥与叠加关系

- **与 `--reg-top` 互斥**：`--reg-top` 用「栈顶值建模」来减少 `PUSH/POP`，同一个值
  会被它跳过处理，若 cbranch 再跳过一次就错位。因此两个注入点都带
  `!ark_top_enabled()` 守卫（沿用 `-fopt-imm` 的先例）。
- **与 `-fopt-cbz` 叠加**：cbranch 之后仍可能出现 `CMP r0, #0` + `BEQ` 的形状
  （值来自内存或函数返回值），文本层的 `-fopt-cbz` 会照旧把它变 `CBZ`。两者不冲突，
  读 `cmp` 探针可以看到 cbranch 站点上没有 `#0` 形态。
- **与 `-fopt-peep` 叠加**：比较值不再经过 `PUSH/POP`，peep 少了一些可折的搬运对，
  但两者互不依赖，先后顺序不影响正确性（只影响数字，见 §7）。

## 6. 明确不折的情形

- **比较结果被存进变量**：`int x = (a < b); if (x) …` —— 值有两个消费者，必须物化。
  门禁专门用 `used` 夹具验这一点（打开后 `ITE` 计数**不变**）。
- **跨基本块**：比较在上一块、跳转在下一块（中间有标签或已生成的代码），IR 里不是
  相邻指令，不折。
- **短路求值里的 `&&` / `||`**：IR 已经展开成多个 `IR_JZ/IR_JNZ` 与临时值，
  能被识别的那部分照折，其余保持原状。

## 7. 实测（HAL 全语料，96 TU / 93 有效，Cortex-M4，`-O2 --reloc-data`）

基线 = `-fopt-vstack -fopt-addr -fopt-strength -fopt-cbz -fopt-branch`，35,211 条 / 82,404 字节：

| 构建 | 指令数 | 代码字节 | 相对基线 |
| --- | ---: | ---: | ---: |
| 基线 | 35,211 | 82,404 | — |
| + `-fopt-cbranch` | **32,610** | **74,166** | **−2,601（−7.4%）/ −8,238（−10.0%）** |
| + `-fopt-imm` | 27,716 | — | −7,495 |
| + `-fopt-peep` | 33,730 | — | −1,481 |
| + `imm` + `peep` | 26,316 | 64,682 | −8,895 |
| + `imm` + `peep` + `cbranch` | **23,692** | **56,384** | **−11,519（−32.7%）/ −26,020（−31.6%）** |

三条臂都 `fails 3`（对称跳过的 `*_template.c`）、`empty 0`，与既有口径一致。

语料级的形状变化（同一批 `.s` 里数文本）：

| 记号 | 基线 | + cbranch | 说明 |
| --- | ---: | ---: | --- |
| `ITE` | 824 | 69 | 比较物化块几乎全部消失 |
| `CMP r0, #0` | 409 | 73 | 紧随其后的「再测一次」跟着消失 |

剩下的 69 个 `ITE` 全是 §6 的「值有第二个消费者」情形。

单站点（`D:/tmp/cbprobe.c`）：8 行 → 2 行；夹具 `cmpi` 135 → 117 条、
1,338 → 1,290 字节、`ITE` 3 → 0、`CMP r0,#0` 5 → 2、标签 11/11 不变。

## 8. 门禁（`tests/run_cbranch_tests.py`，`make test-cbranch`，13 项）

| 组 | 断言 |
| --- | --- |
| 1 | **OFF IS OFF**：`-O2` 与 `-O2 -fno-opt-cbranch` 逐字节相同 |
| 2 | `cmpi` 的 `ITE` 计数下降（3 → 0） |
| 3 | `cmpi` 的 `CMP rN, #0` 计数下降（5 → 2） |
| 4 | `cmpi` 指令条数下降（135 → 117） |
| 5 | `cmpi` 镜像不增（1,338 → 1,290 B） |
| 6 | 标签集合与个数不变（11/11），跳转目标仍是 IR 给的那个 |
| 7 | **反假绿**：`int x = (a<b); if (x)` 的 `ITE` 计数不变且 > 0（2 → 2） |
| 8 | 四臂 `off / on / vstack / imm` 在 emulator 里都算对（`cmpi`=2、`cmpc`=10、`ucmp`=5、`used`=8） |
| 9 | 无符号比较走无符号条件码（`7u<3u` 假、`7u>=3u` 真） |
| 10 | 大立即数 70000 走寄存器兜底路径，结果正确 |
| 11 | 裁切构建（`-DARKCC_FEATURE_OPT_CBRANCH=0`）按名拒绝 `-fopt-cbranch`（rc=1） |
| 12 | 同一个裁切构建不带该旗标仍能正常编译（rc=0） |

第 7 组是这次唯一容易「假绿」的点：如果实现只看「下一条是跳转」而不确认值已死，
`used` 夹具会被折掉、程序仍然输出正确结果，只是 `x` 的语义被破坏。门禁把
「`ITE` 计数不变」写成硬断言来锁死它。

## 9. 裁切

`ARKCC_FEATURE_OPT_CBRANCH` 在 `include/arkcc_config.h` 里按档位给值：

- `ARKCC_PROFILE_STM32_MIN` ⇒ `0`，整个 `cbranch_mnemonic()` 与两处注入都不编译；
- 宿主 / 交叉档 ⇒ `1`。

在裁切构建里传 `-fopt-cbranch` 会得到
`Fatal error: C3900U: -fopt-cbranch is not compiled into this build (rebuild with -DARKCC_FEATURE_OPT_CBRANCH=1)`
并返回 1 —— 与 `-fopt-imm` / `-fopt-peep` 同一套拒绝语义，不会静默忽略。

## 10. 在流水线里的位置

`-fopt-cbranch` **不是**文本 pass，它在 `backend_arm.c` 的主发射循环里，
`case IR_BINARY` 处就地生效。文本 pass 链不变：

```
vstack → addr → cbz → peep → regalloc → fix_far_offset
```

因此它与其他文本 pass 没有「先后顺序」问题：它改变的是发给文本层的指令序列本身。

## 11. 已知代价

- 分支密度上升（`B<cond>` 取代了 `ITE` 块），对顺序执行的分支预测器略不友好；
  本语料上没有做周期模型测量，**不声称性能收益**，只说指令数与体积。
- 立即数路径比寄存器路径多一个 `POP`，因为 `IR_BINARY_imm` 之前可能已经把常数
  折掉、栈上只剩左操作数——这与关闭时的栈形状相同，不构成额外代价。

## 12. 没做（登记）

- **比较结果跨基本块复用**：需要活跃性分析才能判断「下一块开头就用」。
- **`CMP` 与 `B<cond>` 之间插入指令**：目前要求严格相邻；放松它需要知道两条指令
  无依赖（本后端没有调度器）。
- **T1 短条件跳转**：见 `docs/COMPARISON.md` §4，需要布局定点迭代，单独立项。
