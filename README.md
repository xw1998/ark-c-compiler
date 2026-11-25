# Ark C 编译器

[English](README.en.md) | 中文

一个多目标 C99 编译器（另有 C11 的 `_Static_assert` / `_Alignof` / `_Alignas` / `_Generic` / `_Thread_local` / `_Atomic`，见[下文](#c11-关键字子集)），可在 Windows / Linux / macOS 上用 gcc 构建运行，
也可**原生自托管**于 STM32（Cortex-M7）：从外部 SPI Flash 读取 `.c` 文件就地编译，
**并在同一颗芯片上把它跑起来**（2026-11-05 首次端到端跑通，见[里程碑](#里程碑在-stm32-上编译在-stm32-上跑)与
[`examples/stm32_selfhost_build/`](examples/stm32_selfhost_build/)）。
覆盖 98% 以上的 ARM Compiler 5 (armcc) 常用扩展（仅缺 C++ 模式与高级优化）。
**STM32H743 + armcc5 工具链已打通完整构建流水线**：用 armcc5 编译 arkCC 源码可生成
可直接烧录的 `arkcc_stm32.hex/.bin`，目标板启动后从 W25Q Flash 读取 `.c` 源码就地编译执行。

## armcc5 完全兼容路线图

**目标**：在装有 armcc5 的电脑上，arkCC 完全兼容 armcc5，能不对 MDK 工程做任何改动编译出可执行文件，然后能在 STM32 上运行 arkCC，实现 STM32 上编译 STM32 的程序。

| 阶段 | 目标 | 状态 |
| --- | --- | :---: |
| 阶段 1 | arkCC 自身用 armcc5 编译为 STM32 固件 | ✅ 已完成 |
| 阶段 2 | STM32 板载 arkCC 能编译 `.c` 源码生成 `.bin` | ✅ 已完成 |
| 阶段 3a | 板载产物能在板上装载执行（RAM 池借块，`mini run`） | ✅ 已完成（2026-11-05） |
| 阶段 3b | 板载产物掉电保留（外部 QSPI NOR + littlefs） | ✅ 已完成 |
| 阶段 3c | 产物烧写回**内部 Flash** 并由引导跳转执行 | ✅ 已完成（2026-11-09，见 [docs/STM32_BUILD.md](docs/STM32_BUILD.md) §15） |
| 阶段 4 | 无需改动的 MDK 工程可被 arkCC 直接编译 | ✅ 已完成（`--uvprojx` 自动提取 include 路径和宏定义；预处理除零保护） |
| 阶段 5 | `__user_initial_stackheap`、HAL 重定向、scatter 链接完整支持 | ✅ 已完成（`__user_initial_stackheap` + `putchar`/`fputc` UART 重定向 + malloc/free + scatter 感知向量表生成） |


路线图各阶段的构建细节见 [docs/STM32_BUILD.md](docs/STM32_BUILD.md) 与 [docs/MANUAL.md](docs/MANUAL.md)。
想从零理解这套实现（而不是只想用），读 [docs/从零写一个C编译器.md](docs/从零写一个C编译器.md)——19 章教材体：每章有「本章目标 / 前置知识 / 正文 / 小结 / 习题」，书中全部汇编、字节、尺寸都是现场跑出来的，复现命令见后记。

## 里程碑：在 STM32 上编译、在 STM32 上跑

"板上一体化"这条线分五段。**2026-11-05 第一次走到第 ③④ 段的终点**，判据不是"编译
没有报错"，而是板上跑起来的程序自己从串口打出来的字。

| # | 里程碑 | 状态 | 板上读数 |
| --- | --- | :---: | --- |
| ① | arkcc 自身被编成 STM32 固件并运行 | ✅ | 见 [docs/STM32_BUILD.md](docs/STM32_BUILD.md) |
| ② | 板上把一份 `.c` 编成机器码（`.bin`） | ✅ | `cc hello.c` |
| ③ | **多份 `.c` → 一个可装载镜像 → 在板上执行** | ✅ 2026-11-05 | `make` 打出 `app.svcm` 4776 B；`mini run` 打出 `ARKMAKE: link ok` / `ARKMAKE: cross-file add3=6` |
| ④ | 产物掉电保留（外部 QSPI NOR + littlefs） | ✅ | 产物在 `/mnt/nor`，复位后仍在，可直接 `mini run` |
| ⑤ | 产物烧写回**内部 Flash** 并由引导跳转执行 | ✅ 2026-11-09 | `app flash write /tmp/m5.bin` → 1452 B / crc `0x612B4A1E` 落到 `0x081E0000` 并回读逐字节通过；`app flash run` 打出 `M5 alive in flash`，日志入口 `0x081E0424` 就在 Flash 区内；**复位后** `/tmp` 已清空、同一份仍能跑（掉电不丢的判据） |

第 ③ 段值得单列，因为它一次性排除了三类**看起来成功**的失败：

- **链接时把另一个编译单元丢了**——镜像照样链接成功，只是少了那个 TU。判据是
  跨 TU 调用真的返回了结果（`add3(1,2,3)==6`），而不是"编过了"。
- **对象被链接器搬了位置**——arkcc 在 codegen 期把绝对地址烤进指令
  （`movw/movt` 成对、literal slot），对象里只有外部符号是重定位。按旧做法
  "前置 0x400 向量表再把整镜像右移"，实测结果是字符串指针偏低 0x400：**装载成功、
  一个字都打不出来、立刻退出**。现在改成"第一个对象预留空洞、`-link` 只填表、
  永不位移"。
- **四遍差分的前提不成立**——如果链接结果依赖基址，四份镜像的字节差就不是"地址
  造成的位移"，差分表会把优化差异当成地址补掉。判据是四遍尺寸逐字节相同
  （`A/B/C/D` 四行同值）。

最小可复现例子在 [`examples/stm32_selfhost_build/`](examples/stm32_selfhost_build/)：
两份源 + 一份工程描述 + 一条 `make` + 一条 `mini run`，附五条判据与"已知限制"
（4 源上限、池预算、耗时不稳定）。工程描述这一层由
[`ark_make`](https://gitee.com/xw19981010/ark_make) 提供，`make` 的打包回调就是
`cc --pack` 的本体——镜像只允许有一种生成方式，否则"在板上验证过的"和"make 打出来的"
迟早分家。


## 功能特性 (v0.8.3)

### C99 标准语言特性

| 方面 | 支持 | 说明 |
| --- | :---: | --- |
| 基本类型 | 是 | `void/char/short/int/long/long long/_Bool/float/double` + `signed/unsigned` |
| 指针与数组 | 是 | 一维/多维数组、指针、函数指针、数组退化；数组维度支持常量表达式 `int arr[SIZE+2]` |
| 变长数组 (VLA) | 是 | `int a[n]` 运行时变长数组，通过 `IR_ALLOCA` 在栈上分配；向上取整对齐：ARM / x86_64 取 8、RV32I 取 16（psABI 要求每次调用前 sp 16 对齐），RV32I 的尾声在函数含 `IR_ALLOCA` 时先用 `sub sp, s0, frame` 重建 sp 再弹帧——否则 `return` 从错位的地方读 `ra/s0` |
| 复合类型 | 是 | `struct`/`union`/`enum`/`typedef`、位域（真正按位打包）、灵活数组成员 `data[]`、匿名 struct/union 字段提升 |
| 复数类型 | 是 | `_Complex double`/`_Complex float`：运算、实参、返回值、隐式转换、静态初值全通；16 字节的 `_Complex double` 返回在 ARM 用 r0-r3、RV32I 用 a0-a3（软浮点 AAPCS，**不走 sret**，与 gcc 被调方互操作），x86 后端明确拒绝、穿过 `...` 也明确拒绝。细节见 `docs/MANUAL.md` §4.10 |
| 宽字符 | 是 | `wchar_t` + `L"..."` 宽字符串 + `L'...'` 宽字符字面量；通过 `--wchar16`/`--wchar32` 切换宽度 |
| 三字符组 | 是 | 全部 9 个 C99 三字符组（`??=`->`#`、`??(`->`[`、`??/`->`\`、`??)`->`]`、`??'`->`^`、`??<`->`{`、`??>`->`}`、`??!`->`|`、`??-`->`~`） |
| 限定符 | 是 | `const/volatile/restrict/inline` |
| 存储类 | 是 | `static/extern/auto/register`；`static` 在函数内持久化；`__thread`（armcc）/ `_Thread_local`（C11）线程局部存储 |
| 控制流 | 是 | `if/else/while/for/do-while/switch/case/default/break/continue/goto/label/return` |
| 运算符 | 是 | 全部 C99 运算符（算术/比较/逻辑短路/位运算/移位/复合赋值/三目/逗号/sizeof/强制转换） |
| 函数 | 是 | 多参数（>4 个走栈；标量、64 位与结构体参数按 AAPCS32 分配：偶数寄存器对、栈上 8 字节对齐、按实际传输字数编号）、原型检查、变参 `...`（四个后端都支持；ARM / RV32I 用 4 字节字槽、C / x86_64 用 8 字节槽位，见 §后端支持与 `examples/run_va_gate.py`）、递归、多文件独立编译+链接 |
| 字面量 | 是 | 整数（十/八/十六进制+后缀）、字符+转义、字符串拼接、浮点 |
| 浮点 | 是 | `float/double` 算术/比较/转换；ARM 后端支持硬件 FPU（VFP `VADD/VMUL/VCVT/VCMP`）或 `__aeabi_f*`/`__aeabi_d*` 软浮桩，`double` 为真 64 位精度 |
| 64 位整数 | 是 | `long long` 全套：算术/比较/位运算/一元负号/`++`/`--`/复合赋值/移位（`__aeabi_l*` + `__aeabi_llsl/llsr/lasr` 桩）；移位与位运算按 C99 6.5.7 取**左**操作数宽度；`printf` 参数不截断；栈上 64 位参数按 AAPCS 低字在前、8 字节对齐 |
| 除法/取模 | 是 | 有符号/无符号 `__aeabi_idiv/uidiv/idivmod/uidivmod` |
| 隐式类型转换 | 是 | 完整的常规算术转换 + 整数提升 |
| 初始化 | 是 | 标量、聚合 `{1,2,3}`、嵌套 `{{1,2},{3,4}}`、指定初始化 `.x=1/[2]=5`、字符串 `char s[]="hi"`、全局非字面量初始化（常量表达式折叠） |
| 复合字面量 | 是 | `(int[]){1,2,3}` / `(struct P){.x=1,.y=2}` |
| 结构体按值传递 | 是 | 通过隐藏指针参数实现 |
| 寄存器分配 | 可选 | `-fopt-regalloc`（`ARKCC_FEATURE_OPT_REGALLOC`，宿主/交叉 1、板端 0，默认关）：发射后的文本遍把最热的帧槽搬进 `r8-r11`，只搬"每一处提及都是 `LDR r0,[r6,#n]` / `STR r0,[r6,#n]`"的槽；取地址、`volatile`、8 位/16 位/64 位访问一律留在内存。热点用例（`char pad[200]` 把后面的局部压过 offset 124）`[r6,#]` 引用 22→13，两个负例逐字节不变。两档成本模型：默认档只搬远槽且**函数永不增大**（H743 自举工程 25 个 `.c`：−2 398 B、−0.21%，无文件变大）；`-fopt-regalloc-near` / `--fregalloc-near`（隐含打开基础档）连近槽一起搬，栈访问从 27 372 降到 15 108，比默认档多 150 字节、14 个文件变大；**帧几何**：保存块是锚点——保存块变宽时 `[r6, #N]`（N ≥ 局部区上界）与 `MOVW/ADD r6` 的立即数要同步平移，且保存块必须保持 8 的倍数（奇数个自动补一个空闲 `r8-r11`，零字节代价），否则变参函数的 `r0-r3` 镜像与调用者栈参数会整体错位；五档开关（默认 / `-O2` / regalloc / `-O2+regalloc` / `-O2+regtop+inline+regalloc`）由 `examples/run_va_gate.py --opt-suite` 一次跑完 |
| 值栈 → 寄存器分配 | 可选 | `-fopt-vstack`（`ARKCC_FEATURE_OPT_VSTACK`，宿主 1、板端 0，默认关）：表达式求值的 `PUSH {r0}` / `POP {r0}` 改为留在 `r5`/`r7`（prologue 已保存 ⇒ 零帧变化），目的寄存器 retarget + 只读操作数文本替换，池槽引用计数、同行/跨操作数读写与 `ADC/SBC/MUL` 原地形先物化、`MOVW/MOVT` 永不 retarget；识别不了就整函数原样输出。边界（label/分支/调用）处若值已全部写回机器栈就继续往后优化（`cross` 预扫描 + 整段 verbatim）；`verbf` 现在只在「尾部无法建模」时永久生效（label 处与真正离开函数的 epilogue 之后会重置影子栈并继续优化）。池只有两槽，第三个值同时存活时才把 `r4` 加进来当第三槽（帧跟着涨一个字保住 8 字节对齐；深度到不了三的函数一律不动它，多存一个寄存器是净亏）；无参数无局部变量的函数没有帧（序言里没有 `SUB sp`），走另一条路：PUSH/POP 改五寄存器，并在 `MOV r6, sp` 之后补一条 `SUB sp, sp, #4`（收尾 `MOV sp, r6` 会把这点 padding 丢弃，所以不加 `ADD`、也不能把 `SUB` 放到 `MOV` 之前）。STM32F4 HAL 全语料（Cortex-M4，`-O2`）47,449 → 33,284 条（−29.85%，已含 r4 第三槽、逐块恢复与 256 层影子栈），叠 `-fopt-addr` 到 31,218 条；arith 夹具 170 → 120 条，镜像只减不增，`tests/arm_exec` 全语料 39 用例 0 失败。详见 `docs/RA_VSTACK.md` |
| 寻址折叠 | 可选 | `-fopt-addr`（`ARKCC_FEATURE_OPT_ADDR`，宿主 1、板端 0，默认关）：把 `ADD` / `MOV` 算出来的地址折进 `LDR/STR` 的寻址方式（常量偏移、寄存器索引两种），删掉多余的地址算术；死值分析保证被折寄存器在本函数内不再被读，屏障指令 `DMB/DSB/ISB` 放行；两种写回形实测从不发射故不实现。HAL 全语料（STM32F401xE，`-O2` 逐级累加，见 `docs/COMPARISON.md` §5；基线为已过 vstack（含 r4 第三槽、跨界续优化、逐块恢复与 256 层影子栈）的 36,101 条）36,101 → 33,957 条（−2,144 / −5.94%），寄存器索引形可折残差 1,084 → 0。同一个开关还会在 regalloc / vreg / slotreg / cmat 之后**再跑一遍**：那些 pass 造的 `MOV rX, r0` 第一次折叠还看不见，十九开关口径上 12,795 → 12,346 条（−449 / −720 B = −3.51% / −2.15%）。详见 `docs/ADDR_FOLD.md` |
| 强度削减 | 可选 | `-fopt-strength`（`ARKCC_FEATURE_OPT_STRENGTH`，宿主 1、板端 0，默认关）：把乘 2 的幂换成左移，两个落点共用一个开关——IR 层把相邻 `PUSH k` + `MUL`（k 为 2 的幂）改成 `PUSH log2(k)` + `SHL`（k==1 时两条都删），后端把 `IR_LOAD_IDX` 的元素大小缩放 `MOV r2,#es` + `MUL` 改成一条 `LSL`（源码里的常量乘在 IR 里，索引缩放在 IR 之后，谁也看不见谁）。只做 2 的幂：Cortex-M4 的 `MUL` 一周期，`x*3` 保留 `MUL` 并写成门禁断言。阶段行必须排在 `ir.xblock` 之后，否则 `x*1` 的删除会改变内联决策、开了反而变大（实测 +42 B）。HAL 全语料（`-O2` 逐级累加）`MUL` 1,105 → 12（剩下的全是值×值）；在 `-fopt-vstack -fopt-addr` 的 33,957 之上 → 31,865 条（−2,092 / −6.16%）；同一开关的后段再把紧邻的 `LSL` 并进寻址方式成 `[Rn, Rm, LSL #n]`（每次合并是两条 16 位换一条 32 位，对象字节基本不变）。详见 `docs/STRENGTH.md` |
| 零比较跳转折叠 | 可选 | `-fopt-cbz`（`ARKCC_FEATURE_OPT_CBZ`，宿主 1、板端 0，默认关）：`CMP r0-r7, #0` 紧跟 `BEQ/BNE` 时并成一条 `CBZ/CBNZ`，指令少一条、字节少四个。四条必要条件：两条相邻（中间只允许元数据行）、操作数严格是 `r0-r7` 与 `#0` 且目标为本地标签、目标前向且区间上界 ≤ 64 字节、标志位已死（写标志/返回/函数末尾之前不得出现读标志者，无条件 `B` 跟随目标继续扫）。文本层看不见真实宽度，故每条指令按 4 字节估上界，只会漏折不会越界；区间里有数据指令直接放弃。HAL 全语料（`-O2` 逐级累加）31,421 → 30,977 条（−444 条），代码字节 78,262 → 76,486（−1,776 B）；字节随被删那一对的宽窄变化（每处省 2~6 字节）。第二遍扫描用同一旗标、不新增开关，在第二遍活跃性/窥孔/寻址之后、帧裁剪之前再跑一次同一规则，吃掉被 `cmat`/`slotreg`/`litpool`/`regalloc`/`vreg` 新造出来的对：十九开关 + `frame`/`voldmb`/`constcond` 口径 12,266 → 12,215 条（−51 / −0.42%）、405,514 → 404,970 B（−544 B / −0.13%），语料里 `CMP #0`+条件跳的相邻对由 146 处降到 95 处（两个读数取自同一份二进制：把第二遍那一行注释掉重编一次）。详见 `docs/CBZ_FOLD.md` |
| 短分支收缩 | 可选 | `-fopt-branch`（`ARKCC_FEATURE_OPT_BRANCH`，宿主 1、板端 0，默认关）：汇编器内部先把整个文件按「每分支 4 字节」量一遍，记录每个 `B`/`B<cond>` 的 `pc`、条件与目标名以及每条 `.align` 的位置；`off = target − (pc+4)`，条件跳转 `−256..254`（T1 imm8）、无条件 `−2048..2046`（T2 imm11），奇数偏移拒绝，前向目标再减 2 作上界，**跨度跨 `.align` 一律拒绝**（padding 非线性会振荡）。任何一个决策变了就再跑一轮 pass1（此时按 2/4 字节真实布局，对齐填充精确），pass2 按序数表发 2 字节形式，条件/目标名不匹配就回退 32 位；发射前再自检一次偏移，越界报 hard error 而不是编码。夹具 `near` 1,386 → 1,368 B（−18，条数 160 不变），叠 `-fopt-vstack -fopt-addr` 1,294 → 1,276 B；STM32F4 HAL 全语料（`-O2` 逐级累加）指令数不变（只改编码宽度），代码字节 76,486 → 73,906（−2,580 B / −3.37%）；收缩从不增加字节，符号表不变 ⇒ 省的全是代码。详见 `docs/BRANCH_SHRINK.md` |
| 常量折进立即数 | 可选 | `-fopt-imm`（`ARKCC_FEATURE_OPT_IMM`，宿主 1、板端 0，默认关）：发射期把「`PUSH k` 紧跟一次算术/比较」折成指令的立即数字段，常量不再走值栈。每个算子先过编码闸门：`+`/`-` 限 ±4095（ADDW/SUBW）、`&\|^` 与 >255 的 `CMP` 必须过 `thumb_imm12_a`、移位限 0..31、比较只认右常量；装不下就原样保留。判定与发射共用 `emit_binary_imm()`，所以结构上不可能「吞了 push 却发不出立即数」；与 `--reg-top` 互斥。HAL 全语料（`-O2` 逐级累加）31,421 → 25,663 条（−5,758 / −18.33%），代码字节 73,906 → 62,890（−11,016 / −14.91%）。详见 `docs/IMM_FOLD.md` |
| 栈往返清理 | 可选 | `-fopt-peep`（`ARKCC_FEATURE_OPT_PEEP`，宿主 1、板端 0，默认关）：文本层删掉两类经内存的往返——`PUSH {rX}` 紧跟 `POP {rY}` 变成一条 `MOV`（同一个寄存器则两条全删），`STR rX, [r6, #o]` 紧跟同槽 `LDR` 时只保留 `STR`。跨标签一律不配、多寄存器帧 `PUSH` 不匹配、`DMB SY` 天然挡下 volatile；另有 R5：`ADD rD, rS, #0` 在 `D != S` 时只能编成 32 位 `ADDW`，改写成 2 字节的 `MOV`（两侧都不写标志，无需活跃性），下游 `-fopt-live`/`-fopt-coalesce` 只认 `MOV` 因而自动接管。pass 跑两遍：一次在 `-fopt-cbz` 之后，一次在第二遍活跃性之后（死对是后面的改名造出来的，值 −52 条 / −108 B）。在 `-fopt-imm` 之上 25,663 → 25,033 条（−630 / −2.45%），代码字节 62,890 → 61,628（−1,262 / −2.01%）；R5 + 第二遍窥孔在十九开关口径上再吃 13,116 → 12,795（−321 / −736 B）；再补 R6（`PUSH {rX}` … `POP {rY}` 而中间不提及 `rY` 时，这就是一次经内存的 `MOV`，把拷贝提到 `PUSH` 位置、删掉整对）与把 `ip` 纳入单寄存器 `PUSH`/`POP` 识别，12,346 → 12,304（−42 / −54 B）。详见 `docs/PEEPHOLE.md`、`docs/VREG.md` §17、§18 |
| 比较结果直连分支 | 可选 | `-fopt-cbranch`（`ARKCC_FEATURE_OPT_CBRANCH`，宿主 1、板端 0，默认关）：IR 发射期，`IR_BINARY(比较)` 的下一条正好是 `IR_JZ` / `IR_JNZ` 时，直接发 `CMP` + `B<cond>`，不再把比较物化成 0/1 再 `CMP r0, #0` 复测一遍。有符号 / 无符号两套条件码（`BLT/BGE` 对 `BLO/BHS`），`<=`/`>=` 的取反用 `BGT`/`BLT` 而不是 `>`/`>=`；立即数路径附 `MOV r1,#k` + `CMP r0,r1` 兜底；与 `--reg-top` 互斥，与 `-fopt-cbz` 叠加（`CMP r0,#0`+`BNE` 再折成 `CBNZ`）；比较结果有第二个消费者（`int x = (a<b); if (x)`）时不折。在 `-fopt-imm -fopt-peep` 之上 25,033 → 22,438 条（−2,595 / −10.37%）、61,628 → 53,404 字节（−8,224 / −13.34%）。详见 `docs/CBRANCH.md` |
| 寄存器拷贝清理 | 可选 | `-fopt-copyprop`（`ARKCC_FEATURE_OPT_COPYPROP`，宿主 1、板端 0，默认关）：照 IAR `ECT CopyPropagation candidate` / `DefIntoMove` / `Dead MOV` 逆向下放的两条**纯文本**规则，都不需要活跃性分析。A 死拷贝：`MOV rD, rS` 或 `MOV rD, #imm` 在同一个**直线块内**、任何读取之前被完全覆写 ⇒ 删除（`MOV` 不写标志，值与标志都不变）；直线块在标签、任何分支、`PUSH/POP/LDM/STM`、`IT` 系列、`CPS/BKPT`、函数尾结束。B 拷贝推进：`MOV rD, rS` 紧跟 `OP rD, rD, X` ⇒ `OP rD, rS, X`（`rD≠rS`、`X≠rD`，`OP` 限三操作数 ALU，**排除 `CMP/CMN/TST`**）。读判定必须是「第一个操作数也读，除非它是纯写目标」，否则会连 `MOV` + `STR`/`CMP` 一起删（emulator 抓出 9 个错答案）。八开关基线 22,438 → 21,915 条（−523 / −2.33%）、53,404 → 52,358 字节（−1,046 / −1.96%）；省的全是 `MOV`，其余助记符一条不动。详见 `docs/COPYPROP.md` |
| 活跃性驱动清理 | 可选 | `-fopt-live`（`ARKCC_FEATURE_OPT_LIVE`，宿主 1、板端 0，默认关，静态表约 1.5 MB 故板端裁掉）：第一个**跨基本块**的 pass —— 为每个函数建控制流图、把寄存器活跃性（`out = ∪succ.in`、`in = use ∪ (out−def)`）迭代到不动点，然后四条规则：**L1** `MOV rD, rS|#imm` 且 `rD` 之后不活跃 ⇒ 删除（能删掉绕过标签/分支的暂存）；**L2** `MOV rD, rS` 之后窗口内（`LV_WINDOW`=4）唯一读 `rD` 且不写它、之后 `rD` 不活跃的指令 ⇒ 消费者改读 `rS`、删拷贝（不要求三操作数 ALU，也不要求紧邻，`LDR rD,[rD,...]`/`CMP`/`STR` 都能接；窗口里写 `rD`/`rS` 或跨块就放弃）；**L3** `MOV rT, #0` 紧跟只把 `rT` 当地址索引的指令 ⇒ 丢掉索引 `[rB, rT, LSL #n]` → `[rB]`；**L4** `MOVW/MOVT rD` + `MOV rX, rD` ⇒ 常量直接落进 `rX`（IAR `DefIntoMove`）；`MOVW`/`MVN` + `MOV` 的单条材料化同样折（`MOV rD,#imm` 不折：16 位 `MOVS` 换 `MOVW` 会变宽且丢标志位）。拒绝清单：`BL/BLX` 读 `r0-r3`、无后继块返回 `r0-r3`、`CBZ/CBNZ` 第一个操作数是读、`IT` 块内一律不改、`r6`/`sp`/`lr`/`pc` 永不作目标、两操作数 ALU 的第一个操作数**也是读**（否则 `MOV r0,r5` + `LSL r0,r7` 会把活值删掉 —— emulator 抓出 376 条错删）、`ADC/SBC/RSC` 的消费者不折（16 位编码要求 `Rd == Rn`，折出三寄存器形式汇编器不发射）。九开关基线 21,915 → **19,112 条（−2,803 / −12.79%）**、52,358 → **45,760 字节（−12.60%）**；基线里 `MOVW/MOVT/MOV` 三连 681 处与 `MOVW`/`MVN` + `MOV` 二连 21 处全部命中（剩 2 处与 1 处是 `rD` 之后仍活跃）。另修复一处后补的真缺陷：块范围里的伪指令会读到**上一个函数在同一行下标上的残留解析**（`iv[]` 只在真指令处写入），导致 `MOV r5, r0` 被当成死拷贝删掉、`STR r5` 读出未初始化寄存器 ——真实语料上 4 处（`stm32f4xx_ll_utils.c`、`stm32f4xx_hal.c`×2、`stm32f4xx_hal_cortex.c`），修复后九开关口径 19,100 → **19,105**、86/95 TU 逐字节不变，门禁见 §7b。**litpool 之后同一个开关再跑一遍**（第二遍看见池化后的文本——`MOVW`/`MOVT` 已变成 `LDR`）：十九开关 13,566 → **13,116 条（−450 / −3.32%）**、34,980 → **34,200 字节（−2.23%）**，95/95 TU 无一变大；省的只有 `MOV` 立即数（−290）与 `MOV rD,rS`（−160）两栏，其余十六栏一条不动。顺带顶出并修掉内建汇编器的一处真缺陷（`ADDS`/`SUBS` 的高寄存器被 `&7` 掩码，静默算错且让其后标签整体偏移），并新增**两遍尺寸一致性自检**（硬错误，编译期探针 `ARKCC_ASM_SIZECHECK_PROBE` 可让它必失败）。详见 `docs/VREG.md` §16 |
| 值栈操作数配对 | 可选 | `-fopt-pair`（`ARKCC_FEATURE_OPT_PAIR`，宿主 1、板端 0，默认关）：IR 是栈机，两个相邻的值栈压入加上读它们的二元运算改成「左→r0、右→r1、直接算」，两对 `PUSH/POP` 与随之而来的寄存器搬运整块消失；只接栈槽（槽号 <8、非 volatile）、立即数、局部地址、非 va 的全局地址/标量（<8 字节，按宽度选 `LDR/LDRB/LDRH/LDRSB/LDRSH`）；64 位值、volatile、>8 字节对象一律不动。`-fopt-imm`（常量直接进立即数字段）与 `-fopt-cbranch`（比较直连分支）都比它便宜，pair 主动让位——这两条让位规则分别由一次翻车（+1,405 条 / +67 条）换来。95 TU HAL 语料 19,112 → 19,096 条（−16 / 0.08%），无单元变大。详见 `docs/OPTIMIZER_PLAN.md` 的 P12（S2–S5 为后续阶段） |
| 局部槽常量传播与死存储删除 | 可选 | `-fopt-prop`（`ARKCC_FEATURE_OPT_PROP`，宿主 1、板端 0，默认关）：IR 层两半共用一张字节图——**前向**把「写入后没再改」的帧槽常量按宽度精确扩展后改写成 `PUSH_INT`，**后向**把「字节全不活跃、producer 可丢」的 store 连同它的 `PUSH` 一起删成 `NOP`。两条尺寸闸门都是翻车换来的：常量必须一条 ARM 指令装得下（否则 `LDR` 换成 `MOVW+MOVT`，首版 +16 条）；紧跟在覆盖同槽 `STORE` 之后的读不替换（值已在栈顶寄存器，`-fopt-imm` 已免费消化，改写成 `PUSH_INT` 反而 +6 条）。取帧地址只有 `IR_PUSH_ADDR` 一条指令，故函数里没有它时调用/指针写/memcpy 都碰不到本帧，活跃性可以放宽（−6 → −29）。十开关之上 19,112 → 19,083 条（−29 / 0.15%），`STR −15`、`MOV −14`，无单元变大；插桩显示前向传播在 HAL 上 `replaced=0`，收益全部来自死存储删除——文本层余量确实到顶，下一步只能去 IR 级寄存器分配。详见 `docs/OPTIMIZER_PLAN.md` 的 P13 |
| 语句赋值的读回压栈 | 可选 | `-fopt-deadpush`（`ARKCC_FEATURE_OPT_DEADPUSH`，宿主 1、板端 0，默认关）：语句级本地赋值在 `STORE` 之后会紧跟一条读回压栈，而紧接着的丢弃 `POP` 让它白费——压栈（1 字，或 `long long` 的 2 字）后面紧跟相邻 n 个 `POP` 时整组改 `NOP`。volatile 读有观察语义、complex（四字）与宽度不符一律不动，不做任何活跃性分析。`-fopt-prop` 之上 19,083 → 19,066（−17 / 0.09%），`LDR −14`、`MOV −1`，无单元变大。详见 `docs/OPTIMIZER_PLAN.md` 的 P14 |
| 常量与死拷贝删除 | 可选 | `-fopt-cmat`（`ARKCC_FEATURE_OPT_CMAT`，宿主 1、板端 0，默认关）：值栈后端会把同一个常量材料化两次（先搬进暂存寄存器，再由消费者折回寻址方式），暂存寄存器也常连写两次，还会留下整函数范围内没人读的常量与拷贝。九条规则（M1–M7 只看块内文本，M8/M9 走控制流图）：**M1** 已知 0..255 常量的 `MOV rD, rS` ⇒ `MOV rD, #k`；**M2** 已知索引折进寻址方式（`k<<s ≤ 4095`，同地址同标志）；**M3** 块内被后写覆盖的标志中性写删除；**M4** 常量穿三操作数移位；**M5** 常量穿扩展；**M6** 已知 `CMP` 之后的条件分支当场判定（`CMP` 本身保留，故不依赖任何活跃性论证）；**M7** 值栈写进去又原样读回来的 `PUSH {rX}` / `POP {rX}` 对连同中间已死单元一起删掉；**M8** 第一条需要活跃性分析的——按控制流切块、建后继与 use/def 图跑到不动点，删掉全函数范围内死掉的 `MOV rD, #imm` 与 `MOV rD, rS`（只认这两种 flag-neutral 形态，`MOVW`/`MOVT` 不在范围内，被 `IT` 覆盖的一律不删）；**M9** 合流处的 `PUSH {rX}`/`POP {rX}` 回环对消——先做标签链折叠，要求 pop 的每一个前驱都以同一寄存器的 `PUSH` 收尾，成对删掉（遇 `TBB`/`TBH` 或非 `lr` 的 `BX` 整函数弃权）。块边界含标签、任何分支、`IT`、`POP/LDM/STM` 与**任何不在白名单的助记符**；`MOVW`+`MOVT` 必须整体处理。读集模型踩过两个致命坑（`MUL r0, r7` 隐式读目标、`STR` 第一操作数是源），门禁里各留了回归夹具。16 开关基线 15,933 → **14,131 条（−1,802 / −11.31%）**，`ARKOBJ2` 头实测代码段 40,188 → **36,126 B**；95 个 TU 用 `difflib` 逐文件差分实测 M8 删 571 行、M9 再删 238 行，两轮**新增均为 0 行**，删掉的只有那两种 `MOV` 与 `PUSH {r0}`/`POP {r0}`。详见 `docs/CMAT.md` |
| 槽级寄存器化 | 可选 | `-fopt-slotreg`（`ARKCC_FEATURE_OPT_SLOTREG`，宿主 1、板端 0，默认关）：在函数的已发射文本上**只删行、绝不插入**——删掉「`r0` 已持有该槽」的重复重载（**R1**）、删掉永远不会被观察的死写（**R2(a)** 全函数 0 读且地址未外流；**R2(b)** 块内被后写覆盖）。不引入任何寄存器、不动帧布局，所以「只减不增」是结构保证；地址外流点（`ADD rX, r6, #off`）之上的槽一律禁止死写删除，`volatile`、`[r6,rX]` 索引、写回、非十进制偏移、无帧函数整函数弃权。基线（十二开关 + `-fopt-cmat`）18,729 → **18,665 条（−64 / −0.34%）**，`LDR −35`、`STR −29`，95 个 TU 无一变大、85 个逐字节相同。按预注册否证线（<0.5% 即收档）**本条线收档**，代码留在默认关闭的旗标后。详见 `docs/SLOTREG.md` |
| 函数级常量缓存 | 可选 | `-fopt-constcache`（`ARKCC_FEATURE_OPT_CONSTCACHE`，宿主 1、板端 0，默认关）：同一个 32 位常量在一次函数里被材料化 **≥5 次**时，在入口用 `MOVW`+`MOVT` 建一次进 callee-saved（`r8`–`r11`），其余使用点改 `MOV rD, rC`。它是 `-fopt-regalloc` 的**第二个客户**，共用同一段保存寄存器块：`extra` 一次算完、偏移只平移一次、`PUSH`/`POP` 只加宽一次；寄存器从 `ra_` 未占用且函数原文本未出现的高寄存器里取，`.arkdata` 之后的链接期重定位对子不缓存，`vstack` 的 r4 形态 prologue 整函数弃权（多带一个填充字，加宽会破坏 8 字节对齐）。基线（十二开关 + `-fopt-cmat` + `-fopt-slotreg`）18,665 → **18,506 条（−159 / −0.85%）**，95 个 TU 无一变大、92 个逐字节相同，`arm_exec` 0 failure。详见 `docs/OPERAND_ALLOC.md` §8 |
| 32 位常量进字面量池 | 可选 | `-fopt-litpool`（`ARKCC_FEATURE_OPT_LITPOOL`，宿主 1、板端 0，默认关）：把 32 位常量的 `MOVW`+`MOVT`（两条、8 字节）换成一条 `LDR rD, <label>`（4 字节）从 PC 相对字面量池取值，节约 `4(c−1)` 字节、`c−1` 条指令（`c` 是使用次数；`c=1` 时字节中性、只少一条指令）。为此新增一种**汇编器形式** `LDR rd, <label>`，固定 32 位编码（`LDR Rt,[PC,#imm12]`，`imm12` 是 0..4095 的字节偏移；**越界或标签不在本文件时报 hard error**，并在原位发两条 `NOP` 占住 4 字节，绝不静默截断）。文本**按终止控制流的指令（`POP {.., pc}` / `BX` / 无条件 `B`，且只认无条件形式——`POPNE` 会回来）切成区域**，相邻区域向前贪心合并到不超过 `LP_REACH_INS = 800` 条指令，**每组一个池**放在该组终止指令之后、前面一条 `.align 4`（池是数据，控制已离开；所有分支都跳标签、所有标签都在池之后）。一个函数一个大池行不通：`LDR [pc,#imm]` 只够 4,095 字节，语料里两个大函数就占掉 711 个可转换对中的 225 个。拒绝清单：`MOVW`/`MOVT` 前一行是 `.arkdata`/`.arkdatasym`（链接器要打两个半字，对必须成对）、单个区域超 800 条、一个池里超过 128 个不同常量、函数超 4,096 行、末条指令不是终止指令。**静态表约 108 KB，板端剖面（`ARKCC_PROFILE_STM32_MIN`）默认裁掉**；裁切构建以 `C3900U` 拒绝旗标。95 TU HAL 语料：十八开关 **14,271 → 十九开关 13,566 条（−705）**、36,114 → **34,980 B（−1,134）**；配对审计 807 个相邻 `MOVW`/`MOVT` 对里 96 对带 `.arkdata`、0 对不是真对、可池化 711、**实际转换 705**（另 6 对落在被拒绝的长区域/大函数里，与指令差逐条对上），字节账 `−2,820 + 1,436 + 250 = −1,134` 也逐字节对上（705 站点各省 4 / 359 个池各占 4 / `.align 4` 合计补 250）；`HAL_RCC_OscConfig()` 1,256 → 1,229 条。执行级 `arm_exec --extra=-fopt-litpool` **0 failure**，21 项门禁见 `docs/LITPOOL.md` |
| 本地拷贝合并 | 可选 | `-fopt-coalesce`（`ARKCC_FEATURE_OPT_COALESCE`，宿主 1、板端 0，默认关）：`-fopt-live` 的第五条规则（L5），骑在同一个 `lv_pass()` 上——`MOV rD, rS`（`r0-r7`、`d≠s`、都不是 `r6`）之后的那段直线代码里把 `rD` 全部改名成 `rS`、再删掉这条拷贝，且**没有任何一条指令变宽**。段边界：标签、块边界/条件分支、`IT` 块、带 `!` 写回、寄存器列表 `{...}`、**`BL`/`BLX`**（隐式读写 `r0-r3`，文本里看不见）。段内三条判定：写 `rS` 即停（同时读 `rD` 就整段放弃）；写 `rD` 表示值已被带进 `rS`（此后任何 `rS` 读都放弃）；只读 `rD` 是改名目标。结束要求 `rD` 之后不活跃，段内重定义过 `rD` 时还要求 `rS` 也不活跃。每行改写前先做 `lv_same` 回放校验，两趟（校验/改写）。两处真缺陷由门禁/emulator 抓出：只处理「用后即死」几乎不命中（真形状是段内重定义 `rD`，95 TU 只少 1 条）；`BL` 的隐式读写导致参数丢失（返回 5 而非 9，删掉拷贝的同时把参数弄丢）。HAL 全语料 18,509 → **18,151 条（−358 / −1.93%）**，95 个 TU 中 81 个逐字节相同、14 个变小、**无一变大**，不加旗标逐字节相同。详见 `docs/COALESCE.md` |
| 槽提升到寄存器 | 可选 | `-fopt-vreg`（`ARKCC_FEATURE_VREG`，宿主 1、板端 0，默认关）：排在 `-fopt-regalloc` 之后，把「每一处提及都是 `LDR rD,[r6,#n]` / `STR rS,[r6,#n]`」的帧槽提升进 `r8-r11`——store 变 `MOV rC, rS`（与 `STR` 同为一条），喂给消费者的 load 直接删掉、并把**整个基本块**内读该寄存器的行改读缓存寄存器；区域只在四处结束：分支/标签/`BL`/PUSH/POP 的屏障行、帧建立行、另一条写同一目的寄存器的帧装载、以及只写不读该寄存器（读改写改名并保留，缓存寄存器带更新值往下走；别的槽的访存与源为此寄存器的 store 都只是改名后继续）；S6c 起 `BL`/`BLX` 不再是墙——但只在目的寄存器 `>= r4` 且在本函数序言保存名单里时放行，且区域边缘若有隐含读者（调用的 `r0-r3`、`PUSH`/`STM` 名单里的该寄存器、尾声的 `r0` 返回值）整段放弃改名只留 `MOV`。每槽要求至少消掉 2 条 load 才值得多压一个寄存器；新增寄存器数为奇数时再取一个把帧拉回 8 字节对齐。HAL 全语料（按当时的 18,151 基线）18,151 → **17,350 条（−801 / −4.41%）**，14 个 TU 变小、**无一变大**，不加旗标逐字节相同（95/95）；S6c 之后按当前口径重测（十七开关对十八开关）：14,954 → **14,271 条（−683 / −4.6%）**，36,204 → 36,114 B。附带修掉六个真缺陷（S6b 四个 + S6c 一轮顶出的两个隐式读者缺陷）：内建汇编器对 `r8-r15` 静默截断（`CMP`/立即数 `CMP`/`NEG`/`MUL` 的 32 位形式与 pass 1 宽度判据）、两操作数移位 `LSL Rd, Rs` 的操作数角色反了、`vg_reads_reg` 把两操作数的读改写误判成只写、原地重命名覆盖仍在读的文本；S6c 又顶出两个同源的：区域内一行都没改名却删了 load（`hits`），以及区域边缘的隐含读者（调用参数 / `PUSH` 名单 / 返回值）让值丢失；0.9.1-wip 再修掉第七个：`vg_hi_mask()` 恒空让 vreg 误以为 `r8-r11` 全空闲、与常量缓存抢同一寄存器（产物里出现重复寄存器名单 `PUSH {r5..r11,r8,r9,lr}`），修后十八开关 14,218 → 14,271（+53 条 / +42 B，是把抢来的寄存器还回去的价格）。详见 `docs/VREG.md` |
| 死 `static` 删除 | 是（无开关） | 未被引用的 `static` 函数不再发射（`ir_drop_unused_static()`，IR 层、挂在 `ark_emit_program()` 唯一收口处）：`static inline` / `__STATIC_INLINE` / 普通 `static` 一视同仁，候选只要求 `is_static`；存活是从保留函数出发的不动点（`IR_CALL`、`IR_PUSH_FUNC` 取址、全局初始器 `init_sym`/`init_refs`、`alias` 目标、**原始汇编文本里点到名**——`IR_ASM` 语句与 `__asm` 整函数体做子串搜索，读不出来时链接期报 undefined 而不是给错镜像）。不删 `used`/`unused`/`weak`/`constructor`/`destructor`/`interrupt`/`naked`/`alias` 目标/`main`，以及 `Reset_Handler`/`HardFault_Handler`/`SysTick_Handler` 这类入口点名（链接脚本与向量表可能按名字引用）。默认生效、`-O0` 同样生效——这是正确性修复（死助手引用只声明对象会让编译失败，如 CMSIS `ITM_SendChar` 引用 `ITM_RxBuffer`），不是优化；`-v` 打印删了几个函数，`--warn-unused-static` 在 pipeline 更早处仍然告警。95 TU HAL 语料 18,151 → **16,414 条（−1,737 / −9.57%）**、95 个 TU 全部变小无一变大，叠 `-fopt-vreg` 18,151 → **15,613 条（−2,538 / −13.98%）**。详见 `docs/DEADSTATIC.md` |
| 汇编器覆盖面 | 是 | LDR/STR 全地址模式（`[Rn]`/`[Rn,#imm]`/`[Rn,Rm]`/`[Rn,Rm,LSL #0..3]`/`[Rn,#imm]!`/`[Rn],#imm`、`[sp,#imm]`、`[pc,#imm]`）、`VLDM/VSTM/VPUSH/VPOP`、`LDMFD/STMFD/LDMEA/STMEA` 别名、`ADDW/SUBW`；体系结构不存在的形态（`LDMIB/LDMDA/STMIB/STMDA`、寄存器索引写回）明确报错 |
| 预处理 | 是 | 对象/函数宏（`#/##`）、`#if/#elif/#else/#endif/#ifdef/#ifndef/#undef/#error/#warning/#pragma`、嵌套 `#include`（<=8 层）、`__VA_ARGS__`、`-I` 路径、三字符组替换 |
| 注释 | 是 | `//` 和 `/* */` |

### C11 关键字（子集）

只实现这六个关键字；C11 的其余部分（`<threads.h>` 线程库、`_Atomic` 修饰复合体、匿名结构体成员之外的写法等）
不在范围内，遇到就是普通语法错误的报错，不会当作"大概能用"放过。

| 关键字 | 支持 | 说明 |
| --- | :---: | --- |
| `_Static_assert(expr[, "msg"])` | 是 | 文件作用域 / 块作用域 / 结构体成员三处都能用；`expr` 在**解析期**用 `eval_const_expr` 折叠，折不出整数常量表达式就报错（`static assertion whose truth we cannot decide` 不能放行），条件为 0 时把 `msg` 原样打进诊断 |
| `_Alignof(type-name)` | 是 | 从**类型**折叠（不是从表达式的"默认 int"，`sizeof` 曾经在这条路上答错）；只接受类型名形式，`_Alignof(expr)` 明确报错而不是猜 |
| `_Alignas(type-name)` / `_Alignas(const-expr)` | 是 | 文件作用域任意 2 的幂（实测 64 生效，ARM 平铺 SRAM 布局也按 `align_bytes` 落位，不再一律 4 字节对齐）、结构体成员（改 `align_override`，实测 `sizeof` 32 / `align` 16）、块作用域 ≤ 8 字节（实测 8）；**永远不会弱化**自然对齐（C11 6.7.5p6，`_Alignas(2) double` 仍是 8 对齐）；非 2 的幂、非常量报错 |
| `_Generic(ctrl, type: expr, ..., default: expr)` | 是 | 控制表达式按 C11 6.5.1.1p2 做左值转换 + 数组退化 + **函数指示符退化**（`f`、`&f`、`*f` 三种写法都落到函数指针类型）；**不做整型提升**（`char` 还是 `char`）；无匹配且无 `default` → 报错（给 0 就是伪造答案），重复 `default` → 报错；选中后在 sema 里 squash 成普通表达式，下游（irgen / 全局初始化 / 各后端）完全看不到它 |
| `_Thread_local` | 是 | 与 `__thread` 同一套存储（bit `0x10000`），但按 C11 6.7.1p4 校验：file scope 必须配 `static`/`extern`，不能修饰函数、不能在 `typedef` 里、不能与 `auto`/`register` 同用；**armcc 的裸 `__thread` 保持豁免**（`examples/test_tls.c` 依赖这一点）。四条诊断按「更具体优先」排序，所以 `_Thread_local int f(void);` 报的是「applies to objects, not functions」而不是笼统的存储类错误 |
| `_Atomic` | 是（带边界） | 类型限定符与 `_Atomic(type-name)` 两种写法都能解析，`_Atomic` 经 `type_atomic()` 落成 `Type::is_atomic`（浅拷贝后打标记，不污染单例），所以原子性**沿 typedef 传播**——`typedef _Atomic int atomic_int;` 之后 `atomic_int x;` 仍是原子对象。它决定三件事：`<stdatomic.h>` 走哪条实现、哪些类型当场拒绝、以及 `sema` 拒绝一切读-改-写（`x += 1` / `x++` 按 C11 6.5.16.2p3 / 6.5.2.4p2 报错并点名 `atomic_fetch_*`；`x = 5` 不报错，那就是一次原子 store）。数组 / 函数 / `struct`·`union` 三类按 C11 直接报错（array 那句引 6.7.2.4，复合体要锁，拒绝而不是假装能原子访问）。真正的原子性只做在 ARM 上（PRIMASK 临界区）；另外四个目标上**每个原子操作都是编译期错误**，以未声明标识符 `__arkcc_atomic_<op>_not_supported_on_this_target_use_a_mutex` 失败——绝不悄悄退化成普通读写。详见 [docs/ATOMIC.md](docs/ATOMIC.md) |

块作用域 `_Alignas(16/32/64)` 是**报错**而不是静默降级：栈帧按 `sp -= N; base = sp` 建，AAPCS 只保证 `sp` 8 字节对齐，要真支持 16/32/64 得改 prologue/epilogue 并处理变参序列占用 `r5` 存旧 `sp` 的冲突。这里选择"宁可报错，不给错答案"。

`_Thread_local` 的**语义边界**必须说清：`__thread` 那一套 `.tbss`/`.tdata` 只在 `ARKCC_FEATURE_ARMCC_KEYWORDS` 的散列加载路径上发射，**平铺裸镜像（`--vector-table`）里 TLS 变量就是普通 `.data`/`.bss`**——落在 SRAM、由 `__arkcc_init_globals()` 清零，单线程裸机上值语义正确，但不代表有线程指针重定位；C 后端原样输出 `__thread` 交给宿主 gcc。执行级证据见 `tests/arm_exec/run_arm_exec.py` 的 `tls_static_init` / `tls_block_static` / `tls_reject`。

`_Atomic` 的**语义边界**同样要说清。`stdlib/include/stdatomic.h` 分两支：ARM 目标上 32 位类型的 load/store 是普通访问（单核上对齐的单字访问本身就不可分割），`exchange` / `compare_exchange` 与五个 RMW 走 `__arkcc_crit_save` / `__arkcc_crit_restore`（`MRS PRIMASK` + `CPSID i`）的临界区；`long long` / `double` 这些装不进一个字的，连 load/store 也走临界区，比较用两字相等而不是 AEABI 的向量相等。内存序一律按 `seq_cst` 实现（临界区 + 编译器屏障 `__memory_changed`），并且**这是单核中断级互斥**：跨核、跨 DMA 的可见性它不负责，DMB 只解决顺序不解决 cache 一致性。非 ARM 目标（x86 / x86_64 / riscv32 / c）上除 `atomic_init`（就是一次赋值）与 typedef 之外全部是编译期错误，理由写在名字里。边界（`int *_Atomic p` 已在 0.9.1 支持：限定符落在**指针本身**，load/store 是普通访问，`p++` 仍按 C11 判读-改-写而拒绝；`_Atomic(long)` 这种类型说明符跟在 `*` 后面则报错。经指针的读-改-写**已实测被拦**——`atomic_int *p; *p += 1;` / `p[0] += 1;` / `(*p)++;` / `++*(p + 1);` 四种写法都拒绝，而 `int *_Atomic p; *p += 1;` 因 pointee 是普通 int 必须放行）：只剩 `x86_64` 上的 `lock xadd` / `cmpxchg16b` 未接。门禁：`tests/run_atomic_tests.py` 跑五个目标 × （目标身份宏、11 个原子操作必须拒绝、`atomic_init` 必须能编），`tests/arm_exec/run_arm_exec.py` 的 `atomic_rmw` / `atomic_nested_mask` / `atomic_wide` / `atomic_ptr` / `atomic_reject` 在 unicorn 上真跑临界区、64 位路径与原子指针访问。

### ARM Compiler 5 (armcc) 兼容扩展

#### armcc 关键字

| 扩展 | 支持 | 生成 |
| --- | :---: | --- |
| `__svc(n)` | 是 | `SVC #n` |
| `__irq` | 是 | 中断序言 `PUSH {r0-r3,r12,lr}` / 结语 `POP {r0-r3,r12,pc}` |
| `__weak` | 是 | `.weak <name>` |
| `__naked` | 是 | 无序言/结语 |
| `__packed` | 是 | 独立关键字形式 + `__attribute__((packed))` + 通过 `__packed` 指针非对齐访问（逐字节 load-and-stitch，1/2/4/8 字节；ARM 与 RV32I 都做全 8 字节，不再只搬低 4 字节） |
| `__align(n)` | 是 | 实际生效的对齐控制 |
| `__at(addr)` | 是 | 绝对地址（同 `__attribute__((at(addr)))` / `#pragma location=`） |
| `__forceinline` | 是 | 已解析（强制内联提示） |
| `__asm void fn() {...}` | 是 | 整函数体汇编（armcc 风格） |
| `__value_in_regs` | 是 | 已解析（结构体寄存器返回提示） |
| `__pure` | 是 | 已解析（无副作用纯函数提示） |
| `__interwork` | 是 | 已解析（ARM/Thumb 互操作提示） |
| `__thread` | 是 | 线程局部存储（`.tbss`/`.tdata` 段） |
| `__global_reg` | 是 | 已解析（全局寄存器变量提示） |
| `__smc` | 是 | 已解析（SMC 安全监控调用提示） |
| `__int64`/`__int32`/`__int16`/`__int8` | 是 | 定宽整数类型别名 |
| `__typedef` | 是 | 已解析（typedef 兼容前缀） |
| `__args`/`__return` | 是 | 已解析（参数/返回寄存器绑定提示） |
| `__tp_soft` | 是 | 已解析（软件线程指针提示） |
| `__nothrow` | 是 | 已解析（函数不抛出异常提示） |
| `__deprecated` | 是 | 已解析（弃用标记） |
| `__may_alias` | 是 | 已解析（别名安全类型提示） |
| `__softfp` | 是 | 已解析（软浮 ABI 提示） |

#### `__attribute__` 属性

| 属性 | 支持 |
| --- | :---: |
| `section` | 是 |
| `aligned`/`packed`/`noreturn` | 是 |
| `used`/`unused` | 是 |
| `alias("target")` | 是 |
| `constructor`/`destructor` | 是 |
| `deprecated`/`format(printf,...)` | 是 |
| `may_alias`/`nothrow` | 是 |
| `pure`/`const` | 是 |
| `visibility("default/hidden")` | 是 |
| `nonnull` | 是 |
| `warn_unused_result` | 是 |
| `sentinel` | 是 |
| `malloc` | 是 |
| `fastcall`/`stdcall`/`cdecl` | 是 |

#### `#pragma`

| pragma | 支持 |
| --- | :---: |
| `#pragma pack(n)` | 是 |
| `#pragma anon_unions` | 是 |
| `#pragma location=addr` | 是 |
| `#pragma diag_suppress` | 是 |
| `#pragma arm/thumb` | 是 |
| `#pragma import(__use_no_semihosting)` | 是 |
| `#pragma push/pop` | 是 |
| `#pragma O0/O2/O3`、`#pragma optimize` | 是 |

#### 内联汇编

| 形式 | 支持 |
| --- | :---: |
| `asm/__asm__` 内联汇编 | 是 基本形式 + 扩展形式（操作数/约束/破坏描述）；C 后端完全透明，ARM 后端文本透传 |

### armcc 兼容预定义宏

| 宏 | 值 |
| --- | --- |
| `__ARMCC_VERSION` | armcc 版本号 |
| `__arm__` / `__thumb__` | ARM/Thumb 模式标志 |
| `__arm` / `__thumb` | 无下划线形式（armcc 兼容） |
| `__TARGET_ARCH_7_M` / `__TARGET_ARCH_7E_M` | Cortex-M 架构标志 |
| `__TARGET_FPU_VFP` | VFP 标志 |
| `__BIG_ENDIAN` / `__LITTLE_ENDIAN__` | 字节序 |
| `__sizeof_int` / `__sizeof_ptr` | 类型大小 |
| `__STDC_VERSION__` | `199901L` |
| `__STDC_HOSTED__` | `1`（宿主） / `0`（嵌入式） |
| `__SIZE_TYPE__` / `__PTRDIFF_TYPE__` / `__WCHAR_TYPE__` | GCC 风格类型大小宏 |
| `__EDG__` | EDG 前端兼容标志 |
| `__APCS_INTERWORK` | APCS 互操作标志 |

### 代码生成

| 特性 | 支持 |
| --- | :---: |
| 32 位立即数 MOVW/MOVT | 是 |
| 整数除法 SDIV / `__aeabi_idiv` | 是 |
| 64 位算术 `__aeabi_lmul/ldiv` | 是 |
| 软浮 `__aeabi_f*`（单精度） | 是 |
| 软浮 `__aeabi_d*`（双精度，`double` 为真 64 位） | 是 |
| 硬件 FPU 指令（VFP `VADD/VMUL/VCVT/VCMP`，替代软浮桩） | 是 |
| VLA 动态栈分配 `IR_ALLOCA` | 是 |
| `.data/.bss/.rodata` 段分离 | 是 |
| 位域按位打包/解包 | 是 |
| 直接编译汇编文件 | 是（ARM 后端有完整 Thumb-2 文本汇编器；按文件扩展名 `.s`/`.S`/`.asm`/`.ASM` 触发，大小写不敏感） |
| 严格 AAPCS（>4 参数走栈） | 是 |
| `setjmp/longjmp` 支持 | 是 |
| `.init_array`/`.fini_array`（构造/析构函数） | 是 |
| 通过 `__packed` 指针非对齐访问 | 是（1/2/4/8 字节逐字节读写；8 字节先装配低字压栈、再装配高字压栈，与对齐路径的入栈顺序一致） |
| 完整 DWARF 调试信息（`.file/.loc/.cfi_startproc/.size` + `.debug_info`/`.debug_abbrev`/`.debug_line`） | 是 |
| TLS 线程局部存储（`.tbss`/`.tdata`） | 是 |
| `--split_sections` 每函数一段（`.text.fn`） | 是 |
| Scatter 加载描述文件解析（`include/scatter.h` + `src/scatter.c`） | 是（解析 + scatter 感知链接 + 向量表生成；见下表） |
| CPU 选择（`-mcpu`/`--cpu`，`include/cpu.h` + `src/cpu.c`） | 是 |
| 多对象数据段搬迁 `--reloc-data`（`.arkdata` 标记 + 链接期 MOVW/MOVT 改写） | 是（默认关；关时按旧行为报 SRAM 重叠） |
| 段内绝对地址链接期修正 `--reloc-text`（`.arktext` 标记 + 对象自带 `__arkcc_text_base`，链接器按对象算位移） | 是（默认关；关时产物与旧版逐字节相同。修的是字符串字面量这类 `MOVW/MOVT` 里写死的代码地址） |
| 运行库按需发射 `--rt-lazy`（只发可达的 `__aeabi_*` 块） | 是（默认关；`add3.c` 1578 → 60 字节） |
| IR 栈顶驻留 r0 `--reg-top`（有界寄存器化，非分配器） | 是（默认关；80 样例指令数 −7.1%） |
| `float` ↔ `double` 显式转换（`VCVT.F32.F64` / `VCVT.F64.F32`） | 是 |
| 浮点常量表达式折叠（`eval_const_fexpr` + `fconst_to_int`） | 是 | 两处落点：显式转换到整型（`(int)(2.5*4.0)`、`enum {E=(int)(1.5+1.5)}`、`int a[(int)(2.0*3.0)]`）与全局/静态初值的隐式转换（C99 6.6，`int g = 2.5*4.0;`）。NaN/无穷/超出目标类型范围**不折叠**，报错不发明值；`int a[2.5]` 与 `int a[(int)(1.0/0.0)]` 报 `array dimension is not an integer constant expression` 而不是静默取 1 个元素 |
| 汇编器扩展指令集 `--asm-extra`（`ANDS`/`ORRS`/…/`MRS`/`MSR`、`LDM`/`STM` 的 32 位与减前形式、`TBB`/`TBH`、`LDRD`/`STRD` 共 24 个助记符 + `.W`/`.N` 后缀） | 是（默认关；关时报 unknown mnemonic。`ADDS`/`SUBS` 不在这份名单里：后端自己发射它们，所以无条件接受——GNU as 会把无 `S` 的 `ADD` 编成 32 位 `ADD.W`，静默丢掉标志位） |
| 容量上限（宿主做全 / 板端可裁剪） | 是（`include/arkcc_config.h` 第 9 节，一处定义两套默认值，逐项 `-D` 覆盖；越界一律报错不静默丢弃） |

### `.sct` / `.s` 文件支持矩阵

| 能力 | 状态 | 说明 |
| --- | :---: | --- |
| 解析 `.sct`（scatter）文件 | ✅ | `scatter_parse_file()` (`src/scatter.c`) |
| 解析 GNU `.ld` 脚本 | ✅ | `linker_script_parse_file()` (`src/scatter.c`) |
| `.sct` → `.ld` 转换 | ✅ | 仅在 `-S` 模式下输出，`scatter_to_ld_script()` |
| `.ld` → `.sct` 转换 | ✅ | 仅在 `-S` 模式下输出，`scatter_to_sct_file()` |
| 按段名查找执行地址 | ✅ | `scatter_lookup_addr()` + `scatter_get_er_base_for_section()` |
| 用 `.sct` 进行实际段放置/链接 | ✅ | scatter 感知：`-link` 模式解析 `.sct`/`.ld` → 提取 flash_base/initial_sp → 生成 256 条目向量表 → 移动代码 → 调整符号/重定位偏移 |
| 编译 `.s`/`.S` 汇编文件 | ✅ | `arm_assemble()` 完整 Thumb-2 文本汇编器，按扩展名触发 |
| 编译 `.asm`/`.ASM` 文件 | ✅ | 与 `.s`/`.S` 等价（`is_asm_input()`，大小写不敏感） |
| 编译 `.asm`/`.ASM` 时输出文件名 | ✅ | 未给 `-o` 时按同名推导为 `.bin`（与 `.s` 一致） |
| `--scatter <file>` 命令行选项 | ✅ | 在 `-S`/`-link`/`-c` 模式下解析；`-link` 模式参与向量表生成 |
| `-T <file>` / `--linker-script` 选项 | ✅ | 同 `--scatter`，GNU `.ld` 脚本转换为 scatter 内部表示 |
| `--uvprojx <file>` 选项 | ✅ | 从 MDK `.uvprojx` 自动提取 `<IncludePath>`/`<Define>` 为 `-I`/`-D` |

### 标准库子集

| 源文件 | 提供 |
| --- | --- |
| `stdlib/src/printf.c` | 精简 `printf`（`%d/%u/%x/%X/%s/%c/%p/%%` + 宽度/0 填充，64 位 long long 不截断） |
| `stdlib/src/string.c` | `memcpy/memset/memmove/memcmp/strlen/strcpy/strcmp` |
| `stdlib/src/math.c` | `sin/cos/sqrt/pow/fabs/floor/ceil/fmod` |
| `stdlib/src/setjmp.c` | `setjmp/longjmp`（可移植简化宿主实现，只给宿主测试用） |
| `stdlib/src/arm/setjmp.s` | `setjmp/longjmp` 的 **ARM Thumb-2 真实现**（`jmp_buf` 存 r4-r11/sp/lr，`longjmp(env,0)` 读回 1）；为什么必须是汇编、为什么不能是 C 包装见文件头 |
| `stdlib/src/stdlib.c` | 转换与整数算术：`strtol/strtoul/strtoll/strtoull`（base 2..36、`errno=ERANGE` 饱和、`endp` 语义）、`atoi/atol/atoll`、`strtod/strtof/strtold/atof`、`labs/llabs`、`div/ldiv/lldiv`、`qsort`（插入排序，稳定、不用递归）、`abs` |
| `stdlib/src/heap.c` | `malloc/free/calloc/realloc`：`ARK_STDLIB_HEAP_SIZE` 字节的静态 arena（默认 8 KB，`-DARK_STDLIB_HEAP_SIZE=…` 改），按块分裂/相邻合并；**耗尽时返回 `NULL`**（不静默给假地址），只读诊断 `ark_heap_used/ark_heap_capacity` 供门禁与板上 `mem` 命令 |
| `stdlib/src/errno.c` | `errno` 真对象（一个 4 字节全局，各 TU `extern int errno` 共享；`E*` 宏在 `<errno.h>`，换号只需换头） |
| `stdlib/src/exit.c` | `exit/_Exit/abort/atexit`：按注册逆序跑 `atexit` 链，再调端口钩子 `_ark_exit(status)` |
| `stdlib/src/exit_default.c` | `_ark_exit` 的弱定义（死循环）：目标工程可以覆盖它，覆盖后 `exit()` 才真正离开镜像 |
| `stdlib/src/signal.c` | `signal/raise`（子集）：`SIGINT/SIGTERM/SIGABRT/SIGFPE/SIGSEGV/SIGILL`，`SIG_DFL` 走 `_ark_exit`，`SIG_IGN` 忽略 |
| `stdlib/src/putchar_default.c` | `putchar` 弱默认实现 |
| `stdlib/src/arm/aeabi.c` | 平铺 ARM 镜像用的 64 位 AEABI 运行时：`lmul` / `ldiv` / `udiv` / `llsl` / `llsr` / `lasr` / `lcmp` / `ulcmp`，全部只用 32 位算子（不会递归到自己），C 源，可被 arkc 自己编译 |
| `stdlib/src/arm/aeabi_divmod.s` | `__aeabi_ldivmod` / `__aeabi_uldivmod` 的四寄存器返回包装（商 `r0:r1`、余 `r2:r3`）——C 语言写不出四寄存器返回（`__value_in_regs` 只解析不 codegen），所以这一段必须是汇编，算术复用上面的 `aeabi.c` |

`stdlib/include/` 头文件（23 个）：`complex.h`/`ctype.h`/`errno.h`/`fenv.h`/`float.h`/`inttypes.h`/`limits.h`/`locale.h`/`math.h`（含 `M_PI` 等常量）/`setjmp.h`/`signal.h`/`stdarg.h`/`stdatomic.h`/`stdbool.h`/`stddef.h`/`stdint.h`/`stdio.h`/`stdlib.h`/`string.h`/`tgmath.h`/`time.h`/`wchar.h`/`wctype.h` 的子集，全部按 C99/C11 声明原型——**声明与实现同源**，门禁会拿头文件里的原型去编实现文件。

**平铺镜像（`-o image.bin` / `--vector-table`）与上面两份 ARM 运行时**：编译 `.c` 到 `.obj` 时，64 位乘/除/取模/移位/比较会发射 `__aeabi_lmul` 等外部符号（64 位加减已内联成 `ADDS`/`ADC`、`SUBS`/`SBC`，不需要运行库）。**编译器绝不隐式链接这两份源**——镜像里到底要不要软浮/64 位运行时，由链接方决定。所以一条能跑通的平铺镜像命令是三步：

```sh
./arkcc -target arm -c stdlib/src/arm/aeabi.c -o aeabi.obj
./arkcc -target arm -c stdlib/src/arm/aeabi_divmod.s -o aeabi_div.obj
./arkcc x.c -target arm -c --vector-table -o x.obj
./arkcc -link x.obj aeabi.obj aeabi_div.obj --vector-table -o out.bin
```

链接这两份源时会出现一行 `[link] note: 1 duplicate compiler-runtime symbols merged`：`aeabi.c` 里也带了 64 位加/减的函数，用来顶住"别人拿这个目标文件直接调用"的场景，与镜像自带的运行时同名同义，合并是预期行为。

**已知代价（不是缺陷，是设计选择）**：`udivmod64` 是 64 次 restoring 除法，在 arkc "每个中间量都压栈" 的代码形状下**一次 64 位除法约 12.8k 条指令**（实测 `shift64` 整例 9.26M 条）。软除法在 M7 上按主频折算仍在毫秒级可接受，但实时性敏感的内层循环应当避免 64 位除。

**RV32I 的扁平镜像（`-target riscv32 x.c -o x.bin`）**：这个后端早先只到
"输出 GAS 语法汇编"，要执行必须自己接 `as -march=rv32im` + `ld -Ttext=0x08000000`。
现在它自己就是一个 RV32I 汇编器，直接把镜像写到 `0x08000000`：`.text` →
`.rodata` → `.data` 三段连续排列（先 `-S` 再看文本，能对上每一条指令），段基址 16
字节对齐，镜像**在最后一个有字节的段末尾结束**（纯代码程序就是代码长度，不额外补
对齐）。`ARKCC_DUMP_SYMS=1` 会把 `RV_SYM <名字> 0x<地址>` 打到 stderr，宿主机测试
靠它定位 `main`。

这个汇编器**没有链接器**，所以对"半成品"比 GNU as 更严格，三类问题一律报错且不产
镜像：未知助记符；分支超出 `beq/bne/blt/bge/bltu/bgeu` 的 ±4 KB（`jal/j` ±1 MB）；
**引用本翻译单元没有定义的符号**（`a flat image has no linker to fill it in`）——
留着一条半写的 `auipc` 让程序跳到镜像外、编译还 exit 0，正是这个项目不允许的静默
错答案。

**RV32I 的对象模式（`-target riscv32 -c x.c -o x.ark_obj` + `-link`）**：`-c` 产出的是
ARKOBJ2 对象，但对象体里装的是**已汇编好的机器码**（不是汇编文本），跨对象的引用
留给链接器回填。RV32I 的 `la sym` / `call sym` 都是 `auipc`+`addi|jalr` 这种成对指令，
两条指令合起来才决定低 12 位写到哪，所以重定位按**对**记录（`RV_RELOC_AUIPC`，8 字节）；
`.word sym` 要的是绝对地址，单独一种（`RV_RELOC_ABS32`）。只改写 `auipc` 的上 20 位是
不够的——`auipc` 的立即数会被左移 12 位，低位的进位必须跟着改到后一条指令里，这也是
为什么两处必须一起算。

对象内部一律用 PC 相对寻址，所以**每个对象可以落在镜像的任意偏移**：链接器把各对象
按 16 字节对齐依次串联，对象内部的引用天然成立，只有表里的跨对象项需要打补丁。
唯一走不通的是**跨对象分支**（RV32I 没有可重定位的 32 位分支形式），这种写法直接报错
并建议改成函数调用——报错比造半个答案诚实。

导出边界由**导出表**决定：只有被 `.globl`/`.weak` 命名的标签（C 侧即非 `static`
的定义）才能跨对象被引用。不这样做的话，两个翻译单元各自的 `static helper` 会在链接时
撞名，而链接器的策略是"重复的强符号取第一个"——那会把 A 文件的 static helper 静默
绑进 B 文件的调用里，正是又一个静默错答案。

对象带 ISA 描述符（`__arkcc_isa_riscv32`），链接时双向校验：`-target riscv32` 链接的
对象必须是 RV，RV 对象也必须在 `-target riscv32` 下链接。少了这一步，一条
`arkcc -link rv.obj` 会走 ARM 的重定位路径，把 Thumb 分支编码写进 RISC-V 镜像还 exit 0。
`-v` 会打 `[link] object N: base 0x...`，配合 `ARKCC_DUMP_SYMS` 才能把"对象内偏移"
换算成地址——扁平镜像自身没有符号表。

已知边界：**跨翻译单元的函数指针全局初始化器**（`int (*gp)(void) = f;`）RV 后端目前
直接报错（`cannot turn the initialiser of the global 'gp' into data`），这是既有限制；
只用手写汇编时 `.word f` 可以（`RV_RELOC_ABS32`）。另外链接器对**重复的强符号**仍是
警告 + 取第一个（ARM 同此策略，本轮未改），所以在 C 层面重复定义一个非 `static` 的
全局函数/变量不会被拒。

`li` 立即数接受整个无符号 32 位范围（`li t0, 4294967295` 就是 -1，与 GNU as 一致），
超出 32 位才报错。

**RV32I 剩下的四类 IR（内联汇编 / `__svc` / `__smc` / 自动向量化）**：后端的 `default`
分支改成报错之后，凡是走这四条的源在 RV 上直接编译失败——诚实，但仍是"完整 C 编译器"
的缺口。现在都实现了：

- `IR_ASM`：`asm("...")` 原样落到汇编输出；扩展形式（`asm("t" : outs : ins :
  clobbers)`，`irgen` 用 `@` 前缀标出来）把 `%0..%3` 换成 `a0..a3`（ARM 侧是
  `r0..r3`）。这个后端**没有操作数分配器**，所以 outs/ins/clobbers 被丢弃——已知边界，
  写在门禁的注释里。
- `IR_SVC` / `IR_SMC`：编号进 `a7`，指令是 `ecall`。RV32I **只有一条 trap 指令**，所以
  `__svc(n)` 与 `__smc(n)` 在 RV 上不可区分；这是 ISA 的属性，不是取巧。编号放 `a7`
  遵循 RISC-V syscall ABI / SBI 的约定，内核侧从这里取号。
- `IR_SIMD_ADD16/SUB16/ADD8/SUB8`：自动向量化产出的打包车道运算。RV32I 基础指令集没有
  打包指令，所以用 SWAR **精确模拟**（逐车道有符号回绕，绝不饱和——与 ARM 的
  `SADD16/SSUB16/SADD8/SSUB8` 语义一致）。两处容易写错：16 位族不能用字节掩码
  （`0x00FF + 1` 的进位会丢，必须整半字掩码再把进位用移位丢掉）；8 位族可以按
  `0x00FF00FF` 分组，但**减法必须给每条车道的 gap 起点置 guard 位**，否则低位字节的
  借位会穿过 gap 偷走上方车道的一个 1（`0 - 1` 得到 `0xFFFFFFFF` 而不是 `0x000000FF`）。

这条路顺带挖出并修掉了一个**两个后端都有的静默错答案**：`opt_vectorize` 只把
`LOAD_IDX`/`STORE_IDX` 的宽度改成 `es*W`、把 `BINARY` 换成 SIMD，却没撤掉元素窄化留下
的 `IR_TRUNC`，于是打包进一个字的 4 个车道过完窄化只剩 lane 0——`char a[8] + b[8]` 在
`-O2` 下把 `{1,2,3,4,5,6,7,8}` 算成 `{2,0,0,0,10,0,0,0}`。修法是把相邻的 `IR_TRUNC`
目标位宽提到 32（32 在两个后端都是 no-op，不必重编号），同时拒绝 `volatile` 与
`__packed` 的循环（`aux & 0x200 / 0x400`——前者不该被合并，后者的逐字节通路正是非对齐
访问的实现）。门禁：`tests/run_rv_misc_ir_tests.py`。

这条路还暴露并修掉了一个后端缺陷：`irgen` 把"操作数无符号"记在 `aux` 的第 8 位
（`0x100`），ARM 后端会先掩掉这一位，RV32I 后端直接拿 `aux` 做 `switch`，于是**无符号
右移和四种无符号比较全部落进 `default` 分支、不发射任何指令**——两个操作数弹掉、左
操作数再压回去，`u >> 4` 静默返回 `u`，`a < b` 静默返回 `a`。现在按位掩码后选
`srl` / `sltu` 系列，并且 `default` 分支改成报错（未知运算符不许静默返回左操作数）。

### 后端

| 后端 | 用途 |
| --- | --- |
| **ARM Thumb-2** | STM32 Cortex-M（默认，含软浮/硬件 FPU + 段分离 + 双精度桩 + AAPCS + 完整 DWARF + TLS + split_sections + scatter） |
| **C 源码** | 宿主测试主路径（IR -> 可读 C，完整支持内联汇编操作数透传） |
| **x86_64** | 真 SysV AMD64 后端：8 字节指针、`rdi rsi rdx rcx r8 r9` + `xmm0-7` + 右到左 8 字节栈槽、`al` 传 xmm 个数、0x400000 平铺镜像（RIP 相对取数）、自带 64 位编码器（`-target x86_64`；别名 `x86-64`/`amd64` 指向它） |
| **x86** | i386 cdecl，输出 GAS 汇编（别名 `i386`/`i686`） |
| **RV32I** | 输出 RV32I 汇编，并自带扁平镜像汇编器与对象路径（`arkcc -target riscv32 x.c -o x.bin` 直接出 0x08000000 的整张镜像；`-c`/`-link` 出机器码对象再串联，不需要外部 `as`/`ld`） |

x86-64 的 ABI 模型、本轮修掉的四个静默错答案、i386 的两处有意行为变化与已知缺陷清单，
见 [docs/X86_64_BACKEND.md](docs/X86_64_BACKEND.md)。

**各后端的能力不是同一张表：`stdarg.h` 有两条互不兼容的走法。**

四个后端都支持变参函数定义，但参数镜像的**形状**不同，靠驱动注入的宏让 `stdarg.h`
选一条：

| 后端 | 走法 | 布局 |
| --- | --- | --- |
| C / x86 / x86_64 | 8 字节槽位（默认分支） | 每个实参一个 8 字节槽，按序号编号，`long long *` 前进 |
| ARM Thumb-2 | `__ARK_VA_WORD_SLOTS` | 每个 AAPCS 参数字一个 4 字节字，`va_start` 指向第一个变参字；64 位实参就是相邻两个字，读之前把指针向上取整到 8 字节（吃掉调用方为偶数寄存器对/8 字节栈槽留的空洞） |
| RV32I | `__ARK_VA_WORD_SLOTS` + `__ARK_VA_PACKED_WORDS` | 同上，但这个后端的参数字**没有对齐空洞**（a0..a7 平铺），所以不做 8 字节取整 |

ARM 的 va 区**就是调用方自己的参数镜像，不是它的一份拷贝**：变参函数的序言在
`saved registers` 之前把"还可能装变参的那几个寄存器"压栈，于是这些字正好落在调用方
栈参数块的下方，与之上方的栈参数构成一串连续的字——区里 word j 就是 r_(k+j)，
之后接着调用方栈参数块的第 0、1、2… 个字。`k` 是第一个可能装变参的寄存器号，
取 `NCRN` **向下**取到偶数：

| 命名参数字（NCRN） | 序言压 | 每次调用代价 | 尾声 |
|---|---|---|---|
| 0 或 1 | `PUSH {r0,r1,r2,r3}` | 16 B | `POP {..,lr}` + `ADD sp,#16` + `BX lr` |
| 2 或 3 | `PUSH {r2,r3}` | 8 B | `POP {..,lr}` + `ADD sp,#8` + `BX lr` |
| 4（含"有命名参数落在栈上"） | 不压 | 0 B | 普通 `POP {..,pc}`，栈参基址回到 `local_size+16` |

`k` 取偶数有四条理由：区基址恒为 `frame + local_size + 16`（因为 `sp_entry =
基址 + 压栈字节`），所以零拷贝不变；"把 ap 向上取整到 8"与"偶数 AAPCS 参数字"对任何
偶数 `k` 都等价（word j 在 `base+4j`，它是 8 对齐当且仅当 `(j-k)` 为偶，也就是
`k+j` 为偶）；压栈字节数是 8 的倍数，`sp` 保持 AAPCS 要求的 8 字节对齐（奇数 k 虽然
区遍历仍对，却会把帧顶弄成 4 mod 8，8 字节局部量或 GCC 编译的被调方可能因此出错）；
`k=4` 时一个字节都不用压。栈参数仍然**没有条数上限**，也不需要搬运循环。
`_ark_va_ptr` 不是真变量：后端在 `IR_PUSH_GLOBAL` 里直接把 `frame + local_size + 16 +
4*slot` 算进寄存器（`slot` 是变参在区里的起始字）。

RV32I 只从 a0-a7 传参，所以它的 va 区是**帧底**那 8 个字（`s0 - sp_size + 4*k`，
落在 `sp_size` 本来就留的 256 字节余量里，不额外占栈），`_ark_va_ptr =
s0 - sp_size + 4*命名参数字数`。

**穿过 `...` 的结构体：按字内联，不压地址。**

命名形参里超过 8 字节的结构体走本编译器自己的约定（压一个地址字，被调方 `IR_GETARG`
再 memcpy 进自己的帧里）——被调方看得到类型，双方约定即可。变参不是这样：**被调方没有
类型**，`<stdarg.h>` 只按连续的参数字往前走，所以载荷本身必须在线上。AAPCS 也不给这个
情形留间接层，gcc 同样内联（实测 `f(1, s12)` 落在 r1,r2,r3）：调用点把结构体按
`ceil(size/4)` 个字逐个压栈（word 0 在最上面，与"arg0 在 arg1 上面"一致），
`aapcs_assign()` 对超过两个字的实参**逐字**分配——装得下就进剩余寄存器，剩下的进栈
（实测 gcc：三个命名字之后的 12 字节结构体是 r3 + 栈上两个字，不是整体上栈）。
结构体地址只算一次（`IR_DUP`/`IR_SWAP` 把它留在栈顶，最后 `IR_POP` 丢掉），所以
`f(1, mk_s3())` 里的调用只发生一次。5..8 字节的结构体保持原来的两字规则（偶数寄存器对
/ 8 字节栈槽）。

这条**只有 ARM 支持**：RV32I 没有栈参数，C/x86_64 用的是 8 字节槽位镜像，把内联字塞进去
会被读成别的东西，所以它们由 `irgen` 直接报错
（`passing a 12-byte structure through '...' is implemented for the arm target only`），
不是静默错值。

一处**已知的有意偏离**：16 字节且 8 字节对齐的结构体（`struct {long long a,b;}`），
gcc 会把 NCRN 向上取到偶数再放，我们不做这个取整——因为 `<stdarg.h>` 只能按 `sizeof`
判断是否对齐（`_Alignof` 现已实现，但 `<stdarg.h>` 仍按 `sizeof == 8` 判对齐，调用侧也没做 NCRN 取偶，
所以这一格仍然没有对齐信息可用），取整留下的空洞它看不见，会当成第一个字读走。
两侧都是 arkc 时自洽（`struct8a` 用例钉住这一格）；与 gcc 编译的被调方混用时这一格会错位。

**一次调用的实参不超过 64 个**（各后端实参表的上限）。第 65 个起以前是静默丢弃，
现在是编译错误；ARM 另外限制总参数字 192 个（超过同样报错，不静默截断）。

> 这一节曾经是 8 KB 的镜像区（`frame+8000..8127`），每次变参调用都要把栈参数搬进帧里。
> 它通过了全部执行测试，却**在目标板上根本跑不起来**：板上的小程序任务栈只有 4 KB
> （`APP_TASK_STACK_SIZE`），而 8 KB 的帧一进去就溢出。现在 `run_va_gate.py` 会把每个
> 用例的**帧大小**也断言下来（`FRAME_CAP = 1024`），靠"能跑"过不了这一类。

这套东西是**执行过**的，不只是"能出汇编"：`examples/run_va_gate.py` 把同一份源码分别
交给 gcc（求期望值）和 arkcc → GNU as → unicorn（真跑），比对退出码，覆盖全寄存器实参、
寄存器+栈、寄存器对里的 64 位、栈上的 64 位、三个命名字后 64 位实参因奇数寄存器被逼上栈
的**跨界**情形、两种瘦身后的区形状（8 字节 / 0 字节）里的 64 位读、命名长整型把尾巴全
逼上栈、double、以及 float 实参按默认实参提升变成 double。另有一条 34 个参数字
（30 个在栈上）的用例，钉住"栈参数没有上限"。

五档开关一次跑完：`--opt-suite` 会自己把默认、`-O2`、`-fopt-regalloc`、
`-O2 + -fopt-regalloc`、`-O2 + -freg-top + -finline + -fopt-regalloc` 五组各跑一遍
再汇总判词。这档不是补充，是必需：`-fopt-regalloc` 会把保存块从 16 字节加宽，
`r0-r3` 镜像与调用者栈参数随之整体上移，`va_start` 的两个常量（`local+16+…`）
里的那个 16 就不再成立——不加平移时 near 档是 `20 passed / 29 failed`，全是数值错。

每个用例还要过三道静态断言，它们都不依赖外部工具链，所以板上那条路也有人看着：

- **帧大小**（`FRAME_CAP = 1024`）：按函数把连续的 `SUB sp, sp, #N` **累加**再比。
  早先取"单条最大值"，而大帧会被拆成 `4095+4095+810`，于是 9000 字节的帧被记成
  4095、轻松通过断言——这条现在有自检（自检里就放一个 9000 字节的假函数）。
- **帧对齐**：任何函数的序言（`PUSH…` + `SUB sp`）合计必须是 8 的倍数。它专门盯
  "少压一个字看起来免费"这类改动。
- **区形状**：`int f(int a, ...)` 必须 `PUSH {r0,r1,r2,r3}`，两个/三个命名字必须
  `PUSH {r2,r3}`，四个命名字必须**不压**。另有两组看编码与调用结果的断言：
  `POP {..,lr}` 的字节必须恰好是 `e0b5 bde8 e040 7047`，以及只声明不定义的
  `extern void`/`extern long long` 调用压几个字。

RV32I 剩下的是这个后端自己的边界，不是 va 特有的：它只从 a0-a7 传参（没有栈参数），
所以"超过 8 个参数字"被**明确拒绝**（`stack arguments are not implemented`），不再像以前
那样静默留下错值。64 位实参与变参里的 8 字节值都是真正的两个字（低字先压、高字压在上），
`__packed` 指针的 1/2/4/8 字节非对齐访问也一律逐字节读写；>8 字节的聚合体穿 `...`
按连续参数字铺开，读回时 `IR_LOAD_IDX` 的偏移是**元素下标**、由后端按元素宽度缩放。

**变参的调用与 `__asm` 写法**：`__asm int printf(const char*, ...)` 那种"声明有 `...`、
函数体是整段汇编"的写法不经过 va 区（`is_asm_func`），四个后端都照旧可用。float 实参
进变参调用时会先按 C99 6.5.2.2p6 提升成 double（`irgen` 发 `IR_F2F`），所以形参宽度按
8 字节算。

### 运行库依赖：哪些符号必须由外部提供

后端**不再自带**任何 AEABI 软浮 / 64 位整数辅助例程，也不自带 RV32I 的软浮例程。
它们属于目标运行库（AEABI 就是这么定义的），每个真实工具链都带：`arm-none-eabi-gcc`
的 `libgcc.a`、armcc 的 `armlib`。

| 用到了什么 | ARM Thumb-2 | RV32I |
| --- | --- | --- |
| `float`/`double` 算术（软浮） | `__aeabi_f*` / `__aeabi_d*`（`add/sub/mul/div`、`cmpeq/cmpgt/...`） | `__addsf3/__subsf3/__mulsf3/__divsf3`、`__adddf3/__subdf3/__muldf3/__divdf3` |
| 浮点与整型/浮点互转 | `__aeabi_i2f` / `__aeabi_ui2d` / `__aeabi_f2iz` / `__aeabi_d2lz` … | `__extendsfdf2`、`__fixdf*`（软浮实现内部再链） |
| 浮点比较 | `__aeabi_fcmp*` / `__aeabi_dcmp*` | `__eqdf2/__nedf2/__ltdf2/__ledf2/__gtdf2/__gedf2` |
| 64 位整数乘 / 除 / 取模 | `__aeabi_lmul`、`__aeabi_ldivmod`、`__aeabi_uldivmod` | `__muldi3` / `__divdi3` / `__udivdi3`（`libgcc`） |
| 64 位整数逻辑移位 | `__aeabi_llsl` / `__aeabi_llsr` / `__aeabi_lasr` | 内联（`slli`/`srli` 逐字拼） |
| 64 位整数加减 | **内联**（`ADDS`/`ADCS` 序列，不需要库） | **内联**（`sltu` + `add`/`sub` 进位链） |
| `memcpy` | 后端自带 `__aeabi_memcpy`（结构体赋值/传参/数组初始化都用它） | 后端自带同名块 |
| 硬件 FPU 模式（ARM `--fpu=hard`） | 上面的软浮全部换成 `VADD/VMUL/VCVT/VCMP`，不依赖运行库 | 无（RV32I 没有浮点扩展） |

因此：**用到浮点、64 位除法或 64 位↔浮点转换的镜像，链接时必须带运行库**。
不带不会算出错值——会在链接期以 `undefined reference to __aeabi_...` /
`undefined reference to __adddf3` 失败，这是刻意的：这些辅助例程曾被内联实现，
实测 `__aeabi_f2iz`、`__aeabi_fdiv`、`__aeabi_uldivmod`、`__aeabi_ldivmod`、
`__aeabi_dadd` 五个都是**静默错值**（详见 `src/backend/arm/backend_arm.c` 里那段注释），
所以整批删掉，把"算错"变成"链不上"。纯整数、不用 64 位除法的程序仍然零依赖。

RISC-V 侧同理：`arkcc -target riscv32 x.c -o x.bin` 出的镜像只含自己的代码，
软浮和 64 位乘除要另外链 `libgcc`（或换成 `-target riscv32` 下自带汇编器产出的
`.s` 交给完整工具链汇编链接）。

## 目录结构

```
ark c compiler/
├── include/                公共头文件（含 arkcc_config.h/config.h/opt.h/cpu.h/scatter.h）
├── src/                    编译器核心（lexer/parser/sema/ir/irgen/preproc/config/opt/cpu/scatter）
├── src/backend/arm/        ARM Thumb-2 后端（codegen + 汇编器 + 链接器 + 软浮/硬件 FPU + 完整 DWARF + TLS）
├── src/backend/c/          C 源码后端（宿主测试）
├── src/backend/x86_64/     两个 x86 后端：i386 cdecl（`x86`）+ SysV AMD64（`x86_64`）
├── src/backend/riscv32/    RV32I 汇编后端
├── stdlib/include/         内置标准库头文件
├── port/host/              PC 平台层
├── port/stm32/             STM32 平台层（platform/flash_fs/main_stm32 入口）
├── examples/               80 个测试样例（.c；run_tests.ps1 运行其中 75 个用例）
├── examples/stm32_selfhost_build/  板上自举例程（多源 .c → app.svcm → 板上执行）
├── mdk/STM32H743_ArkCC/    Keil MDK 工程
├── build_stm32_armcc.ps1   armcc5 构建 STM32 固件脚本（输出 arkcc_stm32.hex/.bin）
├── arkcc.cfg               默认运行时配置（INI 格式）
├── Makefile                gcc 主机构建脚本
├── docs/MANUAL.md          用户手册（中文，UTF-8）
├── docs/STM32_BUILD.md     STM32 + armcc5 构建手册（中文，UTF-8）
├── docs/DIAGNOSTICS.md     诊断层：与 armcc 逐字节对齐的排版契约（中文，UTF-8）
├── docs/CI.md              持续集成：跑什么、跳过什么、为什么（中文，UTF-8）
├── docs/ATOMIC.md          C11 _Atomic：Type 级传播、读-改-写拒绝、stdatomic.h 两支与门禁（中文，UTF-8）
├── docs/X86_64_BACKEND.md   x86-64（SysV AMD64）后端：寄存器、栈槽、重定位、执行级门禁（中文，UTF-8）
├── docs/MEMLINT.md         函数内内存 lint（--warn-mem）：判据、裁剪开关与实测代价（中文，UTF-8）
├── docs/ENUMCHECK.md       switch 漏掉枚举值（--warn-enum）：判据、裁剪开关与实测代价（中文，UTF-8）
├── docs/PASS_PIPELINE.md   可配置 Pass 管线（--pipeline / --print-pipeline）：阶段表、两剖面、裁剪与实测代价（中文，UTF-8）
├── docs/UNUSEDRESULT.md    丢弃返回值（--warn-unused-result）：判据、别名、裁剪与门禁（中文，UTF-8）
├── docs/MIR_CFG.md         MIR/CFG 与三条跨函数检查（不可达 / 未用 static / 递归）：图不变量、判据、刻意不报的形态、裁剪与门禁（中文，UTF-8）
├── docs/LOOPS.md           循环优化（--licm / --unroll）：搬什么不搬什么、零次迭代、唯一接受形状、上限与门禁（中文，UTF-8）
├── docs/TAILMERGE.md       块尾合并（--tailmerge）：五条规则与各自反例、算法、标签与栈深两处易错点、三层裁剪、字节账实测（中文，UTF-8）
├── docs/TAILCALL.md        尾调用变跳转（--tailcall）：两种可转形状、七条拒绝条件、发射序列为什么必须留 lr、三层裁剪、门禁与实测（中文，UTF-8）
├── docs/DIVCONST.md        除常数变乘魔数+移位（--divconst）：幅值法为何正确、三种无符号形状与 L==32 特例、五条拒绝、三层裁剪、45 项门禁与如实字节账（中文，UTF-8）
├── docs/XBLOCK.md          整块重复块消除（--xblock）：为什么条件分支收尾必须拒绝、跳转目标按块而非 label id 比较、只有标签的块如何归一化、改写形态、三层裁剪、26 项门禁与字节账（中文，UTF-8）
├── docs/RA_VSTACK.md       值栈 → 寄存器分配（-fopt-vstack）：为什么做在发射后的文本层、影子值栈与 r5/r7 双槽池、引用计数与三种必须物化的形状、七条安全护栏、四项改写规则与一项 peephole、有条件的第三槽 r4、23 项门禁与 ARM 全语料执行对账（中文，UTF-8，另有 .en.md）
├── docs/VSTACK_CFG.md      基于控制流的值栈（S7 预注册）：线性扫描 + 边界清空在 19 开关口径上量出 589 处 pin / 471 处 pool-full、便宜版 0 处与完整版上界 1,178 条 = 9.6%（故不能按 F1 收档）、目标模型（函数 CFG + 基本块 + join 状态：同一值须所有前驱同寄存器同槽位才可跨边界保留）、三个切片（S7a 只读影子求解报 `retainable`/`must_spill`/`poolfull_after`/`net`、S7b 新开关 `-fopt-vstack-cfg` 默认关且 OFF IS OFF、S7c 跨调用保留上界 10 条只登记）、冻结判据（S7a 净 ≥ 300 条 = 2.4% 才开工，S7b ≥ 3% 落地 / 1–3% 只登记 / < 1% 撤回）、**S7a 已实测：净 220 条 = 1.79% < 300 故收档**（591 处 pin 可保留、pool-full 471→952、两条独立算法 220/248）与反假绿强制块尾 flush 对照、四条不许的写法、预算法与排期（中文，UTF-8，另有 .en.md）
├── docs/SIZEWEIGHT.md     空间/速度连续权重（--size-weight 0..9）：四张门槛表、5 = 0.9.0 常量、为什么不给 -Oz/-Os/-Ot、派生宏与裁剪、31 项门禁、80 文件逐字节对账、以及「带参函数永不内联」这条已知欠账（中文，UTF-8）
├── docs/ADDR_FOLD.md        寻址折叠（-fopt-addr）：三条规则与安全性、为什么不实现两种写回形、第二遍运行（regalloc / vreg / slotreg / cmat 之后 12,795 → 12,346）、四臂门禁与 HAL 全语料实测（中文，UTF-8，另有 .en.md）
├── docs/STRENGTH.md        强度削减（-fopt-strength）：为什么一个开关两个落点、AC5 的对照证据、阶段位置踩坑（放在 dce 之后会因改变内联决策而变大）、索引缩放折进寻址方式、18 项门禁与 HAL 全语料实测（中文，UTF-8，另有 .en.md）
├── docs/CBZ_FOLD.md         零比较跳转折叠（-fopt-cbz）：一条规则与四条必要条件、offset = 区间−2 的推导、窗口上界与标志位扫描（含跟随 B）、超范围体不折、第二遍扫描（−51 条 / −544 B，146→95 处）、14 项门禁与 HAL 全语料实测（中文，UTF-8，另有 .en.md）
├── docs/BRANCH_SHRINK.md    短分支收缩（-fopt-branch）：汇编器内的测量轮/决策/重排轮、T1/T2 范围与 .align 拒绝、pass1 必须按最终宽度量的那个坑、18 项门禁（含远目标差分判据）与 HAL 全语料实测（中文，UTF-8，另有 .en.md）
├── docs/IMM_FOLD.md         常量折进立即数（-fopt-imm）：为什么必须做在发射期、两种形状、每个算子的编码守卫与拒绝清单、与 --reg-top 互斥、33 项门禁与 HAL 全语料实测（中文，UTF-8，另有 .en.md）
├── docs/PEEPHOLE.md         栈往返清理（-fopt-peep）：R1/R3/R5/R6 四条纯文本等价规则（R5 = 零位移 `ADD` 变 `MOV`；R6 = 中间不提及 `rY` 的 `PUSH {rX}` … `POP {rY}` 即一次经内存的 `MOV`）、`ip` 写法识别、为什么 volatile 不被误伤、放弃 R2/R4 的理由、pass 顺序与第二遍窥孔（−52 条 / −108 B）、12 项门禁与 HAL 全语料实测（中文，UTF-8，另有 .en.md）
├── docs/CBRANCH.md          比较结果直连分支（-fopt-cbranch）：IR 相邻判据、条件码表、两条注入路径与立即数兜底、与 --reg-top / -fopt-cbz 的关系、不折的情形、13 项门禁与 HAL 全语料实测（中文，UTF-8，另有 .en.md）
├── docs/COPYPROP.md         寄存器拷贝清理（-fopt-copyprop）：照 IAR ECT 逆向下放的两条规则、为什么不需要活跃性、「第一个操作数也读」这条被 emulator 抓出的修正、与 peep 的分工、147+241 分解与旧 1,141 估算的错因、17 项门禁（中文，UTF-8，另有 .en.md）
├── docs/LIVE.md             活跃性驱动清理（-fopt-live）：控制流图 + in/out 不动点、L1-L4 四条规则、拒绝清单、四个被测试抓出的真缺陷（两操作数隐式读目标 / pp_trim 剥缩进 / 比对时机 / 块范围里的伪指令读到上一函数的残留解析）与 ADC-SBC 三寄存器那条、与 copyprop 的分工、19,112 条实测、10 组门禁（中文，UTF-8，另有 .en.md）
├── docs/CMAT.md             常量与死拷贝删除（-fopt-cmat）：M1–M9 九条规则与块边界、两个被 emulator 抓出的致命读集错误（`MUL` 隐式读目标 / `STR` 首操作数是源）、`MOVW`+`MOVT` 为什么必须整体处理、那条实测 0 命中被删掉的去重规则、M8/M9 为什么必须建图而 M1–M7 不需要、M9 的标签链折叠与「每个前驱都要核 push」、16 开关基线 15,933 → 14,131（−11.31%）与 40,188 → 36,126 B 的逐规则分解、95 TU 逐文件差分（M8 删 571 / M9 删 238 / 增 0）、53 项门禁（中文，UTF-8，另有 .en.md）
├── docs/OPERAND_ALLOC.md    操作数分配（S3 预注册 + S3a 落地 + S3b 收档）：18,665 条指令的家族拆解（`[r6]` 1,879 / `[r5]` 1,414 / `MOVW`+`MOVT` 2,096 / `MOV rD,rS` 1,305 / `PUSH`+`POP` 1,791）、为什么文本层已量到底、切片 S3a（函数级 32 位常量缓存，实测重复 657 条、乐观上界 399 条）、与 `-fopt-regalloc` 抢寄存器与帧的真冲突及「PUSH 加宽只允许有一个所有者」的解法、七条门禁与四条否证、实现（第二个客户 / 入口材料化 / 重定位对子 poison）与被点亮的既有 PUSH 前缀匹配缺陷及修法、18,665 → 18,506 的实测与落地判决、S3b（跨调用活跃值）的机会度量与收档（38 个调用点里池寄存器活着的 0 个、真实跨调用只剩 5 对 / 0.11%）（中文，UTF-8，另有 .en.md）
├── docs/SLOTREG.md          槽级寄存器化（-fopt-slotreg）：预注册的影子寄存器模型为何被实测推翻、改成「只删不增」的 R1/R2 两条规则与安全论证（地址外流点、volatile、函数级弃权）、三个误编译的根因（memcpy 间接写 / t==3 写 r0 / STR 不清 valid）、18,729 → 18,665 的实测与按 <0.5% 收档的判决、7 组门禁（中文，UTF-8，另有 .en.md）
├── docs/FRAME_TRIM.md       帧裁剪（-fopt-frame）：删掉「压了但从不用」的被调用者保存槽、帧变空再删 `SUB`/`ADD sp`；VALUE 在栈不在代码（16-bit Thumb 下 `PUSH {r4-r7,lr}` 与 `PUSH {r7,lr}` 同长）；289/913 槽未用 = 1,156 B 栈；实测 −29 条 / −84 B、bigger TU 0；含 base_used bail、sp bail 与 2026-11-25 的栈平衡守卫（两处误编译：合成 padding 无人拆 + 分支上未配对 `PUSH {r0}`；守卫分三档，`keep_base` 只在每条返回路径都能靠 `MOV sp, base` 复原时才继续裁剪；相对修前净 +24 条 / +456 B，且修复后全语料 0 个「不平衡且无 base」函数）（中文，UTF-8，另有 .en.md）
├── docs/VOLDBM.md           volatile 帧屏障（-fopt-voldmb）：帧局部 volatile 访问的一对 `DMB SY` 在地址未逃逸时是纯开销；按 `IR_PUSH_ADDR` 携带的对象名做逃逸分析、不可归属则整函数退回；139 个 DMB 中 138 个来自 `__IO` 局部量；实测 −170 条（−1.38%）/ −616 B（−1.88%）、bigger TU 0、16 条门禁（中文，UTF-8，另有 .en.md）
├── docs/VOLMEM.md           volatile 访问的标记与屏障（只打标记默认零代价 / `-fopt-volbar` 才补屏障）：C11 6.5.2.3p3 的「基对象是 volatile 聚合」一层原先被 lvalue 路径丢掉，全局/成员/指针/位域四类访问都没带 `IR_AUX_VOLATILE`（优化器有权折叠=错答案风险），现已全站点补标（95 TU 与改前逐字节相同）；屏障层默认仍不发（ARMv7-M B2.3.7 单核不重排 Device 访问，armcc/armclang/IAR/GCC 全不发），无条件补发实测 +41.0%（12,113 → 17,081）、`DMB` 1 → 2,848，故做成默认关的 `-fopt-volbar`；24 条门禁（中文，UTF-8，另有 .en.md）
├── docs/CONSTCOND.md        条件为字面量的分支在编译期决断（`-fopt-constcond`）：前端把 `if (0)` / `while (0)` / `do {} while (0U)`（HAL 锁宏）/ 关掉的 `assert_param` 真的编成 `PUSH_INT k` + `JZ`，决断它属于纯记账（net stack effect 恒 0、k 是 IR 字面量），故在 IR 层改跳转并把 `PUSH_INT` 变 `NOP`，放在 `ir.dce` 之前让新不可达代码顺手清掉；95 TU `-O2` 实测 12,113 → 12,034（−79 条 / −0.65%）、403,432 → 401,949 B（−0.37%），12 个 TU 变化、无一变大；余下 37 处 `MOV #imm`+`CMP #0` 已定性为布尔物化/移位守卫而非字面量条件；19 条门禁、裁切 23/23（中文，UTF-8，另有 .en.md）
├── docs/BOOLMAT.md         布尔物化消解（-fopt-boolmat）：比较结果本身已是 0/1，故 `x != 0` 是恒等、`x == 0` 是取反，IR 层把多余物化拆掉，让 -fopt-cbranch / -fopt-imm 接手；三条规则 R1 帧往返 / R2 恒等 / R3 取反（贴分支时主动退让）；95 TU `-O2` 实测 12,266 → 12,146（−120 条）、405,833 → 403,994 B（−1,839 B），8 个 TU 变短、无一变大；余下 40 处 `ITE` 已定性为短路求值（`A||B` / `A?1:B`）的 CFG 级汇合物化问题；18 条门禁、裁切 24/24（中文，UTF-8，另有 .en.md）
├── docs/COALESCE.md         本地拷贝合并（-fopt-coalesce）：`-fopt-live` 的第五条规则 L5、段边界表与段内三条判定、为什么只处理「用后即死」几乎不命中、`BL` 隐式读写吃掉参数的错答案、18,509 → 18,151 的实测（−1.93%，无 TU 变大）、7 组门禁、裁切与登记的三条没做（中文，UTF-8，另有 .en.md）
├── docs/EXIT.md             退出路径上的帧维护消解（-fopt-exit）：函数体从不动 sp ⇒ 返回点的 `MOV sp, base` 写的是它已持有的值，连帧基址都没被读过时 `MOV base, sp` 也一并删；纯删除（不加标签、不改分支、不改帧大小），收尾的 `ADD sp, sp, #N` 与每个返回 `POP` 保留，体内动过 sp（VLA / alloca / 内联汇编）整函数拒绝；95 TU `-O2` 实测 12,146 → 11,913（−233 条、−1.9%）、403,994 → 400,499 B（−3,495 B），18 个 TU 变短、无一变大；E1 命中 139/166 个带帧函数、E2 再 48 个；18 条门禁、裁切 25/25（中文，UTF-8，另有 .en.md）
├── docs/BITMASK.md          取反掩码的直接编码（-fopt-bitmask）：`~常数` 被建成 `MOV rX,#imm` + `MVN rX,rX` 两步，紧接着的 `AND`/`MOV` 只消费结果 ⇒ 一步写成 `BIC rD,rD,#imm` / `MVN rD,#imm`；三条前提（三行相邻、`imm` 能被 `thumb_imm12_a` 编码、消费者是严格两操作数且 `rX` 之后死亡），活跃性证明（前向扫描 + label 跨越 + `POP` 视为写 + 无条件跳转跟踪 4 跳）；排在 `-fopt-cmat` 之后、`-fopt-litpool` 之前；95 TU（25 旗标 + `-fopt-exit`）实测 11,877 → 11,766（−111 条）、400,125 → 398,673 B（−1,452 B），关掉时与基线逐字节相同、0 失败 0 变大；折叠 61 站（`BIC` 35 / `MVN` 26）；`MVN/BIC` 立即数与 GNU as 逐字节对拍（含奇数旋转 `0xD0000 = 0xD0 ROR 20`）；18 条门禁、裁切 26/26（中文，UTF-8，另有 .en.md）
├── docs/VREG.md             虚拟寄存器分配（S6，`-fopt-vreg` 已实现，默认关：S6a 点消除 18,151→17,736 = −415，S6b 块内全量重命名 18,151→17,350 = −801 / −4.41%）：18,151 条对 armcc 5,629 / armclang 5,068 的 3.2–3.4× 差距、为什么文本层已到底（3,213 帧访问 + 1,120 暂存 + 741 `PUSH {r0}` = 28% 是「值必经内存或 r0」的直接开销）、目标模型（vreg + 线性扫描 + `r0-r3`/`r8-r11` 池、`r6` 保持帧基址、与 `-fopt-vstack` 二选一）、S6a–S6d 四切片（S6a 目标 −8% ≥1,450 条）、7 条冻结门禁与 F1–F4 否证、实施前的否定性度量（§10：默认 regalloc 空转、near +23、MOV 替换必亏、上界 1,714 条 = 9.4%，并把 S6a 修订为「槽缓存 + 改名消除」）、裁切 `ARKCC_FEATURE_VREG`、§11 落地实测（S6a 17,736、13 个 TU、最大 hal_dma −181、门禁 6 条全绿）与登记的 `-fopt-vstack` 六实参缺陷、§12 S6b 块内全量重命名（17,350、−4.41%、14 个 TU 无一变大、8 条门禁全绿、四个真缺陷：汇编器高寄存器截断 / 两操作数移位角色反了 / `vg_reads_reg` 读写不分 / 原地重命名覆盖）、§13 S6c 区域跨 call（`vg_lk=5` / `saved_mask` / `dr>=4`；新夹具 `crossbl` 一上就顶出两个错答案——区域里零改名仍删 load、以及调用参数/`PUSH` 名单/返回值三处隐含读者——修后按当前口径 17 开关 14,954 → 18 开关 14,271 条 / 36,114 B，并如实写明先前 −415/−801 含错答案换来的收益；§14 记 `vg_hi_mask` 恒空导致与常量缓存抢 `r8-r11` 的修复与 +53 条代价、§15 记 S6b-2 块间活跃性的实测上界 266 条 = 1.96% 并按 F1 收档）、以及写死的不承诺（不打到 5,629，S6a+S6b 中间目标 12,700 −30%）（中文，UTF-8，另有 .en.md）
├── docs/DEADSTATIC.md       未被引用的 `static` 函数不再发射（默认生效、无开关）：可达性不动点与五种边、永不删的清单与入口点名、内联汇编文本扫描的边界与响亮失败、95 TU 18,151 → 16,414（−9.57%，叠 vreg 15,613 / −13.98%）、24 项门禁与两条逃生门（中文，UTF-8，另有 .en.md）
├── docs/MOVIMM.md           常量材料化：0..255 / MOVW / 修改立即数 / MVN / 双字五档的选择与标志位口径、为什么 MOVW 不需要后面的 MOVT #0、无符号立即数解析、-O2 上 −451 条（51,416 → 50,965）与 −1,804 字节（116,380 → 114,576）的同源对拍、门禁（中文，UTF-8，另有 .en.md）
├── docs/LITPOOL.md          32 位常量进字面量池（-fopt-litpool）：`4(c−1)` 收益模型、为什么必须是文本级且排在 cmat 之后、新增汇编器形式 `LDR rd, <label>` 与固定 32 位编码（越界报错不截断）、按终止指令切区域与 800 条合并上限、为什么只认无条件形式、五条拒绝、约 108 KB 静态表与板端裁切、18 开关 14,271 → 19 开关 13,566 与 807/96/0/711/705 的配对审计、`−2,820+1,436+250=−1,134` 的字节账、21 项门禁（中文，UTF-8，另有 .en.md）
├── docs/BUILD.md            Windows / Linux / STM32H743 三平台构建与裁切阶梯：工具链矩阵、两种内存布局实测、`make stm32-check` 装得下的机器判定、裁切后 23 个 `-fopt-*` 逐个按名拒绝（23/23）与三平台验证状态（Windows 已验 / H743 已验 / Linux 未验，如实标注）（中文，UTF-8，另有 .en.md）
├── docs/COMPARISON.md       与 armcc / armclang 的横向对比：语料与口径、9 行结果表与相对比值、十个优化开关、四条结构性差距与逐项实测、复现脚本、三种「不该读成」（中文，UTF-8，另有 .en.md）
├── docs/BOUNDARY.md         打不过 armcc 的结构性边界（诚实账）：2.19× 指令 / 2.35× 字节（12,304 对 5,619、32,690 对 13,920）、三臂指令构成表、差值分解（6,685 条里 4,303 条 = 64.4% 是「值运输」）、三条结构性原因（值栈机 / 每值过 r0 / 地址每次重算）、还剩什么能省（常量池已落地 −705 条 / −1,134 B、`PUSH {r0}` 487、重复物化 1,198（实测上界 297 = 2.41%）、reg-reg 拷贝 1,506（实测上界仅 208 = 1.63%）——两项均已按 F1 收档）、第二次活跃性（litpool 之后再跑一遍 13,566 → 13,116）、R5 + 第二遍窥孔（13,116 → 12,795）、第二遍寻址折叠（12,795 → 12,346）、R6 + `ip`（12,346 → 12,304）、已做完清单与不承诺（中文，UTF-8，另有 .en.md）
├── docs/SLOT_REGISTERS.md   槽级寄存器化（S2 预注册，未实现）：为什么文本层余量只剩 ≤0.7%、`-fopt-regalloc` 两档在 HAL 上是 1:1 变形的反证、块内影子槽缓存状态机（clean/dirty）、成本式 (F+W)−(R+S)、七条冻结门禁、四条否证条件、与 `-fopt-vstack` 抢同一批栈往返的叠加要求（中文，UTF-8，另有 .en.md）
├── docs/IPO_LTO.md         全程序编译（--ipo / -flto）与跨 TU 常量传播（--const-global）：为什么不是对象级 LTO、合并语义、拒绝的组合、裁剪与两条门禁（中文，UTF-8）
├── docs/OBJ_IR.md          对象里的 IR 载荷与链接期重编（--obj-ir / -link --lto）：载荷格式、合并的池 remap、逐字节等价、拒绝与诊断、裁剪与门禁（中文，UTF-8）
├── docs/PARTIAL_LINK.md    部分链接（-r）：机器码作准、符号/重定位 rebase、数据段不搬、三类拒绝、可替换性与幂等、裁剪与门禁（中文，UTF-8）
├── docs/BOARD_VALIDATION.md 板端全功能验证（0.9.0 判据）：54 用例 × 三档、实测读数、门禁自检与全部根因（中文，UTF-8）
├── docs/FLOATLIT.md        浮点字面量的精确转换（单次舍入）：两个 1 ulp 错答案的实例、旧实现三处中途舍入、2304 bit 定点大数与除以 5^k 的二进制长除、prec=53/24 两档与 float 后缀为何不经过 double、400 位与 100000 指数的如实上限、板端 1,464 B `.bss` 与栈零占用、419 例门禁（含三条防假绿）与 178,549 例独立对拍、95 TU 语料逐字节不变（中文，UTF-8，另有 .en.md）
├── docs/从零写一个C编译器.md  教材体逐代码教程：19 章，从 30 行到 3 万行（中文，UTF-8）
├── docs/from-scratch-c-compiler.en.md  上述教材的英文摘要（结构、章目、阅读路线）
└── README.md               项目简介（UTF-8）
```

英文版与中文原件并排存放，文件名形如 `docs/X.en.md`（`docs/X.md` 保持中文）；`README.en.md` 是
`README.md` 的英文对应版。每一对文件顶部都有一行语言切换。除 8740 行的教材只给英文摘要外，
其余文档都有完整英文版。

## 构建

### 方式 1：gcc 构建（用于主机开发与测试）

```bash
make            # 生成 arkcc.exe
make test       # 编译 examples + reloc-text / stdlib / install / x86-64 门禁
make clean
```

同一份 `Makefile` 在 Linux 上直接 `make CC=gcc`（非 Windows 分支自己换产物名、`RM` 与空设备）；
裁切档要在 H743 上跑，用 `make stm32-check` 让 armlink 按真实板级内存回答
"装不装得下"（需要 armclang/armlink/fromelf，缺工具链时明确打印 `SKIP`）。
三平台与裁切阶梯见 [docs/BUILD.md](docs/BUILD.md)。

### `make install`（DESTDIR / PREFIX）

```bash
make install                                   # 装到 PREFIX（默认 /usr/local）
make install PREFIX=$HOME/arkcc                 # 换安装根
make install DESTDIR=/tmp/stage PREFIX=usr/local  # 打包暂存（文件落在 /tmp/stage/usr/local）
```

装出来的布局：

```
$PREFIX/bin/arkcc[.exe]        编译器
$PREFIX/include/ark/*.h        22 个标准头文件
$PREFIX/lib/ark/src/*.c|*.s    库源码（不预编译：镜像要哪一份运行时由链接方决定）
$PREFIX/lib/ark/src/arm/*      平铺 ARM 镜像用的 AEABI / setjmp 汇编
$PREFIX/lib/ark/README.md      这份库该怎么给某个 target 编译
```

三条硬约定：**`DESTDIR` 是暂存根，`PREFIX` 必须是它内部的相对路径**（给了 `DESTDIR` 又给绝对
`PREFIX` 直接报错——否则在 Windows 上 `os.path.join()` 会丢掉 `DESTDIR`，文件静默装到
`PREFIX` 本身上去）；**从不删除任何文件**，内容不同的才覆盖；**装完逐字节读回比对**，
不一致就失败。重复跑 `make install` 不会给任何文件重打时间戳（38 个文件 mtime 全不变），
`--dry-run` 一个字节都不写。

> Git Bash / MSYS 会把 `/usr/local` 改写成 `C:/…/PortableGit/usr/local` 再传给脚本，
> 所以在这类 shell 下要么用 Windows 风格路径（`make install PREFIX=C:/ArkCC`），
> 要么 `MSYS_NO_PATHCONV=1 make install DESTDIR=/tmp/stage PREFIX=usr/local`。

### 方式 2：armcc5 构建（生成 STM32 固件）

```powershell
# 需要 Keil MDK 5.x，armcc.exe 在 PATH 或位于 D:\Keil_v5\ARM\ARMCC\bin
powershell -ExecutionPolicy Bypass -File build_stm32_armcc.ps1
# 输出：bootstrap_x86\armcc_objs\arkcc_stm32.{elf,hex,bin}
```

详细说明见 [docs/STM32_BUILD.md](docs/STM32_BUILD.md)。

## 命令行

```
arkcc <file.c|file.s> [选项]
  -o <file>          输出文件
  -S                 仅输出汇编文本
  -c                 仅编译不链接（.ark_obj，ARKOBJ2 容器）
  -E                 仅预处理
  -link a.o b.o      链接多个 .ark_obj（多个对象各自带 .data/.bss 时报 SRAM 重叠）
  -v                 详细模式
  -target <name>     arm | x86_64 | x86 | riscv32 | c（默认 arm；x86_64 是真 SysV AMD64
                     后端，i386 是 x86 的别名，x86-64/amd64 是 x86_64 的别名）
  -I <dir>           头文件搜索路径
  -O0/-O1/-O2        优化级别（0=无，1=基本常量折叠+DCE，2=激进）
  -g                 输出 DWARF 调试信息
  -config <file>     加载 INI 配置文件（默认 arkcc.cfg）
  -f<feature>        启用特性（vla/complex/wchar/trigraph/fpu/dwarf/...）
  -fno-<feature>     禁用特性
  -Wno-unused        抑制未使用警告
  --list-backends    列出后端

  诊断输出
  --diag_style <s>   arm（默认）| gnu | ide | modern；modern 为 clang 形状（别名 clang）
  --errors <file>    把整条诊断流写入文件（同 armcc）

  目标 CPU 选择
  -mcpu <name>       Cortex-M3/M4/M7/M33 等
  --cpu <name>       armcc 风格同义词
  --thumb            强制 Thumb 模式
  --arm              强制 ARM 模式
  --fpu <type>       soft/hard（软浮 / 硬件 FPU）

  依赖生成
  -MMD               生成 .d 依赖文件（同 gcc）
  --depend           同 -MMD
  -MF <file>         指定依赖文件名

  段与代码生成
  --split_sections   每函数一段（.text.<fn>）
  -ffunction-sections 同 --split_sections

  语言兼容性选项
  --dollar           允许标识符包含 `$`
  --enum_is_int      强制 enum 底层类型为 int
  --signed_chars     char 默认有符号
  --unsigned_chars   char 默认无符号
  --wchar16          wchar_t 为 16 位
  --wchar32          wchar_t 为 32 位

  DWARF 调试版本
  --dwarf2           DWARF v2
  --dwarf3           DWARF v3

  本轮新增（运行期默认全关，不加选项时产物与旧版逐字节相同）
  --reloc-data       多对象数据段搬迁（不加则多对象共用全局时仍报 SRAM overlap）
  --reloc-text       段内绝对地址链接期修正（字符串字面量等 MOVW/MOVT 里的
                     代码地址；多对象或镜像装到别处时必须开，否则读到旧基址）
  --rt-lazy          运行库按需发射（只发可达块）
  --reg-top          IR 栈顶值驻留 r0
  --asm-extra        汇编器扩展指令集；--no-asm-extra 显式关掉
  --warn-mem         函数内内存 lint（返回自动对象地址 / double free /
                     use-after-free / 自动对象地址存进全局 / 常量下标越界）；
                     --no-warn-mem 显式关掉
  --warn-enum        switch 的控制表达式是枚举且没有 default 时，检查是否漏了
                     枚举值；--no-warn-enum 显式关掉
  --pipeline=<p>     优化管线剖面：full（默认，各阶段仍由自身开关与 -O 决定）
                     或 lite（只留便宜阶段，跳过 dce-cfg / inline / vectorize）
  --print-pipeline   逐行打印每个阶段的决策：run 或 skip + 跳过理由
  --warn-unused-result  调用被声明为 warn_unused_result / __must_check 的函数
                     却丢掉返回值（f();）时告警；(void)f(); 是显式丢弃，不告警
  --warn-unreachable 控制流上任何路径都到不了的代码块（--no-warn-unreachable 关）
  --warn-unused-static  static 函数无人调用且地址未被取（--no-warn-unused-static 关）
  --warn-recursion   调用图里的调用环，含自递归（--no-warn-recursion 关）
  --licm             循环不变量外提：把计算搬进帧临时量、store 留在原地
                     （需要 -O1 以上；--no-licm 显式关掉）
  --unroll           常量边界的规范 for 循环完全展开（上限 ARK_UNROLL_MAX，
                     默认 8）；--no-unroll 显式关掉
  --tailmerge        块尾合并：多个基本块以完全相同的指令序列收尾时只留一份，
                     其余改成跳到它前面（需 -O1 以上；--no-tailmerge 关）。
                     只合并求值栈深度为 0 的尾段；深度模型不成立就整函数放弃
  --tailcall         尾调用变跳转：return g(args); 在实参全部走 r0-r3、且返回值原样
                     交还调用者时，拆本帧后发 B g 而不是 BL（两帧并一帧）。
                     有栈参 / 间接调用 / 结构体或 _Complex 返回 / __naked / __irq /
                     可变参一律不动；--no-tailcall 关（默认关）
  --divconst         除常数变乘魔数 + 移位：x / 3、x % 8u 这类除数在编译期已知时，
                     把 SDIV/UDIV 换成 UMULL 加移位（2 的幂退化成 LSR / AND）；
                     除数为 0 / 1 / -1 / 有符号 2^31 时原样发除法；体积通常变大，
                     只有无符号 2^k 变短；--no-divconst 关（默认关）
  --xblock           整块重复块消除：两个基本块逐条指令相同、入口求值栈为空、
                     且只以一条写着去处的跳转 / return 收尾时，只留一份，其余就
                     地改成跳到它前面（需 -O1 以上；--no-xblock 关）。条件分支收尾、
                     出口不同、短于 4 条、含内联汇编的块一律不动
  --size-weight=N    空间/速度连续权重（0..9，默认 5）：同时移动内联上限、展开上限、
                     尾合并与整块合并的最小长度。0 = 速度优先，9 = 体积优先；5 的四张
                     表项等于 0.9.0 的常量，所以不写这个选项产物逐字节不变
  -fopt-vstack       值栈留在 r5/r7（够深时再加 r4）：表达式求值的 PUSH/POP 成对消除，目的寄存器
                     retarget、只读操作数直接换成池寄存器；池槽引用计数、同行/跨操作数
                     读写与 ADC/SBC/MUL 原地形先物化、MOVW/MOVT 永不 retarget，识别
                     不了就整函数原样输出；-fno-opt-vstack 关（默认关）
  -fopt-addr         寻址折叠：把 ADD/MOV 算出的地址折进 LDR/STR 的寻址方式
                     （常量偏移、寄存器索引两种），删掉多余的地址算术；被折寄存器
                     在本函数内若还被后续指令读就不折，屏障指令放行；两种写回形
                     实测从不发射故不实现；-fno-opt-addr 关（默认关）
  -fopt-strength     强度削减：把乘 2^k 换成左移（x*1 直接删），元素大小缩放
                     p[i] 的 i*sizeof 同样换成一条 LSL；`-fopt-addr` 折掉 ADD
                     之后，紧邻的 LSL 再并进寻址方式成 [Rn, Rm, LSL #n]；
                     非 2 的幂保持 MUL（Cortex-M4 上 MUL 一周期，移位链不会更短）；
                     -fno-opt-strength 关（默认关）
  -fopt-cbz          零比较跳转折叠：CMP rX, #0 紧跟 BEQ/BNE 时并成一条 CBZ/CBNZ
                     （16 位，省一条指令和 4 个字节）；只在目标前向、窗口上界
                     ≤64 字节、且标志位确定已死时才折，认不出就原样保留；
                     -fno-opt-cbz 关（默认关）
  -fopt-branch       短分支收缩：目标落在 16 位范围里的 B / B<cond> 从 4 字节
                     缩成 2 字节（条数不变、字节变少）；汇编器先按每分支 4 字节
                     量一遍再决策，跨度跨 .align 的分支不缩，放不下就保持 32 位；
                     -fno-opt-branch 关（默认关）
  -fopt-imm          常量折进立即数：PUSH k 紧跟算术/比较时改成指令立即数，
                     常量不再走值栈；每个算子先过编码闸门，装不下就原样保留；
                     -fno-opt-imm 关（默认关）
  -fopt-peep         栈往返清理：PUSH/POP 变成一条 MOV、同槽 STR 后的 LDR
                     删掉、零位移 ADD 变成 MOV；跨标签不配、多寄存器帧
                     PUSH 不匹配；pass 在最终文本上再跑一遍；
                     -fno-opt-peep 关（默认关）
  -fopt-cbranch      比较结果直连分支：比较的下一条正好是条件跳转时直接
                     CMP + B<cond>，不再物化成 0/1 再复测；值另有消费者时不折；
                     -fno-opt-cbranch 关（默认关）
  -fopt-pair         值栈操作数配对：两个相邻压栈 + 读它们的二元运算并成
                     左→r0、右→r1 直接算，两对 PUSH/POP 连同寄存器搬运消失；
                     常量与比较分支分别让给 -fopt-imm / -fopt-cbranch；
                     64 位、volatile、>8 字节对象不动；-fno-opt-pair 关（默认关）
  -fopt-prop         局部槽常量传播 + 死存储删除：把写入后没再改的帧槽常量
                     前向传播、把没人读的 store 连同压栈一起删掉；常量必须
                     一条指令装得下、紧跟同槽 STORE 的读不动；
                     -fno-opt-prop 关（默认关）
  -fopt-deadpush    丢掉语句赋值的读回压栈：赋值后紧跟的读回与随后的丢弃
                     一起删掉；volatile、四字复杂对象、宽度不符不动；
                     -fno-opt-deadpush 关（默认关）
  -fopt-copyprop     寄存器拷贝清理：删掉被完全覆写却没被读的 MOV，把
                     MOV rD,rS 推进到紧邻的 OP rD,rD,X 里；跨标签/分支/PUSH
                     不判；-fno-opt-copyprop 关（默认关）
  -fopt-live         活跃性驱动清理：为每个函数建控制流图算寄存器活跃性，
                     删跨块的死拷贝、把拷贝推进到唯一的消费者、丢掉零索引、
                     把 MOVW/MOVT 常量直接落进目标；-fno-opt-live 关（默认关）
  -fopt-cmat         常量与死拷贝删除（九条规则）：把已知 0..255 常量的拷贝折成
                     立即数、把已知索引折进寻址方式（k<<s <= 4095）、删掉被块内
                     后写覆盖的标志中性写、常量穿三操作数移位与扩展、已知 CMP 之后
                     的条件分支当场判定、删掉值栈的 PUSH/POP 推拉对、按活跃性删掉
                     全函数范围内死掉的常量与拷贝，以及删掉合流处的 PUSH/POP 回环；
                     MOVW/MOVT 对整体处理；-fno-opt-cmat 关（默认关）
  -fopt-slotreg      槽级寄存器化：删掉「r0 已持有该槽」的重复重载，以及永远不会
                     被观察的死写（全函数 0 读且地址未外流、或块内被后写覆盖）；
                     只删行不插入，帧布局与寄存器分配完全不变；
                     -fno-opt-slotreg 关（默认关）
  -fopt-constcache   函数级常量缓存：同一函数里被材料化 >=5 次的 32 位常量在入口
                     一次建进 callee-saved（r8-r11），其余使用点改 MOV rD, rC；
                     与 -fopt-regalloc 共用同一段保存寄存器（只加宽一次、偏移只
                     平移一次）；-fno-opt-constcache 关（默认关）
  -fopt-litpool      32 位常量进字面量池：MOVW+MOVT 两条换成一条 LDR rD, <label>；
                     文本按终止指令切区域、相邻区域合并到 800 条以内、每组一个池放在
                     该组终止指令之后；.arkdata 链接器补丁对、超范围、超大函数一律不动；
                     -fno-opt-litpool 关（默认关）
  -fopt-coalesce     本地拷贝合并：MOV rD, rS 之后那段直线代码里把 rD 全部改名成 rS
                     并删掉拷贝（r0-r7、d!=s、都不是 r6），标签/分支/IT/写回/寄存器列表/
                     BL|BLX 处停，rD（及段内重定义时 rS）结束时必须不活跃；-fopt-live
                     的第五条规则，只开它时行为等价于「只做 L5」；
                     -fno-opt-coalesce 关（默认关）
  --ipo / -flto      全程序编译：一次吃多个 .c，在同一个 IR program 上做跨文件
                     优化（-O2 下跨文件内联），static 按单元改名、外部名按链接器
                     规则去重、无引用的 static 剪掉；必须给 -o，
                     拒绝 -c/-E/-g/-link 与 .s/.o 输入
  --const-global     跨 TU 常量传播：把 const 对象的读取折成立即数（需 -O1 以上）。
                     只认「const + 标量整型初值 + 从不被写 + 地址从不外泄 + 非
                     volatile/数组/聚合/long long + 无 __at/section/__thread」，
                     任一不满足就保留 load；--no-const-global 显式关掉
  --obj-ir           配合 -c：把管线之前的 IR 序列化后追加进 ARKOBJ2 对象，
                     供 -link --lto 读回重编；--no-obj-ir 显式关掉。
                     拒绝汇编输入与文本后端（-target c）
  --lto              配合 -link：从对象里读回 IR、合并、跑一遍管线、重新出码，
                     结果与 --ipo 逐字节相同。必须写在 -link 之前，
                     拒绝 -c/-E/-g/缺 -o/无输入
  -r                 配合 -link：把 N 个 ARKOBJ2 对象合并成一个新对象（机器码、
                     符号表、重定位表各合成一份），不是镜像。必须给 -o；
                     拒绝 --lto/-c/-S/-E/-MMD、带 IR 载荷的对象、两个 RAM 拥有者、
                     混用 riscv32 与非 riscv32
  --dce-cfg          基本块级可达性 DCE（只删"能到但永不执行"的代码）
  --build-date <s>   固定 __DATE__（如 "May 28 2026"）
  --build-time <s>   固定 __TIME__（如 "20:26:40"）
  --source-date-epoch <n>
                     用 Unix 时间戳同时确定 __DATE__/__TIME__（可复现构建）
```

构建时间、宏重定义检查、scatter 布局校验、依赖文件上限这几项只有编译期宏
（见 `include/arkcc_config.h`），默认值与行为见
[docs/从零写一个C编译器.md](docs/从零写一个C编译器.md) 附录 D.4「开关总表」。

## 配置系统

arkcc 支持三层配置，优先级：**命令行 > 配置文件 > 编译时默认值**。

- **编译时开关**（`include/arkcc_config.h`）：`ARKCC_FEATURE_*` 宏决定哪些特性被编入 arkcc 本身。
- **运行时配置文件**（`arkcc.cfg`，INI 格式）：`[features]` 段切换各特性；`[general]` 段控制优化级别和调试信息。启动时自动加载当前目录的 `arkcc.cfg`；也可用 `-config <file>` 指定。
- **命令行覆盖**：`-O0/-O1/-O2`、`-g`、`-f<feature>`、`-fno-<feature>`、`--dollar`、`--enum_is_int`、`--signed_chars`/`--unsigned_chars`、`--wchar16`/`--wchar32`、`--dwarf2`/`--dwarf3` 覆盖文件设置。

`arkcc.cfg` 示例：

```ini
[features]
vla               = 1
complex           = 1
wchar             = 1
trigraph          = 1
fpu_hw            = 1
dwarf             = 1
opt_constfold     = 1
opt_dce           = 1
opt_regalloc      = 0
enum_is_int       = 0
dollar_in_identifiers = 0
split_sections    = 0
signed_chars      = 0
wchar16           = 1
wchar32           = 0
dwarf_version     = 2

[general]
opt_level   = 0
debug_info  = 0
```

## 优化

`-O1` 及以上启用 IR 级优化Pass（`src/opt.c`）：

- **常量折叠**：`PUSH_INT a; PUSH_INT b; BINARY op` 三元组折叠为 `PUSH_INT (a op b)`，多趟扫描至不动点（最多 8 趟）级联折叠。除零/取模零不折叠，以保留运行时行为。
- **死代码消除**：移除 `RETURN/JMP/JMP_NAMED` 之后、下一标签之前的不可达指令。

每个 Pass 同时受编译时 `ARKCC_FEATURE_OPT_*` 宏和运行时 `g_config.enable_opt_*` 标志守护。

## 调试信息

当设置 `-g` 或 `g_config.debug_info=1` 时，ARM 后端在汇编输出中发射 GNU-as 风格 DWARF 伪操作和完整调试段：

- `.file 1 "<src>.c"` 源文件注册
- `.cfi_startproc` / `.cfi_endproc` 函数帧信息
- `.loc 1 <line>` 行号映射
- `.size <fn>, .-<fn>` 函数大小
- `.type <fn>, %function` 类型标注
- `.debug_info` / `.debug_abbrev` / `.debug_line` 完整 DWARF 段（用 `--dwarf2`/`--dwarf3` 切换版本）

## 测试

**持续集成**：`.workflow/main-pipeline.yml`（Gitee Go，仓库主线在 Gitee，这是真正会跑的那条）与
`.github/workflows/ci.yml`（GitHub Actions，镜像到 GitHub 时才生效）做同一件事——用宿主 gcc 构建
arkcc、`pip install unicorn`、然后 `make test`。只依赖 gcc/make/python3，不碰交叉工具链和硬件；
PowerShell 门禁（Windows 专用）、`make stm32`、需要 armcc/臂工具链的对拍、板载自托管都不在 CI 里。
跑什么、跳过什么、为什么，见 [docs/CI.md](docs/CI.md)。

```powershell
powershell -ExecutionPolicy Bypass -File examples\run_tests.ps1   # 75 个用例（71 断言 + 4 跳过）
powershell -ExecutionPolicy Bypass -File run_full_test.ps1        # 73 个样例全量回归
python tests/run_stdlib_tests.py                                  # 标准库门禁（编译→多对象链接→unicorn 真跑）：21 个用例的期望值全是程序自己算出来的数；`strtod` 一例 SKIP 并打印实测理由（宿主 emulator 没有双精度 FPU，不是库的问题）
python tests/run_x86_64_image_tests.py --arkcc ./arkcc.exe        # x86-64 门禁：35 个程序编成 0x400000 平铺镜像、在 unicorn 64 位核上跑 main，期望值全在程序之外算出；另含「未解析符号必须拒绝且不留镜像」与「期望值 +1 必须被判成 DIFF」两段自检。每个程序再编一次 32 位 i386 并再跑一遍，i386 结果与期望不符即判 FAIL（不再当脚注）
python tests/run_install_tests.py                                 # `make install` 门禁：38 个文件逐字节等于源、第二次跑不改任何 mtime、`--dry-run` 不写盘、绝对 PREFIX + DESTDIR 被拒；最后拿**装出来那棵树**建一个用到 malloc/div/qsort 的程序跑出 181（宿主 gcc 同一份源码算 181，对拍）
python tests/run_diag_tests.py                                    # 诊断排版门禁（需 armcc）
python tests/run_diag_boundary.py                                 # 诊断边界契约（长行/上限/CJK/tab，无需 armcc）
powershell -ExecutionPolicy Bypass -File run_asm_test.ps1         # 汇编输入门禁（.s/.S/.asm/.ASM）
powershell -ExecutionPolicy Bypass -File run_arm_exec_test.ps1    # ARM 执行级：编译→链接→QEMU 真跑（需 qemu-system-arm）
python tests/arm_exec/run_arm_exec.py                             # ARM 执行级（unicorn，无 qemu 也能跑；每例同时跑 --reg-top 臂）
python tests/asm_cases/run_asm_cmp.py                             # 汇编器对拍：arkc vs arm-none-eabi-as，含 --asm-extra 开关契约
python tests/run_atomic_tests.py --arkcc ./arkcc.exe                # 或 make test-atomic；_Atomic / <stdatomic.h> 门禁（五个目标）：目标身份宏恰好一个、armcc 的 arm 宏只在 arm 出现、11 个原子操作在四个非 ARM 目标上必须编译期报错且不留产物、atomic_init 必须处处能编；末尾自检要求同一份源码在 arm 上**不**被拒（否则"拒"这个判据没有分辨力）
python tests/run_c11_keywords_tests.py --arm-as <bin> [--rv-as <bin>]  # C11 关键字门禁（ARM + RV32I 双目标，32 项）：每个运行时用例都由程序自己算地址/值（汇编里出现 `.balign` 不算证据），另含静态断言真/假对照与三条自检
python tests/run_arm_int64_tests.py --arm-as <bin>                # 64 位数据通路门禁（ARM，12 项）：加减内联 / 移位 / 比较 / 除模走运行库，含"运行库仍然必需"自证
python tests/run_arm_abi_mix_tests.py --arm-as <bin>              # AAPCS 混编门禁（ARM，16 项 × 双向）：arkcc 与 arm-none-eabi-gcc 各持一侧、unicorn 跑同一镜像，钉住"穿过 ... 的复合体按 alignment 取偶""8 字节 align-4 复合体可拆分"与寄存器/栈之间的空位；纯 arkc 的同源 oracle（run_va_gate.py）看不见这类分歧，所以必须有这一道
python tests/run_rv_float_tests.py --arm-as <bin> --arm-libgcc <libgcc.a> --rv-as <bin>  # RV32I 软浮点门禁（22 项）：浮点算术/比较/转换与 gcc 对拍
python tests/run_capacity_tests.py                                  # 容量门禁：120 对象 / 1200 头文件 / 520 条 -D / 129 条 -I（宿主不许有人为上限）
python tests/run_rv_alloca_tests.py --rv-as <bin>                   # RV32I VLA 门禁：5 个用例与 gcc 对拍且各自断言硬编码期望值（两臂同时错也算错），覆盖早返回（尾声重建 sp）、两个 VLA、10 个栈参数（对齐）、`long long` VLA
python tests/run_rv_image_tests.py [--rv-as <bin>]                   # RV32I 扁平镜像门禁（8 例）：编译成镜像 → 在 RISCV32 unicorn 上跑 `main` 比对硬编码期望值；校验镜像尾部就是最后一节的内容（不许有多余对齐填充）；三条拒绝用例（未知助记符 / 分支越界 / 未定义外部符号）必须失败且**不产镜像**；给 `--rv-as` 时再用对齐布局的链接脚本让 GNU as/ld 产一份参考镜像，要求逐字节相同
python tests/run_rv_link_tests.py                                 # RV32I 对象模式门禁（6 例 + 3 拒绝 + 自检）：`-c` 出机器码对象、`-link` 串成一张镜像；跨 TU 调用 / extern 全局 / 跨对象读数组 / 两个 TU 各自的 `static helper` 不许撞名 / `.word sym` 绝对地址 / 三对象。未解析符号、跨对象分支、RV 对象缺 `-target riscv32` 必须失败且**不产镜像**；每个用例都在 riscv32 unicorn 上跑 `main` 比对硬编码值，另含"改了运算符必须看见不同答案"的自检
python tests/run_rv_misc_ir_tests.py --rv-as <bin> [--arm-as <bin> --arm-libgcc <libgcc.a>]  # RV32I 其余 IR 门禁（23 项）：内联汇编、`__svc`/`__smc`（RV 侧用 unicorn 的 `UC_HOOK_INTR` 当内核，校验 a7/参数/回值整条约定）、四种打包车道运算（含跨车道进位/借位）。每个向量化用例除了比值还要求在汇编里真的出现 SWAR 掩码 / `SADD*` 助记符——值对不能证明走了 SIMD，标量算出来一样对；另含两条自检：错的期望值必须被拒、关掉向量化后掩码必须消失
python tests/run_rv_packed_tests.py --rv-as <bin> [--arm-as <bin>]   # 非对齐访问门禁（RV32I + ARM，给 `--arm-as` 才跑 ARM 臂）：7 个用例 × 每臂，逐字节校验落点（不靠同一条通路回读自证）、2 字节符号扩展、奇数偏移不串扰、8 字节（`long long`，含负数）全 8 字节与高低字顺序
python tests/run_regalloc_tests.py                                  # 寄存器分配门禁：关就是关 / 开确实改了 / unicorn 上答案不变，外加 volatile 与取地址两个负例要求文本逐字节不变
python tests/arm_exec/run_arm_exec.py --extra=-fopt-regalloc        # 同一套执行级用例，打开寄存器分配再跑一遍
python examples/run_va_gate.py --opt-suite --arm-as <bin> --rv-as <bin>  # 变参门禁五档开关全跑（默认/O2/regalloc/O2+regalloc/O2+regtop+inline+regalloc），任一组红即失败
```

`tests/arm_exec/run_arm_exec.py` 是本仓库唯一"真的执行机器码"的宿主门禁：把 arkc
产出的裸镜像装进 unicorn（一个 QEMU 核），从复位向量开始跑，读 `main()` 的返回
值。语义错（编错一条指令、链接期地址算错、`--reg-top` 回退路径没摆回状态）只有
这条路能看见——`run_tests.ps1` 走的是 C 后端，看不到 ARM 编码。没有 unicorn 时
自报 skipped 并 `exit 0`（编译器本身不依赖 Python 包）。

现在共 29 个用例（清单以 `CASES` 为准，随门禁增长），每例都跑一遍基线臂和一遍 `--reg-top` 臂：`globals`、`reloc_data`、
`reloc_data_off`、`sub_word_access`、`longlong_args`、`shift64`（64 位左/右/算术右移，
计数取 0/1/8/16/31/32/33/40/47/63，参考值用"反复除以 2 / 乘 2"算，不用移位）、
`abi_stack_args`（5/6/7/9 个字参数 + 溢出到栈的 64 位参数）、`longlong64`（64 位
算术/比较/位运算/一元负号/`++`/`--`/聚合与指针/复合赋值）、`struct_byval`（结构体按值
传参与返回、`f().m`、`arr[i] = f()`、混合标量/结构体/指针实参）、`big_frame`（帧 >
4095 字节：单条 `SUB sp` 编不下，旧的 `(N/4) & 0x7f` 把 SP 本身算错）、`far_addr`（帧
偏移 > 4095 的局部变量**取地址**：`ADD Rt, r6, #off` 编不下，改成 `MOVW/MOVT ip` +
`ADD Rt, r6, ip`；第一版把取地址当成取内容，产出 `ADD r0, [ip]` 汇编不过，第二版共用
了 `ADD ip, r6, ip` 于是算成 `r6 + (r6 + n)`，写野地址）。`const_fold_float` 钉编译期浮点折叠（镜像里不许留 VFP 指令），`tls_static_init` / `tls_block_static` 钉 `_Thread_local` 的初值与跨调用持久性，`tls_reject` 钉四条约束的诊断文本与"报错就不许留镜像"，`atomic_rmw` / `atomic_nested_mask` / `atomic_wide` / `atomic_reject` 钉 `<stdatomic.h>` 与 PRIMASK 内建的配对语义（嵌套保存的值必须是 0,1,1,0，restore 一律清掩码会凭空放开中断）。这些用例里有相当一部分是"能编过、跑不了/结果错"的回归钉——每条都对应一个真实修掉的缺陷。

`tests/asm_cases/run_asm_cmp.py` 把 `--asm-extra` 的每个助记符用两个独立汇编器
各编一遍，比较的是 **`objdump` 解码出来的指令文本**而不是字节：同一条指令常有
多种合法编码（GAS 偏爱 mod-imm 形式），字节不等不代表错；能执行的东西一致才是
一致。第二张表验证开关的另一半——关掉时 30 个助记符必须逐个报 unknown
mnemonic；第三张表是反过来的契约——15 行**必须报错且必须报对原因**的输入（不存
在的寄存器索引写回、不连续的 VFP 列表、越界立即数、`LDMIB`/`STMDA`），因为这几
种形态以前都是"编过但编成别的指令"。十组样例分别覆盖带标志的算术、`LDM/STM`
（16 位与 32 位、写回与不写回、增前与减前、高寄存器与 `lr`/`pc`）、乘加、系统寄
存器、PC 相对、`TBB/TBH` 与 `LDRD/STRD`、VFP 的单/双精度与字面量池、LDR/STR 的
全部地址模式、VFP 多寄存器存取、以及 armasm 的四个块传送别名。没有 GNU ARM 工
具链时 `exit 2`，不会假装通过。

`tests/run_regalloc_tests.py` 守的是 `-fopt-regalloc` 的三条独立断言：默认文本里
不出现 `r8-r11`（关就是关，默认产物与上一版逐字节相同）、打开后热点用例的
`[r6, #]` 引用确实下降（开确实改了：`far_slots` 的 `[r6,#]` 从 22 处降到 13 处）、以及三个用例在 unicorn 上真跑的返
回值与 Python 逐值一致（答案不变）。另外两个负例——`volatile` 局部与取地址局
部——要求文本**逐字节不变**：它们一旦开始被改写，就说明"每一处提及都是那两种
形状"的 taint 规则破了，前面的正例也就失去意义。这条规则在实现时确实抓到两个
真问题（取地址发的是 `ADD r0, r6, #off`，不带方括号；`volatile` 走的是完全相同
的两条指令）。

`tests/run_capacity_tests.py` 守的是另一条线：**宿主不许有人为上限**。它生成
120 个 `.c` 各编成一个对象再 `--reloc-data` 链成一个镜像、一个 `#include` 1200
个不同头文件的翻译单元（开 `-MMD`，`.d` 必须一个不少）、500 条 `-D` 必须编过而
520 条必须被拒绝、以及 129 条 `-I`（第 129 条必须**报错**并点名
`ARK_PP_MAX_INC_DIRS`）。这四条都是"表满了就静默丢"的形状：改前 120 个对象只有 32 个进得去（镜像 55 KB，现在 206 KB）、`.d` 停在
1024 条、第 17 条以后的 `-I` 直接消失，症状是后来报"找不到头文件"——报错指向
了错误的原因。板端仍是定长表（`ARKCC_MAX_INC_FILES` / 64 个对象），改前改后
`.bss` 逐字节相同，裁剪入口是 `-D`（见 `include/arkcc_config.h` 第 9 节）。镜像缓冲
同一批从 256 KB 提到 8 MB（宿主按需从池里分配，不长进可执行文件）：一个 1.2 MB 的
镜像改前报 `only 262143 could be read`，现在能正常链出来。

`run_asm_test.ps1` 校验汇编输入的扩展名路由：四种后缀产出逐字节相同的机器码、`-S` 对汇编输入是原样透传、缺失文件必须报错退出、`.c` 仍走正常前端（防止扩展名探测把 C 源当成汇编）。
`run_arm_exec_test.ps1` 把 C 启动代码、汇编 semihosting 陷门和一个 C 工作负载编译链接成裸镜像，在 `qemu-system-arm -machine mps2-an385` 上执行，用 semihosting 退出码判定结果（两个不同负载必须分别返回 8 和 3）。QEMU 路径默认 `D:\qemu\mingw64\bin\qemu-system-arm.exe`，可用 `ARKCC_QEMU` 环境变量或 `-Qemu` 参数覆盖；装不上时脚本 `exit 2`，不会假装通过。这条门禁抓到并固化修复了三个真缺陷：向量表缺 Thumb 位（Cortex-M 会进 INVSTATE lockup）、`SVC`/`BKPT` 的无 `#` 立即数被静默编成 0、以及 `MUL r2, r2, r1` 被编成 `MUL r2, r2, r2`（导致所有整数取模算成 q\*q）。

`tests/run_diag_tests.py` 把 arkc 的诊断输出与**真实 armcc 5.06** 的输出逐字节比对：
能逐字节比的用例标 `exact`，arkc 错误恢复与 armcc 不同、只能比对每行拼写的标 `shape`，
`--errors` 文件落盘标 `sink`。基线由 `--regen` 用真 armcc 重新生成；
既没有 armcc 又没有基线时退出码是 2（拒绝假通过）。

`tests/run_diag_boundary.py` 覆盖逐字节比不了的边界契约——超长行（`DIAG_LINE_MAX` 512）
的截断与"画不出的 caret 就不画"、30 条错误上限、同一行多条诊断各自的 caret、
CJK 按显示单元计列、tab 原样重放。它不需要 armcc，断言的是 arkc 自己写明的行为。
排版规则与设计说明见 [docs/DIAGNOSTICS.md](docs/DIAGNOSTICS.md)。

71 个断言用例全部通过、4 个 ARM 专属用例跳过 C 后端运行（只查 ARM 发射，不计 pass）、0 失败（ARM 汇编生成 + C 后端编译运行，期望退出码逐文件机器校验），覆盖：基本算术、函数/递归、struct/union/enum、位域、VLA、`_Complex`、`wchar_t`/`L"..."`、三字符组、内联汇编（基本+扩展）、完整 `__attribute__` 集、`__svc`/`__irq`/`__weak`/`__naked`/`__packed`/`__align`/`__at`/`__forceinline`、`__asm` 整函数体汇编、`#pragma pack/anon_unions/location/...`、TLS、`__packed` 指针非对齐访问、`split_sections`、双精度浮点、64 位整数、除法/取模、复合字面量、指定初始化、结构体按值传递、隐式转换、整数提升、64 位 `printf`、`setjmp/longjmp`、多文件链接、CPU 宏、调试信息、`$` 标识符等。

## 移植到 STM32

只需将 `port/host/*.c` 替换为 `port/stm32/*.c`；入口点为 `port/stm32/main_stm32.c`。MDK 工程见 `mdk/STM32H743_ArkCC/`。STM32 端为自托管配置，可直接从外部 W25Q Flash 读取 `.c` 文件就地编译执行。

**armcc5 构建**：用 `build_stm32_armcc.ps1` 脚本可在装有 armcc5 的 Windows 上直接编译 arkCC 源码并链接为可烧录的 STM32 固件，无需 gcc。详见 [docs/STM32_BUILD.md](docs/STM32_BUILD.md)。

详见 [docs/MANUAL.md](docs/MANUAL.md)。

## 版本历史

- v0.9.0：**稳定版**——把"这套编译器能干什么"从"汇编看着对"升级成"板上跑出来的返回值对"。新增板端全功能门禁 `tests/run_stm32_board_tests.py`：54 个用例 × `-O0/-O1/-O2` = 162 次"板上编译 → 链接 → 装载 → 执行 → 读回返回值"，STM32H743 实测 **162/162**（约 956 s），门禁自带防假绿自检；判据、覆盖表与全部根因见 [`docs/BOARD_VALIDATION.md`](docs/BOARD_VALIDATION.md)。
  同轮修掉三类会让"稳定"落空的缺陷：① **缓冲顶穿静默截断**——四个后端（arm / c / riscv32 / x86_64）原来把超长汇编按 `%.*s` 截断后照常输出，现在一律**拒绝**并指名宏，STM32 档 `ARK_SRC_BUF_SIZE` / `ARK_ASM_BUF_SIZE` 提到 32 KB / 256 KB，新增门禁 `make test-buffers`（7 项）；② 板上 `link` 遇未定义符号明确失败（`app.bin: Error: unresolved symbol "nope"`、`link failed: -8`），不会静默生成一个跳向量表的镜像；③ 门禁自己的三处错读——`fconv_rne` 把 `FLT_MAX` 当成溢出（期望位型改为 `0x47EFFFFFF0000000`）、返回值正则只看半个数字（`11` 读成 `1`、`68` 读成 `6`，模式补行尾）、串口掉线无恢复（加复位重跑并打 `[board] note:` 记账，不静默升级为通过）。
  本版包含原定的 v0.8.7-wip 全部内容：`--ipo` 全程序编译与 `--const-global` 跨 TU 常量传播（见下条）。
- v0.8.7（未单独发版，内容已并入 v0.9.0）：新增**全程序编译** `--ipo`（别名 `-flto`，`docs/IPO_LTO.md`）。一次调用吃多个 `.c`，每个文件仍然独立走前端（`static` 还是本文件的），IR **追加**进同一个 `IrProgram`，然后跑**一次**管线、生成一次代码。之所以不是对象级 LTO：`ARKOBJ2` 对象里没有 IR，真 LTO 要给对象加 IR 载荷段并在链接期重建（重编号三个池 + 在链接器里跑后端），那是另一套契约。三条合并规则——① 文件作用域符号改名为 `__ipo<单元>f_/g__<名字>` 并全程序查重（撞了再加 `_`，加不出来就报错），② 外部名按链接器规则裁定（weak 输给 strong、**两个 strong 函数报错**、两个 `int g;` 合成一个对象、两个 `int g = 1;` 报错、`extern` 被定义覆盖），③ 内联后无引用的 `static` 剪枝（`used`/构造析构/alias/`__at`/section 一律保留，**程序里出现任何内联汇编就整段跳过**）。价值的来源是 `ir.inline` 本来就是全程序 scope：合并后**跨文件内联免费**（实测 `-O2` 无 `BL one`、`-O1` 有）。拒绝 `-c`/`-E`/`-g`/`-link`/缺 `-o`/`.s`/`.o`，各给理由；单文件走 `--ipo` 与普通编译**逐字节相同**（`.s` 与 `.bin` 都对拍）。可裁减：`ARKCC_FEATURE_IPO` 在 `ARKCC_PROFILE_STM32_MIN` 档默认 0（128 KB 池装不下多 TU 的 IR），关掉时 `--ipo` 报"未编入此构建"而不是未知选项。门禁 `tests/run_ipo_tests.py`（`make test-ipo`，19 项）：三条动态用例在 ARM 模拟器上返回 28 / 23 / 4，两条去重报错必须点名符号且**不留镜像**，剪枝与跨 TU 内联各读一次汇编，外加裁剪构建拒绝。
  本版还加了**跨 TU 常量传播** `--const-global`（`docs/IPO_LTO.md` §8）：合并之后"这个 `const`
  到底是不是常量"第一次能看全，于是把常量对象的 `load` 折成立即数（`const int LIMIT = 100` 跨文件读
  变成 `MOV r0, #100`，不再 `MOVW/MOVT + LDR`）。判定取"过于保守"的一侧——只认「`const` + 标量整型
  初值 + 不是 `extern` + 全程序没人写它 + 地址没外泄（没有取址、也没进别人的 `init_sym`/`init_refs`）
  + 非 `volatile`/数组/聚合/函数 + `type_size==4` + 无 `__at`/section/`__thread`/`__global_reg`」，
  任一不满足就保留 load：漏折只少省一条 `LDR`，错折是错答案。排在 `ir.inline` 之后（跨文件内联把
  读者与定义放进同一视野），且因为管线不迭代，pass 自己重跑一次常量折叠让级联在一个轮次内收敛。
  不做全局变量定理（非 `const` 全局即便全程序从不写也不折）、不删被折掉的 `const` 对象（`-link`
  时仍需要定义）。单文件 `static const` 同样折。可裁减：`ARKCC_FEATURE_CONST_GLOBAL` 在
  `ARKCC_PROFILE_STM32_MIN` 档默认 0，关掉时选项报"未编入此构建"。门禁 `tests/run_constglobal_tests.py`
  （`make test-constglobal`，15 项）：折/不折两个镜像都返回 103、五种保守情形（取址 6、经取址写 9、
  `volatile` 6、数组 3、`long long`）各自保留 load、`-O0` 不折、`--print-pipeline` 报 `run`/`off`、
  裁剪构建拒绝，以及**开关关时全量构建与裁剪构建的 `.s` 逐字节相同**。
  本版还加了**对象里的 IR 载荷与链接期重编**（`docs/OBJ_IR.md`）：`-c --obj-ir` 把"管线之前"
  的整个程序（类型表、三个常量池、参数长度表、全局表、函数表与指令流）序列化后**追加在
  `ARKOBJ2` 的重定位表之后**，`-link --lto` 读回来、按命令行顺序把四个池追加并 remap 索引
  （`IR_PUSH_STR.val`/`IR_PUSH_FLOAT.val`/`IR_CALL.aux2`）、复用 `--ipo` 的单元改名与外部名裁定、
  跑**一遍**管线再重新出码。因为载荷是**未优化**的 IR（钩子挂在 `pipeline_run_ir()` 之前），
  `--lto` 与 `--ipo` 在管线入口握着同一份 IR，所以结果是 **`-S` 与 `-o bin` 双向逐字节相同**
  （同名 `static` 经往返仍是 `__ipo1f_helper`/`__ipo2f_helper`，没有 `main` 的单元也一样合并）。
  老读者读到重定位表就停，因此带载荷对象照样能被 plain `-link` 链接、产出同一镜像。载荷缺失/
  损坏（截断、错魔数、版本 99、正文长度不符）一律**具名报错且不写输出文件**——少合并一个单元
  等于错答案，比链接失败危险得多。版本兼容取硬相等，不做向前兼容。
  可裁减：`ARKCC_FEATURE_OBJ_IR` 在 `ARKCC_PROFILE_STM32_MIN` 档默认 0，关掉时两选项报
  "未编入此构建"。门禁 `tests/run_objir_tests.py`（`make test-objir`，26 项）：载荷写入与前缀
  不变、`--ipo` 参考系真的内联+折常量（否则后面的"相同"是空相等）、两条逐字节对拍、两条模拟器
  动态读数（102 与 79）、两份同名 static 仍具名、四种损坏、无载荷对象具名拒绝、不干扰 plain
  `-link`、六种选项拒绝、裁剪构建拒绝，以及**开关关时全量构建与裁剪构建的 `-c` 对象逐字节相同**。
  本版还加了**部分链接 `-r`**（`docs/PARTIAL_LINK.md`）：`-r -link a.o b.o -o ab.o` 读 N 个
  `ARKOBJ2` 对象，把机器码按命令行顺序首尾相接、符号 `offset += base`、重定位站点 rebase，
  写出一个**新的 `ARKOBJ2` 对象**。语义只有一条：**机器码作准**——合并的是机器码不是 IR 载荷，
  所以带 `--obj-ir` 载荷的对象被**具名拒绝**并提示 `-link --lto`（静默丢载荷会让"之后还能 LTO"
  变成假话）。全局对象（`OBJ_SYM_TYPE_DATA`）的绝对地址**不变**、数据段不搬，`X86_RELOC_SELF_BASE`
  就地加 base 后丢弃（与 `-link` 逐字一致）；`__arkcc_ram_start/end` 描述符原样保留，因此**一次
  `-r` 最多合并一个拥有 RAM 的对象**；`riscv32` 对象在已见过 ISA 标签后按 16 字节对齐。混用
  riscv32 与非 riscv32、非对象文件、表被截断、表后多余字节、同名强定义地址不同、`--reloc-text`
  基址不一致，一律**具名报错且不写输出文件**（对象就是交付物，"报错 + 半个文件"比两者都糟）。
  必须成立的四条性质：**可替换**（`-link` 一个 `-r` 产物与直接 `-link` 那 N 个对象逐字节相同）、
  **幂等**、**输入不被改写**、**被引用未定义的名字不被凭空定义**（留给最终 `-link`）。选项层面拒绝
  `-r` 缺 `-link`、与 `--lto` 同用、与 `-c`/`-S`/`-E`/`-MMD` 同用、缺 `-o`、`-link` 后没有对象。
  可裁减：`ARKCC_FEATURE_PARTIAL_LINK` 独立于 `ARKCC_FEATURE_OBJ_IR`，在 `ARKCC_PROFILE_STM32_MIN`
  档默认 0，关掉时 `-r` 在参数解析期报 `C3900U`。门禁 `tests/run_partiallink_tests.py`
  （`make test-partiallink`，27 项）：合并与三类 rebase、`g_init` 绝对地址不变、RAM 描述符保留、
  合并对象与直接链接逐字节相同、模拟器实答 13、幂等、输入未被改写、无 `main` 可合并、同名
  file-static 各答其值、跨对象后补定义（答 41）、五种坏输入"非零退出且不写文件"、五条选项校验，
  以及**裁剪构建下 `-c`/`-link` 产物与全量构建逐字节相同**。
  本版还补齐了**诊断层最后一条明写的缺口**：`#1-D: last line of file ends without a newline`
  （`docs/DIAGNOSTICS.md` §5.4）。位置取**该文件的最后一行**（头文件缺换行时消息里点名的是头文件，
  主文件名只出现在汇总行），caret 落在行末再往右一格，`-D` 后缀标明它是警告；以 `\n`/`\r`
  结尾的文件与空文件都不报。发射点放在预处理器读文件的地方——主文件在 `process()` 之前（armcc
  也是读完就报，所以同一文件里它排在其它诊断前面），头文件在 `read_include()` 读成功之后——
  因为"缺尾随换行"说的是文件本身，不是某一阶段的语义错误；头文件的行文本不在诊断层的 `g.src`
  里，于是新增 `diag_report_no_final_newline()` 让调用方把那一行交进来（一次性回显覆盖）。
  可裁减：`ARKCC_FEATURE_EOF_NL_WARN` 默认 1（所有 profile），置 0 时两处检查整段编掉，
  **行为与体积都回到 0.8.6**。门禁 `tests/run_diag_tests.py` 新增 10 条逐字节用例（主文件 /
  IDE 风格 / 头文件 / 两行文件的第 2 行 / 警告与错误共存时的顺序 / `--errors` 落盘 / 四条干净对照：
  尾随 `\n`、尾随 `\r`、CRLF、空文件），并顺手修掉一个被它暴露的老缺陷：IDE 风格会剥掉码尾的
  字母，于是 `#1-D` 被印成 `#1-`——剥后缀只对驱动层码（`C3900U` → `C3900`）成立，前端码原样输出。
  本版还补上了 **ARM 软浮点 AEABI 运行库**（`stdlib/src/arm/aeabi_float.c`）：30 个入口
  （`__aeabi_fadd/fsub/fmul/fdiv/f2iz/f2uiz/...` 与 `__aeabi_dadd/dsub/dmul/ddiv/...`、
  `__aeabi_i2f`/`__aeabi_f2d`/`__aeabi_d2f` 一族），纯整数实现、单一舍入点、不调用任何别的
  AEABI helper；契约与 `aeabi.c` 相同——**链接期可选，编译器从不隐式链接**，"不用就不进镜像"
  由链接契约保证，不需要宏开关。两道门禁：① 主机差分 `tests/softfloat_ref.c`（同一张用例表在
  宿主 x86-64 上按 IEEE 双精度算，再与运行库逐位比对；`-msse2 -mfpmath=sse` 是硬要求，x87 的
  双重舍入会把正确实现判错）跑了 1.22 亿次判定、0 失败；② ARM 执行门禁
  `tests/run_arm_softfloat_tests.py`——把用例表编成真实镜像在 ARM 核模型上跑，217 行入口 +
  17 步普通 C 表达式，两组都必须过（它的自包含检查还会拦下"运行库偷偷调了别的 AEABI"）。
  这道门禁抓到两个**只在真实代码生成时才现形**的静默错答案，都已在本版修掉：
  - **序言里 struct-by-value 的 memcpy 踩掉后面的寄存器参数**：>16 字节的结构体按 AAPCS 以指针
    传入，被调用方 `BL __aeabi_memcpy` 把它拷进本帧，而 `__aeabi_memcpy` 会 clobber `r0-r3`；
    序言在这之后才 home 后续形参，于是 `r1/r2/r3` 进来的参数全是垃圾（表现为"某个 double 运算
    返回 0"）。修法是 memcpy 前后各 `PUSH`/`POP {r1,r2,r3}`。
  - **Thumb-2 改良立即数的位段口径错**：旋转量是**五位** `imm12<11:7>`、常量只取
    `'1':imm12<6:0>`（因此常量只有七位），四种字节填充也不是"左移 8/16 位"而是
    `imm8*0x00010001` / `imm8*0x01000100` / `imm8*0x01010101`。旧编码把旋转量当 8 位倍数写进
    `imm12<11:8>`，于是 `EOR r0,r0,#0x80000000`（double 取负）编成"合法但装着别的常数"的指令；
    `-S` 看不出来，只有 `--object` 的镜像错。新实现以一张**由全部 4096 个 `imm12` 实测反推**的
    `thumb_expand_imm_a()` 解码表为准，编码后回解自证（`decode(encode(v)) == v` 才返回成功）。
- v0.8.6：四个方向一起落地，全部**默认关、可裁减、开关关时逐字节不变**。
  ① **`--warn-unused-result` + `__must_check`**：丢弃一个标注了检查的函数返回值即告警，标注从原型（`__must_check` / `__attribute__((warn_unused_result))`）沿声明链传递，宏展开后仍然有效。
  ② **MIR/CFG 基底 + 三条跨函数检查**（`docs/MIR_CFG.md`）：`src/mir.c` 建基本块与控制流边，在此之上做 `--warn-unused-static`（静态函数无人引用）、`--warn-unreachable`（没有任何路径能到达的指令，报"该函数内 N 条指令永远跑不到"）、`--warn-recursion`（直接/间接递归），三条都只看**能证实的形状**——`goto` 进死块、函数指针别名、`#pragma arm section` 之类的模糊情形一律沉默。
  ③ **循环优化**（`docs/LOOPS.md`）：`--licm` 把循环不变量的**计算**搬进帧临时量、store 留在原地（因此零次迭代的循环不会写入原本不写的变量），白名单只认 32 位字形状算术并排除 `/` `%`（可陷入）与一切指针访存；`--unroll` 只对常量起止、步长 1、直线 body 的单层 `for` 做完全展开（上限 `ARK_UNROLL_MAX` = 8），`break`/`continue`/`goto`/非规范形状一律不动。两阶段排在 `ir.dce` 之后、`ir.dce-cfg` 之前。
  ④ **现代化诊断风格**（`docs/DIAGNOSTICS.md` §4.1）：`--diag_style=modern`（别名 `clang`）给一条 clang 形状的头行 `f.c:4:9: error: ... [#20]` + 右对齐 5 列行号的回显框 + `1 error generated.` 汇总，armcc 码保留为消息后的 `[#code]` 以便查表；`note:` 行只有该风格有。这是**唯一不承诺与 armcc 逐字节一致**的风格，`arm`/`gnu`/`ide` 的输出由门禁逐字节钉住。
  门禁：`make test` **255 PASS / 0 FAIL / 1 SKIP**（唯一 skip 是模拟器没有双精度 FPU），新增四个门禁 `test-unusedresult` / `test-mir` / `test-loop` / `test-modern`（分别 17 / 26 / 29 / 35 项，全部自带防假通过自检：把实现改坏后必须红）；x86-64 自举仍是 31 个自源 TU → 平铺镜像 → unicorn 上跑 → 与宿主对象逐字节相同（`fnv=28c333dc`、汇编文本 877 行一致）。
- v0.8.5：可配置 Pass 管线（`docs/PASS_PIPELINE.md`），并修掉一处被它第一次照出来的 x86-64 链接器缺陷。`src/pipeline.c` 把原先散在 `opt_run()` 里的 `#if` / `if` 阶梯收成**一张阶段表 + 一个循环**：AST 两张（`ast.memlint` 看 `--warn-mem`、`ast.enumcheck` 看 `--warn-enum`，都没有 `-O` 门），IR 五张（`ir.constfold` → `ir.dce` → `ir.dce-cfg` → `ir.inline` → `ir.vectorize`，**表内顺序即执行顺序**），每个阶段带三种门槛之一（纯开关 / `-O` 级别且开关 / `-O` 级别或开关）和一句**理由**。`--pipeline=full` 是默认值，且**与不写这个选项逐字节相同**——剖面只是上界，不替代阶段自己的门槛；`--pipeline=lite` 只把贵的三阶段（`dce-cfg` / `inline` / `vectorize`）跳过并留下理由；非法值在命令行以 `C3900U` 报错退出（INI 里则报 warning 并**保留原值**，因为命令行没有"原值"可回退，猜一个等于替用户决定）。`--print-pipeline` 逐行打出决策（`run <name>` / `skip <name> <reason>`），**被跳过的阶段必须写明是哪一条门没过**：空输出不算一次测量。顺带修掉两个**以前被接受但完全无效**的开关：`-fno-opt-constfold` / `-fno-opt-dce` 此前只被 `opt_run()` 看 `-O` 级别而忽略，现在由阶段表真正生效；因默认值为 1，产物不变。可裁减：`ARKCC_FEATURE_PIPELINE_DUMP`（`ARKCC_PROFILE_STM32_MIN` 档默认 0）只裁名字字符串，执行循环与阶段表永远编入；实测（ARM `-c --reloc-data`）默认 8,342 B、关 dump 7,096 B、再关两条 lint 7,830 B、三者全裁 6,616 B，宿主 x86-64 默认 9,135 B。零变化读数：与 v0.8.4 二进制对拍 **480/480 逐字节一致**（80 个 examples 源 × 3 个 `-O` 级别 × 2 个目标，含退出码）；自举门禁仍是 27 个自源 TU → 平铺镜像 → unicorn 上跑自举编译器 → 与宿主对象逐字节比较，PASS（6,357,774 B、`fnv=28c333dc`）。同一轮修掉的链接器缺陷：**跨对象**引用别的对象里定义的符号时，绝对重定位只写了「对象基址 + 符号偏移」，漏加镜像基址 `X86_IMAGE_BASE`（0x400000）。取证：自举镜像运行期崩在 `0x3F571F`，而该值在 6.3 MB 镜像里只出现一次，落在 `pipeline.o` 那条 `.quad opt_vectorize` 的重定位落点（镜像偏移 0x424c8a = 对象基址 0x42491A + 880），减去 `opt_vectorize` 在 `opt.o` 的符号偏移恰好等于 `opt.o` 的对象基址——即"少了 0x400000"。修法：链接期只对 type 4（4 字节绝对）补 `X86_IMAGE_BASE`，type 5（PC 相对 disp32）与已由 `ld_relocate_data` 结算的类型一律不加。新增回归 `fptr_across_objs`（`e1.c` 定义 `f1()`/`f2()`，`e2.c` 用 `int (*tab[2])(void) = {f1, f2};` 跨对象取地址，期望 50；修复前报 `UC_ERR_FETCH_UNMAPPED`），x86-64 对象门禁 **36 passed**。新增 `tests/run_pipeline_tests.py` 27 条断言（`make test-pipeline`），覆盖文本输出、每个阶段的实际效果、拒答路径与 INI 键。
- v0.8.4：`--warn-mem` 补齐两个缺口、新增 `--warn-enum`（`docs/ENUMCHECK.md`）。`--warn-mem` 从两类诊断扩到四类：新增**自动对象地址存进静态存储期对象**（`g = &x;` / `g = local_array;` / `g = (T){...};`，根对象穿过 `a.b`/`a[i]` 判定，`g = "abc"`、`g = 0`、局部指针指局部数组一律沉默）与**常量下标越界**（`int a[4]; a[4]` / `a[-1]`，只对具名数组对象、非 VLA、下标可被 `eval_const_expr` 折成常量的情形判定；`p[8]`、`a[i]`、`"ab"[5]` 沉默）。`--warn-enum` 是独立的一遍检查：`switch` 类型是 enum、没有 `default:`、且 `case` 没覆盖该枚举全部枚举值时告警；**按值比对不按名**（`case 0:` 等价 `case RED:`）、嵌套 `switch` 各自独立判定、枚举值或 `case` 超过 64 条即整条沉默（截断比较会把"表外的值"说成"没写"）。两条检查都默认关、都有 `ARKCC_FEATURE_*` 编译期开关（`ARKCC_PROFILE_STM32_MIN` 档默认 0）与 INI 写法（`warn_mem`/`warn_enum`），特性不在时命令行与配置文件都以 `C3900U` 拒绝。实测代价（宿主 x86-64，互相隔离测量）：`--warn-mem` `-O2` `+6,584 B` / `-Os` `+5,516 B` text，`--warn-enum` `-O2` `+1,852 B` / `-Os` `+1,548 B` text，两者 `data`/`bss` 均为零；默认关时产物与 v0.8.3 逐字节相同。门禁：`tests/run_memlint_tests.py` 27 条断言（12 正例 / 16 反例 / 12 合法孪生）、`tests/run_enumcheck_tests.py` 19 条断言（5 正例 / 6 合法孪生 / 2 负例），均已并入 `make test`；`make test` 129 PASS / 0 FAIL / 1 SKIP，x86-64 自举 26 个翻译单元逐字节一致（6,349,223 B、`fnv=28c333dc`）。
- v0.8.3：新增函数内内存 lint `--warn-mem`（`docs/MEMLINT.md`）。两类诊断——**返回自动存储期对象的地址**（`return &x;` / `return local_array;` / `return &local.field;` / `return (T){...};`）与**同一函数内的 double free / use-after-free**——只认能证实的形状：`realloc` 复活、`free(p + 1)`、`if (c) free(p)` 单侧释放、所有权传给别的函数、含 `goto`/`asm` 的函数、跟踪表（8 指针 / 32 局部名）溢出的函数一律沉默，选择漏报而不是猜。默认关时产物与 v0.8.2 **逐字节相同**（3 个程序 × arm/x86/riscv32/x86-64 共 12 个 `.o` 全部 `cmp` 一致）。可裁减：`ARKCC_FEATURE_MEMLINT` 在 `ARKCC_PROFILE_STM32_MIN` 档默认 0，特性不在时命令行 `--warn-mem` 与配置文件 `warn_mem=1` 都以 `C3900U` 拒绝并给出重建方法，不会假装检查过；实测代价（宿主 x86-64）`-O2` `+5,424 B` / `-Os` `+4,436 B` text、`data`/`bss` 为零、每个被分析函数约 900 B 栈帧。门禁 `tests/run_memlint_tests.py`（`make test-memlint`，22 条断言）：正例逐行逐文案、反例 12 种整份文件零输出、8 个缺陷的合法孪生版本零输出、开关三位一体（`--warn-mem` / `--no-warn-mem` / 配置文件）、以及现场用 `-DARKCC_FEATURE_MEMLINT=0` 重建后必须拒绝。这批诊断**不带 armcc 编号**（只对实测过的 armcc 行为用编号），所以 `--diag_suppress` 无法定向关闭。
- v0.8.2：32 位 x86 后端的历史欠账全部清零，且门禁不再给它留缝。（1）本地数组下标：帧映射改成与 x86-64 同构的 `[ebp - framelo + off]`；（2）结构体按值传参与返回：隐藏返回缓冲指针（sret）在 `[ebp+8]`、真实参数从 `[ebp+12]` 起，`struct_sret40` 曾因 callee 把 sret 也算成一个参数宽度而读 `[ebp+16]`、拿回全零；（3）浮点：`x86_pair_swap_at` 在偏移 0 上退化成空操作，`(int)7.9` 给 0；（4）64 位整数：`IR_UNARY` 忽略 `I->val`、`|a|` 掩码写成 `sar 31`、除法移位用 `add ecx,ecx`。另有 C 档三条错值同轮修完：float/double 局部 `++/--` 按整数加、8 字节指针的 `IR_BINARY` 只做 32 位运算、指针 ↔ `long long` 转换是 no-op（指针 1 个栈字、`long long` 2 个，高半必须在 irgen 层拆/合，接到 cast／声明初始化／赋值／`return`／调用实参五处）。x86-64 镜像门禁 33 → **35 个程序**，并且**同一个程序再编一次 32 位跑一遍**、i386 结果与期望不符即判 FAIL（原口径只把它写成脚注 ⇒ 「32 位已知差距」长期不红）；自举门禁仍逐字节一致（2130 字节、`fnv=28c333dc`、877 行汇编相同）。详见 `docs/X86_64_BACKEND.md` §5。
- v0.8.1：真 x86-64 后端（SysV AMD64 ABI，`--list-backends` 共五个后端）、CI 自动化（GitHub Actions + Gitee Go 双配置，见 `docs/CI.md`）、C11 `_Thread_local`（按 6.7.1p4 校验存储类，armcc 的裸 `__thread` 保持豁免）、C11 `_Atomic` + `<stdatomic.h>`（ARM 上真临界区实现，其余四个目标编译期拒绝；`Type::is_atomic` 使原子性沿 typedef 传播，`x += 1` / `x++` 一律报错；ARM 执行级门禁加 7 个用例，共 29 个；细节见 `docs/ATOMIC.md`）。另有 x86-64 执行级**自举门禁**（`tests/run_x86_64_selfhost.py`，`make test-x86-64-selfhost`）：用宿主 arkcc 编译自身 24 个翻译单元、把镜像在 unicorn 里跑起来、再由镜像内那份 arkcc 编译探针，产物与宿主 arkcc **逐字节相同**（2130 字节、`fnv=28c333dc`、汇编文本 877 行一致、libc stub 命中 0）；x86-64 用例从 26 增到 33，并修掉 §3.5 那条「`sizeof` 一个成员数组被静默答 4」的前端根因（parser 阶段求值 `AST_MEMBER` 时兜底 `s = 4`⇒ 改由 sema 求值，`sizeof(char sym[512])` 从 4 变 512，自举对象从 2351 字节回到 2130 字节）。
- v0.8.0：ARM 后端对真实工程可用（自举工程 25 个源文件 `failed=0`）。新增：64 位数据通路（`long long` 的 AAPCS 传参与返回、32 位 x86 cdecl 64 位实参）、参数分配表改静态（板端 codegen 栈预算）、结构体按值与结构体返回走 AAPCS、汇编器补齐 LDM/STM 32 位形式、`TBB/TBH`、`LDRD/STRD`、`[Rn, Rm]`/写回寻址、`VLDM/VSTM/VPUSH/VPOP`、`AND/ORR/EOR/BIC/MVN` 的全部四形态（含高寄存器与立即数）、两档寄存器分配（`-fopt-regalloc` 只搬远槽且函数不变大，`-fopt-regalloc-near` 才搬近槽；默认关，默认产物逐字节不变）、块内函数声明（C99 6.2.2p5）、跨对象地址重定位（`LDR rd, =sym` 符号未定义时记 type 10/11，由链接器回填并给函数地址补 Thumb 位）、电脑端容量上限全部解除（镜像缓冲 8 MB、`-D` 表 512、数组维数、sret 表；板端按 profile 裁剪），六处"超限即静默丢弃"改为报错。实测寄存器分配让 12 个文件的栈槽引用减少 1518 处、总体积 −2398 字节（−0.21%）。修掉的静默错答案：结构体返回尾声 `ADD sp, sp, #4256` 被截断、函数地址缺 Thumb 位、"`ORR ip, ip, #1`" 编成 `orrs r4, r4`、pass1 不认识 `PUSH/POP` 导致跨标签分支漂移 4 字节、单高寄存器 `POP {ip}` 编出不可执行编码、普通块内声明被当成 `__smc(0)` 而发 `SMC #0`。门禁：`run_full_test.ps1` PASS=73、`examples/run_tests.ps1` 断言 71 通过、`run_arm_exec.py` 13 个用例在 unicorn 真跑、`run_asm_cmp.py` 12 用例与 GAS 逐字节一致 + 30 条开关 + 15 条拒收、`run_regalloc_tests.py` 4 组三臂、`run_capacity_tests.py` 4 项。

- v0.7.0：armcc 兼容覆盖 98%+，STM32 自托管稳定。新增：armcc 关键字（`__value_in_regs`/`__pure`/`__interwork`/`__thread`/`__global_reg`/`__smc`/`__int64`..`__int8`/`__typedef`/`__args`/`__return`/`__tp_soft`/`__nothrow`/`__deprecated`/`__may_alias`/`__softfp`）、`__attribute__` 属性扩展（`may_alias/nothrow/pure/const/visibility/nonnull/warn_unused_result/sentinel/malloc/fastcall/stdcall/cdecl`）、预定义宏（`__arm`/`__thumb`/`__STDC_VERSION__`/`__STDC_HOSTED__`/`__SIZE_TYPE__`/`__PTRDIFF_TYPE__`/`__WCHAR_TYPE__`/`__EDG__`/`__APCS_INTERWORK`）、完整 DWARF（`.debug_info`/`.debug_abbrev`/`.debug_line`）、TLS（`.tbss`/`.tdata`）、`__packed` 指针非对齐访问、`--split_sections` 每函数一段、scatter 加载描述文件（`include/scatter.h`+`src/scatter.c`）、CPU 选择（`-mcpu`/`--cpu`+`include/cpu.h`+`src/cpu.c`）、命令行扩展（`-MMD`/`--depend`/`-MF`/`--dollar`/`--enum_is_int`/`--fpu`/`--thumb`/`--arm`/`--dwarf2`/`--dwarf3`/`--signed_chars`/`--unsigned_chars`/`--wchar16`/`--wchar32`）、配置项扩展（`enum_is_int`/`dollar_in_identifiers`/`split_sections`/`signed_chars`/`wchar16`/`wchar32`/`dwarf_version`）。全部 62 测试通过。
- v0.6.0：配置系统 + 优化Pass + 调试信息 + 前端/后端加强。新增：三层配置系统（`arkcc_config.h` 编译时宏 + `arkcc.cfg` INI 运行时配置 + `-O/-g/-f/-fno-/-config` 命令行）、VLA（`IR_ALLOCA`）、宽字符 `wchar_t`/`L"..."`/`L'...'`、三字符组（全部 9 个 C99 三字符组）、`_Complex` 复数类型、硬件 FPU 指令（VFP `VADD/VMUL/VCVT/VCMP` 替代软浮桩）、DWARF 调试信息（`.file/.loc/.cfi_startproc/.size`）、IR 级常量折叠+死代码消除（`src/opt.c`）、逗号分隔局部声明作用域 bug 修复。全部 56 测试通过。
- v0.5.0：四波必备特性（启动/中断向量、HAL/DMA/MMIO、控制算法/printf 调试、RTOS/完整工程）。新增：`__asm` 整函数体汇编、`__attribute__((used/unused/alias/constructor/destructor/deprecated/format))`、实际生效的 `__align`/`__at`/`__packed`/`__forceinline`、匿名 union 字段提升、`#pragma anon_unions/location/diag_suppress/arm/thumb/import/push/pop/O0-O3/optimize`、armcc 预定义宏、完整隐式转换和整数提升、`double` 真 64 位精度、全局常量表达式初始化、常量表达式数组维度、64 位不截断 `printf`、严格 AAPCS、`setjmp/longjmp`、标准库 string.c/math.c/setjmp.c
- v0.4.0：完整 C99 + armcc 兼容（`__irq`/`__weak`/`__naked`/位域打包/64 位/除法/段分离/复合字面量/灵活数组/结构体按值/pragma pack）
- v0.3.0：浮点算术、`__svc`、`.s` 编译、静态局部变量、多文件链接
- v0.2.0：多后端架构、C99 子集、标准库子集
- v0.1.0：单 ARM 后端最小 C 子集