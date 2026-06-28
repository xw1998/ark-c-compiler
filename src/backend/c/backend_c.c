/* Ark C Compiler - C source backend
 * 把 IR 翻译回可读 C 源代码，便于在 host 上用 gcc 编译运行进行验证。
 *
 * 策略：
 *   - 每个函数生成一个 long ark_<name>(long a0, long a1, ...) 主体。
 *   - 局部以一个 long stk[256] + 偏移 sp 模拟"虚拟栈"，与 IR 完全一致。
 *   - 局部变量、参数槽通过 stk + base 索引（与 r6 偏移含义相同）。
 *   - IR_CALL 直接展开为 C 函数调用，最多取 8 个参数；额外参数变 0。
 *   - 字符串池产生一组 const char *ark_str_<id>。
 *   - 当遇到 main 时另外生成一个 main()，调用 ark_main(0,0,...)。
 *   - 同时输出对常用 stdlib 函数（printf/putchar/puts/strlen/strcmp/strcpy/
 *     memcpy/memset/abort）的 forward declaration，便于直接链接 host libc。
 */
#include "backend.h"
#include "codegen.h"
#include "memory.h"
#include "platform.h"
#include "common.h"
#include "config.h"
#include "arkcc_config.h"

#define MAX_CALL_ARGS 8

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

/* 写入两元运算的 C 表达式。
 * aux 高位 0x100 标记无符号比较/右移：用 (unsigned int) 强转截断到 32 位
 * 后做无符号运算，保证 C99 通常算术转换语义（int/unsigned 混合时转 unsigned）。
 * 截断到 unsigned int(32 位) 而非 unsigned long long(64 位)：因为 IR_BINARY
 * 路径均为 32 位运算，64 位走 IR_64BINARY；32 位截断才能正确处理
 * 负数符号扩展与无符号值的混合比较（如 int -1 vs unsigned 0xFFFFFFFF）。 */
static void emit_binop(AsmBuffer *b, int op) {
    int is_unsigned = (op & 0x100) != 0;
    int base_op = op & ~0x100;
    /* lhs op rhs */
    switch (base_op) {
        case (int)TOK_PLUS:  asmbuf_puts(b, "(a + c)"); break;
        case (int)TOK_MINUS: asmbuf_puts(b, "(a - c)"); break;
        case (int)TOK_MUL:   asmbuf_puts(b, "(a * c)"); break;
        case (int)TOK_DIV:   asmbuf_puts(b, "(c ? a / c : 0)"); break;
        case (int)TOK_MOD:   asmbuf_puts(b, "(c ? a % c : 0)"); break;
        case (int)TOK_BAND:  asmbuf_puts(b, "(a & c)"); break;
        case (int)TOK_BOR:   asmbuf_puts(b, "(a | c)"); break;
        case (int)TOK_BXOR:  asmbuf_puts(b, "(a ^ c)"); break;
        case (int)TOK_SHL:   asmbuf_puts(b, "(a << c)"); break;
        case (int)TOK_SHR:
            if (is_unsigned) asmbuf_puts(b, "((unsigned int)a >> c)");
            else             asmbuf_puts(b, "(a >> c)");
            break;
        case (int)TOK_EQ:    asmbuf_puts(b, "(a == c)"); break;
        case (int)TOK_NE:    asmbuf_puts(b, "(a != c)"); break;
        case (int)TOK_LT:
            if (is_unsigned) asmbuf_puts(b, "((unsigned int)a < (unsigned int)c)");
            else             asmbuf_puts(b, "(a < c)");
            break;
        case (int)TOK_GT:
            if (is_unsigned) asmbuf_puts(b, "((unsigned int)a > (unsigned int)c)");
            else             asmbuf_puts(b, "(a > c)");
            break;
        case (int)TOK_LE:
            if (is_unsigned) asmbuf_puts(b, "((unsigned int)a <= (unsigned int)c)");
            else             asmbuf_puts(b, "(a <= c)");
            break;
        case (int)TOK_GE:
            if (is_unsigned) asmbuf_puts(b, "((unsigned int)a >= (unsigned int)c)");
            else             asmbuf_puts(b, "(a >= c)");
            break;
        default:             asmbuf_puts(b, "(a)"); break;
    }
}

