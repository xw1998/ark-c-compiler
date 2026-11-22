# 寻址方式折叠（`-fopt-addr`）

[English](ADDR_FOLD.en.md) | 中文

> 0.9.1 的第五块优化。一句话：**栈机式发射把一次数组/指针访问摊成
> `MOV` + `ADD` + `LDR/STR` 三条指令，而这个 pass 把地址运算折进寻址方式，
> 让一条 `LDR r0, [r5, r1]` 干完三件事。**
>
> 实现位置：`src/backend/arm/backend_arm.c`，`ark_addr_function()`
> 门禁：`tests/run_addr_tests.py`（`make test-addr`），外加 `tests/arm_exec` 全语料
> 开关：`-fopt-addr` / `-fno-opt-addr`，INI `opt-addr=` / `addr=`

---

## 1. 为什么做，做在哪一层

`arkc` 的 ARM 后端是**栈机式发射**：每个中间值都落到一个"当前寄存器"，地址也是算出来的
一个普通值。于是一次 `p->y[i]` 长这样：

```asm
MOV  r0, r5            ; 把基址从值栈池搬到低寄存器
ADD  r0, r0, r1        ; + 下标
LDR  r0, [r0, #0]      ; *(base + index)
```

ARMv7-M 本身就有 `[Rn, Rm, LSL #n]`、`[Rn, #imm]!`、`[Rn], #imm` 这些寻址方式，
上面三条在语义上就是一条 `LDR r0, [r5, r1]`。省下来的是**指令条数**（取指、译码、执行
都要钱），不是字节数——`LDR r0,[r5,r1]` 与 `LDR r0,[r0,#0]` 都是 16 位。

介入层次与 `-fopt-vstack` 相同：**发射后的函数级文本重建**，而不是 IR 上做地址模式选择。
理由也一样——IR 上做要动 irgen/irser/MIR 和四个后端；而文本层识别不了就原样保留，
**最坏情况是漏折叠，绝不会发出错指令**。

## 2. 三条规则

在函数的汇编行上扫描，`RB` = 基址寄存器，`RI` = 索引寄存器，`Rt` = 数据寄存器。

| 编号 | 原序列 | 改写 | 说明 |
| --- | --- | --- | --- |
| **R1** | `ADD RD, RB, #imm`<br>`mem Rt, [RD(, #off)]` | `mem Rt, [RB, #imm+off]` | 立即数偏移折叠，删 `ADD` |
| **R2** | `ADD RD, RB, RI[, LSL #n]`<br>`mem Rt, [RD]`（off 必须为 0） | `mem Rt, [RB, RI[, LSL #n]]` | 寄存器索引折叠，删 `ADD` |
| **R3** | `MOV RB, RS`<br>`mem Rt, [RB(, #off / , RI)]` | `mem Rt, [RS(, …)]` | 删掉把基址搬进低寄存器的那条拷贝 |

R1/R2 是**地址算术折叠**，R3 是**拷贝消除**。三条都是"改一行、删一行"，没有一条会引入
新指令。

R3 通常是**被 R1/R2 连带出来的**：`MOV r0, r5` 与 `ADD r0, r0, r1` 之间本来隔着若干条，
折叠把 `ADD` 删掉之后两者变成相邻，下一轮 R3 才把它吃掉。因此定点迭代最多 6 轮
（`-fopt-addr` 折叠后实测每个函数 1~3 轮收敛）。

`R2` 的移位只对 `LDR/STR` 生效（`LDRB/LDRH/STRB/STRH` 的寄存器索引在 Thumb 里只允许
`LSL #0`），这一点在 `ad_access()` 里按助记符白名单判断。

## 3. 安全性：什么时候可以删那条 `ADD`

一条 `ADD` 能删的前提是**它算出来的值没人要了**。两条判据：

