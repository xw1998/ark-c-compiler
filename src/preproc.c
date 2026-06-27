/* Ark C Compiler - preproc
 * 预处理器：
 *   - 对象宏 #define NAME body
 *   - 函数宏 #define MAX(a,b) (...)
 *   - 条件编译 #if/#ifdef/#ifndef/#elif/#else/#endif
 *   - #undef / #error / #warning / #pragma（忽略）
 *   - 嵌套 #include "x.h" 与 <x.h>（最多 8 层）
 *   - 预定义宏：__FILE__, __LINE__, __ARK_CC__, __STDC__, __ARK_VERSION__
 *
 * 注意：实现追求"实用"，并非标准合规。
 *   - 函数宏的参数替换只做整体替换；不支持 # 与 ## 的复杂情况，但识别这两个符号。
 *   - #if 表达式只支持：整数字面量、defined(X)、defined X、&& || ! 与括号。
 *   - 字符串/字符字面量内的内容原样保留。
 */
#include "preproc.h"
#include "memory.h"
#include "platform.h"
#include "flash_fs.h"
#include "type.h"   /* type_set_pack/type_get_pack：#pragma pack 对齐控制 */

#define PP_BUF_SIZE (512 * 1024)
#define PP_INC_BUF  (128 * 1024)
#define PP_MAX_INC_DEPTH 8
#define PP_MAX_INC_DIRS  16
#define PP_PACK_STACK    32

typedef struct Macro {
    char         *name;
    char         *body;
    int           is_func;
    char        **params;
    int           param_count;
    struct Macro *next;
} Macro;

static Macro *g_macros;
static int    g_inc_depth;
static const char *g_inc_dirs[PP_MAX_INC_DIRS];
static int    g_inc_dir_count;
static char   g_main_file[256];
/* #pragma pack(push/pop) 栈：保存历史对齐值以便恢复 */
static int    g_pack_stack[PP_PACK_STACK];
static int    g_pack_top;

static int is_alpha(char c) {
    return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') || c == '_';
}
static int is_digit(char c) { return c >= '0' && c <= '9'; }
static int is_alnum(char c) { return is_alpha(c) || is_digit(c); }

static Macro *find_macro(const char *name) {
    Macro *m;
    for (m = g_macros; m; m = m->next) {
        if (ark_streq(m->name, name)) return m;
    }
    return 0;
}

static void remove_macro(const char *name) {
    Macro **pp = &g_macros;
    while (*pp) {
        if (ark_streq((*pp)->name, name)) { *pp = (*pp)->next; return; }
        pp = &(*pp)->next;
    }
}

static void add_object_macro(const char *name, const char *body) {
    Macro *m = (Macro *)mem_pool_alloc(sizeof(Macro));
    m->name = mem_strdup(name);
    m->body = mem_strdup(body ? body : "");
    m->is_func = 0;
    m->next = g_macros;
    g_macros = m;
}

static void add_func_macro(const char *name, char **params, int pc, const char *body) {
    Macro *m = (Macro *)mem_pool_alloc(sizeof(Macro));
    m->name = mem_strdup(name);
    m->body = mem_strdup(body ? body : "");
    m->is_func = 1;
    m->params = params;
    m->param_count = pc;
    m->next = g_macros;
    g_macros = m;
}

static void buf_putc(char *buf, int *plen, int cap, char c) {
    if (*plen + 1 >= cap) return;
    buf[(*plen)++] = c;
}

static void buf_puts(char *buf, int *plen, int cap, const char *s) {
    while (*s) buf_putc(buf, plen, cap, *s++);
}

/* 整数转字符串写入缓冲 */
static void emit_int(char *buf, int *plen, int cap, int v) {
    char tmp[16];
    int n = 0;
    int i;
    int neg = 0;
    unsigned u;
    if (v < 0) { neg = 1; u = (unsigned)(-v); } else u = (unsigned)v;
    if (u == 0) tmp[n++] = '0';
    while (u) { tmp[n++] = (char)('0' + (int)(u % 10)); u /= 10; }
    if (neg) buf_putc(buf, plen, cap, '-');
    for (i = n - 1; i >= 0; i--) buf_putc(buf, plen, cap, tmp[i]);
}

void preproc_reset(void) {
    g_macros = 0;
    g_inc_depth = 0;
    g_inc_dir_count = 0;
    g_main_file[0] = 0;
    g_pack_top = 0;
    type_set_pack(0);
}

void preproc_add_include_dir(const char *dir) {
    if (g_inc_dir_count < PP_MAX_INC_DIRS) {
        g_inc_dirs[g_inc_dir_count++] = mem_strdup(dir);
    }
}

