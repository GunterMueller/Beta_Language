include(startstd.m4)dnl
_deflr(3,5)dnl
begin_start(cq [[Command Line Interaction (cont'd)]] nq)

<H3>Taking one step</H3>
<P>
With BETA assignment syntax, data flows from the left to the right
just like we read from the left to the right.  This is very unusual, 
but after a while you might think  (like me :-) that it is
<EM>the</EM> way to do it.  Anyway, the syntax: 

  code_box(cq [[ 'world!'->s ]] nq)

is an assignment which takes the literal string value
<CODE>'world!'</CODE> and puts it into the object <CODE>s</CODE>.  In
many programming languages, this would look more like: 

  code_box(cq [[ s := 'world!' (* NB: not BETA syntax *)]] nq)

To execute this imperative, just press <CODE>[ENTER]</CODE>, giving
the response: 

program_box(cq [[
====================
(#`196
   s: @string;
   hello: (#`74
      exit 'Hello'
      #)
do 'world!'->s;
   <B><U>hello+', '+s->stdio</U></B>
#)
====================

executing~1> _]] nq)

Note that it is the second imperative which is emphasized now.  To
check that something actually happened, try to look at <CODE>s</CODE>:

program_box(cq [[
executing~1> print s

          object, string object slice~4 = "world!"

executing~1> _]] nq)

This basically says that, as seen from the current imperative and in
the current execution state, the name <CODE>s</CODE> denotes an
object, and the state of this object is the string value
<CODE>"world!"</CODE>.  
</P>

<P>
We can investigate information known from static analysis:

program_box( cq [[
executing~1> assigninfo s

Assignment type: s

                 string static transient

executing~1> _]] nq)

This tells us that <CODE>s</CODE> can accept a string value in
assignments.  Consequently, anything whose <CODE>evalinfo</CODE> is
also a <CODE>string static transient</CODE> can be assigned to it.
(Try <CODE>"help evalinfo"</CODE>.)
</P>

<H3>A constant, an expression, and a primitive</H3>
<P>
The BETA way to express a constant is to declare a pattern which
simply delivers (<CODE>"exit"</CODE>s) a value, like the pattern
<CODE>hello</CODE>: 

  code_box(cq [[ hello: (# exit 'Hello' #) ]] nq)

This constant, a literal string, and the string object <CODE>s</CODE>
are used in an expression whose value is "inserted into"
<CODE>stdio</CODE>:

  code_box(cq [[ hello+', '+s -> stdio ]] nq)

<CODE>stdio</CODE> is the primitive entity which makes it possible to
read the standard input and write to the standard output.  Again, the
arrow, <CODE>"->"</CODE>, signals data flow, and the values flow in
the direction of the arrow, into <CODE>stdio</CODE>.
</P>

<P>
If you execute this imperative: 

program_box(cq [[
executing~1> step
Hello, world!

terminated> _]] nq)
you can see that the imperative was executed (the expression was
evaluated and the computed string value <CODE>"Hello, world!"</CODE>
was delivered to the standard output), and since we reached the end of
the program, _gbeta entered the terminated state.
</P>

<H3>Modern conveniences..</H3>
<P>
Often you can just press <CODE>[ENTER]</CODE> when executing a program
interactively.  The reason why we had to type <CODE>step</CODE> this
time was that the previous command <CODE>"print s"</CODE> would be the
<EM>default command</EM>.  For convenience, the default command is
<CODE>step</CODE> initially, so we could choose to type
<CODE>step</CODE> or just press <CODE>[ENTER]</CODE> at the first step
of execution.
</P>

<P>
In general, commands can be abbreviated.  If an abbreviated command
matches more than one command name, the first mathing command is
executed (no warning about ambiguities!).  To find out what command
matches a given abbreviation, e.g. <CODE>"n"</CODE>, use the
<CODE>help</CODE> command: 

  code_box(`help n')

The response tells you that <CODE>n</CODE> abbreviates the command 
<CODE>next</CODE>, and it gives some general information about the
<CODE>next</CODE> command as well.
</P>

<H3>This is best for one-file programs</H3>
<P>
At the command line, _gbeta can only pretty-print the enclosing source
code to show you what part of the program is currently being executed.
Since pretty-printing drops all comments and reshapes the source code
formatting to a strictly regular style, lots of information is lost,
and this approach gets tedious and confusing when running any but the
smallest programs interactively. The _startref(5,next) section
presents the integration of _gbeta with GNU Emacs which gives a much
more useful environment for larger programs.
</P>

end_start

dnl local variables:
dnl mode: html 
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
