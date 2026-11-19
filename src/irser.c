/* Ark C Compiler - irser.c
 * IR serialisation (see include/irser.h for the byte format).
 *
 * Design notes that are not obvious from the format:
 *
 *  * Every reader checks before it allocates.  A payload is an input file
 *    like any other, so "trusted" is not in its vocabulary: a bad magic, a
 *    version mismatch, a length that does not add up or an index past the end
 *    of a pool is a diagnostic, and the caller gets NULL.  Linking whatever
 *    happened to be in memory after the buffer is the one thing this file must
 *    never do.
 *
 *  * `name` is only meaningful on a fixed set of opcodes (the ones that carry
 *    a symbol, a goto label, a string's bytes or asm text).  Everything else
 *    must have name == NULL.  Both directions enforce that, so a payload that
 *    was hand-edited or written by a buggy writer cannot smuggle text into an
 *    opcode whose backends never read a name -- which would silently drop it
 *    and change the program.
 *
 *  * Types are written as a graph, not as a copy of the pointer.  A Type is
 *    shared (the int singleton, one struct type used by ten globals), so the
 *    writer numbers them breadth-first from the roots the program actually
 *    holds (function return/parameter types, global types) and recurses
 *    through base/fields/params.  The reader allocates all the Type structs
 *    first and fills them in a second pass, which is what makes a forward
 *    reference (a struct that contains a pointer to itself) legal.
 */
#include "irser.h"
#include "memory.h"
#include "diag.h"

#if ARKCC_FEATURE_OBJ_IR

/* ------------------------------------------------------------------ */
/* Writer                                                              */
/* ------------------------------------------------------------------ */

typedef struct {
    unsigned char *b;
    int n;
    int cap;
    int err;
} IrW;

static void w_raw(IrW *w, const void *p, int len)
{
    const unsigned char *s = (const unsigned char *)p;
    int i;
    if (w->err) return;
    if (len < 0 || w->n + len > w->cap) { w->err = 1; return; }
    for (i = 0; i < len; i++) w->b[w->n + i] = s[i];
    w->n += len;
}

static void w_u32(IrW *w, unsigned v)
{
    unsigned char t[4];
    t[0] = (unsigned char)(v & 0xFF);
    t[1] = (unsigned char)((v >> 8) & 0xFF);
    t[2] = (unsigned char)((v >> 16) & 0xFF);
    t[3] = (unsigned char)((v >> 24) & 0xFF);
    w_raw(w, t, 4);
}

static void w_i32(IrW *w, int v)      { w_u32(w, (unsigned)v); }

static void w_i64(IrW *w, long long v)
{
    unsigned char t[8];
    int i;
    for (i = 0; i < 8; i++) t[i] = (unsigned char)((unsigned long long)v >> (8 * i));
    w_raw(w, t, 8);
}

static void w_f64(IrW *w, double d)
{
    union { double d; unsigned char b[8]; } u;
    int i;
    u.d = d;
    for (i = 0; i < 8; i++) u.b[i] = 0;
    u.d = d;
    w_raw(w, u.b, 8);
}

/* A string: i32 present, then u32 length and the bytes.  NULL stays
 * distinguishable from "" because a global with no initialiser text is not a
 * global initialised from an empty string. */
static void w_sstr(IrW *w, const char *s)
{
    int len = 0;
    if (!s) { w_i32(w, 0); return; }
    w_i32(w, 1);
    len = ark_strlen(s);
    w_u32(w, (unsigned)len);
    w_raw(w, s, len);
}

/* ------------------------------------------------------------------ */
/* Type graph                                                          */
/* ------------------------------------------------------------------ */

typedef struct {
    Type **v;
    int n;
    int cap;
} IrTypeTab;

static int ttab_find(IrTypeTab *t, Type *ty)
{
    int i;
    for (i = 0; i < t->n; i++) if (t->v[i] == ty) return i;
    return -1;
}

static void ttab_add(IrTypeTab *t, Type *ty);

/* Add every Type reachable from ty, ty itself first.  The placeholder is
 * inserted before the recursion so a self-referential struct terminates. */
static void ttab_add(IrTypeTab *t, Type *ty)
{
    int idx;
    StructField *f;
    int i;
    if (!ty) return;
    if (ttab_find(t, ty) >= 0) return;
    if (t->n >= t->cap) {
        int nc = t->cap ? t->cap * 2 : 32;
        t->v = (Type **)mem_realloc(t->v, t->cap * (int)sizeof(Type *),
                                    nc * (int)sizeof(Type *));
        t->cap = nc;
    }
    idx = t->n;
    t->v[t->n++] = ty;
    (void)idx;
    ttab_add(t, ty->base);
    for (f = ty->fields; f; f = f->next) ttab_add(t, f->type);
    if (ty->params)
        for (i = 0; i < ty->param_count; i++) ttab_add(t, ty->params[i]);
}

static int ttab_idx(IrTypeTab *t, Type *ty)
{
    if (!ty) return -1;
    return ttab_find(t, ty);
}

/* ------------------------------------------------------------------ */
/* Serialise                                                           */
/* ------------------------------------------------------------------ */

static int ir_ser_fail(const char *who, const char *why, const char *a0)
{
    diag_tool(DIAG_SEV_ERROR, who,
              "cannot write the IR payload: %s", why, a0, 0,0,0,0);
    return -1;
}

