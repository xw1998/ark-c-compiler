# 部分链接（`-r`）：把多个 ARKOBJ2 对象合并成一个对象

[English](PARTIAL_LINK.en.md) | 中文

`-r` 是 `-link` 的修饰符。它读 N 个 `ARKOBJ2` 对象，把**机器码、符号表、重定位表**
各合并一份，写出**一个新的 `ARKOBJ2` 对象**——不是镜像，不带向量表，不落地址布局。

```bash
arkcc -c -target arm --cpu Cortex-M7 -O2 a.c -o a.o
arkcc -c -target arm --cpu Cortex-M7 -O2 b.c -o b.o
arkcc -r -link a.o b.o -o ab.o          # 合并成一个对象
arkcc -link ab.o --vector-table -o app.bin
```

第二条命令的产物与 `arkcc -link a.o b.o --vector-table -o app.bin` **逐字节相同**——
门禁里有一条直接 `cmp` 这件事。这就是 `-r` 的全部价值：它必须是一个**可替换**的中间
步骤，而不是又一条会悄悄改变结果的路径。

| 开关 | 默认 | 剖面 | 说明 |
| --- | :---: | --- | --- |
| `-r` | 关 | `full` | 必须与 `-link` 同时出现；`-r` 写在 `-link` 前后都可以 |
| `ARKCC_FEATURE_PARTIAL_LINK` | 宿主 `1`，`ARKCC_PROFILE_STM32_MIN` 为 `0` | 裁剪开关 | 可在命令行 `-DARKCC_FEATURE_PARTIAL_LINK=0/1` 覆盖 |

---

## 1. 里谁作准：机器码

`-c --obj-ir` 编出的对象里同时有机器码和 IR 载荷（见 [OBJ_IR.md](OBJ_IR.md)）。
`-r` 合并的是**机器码**，不是 IR：

- 合并两份"管线之前"的 IR 需要发明第三种中间格式（两个 translation unit 的
  类型表/常量池/全局表怎么并），而且怎么并都会影响后续优化看到的东西；
- 机器码已经在对象里，合并它只是**改地址**，语义完全由重定位表定义。

代价是：合并后的对象**不能**再走 `-link --lto`（载荷没被继承）。这件事藏不住，
也不该藏——一个带 IR 载荷的对象送进 `-r` 会被**具名拒绝**：

```
error: -r merges machine code and cannot carry the IR payload this object
       holds; use -link --lto to recompile the units, or rebuild the object
       without --obj-ir
```

静默丢掉载荷会让"后面还能 LTO"变成假话，而发现它的时机是在链接期，离出错点很远。

## 2. 合并规则

### 2.1 代码

按命令行顺序**首尾相接**：

```
base(第 i 个) = 已放置字节数
```

`-v` 会逐对象打印 `[r] object 0: base 0x0, 1188 bytes`，方便对账。

`riscv32` 对象在**已经出现过 ISA 标签**之后按 16 字节对齐（与 `-link` 一致：它
是 PC 相对的，放哪都能跑，但保持 16 字节对齐才保住汇编期假设的段对齐）；
ARM 对象紧挨着放。

### 2.2 符号

| 对象里的符号类型 | `-r` 的处理 |
| --- | --- |
| 普通标签（type 0） | `offset += base`，重名走 strong/weak 规则（强定义冲突报错，weak 让位） |
| `OBJ_SYM_TYPE_DATA`（全局对象） | **地址不变**，只登记；不搬数据段 |
| `OBJ_SYM_TYPE_RAM`（`__arkcc_ram_start/end`） | **描述符原样保留**（一个对象最多带一对） |
| `OBJ_SYM_TYPE_TEXT`（`--reloc-text` 基址） | 记录；所有输入必须一致，否则拒绝 |
| `OBJ_SYM_TYPE_ISA`（`__arkcc_isa_riscv32`） | 记录；全部输入都带才输出，混用拒绝 |
| 未知类型 | 拒绝并打印数字类型 |

### 2.3 重定位

站点 `offset += base` 后原样进合并表；**类型不变**，由最终的 `-link` 解释。

唯一就地处理的是 `X86_RELOC_SELF_BASE`：它的站点里已经存着该对象自己的偏移，
只缺基址，而基址在 `-r` 里已经确定——就地加上 base 后丢弃该条重定位。这与
`-link` 的处理逐字一致，所以合并对象与直接链接得到同一批字节。

### 2.4 数据段

`-r` **不搬** `.data`/`.bss`。全局对象的 offset 就是它的绝对地址，原样进合并
对象；`--reloc-data` / `--reloc-text` 那套地址改写留给最终的 `-link`。

