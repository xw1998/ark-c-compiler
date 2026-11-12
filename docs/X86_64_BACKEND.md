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

## 3. 本轮修掉的五个静默错答案

五个缺陷的共同点：**编译退出 0，镜像能跑，答案是错的。** 前四个在 x86-64 后端里，第五个（§3.5）在 `sizeof` 的求值时机上，只在**自举**时才暴露。

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

### 3.5 `sizeof` 一个成员数组被折成 4（只在自举时暴露）

这条不是后端缺陷，是**前端把不知道的事答成 4**，而寄主 GCC 编出来的宿主 arkcc 恰好
不经过那条路径，所以它一直没被 x86-64 的执行级门禁看见。

**现象**：自举镜像里那份"arkcc 编出来的 arkcc"编完整 payload，得到 2351 字节对象；
宿主编译器给 2130 字节。自举侧有 **20 条重定位**（宿主 3 条），而且重定位符号名
**只剩前 3 个字符**：`accumulate`→`acc`、`classify`→`cla`、`g_items`→`g_i`、
`g_names`→`g_n`、`.Lclassify_1`→`.Lc`。

**定位**：先让探针把生成的汇编文本也吐出来（`g_asmout`），结果是
**自举版与宿主 `-S` 输出 877 行完全一致** ⇒ 故障不在 irgen，在**汇编器**。
再往下：`xa_parse_operand` 把符号名拷进 `op->sym` 的循环上限写的是
`sizeof(op->sym) - 1`；宿主编出来的机器码是 `mov eax, 512; sub eax, 1`，
自举版是 `mov eax, 4; sub eax, 1` ⇒ **只拷 3 个字节**。

**根因**：`src/parser.c` 的 `sizeof expr` 分支在 **parser 阶段**就求值，靠 `e->type`；
而 `AST_MEMBER`（`s.f` / `p->f`）的类型要等 **sema** 才有 ⇒ 落到兜底
`if (s <= 0) s = 4;` ⇒ `sizeof` 一个 `char sym[512]` 成员 **静默答 4**。
（宿主侧同样错算，只是宿主是 GCC 编的、汇编器不是 arkcc 自己，于是错答案沉在水下。）

**修法**（4 个文件，口径是"不知道就别说 4"）：

- `include/ast.h`：`AstNode` 加 `AstNode *sizeof_operand;`（NULL = 已折叠），
  并声明 `ast_sizeof_pending()`
- `src/ast.c`：`ast_new` 初始化该字段（`ast_new` 不清 union，新字段必须显式置零）；
  新增 `ast_sizeof_pending()`（`u.num_val = 0`、`sizeof_operand = operand`）
- `src/parser.c`：`sizeof expr` 加 `s_known` 标记——字符串字面量、已有 `type` 的表达式、
  `AST_VAR`、函数返回值、数组元素这五条**能定性**的快速路径行为不变，其余改为
  `ast_sizeof_pending()`，交给 sema
- `src/sema.c`：`AST_SIZEOF` 若 `sizeof_operand` 非空，就 `sema_expr` 求操作数类型、
  `type_size` 回填并清空；`type_size <= 0` 时**报错**
  `'sizeof' applied to an incomplete or untyped operand`，不再答 4。
  `eval_const_expr` 遇到未求值的 sizeof 返回 0 ⇒ 拿它当数组维度 / case 标签的代码
  现在**显式报错**，而不是拿 4 悄悄算错。

**验证**：`sizeof(s.sym)` / `sizeof(p->sym)` 从 4 变 512、`sizeof(struct S)` 516；
门禁新增 `sizeof_member_array`；自举对象从 2351 字节回到 **2130 字节、3 条重定位、
`fnv=28c333dc`（与宿主同值）**。

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
| 本地数组下标全读到错的元素（`int a[3]={1,2,3}; a[1]` 得 1、`const char *p[2]={"ab","cd"}; p[1][0]` 得 `'a'`、两个本地数组同时用得 0） | 本地数组的**取址与下标** |

这些是 i386 后端的历史欠账。x86-64 门禁把它们**明确打印成 SKIP 并给出实测理由**，
既不判 PASS 也不判 FAIL——否则要么假绿、要么把 x86-64 的正确结果误判成回归。

最后一行是 2026-11-12 新查清的一条，写在这里是为了让"已知缺口"有坐标，而不是当免责声明：

32 位路径把本地变量定位成 `[ebp - (48 + off)]`（`backend_x86_64.c` 的 32 位发射器里
`48 + I->val` 出现在 `IR_STORE`/`IR_PUSH_VAR`/`IR_PUSH_ADDR`/`IR_GETARG` 四处），
**帧偏移递增 ⇒ 地址递减**；而 `IR_LOAD_IDX` 与 `&obj + k` 是在**地址空间**里
`base + i*es` 递增。于是同一个对象的"初始化写"（帧偏移，向下）和"下标读"（地址，向上）
方向相反。实测三例都只有 32 位臂错、x86-64 臂对：

| 源 | x86_64 | x86 |
| --- | :---: | :---: |
| `int a[3]={1,2,3}; return a[0]+10*a[1]+100*a[2];` | 321 | 1 |
| `const char *p[2]={"ab","cd"}; return p[1][0];` | 99 | 97 |
| `int a[3]={1,2,3}; int b[3]={4,5,6}; return a[1]+10*b[1];` | 52 | 0 |

结构体字段**碰巧**能用，是因为地址向上的偏移落进了帧底那 36 字节 padding
（`[ebp-12]` 存器区与 `[ebp-48]` 本地区之间），对象一旦大到越过 padding 就会写到
保存的寄存器上。**修它不是一行**：把 32 位帧映射改成与 x86-64 同构的
`[ebp - framelo + off]`（`framelo = 48 + round16(local_size)`）会同时动到
`IR_GETARG` 的 8000 变参区、`sret_off` 与 300 字节 scratch 布局，
按"后端另议"暂挂——**这是缺陷，不是设计**，x86-64 侧不受影响。

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

