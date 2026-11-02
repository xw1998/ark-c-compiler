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

#endif /* ARK_ERRNO_H */
