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
#include "pipeline.h"
#include "memory.h"
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
        "  --ipo a.c b.c      whole-program compile: several sources, one\n"
        "                     translation-unit-independent program (alias -flto).\n"
        "                     Statics stay file-local, cross-file calls can be\n"
        "                     inlined at -O2.  Needs -o; refuses -c/-E/-g/-link.\n"
        "  --vector-table     reserve ARM_VT_SIZE (0x400) at the front of the image and\n"
        "                     emit a Cortex-M vector table there.  Link addresses stay\n"
        "                     valid: nothing is shifted, unlike the implicit table.\n"
        "  --reloc-text       correct absolute addresses baked into MOVW/MOVT pairs at\n"
        "                     link time (string literals and other in-section labels).\n"
        "                     Off by default; required for multi-object images whose\n"
        "                     objects were compiled against a different base.\n"
#if ARKCC_FEATURE_MEMLINT
        "  --warn-mem         warn about the address of an automatic object returned\n"
        "                     from a function, about free() on an already freed\n"
        "                     pointer, and about dereferencing one (intra-procedural;\n"
        "                     off by default, silent about escaped pointers).\n"
#endif
#if ARKCC_FEATURE_ENUMCHECK
        "  --warn-enum        warn about a switch over an enum that has no case for\n"
        "                     every enumerator and no default label (off by default).\n"
#endif
#if ARKCC_FEATURE_UNUSEDRESULT
        "  --warn-unused-result  warn when the value of a call is discarded although\n"
        "                     the callee is declared warn_unused_result / __must_check\n"
        "                     ((void) cast silences it; off by default).\n"
#endif
#if ARKCC_FEATURE_MIR
        "  --warn-unreachable  warn about basic blocks no path from the entry can\n"
        "                     reach, with the number of dead instructions\n"
        "                     (off by default).\n"
        "  --warn-unused-static  warn about a static function in this file that\n"
        "                     nothing calls and whose address never escapes\n"
        "                     (off by default; silent if the file has inline asm).\n"
        "  --warn-recursion   warn about a call cycle among this file's functions:\n"
        "                     its stack depth is decided by the input (off by default).\n"
#endif
        "  -v                 verbose\n"
        "  -target <name>     select backend (arm|x86|x86_64|riscv32|c)\n"
        "  -I <dir>           additional include path\n"
        "  -O0/-O1/-O2        optimisation level: IR constant folding + dead code\n"
        "                     elimination; -O2 also enables inline/vectorise\n"
        "  --pipeline=lite|full  which stages of the pass pipeline may run.  full\n"
        "                     (the default) lets every stage follow its own switch\n"
        "                     and -O level, i.e. the historical behaviour; lite\n"
        "                     keeps only the cheap stages and records why the rest\n"
        "                     were skipped\n"
        "  --print-pipeline   print the resolved stage table (run/skip + reason)\n"
        "                     and exit\n"
#if ARKCC_FEATURE_SIZEWEIGHT
        "  --size-weight=N    size/speed balance for the four optimiser thresholds,\n"
        "                     N = 0..9: 0 favours speed (more inlining, more\n"
        "                     unrolling), 9 favours size, 5 (default) is the\n"
        "                     historical behaviour.  The -O level is not touched.\n"
#endif
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
        "  --diag_style <s>   diagnostic layout: arm (default) | gnu | ide | modern\n"
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
                        while (p < end && opts->include_dir_count < ARK_PP_MAX_INC_DIRS) {
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
                                    if (opts->pre_define_count >= ARK_MAX_PRE_DEFINES) {
                                        /* parse_uvprojx returns void and its caller keeps
                                         * going, so stopping the process is the only way
                                         * to keep a half-imported project from compiling. */
                                        fprintf(stderr,
                                                "Fatal error: C3900U: more than %d macro "
                                                "definitions in %s; raise "
                                                "ARK_MAX_PRE_DEFINES and rebuild arkcc\n",
                                                (int)ARK_MAX_PRE_DEFINES, uvprojx_path);
                                        exit(1);
                                    }
                                    {
                                        char *dup = (char *)malloc(strlen(tmp) + 1);
                                        if (dup) { strcpy(dup, tmp); }
                                        opts->pre_defines[opts->pre_define_count++] = dup;
                                    }
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
    /* Same reason as the board's opts_reset(): this struct grows every
     * release and `ArkOptions opts;` in main() is stack memory.  Zeroing the
     * whole thing first means a newly added field is 0 even if nobody
     * remembered to list it here.  The assignments below are kept so this
     * function still reads as the authoritative default table. */
    memset(o, 0, sizeof(*o));
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
    for (i = 0; i < ARK_LINK_MAX_OBJS; i++) o->link_inputs[i] = 0;
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
    for (i = 0; i < ARK_MAX_PRE_DEFINES; i++) o->pre_defines[i] = 0;
    o->pre_define_count = 0;
    o->uvprojx = 0;
    /* 0.8.0：新增字段必须在这里清零。漏了它们时 build_date/build_time 是栈上
     * 残留，`opts->build_date || opts->build_time` 恒真，于是 __DATE__ 被一段
     * 随机的"看起来像日期"的内存覆盖——2026-11-06 那次实测输出过 "Oct 12 1495"。 */
    o->build_date = 0;
    o->build_time = 0;
    o->build_epoch = 0;
    o->print_pipeline = 0;
    /* 0.8.7 --ipo: the source list.  Zeroed here for the same reason every
     * other field is: a stale count would read --ipo inputs out of stack. */
    o->ipo_mode = 0;
    for (i = 0; i < ARK_LINK_MAX_OBJS; i++) o->ipo_inputs[i] = 0;
    o->ipo_input_count = 0;
    o->obj_ir = 0;
    o->lto_link = 0;
    o->partial_link = 0;
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
    int npos = 0;   /* positional arguments seen (--ipo input count) */
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
            diag_note("run arkcc --help for the options this build understands");
            diag_shutdown();
            return 1;
        }
        else if (strcmp(a, "-config") == 0 && i + 1 < argc) {
            /* Already handled above, skip path argument */
            i++;
        }
