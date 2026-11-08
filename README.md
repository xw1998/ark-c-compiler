# Ark C 编译器

一个多目标 C99 编译器，可在 Windows / Linux / macOS 上用 gcc 构建运行，
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
| 阶段 3c | 产物烧写回**内部 Flash** 并由引导跳转执行 | 🚧 进行中 |
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
| ⑤ | 产物烧写回**内部 Flash** 并由引导跳转执行 | 🚧 未打通 | —— |

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


## 功能特性 (v0.8.0)

### C99 标准语言特性

| 方面 | 支持 | 说明 |
| --- | :---: | --- |
| 基本类型 | 是 | `void/char/short/int/long/long long/_Bool/float/double` + `signed/unsigned` |
| 指针与数组 | 是 | 一维/多维数组、指针、函数指针、数组退化；数组维度支持常量表达式 `int arr[SIZE+2]` |
| 变长数组 (VLA) | 是 | `int a[n]` 运行时变长数组，通过 `IR_ALLOCA` 在栈上分配；向上取整对齐：ARM / x86_64 取 8、RV32I 取 16（psABI 要求每次调用前 sp 16 对齐），RV32I 的尾声在函数含 `IR_ALLOCA` 时先用 `sub sp, s0, frame` 重建 sp 再弹帧——否则 `return` 从错位的地方读 `ra/s0` |
| 复合类型 | 是 | `struct`/`union`/`enum`/`typedef`、位域（真正按位打包）、灵活数组成员 `data[]`、匿名 struct/union 字段提升 |
| 复数类型 | 是 | `_Complex double`/`_Complex float`，透传给 gcc（`sizeof(_Complex double)==16`） |
| 宽字符 | 是 | `wchar_t` + `L"..."` 宽字符串 + `L'...'` 宽字符字面量；通过 `--wchar16`/`--wchar32` 切换宽度 |
| 三字符组 | 是 | 全部 9 个 C99 三字符组（`??=`->`#`、`??(`->`[`、`??/`->`\`、`??)`->`]`、`??'`->`^`、`??<`->`{`、`??>`->`}`、`??!`->`|`、`??-`->`~`） |
| 限定符 | 是 | `const/volatile/restrict/inline` |
| 存储类 | 是 | `static/extern/auto/register`；`static` 在函数内持久化；`__thread` 线程局部存储 |
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
| 汇编器覆盖面 | 是 | LDR/STR 全地址模式（`[Rn]`/`[Rn,#imm]`/`[Rn,Rm]`/`[Rn,Rm,LSL #0..3]`/`[Rn,#imm]!`/`[Rn],#imm`、`[sp,#imm]`、`[pc,#imm]`）、`VLDM/VSTM/VPUSH/VPOP`、`LDMFD/STMFD/LDMEA/STMEA` 别名、`ADDW/SUBW`；体系结构不存在的形态（`LDMIB/LDMDA/STMIB/STMDA`、寄存器索引写回）明确报错 |
| 预处理 | 是 | 对象/函数宏（`#/##`）、`#if/#elif/#else/#endif/#ifdef/#ifndef/#undef/#error/#warning/#pragma`、嵌套 `#include`（<=8 层）、`__VA_ARGS__`、`-I` 路径、三字符组替换 |
| 注释 | 是 | `//` 和 `/* */` |

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
| 浮点常量表达式折叠（`eval_const_expr` 支持浮点） | 是 |
| 汇编器扩展指令集 `--asm-extra`（ADDS/SUBS/…/MRS/MSR、`LDM`/`STM` 的 32 位与减前形式、`TBB`/`TBH`、`LDRD`/`STRD` 共 30 个助记符 + `.W`/`.N` 后缀） | 是（默认关；关时报 unknown mnemonic） |
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
| `stdlib/src/setjmp.c` | `setjmp/longjmp`（可移植简化宿主实现） |
| `stdlib/src/putchar_default.c` | `putchar` 弱默认实现 |

