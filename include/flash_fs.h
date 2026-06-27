/* Ark C Compiler - flash_fs.h
 * 文件系统抽象层：编译器统一通过 fs_read_file 读源代码。
 * Host 端用 stdio 实现；STM32 端用 W25Q SPI Flash 实现。
 */
#ifndef ARK_FLASH_FS_H
#define ARK_FLASH_FS_H

#include "common.h"

/* 读取整个文件到 buf。返回实际字节数；失败返回 -1。
 * 若文件大于 max_len-1，截断并保证 buf 末尾 '\0'。
 */
int fs_read_file(const char *path, char *buf, int max_len);

#endif /* ARK_FLASH_FS_H */
