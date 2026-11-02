/* Regression expectation (machine-checked by examples/run_tests.ps1).
 * typedef/struct forward-reference bootstrap compiles; main returns 0
 * Expected exit code: 0
 */
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
