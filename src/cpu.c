/* Ark C Compiler - cpu
 * 目标 CPU 选型：根据 --cpu/-mcpu 参数查找 CPU 信息并应用预定义宏。
 *
 * 覆盖 armcc 5 常见 Cortex-M 系列：M0/M0+/M1/M3/M4/M7/M23/M33。
 * 不同 CPU 决定 __TARGET_ARCH_*、__TARGET_FEATURE_DSP、__TARGET_FPU_VFP 等
 * 预定义宏的取值，并影响 g_config.enable_fpu_hw 等运行时开关。
 */
#include "cpu.h"
#include "preproc.h"
#include "platform.h"

/* CPU 查找表：armcc 5 / CMSIS 常见 Cortex-M 内核。
 *   arch_m   : __TARGET_ARCH_<x>_M 取值（6/7/8 等，0 表示不定义）
 *   arch_em  : 是否定义 __TARGET_ARCH_7E_M（M4/M7/M33 等带 DSP 扩展）
 *   has_dsp  : 是否定义 __TARGET_FEATURE_DSP（M4/M7/M33）
 *   has_fpu  : 是否定义 __TARGET_FPU_VFP（M4F/M7/M33）
 *   has_fpu_dp: 是否双精度（仅 M7 DP 变体）
 *   thumb_only: 是否仅支持 Thumb 指令集（所有 Cortex-M 均为 thumb-only）
 *   fpu_name : FPU 单元名称（供诊断/未来扩展使用）
 */
static const CpuInfo g_cpu_table[] = {
    /* Cortex-M0 : ARMv6-M, Thumb-only, 无 DSP/FPU */
    { "Cortex-M0",   6, 0, 0, 0, 0, 1, 0 },
    /* Cortex-M0+ : ARMv6-M, 同 M0 但更小 */
    { "Cortex-M0+",  6, 0, 0, 0, 0, 1, 0 },
    /* Cortex-M1  : ARMv6-M, FPGA 优化版 */
    { "Cortex-M1",   6, 0, 0, 0, 0, 1, 0 },
    /* Cortex-M3  : ARMv7-M, Thumb-2, 无 DSP/FPU */
    { "Cortex-M3",   7, 0, 0, 0, 0, 1, 0 },
    /* Cortex-M4  : ARMv7E-M, 带 DSP 扩展，可选单精度 FPU */
    { "Cortex-M4",   7, 1, 1, 1, 0, 1, "VFPv4-SP" },
    /* Cortex-M7  : ARMv7E-M, DSP + 双精度 FPU（默认 DP） */
    { "Cortex-M7",   7, 1, 1, 1, 1, 1, "VFPv5-D16" },
    /* Cortex-M23 : ARMv8-M, Thumb-only, 无 DSP/FPU（Baseline） */
    { "Cortex-M23",  8, 0, 0, 0, 0, 1, 0 },
    /* Cortex-M33 : ARMv8-M, DSP + 单精度 FPU（Mainline） */
    { "Cortex-M33",  8, 1, 1, 1, 0, 1, "VFPv5-SP" },
};

#define CPU_TABLE_COUNT ((int)(sizeof(g_cpu_table) / sizeof(g_cpu_table[0])))

/* 大小写不敏感的 ASCII 字符串比较，避免依赖 strcasecmp。 */
static int cpu_strcaseeq(const char *a, const char *b) {
    while (*a && *b) {
        char ca = *a, cb = *b;
        if (ca >= 'A' && ca <= 'Z') ca = (char)(ca - 'A' + 'a');
        if (cb >= 'A' && cb <= 'Z') cb = (char)(cb - 'A' + 'a');
        if (ca != cb) return 0;
        a++; b++;
    }
    return (*a == 0 && *b == 0);
}

/* 去掉 "Cortex-" 前缀后比较，使 "M4" 等价于 "Cortex-M4"。
 * 也接受 "cortex-m4" / "CORTEX-M4" 等大小写变体。 */
static int cpu_name_matches(const char *user, const char *table_name) {
    const char *prefix = "Cortex-";
    int plen = 7;
    int i;
    /* 1) 直接全名比较 */
    if (cpu_strcaseeq(user, table_name)) return 1;
    /* 2) table_name 必须以 "Cortex-" 开头（大小写不敏感） */
    for (i = 0; i < plen; i++) {
        char pc = prefix[i];
        char tc = table_name[i];
        if (pc >= 'A' && pc <= 'Z') pc = (char)(pc - 'A' + 'a');
        if (tc >= 'A' && tc <= 'Z') tc = (char)(tc - 'A' + 'a');
        if (pc != tc) return 0;
    }
    /* 3) 用户输入与去掉前缀后的部分比较（如 "M4" 对应 "M4"） */
    if (cpu_strcaseeq(user, table_name + plen)) return 1;
    return 0;
}