`stdlib/include/` 头文件：`stdint.h`/`stdbool.h`/`stddef.h`/`stdarg.h`/`string.h`/`stdio.h`/`stdlib.h`/`math.h`（含 `M_PI` 等常量）/`setjmp.h`。

### 后端

| 后端 | 用途 |
| --- | --- |
| **ARM Thumb-2** | STM32 Cortex-M（默认，含软浮/硬件 FPU + 段分离 + 双精度桩 + AAPCS + 完整 DWARF + TLS + split_sections + scatter） |
| **C 源码** | 宿主测试主路径（IR -> 可读 C，完整支持内联汇编操作数透传） |
| **x86** | i386 cdecl，输出 GAS 汇编（`-target` 亦接受别名 `x86_64`/`x86-64`/`i386`/`i686`） |
| **RV32I** | 输出 RV32I 汇编 |

**各后端的能力不是同一张表：`stdarg.h` 有两条互不兼容的走法。**

四个后端都支持变参函数定义，但参数镜像的**形状**不同，靠驱动注入的宏让 `stdarg.h`
选一条：

| 后端 | 走法 | 布局 |
| --- | --- | --- |
| C / x86_64 | 8 字节槽位（默认分支） | 每个实参一个 8 字节槽，按序号编号，`long long *` 前进 |
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
判断是否对齐（`_Alignof` 尚未实现），取整留下的空洞它看不见，会当成第一个字读走。
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

## 目录结构

```
ark c compiler/
├── include/                公共头文件（含 arkcc_config.h/config.h/opt.h/cpu.h/scatter.h）
├── src/                    编译器核心（lexer/parser/sema/ir/irgen/preproc/config/opt/cpu/scatter）
├── src/backend/arm/        ARM Thumb-2 后端（codegen + 汇编器 + 链接器 + 软浮/硬件 FPU + 完整 DWARF + TLS）
├── src/backend/c/          C 源码后端（宿主测试）
├── src/backend/x86_64/     x86（i386 cdecl）汇编后端
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
├── docs/从零写一个C编译器.md  教材体逐代码教程：19 章，从 30 行到 3 万行（中文，UTF-8）
└── README.md               项目简介（UTF-8）
```

## 构建

### 方式 1：gcc 构建（用于主机开发与测试）

```bash
make            # 生成 arkcc.exe
make test       # 编译 examples
make clean
```

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
  -target <name>     arm | x86 | riscv32 | c（默认 arm；x86_64/i386 为 x86 的别名）
  -I <dir>           头文件搜索路径
  -O0/-O1/-O2        优化级别（0=无，1=基本常量折叠+DCE，2=激进）
  -g                 输出 DWARF 调试信息
  -config <file>     加载 INI 配置文件（默认 arkcc.cfg）
  -f<feature>        启用特性（vla/complex/wchar/trigraph/fpu/dwarf/...）
  -fno-<feature>     禁用特性
  -Wno-unused        抑制未使用警告
  --list-backends    列出后端

  诊断输出
  --diag_style <s>   arm（默认）| ide；ide 为 uVision 的 File(line,col) 风格
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

