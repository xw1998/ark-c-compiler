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

/* 公开的宏定义/取消接口：供 cpu.c 等模块在 preproc_process 之前注入
 * CPU 相关预定义宏。同名旧宏会被覆盖。 */
void preproc_define(const char *name, const char *body);
void preproc_undef(const char *name);

/* 输入原始源代码，输出展开后的字符串（来自内存池）。 */
char *preproc_process(const char *src);

/* 依赖文件生成：返回预处理过程中 #include 过的文件路径列表。
 * out 数组由调用方提供，最多 max_count 项；返回实际填入的项数。
 * 路径来自 preproc 内部的 include 跟踪，包含相对/绝对路径原样。 */
int preproc_get_included_files(const char **out, int max_count);

#endif /* ARK_PREPROC_H */
