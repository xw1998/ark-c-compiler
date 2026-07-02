/* Ark C Compiler - flash_fs.h
 * Filesystem abstraction layer: the compiler reads source code uniformly via fs_read_file.
 * Host uses stdio; STM32 uses W25Q SPI Flash.
 */
#ifndef ARK_FLASH_FS_H
#define ARK_FLASH_FS_H

#include "common.h"

/* Read the entire file into buf. Returns byte count read; -1 on failure.
 * If file is larger than max_len-1, it is truncated and buf is guaranteed NUL-terminated.
 */
int fs_read_file(const char *path, char *buf, int max_len);

/* Write binary data to output file/Flash. Returns bytes written; -1 on failure.
 * path "-" means stdout (host) or callback (STM32).
 */
int fs_write_file(const char *path, const unsigned char *data, int len);

/* List all files on the flash FS (STM32 only; prints via ark_log).
 * Returns the number of files found.
 */
int fs_list_files(void);

#endif /* ARK_FLASH_FS_H */