```powershell
powershell -ExecutionPolicy Bypass -File examples\run_tests.ps1   # 75 个用例（71 断言 + 4 跳过）
powershell -ExecutionPolicy Bypass -File run_full_test.ps1        # 73 个样例全量回归
python tests/run_diag_tests.py                                    # 诊断排版门禁（需 armcc）
python tests/run_diag_boundary.py                                 # 诊断边界契约（长行/上限/CJK/tab，无需 armcc）
powershell -ExecutionPolicy Bypass -File run_asm_test.ps1         # 汇编输入门禁（.s/.S/.asm/.ASM）
powershell -ExecutionPolicy Bypass -File run_arm_exec_test.ps1    # ARM 执行级：编译→链接→QEMU 真跑（需 qemu-system-arm）
python tests/arm_exec/run_arm_exec.py                             # ARM 执行级（unicorn，无 qemu 也能跑；每例同时跑 --reg-top 臂）
python tests/asm_cases/run_asm_cmp.py                             # 汇编器对拍：arkc vs arm-none-eabi-as，含 --asm-extra 开关契约
python tests/run_capacity_tests.py                                  # 容量门禁：120 对象 / 1200 头文件 / 520 条 -D / 129 条 -I（宿主不许有人为上限）
python tests/run_rv_alloca_tests.py --rv-as <bin>                   # RV32I VLA 门禁：5 个用例与 gcc 对拍且各自断言硬编码期望值（两臂同时错也算错），覆盖早返回（尾声重建 sp）、两个 VLA、10 个栈参数（对齐）、`long long` VLA
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

现在共 11 个用例，每例都跑一遍基线臂和一遍 `--reg-top` 臂：`globals`、`reloc_data`、
`reloc_data_off`、`sub_word_access`、`longlong_args`、`shift64`（64 位左/右/算术右移，
计数取 0/1/8/16/31/32/33/40/47/63，参考值用"反复除以 2 / 乘 2"算，不用移位）、
`abi_stack_args`（5/6/7/9 个字参数 + 溢出到栈的 64 位参数）、`longlong64`（64 位
算术/比较/位运算/一元负号/`++`/`--`/聚合与指针/复合赋值）、`struct_byval`（结构体按值
传参与返回、`f().m`、`arr[i] = f()`、混合标量/结构体/指针实参）、`big_frame`（帧 >
4095 字节：单条 `SUB sp` 编不下，旧的 `(N/4) & 0x7f` 把 SP 本身算错）、`far_addr`（帧
偏移 > 4095 的局部变量**取地址**：`ADD Rt, r6, #off` 编不下，改成 `MOVW/MOVT ip` +
`ADD Rt, r6, ip`；第一版把取地址当成取内容，产出 `ADD r0, [ip]` 汇编不过，第二版共用
了 `ADD ip, r6, ip` 于是算成 `r6 + (r6 + n)`，写野地址）。后六例都是本轮新增的
"能编过、跑不了/结果错"回归钉。

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

- v0.8.0：ARM 后端对真实工程可用（自举工程 25 个源文件 `failed=0`）。新增：64 位数据通路（`long long` 的 AAPCS 传参与返回、32 位 x86 cdecl 64 位实参）、参数分配表改静态（板端 codegen 栈预算）、结构体按值与结构体返回走 AAPCS、汇编器补齐 LDM/STM 32 位形式、`TBB/TBH`、`LDRD/STRD`、`[Rn, Rm]`/写回寻址、`VLDM/VSTM/VPUSH/VPOP`、`AND/ORR/EOR/BIC/MVN` 的全部四形态（含高寄存器与立即数）、两档寄存器分配（`-fopt-regalloc` 只搬远槽且函数不变大，`-fopt-regalloc-near` 才搬近槽；默认关，默认产物逐字节不变）、块内函数声明（C99 6.2.2p5）、跨对象地址重定位（`LDR rd, =sym` 符号未定义时记 type 10/11，由链接器回填并给函数地址补 Thumb 位）、电脑端容量上限全部解除（镜像缓冲 8 MB、`-D` 表 512、数组维数、sret 表；板端按 profile 裁剪），六处"超限即静默丢弃"改为报错。实测寄存器分配让 12 个文件的栈槽引用减少 1518 处、总体积 −2398 字节（−0.21%）。修掉的静默错答案：结构体返回尾声 `ADD sp, sp, #4256` 被截断、函数地址缺 Thumb 位、"`ORR ip, ip, #1`" 编成 `orrs r4, r4`、pass1 不认识 `PUSH/POP` 导致跨标签分支漂移 4 字节、单高寄存器 `POP {ip}` 编出不可执行编码、普通块内声明被当成 `__smc(0)` 而发 `SMC #0`。门禁：`run_full_test.ps1` PASS=73、`examples/run_tests.ps1` 断言 71 通过、`run_arm_exec.py` 13 个用例在 unicorn 真跑、`run_asm_cmp.py` 12 用例与 GAS 逐字节一致 + 30 条开关 + 15 条拒收、`run_regalloc_tests.py` 4 组三臂、`run_capacity_tests.py` 4 项。

