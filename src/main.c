/* Ark C Compiler - main (host)
 * Usage: arkcc <file.c> [-o output] [-S] [-v] [-target name] [-I dir] [--list-backends]
 *       Added: -c / -E / -link a.o b.o / -O0|1|2 / -g / -Wno-unused
 *             -config <file> / -f<feature> / -fno-<feature>
 *             --enum_is_int / --dollar / --dwarf2 / --dwarf3 / --scatter <file>
 */
#include "compiler.h"
#include "platform.h"
#include "common.h"
#include "config.h"
#include "scatter.h"
#include "arkcc_config.h"
#include "diag.h"
#include "cpu.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

static void usage(void) {
    fprintf(stderr,
        "Ark C Compiler v%s\n"
        "Usage: arkcc <file.c> [options]\n"
        "  -o <file>          output file\n"
        "  -S                 emit assembly text (or .gen.c for -target c)\n"
        "  -c                 compile only (produce .ark_obj)\n"
        "  -E                 preprocess only, write expanded source\n"
        "  -link a.o b.o      link multiple .ark_obj files (use with -o)\n"
        "  --vector-table     reserve ARM_VT_SIZE (0x400) at the front of the image and\n"
        "                     emit a Cortex-M vector table there.  Link addresses stay\n"
        "                     valid: nothing is shifted, unlike the implicit table.\n"
        "  -v                 verbose\n"
        "  -target <name>     select backend (arm|x86|riscv32|c)\n"
        "  -I <dir>           additional include path\n"
        "  -O0/-O1/-O2        optimisation level: IR constant folding + dead code\n"
        "                     elimination; -O2 also enables inline/vectorise\n"
        "  -g                 emit DWARF debug sections (implies --dwarf2;\n"
        "                     use --dwarf3 for DWARF 3)\n"
        "  -Wno-unused        suppress unused warnings\n"
        "  -config <file>     load arkcc INI config file\n"
        "  -f<feature>        enable feature (vla/complex/wchar/trigraph/fpu/dwarf/...)\n"
        "  -fno-<feature>     disable feature\n"
        "  -mcpu <name>       target CPU (Cortex-M0/M3/M4/M7/M33...); alias: --cpu\n"
        "  -MMD               generate dependency file; alias: --depend\n"
        "  -MF <file>         dependency output path (use with -MMD)\n"
        "  -ffunction-sections  one section per function; alias: --split_sections\n"
        "  --scatter <file>   ARM scatter .sct file (parsed and converted to .ld when -S is used)\n"
        "  -T <file>          GNU ld linker script .ld (alias: --linker-script; converted to .sct with -S)\n"
        "  --uvprojx <file>   MDK project file: auto-extract -I include paths and -D defines\n"
        "  -config <file>     load arkcc INI config file (overrides defaults; see arkcc.cfg)\n"
        "  -profile <name>    select build profile (host_full/stm32_min/cross_compile)\n"
        "  -D<name>[=<val>]   define macro (e.g. -DFOO=1 or -D FOO)\n"
        "  --list-backends    print available backends and exit\n"
        "  --diag_style <s>   diagnostic layout: arm (default) | ide\n"
        "  --diag_suppress=<n>[,<n>]  hide diagnostic code(s)\n"
        "  --diag_remark=<n>[,<n>]    same visible effect as --diag_suppress\n"
        "  --diag_error=<n>[,<n>]     report diagnostic code(s) as errors\n"
        "  --errors <file>    write the diagnostic stream to a file\n"
        "  -h, --help         this message\n",
        ARK_VERSION);
}

/* Check if file exists (readable) */
static int file_exists(const char *path) {
    FILE *fp = fopen(path, "r");
    if (!fp) return 0;
    fclose(fp);
    return 1;
}

/* === MDK .uvprojx auto-discovery ===
 * Parses an MDK .uvprojx (XML) file to extract <IncludePath> and <Define>
 * entries from the <Cads><VariousControls> section, then injects them as
 * -I and -D options into opts. Relative paths are resolved relative to
 * the .uvprojx file's directory.
 *
 * This lets arkcc compile an unmodified MDK project:
 *   arkcc main.c --uvprojx project.uvprojx -target arm -c -o main.ark_obj
 */