33 个程序编译成 0x400000 的平铺镜像，在 unicorn 的 64 位核上跑 `main`，逐个断言一个
**在程序之外算出来的常量**（不拿宿主 gcc 当 oracle）。下表只列锚点用例，不是全表：

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
| `data_array_init` | `int g[4]={1,2,3,4}`：`.quad` 必须两个半字都发（曾丢高半字 ⇒ `{1,0,3,0}`） | 30 |
| `rodata_ptr` | `const char *msg="hello"`：静态绝对指针必须带镜像基址（曾留 0） | 35 |
| `fptr_table` | 静态函数指针表：表内每一项都要指向真实函数（曾全指镜像起点） | 14 |
| `struct_sret24` / `struct_sret40` | 24 / 40 字节结构体按值返回：被调方必须真的把 payload 拷进 `*sret`（曾整个丢掉拷贝） | 38 / 19 |
| `ptr_array_init` | 本地与文件级指针数组初始化：每个元素占满 8 字节，下标与元素内容都要对 | 0 |
| `sizeof_member_array` | `sizeof(s.sym)` / `sizeof(p->sym)` 是成员数组的大小而不是 4（§3.5） | 0 |

再加三段让上面那些 PASS 有意义的东西：

- **`-c` / `-link` 跨 TU**：`globals_two_objs`（初始化全局数组 + 字符串 + 两函数）拆成两个
  源文件各自 `-c`，再用 `-link` 拼起来跑，期望 23。它同时钉住
  `X86_RELOC_SELF_BASE`(7)：对象里的绝对引用必须按**对象自身 base** 结算，
  而 `-c` 出对象时还不知道那个 base。
- **refusals**：引用未定义外部函数必须构建失败、且不留镜像
- **selfcheck**：用「期望值 +1」重跑一个用例，必须被判成 DIFF。判不出错的 harness
  证明不了任何通过

当前实测：`33 passed, 0 failed, 0 skipped`。

### 7.1 自举门禁：把"能跑一次"变成"逐字节复现宿主对象"

```
make test-x86-64-selfhost
python tests/run_x86_64_selfhost.py --arkcc ./arkcc.exe
```

这条门禁走的是四步，每一步都能独立失败：

1. **自编译**：x86-64 臂用 `-c` 把 **24 个自源 TU**（`src/*.c` 去掉 `main.c`/`registry.c`
   再加四个后端与 `registry.c`）编成对象；任何一份编不过就 FAIL，不降级。
2. **链接镜像**：24 个对象 + `tests/selfhost/selfprobe.c`（顶替 `port/host/*`）+ 
   `tests/selfhost/libcstub.c`（顶替 libc 的内存/字符串/`vsnprintf` 入口；任何真正的
文件或流调用都会记 `g_stub_hits`，而门禁要求它是 0）用 `-link -v` 拼成约 6.0 MB 平铺镜像，
   基址 0x400000。
3. **在 unicorn 上跑自举编译器**：探针把 payload 源码放在 `g_payload_src`、输出写进
   RAM 缓冲，所以整条"读文件/写文件"的宿主 I/O 都被替换掉了——留下的正是
   **前端 / 优化 / 后端 / 汇编器 / 对象写出** 这一段。同时探针记 `g_stub_hits`，
   一旦自举编译器摸到任何 libc stub 就 FAIL（那等于说这段路径在这个镜像里没有实现）。
4. **对拍**：同一份 payload 用**宿主**arkcc 再编一次，两个 ARKOBJ2 **逐字节**比较
   （长度 + fnv-1a）。相等才 PASS。

它还顺手做一件诊断上的事：探针把自举编译器生成的**汇编文本**也存下来，与宿主 `-S`
的输出逐行比较。文本相等而字节不等 ⇒ 差异在汇编器；文本不等 ⇒ 在代码生成。
2026-11-12 就是靠这一条把 §3.5 从"221 字节差异"缩小到"`sizeof` 一个成员数组"的。

当前实测：

```
self-compiled 24 translation units
built self-host image: 6256161 bytes
asm  : text identical (877 lines)
probe: ark_compile rc=0 object=2130 bytes fnv=28c333dc
probe: libc stubs hit 0 (expected 0), unknown printf conversions 0
host : object=2130 bytes fnv=28c333dc
PASS self-host: byte-identical object
```

**这条门禁证明了什么、没证明什么**（不写清楚就等于夸大）：

- 证明了：编译器能把自己编成 x86-64 机器码、能链接、能在一个 64 位核上**跑起来并完成
  一次完整编译**，产物与宿主逐字节相同。也就是说 x86-64 后端覆盖了"编译器自己用到的
  全部语言子集 + 全部 IR + 全部汇编语法"。
- **没证明**：产出一个能在真实操作系统上直接执行的编译器**二进制**。平铺镜像没有
  ELF/PE 头、没有动态链接、没有 OS 系统调用层，`main` 与 libc 都是探针供的。
  平台上跑得起来还需要"镜像 + 加载器 + 系统调用适配"这一段，不在本门禁范围内。
- 也没证明：`-O` 之外的优化档、`_Complex`、变参函数**定义**（§8 里那些明确不支持的
  形态）在自举路径上成立——payload 与自源都没用到它们。

## 8. 明确不支持（构造时报错，不静默降级）

- `_Complex` 全部形态
- 变参函数的**定义**（调用可以）
- >8 字节复合体按值参数 / 按值返回（sret 的**接收**方向已支持）
- 16 字节 load/store、`DUP > 4`、参数个数 > 64
