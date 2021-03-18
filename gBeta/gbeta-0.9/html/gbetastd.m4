dnl ======================================================================
dnl
define(`topic_colors',`TEXT="#000080" BACKGROUND="marble.jpg" 
  LINK="#0000FF" VLINK="#0000FF" ALINK="#FF0000"')dnl
define(`number_colors',`TEXT="#000080" BACKGROUND="marble.jpg"
  LINK="#0000FF" VLINK="#0000FF" ALINK="#FF0000"')dnl
define(`page_colors',`TEXT="#000000" BGCOLOR="#FFFFFF"
  LINK="#0000FF" VLINK="#800080" ALINK="#FF00FF"')dnl
dnl
dnl ======================================================================
dnl
define(`begin_page_base',`
<HTML>
<HEAD><TITLE>gbeta`'ifelse(`',`$1',`',` $1:'): $2</TITLE></HEAD>
<BODY page_colors>
<TABLE WIDTH="100%">
<TR><TD ALIGN="right">$3</TD></TR>
<TR><TD ALIGN="left"><H1>ifelse(`',`$1',`',`$1: ')$2</H1></TD></TR>
</TABLE>
<P><HR></P>
<TABLE><TR><TD WIDTH="25%">&nbsp;</TD><TD WIDTH="50%">')dnl
dnl
dnl ======================================================================
dnl
define(`end_page_base',`</TD><TD WIDTH="20%">&nbsp;</TD></TR></TABLE>
<P><HR></P>
<SMALL>
  <I>
    <CENTER>
      <STRONG>Signed by: </STRONG>
      <A HREF="mailto:eernst@cs.auc.dk">eernst@cs.auc.dk</A>.
      Last Modified: 'esyscmd(`date +"%e-%b-%y"')`<BR>
    </CENTER>
  </I>
</SMALL>
</BODY>
</HTML>')dnl
dnl
dnl ======================================================================
dnl
define(`_lrref',`
<TABLE><TR ALIGN="center">
  <TD>_lref(`<IMG SRC="left.gif">')</TD>
  <TD>_rref(`<IMG SRC="right.gif">')</TD>
</TR></TABLE>')dnl
dnl
define(`begin_page',`begin_page_base(`',$1,$2)')dnl
define(`end_page',`end_page_base')dnl
dnl
dnl ======================================================================
dnl
define(`num_entry',
       `<TR><TD><A HREF="$2" target="$1display">&lt;$3&gt;</A></TD></TR>')dnl
dnl
dnl ======================================================================
dnl
define(`code_box',`
<P>
  <CENTER>
    <TABLE BORDER=2 CELLPADDING=10 BGCOLOR="#FFFFFF">
      <TR><TD><CODE>$1</CODE></TD></TR>
    </TABLE>
  </CENTER>
</P>')dnl
define(`program_box',`
<P>
  <TABLE BORDER=2 CELLPADDING=10 WIDTH=90% BGCOLOR="#FFFFFF">
    <TR><TD><PRE>$1</PRE></TD></TR>
  </TABLE>
</P>')dnl
define(`cq',`changequote(`[[',`]]')')dnl
define(`nq',`changequote')dnl
dnl
dnl ======================================================================
dnl
define(`foreach',
 `pushdef(`_witheach',`$1')_foreach(shift($@))popdef(`_witheach')')dnl
define(`_foreach',
 `_witheach($1)`'ifelse($#,1,,$#,1,``$1'',`_foreach(shift($@))')')dnl
dnl
dnl ======================================================================
dnl
define(`adv_numbers',`C,1,2,3,4,5,6,7,8,9')dnl
define(`mod_numbers',`C,1,2,3,4,5')dnl
define(`start_numbers',`C,1,2,3,4,5,6,7,8,9')dnl
define(`tut_numbers',`C,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16')dnl
dnl
dnl ======================================================================
dnl
define(`topic_list',``beta', `bugs',dnl
 `compatibility', `compiling', `copyright', `download',dnl
 `faq', `installation', `intro', `lazy', `news', `papers'')dnl
define(`subtopic_list',``advanced', `modularization', `start', `tutorial'')dnl
dnl
dnl ======================================================================
dnl
define(`_gbeta',`<B>gbeta</B>')
define(`_mjolner',
  `<A HREF="http://www.mjolner.dk/" TARGET="_top">Mjolner BETA System</A>')
define(`__mjolner',`Mjolner BETA System')
dnl
dnl ======================================================================
dnl
define(`_topref',`<A HREF="index_$1.html" TARGET="_top">$2</A>')dnl
define(`_ref',`<A HREF="$1_index$2.html" TARGET="display">$3</A>')dnl
dnl
dnl ======================================================================
dnl
define(`_notyet',`<P>
<IMG SRC="under-construction.gif" ALT=""> (Not yet ready .. $1)
</P>')
dnl
dnl ======================================================================
dnl
dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
