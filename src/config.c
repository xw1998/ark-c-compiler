/* Ark C Compiler - config
 * 运行时配置：把编译期默认 / 配置文件 / 命令行三处来源的开关合并到 g_config。
 *
 * 优先级：命令行 > 配置文件 > 编译期默认（ARKCC_FEATURE_*）。
 *   - config_init            : 用宏默认值填充 g_config。
 *   - config_load_file(path) : 解析 INI 风格 arkcc.cfg，覆盖默认值。
 *   - config_apply_args      : 扫描 argv 中的 -O/-g/-fxxx/-fno-xxx，
 *                              覆盖文件设置（最高优先级）。
 */
#include "config.h"
#include "platform.h"
#include "flash_fs.h"

ArkccConfig g_config;

/* 把字符串值（"0"/"1"/"true"/"false" 等）转成 int 0/1。
 * 解析失败时返回 0。 */
static int parse_bool(const char *s) {
    if (!s || !*s) return 0;
    if (s[0] == '0' && s[1] == 0) return 0;
    if (s[0] == '1' && s[1] == 0) return 1;
    if ((s[0] == 't' || s[0] == 'T') &&
        (s[1] == 'r' || s[1] == 'R') &&
        (s[2] == 'u' || s[2] == 'U') &&
        (s[3] == 'e' || s[3] == 'E') &&
        s[4] == 0) return 1;
    if ((s[0] == 'f' || s[0] == 'F') &&
        (s[1] == 'a' || s[1] == 'A') &&
        (s[2] == 'l' || s[2] == 'L') &&
        (s[3] == 's' || s[3] == 'S') &&
        (s[4] == 'e' || s[4] == 'E') &&
        s[5] == 0) return 0;
    /* 非零数字视为真 */
    if (s[0] >= '0' && s[0] <= '9') return 1;
    return 0;
}

static int parse_int(const char *s, int *out) {
    int sign = 1; int v = 0; int seen = 0;
    if (!s || !*s) return 0;
    if (*s == '-') { sign = -1; s++; }
    else if (*s == '+') s++;
    while (*s >= '0' && *s <= '9') { v = v * 10 + (*s - '0'); s++; seen = 1; }
    if (!seen) return 0;
    *out = sign * v;
    return 1;
}

void config_init(void) {
    g_config.enable_vla           = ARKCC_FEATURE_VLA;
    g_config.enable_complex       = ARKCC_FEATURE_COMPLEX;
    g_config.enable_wchar         = ARKCC_FEATURE_WCHAR;
    g_config.enable_trigraph      = ARKCC_FEATURE_TRIGRAPH;
    g_config.enable_fpu_hw        = ARKCC_FEATURE_FPU_HW;
    g_config.enable_dwarf         = ARKCC_FEATURE_DWARF;
    g_config.enable_opt_constfold = ARKCC_FEATURE_OPT_CONSTFOLD;
    g_config.enable_opt_dce       = ARKCC_FEATURE_OPT_DCE;
    g_config.enable_opt_regalloc  = ARKCC_FEATURE_OPT_REGALLOC;
    g_config.enable_opt_inline    = ARKCC_FEATURE_OPT_INLINE;
    g_config.enable_opt_vectorize = ARKCC_FEATURE_OPT_VECTORIZE;
    g_config.opt_level            = 0;
    g_config.debug_info           = 0;
    g_config.split_sections       = 0;
    g_config.config_file          = 0;
    /* 0.6.x：armcc 5 兼容运行时开关默认值 */
    g_config.enum_is_int          = 0;
    g_config.dollar_in_identifiers= 1;  /* armcc 默认支持 $ 标识符 */
    g_config.signed_chars         = 0;
    g_config.unsigned_chars       = 0;
    g_config.wchar16              = 0;
    g_config.wchar32              = 0;
    g_config.dwarf_version        = 0;
    g_config.scatter_file         = 0;
    g_config.fpu_type             = 0;
}

/* 把 "key=value" 应用到 g_config。section 为当前 INI 段名（"features"/"general"）。
 * 未知键静默忽略——配置文件可包含本编译器尚未识别的项。 */
