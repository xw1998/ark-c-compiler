/* Ark C Compiler stdlib - stdatomic.h
 * C11 7.17 <stdatomic.h>: 原子类型、原子操作、内存序。
 *
 * 这个头文件只承诺它真的做到了的事情：
 *
 *   ARM (Cortex-M, __ARKCC_TARGET_ARM)
 *     目标只有单核、并发只来自中断，所以互斥靠 PRIMASK 临界区
 *     （__arkcc_crit_save / __arkcc_crit_restore 两个内建，见
 *     src/backend/arm/backend_arm.c）。语义上全部按 seq_cst 处理：
 *     进入临界区时先读 PRIMASK 再关中断，退出时按原值恢复，因此嵌套临界区
 *     不会把外层关掉的中断重新打开。
 *     1/2/4 字节标量的 load/store 直接是普通访问（ARM 保证自然对齐的单字
 *     访问是 single-copy atomic），8 字节标量（long long / double）和所有
 *     读-改-写（exchange / fetch_* / compare_exchange）走临界区。
 *
 *   其他目标（x86 / x86_64 / riscv32 / c）
 *     没有可用的真原子路径：内部汇编器不支持 LDREX/STREX，也没有 x86 的
 *     `lock` 前缀，RV32I 没有 A 扩展。于是除了「初始化」（atomic_init）
 *     之外的每一个操作都编译期失败，宏展开成一个名字很长的未声明标识符，
 *     用户看到的就是说明书：
 *         __arkcc_atomic_op_not_supported_on_this_target_use_a_mutex
 *     这不是偷懒，而是不给出错答案：悄悄按普通访问执行会违反 C11 的原子性。
 *     （ARM 之外要原子性请显式用互斥量或关中断，而不是假设这个头里的名字可用。）
 *
 * 不提供的部分（编译器本身没有对应类型，硬写typedef会撒谎）:
 *   - atomic_char16_t / atomic_char32_t / atomic_wchar_t 的 char16_t 族
 *     （编译器没有 char16_t 类型）
 * 内存序参数一律被忽略：本实现只有 seq_cst 一档，这比声称支持
 * relaxed/acquire/release 而实际按 seq_cst 执行要诚实。
 */
#ifndef ARK_STDATOMIC_H
#define ARK_STDATOMIC_H

#include <stddef.h>
#include <stdint.h>

/* ---------------------------------------------------------------- 内存序 */
typedef enum memory_order {
    memory_order_relaxed,
    memory_order_consume,
    memory_order_acquire,
    memory_order_release,
    memory_order_acq_rel,
    memory_order_seq_cst
} memory_order;

/* ---------------------------------------------------------------- 原子类型 */
typedef _Atomic _Bool              atomic_bool;
typedef _Atomic char               atomic_char;
typedef _Atomic signed char        atomic_schar;
typedef _Atomic unsigned char      atomic_uchar;
typedef _Atomic short              atomic_short;
typedef _Atomic unsigned short     atomic_ushort;
typedef _Atomic int                atomic_int;
typedef _Atomic unsigned int       atomic_uint;
typedef _Atomic long               atomic_long;
typedef _Atomic unsigned long      atomic_ulong;
typedef _Atomic long long          atomic_llong;
typedef _Atomic unsigned long long atomic_ullong;

typedef _Atomic int8_t             atomic_int_least8_t;
typedef _Atomic uint8_t            atomic_uint_least8_t;
typedef _Atomic int16_t            atomic_int_least16_t;
typedef _Atomic uint16_t           atomic_uint_least16_t;
typedef _Atomic int32_t            atomic_int_least32_t;
typedef _Atomic uint32_t           atomic_uint_least32_t;
typedef _Atomic int64_t            atomic_int_least64_t;
typedef _Atomic uint64_t           atomic_uint_least64_t;

