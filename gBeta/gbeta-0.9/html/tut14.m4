include(tutorialstd.m4)dnl
_deflr(13,15)dnl
begin_tut(`The "new" (&amp;) Operator')

<P>
Sometimes it is desirable to explicitly request that a new object is
instantiated, instead of relying on the _tutref(4,coercion) mechanism
to create objects tranparently whenever an object is required and the
denoted entity is a pattern or a pattern reference.  
</P>

<P>
One reason why the transparency might be unwanted is that the
semantics may depend on having fresh objects.  This is actually mostly
a matter of convenience and performance, since it is typically because
the implementation of a pattern depends on the initialization values
for instances of _tutref(16,`basic patterns').  E.g. a new
<CODE>integer</CODE> has the value zero, and a new <CODE>string</CODE>
is empty. 
</P>

<P>
If some piece of syntax (&lt;Merge&gt;, actually), should denote a
fresh, newly instantiated object, then just put the "new" operator in
front of it:

  code_box(`"&amp;" &lt;Merge&gt;')

As usual, there is a "_tutref(11,concurrent) version" creating an
object which is also a <CODE>component</CODE>:

  code_box(`"&amp;" "|" &lt;Merge&gt;')

If you are explicitly requesting a new object and the given syntax
denotes an existing object, there is a compile-time (well, analysis
time) error and the program is rejected.
</P>

<h3>Renewing an object reference</h3>
<P>
One extension in _gbeta compared to traditional BETA is the
possibility to use the <CODE>"&amp;"</CODE> operator with a name which
denotes an object reference (a "dynamic reference,"
declared with the _tutref(3,`<CODE>"^"</CODE> marker')).  This used to
be a static semantic error.
</P>

<P>
The semantics in _gbeta is that a new instance of the declared type is
created, and the object reference is made to refer to that new
object.  This is similar to the creation syntax <CODE>"!!"</CODE> in
Eiffel.  It is nothing but syntactic sugar for an explicit object
instantiation followed by a reference assignment, e.g.

program_box(cq[[
(#
   ir: ^integer
do 
   (* This: *)
   <FONT COLOR="blue"><B>&iref[]</B></FONT>;
   (* .. is the same as: *)
   &integer[]-&gt;iref[];

   (* And this: *)
   <FONT COLOR="blue"><B>&iref</B></FONT>;
   (* .. is the same as: *)
   &integer[]-&gt;iref[]; 
   iref;
#)]]nq)

Whether or not the (newly created) object should be executed is
determined by the _tutref(5,`<CODE>"[]"</CODE> marker'): when this marker is
present in an imperative (or in an evaluation), the denoted entity is
identified ("a pointer to it is computed") but nothing more happens.
When it is not present, the <CODE>do</CODE>-part is executed, as
always.  Since the execution of an _tutref(16,integer) is a no-op,
nobody would notice in this particular example, though.
</P>

<h3>Caching</h3>
<P>
One special reason why it might be important to explicitly request a
fresh object is that, traditionally, BETA allows a compiler to set up
caching for all objects which are not explicitly requested to be new.
This only applies to objects created as a result of coercion from
pattern or pattern reference to object in an imperative. 
This is normally known by the term <EM>inserted item</EM> even
though that is also the name of a syntactic category which does not
cover all the cases where caching is allowed.  As an example:

program_box(cq[[
(#
   p: (# value: @integer do value+1-&gt;value exit value #)
do 
   (for 3 repeat <FONT COLOR="blue"><B>p</B></FONT>-&gt;putint for)
#)]]nq)

This is should print "123" with caching, since the (same) imperative
mentioning <CODE>p</CODE> will use the same instance of the pattern
denoted by <CODE>p</CODE> which was created by coercion.  In _gbeta
(and in the _mjolner) it prints "111".  In contrast: 
  
program_box(cq[[
(#
   p: (# value: @integer do value+1-&gt;value exit value #)
do 
   (for 3 repeat <FONT COLOR="blue"><B>&amp;p</B></FONT>-&gt;putint for)
#)]]nq)

This must definitely print "111", even according to _tutref(1,`"the
BETA book."')
</P>

<P>
However, this has never been implemented for any cases where it could
be detected (in terms of program state), and it is generally frowned
upon, so it is not (and will not be) implemented to do caching of
inserted items in _gbeta.  Think of it as a non-issue.
</P>

<P>
On the other hand, it might very well be interesting to provide this
functionality explicitly, such that:

program_box(cq[[
(#
   p: (# value: @integer do value+1-&gt;value exit value #)
do 
   (for 3 repeat <FONT COLOR="blue"><B>@p</B></FONT>-&gt;putint for)
#)]]nq)

will print "123" thus making caching an explicit choice by the
programmer.  This has not been implemented, and the grammar does not
even allow it.
</P>

<P>
The _tutref(15,next) topic is general block structure, which might seem
somewhat alien to users of many other languages.
</P>

end_tut

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
