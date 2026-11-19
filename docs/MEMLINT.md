# `--warn-mem`：函数内的内存 lint

[English](MEMLINT.en.md) | 中文

`--warn-mem` 是语义分析通过之后在 AST 上跑的一遍检查，只做**两件事**：

1. **返回自动存储期对象的地址** —— `return &x;`、`return local_array;`、`return &local.field;`、
   `return (T){...};`
2. **同一个函数内的 double free / use-after-free** —— 对象必须是直接来自
   `malloc`/`calloc`/`realloc`/`strdup`、且**从未逃逸、从未重赋值**的裸指针。

先把结论摆在前面：**这一遍检查通过，不代表程序没有内存错误。**
C 里"这个指针拥有那块内存"不在类型系统里，任何分析都无法把这两条检查变成保证。
Rust 能做到，是因为它先改了语言（禁别名 + 所有权进类型）。这里的目标是**只报能证实的**，
把漏报当作可接受的失败方式，把误报当作不可接受的失败方式。

门禁：`tests/run_memlint_tests.py`（`make test-memlint`，已并入 `make test`），22 条断言全过。

## 1. 检查 A：返回自动对象地址

判据是纯语法：`return` 的操作数（剥掉类型转换后）是

| 形式 | 报 | 说明 |
| --- | --- | --- |
| `return &x;`，`x` 是块作用域的普通变量 | 是 | 报 `automatic object "x"` |
| `return &s.b;`，`s` 是块作用域变量 | 是 | 沿 `a.b` / `a[i]` 回溯到根对象 `s` |
| `return a;`，`a` 是块作用域数组 | 是 | 数组退化成指向自己的指针 |
| `return (int[]){1,2,3};` | 是 | 块作用域的复合字面量也是自动存储期 |
| `return (T*)&x;` | 是 | 类型转换不改变被取址的对象 |
| `return &g;`，`g` 是文件作用域对象 | 否 | 活到程序结束 |
| `return &s;`，`s` 是 `static` 局部 | 否 | 静态存储期 |
| `return &p->b;`，`p` 是**指针参数** | 否 | `b` 在调用者的对象里，不是本函数的自动对象 |
| `return &*p;` | 否 | 这个表达式没有创建任何对象 |
| `return a[1];` | 否 | 值的拷贝 |

误报面只有一类：调用者拿到地址但**从不解引用**。这仍然是缺陷，所以文案说的是
"ceases to exist when this function returns"，而不是"运行时会崩"。

## 2. 检查 B：double free / use-after-free

只跟踪**能完整看见生命周期**的指针，跟踪表里每个名字是一个三值格：

```
ALIVE   —— 由 malloc/calloc/realloc/strdup 直接得来，还没被释放
DEAD    —— 已被 free
UNKNOWN —— 不确定（逃逸、重赋值、分支合并后两侧不一致……），一律沉默
```

`p = malloc(n);` 之后，下面这些会报：

| 代码 | 报 | 文案 |
| --- | --- | --- |
| `free(p); free(p);` | 是 | `"p" is freed twice` |
| `free(p); p[0] = 1;` | 是 | `use of "p" after it was freed` |
| `free(p); *p = 0;` | 是 | 同上 |
| `free(p); p->a = 1;` | 是 | 同上 |

下面这些**绝不**报（每条都是真程序，判据见后）：

| 代码 | 为什么沉默 |
| --- | --- |
| `free(p); p = 0; p[0] = 1;` | `p` 已经不再指向那块内存，重赋值即退出跟踪 |
| `p = realloc(p, n);` | `realloc` 会复活，直接按 ALIVE 重新登记 |
| `free(p + 1);` | 不是我们跟踪的那个指针值 |
| `if (c) free(p); p[0] = 1;` | 一侧 DEAD 一侧 ALIVE，合并成 UNKNOWN |
| `sink(p);`（把 `p` 传给别的函数） | 所有权逃逸，之后不再断言 |
| `free(p); p = malloc(16);` | 新对象、新生命周期 |
| 函数里出现 `goto`、标号、`asm`/`__asm` | **整个函数放弃**（跳转的目标状态不可知） |
| 函数指针调用的 `free` | 不认（猜一次就可能猜错） |
| 引用计数减到 0、setjmp/longjmp | 不在模型内 |

实现上的硬上限：**8 个被跟踪指针 / 32 个局部名**。表满即**整个函数放弃**，
不会挤出旧条目继续猜。分支与循环用"快照 + 合并"处理：两侧状态一致就保留，
不一致就降为 UNKNOWN。

因此这一遍的读法是：**报出来的都是真的（在不误报的意义上），没报的不代表安全。**

## 3. 开关与裁减

三层开关，默认全关，关掉时体积与行为都不变：

