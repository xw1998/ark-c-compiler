# 强度削减（`-fopt-strength`）

[English](STRENGTH.en.md) | 中文

> 0.9.1 的第六块优化。一句话：**乘 2 的幂不必乘——左移就够；而这份语料上真正
> 花掉乘法的不是源码里的 `x * 4`，是编译器自己为数组下标生成的「元素大小 × 下标」。**
>
> 实现位置：`src/opt.c`（`opt_strength_func()`，IR 层）＋
> `src/backend/arm/backend_arm.c`（`case IR_LOAD_IDX`，后端）
> 门禁：`tests/run_strength_tests.py`（`make test-strength`）
> 开关：`-fopt-strength` / `-fno-opt-strength`，INI `opt-strength=` / `strength=`

---

## 1. 为什么一个开关两个落点

「乘 2 的幂换成左移」是**同一件事**，但在这套编译器里它出现在两个地方，谁都不覆盖谁：

| 落点 | 看得到的形状 | 在 HAL 语料上的 MUL 条数 |
| --- | --- | --- |
| **A. IR peephole** | 源码里的常量乘法：`x * 4`、`x * 1`、`n * 8` | 53 |
| **B. 后端 `IR_LOAD_IDX`** | 编译器自己生成的元素大小缩放：`p[i]` → `i * sizeof(*p)` | 1,052 |

A 看不见 B —— 因为 B 是 **IR 之后**由后端的寻址代码生成器算出来的，IR 里只有一个
`IR_LOAD_IDX(base, index, size)` 节点，没有任何 `IR_PUSH_INT 4` + `IR_BINARY MUL`。
而 B 才是大头：HAL 语料 1,105 条 `MUL` 里 1,052 条是 `p[i]` 的 stride 缩放
（`MOV r2, #4` 1,043 条、`MOV r2, #2` 9 条），源码里的常量乘只有 53 条
（`MUL r0, r1` 40 条、`MUL r0, r4` 8 条、`MUL r0, r7` 5 条）。

拆成两个旗标会让用户必须记得开两个才有完整效果，所以**一个 `-fopt-strength` 同时管两处**。

## 2. 落点 A：IR 层 peephole

匹配**相邻**两条：

```text
IR_PUSH_INT k            k 是 2 的幂，2 <= k <= 0x40000000
IR_BINARY  TOK_MUL   →   IR_PUSH_INT log2(k)
                         IR_BINARY  TOK_SHL
```

`k == 1` 时**两条都删**：乘 1 是恒等，且 `PUSH 1` + `MUL` 的净栈效应是 0，删除后栈形不变。

不做的事（都是刻意的）：

| 没做 | 原因 |
| --- | --- |
| `k == 0` | IR 没有"丢掉栈顶"的中性操作，删除会破坏栈平衡 |
| `k < 0` | 负数还要再一条取负，净增指令 |
| `3`、`5`、`10` 等非 2 的幂 | Cortex-M4 的 `MUL` 是**一周期**，`LSL`+`ADD` 链至少两条，不会更短（AC5 对 `x*3` 发 `ADD r0, r0, r0, LSL #1`，那是它做 strength/tree 合并时的选择，不是本条规则） |
| 常数在左侧（`4 * x`） | 本规则只看相邻两条；`4 * x` 的 IR 形是 `PUSH x, PUSH 4, MUL`，窗口够不着。宁可漏，不可错 |

`IR_BINARY` 的栈形是「左操作数、右操作数」，所以可交换性对这条规则是安全的
（乘法两个方向等价），但实现里仍按「`PUSH k` 紧跟在 `MUL` 之前」判断，不去猜哪一侧是常量。

## 3. 落点 B：`IR_LOAD_IDX` 的 stride

后端原本对每个带缩放的索引发：

```asm
MOV  r2, #4          ; 元素大小
MUL  r1, r2          ; index * sizeof(element)
```

`es` 是 2 的幂时改为：

```asm
LSL  r1, r1, #2      ; 一步
```

