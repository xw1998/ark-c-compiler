# 诊断层（Diagnostics）

arkc 的目标之一是**在诊断输出上与 armcc 5.06 逐字节一致**：同一份源码、同一个选项，
用户看到的文本应当能和 armcc 的输出直接 diff。本文说明这套诊断层怎么组织、
为什么这样组织，以及新增一条诊断时该改哪里。

判定标准只有一条：**能拿真实 armcc 的输出做逐字节比对**。凡是比对不上、
或只能"看起来像"的地方，都在 §7 明确列出，不用"大概一致"含糊过去。

---

## 1. 分层：一条诊断要经过四步

```
阶段代码                diag.c                                    输出
--------                ------                                    ----
diag_report(...)   ->   admit（抑制/上限策略）                  ->  不通过就丢弃
                        expand（模板 + 参数数组）                ->  得到消息正文
                        emit_diag（按风格排版位置/严重级/码）    ->  得到一整行
                        out_*（stderr 或 --errors 文件）         ->  落字节
```

关键约束：**阶段代码只描述"哪里错了"**（码、严重级、位置、参数），
**怎么排版一律在 `src/diag.c`**。这样 armcc 风格变了、或者要加 `--diag_style`，
只需改一个文件，不需要回头看二十几个源文件里的格式串。

`report()` 内部接收的是**参数数组 + 个数**（`const char *const *args, int nargs`），
而不是散开的三个指针。公开入口仍然是最多三个参数的固定签名（那是 armcc
自身的上限），只有 `diag_tool()` 允许六个——因为链接器的
"SRAM overlap between objects #0 and #1 …" 一条消息要打印四个地址。

| 文件 | 职责 |
| --- | --- |
| `include/diag.h` | 公共接口。阶段代码只 include 这一个头。 |
| `src/diag.c` | 策略、排版、源码回显与 caret、汇总行、输出目标。 |
| `tools/gen_diag_table.py` | 从 armcc 逆向产物抽取码表，生成下面两个文件。 |
| `include/diag_msg_table.h` | **生成物**：`diag_msg_lookup()` 等查询函数。 |
| `src/diag_msg_table.c` | **生成物**：码 → 模板的两张表。 |
| `tests/run_diag_tests.py` | 门禁：与真实 armcc 逐字节比对。 |
| `tests/run_diag_boundary.py` | 门禁：逐字节比不了的边界契约（长行、上限、CJK、tab）。 |

生成物不要手改：改的是 `tools/gen_diag_table.py` 里的策展清单，然后重跑。

---

## 2. 公共接口

```c
void diag_init(const char *main_file, const char *source_text);
void diag_set_source(const char *source_text);   /* 预处理后的文本换了 */
void diag_set_main_file(const char *main_file);  /* 只换"能行动的文件" */
void diag_shutdown(void);
void diag_summary(void);

/* 有 armcc 码：查表拿模板 */
void diag_report(int code, DiagSeverity sev, const DiagLoc *loc,
                 const char *a0, const char *a1, const char *a2);

/* 同一条码，但锚在"翻译单元结束"处（见 §4 的 At end of source） */
void diag_report_at_eof(int code, DiagSeverity sev, const DiagLoc *loc);

/* 没有对应 armcc 码：只借排版，不编造码 */
void diag_report_msg(DiagSeverity sev, const DiagLoc *loc, const char *msg,
                     const char *a0, const char *a1, const char *a2);

/* 驱动层码（C####U / C####E / ...），严重级由码尾字母推断 */
void diag_driver(const char *code, const char *a0, const char *a1);

/* 命令行诊断，比文件诊断多一个 "command-line:" 段 */
void diag_command_line(int code, DiagSeverity sev,
                       const char *a0, const char *a1, const char *a2);

/* 工具阶段（链接器 / scatter / ld 脚本）诊断：锚点是输出镜像，不是源码行 */
void diag_tool(DiagSeverity sev, const char *object, const char *msg,
               const char *a0, ... const char *a5);   /* 六个参数槽 */

const char *diag_num(char *buf, int v);              /* 数字 → 稳定字符串 */
```

设计上的五个决定：

