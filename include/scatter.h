/* Ark C Compiler - scatter.h
 * ARM 链接器 scatter 加载描述文件解析。
 * 支持 armlink scatter 语法的实用子集：
 *   LR_<name> <addr> [attrs] { ER_<name> <addr> [attrs] { <selectors> } ... }
 * 解析结果存入 ScatterDesc，供后端/链接阶段查询段放置策略。
 * arkcc 本身不链接，此模块主要用于校验 scatter 文件语法并记录区域，
 * 以便将来与外部链接器协作或生成对应链接脚本。
 */
#ifndef ARK_SCATTER_H
#define ARK_SCATTER_H

#define ARKCC_FEATURE_SCATTER 1

/* 执行区域（ER）：对应一段运行时地址空间，放置若干输入段选择器。 */
typedef struct ScatterExecRegion {
    char *name;            /* ER 名称 */
    unsigned load_addr;    /* 执行地址 */
    char *selectors;       /* 段选择器原文（如 "*.o (RO)"），简化为整段存储 */
    struct ScatterExecRegion *next;
} ScatterExecRegion;

/* 加载区域（LR）：对应一段加载地址空间，包含若干执行区域。 */
typedef struct ScatterLoadRegion {
    char *name;            /* LR 名称 */
    unsigned load_addr;    /* 加载地址 */
    ScatterExecRegion *exec_regions;  /* 执行区域链表 */
    struct ScatterLoadRegion *next;
} ScatterLoadRegion;

/* 整个 scatter 文件的解析结果。 */
typedef struct ScatterDesc {
    ScatterLoadRegion *load_regions;
    int error_count;
} ScatterDesc;

/* 解析 scatter 文件路径；返回 0 表示成功，非 0 表示出错。
 * 解析结果存入 *out（调用方提供指针）。多次调用会累加（不重置）。 */
int scatter_parse_file(const char *path, ScatterDesc *out);

/* 释放解析结果占用的内存池外资源（arkcc 多用内存池，此处仅清链表头）。 */
void scatter_free(ScatterDesc *desc);

/* 打印解析结果到日志（调试用）。 */
void scatter_dump(const ScatterDesc *desc);

#endif /* ARK_SCATTER_H */
