include(gbetastd.m4)dnl
define(`_tut_toc_entry',  
  `_tutref(define(`inx',incr(inx))inx,<LI>$1</LI>)')dnl
define(`inx',`0')dnl
begin_tut(`Contents')

<UL>
_tut_toc_entry(cq[[The Conceptual Framework]]nq)
_tut_toc_entry(`The Concept of a <CODE>MainPart</CODE>')
_tut_toc_entry(`Overview of Declarations')
_tut_toc_entry(`Transparency and Coercion')
_tut_toc_entry(cq[[Transparency and Coercion (cont'd)]]nq)
_tut_toc_entry(`Evaluations')
_tut_toc_entry(`Specialization (Inheritance)')
_tut_toc_entry(`Virtual Patterns')
_tut_toc_entry(`Pattern References')
_tut_toc_entry(`Co-routines')
_tut_toc_entry(`Concurrency')
_tut_toc_entry(`Control Structures')
_tut_toc_entry(`Repetitions')
_tut_toc_entry(`The "new" (&amp;) Operator')
_tut_toc_entry(`Block-structure')
_tut_toc_entry(`Primitive Entities')
_tut_toc_entry(`Contents')
</UL>

end_tut

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
