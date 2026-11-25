# 在 Windows / Linux / STM32H743 上构建 arkcc

[English](BUILD.en.md) | 中文

> 一句话：编译器核心只有 C99 + `stdio/string/stdlib`，所以同一份源码在三个地方都能编；
> 真正的差别是**内存预算**——主机上 arena 是 256 MB，H743 上要么用 32 MB SDRAM，
> 要么裁到 508 KB AXI 里。这两条路都有门禁实测，不是注释里的承诺。

---

## 1. 三个目标、四条构建路径

| 目标 | 命令 | 工具链 | 产物 |
|------|------|--------|------|
| Windows 宿主 | `make` | MinGW gcc | `arkcc.exe` |
| Linux 宿主 | `make CC=gcc` | 系统 gcc | `arkcc` |
| H743 独立镜像（无 SDRAM） | `make stm32-check` | armclang + armlink | 体积/内存核算 |
| H743 板级固件 | Keil `mdk/STM32H743_ArkCC/ArkCC.uvprojx` | ARM Compiler 6 | `.hex` |

前两条是**编译器本身**（前端 + 全部后端）；后两条是**裁切档**（`ARKCC_PROFILE_STM32_MIN`：
只有 ARM 后端，没有 x86_64 / riscv32 / C 后端，没有 1.5 MB 的活跃性表，
`-fopt-live` 被编掉）。

---

## 2. Windows 宿主

```sh
export PATH="/d/mingw/MinGW/bin:$PATH"
make -j4
./arkcc.exe examples/hello.c -target arm -S -o hello.s
```

`Makefile` 在 `OS=Windows_NT` 时把产物名切成 `arkcc.exe`、`RM` 切成 `del /Q`；
其余部分与 POSIX 完全一致。门禁：

```sh
make test          # 四十余组，最后一个是 test-live
```

`make` 与 `make test` 里的 Python 步骤用 `$(PYTHON)`，默认 `python`；
本机需要显式清掉 PYTHONPATH/PYTHONHOME 时用
`make PYTHON="C:/.../python.exe -X utf8"`。

---

## 3. Linux 宿主

```sh
make CC=gcc -j4
./arkcc examples/hello.c -target arm -S -o hello.s
```

不需要改任何源码。三条依据，按强度排列：

1. `src/`、`include/`、`port/host/` 里**没有任何** `windows.h` / `_WIN32` /
   `unistd.h` / `dirent.h` / `sys/stat.h`，也没有 `mkdir`、`fork`、`dlopen`
   这类平台 API——取文件、打印、退出全部走 `stdio`（`port/host/*.c` 一共 154 行）。
2. `Makefile` 在非 Windows 分支下产物名、`RM`、空设备都换成 POSIX 形式，
   `install` 走 `tools/install.py`（纯 Python，逐字节校验拷贝结果）。
3. 同一份源码在 MinGW gcc 与 armclang 两套完全不同的头文件/ABI 上都编过，
   说明它用的不是"某个 libc 的扩展"，而是 C99 的交集。

**验证状态要如实说：本机没有可用的 Linux 环境**（WSL 未安装发行版，也没有
arm-none-eabi-gcc / clang / docker），所以上面第 1、3 条是**静态核对 + 真实编译**
的结论，不是"在 Linux 上跑过一次"。要在 Linux 上确认，只需 `make && make test`，
预期与 Windows 相同（测试里没有平台分支）。

---

## 4. H743：两种内存布局

板子：STM32H743（2 MB Flash / 128 KB DTCM / 512 KB AXI / 32 MB SDRAM）。
编译器是自举的，要放进板子的东西是**一个 C 编译器**：arena、源码缓冲、汇编文本缓冲、
机器码缓冲、RAM 文件槽、链接符号表。这些全在 `.ark_buf` 段，由 scatter 文件决定放哪。

`make stm32-check` 把同一个源码集编出来，再用**编码了真实板级内存的 scatter**
链接一次，让 armlink 自己回答"装不装得下"：

```sh
make stm32-check
# toolchain: D:/Keil_v5/ARM/ARMCLANG/bin/armclang.exe
# --- layout: sram ---
# PASS  every STM32 profile source compiles  [34 file(s), 0 failed]
# PASS  .ark_buf fits its sram region  [475192 / 520192 bytes (91%)]
# PASS  code + rodata fits the 2 MB flash  [378796 / 2097152 bytes (18.1%)]
# PASS  ordinary .data/.bss fits SRAM1-3 (288 KB)  [30944 / 294912 bytes (10%)]
# --- layout: sdram ---
# PASS  .ark_buf fits its sdram region  [29434192 / 33554432 bytes (88%)]
# ...
# all checks passed (2 layout(s))
```

