include(tutorialstd.m4)dnl
_deflr(6,8)dnl
begin_tut(`Specialization (Inheritance)')

<P>
The language mechanism which is often called "inheritance" in other
languages is normally called <EM>specialization</EM> in BETA
terminology.  This reflects the importance of concepts and their
relations in the _tutref(1,`conceptual framework'): specialization is a
relation between a more general concept and a more special concept,
the opposite of generalization.
</P>

<P>
The term <EM>inheritance</EM> focuses more on the fact that individual
attributes are "inherited" from a base class, and it does not very
much support the consideration that each involved class as a whole is
associated with a concept in the minds of designers and programmers,
and that those concepts are related in the real world.
</P>

<P>
In other words, the term specialization gives priority to the
<EM>modeling</EM> relation between program executions and the
application domain.  Consequently, words like "inherited" are used
below exactly when the focus is on those individual attributes.
</P>

<H3>How does it look?</H3>
<P>
Single inheritance is expressed by putting an
<CODE>&lt;AttributeDenotation&gt;</CODE> (e.g. an identifier) in front
of a _tutref(2,`main part'), like this:

  code_box(`&lt;ObjectDescriptor&gt; ::= &lt;AttributeDenotation&gt;
            &lt;MainPart&gt;')

The <CODE>&lt;AttributeDenotation&gt;</CODE> denotes the
super-pattern, i.e. the pattern which is being specialized.  An
example is:

program_box(cq[[
p: boolean(# a: (# #)#);
q: p(# b: a(# #)#);]]nq)
</P>

<H3>How does it work?</H3>
<P>
Many things are well-known.  Attributes are inherited from the
super-pattern.  If a name is declared both in the super-pattern and in
the new main part, the declaration in the main part shadows the one in
the super-pattern when the statically known type includes both.  This
is just like all other statically typed object-oriented languages.  
</P>

<P>
For <EM>changing</EM> an inherited declaration in stead of shadowing
it, the inherited declaration must have been marked as changeable,
similar to C++ and different from Eiffel.  It must be a
_tutref(8,`virtual pattern').  This means that changeability must be
designed into attributes, which might be a bad thing (as uttered by
Eiffelists), but in return the type system is safe without a global
analysis (as suffered by Eiffelists ;-).  For those few places where
you want covariance, you can get it, and the type-checker will give
you a warning at precisely the dangerous statements.  For normal
programming without covariance, it can be checked locally that type
errors cannot occur at run-time.
</P>

<P>
Please note, however, that the notion of virtual patterns is a lot
more expressive than the notion of virtual methods.
</P>

<H3>The <CODE>INNER</CODE> imperative, and the BETA inheritance "style"</H3>
<P>
Specialization can be viewed as adding up main parts, and main parts
have an associated behavior, specified in the <CODE>do</CODE>-parts.
This behavior is <EM>combined</EM> by the specialization mechanism,
not overridden.
</P>

<P>
The way it is combined may be viewed as a search-and-replace process
which puts the more special <CODE>do</CODE>-part into the more general
one (i.e. the super-pattern <CODE>do</CODE>-part), one copy for each
occurrence of the <CODE>INNER</CODE> imperative.  In this way, the
<CODE>INNER</CODE> imperative may be described as "the opposite of a
super-call," because the super-pattern can execute <CODE>INNER</CODE>
wherever it wants the behavior from the sub-pattern to be inserted,
not the other way round.
</P>

<P>
Please note that actually doing the search-and-replace as described
above would not give the right semantics for name lookup:  Names are
looked up from the actual position in the syntax, and the
search-and-replace process will generally put code in a place where
some declarations are missing or different.  For the pure behavior,
however, the search-and-replace description is accurate.
</P>

<P>
Another point of view is that the specialization process (from the
most general to the most special pattern) is a process which gradually
<EM>completes</EM> the behavior.  Each level can leave some
unspecified place holders (in the form of <CODE>INNER</CODE>) which
can be filled in differently in different sub-patterns.
</P>

<P>
Using <CODE>INNER</CODE> can be wonderful, self-evident, expressive,
just right, and simple, but probably it seems backward and complicated
if "super" and overriding semantics is your normal universe.  It
probably takes months or years to adjust the entire design approach
and programming habits to one or the other.  
</P>

<P>
One important aspect is: Since you cannot "throw away" the
super-pattern behavior, you <EM>will</EM> have to design in a very
clean way, writing only the behavior in your super-patterns which is
relevant in all cases.  This also goes against a very ad-hoc oriented
philosophy, where the modification of existing classes to work in a
new context is viewed as very important, for "reuse".  In this
philosophy, it should be possible to take whatever code which
resembles what we need and tweak it by inheritance in such a way that
it does what we want. 
</P>

<P>
The BETA (and in general, Scandinavian) point of view is that a
specialization hierarchy should be designed as a conceptually sound
totality, with commonalities expressed in as general a position as
possible.  In principle the entire hierarchy should be conceptually
well-formed, and we should never need to "adjust" a super-pattern
because it wasn't designed for this particular usage.
"Un-inheritance," such as overriding a behavior (or for that matter,
if supported, discarding some inherited attributes), is viewed as a
messy business which pollutes the pattern (or class) universe with
contradictions.  In general, discarding attributes makes the type
system unsafe, so it is seldom supported.  Discarding behavior
introduces a similar breach of safety, since the super-pattern can
never rely on certain actions taking place.  Typical examples are
known from the interplay of concurrency control and inheritance, often
termed the "inheritance anomaly."
</P>

<P>
As a consequence, there are more abstract patterns in BETA programs,
because we should not commit to things that we don't want to keep
anyway. 
</P>

<P>
Give it a chance, it <EM>does</EM> work in practice!
</P>

<H3>Specialization and evaluation</H3>
<P>
Just like attributes and behavior is collected and added up from the
contributing main parts, input/output properties are added up by
concatenating the <CODE>enter</CODE>-lists and the
<CODE>exit</CODE>-lists.  The example below shows how, in the
<CODE>init</CODE> method.
</P>


<H3>Example 4</H3>
<P>
This example shows how specialization and <CODE>INNER</CODE> plays
together to create more complex behaviors from less complex ones by
"filling in the blanks."

program_box(cq[[<SMALL>
(* FILE ex4.gb *)
-- betaenv:descriptor --
(# 
   putline: (# enter stdio do '\n'-&gt;stdio #);
   person: 
     (# initPerson: (# enter name #);
        name: @string;
        printPerson: (# do 'Name: '+name-&gt;putline; INNER #);
     #);
   student: person
     (# initStudent: initPerson(# enter id #);
        id: @string;
        printStudent: printPerson(# do 'ID: '+id-&gt;putline; INNER #);
     #);
   freshman: student
     (# initFreshman: initStudent(# enter nickname #);
        nickname: @string;
        printFreshman: printStudent
          (# do 'Also-known-as: '+nickname-&gt;putline; INNER #);
     #);
   Smith: @freshman;
do 
   ('Smith','533987/26B','Bunny')-&gt;Smith.initFreshman;
   Smith.printFreshman;
#)</SMALL>]]nq)

Of course, this example will get nicer when we get to virtual patterns
in the _tutref(8,next) section. 
</P>

end_tut

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
