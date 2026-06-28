/* Ark C Compiler - type.h
 * 类型系统：基础类型 + 指针 + 数组 + 结构体/联合体 + 函数类型。
 */
#ifndef ARK_TYPE_H
#define ARK_TYPE_H

#include "common.h"

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
    TYPE_WCHAR,     /* 宽字符 wchar_t（B2） */
    TYPE_COMPLEX    /* _Complex 复数（B4）：base 指向 float/double */
} ValueType;

typedef struct StructField {
    char               *name;
    struct Type        *type;
    int                 offset;
    int                 bit_offset;   /* 位域起始位（仅 packed 信息透传） */
    int                 bit_width;    /* 位域宽度；0 表示非位域 */
    struct StructField *next;
} StructField;

typedef struct Type {
    ValueType    kind;
    struct Type *base;       /* PTR/ARRAY 的元素类型；FUNC 的返回类型；COMPLEX 的实数类型 */
    int          size;       /* 数组长度；struct/union 的总字节数 */
    int          is_unsigned;
    int          is_variadic;/* 函数：是否可变参 */
    char        *tag;        /* struct/union/enum tag */
    StructField *fields;     /* struct/union 字段链 */
    struct Type **params;    /* 函数参数类型数组 */
    int          param_count;
    int          is_packed;       /* __attribute__((packed)) */
    int          align_override;  /* __attribute__((aligned(N))) 显式对齐，0=默认 */
    int          is_vla;          /* 变长数组标记（B3）：运行时分配 */
} Type;

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
Type *type_func(Type *ret, Type **params, int pc, int variadic);
Type *type_wchar(void);                       /* B2: wchar_t */
Type *type_complex(Type *base);               /* B4: _Complex base（base 为 float/double）*/

void  type_struct_add_field(Type *st, const char *name, Type *ft);
void  type_struct_add_bitfield(Type *st, const char *name, Type *ft, int width);
/* 匿名 struct/union 字段提升：把 child 中所有具名字段以其相对偏移
 * 复制到 parent 中（相对偏移加上 parent 当前 size 决定的基址）。
 * child 本身视为一个匿名块占用空间，parent->size 增加 child 大小。
 * 用于支持 CMSIS 大量使用的匿名 struct/union 嵌套。 */
void  type_struct_add_anonymous(Type *parent, Type *child);

int   type_size(Type *t);
int   type_align(Type *t);
int   type_equal(Type *a, Type *b);
int   type_is_scalar(Type *t);
int   type_is_integer(Type *t);
int   type_is_arith(Type *t);

StructField *type_find_field(Type *t, const char *name);

/* #pragma pack(n) 全局对齐控制 */
void type_set_pack(int n);
int  type_get_pack(void);

#endif /* ARK_TYPE_H */
