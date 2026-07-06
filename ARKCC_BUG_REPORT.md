# Ark C 编译器问题审查报告（给修复 AI 用）

审查目标：解释为何 `examples/ark_test` 经 arkcc ARM 后端编译出的固件无法运行（MDK 编译同工程可运行），并评估 x64 自举与 STM32 自托管的阻塞点。

审查方法：通读 `src/backend/arm/backend_arm.c`、`src/backend/x86_64/backend_x86_64.c`、`src/backend/c/backend_c.c`、`src/compiler.c`、`src/type.c`、`src/irgen.c`、`src/parser.c`、`src/sema.c`、`build_ark_test_fw.ps1`、`ark_test_pp.c`、`ark_test_arkcc.s`、`ark_test.ark_obj` 二进制头部、`bootstrap/` 目录。

HAL 库本身未审（用户说明是标准 HAL，MDK 可运行）。

---

## 一、致命级问题（直接导致 ark_test 固件跑不起来，必须先修）

### F1. LDR/STR 局部变量偏移被截断为 5 位（imm5），大函数访问错栈
- 文件：`src/backend/arm/backend_arm.c`
- 涉及行：`IR_PUSH_VAR`（L534）、`IR_STORE`（L584）、`IR_GETARG`（L507）、汇编器 `LDR/STR` 分支（L2470–L2549）
- 现象：所有局部变量/参数访问都发 `LDR r0, [r6, #off]` / `STR r0, [r6, #off]`，汇编器只按 16 位 T1 编码：`imm5 = (imm >> 2) & 0x1F`，**偏移超过 124 字节就被截断高位**，静默访问错误的栈位置。
- 后果：HAL 里 `HAL_RCC_OscConfig`（~8KB）、`HAL_GPIO_Init`（~3.5KB）等函数局部变量极多，`alloc_local` 的 `g->bp` 偏移轻松超过 124。这些函数读写的局部变量/参数会错位，直接导致时钟/GPIO 配置错误，程序跑飞或卡死。这是 ark_test 跑不起来的**头号原因**。
- 修复方向：当 `off > 124`（字）或 `off > 31`（字节）时，必须用 32 位 T3 编码（`LDR.W Rt, [Rn, #imm12]`，imm12 字偏移可达 4095）；超出 4095 时先 `ADD r2, r6, #大立即数` 再 `LDR Rt, [r2, #小偏移]`。pass1（`op_size_a` / LDR 分支 `pc += 2`）和 pass2 必须同步判定大小，否则 pass1/2 偏移不一致会引发更严重的指令错位。

### F2. `volatile` 类型限定符被完全忽略
- 文件：`src/parser.c`（L6 注释“parsed and ignored”、L144 skip_qualifier）、`src/type.c`（无 `is_volatile` 字段/处理）、`src/sema.c`、`src/irgen.c`（grep `volatile` 0 命中）
- 现象：`volatile` 在前端被解析后直接丢弃，类型系统里没有 volatile 标记，IR 也没有 volatile 语义。
- 后果：
  1. HAL 所有外设寄存器访问（`->Instance->MODER = ...`、`READ_REG/WRITE_REG`）都是 volatile。编译器（尤其开启 `-O1/-O2` 常量折叠后）可能把对同一寄存器的多次读/写折叠、消除或重排，导致外设配置丢失或读到缓存的寄存器值。
  2. `Reset_Handler` 里 `*(volatile unsigned int*)addr = 0` 的 BSS 清零循环，编译器可能把循环消除（因为 `addr` 看似没被读）。
  3. `SystemCoreClock`、`uwTickFreq` 这类被 startup 手动赋值、又被 HAL 读取的变量，没 volatile 保护，常量折叠会把它们当成 0。
- 修复方向：Type 增加 `is_volatile`/`is_const` 位；parser 保留限定符到类型；irgen 对 volatile 左值的 LOAD/STORE 不参与常量折叠、不与相邻同地址访问合并，且保证程序序发射。

