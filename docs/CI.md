# CI（持续集成）

本仓库有两条流水线配置，做的事情完全一样：**用宿主 gcc 构建 arkcc，然后跑 `make test`**。

| 文件 | 平台 | 状态 |
| --- | --- | --- |
| `.workflow/main-pipeline.yml` | Gitee Go（仓库主线在 Gitee，**这是真正会跑的那条**） | 按 Gitee Go 官方 schema 编写；需要在仓库「服务 → Gitee Go」里启用，第一次跑通才算验证过 |
| `.github/workflows/ci.yml` | GitHub Actions（`ubuntu-latest`） | 只在仓库被镜像到 GitHub 时才会跑；语法为标准 workflows 格式 |

两条都只依赖 `gcc` + `make` + `python3` + pip 包 `unicorn`，不需要任何交叉工具链或硬件。

---

## 1 流水线做什么

```
gcc --version && make --version && python3 --version     # 打印实测版本
python3 -m pip install unicorn                           # 唯一的外部依赖
python3 -c "import unicorn; print(unicorn.__version__)"   # 装上没有，直接读出来
make CC=gcc                                              # 构建 arkcc
./arkcc --list-backends                                  # 五个后端都在？
make test PYTHON=python3                                 # 全部门禁
```

`--list-backends` 之后 GitHub 那份还额外断言：`arm`/`x86`/`x86_64`/`riscv32`/`c` 五行齐全、
`x86_64` 报的是 `x86_64-unknown-linux-gnu`（不是 i386 的 triple）、`-target x86-64` 这个带连字符的
拼法能解析到同一个真后端。这些是 `run_tests_x86.ps1` 里 3b 段的 Linux 等价物，因为 PS1 在 CI 里跑不了。

`tools/install.py --dry-run` 在 GitHub 那份里单独跑一步并断言目标目录没被创建——`make test` 里的
install 门禁已经覆盖它，这一步只是让"CI 里 install 只打不写"这条契约有一个独立的、看得见的步骤。

---

## 2 `make test` 在 CI 里覆盖什么

| 目标 | 做的事 | 依赖 |
| --- | --- | --- |
| `test-arm` | `examples/{hello,arith,func}.c` 用 `-target arm -S` 发射汇编 | 只要 arkcc |
| `test-c` | 同上，走 C 后端，产物是 `*.gen.c` | 只要 arkcc |
| `test-x86` | 同上，`-target x86`（i386 cdecl，只到 emit 这一层） | 只要 arkcc |
| `test-riscv` | 同上，`-target riscv32` | 只要 arkcc |
| `test-stdlib` | 标准库 21 个用例：编译 → 多对象链接 → 在 unicorn 的 ARM M 核上**真跑** `main()` | unicorn |
| `test-install` | `make install` 到临时 DESTDIR；逐字节比对、二次跑不改 mtime、`--dry-run` 不写盘、绝对 PREFIX+DESTDIR 被拒；再拿**装出来的那棵树**建一个程序跑出 181 | unicorn |
| `test-reloc-text` | 两个对象被搬到离编译基址 0x1C070000 远处，字符串字面量必须仍指向自己；关掉 `--reloc-text` 必须回到旧（错）地址 | 只要 arkcc |
| `test-x86-64` | 16 个程序编成 0x400000 平铺镜像、在 unicorn 64 位核上跑 `main`，逐例断言程序外算出的常量；含"未解析符号必须拒绝且不留镜像"与"期望值 +1 必须判 DIFF"两段自检 | unicorn |

前四个是**冒烟**（"还能编"），后四个是**执行级**（"真的算对了"）。把 x86 / riscv32 的冒烟也挂进
`make test` 是为了让"某个后端被改坏"不能藏在别的后端的门禁后面。

---

## 3 为此改掉的一处不可移植写法

