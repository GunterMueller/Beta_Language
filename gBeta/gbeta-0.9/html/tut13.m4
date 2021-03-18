include(tutorialstd.m4)dnl
_deflr(12,14)dnl
begin_tut(`Repetitions')

<P>
Repetitions are really not that interesting.  They are just the
concept in BETA which corresponds to arrays in other languages,
defining several entities in one go in stead of just one.  
</P>

<P>
Nevertheless, repetitions are one of the very few topics where _gbeta
has been designed to do something which is <EM>not</EM> backward
compatible with BETA.  This is because I thought the semantics was
messy in BETA.. 
</P>

<P>
The basic idea is that a repetition implies "repeated."  Whatever you
can do with a single item of any kind should have a "repeated"
parallel when applied to a repetition.  Assignments can be described
in the following way.  Assume the following declarations: 

program_box(cq[[
(#
   rep1,rep2: [expr] @ptn;
   refrep: [expr] ^ptn
do 
   ...
#)]]nq)

Firstly, the repetition being assigned to (on the right hand side of
<CODE>"-&gt;"</CODE>) gets adjusted to have the same length as the one
being evaluated.  Secondly, assignments distribute over the elements,
i.e. assigning one repetition to another means assigning the first
element of the repetition to the first element of the second, then the
second etc.  Thirdly, the _tutref(5,`object reference marker')
<CODE>"[]"</CODE> distributes over the elements.  Summing up we get
the following equivalences: 

code_box(cq[[rep1->rep2]]nq)

works like: 

code_box(cq[[(* adjust size of 'rep2' *)<BR>
             (for i:rep1.length repeat rep1[i]-&gt;rep2[i] for)]]nq)

code_box(cq[[rep1[]->rep2]]nq)

works like: 

code_box(cq[[(* adjust size of 'rep2' *)<BR>
             (for i:rep1.length repeat rep1[i][]-&gt;rep2[i] for)]]nq)

code_box(cq[[rep1->rep2[]]]nq)

works like: 

code_box(cq[[(* adjust size of 'rep2' *)<BR>
             (for i:rep1.length repeat rep1[i]-&gt;rep2[i][] for)]]nq)

and, finally,

code_box(cq[[rep1[]->rep2[]]]nq)

works like: 

code_box(cq[[(* adjust size of 'rep2' *)<BR>
             (for i:rep1.length repeat rep1[i][]-&gt;rep2[i][] for)]]nq)

It is possible to extract a subrange of a repetition using a
<EM>repetition slice</EM>, 

  code_box(`&lt;AttributeDenotation&gt; "["  &lt;Evaluation&gt; ":" &lt;Evaluation&gt; "]"')

For example <CODE>"rep1[2:2*b]"</CODE> evaluates to a repetition
containing the elements from <CODE>rep1</CODE> starting with
<CODE>rep1[2]</CODE> and ending with <CODE>rep1[2*b]</CODE>. Note that
there are some known _topref(bugs,bugs) in repetition slice handling.
Unfortunately it is rather easy to provoke internal errors
(i.e. detection of internal inconsistencies) or outright run-time
errors in the interpreter with repetition slices, but this will be
fixed. 
</P>

<h3>Example 11</h3>
<P>
As an example, the following defines a repetition of 10 character
objects, puts <CODE>'ABCDEFGHIJ'</CODE> into it, prints the middle
four characters on standard output, then makes <CODE>crefs</CODE>
refer to the same characters and (value) assigns to the first four of
them: 

program_box(cq[[
(* FILE ex11.gb *)
-- betaenv:descriptor --
(#
   chars: [10] @char;
   crefs: [0] ^char
do
   (for i:chars.range repeat '@'+i -> chars[i] for);
   chars[4:7] -> stdio;
   chars[]->crefs[];
   '****'->crefs;
   chars->stdio
#)]]nq)

Note that <CODE>"'****'->crefs"</CODE> truncates <CODE>crefs</CODE>
such that its length becomes 4.  This just means that we have
references to the first 4 elements of <CODE>chars</CODE>, and
<CODE>chars</CODE> is not itself affected by this length adjustment.
</P>

<P>
As usual, _tutref(5,coercion) ensures that the value assignment
<CODE>"'****'->crefs"</CODE> implicitly accesses the character objects
in <CODE>chars</CODE> by dereferencing the object references in
<CODE>crefs</CODE>. 
</P>

<P>
The _tutref(14,next) topic is even more trivial, it's about explicit
object instantiation.
</P>

end_tut

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
