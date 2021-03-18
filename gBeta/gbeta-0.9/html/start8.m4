include(startstd.m4)dnl
_deflr(7,9)dnl
begin_start(cq [[GNU Emacs Integration (cont'd)]] nq)

<H3>Overview of execution control commands</H3>
<P>
To execute one single step of a program execution, use the command:

  code_box(`step')

and to execute all of the next imperative (not stopping at imperatives
executed indirectly by method invocation etc.) use the command:

  code_box(`next')

To execute until the end of an enclosing block is reached, use: 

  code_box(`finish <I>N</I>')

where <CODE><I>N</I></CODE> is an integer specifying the number of
nesting levels to go out.  This makes it possible to run the
interpretation e.g. until a method invocation terminates, also in the
case where the pattern declaration specifying that method invocation
is more than one nesting level further out than the current
imperative.  
</P>

<P>
It is possible to let the execution continue in the running mode (not
single-stepping), using:  

  code_box(`go')
</P>

<P>
Finally, the commands 

  code_box(`restart')

and 

  code_box(`run')

are used to initiate an execution from the <CODE>"terminated>"</CODE>
state, in the single-stepping respectively running mode.
</P>

<P>
Finally, the _startref(9,`next and last') section explains a few odds and
ends.
</P>

end_start

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
