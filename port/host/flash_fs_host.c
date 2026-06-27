/* Ark C Compiler - flash_fs_host
 * Host 端基于 stdio 的文件读取实现。
 */
#include "flash_fs.h"
#include "platform.h"
#include <stdio.h>

int fs_read_file(const char *path, char *buf, int max_len) {
    FILE *fp;
    int n;
    if (!path || !buf || max_len <= 0) return -1;
    fp = fopen(path, "rb");
    if (!fp) return -1;
    n = (int)fread(buf, 1, (size_t)(max_len - 1), fp);
    fclose(fp);
    if (n < 0) n = 0;
    buf[n] = '\0';
    return n;
}
