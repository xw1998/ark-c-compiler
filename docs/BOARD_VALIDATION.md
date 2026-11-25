# 板端全功能验证（0.9.0 稳定版判据）

[English](BOARD_VALIDATION.en.md) | 中文

> 目标读者：想知道"0.9.0 凭什么叫稳定版"的人，以及以后要重跑这套门禁的人
> 编码：UTF-8（无 BOM）

---

## 1 这份文档在说什么

0.9.0 与之前版本的区别不在功能，而在**证据**：这套编译器在 STM32H743 上把自己编过的每一个
代码生成事实，都用**板上跑出来的返回值**验了一遍，而不是"汇编看上去对"。

判据只有一条：

```
tests/run_stm32_board_tests.py --port COM3 --opt 0,1,2   →   162/162 case-runs passed
```

54 个用例 × 3 个优化档（`-O0` / `-O1` / `-O2`）= 162 次"把源码放到板上、让板上编译器编译、
链接、装载、执行、把 `main()` 的返回值打回串口、与期望值比对"。

同一轮还要求宿主门禁全绿（`make test`，30 个目标，`0 failure(s)`）——板上验的是同一份
后端，宿主验的是前端/中端/文档/拒绝路径，两边都不能有红。

---

## 2 门禁怎么工作

| 步骤 | 做什么 | 为什么要这样 |
| --- | --- | --- |
| `demo` | 装 `crt.c` + `app.sct`（会清 RAM 槽） | 后面每次链接都要一份 scatter 与启动代码 |
| `runtime` | 板上把 `aeabi.c`、`aeabi_divmod.s` 编成 `aeabi.o` / `aeabi_div.o` | 用**板上编译器**产出运行库，链接的才是被测版本 |
| `put` + `sum` | 逐行喂源码，然后 `sum` 取 `size` + FNV-1a-32 | 只比字节数抓不到"重复了一块"；哈希对不上最多重传 3 次 |
| `run` | 板上 `cc -c` → `cc -link` → 装载 → 执行 | 返回 `[arkcc] program returned N` |
| 判 | `N` 与期望值相等 → PASS | 期望值是**独立算出来的**，不是同一份实现自己算的 |

三条硬约束写进门禁：

1. **自检**：门禁结束时故意用一个错期望（`expect 35`，真实值 34）跑一遍，必须被拒绝。
   拒绝不掉说明判据是假的，整轮作废——这就是「闸门必须自带防假绿自检」。
2. **掉线不算失败，但要可见**：串口中途失联或 `put` 未被接受时，门禁走
   `reset_board()` → `sync` → `demo` → `install_runtime()` 恢复，并打印
   `[board] note: resetting the board and re-running <case> O<n> once`。重跑后仍按返回值判
   PASS/FAIL，不静默升级成通过。
3. **返回值必须整行收完**：`run` 的匹配模式带着行尾（见 §6.3），数字少一位就是错答案，
   而不是"另一个正确答案"。

---

## 3 实测读数（0.9.0）

| 项 | 读数 |
| --- | --- |
| 板端全量（正式固件 c21，**刚烧录后第一轮**） | **162/162 case-runs passed**，1022.8 s（约 17 分钟）；其中 1 例因串口 `put` 未被接受触发一次可见复位重跑（86.7 s，属串口 RX 丢字节的既有欠账，不是编译器问题，见 §8） |
| 板端定向复验（新烧录首跑，3 个 double 用例） | `dbl_ull_cast` / `dbl_ll_frac` / `f_ull_cast` **3/3 PASS**，`runtime built on board: aeabi.o 12833 B (12028 code, 27 syms, 11 relocs, 11 .arktext)` |
| 负控制（故意把 `enable_reloc_text` 置 0 的固件） | `[arkcc] aeabi.o carries 0 .arktext relocations (26 syms, 0 relocs): it was built with --reloc-text off, ... Refusing to report the runtime as ready` ⇒ 新检查确实能失败（见 §5.1 第 7 行、§6.5） |
| 固件 | `mdk/STM32H743_ArkCC` 用 UV4 批处理编译 + 烧录，`Verify OK`，`version` 回 `Ark C Compiler v0.9.0` |
| 宿主门禁 | `make test` 30 个目标，`0 failure(s)` |
| 缓冲门禁 | `tests/run_buffer_tests.py` 7 项全过（`all buffer checks passed`） |
| 未解析符号 | 板上 `link` 明确报 `app.bin: Error: unresolved symbol "nope"`，`link failed: -8` |

