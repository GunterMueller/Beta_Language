include(modularizationstd.m4)dnl
_deflr(1,3)dnl
begin_mod(`Using Several Files')

<H3>Fragment groups, forms, and properties</H3>

<P>
A source file is called a <EM>fragment group</EM>, because it contains
a number of <EM>fragment forms</EM> along with the specification of
the relation to other fragment groups, the <EM>fragment
properties</EM>: 

program_box(cq[[
<I>fragment-group</I> ::= <I>fragment-property</I>* <I>fragment-form</I>*;
<I>fragment-property</I> ::= <I>property-kind</I> <I>group-spec</I> ";";
<I>property-kind</I> ::| "ORIGIN" | "INCLUDE" | "BODY";
<I>group-spec</I> ::= <I>pathname</I>;
<I>fragment-form</I> ::= <I>form-head</I> <I>form-body</I>;
<I>form-head</I> ::= "--" <I>form-name</I> ":" <I>non-terminal-name</I> "--";
]]nq)

This is a simplified grammar for the fragment language, but since it
describes a language which is a large subset of the actual fragment
language you can use it as it is.  Certain non-terminals are left
unspecified, namely:

<UL>
<LI><CODE><I>non-terminal-name</I></CODE>: an identifier which occurs in the
  grammar of the language as a non-terminal (i.e. at the left hand side
  of a "::=", "::|", "::+", or "::*" symbol),
  e.g. <CODE>"dopart"</CODE></LI> 
<LI><CODE><I>form-name</I></CODE>: an identifier,
  e.g. <CODE>"aNameForAPieceOfCode"</CODE></LI>
<LI><CODE><I>pathname</I></CODE>: the name of a file in the file
  system, without the extension (such as ".gb") and enclosed in single
  quotes, e.g. <CODE>"'private/myImplementation'"</CODE>; a user
  specification like <CODE>"~beta/"</CODE> in the beginning of a path
  can be treated specially as specified in some configuration files,
  but you shouldn't need to worry about this when using _gbeta</LI>
<LI><CODE><I>form-body</I></CODE>: a sentential form (a syntactic
  derivation, partial or complete) in the grammar of the programming
  language, derived from the the <CODE><I>non-terminal-name</I></CODE>
  of the fragment form.  If it is complete (no non-terminals), it is
  simply a piece of syntax in the programming language; if it still
  contains non-terminals, they must be written as slot applications:

  code_box(`"&lt;&lt;" "SLOT" 
           <I>form-name</I> ":" <I>non-terminal-name</I> "&gt;&gt;"')</LI> 
</UL>

Here is an example of a full-fledged fragment group in _gbeta: 

program_box(cq[[
ORIGIN 'betaenv';
INCLUDE 'myLib';

-- program:merge --
(# anObject: &lt;&lt;SLOT anObject:staticItem&gt;&gt;
&lt;&lt;SLOT mainProgram:dopart&gt;&gt;
#)

-- anObject:staticItem --
@(# x: @integer #)

-- mainProgram:dopart --
do 2-&gt;anObject.x
   aLibMethod (* presumably declared in 'myLib' *)]]nq)
</P>

<H3>Fragment graphs</H3>
<P>
When we have several fragment groups in a program, we must have a way
to specify which groups are included, and what the relations are
within this set of fragment groups.  This is done by constructing a
<EM>fragment graph</EM> according to the <EM>fragment properties</EM>
of the groups. 
</P>

<P>
The starting point is always one distinguished fragment group, the
<EM>seed</EM> of the fragment graph.  This is the fragment group
which is specified as "the file to execute" when starting _gbeta,
probably what you think of as the "main file" of the program.
Starting from the seed, we construct two graphs whose nodes are
fragment groups and whose edges are properties.  The following two
paragraphs give a precise definition of the concepts of extent and
domain, and the third paragraph gives a more understandable
explanation (depending on your attitude to math ;-).
</P>

<P>
The first graph, the <EM>extent</EM> graph, contains the groups which
are reachable from the seed via some number of <CODE>ORIGIN</CODE>,
<CODE>INCLUDE</CODE>, or <CODE>BODY</CODE> links (i.e. all properties
are used).  It is, hence, the transitive closure of all property links
from the seed.  This graph determines what fragment groups are
included in the program, i.e. it determines the overall "content" of
the program.
</P>

<P>
Starting from any fragment group <CODE><I>G</I></CODE> in the graph,
the subgraph of the extent which is induced by the <CODE>ORIGIN</CODE>
and <CODE>INCLUDE</CODE> links is called the <EM>domain</EM> graph of
<CODE><I>G</I></CODE> (with respect to the seed).  The domain graph
determines visibility, as explained below. 
</P>

<P>
Another way to explain this is that the <EM>extent</EM> contains all
the source code you can find by looking into fragment groups mentioned
in properties of the seed group, or of groups looked up that way, or
of groups looked up from there etc.etc.  When you have outlined the
extent, you can determine the <EM>domain</EM> of each group by a
similar, repeated lookup process, but this time you are not allowed to
use the <CODE>BODY</CODE> properties.
</P>

<P>
The basic intuition is that you use a <CODE>"BODY 'aGroup';"</CODE>
property to request that the source code in <CODE>aGroup</CODE> is
included into the program; and you use to 
<CODE>"INCLUDE 'aGroup';"</CODE> to request that the source code in
<CODE>aGroup</CODE> is included into the program <EM>and</EM> made
visible such that the source code in this fragment may depend on it.
In other words, 

  code_box(`INCLUDE </TT>means "I need this!"')

and: 

  code_box(cq[[BODY </TT>means "I need this, but I don't want to see it!"]]nq)
</P>


<P>
The <CODE>ORIGIN</CODE> properties, apart from the fact that they
imply the same things as <CODE>INCLUDE</CODE>, are used to define the
<EM>scope rules</EM> for <I>form-names</I>.  The rule is:

code_box(`</TT>A slot application can be associated with a slot
declaration iff they have the same name and there is a path of
<CODE>ORIGIN</CODE> links from the fragment group that contains the
declaration to the fragment group that contains the application') 

A useful intuition about this is that an <CODE>ORIGIN</CODE> property
tells in what <EM>direction</EM> the fragment forms in this group must
travel to find their ultimate destination.  This intuition reaches
back to the search-and-replace semantics of slots, and when several
groups (files) are involved and the search-and-replace process must
cross group borders, the source code which gets inserted to 
replace the <CODE>&lt;&lt;SLOT ..&gt;&gt;</CODE> expressions must
travel exclusively along <CODE>ORIGIN</CODE> edges in the extent
graph.  In other words, 

  code_box(cq[[ORIGIN </TT>means INCLUDE, and "Home is this way!"]]nq)
</P>

<H3>How to handle this?</H3>
<P>
The fact that graphs and lots of transitive closures are at the heart
of the definition of the module system of _gbeta (and traditional BETA
as well) may make it seem counter-intuitive and unmanageable in
practice.  However, having worked with this system for years (as a
student programmer using BETA for many tasks), I find it very
intuitive and extremely expressive.  Moreover, the fragment system is
being taught to second year C.S. students at &Aring;rhus University
every year, so it should be possible to achieve a working knowledge of
it in a reasonable time.  Looking at concrete examples is surely a
good approach.
</P>

<P>
Expanding a little on the expressiveness:  It is trivial, for example,
to set up a visibility-scheme which hides certain aspects of the
implementation of one pattern from its sub-patterns (similar to C++
<CODE>private</CODE>), or allows them to depend on those aspects
(similar to C++ <CODE>protected</CODE>), or allows certain other
patterns to see some aspects (similar to the selective export
mechanism in Eiffel), or allows certain sub-patterns but not others to
see something (not covered in C++ or Eiffel), etcetc.
</P>

<P>
An important difference is that this scheme is much more fine-grained
than the others.  It is e.g. possible to allow one particular
imperative from one particular method of a pattern to depend on (have
access to) some subset of another pattern, possibly a super-pattern.
And, equally important, since interface and implementation can be kept
in different files, patterns depending on the interface of a given
pattern <CODE>P</CODE> will not need recompilation if (only) the
implementation of <CODE>P</CODE> changes. 
</P>

<P>
Another important difference is that access is <EM>seized</EM> by the
party which "depends-on," not granted by the party which is being
"depended-on."  This means that tool support is needed to detect
whether "somebody are looking at something they shouldn't see," but on
the other hand there is no need to change the code being "depended-on"
when some other code wishes to "depend-on" it.  The philosophy is
that the vulnerable party (which breaks if the other party changes)
declares the vulnerability.
</P>

<P>
Finally, we're ready to look at a complete, concrete example in the 
_modref(3,next) section.
</P>

end_mod

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
