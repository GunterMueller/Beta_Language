/* JO / Body of memory block control unit /*/

#include <malloc.h>

#include "beta.h"/* Contains needed includes (mmalloc.h and gc.h) */
#include "rootset.h"/* declaration of memory block list*/
#include "gc.h"

/* Implicit constant values - setting them provides/explains mmalloc.h */
#ifndef IOA
#define IOA (512)
#endif
#ifndef LVRAMinFree
#define LVRAMinFree (200)
#endif 
#ifndef LVRA
#define LVRA (512)
#endif
#ifndef MSTACKSTEP
#define MSTACKSTEP (10)
#endif
#ifndef MSTACKRATIO
#define MSTACKRATIO (2)
#endif

#define GCIPTEST(maxsize,percentage,currentsize)\
 ((maxsize*(1024-10*percentage)<currentsize))
#ifdef ANYINFO
FILE *infofile=NULL;/* file descriptor of tracing output*/
#endif
struct mchain mlist={NULL};/* starting item of memory block list (chain)*/
struct mrchain mrlist={NULL,0,0};/* starting item of fields list*/
static int mmark=1;/* actualy used mark for indication of live blocks (1 or 2)*/
static struct object ***mstack=NULL;/* mstack is reference to field
                                       of references to references in local
                                       variables*/
static int mstacksize=0;/* size of allocated mstack*/
static int mstackcnt=0;/* counter of items in mstack (root set items amount)*/
static int IOAsize=IOA;/* relatively maximal size of memory used by objects*/
static int LVRAsize=LVRA;/* relatively maximal size of memory used by fields*/
/*
static int CBFAsize=0;*//* may not be implemented yet*/
/* if after collection will be not enough free space then IOAsize wil be
extended by IOA value*/
static void (*activateGC)(void)=marksweep;/* Poiter to collecting function*/

static struct mstatus mstatus;/* statistics of memory control*/

struct mstatus *mgetstatus(void)
 {
 return &mstatus;/* Returns value of state of all areas usage*/
 };

void msetstatusaftergc(void)
 {
 mstatus.ioa.lastgc.size = mstatus.ioa.current.size;
 mstatus.ioa.lastgc.count = mstatus.ioa.current.count;
 mstatus.lvra.lastgc.size = mstatus.lvra.current.size;
 mstatus.lvra.lastgc.count = mstatus.lvra.current.count;
 }

void minsertchain(struct mchain* m)
 {/* procedure for adding block "m" to objects blocks list (at the beginning)*/
 m->mnext=mlist.mnext;
 mlist.mnext=(char *)m+sizeof(struct mchain);
 };

void mrinsertchain(struct mrchain* m)
 {/* procedure for adding block "m" to fields blocks list (at the beginning)*/
 m->mnext=mrlist.mnext;
 mrlist.mnext=(char *)m+sizeof(struct mrchain);
 };

void gcinvoketest(void)/* Starts collection if it is needed*/
 {
 int invoke=0;/* Value indicating that one of conditions was fulfiled*/

 if (!mgetgcruns())/* Only if collector not runs*/
  {/* Follows tests of activating conditions*/
  if (invoke=IOAsize*1024<(mstatus.ioa.current.size-mstatus.ioa.lastgc.size))
#ifdef ANYINFO
   fprintf(infofile,"gcinvoketest:IOA touched its limit, collection will\
 be started\n");
#else
   ;
#endif
  else
   if (invoke=GCIPTEST(LVRAsize,LVRAPercentage,mstatus.lvra.current.size))
#ifdef ANYINFO
    fprintf(infofile,"gcinvoketest:LVRA touched its limit, collection will\
  be started\n");
#else
    ;
#endif
   else
    invoke=(LVRAsize-LVRAMinFree)*1024<mstatus.lvra.current.size;
  if (invoke)
   {
   msetgcruns();/* beforehand is set collector activity flag (may be used
                   in future versions)*/
   activateGC();/* invocation of respective garbage collector*/
   if ((GCIPTEST(LVRAsize,LVRAPercentage,mstatus.lvra.current.size))||
    (LVRAsize-LVRAMinFree<mstatus.lvra.current.size/1024))
    {
    LVRAsize+=LVRA;
#ifdef INFOLVRA
    if (INFOLVRA)
     fprintf(infofile,"gcinvoketest:Size of LVRA extended to %d\n",LVRAsize);
#endif
    }
   }
  }
 };

