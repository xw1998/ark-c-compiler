[English](CONSTCOND.en.md) | 中文

# 条件为字面量的分支在编译期决断：`-fopt-constcond`

0.9.1-wip。这条 pass 很小：它只做一件不含任何猜测的事——**条件的值是 IR 里的字面量时，
分支在编译期就有确定走向**。它默认关闭，收益 **−79 条指令（−0.65%）/ −1,483 B（−0.37%）**
（95 个 HAL/Core TU，`-O2`，Cortex-M4，22→23 个开关）。

## 1 问题：前端真的把字面量条件交给了发射器

HAL 与用户代码里最常见的一类"永远成立"的条件，不是写给人看的 `if (1)`，而是宏展开：

```c
#define __HAL_LOCK(__HANDLE__)                       \
  do {                                               \
    if ((__HANDLE__)->Lock == HAL_LOCKED) {          \
      return HAL_BUSY;                               \
    } else {                                         \
      (__HANDLE__)->Lock = HAL_LOCKED;               \
    }                                                \
  } while (0U)                                       \
```

`do { … } while (0U)` 的尾条件 `0U` 是字面量，`assert_param(...)` 在关断言时也变成
`if (0)`。前端如实把这些条件编成 IR：

```
PUSH_INT 0
PUSH            ; 值栈形态下的 DUP（不发射）
POP
JZ  .L_then
```

于是**每个** `__HAL_LOCK`、每个 `do{}while(0)` 包裹的宏都留下一条 `MOV r0, #0` /
`CMP r0, #0` / `BEQ` 的活指令链。它不是错误的代码，只是**已知答案的分支**。

## 2 为什么放在 IR 层

文本层想删这条链，必须回答两个它答不了的问题：`r0` 里这个常量是不是**正好**被这条
分支消费（中间有没有别的写入）？`PUSH`/`POP` 配平了吗？IR 层不用回答——

- `PUSH_INT k` 的 `k` 是 IR 里的字面量，不是某个寄存器的历史值；
- `PUSH_INT k` 与随后的 `JZ`/`JNZ`/`CMP_JMP_EQ` 的 net stack effect 恒为 0，删掉这两条
  不改变任何其它指令的求值深度。

## 3 三条折叠规则

| IR 形态 | 条件真值 | 结果 |
| --- | --- | --- |
| `PUSH_INT k`, `JZ L` | `k == 0` | 改 `JMP L`（总是跳），`PUSH_INT` 变 `NOP` |
| `PUSH_INT k`, `JZ L` | `k != 0` | 两条都变 `NOP`（次序即落空） |
| `PUSH_INT k`, `JNZ L` | `k != 0` | 改 `JMP L` |
| `PUSH_INT k`, `JNZ L` | `k == 0` | 两条变 `NOP` |
| `PUSH_INT k`, `CMP_JMP_EQ a, b, L` | `k == b->val` | 改 `JMP L` 并把 `b->val = b->aux`（分支的"运载值"换成被比较的那个），否则 `NOP` |

`PUSH_INT` 与分支之间允许夹零个或多个 `IR_DUP`（`val <= 1` 且非 volatile）：DUP 与分支弹出
配平，折叠本身不动它。语料里实测没有这种间隔形态（扩展前后读数完全一致），但逻辑保留。

末尾调用 `compact_func()`，把 `NOP` 从指令流里摘掉。

### 3.1 为什么放在 `ir.dce` 之前

折叠只会**新增**不可达代码（`if (0)` 之后那条跳转之后的块、`while (0)` 的循环体）。放在
线性 DCE 之前，这些块在同一次清理里被顺手删掉，不需要第二遍。实测 `if (0) { g = a*7; }`
从 38 条指令降到 17 条（含前后公共尾部），循环体整段消失。

## 4 不做什么（以及为什么）

