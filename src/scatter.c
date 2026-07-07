/* Ark C Compiler - scatter.c
 * ARM scatter loading description file parser.
 *
 * Supported syntax subset (armlink compatible):
 *   LR_IROM1 0x08000000 0x00100000 {
 *       ER_IROM1 0x08000000 0x00100000 {
 *           *.o (RESET, +First)
 *           *(InRoot$$Sections)
 *           .ANY (+RO)
 *       }
 *       ER_IRAM1 0x20000000 0x00020000 {
 *           .ANY (+RW +ZI)
 *       }
 *   }
 *
 * Parse strategy: read token by token, recognize LR_<name> <addr> and
 * ER_<name> <addr>, record selector text inside { ... } into the selectors
 * field. Attribute keywords (e.g. ABSOLUTE, OVERLAY) and size fields are
 * parsed but currently only the address is recorded. Comments start with ';'
 * to end of line.
 */
#include "scatter.h"
#include "memory.h"
#include "platform.h"
#include "common.h"
#include "flash_fs.h"
#include <stdarg.h>
#include <string.h>
#include <ctype.h>

/* Skip whitespace and comments (; to end of line) */
static const char *skip_ws(const char *p) {
    for (;;) {
        while (*p && isspace((unsigned char)*p)) p++;
        if (*p == ';') {
            while (*p && *p != '\n') p++;
            continue;
        }
        break;
    }
    return p;
}

/* Read an identifier (alphanumeric/underscore/$) into out; return end of identifier.
 * out capacity must be at least 64 bytes. */
static const char *read_ident(const char *p, char *out) {
    int n = 0;
    while (*p && (isalnum((unsigned char)*p) || *p == '_' || *p == '$')) {
        if (n < 63) out[n++] = *p;
        p++;
    }
    out[n] = 0;
    return p;
}

/* Parse an address (0x-prefixed hex or decimal); return end of address.
 * Supports ld-style K/M suffix: 2048K -> 2*1024*1024, 512M -> 512*1024*1024.
 * On success *out_addr is assigned. */
static const char *read_addr(const char *p, unsigned *out_addr) {
    unsigned v = 0;
    if (p[0] == '0' && (p[1] == 'x' || p[1] == 'X')) {
        p += 2;
        while (*p && isxdigit((unsigned char)*p)) {
            char c = *p;
            int d = (c >= '0' && c <= '9') ? c - '0' :
                    (c >= 'a' && c <= 'f') ? c - 'a' + 10 :
                    (c >= 'A' && c <= 'F') ? c - 'A' + 10 : 0;
            v = v * 16 + (unsigned)d;
            p++;
        }
    } else {
        while (*p && isdigit((unsigned char)*p)) {
            v = v * 10 + (unsigned)(*p - '0');
            p++;
        }
    }
    /* ld-style size suffix: K=kilobyte, M=megabyte (case-insensitive) */
    if (*p == 'K' || *p == 'k') { v *= 1024u; p++; }
    else if (*p == 'M' || *p == 'm') { v *= 1024u * 1024u; p++; }
    *out_addr = v;
    return p;
}

/* Collect raw text inside { ... } braces (including nested); return position
 * after the matching '}'. start points at the opening '{'. Result is written
 * into a newly allocated buffer (mem_pool_alloc); length stored in *out_len. */
static const char *collect_braces(const char *start, char **out_buf, int *out_len) {
    int depth = 0;
    const char *p = start;
    const char *content_start;
    const char *content_end;
    /* Skip to first '{' */
    p = skip_ws(p);
    if (*p != '{') return p;
    content_start = p + 1;
    /* Count nesting depth, find matching '}' */
    for (;;) {
        if (*p == 0) break;
        if (*p == '{') depth++;
        else if (*p == '}') {
            depth--;
            if (depth == 0) break;
        }
        p++;
    }
    content_end = p;
    if (*p == '}') p++;
    {
        int len = (int)(content_end - content_start);
        char *buf = (char *)mem_pool_alloc(len + 1);
        int i;
        for (i = 0; i < len; i++) buf[i] = content_start[i];
        buf[len] = 0;
        *out_buf = buf;
        *out_len = len;
    }
    return p;
}

