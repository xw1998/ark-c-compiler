[English](VOLMEM.en.md) | 中文

# volatile 访问的标记与屏障：`-fopt-volbar`

0.9.1-wip。本文记录两件必须分开看的事：**volatile 标记**（一直生效，零代价）和
**volatile 屏障**（默认不发，`-fopt-volbar` 显式打开）。把两件事混在一起，就会出现「体积没变
= 没修」或者「修了 = 体积涨 40%」这两种都不对的读法。

## 1 问题

`arkcc` 原先对 volatile 有两处不对等：

| 访问形态 | 优化器看得见 volatile？ | 后端发 `DMB SY`？ |
| --- | --- | --- |
| 帧槽局部量 `volatile int v; ... v` | 是（`IR_AUX_VOLATILE`） | 是（一对，`-fopt-voldmb` 可在地址未逃逸时删掉） |
| 全局 `volatile int g;` | **否** | **否** |
| volatile 聚合的成员 `s.v`（`s` 为 volatile struct） | **否** | **否** |
| 解引用的指针 `*p`（`volatile int *p`） | **否** | **否** |
| 位域 `s.bf`（同上） | **否** | **否** |

「优化器看不见」是**红线级**的：`IR_AUX_VOLATILE` 一旦缺失，`copyprop`/`slotreg`/`cmat`/
`live` 这些只看 IR 的通道就有权把两次访问折成一次、把读提升出循环、或删掉「写了没人读」的
写——那会直接改变总线事务次数，**给出错答案**。

「后端不发屏障」不是红线：`DMB` 只影响内存系统对**另一个观察者**呈现的次序。ARMv7-M
（ARM ARM B2.3.7）规定单核执行时对 Device / Strongly-ordered 内存不做重排，所以对 volatile
访问一个屏障都不发是安全的；armcc、armclang、IAR 与 GCC（Cortex-M）**全都是这么做的**。

## 2 根因

`src/irgen.c` 各条 lvalue 路径只判 `L->type->is_volatile`。按 C11 6.5.2.3p3，限定符来自
**对象**而不是成员的自身类型：`struct S { int v; }; volatile struct S s;` 里的 `s.v` 是
volatile 访问，但 `L->type`（`int`）不带 `is_volatile`。于是：

- 标记层：IR 里这几个 op 的 `aux` 是 0，优化器不知道它是 volatile；
- 屏障层：ARM 后端原本只对帧槽路径（`IR_PUSH_VAR` / `IR_STORE`）发射 `DMB SY`，
  `IR_PUSH_GLOBAL` / `IR_STORE_GLOBAL` / `IR_LOAD_IDX` / `IR_STORE_IDX` /
  `IR_LOAD_FLD` / `IR_STORE_FLD` 一律不发。

实测（`struct S{volatile int v;}` 赋值＋取址＋读，`volatile int g` 读写，`*p`，`p->v`）：
改动前这四个形态**全部 0 个 `DMB`**，但**读次数、写次数、读写顺序都保留**——也就是说今天
没有可观测的错答案，缺的只是标记和硬件屏障。

## 3 标记层：改法（一直生效）

新增两个 helper：

```c
static int irgen_lvalue_volatile(AstNode *l);   /* 左值是否 volatile：自身类型，或基对象是 volatile 聚合 */
static int irgen_global_aux(Type *t);           /* 全局读写：复浮点 + volatile 两件事一起算 */
```

打标站点（全部走 helper，不再直接判 `L->type->is_volatile`）：全局读/普通写/复合赋值/
`++`/`--`、`*p` 读与写、`arr[i]` 读与写、`s.v` 读与写、`s.f OP=`、地址型 `++`/`--`、
位域读/写/复合赋值/`++`/`--`。

配套：`IR_STORE_FLD` 的 `aux` 同时承载宽度，后端必须 `int bw = I->aux & ~IR_AUX_VOLATILE;`
取宽度，否则 0x10000 会被当成位宽——这条已修，避免「标记把宽度污染了」的次生缺陷。

**代价：0**。95 个 HAL/Core TU 用 21 开关（`-fopt-frame -fopt-voldmb` 在内的默认组合）
对比 `7d5c0d0` 的构建，**95/95 逐字节完全相同**（12,113 条指令不变）。也就是说标记是
净收益的纯保险：它把「哪天某个优化通道开始在帧外 volatile 上折叠」这个未来风险提前堵住，
今天不改一行输出。

## 4 屏障层：为什么默认关

