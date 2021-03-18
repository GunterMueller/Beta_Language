include(modularizationstd.m4)dnl
_deflr(2,4)dnl
begin_mod(`A Concrete Example')

<P>
Many object oriented languages have a basic inheritance hierarchy
where ordered entities inherit from an <TT>Ordered</TT> class, such 
that the commonalities for all classes of ordered entities can be
factored out.  There is no tradition to do this in the BETA family of
languages, but it is possible to write some patterns that implement
such a hierarchy.  The following example does just that (in _gbeta, of
course).
</P>

<P>
First we must establish a universe wherein everything can be placed:
</P>

program_box(cq[[(* FILE betaenv.gb *)
-- betaenv:descriptor --
(#
   &lt;&lt;SLOT lib:attributes&gt;&gt;;
   puttext: (# enter stdio do INNER #);
   putline: puttext(# do '\n'->stdio #);
   theProgram: @&lt;&lt;SLOT program:merge&gt;&gt;
do
   theProgram
#)]]nq)

<P>
This is a minimal basic library; this would normally be provided as
part of the language implementation, but there is nothing magic about
it so we show it here along with the other files.  For brevity we just
include the few 
things which are actually used, and we even leave out methods to print 
numbers.  The name <TT>stdio</TT> denotes a primitive (built-in)
entity which provides access to the standard input and standard
output.  Note the <TT>lib:attributes</TT> slot; such a slot is
conventionally defined in <TT>betaenv</TT>, and it provides us 
with a "global" namespace.  We also have a <TT>program:merge</TT>
slot; this slot is a placeholder for the program, so all we need to do
when we write programs is to claim this place.  The following fragment
does just that:
</P>

program_box(cq[[(* FILE orderedUser.gb *)
ORIGIN 'betaenv';
INCLUDE 'orderedNumber' 'orderedText' 'orderedAsString'

-- program:merge --

(# 
   t1,t2: ^text;
   n1,n2: ^number;
   r: @real;
do
   'Hello, '->(&t1).init;
   'world!'->(&t2).init;
   (if t1[]->t2.lessEqual then t1.asString->puttext if);
   (t1[]->t2.max).asString->putline;
   
   3.14159->float.init->n1[]; 
   4->int.init->n2[];
   (n1[]->n2.max).asString->putline
#)]]nq)

<P>
The <TT>--program:merge--</TT> syntax means "Here comes the piece of
code which is called program (and it is syntactically a merge
construct)".  The INCLUDE properties ensure that the other fragments
we need will be included, and the ORIGIN property specifies that the
place where the piece of code called program is used is in
<TT>betaenv</TT>.  This is the main program, in the sense that it is
the intended argument to <TT>gbeta</TT>, it contains the application
code which uses the libraries (the remaining files), and it ties all
the pieces together.  The _modref(4,next) section presents the missing
pieces.
</P>

end_mod

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