1. **`ad_dead_after(nex+1, RD)`**：从下一条之后往后扫（上限 64 条），在遇到 label、
   `B`/`Bcc`/`BX`/`BL`、`IT`、或者任何写 `RD` 的行之前，如果没有任何行**读** `RD`，
   则 `RD` 的值已死。扫到边界就当作还活着（保守）。
2. **"被地址吃掉"豁免**：`ADD RD, RB, #imm` 后面紧跟 `LDR RD, [RD, #off]` 时，`ADD`
   写出的值**只**被这一条指令的地址部分消费（`LDR` 的 `Rd` 是同一寄存器，先算地址再写回），
   所以无条件可折，不需要 `ad_dead_after`。

第 2 条只在 **load** 上成立：`STR r0, [r0]` 里的 r0 在地址侧是基址、在数据侧是要存的
值，两者是同一个寄存器的不同语义，折叠会发出错指令。因此豁免条件是
`mdst == RD && ad_is_load(mn)`。

实测中第 2 条就是收益的主来源：只做第 1 条时 HAL 语料少 484 条指令，加上第 2 条后
变成 1369 条。这两个分项测于 `-fopt-vstack` 引入跨界之前的那一版编译器，此后
`-fopt-vstack` 自己就把相邻关系改写了，分项已不可与新总数互相折算，只作机制说明保留。

## 4. 永不折叠

| 情况 | 原因 |
| --- | --- |
| 条件指令、`IT` 块成员 | 合并两条条件指令会破坏 `IT` 掩码 |
| 带 `S` 的形式（`ADDS`/`MOVS`） | 删掉会丢标志位，而 `ad_dead_after` 不建模标志；只精确匹配 `ADD`/`MOV` |
| 跨 label / 分支 / 调用 | `ad_dead_after` 到此返回"还活着" |
| 提到该寄存器的未知助记符 | `ad_rw()` 对认不出的指令一律报"读写全都算"，宁可漏折 |

例外只有屏障指令：`DMB`/`DSB`/`ISB` 没有寄存器操作数，`ad_dead_after` 直接跨过它们。
这条是实测逼出来的——HAL 语料里 3 处 `volatile` 访问形如

```asm
ADD r0, r0, r1
LDR r5, [r0, #0]
DMB SY
STR r5, [r6, #0]
```

不给屏障开口时这三处永远折不掉，残留对计数卡在 3；开口后归零。

定点迭代最多 6 轮（折叠会暴露新的相邻关系）；`AD_MAX_OP 6 / AD_OPLEN 96 / AD_MAX_REG 16 /
AD_SCAN_MAX 64` 是全部上限，没有动态分配。

无 `MOV r6, sp` 的函数（`__naked`、手写 runtime helper）退化为"从第一个 label 之后开始"；
连这个都找不到（`pro_end < 0`）就整函数放弃。

## 5. 明确不做的三件事

| 没做 | 原因 |
| --- | --- |
| 两种写回（`[Rn, #imm]!` 与 `[Rn], #imm`） | 这套发射器**从不产生**这两种形状：`p++` 把自增后的指针存回帧槽（`MOV r0, #4` / `ADD r0, r0, r1` / `STR r0, [r6, #0]`），没有 `ADD base, base, #imm` 可折。HAL 全语料 0 处，整个目标文件里仅有的两处在手写 runtime helper `__arkcc_mcpy` 里、本 pass 根本不会遍历。规则写出来只会是死代码，因此不写 |
| `LDRD`/`STRD` 配对 | 帧槽是 8 字节间隔、要求偶寄存器对 + 8 字节对齐；汇编器只在 `--asm-extra` 路径上接受这两条 |
| 把独立的 `LDR`/`STR` 合并成 `LDM`/`STM` | AC5 也不做（见 `08-backend-passes.md` §3.3 的负读数）；收益要用真机读回来才敢开 |
| `[r6, #0]` → `[r6]` 的零偏移美化 | 不省字节，只增 diff 噪声 |

## 6. 实测

条数是 `.s` 里非指示、非标签的行数。

