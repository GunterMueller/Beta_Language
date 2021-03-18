define(`topic_focus',esyscmd(/usr/local/gnu/bin/echo -n $FOCUS))dnl
define(`topic_number',esyscmd(/usr/local/gnu/bin/echo -n $NUMBER))dnl
<HTML>
<HEAD>
<TITLE>gbeta</TITLE>
</HEAD>
<FRAMESET border=1 COLS="120,*">
    <FRAME SRC="topics_`'topic_focus.html" 
           MARGINHEIGHT=2 MARGINWIDTH=2 SCROLLING="no" NAME="topics">
    <FRAME SRC="topic_focus`'topic_number.html" NAME="display">
</FRAMESET>
</HTML>

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
