/* Ark C Compiler - C source backend
 * Emits IR instructions as C source text that the host compiler (gcc) compiles
 * to a native executable.
 *
 * Design overview:
 *   - Each arkcc function is emitted as `long long ark_<name>(long long a0, ...)`.
 *   - The runtime stack is `long long stk[256]` with an `int sp` index; the IR
 *     push/pop model maps directly onto this stack.
 *   - Locals/parameters live in a `char frame[]` array addressed by offset.
 *   - IR_CALL dispatches to either the host libc (for is_libc_func entries) or
 *     to user-defined `ark_<name>` functions; unused argument slots default to 0.
 *   - String literals are emitted as `const char *ark_str_<id>`.
 *   - The C `main` entry is generated separately and calls `ark_main(0,0,...)`.
 *   - Functions with no forward declaration in the IR are assumed to be host
 *     libc functions (printf/putchar/puts/strlen/strcmp/strcpy/memcpy/memset/
 *     abort); their prototypes are emitted before use so the host libc links.
 */
#include "backend.h"
#include "codegen.h"
#include "memory.h"
#include "platform.h"
#include "common.h"
#include "config.h"
#include "arkcc_config.h"
#include <stdio.h>   /* snprintf used for float constant formatting */

#define MAX_CALL_ARGS 16

static void emit_str_literal(AsmBuffer *b, const char *data, int len) {
    int i;
    asmbuf_putc(b, '"');
    for (i = 0; i < len; i++) {
        unsigned char c = (unsigned char)data[i];
        switch (c) {
            case '\n': asmbuf_puts(b, "\\n"); break;
            case '\t': asmbuf_puts(b, "\\t"); break;
            case '\r': asmbuf_puts(b, "\\r"); break;
            case '\\': asmbuf_puts(b, "\\\\"); break;
            case '"':  asmbuf_puts(b, "\\\""); break;
            default:
                if (c < 0x20 || c >= 0x7F) {
                    char buf[8];
                    int n = 0;
                    buf[n++] = '\\';
                    buf[n++] = 'x';
                    {
                        const char *hex = "0123456789abcdef";
                        buf[n++] = hex[(c >> 4) & 0xF];
                        buf[n++] = hex[c & 0xF];
                    }
                    buf[n] = 0;
                    asmbuf_puts(b, buf);
                } else {
                    asmbuf_putc(b, (char)c);
                }
                break;
        }
    }
    asmbuf_putc(b, '"');
}

/* Emit a binary operator for the C backend.
 * The aux flag bit 0x100 marks an unsigned operation; because C99 integer
 * promotion rules make `int/unsigned` already unsigned, we only need an
 * explicit cast for unsigned int (32-bit) but not for unsigned long long (64-bit).
 * For the 32-bit path (IR_BINARY), we cast to (unsigned int); for the 64-bit
 * path (IR_64BINARY), 32-bit cast is unnecessary.
 * This matters for shifts and comparisons, e.g. int -1 vs unsigned 0xFFFFFFFF. */
static void emit_binop(AsmBuffer *b, int op) {
    int is_unsigned = (op & 0x100) != 0;
    int base_op = op & ~0x100;
    /* lhs op rhs form; operands are loaded into ark_a/ark_c before emission. */
    switch (base_op) {
        case (int)TOK_PLUS:  asmbuf_puts(b, "(ark_a + ark_c)"); break;
        case (int)TOK_MINUS: asmbuf_puts(b, "(ark_a - ark_c)"); break;
        case (int)TOK_MUL:   asmbuf_puts(b, "(ark_a * ark_c)"); break;
        case (int)TOK_DIV:   asmbuf_puts(b, "(ark_c ? ark_a / ark_c : 0)"); break;
        case (int)TOK_MOD:   asmbuf_puts(b, "(ark_c ? ark_a % ark_c : 0)"); break;
        case (int)TOK_BAND:  asmbuf_puts(b, "(ark_a & ark_c)"); break;
        case (int)TOK_BOR:   asmbuf_puts(b, "(ark_a | ark_c)"); break;
        case (int)TOK_BXOR:  asmbuf_puts(b, "(ark_a ^ ark_c)"); break;
        case (int)TOK_SHL:   asmbuf_puts(b, "(ark_a << ark_c)"); break;
        case (int)TOK_SHR:
            if (is_unsigned) asmbuf_puts(b, "((unsigned int)ark_a >> ark_c)");
            else             asmbuf_puts(b, "(ark_a >> ark_c)");
            break;
        case (int)TOK_EQ:    asmbuf_puts(b, "(ark_a == ark_c)"); break;
        case (int)TOK_NE:    asmbuf_puts(b, "(ark_a != ark_c)"); break;
        case (int)TOK_LT:
            if (is_unsigned) asmbuf_puts(b, "((unsigned int)ark_a < (unsigned int)ark_c)");
            else             asmbuf_puts(b, "(ark_a < ark_c)");
            break;
        case (int)TOK_GT:
            if (is_unsigned) asmbuf_puts(b, "((unsigned int)ark_a > (unsigned int)ark_c)");
            else             asmbuf_puts(b, "(ark_a > ark_c)");
            break;
        case (int)TOK_LE:
            if (is_unsigned) asmbuf_puts(b, "((unsigned int)ark_a <= (unsigned int)ark_c)");
            else             asmbuf_puts(b, "(ark_a <= ark_c)");
            break;
        case (int)TOK_GE:
            if (is_unsigned) asmbuf_puts(b, "((unsigned int)ark_a >= (unsigned int)ark_c)");
            else             asmbuf_puts(b, "(ark_a >= ark_c)");
            break;
        default:             asmbuf_puts(b, "(ark_a)"); break;
    }
}

static void emit_func_proto(AsmBuffer *b, IrFunc *f) {
    int i;
    /* Emit only the prototype; static linkage keeps it file-local.
     * __weak/__naked are GCC attributes; __irq is emitted as a comment because
     * host builds do not handle interrupt vectoring. */
    if (f->is_weak)   asmbuf_puts(b, "__attribute__((weak)) ");
    if (f->is_naked || f->is_asm_func) asmbuf_puts(b, "__attribute__((naked)) ");
    if (f->is_used)   asmbuf_puts(b, "__attribute__((used)) ");
    if (f->is_unused) asmbuf_puts(b, "__attribute__((unused)) ");
    if (f->forceinline) asmbuf_puts(b, "__attribute__((always_inline)) inline ");
    /* constructor/destructor emit into gcc's .init_array/.fini_array sections;
     * deprecated triggers a gcc warning at the use site. */
    if (f->is_constructor) asmbuf_puts(b, "__attribute__((constructor)) ");
    if (f->is_destructor)  asmbuf_puts(b, "__attribute__((destructor)) ");
    if (f->is_deprecated)  asmbuf_puts(b, "__attribute__((deprecated)) ");
#if ARKCC_FEATURE_ARMCC_KEYWORDS
    /* armcc 5 keywords mapped to the closest gcc equivalent:
     *   __pure            -> __attribute__((pure))
     *   __attribute__((const)) -> __attribute__((const))
     *   __value_in_regs   -> no gcc equivalent; ignored (struct return ABI differs)
     *   __interwork       -> ARM/Thumb interworking; ignored on host builds
     *   __smc(n)          -> secure monitor call; ignored on host builds */
    if (f->is_pure)       asmbuf_puts(b, "__attribute__((pure)) ");
    if (f->is_const_attr) asmbuf_puts(b, "__attribute__((const)) ");
#endif
    if (f->alias_target) {
        /* alias attribute: __attribute__((alias("ark_xxx"))) */
        asmbuf_puts(b, "__attribute__((alias(\"ark_");
        asmbuf_puts(b, f->alias_target);
        asmbuf_puts(b, "\"))) ");
    }
    asmbuf_puts(b, f->is_static ? "static long long ark_" : "long long ark_");
    asmbuf_puts(b, f->name);
    asmbuf_puts(b, "(");
    for (i = 0; i < MAX_CALL_ARGS; i++) {
        if (i) asmbuf_puts(b, ", ");
        asmbuf_puts(b, "long long a");
        asmbuf_int(b, i);
    }
    asmbuf_puts(b, ");");
    if (f->is_irq) asmbuf_puts(b, " /* __irq */");
#if ARKCC_FEATURE_ARMCC_KEYWORDS
    if (f->is_value_in_regs) asmbuf_puts(b, " /* __value_in_regs */");
    if (f->is_interwork)     asmbuf_puts(b, " /* __interwork */");
    if (f->smc_num > 0) {
        asmbuf_puts(b, " /* __smc(");
        asmbuf_int(b, f->smc_num);
        asmbuf_puts(b, ") */");
    }
    if (f->global_reg >= 0) {
        asmbuf_puts(b, " /* __global_reg(");
        asmbuf_int(b, f->global_reg);
        asmbuf_puts(b, ") */");
    }
#endif
    asmbuf_putc(b, '\n');
}

/* Decide whether a function calls directly into host libc; such functions do
 * not have an ark_ wrapper and are referenced via extern declarations. */
static int is_libc_func(const char *name) {
    static const char *libcs[] = {
        "printf", "putchar", "puts", "strlen", "strcmp",
        "strcpy", "memset", "memcpy", "abort",
        /* setjmp/longjmp: dispatched in IR_CALL because the setjmp macro form
         * is incompatible; the IR folds jmp_buf into frame so we cast back.
         * We require host jmp_buf to be at least 40 bytes. */
        "setjmp", "longjmp",
        /* stdlib.h */
        "llabs", "lldiv", "div", "ldiv", "atoll", "_Exit",
        "strtoll", "strtoull", "strtoimax", "strtoumax",
        "imaxabs", "imaxdiv", "strtod", "strtof", "strtold",
        "strtol", "strtoul", "atoi", "atol", "atof",
        "malloc", "calloc", "realloc", "free",
        "qsort", "bsearch", "srand", "rand",
        "exit", "atexit", "system", "getenv",
        /* stdio.h */
        "snprintf", "vsnprintf", "sprintf", "vsprintf",
        "fprintf", "vfprintf", "fputs", "fputc", "putc",
        "vprintf", "vscanf", "vsscanf", "vfscanf",
        "scanf", "sscanf", "fscanf", "fread", "fwrite",
        "fopen", "fclose", "fgets", "fgetc", "getchar",
        "rewind", "fseek", "ftell", "fflush", "remove", "rename",
        "perror",
        /* string.h */
        "strncmp", "strcat", "strncat", "strncpy", "strchr",
        "strrchr", "strstr", "strtok", "strdup", "strpbrk",
        "strspn", "strcspn", "strcoll", "strxfrm", "strerror",
        "memmove", "memcmp", "memchr",
        /* math.h */
        "sqrt", "sqrtf", "sqrtl", "pow", "powf", "powl",
        "exp", "expf", "expl", "exp2", "exp2f", "exp2l",
        "expm1", "expm1f", "expm1l",
        "log", "logf", "logl", "log10", "log10f", "log10l",
        "log2", "log2f", "log2l", "log1p", "log1pf", "log1pl",
        "logb", "logbf", "logbl",
        "sin", "sinf", "sinl", "cos", "cosf", "cosl",
        "tan", "tanf", "tanl",
        "asin", "asinf", "asinl", "acos", "acosf", "acosl",
        "atan", "atanf", "atanl", "atan2", "atan2f", "atan2l",
        "sinh", "sinhf", "sinhl", "cosh", "coshf", "coshl",
        "tanh", "tanhf", "tanhl",
        "asinh", "asinhf", "asinhl", "acosh", "acoshf", "acoshl",
        "atanh", "atanhf", "atanhl",
        "ceil", "ceilf", "ceill", "floor", "floorf", "floorl",
        "fabs", "fabsf", "fabsl", "fmod", "fmodf", "fmodl",
        "modf", "modff", "modfl",
        "ldexp", "ldexpf", "ldexpl", "frexp", "frexpf", "frexpl",
        "trunc", "truncf", "truncl", "round", "roundf", "roundl",
        "lround", "lroundf", "lroundl", "llround", "llroundf", "llroundl",
        "rint", "rintf", "rintl", "lrint", "lrintf", "lrintl",
        "llrint", "llrintf", "llrintl", "nearbyint", "nearbyintf", "nearbyintl",
        "isnan", "isinf", "isfinite", "signbit",
        "isnanf", "isnanl", "isinff", "isinfl",
        "fmax", "fmaxf", "fmaxl", "fmin", "fminf", "fminl",
        "fdim", "fdimf", "fdiml", "fma", "fmaf", "fmal",
        "hypot", "hypotf", "hypotl", "cbrt", "cbrtf", "cbrtl",
        "copysign", "copysignf", "copysignl",
        "scalbn", "scalbnf", "scalbnl", "scalbln", "scalblnf", "scalblnl",
        "nextafter", "nextafterf", "nextafterl",
        "nexttoward", "nexttowardf", "nexttowardl",
        "nan", "nanf", "nanl",
        "remainder", "remainderf", "remainderl",
        "remquo", "remquof", "remquol",
        "erf", "erff", "erfl", "erfc", "erfcf", "erfcl",
        "lgamma", "lgammaf", "lgammal",
        "tgamma", "tgammaf", "tgammal",
        /* complex.h */
        "creal", "crealf", "creall", "cimag", "cimagf", "cimagl",
        "conj", "conjf", "conjl", "cabs", "cabsf", "cabsl",
        "carg", "cargf", "cargl", "cexp", "cexpf", "cexpl",
        "clog", "clogf", "csqrt", "csqrtf", "cpow",
        "csin", "ccos", "ctan",
        "csinh", "ccosh", "ctanh",
        "casin", "cacos", "catan",
        "casinh", "cacosh", "catanh",
        "cproj", "cprojf", "cprojl",
        /* ctype.h */
        "isalnum", "isalpha", "isblank", "iscntrl", "isdigit",
        "isgraph", "islower", "isprint", "ispunct", "isspace",
        "isupper", "isxdigit", "tolower", "toupper",
        /* wctype.h */
        "iswalpha", "iswdigit", "iswspace", "iswupper", "iswlower",
        "iswxdigit", "iswalnum", "iswcntrl", "iswgraph", "iswprint",
        "iswpunct", "iswblank", "iswctype", "towupper", "towlower",
        "wctype", "wctrans", "towctrans",
        /* wchar.h */
        "wcslen", "wcscmp", "wcsncmp", "wcscpy", "wcsncpy",
        "wcscat", "wcsncat", "wcschr", "wcscspn", "wcsspn",
        "wcstok", "wcstol", "wcstoul", "wcstoll", "wcstoull",
        "wcstoimax", "wcstoumax", "wcstod", "wcstof", "wcstold",
        "swprintf", "vswprintf", "wprintf", "fwprintf",
        "swscanf", "wscanf", "fwscanf",
        "fputwc", "getwc", "ungetwc",
        "mbrtowc", "wcrtomb", "mbstowcs", "wcstombs", "mbsinit",
        "wctob", "btowc",
        /* time.h */
        "time", "clock", "difftime", "mktime",
        "localtime", "gmtime", "asctime", "ctime",
        "strftime", "wcsftime",
        /* locale.h */
        "setlocale", "localeconv",
        /* signal.h */
        "signal", "raise",
        /* fenv.h */
        "fegetenv", "fesetenv", "fegetround", "fesetround",
        "feclearexcept", "fetestexcept", "feholdexcept", "feupdateenv",
        "fegetexceptflag", "fesetexceptflag",
        /* tgmath.h type-generic macros expand to the above libc entries. */
        0
    };
    int i;
    if (!name) return 0;
    for (i = 0; libcs[i]; i++) if (ark_streq(name, libcs[i])) return 1;
    return 0;
}

