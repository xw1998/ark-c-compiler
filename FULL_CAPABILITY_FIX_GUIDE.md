# 完整能力修复指导（供其他 AI 使用）

> 日期：2026-07-11
> 编码：UTF-8（无 BOM）
> 目标：修复 5 项能力中不达标的 4 项，实现"x86 自举 + armcc5 完全兼容 + STM32 运行 + MDK 集成"

---

## 0 当前能力状态

| 能力 | 状态 | 阻塞原因 |
| --- | --- | --- |
| 1. x86 32位自举 | ❌ | assemble/link 是 stub，从未验证 |
| 2. armcc5 完全兼容编译MDK工程 | ⚠️ 部分修复 | F1-F5 致命bug大部分已修，但未端到端验证 |
| 3. 模块化config裁剪 | ✅ 达标 | 无需修改 |
| 4. STM32上运行 | ⚠️ 部分 | 固件能生成，但初始化是占位代码 |
| 5. MDK项目集成 | ❌ | .uvprojx 缺文件/缺宏/版本错 |

---

## 1 修复任务清单（按依赖顺序）

### 阶段 A：ARM 后端代码生成验证（最高优先）

F1-F5 致命 bug 大部分已修复（ROUND4 报告确认），但需要端到端验证。

#### A1. 验证 ark_test 工程编译产物能运行

**现状**：
- `examples/ark_test/` 有完整 STM32F4 HAL 工程
- `build_ark_test_fw.ps1` 脚本存在
- ROUND4 报告说"从编译器代码生成角度，当前 ark_test 固件应该能正常运行"
- 但无实际硬件验证证据

**任务**：
1. 运行 `build_ark_test_fw.ps1` 生成 ark_test 固件
2. 检查固件大小是否合理
3. 如果有硬件，烧录验证 LED 闪烁
4. 如果无硬件，用 QEMU 模拟验证

**验证命令**：
```powershell
# 编译 ark_test
.\arkcc.exe examples\ark_test\ark_test_pp.c -target arm -mcpu=Cortex-M4 -c -o ark_test.ark_obj

# 生成固件
powershell -ExecutionPolicy Bypass -File examples\ark_test\build_ark_test_fw.ps1

# 检查输出
Get-ChildItem examples\ark_test\*.bin, examples\ark_test\*.hex
```

**如果仍不能运行**，检查 ROUND4 中的 P1（AAPCS 8字节对齐）：
- 文件：`src/backend/arm/backend_arm.c` IR_CALL（约 L1283-1288）
- 修复：奇数个栈参数时先 `SUB sp, #4` 对齐，调用后 `ADD sp, #4`

---

### 阶段 B：MDK 工程文件修复

#### B1. 修复 .uvprojx 工程文件

**现状问题**：
1. 缺少 4 个核心源文件：cpu.c / config.c / opt.c / scatter.c
2. 编译器版本设为 ARMCLANG V6.16（应为 armcc V5.06）
3. 未定义 `ARKCC_PROFILE=ARKCC_PROFILE_STM32_MIN` 宏
4. Drivers/HAL 组为空

**任务**：
1. 在 `mdk/STM32H743_ArkCC/ArkCC.uvprojx` 的 ArkCC/Core 组中添加 4 个文件：
   - `..\..\src\cpu.c`
   - `..\..\src\config.c`
   - `..\..\src\opt.c`
   - `..\..\src\scatter.c`

2. 修改编译器版本（第 10 行）：
   ```xml
   <!-- 改前 -->
   <pCCUsed>6160000::V6.16::ARMCLANG</pCCUsed>
   <!-- 改后 -->
   <pCCUsed>5060000::V5.06::ARMCC</pCCUsed>
   ```

3. 在宏定义中添加 ARKCC_PROFILE（搜索 `<Define>` 行）：
   ```xml
   <!-- 改前 -->
   <Define>USE_HAL_DRIVER,STM32H743xx,ARK_TARGET_STM32H7</Define>
   <!-- 改后 -->
   <Define>USE_HAL_DRIVER,STM32H743xx,ARK_TARGET_STM32H7,ARKCC_PROFILE=ARKCC_PROFILE_STM32_MIN</Define>
   ```

4. 在 C/C++ 选项中设置 C99 模式（搜索 `<uC99>` 行确保为 1）

**验证**：
在 Keil µVision 中打开 `ArkCC.uvprojx`，Build Target（F7），应成功生成 `.hex`

---

### 阶段 C：STM32 初始化代码完善

#### C1. 填写 SystemClock_Config 占位代码

**现状**：`mdk/STM32H743_ArkCC/User/main.c` 中 4 个初始化函数都是 `#warning` 占位：
- `SystemClock_Config`（第 268 行）
- `MX_GPIO_Init`（第 289 行）
- `MX_USART1_UART_Init`（第 297 行）
- `MX_SPI1_Init`（第 310 行）

