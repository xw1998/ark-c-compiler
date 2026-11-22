# 与 armcc / armclang 的横向对比（0.9.1）

[English](COMPARISON.en.md) | 中文

> 一句话：**在 STM32F4 HAL 全语料上，arkc 打开全部优化后是 armcc `-O2` 的 4.2 倍指令数、
> 4.0 倍代码字节；差距不是编码质量问题，是结构性的——值栈机、没有活跃性分析、
> 中间结果仍要落帧。**
>
> 测量脚本：`D:/tmp/cmp_final.py`（不进仓库），下表全部由它一次跑出，同一批源文件、
> 同一组宏与头路径。

---

## 1. 语料与口径

- **源文件**：`examples/ark_test/Core/Src/*.c` + `Drivers/STM32F4xx_HAL_Driver/Src/*.c`，
  共 99 个 TU。其中 3 个 `*_template.c` 三家编译器都产出空代码，**对称跳过** ⇒ 96 个有效。
- **宏与头**：`-D STM32F401xE -D USE_HAL_DRIVER`，`-I examples/ark_test`、HAL `Inc`、
  `Core/Inc`、CMSIS `Device`/`Core`、`-I include`。
- **CPU**：`-mcpu Cortex-M4`（armclang 用 `--target=arm-arm-none-eabi -mcpu=cortex-m4`）。
- **指令数**：arkc 数 `.s` 里非空、非指示、非标签的行；armcc / armclang 用
  `fromelf --text -c` 抽可执行段里的指令行，排除 `DCD/DCW/DCB/DCQ/ALIGN/SPACE/FIELD/EQU/DCI`。
- **代码字节**：arkc 取自己的目标文件头里的代码字节数；armcc / armclang 取 `fromelf`
  列出的 `SHF_EXECINSTR` 段 `Size` 之和。
- **工具链**：ARM Compiler 5.06 update 7（armcc/armasm/fromelf）、ARM Compiler 6（armclang）。

这套口径只比「编译这一批 `.c` 产生的代码」，不含链接期优化（LTO）、不含库函数。
**arkc 每一份 TU 自带运行时助手**（`__aeabi_memcpy`、`__arkcc_init_globals`、浮点胶水等），
armcc/armclang 则从 C 库取同名例程——在「全部优化」那份产物里，按 `__aeabi_*` /
`__arkcc_*` / `__REV16` / `__REVSH` / `__RRX` 这些符号统计是 **1,799 条 / 7.6%**，
去掉它 arkc 的用户代码是 **21,893 条**。下表不做这个扣减，因为它是真实占用的 Flash。

## 2. 结果

96 个有效 TU 的总和：

| 编译器 | 选项 | 指令数 | 代码字节 |
| --- | --- | ---: | ---: |
| **arkc** | `-O2` | 51,463 | 116,480 |
| **arkc** | `-O2` + 全部 `-fopt-*`（见 §3） | **23,692** | **56,384** |
| armcc | `-O0` | 7,969 | 18,788 |
| armcc | `-O1` | 6,061 | 14,910 |
| armcc | `-O2` | 5,629 | 13,942 |
| armcc | `-O3 -Otime` | 5,750 | 15,322 |
| armcc | `-O3 -Ospace` | 5,642 | 14,102 |
| armclang | `-O2` | 5,068 | 13,856 |
| armclang | `-Oz` | 4,250 | 11,292 |

相对 armcc `-O2`：

| 比较 | 指令数 | 代码字节 |
| --- | ---: | ---: |
| arkc `-O2`（无 `-fopt-*`） | 9.1× | 8.4× |
| arkc `-O2` + 全部 `-fopt-*` | **4.2×** | **4.0×** |

**0.9.1 的八个优化开关把差距从 9.1× 压到 4.2×**（指令数 −54.0%，代码字节 −51.6%）。

**IAR 未参与**：本机没有 `iccarm.exe`（`/c/Program Files*/IAR Systems`、`/d/IAR*` 均无）。
**不估 IAR 的数字**——没有编译出来的字节就没有可比的东西。

## 3. 表里「全部 `-fopt-*`」是哪八个

```
-fopt-tailmerge -fopt-tailcall -fopt-divconst -fopt-xblock -fopt-sizeweight
-fopt-inline   -fopt-vstack    -fopt-addr     -fopt-strength -fopt-cbz
-fopt-branch   -fopt-imm       -fopt-peep     -fopt-regalloc
```

上表实际使用的是**对本语料有作用**的那八个：
`-fopt-vstack -fopt-addr -fopt-strength -fopt-cbz -fopt-branch -fopt-imm -fopt-peep
-fopt-cbranch`。

`-fopt-regalloc` 也在这一轮测了，但它在**本语料上一条指令都没改**（两种构型的指令数
与代码字节完全相同）。原因写在它的选择规则里：默认模式只收「访问宽度超过 16 位
寻址形（偏移 > 124 或非 4 的倍数）的槽」，因为这个 pass 不靠活跃性分析，要靠
「把宽访存换成 `MOV` 才赚回加宽 `PUSH/POP` 的 4 字节」。HAL 的局部变量几乎都落在
`0..124` 且 4 字节对齐，于是 `saves = 0`，一个槽都不选。**这不是缺陷，是它当前的
设计边界**（`-fopt-regalloc-near` 是另一档，按访问次数收近槽，会改这些函数）。