`test-arm` / `test-x86` / `test-riscv` 原来都写 `-S -o nul`。`nul` 是 Windows 的设备名，
在 Linux 上它会被当成**普通文件名**，于是 `make test` 在 CI 里会在仓库根目录写出一个叫 `nul` 的文件，
而"只发射不落盘"的原意消失。现在 Makefile 顶部按平台给变量：

```make
ifeq ($(OS),Windows_NT)
NULLDEV := nul
else
NULLDEV := /dev/null
endif
```

九处 `-o nul` 全部改成 `-o $(NULLDEV)`。Windows 上行为逐字节不变（仍是 `nul`），Linux 上是 `/dev/null`。

---

## 4 CI 里**不**跑什么，以及为什么

| 不跑的东西 | 原因 |
| --- | --- |
| `run_full_test.ps1`、`run_tests_x86.ps1`、`run_link_test.ps1`、`run_asm_test.ps1`、`examples/run_tests.ps1` | 全部是 PowerShell 脚本，Windows 专用；CI 跑 Linux 容器。它们在开发机上仍然是主力门禁，覆盖面见 `docs/MANUAL.md` §6 |
| `examples/run_va_gate.py`、`run_c11_keywords_tests.py`、`run_arm_int64_tests.py`、`run_arm_abi_mix_tests.py`、`run_rv_*_tests.py`、`asm_cases/run_asm_cmp.py` | 需要 `arm-none-eabi-as` / `riscv32-unknown-elf-gcc` / `libgcc.a` 这些交叉工具链；装它们要几百 MB 且版本敏感。脚本本身在缺工具链时会打印原因并 `exit 2`，不会假通过 |
| `tests/arm_exec/run_arm_exec.py`（QEMU 臂）、`run_arm_exec_test.ps1` | 需要 `qemu-system-arm`；unicorn 版本的同一批执行级用例已经在 `make test` 里（`test-stdlib`） |
| `tests/run_diag_tests.py` | 需要**真实 armcc 5.06** 的输出来逐字节对拍，装不上也授权不了 |
| `make stm32` | 需要 `arm-none-eabi-gcc` |
| 板载自托管（H743 上编译、在板上跑） | 需要硬件在环。这是本仓库最有价值也最不可能进云 CI 的一条链，只能在本机跑 |

原则没变：**缺少的东西必须显式说出来**。门禁脚本自己负责打印 `SKIP: <实测原因>`，流水线配置不负责
把缺依赖变成绿灯，也不使用 `|| true` / `continue-on-error` 之类的写法掩盖失败。

---

## 5 本地复现（Linux / macOS）

```sh
sudo apt-get install -y gcc make python3 python3-pip     # Debian/Ubuntu
python3 -m pip install unicorn
make CC=gcc
make test PYTHON=python3
```

开发机（Windows / Git Bash）上的等价命令：

```sh
export PATH="/d/mingw/MinGW/bin:$PATH"
make test PYTHON="C:/Users/<you>/AppData/Local/Programs/Python/Python310/python.exe"
```

> 注意：Windows 上 PATH 里的第一个 `python` 可能是某个 IDE 自带的旧解释器（会报
> `f-string: unmatched '('`）。要么用 `PYTHON=` 显式指定，要么用 `env -u PYTHONPATH -u PYTHONHOME`
> 起一份干净环境。

---

## 6 怎么看结果

- 退出码 0 且没有 `FAIL`：全部通过。
- `SKIP: ...` 出现在输出里不是失败：它是门禁脚本在**实测到缺什么**之后主动放弃某个用例，并打印原因
  （例如宿主 emulator 没有双精度 FPU，`strtod` 一例 SKIP）。
- `EXPECTED-FAIL`：仅出现在 PowerShell 门禁里（`run_full_test.ps1` / `examples/run_tests.ps1`），
  表示某个样例的失败是**设计决定**且诊断文本已被校验过（目前只有 `c99_armcc5_compat_test` 因
  `errno` 的存储定义在另一个编译单元而被单对象镜像拒绝）。CI 这条链上没有 `EXPECTED-FAIL`。
