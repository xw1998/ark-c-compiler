/* Ark C Compiler - arkcc_config.h
 * 编译期特性开关：决定 arkcc 自身编译进哪些功能。
 * 运行时通过 g_config.enable_xxx 在编译用户代码时进一步守护。
 */
#ifndef ARKCC_CONFIG_H
#define ARKCC_CONFIG_H

/* ===== 编译期特性开关（决定 arkcc 自身编译进哪些功能）===== */

/* 前端语言特性 */
#define ARKCC_FEATURE_VLA          1   /* 变长数组 int a[n] */
#define ARKCC_FEATURE_COMPLEX      1   /* _Complex 复数 */
#define ARKCC_FEATURE_WCHAR        1   /* 宽字符 wchar_t / L"..." */
#define ARKCC_FEATURE_TRIGRAPH     1   /* 三元组 ??= 等 */

/* 后端代码生成 */
#define ARKCC_FEATURE_FPU_HW       1   /* 硬件 FPU 指令（VFP） */
#define ARKCC_FEATURE_DWARF        1   /* DWARF 调试信息 */

/* 优化 Pass */
#define ARKCC_FEATURE_OPT_CONSTFOLD 1  /* 常量折叠 */
#define ARKCC_FEATURE_OPT_DCE       1  /* 死代码消除 */
#define ARKCC_FEATURE_OPT_REGALLOC  0  /* 寄存器分配（实验性，默认关） */
#define ARKCC_FEATURE_OPT_INLINE    1  /* 自动函数内联 */
#define ARKCC_FEATURE_OPT_VECTORIZE 1  /* 自动向量化 */

/* armcc 兼容（默认全开，可裁切） */
#define ARKCC_FEATURE_ARMCC_ASM_FUNC  1  /* __asm 函数体 */
#define ARKCC_FEATURE_ARMCC_PRAGMA    1  /* #pragma 兼容 */
#define ARKCC_FEATURE_ARMCC_KEYWORDS  1  /* __irq/__weak/__naked 等 */
#define ARKCC_FEATURE_ENUM_IS_INT     1  /* --enum_is_int / -fenum-is-int */
#define ARKCC_FEATURE_SCATTER         1  /* scatter 加载描述文件解析 */
#define ARKCC_FEATURE_DWARF_FULL      1  /* 完整 .debug_info/.debug_abbrev/.debug_line */

#endif /* ARKCC_CONFIG_H */
