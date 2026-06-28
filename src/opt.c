/* Ark C Compiler - opt
 * IR 级优化 Pass：常量折叠 + 死代码消除 + 自动内联 + 自动向量化。
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
#include "memory.h"

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
#if ARKCC_FEATURE_OPT_INLINE
    if (g_config.enable_opt_inline || level >= 2) {
        opt_inline(prog);
        /* 内联后重新 DCE：被内联函数体留下的 NOP、不可达路径需清理 */
        if (g_config.enable_opt_dce || level >= 1) {
            for (i = 0; i < prog->func_count; i++) {
                opt_dce_func(prog->funcs[i]);
            }
        }
    }
#endif
#if ARKCC_FEATURE_OPT_VECTORIZE
    if (g_config.enable_opt_vectorize || level >= 2) {
        opt_vectorize(prog);
    }
#endif
}

/* =====================================================================
 * 自动内联（--autoinline / -O2）
 * =====================================================================
 *
 * 算法概览：
 *   1. 第一趟：扫描每个函数的 IR，统计"有效指令数"（排除 FUNC_BEGIN/
 *      FUNC_END/LABEL/NOP），并检查是否递归调用自身。构建可内联候选表。
 *      可内联条件（全部满足）：
 *        - 指令数 ≤ ARK_INLINE_THRESHOLD（forceinline 跳过此检查）
 *        - param_count ≤ 4
 *        - 非 variadic / irq / naked / asm_func / constructor / destructor
 *        - 不递归调用自身
 *   2. 第二趟：对每个函数的 IR 扫描 IR_CALL；若被调函数在候选表中且不是
 *      自身，则执行内联替换。
 *   3. 内联替换通过构造新的 code[] 完成（避免 memmove）：
 *        - 在调用点先发 n 条 IR_STORE(temp_off_j)，把 n 个栈上参数弹入
 *          临时局部变量（temp_off_j = caller.local_size + j*4）。
 *        - 复制被调函数体（FUNC_BEGIN..FUNC_END 之间）：
 *            * 局部偏移 += L1（L1 = caller.local_size + n*4）
 *            * IR_GETARG(callee_off, j) → IR_PUSH_VAR(temp_off_j);
 *              IR_STORE(L1 + callee_off)
 *            * IR_RETURN → IR_JMP(end_label)
 *            * IR_LABEL/IR_JMP/IR_JZ/IR_JNZ 标签号 += caller.label_count
 *            * IR_FUNC_BEGIN/IR_FUNC_END → IR_NOP
 *        - 末尾发 IR_LABEL(end_label)
 *        - 更新 caller.local_size = L1 + callee.local_size
 *        - 更新 caller.label_count = end_label + 1
 *      栈平衡：原 IR_CALL 弹 n 个参数、压 1 个返回值；内联后 n 个 STORE
 *      弹 n 个参数，被调函数体在 IR_RETURN 前已压返回值（IR_JMP 不动栈），
 *      末尾 LABEL 不动栈，净效果一致。
 *   4. 内联后由 opt_run 调用 opt_dce_func 清理不可达代码。
 */
#define ARK_INLINE_THRESHOLD 12

typedef struct {
    IrFunc *func;
    int inst_count;
    int can_inline;
} InlineCandidate;

/* 统计函数有效指令数（排除 FUNC_BEGIN/FUNC_END/LABEL/NOP），
 * 并检测是否递归调用自身。返回 1=递归，0=非递归。 */
static int count_insts_and_check_recursion(IrFunc *f, int *out_count) {
    int i;
    int n = 0;
    int recursive = 0;
    for (i = 0; i < f->code_count; i++) {
        IrOp op = f->code[i].op;
        if (op == IR_FUNC_BEGIN || op == IR_FUNC_END ||
            op == IR_LABEL || op == IR_NOP) continue;
        if (op == IR_CALL && f->code[i].name &&
            ark_streq(f->code[i].name, f->name)) {
            recursive = 1;
        }
        n++;
    }
    *out_count = n;
    return recursive;
}