typedef _Atomic int_fast8_t        atomic_int_fast8_t;
typedef _Atomic uint_fast8_t       atomic_uint_fast8_t;
typedef _Atomic int_fast16_t       atomic_int_fast16_t;
typedef _Atomic uint_fast16_t      atomic_uint_fast16_t;
typedef _Atomic int_fast32_t       atomic_int_fast32_t;
typedef _Atomic uint_fast32_t      atomic_uint_fast32_t;
typedef _Atomic int_fast64_t       atomic_int_fast64_t;
typedef _Atomic uint_fast64_t      atomic_uint_fast64_t;

typedef _Atomic intptr_t           atomic_intptr_t;
typedef _Atomic uintptr_t          atomic_uintptr_t;
typedef _Atomic size_t             atomic_size_t;
typedef _Atomic ptrdiff_t          atomic_ptrdiff_t;
typedef _Atomic intmax_t           atomic_intmax_t;
typedef _Atomic uintmax_t          atomic_uintmax_t;

/* C11 7.17.8: atomic_flag 是一个至少含一个成员的 struct，初始值全零。
 * 用 _Atomic int 当成员而不是 int：成员本身的类型就是原子的，不再是"看起来
 * 原子"的普通整数。 */
typedef struct atomic_flag_s {
    _Atomic int __arkcc_flag;
} atomic_flag;

#define ATOMIC_FLAG_INIT  { 0 }
#define ATOMIC_VAR_INIT(v) (v)
#define atomic_init(obj, val) (*(obj) = (val))
#define kill_dependency(y) (y)

#if defined(__ARKCC_TARGET_ARM)

/* 由后端识别并直接发指令的内建（不是运行库函数，不需要链接）：
 *   __arkcc_crit_save()      MRS r0, PRIMASK ; CPSID i    返回进入前的屏蔽位
 *   __arkcc_crit_restore(s)  MSR PRIMASK, r0              按原值恢复
 * 先读后关是嵌套安全的关键：直接把 PRIMASK 置 0 会把外层临界区关掉的中断
 * 重新打开。 */
int  __arkcc_crit_save(void);
void __arkcc_crit_restore(int __arkcc_saved);

/* 1/2/4 字节标量族：load/store 是普通访问（硬件单拷贝原子），
 * 读-改-写走临界区。 */
#define __ARKCC_ATOMIC_SMALL(T, SUF)                                          \
    static T __arkcc_ld_##SUF(const volatile T *__arkcc_p) {                  \
        return *__arkcc_p;                                                    \
    }                                                                         \
    static void __arkcc_st_##SUF(volatile T *__arkcc_p, T __arkcc_v) {        \
        *__arkcc_p = __arkcc_v;                                               \
    }                                                                         \
    static T __arkcc_xchg_##SUF(volatile T *__arkcc_p, T __arkcc_v) {         \
        int __arkcc_s = __arkcc_crit_save();                                  \
        T __arkcc_old = *__arkcc_p;                                           \
        *__arkcc_p = __arkcc_v;                                               \
        __arkcc_crit_restore(__arkcc_s);                                      \
        return __arkcc_old;                                                   \
    }                                                                         \
    static int __arkcc_cas_##SUF(volatile T *__arkcc_p, T *__arkcc_e,         \
                                 T __arkcc_d) {                               \
        int __arkcc_s = __arkcc_crit_save();                                  \
        int __arkcc_ok;                                                       \
        if (*__arkcc_p == *__arkcc_e) { *__arkcc_p = __arkcc_d; __arkcc_ok = 1; } \
        else { *__arkcc_e = *__arkcc_p; __arkcc_ok = 0; }                      \
        __arkcc_crit_restore(__arkcc_s);                                      \
        return __arkcc_ok;                                                    \
    }

/* 整数族：在 SMALL/LARGE 的基础上加 fetch_add/sub/and/or/xor。
 * 幂等与算术都在临界区里做，所以并发下也是"读出-计算-写回"一个整体。 */
