;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                                ;;;
;;;         Using emacs for GBETA single-stepping feedback         ;;;
;;;                  no restrictions, no warranty                  ;;;
;;;                                                           /EE  ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'gud)

;; ======================================================================
;;      Taken from 'gud.el' in the standard GNU emacs distribution:
;; ======================================================================
;;
;; All debugger-specific information is collected here.
;; Here's how it works, in case you ever need to add a debugger to the mode.
;;
;; Each entry must define the following at startup:
;;
;;<name>
;; comint-prompt-regexp
;; gud-<name>-massage-args
;; gud-<name>-marker-filter
;; gud-<name>-find-file
;;
;; The job of the massage-args method is to modify the given list of
;; debugger arguments before running the debugger.
;;
;; The job of the marker-filter method is to detect file/line markers in
;; strings and set the global gud-last-frame to indicate what display
;; action (if any) should be triggered by the marker.  Note that only
;; whatever the method *returns* is displayed in the buffer; thus, you
;; can filter the debugger's output, interpreting some and passing on
;; the rest.
;;
;; The job of the find-file method is to visit and return the buffer indicated
;; by the car of gud-tag-frame.  This may be a file name, a tag name, or
;; something else.  It would be good if it also copied the Gud menubar entry.
;;
;; ======================================================================

(defvar gbeta-binary "gbeta")

(defvar gud-gbeta-marker-regexp 
  "\032\032\\([^:]*\\):\\([0-9]*\\):\\([0-9]*\\):.*\n")

(defun gbeta-getmatch (number offset)
  (interactive)
  (if (match-beginning number)
      (buffer-substring 
       (+ (match-beginning number) offset) 
       (match-end number))
    nil))

(defun gbeta-display-source (arg)
  (interactive "e")
  (mouse-set-point arg)
  (progn
    (while (and (> (point) 1) (looking-at "[^`]")) 
      (goto-char (- (point) 1)))
    (if (or (looking-at "`\\([^ \t:]+\\):\\([0-9]+\\)\\(-[0-9]+\\)?")
	    (looking-at "`\\(\\)\\([0-9]+\\)\\(-[0-9]+\\)?"))
	(progn
	  (let ((spec (gbeta-getmatch 0 0)) 
		(filename (or (gbeta-getmatch 1 0) ""))
		(frompos (string-to-int (gbeta-getmatch 2 0)))
		(topos (string-to-int (gbeta-getmatch 3 1))))

	  ; using gbeta we can just do this:
	  ;   (gud-call (concat "display " spec) arg)
	  ; but we want to be able to look up source code things 
          ; even if the gbeta subprocess is dead:
	    (gud-display-line filename (cons frompos topos))))
      (message (concat "No source code position spec here! "
		       "(\"`[<group>:]<charpos>[-<charpos>]\" expected)")))))

