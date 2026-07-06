# Ark C 编译器第四轮审查报告

基于最新 arkcc.exe（2026/7/6 9:17 构建），用自定义 Thumb-2 反汇编器逐指令验证 ark_obj 二进制，并联网查证 ARMv7-M 编码规范。

## 验证方法

1. 用 `arkcc.exe -target arm -mcpu Cortex-M4 -c ark_test_pp.c -o ark_test.ark_obj` 生成 ARKOBJ2 格式目标文件（含代码+符号表）。
2. 编写 Python Thumb-2 反汇编器（`disasm.py`），解析 ARKOBJ2，反汇编所有函数。
3. 逐指令验证关键函数：Reset_Handler、__arkcc_init_globals、HAL_Init、HAL_InitTick、HAL_Delay、HAL_GetTick、HAL_GPIO_WritePin、SysTick_Config、SystemClock_Config。
4. 联网查证 ARMv7-M BL/B.W/B<cond>.W T3/T4 编码公式（I1=NOT(J1 XOR S), I2=NOT(J2 XOR S)）。

## 验证结论：上一轮问题全部修复确认

| 上轮问题 | 验证结果 |
|---|---|
| N1 volatile 写 16 字节越界 | ✅ `test_stack.c` 只写 `STR r0, [r6, #0]`（4字节），无越界 |
| N2 Reset_Handler 顺序 | ✅ `BL __arkcc_init_globals` 在最前面，无手动清零 48KB |
| N3 向量表偏移 | ✅ `build_ark_test_fw.ps1` 从 ARKOBJ2 动态读取，SysTick=0xE598 匹配 |
| N4 opt_inline -O0 | ✅ `HAL_GetTick` 被 `BL` 调用（地址 0x08001E0C），未内联 |
| N5 volatile 标志污染宽度 | ✅ `IR_PUSH_VAR` 用 `& 0xFF`，`IR_STORE` mask 了 volatile 位 |

## 本轮新发现

### 已验证正确的部分

1. **BL 编码正确**：`BL __arkcc_init_globals`（0x0800018C → 0x0800EDAE），偏移计算 S:I1:I2:imm10:imm11 公式正确。
2. **B.W / B<cond>.W 编码正确**：BSS 清零循环 `BNE.W 0800EF72`（向后分支 -10 字节），21 位符号扩展正确。曾误判为 bug，实际是反汇编器的符号扩展掩码错误（`0xFFC00000` 应为 `0xFFE00000`），修正后确认编译器编码正确。
3. **MOVW/MOVT 编码正确**：`MOVW r0, #0x2400; MOVT r0, #0x00F4` = 0x00F42400 = 16000000（SystemCoreClock）。
4. **IT 块编码正确**：`ITE CC`（0xBF34）用于无符号比较 `wait < 0xFFFFFFFF`，条件码 CC=3(LO) 正确。
5. **条件 MOV.W 编码正确**：`MOV.W r0, #1`（0xF04F 0x0001）在 IT 块内，无 S 位，避免 UNPREDICTABLE。
6. **SDIV/UDIV 编码正确**：`SDIV r0, r0, r1`（0xFB90 0xF0F0）用于 `SystemCoreClock / (1000/uwTickFreq)`。
7. **.data 初始化正确**：`__arkcc_init_globals` 正确初始化 SystemCoreClock=16000000、uwTickFreq=1、AHBPrescTable[16]、APBPrescTable[8]。
8. **.bss 清零正确**：0x20000044(uwTick)..0x20000048 范围正确。
9. **参数传递顺序正确**：irgen 逆序压参（arg[n-1] 先压，arg[0] 后压在栈顶），ARM 后端 `POP {r0}; POP {r1}; ...` 正序弹参，r0=arg0 符合 AAPCS。
10. **栈帧无溢出**：全函数扫描，所有 `STR/LDR [r6, #off]` 的 off 均小于 `SUB sp` 分配量。
11. **BLX ip 已设 Thumb 位**：`ORR ip, ip, #1` 在 `BLX ip` 前（L1389-1390），避免 Cortex-M HardFault。
12. **向量表完整**：98 项（16 系统 + 82 外部），SP=0x20018000，所有 handler 地址含 Thumb 位（+1）。

### 仍存在的问题

#### P1. AAPCS 栈 8 字节对齐不保证（中等风险）

**现象**：`IR_CALL`（`backend_arm.c` L1283-1288）注释自承认"when stack_args is odd, SP is only 4-byte aligned at BL"。AAPCS 要求公开 SP 在 `BL` 时 8 字节对齐。

**影响**：Cortex-M4 硬件容忍 4 字节对齐（不触发 fault），但：
- 如果被调函数使用 `LDRD/STRD`（要求 8 字节对齐），会触发 UsageFault。
- 如果调用编译器库函数（如 `memcpy`），库可能假设 8 字节对齐。
- ark_test 当前不触发（所有调用点参数 ≤4 个，无栈参数），但任何 5+ 参数函数调用可能触发。

**修复方向**：irgen 在压栈参数前，如果栈参数数量为奇数，先 `SUB sp, #4` 填充对齐；调用后 `ADD sp, #4` 清除。或在 ARM 后端 `IR_CALL` 发射前检查 SP 对齐。

#### P2. 函数返回 void 时仍 push 垃圾 r0（低风险）

**现象**：`IR_CALL` 末尾固定 `emit_push_r0`（L1404），即使被调函数返回 void。调用者若不 POP 会累积垃圾。

**影响**：irgen 的 `AST_EXPR_STMT` 会在表达式后发 `IR_POP` 丢弃返回值，所以栈平衡 OK。但浪费一个 PUSH/POP 周期。

#### P3. `__arkcc_init_globals` 返回方式非标准（低风险）

**现象**：`PUSH {lr}` 保存 lr，返回时 `POP {r0}; BX r0`。标准做法是 `POP {pc}`（一步返回）。

**影响**：功能正确，但多一条指令且 `BX r0` 依赖 r0 的 Thumb 位（lr 已含 Thumb 位所以 OK）。

### 结论

**从编译器代码生成角度，当前 ark_test 固件应该能正常运行。** 上一轮报告的 5 个问题全部修复，反汇编验证关键函数（Reset_Handler、__arkcc_init_globals、HAL_Init、HAL_InitTick、HAL_Delay、HAL_GetTick、SysTick_Config、main、SystemClock_Config）的 Thumb-2 编码、参数传递、栈帧布局、分支目标、.data/.bss 初始化均正确。

如果固件仍跑不正常，建议检查：
1. **烧录的 .bin 是否最新**：用最新 arkcc.exe + build_ark_test_fw.ps1 重新生成。
2. **目标芯片匹配**：脚本假设 STM32F401xE（96KB SRAM，SP=0x20018000），若芯片不同需调整。
3. **硬件连接**：LED 在 PC13，需确认硬件电路。
4. **时钟配置**：SystemClock_Config 用 HSI 16MHz（无 PLL），SysTick=16MHz/1000=16000，1ms 中断。若时钟异常，LED 闪烁频率会错。

---

审查人：SOLO
日期：2026-07-06
