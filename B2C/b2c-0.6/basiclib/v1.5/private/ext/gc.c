/* JO Body of collector unit */

#include "gc.h"
#include "mmalloc.h"
#include "rootset.h"

static int gcruns=0;
    /* Value used for presetting of mlive item in a newly created
       object (and either this value indicates that collector is running) */
static int gcsweepingruns=0; /* A flag indicating that runs sweeping phase */
static int minvocations=0; /* Counter of invocations of collecting */

int mgetgcruns(void)
 {/* returns value of flag indicating that collector is running*/
 return gcruns;
 };

void msetgcruns(void)
 {/* sets the flag indicating that collector is running*/
 if (!gcruns)
  {
#if defined INFOIOA || defined INFOLVRA || defined INFOCBFA
  if ((INFOIOA)||(INFOLVRA)||(INFOCBFA)) fprintf(infofile,
   "msetgcruns: Flag of collector activity was set\n");
#endif
  gcruns=1;
  }
 };

void mresetgcruns(void)
 {/* resets the flag of collector activity*/
#if defined INFOIOA || defined INFOLVRA || defined INFOCBFA
 if ((INFOIOA)||(INFOLVRA)||(INFOCBFA)) fprintf(infofile,
  "mresetgcruns:Flag of collector activity was reset\n");
#endif
 gcruns=0;
 };

#if defined INFOIOA || defined INFOLVRA || defined INFOCBFA
#define USAGE(MOF,TH) double TH##usage##MOF (void)\
{ if (stat->MOF.totalused.TH)\
 if (stat->MOF.totalfreed.TH)\
  return 100*(1-((double)stat->MOF.totalfreed.TH/\
   (double)stat->MOF.totalused.TH));\
 else return 100.0;\
else\
 return 0.0;\
};
#define MUSAGE(MOF) USAGE(MOF,size)
#define CUSAGE(MOF) USAGE(MOF,count)

static struct mstatus *stat;/* local variable for statistics displaying*/

MUSAGE(ioa)/* by expanding of macros will by created functions for displaying*/
MUSAGE(lvra)/* of percentual memory usage */
MUSAGE(stack)
CUSAGE(ioa)/* and amount of object usage*/
CUSAGE(lvra)/* resp. fields of repetitions*/
CUSAGE(stack)

void gcstatistics()
 {
 stat=mgetstatus();
 fprintf(infofile,"gcstatistics:Actual state of memory:\n");
 if (INFOIOA)
  fprintf(infofile,"gcstatistics:Memory used by objects %d,\
 amount of objects %d\n",stat->ioa.current.size,stat->ioa.current.count);
 if (INFOLVRA)
  fprintf(infofile,"gcstatistics:Memory used by fields %d,\
 amount of fields %d\n",stat->lvra.current.size,stat->lvra.current.count);
#if MEMDEBUG
  fprintf(infofile,
   "gcstatistics:Memory used by stack (root set) %d,\
 amount of items %d\n",stat->stack.current.size,stat->stack.current.count);
#endif
 fprintf(infofile,"gcstatistics:Summary of used memory:\n");
 if (INFOIOA)
  fprintf(infofile,"gcstatistics:Memory used by objects %d,\
 amount of objects %d\n",stat->ioa.totalused.size,stat->ioa.totalused.count);
 if (INFOLVRA)
  fprintf(infofile,"gcstatistics:Memory used by fields %d,\
 amount of fields %d\n",stat->lvra.totalused.size,stat->lvra.totalused.count);
#if MEMDEBUG
  fprintf(infofile,
   "gcstatistics:Memory used by stack (root set) %d,\
 amount of items %d\n",stat->stack.totalused.size,stat->stack.totalused.count);
#endif
 fprintf(infofile,"gcstatistics:Summary of reclaimed memory:\n");
 if (INFOIOA)
  fprintf(infofile,"gcstatistics:Memory reclaimed by objects %d,\
 amount of objects %d\n",stat->ioa.totalfreed.size,stat->ioa.totalfreed.count);
 if (INFOLVRA)
  fprintf(infofile,"gcstatistics:Memory reclaimed by fields %d,\
 amount of fields %d\n",stat->lvra.totalfreed.size,stat->lvra.totalfreed.count);
#if MEMDEBUG
  fprintf(infofile,
   "gcstatistics:Memory reclaimed by stack (root set) %d,\
 amount of items %d\n",stat->stack.totalfreed.size,stat->stack.totalfreed.count);
#endif
  fprintf(infofile,"gcstatistics:Summary of percentual memory usage:\n");
 if (INFOIOA)
  fprintf(infofile,
   "gcstatistics:by objects %3.2f %% objects area, using %3.2f %% objects\n",
   sizeusageioa(),countusageioa());
 if (INFOLVRA)
  fprintf(infofile,
   "gcstatistics:by fields %3.2f %% fields area, using %3.2f %% fields\n",
   sizeusagelvra(),countusagelvra());
#if MEMDEBUG
  fprintf(infofile,
   "gcstatistics:by stack %3.2f %% root set area,\
 using %3.2f %% stack items\n",sizeusagestack(),countusagestack());
 fprintf(infofile,"gcstatistics:Collector has been invoked by %d times\n",\
  minvocations);
#endif
 };
