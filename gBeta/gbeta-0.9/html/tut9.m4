include(tutorialstd.m4)dnl
_deflr(8,10)dnl
begin_tut(`Pattern References')

<P>
Some people view patterns reference attributes (syntactically:
<CODE>&lt;VariablePattern&gt;</CODE>) as the undisciplined,
"goto"ish variant of _tutref(8,`virtual patterns').
True enough, if you can use the more disciplined virtual patterns for
a given purpose, by all means do that.  On the other hand there is
still a place for real, genuine type variables, and that is just what
a <CODE>&lt;VariablePattern&gt;</CODE> attribute is.
</P>

<H3>What is a pattern reference?</H3>
<P>
A <CODE>&lt;VariablePattern&gt;</CODE> attribute has a state which is
a pattern reference.  The only difference between the set of patterns
and the set of pattern references is that <CODE>NONE</CODE> is
included in the set of pattern references.  In other words, it is the
set of patterns enhanced with a "bottom" element which is used to
signify the absence of a pattern value. 
</P>

<P>
The reason behind the terminology "pattern" and "pattern reference" is
that this might hint at the analogy with "object" and "object
reference."  Attributes denoting the "reference" variant may change
(what it refers to) over time, whereas attributes denoting the short
variant ("pattern"/"object") are immutable: the state of an object may
change, but the attribute always denotes the same object.
</P>

<H3>What does it look like?</H3>
<P>
The declaration uses the same marker as used in pattern concext
_tutref(5,coercion), namely <CODE>"##"</CODE>:

  code_box(`&lt;Names&gt; ":" "##" &lt;AttributeDenotation&gt;')

for example:

program_box(cq[[p: ##object]]nq)
</P>

<H3>Example 7</H3>
<P>
A small example of using a pattern reference attribute:

program_box(cq[[<SMALL>
(* FILE ex7.gb *)
-- betaenv:descriptor --
(# 
   factory:
     (# settype: (# enter type## #);
        counter: @integer;
        type: ##object
     do counter+1-&gt;counter
     exit &type[]
     #);
   f: @factory;
   agent: (# do (for 25 repeat '.'-&gt;stdio for); '\n'-&gt;stdio #)
do 
   agent##-&gt;f.settype;
   (for 5 repeat f! for);
   integer##-&gt;f.settype;
   (for 5 repeat f! for)
#)</SMALL>]]nq)

The <CODE>"!"</CODE> suffix is a <EM>computed object evaluation</EM>.
The semantics is that the expression in front of it is evaluated.  It
must deliver one reference to an object (this is checked statically,
of course).  That object is then executed.  The
_tutref(12,`<CODE>for</CODE>-imperative') is presented later, and so is
the explicit object _tutref(14,`instantiation operator'),
<CODE>"&amp;"</CODE>. 
</P>

<P>
Now to something completely different, the _tutref(10,next) section is
about co-routine sequencing. 
</P>

end_tut

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