int ir_serialize(IrProgram *p, unsigned char *buf, int cap, const char *who)
{
    IrW w;
    IrTypeTab tt;
    int i, k, j;
    int body_start;

    if (!p || !buf || cap < 16) return ir_ser_fail(who, "no buffer", 0);

    w.b = buf; w.n = 0; w.cap = cap; w.err = 0;
    w_raw(&w, ARK_IR_MAGIC, ARK_IR_MAGIC_LEN);
    w_u32(&w, ARK_IR_VERSION);
    w_u32(&w, 0);                 /* body_len, patched below */
    body_start = w.n;

    /* --- types --- */
    tt.v = 0; tt.n = 0; tt.cap = 0;
    for (i = 0; i < p->func_count; i++) {
        IrFunc *f = p->funcs[i];
        ttab_add(&tt, f->ret_type);
        if (f->param_types)
            for (k = 0; k < f->param_count; k++) ttab_add(&tt, f->param_types[k]);
    }
    for (i = 0; i < p->global_count; i++) ttab_add(&tt, p->globals[i]->type);

    w_u32(&w, (unsigned)tt.n);
    for (i = 0; i < tt.n; i++) {
        Type *t = tt.v[i];
        StructField *fd;
        int nf = 0, np = t->param_count, ne = 0;
        EnumConst *ec;
        for (fd = t->fields; fd; fd = fd->next) nf++;
        for (ec = t->enumerators; ec; ec = ec->next) ne++;
        w_u32(&w, (unsigned)t->kind);
        w_i32(&w, ttab_idx(&tt, t->base));
        w_i32(&w, t->size);
        w_i32(&w, t->is_unsigned);
        w_i32(&w, t->is_variadic);
        w_sstr(&w, t->tag);
        w_i32(&w, t->is_packed);
        w_i32(&w, t->align_override);
        w_i32(&w, t->is_vla);
        w_i32(&w, t->is_volatile);
        w_i32(&w, t->is_const);
        w_i32(&w, t->is_atomic);
        w_i32(&w, t->is_func_ptr);
        w_i32(&w, t->bf_break);
        w_u32(&w, (unsigned)nf);
        for (fd = t->fields; fd; fd = fd->next) {
            w_sstr(&w, fd->name);
            w_i32(&w, ttab_idx(&tt, fd->type));
            w_i32(&w, fd->offset);
            w_i32(&w, fd->bit_offset);
            w_i32(&w, fd->bit_width);
        }
        if (!t->params) np = 0;
        w_u32(&w, (unsigned)np);
        for (k = 0; k < np; k++) w_i32(&w, ttab_idx(&tt, t->params[k]));
        w_i32(&w, t->param_count);
        w_u32(&w, (unsigned)ne);
        for (ec = t->enumerators; ec; ec = ec->next) {
            w_sstr(&w, ec->name);
            w_i64(&w, ec->value);
        }
        w_i32(&w, t->enumerator_count);
    }

    /* --- string pool --- */
    w_u32(&w, (unsigned)p->string_count);
    for (i = 0; i < p->string_count; i++) {
        IrString *s = p->strings[i];
        w_u32(&w, (unsigned)s->len);
        w_raw(&w, s->data, s->len);
        w_u32(&w, (unsigned)s->is_wide);
        w_u32(&w, (unsigned)s->id);
    }

    /* --- float pool --- */
    w_u32(&w, (unsigned)p->float_count);
    for (i = 0; i < p->float_count; i++) w_f64(&w, p->floats[i]);

    /* --- complex pool --- */
    w_u32(&w, (unsigned)p->complex_count);
    for (i = 0; i < p->complex_count; i++) {
        w_f64(&w, p->complexes[i].re);
        w_f64(&w, p->complexes[i].im);
    }

    /* --- IR_CALL argument-size table --- */
    w_u32(&w, (unsigned)p->argbytes_count);
    for (i = 0; i < p->argbytes_count; i++) w_i32(&w, p->argbytes[i]);

    w_sstr(&w, p->source_file);

    /* --- globals --- */
    w_u32(&w, (unsigned)p->global_count);
    for (i = 0; i < p->global_count; i++) {
        IrGlobal *g = p->globals[i];
        w_sstr(&w, g->name);
        w_i32(&w, ttab_idx(&tt, g->type));
        w_i32(&w, g->is_static);
        w_i32(&w, g->is_extern);
        w_i32(&w, g->has_init);
        w_i64(&w, g->init_int);
        w_sstr(&w, g->init_str);
        w_sstr(&w, g->init_aggregate);
        w_sstr(&w, g->init_sym);
        w_i64(&w, g->init_sym_off);
        w_i32(&w, g->init_sym_is_func);
        w_u32(&w, (unsigned)g->init_ref_count);
        for (j = 0; j < g->init_ref_count; j++) {
            w_i32(&w, g->init_refs[j].offset);
            w_sstr(&w, g->init_refs[j].sym);
            w_i64(&w, g->init_refs[j].add);
            w_i32(&w, g->init_refs[j].is_func);
            w_sstr(&w, g->init_refs[j].str);
        }
        w_i32(&w, g->init_ref_count);
        w_f64(&w, g->init_float);
        w_i32(&w, g->is_float);
        w_i32(&w, g->init_is_complex);
        w_f64(&w, g->init_float_im);
        w_sstr(&w, g->section);
        w_i32(&w, g->is_const);
        w_u32(&w, g->at_addr);
        w_i32(&w, g->has_at);
        w_i32(&w, g->align_bytes);
        w_i32(&w, g->is_used);
        w_i32(&w, g->is_unused);
        w_i32(&w, g->is_tls);
        w_i32(&w, g->global_reg);
    }

    /* --- functions --- */
    w_u32(&w, (unsigned)p->func_count);
    for (i = 0; i < p->func_count; i++) {
        IrFunc *f = p->funcs[i];
        w_sstr(&w, f->name);
        w_u32(&w, (unsigned)f->code_count);
        for (k = 0; k < f->code_count; k++) {
            IrInst *I = &f->code[k];
            w_u32(&w, (unsigned)I->op);
            w_i64(&w, I->val);
            w_sstr(&w, I->name);
            w_i32(&w, I->aux);
            w_i32(&w, I->line);
            w_i32(&w, I->aux2);
        }
        w_i32(&w, f->local_size);
        w_i32(&w, f->label_count);
        w_i32(&w, f->param_count);
        w_i32(&w, f->is_variadic);
        w_i32(&w, f->is_static);
        w_i32(&w, f->is_irq);
        w_i32(&w, f->is_weak);
        w_i32(&w, f->is_naked);
        w_i32(&w, f->is_used);
        w_i32(&w, f->is_unused);
        w_i32(&w, f->is_asm_func);
        w_i32(&w, f->forceinline);
        w_i32(&w, f->is_inline);
        w_i32(&w, f->is_constructor);
        w_i32(&w, f->is_destructor);
        w_i32(&w, f->is_deprecated);
        w_i32(&w, f->is_value_in_regs);
        w_i32(&w, f->is_pure);
        w_i32(&w, f->is_const_attr);
        w_i32(&w, f->is_interwork);
        w_i32(&w, f->smc_num);
        w_i32(&w, f->global_reg);
        w_sstr(&w, f->alias_target);
        w_sstr(&w, f->asm_body);
        w_i32(&w, f->param_names_count);
        for (k = 0; k < f->param_names_count; k++)
            w_sstr(&w, f->param_names ? f->param_names[k] : 0);
        {
            int np = (f->param_types && f->param_count > 0) ? f->param_count : 0;
            w_u32(&w, (unsigned)np);
            for (k = 0; k < np; k++) w_i32(&w, ttab_idx(&tt, f->param_types[k]));
        }
        w_i32(&w, ttab_idx(&tt, f->ret_type));
    }

    if (w.err) return ir_ser_fail(who, "the IR payload does not fit the object buffer", 0);
    if (w.n < 16) return ir_ser_fail(who, "internal length error", 0);

    /* Patch body_len: everything after the 16-byte header. */
    {
        unsigned v = (unsigned)(w.n - body_start);
        int o = 12;
        buf[o + 0] = (unsigned char)(v & 0xFF);
        buf[o + 1] = (unsigned char)((v >> 8) & 0xFF);
        buf[o + 2] = (unsigned char)((v >> 16) & 0xFF);
        buf[o + 3] = (unsigned char)((v >> 24) & 0xFF);
    }
    return w.n;
}

