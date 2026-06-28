/* Ark C Compiler - opt.h
 * IR 级优化 Pass：常量折叠、死代码消除。
 *
 * 运行时机：irgen 完成后、后端代码生成前。
 * 守护：
 *   - 编译期 #if ARKCC_FEATURE_OPT_CONSTFOLD / ARKCC_FEATURE_OPT_DCE
 *   - 运行时 g_config.enable_opt_constfold / g_config.enable_opt_dce / opt_level
 */
#ifndef ARK_OPT_H
#define ARK_OPT_H

#include "ir.h"

/* 对整个 IR 程序运行优化。
 * level: 0=不优化, 1=基础(常量折叠+DCE), 2=激进(目前同 1)。
 * 各 pass 内部再按 g_config.enable_opt_xxx 二次守护。 */
void opt_run(IrProgram *prog, int level);

/* 单函数常量折叠：折叠 PUSH_INT + PUSH_INT + BINARY 模式。 */
void opt_constfold_func(IrFunc *f);

/* 单函数死代码消除：删除 RETURN/JMP 之后、下一个标签之前的不可达指令。 */
void opt_dce_func(IrFunc *f);

/* 自动内联：将小函数体内联到调用点。
 * 阈值：IR 指令数 ≤ ARK_INLINE_THRESHOLD（默认12）。
 * 排除：递归、变参、irq、naked、asm_func、>4参数。 */
void opt_inline(IrProgram *prog);

/* 自动向量化：识别简单计数循环（a[i]=b[i]±c[i]），用 SIMD 指令并行处理。
 * 仅在 ARM 后端真正加速；C 后端做标量回退。 */
void opt_vectorize(IrProgram *prog);

#endif /* ARK_OPT_H */