#define __ARKCC_ATOMIC_RMW(T, SUF)                                            \
    static T __arkcc_fadd_##SUF(volatile T *__arkcc_p, T __arkcc_v) {         \
        int __arkcc_s = __arkcc_crit_save();                                  \
        T __arkcc_old = *__arkcc_p;                                           \
        *__arkcc_p = (T)(__arkcc_old + __arkcc_v);                            \
        __arkcc_crit_restore(__arkcc_s);                                      \
        return __arkcc_old;                                                   \
    }                                                                         \
    static T __arkcc_fsub_##SUF(volatile T *__arkcc_p, T __arkcc_v) {         \
        int __arkcc_s = __arkcc_crit_save();                                  \
        T __arkcc_old = *__arkcc_p;                                           \
        *__arkcc_p = (T)(__arkcc_old - __arkcc_v);                            \
        __arkcc_crit_restore(__arkcc_s);                                      \
        return __arkcc_old;                                                   \
    }                                                                         \
    static T __arkcc_fand_##SUF(volatile T *__arkcc_p, T __arkcc_v) {         \
        int __arkcc_s = __arkcc_crit_save();                                  \
        T __arkcc_old = *__arkcc_p;                                           \
        *__arkcc_p = (T)(__arkcc_old & __arkcc_v);                            \
        __arkcc_crit_restore(__arkcc_s);                                      \
        return __arkcc_old;                                                   \
    }                                                                         \
    static T __arkcc_for_##SUF(volatile T *__arkcc_p, T __arkcc_v) {          \
        int __arkcc_s = __arkcc_crit_save();                                  \
        T __arkcc_old = *__arkcc_p;                                           \
        *__arkcc_p = (T)(__arkcc_old | __arkcc_v);                            \
        __arkcc_crit_restore(__arkcc_s);                                      \
        return __arkcc_old;                                                   \
    }                                                                         \
    static T __arkcc_fxor_##SUF(volatile T *__arkcc_p, T __arkcc_v) {         \
        int __arkcc_s = __arkcc_crit_save();                                  \
        T __arkcc_old = *__arkcc_p;                                           \
        *__arkcc_p = (T)(__arkcc_old ^ __arkcc_v);                            \
        __arkcc_crit_restore(__arkcc_s);                                      \
        return __arkcc_old;                                                   \
    }

__ARKCC_ATOMIC_SMALL(_Bool, b)
__ARKCC_ATOMIC_SMALL(char, c)
__ARKCC_ATOMIC_SMALL(signed char, sc)
__ARKCC_ATOMIC_SMALL(unsigned char, uc)
__ARKCC_ATOMIC_SMALL(short, s)
__ARKCC_ATOMIC_SMALL(unsigned short, us)
__ARKCC_ATOMIC_SMALL(int, i)
__ARKCC_ATOMIC_SMALL(unsigned int, ui)
__ARKCC_ATOMIC_SMALL(long, l)
__ARKCC_ATOMIC_SMALL(unsigned long, ul)
__ARKCC_ATOMIC_SMALL(float, f)

/* 8 字节标量的相等比较按两个 32 位字做：直接写 `a == b`（long long 比较）
 * 会发 BL __aeabi_lcmp，于是"include 了 <stdatomic.h> 就要额外链接 AEABI
 * 运行库"，连一个 32 位程序也不例外（static 函数没有死代码消除，全都发）。
 * 这里只用到 32 位比较，头文件因此自给自足。 */
static int __arkcc_eq8(const volatile void *__arkcc_a, const void *__arkcc_b) {
    const volatile unsigned int *__arkcc_pa = (const volatile unsigned int *)__arkcc_a;
    const unsigned int *__arkcc_pb = (const unsigned int *)__arkcc_b;
    return (int)(__arkcc_pa[0] == __arkcc_pb[0] && __arkcc_pa[1] == __arkcc_pb[1]);
}

