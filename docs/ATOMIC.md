# C11 `_Atomic` 与 `<stdatomic.h>`

[English](ATOMIC.en.md) | 中文

本文记录本编译器对 C11 原子类型的**实现边界、诊断策略与执行级证据**。要点先摆在前面：

- 有真原子路径的目标**只有一个**：`arm`（Cortex-M，单核 + PRIMASK 临界区）。
- `x86` / `x86_64` / `riscv32` / `c` 四个目标上，除 `atomic_init`（就是一次赋值）与 typedef
  之外，**每一个原子操作都是编译期错误**，报错文本本身就是说明书。
- 原子性不止"用不用库"：`x += 1` 与 `x++` 在 C11 是**读-改-写**，编译器一律拒绝，
  绝不用 LDR/ADD/STR 假装原子。
- 内存序一律按 `seq_cst` 实现，且这是**单核中断级互斥**——跨核、跨 DMA 的可见性它不负责。

## 1. 为什么必须"要么真原子，要么报错"

C 编译器最容易在生产线上留下静默错答案的地方，就是把原子操作悄悄降级成普通读写：
单核上 `atomic_store(p, v)` 展开成 `*p = v` 看起来完全正确，等到真有中断嵌套、
第二个核、或者 DMA 时才发现丢更新——而且这种 bug 的复现期是按月算的。

因此本项目按"宁可报错，不给错答案"处理：

| 场景 | 行为 |
| --- | --- |
| `arm` 目标上的 `<stdatomic.h>` 调用 | 真实现（临界区 / 单字不可分割访问） |
| 其余四个目标上的原子操作 | 编译期错误，`__arkcc_atomic_<op>_not_supported_on_this_target_use_a_mutex` |
| `_Atomic` 对象上的 `+=` / `-=` / `*=` / … / `++` / `--` | 编译期错误，点名 `atomic_fetch_*` |
| `_Atomic` 作用于数组 / 函数 / `struct`·`union` | 编译期错误（C11 6.7.2.4 与"复合体要锁"） |
| `_Atomic` 对象上的普通赋值 `x = 5` | 允许（这就是一次原子 store） |
| `atomic_init(&x, v)` | **五个目标都允许**（它就是一次赋值，可移植） |

## 2. 解析层

- `include/common.h` 增加独立 token `TOK_ATOMIC`；`src/lexer.c` 认可 `_Atomic` 拼写。
- `src/parser.c` 的 `parse_declspec()` 支持两种写法：限定符形式 `_Atomic int x;` 与
  类型名形式 `_Atomic(int) x;`，都置 `g_decl_is_atomic`。
- **原子性落在 `Type` 上**（`Type::is_atomic`，见 `include/type.h`），走 `type_atomic()`
  做浅拷贝，与 `const` / `volatile` 同构。这一点不是实现细节，而是必需：

  ```c
  typedef _Atomic int atomic_int;   /* stdatomic.h 里每个 typedef 都是这么写的 */
  atomic_int g;                     /* 到这里 g 还是不是原子对象？ */
  ```

  如果 `_Atomic` 只停留在解析层标记，`atomic_int g;` 的 `Type` 与 `int g;` 完全相同，
  后面的读-改-写检查就无从谈起。**`stdlib/include/stdatomic.h` 的全部 typedef 都用
  `_Atomic` 拼写**，正是为了让原子性沿 typedef 传播。

- `type_atomic()` 做的是**浅拷贝后打标记**，不是改单例：

  ```c
  Type *type_atomic(Type *t) {
      Type *q;
      if (!t) return t;
      if (t->is_atomic) return t;
      q = (Type *)mem_pool_alloc(sizeof(Type));
      *q = *t;
      q->is_atomic = 1;
      return q;
  }
  ```

  理由与 `type_qualified()` 相同：一个 `_Atomic int x;` 不能把此后所有 `int` 变成原子。

