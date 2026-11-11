# x86-64 后端（SysV AMD64）

`-target x86_64` 在很长一段时间里只是 `x86` 的别名：`backend_x86_64.c` 里只有一份
i386 cdecl 代码，所以 `long long`、指针、`double` 全被当成 32 位处理。现在它是**真后端**，
和 i386 共用同一个源文件（`src/backend/x86_64/backend_x86_64.c`）但走两条独立的代码
生成路径：

| 后端名 | `pointer_size` | ABI | 汇编器 | 镜像基址 |
| --- | :---: | --- | --- | :---: |
| `x86` | 4 | i386 cdecl（`ARK_ABI_SYSV`） | `x86_assemble` | 0（位置相关，重定位是镜像内偏移） |
| `x86_64` | 8 | SysV AMD64 | `x86_assemble64` | `0x400000`（数据用 RIP 相对，位置无关） |

别名：`x86-64`、`amd64` → `x86_64`；`i386`、`i686` → `x86`。
`ark_backend_x86_64()` 仍返回 i386 后端（历史兼容），新代码用 `ark_backend_amd64()`。

## 1. 代码生成模型

不改 IR、不改前端：**仍然是「4 字节一个 IR word」的模型 + `pointer_size = 8`**。
后端把两件事分开处理——IR 的 word 宽度是编译器的内部约定，物理宽度由 `pointer_size`
和 `wires[]` 上的标记决定。

- 帧：`LSZ = (local_size + 15) & ~15`（至少 16）、`FRAMELO = 48 + LSZ`、`FRAME = (FRAMELO + 512 + 15) & ~15`
- 标量槽：`[rbp-8]` sret 指针、`[rbp-16]` 保存 rsp、`[rbp-24..rbp-48]` scratch
- 实参 temp 第 `k` 槽：`-FRAMELO - 8*(k+1)`，`k = 0..63`
- 序言 `push rbp; mov rbp,rsp; sub rsp,FRAME`，尾声 `mov rsp,rbp; pop rbp; ret`
- 参数分类：整数/指针走 `rdi rsi rdx rcx r8 r9`，`float`/`double` 走 `xmm0-7`，
  两类各自独立计数、超出即入栈（8 字节一槽、右到左），`al` = 本次调用用到的 xmm 个数
- `irgen` 在 `pointer_size == 8` 时给指针与「命名参数里 >8 字节的聚合体」标
  `8 | IR_AUX_SLOT64`，并强制注册 `argbytes` 侧表（见 §3.3）

## 2. 传输约定（内部）

- **返回值**：整数/指针 ≤8 字节放 `rax`；64 位结果**完整 64 位都在 `rax`**（不是
  `rdx:rax` 的高半部分单独有效）；`float`/`double` 在 `xmm0`（`IR_CALL` 的 bit53）。
  两 word 结果由调用点显式 `mov rdx,rax; shr rdx,32` 拆分。
- **sret**：>8 字节复合体由调用方分配、指针放 `rdi`，被调方按 `[rbp-8]` 保存。
  这个接收方向已支持；**发起**方向（把 >8 字节聚合体按值返回）仍在报错清单里。

## 3. 本轮修掉的四个静默错答案

四个缺陷的共同点：**编译退出 0，镜像能跑，答案是错的。**

### 3.1 64 位返回值被截成低 32 位

原来调用点写的是 `mov eax,eax; mov edx,edx; push rax; push rdx`，把 `rdx` 当成高
word。但被调方的 `IR_RETURN` 走 `amd_pop64(rax)`：它把完整 64 位重建进 `rax`，同时
把 `hi << 32` 留在 `rdx`。于是 `(hi<<32) & 0xFFFFFFFF == 0`，高位恒读成 0。

改法是不再依赖 `rdx` 里的残留：

```
    mov rdx, rax
    shr rdx, 32
    mov eax, eax
    push rax
    push rdx
```

### 3.2 `amd_push64`/`amd_pop64` 的暂存寄存器冲突

两个助手内部硬编码 `rdx` 当暂存，遇到 `amd_push64("rdx","edx")`（`IR_LOAD_IDX` 读
8 字节字段就是这样）就自杀：`mov rdx,rdx` 无效、`shr rdx,32` 把值毁掉、最后压上去
的两个 word 都是高位。新增

```c
static const char *amd_scratch_for(const char *r64) {
    return ark_streq(r64, "rdx") ? "rcx" : "rdx";
}
```

两个助手全程用它取暂存，从根上消掉「传 rdx 就自毁」这一类。

### 3.3 指针 / 大型聚合体参数没有注册 `argbytes` 侧表

`wires[i] = 8 | 0x20000` 表示「8 字节但只有 1 个 IR word」。可调用点要靠
`argbytes` 侧表才知道「这个槽是 64 位」，而侧表**只在 `wire_extra` 为真时才注册**。
指针分支和大聚合体分支都忘了置 `wire_extra = 1`，于是调用点退回 `argmask`，用
`mov edi, dword ptr [tmp]` 装了个 32 位地址——地址都落在 32 位以内时看起来还能跑，
但语义已经错了。修法：

```c
    wires[i] = 8 | 0x20000;
    wire_extra = 1;                                  /* TYPE_PTR 分支 */
    ...
    else if (ssz > 8 && pt != 0 && g_irgen_slot64_ptrs) {
        wires[i] = 8 | 0x20000;                      /* 命名参数的大聚合体按指针传 */
        wire_extra = 1;
    }
```