/* ------------------------------------------------------------------ */
/* Reader                                                              */
/* ------------------------------------------------------------------ */

typedef struct {
    const unsigned char *b;
    int n;
    int pos;
    int err;
    const char *why;   /* first failure reason, for the diagnostic */
} IrR;

static void r_need(IrR *r, int len)
{
    if (r->err) return;
    if (len < 0 || r->pos + len > r->n) {
        r->err = 1;
        if (!r->why) r->why = "the payload ends in the middle of a record";
    }
}

static unsigned r_u32(IrR *r)
{
    unsigned v = 0;
    r_need(r, 4);
    if (r->err) return 0;
    v = (unsigned)r->b[r->pos] | ((unsigned)r->b[r->pos + 1] << 8) |
        ((unsigned)r->b[r->pos + 2] << 16) | ((unsigned)r->b[r->pos + 3] << 24);
    r->pos += 4;
    return v;
}

static int r_i32(IrR *r) { return (int)r_u32(r); }

static long long r_i64(IrR *r)
{
    unsigned long long v = 0;
    int i;
    r_need(r, 8);
    if (r->err) return 0;
    for (i = 0; i < 8; i++)
        v |= ((unsigned long long)r->b[r->pos + i]) << (8 * i);
    r->pos += 8;
    return (long long)v;
}

static double r_f64(IrR *r)
{
    union { double d; unsigned char b[8]; } u;
    int i;
    r_need(r, 8);
    if (r->err) return 0.0;
    for (i = 0; i < 8; i++) u.b[i] = r->b[r->pos + i];
    r->pos += 8;
    return u.d;
}

static const char *r_str(IrR *r)
{
    int present = r_i32(r);
    unsigned len;
    char *s;
    if (r->err) return 0;
    if (present == 0) return 0;
    if (present != 1) {
        r->err = 1;
        if (!r->why) r->why = "a string field has an invalid 'present' marker";
        return 0;
    }
    len = r_u32(r);
    if (r->err) return 0;
    if (len > (unsigned)(r->n - r->pos)) {
        r->err = 1;
        if (!r->why) r->why = "a string length runs past the end of the payload";
        return 0;
    }
    s = (char *)mem_pool_alloc((int)len + 1);
    {
        unsigned i;
        for (i = 0; i < len; i++) s[i] = (char)r->b[r->pos + i];
    }
    s[len] = 0;
    r->pos += (int)len;
    return s;
}

/* Only these opcodes may carry a name; see include/irser.h and the switch in
 * src/ipo.c's ipo_rewrite_unit(). */