void preproc_set_main_file(const char *path) {
    int n = ark_strlen(path);
    int i;
    if (n >= (int)sizeof(g_main_file)) n = (int)sizeof(g_main_file) - 1;
    for (i = 0; i < n; i++) g_main_file[i] = path[i];
    g_main_file[n] = 0;
}

/* 尝试在多个目录读取被 include 的文件，返回字节数或 -1 */
static int read_include(const char *name, char *buf, int cap) {
    int rd = fs_read_file(name, buf, cap);
    if (rd >= 0) return rd;
    {
        int i;
        for (i = 0; i < g_inc_dir_count; i++) {
            char path[512];
            int dl = ark_strlen(g_inc_dirs[i]);
            int nl = ark_strlen(name);
            int k;
            if (dl + 1 + nl + 1 > (int)sizeof(path)) continue;
            for (k = 0; k < dl; k++) path[k] = g_inc_dirs[i][k];
            path[dl] = '/';
            for (k = 0; k < nl; k++) path[dl + 1 + k] = name[k];
            path[dl + 1 + nl] = 0;
            rd = fs_read_file(path, buf, cap);
            if (rd >= 0) return rd;
        }
    }
    return -1;
}

/* === 条件编译表达式求值（极简） === */
static const char *expr_p;
static int eval_expr(int min_prec);

static void skip_ws_p(void) { while (*expr_p == ' ' || *expr_p == '\t') expr_p++; }

static int parse_primary(void) {
    int v = 0;
    skip_ws_p();
    if (*expr_p == '(') {
        expr_p++;
        v = eval_expr(0);
        skip_ws_p();
        if (*expr_p == ')') expr_p++;
        return v;
    }
    if (*expr_p == '!') {
        expr_p++;
        return !parse_primary();
    }
    if (*expr_p == '-') { expr_p++; return -parse_primary(); }
    if (*expr_p == '+') { expr_p++; return parse_primary(); }
    if (is_digit(*expr_p)) {
        while (is_digit(*expr_p)) { v = v * 10 + (*expr_p - '0'); expr_p++; }
        /* 跳过 L/U 后缀 */
        while (*expr_p == 'u' || *expr_p == 'U' || *expr_p == 'l' || *expr_p == 'L') expr_p++;
        return v;
    }
    if (is_alpha(*expr_p)) {
        const char *st = expr_p;
        char nm[64];
        int nlen = 0;
        while (is_alnum(*expr_p)) {
            if (nlen < 63) nm[nlen++] = *expr_p;
            expr_p++;
        }
        nm[nlen] = 0;
        if (ark_streq(nm, "defined")) {
            int paren = 0;
            char arg[64];
            int alen = 0;
            skip_ws_p();
            if (*expr_p == '(') { paren = 1; expr_p++; skip_ws_p(); }
            while (is_alnum(*expr_p) && alen < 63) { arg[alen++] = *expr_p++; }
            arg[alen] = 0;
            skip_ws_p();
            if (paren && *expr_p == ')') expr_p++;
            return find_macro(arg) ? 1 : 0;
        }
        /* 标识符：未定义视为 0 */
        {
            Macro *m = find_macro(nm);
            if (m && !m->is_func) {
                /* 递归对宏体求值（不展开嵌套宏） */
                const char *save = expr_p;
                int rv;
                expr_p = m->body;
                rv = eval_expr(0);
                expr_p = save;
                return rv;
            }
        }
        (void)st;
        return 0;
    }
    return 0;
}

static int eval_expr(int min_prec) {
    int lhs = parse_primary();
    for (;;) {
        int prec = -1, op = 0;
        skip_ws_p();
        if (expr_p[0] == '&' && expr_p[1] == '&') { prec = 1; op = 1; }
        else if (expr_p[0] == '|' && expr_p[1] == '|') { prec = 0; op = 2; }
        else if (expr_p[0] == '=' && expr_p[1] == '=') { prec = 2; op = 3; }
        else if (expr_p[0] == '!' && expr_p[1] == '=') { prec = 2; op = 4; }
        else if (expr_p[0] == '<' && expr_p[1] == '=') { prec = 3; op = 7; }
        else if (expr_p[0] == '>' && expr_p[1] == '=') { prec = 3; op = 8; }
        else if (expr_p[0] == '<') { prec = 3; op = 5; }
        else if (expr_p[0] == '>') { prec = 3; op = 6; }
        else if (expr_p[0] == '+') { prec = 4; op = 9; }
        else if (expr_p[0] == '-') { prec = 4; op = 10; }
        else if (expr_p[0] == '*') { prec = 5; op = 11; }
        else if (expr_p[0] == '/') { prec = 5; op = 12; }
        if (prec < min_prec) break;
        if (op == 1 || op == 2 || op == 3 || op == 4 || op == 7 || op == 8) expr_p += 2;
        else expr_p++;
        {
            int rhs = eval_expr(prec + 1);
            switch (op) {
                case 1:  lhs = lhs && rhs; break;
                case 2:  lhs = lhs || rhs; break;
                case 3:  lhs = lhs == rhs; break;
                case 4:  lhs = lhs != rhs; break;
                case 5:  lhs = lhs <  rhs; break;
                case 6:  lhs = lhs >  rhs; break;
                case 7:  lhs = lhs <= rhs; break;
                case 8:  lhs = lhs >= rhs; break;
                case 9:  lhs = lhs +  rhs; break;
                case 10: lhs = lhs -  rhs; break;
                case 11: lhs = lhs *  rhs; break;
                case 12: lhs = rhs ? lhs / rhs : 0; break;
                default: break;
            }
        }
    }
    return lhs;
}

