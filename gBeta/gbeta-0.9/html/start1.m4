include(startstd.m4)dnl
_deflr(`',2)dnl
begin_start(`Checking the installation')

<P>
If you have not already _topref(installation,installed)
_gbeta, then please do that before you proceed here.  In this section
it is assumed that you have installed in your <CODE>$HOME</CODE>
directory.  If not, you must adjust some paths accordingly. 
</P>

<H3>Checking that _gbeta is there</H3>

<P>
Generally the experiments in this section take place in the
<CODE>start</CODE> directory: 

  code_box(`cd $HOME/gbeta-0.9/examples/start')
</P>

<P>
First try to execute _gbeta without arguments, like this:

  code_box(`gbeta')

If the interpreter invocation script is in the <CODE>PATH</CODE> or
otherwise reachable, and if the interpreter itself is present for the
current platform, and if it can find the grammar specifications, then
you will get an informative startup message like this:

  code_box(`GBETA version 0.9, copyright (C) 1997-2001 Erik Ernst.<BR>
           This is free software, and you are welcome..')

If you can get this message, the installation is probably working.
</P>

<P>
_startref(2,Next), we'll run an actual program!
</P>

end_start

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
