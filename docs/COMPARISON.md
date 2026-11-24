# 与 armcc / armclang 的横向对比（0.9.1）

[English](COMPARISON.en.md) | 中文

> 一句话：**在 STM32F4 HAL 全语料上，arkc 打开全部优化后是 armcc `-O2` 的 2.4 倍指令数、
> 2.5 倍代码字节；差距不是编码质量问题，是结构性的——值栈机、活跃性只用来删拷贝、
> 中间结果仍要落帧。**
>
> 测量脚本：`D:/tmp/fr/cmp_arm.py`（armcc / armclang 六臂）与 `D:/tmp/fr/cmpark_all.py`
> （arkc 两臂）——都不进仓库，但口径与 `docs/CMAT.md` §6 用的是同一套计数正则与
> `ARKOBJ2` 头。下表全部由它们一次跑出，同一批源文件、同一组宏与头路径。

---

## 1. 语料与口径

- **源文件**：`examples/ark_test/Core/Src/*.c`（5 个）+ `Drivers/STM32F4xx_HAL_Driver/Src/*.c`
  （94 个），共 99 个 TU。其中 4 个 `*_template.c` 三家编译器都产出空代码，**对称跳过**
  ⇒ **95 个有效 TU**。
- **宏与头**：`-D STM32F401xE -D USE_HAL_DRIVER`，`-I examples/ark_test`、HAL `Inc`、
  `Core/Inc`、CMSIS `Device`/`Core`、`-I include`。
- **CPU**：`-mcpu Cortex-M4`（armclang 用 `--target=arm-arm-none-eabi -mcpu=cortex-m4`）。
- **指令数**：arkc 数 `.s` 里非空、非指示、非标签的行（正则 `^\s+[A-Za-z][A-Za-z0-9.]*\s`）；
  armcc / armclang 用 `fromelf --text -c` 抽可执行段里的指令行，排除
  `DCD/DCW/DCB/DCQ/ALIGN/SPACE/FIELD/EQU/DCI`。
- **代码字节**：arkc 取自己的目标文件头（`ARKOBJ2`）里的代码段长度；armcc / armclang 取
  `fromelf` 列出的 `SHF_EXECINSTR` 段 `Size` 之和。
- **工具链**：ARM Compiler 5.06 update 7（`D:/Keil_v5/ARM/ARMCC/bin`）、ARM Compiler 6
  （`D:/Keil_v5/ARM/ARMCLANG/bin`）。

这套口径只比「编译这一批 `.c` 产生的代码」，不含链接期优化（LTO）、不含库函数。
**arkc 每份 TU 可能自带运行时助手**（`__aeabi_memcpy`、`__arkcc_init_globals`、`__REV16`
一类），armcc/armclang 则从 C 库取同名例程。两个默认生效、无开关的机制把这一项压了下来：
① 未被引用的 `static` 函数不再发射（[DEADSTATIC.md](DEADSTATIC.md)）；② `__aeabi_memcpy`
改为按需发射。本表**不做**这项扣减，因为它确实是真实占用的 Flash。

## 2. 结果

95 个有效 TU 的总和：

| 编译器 | 选项 | 指令数 | 代码字节 |
| --- | --- | ---: | ---: |
| **arkc** | `-O2`（无 `-fopt-*`） | 49,186 | 110,468 |
| **arkc** | `-O2` + 全部十九个 `-fopt-*`（见 §3） | **12,304** | **32,690** |
| armcc | `-O1` | 6,051 | 14,888 |
| armcc | `-O2` | 5,619 | 13,920 |
| armcc | `-O3 -Otime` | 5,740 | 15,300 |
| armcc | `-O3 -Ospace` | 5,632 | 14,080 |
| armclang | `-O2` | 5,064 | 13,848 |
| armclang | `-Oz` | 4,246 | 11,284 |

相对 armcc `-O2`（5,619 条 / 13,920 B）：

| 比较 | 指令数 | 代码字节 |
| --- | ---: | ---: |
| arkc `-O2`（无 `-fopt-*`） | 8.8× | 7.9× |
| arkc `-O2` + 全部 `-fopt-*` | **2.19×** | **2.35×** |

**优化开关把差距从 8.8× 压到 2.2×**（相对自己的 `-O2`：指令数 −75.0%，代码字节 −70.4%；
相对 armcc 的差额从 +43,567 条 / +96,548 B 降到 +6,685 条 / +18,770 B）。

