/* JO / definition of an interface to the collector unit /*/
#if !defined(__GC_H)
#define __GC_H

void msetgcruns(void);/* Setting on collector activity flag*/
void mresetgcruns(void);/* Resetting collector activity flag*/
int mgetgcruns(void);/* Returns value of collector activity flag*/
int mgetsweepingruns(void);/* Returns value of sweeping activity flag*/
void marksweep(void);/* Starting of garbage collection*/

#endif
/* JO */
