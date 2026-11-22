# 常量操作数折进立即数（`-fopt-imm`）

[English](IMM_FOLD.en.md) | 中文

> 0.9.1 的第七块优化，也是 0.9.1 里最大的一块。一句话：**`PUSH k` 紧跟一次算术/比较
> 时，不要把这个常量推上值栈再弹下来——直接把它写进指令的立即数字段。**
>
> 实现位置：`src/backend/arm/backend_arm.c`，发射期（`emit_binary_imm()`，IR 主循环里的
> 「吞常量」块）
> 门禁：`tests/run_imm_tests.py`（`make test-imm`），外加 `tests/arm_exec` 全语料
> 开关：`-fopt-imm` / `-fno-opt-imm`，INI `opt-imm=` / `imm=`

---

## 1. 为什么做，做在哪一层

arkc 的 ARM 后端是一个**值栈机**：每个表达式的结果都真的被 `PUSH {r0}` 压到栈上，
二元运算再从栈上 `POP r1` / `POP r0` 取两个操作数。这对常量极不划算：

```c
int f(int a) { return a + 16; }
```

`-O2`（不开任何 `-fopt-*`）发出来是

```asm
    PUSH {r0}          ; a（参数已经在 r0，仍先入栈）
    MOV  r0, #16       ; 常量
    PUSH {r0}          ; 常量入栈
    POP  r1            ; 右操作数 = 16
    POP  r0            ; 左操作数 = a
    ADD  r0, r0, r1
    PUSH {r0}
```

而 `ADD r0, r0, #16` 本来就是一条指令。**六个值栈动作里五个是纯开销。**
HAL 语料里这种形态遍地都是（`HAL_Delay(10)`、`GPIO_PIN_5`、`RCC_CR_HSEON`、
`if (state == 3)`），所以这一块单独贡献了 −21.3% 的指令数（§6）。

介入层次与前三块不同：`-fopt-vstack` / `-fopt-addr` / `-fopt-cbz` 都是**发射后的文本重建
pass**，而这一块是**发射期**决策。理由只有一条：

> 文本层无法可靠回答「`MOV r0, #16` 到底是不是某次 `PUSH` 的操作数」。
> 到了 `.s` 文本里，常量已经被物化成一个寄存器，寄存器编号与「它是第几个压栈的值」
> 的对应关系已经丢了。

IR 层没有这个问题：`IR_PUSH_INT` 与 `IR_BINARY` 的相邻关系是确定的，而且 `-fopt-divconst`
已经先用过这个手法（`divconst_live` / `skip`），口径可以照抄。

## 2. 两种形状

在主发射循环里，遇到 `IR_PUSH_INT` 时先看后面：

| 形状 | IR 序列 | 折叠成 |
| --- | --- | --- |
| **右常量** | `PUSH k` / `BINARY` | `POP r0` / `<OP> r0, r0, #k` |
| **左常量** | `PUSH k` / `<一个字的 push>` / `BINARY` | 同上（`k` 实际在左边，所以只对**可交换**运算符放宽） |

左常量那条额外要求中间那条指令**确实压进一个字**（`ir_pushes_one_word()`：
`IR_PUSH_INT` / `IR_PUSH_ADDR` / `IR_PUSH_GLOBAL_ADDR`，以及宽度小于一个字
（`<8` 位）的局部变量与全局变量）。宽度记录查不到就一律不折——「宁可漏、不可错」。

命中后主循环 `continue` 跳过那次 push，并记下 `imm_live`；等到真正的 `IR_BINARY`
到来时走同一条立即数路径：

```c
case IR_BINARY:
    if (imm_live) {
        imm_live = 0;
        emit_pop_r0(&buf);                    /* 只剩一个真实操作数在栈上 */
        emit_binary_imm(&buf, imm_op, imm_val, imm_left, 1);
        emit_push_r0(&buf);
        break;
    }
```

**判定与发射是同一个函数**：`emit_binary_imm(..., emit = 0)` 只回答「能不能折」，
`emit = 1` 才发射。这样「吞了 push 但发不出立即数」在结构上不可能发生，
`; imm fold inconsistent` 那条兜底分支在实践中不可达（门禁第 5 组专门验它不出现）。

## 3. 每个算子的编码守卫

指令的立即数字段各不相同，写错一条就等于「把合法 C 程序变成汇编错误」。所以
每个算子都先过编码闸门，再决定折：