static void emit_func_proto(AsmBuffer *b, IrFunc *f) {
    int i;
    /* static 函数保持内部链接；非 static 函数给外部链接，便于多文件链接。
     * __weak/__naked 通过 GCC 属性透传；__irq 仅加注释（host 无中断概念）。 */
    if (f->is_weak)   asmbuf_puts(b, "__attribute__((weak)) ");
    if (f->is_naked || f->is_asm_func) asmbuf_puts(b, "__attribute__((naked)) ");
    if (f->is_used)   asmbuf_puts(b, "__attribute__((used)) ");
    if (f->is_unused) asmbuf_puts(b, "__attribute__((unused)) ");
    if (f->forceinline) asmbuf_puts(b, "__attribute__((always_inline)) inline ");
    /* constructor/destructor：透传给 gcc，由其注册到 .init_array/.fini_array。
     * deprecated：透传给 gcc 触发弃用警告。 */
    if (f->is_constructor) asmbuf_puts(b, "__attribute__((constructor)) ");
    if (f->is_destructor)  asmbuf_puts(b, "__attribute__((destructor)) ");
    if (f->is_deprecated)  asmbuf_puts(b, "__attribute__((deprecated)) ");
#if ARKCC_FEATURE_ARMCC_KEYWORDS
    /* armcc 5 兼容函数属性透传给 gcc：
     *   __pure            -> __attribute__((pure))
     *   __attribute__((const)) -> __attribute__((const))
     *   __value_in_regs   -> 仅注释（gcc 用寄存器结构体返回约定，无直接对应属性）
     *   __interwork       -> 仅注释（ARM/Thumb 互调用，host 无意义）
     *   __smc(n)          -> 仅注释（安全监控调用，host 无意义） */
    if (f->is_pure)       asmbuf_puts(b, "__attribute__((pure)) ");
    if (f->is_const_attr) asmbuf_puts(b, "__attribute__((const)) ");
#endif
    if (f->alias_target) {
        /* alias 声明：__attribute__((alias("ark_xxx"))) */
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

/* 判断名字是否为路由到 host libc 的内置函数（这些不走 ark_ 前缀，无需 extern）。 */
static int is_libc_func(const char *name) {
    static const char *libcs[] = {
        "printf", "putchar", "puts", "strlen", "strcmp",
        "strcpy", "memset", "memcpy", "abort",
        /* setjmp/longjmp：路由到 gcc 内置（见 IR_CALL 处理），避免类型不兼容
         * 与宿主 jmp_buf 尺寸差异；缓冲区复用上层 jmp_buf（>= 40B）。 */
        "setjmp", "longjmp", 0
    };
    int i;
    if (!name) return 0;
    for (i = 0; libcs[i]; i++) if (ark_streq(name, libcs[i])) return 1;
    return 0;
}

/* 发出 extern 声明：用于"被调用但未在本 TU 定义"的函数。 */
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

/* 把类型以 C 源码形式输出，并把变量名嵌入到声明子位置。
 *   - 标量：输出 "<base> <name>"
 *   - 指针：递归输出 base，name 前加 '*'
 *   - 数组：先递归输出 base+name，再追加 "[size]"（size==0 输出 "[]"）
 *   - struct/union：内联展开字段定义
 * 该函数不输出存储类、const、section 等修饰符，仅类型与名字。 */
static void emit_c_type(AsmBuffer *b, Type *t, const char *name) {
    if (!t) { asmbuf_puts(b, "long long "); asmbuf_puts(b, name); return; }
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
        case TYPE_WCHAR:  asmbuf_puts(b, "wchar_t "); break;  /* B2: 透传给 gcc */
        case TYPE_COMPLEX: /* B4: _Complex float/double 透传给 gcc */
            asmbuf_puts(b, "_Complex ");
            if (t->base && t->base->kind == TYPE_FLOAT) asmbuf_puts(b, "float ");
            else asmbuf_puts(b, "double ");
            break;
        case TYPE_PTR: {
            /* 指针：name 前加 '*'，递归输出 base */
            char namebuf[256];
            int i = 0;
            namebuf[i++] = '*';
            if (name) { const char *p = name; while (*p && i < 250) namebuf[i++] = *p++; }
            namebuf[i] = 0;
            emit_c_type(b, t->base, namebuf);
            return;
        }
        case TYPE_ARRAY: {
            /* 数组：收集所有维度（从外到内），输出 base+name 后追加维度。
             * C 声明里外层维度在前：int m[2][3] 表示 m 是 2 个 int[3]。 */
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

/* 判断全局变量类型在 C 后端是否为聚合（需要按地址而非值引用）。 */
static int c_type_is_aggregate(Type *t) {
    if (!t) return 0;
    return t->kind == TYPE_ARRAY || t->kind == TYPE_STRUCT || t->kind == TYPE_UNION;
}

static int c_emit(IrProgram *prog, char *out, int cap) {
    AsmBuffer buf;
    int fi;
    int main_idx = -1;
    asmbuf_init(&buf);

    asmbuf_puts(&buf, "/* Ark C Compiler - generated by C backend */\n");
    asmbuf_puts(&buf, "#include <stdio.h>\n");
    asmbuf_puts(&buf, "#include <stdlib.h>\n");
    asmbuf_puts(&buf, "#include <string.h>\n");
    asmbuf_puts(&buf, "#include <stdint.h>\n");
    asmbuf_puts(&buf, "#include <setjmp.h>\n");
    asmbuf_puts(&buf, "#include <malloc.h>\n");   /* B3: alloca 用于 VLA */
    asmbuf_puts(&buf, "#include <wchar.h>\n\n");   /* B2: wchar_t 宽字符 */
    asmbuf_puts(&buf, "typedef long long ark_long;\n\n");
    asmbuf_puts(&buf, "/* 用 long long 保证 8 字节槽位与 double 完全重叠，避免 LLP64 下 long=4 的位模式截断 */\n");
    asmbuf_puts(&buf, "typedef union { long long i; double f; } ark_slot;\n");
    asmbuf_puts(&buf, "static inline long long _AS_I(ark_slot s){return s.i;}\n");
    asmbuf_puts(&buf, "static inline double _AS_F(ark_slot s){return s.f;}\n");
    asmbuf_puts(&buf, "static inline ark_slot _SI(long long v){ark_slot s; s.i=v; return s;}\n");
    asmbuf_puts(&buf, "static inline ark_slot _SF(double v){ark_slot s; s.f=v; return s;}\n\n");

    /* 浮点常量池 */
    {
        int i;
        for (i = 0; i < prog->float_count; i++) {
            char fbuf[64]; int n = 0;
            double v = prog->floats[i];
            int neg = 0;
            asmbuf_puts(&buf, "static const double ark_flt_");
            asmbuf_int(&buf, i);
            asmbuf_puts(&buf, " = ");
            if (v < 0) { neg = 1; v = -v; }
            if (neg) asmbuf_putc(&buf, '-');
            {
                long long ip = (long long)v;
                char tmp[24]; int tn = 0; int k;
                if (ip == 0) tmp[tn++] = '0';
                while (ip > 0) { tmp[tn++] = (char)('0' + ip % 10); ip /= 10; }
                for (k = tn - 1; k >= 0; k--) fbuf[n++] = tmp[k];
            }
            fbuf[n++] = '.';
            {
                double f = v - (double)((long long)v);
                int k;
                for (k = 0; k < 9; k++) {
                    f *= 10.0;
                    {
                        int d = (int)f;
                        if (d > 9) d = 9;
                        fbuf[n++] = (char)('0' + d);
                        f -= (double)d;
                    }
                }
            }
            fbuf[n] = 0;
            asmbuf_puts(&buf, fbuf);
            asmbuf_puts(&buf, ";\n");
        }
        if (prog->float_count) asmbuf_putc(&buf, '\n');
    }

    /* 字符串池 */
    {
        int i;
        for (i = 0; i < prog->string_count; i++) {
            IrString *s = prog->strings[i];
#if ARKCC_FEATURE_WCHAR
            if (s->is_wide) {
                /* B2: 宽字符串。发射为 wchar_t 数组 + L"..." 字面量，
                 * gcc 按宽字符编码填充。元素类型透传 wchar_t。 */
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

    /* 全局变量 */
    {
        int i;
        for (i = 0; i < prog->global_count; i++) {
            IrGlobal *g = prog->globals[i];
            int is_aggregate = (g->init_aggregate != 0) ||
                               c_type_is_aggregate(g->type);
            /* 存储类 */
            if (g->is_extern) asmbuf_puts(&buf, "extern ");
            else if (g->is_static) asmbuf_puts(&buf, "static ");
#if ARKCC_FEATURE_ARMCC_KEYWORDS
            /* __thread：线程局部存储，透传给 gcc（host 上由 gcc/libpthread 处理） */
            if (g->is_tls && !g->is_extern) asmbuf_puts(&buf, "__thread ");
#endif
            /* const 限定符：让 gcc 把全局放到 .rodata 段 */
            if (g->is_const && !g->is_extern) asmbuf_puts(&buf, "const ");
            /* 类型 + 名字（含数组维度、指针 * 等） */
            emit_c_type(&buf, g->type, g->name);
            /* 强制对齐：__attribute__((aligned(n))) */
            if (g->align_bytes > 0 && !g->is_extern) {
                asmbuf_puts(&buf, " __attribute__((aligned(");
                asmbuf_int(&buf, g->align_bytes);
                asmbuf_puts(&buf, ")))");
            }
            /* used/unused：透传给 gcc */
            if (g->is_used && !g->is_extern)   asmbuf_puts(&buf, " __attribute__((used))");
            if (g->is_unused && !g->is_extern) asmbuf_puts(&buf, " __attribute__((unused))");
            /* __at(addr)：host 上无法真正放到指定物理地址；仅注释 */
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
            /* __global_reg(n)：host 上无法绑定全局寄存器；仅注释 */
            if (g->global_reg >= 0) {
                asmbuf_puts(&buf, " /* __global_reg(");
                asmbuf_int(&buf, g->global_reg);
                asmbuf_puts(&buf, ") */");
            }
#endif
            /* 自定义段：__attribute__((section("..."))) */
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
                            /* 输出 15 位小数，覆盖 IEEE 754 双精度有效位 */
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

    /* 函数原型 */
    {
        int i;
        for (i = 0; i < prog->func_count; i++) emit_func_proto(&buf, prog->funcs[i]);
        asmbuf_putc(&buf, '\n');
    }

    /* 跨翻译单元引用：扫描所有 IR_CALL，对"未在本 TU 定义"且"非 libc"的函数
     * 发出 extern 声明，便于把多个 .gen.c 一起喂给 gcc 链接（多文件场景）。 */
    {
        int ffi, ii, jj, emitted = 0;
        const char *seen[128];  /* 已输出过 extern 的函数名，去重 */
        for (ffi = 0; ffi < prog->func_count; ffi++) {
            IrFunc *f = prog->funcs[ffi];
            for (ii = 0; ii < f->code_count; ii++) {
                IrInst *I = &f->code[ii];
                if (I->op != IR_CALL || !I->name) continue;
                if (is_libc_func(I->name)) continue;
                /* 本 TU 已定义？定义由上面 emit_func_proto 处理，跳过 */
                {
                    int defined = 0;
                    for (jj = 0; jj < prog->func_count; jj++) {
                        if (ark_streq(prog->funcs[jj]->name, I->name)) { defined = 1; break; }
                    }
                    if (defined) continue;
                }
                /* 去重 */
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

    /* 函数体 */
    for (fi = 0; fi < prog->func_count; fi++) {
        IrFunc *f = prog->funcs[fi];
        int i;
        if (ark_streq(f->name, "main")) main_idx = fi;

        /* alias 声明：原型已带 __attribute__((alias(...)))，无需函数体 */
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
        /* --split_sections/-ffunction-sections：每函数独立段，透传给 gcc */
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
            /* __asm 整函数体：把原始汇编文本透传到 __asm__ 块。
             * naked 属性保证 gcc 不生成 prologue/epilogue。
             * 函数体内不能写 return（与 naked 不兼容）。 */
            asmbuf_puts(&buf, "    __asm__ __volatile__(\n");
            {
                const char *s = f->asm_body ? f->asm_body : "";
                int sl = ark_strlen(s);
                /* 把多行 asm 文本按行包装到带引号的 C 字符串。 */
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
        asmbuf_puts(&buf, "    /* 抑制未用参数警告 */\n");
        asmbuf_puts(&buf, "    (void)a0; (void)a1; (void)a2; (void)a3;\n");
        asmbuf_puts(&buf, "    (void)a4; (void)a5; (void)a6; (void)a7;\n");
        asmbuf_puts(&buf, "    static char frame[4096];\n");
        asmbuf_puts(&buf, "    ark_slot stk[256]; int sp = 0; long long a, c; long long addr; long long es;\n");
        asmbuf_puts(&buf, "    double fa, fc; (void)fa; (void)fc;\n");
        asmbuf_puts(&buf, "    (void)addr; (void)es; (void)frame; (void)a; (void)c;\n");

        for (i = 0; i < f->code_count; i++) {
            IrInst *I = &f->code[i];
            asmbuf_puts(&buf, "    ");
            switch (I->op) {
                case IR_FUNC_BEGIN:
                case IR_FUNC_END:
                    asmbuf_puts(&buf, "/* fn boundary */");
                    break;
                case IR_GETARG: {
                    /* 把第 aux 个参数写入 frame[val..val+8] */
                    asmbuf_puts(&buf, "*(long long*)(frame + ");
                    asmbuf_int(&buf, I->val);
                    asmbuf_puts(&buf, ") = a");
                    asmbuf_int(&buf, I->aux);
                    asmbuf_putc(&buf, ';');
                    break;
                }
                case IR_PUSH_INT:
                    asmbuf_puts(&buf, "stk[sp++].i = ");
                    asmbuf_int(&buf, I->val);
                    asmbuf_puts(&buf, "LL;");
                    break;
                case IR_PUSH_FLOAT:
                    asmbuf_puts(&buf, "stk[sp++].f = ark_flt_");
                    asmbuf_int(&buf, I->val);
                    asmbuf_puts(&buf, ";");
                    break;
                case IR_PUSH_STR: {
                    /* B2: 宽字符串引用 ark_wstr_<id>，普通字符串引用 ark_str_<id> */
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
                    /* B3: VLA 动态分配。弹栈取字节数，alloca 分配，压入首地址。 */
                    asmbuf_puts(&buf, "stk[sp-1].i = (long long)(intptr_t)alloca((size_t)stk[sp-1].i);");
                    break;
                case IR_PUSH_VAR:
                    asmbuf_puts(&buf, "stk[sp++].i = *(long long*)(frame + ");
                    asmbuf_int(&buf, I->val);
                    asmbuf_puts(&buf, ");");
                    break;
                case IR_PUSH_ADDR:
                    asmbuf_puts(&buf, "stk[sp++].i = (long long)(intptr_t)(frame + ");
                    asmbuf_int(&buf, I->val);
                    asmbuf_puts(&buf, ");");
                    break;
                case IR_PUSH_GLOBAL: {
                    /* 标量全局：直接取值；聚合全局（数组/结构体）取其首地址。
                     * 浮点全局（float/double）走 .f 路径，避免 (long long)pi
                     * 把浮点值整数截断为 3 这种位模式破坏。
                     * 通过查 prog->globals 判断类型。 */
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
                    /* 取全局变量地址（不加载值）：发地址给后端 */
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
                case IR_STORE:
                    asmbuf_puts(&buf, "*(long long*)(frame + ");
                    asmbuf_int(&buf, I->val);
                    asmbuf_puts(&buf, ") = stk[--sp].i;");
                    break;
                case IR_LOAD_IDX:
                    asmbuf_puts(&buf, "{ long long ix = stk[--sp].i; long long ad = stk[--sp].i; es = ");
                    asmbuf_int(&buf, I->val);
                    asmbuf_puts(&buf, "; if (es==1) stk[sp++].i = *(signed char*)(intptr_t)(ad + ix);");
                    asmbuf_puts(&buf, " else stk[sp++].i = *(int*)(intptr_t)(ad + ix*es); }");
                    break;
                case IR_STORE_IDX:
                    asmbuf_puts(&buf, "{ long long va = stk[--sp].i; long long ad = stk[--sp].i; es = ");
                    asmbuf_int(&buf, I->val);
                    asmbuf_puts(&buf, "; if (es==1) *(char*)(intptr_t)ad = (char)va;");
                    asmbuf_puts(&buf, " else *(int*)(intptr_t)ad = (int)va;");
                    asmbuf_puts(&buf, " stk[sp++].i = va; }");
                    break;
                case IR_BINARY:
                    asmbuf_puts(&buf, "c = stk[--sp].i; a = stk[--sp].i; stk[sp++].i = ");
                    emit_binop(&buf, I->aux);
                    asmbuf_putc(&buf, ';');
                    break;
                case IR_FADD:
                    asmbuf_puts(&buf, "fc = stk[--sp].f; fa = stk[--sp].f; stk[sp++].f = fa + fc;");
                    break;
                case IR_FSUB:
                    asmbuf_puts(&buf, "fc = stk[--sp].f; fa = stk[--sp].f; stk[sp++].f = fa - fc;");
                    break;
                case IR_FMUL:
                    asmbuf_puts(&buf, "fc = stk[--sp].f; fa = stk[--sp].f; stk[sp++].f = fa * fc;");
                    break;
                case IR_FDIV:
                    asmbuf_puts(&buf, "fc = stk[--sp].f; fa = stk[--sp].f; stk[sp++].f = (fc!=0.0) ? (fa / fc) : 0.0;");
                    break;
                case IR_FCMP: {
                    /* 屏蔽 aux 高位标志（0x200=double 精度），取比较运算符。
                     * C 后端用 double 存储，float/double 行为一致，无需区分精度。 */
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
                    asmbuf_puts(&buf, "fc = stk[--sp].f; fa = stk[--sp].f; stk[sp++].i = (fa ");
                    asmbuf_puts(&buf, cop);
                    asmbuf_puts(&buf, " fc) ? 1 : 0;");
                    break;
                }
                case IR_F2I:
                    asmbuf_puts(&buf, "fa = stk[--sp].f; stk[sp++].i = (long long)fa;");
                    break;
                case IR_I2F:
                    asmbuf_puts(&buf, "a = stk[--sp].i; stk[sp++].f = (double)a;");
                    break;
                case IR_ASM:
                    /* '@' 前缀表示扩展形式：紧跟 `"text" : outputs : inputs : clobbers`，
                     * 此时直接以括号包裹原文输出给 gcc 处理操作数。
                     * 否则按旧式 IR_ASM 处理（单段模板，需自行加引号）。 */
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
                    asmbuf_puts(&buf, "a = stk[--sp].i; stk[sp++].i = ");
                    if (op == (int)TOK_MINUS) asmbuf_puts(&buf, "(-a)");
                    else if (op == (int)TOK_BNOT) asmbuf_puts(&buf, "(~a)");
                    else if (op == (int)TOK_NOT)  asmbuf_puts(&buf, "(!a)");
                    else asmbuf_puts(&buf, "(a)");
                    asmbuf_putc(&buf, ';');
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
                    asmbuf_puts(&buf, "a = stk[--sp].i; if (!a) goto L_");
                    asmbuf_int(&buf, I->val);
                    asmbuf_putc(&buf, ';');
                    break;
                case IR_JNZ:
                    asmbuf_puts(&buf, "a = stk[--sp].i; if (a) goto L_");
                    asmbuf_int(&buf, I->val);
                    asmbuf_putc(&buf, ';');
                    break;
                case IR_CMP_JMP_EQ:
                    asmbuf_puts(&buf, "a = stk[sp-1].i; if (a == ");
                    asmbuf_int(&buf, I->val);
                    asmbuf_puts(&buf, ") { --sp; goto L_");
                    asmbuf_int(&buf, I->aux);
                    asmbuf_puts(&buf, "; }");
                    break;
                case IR_CALL: {
                    int n = I->val;
                    int k;
                    /* 弹出 n 个参数（栈顶顺序 = arg0..argN-1）。
                     * aa[] 标记为 volatile：强制 gcc 把每槽值真正落到内存，
                     * 避免 -O2 在 union(ark_slot) 类型双关 + 变参 printf 场景下
                     * 误优化掉指针参数（表现为 %s 输出 (null)）。 */
                    asmbuf_puts(&buf, "{ long long volatile aa[8] = {0,0,0,0,0,0,0,0}; ");
                    if (n > MAX_CALL_ARGS) n = MAX_CALL_ARGS;
                    for (k = 0; k < n; k++) {
                        asmbuf_puts(&buf, "aa[");
                        asmbuf_int(&buf, k);
                        asmbuf_puts(&buf, "] = stk[--sp].i; ");
                    }
                    /* 路由：内置 libc 函数走 host libc；其他走 ark_ 前缀 */
                    if (ark_streq(I->name, "printf")) {
                        /* printf 是变参函数。参数槽以 long long(8B) 统一存储；
                         * 这里用 (intptr_t) 把每个参数转成"指针大小"传给 printf：
                         *   - 64 位宿主：intptr_t=8B，与变参 8B 槽位一致，
                         *     %d 读取低 4 位、%s/%p 读取完整 8 位指针，均正确。
                         *   - 32 位宿主：intptr_t=4B，与 int/指针尺寸一致。
                         * 旧实现用 (int) 截断，在 64 位宿主上会丢失指针高 32 位，
                         *  导致 %s 输出 (null)。 */
                        asmbuf_puts(&buf,
                            "stk[sp++].i = printf((const char*)(intptr_t)aa[0],"
                            "(intptr_t)aa[1],(intptr_t)aa[2],(intptr_t)aa[3],"
                            "(intptr_t)aa[4],(intptr_t)aa[5],(intptr_t)aa[6],(intptr_t)aa[7]);");
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
                        /* setjmp：路由到宿主 setjmp（.gen.c 已 #include <setjmp.h>）。
                         * 上层 jmp_buf（int[20]=80B）经指针重解释为宿主 jmp_buf；
                         * 宿主 jmp_buf 尺寸 <= 80B，缓冲区足够。返回值 0/val。 */
                        asmbuf_puts(&buf,
                            "stk[sp++].i = setjmp(*(jmp_buf*)(void*)(intptr_t)aa[0]);");
                    } else if (ark_streq(I->name, "longjmp")) {
                        /* longjmp：不返回；后面的 push 为死代码，gcc -O2 会消除。
                         * val==0 按 C 标准改为 1。 */
                        asmbuf_puts(&buf,
                            "longjmp(*(jmp_buf*)(void*)(intptr_t)aa[0], (int)aa[1] ? (int)aa[1] : 1); stk[sp++].i = 0;");
                    } else {
                        asmbuf_puts(&buf, "stk[sp++].i = ark_");
                        asmbuf_puts(&buf, I->name);
                        asmbuf_puts(&buf,
                            "(aa[0],aa[1],aa[2],aa[3],aa[4],aa[5],aa[6],aa[7]);");
                    }
                    asmbuf_puts(&buf, " }");
                    break;
                }
                case IR_SVC: {
                    /* __svc(n) — C 后端：非 ARM 平台当作 no-op（参数原样返回） */
                    int svc_n = I->val;
                    (void)svc_n;
                    asmbuf_puts(&buf, "{ long long _svc_arg = stk[--sp].i; ");
                    asmbuf_puts(&buf, "/* SVC #");
                    asmbuf_int(&buf, svc_n);
                    asmbuf_puts(&buf, " (no-op on host) */ ");
                    asmbuf_puts(&buf, "stk[sp++].i = _svc_arg; }");
                    break;
                }
                /* === 整数除法/取模：aux=0 有符号, aux=1 无符号 === */
                case IR_DIV:
                    asmbuf_puts(&buf, "c = stk[--sp].i; a = stk[--sp].i; stk[sp++].i = (");
                    if (I->aux) asmbuf_puts(&buf, "(unsigned)a / (unsigned)c");
                    else        asmbuf_puts(&buf, "a / c");
                    asmbuf_puts(&buf, ");");
                    break;
                case IR_MOD:
                    asmbuf_puts(&buf, "c = stk[--sp].i; a = stk[--sp].i; stk[sp++].i = (");
                    if (I->aux) asmbuf_puts(&buf, "(unsigned)a % (unsigned)c");
                    else        asmbuf_puts(&buf, "a % c");
                    asmbuf_puts(&buf, ");");
                    break;
                /* === 64 位运算：C 后端用单个 long long 槽位 === */
                case IR_64PUSH:
                    /* val=高32位, aux=低32位；拼成单个 long long 入栈 */
                    asmbuf_puts(&buf, "stk[sp++].i = ((long long)(unsigned)");
                    asmbuf_int(&buf, I->val);
                    asmbuf_puts(&buf, " << 32) | (unsigned)");
                    asmbuf_int(&buf, I->aux);
                    asmbuf_puts(&buf, ";");
                    break;
                case IR_64BINARY:
                    /* 与 IR_BINARY 同：a/c 已是 long long，运算即 64 位 */
                    asmbuf_puts(&buf, "c = stk[--sp].i; a = stk[--sp].i; stk[sp++].i = ");
                    emit_binop(&buf, I->aux);
                    asmbuf_putc(&buf, ';');
                    break;
                case IR_64CMP: {
                    int op = I->aux;
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
                    asmbuf_puts(&buf, "c = stk[--sp].i; a = stk[--sp].i; stk[sp++].i = (a ");
                    asmbuf_puts(&buf, cop);
                    asmbuf_puts(&buf, " c) ? 1 : 0;");
                    break;
                }
                /* === 内存拷贝：栈顶=dst, 次顶=src === */
                case IR_MEMCPY:
                    asmbuf_puts(&buf, "{ long long _dst = stk[--sp].i; long long _src = stk[--sp].i; memcpy((void*)(intptr_t)_dst, (void*)(intptr_t)_src, (size_t)");
                    asmbuf_int(&buf, I->val);
                    asmbuf_puts(&buf, "); }");
                    break;
                /* === 位域存储/读取：val=位偏移, aux=位宽 === */
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
                case IR_RETURN:
                    asmbuf_puts(&buf, "return (long long)stk[--sp].i;");
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
        asmbuf_puts(&buf, "    (void)argc; (void)argv;\n");
        asmbuf_puts(&buf, "    return (int)ark_main(0,0,0,0,0,0,0,0);\n}\n");
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
    /* C 后端不做二进制汇编：把生成的源码原样作为"字节"输出，
     * 由上层 -o 命令写到 .c 文件后即可被 gcc 编译。 */
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
