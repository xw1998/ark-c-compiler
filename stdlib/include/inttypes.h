/* Ark C Compiler stdlib - inttypes.h
 * C99 7.8: printf/scanf format macros for the stdint types.
 * Assumes int is 32-bit and long long is 64-bit, matching the 32-bit host. */
#ifndef ARK_INTTYPES_H
#define ARK_INTTYPES_H

#include <stdint.h>

/* PRIdN / PRIiN */
#define PRId8   "d"
#define PRIi8   "i"
#define PRId16  "d"
#define PRIi16  "i"
#define PRId32  "d"
#define PRIi32  "i"
#define PRId64  "lld"
#define PRIi64  "lli"

/* PRIoN / PRIuN / PRIxN / PRIXN */
#define PRIo8   "o"
#define PRIu8   "u"
#define PRIx8   "x"
#define PRIX8   "X"
#define PRIo16  "o"
#define PRIu16  "u"
#define PRIx16  "x"
#define PRIX16  "X"
#define PRIo32  "o"
#define PRIu32  "u"
#define PRIx32  "x"
#define PRIX32  "X"
#define PRIo64  "llo"
#define PRIu64  "llu"
#define PRIx64  "llx"
#define PRIX64  "llX"

/* PRI* macros for the least width and fast width types */
#define PRIdLEAST8   "d"
#define PRIiLEAST8   "i"
#define PRIoLEAST8   "o"
#define PRIuLEAST8   "u"
#define PRIxLEAST8   "x"
#define PRIXLEAST8   "X"
#define PRIdLEAST16  "d"
#define PRIiLEAST16  "i"
#define PRIoLEAST16  "o"
#define PRIuLEAST16  "u"
#define PRIxLEAST16  "x"
#define PRIXLEAST16  "X"
#define PRIdLEAST32  "d"
#define PRIiLEAST32  "i"
#define PRIoLEAST32  "o"
#define PRIuLEAST32  "u"
#define PRIxLEAST32  "x"
#define PRIXLEAST32  "X"
#define PRIdLEAST64  "lld"
#define PRIiLEAST64  "lli"
#define PRIoLEAST64  "llo"
#define PRIuLEAST64  "llu"
#define PRIxLEAST64  "llx"
#define PRIXLEAST64  "llX"
#define PRIdFAST8    "d"
#define PRIiFAST8    "i"
#define PRIoFAST8    "o"
#define PRIuFAST8    "u"
#define PRIxFAST8    "x"
#define PRIXFAST8    "X"
#define PRIdFAST16   "d"
#define PRIiFAST16   "i"
#define PRIoFAST16   "o"
#define PRIuFAST16   "u"
#define PRIxFAST16   "x"
#define PRIXFAST16   "X"
#define PRIdFAST32   "d"
#define PRIiFAST32   "i"
#define PRIoFAST32   "o"
#define PRIuFAST32   "u"
#define PRIxFAST32   "x"
#define PRIXFAST32   "X"
#define PRIdFAST64   "lld"
#define PRIiFAST64   "lli"
#define PRIoFAST64   "llo"
#define PRIuFAST64   "llu"
#define PRIxFAST64   "llx"
#define PRIXFAST64   "llX"

#define PRIdMAX  "lld"
#define PRIiMAX  "lli"
#define PRIoMAX  "llo"
#define PRIuMAX  "llu"
#define PRIxMAX  "llx"
#define PRIXMAX  "llX"

#define PRIdPTR  "d"
#define PRIiPTR  "i"
#define PRIoPTR  "o"
#define PRIuPTR  "u"
#define PRIxPTR  "x"
#define PRIXPTR  "X"

/* scanf format macros */
#define SCNd8   "d"
#define SCNu8   "u"
#define SCNx8   "x"
#define SCNd16  "d"
#define SCNu16  "u"
#define SCNx16  "x"
#define SCNd32  "d"
#define SCNu32  "u"
#define SCNx32  "x"
#define SCNd64  "lld"
#define SCNu64  "llu"
#define SCNx64  "llx"
#define SCNdMAX "lld"
#define SCNuMAX "llu"
#define SCNxMAX "llx"
#define SCNdPTR "d"
#define SCNuPTR "u"
#define SCNxPTR "x"

typedef struct { intmax_t quot; intmax_t rem; } imaxdiv_t;

intmax_t  strtoimax(const char *nptr, char **endptr, int base);
uintmax_t strtoumax(const char *nptr, char **endptr, int base);
intmax_t  imaxabs(intmax_t j);
imaxdiv_t imaxdiv(intmax_t numer, intmax_t denom);

#endif /* ARK_INTTYPES_H */
