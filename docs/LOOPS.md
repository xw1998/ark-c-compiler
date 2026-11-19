# 循环优化（`--licm` / `--unroll`）

[English](LOOPS.en.md) | 中文

0.8.6 给中端加了两个**循环级**变换：循环不变量外提（LICM）与计数循环完全展开。
它们和 0.8.6 的三条跨函数检查共用同一份图基底（[MIR_CFG.md](MIR_CFG.md) 里的
`MirFunc` / `MirLoop`），但与前三条不同——**这两条真的改 IR**。

| 开关 | 默认 | 剖面 | 最小 `-O` |
| --- | :---: | --- | :---: |
| `--licm` / `--no-licm` | 关 | `full`（MCU 最小剖面不含） | 1 |
| `--unroll` / `--no-unroll` | 关 | `full`（MCU 最小剖面不含） | 1 |
| `[features]` 节 `licm` / `unroll` | `0` | 配置文件等效写法 | — |
| `ARKCC_FEATURE_LICM` / `ARKCC_FEATURE_UNROLL` | 宿主 `1`，`ARKCC_PROFILE_STM32_MIN` 或 `ARKCC_FEATURE_MIR=0` 时为 `0` | 裁剪开关 | — |

两条都遵守项目一直用的那条规则：**形状没有被证明安全，就原样不动**。没有
"拿不准也先改"的路径，因此两条都不会悄悄改变程序答案。

## 1. LICM：搬计算，不搬 store

### 1.1 为什么不是教科书形态

IR 是栈机：一个值只在"被压栈"到"被下一条指令消费"之间存在。循环回边不携带
任何栈槽，所以"算出来留在寄存器里"的经典写法在这里无处落脚。

于是做的是**把计算搬进编译器临时量、把 store 留在原地**：

```
preheader:   t  = x * y            (新)
loop body:   s  = t                (原来是 s = x * y)
```

临时量在帧里占一个 8 字节槽（`local_size` 向上取 8 对齐后追加），每次循环体只是
一条 `PUSH_VAR t; STORE s`。

### 1.2 零次迭代是硬约束

**只搬计算、不搬 store** 是为了让"循环一次都不进"的情形保持语义：如果整体搬走，
一个 `while (0) { s = 1/1; }` 会把 `s` 写成 1，而这行代码根本没执行。现在的形态
在零次迭代时只写临时量（本来就不存在），`s` 一个字节都不动。门禁用
`licm_case(0, 3, 5) * 1000 + licm_case(4, 3, 5) == 75` 把这条钉住：若临时量真的
漏写进 `s`，返回值会变成 1000+ 量级。

### 1.3 什么可以搬（白名单）

| 指令 | 栈效应 | 备注 |
| --- | :---: | --- |
| `IR_PUSH_INT` / `IR_PUSH_VAR` / `IR_PUSH_GLOBAL` | +1 | 只认名字明确的局部量/全局量 |
| `IR_BINARY` | −1 | **排除 `/` 与 `%`** |
| `IR_UNARY` | 0 | 取负、按位取反等 |
| `IR_DUP` / `IR_SWAP` / `IR_NOP` | +1 / 0 / 0 | |

白名单之外一律不搬，具体几条是刻意的：

- **除法与取模排除**：它们可能陷入（除零）。把可能陷阱的运算提到"本来不执行"
  的位置，等于凭空给程序加一个故障；
- **volatile / `IR_AUX_COMPLEX` / `IR_AUX_SLOT64` / 8 字节 push 排除**：字宽是
  ABI 相关的，数错一个字节就会让求值栈失衡，而栈失衡是静默错答案；
- **一切通过指针的访存（`IR_LOAD_IDX` / `IR_LOAD_FLD` / `IR_PUSH_ADDR` …）排除**：
  需要别名分析，这一层没有。有一条候选里出现这类指令，整段候选作废。

### 1.4 什么算不变量

局部量 `off` 是不变量，当且仅当：

1. **整个函数里没有 `IR_PUSH_ADDR` 取过该 offset**（地址一旦外流，交给被调函数
   就可能被写，"循环里没有直接 store"就不构成证明）；
2. 循环内没有对该 offset 的 `IR_STORE`。

全局量 `name` 是不变量，当且仅当：

1. 循环内没有 `IR_CALL` / `IR_ASM` / `IR_MEMCPY` / `IR_STORE_IDX` /
   `IR_STORE_FLD` / `IR_STORE_GLOBAL` / `IR_ALLOCA` / `IR_SMC`
   （任何能间接写到它的东西）；
2. 循环内没有同名 `IR_STORE_GLOBAL`。

### 1.5 候选段与终止性

候选段长度必须 **≥ 3 条指令**。两条的候选恰好是 `push x; store y`（纯拷贝），
搬它没有任何收益；而且拒绝它同时让 pass 终止——替换后留下的
`PUSH_VAR t; STORE s` 正好是 2 条，永远不会再次成为候选。

