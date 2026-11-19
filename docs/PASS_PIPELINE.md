# 可配置 Pass 管线（`--pipeline`）

[English](PASS_PIPELINE.en.md) | 中文

Ark C 同时以两种形态交付：**桌面端完全体**（`arkcc.exe` / `arkcc`，Windows 与 Linux）
和 **MCU 裁切端**（`ARKCC_PROFILE_STM32_MIN`，跑在 STM32H743 上自举）。
两边共用一份源码、一套后端、一份对象格式，差别只在"这次能跑多少活"。

`src/pipeline.c` 就是那一句话的实现：**阶段表声明一次，一个循环执行它们，
每个被跳过的阶段都留下理由。**

```c
/* 0.8.4 及之前：决策散在 opt_run() 的 #if / if 阶梯 + 每个调用点 */
/* 0.8.5 起：一张表 */
static const IrStage g_ir_stages[] = {
    { "ir.constfold", ARK_PROFILE_LITE, 1, GATE_FLAG_AND_LEVEL, ... opt_constfold_func, 0 },
    { "ir.dce",       ARK_PROFILE_LITE, 1, GATE_FLAG_AND_LEVEL, ... opt_dce_func,       0 },
    { "ir.dce-cfg",   ARK_PROFILE_FULL, 1, GATE_FLAG_AND_LEVEL, ... opt_dce_cfg_func,   0 },
    { "ir.inline",    ARK_PROFILE_FULL, 2, GATE_FLAG_AND_LEVEL, ... 0,            opt_inline },
    { "ir.vectorize", ARK_PROFILE_FULL, 2, GATE_FLAG_OR_LEVEL,  ... 0,       opt_vectorize },
};
```

## 1. 两个剖面，不是两份代码

| 剖面 | 写法 | 含义 |
| --- | --- | --- |
| `full` | `--pipeline=full` 或**不写**（默认） | 每个阶段仍由**自己的**开关与 `-O` 级别决定，即 0.8.4 的历史行为 |
| `lite` | `--pipeline=lite` | 只有 `min_profile = lite` 的阶段允许跑，其余被跳过并留下理由 |

关键点是 **`--pipeline=full` 与不写这个选项逐字节相同**：剖面只是"上界"，
它不替代阶段自己的门槛。`--pipeline=lite` 不会把 `-O2` 变成 `-O0`，
它只把贵的阶段拿掉（目前是 `ir.dce-cfg` / `ir.inline` / `ir.vectorize`）。

配置文件里同样可以写（`arkcc.cfg` 的 `[opt]` 段）：

```ini
pipeline = full
```

非法值不静默回退：`pipeline = lti` 报一条 warning 并**保留原值**，
命令行上的 `--pipeline=lti` 则直接以 `C3900U` 报错退出（命令行没有"原值"可保留，
猜一个等于替用户决定）。

## 2. 阶段表：顺序即执行顺序

| 顺序 | 阶段 | 剖面 | 门槛 | 为什么在这个位置 |
| --- | --- | --- | --- | --- |
| 1 | `ast.memlint` | lite | `--warn-mem` | AST lint，无 `-O` 门；放在 enumcheck 前只为让诊断顺序可复现 |
| 2 | `ast.enumcheck` | lite | `--warn-enum` | 同上，两条 lint 之间无交互 |
| 3 | `ir.constfold` | lite | `-O1` 且开关 | 折叠先做，DCE 才能吃掉折叠之后才暴露的死代码 |
| 4 | `ir.dce` | lite | `-O1` 且开关 | 廉价规则先清掉显眼的部分，CFG 可达性只需走剩下的 |
| 5 | `ir.dce-cfg` | full | `-O1` 且 `--dce-cfg` | 建可达性图，比线性规则贵得多 |
| 6 | `ir.inline` | full | `-O2` 且开关 | 内联之后紧接一遍线性 DCE 清扫（见下） |
| 7 | `ir.vectorize` | full | `-O2` **或**开关 | 内联把 `a[i]=b[i]+c[i]` 展开到能识别的形状，所以排在最后 |

