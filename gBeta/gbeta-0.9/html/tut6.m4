include(tutorialstd.m4)dnl
_deflr(5,7)dnl
begin_tut(`Evaluations')

<P>
Evaluations are related to the input/output properties of various
entities, and that has to do with "extracting the value from" or
"impressing a value upon" an entity.  Syntactically, we're talking
about expressions and about the following syntactic elements:

  code_box(`<CENTER>..-&gt;..<BR>enter ..<BR>exit ..</CENTER>')

One very important property of _gbeta evaluations is that they are
determined by the static analysis information.  Even though a
specialization hierarchy may have a different number of arguments at
different levels of specialization, it is always the statically known
types of the entities being evaluated or assigned to that determines
the structure of the values delivered and accepted.
</P>

<H3>Evaluation lists</H3>
<P>
In general, expressions may be composed into tuples in _gbeta.
If <CODE><I>X1</I>..<I>Xn</I></CODE> are expressions, then the
following is also an expression:

  code_box(`(<I>X1</I>, .. ,<I>Xn</I>)')

Moreover, if <CODE><I>T1</I>..<I>Tn</I></CODE> are assignable (the
grammar term is <CODE>&lt;Transaction&gt;</CODE>) then 

  code_box(`(<I>T1</I>, .. ,<I>Tn</I>)')

is assignable.  As an example, if you could do:

  code_box(`a-&gt;x; b-&gt;y; c-&gt;z')

then you can also do:

  code_box(`(a,(b,c))-&gt;(x,(y,z))')

It is important to note, however, that this does <EM>not</EM> imply a
"parallel assignment" semantics, which computes the composite value of
the entire left hand side of the arrow, and then impresses this value
on the right hand side.  In contrast, the programmer should
<EM>not</EM> rely on a particular ordering in the value transfers.
</P>

<P>
The reason why the language has such a "messy" semantics is
performance.  If the semantics was the "pure" parallel assignment,
every single assignment and method call in a _gbeta program would
give rise to the allocation of temporary data, and presumably only a
very small fraction (though an undecidable fraction) of the program
would actually rely on this semantics.  Consequently, all programs
would have twice as bad performance, just because we wanted the
proverbial "swap" to look good:

  code_box(`(x,y)->(y,x) (* NB: <EM>not</EM> a swap! *)')

The message is: if you need temporary variables for swap-like actions,
declare them! 
</P>

<H3>Assignments and method invocations</H3>
<P>
As mentioned before, assignment looks like this: 

  code_box(`LHS -&gt; RHS')

Syntactically, this is an assignment evaluation.  <CODE>LHS</CODE> is
evaluated, that is: the current value is extracted from it.
<CODE>RHS</CODE> gets this value impressed upon it. 
</P>

<P>
In the special case where <CODE>RHS</CODE> is an object, this has the
effect which is known as (value) assignment in many languages.  It
changes the state of the object denoted by <CODE>RHS</CODE>.
</P>

<P>
In the case where <CODE>RHS</CODE> is a pattern (which is then by
_tutref(4,coercion) instantiated), the effect is known as method
invocation or procedure call in many languages.  The amonymous object
which is created by coercion receives the given value and is then
executed, corresponding to the transfer of actual arguments to a
method or procedure followed by the execution of its body.  Note that
this means that "arguments are moved in front of the method name in
_gbeta."  What looks similar to this in other languages:

  code_box(`obj.aMethod(arg1,arg2,..) // NB: not BETA syntax')

looks like this in _gbeta: 

  code_box(`(arg1,arg2,..)->obj.aMethod')

You might even agree that this syntax is more consistent and readable:

program_box(cq[[
// in an ordinary programming language ;-)
// assume "type result = {result1:type1; result2:type2;};"

var res: result;

res = proc3(proc2(proc1(arg1),arg2))
result1 = res.result1;
proc4(res.result2);]]nq)

program_box(cq[[
(* in BETA syntax *)

(arg1->proc1,arg2)->proc2->proc3->(result1,proc4)
]]nq)
</P>

<H3>Reference assignments</H3>
<P>
As mentioned above, the default assignment semantics in _gbeta is
<EM>value assignment</EM>, i.e. the transfer of some representation of
the state of one object into another object, changing the state of the
other object but not changing the object identity.
</P>

<P>
Another important kind of assignment is the <EM>reference
assignment</EM>, which is the default assignment semantics in many
object-oriented languages, e.g. Smalltalk and Eiffel (for non-expanded
types).  This implies a change of object identity, and hence it is
only possible in _gbeta for attributes which denote object references
(i.e. attributes declared with the <CODE>"^"</CODE> declaration flag,
i.e. dynamic references in traditional BETA terminology).
</P>

<P>
When <CODE>LHS</CODE> evaluates to an object reference with an
acceptable type, an <EM>(object) reference assignment</EM> to the
object reference denoted by <CODE>or</CODE> can be written as:

  code_box(`LHS -&gt; or[]')
</P>

<P>
There is an analogous case for patterns: When <CODE>LHS</CODE>
evaluates to a pattern reference with an acceptable type, a
<EM>pattern reference assignment</EM> to the pattern reference denoted
by <CODE>pr</CODE> can be written as: 

  code_box(`LHS -&gt; pr##')

After this, the value of <CODE>pr</CODE> will be the pattern reference
resulting from the evaluation of <CODE>LHS</CODE>.
</P>

<P>
In fact, this is just a special case of the _tutref(5,coercion)
described earlier, since we are really requesting that <CODE>or</CODE>
should be impressed a value <EM>as an object reference</EM>, and
similarly for <CODE>pr</CODE>.  The specialty is that this is only
allowed when the coercion is trivial (e.g. <CODE>or</CODE> is already
an object reference).  Consider coercing something into a temporary
entity (e.g. from pattern to object reference) and then assigning that
entity, and immediately discarding the temporary; the assignment would
simply "disappear!"  Since this is not a desirable scenario,
non-trivial coercions are forbidden on the receiving side of a
reference assignment.
</P>

<P>
For example:

program_box(cq[[
(#
   p: (# #);
   pr: ^p;
   opr: ##object
   x: @p;
   give_x: (# exit x[] #);
   give_typeof_x: (# exit x## #);
do
   x[]->pr[]; 
   give_x->pr[];
   x##->opr##;
   give_typeof_x->opr##;
   pr[]->x[]; (* rejected! non-trivial coercion of 'x' *)
#)]]nq)
</P>

<H3>Enter- and exit-parts</H3>
<P>
The input/output properties of _tutref(16,`basic patterns') like
<CODE>boolean</CODE> and <CODE>integer</CODE> are predefined and
simple: an <CODE>integer</CODE> is able to accept one value from the
set of integer values supported in the language, and it will deliver
one such value when evaluated; similarly for the other basic patterns.
</P>

<P>
Attribute denotations (e.g. names) with the explicit coercion
markers <CODE>"[]"</CODE> and <CODE>"##"</CODE> also have atomic
input/output properties, e.g. if <CODE>or</CODE> were an object
reference, <CODE>or[]</CODE> would deliver and accept one value
belonging to the set of object references with a type that matches the
declaration. 
</P>

<P>
The input/output properties associated with a _tutref(2,`main part')
are defined in terms of the <CODE>enter</CODE>- and
<CODE>exit</CODE>-parts.  An <CODE>enter</CODE>-part (and an
<CODE>exit</CODE>-part) may contain a single evaluation or an
evaluation list (a tuple).  The input (resp. output) properties are
computed by looking up the entities mentioned in the evaluation
recursively, until atomic entities have been found.  In general this
process computes a nested tuple of primitive input (output) types.
</P>

<P>
An assignment is accepted by the type-checker iff the left hand side
and right hand side have identical nested tuples of value types as
output rsp. input properties.  Interactively, you can inspect these
tuples using the commands <CODE>assigninfo</CODE> and
<CODE>evalinfo</CODE>.
</P>

<H3>Do-parts</H3>
<P>
The <CODE>do</CODE>-part of a _tutref(2,`main part') participates in
input/output.  The simple (and complete) rule is that the
<CODE>do</CODE>-part is always executed.  This means that the
<CODE>do</CODE>-part is executed before an <CODE>exit</CODE>-part is
evaluated, and the <CODE>do</CODE>-part is executed after an
<CODE>enter</CODE>-part has been assigned to, and the
<CODE>do</CODE>-part is executed between the assignment to the
<CODE>enter</CODE>-part and the evaluation of the
<CODE>exit</CODE>-part if both processes are taking place.
</P>

<P>
</P> 

<H3>Example 3</H3>
<P>
Here is an example of this recursive lookup process:

program_box(cq[[<SMALL>
(* FILE ex3.gb *)
-- betaenv:descriptor --
(# 
   point: 
     (# x,y: @integer 
     enter (x,y) 
     do INNER 
     exit (x,y) 
     #);
   rectangle: (# ul,lr: @point enter (ul,lr) exit (ul,lr) #);
   
   i,j,k,l: @integer;
   p1,p2: @point;
   r1,r2: @rectangle
do 
   (3,4)-&gt;p1-&gt;(i,j);
   p1-&gt;p2;
   (p2.x+i,p2.y+j)-&gt;p2;
   (p1,p2)-&gt;r1-&gt;((i,j),(k,l));
   r1-&gt;r2
#)</SMALL>]]nq)
</P>

<P>
Note that one useful way to use <CODE>enter</CODE>- and
<CODE>exit</CODE>-parts is to define the semantics of value assignment
for a pattern.  The <CODE>do</CODE>-part in <CODE>point</CODE> is only
there to annoy you when single-stepping: generally,
<CODE>do</CODE>-parts take place in everything, as you will see! ;-)
</P>

<P>
The _tutref(7,next) section presents the BETA concept of inheritance,
designated <EM>specialization</EM>.
</P>

end_tut

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
