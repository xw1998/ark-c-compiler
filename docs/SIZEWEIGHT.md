# `--size-weight`：一个连续的空间/速度权重（0.9.1）

`--size-weight=N` 用一个 0..9 的整数，同时移动四个已有优化 pass 的**门槛**。
默认值 5，且 5 的四个门槛与 0.9.0 的编译期常量逐一相等——这就是「不写这个
选项的构建，产物与 0.9.0 逐字节相同」的全部依据。

```text
--size-weight=N      0 = 速度优先（门槛最松：多内联、多展开）
                     5 = 默认，等于 0.9.0 的常量（12 / 8 / 3 / 4）
                     9 = 体积优先（少内联、少展开，更容易合并）
```

`-v` 会把解析后的四个门槛打出来，这也是门禁读表的唯一入口：

```text
  size_weight=5 inline<=12 unroll<=8 tailmerge>=3 xblock>=4
```

## 1. 四张表

| 权重 | 0 | 1 | 2 | 3 | 4 | **5** | 6 | 7 | 8 | 9 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 内联上限（IR 指令数 ≤） | 28 | 24 | 20 | 17 | 14 | **12** | 10 | 8 | 6 | 4 |
| 展开上限（循环次数 ≤） | 16 | 14 | 12 | 10 | 9 | **8** | 7 | 6 | 5 | 4 |
| 尾合并最小长度（≥） | 6 | 6 | 5 | 5 | 4 | **3** | 3 | 2 | 2 | 2 |
| 整块合并最小长度（≥） | 7 | 7 | 6 | 6 | 5 | **4** | 4 | 3 | 3 | 3 |

读法：**权重往 9 走 = 体积优先**。内联/展开的上限下降（少动手），尾合并与整块
合并的**最小长度下降**（更容易合并，合并本身是省体积的）。所以「门槛」这四个字
在两个方向上的语义是相反的，看表比记规则可靠。

表的按键在 `src/config.c` 末尾，四个访问器 `ark_inline_threshold()` /
`ark_unroll_max()` / `ark_tailmerge_min_len()` / `ark_xblock_min_len()` 是唯一读点：

| 读点 | 位置 | 用途 |
| --- | --- | --- |
| `ark_inline_threshold()` | `src/opt.c` | `cnt <= 门槛` 才内联（`forceinline` 绕过） |
| `ark_unroll_max()` | `src/opt_loop.c` | 循环次数 `<= 门槛` 才展开（函数体上限仍是 64 条） |
| `ark_tailmerge_min_len()` | `src/opt_tailmerge.c` | 尾段长度 `>= 门槛` 才合并 |
| `ark_xblock_min_len()` | `src/opt_tailmerge.c` | 整块长度 `>= 门槛` 才合并 |

**原来的四个宏被删掉了**（`ARK_INLINE_THRESHOLD` / `ARK_UNROLL_MAX` /
`ARK_TAILMERGE_MIN_LEN` / `ARK_XBLOCK_MIN_LEN`）。留着它们等于留一个「改了也不
起作用」的旋钮，而「宁可报错不给错答案」要求一个值只有一个来源。

## 2. 为什么不给 `-Oz` / `-Os` / `-Ot`

初稿的想法是照 IAR 的 `-s0..9` / `-z0..9` 做三个档位。落到 arkc 上不合适：
`-O0/-O1/-O2` 决定的是**跑哪些 pass**，而这四个门槛只调**同一个 pass 的取舍**。
新增 `-Oz` 会让人合理地以为它顺带改了 `-O` 级别（例如不再跑 LICM），实际不会——
那就是一个语义含糊的旋钮。所以只加一个与 `-O` 正交的数值权重，文档里把这层关系
写清楚。**与初稿不同，已改。**

## 3. 三层裁切

| 层次 | 手段 | 关掉之后 |
| --- | --- | --- |
| 编译期 | `ARKCC_FEATURE_SIZEWEIGHT`（**派生**自四个 pass 宏） | 选项被 `C3900U` 拒绝，`-v` 里连那一行都不打印 |
| 运行期 | `--size-weight=N` / INI `size_weight=` | 默认 5，与不写逐字节相同 |
| 剖面 | 四个 pass 各自的阶段行（`ir.inline` 等） | 被跳过的 pass 连门槛都不读 |

派生宏的写法在 `include/arkcc_config.h`：

```c
#ifdef ARKCC_FEATURE_SIZEWEIGHT
/* 派生开关，不接受 -D 直接设定：单独裁掉它会让访问器没有定义 */
# undef ARKCC_FEATURE_SIZEWEIGHT
#endif
#if ARKCC_FEATURE_OPT_INLINE || ARKCC_FEATURE_UNROLL || \
    ARKCC_FEATURE_TAILMERGE || ARKCC_FEATURE_XBLOCK
#  define ARKCC_FEATURE_SIZEWEIGHT   1
#else
#  define ARKCC_FEATURE_SIZEWEIGHT   0
#endif
```

