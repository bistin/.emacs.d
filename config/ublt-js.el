(require 'ublt-util)

;; Javascript (it seems js-mode in Emacs is newer than espresso)
;; v8: scons via apt-get (not pip or easy_install; among other things,
;; build tool & package manager is what clojure gets absolutely right,
;; whereas python sucks ass).
;; Actually screw that, use virtualenv and easy_install scons, as
;; described here https://github.com/koansys/jshint-v8. But remember
;; to do
;;
;; export SCONS_LIB_DIR=/path/to/virtual-scons-egg/scons-sth
;;
;; scons console=readline snapshot=on library=shared d8
;;
;; Well it's still complains about missing libv8.so. Just install
;; "node" then.
;;
;;
;; (defalias 'javascript-mode 'espresso-mode)
;; (setq js-mode-hook '())
;; (setq flymake-jslint-command "jslint")

;;; TODO: Buffer-local/dir-local config for jshint

(ublt/set-up 'js2-mode
  (add-hook 'js2-mode-hook 'esk-prog-mode-hook)
  (add-hook 'js2-mode-hook 'esk-paredit-nonlisp)
  (add-hook 'js2-mode-hook 'moz-minor-mode)
  (defalias 'javascript-mode 'js2-mode)

  (setcdr (assoc "\\.js\\'" auto-mode-alist)
          'js2-mode)

  (setq js2-highlight-level 3)
  (setq-default js2-basic-offset 2))

(ublt/set-up 'js

  ;; XXX: What is this for?
  (defvar javascript-mode-syntax-table js-mode-syntax-table)

  ;; MozRepl integration
  (add-hook 'js-mode-hook 'moz-minor-mode)
  (autoload 'moz-minor-mode "moz" "Mozilla Minor and Inferior Mozilla Modes" t)

  (setq js-indent-level 2
        espresso-indent-level 2)
  (add-to-list 'auto-mode-alist '("\\.json$" . js-mode))

  ;; FIX
  (ublt/set-up 'starter-kit
    (add-hook 'js-mode-hook 'esk-paredit-nonlisp)))

;;; Syntax checking
(eval-after-load "flymake"
  '(progn
     (ublt/set-up 'flymake-jshint
       ;; FIX: Somehow this does not work now?
       (setq jshint-configuration-path "~/.jshint.json")

       (defun ublt/flymake-js-maybe-enable ()
         (when (and buffer-file-name
                    (string-match "\\.js$" buffer-file-name))
           (flymake-jshint-load)))
       (remove-hook 'js-mode-hook 'flymake-mode)
       (add-hook 'js-mode-hook 'ublt/flymake-js-maybe-enable))))


(provide 'ublt-js)
