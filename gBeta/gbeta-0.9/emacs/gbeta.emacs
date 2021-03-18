;;
;; Add this to your ~/.emacs
;;
(setq gbeta-root (getenv "GBETA_ROOT"))
(if (not gbeta-root) (setq gbeta-root "~/gbeta-0.9"))
(load-file (concat gbeta-root "/emacs/gud-gbeta.elc"))
(setq load-path (append (list (concat gbeta-root "/emacs")) load-path))