**任务**：
用寄存器级代码（不依赖 HAL）或从 STM32CubeMX 生成的代码填入。示例 SystemClock_Config（480MHz PLL）：

```c
static void SystemClock_Config(void) {
    /* Enable HSE */
    RCC->CR |= RCC_CR_HSEON;
    while (!(RCC->CR & RCC_CR_HSERDY));
    
    /* Configure PLL1: HSE / 2 * 120 / 1 = 480MHz */
    RCC->PLLCKSELR = RCC_PLLCKSELR_DIVM_2;      /* M=2 */
    RCC->PLLCFGR = RCC_PLLCFGR_PLL1REN |        /* Enable PLL1 R */
                   (120 << RCC_PLLCFGR_PLL1N_Pos) |  /* N=120 */
                   RCC_PLLCFGR_PLL1VCOSEL_192;   /* VCO 192-836MHz */
    RCC->PLLDIVCFGR1 = (0 << RCC_PLLDIVCFGR1_PLL1Q_Pos) |
                       (0 << RCC_PLLDIVCFGR1_PLL1R_Pos); /* Q=0, R=1(div2) */
    
    /* Enable PLL1 */
    RCC->CR |= RCC_CR_PLL1ON;
    while (!(RCC->CR & RCC_CR_PLL1RDY));
    
    /* Flash latency 4 wait states for 480MHz */
    FLASH->ACR = FLASH_ACR_LATENCY_4WS;
    
    /* Switch system clock to PLL1 */
    RCC->CFGR = RCC_CFGR_SW_PLL1;
    while ((RCC->CFGR & RCC_CFGR_SWS) != RCC_CFGR_SWS_PLL1);
    
    SystemCoreClock = 480000000U;
}
```

同样用寄存器级代码填写 MX_GPIO_Init（PA9/PA10 UART, PA5-PA7 SPI1, PA4 SPI CS）、MX_USART1_UART_Init（115200 8N1）、MX_SPI1_Init。

**或者**：从 STM32CubeMX 生成完整代码粘贴进去，删除 `#warning`。

#### C2. 验证 system_stm32h7xx.c 的 __user_initial_stackheap

确认 `system_stm32h7xx.c` 中的 `__user_initial_stackheap` 实现正确（已在之前修复，确认未被回退）。

---

### 阶段 D：x86 32 位后端自举

#### D1. 实现 x86 assemble 真实功能（或改用外部工具链）

**现状**：`src/backend/x86_64/backend_x86_64.c` 的 `x86_assemble` 是 pass-through stub（第 1336-1351 行），只做内存拷贝不汇编。

**两个方案**：

**方案 A（简单）**：不实现内置汇编器，改用外部 gcc -m32
1. 修改 `x86_assemble`：把汇编文本写入临时文件，调用 `gcc -m32 -c foo.s -o foo.o`，读回 .o
2. 修改 `x86_link`：调用 `gcc -m32 foo.o -o foo.exe` 链接
3. 优点：简单，利用成熟工具链
4. 缺点：依赖外部 gcc，STM32 上不可用

**方案 B（完整）**：实现内置 x86 汇编器
1. 参考 ARM 后端的 `arm_assemble`（两遍汇编 + 重定位）
2. 解析 Intel 语法 x86 指令（mov/push/pop/call/ret/add/sub/cmp/jmp/jcc...）
3. 编码为 x86 机器码
4. 工作量大（约 2000 行），但可自举

**建议先做方案 A**，后续如需 STM32 上 x86 自举再做方案 B。

#### D2. 创建 x86 自举脚本

**任务**：创建 `bootstrap_x86.ps1`，用 x86 后端编译 arkCC 自身源码：

```powershell
# 1. 用 arkcc x86 后端编译每个 .c 文件
foreach ($f in $srcFiles) {
    & .\arkcc.exe $f -target x86 -c -o "$basename.x86.o"
}

# 2. 用 gcc -m32 链接所有 .o
gcc -m32 *.x86.o -o arkcc_bootstrap_x86.exe

# 3. 用 arkcc_bootstrap_x86.exe 再次编译自身（验证自举）
$env:ARKCC_SELF_TEST = "1"
& .\arkcc_bootstrap_x86.exe src\main.c -target x86 -S -o test.s
```

#### D3. 验证 x86 自举

```powershell
# 生成 x86 汇编
.\arkcc.exe examples\hello.c -target x86 -S -o hello.s

# 用 gcc -m32 组装运行
gcc -m32 hello.s -o hello.exe
.\hello.exe
echo $LASTEXITCODE   # 应为 42
```

---

### 阶段 E：armcc5 完全兼容验证

#### E1. 用 arkCC 编译完整 MDK HAL 工程

