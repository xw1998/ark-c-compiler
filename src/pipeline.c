/* Ark C Compiler - pipeline.c
 * The stage tables and the single loop that executes them. See pipeline.h
 * for why the decision lives here instead of in opt_run()'s if-ladders.
 *
 * Ordering is the table order. It is not arbitrary:
 *   - memlint before enumcheck: both are AST lints, no interaction, but a
 *     fixed order keeps the diagnostic sequence reproducible (the gates
 *     compare text, and two runs that emit the same warnings in a different
 *     order would look like a regression).
 *   - the three MIR checks come first, before any optimisation touches the
 *     IR: they are lint, they must describe the source, and a fold that turns
 *     `if (0)` into a jump would otherwise decide what they say.
 *   - constfold before dce: dce removes instructions a fold made unreachable
 *     (e.g. the dead half of `if (0)`, or the arithmetic behind a constant
 *     comparison), so the other order leaves work behind.
 *   - dce-cfg after the linear dce: the cheap rule clears the obvious cases
 *     first, so the reachability build has less to walk.
 *   - inline before vectorize: inlining exposes the counted loops that the
 *     vectorizer recognises (`a[i]=b[i]+c[i]` where b/c are inlined).
 *   - inline is followed by a linear dce sweep: expansion leaves the dead
 *     tail of the callee body behind, which is exactly what that rule eats.
 */
#include "pipeline.h"
#include "platform.h"
#include "arkcc_config.h"
#include "config.h"
#include "opt.h"
#include "memlint.h"
#include "enumcheck.h"
#include "unusedresult.h"
#include "mirpass.h"

/* Names cost Flash on the board and nothing there ever prints them, so the
 * whole dump path (names included) is behind one switch. With it off the
 * table keeps its shape and the loop is identical; only the strings go. */
#if ARKCC_FEATURE_PIPELINE_DUMP
#  define PIPE_NAME(s) (s)
#else
#  define PIPE_NAME(s) ""
#endif

/* ------------------------------------------------------------------ */
/* AST stages                                                          */
/* ------------------------------------------------------------------ */

typedef struct {
    const char *name;
    int  min_profile;
    int  built_in;                 /* the pass is linked into this build */
    int  (*wanted)(void);          /* runtime request, e.g. --warn-mem */
    const char *flag_name;         /* how the dump names that request */
    int  (*fn)(AstNode *);
} AstStage;

#if ARKCC_FEATURE_MEMLINT
static int ast_wanted_memlint(void)   { return g_config.enable_memlint; }
#endif
#if ARKCC_FEATURE_ENUMCHECK
static int ast_wanted_enumcheck(void) { return g_config.enable_enumcheck; }
#endif
#if ARKCC_FEATURE_UNUSEDRESULT
static int ast_wanted_unusedresult(void) { return g_config.enable_unused_result; }
#endif

/* Lint stages are not optimizations, so they carry no -O gate: --warn-mem at
 * -O0 means what it says. They are marked LITE because they are the cheap
 * checks the MCU shape is allowed to keep. */
static const AstStage g_ast_stages[] = {
#if ARKCC_FEATURE_MEMLINT
    { PIPE_NAME("ast.memlint"),   ARK_PROFILE_LITE, 1, ast_wanted_memlint,   PIPE_NAME("off (--warn-mem)"),  memlint_run   },
#else
    { PIPE_NAME("ast.memlint"),   ARK_PROFILE_LITE, 0, 0,                   0,             0             },
#endif
#if ARKCC_FEATURE_ENUMCHECK
    { PIPE_NAME("ast.enumcheck"), ARK_PROFILE_LITE, 1, ast_wanted_enumcheck, PIPE_NAME("off (--warn-enum)"), enumcheck_run },
#else
    { PIPE_NAME("ast.enumcheck"), ARK_PROFILE_LITE, 0, 0,                   0,             0             },
#endif
#if ARKCC_FEATURE_UNUSEDRESULT
    { PIPE_NAME("ast.unusedresult"), ARK_PROFILE_LITE, 1, ast_wanted_unusedresult,
      PIPE_NAME("off (--warn-unused-result)"), unusedresult_run },
#else
    { PIPE_NAME("ast.unusedresult"), ARK_PROFILE_LITE, 0, 0,                0,             0             },
#endif
};
#define AST_STAGE_COUNT ((int)(sizeof(g_ast_stages) / sizeof(g_ast_stages[0])))

