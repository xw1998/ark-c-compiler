/* Ark C Compiler - platform_host
 * Host platform layer: everything goes through stdio.
 * Used for the host build; logging, abort and date/time come from the C library.
 */
#include "platform.h"
#include <stdio.h>
#include <stdarg.h>
#include <stdlib.h>
#include <time.h>

/* C99 predefined __DATE__/__TIME__ strings, formatted locally -- no
 * strftime dependency: "Mmm dd yyyy" / "hh:mm:ss" are built by hand. */
void ark_get_date_time(char *date_buf, char *time_buf) {
    static const char *mon_names[] = {
        "Jan","Feb","Mar","Apr","May","Jun",
        "Jul","Aug","Sep","Oct","Nov","Dec"
    };
    time_t t = time(0);
    struct tm *lt = localtime(&t);
    if (lt) {
        int day = lt->tm_mday;
        int yr  = lt->tm_year + 1900;
        const char *m = mon_names[lt->tm_mon % 12];
        /* "Mmm dd yyyy" - the day field is 2 characters, space padded */
        date_buf[0] = m[0]; date_buf[1] = m[1]; date_buf[2] = m[2];
        date_buf[3] = ' ';
        date_buf[4] = (day < 10) ? ' ' : (char)('0' + day / 10);
        date_buf[5] = (char)('0' + day % 10);
        date_buf[6] = ' ';
        date_buf[7]  = (char)('0' + (yr / 1000) % 10);
        date_buf[8]  = (char)('0' + (yr / 100) % 10);
        date_buf[9]  = (char)('0' + (yr / 10) % 10);
        date_buf[10] = (char)('0' + yr % 10);
        date_buf[11] = 0;
        /* "hh:mm:ss" */
        time_buf[0] = (char)('0' + lt->tm_hour / 10);
        time_buf[1] = (char)('0' + lt->tm_hour % 10);
        time_buf[2] = ':';
        time_buf[3] = (char)('0' + lt->tm_min / 10);
        time_buf[4] = (char)('0' + lt->tm_min % 10);
        time_buf[5] = ':';
        time_buf[6] = (char)('0' + lt->tm_sec / 10);
        time_buf[7] = (char)('0' + lt->tm_sec % 10);
        time_buf[8] = 0;
    } else {
        const char *d = "Jan  1 1970";
        const char *tn = "00:00:00";
        int i;
        for (i = 0; i < 11; i++) date_buf[i] = d[i];
        date_buf[11] = 0;
        for (i = 0; i < 8; i++) time_buf[i] = tn[i];
        time_buf[8] = 0;
    }
}

void ark_log(const char *fmt, ...) {
    va_list args;
    va_start(args, fmt);
    vfprintf(stderr, fmt, args);
    va_end(args);
}

void ark_abort(const char *msg) {
    fprintf(stderr, "[arkcc] FATAL: %s\n", msg ? msg : "");
    exit(1);
}
