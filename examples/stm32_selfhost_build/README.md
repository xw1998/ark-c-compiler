# 板上自举例程：在 STM32 上编译、在 STM32 上跑

这个目录是「**用 arkcc 在 STM32H743 上编译出 STM32 程序，并在同一颗 STM32 上把它跑起来**」
的最小可复现例子。它不是"编译成功了"这种间接证据：跑起来的程序会从板子的串口打出
两行字，其中一行是**跨编译单元调用**的结果。

整个流程没有主机参与编译：宿主机只通过串口把 `.c` 文件和一份工程描述送进板子的
littlefs 卷，剩下的编译、链接、打包、装载、执行全在板子里完成。

## 文件

| 文件 | 作用 |
|---|---|
| `add.c` | 一个函数：`int add3(int a, int b, int c)` |
| `main.c` | 入口 `Reset_Handler`：打印一行、调用 `add3(1,2,3)`、按结果再打印一行 |
| `makefile` | ark make 工程描述：两份源 → `/mnt/nor/app.svcm` |
| `defs_probe.c` | 受 `DEFS` 与 `INCS` 双重控制的 `probe()` |
| `defs_probe_main.c` | 入口：按 `probe()` 的返回值打印 42 或"缺东西" |
| `probe.h` | `#define PROBE_FROM_HEADER 42`，只能通过 `INCS` 找到 |
| `makefile.defs` | 带 `DEFS = ARKMAKE_DEFS_PROBE` 与 `INCS = /mnt/nor` 的工程描述 |

`main.c` 只用到三个东西：`__svc(0x1A) svc_shell`（往控制台打一行）、
`__svc(0x1B) svc_thread`（结束当前小程序、把内存还回去）、
以及 `__arkcc_init_globals()`（编译器自己生成的全局初始化桩）。

## 前提

1. 板子上跑的是 **Ark RTOS**（`gitee xw19981010/ark-rtos`），并且固件带上了这几项：

   ```
   make -j8 USE_QSPI=1 USE_MINI_VFS=1 USE_APPPACK=1 USE_ARKMAKE=1
   ```

   `USE_QSPI=1` 漏了的话启动时不会打印 `NOR:1885 W25Q64 answered...`，`mount` 会
   一直失败（这坑踩过，别去查驱动）。
   `USE_ARKMAKE=1` 依赖 `USE_ARKC=1` 与 `USE_APPPACK=1`——缺一个都是编译期
   `#error`，不会留到运行期。

   还有一条只在**速度**上体现的：ark-rtos 的 QSPI 读通道在 2026-11-05 从位敲换成了
   **内存映射**（启动日志里出现 `read=mm 0x03 1-1-1` 就是新固件）。老固件照样能跑
   完本示例，只是读一卷按 1.5 KB/s 算：`ls /mnt/nor` 要 258 s、`make` 要 41.95 s；
   新固件是 0.249 s / 3.84 s，**产物逐字节相同**。

2. 串口控制台（115200 8N1）能敲命令。

## 复现

```console
# 1) 挂载外部 NOR（大约上电 3 s 之后才稳定；已挂载过会报 already exists，无害）
ark@arkrtos:~$ mount /mnt/nor
nor0 mounted at /mnt/nor

# 2) 把本源文件送进 littlefs 卷。
#    路径是 littlefs 里的绝对路径（/add.c），不是挂载点路径（/mnt/nor/add.c）:
#    `fs put` 直接调 arkrtos_fs_open_write，不做 VFS 前缀解析。
ark@arkrtos:~$ fs put /add.c 52
ark@arkrtos:~$ fs put /main.c 452
ark@arkrtos:~$ fs put /makefile 256

# 3) 在板上构建（四遍差分包成可装载镜像）
ark@arkrtos:~$ cd /mnt/nor
ark@arkrtos:/mnt/nor$ make
make: /mnt/nor/app.svcm <- /mnt/nor/add.c (+more)
make:   src /mnt/nor/main.c
cc: pack 2 sources -> /mnt/nor/app.svcm (4 passes, -O1)
cc:   A 4504 B
cc:   B 4504 B
cc:   C 4504 B
cc:   D 4504 B
cc:   A vector: SP 0x20002000 entry 0x8000A50 (rom base 0x8000000, window 8192 B)
cc: /mnt/nor/app.svcm: payload 4504 + table 4 x 4 = 4776 B
cc:   reloc rom 1 / ram 1 / rom_movw 2 / ram_movw 0, entry +0xA50
cc: packed in 41953 ms
make: ok

# 4) 在板上跑（mini run 要绝对路径：它不按当前目录解析）
ark@arkrtos:/mnt/nor$ mini run /mnt/nor/app.svcm
[ 1081.475] <6>MINI:579 /mnt/nor/app.svcm: 4504 B payload -> code 0x24070000 (8192 B block), RW/stack 0x24072000 (8192 B), task 4
ARKMAKE: link ok
ARKMAKE: cross-file add3=6
[ 1081.695] <6>MINI:873 task 4 returned: MiniApp finished, code and RAM blocks back in the pool
```