> 上一轮（同一套用例、同一份固件，门禁还没修 §6.3 的前缀匹配）读数是 `160/162`，两个"失败"
> 是门禁把 `11` 读成 `1`、把 `68` 读成 `6`：两个用例单独重跑 4/4 全过。修法见 §6.3。
>
> "刚烧录后第一轮"这几个字是本节的关键限定：§5.1 第 7 行的缺陷只在**新烧录后的第一次** `runtime`
> 上现形（旧固件下那三个 double 用例会给出 68 / -1 / 68 这样的错值），重跑就看起来好了。所以全量
> 162/162 只有在「先烧录、再跑、一次不重来」的口径下才有意义；这也正是这轮把开关收到 `main()` 里、
> 并让 `cmd_runtime()` 读自己刚写的对象的理由（§6.5）。

---

## 4 覆盖范围

54 个用例，每个只赌**一条**代码生成事实。按主题分八组：

| 组 | 用例 | 赌的是什么 |
| --- | --- | --- |
| 调用约定 | `int_args_9`(34)、`mixed_8_args`(22)、`struct_byval`(45)、`struct_sret24`(38)、`struct_sret40`(19)、`func_ptr`(42)、`fptr_table`(14)、`ptr_llong_arg`(41)、`varargs_copy`(20) | 6 个整数寄存器 + 栈上参数、8/24/40 字节聚合体的传参与返回、函数指针表、指针当一个字而 `long long` 两个字 |
| 64 位整数 | `ll_mul`(7)、`ull_div`(74)、`ull_loop`(187)、`llong_local_init`(1288)、`dbl_ull_cast`(187)、`dbl_ll_frac`(7)、`f_ull_cast`(31) | `__aeabi_lmul/ldiv/uldiv/ldivmod` 各路径；double → 整数必须向零截断（高位不能进位） |
| 整数语义 | `promo_uchar`(3)、`neg_div`(29)、`signed_div`(68)、`unsigned_shift_right`(1)、`unsigned_shift_right_var`(1)、`unsigned_relational`(15)、`bitfield_neg`(7)、`bitfield_signed`(112)、`bitfield_incdec`(220) | 整型提升、C99 6.5.5p6 向零截断、`shr` 不是 `sar`、无符号比较、位域符号扩展与相邻位域不被踩 |
| 聚合体 | `struct_cond`(34)、`struct_cond_arg`(12)、`struct_ll_field`(21)、`struct_copy16`(11)、`sizeof_member_array`(0)、`designator_chain_local`(15)、`designator_chain_global`(79) | `?:` 产生值不是左值（要物化临时）、16 字节聚合拷贝真走 `__aeabi_memcpy`、`sizeof` 成员数组不是 4、指派链 |
| 指针与数组 | `ptr_walk`(84)、`ptr_diff`(51)、`ptr_llong_roundtrip`(5)、`ptr_array_init`(0)、`data_array_init`(30)、`rodata_ptr`(35)、`ptr_local_init_null`(11) | 8 字节指针运算与差、指针 ↔ `long long` 要补/丢高位、初始化列表里指针元素两个半字都要写 |
| 浮点 | `float_mul`(23)、`float_add`(16)、`double_cmp`(1001)、`double_precision_bits`(7)、`double_precision_arith`(45)、`double_local_init_from_int`(46)、`uint_to_double`(4000)、`double_to_uint`(3500)、`uint_to_float32`(4000)、`fconv_rne`(42) | 单/双精度两条通路、`VCMP` + `VMRS` 的比较链、binary64 位型、无符号 ↔ 浮点（有符号指令要拆 2^31 补偿）、`float↔double` 的四种舍入平局 |
| 变量长度与运行期尺寸 | `vla_sizeof_at_declaration`(7)、`vla_length_conversion`(7)、`vla_outer_dim_2d`(10) | `sizeof` 回答声明时算出的值；长度表达式要走它自己的转换；外层维度可变 |
| 控制流与符号 | `fib_switch`(99)、`x86_sym_plus_disp`(7) | 递归 + 跳转表、`[symbol+disp]` 取 64 位全局的高字 |

