/* feat_func_attr.c - __func__, __noreturn__, unused
 * Expected: __func__ string length 4 ("main") + 1 = 5
 */
static int unused_helper(void) __attribute__((unused));
static int unused_helper(void) { return 0; }

int main(void) {
    const char *name = __func__;
    int len = 0;
    while (name[len] != '\0') len++;
    return len + 1;  /* "main" -> 4 + 1 = 5 */
}