| 布局 | `.ark_buf` 放哪 | 实测 | 说明 |
|------|-----------------|------|------|
| `sdram`（部署档） | `0xC0000000` UNINIT 32 MB | 29,434,192 B（88%） | 15 项实测覆盖（§5.1），profile 默认尺寸远不够；SDRAM 由 `SystemInit()` 起 |
| `sram`（无 SDRAM 回退档） | `0x24000000` 起 508 KB | 475,192 B（91%） | 必须裁，见 §5 |

代码 + 只读数据 **378,768（sdram）–378,796 B（sram）/ 18.1%**，两种布局几乎一样——因为裁的是**零初始化的
工作区**，不是代码。`.ark_buf` 在 SDRAM 布局里是 `UNINIT`，所以 29.4 MB 的工作区
**不进 flash 镜像**；这一条也在门禁里（`the arena is not loaded as initialised data`）。

### 4.1 板级固件（Keil）

```
mdk/STM32H743_ArkCC/ArkCC.uvprojx
```

- `Linker/STM32H743VITx_FLASH.sct`：`.ark_buf` 进 32 MB SDRAM（默认）
- `Linker/STM32H743VITx_FLASH_sram.sct`：`.ark_buf` 进 AXI（回退）
- 两把开关必须**一起**掰：scatter 与 `system_stm32h7xx.c` 的 `ARK_SDRAM_BUFS`

---

## 5. 裁切阶梯

`include/arkcc_config.h` 给的是一个档，`-D` 可以逐项覆盖。下面三列是三个真实配置：
主机默认、STM32 档默认、无 SDRAM 回退档（门禁里用的就是最后一列）。

| 宏 | 宿主 | STM32 默认 | 无 SDRAM 回退 | 它是什么 |
|----|------|-----------|--------------|----------|
| `ARK_POOL_SIZE` | 256 MB | 64 KB | 64 KB | bump arena（`-link` 从中切两块 link buffer） |
| `ARK_SRC_BUF_SIZE` | 1 MB | 32 KB | 32 KB | 源文本（AEABI runtime 17.8 KB，16 KB 时实测不够） |
| `ARK_ASM_BUF_SIZE` | 8 MB | 256 KB | 96 KB | 汇编文本（AEABI `-O0` 实测 92,259 B） |
| `ARK_CODE_BUF_SIZE` | 4 MB | 32 KB | 32 KB | 机器码 |
| `ARK_OBJ_BUF_SIZE` | 8 MB+16 | 16 KB | 16 KB | 单个目标文件镜像 |
| `ARK_LINK_BUF_SIZE` | 64 MB | 16 KB | 16 KB | 最大输入对象 / 链接输出（`arena ≥ 2×`） |
| `RAMFS_SLOTS` × `RAMFS_SLOT_SIZE` | — | 12 × 32 KB | 2 × 16 KB | 板上 RAM 文件槽 |
| `ARK_LINK_MAX_SYMS` / `_RELOCS` | 16384 | 512 | 128 / 128 | 链接符号/重定位表（每项 136/140 B） |
| `PP_BUF_SIZE` | 4 MB | 64 KB | 24 KB | 预处理输出 |
| `PP_INC_BUF` × `PP_MAX_INC_DEPTH` | 1 MB × 32 | 16 KB × 8 | 8 KB × 4 | 每层 include 缓冲 |

三条不能乱动的硬墙：

- **`ARK_ASM_BUF_SIZE` ≥ 96 KB**：板上要自己编 `stdlib/src/arm/aeabi.c`，它的 `-O0`
  汇编是 92,259 B。缓冲不够时旧版本是**静默截断**（汇编器答 "unknown mnemonic P"），
  现在 `*_emit` 直接拒绝。
- **`ARK_SRC_BUF_SIZE` ≥ 32 KB**：同一份 `aeabi.c` 是 17,847 B，16 KB 档的回答是
  "input file is 17847 bytes, larger than the 16384-byte source buffer"。
- **`PP_BUF_SIZE` 必须装得下预处理后的整个 TU**：它以前溢出时**静默丢字节**（真实事故：
  `stm32f4xx_hal_gpio.c` 只产出 537 B 汇编、退出码 0），现在直接报
  "preprocessed output does not fit the N-byte PP_BUF_SIZE; ... refused" 并失败。

`RAMFS_SLOTS` / `RAMFS_SLOT_SIZE` 本轮才变成可覆盖的宏（原来写死在
`port/stm32/flash_fs_stm32.c` 里），这样 AXI 档才有得裁。

### 5.1 SDRAM 部署档（实测）

