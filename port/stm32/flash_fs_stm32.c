/* Ark C Compiler - flash_fs_stm32
 * 基于 W25Q SPI Flash 的文件系统实现（占位伪代码）。
 *
 * 该实现假设 Flash 头部存有一个 32 字节/项的文件索引表：
 *   struct FileEntry { char name[24]; uint32_t offset; uint32_t size; };
 * 用户上位机工具负责构造并烧录此索引。
 */
#include "flash_fs.h"
#include "platform.h"

/* 移植时由 BSP 提供： */
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