void mosetliveto(void* m,int value);

void *mmalloc(size_t size)
 {/* redeclaration of malloc*/
 void *m;

#ifdef MAXDEBUG
 fprintf(infofile,"mmalloc: request for an object of size %d bytes.\n",size);
#endif
 size+=sizeof(struct mchain);/* malloc allocated either for size_t=0*/
#ifdef MAXDEBUG
 fprintf(infofile,"mmalloc: about to allocate %d bytes",size);
#endif
 gcinvoketest();/* Test if is to activate collector*/
 m=malloc(size);/* Respectively memory allocation */


 if (m) /* if isn't enough memory then is m=NULL*/
  {
  mstatus.ioa.current.size+=size;/* Log state of allocated memory*/
  mstatus.ioa.current.count++;
  mstatus.ioa.totalused.size+=size;
  mstatus.ioa.totalused.count++;
  minsertchain((struct mchain*)m);/* set up block chain*/
  (char *)m+=sizeof(struct mchain);
  mosetliveto(m,mgetgcruns()&&mmark);/* preset mlive of new created block
                                     (it should be done during collection too)*/
  }
#ifdef MAXDEBUG
 fprintf(infofile," succeeded at address %p\n",m);
#endif
 return m;
 };

void mrsetliveto(void* m,int value);

void *mrmalloc(size_t size)
 {/* redeclaration of malloc for repetitions fields*/
 void *m;

#ifdef INFOLVRAAlloc
 if (INFOLVRAAlloc)
  fprintf(infofile,"mrmalloc:allocation of field with size %d\n",size);
#endif
 size+=sizeof(struct mrchain);/* malloc allocates either for size_t=0*/
#ifdef INFOLVRAAlloc
 if (INFOLVRAAlloc)
  fprintf(infofile,"mrmalloc:for field will be allocated %d",size);
#endif
 gcinvoketest();
 m=malloc(size);
 if (m) /* if isn't enough memory is m=NULL*/
  {
  ((struct mrchain *)m)->len=size-sizeof(struct mrchain);
  mstatus.lvra.current.size+=((struct mrchain *)m)->len+sizeof(struct mrchain);
  mstatus.lvra.current.count++;
  mstatus.lvra.totalused.size+=((struct mrchain *)m)->len+sizeof(struct mrchain);
  mstatus.lvra.totalused.count++;
  mrinsertchain((struct mrchain *)m);/* set up block chain*/
  (char *)m+=sizeof(struct mrchain);
  mrsetliveto(m,mgetgcruns()&&mmark);
  } 
#ifdef INFOLVRAAlloc
 if (INFOLVRAAlloc)
  fprintf(infofile," with address %p\n",m);
#endif
 return m;
 };

void mdeletechain(struct mchain *m)
 {/* procedure for removal of block "m" in chain*/
 struct mchain *p=&mlist;

 while (p)/* loops until is found block "m"*/
  {
  if ((p->mnext) && ((char*)(p->mnext)-sizeof(struct mchain)==(char*)m))
   {
   p->mnext=m->mnext;/* when found then is removed and looping is done*/
   p=NULL;
   }
  else
   {
   p=(struct mchain *)p->mnext;/* skip to next object*/
   if (p) (char *)p-=sizeof(struct mchain);/* set it to its mchain*/ 
   }
  }
 };

