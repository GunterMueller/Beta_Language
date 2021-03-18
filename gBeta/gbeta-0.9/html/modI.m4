include(gbetastd.m4)dnl
define(`_mod_toc_entry',
  `_modref(define(`inx',incr(inx))inx,<LI>$1</LI>)')dnl
define(`inx',`0')dnl
begin_mod(`Contents')

<UL>
_mod_toc_entry(`Basic Concepts')
_mod_toc_entry(`Using Several Files')
_mod_toc_entry(`A Concrete`,' Complete Example')
_mod_toc_entry(`The Interface/Implementation Setup')
_mod_toc_entry(`The Library Setup')
_mod_toc_entry(`A Larger Example')
_mod_toc_entry(cq[[A Larger Example (cont'd)]]nq)
_mod_toc_entry(`')
_mod_toc_entry(`')
_mod_toc_entry(`Contents')
</UL>

end_mod

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