static IrFunc *deser_func_new(const char *name, int ncode)
{
    IrFunc *f = (IrFunc *)mem_pool_alloc(sizeof(IrFunc));
    f->name = (char *)name;
    f->code_count = ncode;
    f->code_capacity = ncode > 0 ? ncode : 1;
    f->code = (IrInst *)mem_pool_alloc((int)sizeof(IrInst) * f->code_capacity);
    f->local_size = 0;
    f->label_count = 0;
    f->param_count = 0;
    f->is_variadic = 0;
    f->is_static = 0;
    f->is_irq = 0;
    f->is_weak = 0;
    f->is_naked = 0;
    f->is_used = 0;
    f->is_unused = 0;
    f->is_asm_func = 0;
    f->forceinline = 0;
    f->is_inline = 0;
    f->is_constructor = 0;
    f->is_destructor = 0;
    f->is_deprecated = 0;
    f->alias_target = 0;
    f->asm_body = 0;
    f->is_value_in_regs = 0;
    f->is_pure = 0;
    f->is_const_attr = 0;
    f->is_interwork = 0;
    f->smc_num = -1;
    f->global_reg = -1;
    f->param_names = 0;
    f->param_names_count = 0;
    f->param_types = 0;
    f->ret_type = 0;
    return f;
}

static IrGlobal *deser_global_new(void)
{
    IrGlobal *g = (IrGlobal *)mem_pool_alloc(sizeof(IrGlobal));
    g->name = 0;
    g->type = 0;
    g->is_static = 0;
    g->is_extern = 0;
    g->has_init = 0;
    g->init_int = 0;
    g->init_str = 0;
    g->init_aggregate = 0;
    g->init_sym = 0;
    g->init_sym_off = 0;
    g->init_sym_is_func = 0;
    g->init_refs = 0;
    g->init_ref_count = 0;
    g->init_float = 0;
    g->is_float = 0;
    g->init_is_complex = 0;
    g->init_float_im = 0;
    g->section = 0;
    g->is_const = 0;
    g->at_addr = 0;
    g->has_at = 0;
    g->align_bytes = 0;
    g->is_used = 0;
    g->is_unused = 0;
    g->is_tls = 0;
    g->global_reg = -1;
    return g;
}