void mrdeletechain(struct mrchain *m)
 {/* procedure for removal of field block "m" in fields blocks chain*/
 struct mrchain *p=&mrlist;

 while (p)
  {
  if ((p->mnext) && ((char*)(p->mnext)-sizeof(struct mrchain)==(char*)m))
   {
   p->mnext=m->mnext;
   p=NULL;
   }
  else
   {
   p=(struct mrchain *)p->mnext;
   if (p) (char *)p-=sizeof(struct mrchain);
   }
  }
 };

void mfree(void *m)
 {/* redeclaration of free for reclaimed objects*/
 size_t size;

 if (m)/* call with m=NULL has to do nothing*/
  {
  if (mgetsweepingruns())/* if runs sweeping then it has to be reclaimed*/
   {
#ifdef INFOIOA
   if (INFOIOA)
    fprintf(infofile,"mfree:Reclamation of object %p\n",(char*)m);
#endif
   if (((struct object *)m)->pattern)
    size=((struct object *)m)->pattern->len;
   else
    {
    size=0;
#ifdef INFOIOA
    if (INFOIOA)
     fprintf(infofile,"mfree:Failed determination of object size\n");
#endif
    }
   size+=sizeof(struct mchain);
   mstatus.ioa.current.size-=size;/* adjustation of allocated memory amount*/
   mstatus.ioa.current.count--;
   mstatus.ioa.totalfreed.size+=size;
   mstatus.ioa.totalfreed.count++;
   (char*)m-=sizeof(struct mchain);
   free(m);
   }
  else
   {
#ifdef IMMEDIATEFREE
#ifdef MAXDEBUG
    fprintf(infofile,"mfree:Reclaiming of object %p\n",(char*)m);
#endif
   if (((struct object*)m)->mlive==mmark)
    {
#ifdef MAXDEBUG
    fprintf(infofile,"mfree:Live object will be reclaimed!\n");
#endif
    };
   if (((struct object *)m)->pattern)
    size=((struct object *)m)->pattern->len;
   else
    {
    size=0;
#ifdef INFOIOA
    if (INFOIOA)
     fprintf(infofile,"mfree:Determination of object size failed\n");
#endif
    }
   size+=sizeof(struct mchain);
   mstatus.ioa.current.size-=size;
   mstatus.ioa.current.count--;
   mstatus.ioa.totalfreed.size+=size;
   mstatus.ioa.totalfreed.count++;
   (char*)m-=sizeof(struct mchain);
   mdeletechain((struct mchain *)m);/* update of blocks chain*/
   free(m);
#endif  
   } 
  }
 };

void mrfree(void *m)
 {/* redeclaration of fields free*/
 if (m)/* call with m=NULL has to do nothing*/
  {
  if (mgetsweepingruns())
   {
#ifdef INFOLVRA
   if (INFOLVRA)
    fprintf(infofile,"mrfree:Reclamation of field %p\n",(char*)m);
#endif
   (char*)m-=sizeof(struct mrchain);
   mstatus.lvra.current.size-=((struct mrchain *)m)->len+sizeof(struct mrchain);
   mstatus.lvra.current.count--;
   mstatus.lvra.totalfreed.size+=((struct mrchain *)m)->len+sizeof(struct mrchain);
   mstatus.lvra.totalfreed.count++;
   free(m);
   }
  else
   {
#ifdef IMMEDIATEFREE
#ifdef MAXDEBUG
   fprintf(infofile,"mrfree:Reclamation of field %p\n",(char*)m);
#endif
   (char*)m-=sizeof(struct mrchain);
   mstatus.lvra.current.size-=((struct mrchain *)m)->len+sizeof(struct mrchain);
   mstatus.lvra.current.count--;
   mstatus.lvra.totalfreed.size+=((struct mrchain *)m)->len+sizeof(struct mrchain);
   mstatus.lvra.totalfreed.count++;
#ifdef MAXDEBUG
   if (((struct mrchain*)m)->mlive==mmark)
    fprintf(infofile,"mrfree:Live field will be reclaimed!\n");
#endif
   mrdeletechain((struct mrchain *)m);/* update of block chain*/
   free(m);
#endif
   }
  }
 };