### F3. 全局变量布局：每个 .ark_obj 都从 0x20000000 重新分配，多文件/单文件合并都冲突
- 文件：`src/backend/arm/backend_arm.c` `gvar_assign`（L262–L284）、`arm_link`（L2854，空函数）
- 现象：所有非 extern、非 `__at` 的全局变量被按源码顺序硬编码到 `0x20000000` 起的 SRAM 地址；代码里用 `MOVW/MOVT` 加载这些**编译期固定地址**。`arm_link` 是 `return 0` 的空函数，不做任何重定位/地址合并。
- 后果：
  1. `-link` 模式（`compiler.c` L101）只是把多个 `.ark_obj`（其实是 C 源码文本）拼接，**根本不是真正的链接**。所以 ark_test 必须用 unity build（`ark_test_pp.c` / `ark_test_merged.c`）合成单文件编译。
  2. 即便单文件，全局变量地址是编译期固定的，**和启动栈顶 0x20018000、堆、以及 Reset_Handler 里手写的 `0x20000000..0x2000C000` BSS 清零区间硬冲突**：startup 把全局变量区清零后，再手动赋值 SystemCoreClock/uwTickFreq，但 HAL 内部其它带初值的全局变量（如 `uwTick`、`pCallback`、HAL 状态机标志等）的初值**永远丢失**（arkcc 不生成 .data copy）。
  3. 全局变量数量多时会顶到栈区。
- 修复方向：要么实现真正的链接器（符号表 + 重定位 + 段合并），要么在 unity build 路径下：把全局变量地址分配改成相对 `__bss_start` 的偏移，由 startup 统一分配；并生成 .data 初始化表（`_sidata/_sdata/_edata`），让 startup 从 Flash 拷贝初值。当前 `ark_test_pp.c` 里用硬编码地址 `0x20000000`/`0x20000024` 赋 SystemCoreClock/uwTickFreq 的做法不可扩展，任何多一个全局变量就会偏移错位。

### F4. IR_STORE 的 aux（存储宽度 1/2/4/8/16）在 ARM 后端被无视，8 字节局部只存低 4 字节
- 文件：`src/backend/arm/backend_arm.c` `IR_STORE`（L584–L589）；对比 `src/irgen.c` L949 `ir_emit(IR_STORE, off, name, 8)`、L883 `... 4`、L968 `... 1/2/4`
- 现象：irgen 按变量类型给 `IR_STORE` 传 aux=1/2/4/8/16 区分存储宽度；但 ARM 后端 `IR_STORE` 直接 `STR r0, [r6, #off]`，**只写 4 字节**，且汇编器 pass1/2 对 `STR` 一律 2 字节 T1 编码。
- 后果：`long long`、`double`、`struct`(>4B) 的局部变量赋值只写低 32 位，高 32 位是垃圾。HAL 里 `HAL_RCC_ClockConfig` 返回的 `HAL_StatusTypeDef` 是 enum（4B，没事），但任何用 `uint64_t`/`double` 局部、或结构体按值局部赋值的代码都会错。ark_test 主流程虽以 int 为主，但 HAL 内部（尤其涉及 SysTick 计数、PLL 配置计算）一旦涉及 64 位或结构体赋值就崩。
- 修复方向：ARM 后端 `IR_STORE` 必须按 aux 分发：1→STRB、2→STRH、4→STR、8→STR+STR（低/高字）、16→两次 8 字节或 memcpy。同理 `IR_PUSH_VAR` 的加载也要按宽度（见 F5）。

### F5. `IR_PUSH_VAR` 不区分类型宽度，char/short/long long 都按 4 字节 LDR 加载
- 文件：`src/backend/arm/backend_arm.c` `IR_PUSH_VAR`（L533–L538）
- 现象：`LDR r0, [r6, #off]` 固定 4 字节加载，没有符号/零扩展，也没有 8 字节加载。
- 后果：`char`/`short` 局部变量读出来高位是垃圾（没 LDRSB/LDRSH）；`long long`/`double` 局部只读了低字。HAL 里 `uint8_t`/`uint16_t` 局部（如 `HAL_GPIO_Init` 的 `position`、`ioposition`）参与运算/判断时会偶发错值。
- 修复方向：`IR_PUSH_VAR` 需要带类型宽度（irgen 应在 aux 传 elem_sz + signedness），后端按宽度选 LDRB/LDRSB/LDRH/LDRSH/LDR/LDR+LDR(64位)。

---

## 二、严重级问题（特定场景触发，HAL 工程大概率命中）

### S1. 没有真正的链接器，`-c`/`-link` 只对 C 后端文本拼接有意义
- 文件：`src/compiler.c` L101–L146（`-link` 模式）、L410–L436（`-c` 模式只对 C 后端）、`backend_arm.c` `arm_link`（L2854 空函数）
- 现象：`-c` 产物 `.ark_obj` = `ARKOBJ\n` + 生成的 C 源码文本（仅 C 后端有意义）；ARM 后端 `-c` 产出的 `.ark_obj` 是汇编文本而非二进制对象。`-link` 仅拼接文本。
- 后果：无法像 MDK 那样分文件编译再链接。用户被迫 unity build。一旦工程文件多到单文件放不下（STM32 Flash/SRAM 限制、arkcc 自身 ARK_SRC_BUF_SIZE 限制）就崩。这对“用自举编译器编译 STM32 MDK 工程”目标是**架构性阻塞**。
- 修复方向：定义真正的对象文件格式（符号表 + 重定位记录 + .text/.data/.bss 段），实现链接器（符号解析 + 段合并 + 重定位 patch）。这是大工程，但绕不开。

