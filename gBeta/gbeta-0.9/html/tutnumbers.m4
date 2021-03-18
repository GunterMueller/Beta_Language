include(tutorialstd.m4)dnl
define(`number_focus',esyscmd(/usr/local/gnu/bin/echo -n $FOCUS))dnl
define(`tutnum_entry',
`<TR><TD ALIGN="center">_tutref($1,
`<FONT size=-1>ifelse(number_focus,$1,
`<FONT COLOR="#FF0000">$1</FONT>',`&lt;$1&gt;')</FONT>')</TD></TR>
')dnl
<HTML>
<HEAD><TITLE></TITLE></HEAD>
<BODY number_colors>

<FONT size=-2>
<TABLE ALIGN="center" BORDER=0>
foreach(`tutnum_entry($1)',tut_numbers)
</TABLE>
</FONT>
</BODY>
</HTML>

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
