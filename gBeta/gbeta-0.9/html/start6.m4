include(startstd.m4)dnl
_deflr(5,7)dnl
begin_start(cq [[GNU Emacs Integration (cont'd)]] nq)

<H3>The two windows</H3>
<P>
After having invoked _gbeta on the <CODE>beer.gb</CODE> source
code file, you get the familiar prompt in one window:

program_box(`executing~1> _')

and the first statement of the program (which happens to reside in the
file <CODE>betaenv.gb</CODE>) emphasized in the middle of the other
window:

program_box(cq [[<SMALL>...
   min: (# i,j: @integer enter (i,j) exit (if i&lt;j then i else j if)#);
   theProgram: @&lt;&lt;SLOT program:merge>>;
do
=> <FONT COLOR="#0000FF"><B>theProgram</B></FONT>
#)</SMALL>]] nq)

The current imperative is emphasized in two ways.  At the leftmost
column of the window, an <CODE>"=>"</CODE> arrow enables a quick scan
to find the line containing the current imperative, and somewhere in
the middle of that line, a block is highlighted using the same
attributes as the "secondary selection."  This might e.g. give the
selected region a light blue background color.  Here it is shown as
a blue foreground color.
</P>

<H3>Some unchanged features, and a better display</H3>
<P>
Printing the state of objects or the structure of patterns, or static
information about program elements works the same as in the command
line environment.  Showing a position in the source code works a lot
better, because the <CODE>display</CODE> command can exploit Emacs to
show the given source code position in the source code window.  Try:

  code_box(`print theProgram')

This produces a rather large response, specifying the state of the
object <CODE>theProgram</CODE>:

program_box(cq [[<SMALL>
object, composite object slice~72~71 = 
   (#`beer.gb:1112
      "line" : pattern =
	 integer pattern slice
	 composite pattern slice = beer.gb:532 in CsOSli~72~71
      ...
   #)</SMALL>]] nq)

Then go up and find the annotation at the top of the "state block": it
will be a backquote followed by a filename, a colon, and an integer
which gives the identity of a node in the abstract syntax tree,
in this case cq<CODE>`beer.gb:1112</CODE>nq.  Now give that (without
the backquote) as an argument to the <CODE>display</CODE> command:  

  code_box(`display beer.gb:1112')

Actually, double-clicking with the mouse on the text
cq<CODE>`beer.gb:1112</CODE>nq (or closely after it) has the same
effect. 

  code_box(`[ click-click! ]')

You can use this to inspect the source code (declarations)
associated with the program state which 
<CODE>"print <I>something</I>"</CODE> delivers.  Try to double-click on
<CODE>beer.gb:532</CODE> or similar!
</P>

<P>
Remember that if you get lost because you have looked at lots of
places in the source code browsing the state of the program, you can
always display the imperative which will be executed next by:

  code_box(`display')

without any arguments.
</P>

<P>
In the _startref(7,next) section we will start executing the program,
and begin to use breakpoints.
</P>

end_start

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