- **位置决定语义**：`type_atomic(base)` 在 `parse_declspec()` 末尾、解析声明符**之前**应用。
  于是 `_Atomic int *p` 里原子性落在 pointee（`p` 是普通指针），符合 C11；
  `int *_Atomic p`（限定符写在 `*` 之后）本轮未支持，见 §7。

- `check_atomic_type()` 在三处（成员 / 声明符 / 复位）调用，三类拒绝：

  | 输入 | 诊断 |
  | --- | --- |
  | `_Atomic int arr[3];` | `an array type cannot be _Atomic (C11 6.7.2.4)` |
  | `_Atomic int f(void);` | `_Atomic cannot be applied to a function type` |
  | `_Atomic struct S s;` | `atomic struct/union types are not supported (they need a lock; use one explicitly)` |

## 3. sema 层：读-改-写一律拒绝

C11 6.5.16.2p3（复合赋值）与 6.5.2.4p2（`++`/`--`）对原子对象都规定为 read-modify-write。
本编译器没有发射独占指令（`LDREX`/`STREX` 序列）或"取-算-存"临界区包裹的能力，
因此这两类节点在 sema 直接报错：

```c
static void err_atomic_rmw(AstNode *node, const char *form, const char *use) {
    DiagLoc loc = loc_of(node);
    diag_report_msg(DIAG_SEV_ERROR, &loc,
                    "%s on an _Atomic object is a read-modify-write (C11), which "
                    "this compiler does not lower atomically; use %s from <stdatomic.h>",
                    form, use, 0);
    g_errors++;
}
```

调用点：

- `case AST_ASSIGN`：`op != TOK_ASSIGN` 且左值 `type->is_atomic` →
  `form = "a compound assignment"`，`use = "atomic_fetch_add/sub/and/or/xor()"`。
- `case AST_UNARY`：`op == TOK_INC || op == TOK_DEC` 且操作数 `is_atomic` →
  `form = "an increment or decrement"`，`use = "atomic_fetch_add/sub()"`。

实测矩阵（`atomic_int` 经 typedef 得来，所以这同时验证了 `is_atomic` 的传播）：

| 源码 | 结果 |
| --- | --- |
| `atomic_int g; g += 1;` | 报错（复合赋值） |
| `atomic_int g; g++;` | 报错（自增） |
| `atomic_int g; g = 5;` | **不报错**——普通赋值就是原子 store |
| 块作用域 `atomic_int x; x += 1;` | 报错（typedef 传播生效） |
| `_Atomic int *p;` | 不报错（`p` 不是原子对象） |
| `_Atomic int q; q = 7;` | 不报错 |

`<stdatomic.h>` 里的五个 RMW 实现体写的是 `*p = (T)(old + v);` 而**不是**复合赋值，
所以库自身不会被这条新诊断误伤——这也是为什么实现里刻意避开 `+=`。

## 4. `<stdatomic.h>` 的两支

`stdlib/include/stdatomic.h`（约 21 KB）按 `__ARKCC_TARGET_ARM` 分两支。

### 4.1 ARM 支（真实现）

三套模板宏，用 `_Generic(*(p), ...)` 派发：

| 宏 | 覆盖类型 | 实现 |
| --- | --- | --- |
| `__ARKCC_ATOMIC_SMALL` | 32 位及以下：`_Bool, char, signed/unsigned char, short, unsigned short, int, unsigned int, long, unsigned long, float` | `load`/`store` 是普通访问（单核对齐单字访问本身不可分割）；`exchange`/`compare_exchange` 走临界区 |
| `__ARKCC_ATOMIC_LARGE` | `long long` / `unsigned long long` / `double` | load/store/xchg/cas **全部**走临界区（装不进一个字） |
| `__ARKCC_ATOMIC_RMW` | 五个 `fetch_add/sub/and/or/xor` | 临界区内"读-算-写"，实现体为 `*p = (T)(old + v)` |

配套细节：

