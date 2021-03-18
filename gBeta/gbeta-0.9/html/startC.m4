include(startstd.m4)dnl
_deflr(`',`')dnl
define(`_start_toc_entry',
  `_startref(define(`inx',incr(inx))inx,<LI>$1</LI>)')dnl
define(`inx',`0')dnl
begin_start(`Contents')

<OL>
_start_toc_entry(`Checking the installation')
_start_toc_entry(`Running a Program')
_start_toc_entry(`Command Line Interaction')
_start_toc_entry(cq [[Command Line Interaction (cont'd)]] nq)
_start_toc_entry(`GNU Emacs Integration')
_start_toc_entry(cq [[GNU Emacs Integration (cont'd)]] nq)
_start_toc_entry(cq [[GNU Emacs Integration (cont'd)]] nq)
_start_toc_entry(cq [[GNU Emacs Integration (cont'd)]] nq)
_start_toc_entry(cq [[GNU Emacs Integration (cont'd)]] nq)
</OL>

end_start

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