无条件给帧外 volatile 加 `DMB SY` 对的实测代价（同一批 95 TU、同一套开关）：

| 档 | 指令 | 语料 `DMB SY` |
| --- | --- | --- |
| 默认（不开 `-fopt-volbar`） | **12,113** | **1** |
| `-fopt-volbar` | 17,081（**+4,968，+41.0%**） | 2,848 |

热点（加法条数）：

| TU | 默认 | volbar | Δ |
| --- | --- | --- | --- |
| `stm32f4xx_hal_dma_ex.c` | 2,766 | 3,797 | +1,031 |
| `stm32f4xx_hal_dma.c` | 1,640 | 2,644 | +1,004 |
| `stm32f4xx_hal_rcc.c` | 1,860 | 2,829 | +969 |
| `stm32f4xx_hal_flash.c` | 721 | 1,105 | +384 |
| `stm32f4xx_hal_rcc_ex.c` | 755 | 1,080 | +325 |

78 个 TU 完全无变化；代价全部集中在 `hdma->Instance->CR` 这一类「指针 → volatile 成员」
密集的 HAL 模块里。这与 §3 的「宁可不发」判断一致：把这些屏障默认打开会直接摧毁
「打过 armcc」的体积目标，而且与三家参考编译器的行为相反。

所以：

- **默认行为 = armcc / armclang / IAR / GCC(Cortex-M)**：尊重限定符、不发屏障。
- **`-fopt-volbar`**：给帧外 volatile 访问补一对 `DMB SY`（前：让先前访存先完成；后：
  让后续访存后发）。用于「第二条总线主控（DMA 引擎、第二个核、另一个 ISR 上下文）
  依赖编译器提供次序」的场合。
- 与 `-fopt-voldmb` 构成一致的设计：帧槽地址可证未逃逸 ⇒ 屏障纯属开销，可删；
  帧外对象不可证 ⇒ 默认按参考编译器不发，需要严格序时显式打开，无法证明时**不擅自
  替用户做保守选择**（保守选择在这里的代价是 +41%）。
- 裁剪：`ARKCC_FEATURE_OPT_VOLBAR` 在 `ARKCC_PROFILE_STM32_MIN` 下为 0，剖面构建
  **按名拒绝** `-fopt-volbar`（`C3900U`），不带旗标照常编译。

## 5 未做 / 已知限制

- **riscv32 后端不发 `FENCE`**：标记照常打（优化器一侧的保证成立），硬件次序未补。
  RV32 的弱序模型与 ARMv7-M 不同，将来要做需要单独的判据（例如 `fence iorw,iorw`）。
- **x86 / x86-64**：强序 + 编译器不重排 volatile，不需要额外指令；标记同样尊重。
- **STM32H743 未上板**：本轮只有宿主构建、95 TU 语料、`tools/stm32_build_check.py
  --layout both` 与 `tests/arm_exec`（unicorn）四道证据。
- 位域的 `DMB` 只按「整个位域容器的一次读-改-写」计；不区分同容器内相邻位域的不同对象。

## 6 门禁（`tests/run_volmem_tests.py`，24 条全绿）

| 检查 | 读数 |
| --- | --- |
| `-O2` 与 `-O2 -fopt-volbar -fno-opt-volbar` 逐字节相同 | 是 |
| `global` / `member` / `pointer` / `repeat` 默认构建的 `DMB` 数 | 0 / 0 / 0 / 0 |
| `global` 默认构建仍保留 1 个存 + 1 个取 | 2 条访存 |
| `repeat` 默认构建仍保留 2 个存 + 2 个取 | 4 条访存 |
| `-fopt-volbar` 时四条夹具各得成对屏障 | 4 / 4 / 4 / 8 |
| 该旗标只加屏障、不搬动访存 | 访存数两臂相等 |
| 无 volatile 的函数逐字节不变 | 是 |
| 五条夹具 off/on 两臂都等于 Python 答案 | 7/9/11/8/7 |
| 裁剪构建按名拒绝 `-fopt-volbar` | `rc=1`，`C3900U` |
| 裁剪构建不带旗标照常编译 | `rc=0` |

配套跑过的回归：`copyprop` / `atomic` / `vstack` / `vreg` / `slotreg` / `peep` /
`pipeline` / `regalloc` / `live` / `voldmb` 全绿；`tests/arm_exec`（0 failure）；
`tools/stm32_build_check.py --layout both`（全 PASS）。