1. **严重级由码尾字母推断**（`diag_driver`）。码表是唯一真源，
   调用点不可能把 `C3900U` 报成 warning。
2. **没有对应码就不写码**（`DIAG_NO_CODE`）。没用真实 armcc 量到码的消息
   一律走 `diag_report_msg`，只统一排版。宁可少一个 `#N`，也不猜一个。
   链接器那批消息就属于这一类：armlink 的 `L####` 码我们**没有实测过**，
   所以 `diag_tool()` 恒不带码，只保留 `<object>: Error: <text>` 形状。
3. **`DiagLoc.file` 传 `DIAG_NO_SOURCE_TEXT`**（`"no source"`）表示
   "这条诊断说的是整个翻译单元"。排版层认出这个字面量，不会把它替换成主文件名。
4. **`diag_set_main_file()` 与 `diag_init()` 分开**。链接模式下"用户能行动的那个
   文件"是输出镜像而不是源文件，但此时不能再 `diag_init()`——那会清掉已经发生的
   诊断计数。只换名字、不动计数，是这个函数存在的全部理由。
5. **`-D` 后缀跟"内在类别"走，词的种类跟策略走**。实测：
   `--diag_error=177` 打印的是 `Error:  #177-D`（`-D` 仍在），
   `--diag_warning=101` 对一条 error 没有任何可观察效果。
   所以 `code_to_str(code, intrinsic_sev, out)` 用"内在 warning 或表内 `d_tag`"
   决定 `-D`，而 `override_severity()`（`--diag_error` 的表）只决定用哪个词。

---

## 3. 码表：按引用抽取，不搬整张表

armcc 前端有 2428 个消息槽、驱动层另有 316 条 `C####`。arkc 只用到其中
一小撮，所以表是**按引用抽取**的：

- `tools/gen_diag_table.py` 里有两份策展清单：`FRONTEND_CODES`、`DRIVER_CODES`；
- 只有被 arkc 实际调用、而且**用真实 armcc 量到过**的码才进表（当前 37 + 7 条）；
- 板端固件不会被 2428 条字符串撑爆；
- 新增一条诊断 = 清单里加一个码 + 重跑生成器。

```bash
python tools/gen_diag_table.py            # 重新生成（源目录默认指向逆向产物）
python tools/gen_diag_table.py --check    # CI：生成物是否与清单一致
python tools/gen_diag_table.py --source DIR
```

当前表里的 37 条前端码（`src/diag_msg_table.c` 是唯一真源；第二列 `-D` 表示
armcc 给这条码加了 `-D` 后缀，实测 `--diag_error` 改词不改后缀）：

| 码 | -D | 消息 |
| --- | --- | --- |
| 4 | | `out of memory` |
| 5 | | `cannot open %s input file %sq2: %s3` |
| 6 | | `comment unclosed at end of file` |
| 7 | | `unrecognized token` |
| 8 | | `missing closing quote` |
| 9 | | `nested comment is not allowed` |
| 11 | ✓ | `unrecognized preprocessing directive` |
| 12 | | `parsing restarts here after previous syntax error` |
| 13 | | `expected a file name` |
| 17 | | `expected a "]"` |
| 18 | | `expected a ")"` |
| 20 | | `identifier %sq is undefined` |
| 28 | | `expression must have a constant value` |
| 29 | | `expected an expression` |
| 35 | | `#error directive: %s` |
| 36 | | `the #if for this directive is missing` |
| 37 | | `the #endif for this directive is missing` |
| 38 | | `directive is not allowed -- an #else has already appeared` |
| 39 | | `division by zero` |
| 40 | | `expected an identifier` |
| 65 | | `expected a ";"` |
| 67 | | `expected a "}"` |
| 100 | | `duplicate parameter name` |
| 101 | | `%sq has already been declared in the current scope` |
| 117 | | `non-void %n should return a value` |
| 118 | | `a void function may not return a value` |
| 137 | | `expression must be a modifiable lvalue` |
| 140 | | `too many arguments in function call` |
| 148 | | `%n has already been initialized` |
| 165 | | `too few arguments in function call` |
| 174 | ✓ | `expression has no effect` |
| 177 | ✓ | `%n was declared but never referenced` |
| 179 | | `right operand of "%%" is zero` |
| 223 | ✓ | `function %sq declared implicitly` |
| 247 | | `%n has already been defined` |
| 992 | | `invalid macro definition: %s` |
| 1215 | ✓ | `#warning directive: %s` |

