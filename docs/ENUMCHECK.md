# `--warn-enum`：`switch` 漏掉枚举值

[English](ENUMCHECK.en.md) | 中文

`--warn-enum` 是语义分析之后在 AST 上跑的一遍检查，只做一件事：**当 `switch` 的控制
表达式是枚举类型、且这个 `switch` 没有 `default:` 标签、而它的 `case` 标签没有覆盖该
枚举的全部枚举值时，报一次警告。**

```c
enum Color { RED, GREEN, BLUE };

void f(enum Color c)
{
    switch (c) {
    case RED:   break;
    case BLUE:  break;
    }                 /* -> warning: missing GREEN */
}
```

先把口径摆在前面：**这是一个 lint，不是"switch 一定处理了所有取值"的保证。**
C 里枚举变量可以合法地持有任何枚举值之外的值（把一个 `int` 强转成枚举类型），
运行期它照样进 `default`（或者没有 `default` 时什么都不做）。这一遍只回答一个更小、
但可以确切回答的问题：**源码自己声明的枚举值，是不是每个都在这里写了名字。**

## 1. 判据

四条**全部**满足才检查，任何一条不满足就沉默：

| 条件 | 说明 |
| --- | --- |
| 控制表达式的类型是枚举 | 用 `int` 变量 `switch` 枚举常量**不检查** —— 类型才是"这个值来自那个集合"的凭据 |
| 该枚举的**定义**在本翻译单元里可见 | 只出现在声明里的 tag 没有枚举值列表，无从比较 |
| 这个 `switch` 没有 `default:` | `default` 就是 C 里"其余全部"的写法；写了它就是作者已经表过态 |
| 枚举值与 `case` 标签都不超过表上限 | `EC_MAX_ENUM` = 64、`EC_MAX_CASES` = 64 |

**按值比对，不按名字**：`case 0:` 与 `case RED:` 覆盖同一个枚举值；两个枚举值相同
（`enum E { A = 1, B = 1 };`）时一个 `case` 就把两个都覆盖了 —— 这与运行期的
`switch` 语义一致。

**嵌套 `switch` 各自独立判定**：收集 `case` 时遇到内层 `switch` 立即停止下潜，否则
内层 label 会假性补上外层的集合。

**超表即沉默**：枚举值或 `case` 超过上限时整条跳过，绝不截断后报告"缺值"——
截断比较会把"表外的值"说成"没写"，那正是这个项目最不能接受的错答案。

## 2. 诊断文案

```
line 6: Warning: switch on enum 'Color' does not handle every enumerator (missing: GREEN); add a case label or a default label
line 27: Warning: switch on an anonymous enum does not handle every enumerator (missing: B2); add a case label or a default label
```

缺多个值时按声明顺序列前 4 个，之后用 `, ...` 收尾（不截断判断，只截断显示）。
行号与列号指向 `switch` 关键字。

## 3. 开关与裁减

三层开关，默认全关，关掉时体积与行为都不变：

| 层 | 名字 | 默认 | 作用 |
| --- | --- | --- | --- |
| 编译期 | `ARKCC_FEATURE_ENUMCHECK` | 宿主档 `1`，`ARKCC_PROFILE_STM32_MIN` 档 `0` | 为 `0` 时整个 pass 不参与编译、不占 Flash |
| 运行期 | `--warn-enum` / `--no-warn-enum` | 关 | 后出现的那个生效 |
| 配置文件 | `[features]` 节 `warn_enum=1` | 关 | 与命令行等价，命令行优先 |

**特性被编译掉时，两种入口都会拒绝，而不是假装检查过：**

```
Fatal error: C3900U: --warn-enum is not compiled into this build (rebuild with -DARKCC_FEATURE_ENUMCHECK=1)
```

`--no-warn-enum` 在任何 build 里都接受（它只是"要默认值"）。

## 4. 实测读数

| 指标 | 读数 | 口径 |
| --- | --- | --- |
| 代码体积代价 | `-O2`：`+1,852 B` text；`-Os`：`+1,548 B` text | 宿主 x86-64 gcc，同一份源码、仅切换 `-DARKCC_FEATURE_ENUMCHECK=0/1`，`size` 的 `text` 列；**不是** Cortex-M7 上的字节数，Thumb-2 的比例会不同，量级相同 |
| 数据/BSS | `0` | 没有全局表；每个 `switch` 用两个栈上小数组（`EcCases` / `EcNames`） |
| 默认产物 | **逐字节相同** | 未开 `--warn-enum` 时 `compiler.c` 里那条调用根本不执行 |
| 依赖 | 需要 `Type.enumerators` | `parser.c` 在 `parse_enum` 里登记，靠 `type_enum_definition()` 按 tag 回查（每次 `enum E x;` 都新建 `Type`，指针身份不同，所以必须按 tag 建注册表） |

## 5. 门禁在验什么

`tests/run_enumcheck_tests.py`（`make test-enumcheck`，已并入 `make test`），19 条断言：

| 组 | 断言 |
| --- | --- |
| 正例 | 5 种形状各报一次、行号正确、文案正确、**总数恰为 5**：缺 1 值 / 缺 2 值 / 匿名枚举 / 嵌套（只报外层）/ 循环内的 `switch` |
| 合法孪生 | 全枚举覆盖、带 `default`、`switch` 走 `int`、共享值枚举、数字标号 `case 0:`、整份文件没有 `switch` —— 整份零输出 |
| 负例 | 只在声明里出现的 tag、70 个枚举值超表 —— 整份零输出 |
| 开关 | 不开 `--warn-enum` 同一份缺陷文件零警告；`--warn-enum --no-warn-enum` 静默；反过来重新打开 |
| 裁减 | 现场用 `-DARKCC_FEATURE_ENUMCHECK=0` 重建一份 arkcc：命令行与配置文件都必须 `rc!=0` + `C3900U`，而同一份源文件正常编译时零警告 |

用例不写 `#include`（预处理后诊断行号是缓冲区行号，这是本仓库的既有口径），行号靠
`ANCHOR:` 注释定位而不是写死数字，所以改动用例时不需要同步改期望值。

## 6. 已知局限

- 只看**类型是枚举**的 `switch`；`typedef` 到枚举上的名字同样按枚举判（类型没变），
  但 `switch ((int)c)` 就不查了。
- 枚举定义不在本翻译单元时不查（没有枚举值列表可比）。
- 超过 64 个枚举值或 64 个 `case` 时整条跳过。
- `case` 里用非常量表达式（GNU 扩展）不在支持范围；`case` 值由 parser 的
  `eval_const_expr` 折好，本 pass 直接用 `AST_CASE` 上的常量。
- 不检查"枚举值本身是否重复/越界"，那是另一个问题。

## 7. 为什么这条检查值得单独一个开关

Rust 的 `match` 穷尽性检查是**语言保证**；C 的 `switch` 没有这个保证，编译器也没有义务
提示。但"加了一个枚举值、忘了在某个 `switch` 里处理它"是嵌入式代码里最常见的一类静默
缺陷，而且**只在新增枚举值的那天**才会出现 —— 这类检查的正确用法是"新增枚举值时临时打开
一次"，而不是常驻。所以它默认关、可裁减、有 INI 开关，与 `--warn-mem` 同一套形态。
