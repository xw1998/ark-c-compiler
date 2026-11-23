# 未被引用的 `static` 函数不再发射（默认生效，无开关）

[English](DEADSTATIC.en.md) | 中文

> 一句话：`static` 函数只有本翻译单元能叫到。本单元一次都没提到它，它就不可能运行，
> 它的函数体只是躺在对象文件里的字节。ARK 过去对每个函数体都发射代码，于是「包含了
> 头文件但没调用」这种最常见的形态会带出死代码——95 个 TU 的 HAL 语料上白白多出
> **1,737 条指令（−9.57%）**、叠 `-fopt-vreg` 时 **2,538 条（−13.98%）**。
> 现在这一步在 IR 层统一做掉，四个后端、所有路径（`-S` / `-c` / `--ipo` / `-link --lto`）
> 走同一条路，`-O0` 同样生效。

---

## 0 这份文档回答什么

1. 为什么不发射是**正确性**而不是优化（§1）；
2. 什么算「被引用」（§2）；
3. 哪些函数**一定不删**（§3）；
4. 原始汇编文本里的引用怎么处理，读不出来时会怎样（§4）；
5. 实测数字与门禁（§5、§6）；
6. 作者怎么保住一个函数、怎么知道它没被用（§7）；
7. 本 pass **不做**什么（§8）。

## 1 为什么这是正确性修复

C11 6.2.2p3：`static` 函数是内部链接，外部翻译单元无法命名它。
C11 6.7.4p6 只要求「用了就必须有定义」，没有要求「没用也必须留一份」。
所以删掉一个不可达的 `static` 函数体，在任何符合标准的实现下都是允许的。

在 ARK 里它同时也是**必须**的：死掉的头文件助手会引用「只声明未定义」的外部对象。
最典型的形态是 CMSIS 的

```c
__STATIC_INLINE uint32_t ITM_SendChar(uint32_t ch) { ... ITM_RxBuffer ... }
```

`ITM_RxBuffer` 由调试器提供，源码里只有 `extern` 声明。只要 TU 里存在 `ITM_SendChar`
的定义，对象写出阶段就会拒绝：

```
Error: reference to the global 'ITM_RxBuffer', which this translation unit only declares; ...
```

这段代码永远不会执行，却能让一次编译失败。删掉它，问题连同死代码一起消失。
gcc 自 `-O1` 起就删，armcc、IAR 也删——这不是激进，是同行都在做的事。

## 2 「被引用」的定义：一个不动点

`ir_drop_unused_static()`（`src/ir.c`）在 IR 层计算可达性，边有五种：

| 边 | 来源 |
| --- | --- |
| 调用 | `IR_CALL` 的 `name` 等于候选名 |
| 取地址 | `IR_PUSH_FUNC` 的 `name` 等于候选名（`&f`、函数指针表、`_Generic` 派发都会产生它） |
| 全局初始化器 | `IrGlobal::init_sym` / `init_refs[]`（`int (*tab[])(void) = { h };`） |
| `alias` 目标 | 存活函数的 `alias_target` |
| 原始汇编文本 | `IR_ASM` 的 `name` 或 `is_asm_func` 函数的 `asm_body` 里出现了候选名（§4） |

起点是「为自身原因而保留」的函数：非候选的那些（外部链接、`main`、入口点名、带
`used`/`weak`/`interrupt`… 的函数）。从它们出发做不动点，因为一个死函数可能是另一个
死函数的唯一调用者——整簇一起消失才是正确结果。

**候选**只有一个条件：`is_static` 且不在 §3 的保留名单里。

## 3 一定不删的清单

| 保留条件 | 理由 |
| --- | --- |
| `__attribute__((used))` / `__attribute__((unused))` | 作者显式说过「这个符号本身有意义」 |
| `weak` | 弱定义可能被链接期覆盖，也可能被外部取址 |
| `constructor` / `destructor` | 启动代码按段名调用，不由 C 代码调用 |
| `interrupt`（`is_irq`）/ `naked` | 向量表按名引用、函数体是原始汇编 |
| `alias` 目标 | `static void f(void) __attribute__((alias("g")));` |
| `main` | 入口 |
| 入口点名 | `_start`、`Reset_Handler`、`NMI_Handler`、`HardFault_Handler`、`MemManage_Handler`、`BusFault_Handler`、`UsageFault_Handler`、`SVC_Handler`、`DebugMon_Handler`、`PendSV_Handler`、`SysTick_Handler`、`Default_Handler`、`__arkcc_init_globals` |

最后一行是保守的：链接脚本、向量表、启动代码都可能**按名字**引用它们，不看 C 代码。
一个 `static` 的 `SysTick_Handler` 很少见但合法；把它删掉，最好情况是链接期报 undefined，
最坏情况是裸镜像的向量跳到后面的任意字节上。这一步只为省字节存在，不值得冒这个险。