驱动层 7 条（严重级由码尾字母决定，`U`=用法/致命，`E`/`W`/`I` 同 armcc）：

| 码 | 消息 |
| --- | --- |
| `C3900U` | `Unrecognized option '%s%s'.` |
| `C3901U` | `Missing argument for option '%s'.` |
| `C3903U` | `Argument '%s' not permitted for option '%s'.` |
| `C4056E` | `bad option '%s'` |
| `C4065E` | `type of input file '%s' unknown` |
| `C4079E` | `%s command with no effect` |
| `C4486W` | `option '-%c' causes input file '%s' to be ignored` |

本轮新加进表的六条（17 / 18 / 67 / 137 / 140 / 165）与 `C3901U`，全部先用真实
armcc 量过：`#137` 对 `(a+1) = 2` 与 `(a+1) += 2` 都是它；`#140`/`#165` 按参数
多/少分派；`#67` 只在"文件结尾缺 `}`"时出现，走 §5.3 的 At end of source 形态。

`gen_diag_table.py --check` 的期望输出：

```
up to date (37 frontend, 7 driver)
```

占位符规则（`check_placeholders()`）：只接受 arkc 能正确渲染的
`%s %sq %n %c %d %u %%` 与编号形式 `%sq2 %s3`（1-based 下标，
`#5` 这类三参数消息必须用它）。遇到 `%t1`、`%nfd` 这类"类型名打印"
一律**硬失败**，不生成半对的表——那会变成一张看起来能用、实际印错的表。

---

## 4. 排版：两种风格不是"加个前缀"

实测（详见 `tests/diag_baseline/*.expected`，全部由真实 armcc 生成）：

| 情况 | ARM（默认） | IDE（`--diag_style=ide`） |
| --- | --- | --- |
| 前端诊断 | `"f.c", line 4: Error:  #20: identifier "c" is undefined` | `f.c(4,22) : error  #20: identifier "c" is undefined` |
| 结尾缺 token | `"f.c", line 3: Error: At end of source:  #67: expected a "}"` | 未实测，按文件诊断排版 |
| 文件已知行未知 | `"f.c": Error: At end of source:  #65: expected a ";"` | `f.c : error  #65: ...` |
| 无源文件 | `"no source": Error:  #5: cannot open source input file "x": ...` | `no source : error  #5: ...` |
| 命令行 | `"no source": Error: command-line:  #992: invalid macro definition: x` | `no source : error command-line:  #992: ...` |
| 工具阶段 | `out.bin: Error: SRAM overlap between objects #0 and #1: ...` | 同左（工具阶段无码、无行号） |
| 驱动 / 致命 | `Fatal error: C3900U: Unrecognized option '-x'.` | `armcc : Fatal error C3900:  Unrecognized option '-x'.` |

注意 IDE 列里几个**不是机械映射**的地方：

- 严重级词**不带冒号**（`error` 而不是 `Error:`）；
- 驱动码**丢掉尾字母**（`C3900U` → `C3900`）；
- 驱动消息冒号后是**两个空格**，而前端诊断是严重级后两个空格；
- `armcc : ` 前缀只出现在 IDE 风格的**驱动**诊断上；
- IDE 风格**不回显源码、不画 caret**（一行一条，uVision 靠行号列号定位）。

还有三条行为规则：

- **致命诊断（`Fatal error`）之后不打印汇总行**；普通 `Error` 照打。
  `diag_summary()` 里 `counts[FATAL] > 0` 时直接不输出。
- `--diag_style` 是**运行期全局属性**，并且在选项扫描前先扫一遍：
  实测 `armcc -x --diag_style=ide` 依然用 IDE 风格报 `-x`。