| 层 | 名字 | 默认 | 作用 |
| --- | --- | --- | --- |
| 编译期 | `ARKCC_FEATURE_MEMLINT` | 宿主档 `1`，`ARKCC_PROFILE_STM32_MIN` 档 `0` | 为 `0` 时整个 pass 不参与编译、不占 Flash |
| 运行期 | `--warn-mem` / `--no-warn-mem` | 关 | 后出现的那个生效 |
| 配置文件 | `[features]` 节 `warn_mem=1` | 关 | 与命令行等价，命令行优先 |

板端想要这个检查时：

```sh
gcc ... -DARKCC_FEATURE_MEMLINT=1        # 或改 arkcc_config.h 的 profile 默认
```

**特性被编译掉时，两种入口都会拒绝，而不是假装检查过：**

```
Fatal error: C3900U: --warn-mem is not compiled into this build (rebuild with -DARKCC_FEATURE_MEMLINT=1)
```

命令行 `--warn-mem` 与配置文件 `warn_mem=1` 走同一条路径、同一条诊断；
`--no-warn-mem` 在任何 build 里都接受（它只是"要默认值"）。

### 实测读数（口径写在数字旁边）

| 指标 | 读数 | 口径 |
| --- | --- | --- |
| 代码体积代价 | `-O2`：`+5,424 B` text；`-Os`：`+4,436 B` text | 宿主 x86-64 gcc，同一份源码、仅切换 `-DARKCC_FEATURE_MEMLINT=0/1`，`size` 的 `text` 列；**不是** Cortex-M7 上的字节数，Thumb-2 的比例会不同，量级相同 |
| 数据/BSS 代价 | `0` | 同上，`data` 与 `bss` 两列完全相同：没有全局表、没有动态分配 |
| 栈 | 每分析一个函数约 `900 B` 的固定帧 | `MlPtr p[8]` + `MlLocal loc[32]`，随函数返回释放 |
| 默认产物 | **逐字节相同** | `examples/{hello,arith,func}.c` × `arm`/`x86`/`riscv32`/`x86-64` 共 12 个 `.o`，与 `5350048` 用同一条 gcc 命令重建的 `arkcc` 的产物 `cmp` 全部一致 |

## 4. 与 `--diag_suppress` 的关系

这两条诊断**不带 armcc 编号**（项目规则：只对实测过的 armcc 编号使用编号），
所以 `--diag_suppress <code>` 无法定向关闭它们。要关只能整体关掉 `--warn-mem`。

## 5. 门禁在验什么

`tests/run_memlint_tests.py` 内嵌三份源文件，都不 `#include` 任何头（预处理后行号是
预处理缓冲区的行号，是 arkc 的既有口径；用例自带 `extern` 声明即可避开这个偏移），
期望行号靠 `ANCHOR:` 注释定位而不是写死数字。

| 组 | 断言 |
| --- | --- |
| 正例 | 8 种形状各报一次、行号正确、文案正确；**且总数为 8**（多报也算失败）；仍是 `0 errors`、退出码 0 |
| 反例 | 上面"绝不报"表格里的 12 种写法，整份文件**零输出** |
| 合法改写 | 8 个缺陷各自的合法孪生版本，整份文件零输出（防止门禁只认字面形状） |
| 开关 | 不开 `--warn-mem` 同一份缺陷文件零警告；`--warn-mem --no-warn-mem` 静默；反过来重新打开 |
| 裁减 | 现场用 `-DARKCC_FEATURE_MEMLINT=0` 重建一份 arkcc：`--warn-mem` 与 `warn_mem=1` 配置都必须 `rc!=0` + `C3900U`，而同一份源文件正常编译时零警告 |

重建那一步需要宿主 C 编译器（`CC`，默认 `gcc`）；没有编译器时该组打印 `SKIP` 并给出原因，
不会静默通过。

## 6. 已知局限

- 跨函数的所有权（`char *f(void)` 返回堆指针、`void g(char *p)` 接管所有权）**不在模型内**。
- 结构体成员指针、指针数组、`void **` 出参一律不跟踪。
- `goto`/`asm`/表溢出会让**整个函数**放弃，同一函数里其它确凿的缺陷也就一起漏掉。
- 与 `-fopt-*` 无关：这一遍跑在 AST 上、在代码生成之前，任何优化开关都不影响它的输出。
- 不是 sanitizer：它不插桩、不改产物，运行时一行都不多。

## 7. 这份检查在项目里的位置

`arkcc` 的诊断原则是"宁可报错，不给错答案"，而 `--warn-mem` 是这条原则在
**静态分析**方向的延伸：只在能证明时报，证明不了就沉默，并且把沉默的范围写在文档里
（也就是上面第 2 节的表格）。
