/* Ark C Compiler - config.h
 * Runtime config: stores switch states read from config file or command line.
 * Priority: command line > config file > compile-time defaults (ARKCC_FEATURE_*)
 */
#ifndef ARK_CONFIG_H
#define ARK_CONFIG_H

#include "arkcc_config.h"

typedef struct {
    /* Runtime switches (config file may override compile-time defaults) */
    int enable_vla;
    int enable_complex;
    int enable_wchar;
    int enable_trigraph;
    int enable_fpu_hw;
    int enable_dwarf;
    int enable_opt_constfold;
    int enable_opt_dce;
    int enable_opt_regalloc;
    int enable_opt_regalloc_near;   /* -fopt-regalloc-near: 近槽也搬（每函数 +4 字节） */
    int enable_opt_vstack;          /* -fopt-vstack: 值栈留在 r5/r7，不落内存 */
    int enable_opt_addr;            /* -fopt-addr: 把地址运算折进寻址方式 */
    int enable_opt_strength;        /* -fopt-strength: 乘 2^k 换成左移 */
    int enable_opt_cbz;             /* -fopt-cbz: CMP #0 + 条件跳转 合成 CBZ/CBNZ */
    int enable_opt_branch;          /* -fopt-branch: 能放进 16 位范围的分支缩成短跳 */
    int enable_opt_imm;             /* -fopt-imm: 常量操作数折进指令立即数 */
    int enable_opt_peep;            /* -fopt-peep: 消除经栈的寄存器拷贝与回读 */
    int enable_opt_cbranch;         /* -fopt-cbranch: 比较结果直接喂给条件跳转 */
    int enable_opt_copyprop;        /* -fopt-copyprop: 删死拷贝、把拷贝推进到消费者 */
    int enable_opt_live;            /* -fopt-live: 用 CFG+活跃性删只活跃性看得见的拷贝 */
    int enable_opt_inline;   /* --autoinline / -O2 */
    int enable_opt_vectorize;/* --vectorize / -O2 */
    int opt_level;          /* 0=none, 1=basic, 2=aggressive */
    int debug_info;         /* 0=none, 1=DWARF */
    int split_sections;     /* -ffunction-sections: one section per function */
    const char *config_file; /* config file path */
    /* === 0.6.x additions: armcc 5 compatibility runtime switches === */
    int enum_is_int;          /* --enum_is_int / -fenum-is-int: force enum to int */
    int dollar_in_identifiers;/* --dollar: $ as identifier character */
    int signed_chars;         /* --signed_chars: char defaults to signed */
    int unsigned_chars;       /* --unsigned_chars: char defaults to unsigned */
    int wchar16;              /* --wchar16: wchar_t is 16-bit */
    int wchar32;              /* --wchar32: wchar_t is 32-bit */
    int dwarf_version;        /* --dwarf2=2 / --dwarf3=3; 0=default */
    const char *scatter_file; /* --scatter <file>: scatter load description file */
    const char *linker_script;/* -T/--linker-script <file>: GNU ld script (converted to scatter internally) */
    const char *fpu_type;     /* --fpu <name>: FPU type name */
    /* === 0.8.0: 由 --xxx 显式打开的实验性开关 === */
    int enable_dce_cfg;       /* --dce-cfg: 基本块级可达性 DCE */
    int enable_reloc_data;    /* --reloc-data: 多目标文件的数据段可搬迁 */
    int enable_reloc_text;    /* --reloc-text: 段内绝对地址交给链接器修正 */
    int enable_reg_top;       /* --reg-top: 栈顶值常驻 r0 */
    int enable_rt_lazy;       /* --rt-lazy: 只发射被用到的 __aeabi_* 运行库 */
    int enable_asm_extra;     /* --asm-extra: 汇编器扩展指令集 */
    int enable_memlint;       /* --warn-mem: 返回局部地址 / double free / UAF 检查 */
    int enable_enumcheck;     /* --warn-enum: switch on an enum that misses an enumerator */
    int enable_unused_result; /* 0.8.6 --warn-unused-result: discarded value of an annotated call */
    /* 0.8.6 MIR checks (include/mir.h). All three read the same two graphs and
     * only print warnings; enabling them cannot change the image. */
    int enable_warn_unreachable;   /* --warn-unreachable: block with no path from the entry */
    int enable_warn_unused_static; /* --warn-unused-static: static function nothing can reach */
    int enable_warn_recursion;     /* --warn-recursion: call cycle among the unit's functions */
    int enable_licm;               /* --licm: move loop-invariant computations out of the loop */
    int enable_unroll;             /* --unroll: completely unroll a counted for-loop */
    int enable_tailmerge;          /* --tailmerge: merge identical block tails (block-level cross-jump) */
    int enable_xblock;             /* --xblock: merge identical whole blocks (cross-jump, whole form) */
    int enable_tailcall;           /* --tailcall: `return g(...)` with reg-only args becomes a branch */
    int enable_divconst;           /* --divconst: divide by a constant -> multiply + shift */
    int enable_const_global;       /* --const-global: fold loads of const objects to immediates */
#if ARKCC_FEATURE_SIZEWEIGHT
    /* 0.9.1 --size-weight=N (0..9): 连续地调四个门槛，5 = 历史常量。
     * 只在宿主优化 pass 存在时编进来，见 include/arkcc_config.h。 */
    int size_weight;
#endif
    /* 0.8.5: 可配置 Pass 管线（见 include/pipeline.h）。取 ARK_PROFILE_FULL 时
     * 每个 pass 仍由自己的开关与 -O 级别决定，即历史行为、产物逐字节不变；
     * 取 ARK_PROFILE_LITE 时只允许 min_profile 为 lite 的阶段跑，其余阶段
     * 被跳过并留下理由（--print-pipeline 可读）。 */
    int pipeline_profile;
} ArkccConfig;