int scatter_parse_file(const char *path, ScatterDesc *out) {
    char *src;
    const char *p;
    int read;

    if (!path || !out) return 1;
    /* Use fs_read_file() abstraction (host=stdio, STM32=W25Q flash) to avoid
     * pulling in semihosting-dependent C library functions on STM32. */
    {
        int cap = ARK_SRC_BUF_SIZE;
        src = (char *)mem_pool_alloc(cap);
        read = fs_read_file(path, src, cap);
    }
    if (read <= 0) {
        ark_log("[scatter] cannot open %s\n", path);
        return 1;
    }
    src[read] = 0;

    p = src;
    while (*p) {
        char ident[64];
        p = skip_ws(p);
        if (*p == 0) break;
        /* Expect LR_<name> */
        p = read_ident(p, ident);
        if (ident[0] == 0) { p++; continue; }
        if (strncmp(ident, "LR_", 3) != 0) {
            /* Not starting with LR: skip token, ignore line */
            while (*p && *p != '\n') p++;
            continue;
        }
        {
            ScatterLoadRegion *lr = (ScatterLoadRegion *)mem_pool_alloc(sizeof(ScatterLoadRegion));
            lr->name = mem_strdup(ident);
            lr->load_addr = 0;
            lr->size = 0;
            lr->exec_regions = 0;
            lr->next = 0;
            /* Read load address */
            p = skip_ws(p);
            if (*p == '0' || isdigit((unsigned char)*p)) {
                p = read_addr(p, &lr->load_addr);
            }
            /* Read optional region size (decimal/hex, may be absent) */
            p = skip_ws(p);
            if (*p == '0' || isdigit((unsigned char)*p)) {
                p = read_addr(p, &lr->size);
            }
            /* Skip optional attributes (ABSOLUTE/OVERLAY/...) until '{' */
            p = skip_ws(p);
            while (*p && *p != '{' && *p != '\n') p++;
            if (*p == '{') {
                /* Parse brace content, extract ER_<name> */
                char *body;
                int body_len;
                const char *bp;
                p = collect_braces(p, &body, &body_len);
                bp = body;
                while (*bp) {
                    char er_ident[64];
                    bp = skip_ws(bp);
                    if (*bp == 0) break;
                    bp = read_ident(bp, er_ident);
                    if (er_ident[0] == 0) { bp++; continue; }
                    /* ER_<name>, RW_<name> and ZI_<name> all become execution regions */
                    if (strncmp(er_ident, "ER_", 3) == 0 ||
                        strncmp(er_ident, "RW_", 3) == 0 ||
                        strncmp(er_ident, "ZI_", 3) == 0) {
                        ScatterExecRegion *er = (ScatterExecRegion *)mem_pool_alloc(sizeof(ScatterExecRegion));
                        er->name = mem_strdup(er_ident);
                        er->load_addr = 0;
                        er->size = 0;
                        er->selectors = 0;
                        er->next = 0;
                        bp = skip_ws(bp);
                        /* ER address */
                        if (*bp == '0' || isdigit((unsigned char)*bp)) {
                            bp = read_addr(bp, &er->load_addr);
                        }
                        /* Read optional region size */
                        bp = skip_ws(bp);
                        if (*bp == '0' || isdigit((unsigned char)*bp)) {
                            bp = read_addr(bp, &er->size);
                        }
                        /* Skip attributes until '{' */
                        bp = skip_ws(bp);
                        while (*bp && *bp != '{' && *bp != '\n') bp++;
                        if (*bp == '{') {
                            char *sel;
                            int sel_len;
                            bp = collect_braces(bp, &sel, &sel_len);
                            er->selectors = sel;
                        }
                        /* Append to end of lr list */
                        {
                            ScatterExecRegion **tail = &lr->exec_regions;
                            while (*tail) tail = &(*tail)->next;
                            *tail = er;
                        }
                    } else {
                        /* Non-ER token, skip to next whitespace */
                        while (*bp && !isspace((unsigned char)*bp)) bp++;
                    }
                }
            }
            /* Append to end of out list */
            {
                ScatterLoadRegion **tail = &out->load_regions;
                while (*tail) tail = &(*tail)->next;
                *tail = lr;
            }
        }
    }
    ark_log("[scatter] parsed %s\n", path);
    return 0;
}

