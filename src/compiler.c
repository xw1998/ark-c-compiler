/* Ark C Compiler - compiler
 * Top-level pipeline: preproc -> lex -> parse -> sema -> irgen -> backend(emit/assemble/link).
 */
#include "compiler.h"
#include "platform.h"
#include "memory.h"
#include "flash_fs.h"
#include "lexer.h"
#include "parser.h"
#include "sema.h"
#include "irgen.h"
#include "ir.h"
#include "preproc.h"
#include "cpu.h"
#include "backend.h"
#include "config.h"
#include "arkcc_config.h"
#include "opt.h"
#include "scatter.h"
/* Note: <stdio.h> intentionally NOT included - all file I/O goes through
 * fs_read_file/fs_write_file (flash_fs abstraction) to avoid pulling in
 * semihosting-dependent C library functions on STM32. */

/* Buffer sizes come from arkcc_config.h (profile-aware): ARK_SRC_BUF_SIZE,
 * ARK_ASM_BUF_SIZE, ARK_CODE_BUF_SIZE, ARK_OBJ_BUF_SIZE, ARK_LINK_BUF_SIZE.
 * STM32 profile uses much smaller buffers to fit in AXI SRAM. */

/* Place large buffers in .ark_buf section so the linker script can put them
 * in AXI SRAM (0x24000000) on STM32H743. On host builds this is a no-op. */
static char          g_src[ARK_SRC_BUF_SIZE]   __attribute__((section(".ark_buf")));
static char          g_asm[ARK_ASM_BUF_SIZE]   __attribute__((section(".ark_buf")));
static unsigned char g_code[ARK_CODE_BUF_SIZE] __attribute__((section(".ark_buf")));

static int derive_output(const char *input, char *out, int cap, const char *ext) {
    int n = ark_strlen(input);
    int el = ark_strlen(ext);
    int i;
    int dot = -1;
    if (n <= 0 || n + el >= cap - 1) return -1;
    for (i = n - 1; i >= 0; i--) {
        if (input[i] == '/' || input[i] == '\\') break;
        if (input[i] == '.') { dot = i; break; }
    }
    if (dot < 0) dot = n;
    {
        int k;
        for (k = 0; k < dot && k < cap - el - 1; k++) out[k] = input[k];
        for (k = 0; k < el && dot + k < cap - 1; k++) out[dot + k] = ext[k];
        out[dot + el] = 0;
    }
    return 0;
}

static int write_binary(const char *path, const unsigned char *data, int n) {
    int wr = fs_write_file(path, data, n);
    if (wr != n) {
        ark_log("[arkcc] cannot write output '%s'\n", path);
        return ARK_ERR_IO;
    }
    return ARK_OK;
}

static int write_text(const char *path, const char *s) {
    int n = ark_strlen(s);
    int wr = fs_write_file(path, (const unsigned char *)s, n);
    if (wr != n) {
        ark_log("[arkcc] cannot write output '%s'\n", path);
        return ARK_ERR_IO;
    }
    return ARK_OK;
}

