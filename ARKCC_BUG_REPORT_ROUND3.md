# Ark C 编译器新 Bug 报告（第三轮，基于最新代码）

基于最新 arkcc.exe（2026/7/6 0:40 构建）重新编译 `ark_test_pp.c` 生成 `ark_test_new.s` / `ark_test_new.ark_obj`，并反汇编验证。上一轮报告的问题（LDR/STR 大偏移截断、IT 块 MOVS、pass1/2 失配等）已修复，但以下新问题仍然导致 ark_test 固件无法正常运行。

---

## N1.［致命］volatile 局部变量赋值写 16 字节，覆盖保存的寄存器导致 HardFault

**这是当前 ark_test 跑不起来的头号原因。**

### 根因

`irgen.c` L1880 给 volatile 变量的 `IR_STORE` 的 aux 叠加了 `IR_AUX_VOLATILE`（`#define IR_AUX_VOLATILE 0x10000`，见 `include/ir.h` L14）：

```c
// irgen.c L1869-1882 (AST_ASSIGN -> AST_VAR 分支)
int store_aux = 0;
if (s && s->type) {
    switch (s->type->kind) {
        case TYPE_CHAR:  store_aux = 1; break;
        case TYPE_SHORT: store_aux = 2; break;
        case TYPE_INT:
        case TYPE_ENUM:  store_aux = 4; break;
        case TYPE_COMPLEX: store_aux = 16; break;   // ← 16
        default:         store_aux = 0; break;
    }
    if (s->type->is_volatile) store_aux |= IR_AUX_VOLATILE;  // ← 0x10000 叠加
}
ir_emit(g->fn, IR_STORE, s->offset, L->u.name, store_aux);
```

对 `volatile uint32_t tmpreg`，`store_aux = 4 | 0x10000 = 0x10004`。

ARM 后端 `IR_STORE`（`backend_arm.c` L812-845）用 `int sw = I->aux;` 直接取 aux 判断宽度，**没有 mask 掉 `IR_AUX_VOLATILE` 位**：

```c
// backend_arm.c L816
int sw = I->aux;            // sw = 0x10004
if (sw == 0) sw = 4;
if (sw == 1) { ... STRB ... }
else if (sw == 2) { ... STRH ... }
else if (sw >= 8) {          // 0x10004 >= 8 → true!
    POP {r1}; POP {r0};
    STR r0, [r6, #off];      // 写 off+0
    STR r1, [r6, #off+4];    // 写 off+4
    if (sw >= 16) {           // 0x10004 >= 16 → true!
        POP {r1}; POP {r0};
        STR r0, [r6, #off+8]; // 写 off+8  ← 越界！
        STR r1, [r6, #off+12];// 写 off+12 ← 越界！
    }
}
```

`alloc_local` 对 `uint32_t` 只分配 8 字节（`(4+7)&~7 = 8`），但 volatile uint32_t 赋值写了 **16 字节**（4 个 STR），后 8 字节覆盖栈帧中保存的 r5/r6/r7/lr。函数返回时 `POP {r5,r6,r7,pc}` 从被覆盖的位置弹出，PC 错误 → HardFault 或跳到垃圾地址。

### 复现

最小复现代码（`test_stack.c`）：
```c
volatile unsigned int *reg;
void test(void) {
    do {
        volatile unsigned int tmpreg = 0;
        *reg |= 0x10000000;
        tmpreg = *reg & 0x10000000;  // ← 这行触发 16 字节写入
        (void)tmpreg;
    } while(0);
}
```

生成汇编（`SUB sp,#8` 但写 `[r6,#0/4/8/12]`，16 字节越界）：
```asm
test:
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #8        ; ← 只分配 8 字节
    MOV r6, sp
    ...
    STR r0, [r6, #0]      ; off+0  ✓
    STR r1, [r6, #4]      ; off+4  ✓
    POP {r1}
    POP {r0}
    STR r0, [r6, #8]      ; off+8  ← 越界！覆盖保存的 r5
    STR r1, [r6, #12]     ; off+12 ← 越界！覆盖保存的 r6
    ...
    POP {r5, r6, r7, pc}  ; ← 从被覆盖的位置弹出，HardFault
```

### 在 ark_test 中的影响

