include(gbetastd.m4)dnl
define(`_startref',`_ref(`start',`$1',`$2')')dnl
define(`begin_start',`begin_page_base(`Getting Started',$1,`_lrref')')dnl
define(`end_start',`end_page_base')dnl
define(`_deflr',`
define(`_lref',`ifelse($1,`',`<IMG SRC="noleft.gif">',
_startref($1,`<IMG SRC="left.gif">'))')
define(`_rref',`ifelse($2,`',`<IMG SRC="noright.gif">',
_startref($2,`<IMG SRC="right.gif">'))')')dnl