#if !ARKCC_FEATURE_OPT_VSTACK
        /* A build cropped with -DARKCC_FEATURE_OPT_VSTACK=0 has no pass to
         * run, so accepting -fopt-vstack there would be a silent no-op.
         * Refuse the enabling spellings by name; the -fno- forms stay
         * harmless, same convention as --autoinline above. */
        else if (strcmp(a, "-fopt-vstack") == 0 || strcmp(a, "-fvstack") == 0) {
            fprintf(stderr,
                    "Fatal error: C3900U: -fopt-vstack is not compiled into "
                    "this build (rebuild with -DARKCC_FEATURE_OPT_VSTACK=1)\n");
            return 1;
        }
#endif
#if !ARKCC_FEATURE_OPT_ADDR
        else if (strcmp(a, "-fopt-addr") == 0) {
            fprintf(stderr,
                    "Fatal error: C3900U: -fopt-addr is not compiled into "
                    "this build (rebuild with -DARKCC_FEATURE_OPT_ADDR=1)\n");
            return 1;
        }
#endif
#if !ARKCC_FEATURE_OPT_STRENGTH
        else if (strcmp(a, "-fopt-strength") == 0) {
            fprintf(stderr,
                    "Fatal error: C3900U: -fopt-strength is not compiled into "
                    "this build (rebuild with -DARKCC_FEATURE_OPT_STRENGTH=1)\n");
            return 1;
        }
#endif
#if !ARKCC_FEATURE_OPT_CBZ
        else if (strcmp(a, "-fopt-cbz") == 0) {
            fprintf(stderr,
                    "Fatal error: C3900U: -fopt-cbz is not compiled into "
                    "this build (rebuild with -DARKCC_FEATURE_OPT_CBZ=1)\n");
            return 1;
        }
#endif
#if !ARKCC_FEATURE_OPT_BRANCH
        else if (strcmp(a, "-fopt-branch") == 0) {
            fprintf(stderr,
                    "Fatal error: C3900U: -fopt-branch is not compiled into "
                    "this build (rebuild with -DARKCC_FEATURE_OPT_BRANCH=1)\n");
            return 1;
        }
#endif
#if !ARKCC_FEATURE_OPT_IMM
        else if (strcmp(a, "-fopt-imm") == 0) {
            fprintf(stderr,
                    "Fatal error: C3900U: -fopt-imm is not compiled into "
                    "this build (rebuild with -DARKCC_FEATURE_OPT_IMM=1)\n");
            return 1;
        }
#endif
#if !ARKCC_FEATURE_OPT_PEEP
        else if (strcmp(a, "-fopt-peep") == 0) {
            fprintf(stderr,
                    "Fatal error: C3900U: -fopt-peep is not compiled into "
                    "this build (rebuild with -DARKCC_FEATURE_OPT_PEEP=1)\n");
            return 1;
        }
#endif
#if !ARKCC_FEATURE_OPT_CBRANCH
        else if (strcmp(a, "-fopt-cbranch") == 0) {
            fprintf(stderr,
                    "Fatal error: C3900U: -fopt-cbranch is not compiled into "
                    "this build (rebuild with -DARKCC_FEATURE_OPT_CBRANCH=1)\n");
            return 1;
        }
#endif
#if !ARKCC_FEATURE_OPT_COPYPROP
        else if (strcmp(a, "-fopt-copyprop") == 0) {
            fprintf(stderr,
                    "Fatal error: C3900U: -fopt-copyprop is not compiled into "
                    "this build (rebuild with -DARKCC_FEATURE_OPT_COPYPROP=1)\n");
            return 1;
        }
#endif
#if !ARKCC_FEATURE_OPT_LIVE
        else if (strcmp(a, "-fopt-live") == 0) {
            fprintf(stderr,
                    "Fatal error: C3900U: -fopt-live is not compiled into "
                    "this build (rebuild with -DARKCC_FEATURE_OPT_LIVE=1)\n");
            return 1;
        }
#endif
#if !ARKCC_FEATURE_OPT_SPILL
        else if (strcmp(a, "-fopt-spill") == 0) {
            fprintf(stderr,
                    "Fatal error: C3900U: -fopt-spill is not compiled into "
                    "this build (rebuild with -DARKCC_FEATURE_OPT_SPILL=1)\n");
            return 1;
        }
#endif
#if !ARKCC_FEATURE_OPT_PAIR
        else if (strcmp(a, "-fopt-pair") == 0) {
            fprintf(stderr,
                    "Fatal error: C3900U: -fopt-pair is not compiled into "
                    "this build (rebuild with -DARKCC_FEATURE_OPT_PAIR=1)\n");
            return 1;
        }