HAL 代码中 `__HAL_RCC_*_ENABLE()` 等宏展开为 `do { volatile uint32_t tmpreg = ...; ...; tmpreg = ...; (void)tmpreg; } while(0)`。`SystemClock_Config`（L35738-35739）开头就有两个这样的宏调用，每个都触发 16 字节越界写。`SystemClock_Config` 返回时直接 HardFault，程序永远到不了 `MX_GPIO_Init` 和 `while(1)` 主循环。

### 修复方向

`backend_arm.c` 的 `IR_STORE` 取宽度时必须 mask 掉 `IR_AUX_VOLATILE`：

```c
int sw = I->aux & 0xFF;   // 只取低 8 位宽度，屏蔽 0x10000 volatile 标志
// 或者：
int sw = I->aux & ~IR_AUX_VOLATILE;
```

同理检查 `IR_PUSH_VAR`（L713 `int width = I->aux & 0xFF`）——这里已经用 `& 0xFF` 取宽度，0x10000 被 mask 掉，**碰巧没坏**，但 volatile 语义（不缓存、不合并访问）仍然未实现。

---

## N2.［严重］Reset_Handler 调用 `__arkcc_init_globals` 后又清零 48KB SRAM，覆盖刚初始化的 .data

### 现象

`ark_test_pp.c` 的 `Reset_Handler`（L27-50）执行顺序：

```c
void Reset_Handler(void) {
    BL __arkcc_init_globals     // ← 1. 初始化 .data（SystemCoreClock=16000000 等）
    unsigned int addr = 0x20000000;
    while (addr < 0x2000C000) { // ← 2. 清零 48KB SRAM，把 .data 也清零了！
        *(volatile unsigned int *)addr = 0;
        addr += 4;
    }
    SystemCoreClock = 16000000; // ← 3. 手动重新赋值
    uwTickFreq = 1;
    AHBPrescTable[0]=0; ...     // ← 4. 手动重新赋值
    ...
    SystemInit();
    main();
}
```

`__arkcc_init_globals` 正确初始化了 .data（生成代码验证：`SystemCoreClock=16000000` 写到 `0x20000000`，`uwTickFreq=1` 写到 `0x20000004`，`AHBPrescTable[16]` 写到 `0x20000008-0x20000017`，`APBPrescTable[8]` 写到 `0x20000018-0x2000001F`）。但紧接着的 48KB 清零循环（`0x20000000..0x2000C000`）把这些初值全部清零。`__arkcc_init_globals` 白跑。

### 影响

虽然后续手动赋值覆盖了 4 个关键全局，但：
1. `__arkcc_init_globals` 的初始化代码浪费 Flash 空间和启动时间。
2. 如果未来增加带初值的全局变量（不手动赋值），初值会丢失。
3. 逻辑上应该是：先清零 BSS → 再调 `__arkcc_init_globals` 初始化 .data（`__arkcc_init_globals` 本身已有 BSS 清零逻辑，可以完全替代手写清零循环）。

### 修复方向

`ark_test_pp.c` 的 `Reset_Handler` 应改为：
```c
void Reset_Handler(void) {
    __arkcc_init_globals();  // 内部已做 .data 初始化 + .bss 清零
    SystemInit();
    main();
    while (1) {}
}
```
删除手写的 48KB 清零循环和手动赋值。或者调整顺序：先清零 → 再 `__arkcc_init_globals`。

---

## N3.［严重］向量表偏移与实际 ark_obj 不同步，中断跳到错误地址

### 现象

`build_ark_test_fw.ps1`（L9-21）硬编码了 handler 偏移：
```powershell
$off = @{
    SysTick    = 0xE74A   # ← 旧值
    ...
}
```

但当前 arkcc 编译的实际偏移：
```
SysTick_Handler    0xEE86   # ← 实际值，差 0x73C 字节
Default_Handler    0x047E   # ← 实际值（旧值 0x0476，差 8 字节）
```

### 影响

向量表中 SysTick entry 指向 `0x08000000 + 392 + 0xE74A + 1 = 0x0800E97B`，但实际 `SysTick_Handler` 在 `0x08000000 + 392 + 0xEE86 + 1 = 0x0800F27F`。SysTick 中断触发时跳到错误地址 → HardFault。`HAL_Delay` 永远等不到 tick，程序卡死。

所有系统异常 handler（NMI/HardFault/BusFault/SVC/PendSV/SysTick）的偏移都可能不同步。

### 修复方向

`build_ark_test_fw.ps1` 不应硬编码偏移。应该：
1. 编译后用 `ARKCC_DUMP_SYMS=1` 重新生成符号表。
2. 从符号表动态读取 handler 偏移构造向量表。
3. 或让 arkcc 在 ark_obj 头部自带向量表（自动生成），省去外部脚本拼接。

