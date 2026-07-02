/* Ark C Compiler - flash_fs_host
 * Host-side stdio-based file read implementation.
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

int fs_write_file(const char *path, const unsigned char *data, int len) {
    int wr;
    if (!path || !data || len < 0) return -1;
    /* "-" means stdout (default behavior of -E / -S) */
    if (path[0] == '-' && path[1] == 0) {
        wr = (int)fwrite(data, 1, (size_t)len, stdout);
        fflush(stdout);
        return wr;
    }
    {
        FILE *fp = fopen(path, "wb");
        if (!fp) return -1;
        wr = (int)fwrite(data, 1, (size_t)len, fp);
        fclose(fp);
        if (wr != len) return -1;
        return wr;
    }
}

/* Host-side stub: no flash FS listing on host. */
int fs_list_files(void) {
    ark_log("[flash_fs] fs_list_files: not implemented on host\r\n");
    return 0;
}