static void parse_uvprojx(const char *uvprojx_path, ArkOptions *opts) {
    FILE *fp;
    char *buf;
    long fsize;
    char dir[512];
    int di;

    fp = fopen(uvprojx_path, "r");
    if (!fp) {
        fprintf(stderr, "[arkcc] warning: cannot open .uvprojx '%s'\n", uvprojx_path);
        return;
    }
    fseek(fp, 0, SEEK_END);
    fsize = ftell(fp);
    fseek(fp, 0, SEEK_SET);
    if (fsize <= 0 || fsize > 4 * 1024 * 1024) { fclose(fp); return; }
    buf = (char *)malloc(fsize + 1);
    if (!buf) { fclose(fp); return; }
    fread(buf, 1, fsize, fp);
    buf[fsize] = 0;
    fclose(fp);

    /* Extract directory from uvprojx_path (for relative path resolution) */
    for (di = (int)strlen(uvprojx_path) - 1; di >= 0; di--) {
        if (uvprojx_path[di] == '/' || uvprojx_path[di] == '\\') break;
    }
    if (di > 0) {
        int j;
        for (j = 0; j <= di && j < (int)sizeof(dir) - 1; j++)
            dir[j] = uvprojx_path[j];
        dir[j] = 0;
    } else {
        dir[0] = 0;
    }

    /* Find <Cads> section first, then <IncludePath> and <Define> within it.
     * The .uvprojx has multiple <IncludePath>/<Define> tags (top-level empty,
     * Cads with content, Aads empty); we need the Cads ones. */
    {
        char *cads = strstr(buf, "<Cads>");
        char *cads_end = cads ? strstr(cads, "</Cads>") : 0;
        char *inc_start, *def_start;

        /* Find <IncludePath>...</IncludePath> within Cads */
        if (cads && cads_end) {
            inc_start = strstr(cads, "<IncludePath>");
            if (inc_start && inc_start < cads_end) {
                inc_start += 13;  /* strlen("<IncludePath>") */
                {
                    char *end = strstr(inc_start, "</IncludePath>");
                    if (end && end < cads_end) {
                        /* Split by ';' and add each path */
                        char *p = inc_start;
                        while (p < end && opts->include_dir_count < 16) {
                            char *sep = strchr(p, ';');
                            char *path_end = sep ? sep : end;
                            int plen = (int)(path_end - p);
                            if (plen > 0 && plen < 512) {
                                char abspath[1024];
                                char tmp[512];
                                int ti = 0;
                                int j;
                                /* Copy the path segment */
                                for (j = 0; j < plen && ti < (int)sizeof(tmp) - 1; j++) {
                                    if (p[j] != ' ' && p[j] != '\t' && p[j] != '\r' && p[j] != '\n')
                                        tmp[ti++] = p[j];
                                }
                                tmp[ti] = 0;
                                if (ti > 0) {
                                    /* If relative, prepend the .uvprojx directory */
                                    if (tmp[0] != '/' && tmp[0] != '\\' &&
                                        !(ti > 1 && tmp[1] == ':')) {
                                        snprintf(abspath, sizeof(abspath), "%s%s", dir, tmp);
                                    } else {
                                        strncpy(abspath, tmp, sizeof(abspath) - 1);
                                        abspath[sizeof(abspath) - 1] = 0;
                                    }
                                    {
                                        char *dup = (char *)malloc(strlen(abspath) + 1);
                                        if (dup) { strcpy(dup, abspath); }
                                        opts->include_dirs[opts->include_dir_count++] = dup;
                                    }
                                }
                            }
                            p = path_end + 1;
                        }
                    }
                }
            }
        }

        /* Find <Define>...</Define> within Cads */
        if (cads && cads_end) {
            def_start = strstr(cads, "<Define>");
            if (def_start && def_start < cads_end) {
                def_start += 8;  /* strlen("<Define>") */
                {
                    char *end = strstr(def_start, "</Define>");
                    if (end && end < cads_end) {
                        /* Split by ',' and add each define */
                        char *p = def_start;
                        while (p < end && opts->pre_define_count < 64) {
                            char *sep = strchr(p, ',');
                            char *def_end = sep ? sep : end;
                            int dlen = (int)(def_end - p);
                            if (dlen > 0 && dlen < 256) {
                                char tmp[256];
                                int ti = 0;
                                int j;
                                for (j = 0; j < dlen && ti < (int)sizeof(tmp) - 1; j++) {
                                    if (p[j] != ' ' && p[j] != '\t' && p[j] != '\r' && p[j] != '\n')
                                        tmp[ti++] = p[j];
                                }
                                tmp[ti] = 0;
                                if (ti > 0) {
                                    char *dup = (char *)malloc(strlen(tmp) + 1);
                                    if (dup) { strcpy(dup, tmp); }
                                    opts->pre_defines[opts->pre_define_count++] = dup;
                                }
                            }
                            p = def_end + 1;
                        }
                    }
                }
            }
        }
    }

    free(buf);
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
    o->vector_table = 0;
    for (i = 0; i < 32; i++) o->link_inputs[i] = 0;
    o->link_input_count = 0;
    o->opt_level = 0;
    o->debug_info = 0;
    o->no_unused_warn = 0;
    o->cpu = 0;
    o->gen_depend = 0;
    o->depend_file = 0;
    o->split_sections = 0;
    o->scatter_file = 0;
    o->linker_script = 0;
    for (i = 0; i < 64; i++) o->pre_defines[i] = 0;
    o->pre_define_count = 0;
    o->uvprojx = 0;
}

