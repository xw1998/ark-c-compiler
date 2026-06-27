/* feat_multifile_main.c — 多文件分别编译
 * 期望：multifile_a(10) + multifile_b(5) = 20 + 8 = 28
 */
extern int multifile_a(int x);
extern int multifile_b(int x);

int main(void) {
    return multifile_a(10) + multifile_b(5);
}
