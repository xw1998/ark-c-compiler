# 对象里的 IR 载荷与链接期重编（`--obj-ir` / `-link --lto`）

[English](OBJ_IR.en.md) | 中文

0.8.7 给 `ARKOBJ2` 对象加了一个**可选的 IR 载荷段**：`-c --obj-ir` 把"管线之前"
的整个程序（类型表、三个常量池、参数长度表、全局表、函数表）序列化后追加在对象
末尾；`-link --lto` 读回来、合并、跑一遍管线、重新出码。结果是
**`--lto` 与 `--ipo` 逐字节相同**——同一条管线、同一份 IR、同一套池布局。

这两个开关合起来补掉了 [IPO_LTO.md](IPO_LTO.md) §1 里那条"对象里没有 IR，所以
做不到真 LTO"的缺口；但**它不是 GCC/Clang 那种链接器内 LTO**，边界在 §6 逐条写清。

| 开关 | 默认 | 剖面 | 说明 |
| --- | :---: | --- | --- |
| `--obj-ir` / `--no-obj-ir` | 关 | `full` | 只在 `-c` 下有效；`--no-` 用于 ini 里默认打开时按次关掉 |
| `--lto` | 关 | `full` | 只在 `-link` 下有效；**必须写在 `-link` 之前** |
| `ARKCC_FEATURE_OBJ_IR` | 宿主 `1`，`ARKCC_PROFILE_STM32_MIN` 为 `0` | 裁剪开关 | 可在命令行 `-DARKCC_FEATURE_OBJ_IR=0/1` 覆盖 |

```bash
# 1) 逐文件编译，每个对象带上 IR
arkcc -c --obj-ir -target arm --cpu Cortex-M7 -O2 main.c -o main.o
arkcc -c --obj-ir -target arm --cpu Cortex-M7 -O2 util.c -o util.o

# 2) 链接期合并 IR、跑管线、重新出码（等价于一次 --ipo）
arkcc --lto -link main.o util.o -target arm --cpu Cortex-M7 -O2 --vector-table -o app.bin
```

`--lto` 与 `--ipo` 的关系是"同一件事的两种输入形式"：

```bash
arkcc --ipo -O2 main.c util.c -S -o ipo.s          # 吃源码
arkcc --lto -link main.o util.o -O2 -S -o lto.s    # 吃对象
cmp ipo.s lto.s                                     # 必须为空
```

---

## 1. 为什么载荷是"管线之前"的 IR

`--ipo` 对合并后的 program **只跑一次**管线。如果 `-c --obj-ir` 先优化再序列化，
`--lto` 就成了"第二次优化"，而第二次优化的输入已经取决于当初怎么切分文件——
这正是 LTO 最容易出错的地方（同一份源码切成两份编译，结果与不切不同）。

所以写载荷的钩子放在 `ark_frontend_unit()` 里 `pipeline_run_ir()` **之前**：

```
每个 .c → 前端 → IR（无优化） → [--obj-ir: 序列化并 stash]
                                   ↓
                          --ipo: 追加进大 program → 跑一次管线
                          --lto: 从对象读回 → 合并 → 跑一次管线
```

这条设计选择换来一条可以写成门禁的强断言：**`--lto` 与 `--ipo` 逐字节相同**。
不是"差不多"，是 `cmp` 为空。想不做到都难——两条路径走到管线的入口时，手里
必须握着同一个 IR。

## 2. 对象格式

`ARKOBJ2` 的既有布局不变，载荷**追加在重定位表之后**：

```
"ARKOBJ2\n"        8 B
u32 代码长度
代码字节
u32 符号数 + 每条（名字长/名字/偏移/类型/是否 weak）
u32 重定位数 + 每条（名字长/名字/偏移/类型）   ← 仅在存在重定位表时写
[载荷]                                          ← 可选，--obj-ir 才有
```

老读者读到重定位表就停，多出来的字节它根本不看，所以**带载荷的对象照样能被
plain `-link` 链接，结果与不带载荷逐字节相同**（门禁里有一条专门测这个）。

载荷自身的格式：

```
"ARKIR1\n"          8 B 魔数
u32 版本            = 1
u32 正文字节数
正文：
  u32 类型数 + 每个类型（kind / base / 字段数 + 字段 / 参数数 + 参数 ...）
  u32 字符串池长度 + 每个
  u32 浮点池长度 + 每个（8 字节位模式）
  u32 复数池长度 + 每个（两个 double）
  u32 参数长度表长度 + 每个（u8）
  source_file（可空字符串）
  u32 全局数 + 每个全局（名字 / 类型 / 标志 / 初值 / init_sym / init_refs[]）
  u32 函数数 + 每个函数（名字 / 返回类型 / 参数 / 局部 / 指令流）
```

字符串用 `i32 present(0 = NULL) + u32 长度 + 字节` 的形式写，`NULL` 与非 `NULL`
必须能往返——IR 里"没有名字"和"名字是空串"是两件事。