void scatter_free(ScatterDesc *desc) {
    /* arkcc uses a memory pool; here we only null the pointer to avoid double free.
     * The pool is reclaimed uniformly at program exit. */
    if (desc) desc->load_regions = 0;
}

void scatter_dump(const ScatterDesc *desc) {
    ScatterLoadRegion *lr;
    if (!desc) return;
    for (lr = desc->load_regions; lr; lr = lr->next) {
        ScatterExecRegion *er;
        ark_log("LR %s @0x%08X\n", lr->name, lr->load_addr);
        for (er = lr->exec_regions; er; er = er->next) {
            ark_log("  ER %s @0x%08X\n", er->name, er->load_addr);
            if (er->selectors) ark_log("    selectors: %s\n", er->selectors);
        }
    }
}

/* ===== GNU ld .ld script support ===== */

/* Skip whitespace and C-style / C++-style comments used in ld scripts. */
static const char *skip_ld_ws(const char *p) {
    for (;;) {
        while (*p && isspace((unsigned char)*p)) p++;
        if (p[0] == '/' && p[1] == '*') {
            p += 2;
            while (*p && !(p[0] == '*' && p[1] == '/')) p++;
            if (*p) p += 2;
            continue;
        }
        if (p[0] == '/' && p[1] == '/') {
            while (*p && *p != '\n') p++;
            continue;
        }
        break;
    }
    return p;
}

/* Read a section name: leading '.' then alnum/_/. chars. out cap >= 64. */
static const char *read_section_name(const char *p, char *out) {
    int n = 0;
    if (*p == '.') {
        if (n < 63) out[n++] = *p;
        p++;
    }
    while (*p && (isalnum((unsigned char)*p) || *p == '_' || *p == '.')) {
        if (n < 63) out[n++] = *p;
        p++;
    }
    out[n] = 0;
    return p;
}

/* Find a load region by name; returns NULL if not found. */
static ScatterLoadRegion *find_load_region(ScatterDesc *desc, const char *name) {
    ScatterLoadRegion *lr;
    if (!name || !name[0]) return NULL;
    for (lr = desc->load_regions; lr; lr = lr->next) {
        if (ark_streq(lr->name, name)) return lr;
    }
    return NULL;
}

/* Get the first load region; create a default one if none exists yet. */
static ScatterLoadRegion *first_or_default_load_region(ScatterDesc *desc) {
    ScatterLoadRegion *lr;
    if (desc->load_regions) return desc->load_regions;
    lr = (ScatterLoadRegion *)mem_pool_alloc(sizeof(ScatterLoadRegion));
    lr->name = mem_strdup("LR_DEFAULT");
    lr->load_addr = 0;
    lr->size = 0;
    lr->exec_regions = 0;
    lr->next = 0;
    desc->load_regions = lr;
    return lr;
}

/* Build a region name from a section name like ".text" -> "ER_TEXT". */
static char *make_er_name(const char *section_name) {
    char buf[80];
    int i = 0, j = 0;
    buf[j++] = 'E'; buf[j++] = 'R'; buf[j++] = '_';
    while (section_name[i] && j < 76) {
        char c = section_name[i++];
        if (c == '.') continue;
        if (isalnum((unsigned char)c) || c == '_') {
            buf[j++] = (char)toupper((unsigned char)c);
        } else {
            buf[j++] = '_';
        }
    }
    buf[j] = 0;
    return mem_strdup(buf);
}

/* Parse a MEMORY { ... } block. p points just after the MEMORY keyword.
 * Each entry becomes a ScatterLoadRegion (load_addr = ORIGIN, size = LENGTH). */
