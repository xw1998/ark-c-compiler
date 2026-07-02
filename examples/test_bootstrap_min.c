/* Minimal bootstrap typedef test */

typedef enum {
    TYPE_INT = 0,
    TYPE_PTR
} ValueType;

typedef struct StructField {
    char *name;
    struct Type *type;
    int offset;
} StructField;

typedef struct Type {
    ValueType kind;
    struct Type *base;
    StructField *fields;
} Type;

int main(void) {
    return 0;
}