SDRAM 档不是"默认尺寸就够"，而是**必须显式给齐**：STM32 默认档是按 64 KB arena 定的，
连一个 HAL 单元都编不动。`tools/stm32_build_check.py` 的 `LAYOUTS["sdram"]` 里这 15 项
都是量出来的，不是向上取整：

| 宏 | 部署档 | 依据（实测） |
|----|--------|--------------|
| `ARK_POOL_SIZE` | 8 MB | 95 个 HAL/Core TU 的 arena peak 7,664 – 4,292,040 B；最贵 `stm32f4xx_ll_utils.c` 4.29 MB |
| `ARK_SRC_BUF_SIZE` | 512 KB | 最大源文件 `stm32f4xx_hal_fmpi2c.c` 267,050 B |
| `ARK_ASM_BUF_SIZE` | 1 MB | 单个 TU 的汇编文本 |
| `ARK_CODE_BUF_SIZE` | 256 KB | 机器码缓冲 |
| `ARK_OBJ_BUF_SIZE` | 64 KB | 单目标文件镜像 |
| `ARK_LINK_BUF_SIZE` | 64 KB | 链接输入（arena ≥ 2×） |
| `PP_BUF_SIZE` | 4 MB | `stm32f4xx_hal_gpio.c` 预处理后远超 256 KB（汇编 44,888 B） |
| `PP_INC_BUF` | 768 KB | `stm32f4xx.h` 预处理后 644,303 B |
| `PP_MAX_INC_DEPTH` | 16 | CMSIS 头链超过 8 层 |
| `ARK_LINK_MAX_SYMS` / `_RELOCS` | 4096 / 4096 | 链接符号/重定位表 |
| `ARM_MAX_SYMBOLS` / `_RELOCS` / `_GVARS` | 4096 / 4096 / 2048 | ARM 后端符号表 |
| `ARKCC_FEATURE_OPT_INLINE` | 1 | **保留内联**：裁掉它后 95 个 TU 里有 8 个与宿主 `-O2` 不同 |

`.ark_buf` 合计 **29,434,192 / 33,554,432 B（88%）**，代码 + 只读 378,768 B（18.1%），
普通 RW/ZI 86,244 B（29%，在另一块 288 KB SRAM1-3 上）。

arena 取 8 MB 而不是 4.5 MB：peak 4.29 MB 之外还要给 `--ipo` 这类"一次装多个 TU"的
用法留头；SDRAM 有 32 MB，把 arena 压到 4.5 MB 只能让 `.ark_buf` 从 88% 降到 76%，这点收益抵不上一次重量的风险。

**逐字节一致性**：用这套尺寸编出的宿主可执行文件（`-DARKCC_PROFILE_STM32_MIN` + 上表）
对 **95 个 HAL/Core TU** 做 `-O2` 对拍，去掉 `.file/.loc/.type/.size/.cfi_*` 行后
**95/95 完全相同**，最大 arena peak 4,292,040 B。板上编出来的汇编与工作站一致，
板端 bug 能在工作站复现。

### 5.2 裁掉的东西必须**拒绝**，不能静默降级（25/25 实测）

裁切的风险不是"编不过"——是"编得过但行为变了"。所以剖面裁掉的每一个优化都必须
**按名字拒绝**（诊断码 `C3900U`），而不是收下旗标然后悄悄什么都不做。

做法：拿同一份源码用**宿主 gcc** 加 `-DARKCC_PROFILE=ARKCC_PROFILE_STM32_MIN`
（外加 `-DARKCC_BACKEND_X86_64=0 -DARKCC_BACKEND_RISCV32=0 -DARKCC_BACKEND_C=0`）
编出一个真二进制，然后逐个旗标试：

| 检查 | 结果 |
| --- | --- |
| `make` 全量宿主构建（默认档） | 0 error |
| STM32_MIN 剖面宿主构建 | 0 error，二进制可执行 |
| 25 个 `-fopt-*`（addr/boolmat/branch/cbranch/cbz/cmat/coalesce/constcache/constcond/copyprop/deadpush/exit/frame/imm/litpool/live/pair/peep/prop/slotreg/strength/volbar/voldmb/vreg/vstack） | **25/25 全部 `C3900U` 且报出旗标名** |
| 反过来：`constfold` / `dce` / `inline` / `regalloc` / `vectorize` 五个开关在剖面里**保留**（不在裁切表里） | 带旗标 `rc=0` |
| 同一个源文件，不带任何 `-fopt-*` | 退出码 0，正常产出 Thumb-2 汇编 |
| `make stm32-check`（armclang + 真实 scatter，两种布局） | 见 §4，全 PASS |