/* 8 字节标量：load/store 也是两字访问，必须和读-改-写一样进临界区。 */
#define __ARKCC_ATOMIC_LARGE(T, SUF)                                          \
    static T __arkcc_ld_##SUF(const volatile T *__arkcc_p) {                  \
        int __arkcc_s = __arkcc_crit_save();                                  \
        T __arkcc_v = *__arkcc_p;                                             \
        __arkcc_crit_restore(__arkcc_s);                                      \
        return __arkcc_v;                                                     \
    }                                                                         \
    static void __arkcc_st_##SUF(volatile T *__arkcc_p, T __arkcc_v) {        \
        int __arkcc_s = __arkcc_crit_save();                                  \
        *__arkcc_p = __arkcc_v;                                               \
        __arkcc_crit_restore(__arkcc_s);                                      \
    }                                                                         \
    static T __arkcc_xchg_##SUF(volatile T *__arkcc_p, T __arkcc_v) {         \
        int __arkcc_s = __arkcc_crit_save();                                  \
        T __arkcc_old = *__arkcc_p;                                           \
        *__arkcc_p = __arkcc_v;                                               \
        __arkcc_crit_restore(__arkcc_s);                                      \
        return __arkcc_old;                                                   \
    }                                                                         \
    static int __arkcc_cas_##SUF(volatile T *__arkcc_p, T *__arkcc_e,         \
                                 T __arkcc_d) {                               \
        int __arkcc_s = __arkcc_crit_save();                                  \
        int __arkcc_ok;                                                       \
        if (__arkcc_eq8(__arkcc_p, __arkcc_e)) { *__arkcc_p = __arkcc_d; __arkcc_ok = 1; } \
        else { *__arkcc_e = *__arkcc_p; __arkcc_ok = 0; }                      \
        __arkcc_crit_restore(__arkcc_s);                                      \
        return __arkcc_ok;                                                    \
    }

__ARKCC_ATOMIC_LARGE(long long, ll)
__ARKCC_ATOMIC_LARGE(unsigned long long, ull)
__ARKCC_ATOMIC_LARGE(double, d)

__ARKCC_ATOMIC_RMW(_Bool, b)
__ARKCC_ATOMIC_RMW(char, c)
__ARKCC_ATOMIC_RMW(signed char, sc)
__ARKCC_ATOMIC_RMW(unsigned char, uc)
__ARKCC_ATOMIC_RMW(short, s)
__ARKCC_ATOMIC_RMW(unsigned short, us)
__ARKCC_ATOMIC_RMW(int, i)
__ARKCC_ATOMIC_RMW(unsigned int, ui)
__ARKCC_ATOMIC_RMW(long, l)
__ARKCC_ATOMIC_RMW(unsigned long, ul)
__ARKCC_ATOMIC_RMW(long long, ll)
__ARKCC_ATOMIC_RMW(unsigned long long, ull)

/* _Generic 派发：控制表达式用 *(p) 而不是 (p)，这样 volatile/const 限定在
 * 左值转换里被去掉、`_Atomic int *` 与 `int *` 落到同一个分支（C11 6.5.1.1p2
 * 规定的正是 lvalue conversion 后的类型）。default 故意指向一个未声明的
 * 名字：类型不认识时是编译错误，而不是挑一个分支凑合。 */
#define __ARKCC_ATOMIC_DISPATCH(OP, p)                                        \
    _Generic(*(p),                                                            \
        _Bool:              __arkcc_##OP##_b,                                 \
        char:               __arkcc_##OP##_c,                                 \
        signed char:        __arkcc_##OP##_sc,                                \
        unsigned char:      __arkcc_##OP##_uc,                                \
        short:              __arkcc_##OP##_s,                                 \
        unsigned short:     __arkcc_##OP##_us,                                \
        int:                __arkcc_##OP##_i,                                 \
        unsigned int:       __arkcc_##OP##_ui,                                \
        long:               __arkcc_##OP##_l,                                 \
        unsigned long:      __arkcc_##OP##_ul,                                \
        long long:          __arkcc_##OP##_ll,                                \
        unsigned long long: __arkcc_##OP##_ull,                               \
        float:              __arkcc_##OP##_f,                                 \
        double:             __arkcc_##OP##_d,                                 \
        default: __arkcc_atomic_type_not_supported_use_a_scalar_of_1_2_4_or_8_bytes)

