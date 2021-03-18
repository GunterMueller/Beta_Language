include(startstd.m4)dnl
_deflr(2,4)dnl
begin_start(`Command Line Interaction')

<P>
Since _gbeta is biased towards language design and semantics, the
support for observation of program executions has a high priority.
When running interactively, i.e. when giving the <CODE>-i</CODE>
option:

  code_box(`gbeta -i ...')

the execution stops at the first statement of the program, and you can
investigate what is going on much like in a source level debugger.
You can print the state of objects, execute ad-hoc statements, and
retrieve static analysis information about program elements, e.g. the
statically known type of a reference attribute.  Moreover, you can
control the program execution by single-stepping, setting breakpoints,
and running the program. 
</P>

<H3>Starting an interactive session</H3>
<P>
Try to execute the program <CODE>hello2.gb</CODE> interactively: 

  code_box(`gbeta -i hello2')

The program looks like this:

program_box(cq [[
(* FILE hello2.gb *)
-- betaenv:descriptor --
(# s: @string;
   hello: (# exit 'Hello' #)
do 'world!'->s;
   hello+', '+s->stdio
#)]] nq)

When _gbeta starts executing this program interactively, you
will have the usual startup message, and then:

program_box(cq [[
====================
(#`196
   s: @string;
   hello: (#`74
      exit 'Hello'
      #)
do <B><U>'world!'->s;</U></B>
   hello+', '+s->stdio
#)
====================

executing~1> _]] nq)

The source code surrounding the currently executing imperative
(statement) is pretty-printed before the interactive prompt
<CODE>"executing~1> _"</CODE>.  Depending on the capabilities of the
terminal, the exact imperative to execute next is emphasized one way
or another, in this case by an underlined and bold font.  The
<CODE>-c</CODE> option is used to select other color coding schemes;
in particular, option <CODE>-cc</CODE> selects the most expressive one
using ISO 6429 color escape sequences.  This is also an ANSI standard,
and it is often used e.g. under Linux to show color coded directory
listings.
</P>

<H3>The interactive prompt</H3>
<P>
There are two different interactive prompts, namely 
<CODE>"terminated> _"</CODE> and prompts like 
<CODE>"executing~1> _"</CODE>.  The first one indicates that no
threads are currently executing.  In this situation many commands are
disabled, but the program can e.g. be started with <CODE>run</CODE>
or <CODE>step</CODE>. 
</P>

<P>
The second kind of prompt, <CODE>"executing~1> _"</CODE>, indicates
that the program is currently being executed, and it specifies the
identifying number for the thread which is the current run-time
context.  For programs without concurrency, the thread number is
always one.  For programs with concurrency it is nice to know just
what thread was trapped at a given breakpoint..
</P>

<P>
After these preparations, the _startref(4,next) section deals with the
actual executing of the program.
</P>

end_start

dnl local variables:
dnl mode: html 
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
