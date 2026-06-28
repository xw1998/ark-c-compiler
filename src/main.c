/* Ark C Compiler - main (host)
 * 用法：arkcc <file.c> [-o output] [-S] [-v] [-target name] [-I dir] [--list-backends]
 *       新增：-c / -E / -link a.o b.o / -O0|1|2 / -g / -Wno-unused
 *             -config <file> / -f<feature> / -fno-<feature>
 *             --enum_is_int / --dollar / --dwarf2 / --dwarf3 / --scatter <file>
 */
#include "compiler.h"
#include "platform.h"
#include "common.h"
#include "config.h"
#include "scatter.h"
#include "arkcc_config.h"
#include <stdio.h>
#include <string.h>

static void usage(void) {
    fprintf(stderr,
        "Ark C Compiler v%s\n"
        "Usage: arkcc <file.c> [options]\n"
        "  -o <file>          output file\n"
        "  -S                 emit assembly text (or .gen.c for -target c)\n"
        "  -c                 compile only (produce .ark_obj)\n"
        "  -E                 preprocess only, write expanded source\n"
        "  -link a.o b.o      link multiple .ark_obj files (use with -o)\n"
        "  -v                 verbose\n"
        "  -target <name>     select backend (arm|x86_64|riscv32|c)\n"
        "  -I <dir>           additional include path\n"
        "  -O0/-O1/-O2        optimisation level (accepted but currently unused)\n"
        "  -g                 emit debug info (accepted but currently unused)\n"
        "  -Wno-unused        suppress unused warnings\n"
        "  -config <file>     load arkcc INI config file\n"
        "  -f<feature>        enable feature (vla/complex/wchar/trigraph/fpu/dwarf/...)\n"
        "  -fno-<feature>     disable feature\n"
        "  -mcpu <name>       target CPU (Cortex-M0/M3/M4/M7/M33...); alias: --cpu\n"
        "  -MMD               generate dependency file; alias: --depend\n"
        "  -MF <file>         dependency output path (use with -MMD)\n"
        "  -ffunction-sections  one section per function; alias: --split_sections\n"
        "  --list-backends    print available backends and exit\n"
        "  -h, --help         this message\n",
        ARK_VERSION);
}

/* 检查文件是否存在（可读） */
static int file_exists(const char *path) {
    FILE *fp = fopen(path, "r");
    if (!fp) return 0;
    fclose(fp);
    return 1;
}

static void reset_opts(ArkOptions *o) {
    int i;
    o->input_path = 0;
    o->output_path = 0;
    o->emit_asm = 0;
    o->verbose = 0;
    o->target = 0;
    for (i = 0; i < 16; i++) o->include_dirs[i] = 0;
    o->include_dir_count = 0;
    o->list_backends = 0;
    o->compile_only = 0;
    o->preprocess_only = 0;
    o->link_mode = 0;
    for (i = 0; i < 32; i++) o->link_inputs[i] = 0;
    o->link_input_count = 0;
    o->opt_level = 0;
    o->debug_info = 0;
    o->no_unused_warn = 0;
    o->cpu = 0;
    o->gen_depend = 0;
    o->depend_file = 0;
    o->split_sections = 0;
}

