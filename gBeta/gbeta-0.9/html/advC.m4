include(advancedstd.m4)dnl
_deflr(`',`')dnl
define(`_adv_toc_entry',
  `_advref(define(`inx',incr(inx))inx,<LI>$1</LI>)')dnl
define(`inx',`0')dnl
begin_adv(`Contents')

<OL>
_adv_toc_entry(`Object Metamorphosis')
_adv_toc_entry(`Industrial Method Combination..')
_adv_toc_entry(`Co-evolution of Patterns`,' Design Patterns')
_adv_toc_entry(`Roles and Role Players')
_adv_toc_entry(`Dynamic Control Structures')
_adv_toc_entry(`Using a Virtual Prefix')
_adv_toc_entry(`Combination of Patterns Everywhere')
_adv_toc_entry(`More Versatile Control Structures')
_adv_toc_entry(`Using the Code Twice')
</OL>

end_adv

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