/* Decide whether a function returns void. Such functions never push a result;
 * the IR_CALL path synthesizes a 0 value onto the stack. */
static int is_void_func(const char *name) {
    static const char *voids[] = {
        "free", "exit", "_Exit", "abort", "srand", "qsort",
        "setbuf", "setvbuf", "fflush", "fclose", "fputs", "fputc",
        "putc", "fseek", "rewind", "remove", "rename", "perror",
        "memcpy", "memmove", "memset", "strcpy", "strcat", "strncpy",
        "strncat", "wcscpy", "wcsncpy", "wcscat", "wcsncat",
        "feclearexcept", "fesetround", "fesetenv", "feholdexcept",
        "feupdateenv", "fesetexceptflag",
        "free", "exit", "atexit",
        0
    };
    int i;
    if (!name) return 0;
    for (i = 0; voids[i]; i++) if (ark_streq(name, voids[i])) return 1;
    return 0;
}

/* Decide whether a function returns a struct. These functions must not be
 * cast to (long long); the result is stored via the struct-return slot and
 * the quot/rem members need correct typing. */
static int is_struct_ret_func(const char *name) {
    static const char *structs[] = {
        "lldiv", "ldiv", "div", "imaxdiv",
        0
    };
    int i;
    if (!name) return 0;
    for (i = 0; structs[i]; i++) if (ark_streq(name, structs[i])) return 1;
    return 0;
}

static int is_complex_ret_func(const char *name) {
    /* Detect functions returning _Complex. Their return value must be stored in
     * the .c member (16 bytes); casting to (long long) would drop the
     * imaginary part. Their arguments are also _Complex and must be popped
     * via .c. */
    static const char *cplx[] = {
        "conj", "conjf", "conjl",
        "cexp", "cexpf", "cexpl",
        "clog", "clogf", "clogl",
        "csqrt", "csqrtf", "csqrtl",
        "cpow", "cpowf", "cpowl",
        "csin", "csinf", "csinl",
        "ccos", "ccosf", "ccosl",
        "ctan", "ctanf", "ctanl",
        "csinh", "csinhf", "csinhl",
        "ccosh", "ccoshf", "ccoshl",
        "ctanh", "ctanhf", "ctanhl",
        "casin", "casinf", "casinl",
        "cacos", "cacosf", "cacosl",
        "catan", "catanf", "catanl",
        "casinh", "casinhf", "casinhl",
        "cacosh", "cacoshf", "cacoshl",
        "catanh", "catanhf", "catanhl",
        "cproj", "cprojf", "cprojl",
        0
    };
    int i;
    if (!name) return 0;
    for (i = 0; cplx[i]; i++) if (ark_streq(name, cplx[i])) return 1;
    return 0;
}

static const char *struct_ret_type(const char *name) {
    if (ark_streq(name, "lldiv"))  return "lldiv_t";
    if (ark_streq(name, "ldiv"))   return "ldiv_t";
    if (ark_streq(name, "div"))    return "div_t";
    if (ark_streq(name, "imaxdiv")) return "imaxdiv_t";
    return "lldiv_t";
}

/* Decide whether a function has an ark_ wrapper. These are static inline
 * helpers that take long long slots and bridge to the host libc with the
 * correct double/pointer casts; IR_CALL routes ark_func(...) through them.
 * Wrapper returns are long long, so the caller uses host libc types. */
static int is_wrapped_func(const char *name) {
    static const char *wrapped[] = {
        /* ARK_WRAP_D1: (double)->double */
        "sqrt", "sqrtf", "sqrtl", "fabs", "sin", "cos", "tan",
        "asin", "acos", "atan", "exp", "exp2", "expm1",
        "log", "log10", "log2", "log1p",
        "floor", "ceil", "trunc", "round",
        "nearbyint", "rint", "cbrt",
        "erf", "erfc", "tgamma", "lgamma",
        /* ARK_WRAP_D2: (double,double)->double */
        "pow", "fmod", "atan2", "copysign", "fmax", "fmin",
        "fdim", "hypot", "nextafter", "remainder",
        /* ARK_WRAP_D3: (double,double,double)->double */
        "fma",
        /* ARK_WRAP_D2LL: (double)->long long */
        "llround", "lrint", "llrint", "lround",
        /* ARK_WRAP_DI: (double,int)->double */
        "ldexp", "scalbn",
        /* Special wrappers */
        "scalbln", "nan", "nanf", "nanl",
        "strtod", "strtof", "strtold",
        "wcstod", "wcstof", "wcstold",
        "difftime",
        "creal", "cimag", "conj", "cabs", "carg", "cexp",
        "frexp", "modf", "remquo",
        "snprintf", "strstr", "malloc", "calloc", "free",
        "fegetenv", "fesetenv", "feclearexcept", "fetestexcept",
        "setlocale", "localeconv", "wcslen", "wcscmp",
        0
    };
    int i;
    if (!name) return 0;
    for (i = 0; wrapped[i]; i++) if (ark_streq(name, wrapped[i])) return 1;
    return 0;
}

/* Decide whether a name refers to a host libc variable; the C backend emits
 * extern declarations for these so the host linker can resolve them.
 * Variables like stdin/stdout/stderr/errno/FE_DFL_ENV are types defined in
 * the host's <stdio.h>/<errno.h>/<fenv.h>; arkcc declares them through the
 * standard headers and the IR sees them as already extern. */
static int is_libc_var(const char *name) {
    static const char *vars[] = {
        "stdin", "stdout", "stderr",
        "errno", "FE_DFL_ENV",
        0
    };
    int i;
    if (!name) return 0;
    for (i = 0; vars[i]; i++) if (ark_streq(name, vars[i])) return 1;
    return 0;
}

/* Emit an extern prototype so undefined references in this TU link correctly. */
static void emit_extern_proto(AsmBuffer *b, const char *name) {
    int i;
    asmbuf_puts(b, "extern long long ark_");
    asmbuf_puts(b, name);
    asmbuf_puts(b, "(");
    for (i = 0; i < MAX_CALL_ARGS; i++) {
        if (i) asmbuf_puts(b, ", ");
        asmbuf_puts(b, "long long a");
        asmbuf_int(b, i);
    }
    asmbuf_puts(b, ");\n");
}

/* Emit a C type with declarator syntax. Follows the standard layout:
 *   - scalar types print as "<base> <name>"
 *   - pointers recurse with base, name gets a '*' prefix
 *   - arrays recurse with base+name, then append "[size]" ("[]" when size==0)
 *   - struct/union emit either an inline definition or a tag reference.
 * Storage class is added by the caller (e.g., const/static/section). */
static void emit_c_type(AsmBuffer *b, Type *t, const char *name) {
    if (!t) { asmbuf_puts(b, "long long "); asmbuf_puts(b, name); return; }
    /* F2: Emit volatile/const qualifiers for non-pointer types.
     * For pointer types, qualifiers on the pointer itself are not emitted here
     * (would require placement after '*'); base-type qualifiers are correctly
     * emitted through recursion into t->base. This covers the common HAL patterns:
     *   volatile uint32_t x  ->  volatile unsigned int x
     *   volatile uint32_t *p ->  volatile unsigned int *p  (volatile on base) */
    if (t->kind != TYPE_PTR) {
        if (t->is_volatile) asmbuf_puts(b, "volatile ");
        if (t->is_const) asmbuf_puts(b, "const ");
    }
    switch (t->kind) {
        case TYPE_VOID:   asmbuf_puts(b, "void "); break;
        case TYPE_CHAR:   asmbuf_puts(b, "char "); break;
        case TYPE_SHORT:  asmbuf_puts(b, "short "); break;
        case TYPE_INT:    asmbuf_puts(b, "int "); break;
        case TYPE_LONG:   asmbuf_puts(b, "long "); break;
        case TYPE_LLONG:  asmbuf_puts(b, "long long "); break;
        case TYPE_BOOL:   asmbuf_puts(b, "_Bool "); break;
        case TYPE_FLOAT:  asmbuf_puts(b, "float "); break;
        case TYPE_DOUBLE: asmbuf_puts(b, "double "); break;
        case TYPE_ENUM:   asmbuf_puts(b, "int "); break;
        case TYPE_WCHAR:  asmbuf_puts(b, "wchar_t "); break;  /* B2: matches gcc wchar_t */
        case TYPE_COMPLEX: /* B4: _Complex float/double supported by gcc */
            asmbuf_puts(b, "_Complex ");
            if (t->base && t->base->kind == TYPE_FLOAT) asmbuf_puts(b, "float ");
            else asmbuf_puts(b, "double ");
            break;
        case TYPE_PTR: {
            /* If name starts with '*', prepend another '*' to the base. */
            char namebuf[256];
            int i = 0;
            namebuf[i++] = '*';
            if (name) { const char *p = name; while (*p && i < 250) namebuf[i++] = *p++; }
            namebuf[i] = 0;
            /* For pointer to struct/union, emit "struct Tag *name" without recursing
             * into the struct body. This prevents infinite recursion on self-referential
             * types (e.g. struct Type { StructField *fields; } where StructField has
             * a Type* field). Anonymous struct pointers use "void *" as fallback. */
            if (t->base && (t->base->kind == TYPE_STRUCT || t->base->kind == TYPE_UNION)) {
                if (t->base->tag) {
                    asmbuf_puts(b, t->base->kind == TYPE_UNION ? "union " : "struct ");
                    asmbuf_puts(b, t->base->tag);
                    asmbuf_puts(b, " ");
                    asmbuf_puts(b, namebuf);
                    return;
                } else {
                    asmbuf_puts(b, "void ");
                    asmbuf_puts(b, namebuf);
                    return;
                }
            }
            /* Function pointer: emit "<ret> (*name)(<params>)".
             * Without this, function pointer fields in structs (e.g. the
             * ArkBackend vtable) would be emitted as "long long *name",
             * losing the function-pointer type and breaking initializers
             * that reference function symbols. */
            if (t->base && t->base->kind == TYPE_FUNC) {
                Type *func = t->base;
                int j;
                emit_c_type(b, func->base, "");
                asmbuf_puts(b, "(*");
                if (name) asmbuf_puts(b, name);
                asmbuf_puts(b, ")(");
                for (j = 0; j < func->param_count; j++) {
                    if (j) asmbuf_puts(b, ", ");
                    emit_c_type(b, func->params[j], "");
                }
                if (func->is_variadic) {
                    if (func->param_count) asmbuf_puts(b, ", ");
                    asmbuf_puts(b, "...");
                }
                asmbuf_puts(b, ")");
                return;
            }
            emit_c_type(b, t->base, namebuf);
            return;
        }
        case TYPE_ARRAY: {
            /* Multi-dim arrays: collect dimension list, emit base+name then
             * suffix each "[size]" left to right (e.g. int m[2][3] -> m is
             * an array of 2 arrays of int[3]). */
            int dims[16];
            int n = 0;
            Type *cur = t;
            while (cur && cur->kind == TYPE_ARRAY && n < 16) {
                dims[n++] = cur->size;
                cur = cur->base;
            }
            emit_c_type(b, cur, name);
            {
                int k;
                for (k = 0; k < n; k++) {
                    asmbuf_puts(b, "[");
                    if (dims[k] > 0) asmbuf_int(b, dims[k]);
                    asmbuf_puts(b, "]");
                }
            }
            return;
        }
        case TYPE_STRUCT:
        case TYPE_UNION: {
            asmbuf_puts(b, t->kind == TYPE_UNION ? "union " : "struct ");
            if (t->fields) {
                StructField *f;
                asmbuf_puts(b, "{ ");
                for (f = t->fields; f; f = f->next) {
                    if (f->name && f->name[0]) {
                        emit_c_type(b, f->type, f->name);
                        asmbuf_puts(b, "; ");
                    }
                }
                asmbuf_puts(b, "} ");
            } else if (t->tag) {
                asmbuf_puts(b, t->tag);
                asmbuf_puts(b, " ");
            }
            break;
        }
        default:
            asmbuf_puts(b, "long long ");
            break;
    }
    asmbuf_puts(b, name);
}

