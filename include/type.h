/* Ark C Compiler - type.h
 * Type system: basic types + pointer + array + struct/union + function types.
 */
#ifndef ARK_TYPE_H
#define ARK_TYPE_H

#include "common.h"
#include "arkcc_config.h"

typedef enum {
    TYPE_VOID = 0,
    TYPE_CHAR,
    TYPE_SHORT,
    TYPE_INT,
    TYPE_LONG,
    TYPE_LLONG,
    TYPE_BOOL,
    TYPE_FLOAT,
    TYPE_DOUBLE,
    TYPE_PTR,
    TYPE_ARRAY,
    TYPE_STRUCT,
    TYPE_UNION,
    TYPE_FUNC,
    TYPE_ENUM,
    TYPE_WCHAR,     /* wide character wchar_t (B2) */
    TYPE_COMPLEX    /* _Complex (B4): base points to float/double */
} ValueType;

typedef struct StructField {
    char               *name;
    struct Type        *type;
    int                 offset;
    int                 bit_offset;   /* bitfield start bit (packed info passthrough only) */
    int                 bit_width;    /* bitfield width; 0 means non-bitfield */
    struct StructField *next;
} StructField;

/* A `:0` separator met while laying out a struct: `index` is the number of
 * members laid out so far, i.e. the separator sits immediately before member
 * #index of the field list.  type_struct_repack() -- the replay that applies a
 * late `__packed`/`__attribute__((packed))` -- re-inserts it there, so the
 * packed layout keeps the separators the source spelled.  Not serialized: an
 * object file already carries the final offsets, and repack only runs while
 * parsing a definition. */
typedef struct BfBreak {
    int             index;
    struct BfBreak *next;
} BfBreak;

/* One enumerator of an enum type, recorded by the parser.
 *
 * C has no way to enumerate an enum's identifiers after the fact: the symbol
 * table keeps each constant (SYM_ENUM_CONST) with its value but nothing links it
 * back to the enum type it belongs to.  Without this list a pass cannot answer
 * "which values does this enum have?", which is what an exhaustiveness check
 * needs.  The list is built once, at the definition (`enum E { ... }`), and hangs
 * off the defining Type; references to a tagged enum carry only the tag, see
 * type_enum_definition(). */
typedef struct EnumConst {
    char              *name;
    long long          value;
    struct EnumConst  *next;
} EnumConst;

typedef struct Type {
    ValueType    kind;
    struct Type *base;       /* PTR/ARRAY element type; FUNC return type; COMPLEX real type */
    int          size;       /* array length; struct/union total byte count */
    int          is_unsigned;
    int          is_variadic;/* function: whether variadic */
    char        *tag;        /* struct/union/enum tag */
    StructField *fields;     /* struct/union field linked list */
    struct Type **params;    /* function parameter type array */
    int          param_count;
    int          is_packed;       /* __attribute__((packed)) */
    int          align_override;  /* __attribute__((aligned(N))) explicit alignment, 0=default */
    int          is_vla;          /* variable-length array flag (B3): runtime allocated */
    int          is_volatile;     /* volatile type qualifier (F2) */
    int          is_const;        /* const type qualifier (F2) */
    int          is_atomic;       /* C11 _Atomic applied to this type.  Carried in the
                                   * Type (not just the declaration) so that a typedef
                                   * keeps it: `atomic_int x;` must be as atomic as
                                   * `_Atomic int x;`.  Nothing downstream reads it
                                   * except sema's read-modify-write checks -- the
                                   * layout is the underlying type's layout, and the
                                   * atomic operations themselves live in
                                   * <stdatomic.h>. */
    int          is_func_ptr;     /* pointer created by a `(*name)(params)` declarator:
                                   * the pointee is a function, not a data object. */
    int          bf_break;        /* C99 6.7.2.1: width=0 bitfield forces next bitfield to a new storage unit */
    /* TYPE_ENUM only: the enumerator list of the *definition*.  Non-NULL on the
     * Type built by `enum E { A, B }`, NULL on a bare reference (`enum E x;`),
     * which is a fresh Type carrying just the tag.  Appended at the end of the
     * struct so the positional initialisers in type.c keep their meaning. */
    EnumConst   *enumerators;
    int          enumerator_count;
    /* Members of the list above that were preceded by a `:0` separator, in
     * the order they were met.  Appended at the very end so the positional
     * initialisers in type.c keep their meaning; see BfBreak. */
    BfBreak     *bf_breaks;
} Type;

