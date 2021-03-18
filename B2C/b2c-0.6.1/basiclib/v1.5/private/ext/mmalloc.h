/* JO definition of interface to memory block control unit */

#if !defined(__MMALLOC_H)
#define __MMALLOC_H


/* #define MAXDEBUG		/* Set this to turn all debugging on */
/* #define MEMDEBUG		/* Set this for memory management debugging */


#define INFOFILE "info.dump"		/* Filename for writing of trace info */
#define DEFAULTINFOFILE (stderr)	/* Preset filedescriptor for tracing */

#ifdef MAXDEBUG
 #ifndef MEMDEBUG
  #define MEMDEBUG (1)
 #endif
#endif

#ifndef MEMDEBUG
/* #define INFOIOA (1)		/* Write info about IOA collection */
/* #define INFOLVRA (1)		/* Write info about LVRA collection */
/* #define INFOLVRAAlloc (1)	/* Write info about field allocation */
/* #define INFOCBFA (0)		/* Write info about CBFA state */
#else
 #undef MEMDEBUG
 #define MEMDEBUG (1)
 #define INFOIOA (1)
 #define INFOLVRA (1)
 #define INFOLVRAAlloc (1)
 #define INFOCBFA (1)
#endif
#if defined (INFOIOA) || defined (INFOLVRA) || defined (INFOLVRAAlloc) ||\
 defined (INFOCBFA) || !defined (NODEBUG)
 #define ANYINFO
#endif


/* These are adjustable constants affecting collector behavior etc. */
#define IOA (500) /* KB */
#define IOAPercentage (10) /* % */
#define LVRA (500) /* KB */
#define LVRAMinFree (1) /* KB */
#define LVRAPercentage (0) /* % */
/*#define IMMEDIATEFREE/* if it is not set then reclaiming does only collector*/
#define MSTACKSTEP (10)/* Minimal step for mstack allocation*/
#define MSTACKRATIO (2)/* Multiplies the allocation step for mstack allocation*/


#ifdef ANYINFO
 #ifndef MEMDEBUG
 #define MEMDEBUG (0)
 #endif
 #ifndef INFOIOA
  #define INFOIOA (0)
 #endif
 #ifndef INFOLVRA
  #define INFOLVRA (0)
 #endif
 #ifndef INFOLVRAAlloc
  #define INFOLVRAAlloc (0)
 #endif
 #ifndef INFOCBFA
  #define INFOCBFA (0)
 #endif
 #ifndef INFOFILE
  #define INFOFILE "" 
 #endif
 #ifndef DEFAULTINFOFILE
  #define DEFAULTINFOFILE (stderr)
 #endif
 #include <stdio.h>/* Accesses also declarations of types for arguments of mmalloc etc.*/
#endif 

#ifndef size_t
 #include <stdlib.h>/* For access to type size_t, if isn't defined*/
#endif

struct object;/* Forward declaration of existency of this structure needed here*/
struct msumstat {int size,count;};/* size and amount of given block type*/
struct msum {struct msumstat totalused,totalfreed,current,lastgc;}; /* total
 summary of used memory, reclaimed memory and currently used memory*/
struct mstatus {struct msum ioa,lvra,stack/*,cbfa*/;};/* summary control state*/
struct mstatus *mgetstatus(void);/*Returns total statistics of controlled memory*/
void msetstatusaftergc(void);/*Copies "current" values to "lastgc" values*/
#ifdef ANYINFO
 extern FILE* infofile;/* gives access to tracing filedescriptor*/
 void minit(void);/* For inicialization, only for creation of infofile yet*/ 
#endif
void *mmalloc(size_t size);/* redefinition of malloc for objects*/
void *mrmalloc(size_t size);/* redefinition of malloc for fields*/
void mrfree(void *m);/* redefinition of free for fields*/
void *mrrealloc(void *m,size_t size);/* redefinition of realloc for fields*/
void mrsetlive(void* m);/* For marking of fields*/
int mgetlive(void* m);/* Gives value of mark of given object*/
int mrgetlive(void* m);/* Gives value of mark of given field*/
#ifndef NODEBUG
 void mdump(void);/* Listing of all memory blocks and their marks*/
#endif
int markit(struct object* th);/* Starts marking of given object th*/
void mchangemark(void);/* Changes mark for next collection*/
void mstackinsert(struct object ** m);/* Adds local reference to the root set*/
void msetstackcnt(int mstackbase);/* Sets number of references in the root set*/
int mgetstackcnt(void);/* Gives number of references in the root set*/
int mgetstackitem(int pos, struct object ***item);/* Gives an item from the root set*/
int mgetmmark(void);/* Gives current value of mark for live objects*/

#endif
/* JO */
