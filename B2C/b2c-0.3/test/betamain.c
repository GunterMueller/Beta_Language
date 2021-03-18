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

#ifndef NODEBUG
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


void qua_error(void *th)
{
    fputs("\nBETA runtime ERROR:\nA qualification error has occurred!\n",
	  stderr);
    exit(1);
}


void encl_error(void *th)
{
    fputs("\nBETA runtime ERROR:\nA qualification error has occurred due to non-matching enclosing objects!\n", stderr);
    exit(1);
}