void opt_inline(IrProgram *prog) {
    int i, j, k;
    InlineCandidate *cands;
    if (!prog || prog->func_count == 0) return;

    /* 1. 构建候选表 */
    cands = (InlineCandidate *)mem_pool_alloc(
        (int)sizeof(InlineCandidate) * prog->func_count);
    for (i = 0; i < prog->func_count; i++) {
        IrFunc *f = prog->funcs[i];
        int cnt = 0;
        int recursive = count_insts_and_check_recursion(f, &cnt);
        cands[i].func = f;
        cands[i].inst_count = cnt;
        cands[i].can_inline = 0;
        if (recursive) continue;
        if (f->is_variadic) continue;
        if (f->is_irq || f->is_naked || f->is_asm_func) continue;
        if (f->is_constructor || f->is_destructor) continue;
        if (f->param_count > 4) continue;
        if (f->forceinline) {
            cands[i].can_inline = 1;  /* forceinline 跳过大小检查 */
        } else if (cnt <= ARK_INLINE_THRESHOLD) {
            cands[i].can_inline = 1;
        }
    }

    /* 2. 对每个函数扫描 IR_CALL，执行内联 */
    for (i = 0; i < prog->func_count; i++) {
        IrFunc *caller = prog->funcs[i];
        int new_cap;
        int new_count = 0;
        IrInst *new_code;
        int has_site = 0;

        /* 先确认有可内联调用点，否则跳过 */
        for (j = 0; j < caller->code_count; j++) {
            IrInst *I = &caller->code[j];
            if (I->op != IR_CALL) continue;
            for (k = 0; k < prog->func_count; k++) {
                if (cands[k].can_inline && I->name &&
                    ark_streq(I->name, cands[k].func->name) &&
                    !ark_streq(cands[k].func->name, caller->name)) {
                    has_site = 1;
                    break;
                }
            }
            if (has_site) break;
        }
        if (!has_site) continue;

        /* 预估容量：原 code + 每个内联点 (n_args + callee_code*2 + 4) */
        new_cap = caller->code_count + 64;
        for (j = 0; j < caller->code_count; j++) {
            IrInst *I = &caller->code[j];
            if (I->op != IR_CALL) continue;
            for (k = 0; k < prog->func_count; k++) {
                if (cands[k].can_inline && I->name &&
                    ark_streq(I->name, cands[k].func->name) &&
                    !ark_streq(cands[k].func->name, caller->name)) {
                    IrFunc *callee = cands[k].func;
                    new_cap += I->val + callee->code_count * 2 + 8;
                    break;
                }
            }
        }
        new_code = (IrInst *)mem_pool_alloc((int)sizeof(IrInst) * new_cap);

        for (j = 0; j < caller->code_count; j++) {
            IrInst *I = &caller->code[j];
            IrFunc *callee = 0;
            int n_args, L0, L1, end_label;
            int body_begin = -1, body_end = -1;
            if (I->op != IR_CALL) {
                new_code[new_count++] = *I;
                continue;
            }
            /* 查找可内联的被调函数 */
            for (k = 0; k < prog->func_count; k++) {
                if (cands[k].can_inline && I->name &&
                    ark_streq(I->name, cands[k].func->name) &&
                    !ark_streq(cands[k].func->name, caller->name)) {
                    callee = cands[k].func;
                    break;
                }
            }
            if (!callee) {
                new_code[new_count++] = *I;
                continue;
            }

            n_args = I->val;
            if (n_args < 0) n_args = 0;
            if (n_args > 4) n_args = 4;  /* AAPCS：前 4 个走 r0-r3 */
            L0 = caller->local_size;
            L1 = L0 + n_args * 4;
            end_label = caller->label_count + callee->label_count;

            /* 定位被调函数体边界（FUNC_BEGIN..FUNC_END 之间） */
            for (k = 0; k < callee->code_count; k++) {
                if (callee->code[k].op == IR_FUNC_BEGIN) {
                    body_begin = k + 1;
                } else if (callee->code[k].op == IR_FUNC_END) {
                    body_end = k;
                    break;
                }
            }
            if (body_begin < 0 || body_end < 0) {
                /* 异常：被调函数结构不完整，放弃内联 */
                new_code[new_count++] = *I;
                continue;
            }

            /* a. 发 n 条 IR_STORE(temp_off_j)：把栈顶 n 个参数弹入临时局部 */
            for (k = 0; k < n_args; k++) {
                IrInst *s = &new_code[new_count++];
                s->op = IR_STORE;
                s->val = L0 + k * 4;  /* temp_off_k：arg0 在栈顶 */
                s->name = 0;
                s->aux = 0;
                s->line = I->line;
            }

            /* b. 复制被调函数体，做偏移/标签/GETARG/RETURN 变换 */
            for (k = body_begin; k < body_end; k++) {
                IrInst *src = &callee->code[k];
                IrInst *dst = &new_code[new_count++];
                *dst = *src;
                switch (src->op) {
                    case IR_STORE:
                    case IR_PUSH_VAR:
                    case IR_PUSH_ADDR:
                    case IR_LOCAL_ALLOC:
                        dst->val = src->val + L1;
                        break;
                    case IR_GETARG: {
                        /* 原语义：把 r{j} 存入 callee 局部 off。
                         * 内联后：从 temp_off_j 加载，再存到 L1+off。 */
                        int callee_off = src->val;
                        int arg_j = src->aux;
                        dst->op = IR_PUSH_VAR;
                        dst->val = L0 + arg_j * 4;
                        dst->name = 0;
                        dst->aux = 0;
                        {
                            IrInst *st = &new_code[new_count++];
                            st->op = IR_STORE;
                            st->val = L1 + callee_off;
                            st->name = 0;
                            st->aux = 0;
                            st->line = src->line;
                        }
                        break;
                    }
                    case IR_RETURN:
                        /* 返回值已在栈顶（来自前一条 push），
                         * 替换为跳转到 end_label。 */
                        dst->op = IR_JMP;
                        dst->val = end_label;
                        dst->name = 0;
                        dst->aux = 0;
                        break;
                    case IR_LABEL:
                    case IR_JMP:
                    case IR_JZ:
                    case IR_JNZ:
                        dst->val = src->val + caller->label_count;
                        break;
                    case IR_FUNC_BEGIN:
                    case IR_FUNC_END:
                        dst->op = IR_NOP;
                        break;
                    default:
                        /* 其余指令原样复制 */
                        break;
                }
            }

            /* c. 末尾发 IR_LABEL(end_label) */
            {
                IrInst *l = &new_code[new_count++];
                l->op = IR_LABEL;
                l->val = end_label;
                l->name = 0;
                l->aux = 0;
                l->line = I->line;
            }

            /* 更新 caller 状态 */
            caller->local_size = L1 + callee->local_size;
            caller->label_count = end_label + 1;
        }

        /* 替换 caller 的 code 数组 */
        caller->code = new_code;
        caller->code_count = new_count;
        caller->code_capacity = new_cap;
    }
}