/* ------------------------------------------------------------------ */
/* IR stages                                                           */
/* ------------------------------------------------------------------ */

/* How a stage's own gate combines the -O level with its runtime flag.
 * The three shapes below are not a design; they are what each pass has
 * always done, written down. Changing any of them changes generated code,
 * so they are frozen here and covered by the gate. */
#define GATE_FLAG_AND_LEVEL 0   /* runs only when the flag is on AND level >= min_level */
#define GATE_FLAG_OR_LEVEL  1   /* runs when the flag is on, or level >= min_level      */

typedef struct {
    const char *name;
    int  min_profile;
    int  min_level;
    int  gate;
    int  built_in;                 /* #if result of the pass's feature macro */
    int  (*wanted)(void);
    const char *flag_name;
    int  scope;                    /* 0 = per function, 1 = whole program */
    int  cleanup_dce;              /* run linear DCE over every function afterwards */
    void (*fn_func)(IrFunc *);
    void (*fn_prog)(IrProgram *);
} IrStage;

/* The MIR checks are lint, not optimisation: they carry no -O gate (min_level 0)
 * and they run first, on the IR exactly as irgen produced it, so their report
 * describes the program the user wrote and does not move when -O moves. */
static int ir_wanted_unreachable(void)   { return g_config.enable_warn_unreachable; }
static int ir_wanted_unused_static(void) { return g_config.enable_warn_unused_static; }
static int ir_wanted_recursion(void)     { return g_config.enable_warn_recursion; }
static int ir_wanted_constfold(void)  { return g_config.enable_opt_constfold; }
static int ir_wanted_dce(void)        { return g_config.enable_opt_dce; }
static int ir_wanted_dce_cfg(void)    { return g_config.enable_dce_cfg; }
static int ir_wanted_inline(void)     { return g_config.enable_opt_inline; }
static int ir_wanted_vectorize(void)  { return g_config.enable_opt_vectorize; }
static int ir_wanted_licm(void)       { return g_config.enable_licm; }
static int ir_wanted_unroll(void)     { return g_config.enable_unroll; }
static int ir_wanted_tailmerge(void)  { return g_config.enable_tailmerge; }
static int ir_wanted_xblock(void)     { return g_config.enable_xblock; }
static int ir_wanted_strength(void)   { return g_config.enable_opt_strength; }
#if ARKCC_FEATURE_CONST_GLOBAL
static int ir_wanted_const_global(void) { return g_config.enable_const_global; }
/* opt_const_global reports how many loads it replaced; the table wants a void
 * entry point.  A file-static wrapper keeps that count off the program image
 * instead of parking it in a writable global nothing reads. */
static void ir_const_global_run(IrProgram *prog) { (void)opt_const_global(prog); }
#endif

/* The two min_level values of 1 and 2 are not free choices:
 *   - constfold / dce at -O0: folding changes -O0 codegen expectations
 *     (1+2 becomes 3, dead constant arithmetic disappears) and can fold
 *     undefined expressions such as 1/0 or 1<<40 to a wrong value.  -O0
 *     therefore runs neither, even though both are compiled in.
 *   - inline at -O1: expansion assumes stack-slot parameters, which the ARM
 *     backend only guarantees on the -O2 path; running it at -O0/-O1 used to
 *     produce an image that differed from the un-optimised one for no declared
 *     reason.  It is also the pass whose output size grows fastest, which is
 *     why --pipeline=lite drops it first. */