int main(int argc, char **argv) {
    ArkOptions opts;
    int i;
    int rc;
    int cfg_loaded = 0;
    reset_opts(&opts);

    if (argc < 2) { usage(); return 1; }

    /* ---- 配置系统初始化（优先级：命令行 > 配置文件 > 编译期默认）---- */
    /* 1) 用编译期 ARKCC_FEATURE_* 宏初始化 g_config */
    config_init();
    /* 2) 查找 -config <file> 或默认 arkcc.cfg，加载配置文件 */
    for (i = 1; i < argc; i++) {
        const char *a = argv[i];
        if (strcmp(a, "-config") == 0 && i + 1 < argc) {
            config_load_file(argv[i + 1]);
            cfg_loaded = 1;
            break;
        }
    }
    if (!cfg_loaded && file_exists("arkcc.cfg")) {
        config_load_file("arkcc.cfg");
    }
    /* 3) 扫描命令行 -O/-g/-fxxx/-fno-xxx，覆盖文件设置 */
    config_apply_args(argc, argv);

    for (i = 1; i < argc; i++) {
        const char *a = argv[i];
        if (strcmp(a, "-S") == 0)            opts.emit_asm = 1;
        else if (strcmp(a, "-c") == 0)       opts.compile_only = 1;
        else if (strcmp(a, "-E") == 0)       opts.preprocess_only = 1;
        else if (strcmp(a, "-v") == 0)       opts.verbose = 1;
        else if (strcmp(a, "-g") == 0)       opts.debug_info = 1;
        else if (strncmp(a, "-O", 2) == 0)   opts.opt_level = (a[2] >= '0' && a[2] <= '9') ? (a[2] - '0') : 0;
        else if (strcmp(a, "-Wno-unused") == 0) opts.no_unused_warn = 1;
        else if (strncmp(a, "-W", 2) == 0)   { /* 接受未知 -W*，忽略 */ }
        else if (strcmp(a, "-config") == 0 && i + 1 < argc) {
            /* 已在前面处理过，跳过路径参数 */
            i++;
        }
        else if (a[0] == '-' && a[1] == 'f') {
            /* -fxxx / -fno-xxx：已由 config_apply_args 处理，此处静默接受 */
        }
        else if (strcmp(a, "--enum_is_int") == 0 || strcmp(a, "-fenum-is-int") == 0 ||
                 strcmp(a, "--dollar") == 0 ||
                 strcmp(a, "--signed_chars") == 0 || strcmp(a, "--unsigned_chars") == 0 ||
                 strcmp(a, "--wchar16") == 0 || strcmp(a, "--wchar32") == 0 ||
                 strcmp(a, "--dwarf2") == 0 || strcmp(a, "--dwarf3") == 0 ||
                 strcmp(a, "--thumb") == 0 || strcmp(a, "--arm") == 0 ||
                 strcmp(a, "--remarks") == 0 || strcmp(a, "--autoinline") == 0 ||
                 strcmp(a, "--no_autoinline") == 0 || strcmp(a, "--vectorize") == 0 ||
                 strcmp(a, "--no_vectorize") == 0 || strcmp(a, "--library_type") == 0 ||
                 strcmp(a, "--locale") == 0 || strcmp(a, "--multibyte_chars") == 0 ||
                 strcmp(a, "--data_reorder") == 0 || strcmp(a, "--diag_style") == 0 ||
                 strcmp(a, "--remove_unneeded_entities") == 0) {
            /* armcc 5 兼容选项：已由 config_apply_args 处理或静默忽略 */
        }
        else if (strcmp(a, "--scatter") == 0 && i + 1 < argc) {
            /* --scatter <file>：已由 config_apply_args 记录路径，此处跳过参数 */
            i++;
        }
        else if (strcmp(a, "--fpu") == 0 && i + 1 < argc) {
            /* --fpu <name>：已由 config_apply_args 处理，此处跳过参数 */
            i++;
        }
        else if (strcmp(a, "-o") == 0 && i + 1 < argc) {
            opts.output_path = argv[++i];
        }
        else if (strcmp(a, "-target") == 0 && i + 1 < argc) {
            opts.target = argv[++i];
        }
        else if (strcmp(a, "-I") == 0 && i + 1 < argc) {
            if (opts.include_dir_count < 16)
                opts.include_dirs[opts.include_dir_count++] = argv[++i];
            else i++;
        }
        else if (strcmp(a, "-mcpu") == 0 || strcmp(a, "--cpu") == 0) {
            if (i + 1 < argc) opts.cpu = argv[++i];
        }
        else if (strcmp(a, "-MMD") == 0 || strcmp(a, "--depend") == 0) {
            opts.gen_depend = 1;
        }
        else if (strcmp(a, "-MF") == 0 && i + 1 < argc) {
            opts.depend_file = argv[++i];
        }
        else if (strcmp(a, "-ffunction-sections") == 0 ||
                 strcmp(a, "--split_sections") == 0) {
            opts.split_sections = 1;
        }
        else if (strcmp(a, "-link") == 0) {
            opts.link_mode = 1;
            /* 收集后续非 -o/非选项参数作为输入 */
            while (i + 1 < argc) {
                const char *nx = argv[i + 1];
                if (nx[0] == '-') break;
                if (opts.link_input_count < 32)
                    opts.link_inputs[opts.link_input_count++] = nx;
                i++;
            }
        }
        else if (strcmp(a, "--list-backends") == 0) opts.list_backends = 1;
        else if (strcmp(a, "-h") == 0 || strcmp(a, "--help") == 0) {
            usage();
            return 0;
        }
        else if (a[0] == '-') {
            fprintf(stderr, "[arkcc] unknown option: %s\n", a);
            return 1;
        }
        else {
            opts.input_path = a;
        }
    }
    if (opts.verbose) config_print();
    if (!opts.list_backends && !opts.input_path && !opts.link_mode) {
        usage();
        return 1;
    }
#if ARKCC_FEATURE_SCATTER
    /* --scatter <file>：解析 ARM scatter 加载描述文件，校验语法并记录区域。
     * 解析结果当前仅打印到日志（arkcc 不内置链接器），供调试与未来扩展。 */
    if (g_config.scatter_file) {
        ScatterDesc sd;
        sd.load_regions = 0;
        sd.error_count = 0;
        if (scatter_parse_file(g_config.scatter_file, &sd) == 0) {
            if (opts.verbose) scatter_dump(&sd);
        }
        scatter_free(&sd);
    }
#endif
    rc = ark_compile(&opts);
    if (rc != ARK_OK) {
        fprintf(stderr, "[arkcc] failed with code %d\n", rc);
        return 1;
    }
    return 0;
}