`sh` 由 `while ((1 << sh) < es) sh++;` 求出。`es == 1` 时本来就不发这两条，无需分支。

这一步**省下的是一条 `MOV` 与一条 `MUL`**（`MUL` 一周期，但取指与译码不是），
且它作用在编译器自己产生的代码上，源码里无论怎么写都躲不开。

非 2 的幂的 `es`（结构体 12、20、24 字节）保持原样：`LSL` 拼不出来，而
`ADD Rd, Rn, Rm, LSL #n` 这种"一条指令完成 ×3/×5/×(5·2^n)"的形态**本仓库的内部汇编器
目前不生成**，所以留作欠账而不是硬塞。

## 4. 阶段位置：为什么必须放在管线末尾

`ir.strength` 在 `src/pipeline.c` 的阶段表里排在 **`ir.xblock` 之后、`ir.vectorize` 之前**。

第一版放在 `ir.dce` 后面（"常量折叠/死代码之后顺手做"），结果**开了反而变大**：
pow2 夹具 512 → 533 条指令、镜像 2128 → 2170 字节（+42 B）。

原因不是这条规则本身：`x * 1` 的删除让某个函数的 IR 条数从 12 掉到 10，恰好跌破
`opt_inline` 的阈值，于是 `scale()` 被**内联**进调用者，函数体变大。
即——提前做 strength 会改变**后续 pass 的决策**，而 inline 的收益/代价并不在这个
pass 的判据里。

把阶段整行移到 `ir.xblock` 之后，inline / const-global / tailmerge / xblock 看到的是
与原版完全相同的 IR 形状，只有最后一步的发射看到了移位形式。移动后 512 → 503、
镜像 2128 → 2110，问题消失。

这条顺序是**实测踩出来的，不是预设**；理由已写在 `src/pipeline.c` 的注释里。

## 5. 证据：AC5 怎么做

在同一台机器上跑 armcc：

```bash
/d/Keil_v5/ARM/ARMCC/bin/armcc.exe --c99 -O2 -c --cpu Cortex-M4 /tmp/acc.c
/d/Keil_v5/ARM/ARMCC/bin/fromelf.exe --text -c /tmp/acc.o
```

```asm
; int sumi(int *p, int n) { ... *p++ ... }      ->  LDR  r4, [r3, r2, LSL #2]
; int m4(int x)  { return x * 4; }              ->  LSLS r0, r0, #2
; int m3(int x)  { return x * 3; }              ->  ADD  r0, r0, r0, LSL #1
```

三点结论：

1. AC5 对 `x * 4` **不发 `MUL`**，发 `LSLS`；
2. AC5 对 `x * 3` 发一条 scaled `ADD` —— 这是它有一整套 strength reduction 表，
   arkc 只做 2 的幂这一档；
3. AC5 对 `p[i]` 把缩放**折进寻址方式**（`[r3, r2, LSL #2]`）—— 一步到位，
   比 arkc 现在的"先 `LSL` 再 `[r1]"两步"更短。这是 `-fopt-addr` + 本 pass 之后
   仍存在的已知差距（见 §7）。

本 pass 的形态（`LSL r1, r1, #n` 单独一条）是"先保证对、再谈更短"的中间落点。

## 6. 实测

条数是 `.s` 里非指示、非标签的行数（`grep -cE '^    [A-Za-z]'`）；对象大小是
`arkcc -c` 的整个 `.o`（**含符号表与节头，不是纯 text**，只用来做同口径对比）。

语料：`examples/ark_test/ark_test_all.c`（STM32F401xE + HAL + CMSIS，`-O2 -mcpu Cortex-M4`）

### 6.1 纯 `-O2` 之上

| 构建 | 指令数 | 变化 | `MUL` | `LSL` |
| --- | --- | --- | --- | --- |
| `-O2` | 47,885 | — | 1,105 | 125 |
| `-O2 -fopt-strength` | **46,779** | **−1,106（−2.31%）** | **12** | 1,209 |