static const IrStage g_ir_stages[] = {
    /* <name>            <min_profile>     <lvl> <gate>                <built_in>
     *                   <wanted>            <flag name>                     <scope> <cleanup>
     *                   <fn_func>          <fn_prog> */
#if ARKCC_FEATURE_MIR
    { PIPE_NAME("ir.unreachable"),   ARK_PROFILE_LITE, 0, GATE_FLAG_AND_LEVEL, 1,
      ir_wanted_unreachable,   PIPE_NAME("off (--warn-unreachable)"),   0, 0, mirpass_unreachable,   0 },
    { PIPE_NAME("ir.unused-static"), ARK_PROFILE_LITE, 0, GATE_FLAG_AND_LEVEL, 1,
      ir_wanted_unused_static, PIPE_NAME("off (--warn-unused-static)"), 1, 0, 0, mirpass_unused_static },
    { PIPE_NAME("ir.recursion"),     ARK_PROFILE_LITE, 0, GATE_FLAG_AND_LEVEL, 1,
      ir_wanted_recursion,     PIPE_NAME("off (--warn-recursion)"),     1, 0, 0, mirpass_recursion },
#else
    { PIPE_NAME("ir.unreachable"),   ARK_PROFILE_LITE, 0, GATE_FLAG_AND_LEVEL, 0, 0, 0, 0, 0, 0, 0 },
    { PIPE_NAME("ir.unused-static"), ARK_PROFILE_LITE, 0, GATE_FLAG_AND_LEVEL, 0, 0, 0, 1, 0, 0, 0 },
    { PIPE_NAME("ir.recursion"),     ARK_PROFILE_LITE, 0, GATE_FLAG_AND_LEVEL, 0, 0, 0, 1, 0, 0, 0 },
#endif
    { PIPE_NAME("ir.constfold"), ARK_PROFILE_LITE, 1, GATE_FLAG_AND_LEVEL, ARKCC_FEATURE_OPT_CONSTFOLD,
      ir_wanted_constfold, PIPE_NAME("off (-fno-opt-constfold)"), 0, 0, opt_constfold_func, 0 },
    { PIPE_NAME("ir.dce"),       ARK_PROFILE_LITE, 1, GATE_FLAG_AND_LEVEL, ARKCC_FEATURE_OPT_DCE,
      ir_wanted_dce,       PIPE_NAME("off (-fno-opt-dce)"),       0, 0, opt_dce_func,       0 },
#if ARKCC_FEATURE_OPT_DCE_CFG
    { PIPE_NAME("ir.dce-cfg"),   ARK_PROFILE_FULL, 1, GATE_FLAG_AND_LEVEL, 1,
      ir_wanted_dce_cfg,   PIPE_NAME("off (--dce-cfg)"),          0, 0, opt_dce_cfg_func,   0 },
#else
    /* Not compiled in: the row must not name the function, or a trimmed build
     * (STM32_MIN) links with "Undefined symbol opt_dce_cfg_func".  The row is
     * kept so the pass list and its numbering are the same in every build. */
    { PIPE_NAME("ir.dce-cfg"),   ARK_PROFILE_FULL, 1, GATE_FLAG_AND_LEVEL, 0, 0, 0, 0, 0, 0, 0 },
#endif
    /* 循环优化放在 dce 之后、dce-cfg 之前：LICM 只搬东西不造死代码，展开会把
     * 循环头尾整个换掉，两者都与线性 DCE 无冲突；放在 dce-cfg 之前让后者顺手
     * 清掉展开后可能留下的不可达尾巴。两者都需要 -O1 以上（min_level 1），
     * 单给开关不给 -O 时在 dump 里明确写 "needs a higher -O level"。 */
#if ARKCC_FEATURE_LICM
    { PIPE_NAME("ir.licm"),      ARK_PROFILE_FULL, 1, GATE_FLAG_AND_LEVEL, 1,
      ir_wanted_licm,      PIPE_NAME("off (--licm)"),             0, 0, opt_licm_func,      0 },
#else
    { PIPE_NAME("ir.licm"),      ARK_PROFILE_FULL, 1, GATE_FLAG_AND_LEVEL, 0, 0, 0, 0, 0, 0, 0 },
#endif
#if ARKCC_FEATURE_UNROLL
    { PIPE_NAME("ir.unroll"),    ARK_PROFILE_FULL, 1, GATE_FLAG_AND_LEVEL, 1,
      ir_wanted_unroll,    PIPE_NAME("off (--unroll)"),           0, 0, opt_unroll_func,    0 },
#else
    { PIPE_NAME("ir.unroll"),    ARK_PROFILE_FULL, 1, GATE_FLAG_AND_LEVEL, 0, 0, 0, 0, 0, 0, 0 },
#endif
    { PIPE_NAME("ir.inline"),    ARK_PROFILE_FULL, 2, GATE_FLAG_AND_LEVEL, ARKCC_FEATURE_OPT_INLINE,
      ir_wanted_inline,    PIPE_NAME("off (--autoinline / -O2)"), 1, 1, 0,                  opt_inline },
    /* 常量传播放在 inline 之后：跨文件内联把被调函数的函数体搬进来以后，里面
     * 那些「读某个 const 全局」的指令才第一次和定义待在同一个程序里。它自己
     * 重跑一次折叠（opt_constfold_func），所以不必等下一轮 constfold——
     * 管线每个阶段只走一遍，不靠迭代收敛。 */
#if ARKCC_FEATURE_CONST_GLOBAL
    { PIPE_NAME("ir.const-global"), ARK_PROFILE_FULL, 1, GATE_FLAG_AND_LEVEL, 1,
      ir_wanted_const_global, PIPE_NAME("off (--const-global)"), 1, 0, 0, ir_const_global_run },
#else
    { PIPE_NAME("ir.const-global"), ARK_PROFILE_FULL, 1, GATE_FLAG_AND_LEVEL, 0, 0, 0, 1, 0, 0, 0 },
#endif
    /* 块尾合并放在 inline / const-global 之后：这两者会把同一个函数体复制到
     * 多个调用点、把常量折成立即数，于是造出「若干块以完全相同的指令序列收尾」
     * 的形状；再往后就只剩 vectorize 与后端，没有别的 pass 会再造这种重复。
     * 它只读 MIR 的块划分，因此不需要额外图结构。 */
#if ARKCC_FEATURE_TAILMERGE
    { PIPE_NAME("ir.tailmerge"), ARK_PROFILE_FULL, 1, GATE_FLAG_AND_LEVEL, 1,
      ir_wanted_tailmerge, PIPE_NAME("off (--tailmerge)"),        0, 0, opt_tailmerge_func, 0 },
#else
    { PIPE_NAME("ir.tailmerge"), ARK_PROFILE_FULL, 1, GATE_FLAG_AND_LEVEL, 0, 0, 0, 0, 0, 0, 0 },
#endif
    /* 整块形态紧跟块尾形态：块尾合并本身会造出「两块只剩同一段尾」的形状，
     * 但它们不会变成整块相同；反过来整块合并之后的块必然不再以各自独立的
     * 尾部收场。两者都在 MIR 的块划分上工作，不需要额外图结构。 */
#if ARKCC_FEATURE_XBLOCK
    { PIPE_NAME("ir.xblock"), ARK_PROFILE_FULL, 1, GATE_FLAG_AND_LEVEL, 1,
      ir_wanted_xblock, PIPE_NAME("off (--xblock)"),             0, 0, opt_xblock_func,  0 },
#else
    { PIPE_NAME("ir.xblock"), ARK_PROFILE_FULL, 1, GATE_FLAG_AND_LEVEL, 0, 0, 0, 0, 0, 0, 0 },
#endif
    /* 强度削减放在管线末尾：它只重写「常数紧跟乘法」这两条相邻指令，不造块、
     * 不改块尾形态，所以越晚跑越不会改变别的 pass 看到的形状。这条顺序不是
     * 风格问题——放在 inline 之前时，`x*1` 被删掉两条会让一个恰好卡在阈值上的
     * 函数体变成「可内联」，于是同一个程序在开关打开后会多出一整个内联副本
     * （实测 pow2 夹具 512 -> 533 条指令、镜像 +42 B，正是这个原因）。 */
#if ARKCC_FEATURE_OPT_STRENGTH
    { PIPE_NAME("ir.strength"),  ARK_PROFILE_LITE, 1, GATE_FLAG_AND_LEVEL, 1,
      ir_wanted_strength,  PIPE_NAME("off (-fopt-strength)"),     0, 0, opt_strength_func, 0 },
#else
    { PIPE_NAME("ir.strength"),  ARK_PROFILE_LITE, 1, GATE_FLAG_AND_LEVEL, 0, 0, 0, 0, 0, 0, 0 },
#endif
    { PIPE_NAME("ir.vectorize"), ARK_PROFILE_FULL, 2, GATE_FLAG_OR_LEVEL,  ARKCC_FEATURE_OPT_VECTORIZE,
      ir_wanted_vectorize, PIPE_NAME("off (--vectorize / -O2)"),  1, 0, 0,                  opt_vectorize },
};
#define IR_STAGE_COUNT ((int)(sizeof(g_ir_stages) / sizeof(g_ir_stages[0])))