### S2. 函数返回值/参数 struct 按值传递在 ARM 后端无 AAPCS sret 支持
- 文件：`src/backend/arm/backend_arm.c`（IR_GETARG L497、IR_CALL L1011、IR_RETURN L1238 均无 sret 隐藏指针处理）；对比 `src/irgen.c` L629/L996/L2009（struct>8B 走“地址”语义）、`backend_c.c` L1729/L1888（C 后端用 `frame+8176` 缓冲区）
- 现象：irgen 对 >8 字节 struct 用“传地址”语义，但 ARM 后端的 `IR_GETARG`/`IR_CALL`/`IR_RETURN` 完全不处理 sret 隐藏首参指针，也没 `frame+8176` 等价机制。
- 后果：任何返回/接收 >8B struct 的函数在 ARM 固件里**返回值丢失/栈错位**。HAL 里 `HAL_RCC_GetClockConfig`、`HAL_GPIO_ReadPin`(返回 GPIO_PinState=enum,4B,没事)等多数返回小类型，但部分 `HAL_TIM_*`、`HAL_ADC_*` 配置结构体按值传递会错。
- 修复方向：ARM 后端按 AAPCS 实现 sret：返回 >8B struct 时，调用者分配空间，把地址放 r0（作为隐藏首参），被调者把返回值写到该地址，返回 r0=该地址。irgen 的 aux 高位已带 size，后端要消费。

### S3. 汇编器 pass1 对若干指令大小判定与 pass2 不一致或漏判
- 文件：`src/backend/arm/backend_arm.c` `op_size_a`（L1756）与 `pass2_a`
- 已确认的不一致/缺失：
  - `MOV r0, #imm>255`：irgen 的 `emit_mov_imm` 会发 `MOVW(+MOVT)`(4/8字节)，但汇编器 pass1 对 `MOV` 走 default `return 2`。**不过 irgen 直接发的是 `MOVW`/`MOVT` 文本（见 L35–L46），不是 `MOV #大立即数`，所以这条目前不触发**——但一旦有人手写 `MOV r0,#0x12345` 就会错。
  - `LDR r0, =label`：pass1 正确按 8 字节（L1911），pass2 正确发 MOVW+MOVT（L2503–L2523）。OK。
  - 条件 MOV（`MOVEQ`/`MOVLT`...）：pass1 走 default 2 字节，pass2 也是 2 字节。一致，但见 S4。
  - `STRH`/`LDRH`/`LDRSH`/`LDRSB`：pass1 走 default 2 字节（L1959 `pc += op_size_a(first)`，这些不在 op_size_a 特判表，return 2），pass2 也是 2 字节 T1。一致。但 T1 半字加载/存储的 imm5 只支持 0–62 字节偏移，大偏移同样截断（同 F1）。
  - `CMP r0, #大立即数`：pass1 default 2 字节，pass2 `0x2800 | (imm & 0xFF)` 只取低 8 位。立即数超 255 静默截断。
  - `ADD/SUB rd, rn, #imm` 三寄存器形式：pass1（L1940）对 `ADD r0,r1,r2`(寄存器变体) 判 `pc += 2`，但若 rd/rn 是高寄存器(r8+)或 imm 较大，pass2 会发 32 位 T2/T3（L2318/L2354 `out16;out16`），**pass1 算 2 字节而 pass2 发 4 字节**，导致后续所有标签地址算错。这是又一条 pass1/2 失配。
- 后果：任何触发 pass1/2 size 失配的指令都会让整个函数的标签地址偏移，分支跳错地方。F1 的 LDR/STR 截断 + S3 的高寄存器 ADD/SUB 失配，足以让 HAL 任何一个中等大小函数崩。
- 修复方向：pass1 必须和 pass2 用**完全相同的判定逻辑**判定每条指令的大小。建议重构：把“计算指令大小”抽成单一函数，pass1/2 共用。所有立即数/偏移超 T1 范围的都要升到 T2/T3 32 位编码。