> 上面两段日志是**位敲读时代**（2026-11-05 上午）的原样输出，所以里面是
> `packed in 41953 ms` 与 `[ 1081.475]` 这类时间戳。读通道换成内存映射之后同一份
> 例程重跑：`cc: packed in 3763 ms`、`make` 全程 3.84 s、`mini run` 0.37 s；
> 除耗时与时间戳外，输出**逐字相同**（`payload 4504 + table 16 = 4776 B`、
> `ARKMAKE: link ok`、`ARKMAKE: cross-file add3=6`）。原文不改，是因为一改就不是
> 实录了——哪几个数字变了，写在这里。

`ARKMAKE: cross-file add3=6` 是 `main.c` 调用 `add.c` 里的 `add3(1,2,3)` 得到的结果。
这条断言能成立，说明**两个编译单元被正确链接到了各自真实的落点**：arkcc 在 codegen
期就把绝对地址烤进了指令（`movw/movt` 成对、literal slot），对象里只有外部符号是
重定位，所以链接器不能事后搬动任何对象——一旦搬动，字符串指针就会偏低 0x400，
程序会"装载成功、一个字也打不出来、立刻退出"。

## 第二个用例：`DEFS` / `INCS` 是不是真的送到了编译器

这两个键改的是**编译结果**、不改命令行、也不改产物名，最容易"看起来能跑"而其实
没接上。所以这里有一个判据明确的探针：`probe()` 只有在 `ARKMAKE_DEFS_PROBE` 被定义
**并且** `#include "probe.h"` 真的通过 `-I /mnt/nor` 找到了，才返回 42。

```console
ark@arkrtos:~$ fs put /probe.h 29
ark@arkrtos:~$ fs put /defs_probe.c 134
ark@arkrtos:~$ fs put /defs_probe_main.c 482
ark@arkrtos:~$ fs put /makefile.defs 228

# 故意在别的目录下构建：这样 "probe.h" 除了 -I 没有第二条路
ark@arkrtos:~$ cd /
ark@arkrtos:/$ make -f /mnt/nor/makefile.defs
make: /mnt/nor/probe.svcm <- /mnt/nor/defs_probe.c (+more)
make:   src /mnt/nor/defs_probe_main.c
make:   -DARKMAKE_DEFS_PROBE -I/mnt/nor 
cc: pack 2 sources -> /mnt/nor/probe.svcm (4 passes, -O1)
...
make: ok

ark@arkrtos:/$ mini run /mnt/nor/probe.svcm
ARKMAKE: defs+incs ok, probe=42
```

## 判据（为什么这算跑通，不是"没报错"）

| 判据 | 读数 | 它排除了什么 |
|---|---|---|
| 跨 TU 调用 | `cross-file add3=6` | 只编一个文件、或链接时把另一个单元丢了 |
| 四类重定位都被覆盖 | `rom 1 / ram 1 / rom_movw 2 / ram_movw 0` | "恰好没用到哪一类"也能通过的假绿（`ram_movw` 为 0 在文档里单独记账） |
| 向量表落在正确的窗口 | `SP 0x20002000 entry 0x8000A50 (rom base 0x8000000, window 8192 B)` | 镜像按错误基址生成（装载得进去、跑起来地址全错） |
| 四遍尺寸一致 | `A/B/C/D 4504 B` 四行同值 | 链接结果依赖基址（差分表无意义） |
| `DEFS`/`INCS` 生效 | `probe=42`（cwd=`/`） | 宏与头文件目录被静默吞掉 |

## 已知限制（照实记，别当成"应该能"）

- **`SRCS` 上限 4 份**：与 `cc --pack` 的对象槽数一致，超了在解析期就报。
- **单份源码的池上限未摸清**：80 KB 池、-O1 下，482 B 的 `defs_probe_main.c`
  峰值 64720 B。更大的源码要吃 `ARK_POOL_SIZE`，而板子 RAM 只剩约 6.8 KB 余量。
- ~~**耗时不稳定**：同一份两源工程实测过 19.5 s、38.0 s、41.9 s、62.4 s。差别未查明~~
  → **2026-11-05 查明**：那 19.5–62.4 s 的差别是**读通道**造成的，不是编译或擦除。
  位敲读的单价是 616 us/字节（实测量级 1.5 KB/s），而 littlefs 每次 `open` 都会重读
  元数据块，所以**卷上文件越多、同一份工程越慢**——四组读数正好对应卷里文件只增不减
  的那几天。换成 QUADSPI 内存映射后同一份例程 3.84 s（`packed in 3763 ms`）。
  该改动在 ark-rtos（`perf(board/qspi)` 那两条提交），本示例的源码与产物没变。
  四种历史读数没有逐条复算，但量级与机制对得上：同一次 `ls /mnt/nor`，位敲 258 s、
  内存映射 0.25 s。
- **写/擦仍是位敲**（约 0.4 s 量级/次构建），读已不是瓶颈；`make` 现在的耗时大头是
  编译器自己（`packed in 3763 ms`）。
- **没有增量构建**：板上没有可靠的 mtime，所以永远全量（四遍 × 每源 + 四遍链接）。
- **装载路径是 `mini run`**（从 RAM 池借块执行），不是烧回内部 Flash。烧写回
  Flash 并跳转执行尚未打通，见根 README 的里程碑表。
