include(gbetastd.m4)dnl
begin_page(`',`<CENTER><IMG SRC="clean.jpg" ALT="gbeta"></CENTER>')

<H1>What is _gbeta?</H1>

<P>
<BIG><BIG>_gbeta is a generalization of the programming language
_topref(beta,BETA).  You can _topref(download,download) a
compiler/interpreter for _gbeta, and the source code of this
implementation is freely available under the _topref(copyright,`GPL
copyright').</BIG></BIG>
</P>

define(`_small_logo',
<CENTER>
  <TABLE BORDER=1>
    <TR><TD><IMG SRC="logo-small.gif" ALT="small gbeta logo"></TD></TR>
  </TABLE>
</CENTER>)dnl

<P>&nbsp;</P> 
_small_logo

<H3>Here are some features of the language:</H3>
<P>
In _gbeta, <EM>object metamorphosis</EM> coexists with strict,
static type-checking:  It is possible to take an existing object and
modify its structure until it is an instance of a given class, which
is possibly only known or even constructed at run-time.  Still, the
static analysis ensures that message-not-understood errors can never
occur at run-time.
</P>

<P>
It is possible to define relations between classes, e.g., to specify
that the class <TT>MyPoint</TT> must be a subclass of
<TT>YourPoint</TT> (without committing to exactly what classes they
are).  This makes it possible to define a kind of <EM>constraint graph
of classes</EM>.  It ensures that certain relations hold, such that
one inheritance operation may give rise to a complex but orderly
propagation of type changes in a framework of classes.
</P>

<P>
Like BETA, _gbeta supports inheritance hierarchies not only for
classes but also for methods.  This can be used together with dynamic
inheritance to build <EM>dynamic control structures</EM>; dynamic
control structures enable your algorithms to be parameterized with
e.g. a while statement, an iteration through all elements of a given
list, or reading input from a file.  (NB: a control structure as a
parameter is richer than a procedure or function parameter, because the
control structure can provide a name space to its body).
</P>

<P>
BETA already has strong support for <EM>co-evolution of classes</EM>.
For example, the classes <CODE>vehicle</CODE> and
<CODE>operator</CODE> depend on each other, and they should "know"
each other's enhancement to <CODE>car</CODE> respectively
<CODE>chauffeur</CODE>.   The support for class co-evolution is even
more powerful and flexible in the generalized language _gbeta,
enabling such things as the <CODE>observerDesignPattern</CODE> as a
class which can simply be used in stead of a micro-design-guide (a
"design pattern") which must  be re-implemented again and again.
</P>

<P>
Finally, you might want to get to know more about that weird language
called <EM>BETA</EM> that you have heard so much about but never
really tried out, hands on; the _gbeta implementation provides in some
ways a more dynamic environment even if it is just used to try out
BETA programs. 
</P>

<P>
If you are interested in the design or implementation of modern,
object-oriented programming languages, you should take a closer look
at _gbeta. _topref(beta,BETA) has been around since 1978 or so, but
still it is quite innovative and, IMHO it is very well-designed.
_gbeta implements a superset of BETA,
_topref(compatibility,preserving) the static type checking and adding
a lot of _topref(advanced,`new possibilities').
</P>

_small_logo

<H3>Who doesn't want it, then?</H3>
<P>
There is currently no support for calling external code (e.g., C
libraries), and this prevents the execution of existing BETA programs
which could be compiled by e.g. the _mjolner because the basic
libraries of this system depend on some externals.  Another limitation
is in program size.  It 
would cost too much memory and take too long to run e.g. a
100,000 line program (using many libraries pushes the effective
line-count up); 3000 lines is more realistic, especially if
_topref(lazy,`lazy analysis') is used to achieve a quick startup time.
The current _gbeta implementation is more for the (possibly academic)
geek who is interested in programming language design, and less for
the no-nonsense practical programmer who wants to write large
mission-critical applications.  In other words, it's slow but it uses
a lot of memory.  Finally, the library support is hardly existing by
now.  There is a fair chance that some libraries from the __mjolner
will be adapted to work with _gbeta and made available somehow for
free, but this hasn't happened yet.
</P>

_small_logo

<H3>Why was it created?</H3>
<P>
It has been developed as part of my PhD project, as a workbench for
language design experiments and as a proof-of-concept implementation.
The emphasis has been on a clear, high-level expression of the
language semantics.  This means that language design experiments
can be made at a high level by modifying the _gbeta implementation
itself, using the existing, rather well-encapsulated abstractions.
Moreover the implementation is very general, supporting a number of
"gray corners" of BETA which have not been implemented in the
__mjolner.
</P>

<P>
Nevertheless, the main point in implementing the entire language from 
scratch was to rethink the basic concepts of the language, and to
rebuild a language which has traditional BETA as a special case, but
at the same time enhances the expressive power considerably.
</P>

<H3><A HREF="mailto:eernst@cs.auc.dk">Feed-back</A></H3> 
<P>
is always welcome,
about the language and/or its implementation, about the language
design effort that it incarnates, and about this web site.
</P>

_small_logo

<H3>Aahhh, yes...</H3>

<P>
...the funny symbol on the many colored background is a _gbeta logo, a
stylized version of the letters "gb".  You are welcome to use this
logo on your own web pages if you want to refer to _gbeta.  And here
is a picture which shows a situation during a _gbeta session hosted in
GNU Emacs (click on it to see more):
</P>

<CENTER>
<A HREF="gbeta-screen.gif" TARGET="top">
<IMG SRC="gbeta-small-screen.gif" ALT="screen shot"></A>
</CENTER>

end_page

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
