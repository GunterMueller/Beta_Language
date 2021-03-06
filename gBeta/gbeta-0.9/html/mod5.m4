include(modularizationstd.m4)dnl
_deflr(4,`')dnl
begin_mod(`A Concrete Example (continued)')

<P>
In the last section we promised to explain how the <TT>asString</TT>
method can be provided even though the declarations of the
<TT>ordered</TT> patterns and its subpatterns contain no such method.
An important precondition is the declaration of the slots named 
<TT>OrderedLib</TT>, <TT>TextLib</TT>, <TT>NumberLib</TT>,
<TT>IntLib</TT>, and <TT>FloatLib</TT>.  These slots are of the
syntactic category <TT>attributes</TT>.  This means that we can
provide attribute declarations to these patterns by means of these
slots, thereby, e.g., adding new methods to the patterns.  That is
exactly what we need to do.  
</P>

<P>
Note that there is nothing new in this compared with the fragment
system in the language BETA; however, there is a difference between
the (ideal) definition of the fragment system and the actual
implementation in the _mjolner, so the following would not compile
under Mjolner BETA, but it <EM>is</EM> supported in the implementation
of _gbeta. 
</P>

<P>
So, to return to the concrete example, we add an extra method to many
of the patterns, so we can obtain a printable representation of a
given <TT>ordered</TT> entity:
</P>

program_box(cq[[(* FILE orderedAsString.gb *)
ORIGIN 'ordered'; 
ORIGIN 'orderedText';
ORIGIN 'orderedNumber'

-- OrderedLib:attributes --

asString:&lt; (# s: @string do INNER exit s #)

-- TextLib:attributes --

asString::(# do value-&gt;s #)

-- IntLib:attributes --

asString::(# do '&lt;anInt&gt;'-&gt;s #)

-- FloatLib:attributes --

asString::(# do '&lt;aFloat&gt;'-&gt;s #)]]nq)

<P>
In order to keep the example short and complete we have skipped over
the problem of printing numbers and just return the string
<TT>&lt;anInt&gt;</TT> for all <TT>int</TT> objects and
<TT>&lt;aFloat&gt;</TT> for all <TT>float</TT> objects.
</P>

<P>
With these definitions the example is complete.  It is worth
considering the type properties of this inheritance hierarchy.
Usually it would give rise to typing problems to have both
<TT>text</TT> and <TT>number</TT> derived from <TT>ordered</TT>.  The
problem is that if <TT>ordered</TT> is an ordinary class then this
implies that any two <TT>ordered</TT> objects can be compared, and
this is probably not meaningful for a <TT>text</TT> and a
<TT>number</TT>; we would like to be able to compare <TT>number</TT>s
and <TT>text</TT>s with their own kind, but the type system ought to
complain if the two groups of <TT>ordered</TT> things are mixed.
</P>

<P>
To obtain this level of correctness check we could use something else
than a class for <TT>ordered</TT>.  In languages with parameterized
classes (C++, Eiffel, Cecil, GJ, Pizza, ..) it would be possible to
make <TT>ordered</TT> a parameterized class.  This normally means that
<TT>text</TT> and <TT>number</TT> would become <EM>unrelated</EM>
classes, and that would ensure that the two kinds of <TT>ordered</TT>
objects would be kept separate by the type system.  With F-bounded
polymorphism and explicit co-variance and contra-variance
declarations, as in Cecil, it is even possible to allow comparisons of
subclasses of instances of <TT>ordered</TT>, such as <TT>int</TT> and
<TT>float</TT>.  However, it is not possible in these languages to
refer polymorphically to an arbitrary <TT>ordered</TT> object and call
such a method as <TT>asString</TT>.  The problem is that
<TT>ordered</TT> is not a class, and hence there is no way to declare
a polymorphic reference (variable, field, pointer, whatever it's
called in the given language) to such objects.
</P>

<P>
The BETA and _gbeta type systems handle this problem in a more general
manner.  The approach taken is not to uncritically make all the
subpatterns subtypes (which leads to the confusion problem mentioned
above), and it is not to make <TT>ordered</TT> a non-class (which
leads to the cannot-call-<TT>asString</TT>-polymorphically problem),
but to use <EM>computed types</EM>.  Types in BETA and _gbeta do not
have an explicit representation in the program, they are all
inferred.  Patterns are explicit, but types differ from patterns in
that they include a description of what properties all the possible
patterns in a given context might have.  One of the consequences of
this is that it is recognized as safe by the type system to call
<TT>asString</TT> on an object which is only known as being an
instance of a pattern which is less than or equal to
<TT>ordered</TT>.  At the same time, the type system recognizes that
it would <EM>not</EM> be safe to compare two objects of which the same
is known.  Comparison is only safe when the objects are both known to be
less-equal than <TT>number</TT>, or when they are both known to be
less-equal than <TT>text</TT>.  (Note that the <EM>final</EM> bound on
<TT>cmpType</TT> in <TT>number</TT> and in <TT>text</TT> plays a
crucial role in this connection).
</P>

<P>
In this approach, individual methods are marked as "OK" or "Nope, not
safe" to call by the type system, depending on the level of knowledge
about the involved objects.  Compared to the approaches where types
are explicit (and generally constant as seen from all points in the
program), this approach based on computed types allows for a greater
freedom for programmers, because more of the safe actions are
recognized as safe by the type analysis.  The dynamically typed
approaches (e.g. Smalltalk) also allow all the safe actions, but that
is just because <EM>everything</EM> is allowed, including such things
as comparing a <TT>text</TT> with a <TT>number</TT>, which is,
rightfully, caught as a type error in all the statically typed
approaches.
</P>

<P>
As expected, the patterns in our example have the desired type
properties: <TT>number</TT> is specialized to <TT>int</TT> and to
<TT>float</TT>, and the final bound on <TT>cmpType</TT> in
<TT>number</TT> ensures that all kinds of numbers can be compared.
Similarly, <TT>text</TT> objects can be compared.  However, if a
<TT>text</TT> and a <TT>number</TT> are compared with each other, the
static analysis will complain that this is not typesafe, as it should.
Finally, the method <TT>asString</TT> can be called on any
<TT>ordered</TT> object, even if we do not know whether it is a
<TT>text</TT>, or a <TT>number</TT>, or yet another subpattern of
<TT>ordered</TT>.  
</P>

<P>
A more detailed presentation of these issues is given in
the _topref(papers,`PhD thesis').
</P>

end_mod

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