/* armcc: the text before '=' must be an identifier; everything after '=' is
 * taken as-is (so "-D FOO=(1+2)" and "-D FOO=bad text" are both accepted).
 * "-D 1BAD=1" is rejected with #992 "invalid macro definition: 1BAD=1". */
static int valid_define(const char *d) {
    int i = 0;
    if (!d || !d[0]) return 0;
    if (!((d[0] == '_') || (d[0] >= 'a' && d[0] <= 'z') ||
          (d[0] >= 'A' && d[0] <= 'Z'))) return 0;
    while (d[i] && d[i] != '=') {
        char c = d[i];
        if (!((c == '_') || (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') ||
              (c >= '0' && c <= '9'))) return 0;
        i++;
    }
    return 1;
}

/* ---------------------------------------------------------------------------
 * --diag_suppress / --diag_remark / --diag_error / --diag_warning
 *
 * Measured on armcc 5.06u7 (--diag_* always take their value after '='):
 *   --diag_suppress=177            no output, exit 0
 *   --diag_remark=177              no output, exit 0  (indistinguishable)
 *   --diag_error=177               "Error:  #177-D" (word changes, -D stays)
 *   --diag_warning=177/101         no observable change
 *   --diag_suppress=abc / =9999    silently ignored
 *   --diag_suppress   (no value)   Fatal error: C3901U: Missing argument ...
 * ------------------------------------------------------------------------- */

static const char *diag_policy_names[] = {
    "--diag_suppress", "--diag_remark", "--diag_error", "--diag_warning", 0
};

/* Is `a` one of the policy options (with or without a value)? */
static const char *diag_policy_match(const char *a) {
    int i;
    for (i = 0; diag_policy_names[i]; i++) {
        int n = (int)strlen(diag_policy_names[i]);
        if (strncmp(a, diag_policy_names[i], n) == 0 &&
            (a[n] == 0 || a[n] == '=')) return diag_policy_names[i];
    }
    return 0;
}

/* Apply "<name>=<n>[,<n>...]". Junk is skipped, exactly as armcc does. */
static void diag_policy_apply(const char *name, const char *val) {
    int hide  = (strcmp(name, "--diag_suppress") == 0 ||
                 strcmp(name, "--diag_remark") == 0);
    int force = (strcmp(name, "--diag_error") == 0);
    const char *p = val;

    while (p && *p) {
        int code = 0, digits = 0;
        while (*p == ',' || *p == ' ') p++;
        while (*p >= '0' && *p <= '9') { code = code * 10 + (*p - '0'); p++; digits = 1; }
        if (!digits) { if (*p) p++; continue; }
        if (hide)       diag_suppress(code);
        else if (force) diag_force_error(code);
        /* --diag_warning: accepted, no observable change (measured). */
    }
}

int main(int argc, char **argv) {
    ArkOptions opts;
    int i;
    int rc;
    int cfg_loaded = 0;
    char optbuf[128];

    /* Diagnostics are usable from the first option: a bad flag must be able to
     * report itself before any translation unit is known. */
    diag_init(0, 0);
    reset_opts(&opts);

    if (argc < 2) { usage(); return 1; }

    /* ---- Config system initialization (priority: command-line > config file > compile-time defaults) ---- */
    /* 1) Initialize g_config with compile-time ARKCC_FEATURE_* macros */
    config_init();
    /* 2) Find -config <file> or default arkcc.cfg, load config file */
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
    /* 3) Scan command line -O/-g/-fxxx/-fno-xxx, override file settings */
    config_apply_args(argc, argv);

    /* 4) --diag_style describes how *every* diagnostic is printed, including
     * the ones about options that appear before it (measured: armcc prints
     * "-x --diag_style=ide" in IDE style). Scanning it first is cheaper and
     * less error-prone than making each later check order-aware. */
    for (i = 1; i < argc; i++) {
        const char *a = argv[i];
        if (strncmp(a, "--diag_style=", 13) == 0) {
            if (diag_set_style_name(a + 13) != 0) {
                diag_driver("C3903U", a + 13, "diag_style");
                diag_shutdown();
                return 1;
            }
        } else if (strcmp(a, "--diag_style") == 0 && i + 1 < argc) {
            if (diag_set_style_name(argv[i + 1]) != 0) {
                diag_driver("C3903U", argv[i + 1], "diag_style");
                diag_shutdown();
                return 1;
            }
            i++;
        } else {
            const char *pn = diag_policy_match(a);
            if (pn) {
                int n = (int)strlen(pn);
                if (a[n] == '=') {
                    diag_policy_apply(pn, a + n + 1);
                } else {
                    /* Bare form: armcc refuses it rather than eating the next
                     * argument (measured). */
                    diag_driver("C3901U", pn + 2, "");
                    diag_shutdown();
                    return 1;
                }
            }
        }
    }

    for (i = 1; i < argc; i++) {
        const char *a = argv[i];
        if (strcmp(a, "-S") == 0)            opts.emit_asm = 1;
        else if (strcmp(a, "-c") == 0)       opts.compile_only = 1;
        else if (strcmp(a, "-E") == 0)       opts.preprocess_only = 1;
        else if (strcmp(a, "-v") == 0)       opts.verbose = 1;
        else if (strcmp(a, "-g") == 0)       opts.debug_info = 1;
        else if (strncmp(a, "-O", 2) == 0)   opts.opt_level = (a[2] >= '0' && a[2] <= '9') ? (a[2] - '0') : 0;
        else if (strcmp(a, "-Wno-unused") == 0) opts.no_unused_warn = 1;
        else if (strncmp(a, "-W", 2) == 0) {
            /* armcc has no -W family. Measured: "-Wno-unused" is reported as
             * "Unrecognized option '-no-unused'." -- the W is stripped and the
             * remainder becomes the offending option text. Accepting these
             * silently (as arkc used to) hides a misspelled flag. */
            optbuf[0] = '-';
            strncpy(optbuf + 1, a + 2, sizeof(optbuf) - 2);
            optbuf[sizeof(optbuf) - 1] = 0;
            diag_driver("C3900U", optbuf, "");
            diag_shutdown();
            return 1;
        }
        else if (strcmp(a, "-config") == 0 && i + 1 < argc) {
            /* Already handled above, skip path argument */
            i++;
        }
        else if (a[0] == '-' && a[1] == 'f') {
            /* -fxxx / -fno-xxx: already handled by config_apply_args, silently accepted here */
        }
        else if (strncmp(a, "--diag_style=", 13) == 0) {
            /* Already applied by the pre-scan above. */
        }
        else if (strcmp(a, "--diag_style") == 0 && i + 1 < argc) {
            /* Already applied by the pre-scan above; skip its argument. */
            i++;
        }
        else if (diag_policy_match(a)) {
            /* Already applied by the pre-scan above. */
        }
        else if (a[0] == '-' && strncmp(a, "--errors", 8) == 0 &&
                 (a[8] == '=' || a[8] == 0)) {
            /* --errors[=]<file>: redirect the whole diagnostic stream. */
            const char *path = (a[8] == '=') ? (a + 9)
                             : (i + 1 < argc) ? argv[++i] : 0;
            if (!path || diag_open_sink(path) != 0) {
                diag_report_msg(DIAG_SEV_ERROR, 0,
                                "cannot open diagnostic output file %sq",
                                path ? path : "", 0, 0);
                diag_shutdown();
                return 1;
            }
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
                 strcmp(a, "--data_reorder") == 0 ||
                 strcmp(a, "--remove_unneeded_entities") == 0) {
            /* armcc 5 compatible options: already handled by config_apply_args or silently ignored */
        }
        else if (strcmp(a, "--scatter") == 0 && i + 1 < argc) {
            /* --scatter <file>: path already recorded by config_apply_args into g_config;
             * we also mirror it into opts so ark_compile can consume it. */
            opts.scatter_file = argv[i + 1];
            i++;
        }
        else if ((strcmp(a, "-T") == 0 || strcmp(a, "--linker-script") == 0 ||
                  strcmp(a, "--script") == 0) && i + 1 < argc) {
            /* -T <file> / --linker-script <file>: GNU ld linker script (.ld).
             * Stored in opts so the backend can emit address-aware section placement. */
            opts.linker_script = argv[++i];
        }
        else if (strcmp(a, "--uvprojx") == 0 && i + 1 < argc) {
            /* --uvprojx <file>: MDK project file. Auto-extracts -I and -D
             * from <Cads><VariousControls><IncludePath>/<Define> and injects
             * them into opts.include_dirs / opts.pre_defines. */
            opts.uvprojx = argv[++i];
            parse_uvprojx(opts.uvprojx, &opts);
        }
        else if (strcmp(a, "--fpu") == 0 && i + 1 < argc) {
            /* --fpu <name>: already handled by config_apply_args, skip argument here */
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
        else if (strncmp(a, "--cpu=", 6) == 0) {
            opts.cpu = a + 6;
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
        else if (strcmp(a, "--vector-table") == 0) {
            opts.vector_table = 1;
        }
        else if (strcmp(a, "-link") == 0) {
            opts.link_mode = 1;
            /* Collect following non -o/non-option arguments as inputs */
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
        else if (strcmp(a, "-D") == 0 && i + 1 < argc) {
            /* -D NAME or -D NAME=VALUE: space-separated form */
            if (opts.pre_define_count < 64)
                opts.pre_defines[opts.pre_define_count++] = argv[++i];
        }
        else if (strncmp(a, "-D", 2) == 0 && a[2] != 0) {
            /* -DNAME or -DNAME=VALUE: attached form */
            if (opts.pre_define_count < 64)
                opts.pre_defines[opts.pre_define_count++] = a + 2;
        }
        else if (a[0] == '-') {
            /* Unknown options are fatal, as in armcc. Silently ignoring them
             * means a typo ("-targt arm") compiles with the wrong settings and
             * the user never learns. */
            diag_driver("C3900U", a, "");
            diag_shutdown();
            return 1;
        }
        else {
            opts.input_path = a;
        }
    }
    /* armcc validates the CPU name at option-processing time and stops with a
     * driver diagnostic:  Fatal error: C3903U: Argument 'x' not permitted for
     * option 'cpu'.  Doing it here (not in the backend) keeps the failure ahead
     * of any file access and independent of the selected backend. */
    if (opts.cpu && !cpu_lookup(opts.cpu)) {
        diag_driver("C3903U", opts.cpu, "cpu");
        diag_shutdown();
        return 1;
    }

    if (opts.verbose) config_print();
    if (!opts.list_backends && !opts.input_path && !opts.link_mode) {
        usage();
        diag_shutdown();
        return 1;
    }

    /* From here on the translation unit name is known, so diagnostics can be
     * reported the way armcc does:  "no source": Error: command-line: ...
     * followed by "<file>: 0 warnings, N errors". */
    diag_init(opts.input_path, 0);

    /* -D validation, after the whole command line is scanned: armcc reports a
     * malformed define as a command-line diagnostic and still prints the
     * summary line for the input file. Anything after '=' is not checked. */
    for (i = 0; i < opts.pre_define_count; i++) {
        if (!valid_define(opts.pre_defines[i])) {
            diag_command_line(992, DIAG_SEV_ERROR, opts.pre_defines[i], 0, 0);
            diag_shutdown();
            return 1;
        }
    }
#if ARKCC_FEATURE_SCATTER
    /* Parse --scatter <file> (ARM .sct) and/or -T <file> (GNU ld .ld) into a
     * ScatterDesc. The parsed regions are consumed by ark_compile (passed via
     * opts.scatter_file / opts.linker_script) so the ARM backend can place
     * sections at scatter-defined addresses and emit a matching linker script. */
    if (g_config.scatter_file) {
        opts.scatter_file = g_config.scatter_file;
    }
#endif
    rc = ark_compile(&opts);
    if (rc != ARK_OK && diag_errors() == 0) {
        /* Failures that never reached the diagnostic layer still need a
         * reason; failures that did produce diagnostics already explained
         * themselves, and the summary line closes the output. */
        fprintf(stderr, "[arkcc] failed with code %d\n", rc);
    }
    diag_shutdown();
    /* A diagnostic that reached the user is a failure even if the driver
     * carried on to the end: exiting 0 here would let a broken build pass. */
    return (rc == ARK_OK && diag_errors() == 0) ? 0 : 1;
}