两个细节都踩过：

- **不接受 `-DARKCC_FEATURE_SIZEWEIGHT=0` 单独裁剪**。四个 pass 的代码本身不按
  开关裁（只是不注册进阶段表），所以 `src/opt.c` 在裁剪构建里仍然会调用
  `ark_inline_threshold()`；只裁这一个宏就是**未定义符号**——初版门禁就是这样
  拿到一个 `ld returned 1 exit status` 的 SKIP。
- 因此 `#else` 分支也必须能解析那四处调用。这里用**宏**退回历史常量
  （`# define ark_inline_threshold() 12` 等），不用函数：函数是符号，裁剪构建里会
  被链接器留下来（板端实测 +8 B Code，见 §7），宏不留符号。裁剪构建里
  `--size-weight` 被拒绝，行为就是 0.9.0。

板端（`STM32_MIN`）与「没有任何 MIR 优化 pass」的构建都落在 `#else` 一侧：这四个
门槛本来就只属于宿主侧优化，留着只是编出一个「能开、但永远不动」的假选项。

## 4. 判据

`tests/run_sizeweight_tests.py`，31 项，`make test-sizeweight`：

1. **表**：10 个权重都能读出；`5 == (12,8,3,4)`；四张表各自单调；两端确实离开中点
   （不是一张平表）。
2. **默认**：不写选项解析出的表与 `=5` 相同；6 个夹具对象「不写」与「写 5」逐字节
   相同；`hello.c` 亦然。
3. **每个门槛都真的动代码**（`-S` 文本 + 模拟器同值）：
   - 内联 `BL h` 计数：小夹具 0/0/2、中夹具 0/2/2（0/5/9）
   - 展开：12 次循环 467/135/135 行；6 次循环 275/275/135 行
   - 尾合并：313/302/244 行
   - 整块合并：353/159/137 行
4. **拒绝**：`=10`、`=abc`、`=`、无值、`=-1`、`=5x` 全部 `rc=1`、报 `C3900U`
   且**不落盘**；裁剪构建拒绝并报 `not compiled into`，且 `-v` 里没有那一行。
5. **INI**：`size_weight=9` 与 `size-weight=9` 都到达表；越界 42 打警告、保持 5、`rc=0`。
6. **语义**：`tail.c` / `xblock.c` / `unroll6.c` / `inline_mid_rt.c` 在 0/5/9 返回
   同一个值；语料在体积端的对象总字节 5040 → 3094。

两道防假绿：门禁自己会先确认「表不在中点塌成平的」（第 1 项最后一条），以及
「裁剪构建里连 `-v` 的那一行都没有」（否则第 4 项可能只是读到了默认值）。

## 5. 实测

- **对账**：`examples/*.c` 全部 80 个文件，用 HEAD（0.9.0 + P1/P2/P3/P4）与
  P6 工作树各编一遍（`-target arm -S -O2 --tailmerge --xblock --unroll --licm
  --divconst`），**0 处不一致**。这一条只对「内联尚未修」的那个时点成立；
  修掉带参内联之后（见 §6），带参数的小函数会在 `-O2` 下被展开，默认产物因此
  合法地改变——所以它是那一轮的证据，不是一条永久不变量。
- **拆表**：`-v` 在 `=0` 时 `28/16/6/7`，`=9` 时 `4/4/2/3`，默认 `12/8/3/4`。
- **板端**：见 §7（UV4 重建 `mdk/STM32H743_ArkCC` 的 Program Size 对账）。

## 6. 带参数的函数内联（0.9.1-wip 已修）

P6 交付时这里是「已知欠账」：`irgen` 给 `IR_GETARG` 的 `aux` 写 `(size << 8) | slot`
（标量也写 size），`src/opt.c` 用 `(aux >> 8) != 0` 判「有 struct-by-value 参数」，于是
**任何有参数的函数都不内联**，`forceinline` 也绕不过去。修它会改 `-O2` 默认产物，所以当时
单独挂着。

现在判定不再读 `aux` 高位，而读参数类型：

- `irgen_param_slots(Type *)`（`include/irgen.h` / `src/irgen.c`）用的就是 irgen 排参数时
  那条规则 `irgen_param_words()`：>8 字节聚合、16 字节 `_Complex` 按地址走 ⇒ `-1`；
  5..8 字节聚合、`long long` / `double` ⇒ 2 字；其余 ⇒ 1 字。C 后端（8 字节槽）与 x86-64
  （指针占一个字）一律 `-1`。