#endif

void marking(void)
 {
 /* The first phase of collecting will mark all objects accessible
    from root set*/
 int i;
 struct object **m;

#if defined INFOIOA || defined INFOLVRA
 if ((INFOIOA)||(INFOLVRA)) fprintf(infofile,
  "marking:The first collection phase is activated\n");
#endif
 for(i=1;i<=mgetstackcnt();i++)
  if (mgetstackitem(i,&m)) 
   {
   if (!markit(*m)) 
#ifdef INFOIOA
    if (INFOIOA) fprintf(infofile,
     "marking:An Error occured when marking objects from starting by\
 reference %p!\n",*m);
#else
    ;
#endif
   }
#ifdef INFOIOA 
  else
   if (INFOIOA) fprintf(infofile,
    "marking:Failed acquisition of item %d from root set!\n",i);
#endif
#if defined INFOIOA || defined INFOLVRA
 if ((INFOIOA)||(INFOLVRA)) fprintf(infofile,
  "marking:The first collection phase is done\n");
#endif
 };

int mgetsweepingruns(void)
 {/* Returns value of collector activity flag*/
 return gcsweepingruns;
 };

void sweeping(void)
 {
 /* The second collection phase will walk through list of memory blocks and
    reclaim not marked objects and fields*/
 struct mchain *d,*p=&mlist;/* d for reclaiming, p for walking through list
                               of allocated objects*/
 struct mrchain *dr,*pr=&mrlist;/* to same for list of repetitions fields*/
 int mmark=mgetmmark();/* Actual mark meaning live objects and fields*/

 gcsweepingruns=1;
#if defined INFOIOA
 if (INFOIOA)
  fprintf(infofile,"sweeping:Reclaiming of dead objects is activated\n");
#endif
 while (p)
  {
  if ((p->mnext) && (mgetlive(p->mnext)!=mmark))
   {
   d=(struct mchain *)p->mnext;/* Save reference to reclaiming object*/
   /* Rejection an item from the list of allocated objects*/
   p->mnext=((struct mchain *)((char *)d-sizeof(struct mchain)))->mnext;
   mfree(d);
   }
  else 
   {
   p=(struct mchain *)p->mnext;
   if (p) (char *)p-=sizeof(struct mchain);
   }
  }
#if defined INFOIOA 
 if (INFOIOA)
  fprintf(infofile,"sweeping:Reclaiming of dead objects is done\n");
#endif
#if defined INFOLVRA 
 if (INFOLVRA)
  fprintf(infofile,"sweeping:Reclaiming of dead fields is activated\n");
#endif
 while (pr)
  {
  if ((pr->mnext) && (mrgetlive(pr->mnext)!=mmark))
   {
   dr=(struct mrchain *)pr->mnext;
   pr->mnext=((struct mrchain *)((char *)dr-sizeof(struct mrchain)))->mnext;
   mrfree(dr);
   }
  else
   {
   pr=(struct mrchain *)pr->mnext;
   if (pr) (char *)pr-=sizeof(struct mrchain);
   }
  }
#if defined INFOLVRA
 if (INFOLVRA)
  fprintf(infofile,"sweeping:Reclaiming of dead fields is done\n");
#endif
#if defined INFOIOA || defined INFOLVRA
 if ((INFOIOA)||(INFOLVRA))
  fprintf(infofile,"sweeping:The second collection phase is done\n");
#endif
 gcsweepingruns=0;
 };

void marksweep(void)
 {/* Hlavni telo cistice*/
#ifdef MAXDEBUG
 fprintf(infofile,"marksweep:State of memory before collection\n");
 mdump();
#endif
#if defined INFOIOA || defined INFOLVRA || defined INFOCBFA
 if ((INFOIOA)||(INFOLVRA)||(INFOCBFA))
  gcstatistics();
#endif
#ifdef MAXDEBUG
 fprintf(infofile,"marksweep:Garbage collector is activated\n");
#endif
 msetgcruns();/* set collector activity flag*/
 minvocations++;
 marking();/* start marking of live blocks*/
#ifdef MAXDEBUG
 fprintf(infofile,"marksweep:State of memory after marking phase\n");
 mdump(); 
#endif
 sweeping();/* reclaiming of not marked blocks*/
 mchangemark();/* change mark value for next marking phase*/
 msetstatusaftergc();
 mresetgcruns();/* reset collector activity flag*/
#ifdef MAXDEBUG
 fprintf(infofile,"marksweep:State of memory after collection\n");
 mdump();
#endif
#if defined INFOIOA || defined INFOLVRA || defined INFOCBFA
 if ((INFOIOA)||(INFOLVRA)||(INFOCBFA))
  gcstatistics();
#endif
 };
/* JO */
