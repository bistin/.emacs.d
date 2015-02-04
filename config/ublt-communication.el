(require 'ublt-util)


;;; Twitter
(ublt/set-up 'twittering-mode
  (twittering-icon-mode +1)

  (defgroup ubolonton nil ""
    :group 'personal)

  (defface ublt-twitter-meta-face
    '((t (:inherit font-lock-comment-face)))
    "Twitter face for important text")
  (setq twittering-status-format
        "%i %s,  %FACE[ublt-twitter-meta-face]{%@  from %f%L%r%R}\n\t%t"
        twittering-url-show-status nil
        twittering-timer-interval 600
        twittering-use-master-password t
        twittering-use-icon-storage t
        twittering-display-remaining t
        twittering-number-of-tweets-on-retrieval 100
        )
  (add-hook 'twittering-mode-hook (ublt/on-fn 'hl-line-mode))
  (add-hook 'twittering-edit-mode-hook (ublt/off-fn 'auto-fill-mode))
  (add-hook 'twittering-edit-mode-hook (ublt/on-fn 'visual-line-mode))

  ;; Notifications
  ;; `http://www.emacswiki.org/emacs/TwitteringMode'
  (when window-system (require 'todochiku)
        (defun ublt/notify-tweets ()
          (let ((n twittering-new-tweets-count)
                (todochiku-timeout 2))
            (if (> n 10)
                (todochiku-message
                 (twittering-timeline-spec-to-string twittering-new-tweets-spec)
                 (format "You have %d new tweet%s"
                         n (if (> n 1) "s" ""))
                 (todochiku-icon 'social))
              (dolist (el twittering-new-tweets-statuses)
                (todochiku-message
                 (twittering-timeline-spec-to-string twittering-new-tweets-spec)
                 (concat (cdr (assoc 'user-screen-name el))
                         " said: "
                         (cdr (assoc 'text el)))
                 (todochiku-icon 'social))))))
        (add-hook 'twittering-new-tweets-hook 'ublt/notify-tweets)))

;;; ERC

(ublt/set-up 'erc
  (setq erc-autojoin-channels-alist
        '(("freenode.net" "#emacs" "#conkeror" "#clojure" "#concatenative" "#reactjs"))

        erc-server "irc.freenode.net"
        erc-port 6667
        erc-nick "ubolonton"
        erc-try-new-nick-p nil

        erc-hide-list '("JOIN" "PART" "QUIT" "NICK")
        erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
                                  "324" "329" "332" "333" "353" "477")

        erc-auto-query 'buffer

        erc-log-channels-directory "~/erc_logs/"
        erc-save-buffer-on-part t
        erc-save-queries-on-quit t
        erc-log-write-after-send t
        erc-log-write-after-insert t)
  (defun ublt/erc ()
    (interactive)
    (erc :server "irc.freenode.net" :port 6667 :nick "ubolonton"
         :password (read-passwd "Password on freenode: "))))

;;; scpaste
(ublt/set-up 'scpaste
  (setq scpaste-scp-destination "ubolonton@ubolonton.org:/home/ubolonton/paste"
        scpaste-http-destination "https://ubolonton.org/paste"
        scpaste-footer (concat "<p style='font-size: 12pt;'>Generated by "
                               user-full-name
                               " using <a href='https://p.hagelb.org'>scpaste</a> at %s. "
                               (cadr (current-time-zone)) ". (<a href='%s'>original</a>)</p>")))


(provide 'ublt-communication)
