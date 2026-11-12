/* Ark C Compiler stdlib - errno.h
 * C99 7.5: error numbers. */
#ifndef ARK_ERRNO_H
#define ARK_ERRNO_H

extern int errno;

#define EDOM        1
#define ERANGE      2
#define EILSEQ      3
#define EINVAL      4
#define ENOENT      5
#define ENOMEM      6
#define EACCES      7
#define EEXIST      8
#define EAGAIN      11
/* The numbers below are Ark's own values: this header belongs to the target
 * and errno.c says a target with a different numbering scheme replaces it.
 * They are appended, never renumbered, so a program compiled against an
 * older header keeps seeing the same value.  EIO is what the host port
 * reports when a write came up short (port/host/flash_fs_host.c). */
#define EIO         9
#define EBUSY       10
#define EBADF       12
#define ENOSPC      13
#define EROFS       14
#define EISDIR      15
#define ENOTDIR     16
#define EMFILE      17

#endif /* ARK_ERRNO_H */
