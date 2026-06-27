/* Ark C Compiler - MDK STM32H743 - cmsis_compiler (占位) */
#ifndef __CMSIS_COMPILER_H
#define __CMSIS_COMPILER_H

/* 仅覆盖 armclang 的最少宏，正式工程请用官方 CMSIS 覆盖。 */
#ifndef __ASM
  #define __ASM            __asm
#endif
#ifndef __INLINE
  #define __INLINE         __inline
#endif
#ifndef __STATIC_INLINE
  #define __STATIC_INLINE  static __inline
#endif
#ifndef __WEAK
  #define __WEAK           __attribute__((weak))
#endif
#ifndef __PACKED
  #define __PACKED         __attribute__((packed))
#endif
#ifndef __ALIGNED
  #define __ALIGNED(x)     __attribute__((aligned(x)))
#endif
#ifndef __USED
  #define __USED           __attribute__((used))
#endif
#ifndef __NO_RETURN
  #define __NO_RETURN      __attribute__((__noreturn__))
#endif

#endif /* __CMSIS_COMPILER_H */
