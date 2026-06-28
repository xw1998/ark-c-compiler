/* Ark C Compiler - type
 * 类型系统实现。多数复合类型走内存池分配。
 */
#include "type.h"
#include "memory.h"

static Type ty_void   = { TYPE_VOID,   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
static Type ty_char   = { TYPE_CHAR,   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
static Type ty_short  = { TYPE_SHORT,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
static Type ty_int    = { TYPE_INT,    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
static Type ty_long   = { TYPE_LONG,   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
static Type ty_llong  = { TYPE_LLONG,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
static Type ty_bool   = { TYPE_BOOL,   0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0 };
static Type ty_float  = { TYPE_FLOAT,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
static Type ty_double = { TYPE_DOUBLE, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
static Type ty_uchar  = { TYPE_CHAR,   0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0 };
static Type ty_ushort = { TYPE_SHORT,  0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0 };
static Type ty_uint   = { TYPE_INT,    0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0 };
static Type ty_ulong  = { TYPE_LONG,   0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0 };
static Type ty_ullong = { TYPE_LLONG,  0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0 };
/* B2: wchar_t —— 宿主/C 后端透传给 gcc，按 4 字节无符号整数处理 */
static Type ty_wchar  = { TYPE_WCHAR,  0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0 };

Type *type_void(void)   { return &ty_void;  }
Type *type_char(void)   { return &ty_char;  }
Type *type_short(void)  { return &ty_short; }
Type *type_int(void)    { return &ty_int;   }
Type *type_long(void)   { return &ty_long;  }
Type *type_llong(void)  { return &ty_llong; }
Type *type_bool(void)   { return &ty_bool;  }
Type *type_float(void)  { return &ty_float; }
Type *type_double(void) { return &ty_double;}
Type *type_uchar(void)  { return &ty_uchar; }
Type *type_ushort(void) { return &ty_ushort;}
Type *type_uint(void)   { return &ty_uint;  }
Type *type_ulong(void)  { return &ty_ulong; }
Type *type_ullong(void) { return &ty_ullong;}

Type *type_pointer(Type *base) {
    Type *t = (Type *)mem_pool_alloc(sizeof(Type));
    t->kind = TYPE_PTR;
    t->base = base;
    return t;
}

Type *type_array(Type *base, int size) {
    Type *t = (Type *)mem_pool_alloc(sizeof(Type));
    t->kind = TYPE_ARRAY;
    t->base = base;
    t->size = size;
    return t;
}

Type *type_struct(const char *tag, int is_union) {
    Type *t = (Type *)mem_pool_alloc(sizeof(Type));
    t->kind = is_union ? TYPE_UNION : TYPE_STRUCT;
    if (tag) t->tag = mem_strdup(tag);
    return t;
}

Type *type_enum(const char *tag) {
    Type *t = (Type *)mem_pool_alloc(sizeof(Type));
    t->kind = TYPE_ENUM;
    if (tag) t->tag = mem_strdup(tag);
    return t;
}

Type *type_func(Type *ret, Type **params, int pc, int variadic) {
    Type *t = (Type *)mem_pool_alloc(sizeof(Type));
    t->kind = TYPE_FUNC;
    t->base = ret;
    t->params = params;
    t->param_count = pc;
    t->is_variadic = variadic;
    return t;
}

/* B2: wchar_t —— 与宿主 int 同尺寸，4 字节无符号 */
Type *type_wchar(void) { return &ty_wchar; }

/* B4: _Complex —— base 指向 float/double；大小为 2*base */
Type *type_complex(Type *base) {
    Type *t = (Type *)mem_pool_alloc(sizeof(Type));
    t->kind = TYPE_COMPLEX;
    t->base = base;
    return t;
}

/* #pragma pack(n) 全局对齐控制：>0 时限制结构体字段自然对齐不超过此值。
 * 0 表示恢复默认（按各字段自然对齐）。 */
static int g_pack_align = 0;

void type_set_pack(int n) { g_pack_align = n; }
int  type_get_pack(void)  { return g_pack_align; }

void type_struct_add_field(Type *st, const char *name, Type *ft) {
    StructField *f = (StructField *)mem_pool_alloc(sizeof(StructField));
    int al = type_align(ft);
    int fs = type_size(ft);
    int cur = st->size;
    int pack_val = 0;
    int is_flex = 0;  /* 柔性数组成员：ft 是 size==0 的数组，不计入 sizeof */
    /* #pragma pack 与 __attribute__((packed)) 都会收紧对齐：
     *   pack_val = g_pack_align；若 is_packed 则强制为 1（packed 优先收紧）。
     * 字段对齐取 min(自然对齐, pack_val)。 */
    if (g_pack_align > 0) pack_val = g_pack_align;
    if (st->is_packed)    pack_val = 1;
    if (pack_val > 0 && al > pack_val) al = pack_val;
    if (al < 1) al = 1;
    /* 检测柔性数组成员：数组类型且 size==0 */
    if (ft && ft->kind == TYPE_ARRAY && ft->size == 0) {
        is_flex = 1;
    }
    /* 记录 pack 到 align_override，供 type_size/type_align 收紧整体对齐 */
    if (pack_val > 0 && st->align_override == 0) st->align_override = pack_val;
    /* 字段对齐 */
    cur = (cur + al - 1) & ~(al - 1);
    f->name = mem_strdup(name ? name : "");
    f->type = ft;
    f->offset = cur;
    f->bit_offset = 0;
    f->bit_width = 0;
    f->next = 0;
    /* 追加到链尾，保持声明顺序 */
    if (!st->fields) {
        st->fields = f;
    } else {
        StructField *p = st->fields;
        while (p->next) p = p->next;
        p->next = f;
    }
    if (st->kind == TYPE_UNION) {
        if (!is_flex && fs > st->size) st->size = fs;
    } else {
        if (!is_flex) st->size = cur + fs;
        /* 柔性数组成员不增加结构体大小，但 offset 仍记录其起始位置 */
    }
}

void type_struct_add_bitfield(Type *st, const char *name, Type *ft, int width) {
    /* 位域实现：同类位域尽量共用同一存储单元，紧凑排列。
     *   - unit_bits = sizeof(ft) * 8 为一个存储单元的位数
     *   - 若上一个字段是同类型位域且剩余位数足够，则接在其后
     *   - 否则在新对齐偏移处开辟新存储单元
     * 字段 offset 指向存储单元起点；bit_offset 为单元内位偏移；
     * bit_width 为位宽（>0 表示位域）。irgen 据此发 IR_LOAD_FLD/IR_STORE_FLD。 */
    int unit_sz   = type_size(ft);
    int unit_bits = unit_sz * 8;
    int unit_al   = type_align(ft);
    int pack_val  = 0;
    StructField *f;
    StructField *last = 0;
    int cur_off;
    int bit_off;

    if (g_pack_align > 0) pack_val = g_pack_align;
    if (st->is_packed)    pack_val = 1;
    if (pack_val > 0 && unit_al > pack_val) unit_al = pack_val;
    if (pack_val > 0 && st->align_override == 0) st->align_override = pack_val;
    if (unit_al < 1) unit_al = 1;

    /* width <= 0 视为非法/占位，按普通字段处理以保持兼容 */
    if (width <= 0) {
        type_struct_add_field(st, name, ft);
        return;
    }
    /* 位宽不能超过存储单元位数 */
    if (width > unit_bits) width = unit_bits;

    /* 找最后一个字段 */
    if (st->fields) {
        last = st->fields;
        while (last->next) last = last->next;
    }
    /* 尝试与上一个同类位域共用存储单元 */
    if (last && last->bit_width > 0 && last->type == ft &&
        last->bit_offset + last->bit_width + width <= unit_bits) {
        cur_off = last->offset;
        bit_off = last->bit_offset + last->bit_width;
    } else {
        /* 新存储单元：对齐当前 size 到 unit_al */
        cur_off = st->size;
        cur_off = (cur_off + unit_al - 1) & ~(unit_al - 1);
        bit_off = 0;
        if (st->kind == TYPE_UNION) {
            if (unit_sz > st->size) st->size = unit_sz;
        } else {
            st->size = cur_off + unit_sz;
        }
    }

    f = (StructField *)mem_pool_alloc(sizeof(StructField));
    f->name = mem_strdup(name ? name : "");
    f->type = ft;
    f->offset = cur_off;
    f->bit_offset = bit_off;
    f->bit_width = width;
    f->next = 0;
    if (!st->fields) {
        st->fields = f;
    } else {
        StructField *p = st->fields;
        while (p->next) p = p->next;
        p->next = f;
    }
}

/* 匿名 struct/union 字段提升：把 child 内每个具名字段以"父结构 size 对齐
 * 后的基址 + 字段相对偏移"为新偏移，加入 parent 字段链尾。
 *   - 对齐：父结构当前 size 按 child 的对齐 align(child) 圆整后，作为基址。
 *   - 字段：保留原 bit_offset/bit_width。
 *   - parent 大小：基址 + child 大小。
 * union 情况：parent 大小取 max(原 size, child 大小)。 */
void type_struct_add_anonymous(Type *parent, Type *child) {
    int base;
    int al = 1;
    int csz;
    StructField *f;
    if (!parent || !child) return;
    al = type_align(child);
    if (al < 1) al = 1;
    /* UNION 中所有成员都从偏移 0 开始（重叠存储）；
     * STRUCT 中按当前 size 对齐后追加 */
    if (parent->kind == TYPE_UNION) {
        base = 0;
    } else {
        base = parent->size;
        base = (base + al - 1) & ~(al - 1);
    }
    csz = type_size(child);
    for (f = child->fields; f; f = f->next) {
        if (!f->name || f->name[0] == 0) continue;
        {
            StructField *nf = (StructField *)mem_pool_alloc(sizeof(StructField));
            nf->name = mem_strdup(f->name);
            nf->type = f->type;
            nf->offset = base + f->offset;
            nf->bit_offset = f->bit_offset;
            nf->bit_width = f->bit_width;
            nf->next = 0;
            if (!parent->fields) parent->fields = nf;
            else {
                StructField *p = parent->fields;
                while (p->next) p = p->next;
                p->next = nf;
            }
        }
    }
    if (parent->kind == TYPE_UNION) {
        if (csz > parent->size) parent->size = csz;
    } else {
        parent->size = base + csz;
    }
}

int type_size(Type *t) {
    if (!t) return 4;
    switch (t->kind) {
        case TYPE_VOID:   return 0;
        case TYPE_CHAR:   return 1;
        case TYPE_BOOL:   return 1;
        case TYPE_SHORT:  return 2;
        case TYPE_INT:    return 4;
        case TYPE_LONG:   return 4;
        case TYPE_LLONG:  return 8;
        case TYPE_FLOAT:  return 4;
        case TYPE_DOUBLE: return 8;
        case TYPE_PTR:    return 4;
        case TYPE_WCHAR:  return 4;  /* B2 */
        case TYPE_COMPLEX: return 2 * type_size(t->base); /* B4: 实部+虚部 */
        case TYPE_ARRAY:  return type_size(t->base) * (t->size > 0 ? t->size : 1);
        case TYPE_STRUCT: {
            /* 总大小按最大字段对齐补齐。
             * #pragma pack / __attribute__((packed)) 通过 align_override 收紧
             * 整体对齐（pack_val 较小），这里把字段自然对齐上限截到该值，
             * 使结构体尾部补齐也遵循紧凑对齐。aligned(N) 放大对齐由
             * type_align 直接返回 align_override 负责，此处不放大以保持已有行为。 */
            int max_align = 1, s = t->size;
            StructField *f;
            for (f = t->fields; f; f = f->next) {
                int al = type_align(f->type);
                if (al > max_align) max_align = al;
            }
            if (max_align < 1) max_align = 1;
            if (t->align_override > 0 && t->align_override < max_align)
                max_align = t->align_override;
            s = (s + max_align - 1) & ~(max_align - 1);
            return s;
        }
        case TYPE_UNION:  return t->size;
        case TYPE_ENUM:   return 4;
        case TYPE_FUNC:   return 4;
    }
    return 4;
}

int type_align(Type *t) {
    if (!t) return 4;
    if (t->align_override > 0) return t->align_override;
    if (t->is_packed) return 1;
    switch (t->kind) {
        case TYPE_CHAR:
        case TYPE_BOOL:   return 1;
        case TYPE_SHORT:  return 2;
        case TYPE_LLONG:
        case TYPE_DOUBLE: return 8;
        case TYPE_COMPLEX: return type_align(t->base); /* B4 */
        case TYPE_ARRAY:  return type_align(t->base);
        case TYPE_STRUCT:
        case TYPE_UNION: {
            int max_align = 1;
            StructField *f;
            for (f = t->fields; f; f = f->next) {
                int al = type_align(f->type);
                if (al > max_align) max_align = al;
            }
            return max_align;
        }
        default:          return 4;
    }
}

int type_equal(Type *a, Type *b) {
    if (!a || !b) return 0;
    if (a->kind != b->kind) return 0;
    if (a->kind == TYPE_PTR || a->kind == TYPE_ARRAY)
        return type_equal(a->base, b->base);
    if (a->kind == TYPE_COMPLEX)
        return type_equal(a->base, b->base);
    return 1;
}

int type_is_integer(Type *t) {
    if (!t) return 0;
    return t->kind == TYPE_CHAR || t->kind == TYPE_SHORT ||
           t->kind == TYPE_INT  || t->kind == TYPE_LONG  ||
           t->kind == TYPE_LLONG|| t->kind == TYPE_BOOL  ||
           t->kind == TYPE_ENUM ||
           t->kind == TYPE_WCHAR;  /* B2: wchar_t 是整型 */
}

int type_is_arith(Type *t) {
    if (!t) return 0;
    return type_is_integer(t) || t->kind == TYPE_FLOAT || t->kind == TYPE_DOUBLE;
}

int type_is_scalar(Type *t) {
    if (!t) return 0;
    return type_is_arith(t) || t->kind == TYPE_PTR;
}

StructField *type_find_field(Type *t, const char *name) {
    StructField *f;
    if (!t || !name) return 0;
    for (f = t->fields; f; f = f->next) {
        if (ark_streq(f->name, name)) return f;
    }
    return 0;
}