- `src/opt.c` 的 `inline_param_words()` 逐参数求和，`-1` 或 `> 4` 不内联。展开时按参数
  **分组逆序** `IR_STORE`（IR 栈里一个字参数的高字在上）、`IR_GETARG` 按 `aux>>8 > 4` 复制
  1 或 2 个字；`IR_CALL.val` 是**实参个数**而不是字数，与 `param_count` 不一致就保留调用。

| 形态 | 结果 |
| --- | --- |
| 1 字参数（`int`、指针） | 内联 |
| 2 字参数（`long long`、`double`、5..8 字节聚合） | 内联（字偏移按参数宽度累加） |
| `__forceinline` + 带参且体超阈值 | 内联（绕过体积上限这条不变） |
| >8 字节聚合参数（按地址传） | 保留调用 |
| 5 个及以上参数、递归、`...` | 保留调用 |
| `-target c`（8 字节槽）、`-target x86_64`（指针一字） | 保留调用 |

门禁 `tests/run_inline_tests.py`（`make test-inline`，25 项）：`-O2` 下
`static int add1(int)` 无 `BL add1`、`--no_autoinline` 下仍是 2 条（防「pass 没跑」冒充
「内联成功」）；同一夹具在 `--size-weight=9`（inline≤4）下又回到 2 条；`__forceinline`
带参超阈值体仍内联而同体无属性不内联；两字参数在前 + 一字参数在后的槽位、5 字节结构体读
第二个字的值都正确（`long long` 夹具在模拟器上返回 7、结构体返回 9，两臂一致）；四类拒绝
形态与被拒的两个目标都保留调用；九支夹具在「默认 / `--no_autoinline` / `--size-weight=9`」
三臂上同值；`-DARKCC_FEATURE_OPT_INLINE=0` 的裁剪构建对 `--autoinline` 报 `C3900U`，不给
该选项时照常编译成普通调用。

注意三件事：① P6 那一轮「`examples/*.c` 80 个文件 0 处不一致」只对那一轮成立——带参内联
会改变 `-O2` 默认产物；② `--tailcall` 的门禁现在一律带 `--no_autoinline`，否则它的
「带参小函数」夹具会先被内联掉，`B leaf` 永远不出现；③ `--xblock` 的门禁同理（全量 `make
test` 里就是这样抓到的：夹具的 `two()` / `three()` 各调两次 `g()`，内联之后重复块直接消失，
合并自然无从发生——7 项一起 FAIL，加 `--no_autoinline` 后恢复，对象 865 → 763 字节）。

顺带一条同源的测量陷阱（不变）：内联是**单遍**的。夹带启动文件时，`Reset_Handler` 里被
内联进去的那份 `main` 副本仍带着未展开的 `BL h`，所以整文件数 `BL h` 会得到 2，看着像
「没内联」。数调用点只能数**某个具体函数体里**的，或者干脆用不含第二个入口的夹具。

## 7. 板端

`mdk/STM32H743_ArkCC` 用 UV4 重建（`UV4 -r ArkCC.uvprojx -j0`），`0 Error(s)`：

| 构建 | Code | RO-data | RW-data | ZI-data |
| --- | --- | --- | --- | --- |
| P4 基线（`--xblock`） | 182828 | 23740 | 3431972 | 37144 |
| 只加 `--size-weight`（`ae3dd8c`，独立 worktree 编译） | **182828** | 23740 | 3431972 | 37144 |
| 再加带参内联修复（本轮工作树） | 183064 | 23740 | 3431972 | 37144 |

**第一行与第二行逐字节相同，这一条是修出来的，不是碰巧。** 第一版把 `#else` 分支
写成四个返回常量的**函数**，板端 `Code` 立刻 +8 B（182828 → 182836）——裁剪构建里
没人调用它们，但它们是全局符号，链接器不会替你扔掉。改成 `#else` 里的**宏**之后回到
182828。也就是说「关掉就等于 0.9.0」这句话在板端也能被体积证明，而不只是「看起来
没跑」。

**第三行的 +236 字节全部来自带参内联修复**（§6），与权重无关：板端 `STM32_MIN`
下四个 pass 本来就是 0（`ARKCC_FEATURE_OPT_INLINE/UNROLL/TAILMERGE/XBLOCK` 全裁），
所以权重表、`-v` 那一行、usage 一个字节都不进板端。但 `src/opt.c` 的展开代码与
`src/irgen.c` 的 `irgen_param_slots()` **不按开关裁**（pass 只是不进阶段表），因此
裁剪构建仍要链接它们。想让这 236 字节也消失，得把 `opt_inline()` 的函数体也包进
`#if ARKCC_FEATURE_OPT_INLINE`——那是另一件事，登记为欠账，本轮不做：
先让修正在宿主侧完整可用，再谈给板端省 0.13% 的 Flash。
