[Kai's comment: this README was written by Jiri Sitera, jiri@zcu.cz]

Hello,

I have left some comments in the source code.  Those have been
marked with my initials "JS".

To generate a map of fragment bindings, see files fragmap.bet and
slotbind.bet.  These are used mostly by BETAfile (compiler.bet) and
b2c.  Local map of bindings are stored by FragMap (for files, that
are recompiled).  Global maps are maintained by slotbind, see
GetSlotBind.

The data structure of repetition is changed (betaenv.bet, beta.h),
as well, as the generation of code for the extend and new
methods (innerimp.bet).  Some constants have been added to the
beta.h file.  Some change is in file att/init, too.  A chart of
the extend algoritm is in doc/extend.pic.