| 语料 | `-fopt-vstack` | 再加 `-fopt-addr` | 变化 |
| --- | --- | --- | --- |
| STM32F4 HAL（`examples/ark_test/ark_test_all.c`，`-O2 -mcpu Cortex-M4`） | 36,532 条 | 34,915 条 | **−1,617（−4.44%）** |
| 同上 "ADD 后紧跟一次经该寄存器的访问" 就地模式 | 1,084 处 | **0 处** | R2 全部吃掉 |
| 同上 "MOV 后紧跟一次经该寄存器的访问" 拷贝 | 0 处 | 0 处 | R3 无可折叠 |

残差探测器认「`ADD rD, …` 紧接着一条经 `[rD …]` 的访问」，1,084 是它的直接计数；总减少
1,617 比它大，多出来的那部分没有逐条归因，此处不编数字。值得注意的是这 1,084 处**与
`-fopt-vstack` 无关**——它在纯 `-O2` 基线上也是 1,084（`-fopt-vstack` 前后逐字相同），
所以这张表的对比是「同一份 vstack 输出，开不开 `-fopt-addr`」。基线是
`-fopt-vstack`（含 r4 第三槽与跨界续优化）之后的 36,532 条，不是纯 `-O2` 的 47,885 条；
两个数字不要混用。R1（立即数偏移）在这份语料上**一次都没触发**——`ADD r5, r6, #24`
这类帧地址计算后面跟的是 `MOV` 而不是访问（0 次）；它保留是因为形状真实存在
（相邻的 `a[4]` 一类常量下标会触发），只是 HAL 语料里没有。

HAL 语料是这一层的地板而不是天花板：它几乎全是 `HAL_GPIO_WritePin` 这类短函数与寄存器
写，指针遍历的比例不高。指针密集的代码（链表、结构体数组、解析器）收益更大。

## 7. 门禁说了什么

`make test-addr`（`tests/run_addr_tests.py`），每份夹具跑**四个臂**：不带任何旗标
（`base`，唯一的诚实体积基线）、只 `-fopt-vstack`（`off`）、只 `-fopt-addr`（`on`）、
两者都开（`both`）。

1. **OFF IS OFF**：`-fopt-vstack` 与 `-fopt-vstack -fno-opt-addr` 的汇编文本与镜像**逐字节
   相同**——默认构建完全看不到这个 pass。
2. **IT PAYS**：`both` 的指令数低于 `off`，`on` 的指令数也低于 `base`；`array`/`struct`/
   `walk` 上出现 `[rX, rY]` 索引形态。
3. **NO RESIDUE**：`on` 与 `both` 里"`ADD` 后紧跟一次经该寄存器的访问"（立即数形、寄存器
   形）与"`MOV rX, rY` 后紧跟一次经 rX 的访问"这三类就地模式必须为 **0**。这比"条数下降"
   强得多：只折前两处的规则也能让条数下降。
4. **EVERY OPERAND IS STILL AN OPERAND**：用 `MEMOP_RE` 逐个校验改写后的内存操作数，
   抓 `[r1, #1], #1` 这类"偏移打两次"的畸形。
5. **SAME ANSWER**：`array` / `struct` / `walk` / `diff` 四份夹具在**四个臂**上返回值都等于
   Python 算出来的期望值。
6. **CROPPED OUT**：`-DARKCC_FEATURE_OPT_ADDR=0` 的构建以 `C3900U` 拒绝 `-fopt-addr`，
   不带该旗标仍能正常编译。

体积断言比的是**诚实基线**：`on <= base`、`both <= off`。早期版本拿 `on` 与 `off` 比，
于是 `-fopt-addr` 单开时"变大 78 字节"——那是拿它跟已经瘦过身的 `-fopt-vstack` 比，
不是它自己在长胖。

另外每次都跑整个 ARM 执行语料：