const CpuInfo *cpu_lookup(const char *name) {
    int i;
    if (!name || !*name) return 0;
    for (i = 0; i < CPU_TABLE_COUNT; i++) {
        if (cpu_name_matches(name, g_cpu_table[i].name)) return &g_cpu_table[i];
    }
    return 0;
}

/* 把整数转为字符串写入静态缓冲区（仅用于宏体，立即数级别） */
static void int_to_str(int v, char *out) {
    int n = 0;
    char tmp[16];
    int i;
    unsigned u;
    if (v < 0) { out[0] = '-'; out++; u = (unsigned)(-v); }
    else u = (unsigned)v;
    if (u == 0) tmp[n++] = '0';
    while (u) { tmp[n++] = (char)('0' + (int)(u % 10)); u /= 10; }
    for (i = n - 1; i >= 0; i--) out[n - 1 - i] = tmp[i];
    out[n] = 0;
}

void cpu_apply_predefines(const CpuInfo *cpu) {
    char buf[16];
    if (!cpu) return;

    /* 先清除所有 __TARGET_ARCH_* / __TARGET_FEATURE_* / __TARGET_FPU_* 旧宏，
     * 再按当前 CPU 重新定义。这覆盖了 preproc_process 中硬编码的 M7 默认值。 */
    preproc_undef("__TARGET_ARCH_6_M");
    preproc_undef("__TARGET_ARCH_7_M");
    preproc_undef("__TARGET_ARCH_7E_M");
    preproc_undef("__TARGET_ARCH_8_M");
    preproc_undef("__TARGET_ARCH_8_M_BASE");
    preproc_undef("__TARGET_ARCH_8_M_MAIN");
    preproc_undef("__TARGET_FEATURE_DSP");
    preproc_undef("__TARGET_FPU_VFP");
    preproc_undef("__TARGET_FPU_FPV5");
    preproc_undef("__TARGET_FPU_DP");

    /* 按 arch_m 取值定义对应架构宏 */
    switch (cpu->arch_m) {
        case 6:
            preproc_define("__TARGET_ARCH_6_M", "1");
            break;
        case 7:
            if (cpu->arch_em) preproc_define("__TARGET_ARCH_7E_M", "1");
            else              preproc_define("__TARGET_ARCH_7_M", "1");
            break;
        case 8:
            if (cpu->arch_em) preproc_define("__TARGET_ARCH_8_M_MAIN", "1");
            else              preproc_define("__TARGET_ARCH_8_M_BASE", "1");
            preproc_define("__TARGET_ARCH_8_M", "1");
            break;
        default:
            break;
    }

    /* DSP 扩展 */
    if (cpu->has_dsp) {
        preproc_define("__TARGET_FEATURE_DSP", "1");
    }

    /* FPU 标记：单/双精度 */
    if (cpu->has_fpu) {
        preproc_define("__TARGET_FPU_VFP", "1");
        /* M7 默认 VFPv5-D16；M4 是 VFPv4-SP；M33 是 VFPv5-SP。
         * 简化：若 fpu_name 非空，再额外定义一个 FPU 单元宏。 */
        if (cpu->fpu_name) {
            /* 仅 VFPv5 系列定义 __TARGET_FPU_FPV5 */
            if (cpu->fpu_name[0] == 'V' && cpu->fpu_name[1] == 'F' &&
                cpu->fpu_name[2] == 'P' && cpu->fpu_name[3] == 'v' &&
                cpu->fpu_name[4] == '5') {
                preproc_define("__TARGET_FPU_FPV5", "1");
            }
        }
        if (cpu->has_fpu_dp) {
            preproc_define("__TARGET_FPU_DP", "1");
        }
    }

    /* 写入一个 __TARGET_CPU 反射宏，便于用户代码诊断（非标准，arkcc 扩展） */
    preproc_define("__TARGET_CPU_NAME", cpu->name);

    /* 用整数字符串形式定义 __TARGET_ARCH_M（主版本号），便于 #if 比较 */
    int_to_str(cpu->arch_m, buf);
    preproc_define("__TARGET_ARCH_M", buf);
}