static const char *parse_ld_memory(const char *p, ScatterDesc *out) {
    char name[64];
    char kw[64];
    unsigned origin = 0;
    unsigned length = 0;
    ScatterLoadRegion *lr;
    ScatterLoadRegion **tail;

    p = skip_ld_ws(p);
    if (*p != '{') return p;
    p++;  /* skip '{' */
    tail = &out->load_regions;
    while (*tail) tail = &(*tail)->next;
    for (;;) {
        p = skip_ld_ws(p);
        if (*p == '}') { p++; break; }
        if (*p == 0) break;
        name[0] = 0; kw[0] = 0; origin = 0; length = 0;
        /* Region name */
        p = read_ident(p, name);
        if (name[0] == 0) { p++; continue; }
        p = skip_ld_ws(p);
        /* Optional (attr) */
        if (*p == '(') {
            while (*p && *p != ')') p++;
            if (*p == ')') p++;
        }
        p = skip_ld_ws(p);
        if (*p == ':') p++;
        p = skip_ld_ws(p);
        /* ORIGIN = ... */
        p = read_ident(p, kw);
        p = skip_ld_ws(p);
        if (*p == '=') p++;
        p = skip_ld_ws(p);
        p = read_addr(p, &origin);
        p = skip_ld_ws(p);
        if (*p == ',') p++;
        p = skip_ld_ws(p);
        /* LENGTH = ... */
        p = read_ident(p, kw);
        p = skip_ld_ws(p);
        if (*p == '=') p++;
        p = skip_ld_ws(p);
        p = read_addr(p, &length);
        /* Build LR */
        lr = (ScatterLoadRegion *)mem_pool_alloc(sizeof(ScatterLoadRegion));
        lr->name = mem_strdup(name);
        lr->load_addr = origin;
        lr->size = length;
        lr->exec_regions = 0;
        lr->next = 0;
        *tail = lr;
        tail = &lr->next;
    }
    return p;
}

/* Parse a SECTIONS { ... } block. p points just after the SECTIONS keyword.
 * Each .name addr : { selectors } > REGION entry becomes a ScatterExecRegion
 * attached to the LR named by REGION (or first/default LR). */
static const char *parse_ld_sections(const char *p, ScatterDesc *out) {
    char sec_name[64];
    char region[64];
    char at_kw[16];
    char lr_region[64];
    unsigned addr = 0;
    int has_addr = 0;
    char *sel = 0;
    int sel_len = 0;
    ScatterLoadRegion *lr;
    ScatterExecRegion *er;
    ScatterExecRegion **tail;

    p = skip_ld_ws(p);
    if (*p != '{') return p;
    p++;  /* skip '{' */
    for (;;) {
        const char *save;
        p = skip_ld_ws(p);
        if (*p == '}') { p++; break; }
        if (*p == 0) break;
        /* Section name must start with '.' */
        if (*p != '.') {
            while (*p && !isspace((unsigned char)*p) && *p != '}') p++;
            continue;
        }
        sec_name[0] = 0; region[0] = 0; addr = 0; has_addr = 0; sel = 0; sel_len = 0;
        p = read_section_name(p, sec_name);
        if (sec_name[0] == 0) continue;
        p = skip_ld_ws(p);
        /* Optional address */
        if (*p == '0' || isdigit((unsigned char)*p)) {
            p = read_addr(p, &addr);
            has_addr = 1;
            p = skip_ld_ws(p);
        }
        if (*p == ':') p++;
        p = skip_ld_ws(p);
        /* Collect selectors inside { } */
        if (*p == '{') {
            p = collect_braces(p, &sel, &sel_len);
        }
        p = skip_ld_ws(p);
        /* Optional '> REGION' */
        if (*p == '>') {
            p++;
            p = skip_ld_ws(p);
            p = read_ident(p, region);
            p = skip_ld_ws(p);
            /* Optional 'AT > LR_REGION' */
            save = p;
            at_kw[0] = 0;
            p = read_ident(p, at_kw);
            if (ark_streq(at_kw, "AT")) {
                p = skip_ld_ws(p);
                if (*p == '>') {
                    p++;
                    p = skip_ld_ws(p);
                    lr_region[0] = 0;
                    p = read_ident(p, lr_region);
                    p = skip_ld_ws(p);
                }
            } else {
                p = save;
            }
        }
        /* Attach to LR named by REGION (or first/default) */
        lr = find_load_region(out, region);
        if (!lr) lr = first_or_default_load_region(out);
        /* Build ER. Use ER_<section> name to avoid clash with the LR name. */
        er = (ScatterExecRegion *)mem_pool_alloc(sizeof(ScatterExecRegion));
        er->name = make_er_name(sec_name);
        er->load_addr = has_addr ? addr : 0;
        er->size = 0;
        er->selectors = sel ? sel : mem_strdup("");
        er->next = 0;
        tail = &lr->exec_regions;
        while (*tail) tail = &(*tail)->next;
        *tail = er;
    }
    return p;
}