/* =====================================================================
 * 自动向量化（--vectorize / -O2）
 * =====================================================================
 *
 * 简化策略：只处理最简单的 for 计数循环，循环体为 "c[i] = a[i] ± b[i]"
 * 或 "c[i] = a[i] ± K" 模式。元素大小 es ∈ {1, 2}：
 *   - es == 2 (short) → SIMD 宽度 W = 2，使用 IR_SIMD_ADD16/SUB16
 *   - es == 1 (char)  → SIMD 宽度 W = 4，使用 IR_SIMD_ADD8/SUB8
 *
 * 识别的 IR 模式（caller 函数中）：
 *   init:    PUSH_INT 0; STORE <i_off>; [PUSH_VAR i; POP]   (i = 0)
 *   LABEL <start_l>
 *   cond:    PUSH_VAR <i_off>; PUSH_INT N; BINARY <LT>; JZ <end_l>
 *   body:    ... 包含 LOAD_IDX es / STORE_IDX es / BINARY ± ...
 *   LABEL <cont_l>
 *   step:    ... PUSH_INT 1; BINARY PLUS; STORE <i_off> ...   (i++)
 *   JMP <start_l>
 *   LABEL <end_l>
 *
 * 变换：
 *   - 步长 PUSH_INT 1 → PUSH_INT W
 *   - 循环体中 LOAD_IDX es → LOAD_IDX (es * W)（一次加载 W*es 字节）
 *   - 循环体中 STORE_IDX es → STORE_IDX (es * W)
 *   - 循环体中合并两个 LOAD_IDX 的 BINARY ± → IR_SIMD_ADD16/SUB16/ADD8/SUB8
 *
 * 安全检查：
 *   - 循环上界 N 必须是常量且 N % W == 0（否则跳过，不生成余数循环）
 *   - 循环体只有一个基本块（在 start_l..cont_l 之间无嵌套 LABEL）
 *   - 循环体内无函数调用（IR_CALL）、无 IR_RETURN
 *   - 循环体中 LOAD_IDX/STORE_IDX 的 es 一致，且合并运算符是 + 或 -
 */