> 用例表在 `tests/stm32_board/board_cases.py`，每个用例带一句"这个数只有在对的代码生成
> 下才可能得到"，并尽量选一个**错答案会给出别的数**的期望值（例如 `double_cmp` 的
> 1001 = 1 + 1000，四个比较各占一位，答错任何一条都对不上）。

---

## 5 这一轮"稳定版"修掉的根因

### 5.1 本轮（0.9.0）修的

| # | 现象 | 根因 | 落点 |
| --- | --- | --- | --- |
| 1 | 大源文件在板上会被静默截断，产出一份"能跑但语义错"的机器码 | 板端 `ARK_SRC_BUF_SIZE` 1 KB / `ARK_ASM_BUF_SIZE` 8 KB 装不下真实用例 | `include/arkcc_config.h` STM32 档改为 **32 KB 源码 / 256 KB 汇编**（含 `ARK_OBJ_BUF_SIZE = asm + 16`） |
| 2 | 缓冲真被顶穿时，四个后端都只是把 `%.*s` 截断后照常输出 | 没有一处拒绝 | `backend_arm.c` / `backend_c.c` / `backend_riscv32.c` / `backend_x86_64.c` 各自在 emit 处检查负数长度并**拒绝**；`compiler.c` 指名宏 `ARK_ASM_BUF_SIZE` 报诊断 |
| 3 | 新增门禁防回归 | — | `tests/run_buffer_tests.py`（`make test-buffers`，7 项）：4 KB 汇编缓冲拒更大的程序、1 KB 源码缓冲拒更大的文件、"不留对象"、正常编译仍逐字节相同 |
| 4 | `fconv_rne` 在 `-O0/-O1` 返回 95（期望 42） | **测试自己的期望位型写错了**：`0x47EFFFFFE0000000` 正好是 `FLT_MAX`，转 float 是 `0x7F7FFFFF` 不是 inf；真正的"`FLT_MAX` + 半个 ulp 平局到 inf"是 `0x47EFFFFFF0000000` | `tests/stm32_board/board_cases.py`；宿主门禁里同一张表本来就写对了（交叉核对过） |
| 5 | 全量跑到第 158 例时 `put` 未被接受，板子失联 | 串口 RX FIFO 吞掉命令行 / 测试镜像把 shell 打死，**不是编译器问题**（隔离单跑 2/2 PASS） | 门禁新增 `reset_board()` + `bring_back()` + 每例一次重跑 |
| 6 | 门禁把 `11` 读成 `1`、把 `68` 读成 `6` | 匹配模式 `program returned (-?\d+)` 在**第一位数字到达时**就成立，把半个数字当返回值判 | 模式补行尾 `\r?\n`（见 §6.3） |
| 7 | 刚烧录后第一次跑，三个 double 转换用例答错（`dbl_ull_cast` 68、`dbl_ll_frac` -1、`f_ull_cast` 68），同一固件不烧录重跑又全过 | 板端 `runtime` 编 AEABI 时 `g_config.enable_reloc_text` 还是 0（这个开关只在 `build` / `run` 里设过），于是 `aeabi.o` 是 **12607 B / 26 syms / 0 relocs**，常数池里的绝对地址按 `0x08000000` 烘死；镜像却装在 `0x24070000`，读到的是 Flash 里的固件字节。重跑全过是因为那一轮 `g_config` 已被前面的 `run` 置 1，`install_runtime` 再编出来的是 **12833 B / 27 syms / 11 条 `.arktext`** 的好对象 | `User/main.c`：`main()` 在 `config_init()` 之后统一置 `g_config.enable_reloc_text = 1`；`cmd_runtime()` 编完**读对象本身**，`.arktext` 计数为 0 就拒绝报告 ready（见 §6.5） |