/* ARK_IS_CX(t): does `t` name a _Complex type?  Spelled as a literal 0 in a
 * build without the feature (ARKCC_FEATURE_COMPLEX=0), so `if (ARK_IS_CX(t))`
 * folds to `if (0)` and the optimiser drops the block -- plus, once nothing
 * calls them any more, the four-word value helpers.  That is what makes the
 * gate a real one instead of a #if spread over forty interleaved paths.
 * `_Complex` is refused by the parser in such a build, so the dropped blocks
 * were unreachable; nothing else in arkcc produces a TYPE_COMPLEX type. */
#if ARKCC_FEATURE_COMPLEX
#  define ARK_IS_CX(t) ((t)->kind == TYPE_COMPLEX)
#else
#  define ARK_IS_CX(t) 0
#endif

Type *type_void(void);
Type *type_char(void);
Type *type_short(void);
Type *type_int(void);
Type *type_long(void);
Type *type_llong(void);
Type *type_bool(void);
Type *type_float(void);
Type *type_double(void);
Type *type_uchar(void);
Type *type_ushort(void);
Type *type_uint(void);
Type *type_ulong(void);
Type *type_ullong(void);
Type *type_pointer(Type *base);
Type *type_array(Type *base, int size);
Type *type_struct(const char *tag, int is_union);
Type *type_enum(const char *tag);
/* Append one enumerator to an enum *definition* Type (the one built at
 * `enum E { ... }`).  Also registers the type under its tag so that later
 * references, which are different Types with the same tag, can find the list. */
void  type_enum_add_const(Type *t, const char *name, long long value);
/* The defining Type of an enum, or NULL when there is nothing to enumerate.
 * Anonymous enums are their own definition; tagged ones are looked up by tag
 * (the lookup is generation-checked: a pointer left over from a previous
 * translation unit is never returned, the arena behind it is gone). */
Type *type_enum_definition(Type *t);
Type *type_func(Type *ret, Type **params, int pc, int variadic);
Type *type_wchar(void);                       /* B2: wchar_t */
Type *type_complex(Type *base);               /* B4: _Complex base (base is float/double) */
Type *type_qualified(Type *t, int is_volatile, int is_const); /* F2: qualified copy */
Type *type_atomic(Type *t);   /* C11: atomic-qualified copy (never modifies a singleton) */

void  type_struct_add_field(Type *st, const char *name, Type *ft);
void  type_struct_add_bitfield(Type *st, const char *name, Type *ft, int width);
/* Anonymous struct/union field promotion: copy all named fields from child
 * into parent (relative offset added to the base determined by parent's current size).
 * The child itself occupies space as an anonymous block; parent->size increases by child size.
 * Used to support the anonymous struct/union nesting heavily used by CMSIS. */
void  type_struct_add_anonymous(Type *parent, Type *child);

int   type_size(Type *t);
int   type_align(Type *t);
int   type_equal(Type *a, Type *b);
/* Override pointer size/alignment for the selected backend.
 * Defaults to 4 (32-bit targets); the C backend sets 8 on 64-bit hosts
 * because generated code runs on the host where pointers are 8 bytes.
 * Must be called before parsing/sema/irgen so struct layout matches. */
void  type_set_ptr_size(int bytes);
/* The pointer size the current backend selected (4 or 8). */
int   type_ptr_size(void);
int   type_is_scalar(Type *t);
int   type_is_integer(Type *t);
int   type_is_arith(Type *t);

StructField *type_find_field(Type *t, const char *name);

/* #pragma pack(n) global alignment control */
void type_set_pack(int n);
int  type_get_pack(void);
/* Applies one pack(...) directive; q points at the '('.  Called from the
 * lexer so the value is in effect exactly where the directive appears. */
int  type_pragma_pack(const char *q);
/* Re-lays-out a struct/union after `is_packed` was set post-hoc (the
 * `__packed` prefix or a trailing __attribute__((packed))). */
void type_struct_repack(Type *st);
/* Resets the pack value and its push/pop stack (start of every TU). */
void type_pack_reset(void);

#endif /* ARK_TYPE_H */
