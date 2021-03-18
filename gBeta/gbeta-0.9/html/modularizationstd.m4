include(gbetastd.m4)dnl
define(`_modref',`_ref(`modularization',`$1',`$2')')dnl
define(`begin_mod',`begin_page_base(`Modularization',$1,`_lrref')')dnl
define(`end_mod',`end_page_base')dnl
define(`_deflr',`
define(`_lref',`ifelse($1,`',`<IMG SRC="noleft.gif">',
_modref($1,`<IMG SRC="left.gif">'))')
define(`_rref',`ifelse($2,`',`<IMG SRC="noright.gif">',
_modref($2,`<IMG SRC="right.gif">'))')')dnl
