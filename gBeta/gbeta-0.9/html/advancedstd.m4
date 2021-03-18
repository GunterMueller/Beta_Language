include(gbetastd.m4)dnl
define(`_advref',`_ref(`advanced',`$1',`$2')')dnl
define(`begin_adv',`begin_page_base(`Advanced Issues',$1,`_lrref')')dnl
define(`end_adv',`end_page_base')dnl
define(`_deflr',`
define(`_lref',`ifelse($1,`',`<IMG SRC="noleft.gif">',
_advref($1,`<IMG SRC="left.gif">'))')
define(`_rref',`ifelse($2,`',`<IMG SRC="noright.gif">',
_advref($2,`<IMG SRC="right.gif">'))')')dnl