static int eval_pp_expr(const char *s) {
    expr_p = s;
    return eval_expr(0);
}

/* 全局当前行号（仅用于 __LINE__ 替换） */
static int g_cur_line;
/* 是否启用宏展开 */
static int g_macro_expand;

static void process(const char *src, char *out, int *out_len, int out_cap);

/* 读取函数式宏调用参数：从 '(' 之后开始，返回到 ')' 后位置；最多 16 个参数 */
static const char *parse_macro_args(const char *p, char **args, int *parg_count, int max_args) {
    int paren = 1;
    int n = 0;
    char buf[1024];
    int bl = 0;
    if (*p != '(') { *parg_count = 0; return p; }
    p++;
    while (*p && paren > 0) {
        if (*p == '(') { paren++; if (bl < 1023) buf[bl++] = *p; p++; continue; }
        if (*p == ')') {
            paren--;
            if (paren == 0) {
                buf[bl] = 0;
                if (n < max_args) args[n++] = mem_strdup(buf);
                bl = 0;
                p++;
                break;
            }
            if (bl < 1023) buf[bl++] = *p; p++; continue;
        }
        if (*p == ',' && paren == 1) {
            buf[bl] = 0;
            if (n < max_args) args[n++] = mem_strdup(buf);
            bl = 0;
            p++;
            while (*p == ' ' || *p == '\t') p++;
            continue;
        }
        if (*p == '"' || *p == '\'') {
            char q = *p;
            if (bl < 1023) buf[bl++] = *p;
            p++;
            while (*p && *p != q) {
                if (*p == '\\' && p[1]) { if (bl < 1022) { buf[bl++] = *p; buf[bl++] = p[1]; } p += 2; continue; }
                if (bl < 1023) buf[bl++] = *p;
                p++;
            }
            if (*p) { if (bl < 1023) buf[bl++] = *p; p++; }
            continue;
        }
        if (bl < 1023) buf[bl++] = *p;
        p++;
    }
    *parg_count = n;
    return p;
}

/* 展开函数宏的 body：把 params 出现处替换为对应 args（先递归预处理 args） */
static void expand_func_macro(Macro *m, char **args, int argc,
                              char *out, int *out_len, int out_cap) {
    const char *p = m->body;
    while (*p) {
        if (*p == '#' && p[1] == '#') {
            /* token concatenation：忽略空白 */
            p += 2;
            /* 反向去除尾部空白 */
            while (*out_len > 0 && (out[*out_len - 1] == ' ' || out[*out_len - 1] == '\t'))
                (*out_len)--;
            while (*p == ' ' || *p == '\t') p++;
            continue;
        }
        if (*p == '#' && is_alpha(p[1])) {
            /* 字符串化：找到下一个标识符 */
            const char *q = p + 1;
            char nm[64];
            int nl = 0;
            while (is_alnum(*q) && nl < 63) { nm[nl++] = *q++; }
            nm[nl] = 0;
            /* 在参数表找 */
            {
                int i;
                int found = -1;
                for (i = 0; i < m->param_count; i++)
                    if (ark_streq(m->params[i], nm)) { found = i; break; }
                if (found >= 0 && found < argc) {
                    const char *s = args[found];
                    buf_putc(out, out_len, out_cap, '"');
                    while (*s) {
                        if (*s == '"' || *s == '\\') buf_putc(out, out_len, out_cap, '\\');
                        buf_putc(out, out_len, out_cap, *s);
                        s++;
                    }
                    buf_putc(out, out_len, out_cap, '"');
                    p = q;
                    continue;
                }
            }
            buf_putc(out, out_len, out_cap, *p++);
            continue;
        }
        if (is_alpha(*p)) {
            const char *st = p;
            char nm[64];
            int nl = 0;
            int matched = -1;
            int i;
            while (is_alnum(*p) && nl < 63) { nm[nl++] = *p++; }
            nm[nl] = 0;
            for (i = 0; i < m->param_count; i++)
                if (ark_streq(m->params[i], nm)) { matched = i; break; }
            if (matched >= 0 && matched < argc) {
                /* 递归预处理 args[matched] 以支持嵌套宏 */
                process(args[matched], out, out_len, out_cap);
            } else {
                int k;
                for (k = 0; k < nl; k++) buf_putc(out, out_len, out_cap, st[k]);
            }
            continue;
        }
        if (*p == '"' || *p == '\'') {
            char q = *p;
            buf_putc(out, out_len, out_cap, *p++);
            while (*p && *p != q) {
                if (*p == '\\' && p[1]) {
                    buf_putc(out, out_len, out_cap, *p++);
                }
                buf_putc(out, out_len, out_cap, *p++);
            }
            if (*p) buf_putc(out, out_len, out_cap, *p++);
            continue;
        }
        buf_putc(out, out_len, out_cap, *p++);
    }
}

