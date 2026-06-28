/* Ark C Compiler - opt
 * IR 级优化 Pass：常量折叠 + 死代码消除。
 *
 * 设计要点：
 *   - 栈式 IR 中 IR_PUSH_INT a; IR_PUSH_INT b; IR_BINARY op 三连可折叠为
 *     单条 IR_PUSH_INT (a op b)。折叠后把后两条标记为 IR_NOP，再统一压缩。
 *   - IR_BINARY 的 aux 低 8 位为 TOK_xxx 运算符，0x100 位为无符号标记。
 *   - 除零/模零不折叠（保留运行时行为）。
 *   - 死代码消除：IR_RETURN / IR_JMP / IR_JMP_NAMED 之后、下一个
 *     IR_LABEL / IR_LABEL_NAMED 之前的指令不可达，标记为 IR_NOP。
 *   - 多趟扫描直到不动点（或达到上限 8 趟），以级联折叠 (1+2*3)。
 *
 * 守护：
 *   - 编译期 #if ARKCC_FEATURE_OPT_CONSTFOLD / ARKCC_FEATURE_OPT_DCE
 *   - 运行时 g_config.enable_opt_constfold / enable_opt_dce
 */
#include "opt.h"
#include "config.h"
#include "arkcc_config.h"
#include "common.h"

/* 把 IR_NOP 占位压缩出 code[]，更新 code_count。 */
static void compact_func(IrFunc *f) {
    int i;
    int w = 0;
    for (i = 0; i < f->code_count; i++) {
        if (f->code[i].op != IR_NOP) {
            if (w != i) f->code[w] = f->code[i];
            w++;
        }
    }
    f->code_count = w;
}

/* 计算 a op b，返回 1 表示可折叠（结果写入 *out），0 表示不可折叠
 * （如除零）。aux 为 IR_BINARY 的 aux 字段（含符号位 0x100）。 */
static int eval_binary(int a, int b, int aux, int *out) {
    int is_unsigned = (aux & 0x100) != 0;
    int op = aux & ~0x100;
    int r = 0;
    switch (op) {
        case (int)TOK_PLUS:  r = a + b; break;
        case (int)TOK_MINUS: r = a - b; break;
        case (int)TOK_MUL:   r = a * b; break;
        case (int)TOK_DIV:
            if (b == 0) return 0;
            if (is_unsigned) r = (int)((unsigned)a / (unsigned)b);
            else r = a / b;
            break;
        case (int)TOK_MOD:
            if (b == 0) return 0;
            if (is_unsigned) r = (int)((unsigned)a % (unsigned)b);
            else r = a % b;
            break;
        case (int)TOK_BAND: r = a & b; break;
        case (int)TOK_BOR:  r = a | b; break;
        case (int)TOK_BXOR: r = a ^ b; break;
        case (int)TOK_SHL:  r = (int)((unsigned)a << (b & 31)); break;
        case (int)TOK_SHR:
            if (is_unsigned) r = (int)((unsigned)a >> (b & 31));
            else r = a >> (b & 31);
            break;
        case (int)TOK_EQ: r = (a == b) ? 1 : 0; break;
        case (int)TOK_NE: r = (a != b) ? 1 : 0; break;
        case (int)TOK_LT:
            r = is_unsigned ? (((unsigned)a <  (unsigned)b) ? 1 : 0)
                            : ((a <  b) ? 1 : 0);
            break;
        case (int)TOK_GT:
            r = is_unsigned ? (((unsigned)a >  (unsigned)b) ? 1 : 0)
                            : ((a >  b) ? 1 : 0);
            break;
        case (int)TOK_LE:
            r = is_unsigned ? (((unsigned)a <= (unsigned)b) ? 1 : 0)
                            : ((a <= b) ? 1 : 0);
            break;
        case (int)TOK_GE:
            r = is_unsigned ? (((unsigned)a >= (unsigned)b) ? 1 : 0)
                            : ((a >= b) ? 1 : 0);
            break;
        case (int)TOK_AND: r = (a && b) ? 1 : 0; break;
        case (int)TOK_OR:  r = (a || b) ? 1 : 0; break;
        default:
            return 0;  /* 未知运算符不折叠 */
    }
    *out = r;
    return 1;
}

void opt_constfold_func(IrFunc *f) {
    int changed = 1;
    int iter = 0;
    while (changed && iter < 8) {
        int i;
        changed = 0;
        iter++;
        for (i = 0; i + 2 < f->code_count; i++) {
            IrInst *a = &f->code[i];
            IrInst *b = &f->code[i + 1];
            IrInst *c = &f->code[i + 2];
            int result;
            if (a->op != IR_PUSH_INT) continue;
            if (b->op != IR_PUSH_INT) continue;
            if (c->op != IR_BINARY) continue;
            if (!eval_binary(a->val, b->val, c->aux, &result)) continue;
            /* 折叠：第一条改为结果，后两条置 NOP */
            a->val = result;
            b->op = IR_NOP;
            c->op = IR_NOP;
            changed = 1;
            /* 继续向后扫描（不回退也能在下一趟处理级联） */
        }
        if (changed) compact_func(f);
    }
}

void opt_dce_func(IrFunc *f) {
    int i;
    int unreachable = 0;
    for (i = 0; i < f->code_count; i++) {
        IrInst *I = &f->code[i];
        if (unreachable) {
            /* 遇到标签则恢复可达 */
            if (I->op == IR_LABEL || I->op == IR_LABEL_NAMED) {
                unreachable = 0;
                continue;
            }
            /* 不可达指令置 NOP（保留 FUNC_BEGIN/FUNC_END 不动） */
            if (I->op != IR_FUNC_BEGIN && I->op != IR_FUNC_END) {
                I->op = IR_NOP;
            }
            continue;
        }
        /* RETURN / 无条件跳转之后变为不可达 */
        if (I->op == IR_RETURN || I->op == IR_JMP || I->op == IR_JMP_NAMED) {
            unreachable = 1;
        }
    }
    compact_func(f);
}

void opt_run(IrProgram *prog, int level) {
    int i;
    if (!prog) return;
#if ARKCC_FEATURE_OPT_CONSTFOLD
    if (g_config.enable_opt_constfold || level >= 1) {
        for (i = 0; i < prog->func_count; i++) {
            opt_constfold_func(prog->funcs[i]);
        }
    }
#else
    (void)level;
#endif
#if ARKCC_FEATURE_OPT_DCE
    if (g_config.enable_opt_dce || level >= 1) {
        for (i = 0; i < prog->func_count; i++) {
            opt_dce_func(prog->funcs[i]);
        }
    }
#endif
}