/* Check whether a C type is an aggregate (array/struct/union). */
static int c_type_is_aggregate(Type *t) {
    if (!t) return 0;
    return t->kind == TYPE_ARRAY || t->kind == TYPE_STRUCT || t->kind == TYPE_UNION;
}

/* Compute the stack-effect delta of a single IR instruction.
 * Positive = pushes, negative = pops, zero = no net change. */
static int ir_stack_delta(IrInst *I) {
    switch (I->op) {
        case IR_PUSH_INT:
        case IR_PUSH_VAR:
        case IR_PUSH_ADDR:
        case IR_PUSH_STR:
        case IR_PUSH_GLOBAL:
        case IR_PUSH_GLOBAL_ADDR:
        case IR_PUSH_FLOAT:
        case IR_64PUSH:
        case IR_DUP:
            return 1;
        case IR_POP:
        case IR_STORE:
        case IR_STORE_GLOBAL:
        case IR_JZ:
        case IR_JNZ:
        case IR_RETURN:
        case IR_BINARY:
        case IR_FADD:
        case IR_FSUB:
        case IR_FMUL:
        case IR_FDIV:
        case IR_FCMP:
        case IR_DIV:
        case IR_MOD:
        case IR_64BINARY:
        case IR_64CMP:
        case IR_LOAD_IDX:
        case IR_STORE_IDX:
        case IR_STORE_FLD:
        case IR_SIMD_ADD16:
        case IR_SIMD_SUB16:
        case IR_SIMD_ADD8:
        case IR_SIMD_SUB8:
            return -1;
        case IR_UNARY:
        case IR_F2I:
        case IR_I2F:
        case IR_64F2I:
        case IR_64I2F:
        case IR_ALLOCA:
        case IR_SVC:
        case IR_LOAD_FLD:
        case IR_SWAP:
        case IR_JMP:
        case IR_JMP_NAMED:
        case IR_LABEL:
        case IR_LABEL_NAMED:
        case IR_CMP_JMP_EQ:
            return 0;
        case IR_CALL: {
            int n = (int)I->val;
            if (n > MAX_CALL_ARGS) n = MAX_CALL_ARGS;
            return -(n) + 1; /* pop n args, push 1 result */
        }
        case IR_MEMCPY:
            return -2; /* pop dst, src */
        default:
            return 0;
    }
}

/* Compute the maximum stack depth (sp value) for an IR function.
 * Uses fixpoint iteration to correctly handle jumps: a forward jump may
 * skip over POP instructions, so the sp at a label reached via a jump can
 * be HIGHER than the sp at that label reached via the fall-through path.
 * The linear-only approach underestimates stk[] in such cases, causing
 * stack overflow at runtime in the generated C code. */
#define MAX_LABELS_FOR_SP  4096
static int compute_max_sp(IrFunc *f) {
    /* Collect named labels and assign them indices after numeric labels. */
    int named_count = 0;
    char *named_names[256];
    int i;
    int total_labels;
    int label_sp_stack[MAX_LABELS_FOR_SP];
    int *label_sp = label_sp_stack;
    int max_sp = 1;
    int iter;

    for (i = 0; i < f->code_count && named_count < 256; i++) {
        if (f->code[i].op == IR_LABEL_NAMED) {
            char *name = f->code[i].name;
            int found = 0, j;
            for (j = 0; j < named_count; j++) {
                if (named_names[j] && name && ark_streq(named_names[j], name)) {
                    found = 1; break;
                }
            }
            if (!found) named_names[named_count++] = name;
        }
    }

    total_labels = f->label_count + named_count;
    if (total_labels < 1) total_labels = 1;
    /* If too many labels, fall back to linear scan (overestimate is safe). */
    if (total_labels > MAX_LABELS_FOR_SP) {
        int sp = 0;
        max_sp = 1;
        for (i = 0; i < f->code_count; i++) {
            int delta = ir_stack_delta(&f->code[i]);
            sp += delta;
            if (sp > max_sp) max_sp = sp;
            if (sp < 0) sp = 0;
        }
        return max_sp;
    }
    for (i = 0; i < total_labels; i++) label_sp[i] = -1;

    /* Fixpoint iteration: repeat until sp at labels stabilizes. */
    for (iter = 0; iter < 32; iter++) {
        int sp = 0;
        int changed = 0;
        max_sp = 1;

        for (i = 0; i < f->code_count; i++) {
            IrInst *I = &f->code[i];
            int delta = ir_stack_delta(I);
            int jmp_tgt = -1;
            int jmp_sp = 0;

            switch (I->op) {
                case IR_LABEL:
                    if (label_sp[(int)I->val] > sp) sp = label_sp[(int)I->val];
                    break;
                case IR_LABEL_NAMED: {
                    int j;
                    for (j = 0; j < named_count; j++) {
                        if (named_names[j] && I->name &&
                            ark_streq(named_names[j], I->name)) {
                            int idx = f->label_count + j;
                            if (label_sp[idx] > sp) sp = label_sp[idx];
                            break;
                        }
                    }
                    break;
                }
                case IR_JMP:
                    jmp_tgt = (int)I->val;
                    jmp_sp = sp; /* JMP does not pop */
                    break;
                case IR_JMP_NAMED: {
                    int j;
                    for (j = 0; j < named_count; j++) {
                        if (named_names[j] && I->name &&
                            ark_streq(named_names[j], I->name)) {
                            jmp_tgt = f->label_count + j;
                            jmp_sp = sp;
                            break;
                        }
                    }
                    break;
                }
                case IR_JZ:
                case IR_JNZ:
                    /* JZ/JNZ pop the condition, then jump with sp-1. */
                    jmp_tgt = (int)I->val;
                    jmp_sp = sp - 1;
                    break;
                case IR_CMP_JMP_EQ:
                    /* On match, peeks then pops 1 and jumps. Conservatively
                     * assume the jump path has sp-1. */
                    jmp_tgt = I->aux;
                    jmp_sp = sp - 1;
                    break;
                default:
                    break;
            }

            if (jmp_tgt >= 0 && jmp_tgt < total_labels && jmp_sp > label_sp[jmp_tgt]) {
                label_sp[jmp_tgt] = jmp_sp;
                changed = 1;
            }

            sp += delta;
            if (sp > max_sp) max_sp = sp;
            if (sp < 0) sp = 0;
        }

        if (!changed) break;
    }
    return max_sp;
}

/* Compute the frame size needed for a function. The frame must accommodate:
 *   - local_size: all local variables and parameters (from IR)
 *   - 8000-8128: variadic argument area (only for variadic functions)
 *   - 8176+: struct return area (only for struct-returning functions)
 * We use max(local_size + 64, 8704) to ensure backward compatibility with
 * the fixed areas while allowing larger frames when needed. */
static int compute_frame_size(IrFunc *f) {
    int needed = f->local_size + 64; /* 64 bytes padding for alignment */
    if (needed < 8704) needed = 8704; /* preserve fixed areas for variadic/struct return */
    /* round up to 8-byte alignment */
    needed = (needed + 7) & ~7;
    return needed;
}

