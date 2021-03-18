include(advancedstd.m4)dnl
_deflr(7,9)dnl
begin_adv(`More Versatile Control Structures')

<P>
An old idea in the BETA community, and a good one, is to provide
"value" versions of the built-in control structures.  This has been
partially implemented in _gbeta (but not in the _mjolner compiler).
Such versions are used in assignment context or in evaluation
context. 
</P>

<P>
An example of a "value" version of an <CODE>if</CODE>-imperative is:

program_box(`(if b then 1 else a+b if) -&gt; putint')

This works like:

program_box(`1 -&gt; putint')

if <CODE>b</CODE> evaluates to <CODE>true</CODE>, and it works like:

program_box(`a+b -&gt; putint')

if <CODE>b</CODE> evaluates to <CODE>false</CODE>.

This is of course a similar semantics as that of the
<CODE>if</CODE>-statement in functional languages such as SML or
Haskell.  The assignment variant: 

program_box(`x+y*y -&gt; (if b then putint else x if)')

resembles a (non-standard) usage of the ternary <CODE>"?:"</CODE>
operator in C, meaning: 

program_box(`x+y*y -&gt; putint')

if <CODE>b</CODE> evaluates to <CODE>true</CODE>, and:

program_box(`x+y*y -&gt; x')

if <CODE>b</CODE> evaluates to <CODE>false</CODE>.  Of course there is
a double-sided version of this, too:

program_box(`x+y*y -&gt; (if b then putint; 3 else a; a+b if) -&gt; b')

The reason why this is not entirely trivial (perhaps it is ;-) is that
it is a surprisingly handy way to express a lot of things.
</P>

<P>
There should be a similar "value" version of the general
<CODE>if</CODE>-imperative, i.e. the control structure in BETA which
resembles <CODE>switch</CODE> in C (not too much, mind you!), but this
has not yet been implemented.  Similarly, there should be a "value"
version of the <CODE>for</CODE> imperative which would iterate the
transfer of values such that:

program_box(cq[[1 -&gt; (for 5 repeat i; i+1 for) -&gt; putint]]nq) 

would be the same as: 

program_box(cq[[1-&gt;i; 
i+1-&gt;i; 
i+1-&gt;i; 
i+1-&gt;i; 
i+1-&gt;i; 
i+1-&gt;putint]]nq) 
</P>

<P>
_advref(9,`After this') slightly less serious section, we'll leave the
language _gbeta and look at a few changes in the
_topref(modularization,modularization) system. 
</P>

<P>
</P>

<P>
</P>

end_adv

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