- 临界区来自后端内建 `__arkcc_crit_save()`（`MRS r0, PRIMASK` + `CPSID i`，返回**旧的**
  PRIMASK）与 `__arkcc_crit_restore(int)`（`MSR PRIMASK, r0`）。它们被从
  `ARKCC_FEATURE_ASM_EXTRA` 区移出来，因此不需要 `--asm-extra` 就能用。
  `atomic_nested_mask` 用例专门验证嵌套语义必须是 `0,1,1,0`——"restore 一律清掩码"
  也能编过，只是会把调用方没申请的中断打开。
- `__arkcc_eq8(const volatile void *, const void *)` 做两字相等比较，避免 `long long ==`
  把 `__aeabi_lcmp` 拉进裸镜像。
- `atomic_flag` 是 `struct atomic_flag_s { _Atomic int __arkcc_flag; }`，
  `ATOMIC_FLAG_INIT` = `{ 0 }`；`ATOMIC_VAR_INIT(v)` = `(v)`；`kill_dependency(y)` = `(y)`。
- `atomic_is_lock_free(p)` = `((int)(sizeof(*(p)) <= 4))`。
- `atomic_thread_fence` = `__dmb()`，`atomic_signal_fence` = `__memory_changed()`（编译器屏障）。

### 4.2 非 ARM 支（每个名字都是编译期错误）

除 `atomic_init` / typedef / `atomic_is_lock_free` 外，其余名字全部展开成
`__arkcc_atomic_<what>_not_supported_on_this_target_use_a_mutex`，`<what>` ∈
`load / store / exchange / compare_exchange / fetch_add / fetch_sub / fetch_and / fetch_or /
fetch_xor / flag_test_and_set / flag_clear / thread_fence / signal_fence`。

真实报错长这样：

```
"n1.c", line 343: Error:  #20: identifier "__arkcc_atomic_load_not_supported_on_this_target_use_a_mutex" is undefined
```

**为什么用未声明标识符而不是 `#error`**：`#error` 会在任何 `#include <stdatomic.h>` 上引爆，
哪怕这个翻译单元一个原子操作都没用；展开成名字则只在**真的调用**时失败，且失败文本直接
说明是哪个操作、该怎么办。

## 5. 内存序

一律按 `seq_cst` 实现：写侧是临界区 / 单字访问，屏障用 `__memory_changed()`（编译器屏障），
ARM 上另有 `__dmb()` 供 `atomic_thread_fence` 使用。明确写进文档的三条边界：

1. 这是**单核中断级互斥**。`CPSID i` 关的是本核中断，不能阻止另一个核并发写同一地址。
2. `DMB` 只解决**顺序**，不解决 cache 一致性。要多核可见性得配 MPU/cache 维护或硬件一致性。
3. `seq_cst` 是"最强且唯一实现"的近似，不是对每个内存序分别做了优化；写 `memory_order_relaxed`
   也能编，但拿到的仍是 `seq_cst` 的强度。

## 6. 门禁与证据

### 6.1 `tests/run_atomic_tests.py`（跨目标矩阵，五个目标）

四个阶段，任一失败即非零退出：

1. `check_identity`：用 `-E` 展开，检查 `__ARKCC_TARGET_NAME` 等于
   `"arm" | "x86" | "x86_64" | "riscv32" | "c"`；`defined(__ARKCC_TARGET_*)` 之和**恰好为 1**；
   `__arm__` / `__thumb__` / `__ARMCC_VERSION` 只在 `arm` 上出现。
2. `check_refusal`：四个非 ARM 目标 × **11** 个原子操作，每个都必须编译失败、必须命中
   `__arkcc_atomic_<what>_not_supported_on_this_target_use_a_mutex`、必须**不留 `-o` 产物**。
3. `check_init`：五个目标上 `atomic_init` 必须编译通过。
4. `selfcheck`：同一份源码在 `arm` 上**必须不被拒**——否则"拒"这个判据没有分辨力（防假绿）。

