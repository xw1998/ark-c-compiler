/* Trigraph test: ??( -> [, ??) -> ], ??= -> # */
/* Written with trigraph syntax to verify preprocessor substitution */
int main(void) {
    int a??(5??) = {1, 2, 3, 4, 5};
    return a??(0??) + a??(4??);  /* 1 + 5 = 6 */
}
