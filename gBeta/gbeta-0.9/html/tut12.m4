include(tutorialstd.m4)dnl
_deflr(11,13)dnl
begin_tut(`Control Structures')

Now that all the interesting stuff has been dealt with, we have to
cover a few odds and ends.  This section is about the imperative
aspect of _gbeta, namely the built-in imperatives for unusual but
structured transfer of control.  Ah, by the way, <CODE>leave</CODE>
and <CODE>restart</CODE> are not boring, even though they are
imperative constructs.

<H3>Standard control structure imperatives</H3>
<P>
Since the 70'ties, all imperative languages (including the
object-oriented subset) have had built-in support for "structured"
versions of <CODE>GOTO</CODE>, now that <CODE>GOTO</CODE> had been
deemed harmful..
</P>

<P>
As a matter of fact, BETA was designed to have a minimal collection of
such constructs, since the generality of the pattern concept allows it
to support all kinds of customized control structures.  As an example,
look at <CODE>scan</CODE> in the <CODE>container</CODE> pattern of
_tutref(8,`example 6') in the section about virtual patterns, and the
<CODE>cycle</CODE> pattern of _tutref(10,`example 8').
</P>

<P>
The <CODE>if</CODE>-imperative comes in a compact version:

  code_box(`"(if" &lt;Evaluation&gt; "then" .. "else" .. "if)"')

and in a version which is similar in use to <CODE>"switch"</CODE> or
<CODE>"case"</CODE> statements in other languages:

  code_box(`"(if" &lt;Evaluation&gt;<BR>
            "//" &lt;Evaluation&gt; "then" ..<BR>
            "//" &lt;Evaluation&gt; "then" ..<BR>
            ..<BR>
            "else" ..<BR>
            "if)"')

The first <CODE>&lt;Evaluation&gt;</CODE> is computed and the value
compared for equality with the <CODE>&lt;Evaluation&gt;</CODE>s after
the <CODE>"//"</CODE> one by one, and the block of imperatives
(<CODE>".."</CODE>) after the first matching value is executed.  If no
equal values are found, the <CODE>else</CODE> imperatives are 
executed.
</P>

<P>
Finally, iterating a pre-computed number of times is supported with
the <CODE>for</CODE>-imperative which also comes in two variants: 

  code_box(`"(for" &lt;Evaluation&gt; "repeat" .. "for)"')

and 

  code_box(`"(for" &lt;Name&gt; ":" &lt;Evaluation&gt; 
            "repeat" .. "for)"') 

The first variant just repeats the body <CODE>".."</CODE> <CODE>
&lt;Evaluation&gt;</CODE> times, and the second does the same, with
&lt;Name&gt; denoting the number of the current iteration, i.e. 1 the
first time round, 2 the second etc.  <CODE>&lt;Name&gt;</CODE> is
<EM>not</EM> an object, it just denotes the value, so it cannot be
changed by assignment, and the type of it cannot be computed (using
<CODE>"##"</CODE>), and it is not allowed to ask for a reference to it
(using <CODE>"[]"</CODE>).
</P>

<H3>Jumping around, and unwinding the stack</H3>
<P>
The two last constructs for the transfer of control are very
expressive, even if they look rather ordinary at the first sight.
They are called <CODE>leave</CODE> and <CODE>restart</CODE>, and they
are used in connection with some kind of block, e.g. a 
_tutref(2,`main part'). 
</P>

<P>
The first one: 

  code_box(`"leave" &lt;Name&gt;')

jumps to the end of the block denoted by the
<CODE>&lt;Name&gt;</CODE>, i.e. it forces the execution of the block
to terminate earlier than it otherwise would.  The other one:

  code_box(`"restart" &lt;Name&gt;')

jumps to the beginning of the block denoted by the
<CODE>&lt;Name&gt;</CODE>, i.e. it forces the execution of the block
to start from the beginning again.
</P>

<P>
The reason why this is not entirely trivial is that we may have (due
to the _tutref(4,coercion)) objects on the stack between the one
associated with the enclosing block and the one which is currently
executing.  In other words, <CODE>leave</CODE> may imply a stack
unwinding which forcefully terminates the execution of any number of
objects before the target object (associated with the target position
in the source code) is at the top of the stack.  Moreover, the number
of objects to unwind off the stack may not be statically determinable.
</P>

<P>
This resembles the exception handling mechanisms of other languages,
e.g. the <CODE>try</CODE> and <CODE>catch</CODE> pair of C++.  The
most important difference is that the combination of coercion, block
structure, and <CODE>leave</CODE>/<CODE>restart</CODE> makes it
possible to have a statically determined target for the "long jump" in
BETA, whereas the stack unwinding in e.g. C++ only terminates in an
ordered fashion if a <CODE>catch</CODE>er happens to be on the
run-time stack.  In Java, this (missing) safety property has been
reinstated by using strict exception declarations on all methods.  On
the other hand, this pervades the entire program, even if lots of
intermediate routines would not have to depend on the given exception
handling strategy.
</P>

<H3>Example 10</H3>
<P>
Here is an example which by the way also demonstrates how it is
possible to create a recursive procedure which will call the
specialized version of itself in specializations.  This is not a
problem with _gbeta, it's an obstacle which never occurs in languages
that do not support specialization of behavior in the first place,
such as anything but BETA and CLOS..  Anyway, we need a notion of
<EM>selfType</EM> or <EM>myType</EM> or whatever else that concept has
been designated in the literature, and again _tutref(4,coercion) comes
to the rescue, since <CODE>this(recur)</CODE> denotes the currently
enclosing object which is coerced into a pattern because it is used in
a pattern context.  As a result, <CODE>selfType</CODE> is declared to
denote the pattern of the enclosing object, and the type system
recognizes that this type is more specialized in the context of the
anonymous specialization of <CODE>recur</CODE> which occurs in the
main <CODE>do</CODE>-part of the program.
</P>

program_box(cq[[
(* FILE ex10.gb *)
-- betaenv:descriptor --
(# 
   recur:
     (# selfType: this(recur);
        enough:&lt; object;
        depth: @integer
     enter depth
     do (if depth&gt;4 then enough if);
        depth+1-&gt;&amp;selfType
     #)
do 
   L: recur(# enough::(# do leave L #)#)
#)]]nq)

You might want to compare this with the following slight variation:

program_box(cq[[
-- betaenv:descriptor --
(# 
   recur:
     (# enough:&lt; object;
        depth: @integer
     enter depth
     do (if depth&gt;4 then enough if);
        depth+1-&gt;&amp;recur
     #)
do 
   L: recur(# enough::(# do leave L #)#)
#)]]nq)
</P>

<P>
The <CODE>"&amp;"</CODE> operator which marks explicit object
instantiation is covered _tutref(14,later).  Just before that, the
_tutref(13,next) topic is repetitions.
</P>

end_tut

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