;;;###autoload
(defun gbeta (command-line)
  "Run gbeta on program FILE in buffer *gud-FILE*.
The directory containing FILE becomes the initial working directory
and source-file directory for your debugger."
  (interactive
   (list (read-from-minibuffer 
	  "Run gbeta (like this): "
	  (let ((fname (buffer-name (current-buffer))))
	    (if (string-match "\*gud-.*\\.\\(bet\\|gb\\)\*" fname)
		(concat gbeta-binary " " (substring fname 5 -1))
	      (if (string-match ".*\\.\\(bet\\|gb\\)$" fname)
		  (concat gbeta-binary " " fname)
		(if (consp gud-gbeta-history)
		    (car gud-gbeta-history)
		  (concat gbeta-binary " ")))))
	  gdb-minibuffer-local-map nil
	  '(gud-gbeta-history . 1))))
  
  (gud-common-init command-line 'gud-gbeta-massage-args
                   'gud-gbeta-marker-filter 'gud-gbeta-find-file)

  (gud-def gud-break     "break %f:%l" "\C-b" "set Breakpoint.")
  (gud-def gud-abreak    "abreak %f:%l" "\C-a" "set breakpoint After.")
  (gud-def gud-tbreak    "tbreak %f:%l" "\C-t" "set Temporary breakpoint.")
  (gud-def gud-tabreak   "tabreak %f:%l" "\C-m" "set teMp. breakpoint after.")
  (gud-def gud-remove    "unbreak %f:%l" "\C-d" "Delete breakpoint.")
  (gud-def gud-step      "step %p" "\C-s" "Step one source line.")
  (gud-def gud-next      "next %p" "\C-n" "step to Next line.")
  (gud-def gud-cont      "go" "\C-o" "gO (continue).")
  (gud-def gud-finish    "finish" "\C-f" "Finish executing current object.")
  (gud-def gud-restart   "kill all" "\C-e" "kill all threads (End).")
  (gud-def gud-type      "type %f:%l" "\C-p" "show tyPe.")
  (gud-def gud-substance "substance %f:%l" "\C-u" "show sUbstance.")
  (gud-def gud-exittype  "exittype %f:%l" "\C-x" "show eXit-type.")
  (gud-def gud-entertype "entertype %f:%l" "\C-r" "show enteR-type.")
  (gud-def gud-decl      "declaration %f:%l" "\C-l" "show decLaration.")
  (gud-def gud-print     "print %e" "\C-p" "Evaluate expression at point.")
  (gud-def gud-bytecode  "bytecode %f:%l" "\C-y" "print bYtecode at point.")

  (local-set-key [menu-bar debug bytecode] '("Bytecode" . gud-bytecode))
  (local-set-key [menu-bar debug print] '("Print" . gud-print))
  (local-set-key [menu-bar debug decl] '("Declaration" . gud-decl))
  (local-set-key [menu-bar debug entertype] '("Enter-type" . gud-entertype))
  (local-set-key [menu-bar debug exittype] '("Exit-type" . gud-exittype))
  (local-set-key [menu-bar debug substance] '("Substance" . gud-substance))
  (local-set-key [menu-bar debug type] '("Type" . gud-type))
  (local-set-key [menu-bar debug restart] '("Restart" . gud-restart))
  (local-set-key [menu-bar debug finish] '("Finish Object" . gud-finish))
  (local-set-key [menu-bar debug continue] '("Continue" . gud-cont))
  (local-set-key [menu-bar debug next] '("Next" . gud-next))
  (local-set-key [menu-bar debug step] '("Step" . gud-step))
  (local-set-key [menu-bar debug unbreak] '("Remove Breakpoint" . gud-remove))
  (local-set-key [menu-bar debug tabreak] '("Tmp. Brk. After" . gud-tabreak))
  (local-set-key [menu-bar debug tbreak] '("Temp. Breakpoint" . gud-tbreak))
  (local-set-key [menu-bar debug abreak] '("Breakpoint After" . gud-abreak))
  (local-set-key [menu-bar debug break] '("Breakpoint" . gud-break))

  (local-set-key [double-down-mouse-1] 'gbeta-display-source)

  (setq comint-prompt-regexp "^\\(executing\\|analyzing\\|terminated\\)> ")
  (setq paragraph-start comint-prompt-regexp)
  (run-hooks 'gbeta-mode-hook))

;;; History of argument lists passed to gbeta.
(defvar gud-gbeta-history nil)

(defun gud-gbeta-massage-args (file args)
 (interactive)
 (cons "-picn" args))

(defun gud-gbeta-marker-filter (string)
  (setq gud-marker-acc (concat gud-marker-acc string))
  (let ((output ""))

    ;; Process all the complete markers in this chunk.
    (while (string-match gud-gbeta-marker-regexp gud-marker-acc)
      (setq

       ;; Extract the frame position from the marker.
       gud-last-frame
       (cons (substring gud-marker-acc (match-beginning 1) (match-end 1))
             (cons (string-to-int (substring gud-marker-acc
					     (match-beginning 2)
					     (match-end 2)))
		   (string-to-int (substring gud-marker-acc
					     (match-beginning 3)
					     (match-end 3)))))

       ;; Append any text before the marker to the output we're going
       ;; to return - we don't include the marker in this text.
       output (concat output
                      (substring gud-marker-acc 0 (match-beginning 0)))

       ;; Set the accumulator to the remaining text.
       gud-marker-acc (substring gud-marker-acc (match-end 0))))

    ;; Does the remaining text look like it might end with the
    ;; beginning of another marker?  If it does, then keep it in
    ;; gud-marker-acc until we receive the rest of it.  Since we
    ;; know the full marker regexp above failed, it's pretty simple to
    ;; test for marker starts.
    (if (string-match "\032.*\\'" gud-marker-acc)
        (progn
          ;; Everything before the potential marker start can be output.
          (setq output (concat output (substring gud-marker-acc
                                                 0 (match-beginning 0))))

          ;; Everything after, we save, to combine with later input.
          (setq gud-marker-acc
                (substring gud-marker-acc (match-beginning 0))))

      (setq output (concat output gud-marker-acc)
            gud-marker-acc ""))

    output))

(defun gud-gbeta-find-decl (arg)
  (interactive "e")
  (mouse-set-point arg)
  (gud-decl arg)
  (pop-to-buffer gud-comint-buffer))

(defun gud-gbeta-find-file (f)
  (save-excursion
    (let ((buf (find-file-noselect f)))
      (set-buffer buf)
      (gud-make-debug-menu)
      (local-set-key [menu-bar debug bytecode]
		     '("Bytecode" . gud-bytecode))
      (local-set-key [menu-bar debug print]
		     '("Print expression" . gud-print))
      (local-set-key [menu-bar debug decl] 
		     '("Show Declaration" . gud-decl))
      (local-set-key [menu-bar debug exittype] 
		     '("Show Exit-type" . gud-exittype))
      (local-set-key [menu-bar debug entertype] 
		     '("Show Enter-type" . gud-entertype))
      (local-set-key [menu-bar debug substance] 
		     '("Show Substance" . gud-substance))
      (local-set-key [menu-bar debug type] 
		     '("Show Type" . gud-type))
      (local-set-key [menu-bar debug finish] 
		     '("Finish Object" . gud-finish))
      (local-set-key [menu-bar debug unbreak] 
		     '("Delete Breakpoint" . gud-remove))
      (local-set-key [menu-bar debug tabreak] 
		     '("Temporary Breakpoint After" . gud-tabreak))
      (local-set-key [menu-bar debug tbreak] 
		     '("Temporary Breakpoint" . gud-tbreak))
      (local-set-key [menu-bar debug abreak] 
		     '("Breakpoint After" . gud-abreak))
      (local-set-key [menu-bar debug break] 
		     '("Breakpoint" . gud-break))
      (local-set-key [double-down-mouse-1] 'gud-gbeta-find-decl)
      buf)))

;; we want a goto-char version of display-line: 'line' _is_ really char-pos
(defun gud-display-line (true-file range)
  (if (equal true-file "")
      (progn
	(setq overlay-arrow-position nil)
	(if gbeta-secondary-overlay
	    (delete-overlay gbeta-secondary-overlay)))
    (let* ((last-nonmenu-event t)  ; Prevent use of dialog box for questions.
	   (buffer (gud-find-file true-file))
	   (window (display-buffer buffer))
	   (pos))
;;;    (if (equal buffer (current-buffer))
;;;     nil
;;;      (setq buffer-read-only nil))
      (save-excursion
;;;      (setq buffer-read-only t)
	(set-buffer buffer)
	(save-restriction
	  (widen)
	  (if (and (= 0 (car range)) (= 0 (cdr range)))
	      ;; remove markers
	      (progn
		;; delete secondary selection
		(if gbeta-secondary-overlay
		    (delete-overlay gbeta-secondary-overlay))
		(setq pos 0)
		(setq overlay-arrow-string ""))
	    ;; else: set up selection to show the exact statement
	    (gbeta-set-secondary (car range) (+ 1 (cdr range)))
	    ;; now add the conventional arrow at the beginning of the line
	    (goto-char (car range))
	    (beginning-of-line 1)
	    (setq pos (point))
	    (setq overlay-arrow-string "=>")
	    (or overlay-arrow-position
		(setq overlay-arrow-position (make-marker)))
	    (set-marker overlay-arrow-position (point) (current-buffer))))
	(cond ((or (< pos (point-min)) (> pos (point-max)))
	       (widen)
	       (goto-char pos))))
      (if overlay-arrow-position
	  (set-window-point window overlay-arrow-position)))))


;; we also need to adjust gud-format-command
;; to give us char-pos in stead of line-number
(defun gud-format-command (str arg)
  (let ((insource (not (eq (current-buffer) gud-comint-buffer)))
	(frame (or gud-last-frame gud-last-last-frame))
	result)
    (while (and str (string-match "\\([^%]*\\)%\\([adeflp]\\)" str))
      (let ((key (string-to-char (substring str (match-beginning 2))))
	    subst)
	(cond
	 ((eq key ?f)
	  (setq subst (file-name-nondirectory (if insource
						  (buffer-file-name)
						(car frame)))))
	 ((eq key ?d)
	  (setq subst (file-name-directory (if insource
					       (buffer-file-name)
					     (car frame)))))
	 ((eq key ?l)
	  (setq subst (if insource
			  (point)
			(cdr (cdr frame)))))
	 ((eq key ?e)
	  (setq subst (find-c-expr)))
	 ((eq key ?a)
	  (setq subst (gud-read-address)))
	 ((eq key ?p)
	  (setq subst (if arg (int-to-string arg) ""))))
	(setq result (concat result
			     (substring str (match-beginning 1) (match-end 1))
			     subst)))
      (setq str (substring str (match-end 2))))
    ;; There might be text left in STR when the loop ends.
    (concat result str)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;  Adjusted from mouse.el  ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; An overlay which records the current secondary selection
;; or else is deleted when there is no secondary selection.
;; May be nil.
(defvar gbeta-secondary-overlay nil)

;; A marker which records the specified first end for a secondary selection.
;; May be nil.
(defvar gbeta-secondary-start nil)

(defun gbeta-set-secondary (start end)
  "Set the gbeta secondary selection to the given range from START to END"
  (interactive)
  (save-excursion
    (if gbeta-secondary-overlay
	(delete-overlay gbeta-secondary-overlay))
    (setq gbeta-secondary-overlay (make-overlay start end))
    (overlay-put gbeta-secondary-overlay 'face 'secondary-selection)))

