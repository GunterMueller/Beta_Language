/* main file for BETA comiled programs */

#include <stdio.h>
#include <stdlib.h>

#include "beta.h"

struct Omain;
struct Omain *Nmain(void *);
int Fmain(struct Omain *const);

const struct object *LRobject;
const char *LRlabel;

int main(int argc, char *argv[])
{
    struct Omain *m;

    /* JO Initialization of memory and garbage collection debugging/tracing: */
#ifdef ANYINFO
    minit();
#endif
    /* JO */

    m = Nmain(0);

    /* JO Save reference to reference to main program resp. object: */
    mstackinsert((struct object **)&m);

#ifdef MAXDEBUG
    fprintf(infofile, "main: The main BETA pattern is about to be started.\n");
#endif
    /* JO */

    if(! Fmain(m)) {
	fprintf(stderr,
		"\nBETA runtime ERROR:\nExecuting the statement\n\t%s\n"
		"did completely unwind the stack!\n",
		LRlabel);
	exit(1);
    }

    return 0;
}


/* Abort with a qualification error */
void qua_error(void *th)
{
    fputs("\nBETA runtime ERROR:\nA qualification error has occurred!\n",
	  stderr);
    exit(1);
}


/* Abort with an error in the qualification of the enclosing object */
void encl_error(void *th)
{
    fputs("\nBETA runtime ERROR:\nA qualification error has occurred due to non-matching enclosing objects!\n", stderr);
    exit(1);
}


/* Convert a BETA char repetition into a zero terminated C string. */
char *makecstring(const unsigned char *src, int len)
{
    char *out;
    if(len<0) {
	fputs("\nBETA runtime ERROR:\nCalled makecstring() with a negative length!\n", stderr);
	exit(1);
    }
    out = (char *) mrmalloc(len + 1);
    memcpy((void *) out, (void *) src, len);
    out[len] = 0;
    return out;
}
