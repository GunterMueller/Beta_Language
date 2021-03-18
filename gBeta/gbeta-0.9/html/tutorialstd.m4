include(gbetastd.m4)dnl
define(`_tutref',`_ref(`tutorial',`$1',`$2')')dnl
define(`begin_tut',`begin_page_base(`Tutorial',$1,`_lrref')')dnl
define(`end_tut',`end_page_base')dnl
define(`_deflr',`
define(`_lref',`ifelse($1,`',`<IMG SRC="noleft.gif">',
_tutref($1,`<IMG SRC="left.gif">'))')
define(`_rref',`ifelse($2,`',`<IMG SRC="noright.gif">',
_tutref($2,`<IMG SRC="right.gif">'))')')dnl
