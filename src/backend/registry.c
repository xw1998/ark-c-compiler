/* Ark C Compiler - backend registry
 * 串起所有可用后端。新增后端时，只需在 g_backends[] 添加一行。
 *
 * 后端可由编译期宏裁剪：
 *   ARKCC_BACKEND_ARM / ARKCC_BACKEND_X86_64 /
 *   ARKCC_BACKEND_RISCV32 / ARKCC_BACKEND_C
 * 默认全部启用（host）；STM32 移植可通过 -D 覆盖关闭不用的后端，
 * 此时 Makefile 不再编译对应 backend_xxx.c 也不会产生链接错误。
 */
#include "backend.h"
#include "platform.h"
#include "memory.h"

#ifndef ARKCC_BACKEND_ARM
#define ARKCC_BACKEND_ARM      1
#endif
#ifndef ARKCC_BACKEND_X86_64
#define ARKCC_BACKEND_X86_64   1
#endif
#ifndef ARKCC_BACKEND_RISCV32
#define ARKCC_BACKEND_RISCV32  1
#endif
#ifndef ARKCC_BACKEND_C
#define ARKCC_BACKEND_C        1
#endif

static const ArkBackend *g_backends[8];
static int g_count = 0;
static int g_inited = 0;

static void registry_init(void) {
    if (g_inited) return;
    g_inited = 1;
#if ARKCC_BACKEND_ARM
    g_backends[g_count++] = ark_backend_arm();
#endif
#if ARKCC_BACKEND_X86_64
    g_backends[g_count++] = ark_backend_x86_64();
#endif
#if ARKCC_BACKEND_RISCV32
    g_backends[g_count++] = ark_backend_riscv32();
#endif
#if ARKCC_BACKEND_C
    g_backends[g_count++] = ark_backend_c();
#endif
}

const ArkBackend *ark_backend_find(const char *name) {
    int i;
    registry_init();
    if (!name) return 0;
    for (i = 0; i < g_count; i++) {
        if (ark_streq(g_backends[i]->name, name)) return g_backends[i];
    }
    return 0;
}

const ArkBackend *ark_backend_default(void) {
    registry_init();
    /* 默认 ARM，保留原行为 */
    return g_backends[0];
}

void ark_backend_list(void) {
    int i;
    registry_init();
    ark_log("Available targets:\n");
    for (i = 0; i < g_count; i++) {
        ark_log("  %-10s %s\n", g_backends[i]->name, g_backends[i]->triple);
    }
}