/* 只有整数族才有的派发（float/double 没有 fetch_add，指过去就是编译错误）。 */
#define __ARKCC_ATOMIC_DISPATCH_INT(OP, p)                                    \
    _Generic(*(p),                                                            \
        _Bool:              __arkcc_##OP##_b,                                 \
        char:               __arkcc_##OP##_c,                                 \
        signed char:        __arkcc_##OP##_sc,                                \
        unsigned char:      __arkcc_##OP##_uc,                                \
        short:              __arkcc_##OP##_s,                                 \
        unsigned short:     __arkcc_##OP##_us,                                \
        int:                __arkcc_##OP##_i,                                 \
        unsigned int:       __arkcc_##OP##_ui,                                \
        long:               __arkcc_##OP##_l,                                 \
        unsigned long:      __arkcc_##OP##_ul,                                \
        long long:          __arkcc_##OP##_ll,                                \
        unsigned long long: __arkcc_##OP##_ull,                               \
        default: __arkcc_atomic_rmw_needs_an_integer_type)

#define atomic_is_lock_free(p)  ((int)(sizeof(*(p)) <= 4))

#define atomic_load(p)                    (__ARKCC_ATOMIC_DISPATCH(ld, (p))((p)))
#define atomic_load_explicit(p, mo)       (atomic_load(p))
#define atomic_store(p, v)                (__ARKCC_ATOMIC_DISPATCH(st, (p))((p), (v)))
#define atomic_store_explicit(p, v, mo)   (atomic_store((p), (v)))
#define atomic_exchange(p, v)             (__ARKCC_ATOMIC_DISPATCH(xchg, (p))((p), (v)))
#define atomic_exchange_explicit(p, v, mo) (atomic_exchange((p), (v)))
#define atomic_compare_exchange_strong(p, e, d) \
        ((int)(__ARKCC_ATOMIC_DISPATCH(cas, (p))((p), (e), (d))))
#define atomic_compare_exchange_strong_explicit(p, e, d, mo1, mo2) \
        atomic_compare_exchange_strong((p), (e), (d))
#define atomic_compare_exchange_weak(p, e, d) \
        atomic_compare_exchange_strong((p), (e), (d))
#define atomic_compare_exchange_weak_explicit(p, e, d, mo1, mo2) \
        atomic_compare_exchange_strong((p), (e), (d))

#define atomic_fetch_add(p, v)  (__ARKCC_ATOMIC_DISPATCH_INT(fadd, (p))((p), (v)))
#define atomic_fetch_sub(p, v)  (__ARKCC_ATOMIC_DISPATCH_INT(fsub, (p))((p), (v)))
#define atomic_fetch_and(p, v)  (__ARKCC_ATOMIC_DISPATCH_INT(fand, (p))((p), (v)))
#define atomic_fetch_or(p, v)   (__ARKCC_ATOMIC_DISPATCH_INT(for,  (p))((p), (v)))
#define atomic_fetch_xor(p, v)  (__ARKCC_ATOMIC_DISPATCH_INT(fxor, (p))((p), (v)))
#define atomic_fetch_add_explicit(p, v, mo)  atomic_fetch_add((p), (v))
#define atomic_fetch_sub_explicit(p, v, mo)  atomic_fetch_sub((p), (v))
#define atomic_fetch_and_explicit(p, v, mo)  atomic_fetch_and((p), (v))
#define atomic_fetch_or_explicit(p, v, mo)   atomic_fetch_or((p), (v))
#define atomic_fetch_xor_explicit(p, v, mo)  atomic_fetch_xor((p), (v))

/* 屏障：都直接发指令（__dmb/__memory_changed 是后端内建），不需要链接。
 * 单核上 seq_cst 的全部要求由编译器屏障 + 临界区满足，跨核/跨 DMA 的可见性
 * 仍需要用户自己确认（DMB 只是顺序，不解决 cache 一致性）。 */
#define atomic_thread_fence(mo)   (__dmb())
#define atomic_signal_fence(mo)   (__memory_changed())