static void apply_kv(const char *section, const char *key, const char *val) {
    if (!key || !val) return;
    if (ark_streq(section, "features")) {
        if (ark_streq(key, "vla"))            g_config.enable_vla           = parse_bool(val);
        else if (ark_streq(key, "complex"))   g_config.enable_complex       = parse_bool(val);
        else if (ark_streq(key, "wchar"))     g_config.enable_wchar         = parse_bool(val);
        else if (ark_streq(key, "trigraph"))  g_config.enable_trigraph      = parse_bool(val);
        else if (ark_streq(key, "fpu_hw"))    g_config.enable_fpu_hw        = parse_bool(val);
        else if (ark_streq(key, "dwarf"))     g_config.enable_dwarf         = parse_bool(val);
        else if (ark_streq(key, "opt_constfold")) g_config.enable_opt_constfold = parse_bool(val);
        else if (ark_streq(key, "opt_dce"))   g_config.enable_opt_dce       = parse_bool(val);
        else if (ark_streq(key, "opt_regalloc")) g_config.enable_opt_regalloc = parse_bool(val);
        else if (ark_streq(key, "opt_inline"))    g_config.enable_opt_inline    = parse_bool(val);
        else if (ark_streq(key, "opt_vectorize")) g_config.enable_opt_vectorize = parse_bool(val);
    } else if (ark_streq(section, "general")) {
        if (ark_streq(key, "opt_level")) {
            int v = 0;
            if (parse_int(val, &v)) {
                if (v < 0) v = 0;
                if (v > 2) v = 2;
                g_config.opt_level = v;
            }
        } else if (ark_streq(key, "debug_info")) {
            g_config.debug_info = parse_bool(val) ? 1 : 0;
        } else if (ark_streq(key, "split_sections") || ark_streq(key, "function-sections")) {
            g_config.split_sections = parse_bool(val) ? 1 : 0;
        }
    }
}

void config_load_file(const char *path) {
    static char cfg_buf[4096];
    char section[64] = "";
    int len;
    int i;
    char *line_start;
    if (!path) return;
    /* 用 fs_read_file 一次性读取整个配置文件（host=stdio，STM32=W25Q Flash）。
     * 失败时静默回退到编译期默认值。 */
    len = fs_read_file(path, cfg_buf, (int)sizeof(cfg_buf) - 1);
    if (len < 0) {
        ark_log("[config] cannot open config file '%s' (ignored)\n", path);
        return;
    }
    cfg_buf[len] = 0;
    g_config.config_file = path;
    /* 逐行解析：手动按 \n 切分。CR/LF 一并处理。 */
    line_start = cfg_buf;
    for (i = 0; i <= len; i++) {
        if (i == len || cfg_buf[i] == '\n') {
            char *p = line_start;
            char *key;
            char *val;
            char *eq;
            char *end;
            /* 截断当前行 */
            if (i < len) cfg_buf[i] = 0;
            /* 去掉行尾 \r */
            {
                int ll = (int)(&cfg_buf[i] - p);
                while (ll > 0 && (p[ll-1] == '\r')) { p[ll-1] = 0; ll--; }
            }
            /* 跳过前导空白 */
            while (*p == ' ' || *p == '\t') p++;
            /* 空行/注释 */
            if (*p == 0 || *p == ';' || *p == '#') {
                line_start = &cfg_buf[i + 1];
                continue;
            }
            /* 段名 [section] */
            if (*p == '[') {
                char *q = p + 1;
                char *e = q;
                while (*e && *e != ']') e++;
                *e = 0;
                {
                    int k = 0;
                    while (q[k] && k < (int)sizeof(section) - 1) { section[k] = q[k]; k++; }
                    section[k] = 0;
                }
                line_start = &cfg_buf[i + 1];
                continue;
            }
            /* key=value */
            eq = p;
            while (*eq && *eq != '=') eq++;
            if (*eq != '=') {
                line_start = &cfg_buf[i + 1];
                continue;
            }
            *eq = 0;
            /* 去掉 key 尾空白 */
            end = eq;
            while (end > p && (end[-1] == ' ' || end[-1] == '\t')) { end--; *end = 0; }
            key = p;
            val = eq + 1;
            /* 跳过 val 前空白 */
            while (*val == ' ' || *val == '\t') val++;
            /* 去掉 val 尾空白 */
            {
                char *ve = val;
                while (*ve) ve++;
                while (ve > val && (ve[-1] == ' ' || ve[-1] == '\t')) { ve--; *ve = 0; }
            }
            apply_kv(section, key, val);
            line_start = &cfg_buf[i + 1];
        }
    }
}

