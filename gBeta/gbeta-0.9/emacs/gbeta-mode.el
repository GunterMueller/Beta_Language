;; gbeta-mode.el --- gbeta source code editing mode for Emacs,
;;                   made by adapting the BETA mode slightly.

;; Copyright (C) 1997-2001 Erik Ernst
;;
;; This file is part of "gbeta" -- a generalized version of the
;; programming language BETA.
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2 of
;; the License, or (at your option) any later version.
;;
;; This program is destributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; Among other things, the copyright notice and this notice must be
;; preserved on all copies.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program, probably in a file named COPYING; if not,
;; write to the Free Software Foundation, Inc., 675 Mass Ave,
;; Cambridge, MA 02139, USA.
;;
;; To contact the author by email: eernst@cs.auc.dk
;;
;; $Id: gbeta-mode.el,v 1.2 2001/05/30 23:40:55 eernst Exp $

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(provide 'gbeta-mode)

;; We are building on the BETA mode, so we will load that mode and 
;; then adjust a few things
(require 'beta-mode)

;; A function with the natural name for setting up the gbeta mode 

(defun gbeta-mode () 
  "Major mode for editing gbeta code.

This mode is a slightly modified version of the BETA mode.  For this
reason, many functions and variables are named \"beta-..\" and not
\"gbeta-..\", and documentation of functions will use \"BETA\" where 
\"gbeta\" would otherwise be expected.

Tab indents the current line of gbeta code.
To get an ordinary tab-character use C-q TAB
<Return> indents the current line and the new line.
A \{ opens a new pattern \(#.
A \} closes the innermost construct with the appropriate end marker like
#\) or if\).
<Delete> converts tabs to spaces as it moves back.

gbeta-comments:
===============

Comments are delimited with (* ... *), multiline comments are begin with an 
extra '*'
Four useful functions exist for manipulating comments:
 beta-comment-justify 
   Formats a gbeta comment according to the gbeta recommandations (i.e. with '*'
   in front of each new line in the comment).  Furthermore, the comment is
   formatted to fill as little as possible. Assumes that the cursor is 
   positioned within a gbeta comment.  If not, the first comment found before
   the cursor is justified.  If no comment is found before the cursor position,
   the first comment following the cursor position will be affected.
 beta-comment-justify-region
   Like beta-comment-justify, except that the marked region is expected to be
   part of some gbeta comment, and that only that part of the region is to be
   reformatted.
 beta-convert-region-to-comment
   Takes the marked region and surrounds it with gbeta comment symbols, and
   formats the new comment according to the gbeta comment recommandations.  Any
   comment symbols in the marked region will be converted into {*, 
   respectively *} to avoid spurious problems with nested comments (not
   supported by the gbeta compiler).
 beta-remove-comment
   Is the 'inverse' of beta-convert-region-to-comment'.  Removes the gbeta
   comment symbols at the either end of the region, restoring any nested
   comment symbols, enclosed in this comment.

Also the function indent-buffer is supplied as an alternative to indent-region.

Local key map:
==============
\\{beta-mode-map}
Variables controlling indentation style:
========================================

 beta-tab-to-comment
    Non-nil means that for lines which don't need indenting, TAB will
    either delete an empty comment, indent an existing comment, move 
    to end-of-line, or if at end-of-line already, create a new comment.
 beta-auto-indent
    Non-nil means that NEWLINE at the end of a line will auto-indent to
    the 'correct' position on the new line.
 beta-space-after-star
    Non-nil means, that if beta-auto-indent is t, \"* \" is inserted after NEWLINE within 
    comments instead of only \"*\".
 beta-semicolon-after-closing
    Non-nil means that a semicolon is inserted after the closing construction 
   (if needed) by beta-close-pattern.
 beta-indent-level
    Indentation of gbeta statements within surrounding block.
    The surrounding block's indentation is the indentation
    of the line on which an open-construct like \(# or \(for appears.
 beta-separator-indent-level
    Indentation of an enter-, do- or exit-line with respect
    to the containing block.
 beta-case-indent-level
    Indentation of the // lines in if-blocks with respect to the
    containing block.
 beta-below-separator-indent
    Extra indentation of lines belonging to the do-, enter- or
    exit-part of a pattern.
 beta-comment-indent-level
    Indentation of comment-lines after the first one, with respect
    to the containing block.
 beta-if-indent-level
    Indentation of lines within an \(if-block except lines starting
    with // or else.
 beta-else-indent-level
   Indentation of else-lines in if-blocks with respect to containing
   if block.
 beta-for-indent-level
    Indentation of lines within a for-block.
 beta-block-indent-level
    Extra indentation of a new block.
 beta-evaluation-indent-level
    Extra indentation of a line beginning with ->.
 beta-combined-indent
    If non-nil, multiple closing constructors  on the same line
    (e.g. if)for)#) ) will be indented relative to the opening constructor 
    corresponding to the *last* closing constructor

Invoking beta-mode:
===================

Add the following to your .emacs file to automatically go into beta-mode when
the name of the buffer ends in \".bet\"

(setq betalib (getenv \"BETALIB\"))
(if (not betalib) (setq betalib \"/usr/local/lib/beta\"))
;; or if you are on a PC, e.g.: 
;; (if (not betalib) (setq betalib \"c:\\\\beta\"))

(setq load-path (append load-path 
			(list (format \"%s/emacs\" betalib))))

(autoload 'gbeta-mode \"gbeta-mode\")
(setq auto-mode-alist (append (list (cons \"\\\\.gb$\" 'gbeta-mode))
                               auto-mode-alist))

gbeta-mode-hook:
================

Turning on gbeta-mode calls the value of the variable gbeta-mode-hook with no
args, if that value is non-nil. For instance, adding the following in your
.emacs file will bind some of the often used functions in beta-mode to
key-sequences prefixed by C-xC-r:

 (defun mygbeta ()
   \"Make the following local bindings in gbeta-mode:
C-xC-rj calls beta-comment-justify
C-xC-rr calls beta-comment-justify-region
C-xC-rc calls beta-convert-region-to-comment
C-xC-ru calls beta-remove-comment
C-xC-ri calls indent-buffer.\"
   (interactive)
   (local-unset-key \"\\C-x\\C-r\")
   (local-set-key \"\\C-x\\C-rj\" 'beta-comment-justify)
   (local-set-key \"\\C-x\\C-rr\" 'beta-comment-justify-region)
   (local-set-key \"\\C-x\\C-rc\" 'beta-convert-region-to-comment)
   (local-set-key \"\\C-x\\C-ru\" 'beta-remove-comment)
   (local-set-key \"\\C-x\\C-ri\" 'indent-buffer))

 (setq gbeta-mode-hook 'mygbeta) " 

  (interactive)
  (kill-all-local-variables)
  (use-local-map beta-mode-map)
  (setq major-mode 'beta-mode)
  (setq mode-name "gbeta")
  (setq local-abbrev-table beta-mode-abbrev-table)
  (set-syntax-table beta-mode-syntax-table)
  (make-local-variable 'beta-mode-version)
  (setq beta-mode-version "1.1")
  (make-local-variable 'paragraph-start)
  (setq paragraph-start (concat "^$\\|" page-delimiter))
  (make-local-variable 'paragraph-separate)
  (setq paragraph-separate paragraph-start)
  (make-local-variable 'paragraph-ignore-fill-prefix)
  (setq paragraph-ignore-fill-prefix t)
  (make-local-variable 'indent-line-function)
  (setq indent-line-function 'beta-indent-line)
  (make-local-variable 'require-final-newline)
  (setq require-final-newline t)
  (make-local-variable 'comment-start)
  (setq comment-start "(* ")
  (make-local-variable 'comment-end)
  (setq comment-end " *)")
  (make-local-variable 'comment-column)
  (setq comment-column 40)
  (make-local-variable 'comment-start-skip)
  (setq comment-start-skip "\(\\*+ *" )
  (make-local-variable 'beta-construct-start)
  (setq beta-construct-start 
    "\\(\(if\\b\\|\(for\\b\\|\(while\\b\\|\(when\\b\\|\(#\\)")
  (make-local-variable 'beta-construct-end)
  (setq beta-construct-end 
    "\\(\\bif\)\\|\\bfor\)\\|\\bwhile\)\\|\\bwhen\)\\|#\)\\)")
  (make-local-variable 'beta-construct-delimiters)
  ;; this should be both beta-construct-start and beta-construct-end
  (setq beta-construct-delimiters 
   (concat
    "\\(\(if\\b\\|\(for\\b\\|\(while\\b\\|\(when\\b\\|\(#"
    "\\|"
    "\\bif\)\\|\\bfor\)\\|\\bwhile\)\\|\\bwhen\)\\|#\)\\)"
    "\\|"
    "\\(^\-\-\\)"))
  (make-local-variable 'beta-separator)
  (setq beta-separator 
   "\\(\\bdo\\b\\|\\benter\\b\\|\\bexit\\b\\|//\\|\\belse\\b\\|\\brepeat\\b\\)")
  (make-local-variable 'comment-indent-function)
  (setq comment-indent-function 'beta-comment-indent)
  (make-local-variable 'parse-sexp-ignore-comments)
  (setq parse-sexp-ignore-comments nil)
  (run-hooks 'gbeta-mode-hook))