### 1.6 内层优先 + 每轮重建

`opt_licm_func` 每轮都重新 `mir_build` + `mir_loops`，按 `nblocks` 升序取内层
循环、只外提一段后重建。嵌套循环因此是"先把内层的提到内层 preheader，下一轮
外层再接着提"，不需要一次性处理多段搬迁的索引冲突。

## 2. UNROLL：只做完全展开，只认一种形状

接受且只接受 irgen 为下面这种循环发射的形状，常量起止，步长 1：

```c
for (i = c; i < N; i++) body;        /* c, N 整型常量 */
```

对应的 IR 四块：

```
B0  LABEL start ; PUSH_VAR i ; PUSH_INT N ; BINARY(<) ; JZ end
B1  <body：直线，无标签、无跳转、无 return>
B2  LABEL cont  ; [PUSH_VAR i] ; PUSH_VAR i ; PUSH_INT 1 ; BINARY(+)
                ; STORE i ; [POP] ; JMP start
B3  LABEL end   ; ...
```

（B2 的方括号是 `i++` 作为表达式被丢弃时 irgen 额外留下的"旧值 + POP"，
接受但不要求。）

必须同时满足，否则循环原样不动：

- 三块就是整个循环（B1 唯一后继是 B2，B2 唯一后继是 B0），头块判据是 `i < N`；
- `start` / `end` 只被这两条跳转引用——有 `break` / `continue` / `goto` 一律拒绝
  （`break` 会跳到某一份副本的中间，改写模型不覆盖这种形态）；
- `i` 在全函数只有两处 store：循环外的 `i = c`（其所在块必须支配头块）与 latch；
  地址从未被取（副本用常量替换归纳变量）；
- `1 <= N - c <= ARK_UNROLL_MAX`（默认 8），且 body 长度不超过
  `ARK_UNROLL_MAX_BODY`（默认 64 条 IR）；
- body 里没有 inline asm、没有 `alloca`、没有自修改代码标记。

改写：把 B0..B2 换成 `N-c` 份 body，每份前面 `i = c+k`（body 内的 `PUSH_VAR i`
换成 `PUSH_INT c+k`），最后补一条 `i = c+N`，让循环退出时 `i` 的值与未展开时
一致。B3 及其后原样保留，因此头块与回边的标签一起消失。

两个上限都可以在编译时覆盖：

```
-DARK_UNROLL_MAX=16 -DARK_UNROLL_MAX_BODY=128
```

`ARKCC_PROFILE_STM32_MIN` 下两个 pass 连代码都不编进去：给出 `--licm` /
`--unroll` 会以 `C3900U` 拒绝并点名缺的宏，`--no-` 形式永远接受。

## 3. 门禁

`tests/run_loop_tests.py`（`make test-loop`），29 项检查：

| 组 | 检查 |
| --- | --- |
| 1 | `--licm` 真的改了代码；乘法既没被删也没被复制（前后计数相等） |
| 2 | 三种不安全形状（取址 / 循环内写操作数 / 除法）汇编**逐字相同** |
| 3 | `--unroll` 把 body 复制 4 份（`MUL` 1 → 4）；头块与回边标签消失 |
| 4 | `break` 与超上限的循环汇编逐字相同 |
| 5 | emulator 执行 8 个用例，开关前后返回值相同（75 / 18 / 0 / 0 / 3 / 198） |
| 6 | 默认关与 `--no-` 回退产出的 `.o` **逐字节相同** |
| 7 | 无 `-O` 时 dump 明确写 `needs a higher -O level`；`--print-pipeline` 列出两个阶段；被跳过的阶段点名开它的开关 |
| 8 | 裁剪构建（`-DARKCC_FEATURE_LICM=0 -DARKCC_FEATURE_UNROLL=0`）拒绝并点名宏，同一文件正常编译仍成功 |
| 9 | `arkcc.cfg` 的 `licm=1` / `unroll=1` 同样生效 |

第 3 组的"头块标签消失"不是装饰：它把"真的展开了"与"复制了一份但还留着循环"
区分开。第 5 组里 `licm_taken` / `licm_div` / `unroll_break` / `unroll_big` 四个用例
是**反假通过**：它们要求"这条优化没生效"，若哪天实现变宽松，返回值会变。

## 4. 已知局限

- 没有别名分析：任何指针访存都终止 LICM 候选，因此 `p[i]` 这类访问不会被外提；
- LICM 只搬算术，不搬 load（`IR_PUSH_GLOBAL` 除外）——真机上"循环内不变量加载"
  仍然每次重新读内存；
- UNROLL 只处理单层、规范、常量边界的 `for`；`while`、`do-while`、步长非 1、
  上界非常量一律不动（不是漏做，是拒绝）；
- 两条 pass 都不做寄存器分配层面的收益评估：`--unroll` 会让代码体积按 trip count
  线性增长，在小 flash 的目标上应自行衡量。
