include(gbetastd.m4)dnl
begin_page(`Compiling _gbeta`,' Creating Variants')

<P>
If you have _topref(download,downloaded) the soure code, and you have
access to a _mjolner compiler, you can compile the interpreter, and
hence you can perform language design experiments with it.  Since I'd
enjoy cooperating about such endeavors, don't hesitate to <A
HREF="mailto:eernst@cs.auc.dk">ask me</A> if you experience
problems in doing so!
</P>

<P>
Assuming you have installed _gbeta in your home directory, you
can compile the interpreter like this:
</P>

  code_box(`cd $HOME/gbeta-0.9/src/main<BR>beta -lq gbeta')

<P>
This will take some time.  The binary created by this compilation must
be moved to the <CODE>bin</CODE> directory of your _gbeta
installation, and it must be named in a way which shows what platform
it belongs to, i.e. you must execute one of the following commands:
</P>

<P>
On Linux: code_box(`mv gbeta ../../bin/gbeta-0.9-i386-linux-elf-bin')
</P>

<P>
On Sun: code_box(`mv gbeta ../../bin/gbeta-0.9-sparc-sun-solaris2.5-bin')
</P>

<P>
On HP: code_box(`mv gbeta ../../bin/gbeta-0.9-hppa1.1-hp-hpux9-bin')
</P>

<P>
On the SGI platform it is necessary to move a number of auxiliary
dynamically loaded libraries, in order to ensure that the dynamic link
process succeeds: 

  code_box(`mv gbeta ../../bin/gbeta-0.9-mips-sgi-irix6-bin<BR>
            mv sgi/gbeta*..so ../../bin')
</P>

<P>
That's it!  Now you can _topref(start,`try out') your new interpreter,
to see if your installation is basically sound.
</P>

<H3>Creating Variants</H3>

<P>
Of course there could be myriads of different ways to modify
_gbeta.  If you want to experiment with the grammar of the
language, you need the <CODE>dogram</CODE> tool which is delivered
with the __mjolner.  This tool will generate grammar tables
from your customized version of the involved grammars, and the
interpreter cannot use a changed grammar without having these
generated files.  After having generated the new grammar files, you
must adjust a few paths in the generated files.  These paths are
generated on the assumption that the meta-programming system is
located within a standard Mjolner installation, and in this case you
must use the patched version of the meta-programming system which is
included in the _gbeta source distribution (thanks to Mjolner
Informatics for allowing this).  The script <CODE>bin/dogrammar</CODE>
will help you getting this right.
</P>

<P>
Changing the grammar of the language is of course potentially a very
deep change which requires a lot of changes to the static analysis and
run-time system of _gbeta.  Don't hesitate to tell me about your
adventures if you are doing such things!
</P>

end_page

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