---

## N4.［中等］`opt_inline` 在 -O0 下仍然执行，可能改变代码行为

### 现象

`arkcc.cfg` 设置 `opt_level = 0`，但 `ARKCC_FEATURE_OPT_INLINE` 在 host 编译时默认为 1（`arkcc_config.h` L136）。`opt_run`（`opt.c` L172）的 inline pass 检查 `g_config.enable_opt_inline || level >= 2`——只要 `enable_opt_inline` 为真就跑，不看 `opt_level`。

实际生成代码中 `HAL_GetTick` 被 inline 到 `HAL_Delay` 里（`HAL_Delay` 直接 `LDR r0, [uwTick]` 而非 `BL HAL_GetTick`），说明 inline 确实在 -O0 下执行了。

### 影响

- inline pass 对 ARM 后端可能不安全（上一轮报告 #13：`IR_GETARG` 转 `PUSH_VAR(temp_off_j)` 假设参数在栈槽，但 ARM 参数在 r0-r3）。
- 对 ark_test 当前未触发崩溃（HAL_GetTick 无参数，inline 正确），但任何带参数的函数被 inline 后可能读错参数。
- 改变了用户对 -O0 "不优化" 的预期。

### 修复方向

`opt_run` 的 inline 分支应额外检查 `level >= 2`，不单独依赖 `enable_opt_inline`：
```c
if (level >= 2 && g_config.enable_opt_inline) { opt_inline(prog); }
```
或将 host 默认 `ARKCC_FEATURE_OPT_INLINE` 改为 0，只在 `-O2` 时命令行开启。

---

## N5.［中等］`IR_PUSH_VAR` 的 volatile 标志位被 `& 0xFF` 静默丢弃，volatile 读取无任何特殊处理

### 现象

`irgen.c` L1883-1884 给 `IR_PUSH_VAR` 的 aux 叠加 `IR_AUX_VOLATILE`（0x10000）：
```c
ir_emit(g->fn, IR_PUSH_VAR, s->offset, L->u.name,
        (s && s->type && s->type->is_volatile) ? IR_AUX_VOLATILE : 0);
```

ARM 后端 `IR_PUSH_VAR`（L713）`int width = I->aux & 0xFF`——0x10000 & 0xFF = 0，volatile 标志被丢弃。Volatile 变量读取和普通变量读取完全一样（`LDR r0, [r6, #off]`）。

### 影响

- `-O0` 下无合并访问优化，影响小。
- `-O1` 常量折叠不碰 `PUSH_VAR`，影响小。
- 但 `-O2` inline + 未来优化 pass 可能合并/消除 volatile 访问。
- 寄存器读改写操作（`*reg |= val`）在当前栈机模型下是 LDR→ORR→STR 三条独立指令，不会被合并，所以 HAL 的 `__HAL_RCC_*_ENABLE` 等操作目前能正常工作。

### 修复方向

如果要真正支持 volatile 语义：
1. ARM 后端 `IR_PUSH_VAR` / `IR_STORE` 检测 `IR_AUX_VOLATILE`，在读/写后插入 `DMB SY`（或至少不做任何缓存假设）。
2. `opt.c` 的所有 pass 检测 `IR_AUX_VOLATILE`，不消除/合并带此标志的 `PUSH_VAR`/`STORE`。
3. 或者当前阶段至少确保 volatile 标志不污染宽度判断（N1 的修复已覆盖此点）。

---

## 验证优先级

| 优先级 | 问题 | 验证方法 |
|---|---|---|
| P0 | N1 volatile 写 16 字节越界 | 修复后 `test_stack.c` 应只写 4 字节 `[r6,#0]`，不写 `[r6,#8/12]` |
| P0 | N3 向量表偏移不同步 | 修复后用最新 ark_obj 重新生成 syms，向量表 SysTick entry 指向实际 `SysTick_Handler` |
| P1 | N2 Reset_Handler 顺序 | 修复后 `__arkcc_init_globals` 的 .data 初始化不被清零覆盖 |
| P2 | N4 opt_inline -O0 | 修复后 -O0 下 `HAL_Delay` 应 `BL HAL_GetTick` 而非内联 |
| P2 | N5 volatile 读取无特殊处理 | 低优先级，-O0 下无影响 |

---

审查人：SOLO
日期：2026-07-06
