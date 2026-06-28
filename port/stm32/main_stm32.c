/* Ark C Compiler - STM32 入口点
 * 在 STM32 上调用 arkcc 编译源文件。
 *
 * 使用方式：
 * 1. 源文件预先烧录到 W25Q SPI Flash
 * 2. STM32 上电后调用 arkcc_stm32_compile("main.c")
 * 3. 编译结果通过回调返回（写入 Flash 或直接执行）
 */
#include "compiler.h"
#include "platform.h"
#include "config.h"
#include "flash_fs.h"
#include "common.h"

/* 编译结果回调：用户实现（写 Flash / 直接执行 / 通过 UART 传输）。
 * weak 语义允许用户在工程中覆盖；默认实现通过 UART 输出 hex dump。 */
__attribute__((weak)) void arkcc_on_output(const unsigned char *data, int len) {
    int i;
    for (i = 0; i < len; i++) {
        char hex[4];
        int v = data[i];
        int hi = (v >> 4) & 0xf;
        int lo = v & 0xf;
        hex[0] = (char)(hi < 10 ? '0' + hi : 'A' + hi - 10);
        hex[1] = (char)(lo < 10 ? '0' + lo : 'A' + lo - 10);
        hex[2] = ' ';
        hex[3] = 0;
        ark_log("%s", hex);
    }
    ark_log("\n");
}

/* STM32 编译入口。
 * source_file 为 W25Q Flash 中的源文件名（fs_read_file 会查文件表）。
 * 返回 ark_compile 的错误码（ARK_OK=0 表示成功）。 */
int arkcc_stm32_compile(const char *source_file) {
    ArkOptions opts;
    int i;
    /* 手动初始化结构体，避免依赖 memset（裸机环境无 libc）。
     * 与 main.c 的 reset_opts 等价。 */
    opts.input_path = source_file;
    opts.output_path = 0;
    opts.emit_asm = 0;
    opts.verbose = 1;
    opts.target = "arm";
    for (i = 0; i < 16; i++) opts.include_dirs[i] = 0;
    opts.include_dir_count = 0;
    opts.list_backends = 0;
    opts.compile_only = 0;
    opts.preprocess_only = 0;
    opts.link_mode = 0;
    for (i = 0; i < 32; i++) opts.link_inputs[i] = 0;
    opts.link_input_count = 0;
    opts.opt_level = 0;
    opts.debug_info = 0;
    opts.no_unused_warn = 0;

    /* 用编译期默认值初始化 g_config；不调用 config_load_file
     * （STM32 上配置文件路径通常不存在）。 */
    config_init();
    /* STM32H743 默认开启硬件 FPU 与基础优化 */
    g_config.enable_fpu_hw = 1;
    g_config.opt_level = 1;

    return ark_compile(&opts);
}
