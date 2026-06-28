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
    const char *config_file; /* 配置文件路径 */
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