- **错误上限 30**（`DIAG_LIMIT_DEFAULT`）。实测 40 条重复声明：
  armcc 打印 30 条后**既不再打印也不再计数**，也没有"too many errors"之类的收尾行，
  arkc 照做。armcc **没有**对应选项（`--diag_limit=5` 被 `C3900U` 拒绝），
  所以 arkc 也不提供（`diag_at_limit()` 只是查询，上限是常量）。
  上限同时是**解析的停止条件**：`parse_program` 与 `parse_block` 在 `diag_at_limit()`
  时不再继续解析（文件已经看不懂了，继续建 AST 只会吃内存）。另有一条更根本的护栏：
  语句解析若**一个 token 都没消费**，就强制 `lexer_advance` 一个——否则同一条错误会在
  同一个 token 上无限重复。板上实测：`cc -S va.c` 不带 `-I`（`<stdarg.h>` 找不到）时
  `u.v = va_arg(ap, long long);` 让 #65/#29 在同一行刷了 595 ms，最后停在
  `[arkc] FATAL: memory pool exhausted`，真正的病因（缺 include）被最后一行盖住；
  现在 30 条错误后即停，226 ms 返回，不碰分配器。

---

## 5. 源码回显与 caret

实测形态：

```
"f.c", line 1: Error:  #20: identifier "c" is undefined
  int f(void){ int b = c; return b; }
                       ^
```

- gutter 固定 2 个空格，源码原样输出（**tab 保持 tab**）；
- caret 行按**显示宽度**重放：ASCII 记 1 列、CJK 记 2 列、tab 记 1 列且原样输出；
- 只对**主文件**回显。`#include` 进来的行无法在当前缓冲里定位，
  此时不回显——**不回显比回显错行诚实**；
- 回显用的文本必须是**预处理之后**的那份（lexer 的行号就是在它上面数出来的），
  所以 `diag_init()` 在 `preproc_process()` 之后才拿到源码。

### 5.1 列号是"显示单元"，不是字节

`Token.col` 与 `DiagLoc.col` 都是**1-based 显示列**：CJK 占 2 列、2 字节 UTF-8 字符
（如 `é`）占 1 列、tab 占 1 列。理由很直接：caret 行是按显示宽度画的，
若列号按字节算，一行中文注释就会把 caret 推到目标字符右边好几位。
`src/lexer.c: lex_col()` 维护一个增量游标，从左到右续算，
所以每个 token 的代价是"它与前一个 token 之间的字符数"，不是整行重扫。

（armcc 是字节口径，所以同一份含 CJK 的源文件上它的 caret 会偏左。
这是**有意**差异，见 §7。）

### 5.2 语义阶段的列从 AST 来

`AstNode.col` 由 parser 填：从 token 直接建出来的节点（标识符、数字、字符串、
浮点、一元、二元、赋值、调用、成员、下标、后缀自增）记下 token 的起点列；
派生节点继承它所代表子表达式的列（parser 里的 `anchor()`）。
几条实测校准的细节：

- `(a+1) = 2` 的 `#137`，armcc 的 caret 在 `(` 上 ⇒ 括号表达式**强制**取 `(` 的列
  （即使内部节点已有列）；
- `#165 too few arguments` 的 caret 在闭合 `)` 上（用 `g()`、`g(1)`、`g( 1 , 2 )` 三种写法量过）
  ⇒ 调用节点记的是 `)` 的列；
- `#140 too many arguments` 的 caret 在**第一个多余实参**上 ⇒ sema 改锚到
  `args[param_count]`，拿不到列时才退回调用点。

列未知（0）时只回显不画 caret。**caret 画不出来时宁可整行不画**：
若目标列落在行尾之后（长行被截断），或 caret 行本身超过 `DIAG_LINE_MAX`（512），
`echo_source()` 直接不输出 caret 行——画在错误位置比不画更坏。

### 5.3 结尾缺 token 的两种形态

`lexer_expect()` 在流已经到 `TOK_EOF` 时走 `diag_report_at_eof()`：

- 行号取**最后一个换行符所在的行**（`current.line - 1`，实测 1 行 / 3 行 / 5 行文件都成立），
  而不是 EOF token 自己所在的行；
- 位置后加 ` At end of source:` 标记，**不回显、不画 caret**（没有字符可指）；
- 非 EOF 情况下缺失的 `)` `]` `}` `;` 分别对应 18 / 17 / 67 / 65。

---

## 6. 命令行上的诊断策略选项（逐项实测）

