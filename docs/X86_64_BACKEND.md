# x86-64 后端（SysV AMD64）

[English](X86_64_BACKEND.en.md) | 中文

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

## 5. i386 的四类历史欠账：已全部清零

曾经的四类缺陷（`movq needs an xmm operand`、64 位算术 `UC_ERR_EXCEPTION`、
结构体按值传参得到大数、本地数组下标读到错的元素）**都已修好**，i386 与 x86-64
现在跑同一批程序给同一个答案。本节的表格是当时的记录，下面是修复后的实测读数；
x86-64 门禁不再对任何一类标 SKIP。

### 5.1 本地数组下标：帧映射改成与 x86-64 同构

根因是 32 位发射器把本地变量定位成 `[ebp - (48 + off)]`（`IR_STORE`／`IR_PUSH_VAR`／
`IR_PUSH_ADDR`／`IR_GETARG` 四处都这么算）：帧偏移递增 ⇒ 地址递减，而 `IR_LOAD_IDX`
与 `&obj + k` 在地址空间里 `base + i*es` 递增，于是"初始化写"和"下标读"方向相反。
修法是把 32 位帧映射改成 `[ebp - framelo + off]`（`framelo = 48 + round16(local_size)`），
与 x86-64 同构；`sret_area_off`、变参区与 scratch 布局随之平移。

实测（`tests/run_x86_64_image_tests.py` 的数组族用例，双后端逐例断言）：

| 源 | 期望 | x86_64 | x86 |
| --- | :---: | :---: | :---: |
| `int a[3]={1,2,3}; return a[0]+10*a[1]+100*a[2];` | 321 | 321 | 321 |
| `const char *p[2]={"ab","cd"}; return p[1][0];` | 99 | 99 | 99 |
| `int a[3]={1,2,3}; int b[3]={4,5,6}; return a[1]+10*b[1];` | 52 | 52 | 52 |
| `int a[4][3]; … 嵌套下标` | 43 | 43 | 43 |
| `struct {int v;} a[2]` 成员读 | 987 | 987 | 987 |

### 5.2 结构体按值传参与返回（sret）

`>8` 字节结构体走隐藏返回缓冲 + 地址传递，`<=8` 字节走 `edx:eax`。实测 765／321／987／777
五组双后端全等，`sret` 与 `sret2` 两组探针逐例一致。

**最后一条残留（`struct_sret40`，40 字节按值返回）**：i386 上 `T5 x = mk5(3)` 拿回全 0。
根因是 callee 读参数的循环用 `reg_idx` 当边界：

```c
for (j = 0; j < reg_idx && j < 64; j++)      /* reg_idx 对 sret 函数还含隐藏指针 */
    stk += width_of(param_types[j]);
```

`reg_idx` 在 sret 函数里比真实参数序号大 1（隐藏返回缓冲指针占了 index 0），于是这个
"累加前面各参宽度"的循环把**本参数自己的宽度**也加了进去：`mk5(int v)` 的 `v` 在
`[ebp+12]`，却被读成 `[ebp+16]`，拿到的正好是返回缓冲指针的高半（0），所以 `x.a`
`x.b` `x.c[0..3]` 全是 0、只有 `x.c[4]` 是 4。修法是把边界换成"前面真实参数的个数"
（`param_idx - 1`，`param_idx` 此时已自增），非 sret 函数里两者本来相等 ⇒ 其它形态零变化。

修复后细分探针 6 例双后端全等（`s_a=3`、`s_b=6`、`s_c0=3`、`s_c4=7`、`s_all=19`、
`s_ptr=16`），门禁里 `struct_sret40` 的 i386 从 4 变 19，该行原有的
`(known 32-bit backend gap)` 注记已删除，并且**门禁升级为"i386 结果与期望不符即判 FAIL"**——
旧口径只把 i386 当脚注，等于给回归留了一条不必红的缝。