/* 命令行识别以下参数并更新 g_config：
 *   -O0/-O1/-O2/-O3  : opt_level
 *   -g               : debug_info=1
 *   -fno-<feature>   : 关闭某个 feature
 *   -f<feature>      : 打开某个 feature
 *   -config <file>   : 配置文件路径（仅记录，不在此加载；由 main 处理）
 *
 * feature 名称：vla/complex/wchar/trigraph/fpu/fpu_hw/dwarf/opt-constfold/
 *               opt-dce/opt-regalloc/constfold/dce/regalloc
 * 不识别的参数原样不动（main 仍会处理 -o/-target/-I 等）。
 *
 * 0.6.x 新增 armcc 5 风格 --xxx 选项（多数静默接受）：
 *   --enum_is_int / -fenum-is-int / --dollar / --signed_chars / --unsigned_chars
 *   --wchar16 / --wchar32 / --dwarf2 / --dwarf3 / --scatter <file> / --fpu <name>
 *   --thumb / --arm / --remarks / --autoinline / --no_autoinline
 *   --vectorize / --no_vectorize / --split_sections / --library_type
 *   --locale / --multibyte_chars / --data_reorder / --diag_style
 *   --remove_unneeded_entities
 *   --cpp : 报错"不支持 C++"
 */
void config_apply_args(int argc, char **argv) {
    int i;
    if (!argv) return;
    for (i = 1; i < argc; i++) {
        const char *a = argv[i];
        if (!a || a[0] != '-') continue;
        if (a[0] == '-' && a[1] == 'O' && a[2] >= '0' && a[2] <= '9' && a[3] == 0) {
            g_config.opt_level = a[2] - '0';
            if (g_config.opt_level > 2) g_config.opt_level = 2;
            /* -O2 自动启用内联与向量化 */
            if (g_config.opt_level >= 2) {
                g_config.enable_opt_inline    = 1;
                g_config.enable_opt_vectorize = 1;
            }
            continue;
        }
        if (ark_streq(a, "-g")) {
            g_config.debug_info = 1;
            continue;
        }
        if (ark_streq(a, "-config") && i + 1 < argc) {
            /* 仅记录路径，加载由 main 在调用 config_apply_args 之前完成 */
            g_config.config_file = argv[i + 1];
            i++;
            continue;
        }
        /* --cpp：arkcc 不支持 C++，明确报错 */
        if (ark_streq(a, "--cpp")) {
            ark_log("[arkcc] error: C++ (--cpp) is not supported\n");
            continue;
        }
        /* 0.6.x：armcc 5 风格 --xxx 选项 */
        if (ark_streq(a, "--enum_is_int") || ark_streq(a, "-fenum-is-int")) {
            g_config.enum_is_int = 1;
            continue;
        }
        if (ark_streq(a, "--dollar")) {
            g_config.dollar_in_identifiers = 1;
            continue;
        }
        if (ark_streq(a, "--signed_chars")) {
            g_config.signed_chars = 1;
            g_config.unsigned_chars = 0;
            continue;
        }
        if (ark_streq(a, "--unsigned_chars")) {
            g_config.unsigned_chars = 1;
            g_config.signed_chars = 0;
            continue;
        }
        if (ark_streq(a, "--wchar16")) {
            g_config.wchar16 = 1;
            g_config.wchar32 = 0;
            continue;
        }
        if (ark_streq(a, "--wchar32")) {
            g_config.wchar32 = 1;
            g_config.wchar16 = 0;
            continue;
        }
        if (ark_streq(a, "--dwarf2")) { g_config.dwarf_version = 2; continue; }
        if (ark_streq(a, "--dwarf3")) { g_config.dwarf_version = 3; continue; }
        if (ark_streq(a, "--scatter") && i + 1 < argc) {
            g_config.scatter_file = argv[i + 1];
            i++;
            continue;
        }
        if (ark_streq(a, "--fpu") && i + 1 < argc) {
            const char *name = argv[i + 1];
            g_config.fpu_type = name;
            /* 简化：none → 关 FPU；其他 → 开 FPU */
            if (ark_streq(name, "none")) g_config.enable_fpu_hw = 0;
            else                          g_config.enable_fpu_hw = 1;
            i++;
            continue;
        }
        /* 静默接受的 armcc 5 选项（不影响代码生成） */
        if (ark_streq(a, "--thumb") || ark_streq(a, "--arm") ||
            ark_streq(a, "--remarks") ||
            ark_streq(a, "--library_type") || ark_streq(a, "--locale") ||
            ark_streq(a, "--multibyte_chars") || ark_streq(a, "--data_reorder") ||
            ark_streq(a, "--diag_style") ||
            ark_streq(a, "--remove_unneeded_entities")) {
            continue;
        }
        /* --autoinline / --no_autoinline：开启/关闭自动内联 */
        if (ark_streq(a, "--autoinline")) {
            g_config.enable_opt_inline = 1;
            continue;
        }
        if (ark_streq(a, "--no_autoinline")) {
            g_config.enable_opt_inline = 0;
            continue;
        }
        /* --vectorize / --no_vectorize：开启/关闭自动向量化 */
        if (ark_streq(a, "--vectorize")) {
            g_config.enable_opt_vectorize = 1;
            continue;
        }
        if (ark_streq(a, "--no_vectorize")) {
            g_config.enable_opt_vectorize = 0;
            continue;
        }
        /* -fno-xxx / -fxxx */
        if (a[0] == '-' && a[1] == 'f') {
            int enable;
            const char *name;
            if (a[2] == 'n' && a[3] == 'o' && a[4] == '-') {
                enable = 0;
                name = a + 5;
            } else {
                enable = 1;
                name = a + 2;
            }
            if (!*name) continue;
            if      (ark_streq(name, "vla"))            g_config.enable_vla           = enable;
            else if (ark_streq(name, "complex"))        g_config.enable_complex       = enable;
            else if (ark_streq(name, "wchar"))          g_config.enable_wchar         = enable;
            else if (ark_streq(name, "trigraph"))       g_config.enable_trigraph      = enable;
            else if (ark_streq(name, "fpu") || ark_streq(name, "fpu_hw") || ark_streq(name, "fpu-hw"))
                g_config.enable_fpu_hw                  = enable;
            else if (ark_streq(name, "dwarf"))          g_config.enable_dwarf         = enable;
            else if (ark_streq(name, "opt-constfold") || ark_streq(name, "constfold"))
                g_config.enable_opt_constfold           = enable;
            else if (ark_streq(name, "opt-dce") || ark_streq(name, "dce"))
                g_config.enable_opt_dce                 = enable;
            else if (ark_streq(name, "opt-regalloc") || ark_streq(name, "regalloc"))
                g_config.enable_opt_regalloc            = enable;
            else if (ark_streq(name, "opt-inline") || ark_streq(name, "autoinline"))
                g_config.enable_opt_inline              = enable;
            else if (ark_streq(name, "opt-vectorize") || ark_streq(name, "vectorize"))
                g_config.enable_opt_vectorize           = enable;
            else if (ark_streq(name, "function-sections") || ark_streq(name, "split_sections"))
                g_config.split_sections                 = enable;
            else if (ark_streq(name, "enum-is-int"))   g_config.enum_is_int          = enable;
            else if (ark_streq(name, "dollar"))        g_config.dollar_in_identifiers= enable;
            /* 未识别 -fxxx：忽略，不报错（避免与 gcc 风格的 -fxxx 冲突） */
        }
    }
}

void config_print(void) {
    ark_log("[arkcc] config:\n");
    ark_log("  vla=%d complex=%d wchar=%d trigraph=%d\n",
            g_config.enable_vla, g_config.enable_complex,
            g_config.enable_wchar, g_config.enable_trigraph);
    ark_log("  fpu_hw=%d dwarf=%d\n",
            g_config.enable_fpu_hw, g_config.enable_dwarf);
    ark_log("  opt_constfold=%d opt_dce=%d opt_regalloc=%d\n",
            g_config.enable_opt_constfold, g_config.enable_opt_dce,
            g_config.enable_opt_regalloc);
    ark_log("  opt_inline=%d opt_vectorize=%d\n",
            g_config.enable_opt_inline, g_config.enable_opt_vectorize);
    ark_log("  opt_level=%d debug_info=%d split_sections=%d\n",
            g_config.opt_level, g_config.debug_info, g_config.split_sections);
    ark_log("  config_file=%s\n",
            g_config.config_file ? g_config.config_file : "(none)");
}