| 选项 | 实测行为（armcc 5.06u7） | arkc |
| --- | --- | --- |
| `--diag_suppress=177` | 该条不打印，rc 不变 | 同 |
| `--diag_suppress=177,177` | 可用（重复无副作用） | 同（逗号或空格分隔） |
| `--diag_suppress=abc` / `=9999` | **静默忽略**，rc 不变 | 同（非数字、越界直接跳过） |
| `--diag_suppress`（无值） | `Fatal error: C3901U: Missing argument for option 'diag_suppress'.`，rc=1 | 同 |
| `--diag_remark=177` | 与 suppress **不可区分** | 复用同一套抑制位 |
| `--diag_error=177` | 打印为 `Error:  #177-D`，rc=1 | 同（`diag_force_error()`，`-D` 保留） |
| `--diag_error=177,101` | 可用 | 同 |
| `--diag_warning=177` | **无任何可观察变化** | 接受、无操作（拒绝会与 armcc 不兼容，编造降级语义又会错） |
| `--diag_limit=5` | `C3900U` 未识别选项（armcc 没有上限选项） | 不提供 |
| `--diag_style=ide` | `f.c(1,17) : warning  #177-D: ...` + `armcc : f.c: 1 warning, 0 errors` | 同 |

四个选项都在**主选项循环之前**预扫描，因为风格/抑制必须在第一条诊断出现前就位；
主循环里对它们只做"已处理"的空分支。

---

## 7. 与 armcc 的已知差异（明确不追的部分）

这些差异是**有意保留**或**无实测依据**的，不是没做完：

1. **错误恢复不同**。arkc 解析器遇到第一个语法错后按自己的路径恢复，
   因此消息**条数**可能与 armcc 不同。`run_diag_tests.py` 里这类用例标
   `shape`（只断言每行拼写），能逐字节比的标 `exact`。
   此外 arkc 在**前端出现任何 error 之后不再进入 sema / IR / 汇编**
   （`compiler.c` 在 parse 与 sema 之后各查一次 `diag_errors()`）。
   armcc 也停在前端，但恢复点不同；这条闸门的作用是消灭
   "unresolved label"、"could not be lowered" 这类只在第一条错误之后才成立的连带消息。
2. **`#1-D: last line of file ends without a newline` 未实现**。armcc 会为没有
   尾随换行的文件打这条警告（`-D` 后缀），arkc 没有。没做是因为它会改变
   既有工程的告警计数，属于要单独决策的行为变更。
3. **隐式函数声明**。`int f(void){ return nope(1); }` 里 armcc 打
   `#223-D: function "nope" declared implicitly` 并**编译通过**；
   arkc 不实现隐式声明，会在符号未解析时失败。这是语言特性缺口，不是排版差异。
4. **CJK 列的算法不同**。arkc 按显示单元（CJK=2），armcc 按字节。
   在 UTF-8 源码 + UTF-8 终端下 arkc 的 caret 才对得上；用 GBK 源码时 armcc 的才对。
   见 §5.1 与 `tests/run_diag_boundary.py` 的 `cjk` 用例。
5. **词法级诊断的 caret 可能差 1 列**。`#7: unrecognized token` 实测 armcc
   的 IDE 列号 24、ARM caret 画在 23；arkc 统一按列号画。
6. **`#pragma diag_suppress` 的粒度**。arkc 先跑预处理，抑制退化为
   "整个翻译单元生效"，而不是 armcc 的"从该点到下一个 pragma"。
7. **`--diag_style` 不回溯**。已经写到 stderr 的字节无法改风格，
   只有先扫一遍选项才能覆盖"风格选项出现在后面"的情况（已实现）。
8. **arkc 自有消息没有 `#N`**。见 §2 第 2 条。链接器/汇编器/配置文件的错误
   全部属于这一类：`<object>: Error: <text>`，不编造 `L####`。
9. **干净编译时 `--errors` 仍会建一个空文件**，armcc 则根本不建文件。
   arkc 在选项扫描时就打开 sink（这样后续任何一条诊断都不会漏）。
10. **位域超宽不报错**。实测 armcc 对 `struct S{ int a:40; }` 与
    `struct S{ char a:9; }` **完全不报**；arkc 保留自己的严格诊断，
    因此这两条消息不带 armcc 码。