### 5.2 之前几轮修的（已在 git 历史里，可追溯）

| 提交 | 修掉的东西 |
| --- | --- |
| `ed06a73` | ARM 软浮点 AEABI 运行库（30 个入口，纯整数实现）；函序言用 `__aeabi_memcpy` 拷 struct-by-value 时把形参 r1-r3 一起 clobber；Thumb-2 改良立即数编码器旋转量写成三位（`0x80000000` 这类立即数编码错） |
| `4f8d014` | 板上真闭环：编译 → 链接 → 装载 → 执行；一次调用一份布局 |
| `544736a` | MDK（STM32H743）工程链接 |
| `be63198` 等 | 四个共性问题：`double → 64 位整数`的高半字进位、struct-typed `?:` 物化、`ptr → long long` 插 cast、i386 的无符号位（`shr`/`seta`） |

---

## 6 门禁自身教出来的五条教训

### 6.1 测试的期望值也会错，而且更容易错

`fconv_rne` 的 95 不是编译器的答案，是测试把 `FLT_MAX` 当成了"刚好溢出"。这类错误的特征是
**只有这一档错、换一档就对**，所以先做的是"同一条用例在别的档/别的门禁里怎么说"的交叉核对，
而不是去改 `__aeabi_d2f`。

### 6.2 串口掉线必须与"程序真挂"分开

两者在日志里长得一样（没有返回值）。区分办法是隔离复跑：单跑 2/2 过 ⇒ 是链路；单跑也挂 ⇒
是代码。恢复动作（复位 + 重装 `demo` + `runtime`）必须**显式打印**，因为复位会清掉 RAM 盘里
的中间对象，重装是为了不让"磁盘还在"这个假设把某个用例判成错答案。

### 6.3 "数字读一半"是最阴的一种假失败

第三轮之前，门禁的返回值模式是 `\[arkcc\] program returned (-?\d+)`。串口按块把文字交给宿主，
`68` 的两个字节可能分两次到达；正则一旦看到 `6` 就成立，于是判 `returned 6`。表现是
**随机、低频、只在数字有重复位时明显**（`11`→`1`、`68`→`6`），隔离重跑又全过。

修法是把行尾放进模式：`\[arkcc\] program returned (-?\d+)\r?\n`。板端在
`put_int_dec(rc)` 之后立刻打印 `\r\n`，所以"等到换行"就等于"数字收完了"，不需要额外协议。
同一检查顺带扫过另外两处数字解析：`[put] stored (\d+) bytes` 与 `[sum] ... size=(\d+) fnv=0x%08x`
都带固定后缀（` bytes` / 8 位十六进制），不存在前缀成立的可能。

### 6.4 子进程的 cwd 会把标准库换成别的模块

`reset_board()` 用 `subprocess` 调 `python -m pyocd`。如果 cwd 恰好是临时目录，而那里有一个
叫 `cmd.py`（或 `dis.py`）的历史脚本，`python -m pyocd` 会先 import 到它，报
`module 'cmd' has no attribute 'Cmd'`。修法是调用时固定 `cwd=tests/`，并清掉 `PYTHONPATH` /
`PYTHONHOME`。

### 6.5 两份都"合法"的对象：能链不等于能跑

这条是 0.9.0 最后一次根因定位，也是最值得记住的一种：**同一份 `aeabi.c`、同一个编译器，
两次运行产出两个互相不同的对象，两个都能链接成功**。

| 状态 | `aeabi.o` | 表 | 现象 |
| --- | --- | --- | --- |
| 刚烧录（`enable_reloc_text=0`） | 12607 B | 26 syms / 0 relocs | 3 个 double 转换用例答错 |
| 之后（`enable_reloc_text=1`） | 12833 B | 27 syms / 11 relocs | 全部正确 |