**IAR 未参与**：本机装了 IAR EWARM 9.70（`D:\tools\IAR_EWARM_9.70\arm\bin\iccarm.exe`，
V9.70.1.475/W64），但**没有 license**——任何编译都停在
`Fatal error[LMS001]: License check failed`，拿不到一行字节。
**因此不估 IAR 的数字**：没有编译出来的字节就没有可比的东西。对照 IAR 的方式是照
`D:/工作/git_project/c_compiler/iar/docs/` 里逆向出的机制去实现（`-fopt-cbranch`、
`-fopt-copyprop`、`-fopt-cmat` 的 M6/M7 就是这么来的），不是去编一个数出来。

## 3. 表里「全部 `-fopt-*`」是哪十九个

```
-fopt-vstack  -fopt-addr     -fopt-strength -fopt-cbz     -fopt-branch
-fopt-imm     -fopt-peep     -fopt-cbranch  -fopt-copyprop -fopt-live
-fopt-prop    -fopt-deadpush -fopt-coalesce -fopt-slotreg -fopt-constcache
-fopt-vreg    -fopt-cmat     -fopt-pair    -fopt-litpool
```

全部**默认关闭**，各自的裁剪宏见对应文档（`-fopt-cmat` 是
`ARKCC_FEATURE_OPT_CMAT`，`-fopt-slotreg` 是 `ARKCC_FEATURE_OPT_SLOTREG`，
`-fopt-constcache` 是 `ARKCC_FEATURE_OPT_CONSTCACHE`，`-fopt-litpool` 是
`ARKCC_FEATURE_OPT_LITPOOL`）。

`-fopt-cmat`（九条规则，−1,802 条 / −4,062 B，见 [CMAT.md](CMAT.md)）与
`-fopt-slotreg`（−64 条，已按预注册否证线收档，见 [SLOTREG.md](SLOTREG.md)）、
`-fopt-constcache`（−159 条，见 [OPERAND_ALLOC.md](OPERAND_ALLOC.md) §8）、
`-fopt-pair`（−10 条）是这张表相对上一版新增的四条；本条之后新增的第五条是
`-fopt-litpool`（−705 条 / −1,134 B，把 `MOVW`+`MOVT` 换成字面量池 `LDR`，见
[LITPOOL.md](LITPOOL.md)）；
`-fopt-vreg` / `-fopt-coalesce` / `-fopt-prop` / `-fopt-deadpush` 见
[VREG.md](VREG.md) 等各自文档。

## 4. 差距在哪：四条结构性原因

以 `HAL_RCC_OscConfig()`（`stm32f4xx_hal_rcc.c`）为例，arkc 全优化后是 **1,186 条**
（上一版 2,166 条；该函数长到必须切成 4 个区域池，见 [LITPOOL.md](LITPOOL.md) §4），
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
   寄存器之间那一层「搬了又没用」的拷贝已由 `-fopt-copyprop` 与 `-fopt-live` 清掉
   （见 `docs/COPYPROP.md` / `docs/LIVE.md`），剩下的是内存往返。真正的修法是
   **局部变量寄存器分配**（要活跃性分析），不是文本 pass。
2. ~~布尔值先物化成 0/1，再复测一次~~ ——**已由 `-fopt-cbranch` 修掉**（0.9.1）。
   HAL 语料上 `ITE` 从 824 个降到 69 个、`CMP r0,#0` 从 409 条降到 73 条，
   共省 2,601 条指令 / 8,238 字节（见 `docs/CBRANCH.md`）。残下的 69 个是
   「比较结果被存进变量」这类值有两个消费者的情形，需要活跃性分析才能继续压。
3. **活跃性只用来删拷贝，没用来留变量；也没有指令调度。** `-fopt-live` 已经建了控制流
   图与活跃性，但只拿它删/折文本（见 `docs/LIVE.md`）：每个槽的每次访问仍然是独立
   访存，没有「这个值还在 `r3` 里」的概念。真正跨过这一步要把活跃性用在寄存器分配上，
   而不是再写一个文本 pass。也没有把独立指令重排进流水线空档。
4. **每份 TU 自带运行时助手。** 920 条 / 4.3%（§1）。armcc 靠库。

另外两条**已量化但不值得做**的上限：

- **叶子函数无帧**：全语料只有 26 个函数真的可以去掉整个帧（约 78 条，0.2%）。
- **短条件跳转（`B<cond>` T1）**：本后端的条件跳转恒发 32 位 T3，改成 T1 需要布局
  定点迭代（±256 字节），收益与风险不成比例；`-fopt-cbz` 已经顺带吃掉其中一部分。

## 5. 逐优化项的实测（同一语料）

> **这一节是历史阶梯**：它是那十个开关上线时逐个累加的读数，只用来解释各条规则
> 各值多少。**当前总数以 §2 为准**（12,304 条 / 32,690 B），下面的阶梯因为中途
> 落地了默认生效的死静态函数屏蔽与按需运行时助手、又加了四张新表，合计已不再等于 §2。