void *mrrealloc(void *m,size_t size)
 {/* redeclaration of realloc for fields*/
#ifdef IMMEDIATEFREE
 size_t oldsize;
#endif
 void *p;

 if (size==0)/* for zero size has to reclaim "m"*/
  {
  mrfree(m);
  return NULL;
  }
 else
  {
#ifdef INFOLVRAAlloc
   if (INFOLVRAAlloc)
   fprintf(infofile,"mrrealloc:realocation of field %p to size %d\n",m,size);
#endif
#ifdef IMMEDIATEFREE
  if (m)/* if isn't m=NULL then is to adjust it*/
   {
   (char*)m-=sizeof(struct mrchain);
   mrdeletechain((struct mrchain *)m);/* delete from block chain*/
   oldsize=((struct mrchain *)m)->len;
   }
  size+=sizeof(struct mrchain);
#ifdef INFOLVRAAlloc
  if (INFOLVRAAlloc)
   fprintf(infofile,"mrrealloc:will be reallocated %d",size);
#endif
  gcinvoketest();
  p=realloc(m,size);
  if (p)
   {
   m=p; 
   ((struct mrchain *)p)->len=size-sizeof(struct mrchain);
   if (m)
    {
    mstatus.lvra.current.size-=oldsize+sizeof(struct mrchain);
    mstatus.lvra.current.count--;
    mstatus.lvra.totalfreed.size+=oldsize+sizeof(struct mrchain);
    mstatus.lvra.totalfreed.count++;
    }
   mstatus.lvra.current.size+=((struct mrchain *)p)->len+sizeof(struct mrchain);
   mstatus.lvra.current.count++; 
   mstatus.lvra.totalused.size+=((struct mrchain *)p)->len+sizeof(struct mrchain);
   mstatus.lvra.totalused.count++;
   (char*)p+=sizeof(struct mrchain);
   mrsetliveto(p,mgetgcruns()&&mmark);/* sets mlive if is realloc
                                         started when collector is running*/ 
   }
  if (m)/* after successful allocation is to chain fields blocks*/
   mrinsertchain((struct mrchain*)m);
#ifdef INFOLVRAAlloc
  if (INFOLVRAAlloc)
   fprintf(infofile," with address %p\n",p);
#endif
  return p;
#else
  p=mrmalloc(size);
  if (m && p)/* is to copy contains of old field to new one too*/
   {
   (char*)m-=sizeof(struct mrchain);
   if (((struct mrchain *)m)->len<size)
    size=((struct mrchain *)m)->len;
   memcpy(p,(char *)m+sizeof(struct mrchain),size);
   }
  return p;
#endif
  }
 };

void mrsetliveto(void* m,int value)
 {/* setting mark of block "m" to "value"*/
 if (m)/* preserve call with m=NULL*/
  {
  (char*)m-=sizeof(struct mrchain);
  ((struct mrchain*)m)->mlive=value;
  }
 };

void mrsetlive(void* m)
 {
 mrsetliveto(m,mmark);
 };

void mosetliveto(void* m,int value)
 {/* setting mark of object "m" to "value"*/
 if (m)/* preserve call with m=NULL*/
  ((struct object*)m)->mlive=value;
 };

int mgetlive(void* m)
 {/* returns value of mark near block "m"*/
 if (m)
  return ((struct object*)m)->mlive;
 else
  return 0;
 };

int mrgetlive(void* m)
 {/* returns value of mark near field block "m"*/
 if (m)
  {
  (char*)m-=sizeof(struct mrchain);
  return ((struct mrchain*)m)->mlive;
  }
 else
  return 0;
 };

void *mgetnext(void* m)
 {/* returns block following block "m", if m=NULL then returns the first block*/
 if (m)
  {
  (char*)m-=sizeof(struct mchain);
  return ((struct mchain*)m)->mnext;
  }
 else
  return mlist.mnext;
 };

void *mrgetnext(void* m)
 {/* returns fields block following fields block "m", if m=NULL then returns
     the first fields blok*/
 if (m)
  {
  (char*)m-=sizeof(struct mrchain);
  return ((struct mrchain *)m)->mnext;
  }
 else
  return mrlist.mnext;
 };