| 算子 | 折叠条件 | 发射 |
| --- | --- | --- |
| `+` | `k` 在 `0..4095` | `ADD r0, r0, #k`（ADDW） |
| `+` | `k` 在 `−4095..−1` | `SUB r0, r0, #−k`（`a + (−k)` 就是 `a − k`） |
| `−` | `k` 在 `0..4095` | `SUB r0, r0, #k` |
| `−` | `k` 在 `−4095..−1` | `ADD r0, r0, #−k` |
| `&` `\|` `^` | `k ≥ 0` **且** `thumb_imm12_a(k)` 通过 | `AND/ORR/EOR r0, r0, #k`（modified immediate） |
| `<<` | `0..31` | `LSL r0, r0, #k` |
| `>>` | `0..31` | `LSR`（无符号）/ `ASR`（有符号） |
| `==` `!=` `<` `>` `<=` `>=` | 仅右常量；`k ≥ 0` 且（`k ≤ 255` 或 `thumb_imm12_a(k)`） | `CMP r0, #k` + 原样的 `emit_cmp_result()` |

`ADD/SUB` 的 4095 上限不是保守估计而是硬边界：12 位无符号立即数，`SUB #4096` 汇编器
不会接受。`AND/ORR/EOR` 走「modified immediate」（8 位值 + 循环右移偶数位），
所以 `0xFF000000` 能折而 `0x12345678` 不能——这正是 `--reloc-data` 之外最容易
写错的一处。

比较之所以要**单独再收一道** `k ≤ 255 || thumb_imm12_a(k)`：`CMP` 的 16 位形只吃
`0..255`，更大的值要么落进 32 位的 modified immediate，要么根本不存在编码。
（`CMP #256` 就不存在。）比较还额外**排除左常量**——比较不可交换，
`16 < a` 不能发成 `CMP a, #16`。

## 4. 拒绝清单

以下一律保持原样（push 与寄存器形都不动）：

- `*` `/` `%`：没有立即数形（`MUL` 的立即数必须已经在寄存器里；除法走 `-fopt-divconst`，
  那是另一套魔数法，见 `docs/DIVCONST.md`）；
- 浮点：`VADD` 之类不吃整数立即数；
- `k` 装不进对应字段（`ADD #4096`、`AND #0x12345678`、`SHL #32`）；
- 左常量的比较与非交换运算；
- 中间那条 push 不是「一个字」或宽度未知；
- `--reg-top` 打开时整块跳过（§5）。

## 5. 与 `--reg-top` 互斥

`--reg-top` 是另一套「值栈顶常驻寄存器」的建模，它自己也在配 `PUSH`/`BINARY`。
两条路径同时生效会把**同一个值跳过两次**，于是栈深错位——那种错误不会报错，
只会让程序算错。所以这一块的入口条件是 `!ark_top_enabled()`：

```c
if (g_config.enable_opt_imm && !ark_top_enabled() && !imm_live && I->op == IR_PUSH_INT)
```

门禁第 6 组专门把两个开关一起打开，断言编译通过且答案正确（`--reg-top` 单独
本来就覆盖了大部分收益，两者叠加没有额外损失）。

## 6. 实测

语料：`examples/ark_test/Core/Src/*.c` + `Drivers/STM32F4xx_HAL_Driver/Src/*.c`，
共 96 个 TU（其中 3 个 `*_template.c` 三个编译器都产出空代码，对称跳过 → 93 个有效）。
口径：`-O2 -mcpu Cortex-M4`，基线另加 `-fopt-vstack -fopt-addr -fopt-strength
-fopt-cbz -fopt-branch`；条数是 `.s` 里非指示、非标签的行数。

| 构建 | 指令数 | 相对基线 |
| --- | --- | --- |
| 基线（五个 pass） | 35,211 | 1.000× |
| 基线 + `-fopt-peep` | 33,730 | 0.958×（−1,481，−4.21%） |
| 基线 + `-fopt-imm` | **27,716** | 0.787×（**−7,495**） |
| 基线 + `-fopt-imm -fopt-peep` | **26,316** | 0.747×（**−8,895，−25.26%**） |

单独 `-fopt-imm` 一项就是 **−21.3%**——这是 0.9.1 六块优化里最大的一笔，比
`-fopt-vstack` 的 −20.0% 还大一点。两块一起开是 −25.26%，
比两者相加少 81 条（`-fopt-peep` 能吃的那些相邻 `PUSH/POP`，有一部分已经被
`-fopt-imm` 连常量一起消掉了）。

