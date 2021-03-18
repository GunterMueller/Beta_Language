include(advancedstd.m4)dnl
_deflr(1,3)dnl
begin_adv(`Industrial Method Combination..')

<P>
<EM>Method combination</EM> is the support in an object-oriented
language for the implicit construction of behavior of a method based
on the behavior of more than one implementation of that method.  In
CLOS, this is achieved using <CODE>:before</CODE> and
<CODE>:after</CODE> methods, and <CODE>call-next-method</CODE>.  In
BETA, method combination is achieved using the <CODE>INNER</CODE>
imperative in virtual methods.  The <CODE>:before</CODE> and
<CODE>:after</CODE> based method combination would be a particular
way of using the existing constructs in BETA.
</P>

<P>
In _gbeta, there is support for a more large scale method combination,
because a top-level _advref(7,`type combination') operation might give
rise to any number of consequent, implicit type combination
operations, depending on the declarations in the participating
patterns. 
</P>

<h3>Example 2</h3>
<P>
As an example, it is possible to construct a <CODE>stack</CODE>
data-structure which supports being used in a concurrent context by
means of the combination of two <EM>aspects</EM>, in this case the
concurrency aspect and the implementation aspect.  Other aspects could
be brought into play as well, in combinations as you wish.
</P>

program_box(cq[[<SMALL>
(* FILE aex2.gb *)
-- betaenv:descriptor --
(# (* This example shows how the constraint based type analysis
    * makes it possible to combine several patterns by doing
    * just one top-level inheritance operation, in the
    * declaration of 'myStack'.  This is an important reason
    * why the constraint based inheritance mechanism supports
    * a deeper separation of concerns. 
    *
    * The basic idea is that we separate the concurrency
    * control aspect and the sequential implementation
    * aspect in the expression of a stack datatype which
    * must be usable in a multithreaded context.
    *
    * The implementation is largely absent, but there
    * should be enough of it to make it understandable
    * what is going on by single-stepping the program
    *)

   monitor: 
     (# mutex: @semaphore;
        init: (# do mutex.V #);
        entry: (# do mutex.P; INNER; mutex.V #)
     #); 
   list: (* just a dummy impl. with a type parameter *)
     (# element:&lt; object #);
   stack: 
     (# element:&lt; object;
        init:&lt; object;
        push:&lt; (# e: ^element enter e[] do INNER #);
        pop:&lt; (# e: ^element do INNER exit e[] #)
     #);
   threadsafeStack: stack
     (# mon: @monitor;
        init::&lt; (# do mon.init; INNER #);
        push::&lt; mon.entry;
        pop::&lt; mon.entry
     #);
   listStack: stack
     (# storage: @list(# element::this(listStack).element #);
        push::&lt; (# do (* .. *) INNER #);
        pop::&lt; (# do (* .. *) INNER #)
     #);
   myStack: @ threadSafeStack & listStack
do 
   myStack.init;
   &object[]-&gt;myStack.push
#)</SMALL>]]nq)

The implementation of the <CODE>push</CODE> method consists of two
different contributions, namely the contribution from
<CODE>threadSafeStack</CODE> and the contribution
<CODE>listStack</CODE>.  The contributions are merges in accordance
with the general _advref(7,`type combination') rules.
</P>

<P>
The _advref(3,next) topic is the interplay of mutual recursion and
specialization (inheritance). 
</P>

end_adv

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