int mrgetsize(void* m)
 {/* Returns size of field "m"*/
 (char*)m-=sizeof(struct mrchain);
 return ((struct mrchain *)m)->len;
 };

#ifdef MAXDEBUG
void mdump(void)
 {/* for tracing purposes lists all controlled memory blocks*/
 void *m=NULL;
 int c=0; /* counter of blocks in given areas*/

 fprintf(infofile,"\nmdump:Memory listing:\n");
 fprintf(infofile,"mdump:List of dynamic objects:\n");
 while (m=mgetnext(m))
  {
  fprintf(infofile,"mdump:%d:%p (",mgetlive(m),m);
  if (((struct object *)m)->pattern)
   fprintf(infofile,"%d",((struct object *)m)->pattern->len);
  else
   fprintf(infofile,"pattern is not set");
  fprintf(infofile,")\n");
  c++;
  };
 fprintf(infofile,"mdump:amount of blocks %d, memory used by chains %d\n",
  c,c*sizeof(struct mchain));
 m=NULL;
 c=0;
 fprintf(infofile,"mdump:List of fields:\n");
 while (m=mrgetnext(m))
  {
  fprintf(infofile,"mdump:%d:%p (%d)\n",mrgetlive(m),m,mrgetsize(m));
  c++;
  }
 fprintf(infofile,"mdump:amount of blocks %d, memory used by chains %d\n",
  c,c*sizeof(struct mrchain));
 fprintf(infofile,"mdump:End of memory listing\n");   
 };
#endif

#if defined INFOLVRA 
static int mlevel=10;

void lprintf(void)
 {
 int i;

 fprintf(infofile,"markit:");
 if (mlevel>0)
  {
  i=0;
  for(i;i<mlevel;i++)
   fprintf(infofile," ");
  };
 };
#endif

int markit(struct object* th)
 {/* function returns 0 if during marking process arrived an error*/
#ifdef MAXDEBUG
 mlevel+=2;
#endif
 if (th)/* th=NULL is in case of call with non-initialized reference*/
  {
  if (!((*th).pattern))
   {
#ifdef MAXDEBUG
   lprintf();
   fprintf(infofile,"Marked/tested object without pattern - not initialized yet\n");
#endif
   }
  else
   {
#ifdef MAXDEBUG
   lprintf();
   fprintf(infofile,"object: %p\n",th);
   lprintf();
   fprintf(infofile,"pattern: %p\n",th->pattern);
   lprintf();
   fprintf(infofile,"mark: %d\n",th->mlive);
#endif
   if (!(th->mlive==mmark))
    {
    /* Setting mark near object for prevention of neverending looping in 
       circular data structures at the first phase*/
    mosetliveto((void*)th,mmark);
#ifdef MAXDEBUG
    lprintf();
    fprintf(infofile,"new mark: %d\n",th->mlive);
#endif
    if (th->pattern->mark)/* Invocation of marking of object in given object */
     {
#ifdef MAXDEBUG
     lprintf();
     fprintf(infofile,"marking function: %p\n",th->pattern->mark);
     lprintf();
     fprintf(infofile,"outerindex: %d\n",th->pattern->outerindx);
#endif
     if (*(struct object**)((char *)th+th->pattern->outerindx))
      {/* find out address of given "encl" item*/
#ifdef MAXDEBUG
      lprintf();
      fprintf(infofile,"starting of marking of enclosing object: %p\n",
       *(struct object**)((char *)th+th->pattern->outerindx));
      mlevel-=4;
#endif
      if (!markit(*(struct object**)((char *)th+th->pattern->outerindx)))
       return 0;/* Attempt to mark enclosing object failed*/
#ifdef MAXDEBUG
      mlevel+=4;
      lprintf();
      fprintf(infofile,"End of marking of enclosing object\n");
#endif
      }
     else
      {
#ifdef MAXDEBUG
      lprintf();
      fprintf(infofile,"Enclosing object doesn't exist (encl=NULL)\n");
#endif
      };
     if (!(*th->pattern->mark)((void*) th))/* starting of marking function*/
      return 0;
     }
    else
     {
#ifdef MAXDEBUG
     lprintf();
     fprintf(infofile,
      "Invoked marking to wrong object (it has not marking function)\n");
#endif
     return 0; 
     }
    }
   }
  }
 else
  {
#ifdef MAXDEBUG
  lprintf();
  fprintf(infofile,"Marked/tested non-existing object yet\n");
#endif
  };
#ifdef MAXDEBUG
 mlevel-=2;
#endif
 return 1;
 };