IrProgram *ir_deserialize(const unsigned char *buf, int len, const char *who)
{
    IrR r;
    IrProgram *p;
    Type **types = 0;
    int ntypes = 0, i, k, j;
    int body_len;

    if (!buf || len < 16) {
        diag_tool(DIAG_SEV_ERROR, who,
                  "the IR payload is too short to hold a header", 0,0,0,0,0,0);
        return 0;
    }
    for (i = 0; i < ARK_IR_MAGIC_LEN; i++) {
        if ((char)buf[i] != ARK_IR_MAGIC[i]) {
            diag_tool(DIAG_SEV_ERROR, who,
                      "the IR payload does not start with %s", ARK_IR_MAGIC,
                      0,0,0,0,0);
            return 0;
        }
    }
    r.b = buf + ARK_IR_MAGIC_LEN;
    r.n = len - ARK_IR_MAGIC_LEN;
    r.pos = 0;
    r.err = 0;
    r.why = 0;

    {
        unsigned ver = r_u32(&r);
        char b1[12], b2[12], b3[12];
        body_len = (int)r_u32(&r);
        if (r.err) { r.why = "the payload header is truncated"; goto bad; }
        if (ver != ARK_IR_VERSION) {
            diag_tool(DIAG_SEV_ERROR, who,
                      "the IR payload is version %s but this arkcc reads "
                      "version %s (rebuild the object with this arkcc)",
                      diag_num(b1, (int)ver), diag_num(b2, ARK_IR_VERSION),
                      0,0,0,0);
            return 0;
        }
        if (body_len < 0 || body_len != r.n - r.pos) {
            diag_tool(DIAG_SEV_ERROR, who,
                      "the IR payload says %s body bytes but %s are present",
                      diag_num(b1, body_len), diag_num(b2, r.n - r.pos),
                      0,0,0,0);
            return 0;
        }
    }

    p = ir_program_new();

    /* --- types: allocate first, fill second (forward refs are legal) --- */
    ntypes = (int)r_u32(&r);
    if (r.err) goto bad;
    if (ntypes < 0 || ntypes > r.n) { r.why = "implausible type count"; goto bad; }
    if (ntypes > 0) {
        types = (Type **)mem_pool_alloc((int)sizeof(Type *) * ntypes);
        for (i = 0; i < ntypes; i++) {
            Type *t = (Type *)mem_pool_alloc(sizeof(Type));
            t->kind = TYPE_VOID;
            t->base = 0;
            t->size = 0;
            t->is_unsigned = 0;
            t->is_variadic = 0;
            t->tag = 0;
            t->fields = 0;
            t->params = 0;
            t->param_count = 0;
            t->is_packed = 0;
            t->align_override = 0;
            t->is_vla = 0;
            t->is_volatile = 0;
            t->is_const = 0;
            t->is_atomic = 0;
            t->is_func_ptr = 0;
            t->bf_break = 0;
            t->enumerators = 0;
            t->enumerator_count = 0;
            types[i] = t;
        }
    }
    for (i = 0; i < ntypes; i++) {
        Type *t = types[i];
        int base, nf, np, ne;
        int kind = (int)r_u32(&r);
        if (r.err) goto bad;
        if (kind < 0 || kind > (int)TYPE_COMPLEX) {
            r.why = "a type record has an unknown kind";
            goto bad;
        }
        t->kind = (ValueType)kind;
        base = r_i32(&r);
        if (r.err) goto bad;
        if (base < -1 || base >= ntypes) { r.why = "a type base index is out of range"; goto bad; }
        t->base = (base >= 0) ? types[base] : 0;
        t->size = r_i32(&r);
        t->is_unsigned = r_i32(&r);
        t->is_variadic = r_i32(&r);
        t->tag = (char *)r_str(&r);
        t->is_packed = r_i32(&r);
        t->align_override = r_i32(&r);
        t->is_vla = r_i32(&r);
        t->is_volatile = r_i32(&r);
        t->is_const = r_i32(&r);
        t->is_atomic = r_i32(&r);
        t->is_func_ptr = r_i32(&r);
        t->bf_break = r_i32(&r);
        if (r.err) goto bad;
        nf = (int)r_u32(&r);
        if (r.err) goto bad;
        if (nf < 0 || nf > r.n) { r.why = "implausible struct field count"; goto bad; }
        if (nf > 0) {
            StructField *head = 0, *tail = 0;
            for (k = 0; k < nf; k++) {
                StructField *fd = (StructField *)mem_pool_alloc(sizeof(StructField));
                int ti;
                fd->name = (char *)r_str(&r);
                ti = r_i32(&r);
                if (r.err) goto bad;
                if (ti < -1 || ti >= ntypes) { r.why = "a struct field's type index is out of range"; goto bad; }
                fd->type = (ti >= 0) ? types[ti] : 0;
                fd->offset = r_i32(&r);
                fd->bit_offset = r_i32(&r);
                fd->bit_width = r_i32(&r);
                fd->next = 0;
                if (r.err) goto bad;
                if (tail) tail->next = fd; else head = fd;
                tail = fd;
            }
            t->fields = head;
        }
        np = (int)r_u32(&r);
        if (r.err) goto bad;
        if (np < 0 || np > r.n) { r.why = "implausible parameter count"; goto bad; }
        if (np > 0) {
            t->params = (Type **)mem_pool_alloc((int)sizeof(Type *) * np);
            for (k = 0; k < np; k++) {
                int ti = r_i32(&r);
                if (r.err) goto bad;
                if (ti < -1 || ti >= ntypes) { r.why = "a parameter type index is out of range"; goto bad; }
                t->params[k] = (ti >= 0) ? types[ti] : 0;
            }
        }
        t->param_count = r_i32(&r);
        ne = (int)r_u32(&r);
        if (r.err) goto bad;
        if (ne < 0 || ne > r.n) { r.why = "implausible enumerator count"; goto bad; }
        if (ne > 0) {
            EnumConst *head = 0, *tail = 0;
            for (k = 0; k < ne; k++) {
                EnumConst *ec = (EnumConst *)mem_pool_alloc(sizeof(EnumConst));
                ec->name = (char *)r_str(&r);
                ec->value = r_i64(&r);
                ec->next = 0;
                if (r.err) goto bad;
                if (tail) tail->next = ec; else head = ec;
                tail = ec;
            }
            t->enumerators = head;
        }
        t->enumerator_count = r_i32(&r);
        if (r.err) goto bad;
    }

    /* --- string pool --- */
    {
        int n = (int)r_u32(&r);
        if (r.err) goto bad;
        if (n < 0 || n > r.n) { r.why = "implausible string count"; goto bad; }
        for (i = 0; i < n; i++) {
            unsigned slen = r_u32(&r);
            char *data;
            int is_wide, id;
            if (r.err) goto bad;
            if (slen > (unsigned)(r.n - r.pos)) {
                r.why = "a string literal runs past the end of the payload";
                goto bad;
            }
            data = (char *)mem_pool_alloc((int)slen + 1);
            for (k = 0; k < (int)slen; k++) data[k] = (char)r.b[r.pos + k];
            data[slen] = 0;
            r.pos += (int)slen;
            is_wide = (int)r_u32(&r);
            id = (int)r_u32(&r);
            if (r.err) goto bad;
            {
                int idx = ir_program_add_string(p, data, (int)slen);
                p->strings[idx]->is_wide = is_wide;
                p->strings[idx]->id = id;
            }
        }
    }

    /* --- float pool --- */
    {
        int n = (int)r_u32(&r);
        if (r.err) goto bad;
        if (n < 0 || n > r.n) { r.why = "implausible float pool count"; goto bad; }
        for (i = 0; i < n; i++) {
            double d = r_f64(&r);
            if (r.err) goto bad;
            ir_program_add_float(p, d);
        }
    }

    /* --- complex pool --- */
    {
        int n = (int)r_u32(&r);
        if (r.err) goto bad;
        if (n < 0 || n > r.n) { r.why = "implausible complex pool count"; goto bad; }
        for (i = 0; i < n; i++) {
            double re = r_f64(&r);
            double im = r_f64(&r);
            if (r.err) goto bad;
            ir_program_add_complex(p, re, im);
        }
    }

    /* --- IR_CALL argument-size table --- */
    {
        int n = (int)r_u32(&r);
        if (r.err) goto bad;
        if (n < 0 || n * 4 > r.n) { r.why = "implausible argument-size table count"; goto bad; }
        for (i = 0; i < n; i++) {
            int v = r_i32(&r);
            if (r.err) goto bad;
            ir_program_add_argbytes(p, &v, 1);
        }
    }

    p->source_file = r_str(&r);
    if (r.err) goto bad;

    /* --- globals --- */
    {
        int n = (int)r_u32(&r);
        if (r.err) goto bad;
        if (n < 0 || n > r.n) { r.why = "implausible global count"; goto bad; }
        for (i = 0; i < n; i++) {
            IrGlobal *g = deser_global_new();
            int ti;
            g->name = (char *)r_str(&r);
            ti = r_i32(&r);
            if (r.err) goto bad;
            if (ti < -1 || ti >= ntypes) { r.why = "a global's type index is out of range"; goto bad; }
            g->type = (ti >= 0) ? types[ti] : 0;
            g->is_static = r_i32(&r);
            g->is_extern = r_i32(&r);
            g->has_init = r_i32(&r);
            g->init_int = r_i64(&r);
            g->init_str = (char *)r_str(&r);
            g->init_aggregate = (char *)r_str(&r);
            g->init_sym = (char *)r_str(&r);
            g->init_sym_off = r_i64(&r);
            g->init_sym_is_func = r_i32(&r);
            {
                int nr = (int)r_u32(&r);
                if (r.err) goto bad;
                if (nr < 0 || nr > r.n) { r.why = "implausible aggregate address count"; goto bad; }
                if (nr > 0) {
                    g->init_refs = (IrSymRef *)mem_pool_alloc((int)sizeof(IrSymRef) * nr);
                    g->init_ref_count = nr;
                    for (j = 0; j < nr; j++) {
                        g->init_refs[j].offset = r_i32(&r);
                        g->init_refs[j].sym = (char *)r_str(&r);
                        g->init_refs[j].add = r_i64(&r);
                        g->init_refs[j].is_func = r_i32(&r);
                        g->init_refs[j].str = (char *)r_str(&r);
                        if (r.err) goto bad;
                    }
                }
            }
            g->init_ref_count = r_i32(&r);
            g->init_float = r_f64(&r);
            g->is_float = r_i32(&r);
            g->init_is_complex = r_i32(&r);
            g->init_float_im = r_f64(&r);
            g->section = (char *)r_str(&r);
            g->is_const = r_i32(&r);
            g->at_addr = r_u32(&r);
            g->has_at = r_i32(&r);
            g->align_bytes = r_i32(&r);
            g->is_used = r_i32(&r);
            g->is_unused = r_i32(&r);
            g->is_tls = r_i32(&r);
            g->global_reg = r_i32(&r);
            if (r.err) goto bad;
            ir_program_add_global_ptr(p, g);
        }
    }

    /* --- functions --- */
    {
        int n = (int)r_u32(&r);
        if (r.err) goto bad;
        if (n < 0 || n > r.n) { r.why = "implausible function count"; goto bad; }
        for (i = 0; i < n; i++) {
            const char *nm = r_str(&r);
            int ncode = (int)r_u32(&r);
            IrFunc *f;
            if (r.err) goto bad;
            if (!nm) { r.why = "a function record has no name"; goto bad; }
            if (ncode < 0 || ncode * 24 > r.n) { r.why = "implausible instruction count"; goto bad; }
            f = deser_func_new(nm, ncode);
            for (k = 0; k < ncode; k++) {
                IrInst *I = &f->code[k];
                int op = (int)r_u32(&r);
                if (r.err) goto bad;
                if (op < 0 || op >= (int)IR_OP_COUNT) { r.why = "an instruction has an unknown opcode"; goto bad; }
                I->op = (IrOp)op;
                I->val = r_i64(&r);
                I->name = r_str(&r);
                I->aux = r_i32(&r);
                I->line = r_i32(&r);
                I->aux2 = r_i32(&r);
                if (r.err) goto bad;
                switch (I->op) {
                case IR_PUSH_STR:
                    if (I->val < 0 || I->val >= p->string_count) {
                        r.why = "IR_PUSH_STR refers past the string pool";
                        goto bad;
                    }
                    break;
                case IR_PUSH_FLOAT: {
                    int lim = (I->aux & IR_AUX_COMPLEX) ? p->complex_count : p->float_count;
                    if (I->val < 0 || I->val >= lim) {
                        r.why = "IR_PUSH_FLOAT refers past its constant pool";
                        goto bad;
                    }
                    break;
                }
                case IR_CALL:
                    if (I->aux2 < 0 ||
                        (I->aux2 > 0 && I->aux2 - 1 >= p->argbytes_count)) {
                        r.why = "IR_CALL refers past the argument-size table";
                        goto bad;
                    }
                    break;
                default:
                    break;
                }
            }
            f->local_size = r_i32(&r);
            f->label_count = r_i32(&r);
            f->param_count = r_i32(&r);
            f->is_variadic = r_i32(&r);
            f->is_static = r_i32(&r);
            f->is_irq = r_i32(&r);
            f->is_weak = r_i32(&r);
            f->is_naked = r_i32(&r);
            f->is_used = r_i32(&r);
            f->is_unused = r_i32(&r);
            f->is_asm_func = r_i32(&r);
            f->forceinline = r_i32(&r);
            f->is_inline = r_i32(&r);
            f->is_constructor = r_i32(&r);
            f->is_destructor = r_i32(&r);
            f->is_deprecated = r_i32(&r);
            f->is_value_in_regs = r_i32(&r);
            f->is_pure = r_i32(&r);
            f->is_const_attr = r_i32(&r);
            f->is_interwork = r_i32(&r);
            f->smc_num = r_i32(&r);
            f->global_reg = r_i32(&r);
            f->alias_target = (char *)r_str(&r);
            f->asm_body = (char *)r_str(&r);
            {
                int pn = r_i32(&r);
                if (r.err) goto bad;
                if (pn < 0 || pn > r.n) { r.why = "implausible parameter-name count"; goto bad; }
                if (pn > 0) {
                    f->param_names = (char **)mem_pool_alloc((int)sizeof(char *) * pn);
                    f->param_names_count = pn;
                    for (j = 0; j < pn; j++)
                        f->param_names[j] = (char *)r_str(&r);
                }
            }
            {
                int np = (int)r_u32(&r);
                if (r.err) goto bad;
                if (np < 0 || np > r.n) { r.why = "implausible parameter count"; goto bad; }
                if (np > 0) {
                    f->param_types = (Type **)mem_pool_alloc((int)sizeof(Type *) * np);
                    for (j = 0; j < np; j++) {
                        int ti = r_i32(&r);
                        if (r.err) goto bad;
                        if (ti < -1 || ti >= ntypes) { r.why = "a parameter type index is out of range"; goto bad; }
                        f->param_types[j] = (ti >= 0) ? types[ti] : 0;
                    }
                }
                if (f->param_count > 0 && np != f->param_count)
                    f->param_count = np;   /* keep the two views consistent */
            }
            {
                int ti = r_i32(&r);
                if (r.err) goto bad;
                if (ti < -1 || ti >= ntypes) { r.why = "a return type index is out of range"; goto bad; }
                f->ret_type = (ti >= 0) ? types[ti] : 0;
            }
            ir_program_add(p, f);
        }
    }

    if (r.err) goto bad;
    if (r.pos != r.n) {
        r.why = "the payload has trailing bytes no record accounts for";
        goto bad;
    }
    return p;

bad:
    diag_tool(DIAG_SEV_ERROR, who,
              "the IR payload in this object is unusable: %s",
              r.why ? r.why : "truncated or inconsistent", 0,0,0,0,0);
    return 0;
}