static int handle_if(const char *expr_text) {
    return eval_pp_expr(expr_text) ? 1 : 0;
}

/* 处理 #pragma pack 指令的参数部分（q 指向 "pack" 之后的剩余文本）。
 * 支持形式：
 *   pack        -> 无效，忽略
 *   pack()      -> 恢复默认对齐 (0)
 *   pack(n)     -> 设置对齐为 n
 *   pack(push)  -> 压栈当前对齐
 *   pack(push,n)-> 压栈并设置对齐为 n
 *   pack(pop)   -> 出栈恢复
 * 注意：预处理整体先于解析执行，故 push/pop 围绕结构体定义的常见模式
 * 仅在"设置后保持到文件末尾"或"全部 packed 结构体先于 pop"时生效；
 * 单一 pack(n) 设置（测试用例用法）可正确作用于后续解析。 */
static int handle_pragma_pack(const char *q) {
    /* q 应指向 '(' 或空白；先跳过空白找 '(' */
    while (*q == ' ' || *q == '\t') q++;
    if (*q != '(') return 0;
    q++;
    while (*q == ' ' || *q == '\t') q++;
    if (*q == ')') {
        /* pack() 恢复默认 */
        type_set_pack(0);
        return 1;
    }
    if (q[0] == 'p' && q[1] == 'u' && q[2] == 's' && q[3] == 'h') {
        /* push [n] */
        int old = type_get_pack();
        q += 4;
        while (*q == ' ' || *q == '\t') q++;
        if (*q == ',') {
            q++;
            while (*q == ' ' || *q == '\t') q++;
            if (*q >= '0' && *q <= '9') {
                int n = 0;
                while (*q >= '0' && *q <= '9') { n = n * 10 + (*q - '0'); q++; }
                if (g_pack_top < PP_PACK_STACK) g_pack_stack[g_pack_top++] = old;
                type_set_pack(n);
                return 1;
            }
        }
        /* pack(push) 仅压栈不改变当前值 */
        if (g_pack_top < PP_PACK_STACK) g_pack_stack[g_pack_top++] = old;
        return 1;
    }
    if (q[0] == 'p' && q[1] == 'o' && q[2] == 'p') {
        /* pop */
        if (g_pack_top > 0) {
            int v = g_pack_stack[--g_pack_top];
            type_set_pack(v);
        }
        return 1;
    }
    if (*q >= '0' && *q <= '9') {
        /* pack(n) */
        int n = 0;
        while (*q >= '0' && *q <= '9') { n = n * 10 + (*q - '0'); q++; }
        type_set_pack(n);
        return 1;
    }
    return 0;
}

