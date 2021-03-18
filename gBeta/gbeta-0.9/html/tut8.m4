include(tutorialstd.m4)dnl
_deflr(7,9)dnl
begin_tut(`Virtual Patterns')

<P>
To get started, think of virtual patterns as virtual methods.  Then
continue to discover what else they can do.
</P>

<H3>Virtual patterns used as virtual methods</H3>
<P>
When using virtual patterns just like virtual methods in other
statically typed object-oriented languages, there are no new
surprises, remembering that _tutref(7,specialization) does not discard
anything, not even behavior.  Here's an example:
</P>

<H3>Example 5</H3>
<P>
This is just the previous example, adjusted to a more reasonable shape
by using virtual "methods:"

program_box(cq[[<SMALL>
(* FILE ex5.gb *)
-- betaenv:descriptor --
(# 
   putline: (# enter stdio do '\n'-&gt;stdio #);
   person: 
     (# init:&lt; (# enter name #);
        name: @string;
        print:&lt; (# do 'Name: '+name-&gt;putline; INNER #)
     #);
   student: person
     (# init::&lt; (# enter id #);
        id: @string;
        print::&lt; (# do 'ID: '+id-&gt;putline; INNER #)
     #);
   freshman: student
     (# init::&lt; (# enter nickname #);
        nickname: @string;
        print::&lt; (# do 'Also-known-as: '+nickname-&gt;putline; INNER #)
     #);
   Smith: @freshman
do 
   ('Smith','533987/26B','Bunny')-&gt;Smith.init;
   Smith.print
#)</SMALL>]]nq)
</P>

<P>
Note that the <EM>first</EM> (most general) occurrence of a virtual
pattern declaration is marked with <CODE>":&lt;"</CODE>.  Here, it is
the declarations of <CODE>init</CODE> and <CODE>print</CODE> in
<CODE>person</CODE>.  
</P>

<P>
Intermediate declarations, <EM>virtual further-bindings</EM>, are
marked with <CODE>"::&lt;"</CODE>, and there is also the possibility
to declare that a virtual is <EM>final</EM>, using the
<CODE>"::"</CODE> mark (not shown). 
</P>

<H3>Virtual patterns used for genericity</H3>
<P>
Since a pattern is a general descriptor of substance, virtual patterns
can do more than "virtual methods."  If we use the instantiated
substance, i.e. the objects obtained from a given virtual pattern, as
"objects", then the virtual pattern works as a <EM>type parameter</EM>
on the enclosing pattern.
</P>

<H3>Example 6</H3>
<P>
This example shows a data-structure whose contained elements are
qualified by a virtual pattern, <CODE>element</CODE>.  When creating
such a container from a specialization which further-binds
<CODE>element</CODE>, the contained elements must be "at least" that
kind of objects.  ("At least" here means "instances of a
specialization of that pattern," where "specialization of" is a
reflexive relation, i.e. anything is a specialization of itself).  

program_box(cq[[<SMALL>
(* FILE ex6.gb *)
-- betaenv:descriptor --
(# 
   puttext: (# enter stdio do INNER #);
   putline: puttext(# do '\n'-&gt;stdio #);
   container: 
     (# element:&lt; object;
        capacity:&lt; integer;
        storage: [capacity] ^element;
        top: @integer;
        insert: (# enter storage[top+1-&gt;top][] #);
        scan:
          (# current: ^element;
          do (for i:top repeat storage[i][]-&gt;current[]; INNER for)
          #)
     #);
   myStrings: @container
     (# element::string; 
        capacity::(# do 10-&gt;value #);
        add: (# s: ^element enter &s do s[]-&gt;insert #);
        print: scan(# do current-&gt;puttext; ' '-&gt;puttext #)
     #);
do 
   'once'-&gt;myStrings.Add; 'upon'-&gt;myStrings.Add; 'a'-&gt;myStrings.Add; 
   'time'-&gt;myStrings.Add; '...'-&gt;myStrings.Add;
   myStrings.Print;
   putline
#)</SMALL>]]nq)
</P>

<P>
Note that _gbeta actually prints two warnings about a potential
run-time type errors for this program.  Actually, it is statically
type-safe, and the type-checker will be able to detect this in a
future version of _gbeta.  Se the section about _topref(bugs,`bugs and
inconveniences') for more details.
</P>

<P>
Virtual patterns may be viewed as constant, automatically initialized
pattern references: a pattern which depends on the actual enclosing
current object, even though it is the same for all instances of the
same pattern. The _tutref(9,next) section presents the even more dynamic
pattern references. 
</P>

end_tut

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
