include(startstd.m4)dnl
_deflr(8,`')dnl
begin_start(cq [[GNU Emacs Integration (cont'd)]] nq)

This section describes a few remaining commands that did not fit into
the previous sections.

<H3>Examining the stack etc.</H3>

<P>
It is possible to print the current execution stack with: 

  code_box(`stack')

and to print only the topmost element on the stack with:

  code_box(`topofstack')

The topmost element on the stack is the "current" object, and one
particular part of this object is the "current object slice",
containing the state and executing the dopart from one particular
"MainPart" (a piece of syntax enclosed by <CODE>"(#"</CODE> and
<CODE>"#)"</CODE> parentheses).  The current object slice can be
printed with the command:

  code_box(`currentslice')

The outermost object in the nesting structure contains everything in
a BETA (and _gbeta) program execution, and this object can be printed
using the command: 

  code_box(`primaryobject')

The primary object is the only part of the state which can be
inspected in the <CODE>"terminated>"</CODE> state.
</P>

<H3>Killing threads</H3>
<P>
When executing a concurrent program, it may be convenient to be able
to kill the current thread, and this is done with:

  code_box(`kill')

If a given thread is not the active one when the prompt is printed,
there is no way to browse the set of threads and discover what
identity number a given thread has, and then kill it.  (This may be
fixed later, though.)  A special variant of the command: 

  code_box(`kill all')

will kill all threads, just like repeating <CODE>kill</CODE> enough
times, hence making it possible to restart the execution of the
program immediately.
</P>

<H3></H3>
<P>
</P>

<H3>Name applications and declarations</H3>
<P>
It is often necessary to look up the declaration associated with a
given application (i.e. non-declaring occurrence) of the name.  Since
the scope rules are complicated in a language with inheritance, and
BETA has especially rich scope rules because of the combination of
general nesting and inheritance, and since _gbeta makes the
whole thing even more complicated by adding multiple inheritance and
also inheritance from virtual patterns (whose static type depends on
the position of the application), since all that (and even without 
it :-), it is very important to have tool support for interactive name
lookups.
</P>

<P>
In _gbeta, interactive name lookup is supported by means 
of the <CODE>declaration</CODE> command, like:

  code_box(`decl 705')

.. but since a character position argument is awkward (who knows the 
exact character position of a piece of source code when looking at
it?) this kind of invocation is seldom used.  Double-clicking on the
name application, on the other hand, 

  code_box(`[ click-click! ]')

does exactly the same thing, and
this brings forward the source code containing the declaration, even
if it is in another file than the application.  
</P>

<P>
Please note that this is <EM>real</EM> name lookup, and it will not
confuse two name declarations even if the declared names are spelled
identically, nor will it find a name mentioned in the middle of a
comment.  It uses the information from static analysis which is
created and kept by the interpreter anyway.
</P>

<P>
This ends the description of the practical usage of _gbeta.
</P>

end_start

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