### 3.4 `rep movsb` 只发出了前缀字节

内置汇编器的通用操作数扫描先把 `movsb` 当操作数吃掉，`rep` 分支再读时已到行尾，
于是只发出一个孤立的 `0xF3`（成为下一条指令的无效前缀），`IR_MEMCPY` **什么都不拷**。
反汇编看得最清楚：`mov ecx,0x10` 之后直接是 `add rsp,8`。

修法是回卷到操作数扫描之前重新取助记符、查表（`movsb/movsw/movsd/movsq/stosb/stosd/
stosq/lodsb/scasb/cmpsb`），命中才发 `0xF3`（+ 可选 `0x66`/REX.W）+ 操作码；**未命中
一律 `error_count++` + 报错，绝不发裸前缀**。i386 后端此前同样静默丢拷贝。

## 4. i386 的两处有意行为变化

这两条不是回归，是修 bug。逐字节对比 `d6000a0` 的旧二进制，80 个源里 21 个的 i386
输出不同，**差异全部属于第 ①条**（第 ②条只在带聚合体拷贝的源上出现，那 21 个里没有）。

① **调用前对齐**：原来是先 `push` 参数、再 `and esp,-16`，把刚压下去的参数**压到
`esp` 之下**，被调方 `[ebp+8]` 读到的是垃圾。

```
old:  push dword ptr [ebp-80]
      and esp, -16
      call factorial
new:  mov eax, esp
      sub eax, <参数总字节数>
      and eax, 15
      sub esp, eax
      push dword ptr [ebp-80]
      call factorial
```

② **`rep movsb` 现在真的发出字节**（见 §3.4），所以聚合体拷贝开始生效。

## 5. i386 的已知缺陷（不是本轮引入，门禁里显式 SKIP）

| 现象 | 触发 |
| --- | --- |
| `movq needs an xmm operand` | 浮点路径（`double` 参数/比较） |
| `UC_ERR_EXCEPTION` | 64 位算术（`long long` 乘除、64 位循环） |
| 结果明明是整数却是个大数（如 `7335887`） | >8 字节结构体按值传参 |

这些是 i386 后端的历史欠账。x86-64 门禁把它们**明确打印成 SKIP 并给出实测理由**，
既不判 PASS 也不判 FAIL——否则要么假绿、要么把 x86-64 的正确结果误判成回归。

## 6. 单文件镜像拒绝未解析符号

`resolve_refs_x` 找不到 label 时把 disp32 留成全 0，于是 `call foo` 变成 `call +0`：
镜像自己调自己、原地打转，而 `arkcc` 退出码是 0。裸镜像背后没有链接器来补这一手，
所以 `compiler.c` 在 `arm` 之外补了 `x86` / `x86_64` 的同类检查（走
`x86_get_reloc_count()` / `x86_get_reloc_name()`），有未解析引用就报错并**不写镜像**。
`-c` 保留重定位、`-link` 负责解析，不受影响。

## 7. 门禁

```
make test-x86-64                  # 已挂进 make test
python tests/run_x86_64_image_tests.py --arkcc ./arkcc.exe
```

16 个程序编译成 0x400000 的平铺镜像，在 unicorn 的 64 位核上跑 `main`，逐个断言一个
**在程序之外算出来的常量**（不拿宿主 gcc 当 oracle）：

| 用例 | 覆盖 | 期望 |
| --- | --- | :---: |
| `int_args_9` | 6 寄存器参数 + 3 个栈参数 | 34 |
| `ll_mul` | 64 位结果在 rax、调用点拆字 | 7 |
| `ull_div` | 无符号 64 位除法（高位参与） | 74 |
| `struct_ll_field` | 通过指针读 8 字节字段 | 21 |
| `ptr_walk` | 8 字节指针算术 | 84 |
| `float_mul` | `double` 实参走 xmm、结果在 xmm0 | 23 |
| `float_add` | 单精度路径 | 16 |
| `struct_byval` | 8 字节结构体按值返回 + 24 字节结构体按值传参 | 45 |
| `func_ptr` | 64 位函数指针间接调用 | 42 |
| `fib_switch` | 递归 + 跳转表 | 99 |
| `struct_copy16` | 16 字节聚合体拷贝（`rep movsb` 真发字节） | 11 |
| `ull_loop` | 40 次 64 位乘加 | 187 |
| `signed_div` | 负数截断除法与取余 | 68 |
| `double_cmp` | 四种 `double` 比较 | 1001 |
| `mixed_8_args` | `int`/`long long` 在 6 个整数寄存器上交错 | 22 |

再加两段让上面那些 PASS 有意义的东西：

- **refusals**：引用未定义外部函数必须构建失败、且不留镜像
- **selfcheck**：用「期望值 +1」重跑一个用例，必须被判成 DIFF。判不出错的 harness
  证明不了任何通过

## 8. 明确不支持（构造时报错，不静默降级）

- `_Complex` 全部形态
- 变参函数的**定义**（调用可以）
- >8 字节复合体按值参数 / 按值返回（sret 的**接收**方向已支持）
- 16 字节 load/store、`DUP > 4`、参数个数 > 64