**任务**：
1. 用 arkCC 编译 `examples/ark_test/` 中的完整 STM32F4 HAL 工程
2. 对比 arkCC 产物与 armcc5 产物的二进制差异
3. 烧录到硬件验证

**验证命令**：
```powershell
# Unity build 编译完整工程
.\arkcc.exe examples\ark_test\ark_test_pp.c -target arm -mcpu=Cortex-M4 -o ark_test.bin

# 如果有 QEMU
qemu-system-arm -M stm32vldiscovery -kernel ark_test.bin

# 如果有硬件
# 用 ST-Link 烧录 ark_test.bin 到 STM32F4 板子
```

#### E2. 补齐剩余 armcc5 兼容缺口

根据 ARKCC_BUG_REPORT_ROUND4.md，仍存在：
- **P1 AAPCS 栈 8 字节对齐**：IR_CALL 奇数栈参数时 SP 4 字节对齐
  - 修复：`backend_arm.c` IR_CALL 发射前检查参数奇偶，奇数时 `SUB sp, #4`
- **P2 void 函数 push 垃圾 r0**：低风险，可暂不修

如果 E1 验证通过，说明 armcc5 兼容性已达标。如果失败，根据错误现象定位。

---

## 2 修复后的端到端验证清单

### 2.1 主机构建
```powershell
make clean; make
# 无 warning，生成 arkcc.exe
```

### 2.2 全量测试
```powershell
powershell -ExecutionPolicy Bypass -File examples\run_tests.ps1
# 70 passed, 0 failed
```

### 2.3 armcc5 STM32 固件
```powershell
powershell -ExecutionPolicy Bypass -File build_stm32_armcc.ps1
# BUILD SUCCESSFUL
# Flash < 200KB, AXI < 460KB
```

### 2.4 x86 自举
```powershell
.\arkcc.exe examples\hello.c -target x86 -S -o hello.s
gcc -m32 hello.s -o hello.exe
.\hello.exe
# exit code = 42
```

### 2.5 ark_test HAL 工程
```powershell
.\arkcc.exe examples\ark_test\ark_test_pp.c -target arm -mcpu=Cortex-M4 -o ark_test.bin
# 生成可烧录固件
```

### 2.6 MDK 工程
在 Keil µVision 中打开 `ArkCC.uvprojx`，Build Target（F7），应成功。

---

## 3 优先级与依赖关系

```
阶段 A（ARM 后端验证）    ← 最高优先，无依赖
  └→ 阶段 E（armcc5 兼容）← 依赖 A 通过

阶段 B（MDK 工程修复）    ← 独立，可与 A 并行
  └→ 阶段 C（初始化代码）  ← 依赖 B

阶段 D（x86 自举）        ← 独立，可与 A/B 并行
```

**建议执行顺序**：A → B → C → D → E

---

## 4 关键文件索引

| 文件 | 作用 | 修改点 |
| --- | --- | --- |
| src/backend/arm/backend_arm.c | ARM 后端 | A1/E2: IR_CALL 对齐修复 |
| src/backend/x86_64/backend_x86_64.c | x86 后端 | D1: 实现 assemble/link |
| mdk/STM32H743_ArkCC/ArkCC.uvprojx | MDK 工程 | B1: 加文件/改版本/加宏 |
| mdk/STM32H743_ArkCC/User/main.c | STM32 入口 | C1: 填初始化代码 |
| mdk/STM32H743_ArkCC/User/system_stm32h7xx.c | 系统初始化 | C2: 确认 stackheap |
| examples/ark_test/build_ark_test_fw.ps1 | HAL 工程构建 | A1: 运行验证 |
| build_stm32_armcc.ps1 | STM32 固件构建 | 确认仍通过 |
| ARKCC_BUG_REPORT.md | 致命 bug 记录 | F1-F5 状态确认 |
| ARKCC_BUG_REPORT_ROUND4.md | 第四轮验证 | P1-P3 修复参考 |

---

## 5 总结

```
必须修（阶段 A + B + C）：
  A1  验证 ark_test 固件能运行（可能需修 IR_CALL 对齐）
  B1  .uvprojx 加 4 文件 + 改版本 + 加宏
  C1  填写 SystemClock/GPIO/UART/SPI 初始化

需要修（阶段 D）：
  D1  x86 assemble 实现或用 gcc -m32 外部工具链
  D2  创建 x86 自举脚本
  D3  验证 x86 自举

验证修（阶段 E）：
  E1  用 arkCC 编译完整 HAL 工程并烧录验证
  E2  修复剩余 AAPCS 对齐问题

已有能力（无需修改）：
  ✅  模块化 config 裁剪（100+ 处 #if 保护）
  ✅  F1-F5 致命 bug 大部分已修复（ROUND4 确认）
  ✅  sb_putf/ark_log/测试脚本等已修复
  ✅  70 个测试全部通过
```
