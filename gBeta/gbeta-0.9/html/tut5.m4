include(tutorialstd.m4)dnl
_deflr(4,6)dnl
begin_tut(cq[[Transparency and Coercion (cont'd)]]nq)

<H3>Some non-object contexts</H3>

There are cases where the category of entity we want is not an
object.  In these cases, various syntactic "tails" are available to
tell the language processing system that we want e.g. a pattern.  Note
that there is still transparency of the declared category of entity,
since we are specifying what we want, not how we get it or what we
have. 

<H3>Object reference wanted!</H3>

When we want to obtain an object reference from a given entity, we
must annotate the entity with the "box" suffix:

  code_box(`[]')

For example, when making an object reference refer to another object,
we need to access an entity as an object reference both to obtain the
future state of the target and to assign to the target <EM>as an
object reference</EM>:

program_box(cq[[
(#
   i: @integer;
   ir: ^integer
do
   i[]->ir[]
#)]]nq)

After executing the _tutref(6,`reference assignment')
<CODE>i[]->ir[]</CODE>, <CODE>ir</CODE> refers to the object which
<CODE>i</CODE> (invariably) denotes.
</P>

<h4><EM>Not</EM> executing</h4>
<P>
Note that the request for an object reference does not imply
that the object should be executed.  Consequently, the
<CODE>"[]"</CODE> box marker can be used to <EM>avoid the execution of
an object</EM> when that is required.  
</P>

<P>
For example, assume that <CODE>"p[]"</CODE> is used as an imperative,
i.e. not occurring in an <CODE>enter</CODE>- or
<CODE>exit</CODE>-list, and not before or after an
<CODE>"-&gt;"</CODE> _tutref(6,evaluation) arrow.  Moreover, assume
that <CODE>p</CODE> denotes a pattern.  In that case it means: create
an instance of the pattern <CODE>p</CODE> and obtain and then ignore a
reference to it.  This might e.g. have desirable side-effects in a
concrete situation.  Even more useful is the situation where
<CODE>or</CODE> denotes an object reference attribute and and the
_tutref(14,`"new" operator') <CODE>"&amp;"</CODE> is added,
<CODE>"&amp;or[]"</CODE>.  This means: create an instance of the
declared type of <CODE>or</CODE> and make <CODE>or</CODE> refer to it.
</P>

<H3>Pattern reference wanted!</H3>
<P>
It is possible to compare the types of entities directly, and to do
this we must be able to obtain a pattern reference from any entity,
e.g. an object or an object reference.  We also need to obtain a
pattern reference in order to assign a new value to a 
_tutref(9,`pattern reference attribute').  For these purposes we use
the suffix:

  code_box(`##')

As an example:

program_box(cq[[
(#
   p: (# #);
   or: ^object;
   pr: ^p;
   var_p: ##p;
do
   (if ro## &lt;= p## then ro[]->rp[] else NONE->rp[] if);
   p## -> var_p##
#)]]nq)

The first imperative is an example of type-casing.  Even if frowned
upon, the notion of type-casing keeps emerging as something
object-oriented programmers cannot do entirely without.  The 
_tutref(12,`<CODE>if</CODE>-imperative') compares the type of
<CODE>ro</CODE> (it is the pattern from which the actual, run-time
object denoted by <CODE>ro</CODE> were originally instantiated) with
<CODE>p</CODE> <EM>as a pattern</EM> (implying the "empty" coercion),
and iff <CODE>ro</CODE> is actually an instance of a specialization of
<CODE>p</CODE>, the body <CODE>ro[]->rp[]</CODE> will be executed,
otherwise <CODE>NONE->rp[]</CODE> is executed, making <CODE>rp</CODE>
void.  Afterwards, <CODE>rp</CODE> refers to the same object as
referred by <CODE>ro</CODE> iff that is a type-correct thing to do.
</P>

<P>
The second imperative, <CODE>p##->var_p##</CODE>, is a 
_tutref(6,`pattern reference assignment') which gives
<CODE>var_p</CODE> the pattern <CODE>p</CODE> as value.
</P>

<H4>A super-pattern is a pattern context, too</H4>
<P>
_tutref(7,Specialization) is expressed in its most basic form by a
super-pattern and a main part.  The super-pattern is the basis on
which a new pattern is created, and the main part specifies the
differences and additions.  Whatever occurs in the position of a
super-pattern will be coerced into a pattern.  The following example
contains a named and an anonymous pattern created with the aid of a
super-pattern:

program_box(cq[[
(#
   p: q(# .. #);
do
   boolean(# .. #)
#)]]nq)

Note that the expression <CODE>`boolean(# .. #)'</CODE> contains
super-pattern syntax, _tutref(16,`<CODE>boolean</CODE>'), and is itself
used as an imperative.  As a consequence, there is both the coercion
(in this case a no-op) from pattern to pattern for
<CODE>boolean</CODE>, and the coercion from pattern to object
(instantiation), followed by execution, for the syntax
<CODE>`boolean(# .. #)'</CODE>.
</P>

<H3>Example 2</H3>
<P>
Here is an example which is ever so slightly less artificial (one does
rather easily get tired of <CODE>x-y-z-p-q</CODE> examples, doesn't
one? ;-).  The idea is that you start an interactive _gbeta session on
it, single-step through some of the code and think about the coercions
involved in the execution as it happens.  You can always check out the
category of <CODE>XXX</CODE> using <CODE>"print&nbsp;XXX"</CODE>,
usually abbreviated as in e.g. <CODE>"p&nbsp;thyself.init"</CODE>.
</P>

<P>
The example looks like this:

program_box(cq[[<SMALL>
(* FILE ex2.gb *)
-- betaenv:descriptor --
(# 
   putline: (# enter stdio do '\n'-&gt;stdio #);
   person: 
     (# init: (# enter (name,height) #);
        name: @string;
        height: @real;
        loves: (* we _love_ small persons *)
          (# other: ^person;
             value: @boolean
          enter other[] 
          do (other.height&lt;=height)-&gt;value
          exit value 
          #);
        thumpOnHead: (# do height-0.1 -&gt; height; 'Ouch!!'-&gt;putline #);
        greet:
          (# other: ^person
          enter other[]
          do 'Hi, '+other.name+'!'-&gt;putline
          #)
     #);
   thyNeighbor,thySelf: @person;
do 
   ('me!',6.5)-&gt;thySelf.init;
   ('pal',6.7)-&gt;thyNeighbor.init;
   
   L: (if (thyNeighbor[]-&gt;thySelf.loves)=(thySelf[]-&gt;thySelf.loves) then 
          thyNeighbor[]-&gt;thySelf.greet
       else
          thyNeighbor.thumpOnHead;
          restart L
      if)
#)</SMALL>]]nq)

</P>

<P>
</P>

<P>
_tutref(6,Next), we'll present some more details about evaluations.
</P>

end_tut

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
