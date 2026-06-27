/* Ark C Compiler - backend registry
 * 串起所有可用后端。新增后端时，只需在 g_backends[] 添加一行。
 */
#include "backend.h"
#include "platform.h"
#include "memory.h"

static const ArkBackend *g_backends[8];
static int g_count = 0;
static int g_inited = 0;

static void registry_init(void) {
    if (g_inited) return;
    g_inited = 1;
    g_backends[g_count++] = ark_backend_arm();
    g_backends[g_count++] = ark_backend_x86_64();
    g_backends[g_count++] = ark_backend_riscv32();
    g_backends[g_count++] = ark_backend_c();
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
