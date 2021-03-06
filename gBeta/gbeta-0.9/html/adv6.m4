include(advancedstd.m4)dnl
_deflr(5,7)dnl
begin_adv(`Using a Virtual Prefix')

<P>
A virtual pattern is not dynamic in the same way a pattern variable
is, because it never changes during the life-time of its enclosing
object.  On the other hand, it is not possible in general to detect
whether any given syntactic context has a most specific perspective on
a given virtual, so many usages of a virtual pattern must be analyzed
statically under the assumption that it could be <EM>any</EM>
specialization of the statically known type.  Hence, inheriting from a
virtual pattern generally means inheriting from a pattern which is not
known before run-time. 
</P>

<P>
The usage of a virtual pattern as a super-pattern is quite familiar,
it's much like using ordinary specialization, apart from the fact that
_gbeta supports it and traditional BETA does not.  One difference
which emerges when using it, however, is that the further-binding
contributions must often be merged from more than one source.  This
was actually the first source of inspiration for the _advref(7,`type
combination') mechanism in _gbeta.
</P>

<h3>Example 8</h3>
<P>
This example shows a tiny container data-structure hierarchy in
which an iteration method <CODE>scan</CODE> and a conditional
iteration method <CODE>visit</CODE> are declared.  In traditional BETA
it is often a problem that requires a work-around that a control
structure method (such as <CODE>scan</CODE> or <CODE>visit</CODE>)
cannot be virtual. This is because a virtual pattern cannot be a
super-pattern, and a pattern which is a user defined control structure
is usually always used as a super-pattern.  In _gbeta, a virtual
pattern can be a super-pattern.  If you know BETA you might want to
experiment with a traditional BETA version of this fragment, just to
see how much more complicated it gets. 

program_box(cq[[<SMALL>
(* FILE aex8.gb *)
-- betaenv:descriptor --
(#
   container:
     (# element:&lt; object; (* a type parameter for the contents *)
        scan:&lt; (# current: ^element do INNER #);
        visit:&lt; scan(# when:&lt; boolean do (if when then INNER if) #);
     #);
   list: container
     (* as usual a dummy implementation: one element only *)
     (# theElement: ^element;
        append: (# enter theElement[] #);
        scan::&lt; (# do theElement[]-&gt;current[]; INNER #)
     #);
   myList: @list(# element::string #);
   s: ^string;
do
   'I''m just a lowly string!'-&gt;&s; s[]-&gt;myList.append;
   myList.scan(# do current-&gt;stdio #);
   myList.visit
     (# when::(# do (current.length&lt;20)-&gt;value #) 
     do current+'\n'-&gt;stdio 
     #)
#)</SMALL>]]nq)
</P>

<h3>Example 9</h3>
<P>
Another typical way to use a virtual pattern as a super-pattern is for
error handling.  Again, this is a situation which is well-known by
BETA programmers:  A certain method ought to be virtual because it is
a method in a hierarchy where different patterns provide different
implementations.  At the same time, the method must be non-virtual,
because the error handling creates a need for using the method as a
super-pattern.  A typical example is along the lines of: 

program_box(cq[[
(#
   container: 
     (# element:&lt; object;
	..
	delete:&lt;
	  (* remove the element 'elm' from this container; if
           * 'elm' is not present, invoke 'notFound' *)
	  (# notFound:&lt; object;
	     elm: ^element
          enter elm[]
	  do INNER
	  #);
        ..
     #);
   list: .. (* implements 'find' etc *)
   
   myList: @list(# element::integer #);
do
   ..
   someInteger[]-&gt;myList.delete
   (# notFound::(# do .. (* error handling *)#)#);
#)]]nq)
</P>

<P>
Here's a runnable example illustrating the concept:

program_box(cq[[
(* FILE aex9.gb *)
-- betaenv:descriptor --
(#
   abstract:
     (# op:&lt;
          (# err:&lt; (# do INNER #)
          do INNER
          #)
     #);
   concrete: @abstract
     (# op::
          (# err::&lt; (# do INNER #)
          do INNER
          #)
     #)
do
   L: concrete.op(# err::(# do leave L #) do err #)
#)]]nq)
</P>

<P>
The _advref(7,next) section presents the underlying mechanism for type
combination, now that we've seen several more or less perspicuous
examples of how it works. 
</P>

end_adv

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
