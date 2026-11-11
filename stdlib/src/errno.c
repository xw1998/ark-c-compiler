/* Ark C Compiler stdlib - errno.c
 * C99 7.5: the error-number object.
 *
 * C99 7.5p2 says errno may be a macro that expands to a modifiable lvalue;
 * on this target it is a plain global.  Nothing else lives here: the
 * E* macros are in <errno.h> so a target with a different numbering
 * scheme only has to replace the header.
 */
#include <errno.h>

int errno = 0;