`ir.inline` 的 `cleanup_dce` 标志是**刻意绕开 `-fno-opt-dce`** 的：展开会把被调方的
死尾巴留在调用点，而那是内联自己造出来的垃圾；如果这遍清扫还要看
`enable_opt_dce`，`-fno-opt-dce -O2` 就会把内联生成的死指令留在镜像里。

## 3. 门槛只有三种形状

`GATE_FLAG_AND_LEVEL`（默认）、`GATE_FLAG_OR_LEVEL`（只有 `ir.vectorize` 用），
以及 AST 阶段的 `FLAG_ONLY`（表里表现为 `min_level = 0`）。

这三种不是设计，是**每个 pass 一直以来的实际行为被写下来**。改动其中任何一个都会
改变生成代码，所以它们冻结在表里并被门禁覆盖：

- `constfold` / `dce` 在 `-O0` 不跑：折叠会改 `-O0` 的预期（`1+2` 变 `3`），
  还可能把 `1/0`、`1<<40` 这类未定义表达式折成一个"更具体的错答案"。
- `vectorize` 用 OR 门：`--vectorize` 是显式请求，`-O2` 是默认开启；两者任一成立即跑。
  代价是**宿主 `-O0` 也会跑**（见 §7 已知局限）。
- `inline` 的 `-O2` 是硬门槛：展开假设参数在栈槽里，而 ARM 后端只在 `-O2` 路径上保证这点。

## 4. 读决策：`--print-pipeline`

```
$ arkcc --print-pipeline -O2 examples/hello.c -o nul
[arkcc] pipeline:
  profile=full  level=-O2
  skip  ast.memlint  off (--warn-mem)
  skip  ast.enumcheck  off (--warn-enum)
  run   ir.constfold
  run   ir.dce
  skip  ir.dce-cfg  off (--dce-cfg)
  run   ir.inline
  run   ir.vectorize

$ arkcc --print-pipeline --pipeline=lite -O2 examples/hello.c -o nul
[arkcc] pipeline:
  profile=lite  level=-O2
  skip  ir.dce-cfg  skipped by --pipeline=lite
  skip  ir.inline  skipped by --pipeline=lite
  skip  ir.vectorize  skipped by --pipeline=lite

$ arkcc --print-pipeline examples/hello.c -o nul          # -O0
  skip  ir.constfold  needs a higher -O level
  skip  ir.dce  needs a higher -O level
  ...
  run   ir.vectorize
```

三条硬约定：

1. **每一行都是决策，不是"大概"**。跳过必须给理由，理由必须是**实际失败的**
   那一条门槛（`off (-fno-opt-dce)` 不会写成 `needs a higher -O level`）。
2. **剪裁掉的阶段也占一行**：`not compiled into this build`。它和"开关关着"是两件事，
   混在一起读就会把"这份二进制没有这个 pass"说成"用户关了它"。
3. **格式无填充、无括号**：理由字符串本身就是句子，门禁按空白切分这一行。

## 5. 顺带修掉的缺陷：两个开关曾经完全无效

`-fno-opt-constfold` 与 `-fno-opt-dce` 在 0.8.4 及之前**被接受但不起作用**——
旧的 `opt_run()` 只看 `-O` 级别，根本没读这两个开关。行为是"接受一个选项、
悄悄不照办"，正是这个项目最不能接受的那类回答。

新表把两个阶段的门写成 `GATE_FLAG_AND_LEVEL`，开关从此真的生效；
默认 `flag = 1`，所以**不写这些选项时产物与 0.8.4 逐字节相同**（§8 有读数）。

## 6. 裁减：`ARKCC_FEATURE_PIPELINE_DUMP`

阶段表和执行循环**永远编入**——`pipeline.c` 是驱动，不是可选 pass。可裁的只有
"人能读的那一半"：阶段名与理由字符串。