### 5.3 浮点：`x86_pair_swap_at` 在偏移 0 上是空操作

`double` 在栈上按"高字在上"传，`movq xmm0,[esp]` 之前要先把两个字调头。
`x86_pair_swap_at(&buf, off)` 原来写的是 `if (off) { 打印 [esp+off+4] }`，
`off == 0` 时**两处都读 `[esp]`**，交换退化成空操作，`movq` 把 hi:lo 当 lo:hi 装进 xmm0。
实测 `double d=7.9; (int)d;` 得 0。修法是两个位移永远都打印。

修复后浮点族 17 个用例（`f32` 9 例 + `f32b` 8 例）全等，含 `g3=59`、`g4=6`、`g5=7`、`g8=10`
这类"先算后转"的复合表达式。

### 5.4 64 位整数：四个根因

| 根因 | 现象 | 修法 |
| --- | --- | --- |
| `IR_UNARY` 忽略 `I->val` | `-1000000000LL` 变成 +1000000000（只翻了高半字，还漂 4 字节栈） | 新增 `I->val == 2` 分支（64 位 neg／bnot／逻辑非） |
| 64 位除法的 `|a|` 掩码写成 `sar esi,31` | 所有带负被除数的除法错值（`-1000000000LL/1000000` 给 140463611） | 改成 `neg esi`：`esi` 里是 0／1 符号位，`sar 31` 得 0 ⇒ `|a|` 从未取到 |
| 除法移位链用 `add ecx,ecx` | 所有 64 位除法答 0 | 四字全用 `add/adc` 链 |
| `IR_PUSH_INT` 只有 1 word | 64 位常量走 `IR_64PUSH`（val=high32, aux=low32） | 前端已按此分裂，此处记录口径 |

实测 `i64` 14 例、`i64b` 4 例、`neg` 6 例双后端全等（`p_sub=4294966296`、`p_mod=182`、
`p_shl=8`、`p_add=4000`、`n5`（`-1e9LL>>20`）=4294966342）。

### 5.5 C 档三条错值（同一轮修完）

| 缺陷 | 触发 | 修法 |
| --- | --- | --- |
| float／double 局部 `++`／`--` 当整数 1 加 | `double d=1.5; d++` 把 1 加到 bit pattern 上且只存 1 word | irgen 的 `AST_VAR` 分支补浮点路径（`irgen_push_step` + `IR_FADD` + 8 字节 store） |
| `IR_BINARY` 对 8 字节指针只做 32 位运算 | `p+n` 截断到 4 GB、`p<q` 只比低半 | irgen 打 `IR_AUX_SLOT64`，x86-64 发射器走 `rax/rcx` 形式 |
| 指针 ↔ `long long` 转换是 no-op | `char *q=p+4; (long long)q` 得 0（want 5）——指针 1 word、`long long` 2 word，高半是栈上垃圾 | irgen 新增 `irgen_ptr_to_int64`／`irgen_int64_to_ptr`，接到 cast／声明初始化／赋值／`return`／调用实参五处；x86-64 用 `IR_SEXT`／`IR_ZEXT` + `IR_AUX_SLOT64` 拆分／合并那个字，32 位目标用 `PUSH 0`／`POP` |

指针这一族的实测（11 个构造，双后端断言；32 位指针装不下 >4 GB，两例按 ISA 分别取值）：

| 源 | x86_64 | x86 |
| --- | :---: | :---: |
| `q=p+4; (long long)q` | 5 | 5 |
| `long long d=q;`（隐式赋值） | 5 | 5 |
| `(long long)q >> 32`（`p=(char*)0x100000000LL`） | 1 | 0 |
| `long long d; d=q; d=d+1;` | 6 | 6 |
| `(char*)5LL + 2` | 7 | 7 |
| `(char*)0x300000000LL != 0` | 1 | 0 |
| `f((long long)q)` / `f(q)`（`long long f(long long)`） | 6 | 6 |
| `long long f(char *q){return (long long)q;}` 的返回值 | 10 | 10 |
| `(char*)(long long)p == p` | 1 | 1 |

