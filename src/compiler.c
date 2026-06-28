/* Ark C Compiler - compiler
 * 顶层流水线：preproc -> lex -> parse -> sema -> irgen -> backend(emit/assemble/link)。
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
#include "backend.h"
#include "config.h"
#include "arkcc_config.h"
#include "opt.h"
#include <stdio.h>

#define SRC_BUFFER_SIZE (128 * 1024)
#define ASM_BUFFER_SIZE (512 * 1024)
#define CODE_BUFFER_SIZE (256 * 1024)

static char          g_src[SRC_BUFFER_SIZE];
static char          g_asm[ASM_BUFFER_SIZE];
static unsigned char g_code[CODE_BUFFER_SIZE];

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
    FILE *fp = fopen(path, "wb");
    int wr;
    if (!fp) {
        ark_log("[arkcc] cannot open output '%s'\n", path);
        return ARK_ERR_IO;
    }
    wr = (int)fwrite(data, 1, (size_t)n, fp);
    fclose(fp);
    if (wr != n) return ARK_ERR_IO;
    return ARK_OK;
}

static int write_text(const char *path, const char *s) {
    FILE *fp = fopen(path, "wb");
    int n = ark_strlen(s);
    int wr;
    if (!fp) {
        ark_log("[arkcc] cannot open output '%s'\n", path);
        return ARK_ERR_IO;
    }
    wr = (int)fwrite(s, 1, (size_t)n, fp);
    fclose(fp);
    if (wr != n) return ARK_ERR_IO;
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

    /* -link 模式：合并多个 .ark_obj（自定义最简格式：原始文本对象拼接） */
    if (opts->link_mode) {
        FILE *fp_out;
        const char *out_path = opts->output_path ? opts->output_path : "a.out.c";
        int li;
        char buf[64 * 1024];
        fp_out = fopen(out_path, "wb");
        if (!fp_out) {
            ark_log("[arkcc] cannot open link output '%s'\n", out_path);
            return ARK_ERR_IO;
        }
        for (li = 0; li < opts->link_input_count; li++) {
            int n = fs_read_file(opts->link_inputs[li], buf, sizeof(buf));
            if (n < 0) {
                ark_log("[arkcc] cannot read object '%s'\n", opts->link_inputs[li]);
                fclose(fp_out);
                return ARK_ERR_IO;
            }
            /* 简单跳过对象头 "ARKOBJ\n" 与可选的 #include 块（如果存在） */
            {
                const char *p = buf;
                int rem = n;
                if (rem >= 7 && p[0] == 'A' && p[1] == 'R' && p[2] == 'K' &&
                    p[3] == 'O' && p[4] == 'B' && p[5] == 'J' && p[6] == '\n') {
                    p += 7; rem -= 7;
                }
                /* 只在第一个对象保留 #include 块；其余跳过到首个 typedef 之后即可。
                 * 这里简化：把每个对象的全部内容直接拼接，重复的 #include 不会引起 gcc 错误。 */
                if (li > 0) {
                    /* 跳过开头空行 */
                    while (rem > 0 && (*p == '\n' || *p == '\r')) { p++; rem--; }
                }
                fwrite(p, 1, (size_t)rem, fp_out);
                fputc('\n', fp_out);
            }
        }
        fclose(fp_out);
        if (opts->verbose) ark_log("[arkcc] linked %d objects -> %s\n", opts->link_input_count, out_path);
        return ARK_OK;
    }

    if (!opts->input_path) return ARK_ERR_ARG;

    /* 检测 .s / .S 汇编文件：直接交给后端 assemble，跳过前端流水线 */
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
            asm_len = fs_read_file(opts->input_path, g_asm, ASM_BUFFER_SIZE);
            if (asm_len < 0) {
                ark_log("[arkcc] cannot read '%s'\n", opts->input_path);
                return ARK_ERR_IO;
            }
            g_asm[asm_len] = 0;
            asm_text = g_asm;

            if (opts->emit_asm) {
                /* -S 模式：原样输出汇编文本 */
                if (opts->output_path && !ark_streq(opts->output_path, "-") &&
                    !ark_streq(opts->output_path, "nul") && !ark_streq(opts->output_path, "NUL")) {
                    return write_text(opts->output_path, asm_text);
                } else if (!opts->output_path ||
                           ark_streq(opts->output_path, "-")) {
                    fwrite(asm_text, 1, (size_t)asm_len, stdout);
                    fflush(stdout);
                }
                return ARK_OK;
            }

            code_size = be2->assemble(asm_text, g_code, CODE_BUFFER_SIZE);
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
    /* 内置头文件路径优先级最低，先把用户指定的 -I 加入 */
    for (i = 0; i < opts->include_dir_count; i++) {
        preproc_add_include_dir(opts->include_dirs[i]);
    }
    preproc_add_include_dir("stdlib/include");

    src_len = fs_read_file(opts->input_path, g_src, SRC_BUFFER_SIZE);
    if (src_len < 0) {
        ark_log("[arkcc] cannot read '%s'\n", opts->input_path);
        return ARK_ERR_IO;
    }

    preprocessed = preproc_process(g_src);

    /* -E 仅预处理 */
    if (opts->preprocess_only) {
        const char *target = opts->output_path ? opts->output_path : "-";
        if (ark_streq(target, "-")) {
            fwrite(preprocessed, 1, (size_t)ark_strlen(preprocessed), stdout);
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

    lexer_init(&lex, preprocessed);
    ast = parse_program(&lex);
    if (!ast) {
        ark_log("[arkcc] parse failed\n");
        return ARK_ERR_PARSE;
    }
    if (opts->verbose) ark_log("[arkcc] parse OK\n");

    sema_errs = sema_check(ast);
    if (sema_errs > 0) {
        ark_log("[arkcc] %d semantic error(s)\n", sema_errs);
        return ARK_ERR_SEMA;
    }
    if (opts->verbose) ark_log("[arkcc] sema OK\n");

    ir = irgen_program(ast);
    if (!ir) return ARK_ERR_IRGEN;
    ir->source_file = opts->input_path;  /* 供 DWARF .file/.loc 使用 */
    if (opts->verbose) ark_log("[arkcc] irgen OK (%d funcs)\n", ir->func_count);

    /* IR 级优化：常量折叠 + 死代码消除。
     * 编译期由 ARKCC_FEATURE_OPT_* 守护，运行时由 g_config / opt_level 守护。 */
#if ARKCC_FEATURE_OPT_CONSTFOLD || ARKCC_FEATURE_OPT_DCE
    {
        int lvl = opts->opt_level;
        if (lvl < g_config.opt_level) lvl = g_config.opt_level;
        opt_run(ir, lvl);
        if (opts->verbose) ark_log("[arkcc] opt OK (level %d)\n", lvl);
    }
#endif

    asm_len = be->emit_asm(ir, g_asm, ASM_BUFFER_SIZE);
    if (asm_len < 0) return ARK_ERR_CODEGEN;
    g_asm[asm_len] = 0;

    /* -c 模式：生成 .ark_obj（仅 C 后端：把生成的 C 源码贴一个简易头）。 */
    if (opts->compile_only) {
        char outpath[512];
        const char *target;
        FILE *fp;
        if (opts->output_path) target = opts->output_path;
        else {
            if (derive_output(opts->input_path, outpath, sizeof(outpath), ".ark_obj") != 0)
                return ARK_ERR_ARG;
            target = outpath;
        }
        fp = fopen(target, "wb");
        if (!fp) return ARK_ERR_IO;
        fputs("ARKOBJ\n", fp);
        fwrite(g_asm, 1, (size_t)asm_len, fp);
        fclose(fp);
        if (opts->verbose) ark_log("[arkcc] wrote object '%s' (%d bytes)\n", target, asm_len);
        return ARK_OK;
    }

    if (opts->emit_asm) {
        if (opts->output_path && !ark_streq(opts->output_path, "-") &&
            !ark_streq(opts->output_path, "nul") && !ark_streq(opts->output_path, "NUL")) {
            int rc = write_text(opts->output_path, g_asm);
            if (rc != ARK_OK) return rc;
        } else if (opts->output_path && (ark_streq(opts->output_path, "nul") || ark_streq(opts->output_path, "NUL"))) {
            /* 丢弃输出 */
        } else {
            FILE *fp = stdout;
            fwrite(g_asm, 1, (size_t)asm_len, fp);
            fflush(fp);
        }
        return ARK_OK;
    }

    code_size = be->assemble(g_asm, g_code, CODE_BUFFER_SIZE);
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
    return ark_compile(&o);
}