/* 主驱动 */
static void process(const char *src, char *out, int *out_len, int out_cap) {
    const char *p = src;
    /* 条件编译栈：每层保存"是否处于活动分支"。 */
    int cond_stack[32];
    int cond_taken[32];   /* 这一层是否已经"采用"过一个分支 */
    int cond_top = 0;
    int active = 1;
    int saved_line = g_cur_line;
    int line_no = 1;

#define ACTIVE() (active)

    while (*p) {
        /* 行首：跳过空白以识别 # */
        const char *line_start = p;
        const char *q;
        int is_pp_line = 0;
        while (*p == ' ' || *p == '\t') p++;
        if (*p == '#') {
            is_pp_line = 1;
        } else {
            p = line_start;
        }

        if (is_pp_line) {
            char cmd[16];
            int n = 0;
            q = p + 1;
            while (*q == ' ' || *q == '\t') q++;
            while (*q && is_alpha(*q) && n < 15) cmd[n++] = *q++;
            cmd[n] = 0;
            while (*q == ' ' || *q == '\t') q++;

            if (ark_streq(cmd, "define") && ACTIVE()) {
                char name[64];
                int nl = 0;
                int is_fn = 0;
                char **params = 0;
                int pc = 0;
                char body[2048];
                int bl = 0;
                while (*q && is_alnum(*q) && nl < 63) name[nl++] = *q++;
                name[nl] = 0;
                if (*q == '(') {
                    is_fn = 1;
                    q++;
                    for (;;) {
                        char pname[64];
                        int pl = 0;
                        while (*q == ' ' || *q == '\t') q++;
                        if (*q == ')') { q++; break; }
                        while (*q && is_alnum(*q) && pl < 63) pname[pl++] = *q++;
                        pname[pl] = 0;
                        if (pl > 0) {
                            params = (char **)mem_realloc(params, pc * (int)sizeof(char*), (pc+1)*(int)sizeof(char*));
                            params[pc++] = mem_strdup(pname);
                        }
                        while (*q == ' ' || *q == '\t') q++;
                        if (*q == ',') { q++; continue; }
                        if (*q == ')') { q++; break; }
                        break;
                    }
                }
                while (*q == ' ' || *q == '\t') q++;
                while (*q && *q != '\n' && bl < 2047) {
                    /* 支持续行 \ 在行末 */
                    if (*q == '\\' && q[1] == '\n') {
                        q += 2;
                        line_no++;
                        body[bl++] = ' ';
                        continue;
                    }
                    body[bl++] = *q++;
                }
                while (bl > 0 && (body[bl-1] == ' ' || body[bl-1] == '\t' || body[bl-1] == '\r')) bl--;
                body[bl] = 0;
                if (nl > 0) {
                    if (is_fn) add_func_macro(name, params, pc, body);
                    else add_object_macro(name, body);
                }
            }
            else if (ark_streq(cmd, "undef") && ACTIVE()) {
                char name[64];
                int nl = 0;
                while (*q && is_alnum(*q) && nl < 63) name[nl++] = *q++;
                name[nl] = 0;
                if (nl > 0) remove_macro(name);
            }
            else if (ark_streq(cmd, "include") && ACTIVE()) {
                char path[256];
                int pl = 0;
                char quote;
                if (*q != '"' && *q != '<') {
                    /* skip */
                } else {
                    quote = (*q == '<') ? '>' : '"';
                    q++;
                    while (*q && *q != quote && pl < 255) path[pl++] = *q++;
                    path[pl] = 0;
                    if (*q == quote) q++;
                    if (g_inc_depth >= PP_MAX_INC_DEPTH) {
                        ark_log("[preproc] include too deeply nested: '%s'\n", path);
                    } else {
                        char *inc_buf = (char *)mem_pool_alloc(PP_INC_BUF);
                        int rd = read_include(path, inc_buf, PP_INC_BUF);
                        if (rd < 0) {
                            ark_log("[preproc] cannot include '%s'\n", path);
                        } else {
                            g_inc_depth++;
                            process(inc_buf, out, out_len, out_cap);
                            g_inc_depth--;
                        }
                    }
                }
            }
            else if (ark_streq(cmd, "if")) {
                int v = 0;
                char expr[512];
                int el = 0;
                while (*q && *q != '\n' && el < 511) expr[el++] = *q++;
                expr[el] = 0;
                if (cond_top < 32) {
                    cond_stack[cond_top] = ACTIVE();
                    if (ACTIVE()) {
                        v = handle_if(expr);
                        cond_taken[cond_top] = v;
                        active = v;
                    } else {
                        cond_taken[cond_top] = 1; /* 外层为假，这层无效，禁止 else 分支误启用 */
                    }
                    cond_top++;
                }
            }
            else if (ark_streq(cmd, "ifdef") || ark_streq(cmd, "ifndef")) {
                int neg = ark_streq(cmd, "ifndef");
                char name[64];
                int nl = 0;
                while (*q && is_alnum(*q) && nl < 63) name[nl++] = *q++;
                name[nl] = 0;
                if (cond_top < 32) {
                    cond_stack[cond_top] = ACTIVE();
                    if (ACTIVE()) {
                        int defined = find_macro(name) ? 1 : 0;
                        int v = neg ? !defined : defined;
                        cond_taken[cond_top] = v;
                        active = v;
                    } else {
                        cond_taken[cond_top] = 1;
                    }
                    cond_top++;
                }
            }
            else if (ark_streq(cmd, "elif")) {
                if (cond_top > 0) {
                    int outer = cond_stack[cond_top - 1];
                    if (cond_taken[cond_top - 1]) {
                        active = 0;
                    } else if (outer) {
                        char expr[512]; int el = 0;
                        int v;
                        while (*q && *q != '\n' && el < 511) expr[el++] = *q++;
                        expr[el] = 0;
                        v = handle_if(expr);
                        cond_taken[cond_top - 1] = v;
                        active = v;
                    } else {
                        active = 0;
                    }
                }
            }
            else if (ark_streq(cmd, "else")) {
                if (cond_top > 0) {
                    int outer = cond_stack[cond_top - 1];
                    if (cond_taken[cond_top - 1]) active = 0;
                    else if (outer) { cond_taken[cond_top - 1] = 1; active = 1; }
                    else active = 0;
                }
            }
            else if (ark_streq(cmd, "endif")) {
                if (cond_top > 0) {
                    cond_top--;
                    active = cond_stack[cond_top];
                }
            }
            else if (ark_streq(cmd, "error") && ACTIVE()) {
                char msg[256]; int ml = 0;
                while (*q && *q != '\n' && ml < 255) msg[ml++] = *q++;
                msg[ml] = 0;
                ark_log("[preproc] error: %s\n", msg);
            }
            else if (ark_streq(cmd, "warning") && ACTIVE()) {
                char msg[256]; int ml = 0;
                while (*q && *q != '\n' && ml < 255) msg[ml++] = *q++;
                msg[ml] = 0;
                ark_log("[preproc] warning: %s\n", msg);
            }
            else if (ark_streq(cmd, "pragma")) {
                /* #pragma pack(n)/push/pop/() —— 调整全局结构体对齐。
                 * q 指向 "pragma" 之后的内容，若以 "pack" 开头则交由专用处理器。
                 * 其余 #pragma（如 once/Pack/anon_unions 等）静默忽略。
                 * #pragma location=addr —— 把目标地址转译为 "__at(addr) " 输出，
                 *   下一变量声明的 declspec 之前命中即被 parser 当作绝对地址。 */
                const char *r = q;
                if (r[0] == 'p' && r[1] == 'a' && r[2] == 'c' && r[3] == 'k' &&
                    (r[4] == '(' || r[4] == ' ' || r[4] == '\t')) {
                    handle_pragma_pack(r + 4);
                }
                /* #pragma location=addr：把绝对地址转写为 __at(N) 注入输出。
                 *   后跟变量声明（同一文件，next non-pragma line）的 parser 会
                 *   把 __at 当作 declspec 前置关键字消费掉。 */
                else if (r[0] == 'l' && r[1] == 'o' && r[2] == 'c' &&
                         r[3] == 'a' && r[4] == 't' && r[5] == 'i' &&
                         r[6] == 'o' && r[7] == 'n') {
                    const char *t2 = r + 8;
                    while (*t2 == ' ' || *t2 == '\t' || *t2 == '=') t2++;
                    if (*t2) {
                        unsigned addr = 0;
                        int got = 0;
                        if (t2[0] == '0' && (t2[1] == 'x' || t2[1] == 'X')) {
                            t2 += 2;
                            while ((*t2 >= '0' && *t2 <= '9') ||
                                   (*t2 >= 'a' && *t2 <= 'f') ||
                                   (*t2 >= 'A' && *t2 <= 'F')) {
                                int d;
                                if (*t2 <= '9') d = *t2 - '0';
                                else if (*t2 <= 'F') d = *t2 - 'A' + 10;
                                else d = *t2 - 'a' + 10;
                                addr = addr * 16 + (unsigned)d;
                                t2++; got = 1;
                            }
                        } else {
                            while (*t2 >= '0' && *t2 <= '9') {
                                addr = addr * 10 + (unsigned)(*t2 - '0');
                                t2++; got = 1;
                            }
                        }
                        if (got) {
                            /* 转写成 "__at(addr) "，parser 会识别。
                             * 输出十进制即可（lexer 的 NUM 在 0x.. 与十进制
                             * 上等价）。 */
                            buf_puts(out, out_len, out_cap, "__at(");
                            emit_int(out, out_len, out_cap, (int)addr);
                            buf_puts(out, out_len, out_cap, ") ");
                        }
                    }
                }
                /* anon_unions / Otrace / ... 之类静默忽略 */
                /* armcc 兼容 pragma：以下指令对 arkcc 无意义，显式识别并
                 * 静默吸收（用户在 MDK 中提供 retarget/启动代码）。
                 *   diag_suppress / diag_warning / diag_error / diag_default
                 *     —— 诊断抑制/恢复
                 *   arm / thumb —— 指令集切换（arkcc 始终生成 Thumb-2）
                 *   import(symbol) —— 如 import(__use_no_semihosting)
                 *   push / pop —— pragma 状态保存/恢复（不含 pack 栈）
                 *   O0/O1/O2/O3/Ospace/Otime/optimize —— 优化等级
                 * 这些都走"识别即忽略"路径，避免误判为未知指令产生噪音。 */
                else if (r[0] == 'd' && r[1] == 'i' && r[2] == 'a' && r[3] == 'g' && r[4] == '_') {
                    /* diag_suppress / diag_warning / diag_error / diag_default */
                }
                else if (ark_streq(r, "arm") || ark_streq(r, "thumb")) {
                    /* #pragma arm / #pragma thumb */
                }
                else if (r[0] == 'i' && r[1] == 'm' && r[2] == 'p' && r[3] == 'o' &&
                         r[4] == 'r' && r[5] == 't') {
                    /* #pragma import(__use_no_semihosting) 等 */
                }
                else if (ark_streq(r, "push") || ark_streq(r, "pop")) {
                    /* #pragma push / #pragma pop（armcc pragma 状态栈，
                     * 非 pack 栈；arkcc 不维护该栈，静默忽略） */
                }
                else if ((r[0] == 'O' && (r[1] == 0 || r[1] == ' ' || r[1] == '\t')) ||
                         (r[0] == 'O' && (r[1] == 's' || r[1] == 't')) ||
                         (r[0] == 'o' && r[1] == 'p' && r[2] == 't' && r[3] == 'i' &&
                          r[4] == 'm' && r[5] == 'i' && r[6] == 'z' && r[7] == 'e')) {
                    /* #pragma O0/O1/O2/O3/Ospace/Otime/optimize */
                }
            }
            else if (ark_streq(cmd, "line")) {
                /* 忽略 */
            }
            /* skip to EOL */
            while (*q && *q != '\n') q++;
            if (*q == '\n') { q++; line_no++; }
            p = q;
            buf_putc(out, out_len, out_cap, '\n'); /* 保持行号 */
            continue;
        }

        /* 字符串/字符字面量：原样拷贝（不被宏替换） */
        if (*p == '"' || *p == '\'') {
            char qc = *p;
            if (ACTIVE()) buf_putc(out, out_len, out_cap, *p);
            p++;
            while (*p && *p != qc) {
                if (*p == '\\' && p[1]) {
                    if (ACTIVE()) buf_putc(out, out_len, out_cap, *p);
                    p++;
                }
                if (*p == '\n') line_no++;
                if (ACTIVE()) buf_putc(out, out_len, out_cap, *p);
                p++;
            }
            if (*p) {
                if (ACTIVE()) buf_putc(out, out_len, out_cap, *p);
                p++;
            }
            continue;
        }

        if (*p == '/' && p[1] == '/') {
            while (*p && *p != '\n') {
                if (ACTIVE()) buf_putc(out, out_len, out_cap, *p);
                p++;
            }
            continue;
        }
        if (*p == '/' && p[1] == '*') {
            if (ACTIVE()) { buf_putc(out, out_len, out_cap, *p); buf_putc(out, out_len, out_cap, p[1]); }
            p += 2;
            while (*p && !(*p == '*' && p[1] == '/')) {
                if (*p == '\n') line_no++;
                if (ACTIVE()) buf_putc(out, out_len, out_cap, *p);
                p++;
            }
            if (*p) {
                if (ACTIVE()) { buf_putc(out, out_len, out_cap, *p); buf_putc(out, out_len, out_cap, p[1]); }
                p += 2;
            }
            continue;
        }

        /* 标识符：检查宏 */
        if (is_alpha(*p)) {
            const char *st = p;
            char name[64];
            int len = 0;
            Macro *m;
            while (is_alnum(*p) && len < 63) { name[len++] = *p++; }
            name[len] = 0;
            if (!ACTIVE()) continue;
            /* armcc 风格 __asm void fn(){...}：把后续 '{...}' 体视为原始文本，
             * 避免内部 "    #42" 这种立即数语法被错认为预处理指令。 */
            if (ark_streq(name, "__asm")) {
                /* 输出 "__asm" 本身，让 lexer/parser 识别 */
                int i;
                for (i = 0; i < len; i++) buf_putc(out, out_len, out_cap, st[i]);
                /* 向前扫描是否是函数体形式：跳过空白与类型名/名字/参数到 '{' */
                {
                    const char *r = p;
                    int saw_lparen = 0, saw_rparen = 0;
                    while (*r && *r != '{' && *r != ';' && *r != '"' && *r != '\'') {
                        if (*r == '(') saw_lparen = 1;
                        if (*r == ')') saw_rparen = 1;
                        r++;
                    }
                    if (*r == '{' && saw_lparen && saw_rparen) {
                        /* 把从 p 到 '{' 之后再到匹配 '}' 之间的文本原样输出。 */
                        while (p < r) {
                            if (*p == '\n') line_no++;
                            buf_putc(out, out_len, out_cap, *p);
                            p++;
                        }
                        /* 现在 *p == '{'：拷贝 '{'，再按括号深度拷贝到匹配 '}' */
                        buf_putc(out, out_len, out_cap, *p);
                        p++;
                        {
                            int depth = 1;
                            while (*p && depth > 0) {
                                if (*p == '{') depth++;
                                else if (*p == '}') {
                                    depth--;
                                    if (depth == 0) {
                                        buf_putc(out, out_len, out_cap, *p);
                                        p++;
                                        break;
                                    }
                                }
                                if (*p == '\n') line_no++;
                                buf_putc(out, out_len, out_cap, *p);
                                p++;
                            }
                        }
                        continue;
                    }
                }
                continue;
            }
            /* 内建宏 */
            if (ark_streq(name, "__LINE__")) {
                emit_int(out, out_len, out_cap, line_no);
                continue;
            }
            if (ark_streq(name, "__FILE__")) {
                buf_putc(out, out_len, out_cap, '"');
                buf_puts(out, out_len, out_cap, g_main_file);
                buf_putc(out, out_len, out_cap, '"');
                continue;
            }
            if (ark_streq(name, "__STDC__")) {
                buf_putc(out, out_len, out_cap, '1');
                continue;
            }
            if (ark_streq(name, "__ARK_CC__")) {
                buf_putc(out, out_len, out_cap, '1');
                continue;
            }
            m = find_macro(name);
            if (m) {
                if (m->is_func) {
                    const char *r = p;
                    while (*r == ' ' || *r == '\t') r++;
                    if (*r == '(') {
                        char *args[16] = {0};
                        int argc = 0;
                        r = parse_macro_args(r, args, &argc, 16);
                        expand_func_macro(m, args, argc, out, out_len, out_cap);
                        p = r;
                        continue;
                    } else {
                        /* 名称无后随括号：保持原样 */
                        int i;
                        for (i = 0; i < len; i++) buf_putc(out, out_len, out_cap, st[i]);
                        continue;
                    }
                }
                /* 对象宏：递归预处理 body 以支持嵌套宏 */
                process(m->body, out, out_len, out_cap);
                continue;
            }
            {
                int i;
                for (i = 0; i < len; i++) buf_putc(out, out_len, out_cap, st[i]);
            }
            continue;
        }

        if (*p == '\n') line_no++;
        if (ACTIVE()) buf_putc(out, out_len, out_cap, *p);
        p++;
    }
    g_cur_line = saved_line;
}

