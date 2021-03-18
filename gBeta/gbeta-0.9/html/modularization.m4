include(gbetastd.m4)dnl
define(`number_focus',esyscmd(/usr/local/gnu/bin/echo -n $FOCUS))dnl

<HTML>
<HEAD><TITLE></TITLE></HEAD>
<FRAMESET border=1 COLS="50,*">
    <FRAME SRC="modnumbers`'number_focus.html" MARGINHEIGHT=2 MARGINWIDTH=2 
           SCROLLING="no" NAME="modnumbers">
    <FRAME SRC="mod`'number_focus.html" NAME="moddisplay">
</FRAMESET>
</HTML>

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