static int c_emit(IrProgram *prog, char *out, int cap) {
    AsmBuffer buf;
    int fi;
    int main_idx = -1;
    asmbuf_init(&buf);

    asmbuf_puts(&buf, "/* Ark C Compiler - generated by C backend */\n");
    /* The stack-machine model casts `char frame[]` to long long, int, double
     * pointers etc. Under -O2 -fstrict-aliasing, gcc may assume these casts
     * do not alias and miscompile struct-by-value passes (e.g. returning 0
     * instead of the packed value). Disable strict aliasing for the file. */
    asmbuf_puts(&buf, "#if defined(__GNUC__)\n");
    asmbuf_puts(&buf, "#pragma GCC optimize(\"-fno-strict-aliasing\")\n");
    asmbuf_puts(&buf, "#endif\n");
    asmbuf_puts(&buf, "#include <stdio.h>\n");
    asmbuf_puts(&buf, "#include <stdlib.h>\n");
    asmbuf_puts(&buf, "#include <string.h>\n");
    asmbuf_puts(&buf, "#include <stdint.h>\n");
    asmbuf_puts(&buf, "#include <setjmp.h>\n");
    asmbuf_puts(&buf, "#include <malloc.h>\n");   /* B3: alloca for VLA */
    asmbuf_puts(&buf, "#include <wchar.h>\n");    /* B2: wchar_t type */
    asmbuf_puts(&buf, "#include <wctype.h>\n");   /* iswalpha/towupper etc. */
    asmbuf_puts(&buf, "#include <errno.h>\n");     /* errno: mingw defines it via thread-local accessor */
    asmbuf_puts(&buf, "#include <fenv.h>\n");      /* FE_DFL_ENV: host extern symbol */
    asmbuf_puts(&buf, "#include <math.h>\n");      /* sqrt/fabs/sin/cos/pow */
    asmbuf_puts(&buf, "#include <complex.h>\n");   /* creal/cimag/cabs/carg/cexp */
    asmbuf_puts(&buf, "#include <time.h>\n");      /* time/localtime/strftime */
    asmbuf_puts(&buf, "#include <locale.h>\n");    /* setlocale/localeconv */
    asmbuf_puts(&buf, "#include <signal.h>\n");  /* signal */
    asmbuf_puts(&buf, "#include <inttypes.h>\n");  /* imaxdiv_t/imaxabs/strtoumax */
    /* mingw's swprintf/vswprintf lack the C99 size_t n parameter; use _snwprintf/_vsnwprintf instead. */
    asmbuf_puts(&buf, "#define swprintf _snwprintf\n");
    asmbuf_puts(&buf, "#define vswprintf _vsnwprintf\n");
    asmbuf_puts(&buf, "typedef long long ark_long;\n\n");
    asmbuf_puts(&buf, "/* ark_slot is 8 bytes for long long and overlaps with double; the C backend uses an LLP64 long=4 byte model. */\n");
    asmbuf_puts(&buf, "typedef union { long long i; double f; _Complex double c; } ark_slot;\n");
    asmbuf_puts(&buf, "static inline long long _AS_I(ark_slot s){return s.i;}\n");
    /* ark_<libc> wrapper macros: arkcc IR functions are declared as
     * (long long a0..a7) -> long long. These static inline helpers:
     *   1. Take long long slots and cast back to double/pointer/int as needed
     *   2. Call the corresponding host libc function
     *   3. Cast the result back to long long (double uses the union slot)
     * The actual instantiations are below; the IR_CALL path picks the right route. */
    asmbuf_puts(&buf,
        "static inline long long _ark_d2ll(double d){ark_slot s;s.f=d;return s.i;}\n"
        "static inline double _ark_ll2d(long long i){ark_slot s;s.i=i;return s.f;}\n"
        /* single-arg double->double */
        "#define ARK_WRAP_D1(name) static inline long long ark_##name(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){(void)a1;(void)a2;(void)a3;(void)a4;(void)a5;(void)a6;(void)a7;return _ark_d2ll(name(_ark_ll2d(a0)));}\n"
        /* two-arg (double,double)->double */
        "#define ARK_WRAP_D2(name) static inline long long ark_##name(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){(void)a2;(void)a3;(void)a4;(void)a5;(void)a6;(void)a7;return _ark_d2ll(name(_ark_ll2d(a0),_ark_ll2d(a1)));}\n"
        /* three-arg (double,double,double)->double */
        "#define ARK_WRAP_D3(name) static inline long long ark_##name(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){(void)a3;(void)a4;(void)a5;(void)a6;(void)a7;return _ark_d2ll(name(_ark_ll2d(a0),_ark_ll2d(a1),_ark_ll2d(a2)));}\n"
        /* double->long long (return integer) */
        "#define ARK_WRAP_D2LL(name) static inline long long ark_##name(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){(void)a1;(void)a2;(void)a3;(void)a4;(void)a5;(void)a6;(void)a7;return (long long)name(_ark_ll2d(a0));}\n"
        /* (double,int)->double */
        "#define ARK_WRAP_DI(name) static inline long long ark_##name(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){(void)a2;(void)a3;(void)a4;(void)a5;(void)a6;(void)a7;return _ark_d2ll(name(_ark_ll2d(a0),(int)a1));}\n"
    );
    /* Single-arg double->double wrapper instantiations */
    asmbuf_puts(&buf,
        "ARK_WRAP_D1(sqrt) ARK_WRAP_D1(sqrtf) ARK_WRAP_D1(sqrtl)\n"
        "ARK_WRAP_D1(fabs) ARK_WRAP_D1(sin) ARK_WRAP_D1(cos) ARK_WRAP_D1(tan)\n"
        "ARK_WRAP_D1(asin) ARK_WRAP_D1(acos) ARK_WRAP_D1(atan)\n"
        "ARK_WRAP_D1(exp) ARK_WRAP_D1(exp2) ARK_WRAP_D1(expm1)\n"
        "ARK_WRAP_D1(log) ARK_WRAP_D1(log10) ARK_WRAP_D1(log2) ARK_WRAP_D1(log1p)\n"
        "ARK_WRAP_D1(floor) ARK_WRAP_D1(ceil) ARK_WRAP_D1(trunc) ARK_WRAP_D1(round)\n"
        "ARK_WRAP_D1(nearbyint) ARK_WRAP_D1(rint) ARK_WRAP_D1(cbrt)\n"
        "ARK_WRAP_D1(erf) ARK_WRAP_D1(erfc) ARK_WRAP_D1(tgamma) ARK_WRAP_D1(lgamma)\n"
        /* two-arg wrappers */
        "ARK_WRAP_D2(pow) ARK_WRAP_D2(fmod) ARK_WRAP_D2(atan2)\n"
        "ARK_WRAP_D2(copysign) ARK_WRAP_D2(fmax) ARK_WRAP_D2(fmin)\n"
        "ARK_WRAP_D2(fdim) ARK_WRAP_D2(hypot) ARK_WRAP_D2(nextafter)\n"
        "ARK_WRAP_D2(remainder)\n"
        /* three-arg */
        "ARK_WRAP_D3(fma)\n"
        /* double->long long */
        "ARK_WRAP_D2LL(llround) ARK_WRAP_D2LL(lrint) ARK_WRAP_D2LL(llrint) ARK_WRAP_D2LL(lround)\n"
        /* (double,int)->double */
        "ARK_WRAP_DI(ldexp) ARK_WRAP_DI(scalbn)\n"
        /* (double,long)->double */
        "static inline long long ark_scalbln(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){(void)a2;(void)a3;(void)a4;(void)a5;(void)a6;(void)a7;return _ark_d2ll(scalbln(_ark_ll2d(a0),(long)a1));}\n"
        /* nan/nanf/nanl (const char*)->double */
        "static inline long long ark_nan(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){(void)a1;(void)a2;(void)a3;(void)a4;(void)a5;(void)a6;(void)a7;return _ark_d2ll(nan((const char*)(intptr_t)a0));}\n"
        "static inline long long ark_nanf(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){(void)a1;(void)a2;(void)a3;(void)a4;(void)a5;(void)a6;(void)a7;return _ark_d2ll((double)nanf((const char*)(intptr_t)a0));}\n"
        "static inline long long ark_nanl(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){(void)a1;(void)a2;(void)a3;(void)a4;(void)a5;(void)a6;(void)a7;return _ark_d2ll((double)nanl((const char*)(intptr_t)a0));}\n"
        /* strtod/strtof/strtold (const char*, char**)->float/double */
        "static inline long long ark_strtod(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){(void)a2;(void)a3;(void)a4;(void)a5;(void)a6;(void)a7;return _ark_d2ll(strtod((const char*)(intptr_t)a0,(char**)(intptr_t)a1));}\n"
        "static inline long long ark_strtof(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){(void)a2;(void)a3;(void)a4;(void)a5;(void)a6;(void)a7;return _ark_d2ll((double)strtof((const char*)(intptr_t)a0,(char**)(intptr_t)a1));}\n"
        "static inline long long ark_strtold(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){(void)a2;(void)a3;(void)a4;(void)a5;(void)a6;(void)a7;return _ark_d2ll((double)strtold((const char*)(intptr_t)a0,(char**)(intptr_t)a1));}\n"
        /* wcstod/wcstof/wcstold (const wchar_t*, wchar_t**)->float/double */
        "static inline long long ark_wcstod(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){(void)a2;(void)a3;(void)a4;(void)a5;(void)a6;(void)a7;return _ark_d2ll(wcstod((const wchar_t*)(intptr_t)a0,(wchar_t**)(intptr_t)a1));}\n"
        "static inline long long ark_wcstof(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){(void)a2;(void)a3;(void)a4;(void)a5;(void)a6;(void)a7;return _ark_d2ll((double)wcstof((const wchar_t*)(intptr_t)a0,(wchar_t**)(intptr_t)a1));}\n"
        "static inline long long ark_wcstold(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){(void)a2;(void)a3;(void)a4;(void)a5;(void)a6;(void)a7;return _ark_d2ll((double)wcstold((const wchar_t*)(intptr_t)a0,(wchar_t**)(intptr_t)a1));}\n"
        /* difftime (time_t,time_t)->double */
        "static inline long long ark_difftime(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){(void)a2;(void)a3;(void)a4;(void)a5;(void)a6;(void)a7;return _ark_d2ll(difftime((time_t)a0,(time_t)a1));}\n"
        /* Complex funcs: the IR stores _Complex double as a long long pair, but the host
         * _Complex double is 16 bytes and cannot fit into a single long long, so creal/cimag
         * take long long a0..a1 and pass them through. These wrappers are stubs returning
         * the first slot (real part); the proper complex path uses is_complex_ret_func. */
        "static inline long long ark_creal(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){(void)a1;(void)a2;(void)a3;(void)a4;(void)a5;(void)a6;(void)a7;return a0;}\n"
        "static inline long long ark_cimag(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){(void)a0;(void)a2;(void)a3;(void)a4;(void)a5;(void)a6;(void)a7;return a1;}\n"
        "static inline long long ark_conj(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){(void)a2;(void)a3;(void)a4;(void)a5;(void)a6;(void)a7;return a0;}\n"
        "static inline long long ark_cabs(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){(void)a2;(void)a3;(void)a4;(void)a5;(void)a6;(void)a7;return _ark_d2ll(hypot(_ark_ll2d(a0),_ark_ll2d(a1)));}\n"
        "static inline long long ark_carg(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){(void)a2;(void)a3;(void)a4;(void)a5;(void)a6;(void)a7;return _ark_d2ll(atan2(_ark_ll2d(a1),_ark_ll2d(a0)));}\n"
        "static inline long long ark_cexp(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){(void)a1;(void)a2;(void)a3;(void)a4;(void)a5;(void)a6;(void)a7;return a0;}\n"
        /* frexp/modf (double,int*) */
        "static inline long long ark_frexp(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){(void)a2;(void)a3;(void)a4;(void)a5;(void)a6;(void)a7;return _ark_d2ll(frexp(_ark_ll2d(a0),(int*)(intptr_t)a1));}\n"
        "static inline long long ark_modf(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){(void)a2;(void)a3;(void)a4;(void)a5;(void)a6;(void)a7;return _ark_d2ll(modf(_ark_ll2d(a0),(double*)(intptr_t)a1));}\n"
        /* remquo (double,double,int*) */
        "static inline long long ark_remquo(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){(void)a3;(void)a4;(void)a5;(void)a6;(void)a7;return _ark_d2ll(remquo(_ark_ll2d(a0),_ark_ll2d(a1),(int*)(intptr_t)a2));}\n"
        /* snprintf(char*,size_t,const char*,...) - hardcoded to 5 variadic args */
        "static inline long long ark_snprintf(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){return (long long)snprintf((char*)(intptr_t)a0,(size_t)a1,(const char*)(intptr_t)a2,(long long)a3,(long long)a4,(long long)a5,(long long)a6,(long long)a7);}\n"
        /* strstr/strchr */
        "static inline long long ark_strstr(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){(void)a2;(void)a3;(void)a4;(void)a5;(void)a6;(void)a7;return (long long)(intptr_t)strstr((const char*)(intptr_t)a0,(const char*)(intptr_t)a1);}\n"
        /* malloc/free/calloc */
        "static inline long long ark_malloc(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){(void)a1;(void)a2;(void)a3;(void)a4;(void)a5;(void)a6;(void)a7;return (long long)(intptr_t)malloc((size_t)a0);}\n"
        "static inline long long ark_calloc(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){(void)a2;(void)a3;(void)a4;(void)a5;(void)a6;(void)a7;return (long long)(intptr_t)calloc((size_t)a0,(size_t)a1);}\n"
        "static inline long long ark_free(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){(void)a1;(void)a2;(void)a3;(void)a4;(void)a5;(void)a6;(void)a7;free((void*)(intptr_t)a0);return 0;}\n"
        /* fenv */
        "static inline long long ark_fegetenv(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){(void)a1;(void)a2;(void)a3;(void)a4;(void)a5;(void)a6;(void)a7;return (long long)fegetenv((fenv_t*)(intptr_t)a0);}\n"
        "static inline long long ark_fesetenv(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){(void)a1;(void)a2;(void)a3;(void)a4;(void)a5;(void)a6;(void)a7;return (long long)fesetenv((const fenv_t*)(intptr_t)a0);}\n"
        "static inline long long ark_feclearexcept(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){(void)a1;(void)a2;(void)a3;(void)a4;(void)a5;(void)a6;(void)a7;return (long long)feclearexcept((int)a0);}\n"
        "static inline long long ark_fetestexcept(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){(void)a1;(void)a2;(void)a3;(void)a4;(void)a5;(void)a6;(void)a7;return (long long)fetestexcept((int)a0);}\n"
        /* locale */
        "static inline long long ark_setlocale(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){(void)a2;(void)a3;(void)a4;(void)a5;(void)a6;(void)a7;return (long long)(intptr_t)setlocale((int)a0,(const char*)(intptr_t)a1);}\n"
        "static inline long long ark_localeconv(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){(void)a0;(void)a1;(void)a2;(void)a3;(void)a4;(void)a5;(void)a6;(void)a7;return (long long)(intptr_t)localeconv();}\n"
        /* wchar */
        "static inline long long ark_wcslen(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){(void)a1;(void)a2;(void)a3;(void)a4;(void)a5;(void)a6;(void)a7;return (long long)wcslen((const wchar_t*)(intptr_t)a0);}\n"
        "static inline long long ark_wcscmp(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){(void)a2;(void)a3;(void)a4;(void)a5;(void)a6;(void)a7;return (long long)wcscmp((const wchar_t*)(intptr_t)a0,(const wchar_t*)(intptr_t)a1);}\n"
        "static inline long long ark_iswalpha(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){(void)a1;(void)a2;(void)a3;(void)a4;(void)a5;(void)a6;(void)a7;return (long long)iswalpha((wint_t)a0);}\n"
        "static inline long long ark_iswdigit(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){(void)a1;(void)a2;(void)a3;(void)a4;(void)a5;(void)a6;(void)a7;return (long long)iswdigit((wint_t)a0);}\n"
        "static inline long long ark_iswspace(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){(void)a1;(void)a2;(void)a3;(void)a4;(void)a5;(void)a6;(void)a7;return (long long)iswspace((wint_t)a0);}\n"
        "static inline long long ark_towupper(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){(void)a1;(void)a2;(void)a3;(void)a4;(void)a5;(void)a6;(void)a7;return (long long)towupper((wint_t)a0);}\n"
        "static inline long long ark_towlower(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){(void)a1;(void)a2;(void)a3;(void)a4;(void)a5;(void)a6;(void)a7;return (long long)towlower((wint_t)a0);}\n"
        "static inline long long ark_swprintf(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){(void)a1;return (long long)swprintf((wchar_t*)(intptr_t)a0,(const wchar_t*)(intptr_t)a2,(long long)a3,(long long)a4,(long long)a5,(long long)a6,(long long)a7);}\n"
        /* signal */
        "static inline long long ark_signal(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){(void)a2;(void)a3;(void)a4;(void)a5;(void)a6;(void)a7;return (long long)(intptr_t)signal((int)a0,((void(*)(int))(intptr_t)a1));}\n"
        /* time/localtime/strftime */
        "static inline long long ark_time(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){(void)a1;(void)a2;(void)a3;(void)a4;(void)a5;(void)a6;(void)a7;return (long long)time((time_t*)(intptr_t)a0);}\n"
        "static inline long long ark_localtime(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){(void)a1;(void)a2;(void)a3;(void)a4;(void)a5;(void)a6;(void)a7;return (long long)(intptr_t)localtime((const time_t*)(intptr_t)a0);}\n"
        "static inline long long ark_strftime(long long a0,long long a1,long long a2,long long a3,long long a4,long long a5,long long a6,long long a7){(void)a4;(void)a5;(void)a6;(void)a7;return (long long)strftime((char*)(intptr_t)a0,(size_t)a1,(const char*)(intptr_t)a2,(const struct tm*)(intptr_t)a3);}\n"
    );
    asmbuf_putc(&buf, '\n');
    asmbuf_puts(&buf, "static inline double _AS_F(ark_slot s){return s.f;}\n");
    asmbuf_puts(&buf, "static inline ark_slot _SI(long long v){ark_slot s; s.i=v; return s;}\n");
    asmbuf_puts(&buf, "static inline ark_slot _SF(double v){ark_slot s; s.f=v; return s;}\n\n");

    /* Float constants: emit %.17g for round-trip precision while keeping the
     * minimal significant digits. Values near 0 (e.g. 1e-10) or huge (e.g.
     * 1e100) require full precision; printing only 9 fractional digits would
     * produce "0.000000000" for 1e-10. */
    {
        int i;
        for (i = 0; i < prog->float_count; i++) {
            char fbuf[64];
            double v = prog->floats[i];
            asmbuf_puts(&buf, "static const double ark_flt_");
            asmbuf_int(&buf, i);
            asmbuf_puts(&buf, " = ");
            /* Detect NaN/Inf: %.17g would emit mingw's "nan"/"inf" strings,
             * which are not valid C tokens. Use 0.0f/0.0f and HUGE_VAL literals. */
            if (v != v) {
                asmbuf_puts(&buf, "((double)0.0f/0.0f)");  /* NAN */
            } else if (v > 1e308) {
                asmbuf_puts(&buf, "((double)3.40282347e+38f)");  /* +INFINITY (float HUGE_VALF) */
            } else if (v < -1e308) {
                asmbuf_puts(&buf, "(-(double)3.40282347e+38f)");  /* -INFINITY */
            } else {
                snprintf(fbuf, sizeof(fbuf), "%.17g", v);
                asmbuf_puts(&buf, fbuf);
            }
            asmbuf_puts(&buf, ";\n");
        }
        if (prog->float_count) asmbuf_putc(&buf, '\n');
    }

    /* Complex constants: use %.17g for round-trip precision on real and imag
     * parts. GCC accepts the i suffix; emit as "re + im * 1.0i" form. */
    {
        int i;
        for (i = 0; i < prog->complex_count; i++) {
            char rbuf[64], ibuf[64];
            double re = prog->complexes[i].re;
            double im = prog->complexes[i].im;
            asmbuf_puts(&buf, "static const _Complex double ark_cflt_");
            asmbuf_int(&buf, i);
            asmbuf_puts(&buf, " = ");
            /* Detect NaN/Inf */
            if (re != re) snprintf(rbuf, sizeof(rbuf), "((double)0.0f/0.0f)");
            else if (re > 1e308) snprintf(rbuf, sizeof(rbuf), "((double)3.40282347e+38f)");
            else if (re < -1e308) snprintf(rbuf, sizeof(rbuf), "(-(double)3.40282347e+38f)");
            else snprintf(rbuf, sizeof(rbuf), "%.17g", re);
            if (im != im) snprintf(ibuf, sizeof(ibuf), "((double)0.0f/0.0f)");
            else if (im > 1e308) snprintf(ibuf, sizeof(ibuf), "((double)3.40282347e+38f)");
            else if (im < -1e308) snprintf(ibuf, sizeof(ibuf), "(-(double)3.40282347e+38f)");
            else snprintf(ibuf, sizeof(ibuf), "%.17g", im);
            asmbuf_puts(&buf, rbuf);
            asmbuf_puts(&buf, " + ");
            asmbuf_puts(&buf, ibuf);
            asmbuf_puts(&buf, " * 1.0i;\n");
        }
        if (prog->complex_count) asmbuf_putc(&buf, '\n');
    }

    /* String constants */
    {
        int i;
        for (i = 0; i < prog->string_count; i++) {
            IrString *s = prog->strings[i];
#if ARKCC_FEATURE_WCHAR
            if (s->is_wide) {
                /* B2: wide strings: emit a wchar_t array using L"..." literal.
                 * gcc will compile to the platform's native wchar_t encoding. */
                asmbuf_puts(&buf, "static const wchar_t ark_wstr_");
                asmbuf_int(&buf, s->id);
                asmbuf_puts(&buf, "[] = L");
                emit_str_literal(&buf, s->data, s->len);
                asmbuf_puts(&buf, ";\n");
            } else
#endif
            {
                asmbuf_puts(&buf, "static const char ark_str_");
                asmbuf_int(&buf, s->id);
                asmbuf_puts(&buf, "[] = ");
                emit_str_literal(&buf, s->data, s->len);
                asmbuf_puts(&buf, ";\n");
            }
        }
        if (prog->string_count) asmbuf_putc(&buf, '\n');
    }

    /* Function prototypes (must precede global variables so that
     * initializers referencing function symbols, e.g.
     *   static const Backend g_arm_backend = { ..., arm_emit, ... };
     * compile cleanly: the function is already declared). */
    {
        int i;
        for (i = 0; i < prog->func_count; i++) emit_func_proto(&buf, prog->funcs[i]);
        asmbuf_putc(&buf, '\n');
    }

    /* Global variables */
    {
        int i;
        for (i = 0; i < prog->global_count; i++) {
            IrGlobal *g = prog->globals[i];
            int is_aggregate = (g->init_aggregate != 0) ||
                               c_type_is_aggregate(g->type);
            /* Skip host libc variables (stdin/stdout/stderr/errno/FE_DFL_ENV):
             * the C backend would emit extern, but the host already defines them. */
            if (g->is_extern && is_libc_var(g->name)) continue;
            /* Storage class */
            if (g->is_extern) asmbuf_puts(&buf, "extern ");
            else if (g->is_static) asmbuf_puts(&buf, "static ");
#if ARKCC_FEATURE_ARMCC_KEYWORDS
            /* __thread: thread-local storage, supported by gcc/libpthread on host. */
            if (g->is_tls && !g->is_extern) asmbuf_puts(&buf, "__thread ");
#endif
            /* const qualifier forces gcc to place the variable in .rodata.
             * F2: if the type already has is_const (from type_qualified in parser),
             * emit_c_type will emit it; avoid double-const here. */
            if (g->is_const && !g->is_extern && !(g->type && g->type->is_const)) asmbuf_puts(&buf, "const ");
            /* Type and declarator; pointer/array syntax recurses with '*' */
            emit_c_type(&buf, g->type, g->name);
            /* Alignment via __attribute__((aligned(n))) */
            if (g->align_bytes > 0 && !g->is_extern) {
                asmbuf_puts(&buf, " __attribute__((aligned(");
                asmbuf_int(&buf, g->align_bytes);
                asmbuf_puts(&buf, ")))");
            }
            /* used/unused attributes for gcc. */
            if (g->is_used && !g->is_extern)   asmbuf_puts(&buf, " __attribute__((used))");
            if (g->is_unused && !g->is_extern) asmbuf_puts(&buf, " __attribute__((unused))");
            /* __at(addr): unsupported on host; emit as a comment. */
            if (g->has_at) {
                asmbuf_puts(&buf, " /* __at(0x");
                {
                    unsigned a = g->at_addr;
                    char hex[9]; int k;
                    const char *hd = "0123456789abcdef";
                    for (k = 7; k >= 0; k--) { hex[k] = hd[a & 0xF]; a >>= 4; }
                    hex[8] = 0;
                    asmbuf_puts(&buf, hex);
                }
                asmbuf_puts(&buf, ") */");
            }
#if ARKCC_FEATURE_ARMCC_KEYWORDS
            /* __global_reg(n): unsupported on host; emit as a comment. */
            if (g->global_reg >= 0) {
                asmbuf_puts(&buf, " /* __global_reg(");
                asmbuf_int(&buf, g->global_reg);
                asmbuf_puts(&buf, ") */");
            }
#endif
            /* Section attribute: __attribute__((section("..."))) */
            if (g->section && !g->is_extern) {
                asmbuf_puts(&buf, " __attribute__((section(\"");
                asmbuf_puts(&buf, g->section);
                asmbuf_puts(&buf, "\")))");
            }
            if (!g->is_extern) {
                if (g->has_init) {
                    asmbuf_puts(&buf, " = ");
                    if (is_aggregate && g->init_aggregate) {
                        asmbuf_puts(&buf, g->init_aggregate);
                    } else if (g->is_float) {
                        char fb[64]; int fn=0; double v = g->init_float; int neg=0;
                        if (v < 0) { neg = 1; v = -v; }
                        if (neg) asmbuf_putc(&buf, '-');
                        {
                            long long ip = (long long)v; char tmp[24]; int tn=0; int kk;
                            if (ip == 0) tmp[tn++]='0';
                            while (ip>0) { tmp[tn++]=(char)('0'+ip%10); ip/=10; }
                            for (kk = tn - 1; kk >= 0; kk--) fb[fn++] = tmp[kk];
                        }
                        fb[fn++] = '.';
                        {
                            /* Print 15 fractional digits to cover IEEE 754 double precision. */
                            double f = v - (double)((long long)v);
                            int kk; for (kk = 0; kk < 15; kk++) { f*=10; { int d=(int)f; if (d>9)d=9; fb[fn++]=(char)('0'+d); f-=d;} }
                        }
                        fb[fn]=0;
                        asmbuf_puts(&buf, fb);
                    } else if (g->init_str) {
                        /* char a[] = "..." */
                        emit_str_literal(&buf, g->init_str, ark_strlen(g->init_str));
                    } else {
                        asmbuf_int(&buf, g->init_int);
                    }
                }
            }
            asmbuf_puts(&buf, ";\n");
        }
        if (prog->global_count) asmbuf_putc(&buf, '\n');
    }


    /* Forward declarations for functions referenced by IR_CALL but not defined
     * in this TU (neither user-defined nor host libc). Emit them as extern
     * prototypes so the .gen.c file compiles cleanly with gcc. */
    {
        int ffi, ii, jj, emitted = 0;
        const char *seen[128];  /* Dedup list of emitted extern prototypes */
        for (ffi = 0; ffi < prog->func_count; ffi++) {
            IrFunc *f = prog->funcs[ffi];
            for (ii = 0; ii < f->code_count; ii++) {
                IrInst *I = &f->code[ii];
                if (I->op != IR_CALL || !I->name) continue;
                if (I->name[0] == '?') continue;  /* indirect call placeholder */
                if (is_libc_func(I->name)) continue;
                if (is_wrapped_func(I->name)) continue;
                /* Defined in this TU? skip; emit_func_proto already emitted it. */
                {
                    int defined = 0;
                    for (jj = 0; jj < prog->func_count; jj++) {
                        if (ark_streq(prog->funcs[jj]->name, I->name)) { defined = 1; break; }
                    }
                    if (defined) continue;
                }
                /* Dedup */
                {
                    int dup = 0, kk;
                    for (kk = 0; kk < emitted; kk++) if (ark_streq(seen[kk], I->name)) { dup = 1; break; }
                    if (dup) continue;
                }
                if (emitted < 128) seen[emitted++] = I->name;
                emit_extern_proto(&buf, I->name);
            }
        }
        if (emitted) asmbuf_putc(&buf, '\n');
    }

    /* Function bodies */
    for (fi = 0; fi < prog->func_count; fi++) {
        IrFunc *f = prog->funcs[fi];
        int i;
        if (ark_streq(f->name, "main")) main_idx = fi;

        /* alias target: __attribute__((alias(...))) handles body generation. */
        if (f->alias_target) continue;

        if (f->is_weak)   asmbuf_puts(&buf, "__attribute__((weak)) ");
        if (f->is_naked || f->is_asm_func) asmbuf_puts(&buf, "__attribute__((naked)) ");
        if (f->is_used)   asmbuf_puts(&buf, "__attribute__((used)) ");
        if (f->is_unused) asmbuf_puts(&buf, "__attribute__((unused)) ");
        if (f->is_irq)    asmbuf_puts(&buf, "/* __irq */ ");
        if (f->is_constructor) asmbuf_puts(&buf, "__attribute__((constructor)) ");
        if (f->is_destructor)  asmbuf_puts(&buf, "__attribute__((destructor)) ");
        if (f->is_deprecated)  asmbuf_puts(&buf, "__attribute__((deprecated)) ");
#if ARKCC_FEATURE_ARMCC_KEYWORDS
        if (f->is_pure)       asmbuf_puts(&buf, "__attribute__((pure)) ");
        if (f->is_const_attr) asmbuf_puts(&buf, "__attribute__((const)) ");
        if (f->is_value_in_regs) asmbuf_puts(&buf, "/* __value_in_regs */ ");
        if (f->is_interwork)     asmbuf_puts(&buf, "/* __interwork */ ");
        if (f->smc_num > 0) {
            asmbuf_puts(&buf, "/* __smc(");
            asmbuf_int(&buf, f->smc_num);
            asmbuf_puts(&buf, ") */ ");
        }
#endif
        /* --split_sections/-ffunction-sections: per-function section attribute for gcc. */
        if (g_config.split_sections) {
            asmbuf_puts(&buf, "__attribute__((section(\".text.");
            asmbuf_puts(&buf, f->name);
            asmbuf_puts(&buf, "\"))) ");
        }
        asmbuf_puts(&buf, f->is_static ? "static long long ark_" : "long long ark_");
        asmbuf_puts(&buf, f->name);
        asmbuf_puts(&buf, "(");
        for (i = 0; i < MAX_CALL_ARGS; i++) {
            if (i) asmbuf_puts(&buf, ", ");
            asmbuf_puts(&buf, "long long a");
            asmbuf_int(&buf, i);
        }
        asmbuf_puts(&buf, ") {\n");
        if (f->is_asm_func) {
            /* __asm function body: emit the asm text as a single __asm__ block.
             * naked attribute tells gcc to omit prologue/epilogue, so we never
             * emit a return statement (naked functions require no return). */
            asmbuf_puts(&buf, "    __asm__ __volatile__(\n");
            {
                const char *s = f->asm_body ? f->asm_body : "";
                int sl = ark_strlen(s);
                /* Convert each asm line into a C string literal. */
                int k;
                int line_start = 1;
                for (k = 0; k <= sl; k++) {
                    char c = (k < sl) ? s[k] : 0;
                    if (line_start) {
                        if (c == ' ' || c == '\t' || c == '\r') continue;
                        if (c == '\n' || c == 0) continue;
                        asmbuf_puts(&buf, "        \"");
                        line_start = 0;
                    }
                    if (c == '\n' || c == 0) {
                        asmbuf_puts(&buf, "\\n\"\n");
                        line_start = 1;
                        if (c == 0) break;
                        continue;
                    }
                    if (c == '"') asmbuf_puts(&buf, "\\\"");
                    else if (c == '\\') asmbuf_puts(&buf, "\\\\");
                    else asmbuf_putc(&buf, c);
                }
            }
            asmbuf_puts(&buf, "    );\n}\n\n");
            continue;
        }
        asmbuf_puts(&buf, "    /* silence unused-parameter warnings */\n");
        asmbuf_puts(&buf, "    (void)a0; (void)a1; (void)a2; (void)a3;\n");
        asmbuf_puts(&buf, "    (void)a4; (void)a5; (void)a6; (void)a7;\n");
        {
            int frame_sz = compute_frame_size(f);
            int stk_sz = compute_max_sp(f);
            /* Add safety margin to stk to account for any simulation imprecision */
            stk_sz += 16;
            if (stk_sz < 256) stk_sz = 256;
            asmbuf_puts(&buf, "    char frame[");
            asmbuf_int(&buf, frame_sz);
            asmbuf_puts(&buf, "] = {0};\n");
            asmbuf_puts(&buf, "    ark_slot stk[");
            asmbuf_int(&buf, stk_sz);
            asmbuf_puts(&buf, "]; int sp = 0; long long ark_a, ark_c; long long ark_addr; long long ark_es;\n");
        }
        asmbuf_puts(&buf, "    double ark_fa, ark_fc; (void)ark_fa; (void)ark_fc;\n");
        asmbuf_puts(&buf, "    _Complex double ark_ca, ark_cc; (void)ark_ca; (void)ark_cc;\n");
        asmbuf_puts(&buf, "    (void)ark_addr; (void)ark_es; (void)frame; (void)ark_a; (void)ark_c;\n");
        /* For variadic functions, expose _ark_va_ptr pointing to the first
         * variadic argument stored at frame+8000. stdarg.h's va_start uses
         * this directly. param_count gives the number of named params. */
        if (f->is_variadic) {
            asmbuf_puts(&buf, "    long long *_ark_va_ptr = (long long*)(frame + 8000) + ");
            asmbuf_int(&buf, f->param_count);
            asmbuf_puts(&buf, ";\n");
        }

        for (i = 0; i < f->code_count; i++) {
            IrInst *I = &f->code[i];
            asmbuf_puts(&buf, "    ");
            switch (I->op) {
                case IR_FUNC_BEGIN:
                case IR_FUNC_END:
                    asmbuf_puts(&buf, "/* fn boundary */");
                    break;
                case IR_GETARG: {
                    /* aux low 8 bits = argument index; aux>>8 = struct size (0 if
                     * scalar/pointer). For scalar/pointer (size==0), store the
                     * 8-byte a<idx> at frame[val]. For struct-by-value, a<idx>
                     * carries a *pointer* to the source struct pushed by the
                     * caller; memcpy the payload into frame[val]. */
                    int arg_idx = I->aux & 0xFF;
                    int st_sz   = (I->aux >> 8) & 0xFFFFFF;
                    if (st_sz > 0) {
                        asmbuf_puts(&buf, "memcpy(frame + ");
                        asmbuf_int(&buf, I->val);
                        asmbuf_puts(&buf, ", (void*)(intptr_t)a");
                        asmbuf_int(&buf, arg_idx);
                        asmbuf_puts(&buf, ", (size_t)");
                        asmbuf_int(&buf, st_sz);
                        asmbuf_puts(&buf, ");");
                    } else {
                        asmbuf_puts(&buf, "*(long long*)(frame + ");
                        asmbuf_int(&buf, I->val);
                        asmbuf_puts(&buf, ") = a");
                        asmbuf_int(&buf, arg_idx);
                        asmbuf_putc(&buf, ';');
                    }
                    break;
                }
                case IR_PUSH_INT:
                    asmbuf_puts(&buf, "stk[sp++].i = ");
                    asmbuf_int(&buf, I->val);
                    asmbuf_puts(&buf, "LL;");
                    break;
                case IR_PUSH_FLOAT:
                    if (I->aux & 0x400) {
                        /* Complex constant: aux 0x600 = double(0x200)+complex(0x400); val = constant index. */
                        asmbuf_puts(&buf, "stk[sp++].c = ark_cflt_");
                        asmbuf_int(&buf, I->val);
                        asmbuf_puts(&buf, ";");
                    } else {
                        asmbuf_puts(&buf, "stk[sp++].f = ark_flt_");
                        asmbuf_int(&buf, I->val);
                        asmbuf_puts(&buf, ";");
                    }
                    break;
                case IR_PUSH_STR: {
                    /* B2: wide strings reference ark_wstr_<id>; narrow strings use ark_str_<id>. */
                    int is_w = 0;
#if ARKCC_FEATURE_WCHAR
                    if (I->val >= 0 && I->val < prog->string_count &&
                        prog->strings[I->val]->is_wide) is_w = 1;
#endif
                    asmbuf_puts(&buf, "stk[sp++].i = (long long)(intptr_t)ark_");
                    asmbuf_puts(&buf, is_w ? "wstr_" : "str_");
                    asmbuf_int(&buf, I->val);
                    asmbuf_putc(&buf, ';');
                    break;
                }
                case IR_ALLOCA:
                    /* B3: VLA allocation; replace top-of-stack with alloca(size) pointer. */
                    asmbuf_puts(&buf, "stk[sp-1].i = (long long)(intptr_t)alloca((size_t)stk[sp-1].i);");
                    break;
                case IR_PUSH_VAR: {
                    /* aux encodes load size and sign:
                     * Low 8 bits = element size (1/2/4/8/16); bit8 (0x100) = unsigned.
                     * For signed integers, sign-extend into a long long slot to
                     * preserve negative values when re-stored as a narrower type.
                     * Sign-extending before comparison avoids mixing 0xFFFFFFFF
                     * (unsigned) with -1 (signed) semantics.
                     * sz==16 means _Complex double; use the .c member to push. */
                    int sz = I->aux & 0xFF;
                    int is_unsigned = I->aux & 0x100;
                    if (sz == 0) sz = 8;
                    if (sz == 16) {
                        asmbuf_puts(&buf, "stk[sp++].c = *(_Complex double*)(frame + ");
                        asmbuf_int(&buf, I->val);
                        asmbuf_puts(&buf, ");");
                        break;
                    }
                    if (sz == 1) {
                        if (is_unsigned)
                            asmbuf_puts(&buf, "stk[sp++].i = (long long)(unsigned char)*(unsigned char*)(frame + ");
                        else
                            asmbuf_puts(&buf, "stk[sp++].i = (long long)(signed char)*(signed char*)(frame + ");
                    }
                    else if (sz == 2) {
                        if (is_unsigned)
                            asmbuf_puts(&buf, "stk[sp++].i = (long long)(unsigned short)*(unsigned short*)(frame + ");
                        else
                            asmbuf_puts(&buf, "stk[sp++].i = (long long)(short)*(short*)(frame + ");
                    }
                    else if (sz == 4) {
                        if (is_unsigned)
                            asmbuf_puts(&buf, "stk[sp++].i = (long long)(unsigned int)*(unsigned int*)(frame + ");
                        else
                            asmbuf_puts(&buf, "stk[sp++].i = (long long)(int)*(int*)(frame + ");
                    }
                    else
                        asmbuf_puts(&buf, "stk[sp++].i = *(long long*)(frame + ");
                    asmbuf_int(&buf, I->val);
                    asmbuf_puts(&buf, ");");
                    break;
                }
                case IR_PUSH_ADDR:
                    asmbuf_puts(&buf, "stk[sp++].i = (long long)(intptr_t)(frame + ");
                    asmbuf_int(&buf, I->val);
                    asmbuf_puts(&buf, ");");
                    break;
                case IR_PUSH_GLOBAL: {
                    /* Look up the global by name to determine its category
                     * (aggregate vs. scalar vs. float/double). Aggregates use
                     * address-of to push a pointer; floats push via .f member
                     * to avoid bit-pattern loss via (long long) cast.
                     * We scan prog->globals each time because the IR does not
                     * tag globals by category. */
                    int is_agg = 0;
                    int is_flt = 0;
                    int gi;
                    for (gi = 0; gi < prog->global_count; gi++) {
                        if (prog->globals[gi]->name &&
                            ark_streq(prog->globals[gi]->name, I->name)) {
                            Type *gt = prog->globals[gi]->type;
                            is_agg = c_type_is_aggregate(gt);
                            is_flt = gt && (gt->kind == TYPE_FLOAT || gt->kind == TYPE_DOUBLE);
                            break;
                        }
                    }
                    if (is_agg) {
                        asmbuf_puts(&buf, "stk[sp++].i = (long long)(intptr_t)&");
                        asmbuf_puts(&buf, I->name);
                        asmbuf_putc(&buf, ';');
                    } else if (is_flt) {
                        asmbuf_puts(&buf, "stk[sp++].f = (double)");
                        asmbuf_puts(&buf, I->name);
                        asmbuf_putc(&buf, ';');
                    } else {
                        asmbuf_puts(&buf, "stk[sp++].i = (long long)");
                        asmbuf_puts(&buf, I->name);
                        asmbuf_putc(&buf, ';');
                    }
                    break;
                }
                case IR_PUSH_GLOBAL_ADDR:
                    /* Always push the address of the global (regardless of category). */
                    asmbuf_puts(&buf, "stk[sp++].i = (long long)(intptr_t)&");
                    asmbuf_puts(&buf, I->name);
                    asmbuf_putc(&buf, ';');
                    break;
                case IR_STORE_GLOBAL:
                    asmbuf_puts(&buf, I->name);
                    asmbuf_puts(&buf, " = (long long)stk[--sp].i;");
                    break;
                case IR_POP:
                    asmbuf_puts(&buf, "if (sp>0) --sp;");
                    break;
                case IR_DUP:
                    asmbuf_puts(&buf, "if (sp>0) { stk[sp] = stk[sp-1]; sp++; }");
                    break;
                case IR_SWAP:
                    asmbuf_puts(&buf, "if (sp>=2) { long long _t = stk[sp-1].i; stk[sp-1].i = stk[sp-2].i; stk[sp-2].i = _t; }");
                    break;
                case IR_STORE: {
                    /* aux encodes the store size: 1/2/4/8/16. Narrow values
                     * are stored through the corresponding pointer type so that
                     * the high bits of an int are not written past the slot.
                     * sz==16 means _Complex double; store via the .c member.
                     * N1 FIX: mask off IR_AUX_VOLATILE (0x10000) bit. */
                    int sz = I->aux & ~IR_AUX_VOLATILE;
                    if (sz == 0) sz = 8;
                    if (sz == 16) {
                        asmbuf_puts(&buf, "*(_Complex double*)(frame + ");
                        asmbuf_int(&buf, I->val);
                        asmbuf_puts(&buf, ") = stk[--sp].c;");
                    } else if (sz == 1)
                        asmbuf_puts(&buf, "*(signed char*)(frame + ");
                    else if (sz == 2)
                        asmbuf_puts(&buf, "*(short*)(frame + ");
                    else if (sz == 4)
                        asmbuf_puts(&buf, "*(int*)(frame + ");
                    else
                        asmbuf_puts(&buf, "*(long long*)(frame + ");
                    if (sz != 16) {
                        asmbuf_int(&buf, I->val);
                        asmbuf_puts(&buf, ") = stk[--sp].i;");
                    }
                    break;
                }
                case IR_LOAD_IDX:
                    asmbuf_puts(&buf, "{ long long ix = stk[--sp].i; long long ad = stk[--sp].i; ark_es = ");
                    asmbuf_int(&buf, I->val);
                    asmbuf_puts(&buf, "; if (ark_es==1) stk[sp++].i = *(signed char*)(intptr_t)(ad + ix);");
                    asmbuf_puts(&buf, " else if (ark_es==2) stk[sp++].i = *(short*)(intptr_t)(ad + ix*2);");
                    asmbuf_puts(&buf, " else if (ark_es==8) stk[sp++].i = *(long long*)(intptr_t)(ad + ix*8);");
                    asmbuf_puts(&buf, " else stk[sp++].i = *(int*)(intptr_t)(ad + ix*ark_es); }");
                    break;
                case IR_STORE_IDX:
                    asmbuf_puts(&buf, "{ long long va = stk[--sp].i; long long ad = stk[--sp].i; ark_es = ");
                    asmbuf_int(&buf, I->val);
                    asmbuf_puts(&buf, "; if (ark_es==1) *(char*)(intptr_t)ad = (char)va;");
                    asmbuf_puts(&buf, " else if (ark_es==2) *(short*)(intptr_t)ad = (short)va;");
                    asmbuf_puts(&buf, " else if (ark_es==8) *(long long*)(intptr_t)ad = va;");
                    asmbuf_puts(&buf, " else *(int*)(intptr_t)ad = (int)va;");
                    asmbuf_puts(&buf, " stk[sp++].i = va; }");
                    break;
                case IR_BINARY:
                    asmbuf_puts(&buf, "ark_c = stk[--sp].i; ark_a = stk[--sp].i; stk[sp++].i = ");
                    emit_binop(&buf, I->aux);
                    asmbuf_putc(&buf, ';');
                    break;
                case IR_FADD:
                    if ((I->aux & 0x500) == 0x500) {
                        /* cexp intrinsic: 1 arg in -> 1 complex result out. */
                        asmbuf_puts(&buf, "ark_ca = stk[--sp].c; stk[sp++].c = cexp(ark_ca);");
                    } else if (I->aux & 0x400) {
                        asmbuf_puts(&buf, "ark_cc = stk[--sp].c; ark_ca = stk[--sp].c; stk[sp++].c = ark_ca + ark_cc;");
                    } else {
                        asmbuf_puts(&buf, "ark_fc = stk[--sp].f; ark_fa = stk[--sp].f; stk[sp++].f = ark_fa + ark_fc;");
                    }
                    break;
                case IR_FSUB:
                    if (I->aux & 0x400) {
                        asmbuf_puts(&buf, "ark_cc = stk[--sp].c; ark_ca = stk[--sp].c; stk[sp++].c = ark_ca - ark_cc;");
                    } else {
                        asmbuf_puts(&buf, "ark_fc = stk[--sp].f; ark_fa = stk[--sp].f; stk[sp++].f = ark_fa - ark_fc;");
                    }
                    break;
                case IR_FMUL:
                    if (I->aux & 0x400) {
                        asmbuf_puts(&buf, "ark_cc = stk[--sp].c; ark_ca = stk[--sp].c; stk[sp++].c = ark_ca * ark_cc;");
                    } else {
                        asmbuf_puts(&buf, "ark_fc = stk[--sp].f; ark_fa = stk[--sp].f; stk[sp++].f = ark_fa * ark_fc;");
                    }
                    break;
                case IR_FDIV:
                    /* Float division follows IEEE754: x/0.0 = +/-inf or NaN.
                     * The result feeds isnan/isinf classification paths; we keep
                     * the division at IR_FDIV rather than IR_BINARY+emit_binop. */
                    if (I->aux & 0x400) {
                        asmbuf_puts(&buf, "ark_cc = stk[--sp].c; ark_ca = stk[--sp].c; stk[sp++].c = ark_ca / ark_cc;");
                    } else {
                        asmbuf_puts(&buf, "ark_fc = stk[--sp].f; ark_fa = stk[--sp].f; stk[sp++].f = ark_fa / ark_fc;");
                    }
                    break;
                case IR_FCMP: {
                    /* Mask out the aux double bit (0x200) and pick the comparison op.
                     * C99 floats use the same comparison regardless of width. */
                    int op = I->aux & ~0x200;
                    const char *cop = "==";
                    switch (op) {
                        case (int)TOK_EQ: cop = "=="; break;
                        case (int)TOK_NE: cop = "!="; break;
                        case (int)TOK_LT: cop = "<";  break;
                        case (int)TOK_GT: cop = ">";  break;
                        case (int)TOK_LE: cop = "<="; break;
                        case (int)TOK_GE: cop = ">="; break;
                        default: break;
                    }
                    asmbuf_puts(&buf, "ark_fc = stk[--sp].f; ark_fa = stk[--sp].f; stk[sp++].i = (ark_fa ");
                    asmbuf_puts(&buf, cop);
                    asmbuf_puts(&buf, " ark_fc) ? 1 : 0;");
                    break;
                }
                case IR_F2I:
                    if ((I->aux & 0x500) == 0x500) {
                        /* cabs intrinsic: 1 complex arg in -> 1 double result. */
                        asmbuf_puts(&buf, "ark_ca = stk[--sp].c; stk[sp++].f = cabs(ark_ca);");
                    } else if (I->aux & 0x400) {
                        /* creal intrinsic: 1 complex arg in -> 1 double result. */
                        asmbuf_puts(&buf, "ark_ca = stk[--sp].c; stk[sp++].f = creal(ark_ca);");
                    } else {
                        asmbuf_puts(&buf, "ark_fa = stk[--sp].f; stk[sp++].i = (long long)ark_fa;");
                    }
                    break;
                case IR_I2F:
                    if ((I->aux & 0x700) == 0x700) {
                        /* int->complex: read .i as double, then write .c (imaginary=0). */
                        asmbuf_puts(&buf, "ark_ca = (double)stk[--sp].i; stk[sp++].c = ark_ca;");
                    } else if ((I->aux & 0x600) == 0x600) {
                        /* float->complex: read .f, then write .c (imaginary=0). */
                        asmbuf_puts(&buf, "ark_ca = stk[--sp].f; stk[sp++].c = ark_ca;");
                    } else if ((I->aux & 0x500) == 0x500) {
                        /* carg intrinsic: 1 complex arg in -> 1 double result. */
                        asmbuf_puts(&buf, "ark_ca = stk[--sp].c; stk[sp++].f = carg(ark_ca);");
                    } else if (I->aux & 0x400) {
                        /* cimag intrinsic: extracts imaginary part, 1 complex in -> 1 double out. */
                        asmbuf_puts(&buf, "ark_ca = stk[--sp].c; stk[sp++].f = cimag(ark_ca);");
                    } else {
                        asmbuf_puts(&buf, "ark_a = stk[--sp].i; stk[sp++].f = (double)ark_a;");
                    }
                    break;
                case IR_ASM:
                    /* '@' prefix indicates extended asm form: `"text" : outputs : inputs : clobbers`.
                     * Otherwise we emit a basic asm string literal; gcc accepts both forms.
                     * Note: IR_ASM is always volatile; the parser has already validated syntax. */
                    if (I->name && I->name[0] == '@') {
                        asmbuf_puts(&buf, "__asm__ __volatile__(");
                        asmbuf_puts(&buf, I->name + 1);
                        asmbuf_puts(&buf, ");");
                    } else {
                        asmbuf_puts(&buf, "__asm__ __volatile__(");
                        {
                            const char *s = I->name ? I->name : "";
                            emit_str_literal(&buf, s, ark_strlen(s));
                        }
                        asmbuf_puts(&buf, ");");
                    }
                    break;
                case IR_UNARY: {
                    int op = I->aux;
                    int is_float = (I->val == 1);
                    if (op & 0x400) {
                        /* Complex unary conj: 1 complex in -> 1 complex out. */
                        asmbuf_puts(&buf, "ark_ca = stk[--sp].c; stk[sp++].c = conj(ark_ca);");
                    } else if (is_float) {
                        /* Float negation: respects IEEE754 sign bit (handles -0.0/NaN).
                         * Uses the stk[].f member to preserve the sign bit semantics. */
                        asmbuf_puts(&buf, "ark_fc = stk[--sp].f; stk[sp++].f = (-ark_fc);");
                    } else {
                        asmbuf_puts(&buf, "ark_a = stk[--sp].i; stk[sp++].i = ");
                        if (op == (int)TOK_MINUS) asmbuf_puts(&buf, "(-ark_a)");
                        else if (op == (int)TOK_BNOT) asmbuf_puts(&buf, "(~ark_a)");
                        else if (op == (int)TOK_NOT)  asmbuf_puts(&buf, "(!ark_a)");
                        else asmbuf_puts(&buf, "(ark_a)");
                        asmbuf_putc(&buf, ';');
                    }
                    break;
                }
                case IR_LABEL:
                    asmbuf_puts(&buf, "L_");
                    asmbuf_int(&buf, I->val);
                    asmbuf_puts(&buf, ": ;");
                    break;
                case IR_LABEL_NAMED:
                    asmbuf_puts(&buf, "LN_");
                    asmbuf_puts(&buf, I->name);
                    asmbuf_puts(&buf, ": ;");
                    break;
                case IR_JMP:
                    asmbuf_puts(&buf, "goto L_");
                    asmbuf_int(&buf, I->val);
                    asmbuf_putc(&buf, ';');
                    break;
                case IR_JMP_NAMED:
                    asmbuf_puts(&buf, "goto LN_");
                    asmbuf_puts(&buf, I->name);
                    asmbuf_putc(&buf, ';');
                    break;
                case IR_JZ:
                    asmbuf_puts(&buf, "ark_a = stk[--sp].i; if (!ark_a) goto L_");
                    asmbuf_int(&buf, I->val);
                    asmbuf_putc(&buf, ';');
                    break;
                case IR_JNZ:
                    asmbuf_puts(&buf, "ark_a = stk[--sp].i; if (ark_a) goto L_");
                    asmbuf_int(&buf, I->val);
                    asmbuf_putc(&buf, ';');
                    break;
                case IR_CMP_JMP_EQ:
                    asmbuf_puts(&buf, "ark_a = stk[sp-1].i; if (ark_a == ");
                    asmbuf_int(&buf, I->val);
                    asmbuf_puts(&buf, ") { --sp; goto L_");
                    asmbuf_int(&buf, I->aux);
                    asmbuf_puts(&buf, "; }");
                    break;
                case IR_CALL: {
                    int n = I->val;
                    int k;
                    /* Pop n args off the stack into aa[] (in call order arg0..argN-1).
                     * aa[] is volatile so gcc cannot constant-fold away the stores.
                     * Without volatile, gcc -O2 would erase the union(ark_slot) write
                     * pattern, breaking printf's variadic ABI. The default values are
                     * 0 so unused slots read as NULL (avoids %s printing "(null)"). */
                    asmbuf_puts(&buf, "{ long long volatile aa[16] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}; ");
                    if (n > MAX_CALL_ARGS) n = MAX_CALL_ARGS;
                    if (is_complex_ret_func(I->name)) {
                        /* Complex-function args are _Complex double (16 bytes, .c member);
                         * popping via .i reads only 8 bytes. Use a separate _Complex array. */
                        asmbuf_puts(&buf, "_Complex double volatile aac[8] = {0}; ");
                        for (k = 0; k < n; k++) {
                            asmbuf_puts(&buf, "aac[");
                            asmbuf_int(&buf, k);
                            asmbuf_puts(&buf, "] = stk[--sp].c; ");
                        }
                    } else {
                        for (k = 0; k < n; k++) {
                            asmbuf_puts(&buf, "aa[");
                            asmbuf_int(&buf, k);
                            asmbuf_puts(&buf, "] = stk[--sp].i; ");
                        }
                    }
                    /* Dispatch to libc if the function is host libc; otherwise ark_ prefix. */
                    if (ark_streq(I->name, "printf")) {
                        /* printf variadic ABI: arkcc stores all args as long long in aa[].
                         * aux encodes per-argument type using 2 bits per arg:
                         *   bit(2*i)   = 1 => float/double (promoted to double, XMM/8B)
                         *   bit(2*i+1) = 1 => long long (8 bytes on the wire)
                         *   both 0     => int/ptr/short/char (int-promoted, 4 bytes)
                         * On 32-bit hosts va_arg(int) reads 4 bytes and va_arg(long long)
                         * reads 8 bytes; passing everything as long long shifts subsequent
                         * arguments and produces garbage. Casting to `int` for int-typed
                         * args restores the proper stack layout. */
                        int amask = I->aux;
                        asmbuf_puts(&buf, "stk[sp++].i = printf((const char*)(intptr_t)aa[0],");
                        for (k = 1; k < MAX_CALL_ARGS; k++) {
                            int is_double = (amask >> (2 * k)) & 1;
                            int is_llong  = (amask >> (2 * k + 1)) & 1;
                            if (k > 1) asmbuf_putc(&buf, ',');
                            if (is_double) {
                                asmbuf_puts(&buf, "_ark_ll2d(aa[");
                                asmbuf_int(&buf, k);
                                asmbuf_puts(&buf, "])");
                            } else if (is_llong) {
                                asmbuf_puts(&buf, "(long long)aa[");
                                asmbuf_int(&buf, k);
                                asmbuf_puts(&buf, "]");
                            } else {
                                asmbuf_puts(&buf, "(int)aa[");
                                asmbuf_int(&buf, k);
                                asmbuf_puts(&buf, "]");
                            }
                        }
                        asmbuf_puts(&buf, ");");
                    } else if (ark_streq(I->name, "putchar")) {
                        asmbuf_puts(&buf, "stk[sp++].i = putchar((int)aa[0]);");
                    } else if (ark_streq(I->name, "puts")) {
                        asmbuf_puts(&buf, "stk[sp++].i = puts((const char*)(intptr_t)aa[0]);");
                    } else if (ark_streq(I->name, "strlen")) {
                        asmbuf_puts(&buf, "stk[sp++].i = (long long)strlen((const char*)(intptr_t)aa[0]);");
                    } else if (ark_streq(I->name, "strcmp")) {
                        asmbuf_puts(&buf, "stk[sp++].i = strcmp((const char*)(intptr_t)aa[0],(const char*)(intptr_t)aa[1]);");
                    } else if (ark_streq(I->name, "strcpy")) {
                        asmbuf_puts(&buf, "stk[sp++].i = (long long)(intptr_t)strcpy((char*)(intptr_t)aa[0],(const char*)(intptr_t)aa[1]);");
                    } else if (ark_streq(I->name, "memset")) {
                        asmbuf_puts(&buf, "stk[sp++].i = (long long)(intptr_t)memset((void*)(intptr_t)aa[0],(int)aa[1],(size_t)aa[2]);");
                    } else if (ark_streq(I->name, "memcpy")) {
                        asmbuf_puts(&buf, "stk[sp++].i = (long long)(intptr_t)memcpy((void*)(intptr_t)aa[0],(const void*)(intptr_t)aa[1],(size_t)aa[2]);");
                    } else if (ark_streq(I->name, "abort")) {
                        asmbuf_puts(&buf, "abort(); stk[sp++].i = 0;");
                    } else if (ark_streq(I->name, "setjmp")) {
                        /* setjmp: dispatched inline because .gen.c has #include <setjmp.h>.
                         * The IR folds jmp_buf as int[20]=80B; we cast the slot back to
                         * jmp_buf. Requires host jmp_buf to fit in 80B; if it grows,
                         * extend the frame size or emit a dedicated buffer for jmp_buf. */
                        asmbuf_puts(&buf,
                            "stk[sp++].i = setjmp(*(jmp_buf*)(void*)(intptr_t)aa[0]);");
                    } else if (ark_streq(I->name, "longjmp")) {
                        /* longjmp: never returns; we still push a 0 result so gcc -O2
                         * does not delete the push. C mandates val==0 returns 1. */
                        asmbuf_puts(&buf,
                            "longjmp(*(jmp_buf*)(void*)(intptr_t)aa[0], (int)aa[1] ? (int)aa[1] : 1); stk[sp++].i = 0;");
                    } else if (I->name[0] == '?') {
                        /* Indirect call through function pointer: aa[0] is the
                         * function pointer, aa[1..n-1] are the actual arguments.
                         * Cast aa[0] to a function pointer and call through it. */
                        int k;
                        asmbuf_puts(&buf, "stk[sp++].i = (long long)((long long (*)(");
                        for (k = 1; k < n; k++) {
                            if (k > 1) asmbuf_puts(&buf, ",");
                            asmbuf_puts(&buf, "long long");
                        }
                        asmbuf_puts(&buf, "))(intptr_t)aa[0])(");
                        for (k = 1; k < n; k++) {
                            if (k > 1) asmbuf_puts(&buf, ", ");
                            asmbuf_puts(&buf, "(long long)aa[");
                            asmbuf_int(&buf, k);
                            asmbuf_puts(&buf, "]");
                        }
                        asmbuf_puts(&buf, ");");
                    } else {
                        int is_libc = is_libc_func(I->name) && !is_wrapped_func(I->name);
                        int is_wrapped = is_wrapped_func(I->name);
                        int is_void_ret = is_void_func(I->name);
                        int is_struct_ret = is_struct_ret_func(I->name);
                        int k;
                        /* libc: pass only n args; wrapped: wrappers have fixed 8-arg
                         * signature; user-defined: pass all MAX_CALL_ARGS args. */
                        int nargs = is_libc ? n : (is_wrapped ? 8 : MAX_CALL_ARGS);
                        if (is_struct_ret) {
                            const char *tname = struct_ret_type(I->name);
                            asmbuf_puts(&buf, "{ ");
                            asmbuf_puts(&buf, tname);
                            asmbuf_puts(&buf, " _r = ");
                            asmbuf_puts(&buf, I->name);
                            asmbuf_puts(&buf, "(");
                            for (k = 0; k < n; k++) {
                                if (k) asmbuf_puts(&buf, ", ");
                                asmbuf_puts(&buf, "(intptr_t)aa[");
                                asmbuf_int(&buf, k);
                                asmbuf_puts(&buf, "]");
                            }
                            asmbuf_puts(&buf, "); *( ");
                            asmbuf_puts(&buf, tname);
                            asmbuf_puts(&buf, "*)(frame + 8176) = _r; stk[sp++].i = (long long)(intptr_t)(frame + 8176); }");
                        } else if (is_complex_ret_func(I->name)) {
                            /* Complex-returning functions: store result via .c member, pass
                             * args from aac[] (_Complex array). Do NOT cast to long long
                             * (would lose the imaginary part). These are in is_libc_func,
                             * so call host libc directly. */
                            asmbuf_puts(&buf, "stk[sp++].c = ");
                            asmbuf_puts(&buf, I->name);
                            asmbuf_puts(&buf, "(");
                            for (k = 0; k < n; k++) {
                                if (k) asmbuf_puts(&buf, ", ");
                                asmbuf_puts(&buf, "aac[");
                                asmbuf_int(&buf, k);
                                asmbuf_puts(&buf, "]");
                            }
                            asmbuf_puts(&buf, ");");
                        } else if (is_void_ret) {
                            asmbuf_puts(&buf, "");
                            if (!is_libc) asmbuf_puts(&buf, "ark_");
                            asmbuf_puts(&buf, I->name);
                            asmbuf_puts(&buf, "(");
                            for (k = 0; k < nargs; k++) {
                                if (k) asmbuf_puts(&buf, ", ");
                                if (is_libc)
                                    asmbuf_puts(&buf, "(intptr_t)aa[");
                                else
                                    asmbuf_puts(&buf, "(long long)aa[");
                                asmbuf_int(&buf, k);
                                asmbuf_puts(&buf, "]");
                            }
                            asmbuf_puts(&buf, "); stk[sp++].i = 0;");
                        } else {
                            asmbuf_puts(&buf, "stk[sp++].i = (long long)");
                            if (!is_libc) asmbuf_puts(&buf, "ark_");
                            asmbuf_puts(&buf, I->name);
                            asmbuf_puts(&buf, "(");
                            for (k = 0; k < nargs; k++) {
                                if (k) asmbuf_puts(&buf, ", ");
                                if (is_libc)
                                    asmbuf_puts(&buf, "(intptr_t)aa[");
                                else
                                    asmbuf_puts(&buf, "(long long)aa[");
                                asmbuf_int(&buf, k);
                                asmbuf_puts(&buf, "]");
                            }
                            asmbuf_puts(&buf, ");");
                        }
                    }
                    asmbuf_puts(&buf, " }");
                    break;
                }
                case IR_SVC: {
                    /* __svc(n) is an ARM supervisor call; in C it is a no-op.
                     * We emit the comment so the SVC number is preserved in code. */
                    int svc_n = I->val;
                    (void)svc_n;
                    asmbuf_puts(&buf, "{ long long _svc_arg = stk[--sp].i; ");
                    asmbuf_puts(&buf, "/* SVC #");
                    asmbuf_int(&buf, svc_n);
                    asmbuf_puts(&buf, " (no-op on host) */ ");
                    asmbuf_puts(&buf, "stk[sp++].i = _svc_arg; }");
                    break;
                }
                /* === Signed/unsigned 32-bit division: aux=0 signed, aux=1 unsigned === */
                case IR_DIV:
                    asmbuf_puts(&buf, "ark_c = stk[--sp].i; ark_a = stk[--sp].i; stk[sp++].i = (");
                    if (I->aux) asmbuf_puts(&buf, "(unsigned)ark_a / (unsigned)ark_c");
                    else        asmbuf_puts(&buf, "ark_a / ark_c");
                    asmbuf_puts(&buf, ");");
                    break;
                case IR_MOD:
                    asmbuf_puts(&buf, "ark_c = stk[--sp].i; ark_a = stk[--sp].i; stk[sp++].i = (");
                    if (I->aux) asmbuf_puts(&buf, "(unsigned)ark_a % (unsigned)ark_c");
                    else        asmbuf_puts(&buf, "ark_a % ark_c");
                    asmbuf_puts(&buf, ");");
                    break;
                /* === 64-bit operations: C uses long long natively === */
                case IR_64PUSH:
                    /* val=high 32 bits, aux=low 32 bits; assemble into a long long. */
                    asmbuf_puts(&buf, "stk[sp++].i = ((long long)(unsigned)");
                    asmbuf_int(&buf, I->val);
                    asmbuf_puts(&buf, " << 32) | (unsigned)");
                    asmbuf_int(&buf, I->aux);
                    asmbuf_puts(&buf, ";");
                    break;
                case IR_64BINARY:
                    /* Same as IR_BINARY but a/c are long long, preserving 64-bit. */
                    asmbuf_puts(&buf, "ark_c = stk[--sp].i; ark_a = stk[--sp].i; stk[sp++].i = ");
                    emit_binop(&buf, I->aux);
                    asmbuf_putc(&buf, ';');
                    break;
                case IR_64CMP: {
                    /* aux bit 0x100 marks an unsigned comparison (unsigned long long).
                     * Signed -1 vs unsigned ULLONG_MAX would compare differently;
                     * EQ/NE are bit-equal regardless of sign, but LT/LE/GT/GE differ. */
                    int is_unsigned = (I->aux & 0x100) != 0;
                    int op = I->aux & ~0x100;
                    const char *cop = "==";
                    const char *lcast = is_unsigned ? "(unsigned long long)ark_a" : "ark_a";
                    const char *rcast = is_unsigned ? "(unsigned long long)ark_c" : "ark_c";
                    switch (op) {
                        case (int)TOK_EQ: cop = "=="; break;
                        case (int)TOK_NE: cop = "!="; break;
                        case (int)TOK_LT: cop = "<";  break;
                        case (int)TOK_GT: cop = ">";  break;
                        case (int)TOK_LE: cop = "<="; break;
                        case (int)TOK_GE: cop = ">="; break;
                        default: break;
                    }
                    asmbuf_puts(&buf, "ark_c = stk[--sp].i; ark_a = stk[--sp].i; stk[sp++].i = (");
                    asmbuf_puts(&buf, lcast);
                    asmbuf_puts(&buf, " ");
                    asmbuf_puts(&buf, cop);
                    asmbuf_puts(&buf, " ");
                    asmbuf_puts(&buf, rcast);
                    asmbuf_puts(&buf, ") ? 1 : 0;");
                    break;
                }
                /* === Stack-based memcpy: pop order = dst, then src === */
                case IR_MEMCPY:
                    asmbuf_puts(&buf, "{ long long _dst = stk[--sp].i; long long _src = stk[--sp].i; memcpy((void*)(intptr_t)_dst, (void*)(intptr_t)_src, (size_t)");
                    asmbuf_int(&buf, I->val);
                    asmbuf_puts(&buf, "); }");
                    break;
                /* === Bitfield store/load: val=bit offset, aux=bit width === */
                case IR_STORE_FLD:
                    asmbuf_puts(&buf, "{ long long _v = stk[--sp].i; long long _ad = stk[--sp].i; int _mask = (1 << ");
                    asmbuf_int(&buf, I->aux);
                    asmbuf_puts(&buf, ") - 1; int *_p = (int*)(intptr_t)_ad; *_p = (*_p & ~(_mask << ");
                    asmbuf_int(&buf, I->val);
                    asmbuf_puts(&buf, ")) | (((int)_v & _mask) << ");
                    asmbuf_int(&buf, I->val);
                    asmbuf_puts(&buf, "); }");
                    break;
                case IR_LOAD_FLD:
                    asmbuf_puts(&buf, "{ long long _ad = stk[--sp].i; int _mask = (1 << ");
                    asmbuf_int(&buf, I->aux);
                    asmbuf_puts(&buf, ") - 1; stk[sp++].i = (long long)((*(unsigned int*)(intptr_t)_ad >> ");
                    asmbuf_int(&buf, I->val);
                    asmbuf_puts(&buf, ") & _mask); }");
                    break;
                case IR_RETURN: {
                    /* Struct/union return by value (> 8 bytes): the stack top
                     * is a pointer to the struct. Copy the struct to a *static*
                     * ret buffer and return its address so the caller can memcpy.
                     * We use static (not `frame + 8176`) because `frame` is a
                     * local stack array; returning its address is UB ?? after
                     * the callee returns, the stack frame is destroyed and the
                     * caller's memcpy reads garbage. This was the root cause of
                     * the bootstrap crash when Token (40 bytes) was returned
                     * by lexer_peek/next. Single-threaded compiler use makes
                     * the static buffer safe (no re-entrancy).
                     * Small structs (<= 8 bytes) are returned as a value
                     * directly; callers must use IR_STORE (not IR_MEMCPY) for
                     * them, since the result is an rvalue, not a pointer. */
                    Type *rt = f->ret_type;
                    if (rt && (rt->kind == TYPE_STRUCT || rt->kind == TYPE_UNION) &&
                        type_size(rt) > 8) {
                        int rsz = type_size(rt);
                        asmbuf_puts(&buf, "{ static char _ark_ret_buf[256]; long long _ret_addr = stk[--sp].i; memcpy(_ark_ret_buf, (void*)(intptr_t)_ret_addr, ");
                        asmbuf_int(&buf, rsz);
                        asmbuf_puts(&buf, "); return (long long)(intptr_t)_ark_ret_buf; }");
                    } else {
                        asmbuf_puts(&buf, "return (long long)stk[--sp].i;");
                    }
                    break;
                }
                /* === 0.7.0+ SIMD emulation: arithmetic on packed lanes ===
                 * SADD16/SSUB16: split a 32-bit word into two 16-bit lanes.
                 * SADD8/SSUB8: split into four 8-bit lanes.
                 * These emulate ARM DSP intrinsics for the host C backend. */
                case IR_SIMD_ADD16:
                    asmbuf_puts(&buf, "ark_c = stk[--sp].i; ark_a = stk[--sp].i; { unsigned _a=(unsigned)ark_a, _c=(unsigned)ark_c; "
                                      "unsigned lo=(_a&0xFFFF)+(_c&0xFFFF); "
                                      "unsigned hi=((_a>>16)&0xFFFF)+((_c>>16)&0xFFFF); "
                                      "stk[sp++].i=(long long)((unsigned)((hi<<16)|(lo&0xFFFF))); }");
                    break;
                case IR_SIMD_SUB16:
                    asmbuf_puts(&buf, "ark_c = stk[--sp].i; ark_a = stk[--sp].i; { unsigned _a=(unsigned)ark_a, _c=(unsigned)ark_c; "
                                      "unsigned lo=(_a&0xFFFF)-(_c&0xFFFF); "
                                      "unsigned hi=((_a>>16)&0xFFFF)-((_c>>16)&0xFFFF); "
                                      "stk[sp++].i=(long long)((unsigned)((hi<<16)|(lo&0xFFFF))); }");
                    break;
                case IR_SIMD_ADD8:
                    asmbuf_puts(&buf, "ark_c = stk[--sp].i; ark_a = stk[--sp].i; { unsigned _a=(unsigned)ark_a, _c=(unsigned)ark_c; "
                                      "unsigned b0=(_a&0xFF)+(_c&0xFF); "
                                      "unsigned b1=((_a>>8)&0xFF)+((_c>>8)&0xFF); "
                                      "unsigned b2=((_a>>16)&0xFF)+((_c>>16)&0xFF); "
                                      "unsigned b3=((_a>>24)&0xFF)+((_c>>24)&0xFF); "
                                      "stk[sp++].i=(long long)((unsigned)((b3<<24)|((b2&0xFF)<<16)|((b1&0xFF)<<8)|(b0&0xFF))); }");
                    break;
                case IR_SIMD_SUB8:
                    asmbuf_puts(&buf, "ark_c = stk[--sp].i; ark_a = stk[--sp].i; { unsigned _a=(unsigned)ark_a, _c=(unsigned)ark_c; "
                                      "unsigned b0=(_a&0xFF)-(_c&0xFF); "
                                      "unsigned b1=((_a>>8)&0xFF)-((_c>>8)&0xFF); "
                                      "unsigned b2=((_a>>16)&0xFF)-((_c>>16)&0xFF); "
                                      "unsigned b3=((_a>>24)&0xFF)-((_c>>24)&0xFF); "
                                      "stk[sp++].i=(long long)((unsigned)((b3<<24)|((b2&0xFF)<<16)|((b1&0xFF)<<8)|(b0&0xFF))); }");
                    break;
                default:
                    asmbuf_puts(&buf, "/* unknown ir */");
                    break;
            }
            asmbuf_putc(&buf, '\n');
        }
        asmbuf_puts(&buf, "    return 0;\n}\n\n");
    }

    if (main_idx >= 0) {
        asmbuf_puts(&buf, "int main(int argc, char **argv) {\n");
        asmbuf_puts(&buf, "    return (int)ark_main((long long)argc,(long long)(intptr_t)argv,0,0,0,0,0,0,0,0,0,0,0,0,0,0);\n}\n");
    }

    {
        int n = buf.len;
        int i;
        if (n + 1 > cap) n = cap - 1;
        for (i = 0; i < n; i++) out[i] = buf.buf[i];
        out[n] = 0;
        return n;
    }
}

static int c_assemble(const char *asm_text, unsigned char *out, int cap) {
    /* The C backend has no assemble step; we just copy the source text.
     * The driver writes it to a .c file and invokes gcc externally. */
    int n = ark_strlen(asm_text);
    int i;
    if (n > cap) n = cap;
    for (i = 0; i < n; i++) out[i] = (unsigned char)asm_text[i];
    return n;
}

static int c_link(unsigned char *code, int size, struct LinkContext *lc) {
    (void)code; (void)size; (void)lc;
    return 0;
}

static const ArkBackend g_c_backend = {
    "c",
    "host-c-source",
    (int)sizeof(void*),
    c_emit,
    c_assemble,
    c_link
};

const ArkBackend *ark_backend_c(void) {
    return &g_c_backend;
}
