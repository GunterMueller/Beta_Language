/*
 * standard header file for BETA programs
 * (C) 1997 Kai Petzke, wpp@physik.tu-berlin.de
 */

#include <stddef.h>	/* for offsetof() macro */
#include <string.h>	/* for memset() function */



/* JS constants to handle allocation/deallocation of memory for repetitions */
/* Given a repetition's size, return the mimum number of elements, that must
 * be valid.  If the repetition's length drops below that figure, the
 * repetition's allocated storage area will be shrinked.  If a negative
 * value is returned, the repetition won't shrink. */
#define RepMinUse(n)	((((n)*3)>>2) - 8)

/* If a repetition is extended, allocate at least this many new elements: */
#define RepMinExt(n)	(((n)>>2) + 8)
/* JS */


/* standard structure for storing patterns */
struct object;
struct pattern {
    const struct pattern *const super;
    struct pattern *const outer;
    int len;
    int outerindx;
    int (*function)(struct object *const th);
    struct object *(*newf)(struct object *const th);
    /* JO Added reference to marking function */
    int (*mark)(void *const th);
    /* JO */
};

/* standard structure of BETA objects */
struct object {
    const struct pattern *const pattern;
    struct object *encl1;
    /* JO Added item for prevention of neverending looping in marking phase */
    int mlive;
    /* JO */
};

/* standard repetition objects */
struct repetition {
    const struct pattern *const pattern;
    struct object *encl1;
    /* JO For the same purpose as in object structure */
    int mlive;
    /* JO */
    int b_size;
    int b_elsize;
    int b_alsize; /* JS size of actually allocated memory */
    char *b_ptr;
};

/* pattern variable */
struct pvariable {
    const struct pattern *pattern;
    struct object *encl;
};

/* While processing a non-local LEAVE or RESTART, store information
 * about the block to leave or restart here:
 */
extern const struct object *LRobject;
extern const char *LRlabel;

/* Define the various functions, that report BETA runtime errors.
 * If we use GCC, tell it, that these functions won't return.
 * That way, GCC can produce smaller code.
 */
#ifdef __GNUC__
#if __GNUC__<2 || __GNUC__==2 && (__GNUC_MINOR__ < 5 || \
				 defined(__cplusplus)&&__GNUC_MINOR__ < 6)
volatile void qua_error(void *th);
volatile void encl_error(void *th);
#else
void qua_error(void *th) __attribute__((noreturn));
void encl_error(void *th) __attribute__((noreturn));
#endif
#else
void qua_error(void *th);
void encl_error(void *th);
#endif


/* makecstring - convert a BETA string to a zero terminated C string */
char *makecstring(const unsigned char *, int);
