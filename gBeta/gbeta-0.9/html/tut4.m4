include(tutorialstd.m4)dnl
_deflr(3,5)dnl
begin_tut(`Transparency and Coercion')

<P>
A very important, implicit, and pervasive aspect of the _gbeta
language is that there is a very consistent <EM>transparency</EM> of
entity category.  When used in a given context, whatever category of
entity is available will be transformed to the category requested by
the context.  Entity categories are object, pattern, object identity
and pattern identity, including concurrent variants.
</P>

<H3>An imperative is an object context</H3>
<P>
An imperative is an object context, and that means that whatever is
denoted by a name which occurs as an imperative in a program will be
transformed into an object, implicitly and without special syntax
which reveals what it was before the transformation.  That information
is available by looking up the declaration anyway. 
</P>

<P>
This is good since it makes the syntax at the point of application
independent of the precise category of entity declared, and this means
that the declaration may be changed without affecting all the usages
of that declared name.
</P>

<P>
The most basic example of this is that a name which denotes an object
and a name which denotes an object reference (think "a pointer" if you
like) are used in the same way, 

program_box(cq[[
(# 
   i: @integer;
   ir: ^integer
do 
   ...
   1->i;
   2->ir;
   ...
#)]]nq)

If we decide to change <CODE>i</CODE> into an object reference, that
is a change which is local to the declaration; the rest of the program
works as before without changes.
</P>

<P>
Of course, this means that it is very un-BETA-like to give names like
<CODE>i</CODE> and <CODE>ir</CODE> which reveal the choice of
representation, but when presenting a transparency mechanism it is
necessary to focus on exactly that which is going to become invisible.
</P>

<P>
Since this transparency is a very basic property of the BETA family of
languages, the traditional BETA terminology is that <CODE>"@"</CODE>
declares a <EM>static reference</EM> and <CODE>"^"</CODE> declares a
<EM>dynamic reference</EM>.  Think of all substance-names as
"pointers"/"references" and then note that some of them are constant
(static) and others are variable (dynamic).  This might seem the most
natural perspective, if you are used to the "everything-is-a-pointer"
semantics of some other object-oriented languages.  When giving the
formal semantics of the language, however, the notion of a "constant
pointer" is an unnecessary complication compared to saying that a name
simply "is" an object.
</P>

<H4>Method invocation is coercion!</H4>
<P>
A very important example of the imperative as an object context is
method invocation.  If a name which denotes a pattern occurs as an
imperative, the pattern is coerced into an object (this transformation
from pattern to object is normally called "object instantiation"), and
the resulting, anonymous object is executed.  As an example:

program_box(cq[[
(# i: @integer;
   p: (# do i+1->i #);
   x: @(# j: @integer do j+i->i #)
do
   p;
   x;
#)]]nq)

In this example, it is not possible to detect syntactically at the
application of the names <CODE>p</CODE> and <CODE>x</CODE> that
<CODE>p</CODE> is a pattern (which is implicitly instantiated to
create a "procedure activation record"), whereas <CODE>x</CODE> is an
object which is simply executed (hence keeping its local state intact
between "invocations"). 
</P>

<P>
As a consequence of this, a pattern may be thought of as a procedure
or method, since applying them as an imperative "works like" an
invocation as known in other imperative languages.
</P>

<H3>An evaluation is also an object context</H3>

Since an _tutref(6,evaluation) is also an object context, the
mechanism of the following examples are the same as explained above:

program_box(cq[[
(# i: @integer;
   ir: ^integer;
   p: (# enter ir do (if ir&lt;i then i-ir else i+ir if)->i 
      exit 2*i 
      #);
   x: @(# j: @integer enter j do j+i->i #)
do
   ...
   i+ir->putint;
   ((x,x),x)->(max,p)->min->putint;
   ...
#)]]nq)

When <CODE>i</CODE> is printed with the assignment evaluation
<CODE>i+ir->putint</CODE>, the transformation of <CODE>i</CODE> is a
no-op since it is already an object.  However, <CODE>ir</CODE> is
coerced from object reference to object.  You may think of it as
"dereferencing a pointer."  On the right hand side of the assignment
evaluation, <CODE>putint</CODE> is coerced from a pattern into an
object, i.e. an instance is created, and this instance is then
executed.
</P>

<P>
The next imperative is a composite (multiple) assignment evaluation.
Everywhere, whether a name delivers a value (it occurs before
<CODE>-&gt;</CODE>), or a value is impressed upon it (it occurs after
<CODE>-&gt;</CODE>), or both (it occurs between two
<CODE>-&gt;</CODE>'s), patterns are instantiated and object references
are dereferenced implicitly.  The
_tutref(12,`<CODE>if</CODE>-imperative') in <CODE>p</CODE> is 
covered later.
</P>

<P>
The _tutref(5,next) section deals with a number of non-object contexts.
</P>

end_tut

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