拆开看这 1,106 条：`LOAD_IDX` 的 stride 缩放 1,052 条 × 2 条指令 = 2,104 条被换成
1,052 条 `LSL`（净 −1,052）；IR 层的常量乘 41 条 × 2 条 = 82 条被换成 41 条 `LSL`
（净 −41）；`x * 1` 的删除再贡献一些。合计 −1,106。

**`MUL` 1,105 → 12**，且这 12 条**没有一条是常量乘**：它们全是两个值相乘
（HAL 里的定点/比例计算）。也就是说，这份语料上"常量乘"这一类被清空了。

### 6.2 在 `-fopt-vstack -fopt-addr` 之上（完整链）

| 构建 | 指令数 | 变化 |
| --- | --- | --- |
| `-fopt-vstack` | 38,004 | （相对纯 `-O2` −20.64%） |
| `+ -fopt-addr` | 36,553 | −3.82% |
| `+ -fopt-strength` | **35,453** | **−1,100（−3.01%）** |

完整链：**47,885 → 38,004 → 36,553 → 35,453（累计 −25.96%）**。

### 6.3 对象字节（同一 TU，`-c`）

| 构建 | 字节 | 变化 |
| --- | --- | --- |
| `-O2` | 115,090 | — |
| `-O2 -fopt-strength` | 112,878 | **−2,212 B（−1.92%）** |
| `-fopt-vstack -fopt-addr` | 92,408 | — |
| `+ -fopt-strength` | 90,208 | **−2,200 B（−2.38%）** |

两份对比的绝对值不同、降幅相近，说明收益不依赖前面两个 pass 的形态。

### 6.4 夹具

| 夹具 | 关 | 开 | 说明 |
| --- | --- | --- | --- |
| `pow2`（`int` 数组求和 + `short` 数组求和 + `x*4 + x*8 + x*1` + 指针走查） | 512 条 / 2128 B | 503 条 / 2110 B | 返回值 112 |
| 同上，叠 vstack+addr | 333 条 / 1768 B | 326 条 / 1754 B | 返回值 112 |
| `odd`（`x*3 + x*5`） | 124 条 / 1298 B | 124 条 / 1298 B | **逐字节相同**，返回值 56 |

`odd` 那一行是本 pass 的**边界证据**：非 2 的幂一个字节都不动。

## 7. 与 AC5 的已知差距

1. **索引缩放没有折进寻址方式**：AC5 发 `LDR r4, [r3, r2, LSL #2]`，arkc 现在发
   `LSL r1, r1, #2` + `LDR r0, [r4, r1]`。要走到这一步，`-fopt-addr` 的 R2 规则
   需要认识「`LSL` 之后紧跟一次 `[rB, rI]`」并把它并成 `[rB, rI, LSL #n]`。
   这需要后端能发出 `[Rn, Rm, LSL #n]` 的变体，而 `-fopt-addr` 目前只在原有形状上折叠；
   合并会**缩短**指令流，但会让 `-fopt-addr` 的"只删不改"不变量多一条例外。留作欠账。
2. **非 2 的幂**：AC5 有 3/5/9 等一整套，arkc 只有 2 的幂。这条的收益取决于语料里
   结构体数组的比例；HAL 语料里 `es = 12/20/24` 的访问不多。
3. **左侧常量**：`4 * x` 不动（见 §2）。

## 8. 门禁说了什么

`make test-strength`（`tests/run_strength_tests.py`），14 项检查，两个夹具五臂：

臂 = `base`（`-O2`）、`off`（`-O2 -fno-opt-strength`）、`on`（`-O2 -fopt-strength`）、
`va`（`-fopt-vstack -fopt-addr`）、`all`（`va` + strength）。

