include(tutorialstd.m4)dnl
_deflr(`',2)dnl
begin_tut(cq[[The Conceptual Framework]]nq)

<H3>A little bit about navigation</H3>

<P>
This tutorial is about the _gbeta language.  If you are looking for
information about the practical usage of _gbeta, such as the
interaction commands, help facilities, or the integration with Emacs,
take a look at the _topref(start,`Getting Started') section.
</P>

<P>
If you look in here and don't find what you are looking for, try the
general <A HREF="http://www.daimi.au.dk/~beta/index.html#tutorial"
TARGET="_top">BETA Tutorials</A>.  Those tutorials are somewhat
oriented towards the _mjolner implementation and will give some advice
which does not apply to _gbeta, but the vast majority of truths
(except for the restrictions ;-) which can be said about the language
BETA also apply to the _gbeta language.
</P>

<P>
If you already know _topref(beta,BETA) and just want to discover how
the _gbeta language differs from BETA, then take a look at the section
about _topref(compatibility,`compatibility issues'), and at the
section about the _topref(advanced,`language enhancements') made on
the way from BETA to _gbeta.
</P>

<H3>The conceptual framework behind BETA</H3>
<P>
BETA has always had a rich philosophical foundation, providing a deep
explanation of and motivation for the object-oriented perspective on
system development, and to the design of object-oriented programming
languages.  To learn more about this, look into chapter 18 of

code_box(
`</TT>Ole Lehrmann Madsen, Birger Møller-Pedersen, Kristen Nygaard:<BR>
<I>"Object-Oriented Programming in the BETA Programming Language"</I><BR>
Addison-Wesley and ACM Press, 1993<BR>ISBN 0-201-62430-3')
</P>

<P>
Here, we'll just mention some important concepts, briefly, starting
with a quote from the above mentioned <A
HREF="http://www.daimi.au.dk/~beta/index.html#tutorial"
TARGET="_top">BETA Language Tutorial</A>, p.8:

<BLOCKQUOTE>
<P>
BETA is intended for modeling and design as well as implementation.
During the design of BETA the development of the underlying conceptual
framework has been just as important as the language itself.
</P>

<P>
BETA is a language for representing/modeling concepts and phenomena
from the application domain and for implementing such concepts and
phenomena on a computer system.  
<!-- Part of a BETA program describes objects and patterns that
represent phenomena and concepts from the application model.  This
part is said to be representative since BETA elements at this level
are meaningful with respect to the application domain.  Other parts of
a BETA program are non-representative, since they do not correspond to
elements of the application domain, but are intended for realizing the
model as a computer system. -->
</P>
</BLOCKQUOTE>  

<P>
Starting from the concept of a <EM>system</EM>, which is a portion of
the world that somebody chooses to view as a whole, built from a
number of interacting components, and continuing with the concept of
an <EM>information process</EM>, which is a perspective on a process
that emphasizes the information content and its transformations over
time, a BETA <EM>program execution</EM> may be described as an
information process considered as a system which is a <EM>physical
model</EM> of some real world process.  
</P>

<P>
In other words, what happens in the computer is actually a physical
process, and this process is analogous to what happens in the real
world, focusing on the application domain and choosing some
perspective on this application domain.
</P>

<P>
This establishes the modeling relation between programs and selected
parts of the real world as crucial, and that is the kernel of
object-orientation from a BETA perspective.  The fact that many
programming languages use constructs like inheritance, polymorphism,
genericity, encapsulation and whatnot is just a technicality which
might change as soon as other technical means for supporting the
"physical model" perspective emerge.
</P>

<P>
Enough philoso-babble ;-) The tutorial about the concrete language
starts on the _tutref(2,next) page!  By the way: just about every
reference to the programming language in the tutorial should be "BETA
and/or _gbeta" since the material presented applies to both, but the
references are just given as "_gbeta" unless there is a special reason
to distinguish.
</P>

end_tut

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