extern ArkccConfig g_config;

/* Initialize g_config with compile-time defaults from ARKCC_FEATURE_* macros */
void config_init(void);
/* Parse arkcc.cfg (INI format, key=value under [features]/[general] sections) */
void config_load_file(const char *path);
/* Parse command-line -O0/-O1/-O2/-g/-fxxx/-fno-xxx etc.
 * Recognizes only config-related args and updates g_config; leaves other argv entries untouched.
 * argc/argv are taken directly from main. */
void config_apply_args(int argc, char **argv);
/* Debug print of current g_config contents (to stderr) */
void config_print(void);

#if ARKCC_FEATURE_SIZEWEIGHT
/* 0.9.1 --size-weight: 四个门槛作为 g_config.size_weight 的函数。
 * 每张表的下标 5 都是历史常量（12 / 8 / 3 / 4），所以从不写 --size-weight 的
 * 构建产物与 0.9.0 逐字节相同。
 * 两个分支都必须能解析四处调用点：四个 pass 的代码不按开关裁，只是不注册到
 * 管线里（见 src/pipeline.c）；裁剪构建用宏退回历史常量，不留任何符号。 */
int ark_inline_threshold(void);
int ark_unroll_max(void);
int ark_tailmerge_min_len(void);
int ark_xblock_min_len(void);
#else
/* 四个 pass 被裁掉的构建（STM32_MIN，或显式 -DARKCC_FEATURE_OPT_INLINE=0 等）：
 * pass 的代码仍然要编译（只是不进阶段表），所以这四处调用仍要能解析。这里用
 * 宏退回历史常量而不是函数——宏不留下任何符号，板端体积因此零变化。 */
# define ark_inline_threshold()   12
# define ark_unroll_max()         8
# define ark_tailmerge_min_len()  3
# define ark_xblock_min_len()     4
#endif

#endif /* ARK_CONFIG_H */
