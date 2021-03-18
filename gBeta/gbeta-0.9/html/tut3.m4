include(tutorialstd.m4)dnl
_deflr(2,4)dnl
begin_tut(`Overview of Declarations')

The declaration syntax in _gbeta is very simple and consistent.  It is
also based on "funny" characters, and this makes it hard for the
casual reader to understand what is going on in a _gbeta program,
since the reader's basic assumptions about the meaning of syntax do
not reveal enough.  The trick is to focus on the few "funny"
characters right after the colon, they tell what kind of attribute is
being declared here.
</P>

<P>
The syntax specifications below mention the <CODE>&lt;Merge&gt;</CODE>
and the <CODE>&lt;AttributeDenotation&gt;</CODE> syntax categories.
For now, think of a <CODE>&lt;Merge&gt;</CODE> as a main part or an
identifier, and think of an <CODE>&lt;AttributeDenotation&gt;</CODE>
as an identifier.  The examples go slightly beyond what has been
presented sofar, so don't despair if some of the examples can not be
fully explained by now.
</P>

<H3>Declarations of patterns</H3>
<P>
A pattern is declared by the simplest form of declarations:

  code_box(`&lt;Name&gt; ":" &lt;Merge&gt;')

A pattern is the language concept in _gbeta which takes care of every
aspect of structure description.  Whenever a piece of substance is
created, its structure is created according to some pattern, and that
again consists of predefined and/or main part specified building
blocks.  To be precise, a pattern also specifies a run-time context,
i.e. one or more enclosing objects (<CODE>origins</CODE>).  Since a
pattern includes the specification of some enclosing objects, it does
not exist before run-time, and patterns associated with the same
syntax (main parts) are still different if their enclosing objects are
different.  The static analysis works with patterns relative to a
given run-time environment:  take the analysis version of a pattern
and provide it with a concrete run-time context, and there is your
pattern!  The fact that the run-time context is included into patterns
makes it possible to create substance directly from patterns.  Here's
an example of some pattern declarations: 

program_box(cq[[
p: (# q: (# #); 
      r: (# s: (# #);
            t: (# #)
         #);
      u: boolean
   #);
v: (# #)]]nq)
</P>

<H3>Declarations of objects</H3>
<P>
Objects (part objects) are declared using the <CODE>"@"</CODE>
substance flag: 

  code_box(`&lt;Names&gt; ":" "@" &lt;Merge&gt;')

A variant declaration specifies that the object should have its own
execution stack:

  code_box(`&lt;Names&gt; ":" "@" "|" &lt;Merge&gt;')

This is used when creating concurrent threads or co-routines.
A few examples:

program_box(cq[[
i,j: @integer;
f: @real;
y: @|(# g: @real do INNER #);
x: @(# k,l.m: @boolean #) & somePattern]]nq)
</P>

<H3>Declarations of object references</H3>
<P>
To allow a name to refer to varying objects during the execution of a
program, it is necessary to introduce the notion of <EM>object
identity</EM>.  When using the <CODE>"@"</CODE> substance flag, a name
is declared to denote an object, and that's it, but when using the
<CODE>"^"</CODE> object identity flag, the name is declared to denote
the identity of an object, and by changing the state of this
attribute, it lets the name refer to different objects at different
times, or possibly to "no object," <CODE>NONE</CODE>.

  code_box(`&lt;Names&gt; ":" "^" &lt;AttributeDenotation&gt;')

Again, there is a concurrency biased version:

  code_box(`&lt;Names&gt; ":" "^" "|" &lt;AttributeDenotation&gt;')

The headline of this section mentions "references" since object
identity attributes are often implemented by pointers to memory cells
and often denoted "pointers" or "references."  Hence, we will use the
terms <EM>object reference attribute</EM> or just <EM>object
reference</EM>. 
</P>

<P>
The <CODE>&lt;AttributeDenotation&gt;</CODE> on the right hand side of
the declaration specifies the <EM>qualification</EM> of the object
reference attribute.  The qualification is a type constraint on the
objects which can be referred to by the attribute.  The constraint is
that the pattern of the referred object should be a specialization of
the pattern of the qualification.  In other words, the qualification
promises a certain richness of the interface, and the actual object
will at all times support an interface which is at least that rich.
</P>

<P>
A few examples are:

program_box(cq[[
ir1,ir2: ^integer;
pr: ^p;
conc_pr: ^|p;]]nq)
</P>

<H3>Declarations of virtual patterns</H3>
<P>
A virtual pattern is a pattern.  But a virtual declaration does not
declare the precise pattern value, it declares an upper bound on the
type (or a lower bound on the structure) denoted by the declared
name.  We'll return to this in more detail
_tutref(8,later).  there are three variants; the virtual declaration:

  code_box(`&lt;Name&gt; ":" "<" &lt;Merge&gt;')

.. the virtual further-binding:

  code_box(`&lt;Name&gt; ":" ":" "<" &lt;Merge&gt;')

.. and the virtual final-binding: 

  code_box(`&lt;Name&gt; ":" ":" &lt;Merge&gt;')

They look like this: 

program_box(cq[[
p: (# v:< (# #)#); 
q: p(# v::< (# #)#);
r: q(# v:: (# #)#)]]nq)
</P>

<H3>Declarations of pattern references</H3>
<P>
Just like we can have a name which denotes an object and another name
which may denote different objects at different times, we can also
have the dynamically varying version of a pattern declaration:

  code_box(`&lt;Names&gt; ":" "##" &lt;AttributeDenotation&gt;')

This declares the names to be attributes whose values are patterns.
The patterns must be specializations of the pattern denoted by the
right hand side of the colon.  This is also covered in more detail
_tutref(9,later).  An example is:

program_box(cq[[pr1,pr2: ##p]]nq)
</P>

<H3>Declarations of repetitions</H3>
<P>
A 
_tutref(13,repetition) in _gbeta corresponds to what is often
designated an array in other languages.  Most attributes can be
declared in repeated versions: 

  code_box(`&lt;Name&gt; ":" "[" &lt;Index&gt; "]" "@" &lt;Merge&gt;')
  code_box(`&lt;Name&gt; ":" "[" &lt;Index&gt; "]" "@" "|" &lt;Merge&gt;')
  code_box(`&lt;Name&gt; ":" "[" &lt;Index&gt; "]" "^"
           &lt;AttributeDenotation&gt;')
  code_box(`&lt;Name&gt; ":" "[" &lt;Index&gt; "]" "^" "|"
           &lt;AttributeDenotation&gt;')
  code_box(`&lt;Name&gt; ":" "[" &lt;Index&gt; "]" "##"
           &lt;AttributeDenotation&gt;')

The <CODE>&lt;Index&gt;</CODE> is an expression whose
(_tutref(16,`<CODE>integer</CODE>')) value is obtained when the
enclosing object is instantiated, and that becomes the initial number
of elements in the repetition.  In practice, it looks like this:

program_box(cq[[
txt: [100] @char;
conc_xrs: [a+b] ^|x;
prs: [0] ##p]]nq)
</P>

<P>
The _tutref(4,next) section introduces the notion of <EM>coercion</EM>
which denotes the transformation processes that are used to obtain a
certain category of entity (e.g. a pattern) from a given entity
(e.g. an object).  In other words, coercion compensates for the fact
that sometimes a declaration has another "funny character" flag than
what is needed in the usage context.
</P>

end_tut

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