```c
#if ARKCC_FEATURE_PIPELINE_DUMP
#  define PIPE_NAME(s) (s)
#else
#  define PIPE_NAME(s) ""
#endif
```

`ARKCC_PROFILE_STM32_MIN` 档默认 `0`。此时 `--print-pipeline` 以 `C3900U` 拒绝并给出
重建方法，而不是打印一张空表——空表会被读成"什么都不跑"，那是错答案。

实测（`-target arm -c --reloc-data`，同一份 `src/pipeline.c`）：

| 配置 | 对象大小 |
| --- | --- |
| 默认（字符串与两条 lint 都编入） | 8,342 B |
| `-DARKCC_FEATURE_PIPELINE_DUMP=0` | 7,096 B |
| `-DARKCC_FEATURE_MEMLINT=0 -DARKCC_FEATURE_ENUMCHECK=0`（字符串仍在） | 7,830 B |
| 三者全裁 | 6,616 B |
| 宿主 x86-64 默认 | 9,135 B |

即：**dump 字符串占 1,246 B**（8,342 → 7,096），MCU 档裁掉的正是这一块；
两条 lint 的表与调用再占 512 B（8,342 → 7,830）。

## 7. 已知局限（写在这里，不留给读者猜）

- **`ir.vectorize` 在宿主 `-O0` 也跑**。OR 门 = 历史行为，改它会动 `-O0` 的产物，
  所以这一版保持原样并如实登记。
- **`lite` 不等于 `-O0`**。`lite` 是"阶段上界"，`-O0` 是"级别门槛"，两者独立；
  `--pipeline=lite -O2` 仍然跑 `constfold` 与 `dce`。
- **没有 `none` 剖面**，刻意的：全部关掉就是 `-O0` 且不开 lint 开关，再造一个拼写
  等于给同一个镜像两条生成路径。
- **管线不改变语义**。这一版是调度重构：谁跑、按什么顺序跑，与 0.8.4 完全一致
  （§8）；新增能力只有"能读、能裁、能选 lite"。

## 8. 零变化：把口号换成读数

```
$ bash cmp_old_new.sh          # 0.8.4 的 arkcc vs 本版
compared=480 diffs=0
```

口径：`examples/*.c` × `-O0/-O1/-O2` × `arm/x86-64`，全部 `-S`，**汇编文本逐字节**
比较（同时比较退出码）；`480 = 80 个 examples 源文件 × 3 个级别 × 2 个目标`。
默认剖面下 480 份产物完全一致。

再加一条更重的：自举门禁（27 个自源 TU → 平铺镜像 → unicorn 上跑自举编译器 →
与宿主对象**逐字节**比较）在本版仍然 PASS，`fnv=28c333dc`、2,130 B，
与 0.8.4 的基准值完全相同。

## 9. 门禁：`tests/run_pipeline_tests.py`

```
make test-pipeline
python tests/run_pipeline_tests.py --arkcc ./arkcc.exe
```

27 条断言，分四类：

| 类 | 在验什么 |
| --- | --- |
| 文本 | `--print-pipeline` 的每一行（run/skip + 理由）在 `-O0/-O1/-O2`、`full/lite`、各 lint 开关组合下都正确 |
| 效果 | `-O2` 与 `-O2 --pipeline=lite` 的产物**必须不同**（内联真的被拿掉了），并且 `lite` 等于 `full` 去掉内联阶段 |
| 拒答 | `--pipeline=lti` 以 `C3900U` 失败、**不留输出文件**；`--print-pipeline` 同样拒答 |
| ini | 配置文件里的 `pipeline=lite` 生效；非法值报 warning 且保留原值；`ARKCC_FEATURE_PIPELINE_DUMP=0` 重建后 `--print-pipeline` 拒答、编译照常、`--pipeline` 循环仍在 |

最后一条是**防假绿**：如果"拒答"只是碰巧因为别的错误而失败，那这条门禁什么都没证明。
所以拒答用例同时检查退出码、错误码文本（`C3900U`）和"输出文件不存在"。
