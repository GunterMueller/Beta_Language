include(startstd.m4)dnl
_deflr(6,8)dnl
begin_start(cq [[GNU Emacs Integration (cont'd)]] nq)

Execute a few steps of the program by typing:

  code_box(`step[ENTER][ENTER][ENTER]')

at the interactive prompt.  This should bring you to the following
statement: 

program_box(cq [[
line: integer
  (# a:< string; b:< string; end:< boolean;
     plural: (# exit (if value=1 then '' else 's' if)#);
     punct: (# exit (if end then '.' else ',' if)#);
=>do <FONT COLOR="#0000FF"><B>(if value=0 then 
         'no more'->puttext 
      else 
         value->putint 
     if);</B></FONT>
     ' bottle'+plural+' of beer'+a+punct+b->putline
  #);]] nq)

Now take a look at the <CODE>value</CODE>:

  code_box(`print value')

.. and try to execute an ad-hoc imperative (which assigns the lesser
of zero and <CODE>value</CODE> to <CODE>value</CODE> and then prints
the result): 

  code_box(`do (0,value)->min->value->putint')

Give the command <CODE>step</CODE> and press <CODE>[ENTER]</CODE>
several times to see the program execute step-by-step.  As you can
see, the program is affected by the changes introduced by the
execution of the ad-hoc imperative, and since any imperative is
allowed (as long as it is statically correct) the <CODE>do</CODE>
command is a strong tool.
</P>

<H3>Basic breakpoints</H3>
<P>
At some point, when the source code window shows the file
<CODE>beer.bg</CODE>, click in the source code window on the
<CODE>"->"</CODE> arrow of cq<CODE>value->putint</CODE>nq, to
ensure that the source code window is the active window and that the
point (cursor, insertion point) is at that arrow.  Since the arrow is
syntactically a top-level constituent of the assignment 
cq<CODE>value->putint</CODE>nq, this position is identified with
the assignment itself, and that is useful because you can select the
menu item <CODE>Breakpoint</CODE> from the <CODE>Gud</CODE> menu, thus
setting a permanent breakpoint at that assignment.  By the way, a
convenient method to access this menu is pressing the rightmost mouse
button along with the <CODE>Control</CODE> modifier, then the menu
pops up right there in over the source code window.
</P>

<P>
Now execute the command:

  code_box(`go')

to continue running until the interpretation would start executing
that assignment.  Press <CODE>[ENTER]</CODE> a couple of times to
watch what happens between each time the program reaches that point,
for example: 

program_box(`executing~1> 
96 bottles of beer.
Take one down, pass it around,


executing~1> _')

program_box(cq [[<SMALL>line: integer
  (# a:< string; b:< string; end:< boolean;
     plural: (# exit (if value=1 then '' else 's' if)#);
     punct: (# exit (if end then '.' else ',' if)#);
=>do (if value=0 then 'no more'->puttext else <FONT COLOR="#0000FF"><B>value->putint</B></FONT> if);
     ' bottle'+plural+' of beer'+a+punct+b->putline
  #);</SMALL>]] nq)

By now the default command is <CODE>go</CODE>, so every
<CODE>[ENTER]</CODE> continues the execution in the running, not
single-stepping, mode.
</P>

<H3>Other kinds of breakpoints</H3>
<P>
There are some other variants of breakpoints, namely <EM>temporary
breakpoints</EM> and <EM>"after-breakpoints"</EM>.  A temporary
breakpoint simply gets deleted the first time it causes a break, and
this is sometimes convenient .. think of it as a way to "run until you
hit this spot" without changing the properties of "this spot."
</P>

<P>
Sometimes it is hard to say exactly what imperative will execute after
the execution of a given imperative finishes, perhaps because it is
the last imperative in the body of a method (pattern) which might be
invoked from many different places.  In these cases it is convenient
to stop <EM>after</EM> the execution of an imperative, not before the
next one.  This is the motivation for the 
<CODE>"Breakpoint After"</CODE> and <CODE>"Tmp. Brk. After"</CODE>
menu entries, corresponding to the <CODE>abreak</CODE> and
<CODE>tabreak</CODE> commands. 
</P>

<P>
The _startref(8,next) section summarizes the execution control commands.
</P>

end_start

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