最后两行合起来才有意义：**旗标被拒 ≠ 编译器坏了**，不带旗标它照样把 `stm32f4xx` 那样的
代码编成正确的汇编。剖面构建顺带证明了一件与本轮缺陷相关的事：裁掉 `-fopt-live` 之后
后端仍会发高寄存器形态（`ADDS`/`SUBS` 的 32 位 `adds.w`/`subs.w`），这条编码路径与宿主
完全相同，所以 §16.3（`docs/VREG.md`）那条装配器两遍尺寸自检在三个平台上守的是同一件事。`tests/run_vreg_tests.py` 的第 6 项把其中 `-fopt-vreg` 这一条
固化成常规门禁（`-DARKCC_FEATURE_OPT_VREG=0` 构建必须拒绝该旗标、无旗标仍可编）。

### 5.3 三个平台的验证状态（如实）

| 平台 | 怎么验的 | 状态 |
| --- | --- | --- |
| Windows 宿主（MinGW gcc） | `make` + 四十余组门禁 + 95 TU 对拍 | **已验** |
| STM32H743（armclang + armlink + 真实 scatter） | `make stm32-check`，sram / sdram 两种布局 | **已验**（§4） |
| Linux 宿主 | 本机没有可用的 Linux 环境（WSL 无发行版、无 clang/docker/`arm-none-eabi-gcc`） | **未验**，只做了 §3 的三条静态核对 |

Linux 那一格不写成"应该能跑"：`port/host/*.c` 共 154 行、只 `#include <stdio.h>` 系的
头，`Makefile` 非 Windows 分支只换产物名/RM/空设备，所以**预期**与 Windows 相同；
但"预期"不是"跑过"，拿到 Linux 机器时请 `make && make test` 复核。

---

## 6. 门禁在防什么

`tools/stm32_build_check.py` 的两类检查，都是"能编译 ≠ 跑得起来"：

1. **每个 TU 都编过**（34 个文件，`armcc`/`armclang` 的方言差异会在这里暴露——
   本轮就抓到一个：`port/stm32/platform_stm32.c` 用的是 `__value_in_regs` 关键字，
   armclang 与 gcc 都不认，现在按编译器分三支展开）。
2. **链接进真实内存**：scatter 里写死 region 大小，超了 armlink 直接报
   `L6220E ... exceeds limit`。这就是"板子装不下"的机器判定，而不是注释。

另外两条断言容易被忽略：

- `the arena is not loaded as initialised data`：`.ark_buf` 的零字节不许进 flash 镜像
  （在 SDRAM 布局里靠 `UNINIT`）。
- `ordinary .data/.bss fits SRAM1-3`：真正的 RW/ZI 在无 SDRAM 回退档只有 30,944 B（SDRAM 档 86,244 B），但它在
  **另一块** 288 KB 的 SRAM1-3 上，不能拿 AXI 的余量去抵。

`tests/run_buffer_tests.py` 现在也盯 `PP_BUF_SIZE`（4 KB 档必须**拒绝**而不是截断），
加上原有的 arena/源/汇编/链接缓冲案例共 10 项。

工具链不存在时门禁打印 `SKIP` 并返回 0——**"没有交叉工具链"不是"通过"**，
所以它把结论写在屏幕上，而不是悄悄过关。要指定路径：

```sh
python tools/stm32_build_check.py --layout both \
    --armclang /path/to/armclang --armlink /path/to/armlink --fromelf /path/to/fromelf
```

---

## 7. 没做的

- `make stm32`（arm-none-eabi-gcc 路径）仍然保留，但**本机没装 gcc 交叉工具链**，
  本轮没有验证过；已验证的是 armclang 路径。两者源码集相同，差别只在链接器脚本
  （`.sct` vs `.ld`）。
- 无 SDRAM 档能编多大的 TU，现在有定量答案：它**编不动任何 HAL 单元**。第一道墙是
  `ARK_SRC_BUF_SIZE`（32 KB vs `stm32f4xx_ll_adc.c` 的 42,704 B）和 `PP_INC_BUF`
  （8 KB vs `stm32f4xx_hal_gpio.c` 触到的 12,683 B 头文件），过了这两道还有 arena 墙
  （95 个 TU 的 peak 7,664–4,292,040 B，多数远超 64 KB）。它能编的是 ≤1 KB 的纯应用 TU：
  `examples/hello.c`（162 B 源）peak 10,816 B、`tests/stm32_board/tmp_pai.c`（422 B）
  peak 63,344 B（几乎顶满 64 KB）。**AEABI 自举必须走 SDRAM 档**：
  `stdlib/src/arm/aeabi.c`（17,351 B 源）需要 495,728（`-O0`）/ 496,032（`-O2`）B arena。
- AXI 档没有把 `.ark_buf` 拆到 SRAM1-3 的富余空间（那里只用了 10%）。真要更宽，
  应该按访问频率分段，而不是继续挤 AXI。