由此得到一条硬约束：**一次 `-r` 最多合并一个"拥有 RAM"的对象**（即带
`__arkcc_ram_start/end` 的对象）。两个都带时它们的绝对地址会重叠，而合并之后
`-link` 已经看不见"这是两坨数据"了。拒绝而不是猜。

## 3. 拒绝清单

每一项都是"看起来能出结果、其实结果没意义"的形态：

| 输入 | 结果 |
| --- | --- |
| 带 `--obj-ir` 载荷的对象 | 具名拒绝，提示 `-link --lto` |
| 两个及以上 RAM 拥有者 | 拒绝，提示合并翻译单元或每个部分链接只留一个 |
| riscv32 与非 riscv32 混用 | 拒绝（两者的重定位编号含义不同） |
| 不是 `ARKOBJ2` 的文件 | 拒绝 |
| 符号表/重定位表被截断 | 拒绝 |
| 表后有多余字节（且不是 IR 载荷） | 拒绝（对象已损坏） |
| 同名强定义地址不同 | 拒绝 |
| `--reloc-text` 基址不一致 | 拒绝 |
| 符号/重定位条目超限 | 拒绝，提示调 `ARK_LINK_MAX_SYMS` / `ARK_LINK_MAX_RELOCS` |

**任何一次拒绝都不写输出文件**——对象就是交付物，"报错 + 留下半个文件"比两者
单独出现都更糟，所以出错路径在写盘之前返回。

选项层面的校验（都在 `src/main.c`，全部是 `C3900U`）：

| 组合 | 结果 |
| --- | --- |
| `-r` 没有 `-link` | 拒绝 |
| `-r` 与 `--lto` 同时给 | 拒绝（一个是合并机器码，一个是重编 IR） |
| `-r` 与 `-c` / `-S` / `-E` / `-MMD` | 拒绝 |
| `-r` 没有 `-o` | 拒绝（多输入没有唯一派生名，默认名会让"对象叫 bin"成为新坑） |
| `-link` 后没有对象 | 拒绝 |
| 构建时 `-DARKCC_FEATURE_PARTIAL_LINK=0` | 拒绝并提示重新构建 |

## 4. `-r` 不做的事

- **不做符号裁剪**：未被引用的全局符号照样进对象，`--gc-sections` 之类的判断
  属于最终链接。
- **不继承 IR 载荷**（见 §1）。
- **不搬数据段**（见 §2.4）。
- **不生成向量表**：`--vector-table` 是镜像期的洞，`-r` 的输出是对象。
- **不做 ISA 转换**：混用直接拒绝。

## 5. 必须成立的性质

1. **可替换**：`-link (a.o b.o)` 与 `-link (-r a.o b.o)` 逐字节相同（门禁 `cmp`）。
2. **幂等**：`-r` 的输出再 `-r` 一次与直接 `-r` 相同。
3. **输入不变**：合并前后输入对象的 sha256 不变。
4. **对象仍是对象**：输出以 `ARKOBJ2\n` 开头，`code_len` = 各输入之和（RV 对齐
   填充除外），符号偏移落在新 code 范围内。
5. **可后补定义**：被引用的名字在合并对象里没有定义时，允许，后续 `-link` 再补；
   `-r` 不会凭空定义它。

## 6. 门禁

`tests/run_partiallink_tests.py`，27 项，接在 `make test` 的 `test-partiallink`
目标里：

```bash
make test-partiallink PYTHON=...python.exe      # 27 PASS / 0 FAIL / 0 SKIP
```

覆盖：合并与 code/符号/重定位 rebase、`g_init` 绝对地址不变、RAM 描述符保留、
合并对象与直接链接逐字节相同、模拟器实答 13、幂等、输入未被改写、无 `main`
可合并、同名 file-static 仍各答其值、跨对象后补定义（答 41）、载荷/双 RAM/
非对象/混 ISA/截断全部"非零退出且不写文件"、5 条选项校验、以及裁剪构建下
`-r` 被拒且 `-c`/`-link` 产物与全量构建逐字节相同。

## 7. 裁剪

`ARKCC_FEATURE_PARTIAL_LINK` 独立于 `ARKCC_FEATURE_OBJ_IR`：两者是不同功能，
不用就不该驻留。`ARKCC_PROFILE_STM32_MIN` 档默认 `0`，`ld_partial_link()` 整段
被 `#if` 包住，裁剪后既不占代码也没有符号；此时 `-r` 在参数解析期就报
`C3900U`，"编译进去了但行为不同"这种情形不存在。

裁剪证据：`-DARKCC_FEATURE_PARTIAL_LINK=0` 构建下 `-c` 与 `-link` 的产物与全量
构建**逐字节相同**（门禁最后一项）。