int ark_compile(const ArkOptions *opts) {
    int src_len;
    Lexer lex;
    AstNode *ast;
    int sema_errs;
    IrProgram *ir;
    char *preprocessed;
    const ArkBackend *be;
    int asm_len;
    int code_size;
    int i;

    if (!opts) return ARK_ERR_ARG;
    if (opts->list_backends) { ark_backend_list(); return ARK_OK; }

    /* -link mode: merge multiple .ark_obj (custom minimal format: raw text object concatenation) */
    if (opts->link_mode) {
        const char *out_path = opts->output_path ? opts->output_path : "a.out.c";
        int li;
        char buf[64 * 1024];
        /* Since fs_write_file writes a whole block at once, accumulate link results into out_buf first.
         * Size is controlled by ARK_LINK_BUF_SIZE (can be very small on STM32). */
        static char out_buf[ARK_LINK_BUF_SIZE] __attribute__((section(".ark_buf")));
        int out_len = 0;
        for (li = 0; li < opts->link_input_count; li++) {
            int n = fs_read_file(opts->link_inputs[li], buf, sizeof(buf));
            int rem;
            const char *p;
            if (n < 0) {
                ark_log("[arkcc] cannot read object '%s'\n", opts->link_inputs[li]);
                return ARK_ERR_IO;
            }
            /* Skip the object header "ARKOBJ\n" and optional #include block (if present) */
            p = buf;
            rem = n;
            if (rem >= 7 && p[0] == 'A' && p[1] == 'R' && p[2] == 'K' &&
                p[3] == 'O' && p[4] == 'B' && p[5] == 'J' && p[6] == '\n') {
                p += 7; rem -= 7;
            }
            /* Keep #include block only in the first object; others skip past the first typedef.
             * Simplified here: just concatenate every object's full content; duplicate #includes won't cause gcc errors. */
            if (li > 0) {
                /* Skip leading blank lines */
                while (rem > 0 && (*p == '\n' || *p == '\r')) { p++; rem--; }
            }
            if (out_len + rem + 1 > (int)sizeof(out_buf)) {
                ark_log("[arkcc] link output too large\n");
                return ARK_ERR_IO;
            }
            {
                int k;
                for (k = 0; k < rem; k++) out_buf[out_len++] = p[k];
            }
            out_buf[out_len++] = '\n';
        }
        if (fs_write_file(out_path, (const unsigned char *)out_buf, out_len) != out_len) {
            ark_log("[arkcc] cannot write link output '%s'\n", out_path);
            return ARK_ERR_IO;
        }
        if (opts->verbose) ark_log("[arkcc] linked %d objects -> %s\n", opts->link_input_count, out_path);
        return ARK_OK;
    }

    if (!opts->input_path) return ARK_ERR_ARG;

    /* Detect .s / .S assembly files: hand directly to backend assemble, skip frontend pipeline */
    {
        int inlen = ark_strlen(opts->input_path);
        if (inlen >= 2 &&
            (opts->input_path[inlen-2] == '.' &&
             (opts->input_path[inlen-1] == 's' || opts->input_path[inlen-1] == 'S'))) {
            int asm_len;
            int code_size;
            const ArkBackend *be2;
            char *asm_text;

            be2 = opts->target ? ark_backend_find(opts->target) : ark_backend_default();
            if (!be2) {
                ark_log("[arkcc] unknown target '%s'\n", opts->target ? opts->target : "(null)");
                return ARK_ERR_ARG;
            }
            mem_pool_reset();
            asm_len = fs_read_file(opts->input_path, g_asm, ARK_ASM_BUF_SIZE);
            if (asm_len < 0) {
                ark_log("[arkcc] cannot read '%s'\n", opts->input_path);
                return ARK_ERR_IO;
            }
            g_asm[asm_len] = 0;
            asm_text = g_asm;

            if (opts->emit_asm) {
                /* -S mode: output assembly text as-is */
                if (opts->output_path && !ark_streq(opts->output_path, "-") &&
                    !ark_streq(opts->output_path, "nul") && !ark_streq(opts->output_path, "NUL")) {
                    return write_text(opts->output_path, asm_text);
                } else if (!opts->output_path ||
                           ark_streq(opts->output_path, "-")) {
                    /* Write to stdout (fs_write_file handles the "-" path) */
                    if (fs_write_file("-", (const unsigned char *)asm_text, asm_len) != asm_len)
                        return ARK_ERR_IO;
                }
                return ARK_OK;
            }

            code_size = be2->assemble(asm_text, g_code, ARK_CODE_BUF_SIZE);
            if (code_size < 0) {
                ark_log("[arkcc] assembly of '%s' failed\n", opts->input_path);
                return ARK_ERR_ASM;
            }
            if (be2->link) {
                int rc = be2->link(g_code, code_size, 0);
                if (rc < 0) return ARK_ERR_LINK;
            }
            if (opts->verbose) ark_log("[arkcc] assembled .s: %d bytes\n", code_size);
            {
                char outpath[512];
                const char *target;
                if (opts->output_path) {
                    target = opts->output_path;
                } else {
                    if (derive_output(opts->input_path, outpath, sizeof(outpath), ".bin") != 0)
                        return ARK_ERR_ARG;
                    target = outpath;
                }
                return write_binary(target, g_code, code_size);
            }
        }
    }

    mem_pool_reset();
    preproc_reset();
    preproc_set_main_file(opts->input_path);
    /* Built-in header search paths have lowest priority; add user-specified -I dirs first */
    for (i = 0; i < opts->include_dir_count; i++) {
        preproc_add_include_dir(opts->include_dirs[i]);
    }
    preproc_add_include_dir("stdlib/include");

    /* --cpu/-mcpu: override default (M7) predefined macros and FPU/DSP switches based on target CPU.
     * Must be called before preproc_process so later preprocessing sees the correct
     * __TARGET_ARCH_* / __TARGET_FEATURE_DSP / __TARGET_FPU_VFP macros. */
    if (opts->cpu) {
        const CpuInfo *cpu = cpu_lookup(opts->cpu);
        if (!cpu) {
            ark_log("[arkcc] unknown CPU '%s' (supported: Cortex-M0/M0+/M1/M3/M4/M7/M23/M33)\n",
                    opts->cpu);
            return ARK_ERR_ARG;
        }
        cpu_apply_predefines(cpu);
        /* CPUs without FPU support automatically disable hardware FPU codegen */
        if (!cpu->has_fpu) g_config.enable_fpu_hw = 0;
        if (opts->verbose) {
            ark_log("[arkcc] cpu=%s arch_m=%d dsp=%d fpu=%d\n",
                    cpu->name, cpu->arch_m, cpu->has_dsp, cpu->has_fpu);
        }
    }

    /* -DNAME[=VALUE]: register command-line macro defines before preprocessing.
     * Each entry is parsed: optional '=VALUE' suffix becomes the macro body;
     * without '=', the macro body is "1". */
    for (i = 0; i < opts->pre_define_count; i++) {
        const char *e = opts->pre_defines[i];
        const char *eq = 0;
        int j;
        for (j = 0; e[j]; j++) { if (e[j] == '=') { eq = e + j; break; } }
        if (eq) {
            /* NAME=VALUE: copy NAME to a temp buffer (not pooled; lives through preproc) */
            static char name_buf[256];
            int nl = (int)(eq - e);
            int k;
            if (nl >= (int)sizeof(name_buf)) nl = (int)sizeof(name_buf) - 1;
            for (k = 0; k < nl; k++) name_buf[k] = e[k];
            name_buf[nl] = 0;
            preproc_define(name_buf, eq + 1);
        } else {
            preproc_define(e, "1");
        }
    }

    /* --split_sections/-ffunction-sections: sync runtime switch to g_config,
     * so ARM/C backends emit a separate section before each function. */
    if (opts->split_sections) g_config.split_sections = 1;

    src_len = fs_read_file(opts->input_path, g_src, ARK_SRC_BUF_SIZE);
    if (src_len < 0) {
        ark_log("[arkcc] cannot read '%s'\n", opts->input_path);
        return ARK_ERR_IO;
    }
    preprocessed = preproc_process(g_src);

    /* -MMD/--depend: generate dependency file (Makefile style, gcc -MMD compatible).
     * Format: "<output>: <source> <header1> <header2> ...\n"
     * Output path is given by -MF, otherwise defaults to "<input>.d". */
    if (opts->gen_depend) {
        const char *incs[64];
        int ninc = preproc_get_included_files(incs, 64);
        char dep_path[512];
        const char *dep_target;
        /* Derive output target name: prefer -o (strip extension and add .o), otherwise <input>.o */
        char obj_name[512];
        if (opts->output_path) {
            int ol = ark_strlen(opts->output_path);
            int dot = -1; int k;
            for (k = ol - 1; k >= 0; k--) {
                if (opts->output_path[k] == '/' || opts->output_path[k] == '\\') break;
                if (opts->output_path[k] == '.') { dot = k; break; }
            }
            if (dot < 0) dot = ol;
            for (k = 0; k < dot && k < (int)sizeof(obj_name) - 3; k++) obj_name[k] = opts->output_path[k];
            obj_name[dot] = 0;
            /* Default to .o extension (unless -S outputs .s) */
            if (opts->emit_asm) {
                obj_name[dot] = '.'; obj_name[dot+1] = 's'; obj_name[dot+2] = 0;
            } else {
                obj_name[dot] = '.'; obj_name[dot+1] = 'o'; obj_name[dot+2] = 0;
            }
        } else {
            /* Derive from input_path */
            int il = ark_strlen(opts->input_path);
            int dot = -1; int k;
            for (k = il - 1; k >= 0; k--) {
                if (opts->input_path[k] == '/' || opts->input_path[k] == '\\') break;
                if (opts->input_path[k] == '.') { dot = k; break; }
            }
            if (dot < 0) dot = il;
            for (k = 0; k < dot && k < (int)sizeof(obj_name) - 3; k++) obj_name[k] = opts->input_path[k];
            obj_name[dot] = '.'; obj_name[dot+1] = 'o'; obj_name[dot+2] = 0;
        }
        /* Dependency file path: -MF specifies, otherwise <input>.d */
        if (opts->depend_file) {
            dep_target = opts->depend_file;
        } else {
            int il = ark_strlen(opts->input_path);
            int dot = -1; int k;
            for (k = il - 1; k >= 0; k--) {
                if (opts->input_path[k] == '/' || opts->input_path[k] == '\\') break;
                if (opts->input_path[k] == '.') { dot = k; break; }
            }
            if (dot < 0) dot = il;
            for (k = 0; k < dot && k < (int)sizeof(dep_path) - 3; k++) dep_path[k] = opts->input_path[k];
            dep_path[dot] = '.'; dep_path[dot+1] = 'd'; dep_path[dot+2] = 0;
            dep_target = dep_path;
        }
        /* Build dependency file content: "<obj>: <source> <h1> <h2> ...\n" */
        {
            static char dep_buf[8192] __attribute__((section(".ark_buf")));
            int dl = 0;
            int k;
            /* Output target */
            for (k = 0; obj_name[k] && dl < (int)sizeof(dep_buf) - 1; k++) dep_buf[dl++] = obj_name[k];
            dep_buf[dl++] = ':';
            dep_buf[dl++] = ' ';
            /* Source file */
            for (k = 0; opts->input_path[k] && dl < (int)sizeof(dep_buf) - 1; k++) dep_buf[dl++] = opts->input_path[k];
            /* Dependent header files */
            for (k = 0; k < ninc && dl < (int)sizeof(dep_buf) - 2; k++) {
                dep_buf[dl++] = ' ';
                {
                    int j;
                    for (j = 0; incs[k][j] && dl < (int)sizeof(dep_buf) - 1; j++) dep_buf[dl++] = incs[k][j];
                }
            }
            dep_buf[dl++] = '\n';
            if (fs_write_file(dep_target, (const unsigned char *)dep_buf, dl) != dl) {
                ark_log("[arkcc] cannot write dependency file '%s'\n", dep_target);
                return ARK_ERR_IO;
            }
            if (opts->verbose) ark_log("[arkcc] wrote dependency file '%s' (%d includes)\n", dep_target, ninc);
        }
    }

    /* -E preprocess only */
    if (opts->preprocess_only) {
        const char *target = opts->output_path ? opts->output_path : "-";
        int e_len = ark_strlen(preprocessed);
        if (ark_streq(target, "-")) {
            if (fs_write_file("-", (const unsigned char *)preprocessed, e_len) != e_len)
                return ARK_ERR_IO;
            return ARK_OK;
        }
        return write_text(target, preprocessed);
    }

    be = opts->target ? ark_backend_find(opts->target) : ark_backend_default();
    if (!be) {
        ark_log("[arkcc] unknown target '%s'\n", opts->target ? opts->target : "(null)");
        return ARK_ERR_ARG;
    }
    if (opts->verbose) ark_log("[arkcc] target=%s, source=%d bytes\n", be->name, src_len);

    /* Set pointer size for the selected backend BEFORE parsing/sema/irgen so
     * struct layout and array indexing use the correct pointer width.
     * The C backend runs on the host (8-byte pointers on 64-bit); ARM/RISC-V32
     * use 4-byte pointers; x86_64 uses 8-byte pointers. */
    type_set_ptr_size(be->pointer_size);
    lexer_init(&lex, preprocessed);
    ast = parse_program(&lex);
    if (!ast) {
        ark_log("[arkcc] parse failed\n");
        return ARK_ERR_PARSE;
    }
    sema_errs = sema_check(ast);
    if (sema_errs > 0) {
        ark_log("[arkcc] %d semantic error(s)\n", sema_errs);
        return ARK_ERR_SEMA;
    }
    ir = irgen_program(ast);
    if (!ir) return ARK_ERR_IRGEN;
    ir->source_file = opts->input_path;  /* Used for DWARF .file/.loc */

    /* IR-level optimization: constant folding + dead code elimination.
     * Compile-time guarded by ARKCC_FEATURE_OPT_*, runtime guarded by g_config / opt_level. */
#if ARKCC_FEATURE_OPT_CONSTFOLD || ARKCC_FEATURE_OPT_DCE
    {
        int lvl = opts->opt_level;
        if (lvl < g_config.opt_level) lvl = g_config.opt_level;
        opt_run(ir, lvl);
    }
#endif

    asm_len = be->emit_asm(ir, g_asm, ARK_ASM_BUF_SIZE);
    if (asm_len < 0) return ARK_ERR_CODEGEN;
    g_asm[asm_len] = 0;

    /* -c mode: generate .ark_obj with binary code + symbol table for ARM backend */
    if (opts->compile_only) {
        char outpath[512];
        const char *target;
        static unsigned char obj_buf[ARK_OBJ_BUF_SIZE] __attribute__((section(".ark_buf")));
        int ol = 0;
        int code_len = asm_len;  /* default: text assembly for non-ARM backends */

        /* For ARM backend: assemble text to binary first */
        if (ark_streq(be->name, "arm")) {
            code_len = be->assemble(g_asm, g_code, ARK_CODE_BUF_SIZE);
            if (code_len < 0) {
                ark_log("[arkcc] assembly failed\n");
                return ARK_ERR_ASM;
            }
        }

        if (opts->output_path) target = opts->output_path;
        else {
            if (derive_output(opts->input_path, outpath, sizeof(outpath), ".ark_obj") != 0)
                return ARK_ERR_ARG;
            target = outpath;
        }

        /* Write extended header "ARKOBJ2\n" (8 bytes) */
        {
            const char *hdr = "ARKOBJ2\n";
            int hk;
            for (hk = 0; hdr[hk]; hk++) obj_buf[ol++] = (unsigned char)hdr[hk];
        }

        /* Write code size (4 bytes, little-endian) */
        {
            int cs = code_len;
            obj_buf[ol++] = (unsigned char)(cs & 0xFF);
            obj_buf[ol++] = (unsigned char)((cs >> 8) & 0xFF);
            obj_buf[ol++] = (unsigned char)((cs >> 16) & 0xFF);
            obj_buf[ol++] = (unsigned char)((cs >> 24) & 0xFF);
        }

        /* Write code body */
        if (code_len + ol > (int)sizeof(obj_buf)) {
            ark_log("[arkcc] object output too large for buffer\n");
            return ARK_ERR_IO;
        }
        {
            int k;
            const unsigned char *src = ark_streq(be->name, "arm") ? g_code : (const unsigned char *)g_asm;
            for (k = 0; k < code_len; k++) obj_buf[ol++] = src[k];
        }

        /* Write symbol table for ARM backend */
        if (ark_streq(be->name, "arm")) {
            extern int arm_get_symbol_count(void);
            extern const char *arm_get_symbol_name(int idx);
            extern int arm_get_symbol_offset(int idx);
            extern int arm_get_symbol_type(int idx);
            int sc = arm_get_symbol_count();
            int si;
            /* symbol count (4 bytes LE) */
            obj_buf[ol++] = (unsigned char)(sc & 0xFF);
            obj_buf[ol++] = (unsigned char)((sc >> 8) & 0xFF);
            obj_buf[ol++] = (unsigned char)((sc >> 16) & 0xFF);
            obj_buf[ol++] = (unsigned char)((sc >> 24) & 0xFF);
            for (si = 0; si < sc; si++) {
                const char *sn = arm_get_symbol_name(si);
                int nl = ark_strlen(sn) + 1; /* include null terminator */
                int off = arm_get_symbol_offset(si);
                int tp = arm_get_symbol_type(si);
                /* name length (4 bytes LE) */
                obj_buf[ol++] = (unsigned char)(nl & 0xFF);
                obj_buf[ol++] = (unsigned char)((nl >> 8) & 0xFF);
                obj_buf[ol++] = (unsigned char)((nl >> 16) & 0xFF);
                obj_buf[ol++] = (unsigned char)((nl >> 24) & 0xFF);
                /* name bytes */
                {
                    int k;
                    for (k = 0; k < nl; k++) obj_buf[ol++] = (unsigned char)sn[k];
                }
                /* offset (4 bytes LE) */
                obj_buf[ol++] = (unsigned char)(off & 0xFF);
                obj_buf[ol++] = (unsigned char)((off >> 8) & 0xFF);
                obj_buf[ol++] = (unsigned char)((off >> 16) & 0xFF);
                obj_buf[ol++] = (unsigned char)((off >> 24) & 0xFF);
                /* type (1 byte) */
                obj_buf[ol++] = (unsigned char)tp;
            }
        } else {
            /* Non-ARM: write 0 symbol count */
            obj_buf[ol++] = 0; obj_buf[ol++] = 0; obj_buf[ol++] = 0; obj_buf[ol++] = 0;
        }

        /* Bug-A2: Write relocation table for ARM backend.
         * Format: reloc_count (4 bytes LE) + for each reloc:
         *   name_len (4 bytes LE) + name (name_len bytes) + offset (4 bytes LE) + type (1 byte)
         * This goes AFTER the symbol table. Existing readers that stop
         * after the symbol table (like build_ark_test_fw.ps1) are unaffected. */
        if (ark_streq(be->name, "arm")) {
            extern int arm_get_reloc_count(void);
            extern const char *arm_get_reloc_name(int idx);
            extern int arm_get_reloc_offset(int idx);
            extern int arm_get_reloc_type(int idx);
            int rc = arm_get_reloc_count();
            int ri;
            /* reloc count (4 bytes LE) */
            obj_buf[ol++] = (unsigned char)(rc & 0xFF);
            obj_buf[ol++] = (unsigned char)((rc >> 8) & 0xFF);
            obj_buf[ol++] = (unsigned char)((rc >> 16) & 0xFF);
            obj_buf[ol++] = (unsigned char)((rc >> 24) & 0xFF);
            for (ri = 0; ri < rc; ri++) {
                const char *rn = arm_get_reloc_name(ri);
                int nl = ark_strlen(rn) + 1;
                int off = arm_get_reloc_offset(ri);
                int tp = arm_get_reloc_type(ri);
                /* name length (4 bytes LE) */
                obj_buf[ol++] = (unsigned char)(nl & 0xFF);
                obj_buf[ol++] = (unsigned char)((nl >> 8) & 0xFF);
                obj_buf[ol++] = (unsigned char)((nl >> 16) & 0xFF);
                obj_buf[ol++] = (unsigned char)((nl >> 24) & 0xFF);
                /* name bytes */
                {
                    int k;
                    for (k = 0; k < nl; k++) obj_buf[ol++] = (unsigned char)rn[k];
                }
                /* offset (4 bytes LE) */
                obj_buf[ol++] = (unsigned char)(off & 0xFF);
                obj_buf[ol++] = (unsigned char)((off >> 8) & 0xFF);
                obj_buf[ol++] = (unsigned char)((off >> 16) & 0xFF);
                obj_buf[ol++] = (unsigned char)((off >> 24) & 0xFF);
                /* type (1 byte) */
                obj_buf[ol++] = (unsigned char)tp;
            }
        }

        if (fs_write_file(target, obj_buf, ol) != ol)
            return ARK_ERR_IO;
        {
            extern int arm_get_symbol_count(void);
            extern int arm_get_reloc_count(void);
            if (opts->verbose) ark_log("[arkcc] wrote object '%s' (%d bytes code, %d syms, %d relocs)\n",
                target, code_len,
                ark_streq(be->name, "arm") ? arm_get_symbol_count() : 0,
                ark_streq(be->name, "arm") ? arm_get_reloc_count() : 0);
        }
        return ARK_OK;
    }

    if (opts->emit_asm) {
        if (opts->output_path && !ark_streq(opts->output_path, "-") &&
            !ark_streq(opts->output_path, "nul") && !ark_streq(opts->output_path, "NUL")) {
            int rc = write_text(opts->output_path, g_asm);
            if (rc != ARK_OK) return rc;
        } else if (opts->output_path && (ark_streq(opts->output_path, "nul") || ark_streq(opts->output_path, "NUL"))) {
            /* Discard output */
        } else {
            /* Write to stdout (fs_write_file handles the "-" path) */
            if (fs_write_file("-", (const unsigned char *)g_asm, asm_len) != asm_len)
                return ARK_ERR_IO;
        }
#if ARKCC_FEATURE_SCATTER
        /* If the user supplied a scatter .sct or a GNU ld .ld file, emit the
         * converted counterpart next to the assembly output. This lets a user
         * feed arkcc an .sct and get a matching .ld for arm-none-eabi-ld, or
         * feed an .ld and get a .sct for armlink. The converted file name is
         * <output_without_ext>.ld or <output_without_ext>.sct respectively. */
        if (opts->scatter_file || opts->linker_script) {
            ScatterDesc sd;
            sd.load_regions = 0;
            sd.error_count = 0;
            if (opts->scatter_file &&
                scatter_parse_file(opts->scatter_file, &sd) == 0) {
                /* .sct -> .ld */
                static char ld_buf[8192] __attribute__((section(".ark_buf")));
                int ln = scatter_to_ld_script(&sd, ld_buf, (int)sizeof(ld_buf) - 1);
                if (ln > 0) {
                    char ld_path[512];
                    const char *out_base = opts->output_path ? opts->output_path : opts->input_path;
                    if (derive_output(out_base, ld_path, sizeof(ld_path), ".ld") == 0) {
                        write_text(ld_path, ld_buf);
                        if (opts->verbose) ark_log("[arkcc] wrote linker script %s\n", ld_path);
                    }
                }
                scatter_free(&sd);
            } else if (opts->linker_script &&
                       linker_script_parse_file(opts->linker_script, &sd) == 0) {
                /* .ld -> .sct */
                static char sct_buf[8192] __attribute__((section(".ark_buf")));
                int sn = scatter_to_sct_file(&sd, sct_buf, (int)sizeof(sct_buf) - 1);
                if (sn > 0) {
                    char sct_path[512];
                    const char *out_base = opts->output_path ? opts->output_path : opts->input_path;
                    if (derive_output(out_base, sct_path, sizeof(sct_path), ".sct") == 0) {
                        write_text(sct_path, sct_buf);
                        if (opts->verbose) ark_log("[arkcc] wrote scatter file %s\n", sct_path);
                    }
                }
                scatter_free(&sd);
            }
        }
#endif
        return ARK_OK;
    }

    code_size = be->assemble(g_asm, g_code, ARK_CODE_BUF_SIZE);
    if (code_size < 0) {
        ark_log("[arkcc] assembly failed\n");
        return ARK_ERR_ASM;
    }
    if (be->link) {
        int rc = be->link(g_code, code_size, 0);
        if (rc < 0) return ARK_ERR_LINK;
    }
    if (opts->verbose) ark_log("[arkcc] assembled: %d bytes\n", code_size);

    {
        char outpath[512];
        const char *target;
        if (opts->output_path) {
            target = opts->output_path;
        } else {
            const char *ext = ".bin";
            if (ark_streq(be->name, "c")) ext = ".gen.c";
            if (derive_output(opts->input_path, outpath, sizeof(outpath), ext) != 0) {
                ark_log("[arkcc] failed to derive output name\n");
                return ARK_ERR_ARG;
            }
            target = outpath;
        }
        return write_binary(target, g_code, code_size);
    }
}

int ark_compile_and_run(const char *path) {
    ArkOptions o;
    int i;
    o.input_path = path;
    o.output_path = 0;
    o.emit_asm = 0;
    o.verbose = 1;
    o.target = 0;
    for (i = 0; i < 16; i++) o.include_dirs[i] = 0;
    o.include_dir_count = 0;
    o.list_backends = 0;
    o.compile_only = 0;
    o.preprocess_only = 0;
    o.link_mode = 0;
    for (i = 0; i < 32; i++) o.link_inputs[i] = 0;
    o.link_input_count = 0;
    o.opt_level = 0;
    o.debug_info = 0;
    o.no_unused_warn = 0;
    o.cpu = 0;
    o.gen_depend = 0;
    o.depend_file = 0;
    o.split_sections = 0;
    o.scatter_file = 0;
    o.linker_script = 0;
    for (i = 0; i < 64; i++) o.pre_defines[i] = 0;
    o.pre_define_count = 0;
    return ark_compile(&o);
}
