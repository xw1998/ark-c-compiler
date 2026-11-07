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

/* --- RAM-resident file slots ------------------------------------------
 * The on-board compiler is a closed loop: -c writes an object, -link reads
 * it back through fs_read_file().  A bare board has no flash filesystem, so
 * the objects (and the .c / .sct inputs they came from) live in these
 * slots.  Flat names only, RAM first, flash second. */
#define RAMFS_SLOTS     8
#define RAMFS_SLOT_SIZE 8192
typedef struct {
    char name[24];
    int  len;
    char data[RAMFS_SLOT_SIZE];
} RamFile;
static RamFile s_ram[RAMFS_SLOTS];
static int my_streq(const char *a, const char *b);   /* defined below */

void fs_ram_clear(void) {
    int i;
    for (i = 0; i < RAMFS_SLOTS; i++) { s_ram[i].name[0] = 0; s_ram[i].len = 0; }
}

int fs_ram_count(void) {
    int i, n = 0;
    for (i = 0; i < RAMFS_SLOTS; i++) if (s_ram[i].name[0]) n++;
    return n;
}

const char *fs_ram_name_at(int i) {
    if (i < 0 || i >= RAMFS_SLOTS || !s_ram[i].name[0]) return 0;
    return s_ram[i].name;
}

int fs_ram_size_at(int i) {
    if (i < 0 || i >= RAMFS_SLOTS || !s_ram[i].name[0]) return -1;
    return s_ram[i].len;
}

static RamFile *ram_find(const char *name) {
    int i;
    if (!name) return 0;
    for (i = 0; i < RAMFS_SLOTS; i++) {
        if (!s_ram[i].name[0]) continue;
        if (my_streq(s_ram[i].name, name)) return &s_ram[i];
    }
    return 0;
}

/* Stores a file in RAM.  len < 0 means "data is a NUL-terminated string".
 * Returns bytes stored, or -1 when the name is too long / the slot set is
 * full / the payload does not fit -- never a silent truncation. */
int fs_ram_put(const char *name, const char *data, int len) {
    RamFile *f;
    int i, n;
    if (!name || !data) return -1;
    n = 0; while (name[n]) { if (n >= 22) return -1; n++; }
    if (len < 0) { len = 0; while (data[len]) len++; }
    if (len > RAMFS_SLOT_SIZE) return -1;
    f = ram_find(name);
    if (!f) {
        for (i = 0; i < RAMFS_SLOTS; i++) if (!s_ram[i].name[0]) { f = &s_ram[i]; break; }
        if (!f) return -1;
        for (i = 0; i <= n; i++) f->name[i] = name[i];
    }
    for (i = 0; i < len; i++) f->data[i] = data[i];
    f->len = len;
    return len;
}

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

/* The flash FS knows "not found" but nothing finer, so it reports exactly that
 * much; callers must not read it as a syscall errno. */
const char *fs_last_error(void) {
    return "No such file or directory";
}

int fs_read_file(const char *path, char *buf, int max_len) {
    int i;
    RamFile *rf;
    if (!path || !buf || max_len <= 0) return -1;
    rf = ram_find(path);
    if (rf) {
        int len = rf->len;
        if (len > max_len - 1) len = max_len - 1;
        for (i = 0; i < len; i++) buf[i] = rf->data[i];
        buf[len] = 0;
        return len;
    }
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

/* Size of a file in the flash directory, or -1 if it is not there. */
int fs_file_size(const char *path) {
    int i;
    RamFile *rf;
    if (!path) return -1;
    rf = ram_find(path);
    if (rf) return rf->len;
    ensure_table();
    for (i = 0; i < MAX_FILES; i++) {
        if (s_table[i].name[0] == 0) continue;
        if (my_streq(s_table[i].name, path))
            return (int)s_table[i].size;
    }
    return -1;
}

/* List all files on the flash FS to UART via ark_log.
 * Returns the number of files found. */
int fs_list_files(void) {
    int i;
    int count = 0;
    for (i = 0; i < RAMFS_SLOTS; i++) {
        if (!s_ram[i].name[0]) continue;
        ark_log("  %s %d bytes (ram)\r\n", s_ram[i].name, s_ram[i].len);
        count++;
    }
    ensure_table();
    for (i = 0; i < MAX_FILES; i++) {
        if (s_table[i].name[0] == 0) continue;
        ark_log("  %s %d bytes (flash)\r\n", s_table[i].name, (int)s_table[i].size);
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