### 6.2 `tests/arm_exec/run_arm_exec.py`（unicorn 执行级）

| 用例 | 期望 | 说明 |
| --- | --- | --- |
| `atomic_rmw` | 10 | load/store、exchange、两条 CAS 路径（成功写对象、失败把 **`expected` 操作数**写回）、`atomic_flag`、五个 RMW |
| `atomic_nested_mask` | 6 | 嵌套保存值按位编码 `0,1,1,0` ⇒ `1<<1 | 1<<2` = 6，专门打"restore 一律清掩码" |
| `atomic_wide` | 6 | 64 位路径：`12/2 + 4300000000%2 = 6`，只有 CAS 失败后对象未被改动且正确报失败才可达 |
| `atomic_reject` | 3 条诊断 | 数组 / 函数 / 结构体三类拒绝，且不许留镜像 |

`atomic_wide` 的期望值里 `4300000000u` 同时是整数字面量候选表（C99 6.4.4.1p5，
十进制带 `u` ⇒ `unsigned long long`）的回归点——旧实现在这里会把它截成 `0x004CA300`。

### 6.3 怎么跑

```
make test-atomic PYTHON="<path-to-python>"
python tests/run_atomic_tests.py --arkcc ./arkcc.exe
python tests/arm_exec/run_arm_exec.py            # 需 unicorn，共 29 个用例
```

## 7. 已登记的限制（不是 TODO，是明写的边界）

1. **`int *_Atomic p`（限定符在 `*` 之后）不支持**：`_Atomic` 只在 declspec 里识别，
   写法只覆盖 `_Atomic type` 与 `_Atomic(type-name)` 两种。
2. **经指针的读-改-写不拦**：`*p += 1` 里 `p` 指向 `_Atomic` 对象时，sema 看的是
   `*p` 的表达式类型，`is_atomic` 不沿解引用传播，因此不会报错。用 `atomic_fetch_add(p, 1)`。
3. **复合体原子类型不支持**：`_Atomic struct` 需要锁，当场报错而不是假装能原子访问。
4. **没有 `<threads.h>`**：`thrd_create` 之类不在范围内；`_Atomic` 的价值在本项目里是
   中断级同步，不是多线程。
5. **行号是预处理展开后的行号**：预处理器不发 line marker，`#include <stdatomic.h>`
   之后的诊断行号会落在展开流上（既有行为，非 `_Atomic` 特有）。
6. **只有 `arm` 有真实现**：`x86_64` 后端的 `lock xadd` / `cmpxchg16b` 未接，
   需要时另立（与 RV64 / ARM64 后端同批）。

## 8. 改动清单

| 位置 | 改动 |
| --- | --- |
| `include/common.h` | `TOK_ATOMIC` |
| `include/type.h` · `src/type.c` | `Type::is_atomic`、`type_atomic()` |
| `src/lexer.c` | `_Atomic` 关键字 |
| `src/parser.c` | `g_decl_is_atomic`、`check_atomic_type()`、declspec 末尾 `type_atomic(base)` |
| `src/sema.c` | `err_atomic_rmw()` + 复合赋值 / 自增减拒绝 |
| `src/backend/arm/backend_arm.c` | `MRS`/`MSR` 脱 `--asm-extra` 闸门；`__arkcc_crit_save` / `__arkcc_crit_restore` 内建 |
| `include/preproc.h` · `src/preproc.c` · `src/compiler.c` | `preproc_set_target()`、`__ARKCC_TARGET_*` 身份宏、非 arm 目标 undef 整套 armcc 宏 |
| `stdlib/include/stdatomic.h` | 全部原子接口（ARM 真实现 / 非 ARM 编译期拒绝） |
| `tests/run_atomic_tests.py` · `tests/arm_exec/run_arm_exec.py` · `tests/run_install_tests.py` | 门禁与安装清单（39 个文件） |
