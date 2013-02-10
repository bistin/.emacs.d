(require 'ublt-util)

;;; My Dvorak key map for Dvorak. Keys are extensively remapped and
;;; translated.
;;   ' , . p y    f g c r l   / = \
;;   a o e u i    d h t n s   -
;;   ; q j k x    b m w v z

;;; TODO: remap


;; TODO: Make it a macro so that indentation can be customized.
;; Helper to define keys
(defun ublt/define-keys (key-map &rest ps)
  "Define key binding pairs for KEY-MAP."
  (let ((i 0))
    (while (< i (length ps))
      (if (= (mod i 2) 0)
          (let ((src (elt ps i))
                (dst (elt ps (1+ i))))
            (define-key key-map
              (read-kbd-macro src) (if (stringp dst)
                                       (read-kbd-macro dst)
                                     dst))))
      (setq i (+ i 2)))))


;;; Custom global bindings -------------------------------------------
;; TODO:
;; M-f
;; M-y
;; M-o
;; M-a
;; M-j
;; M-k
;; M-z
;; M-1 ... M-0
;; M-` M-'
;; M-= M-\

;;; Keys shadowed by translation:
;; "M-h"     'mark-paragraph
;; "M-c"     'capitalize-word
;; "M-t"     'transpose-words
;; "M-i"     'tab-to-tab-stop
;; "M-d"     'kill-word
;; "M-e"     'forward-sentence
;; "M-u"     'upcase-word
;; "M-v"     'scroll-up
;; "C-M-n"   'forward-list
;; "C-M-c"   'exit-recursive-edit
;; "C-M-t"   'transpose-sexps

;;; Keys shadowed by rebinding:
;; "C-M-r"    something with isearch backward repeat regexp
;; "s-h"     'ns-do-hide-emacs
;; "M-g g"   'goto-line
;; "M-g n"   'next-error
;; "M-g p"   'previous-error
;; "M-r"     'move-to-window-line-top-bottom 'paredit-raise-sexp
;; "M-l"     'downcase-word

;;; These are translated so that they can be pervasive, as most modes
;;; rebind them (syntactically override), instead of remapping the
;;; original command (semantically override).
(ublt/define-keys
 key-translation-map
 ;; OSX goodness
 ;; TODO: Use sth like s-t instead of s-x, since s-x is not convenient
 ;; for Dvorak
 "s-c"    "M-w"                         ; copy
 "s-x"    "C-w"                         ; cut
 "s-v"    "C-y"                         ; paste
 "s-V"    "M-y"                         ; paste cycle
 "s-s"    "C-x C-s"                     ; save
 "s-S"    "C-x s"                       ; save some buffers
 "s-z"    "C-_"                         ; undo
 "s-Z"    "M-_"                         ; redo
 "s-a"    "C-x h"                       ; mark all

 "s-C"    'ublt/duplicate-line

 ;; Movement keys (right hand)
 "M-c"    "<up>"
 "M-t"    "<down>"
 "M-h"    "<left>"
 "M-n"    "<right>"
 "M-C"    "<prior>"                     ; scroll
 "M-T"    "<next>"                      ; scroll
 "M-H"    "C-<up>"                      ; -> paragraph
 "M-N"    "C-<down>"                    ; <- paragraph
 "M-g"    "C-<left>"                    ; <- word
 "M-r"    "C-<right>"                   ; -> word
 "M-G"    "M-<"                         ; beginning
 "M-R"    "M->"                         ; end

 ;; Deletion (left hand)
 "M-e"    "DEL"
 "M-u"    "<kp-delete>"
 "M-."    "M-DEL"
 "M-p"    "M-<kp-delete>"

 "M-i"    "C-k"
 "M-d"    "C-a"
 "M-D"    "C-e"

 ;; Nut!!! But seriously much more effective
 "M-SPC"  "C-SPC"
 "C-SPC"  "M-SPC"
 ;; More obsession, but C-t is actually unavailable this way
 ;; though. And another problem is that C-x is a prefix that's kinda
 ;; mnemonic. So it's not used until I find a workaround
 ;; "C-t" "C-x"
 ;; "C-x" "C-t"

 "C-M-h"  "M-<left>"                    ; -> list (except for org-mode)
 "C-M-n"  "M-<right>"                   ; <- list (except for org-mode)
 "C-M-c"  "M-<up>"                      ; <- paredit splice-kill, org up
 "C-M-t"  "M-<down>"                    ; -> paredit splice-kill, org down

 "M-M"    "C-M-u"                       ; <- up list
 "M-V"    "C-M-d"                       ; -> down list

 "M-m"    "M-p"                         ; <- special (history, errors)
 "M-v"    "M-n"                         ; -> special (history, errors)

 "s-t"    "M-."                         ; push reference
 "s-T"    "M-,"                         ; pop reference

 "s-4"    "C-x 4"

 "M-f"    "<escape>"                    ; use evil-mode
 )

(ublt/define-keys
 global-map
 ;; OSX goodness
 "s-u"           'revert-buffer
 "s-k"           'kill-this-buffer
 "s-l"           'goto-line

 ;; Line/region movement
 "M-s-h"         'textmate-shift-left
 "M-s-n"         'textmate-shift-right
 "M-s-c"         'ublt/move-text-up
 "M-s-t"         'ublt/move-text-down
 "M-s-˙"         'textmate-shift-left   ; OS X
 "M-s-˜"         'textmate-shift-right  ; OS X
 "M-s-ç"         'ublt/move-text-up     ; OS X
 "M-s-†"         'ublt/move-text-down   ; OS X

 ;; Windows manipulation
 "s-1"           'delete-other-windows
 "s-2"           'split-window-vertically
 "s-3"           'split-window-horizontally
 "s-0"           'delete-window
 "s-w"           'other-window
 "s-W"           'ublt/swap-windows

 ;; Utilities, super-
 "s-d"           'helm-command-prefix
 "s-D"           'eproject-ido-imenu
 "s-f"           'helm-occur
 "s-F"           'helm-do-grep
 "s-g"           'magit-status
 "s-G"           'find-grep
 "s-m"           'ace-jump-mode
 "s-M"           'ace-jump-char-mode
 "s-r"           'org-remember
 "s-R"           'org-agenda

 "s-h"           'ido-switch-buffer
 "s-n"           'ublt/switch-to-last-buffer
 "s-b"           'ublt/browse-url-at-point
 "s-p"           'pop-global-mark
 "s-<backspace>" 'ublt/toggle-alpha
 "s-<return>"    'ublt/toggle-fullscreen
 "s-/"           'find-file-in-project
 "s-\\"          'align-regexp

 ;; These should be translated
 "s-["           'backward-page   "s-]" 'forward-page

 "C-M-r"         'highlight-symbol-next
 "C-M-g"         'highlight-symbol-prev

 ;; Deletion
 "<kp-delete>"   'delete-char
 "M-<kp-delete>" 'kill-word
 ;; "M-I"           'kill-whole-line

 "M-I"           'whole-line-or-region-kill-region
 ;; Zooming in/out (consistent with other Mac apps)
 "s-+"           'text-scale-increase
 "s-="           'text-scale-increase
 "C-="           'text-scale-increase
 "s--"           'text-scale-decrease

 ;; Toggling
 "<f9> l"        'global-linum-mode
 "<f9> <f9>"     'ublt/toggle-fonts
 "<f9> <f12>"    'ublt/toggle-line-wrap

 ;; ido-mode
 "C-x C-d"       'ido-dired
 "C-x d"         'ido-list-directory
 "C-x C-i"       'ido-imenu

 ;; Ubuntu
 "M-<f4>"        'kmacro-start-macro-or-insert-counter ; F3 is taken by xbindkeys
 "C-<f9>"        'ibus-toggle

 ;; Right, use C-u if you want digit args
 "M-5"           'query-replace
 "M-%"           'query-replace-regexp
 "M-6"           'ublt/toggle-letter-case
 "M-7"           'ublt/toggle-cua-rect
 "M-8"           'ublt/cycle-prose-region
 "M-9"           'mark-enclosing-sexp
 "M-0"           'ublt/cycle-code-region

 ;; TODO: more pervasive
 "C-a"           'ublt/back-to-indentation-or-line-beginning

 ;; Misc
 "C-c C-x C-o"   'org-clock-out
 "M-l"           'move-to-window-line-top-bottom
 "M-b"           'hippie-expand         ; more convenient here
 "M-B"           'yas-expand
 "C-z"           nil                    ; who needs suspend-frame?
 "C-x C-h"       nil                    ; bad emacs-starter-kit
 "S-s-SPC"       'whitespace-mode
 ;; "M-x"           'helm-M-x          ; C-x C-m for the original
 "M-X"           'smex-major-mode-commands
 "C-h C-a"       'apropos-command
 ;; "C-x C-b"       'ido-switch-buffer     ; Because it's to easy to mis-press
 "C-x C-b"       'ublt/helm        ; Because it's to easy to mis-press
 "C-x b"         'ublt/helm
 "C-x B"         'ibuffer
 "C-S-s"         'ublt/isearch-other-window

 "M-<left>"      'backward-list
 "M-<right>"     'forward-list

 ;; XXX: Multimedia keys
 "<XF86Forward>" 'emms-next
 "<XF86Back>"    'emms-previous
 "<XF86Reload>"  'emms-pause

 "M-TAB"         'auto-complete        ; Don't use completion-at-point
 )


;;; Help
(eval-after-load "help-mode"
  '(ublt/define-keys
    help-mode-map
    "M-s-h" 'help-go-back
    "M-s-n" 'help-go-forward
    "C-f"   'help-follow-symbol))


;;; Evil -------------------------------------------------------------
;;; TODO: Swap WORD & word
(eval-after-load "evil"
  '(progn
     (ublt/define-keys
      evil-normal-state-map
      ;; Preparation for motion map
      "h" nil "H" nil
      "n" nil "N" nil
      "c" nil "C" nil
      "t" nil "T" nil
      "g" nil "G" nil
      "r" nil "R" nil
      "l" nil "L" nil

      ;; (c)hange => (j)ab
      "j"        'evil-change
      "J"        'evil-change-line

      "U"        'undo-tree-redo

      "C-r"      nil
      "M-."      nil ; evil-repeat-pop-next
      "<escape>" 'evil-force-normal-state

      ;; (r)eplace => (b)
      "b"        'evil-replace
      "B"        'evil-replace-state

      ;; g => e
      "e"  nil
      "e&"       'evil-ex-repeat-global-substitute
      "e8"       'what-cursor-position
      "ea"       'what-cursor-position
      "ei"       'evil-insert-resume
      "eJ"       'evil-join-whitespace
      "eq"       'evil-fill-and-move
      "ew"       'evil-fill
      "eu"       'evil-downcase
      "eU"       'evil-upcase
      "ef"       'find-file-at-point
      "eF"       'evil-find-file-at-point-with-line
      "e?"       'evil-rot13
      "e~"       'evil-invert-case
      "e;"       'goto-last-change
      "e,"       'goto-last-change-reverse

      )
     (ublt/define-keys
      evil-motion-state-map

      ;; Dvorak, positional
      "h"     'evil-backward-char
      "n"     'evil-forward-char
      "H"     'evil-window-top
      "N"     'evil-window-bottom
      ;; Dvorak, positional (line)
      "c"     'evil-previous-line
      "t"     'evil-next-line
      "C"     'evil-scroll-line-up
      "T"     'evil-scroll-line-down
      ;; Dvorak, positional (word)
      "g"     'evil-backward-word-begin
      "G"     'evil-backward-WORD-begin
      "r"     'evil-forward-word-end
      "R"     'evil-forward-WORD-end

      "SPC"   'evil-scroll-page-down
      "S-SPC" 'evil-scroll-page-up

      ;; (n)ext => (l)ook
      "l"     'evil-search-next
      "L"     'evil-search-previous
      ;; (c)hange => (j)ab
      "j"     'evil-change
      "J"     'evil-change-line
      ;; (t)o => к (Russian)
      "k"     'evil-find-char-to
      "K"     'evil-find-char-to-backward
      ;; (r)eplace => (b)
      "b"     'evil-replace
      "B"     'evil-replace-state

      ;; g => (e)vil do
      "e"     nil
      "ed"    'evil-goto-definition
      "ee"    'evil-backward-word-end
      "eE"    'evil-backward-WORD-end
      "eg"    'evil-goto-first-line
      "ej"    'evil-next-visual-line
      "ek"    'evil-previous-visual-line
      "e0"    'evil-beginning-of-visual-line
      "e_"    'evil-last-non-blank
      "e^"    'evil-first-non-blank-of-visual-line
      "e$"    'evil-end-of-visual-line
      "e\C-]" 'find-tag
      "ev"    'evil-visual-restore

      "*"     'highlight-symbol-next
      "#"     'highlight-symbol-prev

      "C-b"    nil
      "C-d"    nil
      "C-e"    nil
      "C-f"    nil
      "C-o"    nil
      "C-y"    nil
      )
     (ublt/define-keys
      evil-insert-state-map
      "<escape>" 'evil-normal-state

      "C-n" nil     ; evil-complete-next
      "C-p" nil     ; evil-complete-previous
      "C-r" nil     ; evil-paste-from-register
      "C-w" nil     ; evil-delete-backward-word
      "C-x C-n" nil ; evil-complete-next-line
      "C-x C-p" nil ; evil-complete-previous-line
      )
     (ublt/define-keys
      evil-visual-state-map
      "<escape>" 'evil-exit-visual-state
      "R" nil
      )
     (ublt/define-keys evil-replace-state-map
                       "<escape>" 'evil-normal-state)
     (ublt/define-keys evil-emacs-state-map
                       "<escape>" 'evil-normal-state)
     (ublt/define-keys
      evil-insert-state-map
      "C-k" nil
      "C-o" nil
      "C-e" nil
      "C-y" nil)
     (ublt/define-keys
      evil-outer-text-objects-map
      "d" 'evil-a-defun
      "S" 'evil-a-symbol)
     (ublt/define-keys
      evil-inner-text-objects-map
      "d" 'evil-inner-defun
      "S" 'evil-inner-symbol
      "*" 'evil-inner-symbol
      )
     (ublt/define-keys
      evil-outer-text-objects-map
      "d" 'evil-a-defun
      "S" 'evil-a-symbol
      "*" 'evil-a-symbol)))


;;; Helm
(eval-after-load "helm"
  '(ublt/define-keys
    helm-map
    "s-h"         'minibuffer-keyboard-quit
    "s-<return> " 'minibuffer-keyboard-quit
    "C-x h"       'helm-toggle-all-marks
    "C-f"         'helm-follow-mode
    ))
(eval-after-load "helm-config"
  '(ublt/define-keys
    helm-command-map
    "s-r" 'helm-emms
    "g"   'helm-google-suggest
    "l"   'helm-locate
    "p"   'helm-list-emacs-process
    "M-o" 'helm-occur
    "M-O" 'helm-multi-occur
    "o"   'helm-occur
    "O"   'helm-multi-occur
    "SPC" 'helm-global-mark-ring
    ))


;;; HTML
(eval-after-load "nxhtml-mumamo"
  '(ublt/define-keys
    nxhtml-mumamo-mode-map
    "s-<right>" 'sgml-skip-tag-forward
    "s-<left>"  'sgml-skip-tag-backward))
(eval-after-load "html-mode"
  '(ublt/define-keys
    html-mode-map
    "s-<right>" 'sgml-skip-tag-forward
    "s-<left>"  'sgml-skip-tag-backward))
(eval-after-load "nxml-mode"
  '(ublt/define-keys
    nxml-mode-map
    "s-<right>" 'sgml-skip-tag-forward
    "s-<left>"  'sgml-skip-tag-backward))


;;; auto-complete and yasnippet
(eval-after-load "auto-complete"
  '(progn
     (ublt/define-keys
      ac-complete-mode-map
      "M-n"   'ac-next
      "M-p"   'ac-previous
      "C-h"   'ac-help
      "M-TAB" 'ac-complete
      "C-SPC" 'ac-complete
      "SPC"   'ac-complete
      "TAB"   'ac-expand)
     (ublt/define-keys
      ac-mode-map
      "M-TAB" 'auto-complete)
     (ac-set-trigger-key "M-TAB" ;; "M-k"
                         )))
(eval-after-load "yasnippet"
  '(ublt/define-keys
    yas-minor-mode-map
    "TAB" nil
    "<tab>" nil
    "M-B" 'yas-expand))
(eval-after-load "slime"
  '(ublt/define-keys
    slime-mode-map
    "M-TAB"   'auto-complete))
(eval-after-load "python-mode"
  '(progn
     (ublt/define-keys py-mode-map
      "M-TAB" 'auto-complete)
     (ublt/define-keys
      py-shell-map
      "M-TAB" 'auto-complete)))


;;; Error navigation
(eval-after-load "js2-mode"
  '(progn
     (unless (functionp 'js-prev-error)
       (defun js2-prev-error (&optional arg reset)
         (interactive "p")
         (js2-next-error (- arg) reset)))
     (ublt/define-keys
      js2-mode-map
      "M-p" 'js2-prev-error
      "M-n" 'js2-next-error)))
(eval-after-load "js"
  '(ublt/define-keys
    js-mode-map
    "M-n" 'flymake-goto-next-error
    "M-p" 'flymake-goto-prev-error))
(eval-after-load "python-mode"
  '(ublt/define-keys
    py-mode-map
    "M-n" 'flymake-goto-next-error
    "M-p" 'flymake-goto-prev-error))
(eval-after-load "php-mode"
  '(ublt/define-keys
    php-mode-map
    "M-p" 'flymake-goto-prev-error
    "M-n" 'flymake-goto-next-error))
(eval-after-load "lisp-mode"
  '(ublt/define-keys
    emacs-lisp-mode-map
    "M-p" 'flymake-goto-prev-error
    "M-n" 'flymake-goto-next-error))
(eval-after-load "erlang"
  '(ublt/define-keys
    erlang-mode-map
    "M-n" 'flymake-goto-next-error
    "M-p" 'flymake-goto-prev-error))


;;; Paredit
(eval-after-load "paredit"
  '(progn
     (ublt/define-keys
      paredit-mode-map
      "{"             'paredit-open-curly
      "}"             'paredit-close-curly
      "M-("           'paredit-wrap-round
      "M-["           'paredit-wrap-square
      "M-{"           'paredit-wrap-curly
      "M-r"           nil               ; was paredit-raise-sexp
      "M-<backspace>" 'paredit-backward-kill-word
      "M-<kp-delete>" 'paredit-forward-kill-word
      "<backspace>"   'paredit-backward-delete
      "<kp-delete>"   'paredit-forward-delete
      "C-<left>"      nil
      "C-<right>"     nil
      "M-<left>"      'paredit-backward
      "M-<right>"     'paredit-forward
      ;; TODO: advice comment-dwim instead
      "M-;"           nil)
     (eval-after-load "starter-kit-lisp"
       '(ublt/define-keys
         paredit-mode-map
         "M-(" 'paredit-wrap-round
         "M-)" 'paredit-forward-slurp-sexp))
     (eval-after-load "starter-kit-lisp-autoloads"
       '(ublt/define-keys
         paredit-mode-map
         "M-(" 'paredit-wrap-round
         "M-)" 'paredit-forward-slurp-sexp))))
;;; XXX starter-kit

(eval-after-load "python-mode"
  '(ublt/define-keys
    py-mode-map
    "{"       'paredit-open-curly
    "}"       'paredit-close-curly))
(eval-after-load "js2-mode"
  '(ublt/define-keys
    js2-mode-map
    "{"   'paredit-open-curly
    "}"   'paredit-close-curly-and-newline))


;;; Languages with interactive REPL
;;; TODO: sql, ruby, factor, haskell, octave
;;; For mode with a REPL: lisps, python, js (c r l are adjacent on Dvorak!!!):
;; C-c C-c                                 ; eval defun
;; C-c C-r                                 ; eval region
;; C-c C-l                                 ; eval buffer
;; C-c v                                   ; eval buffer
;; C-c C-s                                 ; go to REPL
;;; TODO:
;; C-M-x

;;; Talking about bad defaults!!! (These are like 100 times better)
(eval-after-load "comint"
  '(ublt/define-keys
    comint-mode-map
    "M-p" 'comint-previous-matching-input-from-input
    "M-n" 'comint-next-matching-input-from-input))

(eval-after-load "lisp-mode"
  '(progn
     (ublt/define-keys
      emacs-lisp-mode-map
      "C-c C-c" 'eval-defun
      "C-c C-r" 'eval-region
      "C-c C-l" 'eval-buffer
      "C-c C-s" 'ielm)
     (ublt/define-keys
      lisp-mode-map
      "C-c C-s" 'switch-to-lisp)
     (ublt/define-keys
      lisp-interaction-mode-map
      "C-c C-c" 'eval-defun
      "C-c C-r" 'eval-region
      "C-c C-l" 'eval-buffer
      "C-c C-s" 'ielm)))
(eval-after-load "clojure-mode"
  '(ublt/define-keys
    clojure-mode-map
    "C-c C-s" 'run-lisp))
(eval-after-load "slime"
  '(ublt/define-keys
    slime-mode-map
    "C-c C-l" 'slime-compile-and-load-file
    "C-c C-k" 'slime-load-file
    "C-c v"   'slime-load-file
    "C-c C-s" 'slime-switch-to-output-buffer))
(eval-after-load "factor-mode"
  '(progn
     (ublt/define-keys
      factor-mode-map
      "C-c C-c" 'fuel-eval-definition
      "C-c C-s" 'run-factor)
     (ublt/define-keys
      fuel-mode-map
      "C-c C-c" 'fuel-eval-definition
      "C-c C-s" 'run-factor)))
(eval-after-load "octave-mode"
  '(ublt/define-keys
    octave-mode-map
    "C-c C-c" 'octave-send-defun
    "C-c C-r" 'octave-send-region
    "C-c C-s" 'octave-show-process-buffer))
(eval-after-load "python-mode"
  '(ublt/define-keys
    py-mode-map
    "C-c C-c" 'py-execute-def-or-class  ; was py-execute-buffer
    "C-c C-r" 'py-execute-region        ; was py-shift-region-right
    "C-c C-l" 'py-execute-buffer        ; was py-shift-region-left
    "C-c C-s" 'py-shell                 ; was py-execute-string
    "C-c v"   'py-execute-buffer))
(eval-after-load "sql"
  '(ublt/define-keys
    sql-mode-map
    "C-c C-s" 'sql-product-interactive  ; was sql-send-string
    ))
;;; XXX: Why doesn't this work???
;; (eval-after-load "erlang"
;;   (add-hook 'erlang-mode-hook
;;             (lambda ()
;;               (ublt/define-keys
;;                erlang-mode-map
;;                "C-c v"   'erlang-compile
;;                "C-c C-l" 'ublt/erlang-compile-and-display ; was erlang-compile-display
;;                "C-c C-s" 'erlang-shell-display ; was erlang-show-syntactic-information
;;                ))))
(eval-after-load "erlang"
  '(ublt/define-keys
    erlang-mode-map
    "C-c C-l" 'ublt/erlang-compile-and-display ; was erlang-compile-display
    "C-c C-s" 'erlang-shell-display ; was erlang-show-syntactic-information
    "C-c v"   'erlang-compile))


;;; Other bindings specific to language modes
(eval-after-load "python-mode"
  '(progn
     (ublt/define-keys
      py-mode-map
      "M-." 'pylookup-lookup
      "C-c h" 'pylookup-lookup
      "'"     'skeleton-pair-insert-maybe)
     (ublt/define-keys
      py-shell-map
      "C-c h" 'pylookup-lookup
      "s-t" 'pylookup-lookup)))

(eval-after-load "slime-repl"
  '(ublt/define-keys
    slime-repl-mode-map
    "M-I" 'slime-repl-delete-from-input-history
    "M-TAB" 'auto-complete
    "DEL" nil
    "M-s" nil
    "C-c p" 'slime-repl-set-package
    "C-c n" 'slime-repl-set-package))


;;; Misc

(eval-after-load "isearch"
  '(ublt/define-keys
    isearch-mode-map
    "M-o"        'isearch-occur
    "M-z"        'ublt/zap-to-isearch
    "C-<return>" 'ublt/isearch-exit-other-end
    "C-M-w"      'ublt/isearch-yank-symbol))

(eval-after-load "dired"
  '(ublt/define-keys
    dired-mode-map
    "M-RET"      'ublt/dired-open-native
    ;; It makes more sense to search in filenames by default
    "C-s"        'dired-isearch-filenames-regexp
    "C-S-s"      'isearch-forward-regexp
    "C-M-s"      'dired-isearch-filenames
    "C-M-S-s"    'isearch-forward
    "M-l"        'move-to-window-line-top-bottom
    "C-c C-c"    'dired-toggle-read-only))

(eval-after-load "magit"
  '(progn
     (ublt/define-keys
      magit-mode-map
      "S-SPC" 'magit-show-item-or-scroll-down
      )
     (ublt/define-keys
      magit-log-edit-mode-map
      "s-s"     'magit-log-edit-commit
      "C-x C-s" 'magit-log-edit-commit)))

(eval-after-load "ido"
  '(add-hook 'ido-setup-hook
             (lambda ()
               (ublt/define-keys
                ido-completion-map
                "<tab>"  'ido-complete
                "<down>" 'ido-next-match
                "<up>"   'ido-prev-match))))

(eval-after-load "info"
  '(ublt/define-keys
    Info-mode-map
    "<kp-delete>" 'Info-scroll-up
    "S-SPC"       'Info-scroll-down))

(eval-after-load "woman"
  '(ublt/define-keys
    woman-mode-map
    "<kp-delete>" 'scroll-up
    "S-SPC"       'scroll-down))

;;; XXX: Why not working?
(eval-after-load "twittering-mode"
  '(ublt/define-keys
    twittering-mode-map
    "S-SPC" 'twittering-scroll-down))
(eval-after-load "ess-mode"
  '(ublt/define-keys
    ess-mode-map
    ;; NTA XXX: Their "yank" variation is not as good
    "C-y" nil))

(provide 'ublt-dvorak)