static int atomic_flag_test_and_set(volatile atomic_flag *__arkcc_f) {
    int __arkcc_s = __arkcc_crit_save();
    int __arkcc_old = __arkcc_f->__arkcc_flag;
    __arkcc_f->__arkcc_flag = 1;
    __arkcc_crit_restore(__arkcc_s);
    return __arkcc_old;
}

static void atomic_flag_clear(volatile atomic_flag *__arkcc_f) {
    int __arkcc_s = __arkcc_crit_save();
    __arkcc_f->__arkcc_flag = 0;
    __arkcc_crit_restore(__arkcc_s);
}

#define atomic_flag_test_and_set_explicit(f, mo) atomic_flag_test_and_set(f)
#define atomic_flag_clear_explicit(f, mo)        atomic_flag_clear(f)

#else  /* 非 ARM 目标 */

/* 这些目标上本编译器没有真原子路径（见文件头）。除了初始化，每个名字都
 * 编译期失败，并以标识符本身说明原因；绝不悄悄按普通访问执行。
 * 需要原子性请显式用互斥量或平台提供的关中断/自旋锁。 */
#define __ARKCC_NOATOMIC(what)                                  \
    (__arkcc_atomic_##what##_not_supported_on_this_target_use_a_mutex)

#define atomic_load(p)                 __ARKCC_NOATOMIC(load)
#define atomic_load_explicit(p, mo)    __ARKCC_NOATOMIC(load)
#define atomic_store(p, v)             __ARKCC_NOATOMIC(store)
#define atomic_store_explicit(p, v, mo) __ARKCC_NOATOMIC(store)
#define atomic_exchange(p, v)          __ARKCC_NOATOMIC(exchange)
#define atomic_exchange_explicit(p, v, mo) __ARKCC_NOATOMIC(exchange)
#define atomic_compare_exchange_strong(p, e, d) __ARKCC_NOATOMIC(compare_exchange)
#define atomic_compare_exchange_strong_explicit(p, e, d, mo1, mo2) \
        __ARKCC_NOATOMIC(compare_exchange)
#define atomic_compare_exchange_weak(p, e, d) __ARKCC_NOATOMIC(compare_exchange)
#define atomic_compare_exchange_weak_explicit(p, e, d, mo1, mo2) \
        __ARKCC_NOATOMIC(compare_exchange)
#define atomic_fetch_add(p, v)         __ARKCC_NOATOMIC(fetch_add)
#define atomic_fetch_sub(p, v)         __ARKCC_NOATOMIC(fetch_sub)
#define atomic_fetch_and(p, v)         __ARKCC_NOATOMIC(fetch_and)
#define atomic_fetch_or(p, v)          __ARKCC_NOATOMIC(fetch_or)
#define atomic_fetch_xor(p, v)         __ARKCC_NOATOMIC(fetch_xor)
#define atomic_fetch_add_explicit(p, v, mo) atomic_fetch_add((p), (v))
#define atomic_fetch_sub_explicit(p, v, mo) atomic_fetch_sub((p), (v))
#define atomic_fetch_and_explicit(p, v, mo) atomic_fetch_and((p), (v))
#define atomic_fetch_or_explicit(p, v, mo)  atomic_fetch_or((p), (v))
#define atomic_fetch_xor_explicit(p, v, mo) atomic_fetch_xor((p), (v))
#define atomic_flag_test_and_set(f)    __ARKCC_NOATOMIC(flag_test_and_set)
#define atomic_flag_test_and_set_explicit(f, mo) atomic_flag_test_and_set(f)
#define atomic_flag_clear(f)           __ARKCC_NOATOMIC(flag_clear)
#define atomic_flag_clear_explicit(f, mo) atomic_flag_clear(f)
#define atomic_thread_fence(mo)        __ARKCC_NOATOMIC(thread_fence)
#define atomic_signal_fence(mo)        __ARKCC_NOATOMIC(signal_fence)
#define atomic_is_lock_free(p)         (0)

#endif /* __ARKCC_TARGET_ARM */

#endif /* ARK_STDATOMIC_H */