/* ------------------------------------------------------------------ */
/* Merge into a destination program                                    */
/* ------------------------------------------------------------------ */

static void append_global_ptr(IrProgram *dst, IrGlobal *g)
{
    ir_program_add_global_ptr(dst, g);
}

void ir_program_append_unit(IrProgram *dst, IrProgram *unit, int unit_index,
                            const char *who)
{
    int str_base = dst->string_count;
    int float_base = dst->float_count;
    int cx_base = dst->complex_count;
    int ab_base = dst->argbytes_count;
    int i, k;

    for (i = 0; i < unit->string_count; i++) {
        IrString *s = unit->strings[i];
        int idx = ir_program_add_string(dst, s->data, s->len);
        dst->strings[idx]->is_wide = s->is_wide;
        dst->strings[idx]->id = idx;
    }
    for (i = 0; i < unit->float_count; i++)
        ir_program_add_float(dst, unit->floats[i]);
    for (i = 0; i < unit->complex_count; i++)
        ir_program_add_complex(dst, unit->complexes[i].re, unit->complexes[i].im);
    for (i = 0; i < unit->argbytes_count; i++) {
        int v = unit->argbytes[i];
        ir_program_add_argbytes(dst, &v, 1);
    }

    for (i = 0; i < unit->global_count; i++)
        append_global_ptr(dst, unit->globals[i]);

    for (i = 0; i < unit->func_count; i++) {
        IrFunc *f = unit->funcs[i];
        for (k = 0; k < f->code_count; k++) {
            IrInst *I = &f->code[k];
            switch (I->op) {
            case IR_PUSH_STR:
                I->val += str_base;
                if (I->val < 0 || I->val >= dst->string_count) {
                    char b1[12], b2[12];
                    char b3[12];
                    diag_tool(DIAG_SEV_ERROR, who,
                              "internal error: a string pool reference (index %s of %s) "
                              "went out of range while merging unit %s",
                              diag_num(b1, (int)I->val),
                              diag_num(b2, dst->string_count),
                              diag_num(b3, unit_index), 0,0,0);
                    I->val = 0;
                }
                break;
            case IR_PUSH_FLOAT:
                if (I->aux & IR_AUX_COMPLEX) I->val += cx_base;
                else I->val += float_base;
                break;
            case IR_CALL:
                if (I->aux2 > 0) I->aux2 += ab_base;
                break;
            default:
                break;
            }
        }
        ir_program_add(dst, f);
    }
}