#endif
#if !ARKCC_FEATURE_OPT_PROP
        else if (strcmp(a, "-fopt-prop") == 0) {
            fprintf(stderr,
                    "Fatal error: C3900U: -fopt-prop is not compiled into "
                    "this build (rebuild with -DARKCC_FEATURE_OPT_PROP=1)\n");
            return 1;
        }
#endif
#if !ARKCC_FEATURE_OPT_DEADPUSH
        else if (strcmp(a, "-fopt-deadpush") == 0) {
            fprintf(stderr,
                    "Fatal error: C3900U: -fopt-deadpush is not compiled into "
                    "this build (rebuild with -DARKCC_FEATURE_OPT_DEADPUSH=1)\n");
            return 1;
        }
#endif
#if !ARKCC_FEATURE_OPT_CMAT
        else if (strcmp(a, "-fopt-cmat") == 0) {
            fprintf(stderr,
                    "Fatal error: C3900U: -fopt-cmat is not compiled into "
                    "this build (rebuild with -DARKCC_FEATURE_OPT_CMAT=1)\n");
            return 1;
        }
#endif
#if !ARKCC_FEATURE_OPT_SLOTREG
        else if (strcmp(a, "-fopt-slotreg") == 0) {
            fprintf(stderr,
                    "Fatal error: C3900U: -fopt-slotreg is not compiled into "
                    "this build (rebuild with -DARKCC_FEATURE_OPT_SLOTREG=1)\n");
            return 1;
        }
#endif
#if !ARKCC_FEATURE_OPT_FRAME
        else if (strcmp(a, "-fopt-frame") == 0) {
            fprintf(stderr,
                    "Fatal error: C3900U: -fopt-frame is not compiled into "
                    "this build (rebuild with -DARKCC_FEATURE_OPT_FRAME=1)\n");
            return 1;
        }
#endif
#if !ARKCC_FEATURE_OPT_VOLDBM
        else if (strcmp(a, "-fopt-voldmb") == 0) {
            fprintf(stderr,
                    "Fatal error: C3900U: -fopt-voldmb is not compiled into "
                    "this build (rebuild with -DARKCC_FEATURE_OPT_VOLDBM=1)\n");
            return 1;
        }
#endif
#if !ARKCC_FEATURE_OPT_CONSTCOND
        else if (strcmp(a, "-fopt-constcond") == 0) {
            fprintf(stderr,
                    "Fatal error: C3900U: -fopt-constcond is not compiled into "
                    "this build (rebuild with -DARKCC_FEATURE_OPT_CONSTCOND=1)\n");
            return 1;
        }
#endif
#if !ARKCC_FEATURE_OPT_BOOLMAT
        else if (strcmp(a, "-fopt-boolmat") == 0) {
            fprintf(stderr,
                    "Fatal error: C3900U: -fopt-boolmat is not compiled into "
                    "this build (rebuild with -DARKCC_FEATURE_OPT_BOOLMAT=1)\n");
            return 1;
        }
#endif
#if !ARKCC_FEATURE_OPT_EXIT
        else if (strcmp(a, "-fopt-exit") == 0) {
            fprintf(stderr,
                    "Fatal error: C3900U: -fopt-exit is not compiled into "
                    "this build (rebuild with -DARKCC_FEATURE_OPT_EXIT=1)\n");
            return 1;
        }
#endif
#if !ARKCC_FEATURE_OPT_BITMASK
        else if (strcmp(a, "-fopt-bitmask") == 0) {
            fprintf(stderr,
                    "Fatal error: C3900U: -fopt-bitmask is not compiled into "
                    "this build (rebuild with -DARKCC_FEATURE_OPT_BITMASK=1)\n");
            return 1;
        }
#endif
#if !ARKCC_FEATURE_OPT_VOLBAR
        else if (strcmp(a, "-fopt-volbar") == 0) {
            fprintf(stderr,
                    "Fatal error: C3900U: -fopt-volbar is not compiled into "
                    "this build (rebuild with -DARKCC_FEATURE_OPT_VOLBAR=1)\n");
            return 1;
        }
#endif
#if !ARKCC_FEATURE_OPT_VREG
        else if (strcmp(a, "-fopt-vreg") == 0) {
            fprintf(stderr,
                    "Fatal error: C3900U: -fopt-vreg is not compiled into "
                    "this build (rebuild with -DARKCC_FEATURE_OPT_VREG=1)\n");
            return 1;
        }
#endif
#if !ARKCC_FEATURE_OPT_LITPOOL
        else if (strcmp(a, "-fopt-litpool") == 0) {
            fprintf(stderr,
                    "Fatal error: C3900U: -fopt-litpool is not compiled into "
                    "this build (rebuild with -DARKCC_FEATURE_OPT_LITPOOL=1)\n");
            return 1;
        }
#endif
#if !ARKCC_FEATURE_OPT_COALESCE
        else if (strcmp(a, "-fopt-coalesce") == 0) {
            fprintf(stderr,
                    "Fatal error: C3900U: -fopt-coalesce is not compiled into "
                    "this build (rebuild with -DARKCC_FEATURE_OPT_COALESCE=1)\n");
            return 1;
        }