指令的字段顺序**照抄结构体**（`op, val, name, aux, line, aux2`），`name` **无条件
原样保留**。这是踩过的坑：`IR_FUNC_BEGIN` 用 `name` 存函数名，`IR_GETARG` /
`IR_PUSH_ADDR` / `IR_PUSH_VAR` / `IR_STORE` / `IR_PUSH_INT` / `IR_SMC` / `IR_SVC`
在实践中也会带 `name`，所以"只有某些 opcode 才允许有 name"的白名单校验只会误杀
合法 IR。序列化必须无损往返，反序列化不做这道白名单。

## 3. 合并规则

`ir_program_append_unit(dst, unit, index, who)`：

1. 记下四个池的当前位置作为 `base`；
2. 把单元的字符串 / 浮点 / 复数 / 参数长度表**追加**进目标池；
3. 指令里的池索引按 `base` **remap**（`IR_PUSH_STR.val` 是 strings 索引；
   `IR_PUSH_FLOAT.val` 按 `aux & 0x800` 选复数池还是浮点池；`IR_CALL.aux2` 是
   `1 + 参数长度表下标`，`0` 表示没有表）；
4. 把单元的函数逐个加进目标 program。

池**不去重**（追加，id = 追加后的位置）。这正是 `--ipo` 的行为，所以"两个对象
按命令行顺序合并"能复现 `--ipo` 的池布局，进而复现它的机器码。

合并之后走与 `--ipo` 完全相同的三件事：`ipo_mangle_unit`（文件作用域符号改名
`__ipo<单元>f_/g__<名字>` 并查重，两个对象里同名 `static helper` 必须仍是两个）、
`ipo_dedupe_funcs` / `ipo_dedupe_globals`（外部名按链接器规则裁定），
最后 `ipo_prune_statics`。`--lto` 复用 `src/ipo.c` 里的这几段，因为它们本来就是
`static`，没有第二份实现。

## 4. 命令行形状

**`--lto` 必须写在 `-link` 之前。** 原因在 `-link` 的输入收集规则：`-link` 之后
连续的非 `-` 开头参数才被当作对象文件，遇到 `-` 开头的就停。写成
`-link --lto a.o b.o` 会让 `--lto` 截断收集，报
`--lto needs at least one object file`。

```bash
arkcc --lto -link a.o b.o -O2 -o app.bin     # 对
arkcc -link a.o b.o --lto -O2 -o app.bin     # 也对（放在对象之后）
arkcc -link --lto a.o b.o -O2 -o app.bin     # 错：--lto 之后没有对象
```

其余选项（`-target` / `--cpu` / `-O` / `--const-global` / `-S` / `-o`）与普通编译
同义；`-S` 时输出汇编，否则出镜像。

## 5. 拒绝与诊断

**宁可报错，不给错答案**：链接期少合并一个单元，产出的就是"能跑但少一半代码"的
镜像，这比链接失败危险得多。所以载荷缺失、损坏、版本不符，一律具名报错，且**不写
输出文件**。

`--lto` 拒绝：

| 组合 | 消息 |
| --- | --- |
| `-c` | `--lto cannot be combined with -c: --lto generates code from IR and writes a program` |
| `-E` | `--lto cannot be combined with -E: an object is already preprocessed` |
| `-g` | `--lto cannot be combined with -g: a merged program has one source_file, so every unit's lines would be labelled with the first object's name` |
| 缺 `-o` | `--lto cannot be combined with no -o: with several objects there is no single name to derive the output from` |
| 没有输入 | `--lto needs at least one object file` |

`-c --obj-ir` 拒绝：

| 输入 | 消息 |
| --- | --- |
| `.s` 汇编输入 | `--obj-ir needs a C source: an assembly input has no IR` |
| `-target c` 等文本后端 | `--obj-ir needs an object backend (arm/x86/x86_64/riscv32): the 'c' backend writes text, not a linkable object` |

载荷层面的诊断（都带文件名）：

```
cannot stat object: ...
object is <N> bytes but this arkcc reads at most <M>; raise ARK_LINK_BUF_SIZE and rebuild arkcc
only <N> of <M> bytes could be read; raise ARK_LINK_BUF_SIZE and rebuild arkcc
not an ARKOBJ2 object; --lto reads the objects produced by `-c --obj-ir`
this object carries no IR payload, so -link --lto cannot use it; rebuild it with -c --obj-ir
not an IR payload                  （魔数不对）
IR payload is version <N> but this arkcc reads version 1
payload length does not match the file
```

裁剪构建（`-DARKCC_FEATURE_OBJ_IR=0`）里两个选项都在，且都以"未编入此构建"拒绝，
不会退化成"认不出选项"让人去找拼写错误：

```
Fatal error: C3900U: --obj-ir is not compiled into this build (rebuild with -DARKCC_FEATURE_OBJ_IR=1)
Fatal error: C3900U: --lto is not compiled into this build (rebuild with -DARKCC_FEATURE_IPO=1 -DARKCC_FEATURE_OBJ_IR=1)
```

## 6. 不做的事