char *preproc_process(const char *src) {
    char *out = (char *)mem_pool_alloc(PP_BUF_SIZE);
    int out_len = 0;
    /* 注意：preproc_reset() 应该由 compiler.c 在每次编译开始时调用 */
    g_cur_line = 1;
    g_macro_expand = 1;
    /* 预定义 ARM Compiler 5 (armcc) 兼容宏与 ark 自定义编译器标识。
     * 这些宏在每次预处理开始时按需注入；用户脚本可通过 #undef 关闭。
     * 注意：__FILE__/__LINE__/__STDC__/__ARK_CC__ 在主驱动里特殊处理，
     * 这里仅追加普通对象宏。 */
    if (!find_macro("__arm__"))             add_object_macro("__arm__", "1");
    if (!find_macro("__thumb__"))           add_object_macro("__thumb__", "2");
    if (!find_macro("__ARMCC_VERSION"))     add_object_macro("__ARMCC_VERSION", "5060750");
    if (!find_macro("__TARGET_ARCH_7_M"))   add_object_macro("__TARGET_ARCH_7_M", "1");
    if (!find_macro("__TARGET_ARCH_7E_M"))  add_object_macro("__TARGET_ARCH_7E_M", "1");
    if (!find_macro("__TARGET_FPU_VFP"))    add_object_macro("__TARGET_FPU_VFP", "1");
    if (!find_macro("__BIG_ENDIAN"))        add_object_macro("__BIG_ENDIAN", "0");
    if (!find_macro("__LITTLE_ENDIAN__"))   add_object_macro("__LITTLE_ENDIAN__", "1");
    if (!find_macro("__sizeof_int"))        add_object_macro("__sizeof_int", "4");
    if (!find_macro("__sizeof_ptr"))        add_object_macro("__sizeof_ptr", "4");
    process(src, out, &out_len, PP_BUF_SIZE - 1);
    out[out_len] = 0;
    return out;
}