两者的**代码段完全一样**（都是 12028 B），差的 226 B 全在符号/重定位表里。所以任何只看
"编过了""链上了"的判据都看不见它——`link` 也确实报了 `4 objects -> app.bin`，只是那个镜像
里常数池的地址指向 `0x08000000`。

把它定死的手法，是把"同一源→两个对象"这件事本身当成证据：

1. 读对象的**尺寸 + 符号数 + 重定位数**（`sum`/`link` 输出），而不是只看编译退出码；
2. 在宿主复现同一个分裂：`-mcpu Cortex-M7 -c` 得 12607 B / 0 relocs，
   再加 `--reloc-text` 得 12833 B / 11 条 `.arktext` ⇒ 差异被锁定在一个开关上；
3. 把判据落进**产出端**而不是日志端：板端 `cmd_runtime()` 自己走一遍 ARKOBJ2 的表，
   `.arktext` 为 0 就拒绝说 ready，门禁只认这行里的数字。

教训：**功能的开关如果只在一个入口打开，另一个入口就会安静地产出错误的产物**；
而这个项目的判据必须是"读产物"，不是"读意图"。

---

## 7 "宁可报错，不给错答案"的板上取证

板端 `link` 遇到未定义符号时的实测输出（`put` 一份 `extern int nope(void);` 再 `run`）：

```
[link] vector table written into the 1024-byte hole the first object reserved (SP=0x2407C000, entry=0x24070478)
app.bin: Error: unresolved symbol "nope"
[arkcc] link failed: -8
```

没有镜像、没有返回值、退出码非 0。这条必须单独取证，因为"静默成功"正是这个项目最怕的失败
模式：板上跑起来的代码里那个符号是 `0x00000000`，程序会跳到向量表。

---

## 8 已知欠账（不属于 0.9.0 判据）

| # | 欠账 | 现状 |
| --- | --- | --- |
| 1 | 每语句约 1.3 KB 的 arena | 大函数在板上仍受 RAM 限制；未改 |
| 2 | 长 `double` 字面量差 1 ulp（例如 `.L_dbl_9` = `1:0x43e00000`） | **已修**（0.9.1-wip）：字面量改走 2304 bit 定点大数、单次舍入，宿主与板端同一份实现；见 `docs/FLOATLIT.md` |
| 3 | 板端没有上传 `aeabi_float.c`（30 个软浮入口） | 板端用例都走 VFP 或整型路径，软浮由宿主门禁 `test-softfloat` 覆盖 |
| 4 | 串口 RX 偶发丢字节 / 板子偶发失联 | 由门禁自动复位兜底；根因未定位到具体寄存器级 |
| 5 | `pyocd -m` 需要固定 cwd | 已在 `reset_board()` 里固定 |

---

## 9 复现

```bash
# 1) 宿主：编译器本体 + 全部门禁
export PATH="/d/mingw/MinGW/bin:$PATH"
env -u PYTHONPATH -u PYTHONHOME make PYTHON="<python>" test

# 2) 固件：编译 + 烧录（UV4 批处理，-j0 让 warning 不算失败）
"D:/Keil_v5/UV4/UV4.exe" -b ArkCC.uvprojx -j0 -o build.log      # 在 mdk/STM32H743_ArkCC/ 下
"D:/Keil_v5/UV4/UV4.exe" -f ArkCC.uvprojx -j0 -o flash.log      # EXIT=0 且日志有 Verify OK
pyocd commander -t stm32h743xx -c "reset" -c "go"               # UV4 之后必须放行

# 3) 板端全量（约 16 分钟，串口独占）
env -u PYTHONPATH -u PYTHONHOME python -X utf8 tests/run_stm32_board_tests.py \
    --port COM3 --opt 0,1,2
# 期望最后两行：
#   [board] 162/162 case-runs passed in <n>s
#   PASS selfcheck: an expectation of <x> was rejected (the real value is <x-1>)

# 4) 只跑几个用例（改完一处后端时最常用）
... --only struct_copy16,fconv_rne --opt 1,2
```
