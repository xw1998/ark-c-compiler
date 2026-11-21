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
   - 尾合并：289/278/244 行
   - 整块合并：168/159/137 行
4. **拒绝**：`=10`、`=abc`、`=`、无值、`=-1`、`=5x` 全部 `rc=1`、报 `C3900U`
   且**不落盘**；裁剪构建拒绝并报 `not compiled into`，且 `-v` 里没有那一行。
5. **INI**：`size_weight=9` 与 `size-weight=9` 都到达表；越界 42 打警告、保持 5、`rc=0`。
6. **语义**：`tail.c` / `xblock.c` / `unroll6.c` / `inline_mid_rt.c` 在 0/5/9 返回
   同一个值；语料在体积端的对象总字节 4544 → 3094。

两道防假绿：门禁自己会先确认「表不在中点塌成平的」（第 1 项最后一条），以及
「裁剪构建里连 `-v` 的那一行都没有」（否则第 4 项可能只是读到了默认值）。

## 5. 实测

- **对账**：`examples/*.c` 全部 80 个文件，用 HEAD（0.9.0 + P1/P2/P3/P4）与
  P6 工作树各编一遍（`-target arm -S -O2 --tailmerge --xblock --unroll --licm
  --divconst`），**0 处不一致**。
- **拆表**：`-v` 在 `=0` 时 `28/16/6/7`，`=9` 时 `4/4/2/3`，默认 `12/8/3/4`。
- **板端**：见 §7（UV4 重建 `mdk/STM32H743_ArkCC` 的 Program Size 对账）。

## 6. 已知欠账：带参数的函数永远不会被内联

一个既有缺陷，P6 **没有修**，因为修它会改变 `-O2` 的默认产物（属于独立决定）。
登记在这里，-O 不知道它是缺陷时最容易读到错答案：

- `src/irgen.c` 给 `IR_GETARG` 的 `aux` 写 `(size << 8) | slot`，**标量参数也写
  size**（例如 `int` 就是 `1 << 8`）。
- `src/opt.c` 的 `count_insts_and_check_recursion()` 用 `(aux >> 8) != 0` 判定
  「有 struct-by-value 参数」，于是**任何有参数的函数都被判成不可内联**。

最小复现（`arkcc -target arm -O2 -S`）：

```c
int v;
static int g(int x) { int y = x + v; return y; }   /* byval=1 ⇒ 不内联 */
int main(void) { return (g(1) + g(2)) & 0x7F; }    /* 产物里 BL g 仍是 2 */
```

同一份代码把参数去掉（`static int g(void)`）就正常内联。`forceinline` 也绕不过去
（它只绕过体积上限，绕不过 `has_struct_byval` 的 `continue`）。

**对 P6 的影响**：权重的内联维度只能用**无参数**的被调函数观察，门禁因此把内联
夹具写成无参数版本（`inline_small.c` / `inline_mid.c`），并在脚本注释里写明原因。
这不是「内联没生效」的证据——插桩确认 `can_inline=1` 且 `inline h -> main` 确实执行。

顺带一条同源的测量陷阱：内联是**单遍**的。夹带启动文件时，`Reset_Handler` 里被
内联进去的那份 `main` 副本仍带着未展开的 `BL h`，所以整文件数 `BL h` 会得到 2，
看着像「没内联」。数调用点只能数**某个具体函数体里**的，或者干脆用不含第二个入口
的夹具。

## 7. 板端

`mdk/STM32H743_ArkCC` 用 UV4 重建（`UV4 -b ArkCC.uvprojx -j0`）后记录 Program
Size：`Code=182828 RO-data=23740 RW-data=3431972 ZI-data=37144`，与 P4
（`--xblock`）的基线**逐字节相同**，`0 Error(s)`。

这一条是修出来的，不是碰巧：第一版把 `#else` 分支写成四个返回常量的**函数**，
板端 `Code` 立刻 +8 B（182828 → 182836）——裁剪构建里没人调用它们，但它们是全局
符号，链接器不会替你扔掉。改成宏之后回到 182828。也就是说「关掉就等于 0.9.0」
这句话在板端也要能被体积证明，而不只是「看起来没跑」。
