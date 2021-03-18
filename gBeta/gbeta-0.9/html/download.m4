include(gbetastd.m4)dnl
define(`gbeta_ftp',`"http://www.cs.auc.dk/~eernst/gbeta-0.9/$1"')dnl
define(`ftp_entry',
  `<A HREF=gbeta_ftp(`gbeta-0.9-$1-bin.tgz')>$2</A> <SMALL>($3)</SMALL>')dnl
begin_page(`Downloading _gbeta')

<H3>Source code</H3>

You can download the _gbeta 
<A HREF=gbeta_ftp(`gbeta-0.9-src.tgz')>source code</A>, and this
will enable you to compile the interpreter and to make whatever
experiments with it you want.  Moreover, the source code can give you
detailed information if you want to know more about how such a
language can be statically analyzed, and how it can be executed.

Since the interpreter was implemented in (standard) 
<A HREF="http://www.daimi.au.dk/~beta" TARGET="_top">BETA</A>, you
will need a BETA compiler if you want to _topref(compiling,compile)
your own version of the interpreter. 

<H3>Binaries</H3>

A number of binary versions are available, for the following
platforms (with a few details from the command <CODE>uname</CODE>
given in the parentheses):

<UL>
<LI>
  ftp_entry(`i386-linux-elf',`Linux/x86 (ELF)',
            `Linux 2.4.0 i686 unknown')
</LI>
<LI>
  ftp_entry(`sparc-sun-solaris',`SunOS (Solaris)',
            `SunOS sun4u sparc')
</LI>
<!-- <LI>
  ftp_entry(`hppa1.1-hp-hpux9',`HP-UX 9',
            `HP-UX A.09.05 A 9000/705 unknown')
</LI>
<LI>
  ftp_entry(`mips-sgi-irix6',`SGI IRIX 6',
  `IRIX 6.2 IP22 mips, IRIX 6.3 IP32 mips, IRIX64 6.4 IP30 mips')
</LI>
<LI>
  ftp_entry(`windows',`Windows NT/95',`NB: semi-supported!')
</LI> -->
</UL>

<P>
You need one or more of the above binary distributions unless you want
to compile _gbeta.  If you get binaries for more than one
platform, they can coexist.  A shell script is used to detect what
platform is currently being used, and the relevant binary is
executed. 
</P>

<P>
When you have fetched the files you want, proceed with the 
_topref(installation,installation).
</P>

<!--
<h4>Special issues with the Windows version</h4>
<P>
Please note that the Windows version is not covered explicitly in the
installation section and other places; this means that special
considerations are needed regarding the file system layout (with
<CODE>C:</CODE>,<CODE>D:</CODE>,<CODE>..</CODE> "drive letters") and 
the lack of a portable shell script language.  The binary distribution
works on a Windows NT machine here, but it has not been tested on a
Windows/95 machine, and you will need to edit the
<CODE>gbeta.bat</CODE> file in order to ensure that the environment
variable GBETA_ROOT actually points to the root directory of the
installation.  Moreover, the environment variable BETALIB must be set
on this platform, as specified in the file <CODE>gbeta.bat</CODE>.
</P>

<P>
The easiest approach is probably to copy
<CODE>...\gbeta-0.9\bin\gbeta.bat</CODE> into some directory in your
<CODE>PATH</CODE> and then edit it to make the two environment
variables <CODE>GBETA_ROOT</CODE> and <CODE>BETALIB</CODE> refer to
the root directory of the installation (<CODE>...\gbeta-0.9</CODE>)
resp. the parent directory of that.
</P>

<P>
There is an important problem with Emacs on Windows, namely that the
Grand Unified Debugger framework which is used to integrate _gbeta
with Emacs seems to consistently crash Emacs.  In other words, don't
count on more than command line sessions on Windows.
</P>

<P>
Finally, if you
want to compile _gbeta on a Windows machine, you must search the
source code files and change the explicit path separator strings
from <CODE>"'/'"</CODE> to <CODE>"'\\'"</CODE>.  The source code will
be made cross-platform enough that such editing is unnecessary, but
that hasn't happened yet.  Also note that the Windows version can
<EM>not</EM> co-exist with versions for other platforms since Windows
does not distinguish between upper and lower case letters in
filenames, and generated filenames (sitting inside some generated
files) will consequently have modified case, and then the other
platforms cannot use those files.  To avoid these problems, just
install the Windows version in its own directory or on another disk,
keeping the files entirely separate.
</P>
-->

end_page

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
