# 丢弃返回值检查（`--warn-unused-result`）

[English](UNUSEDRESULT.en.md) | 中文

`__attribute__((warn_unused_result))` 是 C 里少数能把"这里有个缺陷"写进声明
的手段之一。arkc 从 0.6.x 起就**接受**这个属性，然后把它和 `may_alias`、
`nothrow` 一起丢进"静默忽略"的桶里——这比不认它更糟：声明读起来像检查已经
生效，实际什么都没发生。

0.8.6 起它有了意义，开关是 `--warn-unused-result`，默认**关**。

## 1. 判据

一条语句的**整个表达式**恰是一个对被标注函数的调用，就告警：

```c
extern int __attribute__((warn_unused_result)) f(void);

void g(void)
{
    f();            /* 告警：f 的值被整条语句丢掉 */
    (void)f();      /* 沉默：显式丢弃 */
    int x = f();    /* 沉默：值被使用 */
    if (f()) {}     /* 沉默：值被使用 */
    h(f());         /* 沉默：值被使用 */
}
```

`(void)` 强转是 GNU / clang 通用的"我确实不要这个值"的写法，所以它是唯一
的显式丢弃通道。

### 别名

同一个属性有三种常见拼写，全部认：

| 写法 | 出处 |
| --- | --- |
| `__attribute__((warn_unused_result))` | GCC / armcc 5 |
| `__attribute__((__warn_unused_result__))` | glibc 头文件 |
| `__attribute__((__must_check__))` | Linux 内核的 `__must_check` 宏展开形态 |

注意：裸写 `__must_check`（不带 `__attribute__`）**不是**语言关键字，arkc 不
认这种写法——它是内核用宏 `#define __must_check __attribute__((warn_unused_result))`
拼出来的，源文件必须自己带上那个宏定义。

### 属性的粘性

属性按**函数名**记录，所以"头文件里声明、另一个地方定义"是同一个函数：

```c
extern int f(void) __attribute__((warn_unused_result));   /* 声明带属性 */
int f(void) { return 1; }                                /* 定义不带 */
void g(void) { f(); }                                    /* 仍然告警 */
```

## 2. 刻意不做的事

| 形状 | 行为 | 为什么 |
| --- | --- | --- |
| 通过函数指针调用 `p();` | 沉默 | 没有声明可读，属性不存在于任何声明上 |
| 返回值是 `void` 的被标注函数 | 沉默 | 没有值可丢，属性是空操作 |
| 调用出现在更大的表达式里 | 沉默 | 值被使用了——这只是"语句形状"的检查，不是数据流分析 |
| 超过 256 个被标注函数 | 报一条 warning 说检查不完整 | 截断的表会静默漏检，那比报错更糟 |
| 与 `--warn-mem` 的 double free 检查合并 | 不做 | 两件事的证据来源不同（一个看声明，一个看调用形状） |

## 3. 可裁减

```c
/* include/arkcc_config.h */
#ifndef ARKCC_FEATURE_UNUSEDRESULT
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_UNUSEDRESULT 0   /* 板上裁掉：省 Flash */
# else
#   define ARKCC_FEATURE_UNUSEDRESULT 1
# endif
#endif
```

整个 pass 是一个自包含源文件（`src/unusedresult.c`），无堆、无动态分配，
栈上一张 256 项的指针表。特性不在的构建里：

- 命令行 `--warn-unused-result` 以 `C3900U` 拒绝并给出重建方法；
- 配置文件 `warn_unused_result = 1` 同样以 `C3900U` 拒绝；
- `--no-warn-unused-result` 永远接受（要求"不检查"不需要那个 pass 存在）。

**默认关 ⇒ 产物与 v0.8.5 逐字节相同**（80 个 examples × 3 个 `-O` × 2 个目标
= 480 次对拍，`diffs=0`）。

## 4. 与管线的关系

它是 `src/pipeline.c` 里的一张 AST 阶段表项：

```
  skip  ast.unusedresult  off (--warn-unused-result)
```

`--print-pipeline` 会把它和其他阶段一起打出来。它属于 `lite` 剖面（和
`ast.memlint` / `ast.enumcheck` 一样是廉价检查，没有 `-O` 门槛），所以
`--pipeline=lite` 不会把它关掉——关它只有 `--warn-unused-result` 这一个开关。

## 5. 门禁

`tests/run_unusedresult_tests.py`（`make test-unusedresult`），19 条断言：

1. 五个正例逐行命中，文案带被调函数名；
2. 合法孪生（`(void)` / 赋值 / 条件 / 操作数 / 函数指针 / void 返回 / 未标注）
   整份文件零输出；
3. 反例文件（只有函数指针调用）零输出；
4. 开关三位一体：不带开关沉默、`--warn-unused-result --no-warn-unused-result`
   沉默、反过来点亮；
5. 现场用 `-DARKCC_FEATURE_UNUSEDRESULT=0` 重建后，命令行与 INI 两条路径都必须
   被拒。

## 6. 已知局限

- 只做语句形状判定，不追数据流：`int x = f(); (void)x;` 不会告警（值"被使用"
  过），这不是本 pass 的目标。
- 不做跨翻译单元：属性必须出现在本 TU 能看到的某个声明上。系统头文件里的
  原型经预处理进入本 TU，因此照常生效。
- 报错位置是语句行的调用处；列号在调用节点没有记录时退化为"整行"。
- 与 armcc 的 `--diag_suppress` 不兼容：这条诊断没有 armcc 编号（没有实测过
  armcc 的对应文案），所以只能整类开关，不能按编号屏蔽。
