include(advancedstd.m4)dnl
_deflr(4,6)dnl
begin_adv(`Dynamic Control Structures')

<P>
Control structures are things like <CODE>if</CODE>, <CODE>for</CODE>,
and <CODE>while</CODE>.  They have been part of any imperative
language since the sixties as primitive constructs, i.e. something
which is visible in the grammar of the language and which would get a
separate description in a formal semantics for the language.
</P>

<h3>User defined control structures</h3>
<P>
In BETA, the pattern concept is so versatile that control structures
can be written in the language, in stead of being built-in language
constructs.  The basic built-in control primitives are
<CODE>leave</CODE> and <CODE>restart</CODE>. As an example of a
user-defined control structure in BETA, a while loop looks like this:

program_box(cq[[
loop: 
  (# while:< boolean
  do (if while then INNER; restart loop if)
  #)]]nq)

and it can be used like this: 

program_box(cq[[
loop
(# while::(# do (n&lt;&gt;10)-&gt;value #)
do n+1-&gt;n
#)]]nq)

Actually, I considered adding a built-in <CODE>while</CODE> loop to
_gbeta, because this is more verbose than a built-in
<CODE>while</CODE> would have to be.  Anyway, the verbosity is no
problem when the control structure is more complex and
special-purpose, and by the way would never be a built-in language 
construct.  
</P>

<P>
Let us define a control structure as a language construct (built-in or
user defined) which can be parameterized with one or more pieces of
code (a "body", or several bodies) and which executes this body zero
or more times, each time setting up a certain environment.  The
standard <CODE>while</CODE> does not provide any special environment,
but the <CODE>for</CODE> provides an index variable with values
1,2,.. or similar.
</P>

<P>
A good example of a more complex control structure is an
iteration control structure associated with a data structure which
contains a number of similar entities, e.g. a list.  A very common
piece of BETA code iterates a list using such a (user defined) control
structure: 

program_box(cq[[aList.scan(# do current.print #)]]nq)

It is a BETA convention to name the currently visited element
<CODE>current</CODE> in such iteration control structures.
</P>

<h3>Dynamic control structures</h3>
<P>
Now imagine that you could parameterize your algorithms with
control structures, selecting different control structures for
different purposes.  This might sound much like taking a routine
argument in a method, thus being able to invoke some algorithm which
is only known at runtime.  In C++, e.g., a routine argument is a
function pointer or a pointer to a member function.  
</P>

<P>
In fact, this is a much stronger concept, since the control
structure provides a binding environment, i.e. it gives some code at
the point of application, the body, access to a set of declared names.
To support this, another function pointer could be brought into play,
in plain C: 

program_box(cq[[<SMALL>
#include &lt;stdio.h&gt;

typedef void (*callback)(char *);
typedef void (*control_structure)(callback);

void body(char *arg)
{
  printf("%s\n",arg);
}

void var_control_struct(control_structure cs)
{
  (*cs)(&body);
}

void example_cs1(callback cb)
{
  (*cb)("Once"); 
  (*cb)("upon"); 
  (*cb)("a time");
}

void example_cs2(callback cb)
{
  int i;
  char *arg="**********";
  for (i=0; i&lt;10; ++i) (*cb)(arg+i);
}

int main(int argc, char *argv[])
{
  var_control_struct(&example_cs1);
  var_control_struct(&example_cs2);
  return 0;
}</SMALL>]]nq)
</P>

<P>
Here's the _gbeta solution:

program_box(cq[[<SMALL>
(# control_structure: string;

   var_control_struct:
     (# cs: ##control_structure
     enter cs##
     do cs(# do value+'\n'-&gt;stdio #)
     #);
   example_cs1: control_structure
     (# 
     do 'Once'-&gt;value; INNER; 
        'upon'-&gt;value; INNER;
        'a time'-&gt;value; INNER
     #);
   example_cs2: control_structure
     (# rep: [0] @char;
     do '**********'-&gt;rep;
        (for i:10 repeat rep[i:rep.range]-&gt;value; INNER for)
     #)
do
   example_cs1##-&gt;var_control_struct;
   example_cs2##-&gt;var_control_struct
#)</SMALL>]]nq)

The interesting aspect of this program is the fact that the
<CODE>do</CODE>-part of <CODE>var_control_struct</CODE> uses a pattern
variable as a superpattern.  This means that the pattern being
inherited from is not known before run-time, although it is declared
(and hence known) at compile time that this pattern is some
specialization of <CODE>control_structure</CODE> (possibly
<CODE>control_structure</CODE> itself). 
</P>

<P>
Inheriting from a pattern which isn't completely known before run-time
is what dynamic control structures is all about.
</P>

<P>
Now consider what happens if we have some good reason to change the
<CODE>control_structure</CODE> pattern to:

program_box(cq[[
control_structure: 
  (# value: string; 
     x,y,z: @integer; 
     doit: (# .. (* some useful method *)#)
  #);
]]nq)

What happens is that the <CODE>example_cs?</CODE> patterns and the
specialization of <CODE>cs</CODE> in the <CODE>do</CODE>-part of
<CODE>var_control_struct</CODE> gets a richer name space which could
be exploited, if needed.  The rest of the code could also stay
unchanged.  One way to put it is that new facilities could be
introduced in the context of a complex program, and only those places
where the new facilities are actually used will have to change.
</P>

<P>
However, in the C version of the program, the name space must be
specified explicitly in the argument list of <CODE>body</CODE>, in the
<CODE>typedef</CODE> for <CODE>callback</CODE>, and everwhere a
<CODE>callback</CODE> function is invoked.  As you can see, the whole
machinery and all applications of it must be adapted, not just the
construct which was changed for some good reason.
</P>

<P>
Do you <A HREF="mailto:eernst@cs.auc.dk">think</A> that going from
C to e.g. C++ would make it possible to handle this example more
elegantly? 
</P>

<h3>Example 7</h3>
<P>
Here's a larger example of the same technique:

program_box(cq[[<SMALL>
(* FILE aex7.gb*)
-- betaenv:descriptor --
(# 
   loop:
     (# while:&lt; boolean
     do (if while then INNER; restart loop if)
     #);
   
   file: (* an artificial file with two lines of text! *)
     (# name: @string;
        count: @integer;
        eof: (# exit count=2 #);
        openRead: (# do 0-&gt;count #);
        getline: 
          (# s: @string 
          do (if count+1-&gt;count // 1 then 'one'-&gt;s // 2 then 'two'-&gt;s if)
          exit s
          #)
     #);
   list: (* an artificial singleton list *)
     (# element:&lt; object;
        init: object;
        theElement: ^element;
        scan: (# current: ^element do theElement[]-&gt;current[]; INNER #)
     #);
   
   myfile: @file;
   mylist: @list(# element::string #);
   
   (* define the iterator interface *)
   iterator: (# theLine: @string do INNER #);
   
   (* define concrete iterators *)
   fileIterator: iterator
     (# do loop
        (# while::(# do not myFile.eof-&gt;value #) 
        do myFile.getLine-&gt;theLine;
           INNER fileIterator
        #)
     #);
   listIterator: iterator
     (# do mylist.scan
        (# do current-&gt;this(listIterator).theLine;
           INNER listIterator
        #)
     #);
   inputIterator: iterator
     (# do loop
        (# while::(# do (theLine&lt;&gt;'quit')-&gt;value #)
        do stdio-&gt;theLine; INNER inputIterator
        #)
     #);
   
   LinePrinter:
     (# anIterator: ##iterator
     enter anIterator##
     do anIterator(# do theLine+'\n'-&gt;stdio #)
     #);
do
   'somename'-&gt;myFile.name;
   myFile.openRead;
   myList.init; 'a string'-&gt;&myList.theElement;
   fileIterator##-&gt;linePrinter;
   listIterator##-&gt;linePrinter;
   'Type strings and [ENTER].  Type "quit" to quit\n'-&gt;stdio;
   inputIterator##-&gt;linePrinter
#)</SMALL>]]nq)
</P>

<P>
The _advref(6,next) section is about another unusual kind of "base
class," namely a virtual pattern used as a super-pattern.
</P>

<P>
</P>

end_adv

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
