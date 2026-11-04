/* Ark C Compiler - flash_fs_host
 * Host-side stdio-based file read implementation.
 */
#include "flash_fs.h"
#include "platform.h"
#include <stdio.h>
#include <errno.h>
#include <string.h>

/* Reason text of the last failed operation; see flash_fs.h. */
static char g_fs_error[128];

static void set_error(int err) {
    const char *s = strerror(err);
    int i;
    if (!s || !s[0]) s = "I/O error";
    for (i = 0; i < (int)sizeof(g_fs_error) - 1 && s[i]; i++) g_fs_error[i] = s[i];
    g_fs_error[i] = 0;
}

const char *fs_last_error(void) {
    return g_fs_error[0] ? g_fs_error : "I/O error";
}

int fs_read_file(const char *path, char *buf, int max_len) {
    FILE *fp;
    int n;
    g_fs_error[0] = 0;
    if (!path || !buf || max_len <= 0) return -1;
    fp = fopen(path, "rb");
    if (!fp) { set_error(errno); return -1; }
    n = (int)fread(buf, 1, (size_t)(max_len - 1), fp);
    fclose(fp);
    if (n < 0) n = 0;
    buf[n] = '\0';
    return n;
}

int fs_file_size(const char *path) {
    FILE *fp;
    long sz;
    g_fs_error[0] = 0;
    if (!path || !path[0]) return -1;
    fp = fopen(path, "rb");
    if (!fp) { set_error(errno); return -1; }
    if (fseek(fp, 0, SEEK_END) != 0) { set_error(errno); fclose(fp); return -1; }
    sz = ftell(fp);
    fclose(fp);
    if (sz < 0) { set_error(errno); return -1; }
    return (int)sz;
}

int fs_write_file(const char *path, const unsigned char *data, int len) {
    int wr;
    g_fs_error[0] = 0;
    if (!path || !data || len < 0) return -1;
    /* "-" means stdout (default behavior of -E / -S) */
    if (path[0] == '-' && path[1] == 0) {
        wr = (int)fwrite(data, 1, (size_t)len, stdout);
        fflush(stdout);
        return wr;
    }
    {
        FILE *fp = fopen(path, "wb");
        if (!fp) { set_error(errno); return -1; }
        wr = (int)fwrite(data, 1, (size_t)len, fp);
        fclose(fp);
        if (wr != len) { g_fs_error[0] = 0; set_error(EIO); return -1; }
        return wr;
    }
}

/* Host-side stub: the host has no flash FS backing store, so a listing is
 * not available. Return -1 (error) rather than 0 (an empty listing) so that
 * callers cannot mistake "not supported" for "no files present". */
int fs_list_files(void) {
    ark_log("[flash_fs] fs_list_files: not implemented on host\r\n");
    return -1;
}