11. **`At end of source` 的 IDE 风格未实测**，arkc 按文件诊断排版，不额外加工。

---

## 8. 新增一条诊断的步骤

1. 先拿到真实 armcc 的输出（`tests/diag_baseline/` 里放一个最小用例）。
2. 若要用 armcc 的码：把码加进 `tools/gen_diag_table.py` 的策展清单，重跑生成器。
   若 armcc 根本没有这条消息（或没量到）：不要编码，用 `DIAG_NO_CODE`。
3. 在阶段代码里调 `diag_report()` / `diag_report_at_eof()` /
   `diag_report_msg()` / `diag_tool()`；位置取该阶段的 token 行号列号，
   传 `0` 表示"行未知"。
4. 在 `tests/run_diag_tests.py` 的 `CASES`（能逐字节比）、`SHAPE_CASES`
   （只能比拼写）或 `SINK_CASES`（断言落到 `--errors` 文件里、控制台无泄漏）
   里加一条；若它是 arkc 自己的契约（长行截断、上限、CJK、tab 之类），
   加到 `tests/run_diag_boundary.py`。
5. `python tests/run_diag_tests.py --regen` 生成基线，再
   `python tests/run_diag_tests.py`；边界用例直接
   `python tests/run_diag_boundary.py`（它不需要 armcc）。

门禁的退出码有三档：`0` 全绿、`1` 有回归、`2` **无法判定**（既没有 armcc
也没有存好的基线）。第 2 档是故意的：没有证据时不允许"通过"。

基线文件后缀是 `.expected` 而不是 `.out`，因为仓库 `.gitignore` 里有 `*.out`
（构建产物）。用 `.out` 会让基线**静默不入库**，CI 上只剩 `[SKIP]`。

---

## 9. 配置开关

`include/arkcc_config.h` 里有两个开关：

- **`ARKCC_FEATURE_DIAG`**（总开关，默认 1）。置 0 时 `src/diag.c` 只编译
  一个**极简回退实现**（约 90 行，自带 512 字节缓冲的位置式 `%s/%sq/%n/%d/%c`
  展开，输出 `ark_log("[arkcc] ...")`）：仍然计数、仍然决定退出码，
  但**没有**码、风格、回显、caret、抑制、上限、sink。
  实测（`src/diag.o`，gcc -O2 x86_64，2026-11-04）：**14645 → 4397 字节**；
  整机可执行文件 127877965 → 127868520 字节（`-DARKCC_FEATURE_DIAG=0` 全量编译链接通过，
  `#warning`/重复声明/干净文件三条用例的退出码与完整版一致）。
  开关默认 1，所以默认构建的体积与行为跟"没有这个开关"时完全一致。
  回退实现**刻意不与完整实现共享代码**——共享机件省不了字节，
  而独立实现更容易看出正确性；码表（`diag_msg_table.c`）保留，
  因为文案是数据不是排版。
  `ARKCC_FEATURE_DIAG=0` 时 `ARKCC_FEATURE_DIAG_SINK` 被强制为 0。
- **`ARKCC_FEATURE_DIAG_SINK`**（`--errors <file>` 与输出目标切换）。
  `STM32_MIN` 档为 0（省 flash），此时 `diag_open_sink()` 恒失败，
  诊断只走 `ark_log`。

**两个已经踩过的坑**：

- `diag.h` 与 `common.h` 都**不**包含 `arkcc_config.h`，
  所以 `src/diag.c` 必须自己 include 它。少了这一行，`#if ARKCC_FEATURE_DIAG_SINK`
  在**所有** profile 上都读作 0（未定义宏在 `#if` 里就是 0），
  `sink` 相关代码被静默编掉，而 `--help` 与配置开关都还显示"支持"。
  `SINK_CASES` 就是这条的护栏。
- 开关类功能必须有一条**真正走到该功能**的用例，否则"关掉/编掉"与"可用"
  在测试里长得一模一样。总开关的护栏是"`-DARKCC_FEATURE_DIAG=0` 全量构建 +
  四个手工用例的退出码不变"，篇幅小但每一步都真的走过了回退实现。
