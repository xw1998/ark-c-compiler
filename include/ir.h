/* Ark C Compiler - ir.h
 * 栈式四元式 IR。
 */
#ifndef ARK_IR_H
#define ARK_IR_H

#include "common.h"
#include "type.h"

typedef struct IrInst {
    IrOp  op;
    int   val;   /* 立即数/偏移/标签号 */
    char *name;  /* 变量名/函数名 */
    int   aux;   /* 辅助：BINARY 的具体运算符等 */
    int   line;  /* 源文件行号（来自 AST，供 DWARF .loc 使用）；0=未知 */
} IrInst;

/* irgen 在发射每条指令前设置该变量；ir_emit 会将其拷贝到 IrInst.line。
 * 非 irgen 路径（如手写 IR）保持 0，表示行号未知。 */
extern int g_ir_cur_line;

typedef struct IrFunc {
    char    *name;
    IrInst  *code;
    int      code_count;
    int      code_capacity;
    int      local_size;
    int      label_count;
    int      param_count;
    int      is_variadic;
    int      is_static;
    int      is_irq;       /* __irq 中断函数 */
    int      is_weak;      /* __weak 弱符号 */
    int      is_naked;     /* __naked 裸函数 */
    int      is_used;      /* __attribute__((used)) */
    int      is_unused;    /* __attribute__((unused)) */
    int      is_asm_func;  /* __asm 整函数体 */
    int      forceinline;  /* __forceinline */
    int      is_constructor; /* __attribute__((constructor)) */
    int      is_destructor;  /* __attribute__((destructor)) */
    int      is_deprecated;  /* __attribute__((deprecated)) */
    char    *alias_target; /* __attribute__((alias("xxx"))) */
    char    *asm_body;     /* __asm 函数体的原始汇编文本 */
    /* 0.6.x：armcc 5 兼容函数修饰符（多数仅语义标记） */
    int      is_value_in_regs; /* __value_in_regs */
    int      is_pure;          /* __pure / __attribute__((pure)) */
    int      is_const_attr;    /* __attribute__((const)) */
    int      is_interwork;     /* __interwork（静默忽略）*/
    int      smc_num;          /* __smc(n) 编号；-1=未使用 */
    int      global_reg;       /* __global_reg(n) 寄存器号；-1=未使用 */
    int      param_names_count;
    char   **param_names;
    Type   **param_types;
    Type    *ret_type;
} IrFunc;

typedef struct IrString {
    int    id;
    char  *data;
    int    len;
    int    is_wide;  /* B2: 宽字符串 L"..." 标记 */
} IrString;

typedef struct IrGlobal {
    char  *name;
    Type  *type;
    int    is_static;
    int    is_extern;
    /* 简单初始化器：对标量取 init_int；对字符串数组取 init_str；
     * 对结构体/数组的复杂聚合初始化暂不持久化，sema 完成后由 irgen 直接
     * 在 main 里运行时赋值（简化）。 */
    int     init_int;
    char   *init_str;
    int     has_init;
    /* 聚合初始化：保存原始 C 代码片段（含外层 {} ），由 C 后端直接透传 */
    char   *init_aggregate;
    /* 浮点初始化 */
    double  init_float;
    int     is_float;
    /* 段控制（透传给 C 后端的 __attribute__((section(...))) 字符串） */
    char   *section;
    /* 是否 const（用于 .rodata 选择） */
    int     is_const;
    /* __at(addr) 绝对地址；has_at=1 时 at_addr 有效 */
    unsigned at_addr;
    int     has_at;
    /* 强制对齐字节数；0=默认 */
    int     align_bytes;
    /* __attribute__((used/unused)) */
    int     is_used;
    int     is_unused;
    /* 0.6.x：TLS / 全局寄存器变量 */
    int     is_tls;       /* __thread 线程局部存储 */
    int     global_reg;   /* __global_reg(n) 寄存器号；-1=未使用 */
} IrGlobal;

typedef struct IrProgram {
    IrFunc   **funcs;
    int        func_count;
    IrString **strings;
    int        string_count;
    IrGlobal **globals;
    int        global_count;
    /* 浮点常量池 */
    double    *floats;
    int        float_count;
    int        float_capacity;
    /* 源文件路径（供 DWARF .file/.loc 使用）；NULL=未知 */
    const char *source_file;
} IrProgram;

IrFunc    *ir_func_new(const char *name);
void       ir_emit(IrFunc *f, IrOp op, int val, const char *name, int aux);
IrProgram *ir_program_new(void);
void       ir_program_add(IrProgram *prog, IrFunc *func);
int        ir_program_add_string(IrProgram *prog, const char *data, int len);
int        ir_program_add_float(IrProgram *prog, double v);
IrGlobal  *ir_program_add_global(IrProgram *prog, const char *name, Type *t);
const char *ir_op_name(IrOp op);

#endif /* ARK_IR_H */
