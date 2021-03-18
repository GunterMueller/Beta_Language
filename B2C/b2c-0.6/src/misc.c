#include <stdio.h>
#include <sys/resource.h>
#include <sys/utsname.h>

/* timing */
static struct timeval start_time;
void set_start_time(void)
{
    struct timezone tz;
    gettimeofday(&start_time, &tz);
}
void print_usage(void)
{
    struct timeval end_time;
    struct timezone tz;
    struct rusage me;
    struct rusage child;
    double me_user, me_sys, child_user, child_sys, real, percent;

    getrusage(RUSAGE_SELF, &me);
    getrusage(RUSAGE_CHILDREN, &child);
    me_user = me.ru_utime.tv_sec + 0.000001*me.ru_utime.tv_usec;
    me_sys = me.ru_stime.tv_sec + 0.000001*me.ru_stime.tv_usec;
    child_user = child.ru_utime.tv_sec + 0.000001*child.ru_utime.tv_usec;
    child_sys = child.ru_stime.tv_sec + 0.000001*child.ru_stime.tv_usec;

    gettimeofday(&end_time, &tz);
    real = (end_time.tv_sec - start_time.tv_sec) +
	   0.000001 * (end_time.tv_usec - start_time.tv_usec);
    percent = 100.0;
    if(real > 0.0)
	percent = 100.0 * (me_user+me_sys+child_user+child_sys) / real;

    printf("CPU time: %.2f/%.2f (user/sys) for self, and %.2f/%.2f for C compiler/linker.\n", me_user, me_sys, child_user, child_sys);
    printf("That are %.1f%% of the %.2fs real elapsed time.\n", percent, real);
}


char *uname_wrap(int arg)
{
    static struct utsname buf;

    if(! buf.sysname[0])
	uname(&buf);

    switch(arg) {
    case 0: return buf.nodename;
    case 1: return buf.domainname;
    case 2: return buf.machine;
    case 3: return buf.sysname;
    case 4: return buf.release;
    case 5: return buf.version;
    }
    fprintf(stderr, "uname_wrap() called with illegal argument %d\n", arg);
    exit(1);
    return 0;
}