## 4 内联汇编：能读文本就保留，读不出来就响亮报错

汇编语句里的符号对控制流图不可见，所以 `__asm("bl helper");` 这类引用必须靠文本判断。
本 pass 对每个未保留的候选做一次子串搜索（`ir_text_names`），命中就保留：

- `bl helper`、`ldr r0, =helper`、`.word helper` 都能命中；
- 搜索是**子串**而不是词边界，所以 `helper2` 也会让 `helper` 保留——假阳性只是多留一个
  函数体，假阴性才是链接错误；
- `__asm` 整函数体（`asm_body`）走同一套扫描。

真的读不出来的形态（例如汇编宏把名字拼接出来）会怎样？名字不会出现在 IR 里，
`static` 定义被删，链接期**报 undefined symbol**。这是**响亮失败**，不是错镜像——
符合项目口径「宁可报错，不给错答案」。

## 5 实测（95 TU，STM32F401xE HAL，Cortex-M4，`-O2`）

计数口径：`^\s+[A-Za-z][A-Za-z0-9.]*\s`（不数标签、不数伪指令、不数注释）。

| 口径 | 基线 | 现在 | 差 |
| --- | ---: | ---: | ---: |
| 十六开关（无 vreg） | 18,151 | **16,414** | **−1,737（−9.57%）** |
| 同上 + `-fopt-vreg` | 18,151 / 17,350 | **15,613** | **−2,538（−13.98%）** |

- **95 个 TU 全部变小**，没有一个变大；
- 空壳 TU 直接归零（`stm32f4xx_hal_adc.c` 这类「包含一堆头文件、函数体一个都不用」的
  文件，19 条 → 0 条）；
- 省下来的全是没有入边的函数体（CMSIS 的 `__REV16` / `__REVSH` / `__RRX` 这类
  `__STATIC_INLINE __ASM` 助手在 95 个 TU 里各带一份）。

## 6 门禁

`tests/run_deadinline_tests.py`（`make test-deadinline`，**24 项**）：

- 死 `static inline` 与死普通 `static` 都消失（`-c` 和 `-S` 一致）；
- 活函数保留，死函数引用的活函数保留；
- `ITM_SendChar` 那种「死代码引用只声明对象」的形态现在能编译通过；
- 每条保留理由各一个反假通过：`used`、`weak`、`constructor`、`interrupt`、`alias`、
  入口点名（`static void SysTick_Handler`）都留着；
- 「普通 `static` 加 `used` 仍然报 only declares」——证明保留是真的靠属性，不是碰巧；
- `__asm("bl keep_by_asm")` 点名则保留（仍报 only declares）；asm 没点名时死 inline 照删。

另有 `tests/arm_exec`（默认臂 + `-fopt-vreg` 臂，各 39 用例 0 failure）覆盖真实执行：
删错任何一条活路径都会在 emulator 里变成错答案。

## 7 作者的两条逃生门

1. **`__attribute__((used))`**：显式保住一个没有 C 引用的 `static`（中断服务函数、
   被链接脚本取址的表项、只被汇编调用的实现）。
2. **`--warn-unused-static`**：这条诊断在 pipeline 更早处（MIR/CFG 阶段）运行，所以
   即使函数体已经不发射，作者仍然会听到「这个 static 没人用」。删代码不等于不告诉人。

## 8 本 pass 不做什么

- **不删非 `static` 函数**：外部链接的符号可以被别的 TU 引用，本 TU 看不见。
- **不删全局变量**：未引用的 `static` 全局仍按原样发射（它们的初始化表达式可能有副作用，
  且 `volatile` / 段属性语义更重）。这条留给未来的独立工作项。
- **不处理 `__aeabi_memcpy` 之类的编译器运行时**：那不在 IR 里，是 ARM 后端在
  「确实出现 `BL __aeabi_memcpy`」时按需拼的文本，本来就是按需发射。
- **不是优化开关**：没有旗标、`-O0` 生效。给它开一个「关掉」的开关只会让关掉的一方
  重新踩 `ITM_RxBuffer` 那种编译失败。

## 9 实现落点

| 文件 | 改动 |
| --- | --- |
| `src/ir.c` | `ir_drop_unused_static()`（可达性不动点）、`ir_is_droppable_static()`（候选判据）、`ir_name_is_entry_point()`（入口点名名单）、`ir_text_names()`（汇编文本子串搜索） |
| `include/ir.h` | 声明与口径注释 |
| `src/compiler.c` | `ark_emit_program()` 内的唯一调用点；`-v` 打印 `dropped %d unreachable static function(s)` |
| `tests/run_deadinline_tests.py` | 24 项门禁 |

挂在 `ark_emit_program()` 这个唯一收口处，所以 `-S`、`-c`、`--ipo`、`-link --lto`、
arm / i386 / x86_64 / rv32 / c 五个后端看到的是同一份已清理的 IR。
