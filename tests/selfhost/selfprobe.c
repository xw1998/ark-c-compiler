/* x86_64 self-host probe.
 *
 * arkcc is compiled by arkcc into a 28-object x86_64 image, and the only thing
 * that image still misses to become a real compiler binary is the host I/O
 * layer (fopen/fread/... and the Windows entry point).  This probe replaces
 * exactly that layer: the "file system" is one string embedded at build time,
 * and the "output file" is a RAM buffer.  Everything in between -- preprocess,
 * lex, parse, sema, irgen, opt, x86_64 codegen and the ARKOBJ2 object writer --
 * is the self-compiled code.
 *
 * main() returns 0 and publishes two numbers through globals:
 *   g_out_len  = length of the object the self-hosted compiler produced
 *   g_out_sum  = FNV-1a/32 over those bytes
 * The driver compares them with the object the host-built arkcc produces from
 * the same payload source.  Equal numbers mean the self-hosted compiler
 * reproduced its own output byte for byte.
 */
#include "compiler.h"
#include "config.h"
#include "flash_fs.h"
#include "platform.h"
#include <stdarg.h>
#include <stddef.h>

#include "payload.h"

/* Not static: the driver dumps this buffer to payload_self.o when the two
 * objects differ, so the difference can be inspected instead of guessed.
 * A flat image has no symbol table, and a file-scope static would not be
 * listed in the object's symbol table either. */
unsigned char g_obj[65536];
static int  g_obj_len = -1;

/* The self-hosted assembler is the last stage under test, so when an object
 * differs the first thing to establish is whether the assembly TEXT differs
 * (a code generator bug) or only the encoding of it (an assembler bug).
 * fs_write_file() routes any *.s request into this buffer, so one extra
 * ark_compile() call with emit_asm set publishes the text without touching
 * the compiler itself. */
unsigned char g_asmout[262144];
int g_asmout_len = -1;

int        g_out_len = -1;
unsigned   g_out_sum = 0;
int        g_probe_rc = -999;

/* Diagnostic log.  The self-hosted compiler runs under unicorn with no console,
 * so when it crashes the only evidence is what it managed to say first.  Every
 * ark_log()/ark_abort() string is appended here and the driver dumps the tail
 * on failure -- "it crashed somewhere" is not an acceptable report. */
char       g_log[32768];
int        g_log_len = 0;
int        g_aborted = 0;

/* --- the fake host surface ------------------------------------------- */

int fs_read_file(const char *path, char *buf, int max_len) {
    int i = 0;
    (void)path;
    if (!buf || max_len <= 0) return -1;
    while (g_payload_src[i] && i < max_len - 1) { buf[i] = g_payload_src[i]; i++; }
    buf[i] = 0;
    return i;
}

int fs_file_size(const char *path) {
    int i = 0;
    (void)path;
    while (g_payload_src[i]) i++;
    return i;
}

int fs_write_file(const char *path, const unsigned char *data, int len) {
    int i;
    {
        /* Anything ending in ".s" is the assembly text asked for by the
         * diagnostic compile below; keep it apart from the object bytes. */
        int pl = 0, dot_s = 0;
        while (path && path[pl]) pl++;
        if (pl >= 2 && path[pl-2] == '.' && (path[pl-1] == 's' || path[pl-1] == 'S')) dot_s = 1;
        if (dot_s) {
            if (!data || len < 0 || len > (int)sizeof(g_asmout)) return -1;
            for (i = 0; i < len; i++) g_asmout[i] = data[i];
            g_asmout_len = len;
            return len;
        }
    }
    if (!data || len < 0 || len > (int)sizeof(g_obj)) return -1;
    for (i = 0; i < len; i++) g_obj[i] = data[i];
    g_obj_len = len;
    return len;
}

const char *fs_last_error(void) { return "probe"; }
int fs_list_files(void) { return -1; }

extern int vsnprintf(char *buf, size_t n, const char *fmt, va_list ap);

static void log_append(const char *s) {
    int cap = (int)sizeof(g_log) - 1;
    if (!s) return;
    while (*s && g_log_len < cap) g_log[g_log_len++] = *s++;
    g_log[g_log_len] = 0;
}

void ark_log(const char *fmt, ...) {
    char line[512];
    va_list ap;
    va_start(ap, fmt);
    vsnprintf(line, sizeof(line), fmt, ap);
    va_end(ap);
    log_append(line);
}

/* The arena figures, spelled out.  "memory pool exhausted" on its own cannot be
 * told apart from "some allocation asked for a bogus size", and under unicorn
 * there is no debugger to ask.  mem_pool_high() is the number the host prints
 * with -v, so the two runs are directly comparable. */
extern int mem_pool_high(void);
extern int mem_pool_capacity(void);

static void log_int(int v) {
    char buf[16];
    int i = 15, neg = 0;
    buf[i] = 0;
    if (v < 0) { neg = 1; }
    if (v == 0) buf[--i] = '0';
    while (v != 0) {
        int dig = v % 10;
        if (dig < 0) dig = -dig;
        buf[--i] = (char)('0' + dig);
        v /= 10;
    }
    if (neg) buf[--i] = '-';
    log_append(&buf[i]);
}

void ark_abort(const char *msg) {
    g_aborted = 1;
    log_append("ABORT: ");
    log_append(msg);
    log_append(" [pool hi=");
    log_int(mem_pool_high());
    log_append(" cap=");
    log_int(mem_pool_capacity());
    log_append("]\n");
}
void ark_get_date_time(char *date_buf, char *time_buf) {
    /* Fixed strings keep __DATE__/__TIME__ out of the comparison: the payload
     * does not use them, and the host side would otherwise stamp today's date. */
    int i;
    const char *d = "Jan  1 1970";
    const char *t = "00:00:00";
    for (i = 0; i < 11; i++) date_buf[i] = d[i];
    date_buf[11] = 0;
    for (i = 0; i < 8; i++) time_buf[i] = t[i];
    time_buf[8] = 0;
}

void ark_dbg_char(int c) { (void)c; }
void ark_dbg_str(const char *s) { (void)s; }
void ark_dbg_int(int v) { (void)v; }

int main(void) {
    static ArkOptions opts;
    int i;
    unsigned sum = 2166136261u;

    config_init();
    opts.input_path   = "payload.c";
    opts.output_path  = "payload.o";
    opts.target       = "x86_64";
    opts.compile_only = 1;

    g_probe_rc = ark_compile(&opts);

    /* Same payload, assembly text instead of an object: the diff driver
     * compares this with the host compiler's -S output, which splits a
     * "text differs" (code generator) from "text equal but encoding
     * differs" (assembler) failure.  A failure here is not fatal for the
     * object comparison, so the return code of the real compile stands. */
    {
        static ArkOptions asm_opts;
        asm_opts.input_path   = "payload.c";
        asm_opts.output_path  = "payload.s";
        asm_opts.target       = "x86_64";
        asm_opts.compile_only = 0;
        asm_opts.emit_asm     = 1;
        (void)ark_compile(&asm_opts);
    }
    g_out_len = g_obj_len;
    if (g_obj_len > 0) {
        for (i = 0; i < g_obj_len; i++) {
            sum ^= (unsigned)g_obj[i];
            sum *= 16777619u;
        }
    }
    g_out_sum = sum;
    return 0;
}
