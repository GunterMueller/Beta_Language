include(startstd.m4)dnl
define(`number_focus',esyscmd(/usr/local/gnu/bin/echo -n $FOCUS))dnl
define(`startnum_entry',
`<TR><TD ALIGN="center">_startref($1,
`<FONT size=-1>ifelse(number_focus,$1,
`<FONT COLOR="#FF0000">$1</FONT>',`&lt;$1&gt;')</FONT>')</TD></TR>
')dnl
<HTML>
<HEAD><TITLE></TITLE></HEAD>
<BODY number_colors>

<TABLE ALIGN="center" BORDER=0>
foreach(`startnum_entry($1)',start_numbers)
</TABLE>
</BODY>
</HTML>

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