/* ------------------------------------------------------------------ */
/* The payload of the unit being compiled                              */
/* ------------------------------------------------------------------ */

/* One buffer, reused across translation units (a board `cc --pack` compiles
 * several sources in one process).  It lives in the arena, so it is
 * re-allocated whenever mem_pool_reset() has moved the arena -- the pointer
 * from a previous unit is not merely stale data, it is a stale address. */
static unsigned char *g_ir_payload;
static int g_ir_payload_len;
static int g_ir_payload_gen = -1;

void ir_stash_payload(IrProgram *p, const char *who)
{
    int gen = mem_pool_generation();
    if (g_ir_payload_gen != gen) {
        g_ir_payload = (unsigned char *)mem_pool_alloc(ARK_OBJ_BUF_SIZE);
        g_ir_payload_gen = gen;
    }
    g_ir_payload_len = ir_serialize(p, g_ir_payload, ARK_OBJ_BUF_SIZE, who);
}

const unsigned char *ir_stashed_payload(int *len)
{
    if (len) *len = g_ir_payload_len > 0 ? g_ir_payload_len : 0;
    return g_ir_payload_len > 0 ? g_ir_payload : 0;
}

/* ------------------------------------------------------------------ */
/* Object-file payload locator                                         */
/* ------------------------------------------------------------------ */