#endif
#if !ARKCC_FEATURE_OPT_CONSTCACHE
        else if (strcmp(a, "-fopt-constcache") == 0) {
            fprintf(stderr,
                    "Fatal error: C3900U: -fopt-constcache is not compiled into "
                    "this build (rebuild with -DARKCC_FEATURE_OPT_CONSTCACHE=1; "
                    "it also needs -DARKCC_FEATURE_OPT_REGALLOC=1, which owns "
                    "the PUSH/POP widening and the frame offset shift)\n");
            return 1;
        }
#endif
        else if (a[0] == '-' && a[1] == 'f') {
            /* -fxxx / -fno-xxx is applied by config_apply_args().  gcc-style
             * names it does not know are ignored there on purpose, so gcc
             * command lines keep working.  -fopt-* is a different matter: that
             * family is ours, so a name in it that matches no pass is a
             * misspelling, and compiling with it silently dropped would be the
             * one answer this compiler never gives. */
            const char *bad = config_unknown_fopt();
            if (bad) {
                diag_driver("C3900U", bad, "");
                diag_note("run arkcc --help for the passes this build understands");
                diag_shutdown();
                return 1;
            }
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
#if !ARKCC_FEATURE_OPT_INLINE
        /* A build without the pass must refuse the flag by name instead
         * of accepting it and emitting calls.  Only the explicit option:
         * -O2 also sets the flag, and a cropped build is allowed to
         * compile at -O2 with the pass simply absent (same as every other
         * trimmed pass). */
        else if (strcmp(a, "--autoinline") == 0) {
            fprintf(stderr,
                    "Fatal error: C3900U: --autoinline is not compiled into "
                    "this build (rebuild with -DARKCC_FEATURE_OPT_INLINE=1)\n");
            return 1;
        }
#endif
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
            if (opts.include_dir_count < ARK_PP_MAX_INC_DIRS) {
                opts.include_dirs[opts.include_dir_count++] = argv[++i];
            } else {
                /* Silence here means the header is "not found" later even
                 * though the path was on the command line. */
                fprintf(stderr,
                        "Fatal error: C3900U: more than %d -I search paths; "
                        "raise ARK_PP_MAX_INC_DIRS and rebuild arkcc\n",
                        (int)ARK_PP_MAX_INC_DIRS);
                return 1;
            }
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
        else if (strcmp(a, "--ipo") == 0 || strcmp(a, "-flto") == 0) {
            /* 0.8.7: whole-program compile.  Only marks the mode here; the
             * source list is the positional arguments, in command-line order,
             * which the parser records as it goes (see the last branch). */
            opts.ipo_mode = 1;
        }
#if ARKCC_FEATURE_OBJ_IR
        else if (strcmp(a, "--obj-ir") == 0)   opts.obj_ir = 1;
        else if (strcmp(a, "--no-obj-ir") == 0) opts.obj_ir = 0;
        else if (strcmp(a, "--lto") == 0)      opts.lto_link = 1;
#else
        else if (strcmp(a, "--obj-ir") == 0 || strcmp(a, "--lto") == 0) {
            fprintf(stderr,
                    "Fatal error: C3900U: %s is not compiled into this build "
                    "(rebuild with -DARKCC_FEATURE_OBJ_IR=1)\n", a);
            return 1;
        }
        else if (strcmp(a, "--no-obj-ir") == 0) opts.obj_ir = 0;
#endif
        else if (strcmp(a, "-r") == 0) {
#if ARKCC_FEATURE_PARTIAL_LINK
            /* Partial link: a modifier on -link, validated after the whole
             * command line is known (it needs -o and at least one object).
             * Accepted here so that `-r -link a.o b.o -o x.o` and
             * `-link a.o b.o -r -o x.o` mean the same thing. */
            opts.partial_link = 1;
#else
            fprintf(stderr,
                    "Fatal error: C3900U: -r is not compiled into this "
                    "build (rebuild with -DARKCC_FEATURE_PARTIAL_LINK=1)\n");
            return 1;
#endif
        }
        else if (strcmp(a, "-link") == 0) {
            opts.link_mode = 1;
            /* Collect following non -o/non-option arguments as inputs */
            while (i + 1 < argc) {
                const char *nx = argv[i + 1];
                if (nx[0] == '-') break;
                if (opts.link_input_count < ARK_LINK_MAX_OBJS) {
                    opts.link_inputs[opts.link_input_count++] = nx;
                } else {
                    /* Dropping an object here produces an image that exits 0
                     * but is missing code; refuse instead. */
                    fprintf(stderr,
                            "Fatal error: C3900U: more than %d -link inputs; "
                            "raise ARK_LINK_MAX_OBJS and rebuild arkcc\n",
                            (int)ARK_LINK_MAX_OBJS);
                    return 1;
                }
                i++;
            }
        }
        else if (strcmp(a, "--build-date") == 0 && i + 1 < argc) opts.build_date = argv[++i];
        else if (strcmp(a, "--build-time") == 0 && i + 1 < argc) opts.build_time = argv[++i];
        else if (strcmp(a, "--source-date-epoch") == 0 && i + 1 < argc) {
            const char *p = argv[++i];
            long long v = 0;
            while (*p >= '0' && *p <= '9') { v = v * 10 + (*p - '0'); p++; }
            opts.build_epoch = v;
        }
        else if (strncmp(a, "--pipeline=", 11) == 0) {
            /* Refusing beats guessing: an unknown profile must not fall back
             * to "full", because the caller would then believe trimming
             * happened when it did not. */
            int prof = pipeline_profile_parse(a + 11);
            if (prof < 0) {
                fprintf(stderr,
                        "Fatal error: C3900U: unknown pipeline \"%s\" "
                        "(expected lite or full)\n", a + 11);
                return 1;
            }
            g_config.pipeline_profile = prof;
        }
        else if (strcmp(a, "--print-pipeline") == 0) opts.print_pipeline = 1;
#if ARKCC_FEATURE_SIZEWEIGHT
        else if (strcmp(a, "--size-weight") == 0 ||
                 strncmp(a, "--size-weight=", 14) == 0) {
            /* 不夹紧、不猜：把 42 或 fast 静默当成 5 会让调用方以为已经按某个
             * 平衡编译过了，而实际上一个字都没变。 */
            const char *v = (a[13] == '=') ? a + 14 : "";
            const char *p = v;
            int w = 0;
            int ok = (*p != 0);
            while (ok && *p) {
                if (*p < '0' || *p > '9') { ok = 0; break; }
                w = w * 10 + (*p - '0');
                if (w > 99) { ok = 0; break; }
                p++;
            }
            if (!ok || w > 9) {
                fprintf(stderr,
                        "Fatal error: C3900U: --size-weight expects 0..9 "
                        "(got \"%s\")\n", v);
                return 1;
            }
            g_config.size_weight = w;
        }
#else
        else if (strncmp(a, "--size-weight", 13) == 0) {
            fprintf(stderr,
                    "Fatal error: C3900U: --size-weight is not compiled into "
                    "this build (no host optimisation pass is enabled)\n");
            return 1;
        }
#endif
        else if (strcmp(a, "--dce-cfg") == 0)       g_config.enable_dce_cfg = 1;
        else if (strcmp(a, "--no-dce-cfg") == 0)    g_config.enable_dce_cfg = 0;
        else if (strcmp(a, "--reloc-data") == 0)    g_config.enable_reloc_data = 1;
        else if (strcmp(a, "--no-reloc-data") == 0) g_config.enable_reloc_data = 0;
        else if (strcmp(a, "--reloc-text") == 0)    g_config.enable_reloc_text = 1;
        else if (strcmp(a, "--no-reloc-text") == 0) g_config.enable_reloc_text = 0;
        else if (strcmp(a, "--reg-top") == 0)       g_config.enable_reg_top = 1;
        else if (strcmp(a, "--no-reg-top") == 0)    g_config.enable_reg_top = 0;
        else if (strcmp(a, "--rt-lazy") == 0)       g_config.enable_rt_lazy = 1;
        else if (strcmp(a, "--no-rt-lazy") == 0)    g_config.enable_rt_lazy = 0;
        else if (strcmp(a, "--asm-extra") == 0)     g_config.enable_asm_extra = 1;
        else if (strcmp(a, "--no-asm-extra") == 0)  g_config.enable_asm_extra = 0;
#if ARKCC_FEATURE_ENUMCHECK
        else if (strcmp(a, "--warn-enum") == 0)     g_config.enable_enumcheck = 1;
        else if (strcmp(a, "--no-warn-enum") == 0)  g_config.enable_enumcheck = 0;
#else
        /* Same rule as --warn-mem below: refusing beats accepting an option that
         * would claim a check this build cannot run. */
        else if (strcmp(a, "--warn-enum") == 0) {
            fprintf(stderr,
                    "Fatal error: C3900U: --warn-enum is not compiled into this "
                    "build (rebuild with -DARKCC_FEATURE_ENUMCHECK=1)\n");
            return 1;
        }
        else if (strcmp(a, "--no-warn-enum") == 0)  g_config.enable_enumcheck = 0;
#endif
#if ARKCC_FEATURE_MEMLINT
        else if (strcmp(a, "--warn-mem") == 0)      g_config.enable_memlint = 1;
        else if (strcmp(a, "--no-warn-mem") == 0)   g_config.enable_memlint = 0;
#else
        /* Refusing beats ignoring: a build without the pass must not accept the
         * option and then behave as if memory had been checked. */
        else if (strcmp(a, "--warn-mem") == 0) {
            fprintf(stderr,
                    "Fatal error: C3900U: --warn-mem is not compiled into this "
                    "build (rebuild with -DARKCC_FEATURE_MEMLINT=1)\n");
            return 1;
        }
        /* Safe direction, no pass needed: asking for the default is not a
         * request to check anything. */
        else if (strcmp(a, "--no-warn-mem") == 0)   g_config.enable_memlint = 0;
#endif
#if ARKCC_FEATURE_UNUSEDRESULT
        else if (strcmp(a, "--warn-unused-result") == 0)    g_config.enable_unused_result = 1;
        else if (strcmp(a, "--no-warn-unused-result") == 0) g_config.enable_unused_result = 0;
#else
        else if (strcmp(a, "--warn-unused-result") == 0) {
            fprintf(stderr,
                    "Fatal error: C3900U: --warn-unused-result is not compiled "
                    "into this build (rebuild with "
                    "-DARKCC_FEATURE_UNUSEDRESULT=1)\n");
            return 1;
        }
        else if (strcmp(a, "--no-warn-unused-result") == 0) g_config.enable_unused_result = 0;
#endif
#if ARKCC_FEATURE_MIR
        else if (strcmp(a, "--warn-unreachable") == 0)       g_config.enable_warn_unreachable = 1;
        else if (strcmp(a, "--no-warn-unreachable") == 0)    g_config.enable_warn_unreachable = 0;
        else if (strcmp(a, "--warn-unused-static") == 0)     g_config.enable_warn_unused_static = 1;
        else if (strcmp(a, "--no-warn-unused-static") == 0)  g_config.enable_warn_unused_static = 0;
        else if (strcmp(a, "--warn-recursion") == 0)         g_config.enable_warn_recursion = 1;
        else if (strcmp(a, "--no-warn-recursion") == 0)      g_config.enable_warn_recursion = 0;
#else
        /* Refusing beats ignoring: a build without the checks must not accept
         * the option and then behave as if control flow had been analysed. */
        else if (strcmp(a, "--warn-unreachable") == 0 ||
                 strcmp(a, "--warn-unused-static") == 0 ||
                 strcmp(a, "--warn-recursion") == 0) {
            fprintf(stderr,
                    "Fatal error: C3900U: %s is not compiled into this build "
                    "(rebuild with -DARKCC_FEATURE_MIR=1)\n", a);
            return 1;
        }
        else if (strcmp(a, "--no-warn-unreachable") == 0)    g_config.enable_warn_unreachable = 0;
        else if (strcmp(a, "--no-warn-unused-static") == 0)  g_config.enable_warn_unused_static = 0;
        else if (strcmp(a, "--no-warn-recursion") == 0)      g_config.enable_warn_recursion = 0;
#endif
#if ARKCC_FEATURE_LICM
        else if (strcmp(a, "--licm") == 0)          g_config.enable_licm = 1;
        else if (strcmp(a, "--no-licm") == 0)       g_config.enable_licm = 0;
#else
        /* 与 --warn-mem 同一条规矩：没有这个 pass 的构建不能接受选项，
         * 否则用户会以为自己打开了循环不变量外提。 */
        else if (strcmp(a, "--licm") == 0) {
            fprintf(stderr,
                    "Fatal error: C3900U: --licm is not compiled into this "
                    "build (rebuild with -DARKCC_FEATURE_LICM=1)\n");
            return 1;
        }
        else if (strcmp(a, "--no-licm") == 0)       g_config.enable_licm = 0;
#endif
#if ARKCC_FEATURE_UNROLL
        else if (strcmp(a, "--unroll") == 0)        g_config.enable_unroll = 1;
        else if (strcmp(a, "--no-unroll") == 0)     g_config.enable_unroll = 0;
#else
        else if (strcmp(a, "--unroll") == 0) {
            fprintf(stderr,
                    "Fatal error: C3900U: --unroll is not compiled into this "
                    "build (rebuild with -DARKCC_FEATURE_UNROLL=1)\n");
            return 1;
        }
        else if (strcmp(a, "--no-unroll") == 0)     g_config.enable_unroll = 0;
#endif
#if ARKCC_FEATURE_TAILMERGE
        else if (strcmp(a, "--tailmerge") == 0)      g_config.enable_tailmerge = 1;
        else if (strcmp(a, "--no-tailmerge") == 0)   g_config.enable_tailmerge = 0;
#else
        else if (strcmp(a, "--tailmerge") == 0) {
            fprintf(stderr,
                    "Fatal error: C3900U: --tailmerge is not compiled into this "
                    "build (rebuild with -DARKCC_FEATURE_TAILMERGE=1)\n");
            return 1;
        }
        else if (strcmp(a, "--no-tailmerge") == 0)   g_config.enable_tailmerge = 0;
#endif
#if ARKCC_FEATURE_XBLOCK
        else if (strcmp(a, "--xblock") == 0)         g_config.enable_xblock = 1;
        else if (strcmp(a, "--no-xblock") == 0)      g_config.enable_xblock = 0;
#else
        else if (strcmp(a, "--xblock") == 0) {
            fprintf(stderr,
                    "Fatal error: C3900U: --xblock is not compiled into this "
                    "build (rebuild with -DARKCC_FEATURE_XBLOCK=1)\n");
            return 1;
        }
        else if (strcmp(a, "--no-xblock") == 0)      g_config.enable_xblock = 0;
#endif
#if ARKCC_FEATURE_TAILCALL
        else if (strcmp(a, "--tailcall") == 0)       g_config.enable_tailcall = 1;
        else if (strcmp(a, "--no-tailcall") == 0)    g_config.enable_tailcall = 0;
#else
        else if (strcmp(a, "--tailcall") == 0) {
            fprintf(stderr,
                    "Fatal error: C3900U: --tailcall is not compiled into this "
                    "build (rebuild with -DARKCC_FEATURE_TAILCALL=1)\n");
            return 1;
        }
        else if (strcmp(a, "--no-tailcall") == 0)    g_config.enable_tailcall = 0;
#endif
#if ARKCC_FEATURE_DIVCONST
        else if (strcmp(a, "--divconst") == 0)       g_config.enable_divconst = 1;
        else if (strcmp(a, "--no-divconst") == 0)    g_config.enable_divconst = 0;
#else
        else if (strcmp(a, "--divconst") == 0) {
            fprintf(stderr,
                    "Fatal error: C3900U: --divconst is not compiled into this "
                    "build (rebuild with -DARKCC_FEATURE_DIVCONST=1)\n");
            return 1;
        }
        else if (strcmp(a, "--no-divconst") == 0)    g_config.enable_divconst = 0;
#endif
#if ARKCC_FEATURE_CONST_GLOBAL
        else if (strcmp(a, "--const-global") == 0)    g_config.enable_const_global = 1;
        else if (strcmp(a, "--no-const-global") == 0) g_config.enable_const_global = 0;
#else
        else if (strcmp(a, "--const-global") == 0) {
            fprintf(stderr,
                    "Fatal error: C3900U: --const-global is not compiled into "
                    "this build (rebuild with -DARKCC_FEATURE_CONST_GLOBAL=1)\n");
            return 1;
        }
        else if (strcmp(a, "--no-const-global") == 0) g_config.enable_const_global = 0;
#endif
        else if (strcmp(a, "--list-backends") == 0) opts.list_backends = 1;
        else if (strcmp(a, "-h") == 0 || strcmp(a, "--help") == 0) {
            usage();
            return 0;
        }
        else if (strcmp(a, "-D") == 0 && i + 1 < argc) {
            /* -D NAME or -D NAME=VALUE: space-separated form. Refusing here
             * matters: silently skipping the body would leave NAME to be parsed
             * as the input file, which reports a missing file instead. */
            if (opts.pre_define_count >= ARK_MAX_PRE_DEFINES) {
                fprintf(stderr,
                        "Fatal error: C3900U: more than %d macro definitions; "
                        "raise ARK_MAX_PRE_DEFINES and rebuild arkcc\n",
                        (int)ARK_MAX_PRE_DEFINES);
                return 1;
            }
            opts.pre_defines[opts.pre_define_count++] = argv[++i];
        }
        else if (strncmp(a, "-D", 2) == 0 && a[2] != 0) {
            /* -DNAME or -DNAME=VALUE: attached form */
            if (opts.pre_define_count >= ARK_MAX_PRE_DEFINES) {
                fprintf(stderr,
                        "Fatal error: C3900U: more than %d macro definitions; "
                        "raise ARK_MAX_PRE_DEFINES and rebuild arkcc\n",
                        (int)ARK_MAX_PRE_DEFINES);
                return 1;
            }
            opts.pre_defines[opts.pre_define_count++] = a + 2;
        }
        else if (a[0] == '-') {
            /* Unknown options are fatal, as in armcc. Silently ignoring them
             * means a typo ("-targt arm") compiles with the wrong settings and
             * the user never learns. */
            diag_driver("C3900U", a, "");
            diag_note("run arkcc --help for the options this build understands");
            diag_shutdown();
            return 1;
        }
        else {
            /* 0.8.7 --ipo: every positional argument is remembered in
             * command-line order, because the whole-program compile cannot
             * guess the list from one name.  Without --ipo the last one still
             * wins (historical behaviour), so nothing changes for it. */
            npos++;
            if (opts.ipo_input_count < ARK_LINK_MAX_OBJS)
                opts.ipo_inputs[opts.ipo_input_count++] = a;
            opts.input_path = a;
        }
    }
    if (opts.partial_link) {
        /* -r produces an object, not an image.  Each refusal below is a way
         * to get an answer that looks fine and is not: an image written under
         * the name of an object, a recompiled --lto merge, or lower-stage
         * flags silently ignored. */
        if (!opts.link_mode) {
            fprintf(stderr,
                    "Fatal error: C3900U: -r needs -link (a partial link takes "
                    "objects: arkcc -r -link a.o b.o -o out.ark_obj)\n");
            return 1;
        }
        if (opts.lto_link) {
            fprintf(stderr,
                    "Fatal error: C3900U: -r and --lto are two different "
                    "links: -r merges machine code, --lto recompiles IR; pick "
                    "one\n");
            return 1;
        }
        if (opts.compile_only || opts.emit_asm || opts.preprocess_only ||
            opts.gen_depend) {
            fprintf(stderr,
                    "Fatal error: C3900U: -r writes a linked object, so it "
                    "cannot be combined with -c, -S, -E or -MMD\n");
            return 1;
        }
        if (!opts.output_path || !opts.output_path[0]) {
            fprintf(stderr,
                    "Fatal error: C3900U: -r needs -o <object> (the merged "
                    "object is not an image, so it has no default name)\n");
            return 1;
        }
        if (opts.link_input_count == 0) {
            fprintf(stderr,
                    "Fatal error: C3900U: -r needs at least one object "
                    "after -link\n");
            return 1;
        }
    }
    if (opts.ipo_mode && npos > opts.ipo_input_count) {
        /* The list was truncated above.  Compiling a prefix of the sources
         * would produce an image missing code and exit 0 -- refuse. */
        fprintf(stderr,
                "Fatal error: C3900U: more than %d source files for --ipo; "
                "raise ARK_LINK_MAX_OBJS and rebuild arkcc\n",
                (int)ARK_LINK_MAX_OBJS);
        return 1;
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

#if !ARKCC_FEATURE_MEMLINT
    /* The pass can also be switched on from arkcc.cfg (warn_mem=1).  A build
     * without it must refuse that too, for the same reason the command-line
     * form is refused: accepting it would claim a check that never ran. */
    if (g_config.enable_memlint) {
        fprintf(stderr,
                "Fatal error: C3900U: --warn-mem is not compiled into this "
                "build (rebuild with -DARKCC_FEATURE_MEMLINT=1)\n");
        return 1;
    }
#endif

#if !ARKCC_FEATURE_ENUMCHECK
    /* Same for the ini entry (warn_enum=1 in [features]).  The CPU check above
     * has already run, so this is the last chance to refuse it. */
    if (g_config.enable_enumcheck) {
        fprintf(stderr,
                "Fatal error: C3900U: --warn-enum is not compiled into this "
                "build (rebuild with -DARKCC_FEATURE_ENUMCHECK=1)\n");
        return 1;
    }
#endif

#if !ARKCC_FEATURE_UNUSEDRESULT
    /* Same rule again for warn_unused_result=1 in the ini file. */
    if (g_config.enable_unused_result) {
        fprintf(stderr,
                "Fatal error: C3900U: --warn-unused-result is not compiled into "
                "this build (rebuild with -DARKCC_FEATURE_UNUSEDRESULT=1)\n");
        return 1;
    }
#endif

#if !ARKCC_FEATURE_LICM
    /* Same rule for licm=1 in the ini file. */
    if (g_config.enable_licm) {
        fprintf(stderr,
                "Fatal error: C3900U: --licm is not compiled into this build "
                "(rebuild with -DARKCC_FEATURE_LICM=1)\n");
        return 1;
    }
#endif
#if !ARKCC_FEATURE_UNROLL
    if (g_config.enable_unroll) {
        fprintf(stderr,
                "Fatal error: C3900U: --unroll is not compiled into this build "
                "(rebuild with -DARKCC_FEATURE_UNROLL=1)\n");
        return 1;
    }
#endif
#if !ARKCC_FEATURE_TAILMERGE
    if (g_config.enable_tailmerge) {
        fprintf(stderr,
                "Fatal error: C3900U: --tailmerge is not compiled into this build "
                "(rebuild with -DARKCC_FEATURE_TAILMERGE=1)\n");
        return 1;
    }
#endif
#if !ARKCC_FEATURE_XBLOCK
    /* Same rule for xblock=1 in the ini file. */
    if (g_config.enable_xblock) {
        fprintf(stderr,
                "Fatal error: C3900U: --xblock is not compiled into this build "
                "(rebuild with -DARKCC_FEATURE_XBLOCK=1)\n");
        return 1;
    }
#endif
#if !ARKCC_FEATURE_TAILCALL
    /* Same rule for tailcall=1 in the ini file. */
    if (g_config.enable_tailcall) {
        fprintf(stderr,
                "Fatal error: C3900U: --tailcall is not compiled into this build "
                "(rebuild with -DARKCC_FEATURE_TAILCALL=1)\n");
        return 1;
    }
#endif
#if !ARKCC_FEATURE_DIVCONST
    /* Same rule for divconst=1 in the ini file. */
    if (g_config.enable_divconst) {
        fprintf(stderr,
                "Fatal error: C3900U: --divconst is not compiled into this build "
                "(rebuild with -DARKCC_FEATURE_DIVCONST=1)\n");
        return 1;
    }
#endif
#if !ARKCC_FEATURE_CONST_GLOBAL
    if (g_config.enable_const_global) {
        fprintf(stderr,
                "Fatal error: C3900U: --const-global is not compiled into this "
                "build (rebuild with -DARKCC_FEATURE_CONST_GLOBAL=1)\n");
        return 1;
    }
#endif

#if !ARKCC_FEATURE_MIR
    /* Same rule again for the three MIR checks in the ini file. */
    if (g_config.enable_warn_unreachable) {
        fprintf(stderr,
                "Fatal error: C3900U: --warn-unreachable is not compiled into "
                "this build (rebuild with -DARKCC_FEATURE_MIR=1)\n");
        return 1;
    }
    if (g_config.enable_warn_unused_static) {
        fprintf(stderr,
                "Fatal error: C3900U: --warn-unused-static is not compiled into "
                "this build (rebuild with -DARKCC_FEATURE_MIR=1)\n");
        return 1;
    }
    if (g_config.enable_warn_recursion) {
        fprintf(stderr,
                "Fatal error: C3900U: --warn-recursion is not compiled into "
                "this build (rebuild with -DARKCC_FEATURE_MIR=1)\n");
        return 1;
    }
#endif

    if (opts.print_pipeline) {
#if ARKCC_FEATURE_PIPELINE_DUMP
        int lvl = opts.opt_level;
        if (lvl < g_config.opt_level) lvl = g_config.opt_level;
        pipeline_dump(lvl, pipeline_profile());
        diag_shutdown();
        return 0;
#else
        /* Same rule as --warn-mem: a build that cannot answer the query must
         * say so, not print an empty table that reads like "nothing runs". */
        fprintf(stderr,
                "Fatal error: C3900U: --print-pipeline is not compiled into this "
                "build (rebuild with -DARKCC_FEATURE_PIPELINE_DUMP=1)\n");
        return 1;
#endif
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
    if (opts.verbose) {
        /* Arena high-water mark: the figure the board's ARK_POOL_SIZE should be
         * set from.  Printed for links too, where the compile part of the run
         * is what usually decides it. */
        fprintf(stderr, "[arkcc] arena peak %d/%d B\n",
                mem_pool_high(), mem_pool_capacity());
    }
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
