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
    int enable_opt_bitmask;         /* -fopt-bitmask: MOV#imm+MVN+AND 折成 BIC，MOV 折成 MVN 立即数 */
    int enable_opt_imm;             /* -fopt-imm: 常量操作数折进指令立即数 */
    int enable_opt_peep;            /* -fopt-peep: 消除经栈的寄存器拷贝与回读 */
    int enable_opt_cbranch;         /* -fopt-cbranch: 比较结果直接喂给条件跳转 */
    int enable_opt_pair;            /* -fopt-pair: 两个紧推 push 与二元运算合并，不走值栈 */
    int enable_opt_prop;            /* -fopt-prop: 局部槽常量传播，把载回读成立即数 */
    int enable_opt_deadpush;        /* -fopt-deadpush: 删掉紧跟 IR_POP 的单字压栈（赋值读回） */
    int enable_opt_boolmat;         /* -fopt-boolmat: 删掉单字 STORE v ; PUSH_VAR v 往返（布尔物化后被测试） */
    int enable_opt_cmat;            /* -fopt-cmat: 常量二次材料化清理（立即数与索引折叠、死中性写） */
    int enable_opt_slotreg;         /* -fopt-slotreg: 块内冗余帧读与死帧写的删除 */
    int enable_opt_vreg;            /* -fopt-vreg: 槽提升到 r8-r11（改名消除，S6a） */
    int enable_opt_frame;           /* -fopt-frame: 帧保存表裁剪（删未用 callee-saved 槽与空帧） */
    int enable_opt_voldmb;          /* -fopt-voldmb: 非取址 volatile 局部量的 DMB SY 对省略 */
    int enable_opt_constcond;       /* -fopt-constcond: fold a literal condition + branch */
    int enable_opt_exit;            /* -fopt-exit: 删掉退出路径上写回原值的帧维护（MOV sp,base / MOV base,sp） */
    int enable_opt_volbar;          /* -fopt-volbar: 帧外 volatile 访存（成员/全局/指针）也发 DMB SY 对 */
    int enable_opt_constcache;      /* -fopt-constcache: 函数级 32 位常量缓存（callee-saved） */
    int enable_opt_litpool;         /* -fopt-litpool: 32 位常量放进函数尾的字面量池 */
    int enable_opt_copyprop;        /* -fopt-copyprop: 删死拷贝、把拷贝推进到消费者 */
    int enable_opt_live;            /* -fopt-live: 用 CFG+活跃性删只活跃性看得见的拷贝 */
    int enable_opt_coalesce;        /* -fopt-coalesce: 本地拷贝合并（MOV rD,rS 重命名为 rS 并删掉） */
    int enable_opt_spill;           /* -fopt-spill: 删跨块的栈往返（各臂 PUSH、汇合点 POP 的同一寄存器） */
    int enable_opt_ldhoist;         /* -fopt-ldhoist: 同一地址的重复装载提升到专用寄存器（S12-1） */
    int enable_opt_stackframe;      /* -fopt-stackframe: 删帧基址 MOV r6,sp/MOV sp,r6，改走 sp（S13） */
    int enable_opt_deadins;         /* -fopt-deadins: 删块内死写与死标志 CMP（S13） */
    int enable_opt_ladderload;      /* -fopt-ladderload: 删比较阶梯内重复的 LDR Rb,[Rn,#0]（S15） */
    int enable_opt_ladderstage;     /* -fopt-ladderstage: 删 BNE 前被覆盖的死装配 MOV（S15） */
    int enable_opt_birthdest;       /* -fopt-birthdest: 结果直接生在目的寄存器（OP r0…/MOV rD,r0 合并，S16） */
    int enable_opt_basefold;        /* -fopt-basefold: 基址折进寻址方式（ADD rB,rX,#i + 唯一访存，S16） */
    int enable_opt_chainfold;       /* -fopt-chainfold: 相邻同值比较段折叠（S17） */
    int enable_opt_pushpop;        /* -fopt-pushpop: 值栈往返消除（S19-a） */
    int enable_opt_addrfold;       /* -fopt-addrfold: 地址链折叠（S20） */
    int enable_opt_remat;          /* -fopt-remat: 同值重物化消除（S21） */
    int enable_opt_vregemit;       /* -fopt-vregemit: 虚拟寄存器发射路径（V-5） */
    int enable_opt_alloc;          /* -fopt-alloc: CFG 分配器发射路径（V-4' 阶段 A） */
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
/* The last -fopt-* / -fno-opt-* spelling that matched no pass, or 0 if every
 * one did.  The driver refuses such a name by itself: -fopt-* is our own
 * family, so an unknown name in it is a misspelling. */
const char *config_unknown_fopt(void);

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
