/* Ark C Compiler - flash_fs_stm32
 * W25Q SPI Flash based filesystem implementation (placeholder / pseudo-code).
 *
 * This implementation assumes the Flash header holds a file index table with 32-byte entries:
 *   struct FileEntry { char name[24]; uint32_t offset; uint32_t size; };
 * A host-side tool is responsible for building and flashing this index.
 */
#include "flash_fs.h"
#include "platform.h"

/* Provided by the BSP when porting: */
extern void W25Q_Read(unsigned int addr, unsigned char *buf, unsigned int len);

#define MAX_FILES   32
#define FILE_TABLE_ADDR 0x000000

typedef struct {
    char         name[24];
    unsigned int offset;
    unsigned int size;
} FileEntry;

static FileEntry s_table[MAX_FILES];
static int       s_table_loaded = 0;

static int my_streq(const char *a, const char *b) {
    while (*a && *b) {
        if (*a != *b) return 0;
        a++; b++;
    }
    return *a == 0 && *b == 0;
}

static void ensure_table(void) {
    if (s_table_loaded) return;
    W25Q_Read(FILE_TABLE_ADDR, (unsigned char *)s_table, (unsigned int)sizeof(s_table));
    s_table_loaded = 1;
}

int fs_read_file(const char *path, char *buf, int max_len) {
    int i;
    if (!path || !buf || max_len <= 0) return -1;
    ensure_table();
    for (i = 0; i < MAX_FILES; i++) {
        if (s_table[i].name[0] == 0) continue;
        if (my_streq(s_table[i].name, path)) {
            unsigned int len = s_table[i].size;
            if ((int)len > max_len - 1) len = (unsigned int)(max_len - 1);
            W25Q_Read(s_table[i].offset, (unsigned char *)buf, len);
            buf[len] = 0;
            return (int)len;
        }
    }
    return -1;
}

/* List all files on the flash FS to UART via ark_log.
 * Returns the number of files found. */
int fs_list_files(void) {
    int i;
    int count = 0;
    ensure_table();
    for (i = 0; i < MAX_FILES; i++) {
        if (s_table[i].name[0] == 0) continue;
        ark_log("  %-24s  %u bytes\r\n", (int)s_table[i].name, (int)s_table[i].size);
        count++;
    }
    if (count == 0) {
        ark_log("  (no files found)\r\n");
    }
    return count;
}

/* On STM32: write to Flash or return to the caller.
 * Placeholder implementation: returns the compilation result via callback or a global pointer.
 * When porting, replace this with Flash programming or a RAM copy. */

/* Default weak implementation of arkcc_on_output: dumps hex over UART via ark_log.
 * The user (e.g. MDK main.c) can override this by providing a strong definition. */
__attribute__((weak)) void arkcc_on_output(const unsigned char *data, int len) {
    int i;
    for (i = 0; i < len; i++) {
        char hex[4];
        int v = data[i];
        int hi = (v >> 4) & 0xf;
        int lo = v & 0xf;
        hex[0] = (char)(hi < 10 ? '0' + hi : 'A' + hi - 10);
        hex[1] = (char)(lo < 10 ? '0' + lo : 'A' + lo - 10);
        hex[2] = ' ';
        hex[3] = 0;
        ark_log("%s", hex);
    }
    ark_log("\n");
}

int fs_write_file(const char *path, const unsigned char *data, int len) {
    (void)path;
    if (!data || len < 0) return -1;
    /* path is "-" or any path: uniformly return the compilation result via callback.
     * Porters can inspect path here and write to the corresponding W25Q region. */
    arkcc_on_output(data, len);
    return len;
}