void mchangemark(void)/* Change of mark after collection*/
{
#if MEMDEBUG
    fprintf(infofile,"mchangemark:change of mark value from %d ",mmark);
#endif
    mmark = (mmark%2) + 1;
#if MEMDEBUG
    fprintf(infofile,"to %d\n",mmark);
#endif
};

int mgetmmark(void)
 {/* Returns mark value which means live objects*/
 return mmark;
 };

int mgetstackcnt(void)
 {/* Returns number of items in the root set*/
 return mstackcnt;
 };

/* Sets number of items in the root set */
void msetstackcnt(int mstackbase)
{
#if MEMDEBUG
    fprintf(infofile,
	    "msetstackcnt: root set reduced from %d to %d items.\n",
	    mstackcnt,mstackbase);
#endif
    if (mstackcnt<mstackbase) {
	fprintf(stderr,
		"\nBETA RUNTIME ERROR: attempt to increase root set size in \n"
		"call to msetstackcnt()!\n");
	exit(1);
    }
    mstackcnt=mstackbase;
};

/* add an item to the end of the root set (analogy to push) */
void mstackinsert(struct object ** m)
{
    /* Do we need this? */
    if (!m) return;

    if (mstacksize<mstackcnt+1) {
	int oldsize=mstacksize;
	mstacksize=MSTACKRATIO*mstacksize + MSTACKSTEP;
	mstack= (struct object***)
		realloc((void *)mstack,sizeof(struct object**) * mstacksize);
	if(! mstack) {
	    fprintf(stderr,
		    "\nBETA RUNTIME ERROR: out of memory in mstackinsert()!\n");
	    exit(1);
	}

	/* Update statistics */
	mstatus.stack.current.size=mstacksize;
	mstatus.stack.current.count=1;
	mstatus.stack.totalused.size+=mstacksize-oldsize;
	mstatus.stack.totalused.count++;
    }
    /* store item */
    mstack[mstackcnt++]=m;

#if MEMDEBUG
    fprintf(infofile,
	    "mstackinsert: Reference to reference to object %p "
	    "added to the root set.\n",
	    *m);
    fprintf(infofile, "mstackinsert: root set uses %d out of %d items.\n",
	    mstackcnt,mstacksize);
#endif
}

int mgetstackitem(int pos, struct object ***item)
 {/* Returns item of the root set with order pos*/
 if ((pos>0) && (pos<=mstackcnt))
  {
  *item=mstack[pos-1];
  return 1;
  };
 return 0;
 };

#ifdef ANYINFO
void minit(void)
 {/* used for initialization (opening) of tracing file*/
 FILE *f;

 if (!infofile) 
  {
  if (!strcmp(INFOFILE,""))
   f=DEFAULTINFOFILE;
  else
   if (!(f=fopen(INFOFILE,"w")))
    {
    fprintf(stderr,
     "minit:Can't create tracing file, default file will be used\n");
    f=DEFAULTINFOFILE;
    }
  infofile=f;
  }
 };
#endif

/* The next part should be used for possibility of call to another collector
   by callback from main program in BETA.
   Invocation is then done by activateGC()

void installgc2beta(int i,int (*cb)(void))
 {
 switch(i)
  {
  case 0:
   activateGC=cb;
   break;
  }
 };
*/

/* JO */
