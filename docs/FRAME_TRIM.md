# `-fopt-frame`：裁掉没人用的被调用者保存槽

[English](FRAME_TRIM.en.md) | 中文

> 一句话：`-fopt-frame` 在**已发射的文本**上删掉「压了但函数体从不使用」的被调用者保存寄存器
> 槽，帧因此变小时再把 `SUB sp` / `ADD sp` 一起删掉。HAL 全语料上少 **29 条指令（−0.24%）、
> 84 字节**，`bigger TU 0`（没有一个翻译单元变大）。
>
> **它省的主要是栈，不是代码。** 详见 §3 —— 这一条必须写清楚，否则会重犯「预估比实测大十倍」的错。
>
> **判决：按预注册的否证线（总下降 < 0.5% 即收档），代码体积收益收档；栈用量收益记账保留。**
> 旗标默认关闭，STM32_MIN 构建里裁掉（按名拒绝 `C3900U`）。

---

## 1 为什么做这个

HAL 的每个 `HAL_xxx_Init` 都长一个样：进函数 `PUSH {r4-r7, lr}`，出函数 `POP {r4-r7, pc}`。
但很多函数体里只用 `r4`（或者一个都不用），剩下的槽纯粹是**函数序言抄下来的习惯**。

先做纯离线统计（`pushscan.py`，216 个函数、913 个 `PUSH` 槽）：

| 量 | 读数 |
|---|---|
| `PUSH` 槽总数 | 913 |
| 函数体从不读写的槽 | **289（31.7%）** |
| 折合栈字节 | **1,156 B** |

再按「删槽 → 帧变小 → 删 `SUB`/`ADD`」的完整模型模拟（`framesim2.py`），预测
**132 个函数 / 285 条 / 1,328 B**。

## 2 实现

pass 放在 `ark_fix_far_offset()` 之前、`-fopt-addr` 第二轮之后，直接在 `codegen_arm()` 的
已发射文本上做（`src/backend/arm/backend_arm.c`，`ARKCC_FEATURE_OPT_FRAME`）：

1. `fr_trim()` 逐函数定位 `PUSH {..}` 与配对的 `POP {..}`；
2. 扫函数体，把「以 `[rN` 形式被读或写」的寄存器记入 `fr_names` 使用集；
3. `PUSH`/`POP` 名单里**不在使用集**、且是 callee-saved（`r4`–`r11`）的槽删掉；`lr`/`pc` 永不动；
4. 删完若 `PUSH` 只剩 `{lr}`、`POP` 只剩 `{pc}`，则把配对的 `SUB sp, #N` / `ADD sp, #N` 也删掉
   （这一步才减指令）；
5. **一个保守 bail**：函数体里出现 `sp` 字样（内联汇编、可变长数组、`alloca`）就整函数放弃；
   `base_used` 与帧大小对不上也放弃。

只删不插 ⇒ 正确性论证不需要活跃性分析，只需要「删掉的槽语义上没人用」。

## 3 实测：代码只保证不亏，收益在栈

四臂 = 基线 / 只开本 pass / 只开 `-fopt-voldmb` / 两个都开，95 个 TU：

| 臂 | insns | bytes |
|---|---|---|
| base | 12,304 | 32,690 |
| `-fopt-frame` | **12,275（−29，−0.24%）** | **32,606（−84）** |
| `-fopt-voldmb` | 12,134（−170） | 32,074（−616） |
| both | 12,105（−199） | **31,990（−700）** |

`-fopt-frame` 单独：`smaller TU 10 / bigger TU 0 / identical 85`。

**为什么只有 29 条、不是预测的 285 条**（调试统计 `frdbg_all.py` 的读数）：

```
{'tipped_with_drop': 126,   # 帧确实变小了的函数
 'frame_only': 0,           # 只改 PUSH/POP、没删 SUB/ADD 的函数
 'drop0_baseused_bail': 25} # 因 base_used 对不上而放弃的
```

