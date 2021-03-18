include(gbetastd.m4)dnl
begin_page(Installation of _gbeta)

Installation has several aspects.  First installation of 
<A HREF="#source">source code</A> is covered, and then 
the <A HREF="#binary">binary distributions</A> are treated.  If you
want to install in <A HREF="#nonstandard">another place than your
home</A> directory, you must adjust a few things.  Finally, no matter
what platform you're using and no matter where you installed, you must
<A HREF="#path">enhance your path</A> to include the place where the
interpreter script is located, and you are ready to 
<A HREF="#check">check</A> that your installation works.

<A NAME="source"><H3>Source Code</H3>
<P>
If you have _topref(download,downloaded) the source code, i.e. the
file <CODE>gbeta-0.9-src.tgz</CODE>, then you need to unpack it,
otherwise you may <A HREF="#binary">skip</A> this section.
</P>

<P>
You will get a standard installation by unpacking in your home
directory: 
</P>
  code_box(`cd $HOME')
<P>
For installations elsewhere, see <A HREF="#nonstandard">below</A>.
Assuming that you have put <CODE>gbeta-0.9-src.tgz</CODE> in your
home directory, you can unpack the archive with:
</P>
  code_box(`gtar xzf gbeta-0.9-src.tgz')
If you are running Linux, <CODE>gtar</CODE> is available as
<CODE>tar</CODE>:,
</P>
  code_box(`tar xzf gbeta-0.9-src.tgz')
<P>
and if you are running on another platform where <CODE>gtar</CODE> is
not available, the following should work:
</P>
  code_box(`gunzip gbeta-0.9-src.tgz<BR>tar xf gbeta-0.9-src.tar')
There are a couple of things you might like to know if you want to
_topref(compiling,compile) your own version of the interpreter.
<P>

<A NAME="binary"><H3>Binaries</H3>

<P>
If you have _topref(download,downloaded) one or more binary
distributions of _gbeta, you'll need to unpack them, and the standard
place to do this is your home directory: 
</P>
  code_box(`cd $HOME<BR>')
<P>
Again, <A HREF="#nonstandard">alternative placements</A> are possible.
Then, on Linux:  
  code_box(`gtar xzf gbeta-0.9-i386-linux-elf-bin.tgz')
</P>

<P>
On Sun: code_box(`gtar xzf gbeta-0.9-sparc-sun-solaris2.5-bin.tgz')
</P>

<P>
On HP:  code_box(`gtar xzf gbeta-0.9-hppa1.1-hp-hpux9-bin.tgz')
</P>

<P>
And on SGI: code_box(`gtar xzf gbeta-0.9-mips-sgi-irix6-bin.tgz')
<P>

You may have to use slightly different versions of these commands,
just like <A HREF="#source">above</A>, depending on the kind of
<CODE>tar</CODE> your system provides.

<A NAME="path"><H3>Adjusting the <CODE>PATH</CODE></H3>

The <CODE>PATH</CODE> environment variable must be enhanced to include
the position of the script <CODE>gbeta</CODE> which is used to invoke
the interpreter.  Since the interpreter needs a few environment
variables you cannot just run it on its own, and the script is there
to select the right platform and to provide the correct environment.
In a standard installation, this could be achieved by adding one extra
statement in your shell startup script:

  code_box(`# users of sh family shells (sh,bash,ksh,pdksh,ash..)<BR>
            # would add this to ~/.profile or ~/.bash_profile or ..<BR>
            PATH=$PATH:$HOME/gbeta-0.9/bin')

or 

  code_box(`# users of csh family shells (csh,tcsh)<BR>
            # would add this to ~/.login<BR>
            setenv PATH $PATH:$HOME/gbeta-0.9/bin')

If you prefer that, it is of course possible to use other approaches
than changing your path, e.g.

  code_box(`alias gbeta=$HOME/gbeta-0.9/bin/gbeta')

</P>

<A NAME="check"><H3>Check the Installation</H3>

<P>
Now you are ready to _topref(start,`try out') your installation by
using the interpreter for some basic tasks. 
</P>

<A NAME="nonstandard"><H3>Installing Elsewhere</H3>

<P>
It is possible to install _gbeta in a different place, i.e. not
in your home directory.  Assuming that you have unpacked the files in
the directory <CODE><I>MYDIR</I></CODE>, you must edit the script
which is used to invoke the interpreter.  With e.g. emacs as the
editor that amounts to: 

  code_box(`cd <I>MYDIR</I>/gbeta-0.9/bin<BR>
            chmod u+w gbeta<BR>emacs gbeta')

In the editor you should change the assignment of
<CODE>GBETA_ROOT</CODE> to:

program_box(cq[[...
GBETA_ROOT=${GBETA_ROOT:-<I>MYDIR</I>/gbeta-$GBETA_VERSION}

# ----- INSTALL END ----- 
...]]nq)
</P>

<P>
Alternatively, you can leave the <CODE>gbeta</CODE> script unchanged
and assign to the evironment variable <CODE>GBETA_ROOT</CODE>, by
putting the following into your shell startup file:

program_box(`
# for sh-family shells:
export GBETA_ROOT=<I>MYDIR</I>/gbeta-0.9

# for csh-family shells:
setenv GBETA_ROOT <I>MYDIR</I>/gbeta-0.9')
</P>

<P>
Please note that creating an alias or similar to make it possible to
execute the <CODE>gbeta</CODE> script is not sufficient when
_gbeta is installed in another place than your home directory:
the grammar specifications can not be found if <CODE>GBETA_ROOT</CODE>
does not point to the right directory.
</P>

end_page

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
