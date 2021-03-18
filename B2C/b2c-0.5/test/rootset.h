/* JO Header file for sharing of memory blocks list */
#if !defined(__ROOTSET_H)
#define __ROOTSET_H
 
struct mchain {void* mnext;};/* structure inserted before each object*/
struct mrchain {void* mnext;int len,mlive;};/* dtto before each field*/

extern struct mchain mlist;/* accesses objects blocks to collector*/
extern struct mrchain mrlist;/* accesses fields blocks to collector*/

#endif
/* JO */
