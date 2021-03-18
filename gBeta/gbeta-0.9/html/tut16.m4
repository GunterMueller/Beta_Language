include(tutorialstd.m4)dnl
_deflr(15,`')dnl
begin_tut(`Primitive Entities')

<P>
An important idea behind BETA was to create such a general,
orthogonal, and minimal language that it would be easy to get to know
well, and still it would be so expressive that anything could be
written in it in an elegant and maintainable form.
</P>

<P>
Because of this, there should not be many predefined languge
entities.  However, a few are needed, and they are presented here.
</P>

<h3>Basic patterns</h3>
<P>
All patterns are either constructed from other patterns (using
_tutref(7,specialization) and _tutref(2,`main parts')) or predefined.
The set of predefined patterns may be viewed as a parameter, defining
a family of BETA languages which differ only in the choice of
predefined patterns.  Because of this, it has not been given that much
attention what selection of basic patterns are present in _gbeta, it
simply supports the same basic patterns as the _mjolner as well as a
few extras.  It would be nice to have different widths of integers,
unicode characters, and infinite precision arithmetic types as well,
but that remains a future project.  In __mjolner, by the way, some
changes are being introduced in this area right now.
</P>

<P>
The basic patterns for simple values are <CODE>boolean</CODE>,
<CODE>char</CODE>, <CODE>integer</CODE>, <CODE>real</CODE>, and
<CODE>string</CODE>.  The <CODE>string</CODE> basic pattern is new
compared to __mjolner, and it will be described below.  The others are
well-known.  Each <CODE>integer</CODE> object, e.g., is a container
for one value from the set of integer values supported (again a
language family parameter).  In evaluations, an	<CODE>integer</CODE>
object will deliver one integer value ("its value"), and when assigned
to it will accept one integer value.  Similarly with the others.  All
these basic patterns have a primitive <CODE>value</CODE> attribute.
It is not an object, and you cannot obtain a reference to it or ask
for its type or inherit from it.  It is used for access to the value
of primitive objects in specializations, e.g.:

program_box(cq[[
(#
   talking_integer: @integer
     (# do 'Hi, mom, I''m '-&gt;stdio; 
        value-&gt;putint; 
        ' now!\n'-&gt;stdio
     #)
do 
   5-&gt;talking_integer
#)]]nq)

</P>

<P>
These input/output properties are the atomic (irreducible) elements in
the recursive definition of _tutref(6,input/output) properties: Any
object will deliver a (possibly composite) value when evaluated, and
this value is computed by looking up <CODE>exit</CODE>-lists
recursively until a primitive pattern or an object reference
 or a pattern reference
(_tutref(5,`<CODE>"[]"</CODE>, <CODE>"##"</CODE>')), or a literal
expression (like <CODE>"3.1415926"</CODE> or <CODE>"'Ho! Ho!
Ho!'"</CODE>), or a primitive value (like the index variable of a
<CODE>for</CODE>-imperative) is encountered.
</P>

<P>
A <CODE>string</CODE> contains a string of characters as a value,
i.e. it is immutable.  This provides a nice compromise between sharing
references to (heavy) "text" objects and copying these objects all the
time.  The problem is that copying a text object everytime it is used
as an argument is too expensive, and sharing it by tranferring an
object reference gives rise to aliasing. This is bad aliasing, because
it is not motivated by the modeling relation (there is no analogous
sharing in the conceptual model of the application domain), but
exclusively motivated by performance considerations.  It is possible
that the problem lies in the fact that the standard <CODE>text</CODE>
pattern in the __mjolner basic libraries uses repetitions in the
<CODE>enter</CODE>- and <CODE>exit</CODE>-lists, and repetitions of
instances of basic patterns are a too low-level construct in the
__mjolner to support read-only access (which is normally achieved
using a pattern that has only an <CODE>exit</CODE>-part and which
exits whatever we want to have read-only access to).
</P>

<P>
Anyway, the<CODE>string</CODE> basic pattern provides a solution
because it allows sharing at the implementation level (value
assignment of a	<CODE>string</CODE> can be just an assignment of a
pointer) and semantically works like other values: If you have a "7"
in an integer variable, nobody will ever be able to change "7" into
anything else, and hence the variable will not change because of
"internal aliasing" (somebody else referring to the contents).  As a
result, a <CODE>string</CODE> is both fast and safe.  On the other
hand, it cannot be "edited", so if you want to change the individual
characters a lot, copy the <CODE>string</CODE> into an oldfashioned
repetition of <CODE>char</CODE>, and change the contents as you like,
then possibly copy it back into a <CODE>string</CODE>.
</P>

<P>
There are three primitive operations on <CODE>string</CODE>s: 
<CODE>aString.length</CODE> delivers the length of the string,
<CODE>aString.at</CODE> accepts an <CODE>integer</CODE> value and
delivers the character at that position.  In the future, there will
possibly be some substring support, but	<CODE>string</CODE> generally
should remain a simple thing.  Finally, <CODE>string</CODE> has a
<CODE>value</CODE> attribute like the other basic (value) patterns.
As an example: 

program_box(cq[[
(# 
   s: @string
do
   'test'-&gt;s;
   s.length-&gt;putint;
   2-&gt;s.at-&gt;stdio
#)]]nq)
</P>

<h3>Concurrency</h3>
<P>
As mentioned in the _tutref(10,co-routine) and _tutref(11,concurrency)
sections, concurrency has been re-defined from being a basic property
(distinguishing "objects" and "components") into being a matter of
types.  An object has its own stack of execution iff it is a
specialization of <CODE>component</CODE>, which is one more basic
pattern.  Along with <CODE>component</CODE> goes
<CODE>semaphore</CODE>, since concurrency control is needed as soon as
there is concurrency.
</P>

<P>
The primitive commands available with <CODE>component</CODE> have been
mentioned in the _tutref(11,concurrency) section, and the primitive
commands of <CODE>semaphore</CODE> are 

   code_box(`P, V, </TT>and<TT> count')

e.g. <CODE>aSem.P</CODE>, <CODE>aSem.V</CODE>, and
<CODE>aSem.count</CODE>.  These command are standard semaphore
commands as defined by Dijkstra.  The <CODE>P</CODE> command and the
<CODE>V</CODE> command are executed by the run-time system in such a
way the the number of <CODE>V</CODE> commands on any given
<CODE>semaphore</CODE> is at all times greater than or equal to the
number of <CODE>P</CODE> commands.  This means that a thread can be
delayed when it attempts to execute a <CODE>P</CODE> command, and it
will not continue the execution before "somebody else" executes the
<CODE>V</CODE> command on the same <CODE>semaphore</CODE>.  This
concurrency control primitive is sufficient to create higher level
concurrency control abstractions, such as monitors and ports.  Lots of
details about this can be read in _tutref(1,"the Beta book.")  Finally
<CODE>aSem.count</CODE> evaluates to the number of threads waiting to
execute because of the <CODE>P/V</CODE> command count constraint.
</P>

<P>
This concludes the _gbeta tutorial.
</P>

end_tut

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