- v0.7.0：armcc 兼容覆盖 98%+，STM32 自托管稳定。新增：armcc 关键字（`__value_in_regs`/`__pure`/`__interwork`/`__thread`/`__global_reg`/`__smc`/`__int64`..`__int8`/`__typedef`/`__args`/`__return`/`__tp_soft`/`__nothrow`/`__deprecated`/`__may_alias`/`__softfp`）、`__attribute__` 属性扩展（`may_alias/nothrow/pure/const/visibility/nonnull/warn_unused_result/sentinel/malloc/fastcall/stdcall/cdecl`）、预定义宏（`__arm`/`__thumb`/`__STDC_VERSION__`/`__STDC_HOSTED__`/`__SIZE_TYPE__`/`__PTRDIFF_TYPE__`/`__WCHAR_TYPE__`/`__EDG__`/`__APCS_INTERWORK`）、完整 DWARF（`.debug_info`/`.debug_abbrev`/`.debug_line`）、TLS（`.tbss`/`.tdata`）、`__packed` 指针非对齐访问、`--split_sections` 每函数一段、scatter 加载描述文件（`include/scatter.h`+`src/scatter.c`）、CPU 选择（`-mcpu`/`--cpu`+`include/cpu.h`+`src/cpu.c`）、命令行扩展（`-MMD`/`--depend`/`-MF`/`--dollar`/`--enum_is_int`/`--fpu`/`--thumb`/`--arm`/`--dwarf2`/`--dwarf3`/`--signed_chars`/`--unsigned_chars`/`--wchar16`/`--wchar32`）、配置项扩展（`enum_is_int`/`dollar_in_identifiers`/`split_sections`/`signed_chars`/`wchar16`/`wchar32`/`dwarf_version`）。全部 62 测试通过。
- v0.6.0：配置系统 + 优化Pass + 调试信息 + 前端/后端加强。新增：三层配置系统（`arkcc_config.h` 编译时宏 + `arkcc.cfg` INI 运行时配置 + `-O/-g/-f/-fno-/-config` 命令行）、VLA（`IR_ALLOCA`）、宽字符 `wchar_t`/`L"..."`/`L'...'`、三字符组（全部 9 个 C99 三字符组）、`_Complex` 复数类型、硬件 FPU 指令（VFP `VADD/VMUL/VCVT/VCMP` 替代软浮桩）、DWARF 调试信息（`.file/.loc/.cfi_startproc/.size`）、IR 级常量折叠+死代码消除（`src/opt.c`）、逗号分隔局部声明作用域 bug 修复。全部 56 测试通过。
- v0.5.0：四波必备特性（启动/中断向量、HAL/DMA/MMIO、控制算法/printf 调试、RTOS/完整工程）。新增：`__asm` 整函数体汇编、`__attribute__((used/unused/alias/constructor/destructor/deprecated/format))`、实际生效的 `__align`/`__at`/`__packed`/`__forceinline`、匿名 union 字段提升、`#pragma anon_unions/location/diag_suppress/arm/thumb/import/push/pop/O0-O3/optimize`、armcc 预定义宏、完整隐式转换和整数提升、`double` 真 64 位精度、全局常量表达式初始化、常量表达式数组维度、64 位不截断 `printf`、严格 AAPCS、`setjmp/longjmp`、标准库 string.c/math.c/setjmp.c
- v0.4.0：完整 C99 + armcc 兼容（`__irq`/`__weak`/`__naked`/位域打包/64 位/除法/段分离/复合字面量/灵活数组/结构体按值/pragma pack）
- v0.3.0：浮点算术、`__svc`、`.s` 编译、静态局部变量、多文件链接
- v0.2.0：多后端架构、C99 子集、标准库子集
- v0.1.0：单 ARM 后端最小 C 子集