### S4. IT 块内使用 MOVS（0x2000）改写标志位，ARMv7-M 下 UNPREDICTABLE
- 文件：`src/backend/arm/backend_arm.c` L138–L165（emit_binary 发 `ITE EQ; MOVEQ r0,#1`）、汇编器 L2261–L2275（条件 MOV 编码成 `0x2000 | ...` = MOVS）
- 现象：`MOVEQ r0, #1` 被编码成 `MOVS r0, #1`（0x2001），在 IT 块内执行。ARMv7-M 规范：IT 块内若指令带 S 后缀且修改条件标志，行为 UNPREDICTABLE（Cortex-M3/M4 实现上通常会忽略条件，直接执行，等于破坏 IT 语义）。
- 后果：比较结果 `a < b` 之类的条件表达式可能得到错误 0/1。HAL 大量分支判断受影响。
- 修复方向：IT 块内的条件 MOV 应编码为不带 S 的 32 位 `MOV.W<c> Rd, #imm`（T2），或干脆不用 IT 块，改用 `CMP; BX/条件转移` 模式。

### S5. 全局变量初始化（.data 段）完全不生成
- 文件：`src/backend/arm/backend_arm.c` L1325–L1331（注释明说“No .data/.bss storage is emitted”）、`if (0 && ...)` 把整个全局数据发射段死代码化
- 现象：后端不给全局变量生成 .data/.rodata 存储，只把地址分配在 SRAM；非零初值全局变量在 SRAM 里是 0（或被 startup 清零）。
- 后果：HAL 的 `AHBPrescTable[]`、`APBPrescTable[]`、`uwTickFreq`、`SystemCoreClock` 等带初值全局变量初值丢失。`ark_test_pp.c` 试图在 Reset_Handler 里手动赋几个，但：
  1. 赋值用的是**硬编码绝对地址**（`0x20000000`/`0x20000024`），只要前面多一个全局变量就错位；
  2. 只覆盖了 3 个变量，HAL 里其它带初值全局（如 `__HAL_RCC_*` 相关的回调表、HAL 各模块的 `__HAL_*_STATE`）全丢。
- 修复方向：后端必须为带初值全局生成 `.data` 段（初值进 Flash）+ `.bss` 段（零占位），并让 startup 执行 `.data` copy（`_sidata → _sdata.._edata`）和 `.bss` 清零（`_sbss.._ebss`）。这是标准 MDK startup 做的事，arkcc 必须产出配套的符号。

### S6. `IR_ALLOCA`(VLA) 实现错误：先 push 占位再 pop，返回的地址是占位槽而非分配区
- 文件：`src/backend/arm/backend_arm.c` L1241–L1253
- 现象：
  ```
  POP {r0}        ; r0 = 字节数
  ADD r0, r0, #7; BIC r0, r0, #7   ; 8 对齐
  SUB sp, sp, r0  ; 分配
  PUSH {r0}       ; 占位（错误：压的是字节数，不是地址）
  MOV r0, sp
  ADD sp, sp, #4  ; 撤销占位
  PUSH {r0}       ; 压地址
  ```
  中间的 `PUSH {r0}`/`ADD sp,#4` 多此一举且压错值；虽然最后用 `MOV r0, sp` 取地址，但占位逻辑让 sp 短暂抬高 4 字节再降回，分配的地址和后续 sp 关系混乱。
- 后果：VLA 局部（`int a[n]`）访问越界或与其它局部重叠。HAL 基本不用 VLA，影响小，但自举 arkcc 自身（如果用到 VLA）会崩。
- 修复方向：直接 `SUB sp, sp, r0(对齐后)`；`MOV r0, sp`；`PUSH {r0}`。删掉占位 4 字节。

---

## 三、自举与 STM32 自托管阻塞点

### B1. x86_64 后端是占位实现，无法自举
- 文件：`src/backend/x86_64/backend_x86_64.c`
- 致命缺陷：
  1. `x86_assemble`（L309）：把汇编**文本原样当字节**拷进输出，根本不汇编。`-c` 产物是文本而非机器码。
  2. `x86_link`（L317）：`return 0` 空函数。
  3. 缺失 IR：`IR_ALLOCA`、`IR_MEMCPY`、`IR_64PUSH`、`IR_64BINARY`、`IR_64CMP`、`IR_FADD/FSUB/FMUL/FDIV/F2I/I2F/FCMP`、`IR_STORE_FLD/LOAD_FLD`、`IR_SIMD_*`、`IR_SVC/SMC` 全部落到 `default: # unknown`。
  4. 全局变量固定 `.quad <init_int>`（L90），无法表达数组/struct/字符串初始化。
  5. `IR_CALL` 只支持前 6 个寄存器参数，栈参数完全没处理（L274–L287），varargs 也没设 al。
  6. 无 sret、无浮点、无结构体按值传递/返回。
  7. `IR_LOAD_IDX`/`IR_STORE_IDX` 对 es>1 用 `DWORD PTR` + `movsx eax`，但 64 位值、8 字节结构体全错。
