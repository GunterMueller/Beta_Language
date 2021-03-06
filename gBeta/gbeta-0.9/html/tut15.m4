include(tutorialstd.m4)dnl
_deflr(14,16)dnl
begin_tut(`Block-structure')

<P>
For BETA programmers, general block structure, or nesting, or true
closures, is like the air we are breathing.  "Do we need air?  Well,
then please tell me exactly in what situations it is valuable to have 
access to air, and what you are using it for." ;-)
</P>

<P>
Being a fundamental structuring principle behind the construction of
large and largish systems (e.g. _gbeta is approximately 70KLOC
excluding basic libraries and the metaprogramming system), there are
many ways in which block structure helps encapsulating local entities,
fighting name space pollution, providing access to all sorts of shared
and semi-shared entities, and supporting the simultaneous creation of
entire systems of cooperating patterns and objects.
</P>

<P>
At the most basic level we may compare imperative languages like
(traditional) Pascal and C with object-oriented languages like BETA,
Smalltalk, or even C++, and thereby highlight a difference which is a
special case of block structure and at the same time lies at the heart
of object orientedness.
</P>

<P>
Of course, objects are buzzwordy and "object oriented" tends to be
understood simply as "good", so there is a large number of candidates
to the honorable location at or just beside the heart of object
orientedness.  We happen to emphasize the importance of the following
aspect:  
</P>

<P>
In imperative languages the basic units into whichs programs are
divided are procedures/functions.  By collecting particular sequences
of statements into procedures and giving them names, it becomes
possible for human beings to understand programs built with these
procedures at a higher level: If there is a procedure called
<TT>printReceipt</TT> then programmers may mentally associate the
phrase "print receipt" with one particular action, possibly complex,
but understandable and meaningful as a whole.  The programmer may look
inside the procedure in order to refine and improve his/her
understanding of this complex action, but generally the "print
receipt" concept has a life of its own and it is not necessary to look
at the implementation all the time in order to use it correctly.
</P>

<P>
This phenomenon, which is a very important aspect of the wider concept
of <EM>encapsulation</EM>, helps us tremendously in the constant
battle against complexity.  However, we can do even better, and that
constitutes a main benefit of object orientation over traditional
imperative programming.  The problem with the traditional imperative
approach is that the individual procedure invocations remain
isolated.  Understanding an imperative program becomes a bit like
watching a movie where every picture is meaningful but the order of the
pictures has been drastically changed, for example such that all the
greenish pictures are shown first, then the bluish pictures, then the
brownish pictures, and so on.  Of course, it would be a very
frustrating experience to watch a movie like that, because the logical
developments have been cut to little pieces and all we can make of it
is a series of confusing shapes and colors rushing back and forth,
even if every picture were perfectly meaningful in the original
context.
</P>

<P>
The reason why an imperative program tends to create this impression
is that each procedure invocation is a highly <EM>transient</EM>
phenomenon; all we have to look at are these short-lived creatures,
and the interesting, <EM>long term</EM> developments have no direct
representation.  Objects are long-lived, and whether they are
described by classes or they are described directly (as in prototype
based languages), an object is a far more robust platform for a
programmer to build his/her understanding on than a procedure.  The
improvement comes from considering the procedure invocations not in
isolation but in <EM>context</EM> of a selection of data items which
are related in use, such that the combined entity (the object = the
methods + the state) can be understood as a whole.  The individual
procedure invocation is no longer considered in isolation, it is
considered to be just one step in the long term process which is the
"life history" of the object.
</P>

<P>
It does no good to arbitrarily collect some procedures and some state
and call it an object; it is absolutely crucial that the collection of
procedures and state is meaningful as a unit, such that the hard work
of understanding a complex system can be reduced because each object
in it is meaningful and encapsulates some amount of complexity.
Because of the importance of this complexity reduction mechanism, we
use new words for the old concepts:  the procedures may be called
"methods" and the data may be called "instance variables" (as in
Smalltalk), or the two concepts may be unified and called "attributes"
(as in BETA and _gbeta).  May atrocities lower their brutal wings and
crush the perpetrators who forget, and use words like "procedure"
or "function" about "methods"!  <TT>;-)</TT>
</P>

<P>
This step, to consider methods in context of objects as opposed to
considering them in isolation, is a special case of the general
mechanism of block structure, which allows us to place arbitrary
entities in context of other entities.  As always when we are given
the opportunity to use a more general mechanism, the well-known
special cases are trivially supported, such as placing patterns used
as procedures inside patterns used as classes, thereby creating the
BETA/_gbeta equivalent of having methods in objects.  But there is a
rich universe of other possibilities that programmers in languages
with general block structure get to explore and enjoy.
</P>

<P>
At all times, the criterion for nesting must be that it is <EM>easier
to explain</EM> the combined entity than it would have been to explain
them when considered separately.  Typically, nested entities can be
separated by adding more parameters to procedures and/or more
attributes to objects, and the separated entities will be more complex
to use, but sometimes also more flexible; as always with trade-offs
between correctness and freedom, a reasonable design must be
chosen and the trade-offs made judiciously.  However, without general
block structure there is no trade-off, because only the complex,
tediously parameterized design of isolated entities can be
expressed.
</P>

<P>
Here are a few hints as to some situations where general block
structure is very valuable:  Many languages have the notion of "class
variables" (Smalltalk) or "static members" (C++, Java) or "class
allocated slots" (CLOS), and they are used to support shared state,
i.e., state which is shared among all instances of a given class, all
instances of the class and all subclasses, or something similar.  With
block structure the natural way to obtain shared state is simply to
move a declaration one level out in the block structure; there is no
need for a new concept, and class variables come out as a special
case (namely moving it out <EM>one</EM> level; another special case is
to move it out two levels, etc).
</P>

<P>
Another situation where block structure proves valuable, in
cooperation with the unification of procedures and classes into
patterns in BETA and _gbeta, is the notion of <EM>closures</EM>.  A
closure is a reified procedure invocation which retains the original
environment in which it was created (it "closes" over the variables
etc. that were in scope at the creation time).  These are perhaps most
well-known to the functional programming language community (Haskell,
SML, Miranda, Clean, CAML, ...), but blocks in Self, Smalltalk and
Cecil are also examples of similar concepts.  Again, there is no need
for a separate concept in BETA/_gbeta for closures, they are just
special cases of the concepts of patterns with general block
structuring.
</P>

<P>
Finally, repeating the point because it is so important, it is a
very powerful tool for program complexity reduction to be able to "put
X into Y" in those cases where "X" meaningfully belongs inside "Y".
This is harder to describe in terms of known examples in other
(non-block-structured languages), because it simply opens up an
entirely new world of expressive possibilities that programmers who
use block structured languages over time discover and appreciate.
Hopefully the inclusion of an almost-correctly-defined version of
general block structure by means of inner classes in Java will open
the eyes of more people all over the world to the wonders of this
largely neglected topic.
</P>

<P>
The _tutref(16,`next and last') topic in this tutorial is predefined
entities of all kinds.
</P>

end_tut

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