/* ------------------------------------------------------------------ */
/* Decisions                                                           */
/* ------------------------------------------------------------------ */

int pipeline_profile_parse(const char *s) {
    if (!s) return -1;
    if (s[0] == 'l' && s[1] == 'i' && s[2] == 't' && s[3] == 'e' && s[4] == 0)
        return ARK_PROFILE_LITE;
    if (s[0] == 'f' && s[1] == 'u' && s[2] == 'l' && s[3] == 'l' && s[4] == 0)
        return ARK_PROFILE_FULL;
    return -1;
}

const char *pipeline_profile_name(int profile) {
    if (profile == ARK_PROFILE_LITE) return "lite";
    if (profile == ARK_PROFILE_FULL) return "full";
    return "?";
}

int pipeline_profile(void) {
    return g_config.pipeline_profile;
}

/* The reason strings are part of the dump contract the gate reads. */
#define WHY_NOT_BUILT     "not compiled into this build"
#define WHY_PROFILE_LITE  "skipped by --pipeline=lite"

static int decide_ast(const AstStage *s, const char **why) {
    if (!s->built_in) { *why = WHY_NOT_BUILT; return 0; }
    if (!s->wanted || !s->wanted()) {
        *why = s->flag_name ? s->flag_name : "switch is off";
        return 0;
    }
    *why = 0;
    return 1;
}