1. **OFF IS OFF**：`base` 与 `off` 的镜像**逐字节相同**（2128/2128）——默认构建看不见这个 pass。
2. **IT PAYS**：`pow2` 上 `on` 的指令数低于 `base`（512 → 503）。
3. **NO POWER-OF-TWO MUL**：`pow2` 上 `MUL` 计数 `base=10 → on=0`、`all=0`。
4. **THE SCALE BECAME A SHIFT**：`LSL r1, r1, #n`（`IR_LOAD_IDX` 缩放形）`base=0 → on=3`。
   只做 IR 层、漏掉后端那一处的实现过不了这一项。
5. **NO RESIDUE**：`PUSH #2^k` + `MUL` 的就地模式，`on`/`all` 均 **0**。
6. **IT PAYS ON TOP OF VSTACK/ADDR**：`all` 的指令数低于 `va`（333 → 326）。
   （早期版本拿 `on` 与 `va` 比，逻辑不成立，已改为独立 `va` 臂。）
7. **THE IMAGE NEVER GROWS**：`base/on = 2128/2110`、`va/all = 1768/1754`。
8. **SAME ANSWER**：五臂在 unicorn 上都返回 112。
9. **NO REWRITE FOR NON-POWERS-OF-TWO**：`odd` 上 `MUL` 计数 `base=on=all=4`、
   指令数 124 → 124、镜像 1298 → 1298 / 1244 → 1244。这条是**防后人"顺手"把 3/5 也改了**。
10. **CROPPED OUT**：`-DARKCC_FEATURE_OPT_STRENGTH=0` 的构建以 `C3900U` 拒绝
    `-fopt-strength`，且不带该旗标仍能编译同一份程序。

第 3/4/5 项是必需的三件套：只测"条数下降"的实现可以靠各种副作用通过；
必须**同时**看到 `MUL` 归零、`LSL` 出现、残留为 0。

另外每次都跑整个 ARM 执行语料：

```
tests/arm_exec/run_arm_exec.py --arkcc ./arkcc.exe "--extra=-fopt-strength"
tests/arm_exec/run_arm_exec.py --arkcc ./arkcc.exe "--extra=-fopt-vstack -fopt-addr -fopt-strength"
```

两条都是 **0 failure(s)**。夹具验的是形状，全语料验的是语义：移位与乘法在低 32 位
上等价这一点，只有把带符号/无符号、`short` 提升、指针差这些用例真跑一遍才算数。

## 9. 裁切

`include/arkcc_config.h` 的 `ARKCC_FEATURE_OPT_STRENGTH`：`ARKCC_PROFILE_STM32_MIN` 下为 0，
宿主/交叉编译为 1。

与前面几个 pass 不同的是：**这个 pass 在板端也裁掉是对的**，因为运行期默认关，
它在板端 Flash 里只是躺着。为 0 时 `opt_strength_func()` 与后端那一处分支整块被预处理掉，
`src/main.c` 以 `C3900U: -fopt-strength is not compiled into this build` 拒绝该旗标。

运行期默认**关**（`g_config.enable_opt_strength = 0`），所以不加旗标的产物与 0.9.0 逐字节相同
（`cmp` 验证：`BASE-IDENTICAL`、`VA-IDENTICAL`）。

## 10. 与其它 pass 的关系

```
...  ir.constglobal → ir.tailmerge → ir.xblock
     ir.strength        # 本条：只改写 IR 的最后一步，不动内联决策
     ir.vectorize
     ...  发射 → ark_vstack_function() → ark_addr_function() → ...
```

- **在 `ir.xblock` 之后**：见 §4。
- **与 `-fopt-addr` 的分工**：strength 缩短的是"算出地址算术里的乘法"，addr 折的
  "把已算出的地址塞进寻址方式"。两者相邻但不重叠；先做哪个都一样，但 stage 表里
  strength 在 IR 层、addr 在汇编文本层，顺序由架构决定。
- **与 `-fopt-divconst` 的关系**：那条处理的是除法常数（长除法 → 乘法 + 移位），
  象限完全不同；两者都是"把一条贵指令换成便宜指令"，但 divconst 的判据是确定性
  魔数公式，本条的判据只有 2 的幂。