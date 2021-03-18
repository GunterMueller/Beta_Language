include(gbetastd.m4)dnl
define(`_question',`<P><HR></P><P>
<BIG><BIG><A NAME="Q$1">Q$1: </BIG>$2</BIG>
<P><BIG><BIG>A: </BIG></BIG>$3</P>')
define(`_qref',`<A HREF="Q$1">$2</A>')
begin_page(FAQ for _gbeta)

<P>
This is a list of Frequently Asked Questions for _gbeta, both
the language and the environment.  
</P>

<P>
I'll put more questions &amp; answers in here as soon as they
get frequent ;-), hence: Don't hesitate to 
<A HREF="mailto:eernst@cs.auc.dk">tell me</A> when you think
something is missing!
</P>

<!------------------------------------------------------------------------>
_question(1,cq[[Why can't I run my existing BETA program 
              under _gbeta?]], [[There are some low-level differences
between the _mjolner implementation of BETA and the _gbeta
implementation which makes it impossible to run Mjolner BETA code
directly with _gbeta.  Check out the
_topref(compatibility,compatibility) section for details.  A future 
release will contain a slightly adapted version of the Mjolner basic
libraries that will work with _gbeta.  Even then, however, support for
calling external code (such as compiled C) is probably not ready, and
lots of the libraries of the __mjolner use externals, e.g. to create
BETA-bindings for GUI APIs.]]nq)

<!------------------------------------------------------------------------>
_question(2,cq[[Why doesn't _gbeta discover my source code changes?]],
[[During an interactive session, e.g. under Emacs, it is possible and
often relevant to change the source code of the program being
interpreted, but _gbeta will not notice the changes, and the
color coding in the source code window will still correspond to the
original program, as when the interpretation started.  It probably
looks as if the colored block is an arbitrary part of the source code,
and not the currently executing imperative.  Even <CODE>kill</CODE>ing
and <CODE>restart</CODE>ing the interpretation does not solve the
problem. 
</P>

<P>
This is because _gbeta reads the source code at startup, then builds
an internal representation of the program, an abstract syntax tree,
and then decorates this abstract syntax tree with static analysis
information and executes.  It never looks at the text files after
the startup phase. 
</P>

<P>
To refresh _gbeta's picture of the program, <CODE>quit</CODE> the
session and start a new one.  In Emacs you should kill the _gbeta
interactive buffer (<CODE>C-xk</CODE>) and execute the 
<CODE>M-x gbeta</CODE> command from the main source code buffer
again: the debugger framework of Emacs, which is used for the _gbeta
Emacs integration, does not support running the "debugger" (here:
_gbeta) more than once in a given buffer.
]]nq)

<!------------------------------------------------------------------------>
_question(3,cq[[Why doesn't it work to <CODE>finish</CODE> a
<CODE>for</CODE>-imperative?]],
[[When single-stepping through a piece of code like:

program_box(
cq[[(# i: @integer
do something;
   (for 200000 repeat 1-&gt;i for);
   something_else
#)]]nq)

it is tempting to skip all those iterations of the
<CODE>for</CODE>-imperative, because single-stepping them is not
likely to reveal any new information.  If you haven't stepped into the
<CODE>for</CODE>-imperative yet, the <CODE>next</CODE> command will
execute all of it in one go.  But if you have already stepped into the
body of the <CODE>for</CODE>-imperative, you have to do something else.
</P>

<P>
This looks like a job for <CODE>finish</CODE>, but since
<CODE>finish</CODE> only executes to the end of the current block of
imperatives, it just executes one of the many iterations of the
<CODE>for</CODE>-imperative.  We still have to press
<CODE>[ENTER]</CODE> 200000 times.  Moreover, <CODE>"finish 2"</CODE>
will execute to the end of the enclosing do-part, but we might want
to single-step into <CODE>something_else</CODE>.
</P>

<P>
The solution is to put a temporary breakpoint after the
<CODE>for</CODE>-imperative.  In Emacs you can this by clicking on
<CODE>for</CODE> and selecting the <CODE>"Tmp. Brk. After"</CODE>
entry in the <CODE>Gud</CODE> menu.]]nq)

<!------------------------------------------------------------------------>

_question(4,cq[[How do I get a list of breakpoints?]],
[[The currently installed breakpoints can be printed with the command
<CODE>"show breakpoints"</CODE> (possibly abbreviated to something
like <CODE>"sh b"</CODE>).  To view the associated source code, when
running under Emacs, double-click near the end of the line specifying
the source code file and position for the breakpoint in question.]]nq)

<!------------------------------------------------------------------------>
<!------------------------------------------------------------------------>
<HR>
<A NAME="other"><H3>Other sources</H3>
<P>
If you cannot find an answer to your question here, there are a few
other possibilities.  For questions about the language, consider the
general <A HREF="http://www.daimi.au.dk/~beta/FAQ/"
TARGET="_top">BETA FAQ</A>.  Except for a few, small
_topref(compatibility,changes), the language _gbeta is a backwards
compatible superset of the traditional BETA language.  Consequently, a
large number of questions about _gbeta could as well be seen as
questions about BETA.
</P>

<P>
For questions about the practical usage of and interaction
with the current _gbeta implementation, check out the section
_topref(start,`"Getting Started"').
</P>

end_page

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