> 口径：`0x100000000LL` 转成 32 位指针必然截成 0，这是 ISA 事实，不是后端差异；
> x86-64 的 `(long long)q >> 32` 必须给 1，这正是那条"高半不能靠压 0"的分辨点。


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

35 个程序编译成 0x400000 的平铺镜像，在 unicorn 的 64 位核上跑 `main`，逐个断言一个
**在程序之外算出来的常量**（不拿宿主 gcc 当 oracle）；同一个程序**再编一次 32 位并在
unicorn 的 32 位核上跑**，`i386` 列与期望不符即判 FAIL（早期只把它写成脚注，
"32 位已知差距"因此长期没有变红）。下表只列锚点用例，不是全表：

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
| `ptr_llong_roundtrip` | 指针 ↔ `long long` 双向转换：高半要补也要丢（曾全给 0，§5.5） | 5 |
| `ptr_llong_arg` | 指针当 64 位实参传、并当 64 位返回值 | 41 |

再加三段让上面那些 PASS 有意义的东西：

- **`-c` / `-link` 跨 TU**：`globals_two_objs`（初始化全局数组 + 字符串 + 两函数）拆成两个
  源文件各自 `-c`，再用 `-link` 拼起来跑，期望 23。它同时钉住
  `X86_RELOC_SELF_BASE`(7)：对象里的绝对引用必须按**对象自身 base** 结算，
  而 `-c` 出对象时还不知道那个 base。
- **refusals**：引用未定义外部函数必须构建失败、且不留镜像
- **selfcheck**：用「期望值 +1」重跑一个用例，必须被判成 DIFF。判不出错的 harness
  证明不了任何通过

当前实测：`35 passed, 0 failed, 0 skipped`。

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

先记一条**已经不再是缺口**的事实（旧版这里写着"变参函数的定义不支持"，已经不成立）：
x86-64 与 i386 都支持变参函数的**定义**，`va_arg` 的 `int`／`long long`／指针／`double`／
≤8 字节聚合体都在门禁或探针里真跑过——`sum2(4,1,2,3,4)=20`（门禁用例 `varargs_copy`）、
`sd(3,1.5,2.5,3.0)=7`、`sl(1,3000000000LL)%251=59`、`ss(1,{1,2})=3`。
>8 字节结构体的按值传参与按值返回也支持（`struct_byval=45`、`struct_sret24=38`、
`struct_sret40=19`、64 字节返回体），18 个参数的调用（9 个寄存器 + 9 个栈槽）同样能编。

真正不支持的只剩下面这些，全部在**构造时报错**：

| 不支持的形态 | 现在的行为 |
| --- | --- |
| `_Complex` 全部形态 | 两个后端都在代码生成时报错（`real to complex conversion is not supported by the x86_64 backend`／`_Complex float store is not supported`／`[x86] _Complex value not supported`） |
| `va_list` 作为**文件级对象** | `__builtin_va_list g_ap;` 报 `expected declaration at top level`；函数内的 `va_list` 完全可用 |
| 单条 16 字节 load/store、`IR_DUP > 4`、参数个数 > 64 | IR／发射器内部上限。C 源码里需要 16 字节读写的唯一形态是 16 字节聚合体，而聚合体走 `rep movsb` 拷贝（`struct_copy16=11`），不受影响 |

`sizeof(long double) == 8`（`long double` 等同 `double`）是有意为之：C99 只要求
long double 的值集**至少**与 double 相同，等同是合法的，不构成降级。

C++ 不在范围内。已知的不设防点：`.cpp`／`.cxx` 输入会被按 C 编译而不报错，
此时得到的是 C 语义（没有 `bool` 类型名、类、重载、引用），不要把它当 C++ 用。

