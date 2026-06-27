/* Ark C Compiler - compiler.h */
#ifndef ARK_COMPILER_H
#define ARK_COMPILER_H

#include "common.h"

typedef struct {
    const char *input_path;
    const char *output_path;  /* NULL = 推导默认 */
    int         emit_asm;     /* -S */
    int         verbose;
    const char *target;       /* -target <name>；NULL = 默认 */
    const char *include_dirs[16];
    int         include_dir_count;
    int         list_backends;
    /* === 0.3.0 扩展 === */
    int         compile_only;     /* -c 仅生成对象文件 */
    int         preprocess_only;  /* -E 仅输出预处理结果 */
    int         link_mode;        /* -link 链接多个对象 */
    const char *link_inputs[32];  /* -link 输入 */
    int         link_input_count;
    int         opt_level;        /* -O0/-O1/-O2，目前接受但忽略 */
    int         debug_info;       /* -g 接受但忽略 */
    int         no_unused_warn;   /* -Wno-unused */
} ArkOptions;

int ark_compile(const ArkOptions *opts);
int ark_compile_and_run(const char *path);

#endif /* ARK_COMPILER_H */