## 4. 差距在哪：四条结构性原因

以 `HAL_RCC_OscConfig()`（`stm32f4xx_hal_rcc.c`）为例，arkc 全优化后是 3,676 条，
armcc `-O2` 是 336 条。看开头那段 `if (RCC_OscInitStruct == 0)`：

```asm
; arkc，全优化（含 -fopt-cbranch -fopt-cbz）
    CBNZ r0, .L_HAL_RCC_OscConfig_0
```

```asm
; armcc -O2 的等价实现
    CMP  r0, #0
    BEQ  .L
```

**一条对两条**——比较结果物化那一段已经被 `-fopt-cbranch` 吃掉，`-fopt-cbz` 再把
`CMP r0, #0` + `BNE` 折成 `CBNZ`。剩下的差距不再是「比较结果物化」这一笔，仍是代码生成的结构：

1. **值栈机：每个值都真的进栈。** `-fopt-vstack` 把相邻的 `PUSH/POP` 折成寄存器搬运，
   但「一个表达式的中间结果」在这里仍然经常落回帧（`STR r0, [r6, #8]` / `LDR r0, [r6, #8]`）。
   真正的修法是**局部变量寄存器分配**（要活跃性分析），不是文本 pass。
2. ~~布尔值先物化成 0/1，再复测一次~~ ——**已由 `-fopt-cbranch` 修掉**（0.9.1）。
   HAL 语料上 `ITE` 从 824 个降到 69 个、`CMP r0,#0` 从 409 条降到 73 条，
   共省 2,601 条指令 / 8,238 字节（见 `docs/CBRANCH.md`）。残下的 69 个是
   「比较结果被存进变量」这类值有两个消费者的情形，需要活跃性分析才能继续压。
3. **没有活跃性 / 没有指令调度。** 每个槽的每次访问都是独立访存，没有「这个值还在
   `r3` 里」的概念；也没有把独立指令重排进流水线空档。
4. **每份 TU 自带运行时助手。** 1,325 条 / 5.0%（§1）。armcc 靠库。

另外两条**已量化但不值得做**的上限：

- **叶子函数无帧**：全语料只有 26 个函数真的可以去掉整个帧（约 78 条，0.2%）。
- **短条件跳转（`B<cond>` T1）**：本后端的条件跳转恒发 32 位 T3，改成 T1 需要布局
  定点迭代（±256 字节），收益与风险不成比例；`-fopt-cbz` 已经顺带吃掉其中一部分。

## 5. 逐优化项的实测（同一语料）

基线 = `-fopt-vstack -fopt-addr -fopt-strength -fopt-cbz -fopt-branch`，共 35,211 条：

| 构建 | 指令数 | 变化 |
| --- | ---: | ---: |
| 基线 | 35,211 | — |
| + `-fopt-cbranch` | 32,610 | −2,601（−7.4%） |
| + `-fopt-peep` | 33,730 | −1,481（−4.2%） |
| + `-fopt-imm` | 27,716 | −7,495（−21.3%） |
| + imm + peep | 26,316 | −8,895（−25.3%） |
| + imm + peep + cbranch | **23,692** | **−11,519（−32.7%）** |

（各行是各自相对基线的单项/组合效果，不是累加关系：`-fopt-cbranch` 与 `-fopt-imm`
都动 `IR_BINARY`，叠起来看最后一行走廊。）

单独 `-fopt-imm` 一项就占 0.9.1 全部收益的一半以上（见 `docs/IMM_FOLD.md`），
`-fopt-peep`（见 `docs/PEEPHOLE.md`）与 `-fopt-cbranch`（见 `docs/CBRANCH.md`）
各是一块。更早五块的数字见
`docs/OPTIMIZER_PLAN.md` 与各 `docs/*_FOLD.md` / `docs/STRENGTH.md` / `docs/RV...`。

## 6. 怎么复现

```bash
# 1) 三条 arkc 臂 + 五条 armcc 臂 + 两条 armclang 臂，一次跑完
python D:/tmp/cmp_final.py          # 输出汇总表，明细写 D:/tmp/cmp_final.json

# 2) 只看 arkc 的四档（base / cbranch / imm+peep / 三者全开）
python D:/tmp/cbr_bytes.py
```

两个脚本都假定：当前目录是仓库根、`./arkcc.exe` 是刚 `make` 出来的二进制、
Keil 装在 `D:/Keil_v5`。语料路径写死在脚本里，换语料改 `srcs` 那一行。

## 7. 这张表不该被读成什么

- **不是「arkc 不可用」**：它自己编译自己、编译 HAL、在 STM32H743 与 F401 上跑过
  （见 `docs/BOARD_VALIDATION.md`），语义正确性由 `tests/arm_exec` 在 unicorn 上
  逐条执行验证。上表只是**体积/指令数**这一个维度。
- **不是「armcc 的优势不可追」**：§4 第 2 条（比较结果直连分支）已经落地并吃下
  2,601 条指令，是与活跃性分析无关的纯代码生成改动；剩下的第 1 条（中间结果落帧）
  要活跃性分析，是真正的工程量。
- **不是「IAR 更差或更好」**：没测，没有数字，所以这里没有说法。