static unsigned obj_u32(const unsigned char *b)
{
    return (unsigned)b[0] | ((unsigned)b[1] << 8) |
           ((unsigned)b[2] << 16) | ((unsigned)b[3] << 24);
}

int ir_obj_find_payload(const unsigned char *obj, int obj_len, int want_payload,
                        const unsigned char **payload, int *plen,
                        const char *who)
{
    int pos = 8;
    int code_sz, sym_cnt, reloc_cnt, i;

    if (payload) *payload = 0;
    if (plen) *plen = 0;
    if (!obj || obj_len < 8) return -1;

    /* Code section. */
    if (pos + 4 > obj_len) return -1;
    code_sz = (int)obj_u32(obj + pos); pos += 4;
    if (code_sz < 0 || pos + code_sz > obj_len) {
        diag_tool(DIAG_SEV_ERROR, who,
                  "the object's code size runs past the end of the file", 0,0,0,0,0,0);
        return -1;
    }
    pos += code_sz;

    /* Symbol table: count then (name_len, name, offset, type, weak) each. */
    if (pos + 4 > obj_len) {
        diag_tool(DIAG_SEV_ERROR, who,
                  "the object ends before its symbol table", 0,0,0,0,0,0);
        return -1;
    }
    sym_cnt = (int)obj_u32(obj + pos); pos += 4;
    if (sym_cnt < 0) return -1;
    for (i = 0; i < sym_cnt; i++) {
        int nl;
        if (pos + 4 > obj_len) return -1;
        nl = (int)obj_u32(obj + pos); pos += 4;
        if (nl < 0 || pos + nl + 6 > obj_len) {
            diag_tool(DIAG_SEV_ERROR, who,
                      "a symbol table entry runs past the end of the file", 0,0,0,0,0,0);
            return -1;
        }
        pos += nl + 4 + 1 + 1;
    }

    /* Relocation table: count then (name_len, name, offset, type) each. */
    if (pos + 4 > obj_len) {
        diag_tool(DIAG_SEV_ERROR, who,
                  "the object ends before its relocation table", 0,0,0,0,0,0);
        return -1;
    }
    reloc_cnt = (int)obj_u32(obj + pos); pos += 4;
    if (reloc_cnt < 0) return -1;
    for (i = 0; i < reloc_cnt; i++) {
        int nl;
        if (pos + 4 > obj_len) return -1;
        nl = (int)obj_u32(obj + pos); pos += 4;
        if (nl < 0 || pos + nl + 5 > obj_len) {
            diag_tool(DIAG_SEV_ERROR, who,
                      "a relocation table entry runs past the end of the file", 0,0,0,0,0,0);
            return -1;
        }
        pos += nl + 4 + 1;
    }

    if (pos == obj_len) {
        /* A complete object with nothing after the relocation table: built
         * without --obj-ir.  Not a corruption, but --lto cannot use it. */
        if (want_payload) {
            diag_tool(DIAG_SEV_ERROR, who,
                      "this object carries no IR payload, so -link --lto cannot "
                      "use it; rebuild it with -c --obj-ir", 0,0,0,0,0,0);
            return -1;
        }
        return 0;
    }
    if (pos + 16 > obj_len) {
        char b1[12], b2[12];
        diag_tool(DIAG_SEV_ERROR, who,
                  "the object has %s trailing bytes after its relocation table; "
                  "they are too short to be an IR payload header",
                  diag_num(b1, obj_len - pos), diag_num(b2, 16), 0,0,0,0);
        return -1;
    }
    for (i = 0; i < ARK_IR_MAGIC_LEN; i++) {
        if ((char)obj[pos + i] != ARK_IR_MAGIC[i]) {
            diag_tool(DIAG_SEV_ERROR, who,
                      "the bytes after the relocation table are not an IR payload "
                      "(no %s header)", ARK_IR_MAGIC, 0,0,0,0,0);
            return -1;
        }
    }
    {
        unsigned ver = obj_u32(obj + pos + 8);
        int blen = (int)obj_u32(obj + pos + 12);
        if (ver != ARK_IR_VERSION) {
            char b1[12], b2[12];
            diag_tool(DIAG_SEV_ERROR, who,
                      "the object's IR payload is version %s but this arkcc reads "
                      "version %s; rebuild the object",
                      diag_num(b1, (int)ver), diag_num(b2, ARK_IR_VERSION),
                      0,0,0,0);
            return -1;
        }
        if (blen < 0 || pos + 16 + blen != obj_len) {
            diag_tool(DIAG_SEV_ERROR, who,
                      "the object's IR payload length does not match the file "
                      "(the object is truncated or was written by a different "
                      "version)", 0,0,0,0,0,0);
            return -1;
        }
        if (payload) *payload = obj + pos;
        if (plen) *plen = 16 + blen;
    }
    return 1;
}

#else /* !ARKCC_FEATURE_OBJ_IR */

/* A trimmed build still defines the two functions the driver calls
 * unconditionally, so the option-parser's refusal is the only thing that has
 * to be true.  They never produce or return a payload: --obj-ir cannot be
 * parsed in this build, so nothing can reach them. */
void ir_stash_payload(IrProgram *p, const char *who)
{
    (void)p;
    (void)who;
}

const unsigned char *ir_stashed_payload(int *len)
{
    if (len) *len = 0;
    return 0;
}

#endif /* ARKCC_FEATURE_OBJ_IR */