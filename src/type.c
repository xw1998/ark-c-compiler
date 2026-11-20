/* Ark C Compiler - type
 * Type system implementation. Most composite types are allocated from the memory pool.
 */
#include "type.h"
#include "memory.h"
#include "config.h"
/* Note: <stdio.h> intentionally NOT included - no stdio functions used in
 * type.c, and we want to avoid pulling in semihosting on STM32. */

static Type ty_void   = { TYPE_VOID, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
static Type ty_char   = { TYPE_CHAR, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
static Type ty_short  = { TYPE_SHORT, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
static Type ty_int    = { TYPE_INT, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
static Type ty_long   = { TYPE_LONG, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
static Type ty_llong  = { TYPE_LLONG, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
static Type ty_bool   = { TYPE_BOOL, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
static Type ty_float  = { TYPE_FLOAT, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
static Type ty_double = { TYPE_DOUBLE, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
static Type ty_uchar  = { TYPE_CHAR, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
static Type ty_ushort = { TYPE_SHORT, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
static Type ty_uint   = { TYPE_INT, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
static Type ty_ulong  = { TYPE_LONG, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
static Type ty_ullong = { TYPE_LLONG, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
/* B2: wchar_t - passed through to gcc by host/C backend, treated as 4-byte unsigned integer */
static Type ty_wchar  = { TYPE_WCHAR, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

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

/* F2: Create a qualified copy of a type with volatile/const flags set.
 * Does not modify the original (important for singleton basic types).
 * If no qualifiers are requested, returns the original type unchanged. */
Type *type_qualified(Type *t, int is_volatile, int is_const) {
    Type *q;
    if (!t) return t;
    if (!is_volatile && !is_const) return t;
    q = (Type *)mem_pool_alloc(sizeof(Type));
    *q = *t;  /* shallow copy all fields */
    q->is_volatile = is_volatile;
    q->is_const = is_const;
    return q;
}

/* C11 _Atomic: same layout as the underlying type, so this is the same
 * shallow copy type_qualified() makes.  Copying instead of setting the flag on
 * the argument is what keeps `type_int()` a singleton: one `_Atomic int x;`
 * must not turn every later `int` atomic. */
Type *type_atomic(Type *t) {
    Type *q;
    if (!t) return t;
    if (t->is_atomic) return t;
    q = (Type *)mem_pool_alloc(sizeof(Type));
    *q = *t;
    q->is_atomic = 1;
    return q;
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

/* ---------------------------------------------------------------------------
 * Enum definitions: tag -> defining Type.
 *
 * The list lives in the arena, so it dies with the translation unit that
 * created it.  g_enum_gen remembers which arena generation it belongs to and
 * is compared on every entry point: after mem_pool_reset() the old head would
 * still be a valid pointer into the pool but no longer own anything, and
 * following it would read another TU's data.  Dropping it is the only correct
 * answer -- a stale registry would silently enumerate the wrong enum.
 * ------------------------------------------------------------------------- */
typedef struct EnumDef {
    char           *tag;
    Type           *type;
    struct EnumDef *next;
} EnumDef;

static EnumDef *g_enum_defs;
static int      g_enum_gen = -1;

static void enum_registry_sync(void)
{
    int gen = mem_pool_generation();
    if (gen != g_enum_gen) { g_enum_defs = 0; g_enum_gen = gen; }
}

void type_enum_add_const(Type *t, const char *name, long long value)
{
    EnumConst *c, *p;

    if (!t || t->kind != TYPE_ENUM) return;
    enum_registry_sync();

    c = (EnumConst *)mem_pool_alloc(sizeof(EnumConst));
    c->name  = name ? mem_strdup(name) : 0;
    c->value = value;
    c->next  = 0;
    if (!t->enumerators) t->enumerators = c;
    else { for (p = t->enumerators; p->next; p = p->next) ; p->next = c; }
    t->enumerator_count++;

    /* First definition of a tag wins.  C99 6.7.2.3p3 forbids defining the
     * same enum twice in one scope, so a second one is already a diagnosed
     * error; keeping the first makes the answer well defined regardless. */
    if (t->tag) {
        EnumDef *d;
        for (d = g_enum_defs; d; d = d->next)
            if (ark_streq(d->tag, t->tag)) return;
        d = (EnumDef *)mem_pool_alloc(sizeof(EnumDef));
        d->tag  = t->tag;
        d->type = t;
        d->next = g_enum_defs;
        g_enum_defs = d;
    }
}

Type *type_enum_definition(Type *t)
{
    EnumDef *d;

    if (!t || t->kind != TYPE_ENUM) return 0;
    if (t->enumerators) return t;        /* anonymous, or the definition itself */
    if (!t->tag) return 0;
    enum_registry_sync();
    for (d = g_enum_defs; d; d = d->next)
        if (ark_streq(d->tag, t->tag)) return d->type;
    return 0;
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

/* B2: wchar_t - same size as host int, 4-byte unsigned */
Type *type_wchar(void) { return &ty_wchar; }

/* B4: _Complex - base points to float/double; size is 2*base */
Type *type_complex(Type *base) {
    Type *t = (Type *)mem_pool_alloc(sizeof(Type));
    t->kind = TYPE_COMPLEX;
    t->base = base;
    return t;
}

/* #pragma pack(n) global alignment control: when >0, limits struct field natural alignment to no more than this value.
 * 0 means restore default (natural alignment per field). */
static int g_pack_align = 0;

void type_set_pack(int n) { g_pack_align = n; }
int  type_get_pack(void)  { return g_pack_align; }

/* #pragma pack push/pop stack and the directive parser.
 *
 * These used to live in the preprocessor, which applied the directive while
 * expanding the file.  That is one phase too early: struct layout happens
 * when the PARSER sees the definition, so every struct in the file ended up
 * laid out with whatever value the LAST pragma left behind.  Measured before
 * the fix: `#pragma pack(push,1) struct P{char c;int i;}; #pragma pack(pop)`
 * gave sizeof(P) == 8 instead of 5 -- the canonical embedded idiom silently
 * produced an unpacked struct, and every offset taken from it was wrong.
 * The preprocessor now hands the raw line through and the lexer applies it
 * here, at the position it appears. */
static int g_pack_stack[32];
static int g_pack_top = 0;

void type_pack_reset(void) { g_pack_align = 0; g_pack_top = 0; }

/* q points at the '(' of "pack(...)".  Accepted forms:
 *   pack         -> reset to default alignment
 *   pack()       -> reset to default (0)
 *   pack(n)      -> set current alignment to n
 *   pack(push)   -> push current alignment onto the stack
 *   pack(push,n) -> push current and set the new alignment to n
 *   pack(pop)    -> pop the alignment off the stack
 * Returns 1 when the directive was understood, 0 otherwise (caller leaves
 * the state alone, so an unparsable directive is not mistaken for pack()). */
int type_pragma_pack(const char *q) {
    while (*q == ' ' || *q == '\t') q++;
    if (*q != '(') return 0;
    q++;
    while (*q == ' ' || *q == '\t') q++;
    if (*q == ')') { type_set_pack(0); return 1; }
    if (q[0] == 'p' && q[1] == 'u' && q[2] == 's' && q[3] == 'h') {
        int old = type_get_pack();
        q += 4;
        while (*q == ' ' || *q == '\t') q++;
        if (*q == ',') {
            int n = 0;
            q++;
            while (*q == ' ' || *q == '\t') q++;
            if (*q >= '0' && *q <= '9') {
                while (*q >= '0' && *q <= '9') { n = n * 10 + (*q - '0'); q++; }
                if (g_pack_top < 32) g_pack_stack[g_pack_top++] = old;
                type_set_pack(n);
                return 1;
            }
        }
        if (g_pack_top < 32) g_pack_stack[g_pack_top++] = old;
        return 1;
    }
    if (q[0] == 'p' && q[1] == 'o' && q[2] == 'p') {
        if (g_pack_top > 0) type_set_pack(g_pack_stack[--g_pack_top]);
        return 1;
    }
    if (*q >= '0' && *q <= '9') {
        int n = 0;
        while (*q >= '0' && *q <= '9') { n = n * 10 + (*q - '0'); q++; }
        type_set_pack(n);
        return 1;
    }
    return 0;
}

/* See include/type.h.  `packed` can arrive after the members were laid out
 * (armcc writes `__packed struct S {...};`, and GCC allows `struct S {...}
 * __attribute__((packed));`), and the normal add path fixes each offset as
 * the member is parsed -- so a late flag left every offset and the size at
 * their natural values (measured: sizeof 8 instead of 5, i.e. every field
 * after the first one sat at the wrong address).  Replaying the field list
 * through the same add path with is_packed already set gives exactly the
 * layout the flag would have produced up front.  The old StructField nodes
 * stay in the memory pool; only the list head is rebuilt. */
/* `:0` separators are replayed too: struct_note_break() recorded where they
 * sat, and under packed layout a separator rounds up to the next byte instead
 * of the next container, so each one is re-applied as a byte break just before
 * the member it preceded.  A struct type that arrived from an object file has
 * no such record (see BfBreak) -- its offsets are already final, and repacking
 * a deserialized type is not something the parser does. */
void type_struct_repack(Type *st) {
    StructField *f, *saved;
    if (!st || !st->is_packed) return;
    if (st->kind != TYPE_STRUCT && st->kind != TYPE_UNION) return;
    if (!st->fields) return;
    saved = st->fields;
    st->fields = 0;
    st->size = 0;
    st->align_override = 0;
    st->bf_break = 0;   /* replay starts fresh; see the :0 note below */
    {
        BfBreak *br = st->bf_breaks;
        int idx = 0;
        for (f = saved; f; f = f->next) {
            while (br && br->index == idx) {
                st->bf_break = 2;      /* packed: `:0` goes to the next byte */
                br = br->next;
            }
            if (f->bit_width > 0) {
                type_struct_add_bitfield(st, f->name, f->type, f->bit_width);
            } else {
                type_struct_add_field(st, f->name, f->type);
            }
            idx++;
        }
    }
}

void type_struct_add_field(Type *st, const char *name, Type *ft) {
    StructField *f = (StructField *)mem_pool_alloc(sizeof(StructField));
    int al = type_align(ft);
    int fs = type_size(ft);
    int cur = st->size;
    int pack_val = 0;
    int is_flex = 0;  /* Flexible array member: ft is an array with size==0, not counted in sizeof */
    /* Union members all start at offset 0; only struct fields accumulate offsets. */
    if (st->kind == TYPE_UNION) cur = 0;
    /* Both #pragma pack and __attribute__((packed)) tighten alignment:
     *   pack_val = g_pack_align; if is_packed, force to 1 (packed takes precedence).
     * Field alignment is min(natural alignment, pack_val). */
    if (g_pack_align > 0) pack_val = g_pack_align;
    if (st->is_packed)    pack_val = 1;
    if (pack_val > 0 && al > pack_val) al = pack_val;
    if (al < 1) al = 1;
    /* Detect flexible array member: array type with size==0 */
    if (ft && ft->kind == TYPE_ARRAY && ft->size == 0) {
        is_flex = 1;
    }
    /* Record pack into align_override, so type_size/type_align can tighten overall alignment */
    if (pack_val > 0 && st->align_override == 0) st->align_override = pack_val;
    /* Field alignment */
    cur = (cur + al - 1) & ~(al - 1);
    f->name = mem_strdup(name ? name : "");
    f->type = ft;
    f->offset = cur;
    f->bit_offset = 0;
    f->bit_width = 0;
    f->next = 0;
    /* Append to tail of list, preserving declaration order */
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
        /* Flexible array member does not increase struct size, but offset still records its start position */
    }
}

/* Absolute bit position just past the last laid-out member: where the next
 * bit-field starts.  When the last member is a bit-field its end is exact;
 * otherwise every preceding member ends on a byte boundary, so st->size*8 is
 * exact as well (st->size carries no tail padding -- type_size() adds that). */
static int struct_bitpos(const Type *st) {
    StructField *f = st->fields;
    StructField *last = 0;
    while (f) { last = f; f = f->next; }
    if (last && last->bit_width > 0)
        return last->offset * 8 + last->bit_offset + last->bit_width;
    return st->size * 8;
}

/* Record a `:0` separator at the current end of the field list, so that
 * type_struct_repack() can put it back when a late packed flag forces a
 * re-layout.  Without it the replay produced the packed layout of a struct
 * that never had a separator: measured on armcc, `__packed struct {unsigned
 * a:4; unsigned :0; unsigned b:4;}` is 2 bytes while the separator-less version
 * is 1, and the replay used to answer 1 for both. */
static void struct_note_break(Type *st) {
    BfBreak *n = (BfBreak *)mem_pool_alloc(sizeof(BfBreak));
    StructField *p;
    int n_fields = 0;
    for (p = st->fields; p; p = p->next) n_fields++;
    n->index = n_fields;
    n->next = 0;
    if (!st->bf_breaks) {
        st->bf_breaks = n;
    } else {
        BfBreak *b = st->bf_breaks;
        while (b->next) b = b->next;
        b->next = n;
    }
}

void type_struct_add_bitfield(Type *st, const char *name, Type *ft, int width) {
    /* Bit-field layout, matched against armcc (ARM Compiler 5.06) measured
     * through sizeof()/offsetof(); the gate is tests/run_layout_tests.py.
     *
     * Two regimes:
     *   - Without #pragma pack / __packed: a bit-field lives inside a naturally
     *     aligned container of its declared type (32 bits for `unsigned`), and
     *     may not straddle a container boundary.  If it does not fit in what is
     *     left of the container it moves to the next container boundary.  The
     *     FIRST container starts wherever the previous member ended, with no
     *     padding out to a container boundary -- measured: `struct {char c;
     *     unsigned a:4; unsigned b:12;}` is 4 bytes with the pair at bits 8..23.
     *   - With #pragma pack(n) or __packed: bit-fields are a pure bit stream.
     *     No containers, no straddle rule -- measured: `__packed struct {char c;
     *     unsigned a:4; unsigned b:12;}` is 3 bytes and `__packed struct
     *     {unsigned a:4; unsigned b:12;}` is 2 bytes (pack(2) takes the same
     *     path: `#pragma pack(2) struct {unsigned a:20; unsigned b:20;}` is 6).
     * In both regimes the accumulated byte size is ceil(bits/8); type_size()
     * then rounds it up to the struct alignment, which still counts the
     * bit-field's declared type as a member for alignment purposes.
     *
     * Storage representation: IR_LOAD_FLD/IR_STORE_FLD read and write ONE
     * 32-bit word at f->offset and shift by f->bit_offset, so the field must fit
     * inside that word.  f->offset is therefore the address of the leftmost
     * byte window that still contains the field:
     *     offset = max(0, ceil((P + width - 32) / 8)),  bit_offset = P - 8*offset
     * which keeps bit_offset in [0,31] and bit_offset + width <= 32.  Under
     * packed layout that window can be unaligned; ARMv6-M LDR/STR permit it,
     * and the read-modify-write store writes back the neighbouring bits it
     * just read, so bytes outside the field are preserved. */
    int unit_sz   = type_size(ft);
    int unit_bits = unit_sz * 8;
    int pack_val  = 0;
    int packed_mode;
    int P;
    int off_bytes;
    int bit_off;
    StructField *f;

    if (g_pack_align > 0) pack_val = g_pack_align;
    if (st->is_packed)    pack_val = 1;
    if (pack_val > 0 && st->align_override == 0) st->align_override = pack_val;
    packed_mode = (pack_val > 0);

    if (width == 0) {
        /* C99 6.7.2.1: width 0 stops bit-fields from packing into the unit that
         * holds the previous one.  Measured on armcc: unpacked `struct {unsigned
         * a:4; unsigned :0; unsigned b:4;}` is 8 bytes (b starts at bit 32),
         * while `__packed` with the same members is 2 bytes (b starts at bit 8,
         * i.e. the separator only advances to the next byte). */
        st->bf_break = packed_mode ? 2 : 1;
        struct_note_break(st);
        return;
    }
    if (width < 0) {
        st->bf_break = 0;
        type_struct_add_field(st, name, ft);
        return;
    }
    if (width > unit_bits) width = unit_bits;

    if (st->kind == TYPE_UNION) {
        /* Union members all start at bit 0 (overlapping storage). */
        P = 0;
    } else {
        P = struct_bitpos(st);
        if (st->bf_break) {
            if (st->bf_break == 2) {
                P = (P + 7) & ~7;                       /* packed: next byte */
            } else if (unit_bits > 0) {
                P = ((P + unit_bits - 1) / unit_bits) * unit_bits;
            }
        } else if (!packed_mode && unit_bits > 0) {
            int rem = unit_bits - (P % unit_bits);
            if (width > rem) P += rem;                  /* next container */
        }
    }
    st->bf_break = 0;

    off_bytes = 0;
    if (P + width > 32) {
        off_bytes = (P + width - 32 + 7) / 8;
        if (off_bytes > P / 8) off_bytes = P / 8;
    }
    bit_off = P - off_bytes * 8;

    if (st->kind == TYPE_UNION) {
        int need = (P + width + 7) / 8;
        if (need > st->size) st->size = need;
    } else {
        st->size = (P + width + 7) / 8;
    }

    f = (StructField *)mem_pool_alloc(sizeof(StructField));
    f->name = mem_strdup(name ? name : "");
    f->type = ft;
    f->offset = off_bytes;
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

/* Anonymous struct/union field promotion: add each named field in child with
 * "base address (parent size aligned) + field relative offset" as the new offset, to the parent field list tail.
 *   - Alignment: round parent's current size up to align(child), as the base address.
 *   - Fields: preserve original bit_offset/bit_width.
 *   - parent size: base + child size.
 * For unions: parent size = max(original size, child size). */
void type_struct_add_anonymous(Type *parent, Type *child) {
    int base;
    int al = 1;
    int csz;
    StructField *f;
    if (!parent || !child) return;
    al = type_align(child);
    if (al < 1) al = 1;
    /* In UNION, all members start at offset 0 (overlapping storage);
     * in STRUCT, append after aligning current size */
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

/* Pointer size for the selected backend. Defaults to 4 (32-bit ARM/RISC-V).
 * The C backend overrides this to sizeof(void*) (8 on 64-bit hosts) because
 * generated code runs on the host, where pointers are 8 bytes. Without this,
 * argv[i] (char**) would compute argv+i*4 and load 4 bytes, corrupting the
 * pointer and crashing with STATUS_ACCESS_VIOLATION. */
static int g_ptr_size = 4;

void type_set_ptr_size(int bytes) {
    if (bytes == 4 || bytes == 8) g_ptr_size = bytes;
}

int type_ptr_size(void) {
    return g_ptr_size;
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
        case TYPE_PTR:    return g_ptr_size;
        case TYPE_WCHAR:  return 4;  /* B2 */
        case TYPE_COMPLEX: return 2 * type_size(t->base); /* B4: real + imaginary parts */
        case TYPE_ARRAY:  return type_size(t->base) * (t->size > 0 ? t->size : 1);
        case TYPE_STRUCT: {
            /* Total size is padded to the maximum field alignment.
             * #pragma pack / __attribute__((packed)) tighten overall alignment via align_override
             * (smaller pack_val); here we cap field natural alignment to that value,
             * so struct tail padding also follows the tight alignment. aligned(N) widening is
             * handled by type_align returning align_override directly; not widened here to preserve existing behavior. */
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
        case TYPE_UNION: {
            /* Same tail rounding as a struct: the union's size must be a
             * multiple of its alignment so that array stride holds.  This
             * used to be implied by the largest member, which stops being
             * true once a bit-field is the largest member -- measured:
             * `union {unsigned a:4; unsigned char c;};` is 4 bytes on armcc
             * (2 bits worth of storage, rounded up to the unsigned align). */
            int max_align = 1, s = t->size;
            StructField *f;
            for (f = t->fields; f; f = f->next) {
                int al = type_align(f->type);
                if (al > max_align) max_align = al;
            }
            if (max_align < 1) max_align = 1;
            if (t->align_override > 0 && t->align_override < max_align)
                max_align = t->align_override;
            return (s + max_align - 1) & ~(max_align - 1);
        }
        case TYPE_ENUM:
            /* --enum_is_int / -fenum-is-int: force enum to int (4 bytes).
             * armcc by default picks the smallest type based on enum value range; arkcc always uses int,
             * so it returns 4 regardless of the switch. The switch only exists for armcc CLI compatibility. */
            (void)g_config.enum_is_int;
            return 4;
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
        case TYPE_PTR:    return g_ptr_size; /* pointer is naturally aligned */
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
    if (a->is_unsigned != b->is_unsigned) return 0;
    return 1;
}

int type_is_integer(Type *t) {
    if (!t) return 0;
    return t->kind == TYPE_CHAR || t->kind == TYPE_SHORT ||
           t->kind == TYPE_INT  || t->kind == TYPE_LONG  ||
           t->kind == TYPE_LLONG|| t->kind == TYPE_BOOL  ||
           t->kind == TYPE_ENUM ||
           t->kind == TYPE_WCHAR;  /* B2: wchar_t is an integer type */
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