/* 在 [start, end) 范围内查找 IR_CALL / IR_RETURN / 嵌套 LABEL */
static int body_has_unsafe_op(IrFunc *f, int start, int end) {
    int i;
    for (i = start; i < end; i++) {
        IrOp op = f->code[i].op;
        if (op == IR_CALL || op == IR_RETURN) return 1;
        if (op == IR_LABEL || op == IR_LABEL_NAMED) return 1;
    }
    return 0;
}

/* 在 body 范围内识别向量化模式：
 *   ... LOAD_IDX es ... LOAD_IDX es ... BINARY ± ... STORE_IDX es ...
 * 找到匹配则填充 *es_out, *op_out (TOK_PLUS/TOK_MINUS)，
 * 以及 load_idx1, load_idx2, binary_idx, store_idx 在 code[] 中的索引。
 * 返回 1=匹配，0=不匹配。 */
static int match_vectorize_body(IrFunc *f, int body_start, int body_end,
                                int *es_out, int *op_out,
                                int *load1_idx, int *load2_idx,
                                int *binary_idx, int *store_idx) {
    int i;
    int li1 = -1, li2 = -1, bi = -1, si = -1;
    int es = 0;
    int op = 0;
    int count_load = 0;
    int count_store = 0;
    for (i = body_start; i < body_end; i++) {
        IrInst *I = &f->code[i];
        if (I->op == IR_LOAD_IDX) {
            if (count_load == 0) {
                li1 = i;
                es = I->val;
            } else if (count_load == 1) {
                li2 = i;
                if (I->val != es) return 0;  /* 元素大小不一致 */
            } else {
                return 0;  /* 超过 2 个 LOAD_IDX */
            }
            count_load++;
        } else if (I->op == IR_STORE_IDX) {
            if (count_store > 0) return 0;  /* 超过 1 个 STORE_IDX */
            si = i;
            if (es != 0 && I->val != es) return 0;
            if (es == 0) es = I->val;
            count_store++;
        } else if (I->op == IR_BINARY && count_load >= 2) {
            /* 只有在两个 LOAD_IDX 之后的 BINARY ± 才是数据运算；
             * 在此之前的 BINARY ± 都是地址计算（&base + i*es），
             * 不应计入。模式：LOAD_IDX → LOAD_IDX → BINARY → STORE_IDX。 */
            int bop = I->aux & ~0x100;
            if (bop == (int)TOK_PLUS || bop == (int)TOK_MINUS) {
                if (bi >= 0) return 0;  /* 多个加减法 */
                bi = i;
                op = bop;
            }
        }
    }
    if (count_load != 2 || count_store != 1 || bi < 0) return 0;
    if (li2 < li1 || bi < li2 || si < bi) return 0;  /* 顺序错误 */
    if (es != 1 && es != 2) return 0;
    *es_out = es;
    *op_out = op;
    *load1_idx = li1;
    *load2_idx = li2;
    *binary_idx = bi;
    *store_idx = si;
    return 1;
}

