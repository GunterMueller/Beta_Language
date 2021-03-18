include(gbetastd.m4)dnl
define(`topic_focus',esyscmd(/usr/local/gnu/bin/echo -n $FOCUS))dnl
define(`topic_entry',`<TR><TD><IMG SRC=ifelse(
topic_focus`.html',`$1',`"redball.gif"',`"bullet.gif"') ALT=""></TD><TD>
<A HREF="index_$1" target="_top"><FONT SIZE=-1>$2</FONT></A></TD></TR>')dnl
dnl
<HTML>
<HEAD><TITLE></TITLE></HEAD>
<BODY topic_colors>

<CENTER>
  <P><B><H1>gbeta</H1></B></P>
  <TABLE BORDER=2>
    <TR><TD><IMG SRC="logo-fat.gif" ALT="gbeta logo"></TD></TR>
  </TABLE>
</CENTER>

<P><B>Contents:</B>
<HR>
<FONT size=-3>
<TABLE ALIGN="left" BORDER=0>
topic_entry(`intro.html',`What is _gbeta?')
topic_entry(`beta.html',`What is BETA?')
topic_entry(`start.html',`Getting started')
topic_entry(`tutorial.html',`Tutorial')
topic_entry(`modularization.html',`Modularization')
topic_entry(`lazy.html',`Lazy analysis')
topic_entry(`advanced.html',`Advanced Issues')
topic_entry(`compatibility.html',`Compatibility')
topic_entry(`papers.html',`Papers')
topic_entry(`download.html',`Download')
topic_entry(`installation.html',`Installation')
topic_entry(`compiling.html',`Compiling')
topic_entry(`faq.html',`FAQ')
topic_entry(`bugs.html',`Bugs etc.')
topic_entry(`copyright.html',`Copyright (GPL)')
topic_entry(`news.html',`News')
</TABLE>
</FONT>
</BODY>
</HTML>

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
