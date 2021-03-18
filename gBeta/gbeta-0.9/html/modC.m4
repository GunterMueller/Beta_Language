include(modularizationstd.m4)dnl
_deflr(`',`')dnl
define(`_mod_toc_entry',
  `_modref(define(`inx',incr(inx))inx,<LI>$1</LI>)')dnl
define(`inx',`0')dnl
begin_mod(`Contents')

<OL>
_mod_toc_entry(`Basic Concepts')
_mod_toc_entry(`Using Several Files')
_mod_toc_entry(`A Concrete Example')
_mod_toc_entry(`A Concrete Example (continued)')
_mod_toc_entry(`A Concrete Example (continued)')
</OL>

end_mod

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