void opt_vectorize(IrProgram *prog) {
    int fi, i;
    if (!prog) return;
    for (fi = 0; fi < prog->func_count; fi++) {
        IrFunc *f = prog->funcs[fi];
        int j;

        /* 扫描回边跳转：IR_JMP(val=lab) 跳转到更早的 IR_LABEL(val=lab) */
        for (j = 0; j < f->code_count; j++) {
            int start_lab = -1, end_lab = -1, cont_lab = -1;
            int start_lab_idx = -1, cont_lab_idx = -1;
            int body_start = -1, body_end = -1;
            int step_start = -1, step_end = -1;
            int i_off = -1;
            int N = -1;
            int es = 0, bop = 0;
            int li1 = -1, li2 = -1, bi = -1, si = -1;
            int W;
            IrOp simd_op;

            if (f->code[j].op != IR_JMP) continue;
            start_lab = f->code[j].val;

            /* 向前找 IR_LABEL(val=start_lab) */
            for (i = j - 1; i >= 0; i--) {
                if (f->code[i].op == IR_LABEL && f->code[i].val == start_lab) {
                    start_lab_idx = i;
                    break;
                }
            }
            if (start_lab_idx < 0) continue;

            /* 在 start_lab 之后找 IR_JZ <end_lab>（循环条件） */
            end_lab = -1;
            for (i = start_lab_idx + 1; i < j; i++) {
                if (f->code[i].op == IR_JZ) {
                    end_lab = f->code[i].val;
                    break;
                }
            }
            if (end_lab < 0) continue;

            /* cont_lab 是 body 之后、JMP 之前的 LABEL */
            for (i = j - 1; i > start_lab_idx; i--) {
                if (f->code[i].op == IR_LABEL) {
                    cont_lab = f->code[i].val;
                    cont_lab_idx = i;
                    break;
                }
            }
            if (cont_lab < 0) continue;
            if (cont_lab == end_lab) continue;  /* 无 body 的循环 */

            /* end_lab_idx = j + 1（应紧跟 JMP 后的 LABEL） */
            if (j + 1 >= f->code_count) continue;
            if (f->code[j + 1].op != IR_LABEL ||
                f->code[j + 1].val != end_lab) continue;

            body_start = start_lab_idx + 1;
            body_end = cont_lab_idx;
            step_start = cont_lab_idx + 1;
            step_end = j;

            /* 解析 cond：PUSH_VAR <i_off>; PUSH_INT N; BINARY <LT>; JZ end_lab */
            {
                /* 找到 JZ 的位置 */
                int jz_idx = -1;
                int k;
                for (k = start_lab_idx + 1; k < cont_lab_idx; k++) {
                    if (f->code[k].op == IR_JZ) { jz_idx = k; break; }
                }
                if (jz_idx < 0) continue;
                body_start = jz_idx + 1;
                /* 模式：PUSH_VAR i_off; PUSH_INT N; BINARY LT; JZ end_lab */
                if (jz_idx - 3 < start_lab_idx) continue;
                if (f->code[jz_idx - 3].op != IR_PUSH_VAR) continue;
                if (f->code[jz_idx - 2].op != IR_PUSH_INT) continue;
                if (f->code[jz_idx - 1].op != IR_BINARY) continue;
                {
                    int bop2 = f->code[jz_idx - 1].aux & ~0x100;
                    if (bop2 != (int)TOK_LT && bop2 != (int)TOK_LE &&
                        bop2 != (int)TOK_NE) continue;
                }
                i_off = f->code[jz_idx - 3].val;
                N = f->code[jz_idx - 2].val;
            }

            /* body 不能含 CALL/RETURN/嵌套 LABEL */
            if (body_has_unsafe_op(f, body_start, body_end)) continue;

            /* 匹配 body 模式 */
            if (!match_vectorize_body(f, body_start, body_end,
                                      &es, &bop, &li1, &li2, &bi, &si)) continue;

            /* 确定 SIMD 宽度和指令 */
            if (es == 2) {
                W = 2;
                simd_op = (bop == (int)TOK_PLUS) ? IR_SIMD_ADD16 : IR_SIMD_SUB16;
            } else {
                W = 4;
                simd_op = (bop == (int)TOK_PLUS) ? IR_SIMD_ADD8 : IR_SIMD_SUB8;
            }

            /* 检查 N % W == 0；否则跳过（简化：不生成余数循环） */
            if (N <= 0 || (N % W) != 0) continue;

            /* 找到 step 中的 PUSH_INT 1（步长增量）并校验后续是 BINARY PLUS; STORE i_off */
            {
                int found_step = 0;
                int k;
                for (k = step_start; k < step_end - 2; k++) {
                    if (f->code[k].op == IR_PUSH_INT &&
                        f->code[k].val == 1 &&
                        f->code[k + 1].op == IR_BINARY &&
                        (f->code[k + 1].aux & ~0x100) == (int)TOK_PLUS &&
                        f->code[k + 2].op == IR_STORE &&
                        f->code[k + 2].val == i_off) {
                        /* 修改步长为 W */
                        f->code[k].val = W;
                        found_step = 1;
                        break;
                    }
                }
                if (!found_step) continue;
            }

            /* 变换 body：
             *   - LOAD_IDX es → LOAD_IDX (es * W)
             *   - STORE_IDX es → STORE_IDX (es * W)
             *   - 中间合并的 BINARY ± → simd_op
             */
            f->code[li1].val = es * W;
            f->code[li2].val = es * W;
            f->code[si].val = es * W;
            f->code[bi].op = simd_op;
            f->code[bi].aux = 0;

            /* 继续扫描后续循环（j 已经被改写过，但 val 没变，可以继续）。
             * 注意：单趟扫描即可，因为内层已处理完该循环。 */
        }
    }
}
