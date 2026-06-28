/* Ark C Compiler - cpu.h
 * 目标 CPU 选型：根据 --cpu/-mcpu 参数查询 CPU 信息并应用预定义宏。
 * 覆盖 armcc 5 常见 Cortex-M 系列：M0/M0+/M1/M3/M4/M7/M23/M33。
 */
#ifndef ARK_CPU_H
#define ARK_CPU_H

#include "common.h"

typedef struct {
    const char *name;       /* "Cortex-M0", "Cortex-M3", "Cortex-M4", "Cortex-M7" 等 */
    int arch_m;             /* __TARGET_ARCH_6_M, __TARGET_ARCH_7_M, __TARGET_ARCH_7E_M */
    int arch_em;            /* __TARGET_ARCH_7E_M */
    int has_dsp;            /* __TARGET_FEATURE_DSP */
    int has_fpu;            /* __TARGET_FPU_VFP */
    int has_fpu_dp;         /* 双精度 FPU */
    int thumb_only;         /* 只支持 Thumb 指令集 */
    const char *fpu_name;   /* "VFPv4-SP", "VFPv5-D16" 等 */
} CpuInfo;

/* 按名称查找 CPU 信息；找不到返回 NULL。
 * 名称匹配大小写不敏感，且支持省略 "Cortex-" 前缀（如 "M4" 等价 "Cortex-M4"）。 */
const CpuInfo *cpu_lookup(const char *name);

/* 根据 CPU 信息设置/覆盖预定义宏（覆盖默认的硬编码 M7 值）。
 * 在 preproc_process 之前调用，使后续预处理看到正确的 __TARGET_ARCH_* 等宏。 */
void cpu_apply_predefines(const CpuInfo *cpu);

#endif /* ARK_CPU_H */
