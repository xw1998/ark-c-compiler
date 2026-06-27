/* Ark C Compiler - preproc.h
 * 预处理器：对象宏 + 函数宏 + 条件编译 + #include 嵌套。
 *
 * 工作目录搜索顺序：当前文件目录 -> 自定义 -I 路径 -> 内置 stdlib/include。
 */
#ifndef ARK_PREPROC_H
#define ARK_PREPROC_H

#include "common.h"

/* 添加额外搜索路径（每次编译开始前 reset）。 */
void preproc_reset(void);
void preproc_add_include_dir(const char *dir);
void preproc_set_main_file(const char *path);

/* 输入原始源代码，输出展开后的字符串（来自内存池）。 */
char *preproc_process(const char *src);

#endif /* ARK_PREPROC_H */