## 7. 门禁说了什么

`make test-imm`（`tests/run_imm_tests.py`）跑两份夹具 × 六个臂，共 33 项全 ok：

- `FOLD`：`f_add/f_sub/f_and/f_or/f_xor/f_shl/f_shr/f_lt/f_eq`，`main` 返回 125；
- `REJECT`：`r_and 0x12345678`、`r_add 70000`、`r_mul 5`、`r_div 3`（全部必须**不折**），
  `main` 返回 245。

六组断言：

1. **OFF IS OFF**：`-O2` 与 `-O2 -fno-opt-imm` 的镜像逐字节相同。
2. **九条 immediate 真的出现**：`ADD r0, r0, #16`、`SUB r0, r0, #7`、`AND/ORR/EOR`、
   `LSL/LSR`、`CMP r0, #5` 逐条 grep 命中。
3. **每条对应的 `MOV r0, #k` 消失**：只断言「立即数出现了」会漏掉「立即数出现了但
   常量也还压栈」的半折叠——那种错在汇编期不报，只在运行时算错。
4. **语义**：`off / on / vstack / imm` 四臂与 Python 参考值一致（两份夹具、每组四臂）。
5. **拒绝路径逐字节不变**：`REJECT` 在 `off` 与 `on` 下镜像相同，且全文没有
   `; imm fold inconsistent`。
6. **`--reg-top` 组合**：一起打开时编译通过、答案正确、无兜底标记；**裁切构建**
   按名字拒绝 `-fopt-imm`（`C3900U`，退出码 1），不带旗标仍能编译。

另有一遍全语料执行等价：`run_arm_exec.py --extra=-fopt-imm`（外加其它六个开关），
0 failure。

## 8. 裁切

`include/arkcc_config.h` 的 `ARKCC_FEATURE_OPT_IMM`：`ARKCC_PROFILE_STM32_MIN` 下为 0，
宿主 / 交叉为 1。为 0 时 `emit_binary_imm()` 与「吞常量」块整段被预处理掉，
`src/main.c` 以 `C3900U: -fopt-imm is not compiled into this build` 拒绝该旗标
（拒绝而非静默忽略）。

运行期默认**关**（`g_config.enable_opt_imm = 0`），所以不加旗标的产物与 0.9.0
逐字节相同（192 个输出的 OFF-IS-OFF 比对，`bad 0`）。

## 9. 位置：发射期，不是 pass

```
IR 主循环（发射期）
  ├─ -fopt-imm：吞掉常量 push，按立即数形发射
  └─ 每个函数发射完毕
       ├─ -fopt-vstack
       ├─ -fopt-addr
       ├─ -fopt-cbz
       ├─ -fopt-peep
       └─ -fopt-regalloc
```

把它放发射期的另一个好处是**后面的 pass 看见的是更短的文本**：常量 push 消失之后，
`-fopt-vstack` 的池压力、`-fopt-peep` 的相邻对统计、`-fopt-regalloc` 的槽热度
都在更接近真实的指令流上计算。

## 10. 明确没做

| 没做 | 原因 |
| --- | --- |
| 常量与常量先算（`k1 op k2` 折叠成 `k`） | 这是另一件事（常量折叠），`src/opt.c` 在 IR 之前已经做过一部分；这里只处理「一个常量 + 一个运行时值」 |
| 把 `MOV r0, #k` 与随后的 `CMP`/`ADD` 在文本层合并 | 文本层分不清「这个常量寄存器是谁的」，见 §1 |
| `SUB` 的反向形（`k − a` → `RSB r0, r0, #k`） | `RSB` 立即数形存在、收益同样是少一次 push，但要多一条编码路径与一个门禁；先记在这里 |
| `LDR r0, =k` 大常量的字面池化 | `MOVW/MOVT` 已经由汇编器处理，字面池是另一条路（`--literal-pool`） |

## 11. 已知代价

- 代码体积与指令数的收益都是**实测**，没有做「每处省几条」的逐站点归因；
- 与 `--reg-top` 不能组合（§5），这是一个真实的表达能力损失，只是两条路径各自
  都已经覆盖了主要收益；
- 立即数守卫是按**内建汇编器的实际编码能力**写的，不是按 ARM 手册的一般规则写的：
  `ADD #4095` 靠 `ADDW`，`AND` 靠 modified immediate。将来若给汇编器加了新的立即数
  形（例如 `SUB.W #4095` 之外的形状），这里的守卫要同步放宽，否则只是漏折。