include(modularizationstd.m4)dnl
_deflr(`',2)dnl
begin_mod(`Basic Concepts')

<P>
The <EM>fragment language</EM> provides support for creating a 
program as the combination of several independent or interdependent
modules.  It is a language in its own right, and it could be used for
the modularization of any programmming language whose syntax can
be described by a context free grammar (well, with the current tools:
a LALR(1) grammar). 
</P>

<P>
A <B>gbeta</B> program, as well as a traditional BETA program, is
written in a mixture of the fragment language and the (<B>gbeta</B> or
BETA) programming language.  The fragment language defines the
top-level structure, and the programming language syntax occurs as
fragments of varying size, inserted into the fragment language
constructs at certain places.
</P>

<P>
The fragment language also defines some bottom-level expressions, i.e.
small pieces of syntax that do not contain any syntax from the
programming language.  These bottom-level expressions are inserted
into the programming language syntax as place-holders.
</P>

<P>
The following sections will add the missing details to this
description.  The basic concepts can be introduced without considering
multi-file programs, so we commence with a one-file situation. 
</P> 

<H3>Declarations and applications of SLOTs</H3>

<P>
First, let us take a look at the top-level construct where the
fragment language construct encloses some programming language syntax
(<CODE><I>piece-of-code</I></CODE> is written in the programming 
language).  The basic purpose of this is to give a
<CODE><I>name</I></CODE> to a <CODE><I>piece-of-code</I></CODE>:  

program_box(cq[[
(* SLOT declaration *)
-- <I>name</I>:<I>non-terminal</I>:<I>grammar</I> --
<I>piece-of-code</I>
]]nq)

<P>

</P>
The <CODE><I>piece-of-code</I></CODE> must be syntactically derived
from the given <CODE><I>non-terminal</I></CODE>.  If for example the
<CODE><I>non-terminal</I></CODE> is <CODE>dopart</CODE>, then the
<CODE><I>piece-of-code</I></CODE> must be a <CODE>dopart</CODE>, i.e.
<CODE>"do"</CODE> followed by a number of imperatives.

Such a named piece of code can then be used (applied) in other places
by referring to the name:

program_box(cq[[...
(* SLOT application *)
&lt;&lt;SLOT <I>name</I>:<I>non-terminal</I>&gt;&gt;
...]]nq)

This is the bottom-level construct of the fragment language.  The 
<CODE>&lt;&lt;SLOT ..&gt;&gt;</CODE> syntax appears in the middle of
some programming language syntax. 
</P>

<P>
There is an analogy to constants in ordinary programming languages:
The slot declaration says that the given <CODE><I>name</I></CODE> is 
declared to be a constant whose value is the associated
<CODE><I>piece-of-code</I></CODE>.  The slot application instructs the
language processing system (compiler, interpreter, analyzer, ..) to
look up the piece of code with the given <CODE><I>name</I></CODE> and
put it right here, in stead of the 
<CODE>&lt;&lt;SLOT ..&gt;&gt;</CODE>.  
</P>

<P>
Think of it as a kind of search-and-replace operation which will
substitute away slot applications until the entire program is written
in the programming language and all of the fragment language syntax
has been eliminated.
</P>

<P>
Here's an example:

program_box(cq[[
-- betaenv:descriptor --
(# s: @string
&lt;&lt;SLOT main:dopart&gt;&gt;
#)

-- main:dopart --
do '"s" can be accessed from here'-&gt;s
]]nq)

The <CODE>betaenv:descriptor</CODE> slot is special.  Since we
cannot substitute pieces of code into each other ad infinitum, we must
choose a distinguished piece of code to be the root of the system.
That is a <CODE>descriptor</CODE> with the name <CODE>betaenv</CODE>.
_modref(2,Later) we'll add one more constraint to this. 
</P>

<P>
If we perform the search-and-replace process on the above example, we
get the following program:

program_box(cq[[
(# s: @string
do '"s" can be accessed from here'-&gt;s
#)]]nq)
</P>

<H3>Separate compilation vs. generality</H3>
<P>
The semantics of slots is described by the search-and-replace
scenario, but a language processing system would normally not be
appropriate for real-world use if it actually did modify the source
code in such a way.  The problem is that compilation of almost any
BETA program would imply changes in very basic (highly depended-upon)
files, and hence almost any BETA compilation would be a recompilation
of "the entire universe" (including various standard libraries).
</P>

<P>
Luckily, it does not have to be like that.  As long as a BETA compiler
is able to compile the code in such a way that resulting programs
behave <EM>as if</EM> the search-and-replace operations had taken
place, the semantics will be correct, the basic files will remain
unaffected, and compilation will take time roughly proportional to the
size of the program, not to the size of the "universe." 
</P>

<P>
So, in practice (in particular in the __mjolner),
separate compilation is achieved by supporting some non-terminals
as slots (notably <CODE>dopart</CODE>, <CODE>descriptor</CODE>, and 
<CODE>attributes</CODE>) for which separate compilation has been
implemented, and reject programs using other non-terminals as slots.
Moreover, there are some restrictions on the usage of the supported
non-terminals.  Look into the standard 
<A HREF="http://www.daimi.au.dk/~beta/FAQ/index.html#SectionI" 
TARGET="_top">BETA FAQ</A> 
for details about this.  As practical experience shows, even those few
supported non-terminals are sufficient to establish a very expressive
and flexible module system. 
</P>

<P>
Nevertheless, it's interesting to be able to experiment with all 
non-terminals of the grammar, as well as being relieved of those
restrictions which the __mjolner puts on the usage of the supported
non-terminals.  Notably, it is a serious constraint that no substance
can be declared in an <CODE>attributes</CODE> slot, even though there
is a reasonable work-around.
</P>

<P>
Because of this, and because _gbeta (being an interpreter) would
look at all of the source code anyway, _gbeta was designed in such a
way that all non-terminals are supported, and there are no
special restrictions on their usage.  On the other hand there is no
"separate compilation" in _gbeta.  It is a possible future project to
reconcile the generality of the fragment language in _gbeta and some
notion of separateness and persistence in the _gbeta analysis.
</P>

<H3>How many files?</H3>
<P>
Everything said sofar can be tried out using programs consisting of
only one source code file, but it basically also holds in the general
case where there are several files involved.  However, with several
files we have to consider visibility ("privateness") issues and issues
concerning the relations between those several files.  The 
_modref(2,next) section deals with this.
</P>

end_mod

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