static int decide_ir(const IrStage *s, int level, int profile, const char **why) {
    if (!s->built_in) { *why = WHY_NOT_BUILT; return 0; }
    if (profile < s->min_profile) { *why = WHY_PROFILE_LITE; return 0; }
    {
        int want = s->wanted ? s->wanted() : 1;
        int lvl_ok = (s->min_level <= 0) || (level >= s->min_level);
        int run;
        if (s->gate == GATE_FLAG_OR_LEVEL) run = want || lvl_ok;
        else                               run = want && lvl_ok;
        if (run) { *why = 0; return 1; }
        /* Report the condition that actually failed, in the reader's terms. */
        if (s->gate == GATE_FLAG_AND_LEVEL && !lvl_ok) *why = "needs a higher -O level";
        else if (s->gate == GATE_FLAG_AND_LEVEL)       *why = s->flag_name ? s->flag_name : "switch is off";
        else                                           *why = s->flag_name ? s->flag_name : "switch is off";
        return 0;
    }
}

/* ------------------------------------------------------------------ */
/* Execution                                                           */
/* ------------------------------------------------------------------ */

void pipeline_run_ast(AstNode *prog) {
    int i;
    if (!prog) return;
    for (i = 0; i < AST_STAGE_COUNT; i++) {
        const char *why = 0;
        if (!decide_ast(&g_ast_stages[i], &why)) continue;
        g_ast_stages[i].fn(prog);
    }
}

void pipeline_run_ir(IrProgram *prog, int level, int profile) {
    int i;
    if (!prog) return;
    for (i = 0; i < IR_STAGE_COUNT; i++) {
        const IrStage *s = &g_ir_stages[i];
        const char *why = 0;
        int f;
        if (!decide_ir(s, level, profile, &why)) continue;
        if (s->scope == 1) {
            s->fn_prog(prog);
            if (s->cleanup_dce) {
                /* Expansion leaves the callee's dead tail behind; the linear
                 * rule is what removes it, and it must not be gated on the
                 * dce stage's own flag (that would let -fno-opt-dce keep the
                 * dead instructions inlining just created). */
                for (f = 0; f < prog->func_count; f++)
                    opt_dce_func(prog->funcs[f]);
            }
        } else {
            for (f = 0; f < prog->func_count; f++)
                s->fn_func(prog->funcs[f]);
        }
    }
}

/* ------------------------------------------------------------------ */
/* The readable table                                                  */
/* ------------------------------------------------------------------ */

#if ARKCC_FEATURE_PIPELINE_DUMP
static void dump_line(const char *name, int run, const char *why) {
    /* No padding and no added parentheses: the reason strings already read as
     * sentences ("off (--dce-cfg)", "needs a higher -O level"), and the gate
     * splits this line on whitespace. */
    if (run) ark_log("  run   %s\n", name[0] ? name : "(unnamed)");
    else     ark_log("  skip  %s  %s\n", name[0] ? name : "(unnamed)",
                     why ? why : "skipped");
}
#endif

void pipeline_dump(int level, int profile) {
#if ARKCC_FEATURE_PIPELINE_DUMP
    int i;
    ark_log("[arkcc] pipeline:\n");
    ark_log("  profile=%s  level=-O%d\n", pipeline_profile_name(profile), level);
    for (i = 0; i < AST_STAGE_COUNT; i++) {
        const char *why = 0;
        int run = decide_ast(&g_ast_stages[i], &why);
        dump_line(g_ast_stages[i].name, run, why);
    }
    for (i = 0; i < IR_STAGE_COUNT; i++) {
        const char *why = 0;
        int run = decide_ir(&g_ir_stages[i], level, profile, &why);
        dump_line(g_ir_stages[i].name, run, why);
    }
#else
    (void)level; (void)profile;
#endif
}