**逐级累加**（每一行 = 在上一行基础上再开一个开关），95 个有效 TU，
`-O2 --reloc-data -mcpu Cortex-M4`：

| 构建（逐级累加） | 指令数 | 代码字节 |
| --- | ---: | ---: |
| `-O2`（无 `-fopt-*`） | 50,965 | 114,576 |
| + `-fopt-vstack` | 36,101 | 84,848 |
| + `-fopt-addr` | 33,957 | 80,542 |
| + `-fopt-strength` | 31,865 | 78,262 |
| + `-fopt-cbz` | 31,421 | 76,486 |
| + `-fopt-branch` | 31,421 | 73,906 |
| + `-fopt-imm` | 25,663 | 62,890 |
| + `-fopt-peep` | 25,033 | 61,628 |
| + `-fopt-cbranch` | 22,438 | 53,404 |
| + `-fopt-copyprop` | 21,915 | 52,358 |
| + `-fopt-live` | **19,112** | **45,760** |

十个开关合计：指令数 **−31,853（−62.5%）**、代码字节 **−68,816（−60.1%）**。
注意 `-fopt-branch` 只改编码宽度不改条数，所以它在指令数一列是平的、在字节一列 −2,580。

单看每一级：`-fopt-vstack` −14,864、`-fopt-imm` −5,758、`-fopt-cbranch` −2,595、
`-fopt-live` −2,803、`-fopt-peep` −630、`-fopt-addr` −2,144、`-fopt-strength` −2,092、
`-fopt-cbz` −444、`-fopt-copyprop` −523。设计与判据分别见 `docs/RA_VSTACK.md`、
`docs/IMM_FOLD.md`、`docs/CBRANCH.md`、`docs/LIVE.md`、`docs/PEEPHOLE.md`、
`docs/ADDR_FOLD.md`、`docs/STRENGTH.md`、`docs/CBZ_FOLD.md`、`docs/COPYPROP.md`；
常量材料化本身（不开任何开关也生效，见 `docs/MOVIMM.md`）把 `-O2` 那一行从
51,416 条 / 116,380 字节降到 50,965 条 / 114,576 字节（−451 条 / −0.88%、
−1,804 字节 / −1.55%）。

**口径提醒**：各 `-fopt-*` 自己的文档里那张表是它上线那一刻的读数（当时常量材料化
还是「`MOVW` + `MOVT` + `MOVT #0`」的旧形态，vstack 也还没有逐块恢复与 256 层影子栈），
绝对数字与这张表不同；**这张表是当前二进制的权威口径**。

## 6. 怎么复现

```bash
# 1) 六条 armcc/armclang 臂，一次跑完（明细写 D:/tmp/fr/cmp_arm.json）
python D:/tmp/fr/cmp_arm.py

# 2) 两条 arkc 臂：-O2 无旗标 / 全部十九个 -fopt-*
python D:/tmp/fr/cmpark_all.py

# 3) 常量池两臂（十八 / 十九开关），产出 cmpark_lp.json
python D:/tmp/fr/cmpark_lp.py
```

两个脚本都假定：`D:/工作/git_project/ark c compiler` 是仓库根、`arkcc.exe` 是刚
`make` 出来的二进制、Keil 装在 `D:/Keil_v5`。语料路径写死在脚本里，换语料改 `srcs` 那一行。

## 7. 这张表不该被读成什么

- **不是「arkc 不可用」**：它自己编译自己、编译 HAL、在 STM32H743 与 F401 上跑过
  （见 `docs/BOARD_VALIDATION.md`），语义正确性由 `tests/arm_exec` 在 unicorn 上
  逐条执行验证。上表只是**体积/指令数**这一个维度。
- **不是「armcc 的优势不可追」**：§4 第 2 条（比较结果直连分支）已经落地并吃下
  2,601 条指令，是与活跃性分析无关的纯代码生成改动；剩下的第 1 条（中间结果落帧）
  要活跃性分析，是真正的工程量。
- **不是「IAR 更差或更好」**：没测，没有数字，所以这里没有说法。
- **不是「差距只剩几个 pass」**：把当前二进制的指令按助记符归类后，7,947 条差里有
  4,918 条（62%）落在同一组「值运输」类别（`MOV` 立即数 / `MOVW`+`MOVT` / `MOV` 寄存器 /
  `PUSH`+`POP` / 帧访问）。这是模型性代价，不是漏了某个 pass；还剩多少能省、每项要付
  什么，逐条写在 **[BOUNDARY.md](BOUNDARY.md)**（英文 [BOUNDARY.en.md](BOUNDARY.en.md)）。