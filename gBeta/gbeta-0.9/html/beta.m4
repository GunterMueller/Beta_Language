include(gbetastd.m4)dnl
begin_page(`What is BETA?')

<P>
The programming language 
<A HREF="http://www.daimi.au.dk/~beta" TARGET="_top">BETA</A>
is a modern member of the Scandinavian family of object-oriented
languages.  The first member of this family was Simula, the first
object-oriented language of them all.  BETA preserves the important
concepts from Simula, such as inheritance, virtuals, general block
structure (nesting), and concurrency as a well-integrated aspect.
Many of these concepts are well-known from various newer
object-oriented languages.
</P>

<P>
BETA generalizes Simula in various respects, by lifting a
number of restrictions on allowed combinations of language elements.
In BETA it is, e.g., possible to inherit across enclosing-object
boundaries, whereas a derived class in Simula must "live in the same
context" as its super-class.  This is an example of a restriction
which might seem superficial, but in fact it has very deep
implications for the universe of possibilities experienced by
programmers. 
</P>

<P>
Compared to other, modern object-oriented languages with static
typing, BETA is a very general and at the same time minimal language:
Few constructs with lots of expressive power.
</P>

<H3>Unification and Orthogonality</H3>

<P>
BETA simplifies and unifies the language constructs to an
unusual extent.  Descriptions of substance are made 
using <EM>patterns</EM>, and substance is realized in the shape of
<EM>objects</EM>, instantiated from patterns.
</P>

<P>
As a result, there is no separate notion of "classes" and "procedures"
or "methods."  If a pattern is instantiated, and the resulting object
is executed and then forgotten (ignored), the substance works like the
invocation record for a procedure call: a place to keep some local,
short-lived state during the execution of a series of actions.
</P>

<P>
Assume that a pattern is instantiated in such a procedure-call like 
scenario, and that it is nested within an object and affects the state
of that object.  In this case, a natural way to describe it would be
as a method invocation:  A series of actions is executed in the context
of some object in order to investigate or change the state of that
object.
</P>

<P>
Syntactically it turns out to look rather conventional:
<CODE>anObject.aMethod</CODE> would describe this method-call scenario,
assuming that <CODE>anObject</CODE> is an object and
<CODE>aMethod</CODE> is a pattern whose declaration is textually
nested in the declaration of the pattern of <CODE>anObject</CODE>.
</P>

<P>
Patterns, objects, and nesting together are versatile enough to define
the notion of method calls, and we get two main benefits compared to
the traditional approach where a method is a primitive (irreducible)
concept.  Firstly, it is more general, since there is no need to
invent new language constructs in order to support such concepts as
"reference to method" or indeed "reference to method invocation"
(closure).  Another concept that the generality gives us is that of
method inheritance, or  <EM>pre-methoding</EM>, which is a very useful
concept, almost only supported by BETA, but related to method
combination in CLOS (based on <CODE>:before</CODE> methods,
<CODE>:after</CODE> methods, and <CODE>call-next-method</CODE>). 
Secondly, the language is kept small, tight, and hence easier to get
to know well.
</P>

<P>
BETA is very orthogonal, i.e. it is possible to combine these very
general language elements freely, with only few exceptions.  Using
many separate language constructs, each less general than BETA's,
could yield the same expressive power, but with countless dark corners
of unexplored interactions and special cases.  Creating one special
case in a language is the certain way to breed lots of other special
cases, when integrating the first special case with the rest of the
language.
</P>

<H3>Inspiring other languages</H3>
<P>
Recently, the basic concept of general block-structure (i.e. nested
classes) has emerged in such a trendy language as Java.  Since nesting
has only been an integral part of the Scandinavian object-oriented
languages since the sixties, it is tempting to see it as an
inspiration from Scandinavia.  However, functional programming
languages have also had the notion of (true) closures for many years,
and blocks in Smalltalk, Self, and Cecil are also related to the
notion of closures.  Anyway, it's an important step forward.
Moreover, there is active work in the Java world in the direction of
introducing <EM>virtual classes</EM>, which has been an important part
of BETA for about 20 years.  If you want to see how to do these things
right, take a look at BETA or _gbeta! ;-) 
</P>

end_page

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
