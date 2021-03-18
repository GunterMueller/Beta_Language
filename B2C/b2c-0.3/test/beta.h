/* standard header file for BETA programs */

#include <stddef.h>	/* for offsetof() macro */
#include <string.h>	/* for memset() function */

/* JO for own memory control was overriden usage of malloc with mmalloc etc. */
/*#include <malloc.h>*/	/* for malloc() system call */
#include "mmalloc.h"    /* for accessing of allocating function as mmalloc()*/
/* JO */


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
    void *b_ptr;
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

/* Define the various functions, that report BETA runtime error.
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


/* JS constants for configuration of strategy for allocation of memory
  for repetition */
/* minimal usage of memory block allocated for repetition
   in percent (as decimal number) */
#define RepUseBlock (0.7)
/* minimal increment for increase of memory block allocated for repetition
   in percent (as decimal number) */ 
#define RepAddBlock (0.3)
