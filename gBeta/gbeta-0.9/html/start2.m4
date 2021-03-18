include(startstd.m4)dnl
_deflr(1,3)dnl
begin_start(`Running a Program')

<P>
Now try to run the program <CODE>hello.gb</CODE> (you didn't expect
this, did you? ;-)

  code_box(`gbeta hello')

The program looks like this:

program_box(cq [[
-- betaenv:descriptor --
(# 
do 'Hello, world!'->stdio
#)]] nq)

The output from the execution is quite verbose:

program_box(cq [[
<SMALL>GBETA version 0.9, copyright (C) 1997-2001 Erik Ernst.
This is free software, and you are welcome to redistribute it 
under certain conditions; this software comes with ABSOLUTELY NO WARRANTY.
For details please see the file COPYING.

Interpreting "hello"

------------------------------ Analyze program

------------------------------ Execute primary object
Hello, world!
</SMALL>]] nq)

There is no way to get rid of the verbosity right now, but the next
release will have a <CODE>-q</CODE> option or (likely) be much more
quiet by default.
</P>

<P>
The _startref(3,next) subject is interactive execution, not unlike a
debugging session.
</P>

end_start

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