int linker_script_parse_file(const char *path, ScatterDesc *out) {
    char *src;
    const char *p;
    int read;

    if (!path || !out) return 1;
    /* Use fs_read_file() abstraction (host=stdio, STM32=W25Q flash) to avoid
     * pulling in semihosting-dependent C library functions on STM32. */
    {
        int cap = ARK_SRC_BUF_SIZE;
        src = (char *)mem_pool_alloc(cap);
        read = fs_read_file(path, src, cap);
    }
    if (read <= 0) {
        ark_log("[ld] cannot open %s\n", path);
        return 1;
    }
    src[read] = 0;

    p = src;
    while (*p) {
        char ident[64];
        p = skip_ld_ws(p);
        if (*p == 0) break;
        p = read_ident(p, ident);
        if (ident[0] == 0) { p++; continue; }
        if (ark_streq(ident, "MEMORY")) {
            p = parse_ld_memory(p, out);
        } else if (ark_streq(ident, "SECTIONS")) {
            p = parse_ld_sections(p, out);
        } else {
            while (*p && *p != '\n') p++;
        }
    }
    ark_log("[ld] parsed %s\n", path);
    return 0;
}

unsigned scatter_lookup_addr(const ScatterDesc *desc, const char *section_name) {
    ScatterLoadRegion *lr;
    if (!desc || !section_name) return 0;
    for (lr = desc->load_regions; lr; lr = lr->next) {
        ScatterExecRegion *er;
        for (er = lr->exec_regions; er; er = er->next) {
            if (er->selectors && strstr(er->selectors, section_name)) {
                return er->load_addr;
            }
        }
    }
    return 0;
}

/* snprintf-style append: writes to buf at *off (up to cap), returns the number
 * of chars that would have been written (excluding NUL).
 * Custom implementation to avoid pulling in vsnprintf (semihosting) on STM32.
 * Supports only the format specifiers used by scatter.c: %s, %X (and %%).
 * Width specifiers (e.g. %08X) are NOT supported. */
static int put_fmt(char *buf, int cap, int *off, const char *fmt, ...) {
    va_list ap;
    int n = 0;
    const char *p;
    va_start(ap, fmt);
    p = fmt;
    while (*p) {
        if (*p == '%' && p[1]) {
            char c = p[1];
            p += 2;
            if (c == 's') {
                const char *s = va_arg(ap, const char *);
                if (!s) s = "(null)";
                while (*s) {
                    if (buf && *off + n < cap - 1) buf[*off + n] = *s;
                    n++; s++;
                }
            } else if (c == 'X') {
                unsigned int v = (unsigned int)va_arg(ap, int);
                char tmp[8];
                int k = 0;
                const char *hex = "0123456789ABCDEF";
                if (v == 0) tmp[k++] = '0';
                while (v && k < 8) { tmp[k++] = hex[v & 0xF]; v >>= 4; }
                while (k > 0) {
                    k--;
                    if (buf && *off + n < cap - 1) buf[*off + n] = tmp[k];
                    n++;
                }
            } else if (c == 'd') {
                int v = va_arg(ap, int);
                char tmp[12];
                int k = 0, neg = 0;
                unsigned int u;
                if (v < 0) { neg = 1; u = (unsigned int)(-v); } else u = (unsigned int)v;
                if (u == 0) tmp[k++] = '0';
                while (u && k < 11) { tmp[k++] = (char)('0' + (u % 10)); u /= 10; }
                if (neg) tmp[k++] = '-';
                while (k > 0) {
                    k--;
                    if (buf && *off + n < cap - 1) buf[*off + n] = tmp[k];
                    n++;
                }
            } else if (c == 'c') {
                int v = va_arg(ap, int);
                if (buf && *off + n < cap - 1) buf[*off + n] = (char)v;
                n++;
            } else if (c == '%') {
                if (buf && *off + n < cap - 1) buf[*off + n] = '%';
                n++;
            } else {
                /* Unknown specifier: emit literally */
                if (buf && *off + n < cap - 1) buf[*off + n] = '%';
                n++;
                if (buf && *off + n < cap - 1) buf[*off + n] = c;
                n++;
            }
        } else {
            if (buf && *off + n < cap - 1) buf[*off + n] = *p;
            n++;
            p++;
        }
    }
    va_end(ap);
    if (buf && *off + n < cap) buf[*off + n] = 0;
    *off += n;
    return n;
}

