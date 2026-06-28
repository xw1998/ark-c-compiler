/* Ark C Compiler - config.h
 * 运行时配置：存储从配置文件或命令行读取的开关状态。
 * 优先级：命令行 > 配置文件 > 编译期默认（ARKCC_FEATURE_*）
 */
#ifndef ARK_CONFIG_H
#define ARK_CONFIG_H

#include "arkcc_config.h"

typedef struct {
    /* 运行时开关（可在配置文件中覆盖编译期默认） */
    int enable_vla;
    int enable_complex;
    int enable_wchar;
    int enable_trigraph;
    int enable_fpu_hw;
    int enable_dwarf;
    int enable_opt_constfold;
    int enable_opt_dce;
    int enable_opt_regalloc;
    int opt_level;          /* 0=无优化, 1=基础, 2=激进 */
    int debug_info;         /* 0=无, 1=DWARF */
    int split_sections;     /* -ffunction-sections：每函数一段 */
    const char *config_file; /* 配置文件路径 */
    /* === 0.6.x 新增：armcc 5 兼容运行时开关 === */
    int enum_is_int;          /* --enum_is_int / -fenum-is-int：enum 强制为 int */
    int dollar_in_identifiers;/* --dollar：$ 作为标识符字符 */
    int signed_chars;         /* --signed_chars：char 默认带符号 */
    int unsigned_chars;       /* --unsigned_chars：char 默认无符号 */
    int wchar16;              /* --wchar16：wchar_t 为 16 位 */
    int wchar32;              /* --wchar32：wchar_t 为 32 位 */
    int dwarf_version;        /* --dwarf2=2 / --dwarf3=3；0=默认 */
    const char *scatter_file; /* --scatter <file>：scatter 加载描述文件 */
    const char *fpu_type;     /* --fpu <name>：FPU 类型名 */
} ArkccConfig;

extern ArkccConfig g_config;

/* 用 ARKCC_FEATURE_* 宏初始化 g_config 为编译期默认 */
void config_init(void);
/* 解析 arkcc.cfg（INI 格式，[features]/[general] 段下 key=value） */
void config_load_file(const char *path);
/* 解析命令行 -O0/-O1/-O2/-g/-fxxx/-fno-xxx 等。
 * 仅识别配置相关参数并更新 g_config；非配置参数不动 argv。
 * argc/argv 直接取自 main。 */
void config_apply_args(int argc, char **argv);
/* 调试打印当前 g_config 内容（到 stderr） */
void config_print(void);

#endif /* ARK_CONFIG_H */