```
tests/arm_exec/run_arm_exec.py --arkcc ./arkcc.exe "--extra=-fopt-addr"
tests/arm_exec/run_arm_exec.py --arkcc ./arkcc.exe "--extra=-fopt-vstack -fopt-addr"
```

两条都是 0 失败。第 3/4 项与这道全语料是必须的：开发中真正踩到的缺陷
（`ad_memop2` 把整条 `rD, [rB, #off]` 当成 `[...]` 去解析导致一处都不折；
`ad_mem_line` 在写回时把偏移打印两次，形成 `[r1, #1], #1`）都是它们抓到的。

## 8. 裁切

`include/arkcc_config.h` 的 `ARKCC_FEATURE_OPT_ADDR`：`ARKCC_PROFILE_STM32_MIN` 下为 0，
宿主/交叉编译为 1。为 0 时 `ark_addr_function()` 整块被预处理掉，`src/main.c` 以
`C3900U: -fopt-addr is not compiled into this build` 拒绝该旗标（拒绝而非静默忽略）。
实测：`-DARKCC_PROFILE=ARKCC_PROFILE_STM32_MIN` 的构建能正常编译，带 `-fopt-addr` 被拒、
不带该旗标行为不变。

运行期默认**关**（`g_config.enable_opt_addr = 0`），所以不加旗标的产物与 0.9.0 逐字节相同。

## 9. pass 顺序

```
ark_vstack_function()      # 先缩短函数，删掉 PUSH/POP
ark_addr_function()        # 再看剩下的 ADD/MOV 能不能折进寻址
ark_regalloc_function()    # 然后在更短的指令流上做寄存器分配
ark_fix_far_offset()       # 最后处理远偏移
```

顺序有两条理由：

- **在 `vstack` 之后**：vstack 先把 `PUSH/POP` 删掉、把值留在池寄存器里，于是
  `MOV r0, r5` 与访问之间少了一批存取指令，R1/R2/R3 的相邻条件更容易成立；反过来先折
  addr，vstack 随后还会改写这些行，折叠结果就不再是最终形态。
- **在 `regalloc` 之前**：regalloc 把值钉到固定寄存器上之后，"这条 `ADD` 的值还活着吗"
  更难证明（`ad_dead_after` 看到的是分配后的编号），先折能用更短的指令流去做分配。

这两条是设计理由，不是在四个顺序上各跑一遍的实测对照——没有做那个对照，所以这里
不报"顺序差多少条"的数字。

**与 `-fopt-strength` 的关系**：R2 折完之后，形如

```asm
LSL  r1, r1, #2      ; -fopt-strength 把 index * 4 换成这一步
LDR  r0, [r4, r1]    ; R2 已把 ADD 并掉，于是移位与访问相邻
```

这样一来，移位与访问正好相邻，`-fopt-strength` 的后半段（R4）会把两者并成
`LDR r0, [r4, r1, LSL #2]` 一条。也就是说 addr 不负责这条合并——它只把 `ADD` 删掉，
让形状暴露出来；合并归 strength，因为它才是产生移位的人。**addr 单开时行为零变化**
（`-fopt-vstack -fopt-addr` 在本语料上是 34,915 条；vstack 的跨界改造只改变它自己的输入，
不改变 `-fopt-addr` 的规则集）。

另有一处与 R1–R3 共用的活跃性修正：`ad_rw()` 原先把 `PUSH` 与 `POP` 合并在同一支里、
把 `POP` 的操作数当成"读"，于是 `POP {r1}` 让 r1 永远活着，`ad_dead_after()` 再也
不会说它死。现在两支拆开，`POP` 计为写。这一处修正不改变 addr 自身在本语料上的
指令数，但它是 R1–R4 共同的前提。

## 10. 已知代价

`ad_dead_after` 的 64 条前向扫描上限意味着：一个大表达式里如果中间隔了超过 64 条指令
才用到中间寄存器，就放弃折叠。这是"宁可漏、不可错"的另一面。