126 个函数都「帧变小了」，但其中**没有一个**同时满足「删完 `SUB`/`ADD` 也不破坏 `base_used`
对齐」之外还能省指令——因为 16-bit Thumb 下 `PUSH {r4-r7, lr}` 与 `PUSH {r7, lr}` **都是 2 字节**。
删槽只改编码位、不改长度。只有「帧整个变空 ⇒ `SUB sp`/`ADD sp` 一起消失」才真的少一条指令，
而这种函数在 HAL 里只有 29 个。

⇒ **本 pass 的价值是栈用量**：1,156 B 的栈在 MCU 上是实打实的（4 KB 栈预算），
代码体积只是「不亏」。任何把它当成 2% 体积优化的读法都是错的。

## 4 门禁

- 95 TU 编译 0 err；
- 四臂 `bigger TU 0`；both 臂 `smaller TU 16 / identical 79`；
- **OFF IS OFF**：默认构建与改前二进制的产物逐字节相同（`.s` 与 `.o` 全量 `diff -rq` 无差异）；
- `tests/arm_exec` 基线 0 failure；`--extra=-fopt-frame --extra=-fopt-voldmb` 亦 0 failure；
- 裁剪构建（`ARKCC_FEATURE_OPT_FRAME=0`）按名拒绝 `-fopt-frame`，报 `C3900U`；不带旗标照常编译。

## 5 未做 / 已知限制

- 未做「跨 `BL` 的槽复用」（需要活跃性 + 调用点分析，收益同样只落在栈上）；
- Linux 宿主未实跑（本机无交叉工具链），只做了 MinGW 宿主 + `--layout both` 构建级检查；
- STM32H743 仅 `--layout both` 构建通过，未上板。

## 6 修订（2026-11-24）：多 return 收尾与 base 偏移补偿

23 开关口径下 `-fopt-frame` 自己造了两类误编译，都是「删了 PUSH 槽但只在一条
返回路径上补齐」的变体。

### 6.1 多 return：只收窄第一个 epilogue

旧实现只找**第一个** `POP {..}` 做收窄，函数里其它返回路径仍是原来的宽 `POP`。
于是同一个函数里 `PUSH {r4-r7, lr}` 被改成 `PUSH {r7, lr}`，而另一条 epilogue 还
`POP {r4-r7, pc}`——退出时多弹 4 个字，SP 被拉偏，模拟器报 `UC_ERR_EXCEPTION`。

修法：步 2 收集**全部** `POP {..}`，步 3b 按每个 `return` 路径标记 sp 恢复行
（`MOV sp, r6` / `ADD sp, #N`），步 4 扫全函数，步 7 逐条 rebuild；
`FR_MAX_EPI = 64` 条上限，超出整函数弃权。收窄名单取所有 epilogue 的**子集**
（只在每条返回路径都不用的槽才删）。

### 6.2 base_used：删掉的字必须补成 padding

帧基址模式下序言是 `PUSH {..}` + `SUB sp, sp, #N` + `MOV r6, sp`，入栈实参在
`[r6, #(4*np + oldN) + k]`。删掉 `d` 个 PUSH 槽后 `SUB` 的立即数也减 `4d`，
**基址整体下移 `4d`**，而入栈实参的地址是调用者按 ABI 摆好的、不会跟着动 ⇒
每个栈参数读偏 `4d` 字节。实测 `five(1,2,3,4,9)` 读成 `11`（第 5 个参数是栈参数）。

修法：`base_used` 时保持总帧长不变 —— `newN = oldN + 4 * dropped`（删掉的槽位改成
padding，`SUB` 仍是原来的立即数）。若原帧长本来就不是 8 的倍数（无法在保持对齐的
前提下补偿），整函数弃权。

**为什么不直接 bail**：bail 会失去所有「带局部变量或栈参数」函数的帧优化，
而那正是收益集中的地方。补偿后总帧长不变、对齐自动成立，`PUSH`/`POP` 缩短编码的
收益仍然保留（16-bit Thumb 下 `PUSH {r4-r7,lr}` 与 `PUSH {r7,lr}` 同长，真正的
收益是栈 —— 见 §3）。

### 6.3 门禁

`abi_stack_args` 单开关 `-fopt-frame` = 50（修前 1）；`shift64` 五开关 = 50；
23 开关 `tests/arm_exec` 40/40；`make test-frame` 全过；95 TU 编译 0 err。