- 结论：**x86_64 后端当前不可能自举**。README 宣称的“x86_64 输出 GAS 汇编”仅对最简单例子成立。

### B2. 当前“自举”实质是 C 后端 + gcc，不是真自举
- 证据：`bootstrap/bootstrap_build.ps1` 用 `arkcc -target c` 把 arkcc 源码翻成 `.gen.c`，再用 `gcc` 编译链接；`bootstrap/` 下大量 `.gen.o`、`arkcc_bootstrap*.exe` 都是这条路径产物。`bt2_compiler.stderr/.stdout` 为空。
- 含义：所谓自举是“arkcc → C 源码 → gcc → 可执行”，**依赖 gcc 做真正的代码生成和链接**。一旦要求“用自举的编译器（不靠 gcc）编译”，当前路径立刻断。
- 真正 x64 自举的前提：x86_64 后端必须从占位级补到至少能编译 arkcc 自身的水平（补全上述 IR、实现真正的两遍汇编器、实现链接器或直接生成可执行）。

### B3. STM32 自托管（在 STM32 上跑 arkcc 编译 .c）的路径与风险
- 现状：`Makefile` 的 `stm32` 目标用 `arm-none-eabi-gcc` 交叉编译 arkcc（C 后端 + port/stm32），arkcc 在 STM32 上用 C 后端生成 C 源码，但 STM32 上没有 gcc，**生成物无法在 STM32 上进一步变成可执行程序**。
- 缺口：要在 STM32 上“就地编译执行”，ARM 后端必须能产出可运行的 .bin（即修完第一/二节所有问题），且 arkcc 自身要在 STM32 上不依赖 host libc（已有 stdlib 子集，但 C 后端生成的代码依赖 host libc 头文件，`backend_c.c` 顶部 `#include <stdio.h>...` 一大堆，STM32 上这些头没有）。
- 结论：STM32 自托管当前是“能跑 arkcc 进程，但跑不出可执行结果”。修完 ARM 后端 + 替换 C 后端的 host 依赖后才有意义。

---

## 四、修复优先级建议

| 优先级 | 问题 | 理由 |
|---|---|---|
| P0 | F1 LDR/STR 大偏移截断 | HAL 任何中等函数立刻崩，ark_test 跑不起来的头号原因 |
| P0 | F3 全局变量地址冲突 + S5 .data 初始化缺失 | SystemCoreClock/uTickFreq/表初值全丢，SysTick 不起，HAL_Delay 永久阻塞 |
| P0 | F2 volatile 被忽略 | 寄存器访问被优化掉，外设配置无效 |
| P1 | F4/F5 STORE/LOAD 不分宽度 | 8字节/小整数局部错值 |
| P1 | S3 pass1/2 size 失配 | 大函数标签错位、分支乱跳 |
| P1 | S4 IT 块 MOVS unpredictable | 条件表达式偶发错值 |
| P2 | S1 真正链接器 | 多文件工程的前提 |
| P2 | S2 ARM sret | struct 按值返回/传参 |
| P2 | S6 VLA 修复 | 自举/复杂代码才命中 |
| P3 | B1 x86_64 后端补全 | x64 自举的前提 |
| P3 | B3 STM32 自托管 C 后端去 host 依赖 | 自托管可执行的前提 |

---

## 五、验证建议

修复后用以下方式回归：
1. 对比 `ark_test_arkcc.s` 与 MDK 生成的 `.s`，关键函数（`HAL_RCC_OscConfig`、`HAL_GPIO_Init`、`HAL_InitTick`、`HAL_Delay`、`SystemClock_Config`、`main`）逐指令比对偏移/分支目标。
2. 用 `disasm_mdk.py` 反汇编 MDK 产物，和 arkcc 产物做符号地址对比（已有 `ark_test_syms_new.txt`）。
3. 单元测试：构造局部变量偏移 > 124 的函数、volatile 寄存器读写、8 字节局部赋值、struct 按值返回，分别在小 .c 上验证。
4. 自举回归：`bootstrap_build.ps1` 跑通后，用 `arkcc_bootstrap.exe` 再编译 arkcc 自身，diff 生成的 `.gen.c` 与原 `arkcc -target c` 输出一致。

---

审查人：SOLO
日期：2026-07-05
