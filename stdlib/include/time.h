/* Ark C Compiler stdlib - time.h
 * C99 7.23???????????
 * ?????????????????????? host libc ????? */
#ifndef ARK_TIME_H
#define ARK_TIME_H

#include <stddef.h>

typedef long          time_t;
typedef long          clock_t;

#define CLOCKS_PER_SEC 1000
#define TIME_UTC       1

struct tm {
    int tm_sec;
    int tm_min;
    int tm_hour;
    int tm_mday;
    int tm_mon;
    int tm_year;
    int tm_wday;
    int tm_yday;
    int tm_isdst;
};

struct timespec {
    time_t tv_sec;
    long   tv_nsec;
};

time_t      time(time_t *timer);
clock_t      clock(void);
double       difftime(time_t t1, time_t t0);
time_t       mktime(struct tm *tp);
struct tm   *gmtime(const time_t *timer);
struct tm   *localtime(const time_t *timer);
size_t       strftime(char *s, size_t maxsize, const char *format, const struct tm *tp);
char        *asctime(const struct tm *tp);
char        *ctime(const time_t *timer);
int          timespec_get(struct timespec *ts, int base);

#endif /* ARK_TIME_H */