- **不是链接器内 LTO**：没有 `-r` 部分链接，没有"对象里存机器码 + IR 两条路各走
  一半"，也没有跨语言（汇编对象）的参与——`--lto` 只吃 `-c --obj-ir` 产出的对象，
  混进一个汇编对象会以"没有 IR 载荷"被具名拒绝。
- **不做版本兼容策略**：版本号校验是硬相等。0.8.7 的对象只能被 0.8.7 的 `--lto`
  读；格式一改就把版本 +1，旧对象被具名拒绝而不是"尽力解析"。
- **不做符号表合并**：`--lto` 不读对象的符号表/重定位表来仲裁，它从 IR 重新出码，
  外部符号的裁定走 IR 层（`ipo_dedupe_*`）。这也是为什么 `-c --lto` 没有意义。
- **不做增量 / 缓存**：每次 `--lto` 都从头跑一遍管线。对 MCU 尺寸的程序这是
  几百毫秒的事，缓存只会引入"什么时候失效"的第二个问题。
- **载荷不压缩、不裁剪**：序列化的是全量 IR（含未使用的 `static`），剪枝发生在
  读回来之后。先压后解会引入第二个 bug 面，而省下的是几 KB。

## 7. 门禁（`tests/run_objir_tests.py`）

`make test-objir`。二十六项检查：

| 组 | 检查 | 为什么这一项能失败 |
| --- | --- | --- |
| 载荷写入 | `-c --obj-ir` 的对象里有 `ARKIR1\n` | 钩子没接、或序列化被裁掉 |
| 前缀不变 | 带载荷对象的前 N 字节与不带载荷**逐字节相同** | 载荷写到了前面、或改动了既有布局 |
| 参考系 | `--ipo` 的 `-S` 里 `main` 体没有 `BL one`、有 `MOV r0, #100` | 参考系本身没跨文件内联/没折常量，后面的"相同"就是空相等 |
| 逐字节对拍 | `--lto` 与 `--ipo` 的 `.s` 相同 | 池 remap 错、行号泄漏、`static` 改名不一致 |
| 动态 | 合并后的镜像返回 102（`1*2+100`） | 错折、错链、错池索引都能让这个数变 |
| 镜像对拍 | `--lto` 与 `--ipo` 的 `-o bin` 相同 | 向量表保留、初始化表顺序任一错位都会变红 |
| 同名 static | 两个对象的同名 `helper` 经载荷仍是 `__ipo1f_helper` / `__ipo2f_helper`，两臂文本相同 | 合并时没做单元改名，或改名在往返中丢失 |
| 动态 | 那个程序返回 79（`7*10+9`） | 若两个 `helper` 被并成一个，答案会变成 70 或 90 |
| 无 main | 两个不含 `main` 的单元合并结果与 `--ipo` 相同 | 合并逻辑偷偷依赖程序入口 |
| 载荷定位 | 能在对象里找到载荷头 | 搜索逻辑写死偏移 |
| 损坏 ×4 | 截断 / 魔数 / 版本 99 / 正文长度 +64：各报具名错误且**不产出文件** | 任何一条"尽力解析"都会静默产出错镜像 |
| 无载荷对象 | 被 `--lto` 具名拒绝（`no IR payload`） | 静默丢一个单元 = 错答案 |
| 源文件当对象 | 被拒为 `not an ARKOBJ2 object` | 魔数校验被绕过 |
| 不干扰 | plain `-link` 对"带载荷/不带载荷"对象产出**同一镜像** | 老读者读到了载荷区 |
| 选项拒绝 ×4 | `-c` / `-E` / 缺 `-o` / 无输入 | 任一缺失就是静默的错语义 |
| `--obj-ir` 拒绝 ×2 | 汇编输入 / 文本后端 | 产出一个永远用不上的对象 |
| 裁剪构建 | `-DARKCC_FEATURE_OBJ_IR=0` 拒绝两选项 | 裁剪藏了一个空实现 |
| 默认关零变化 | 全量构建与裁剪构建对 `examples/*.c` 的 `-c` 对象**逐字节相同** | 默认关时必须连一个字节都不变（compared=5, diff=0） |

`-g` 也拒绝（理由见 §5 表格），门禁没有单列，因为它与 `-c` / `-E` 走同一条
`lto_refuse()`。

`--lto` 与 `--ipo` 两项对拍（`-S` 与 `-o bin`）是这个功能唯一的正确性定义：只要能
做到"结果一样"，中间怎么实现都可以；做不到，就是没做完。

## 8. 在 STM32 上跑

`ARKCC_FEATURE_OBJ_IR` 在 `ARKCC_PROFILE_STM32_MIN` 下默认 `0`：板上编译器不缺
序列化代码，缺的是 RAM。打开它需要的缓冲是 `ARK_LINK_BUF_SIZE`（宿主 64 MB）——
板上要把这个常量降到与可用 RAM 匹配，见 [STM32_BUILD.md](STM32_BUILD.md)。

实际做法通常是：**板上只做 `-c`，链接期重编放在主机**。也就是板上 `--obj-ir`
产出带载荷的对象，主机 `--lto` 合并出镜像。这样板上不需要付出第二次管线的时间。
