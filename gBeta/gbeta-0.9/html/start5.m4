include(startstd.m4)dnl
_deflr(4,6)dnl
begin_start(`GNU Emacs Integration')

<P>
To obtain an environment which has much better scalability for
programs consisting of many fragment groups (source code files),
try to run _gbeta from GNU Emacs.  This environment offers a
more "visually" oriented interaction as well.
</P>

<H3>Setting up Emacs</H3>
<P>
Assuming that you have access to GNU Emacs and already use it, you
probably have a file <CODE>~/.emacs</CODE> which contains your
personal Emacs initialization code.  If you do not have this file, 
just create it with the contents given below, otherwise add these
three lines anywhere in the file.

program_box(cq 
[[(setq gbeta-root (getenv "GBETA_ROOT"))
(if (not gbeta-root) (setq gbeta-root "~/gbeta-0.9"))
(load-file (concat gbeta-root "/emacs/gud-gbeta.elc"))]] nq)

By the way, you can also find this in the file
<CODE>gbeta.emacs</CODE> in the distribution.
</P>

<H3>Starting Emacs, under X..</H3>
<P>
Initially, go to the <CODE>start</CODE> directory, i.e. with a
standard installation:

  code_box(`cd $HOME/gbeta-0.9/examples/start')

Now you can start up Emacs and load a source code file:

  code_box(`emacs beer.gb &amp;')

It is assumed that you are running under X Windows, such that Emacs is
able to point out selected portions of the source code by changing a
visual attribute such as the background color of the text within that
region.  This is very important for the interaction.  Of course you
can load the source code file from within an already running instance
of Emacs if you prefer.
</P>

<H3>Some Emacs terminology</H3>
<P>
Emacs may have more than one "frame," and each frame may have more
than one "window."  Since the Emacs terminology collides with the
general terminology of common GUIs, we'll shortly recapitulate the
Emacs terms here:  An Emacs <EM>frame</EM> is the graphical unit which
is decorated by the window manager (e.g. with a titlebar and a
border), and which can be moved, resized, iconified, raised, lowered,
and so on.  An Emacs <EM>window</EM> is a vertical or horizontal band
of an Emacs frame, showing a portion of one buffer.  These concepts
are important because there is normally an interpreter window showing
an interpretation (Emacs thinks: debugging) buffer, and a source code
window showing one of a number of source code buffers containing the
program being interpreted.  The interaction is different when the
interpretation window is active and when the source code window is
active. 
</P>

<H3>Starting the interpretation</H3>
<P>
To initiate an interactive execution of the program in the newly
loaded buffer, ensure that the window showing that buffer is the
currently active window (click in it).  Then do:

  code_box(`M-x gbeta')

This is standard Emacs notation for pressing the Meta-modifier
(possibly labeled with "Alt", "AltGr" or a small rhombus) along with
the "x" key and then typing <CODE>"gbeta[ENTER]"</CODE>.  This leads
to a prompt in the bottommost line of the frame (the "minibuffer"):

  code_box(`Run gbeta (like this): gbeta beer.gb')

At this prompt you can edit the command line for invoking
_gbeta to e.g. add various options, but normally accepting the
default and pressing <CODE>[ENTER]</CODE> is appropriate.
</P>

<P>
This starts up an interactive _gbeta session in one window and
shows the source code file containing the first statement of the
program in another window.  The file shown is not necessarily the same
as the argument given to _gbeta, since the
_topref(modularization,`fragment system') makes it possible to insert
your program into some larger context. 
</P>

<P>
The _startref(6,next) section deals with the interaction within an
Emacs-based _gbeta session.  As a rule of thumb, however, you can just
start using what you already know from the command line interaction.
</P>

end_start

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