/* Derive a section name (.text/.data/.bss/.rodata) from the selectors string.
 * Handles both GNU ld (*.o (.text)) and ARM scatter (.ANY (+RO)) syntax. */
static const char *derive_section_name(const char *selectors) {
    if (selectors) {
        /* Explicit section names first */
        if (strstr(selectors, ".rodata")) return ".rodata";
        if (strstr(selectors, ".bss"))    return ".bss";
        if (strstr(selectors, ".data"))   return ".data";
        if (strstr(selectors, ".text"))  return ".text";
        /* Scatter attribute selectors: +ZI (zero-init) maps to .bss */
        if (strstr(selectors, "+ZI"))     return ".bss";
        /* +RW (read-write) maps to .data; check after +ZI so +RW +ZI -> .bss */
        if (strstr(selectors, "+RW"))     return ".data";
        /* +RO / +XO (read-only / execute-only) maps to .text */
        if (strstr(selectors, "+RO") || strstr(selectors, "+XO")) return ".text";
    }
    return ".text";
}

int scatter_to_ld_script(const ScatterDesc *desc, char *buf, int cap) {
    int off = 0;
    ScatterLoadRegion *lr;

    if (!desc) return 0;
    if (buf && cap > 0) buf[0] = 0;
    /* MEMORY block: LRs first, then ERs (skip ERs whose name matches an LR). */
    put_fmt(buf, cap, &off, "MEMORY {\n");
    for (lr = desc->load_regions; lr; lr = lr->next) {
        put_fmt(buf, cap, &off, "  %s (rx) : ORIGIN = 0x%X, LENGTH = 0x%X\n",
                lr->name, lr->load_addr, lr->size);
    }
    for (lr = desc->load_regions; lr; lr = lr->next) {
        ScatterExecRegion *er;
        for (er = lr->exec_regions; er; er = er->next) {
            int conflict = 0;
            ScatterLoadRegion *lr2;
            for (lr2 = desc->load_regions; lr2; lr2 = lr2->next) {
                if (ark_streq(lr2->name, er->name)) { conflict = 1; break; }
            }
            if (conflict) continue;
            put_fmt(buf, cap, &off, "  %s (rwx) : ORIGIN = 0x%X, LENGTH = 0x%X\n",
                    er->name, er->load_addr, er->size);
        }
    }
    put_fmt(buf, cap, &off, "}\n");
    /* SECTIONS block: one entry per ER. */
    put_fmt(buf, cap, &off, "SECTIONS {\n");
    for (lr = desc->load_regions; lr; lr = lr->next) {
        ScatterExecRegion *er;
        for (er = lr->exec_regions; er; er = er->next) {
            const char *sec = derive_section_name(er->selectors);
            put_fmt(buf, cap, &off, "  %s 0x%X : { %s } > %s",
                    sec, er->load_addr,
                    er->selectors ? er->selectors : "",
                    er->name);
            if (ark_streq(sec, ".data")) {
                put_fmt(buf, cap, &off, " AT > %s", lr->name);
            }
            put_fmt(buf, cap, &off, "\n");
        }
    }
    put_fmt(buf, cap, &off, "}\n");
    return off;
}

int scatter_to_sct_file(const ScatterDesc *desc, char *buf, int cap) {
    int off = 0;
    ScatterLoadRegion *lr;

    if (!desc) return 0;
    if (buf && cap > 0) buf[0] = 0;
    for (lr = desc->load_regions; lr; lr = lr->next) {
        ScatterExecRegion *er;
        put_fmt(buf, cap, &off, "%s 0x%X 0x%X {\n", lr->name, lr->load_addr, lr->size);
        for (er = lr->exec_regions; er; er = er->next) {
            put_fmt(buf, cap, &off, "    %s 0x%X 0x%X {\n", er->name, er->load_addr, er->size);
            if (er->selectors && er->selectors[0]) {
                put_fmt(buf, cap, &off, "        %s\n", er->selectors);
            }
            put_fmt(buf, cap, &off, "    }\n");
        }
        put_fmt(buf, cap, &off, "}\n");
    }
    return off;
}
