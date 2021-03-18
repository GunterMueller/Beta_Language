include(tutorialstd.m4)dnl
_deflr(1,3)dnl
begin_tut(`The Concept of a <CODE>MainPart</CODE>')

<H3>How it looks</H3>
<P>
A <EM>main part</EM> is a piece of syntax, so you can just look it up
in the grammar (the file gbeta-meta.gram in the distribution).
Roughly, it looks like this:

  code_box(cq[[(# &lt;attributes&gt;<BR>
enter &lt;evaluation&gt;<BR>
do &lt;imperatives&gt;<BR>
exit &lt;evaluation&gt;<BR>
#)]]nq)

The <CODE>&lt;attributes&gt;</CODE> section is a list of declarations.
The <I>enter-part</I>, <CODE>enter &lt;evaluation&gt;</CODE>,
specifies input properties, i.e. arguments accepted for assignment or
procedure call usage.  The <I>do-part</I>, <CODE>do
&lt;imperatives&gt;</CODE>, is a list of <CODE>imperatives</CODE> (in
many languages imperatives are called "statements") which defines the
behavior associated with this main part.  Finally, the
<I>exit-part</I>, <CODE>exit &lt;evaluation&gt;</CODE>, specifies the
output properties, i.e. values delivered when evaluating the main
part. 
</P>

<P>
All the elements are optional, so the list of declarations may be
empty, and any selection of the enter-, do-, and exit-parts may be
absent.  This means that the main part is both a light-weight
construct when only few of the basic elements are present, and it is a
very rich construct when everything is there.
</P>

<P>
Main parts are the building bricks used to construct substance in
_gbeta programs.  Either something is _tutref(16,predefined) (like the
basic pattern <CODE>integer</CODE>), or it was constructed using a
number of main parts.  Like a recursive set, there are atomic
elements, the predefined patterns, and composite elements, built from
"smaller" elements using main parts.
</P>

<H3>Related syntax in other languages</H3>
<P>
Main parts are related to declaration blocks in other languages, such
as e.g. the brace-enclosed blocks used to derive a new class from an
existing one in C++,  

  code_box(`class D : public B <FONT COLOR="blue"><B>{ .. }</B></FONT>;')

or the similar Java syntax, or the keyword-enclosed feature block used
in Eiffel.  They are also related to behavior specification blocks,
such as the brace-enclosed function bodies of a C or C++ or Java
program 

  code_box(`int my_func(float *arg) <FONT COLOR="blue"><B>{ .. }</B></FONT>')

or the keyword-based Eiffel equivalent.  Finally, they include
the specification of input/output properties which are more often
specified outside the block in other languages, for instance in a
parenthesized argument list.
</P>

<H3>Main parts can do it all!</H3>
<P>
Main parts are very versatile, supporting both the description of
substance (attributes) and behavior (do-part), and specifying
input/output properties (enter-/exit-parts), and this allows them to
support the unification of classes, methods, co-routines, control
structures, exceptions, and a lot more.  Since input/output properties
are specified inside the main part, there is no need to declare a name
for a main part.  With more traditional syntax, the grammar wouldn't
easily allow the declaration of a nameless function, for example.
This enables _gbeta to support anonymous entities of many kinds, and
they make a lot of things simpler, more convenient, and more concise.
</P>

<P>
The trade-off is that it is a matter of convention how a given main
part is used in a program.  It may be constructed in such a way that
usage as a method is the only reasonable one, and it may be designed
specifically to support a class-like usage.  In practice, however, it
is rarely a problem to understand the intended use, and often the
generality allows a natural and valuable usage which was nevertheless
unforeseen.
</P>

<H3>Example 1</H3>
<P>
The first example is a program which is similar to the
<CODE>hello2.gb</CODE> program introduced in the "Getting Started"
section:

program_box(cq[[(* FILE ex1.gb *)
-- betaenv:descriptor --
(# 
   hello: (# exit 'Hello' #);
   print: (# enter stdio #)
do 
   hello+', world!\n'-&gt;print
#)]]nq)

Until you start looking into the 
_topref(modularization,`module system'), you may consider the 

  code_box(`-- betaenv:descriptor --')

to be "standard magic" which is necessary to make _gbeta accept the
program..  

<P>
Declarations are associated with a colon and possibly some other
characters, with the declared names to the left of the colon, and the
value or type contraint to the right.

  code_box(`</TT>Declaration: 
            <TT>&lt;names&gt; ":" .. &lt;valueOrConstraint&gt;')

A _gbeta program is ultimately a main part, the outermost block, and
this block encloses everything in the program except for the few
_tutref(16,predefined) entities.  That is the main part which
constitutes the whole program.  Inside this main part, the patterns
<CODE>hello</CODE> and <CODE>print</CODE> are declared as attributes,
and there is a do-part which uses these attributes.
</P>

<P>
The pattern <CODE>hello</CODE> uses only the exit-part, and this is
used for delivering values.  When the value is a constant, the whole
pattern may be considered a constant function, or simply "a constant."
If this exit-part had contained a complex evaluation, much activity
could have been the result of evaluating <CODE>hello</CODE>, such as
it happens in the plus-expression in the do-part.
</P>

<P>
The pattern <CODE>print</CODE> uses only the enter-part, i.e. it has
input properties but no attributes, behaviour, nor output properties.
The input properties are directly taken over from <CODE>stdio</CODE>,
which is a _tutref(16,predefined) entity that enables _gbeta programs
to read from the standard input and write to the standard output.
Please note that <CODE>stdio</CODE> is not an example of careful
language design, it was simply a quick, easy solution to the problem
that _gbeta had to be able to communicate with the rest of the world.
Anyway, putting a value into <CODE>print</CODE> is exactly the same as
putting a value into <CODE>stdio</CODE>, and that means printing it on
the standard output.
</P>

<P>
Finally, the imperative in the do-part, 

  code_box(cq[[hello + ', world!\n' -&gt; print]]nq)

specifies the behavior that the operands of the addition are
evaluated, the resulting value is computed, and this value is
impressed upon <CODE>print</CODE>.  As mentioned in the 
"Getting Started" section, the arrow: 

  code_box(`-&gt')

is associated with flow of values, and the values flow in the
direction of the arrow.  This means that it is used to express
assignment, argument delivery in method/procedure/function calls, and
return value delivery from method/function calls and evaluation of the
state of objects.  
</P>

<P>
Think of it as an instruction to "extract a value"
from whatever is on the left hand side of the arrow, and an
instruction to impress a value upon whatever is on the right hand side
of the arrow.  The value may be arbitrarily complex, expressed by
nested, parenthesized lists, and the recursive "take-over" semantics
which ensures that impressing a value upon <CODE>print</CODE> and upon
<CODE>stdio</CODE> is the same thing.
</P>

<P>
_tutref(3,Next), we'll look at different kinds of declarations.
</P>

end_tut

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