| 没做 | 原因 |
| --- | --- |
| 64 位字面量条件 | `PUSH_INT` 只承载 32 位；64 位常量走另一条 IR 路径，需要单独的配平论证 |
| 数据流常量（`const int N = 0; if (N)`） | 那是 `constfold` + 常量传播的工作，本 pass 只认**直接**的字面量 |
| volatile 参与的条件 | volatile 读不是常量，语义上必须真的读一次 |
| 文本层 `MOV imm + CMP #0 + 条件跳` 的删除 | 需要文本层 liveness，是另一个量级的工作；见 §6 的残差 |

## 5 读数（95 TU，`-O2`，Cortex-M4）

| 配置 | 指令 | 字节 | 错误 |
| --- | --- | --- | --- |
| 22 个 `-fopt-*` | 12,113 | 403,432 | 0 |
| 23 个（+ `-fopt-constcond`） | **12,034** | **401,949** | 0 |
| 差 | **−79（−0.65%）** | **−1,483 B（−0.37%）** | — |

变化的 TU 12 个，**无一变大**。条数热点：

| TU | Δ 条 |
| --- | --- |
| `stm32f4xx_hal_dma.c` | −15 |
| `stm32f4xx_hal_flash_ex.c` | −12 |
| `stm32f4xx_hal_rcc.c` | −10 |
| `stm32f4xx_hal_dma_ex.c` | −8 |
| `main.c` | −7 |
| `stm32f4xx_it.c` | −5 |
| `gpio.c` / `stm32f4xx_hal_msp.c` / `stm32f4xx_hal_flash.c` / `stm32f4xx_hal_pwr_ex.c` / `stm32f4xx_hal_rcc_ex.c` | −4 各 |
| `stm32f4xx_hal_gpio.c` | −2 |

## 6 残差：37 处 `MOV rX, #imm` 紧邻 `CMP rX, #0`

23 开关的文本里仍有 37 处这种形状，抽样两类，**都不是相邻字面量条件**：

1. **布尔物化 + 逻辑或**——`if (cb != NULL || m1cb != NULL)` 编成
   `MOVNE r0, #1` / `MOVEQ r0, #0` / `B .L_x_8`，之后 `MOV r0, #1` / `CMP r0, #0` / `BEQ`。
   那个 `#1` 是上一段物化的**结果**，不是源码里的字面量条件。
2. **移位量守卫**——`MOV r4, #32` / `CMP r4, #0` / `ITE LT`：`#32` 是移位位宽，`CMP` 是
   负移位量的检查，与条件常量无关。

第 1 类要消掉，需要在 IR 层做"布尔物化消解"（把 `?:`/`||` 产生的 0/1 值直接接进分支），
那是另一个 pass，且必须同时处理两个分支的合流，收益面远大于本 pass。已登记，不混进来。

## 7 裁切

`ARKCC_FEATURE_OPT_CONSTCOND`：`ARKCC_PROFILE_STM32_MIN` 档为 0，其它档为 1。
裁掉之后 `-fopt-constcond` **按名字拒绝**（`C3900U`），而不是收下旗标静默不做事。
裁切自检已实测 **23/23**：22 个旧开关 + `constcond` 全部 `C3900U`，而
`constfold` / `dce` / `inline` / `regalloc` / `vectorize` 五个保留开关照旧 `rc=0`。
（`docs/BUILD.md` §5.2 同表已同步为 23/23。）

## 8 门禁

`tests/run_constcond_tests.py`（19 项检查，`make test-constcond`）：

1. **OFF IS OFF**：`-O2` 与 `-O2 -fopt-constcond -fno-opt-constcond` 逐字节相同（汇编与镜像）。
2. `if (0)` 的**死体消失**（含 `CC_G0` 的写不残留）。
3. `if (1)` 的**活体保留**，但不再有字面量分支。
4. `while (0)` 的**空循环**不留下回边。
5. `do { } while (0)` 的**单次执行**保留体、去掉回边。
6. **真实条件不动**：同一 TU 里按参数分支的函数逐字节相同。
7. **答案相同**：五个夹具在 unicorn 上两臂都返回 Python 算出的值（6/7/8/9/21）。
8. **裁掉即拒绝**：`-DARKCC_FEATURE_OPT_CONSTCOND=0` 的构建对 `-fopt-constcond` 报
   `C3900U` 并点名，不带旗标仍能编。