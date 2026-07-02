/* Ark C Compiler - STM32 entry point
 * Invokes arkcc on the STM32 to compile source files.
 *
 * Usage:
 * 1. Source file is pre-flashed to the W25Q SPI Flash
 * 2. After STM32 power-on, call arkcc_stm32_compile("main.c")
 * 3. Compilation result is returned via callback (written to Flash or executed directly)
 */
#include "compiler.h"
#include "platform.h"
#include "config.h"
#include "flash_fs.h"
#include "common.h"

/* Compile result callback: implemented by the user (write to Flash / execute directly / stream over UART).
 * weak semantics allow the user to override it in their project; the default implementation dumps hex over UART. */
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

/* STM32 compile entry point.
 * source_file is the source filename in W25Q Flash (fs_read_file looks it up in the file table).
 * Returns ark_compile's error code (ARK_OK=0 on success). */
int arkcc_stm32_compile(const char *source_file) {
    ArkOptions opts;
    int i;
    /* Initialize the struct manually to avoid depending on memset (bare-metal has no libc).
     * Equivalent to reset_opts in main.c. */
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

    /* Initialize g_config with compile-time defaults; do not call config_load_file
     * (the config file path typically does not exist on STM32). */
    config_init();
    /* STM32H743: enable hardware FPU and basic optimization by default */
    g_config.enable_fpu_hw = 1;
    g_config.opt_level = 1;

    return ark_compile(&opts);
}
