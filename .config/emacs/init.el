(if (not (boundp 'has-restarted))
    (setq has-restarted nil)
  (setq has-restarted t))

(when (not has-restarted)
  (setq config-dir user-emacs-directory)) ;; to use for some stuff like autostart.sh for example, which I do want in my default user-emacs-directory
(setq user-emacs-directory "~/.local/share/emacs/")

(require 'package)
(setq package-user-dir (concat user-emacs-directory ".local/elpa"))
(setq package-gnupghome-dir (concat user-emacs-directory ".local/elpa/gnupg"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(add-to-list 'default-frame-alist
             '(font . "Iosevka Nerd Font Mono-15"))

(load-theme 'tango-dark t)

(global-display-line-numbers-mode 1)

(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; 1 line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time
(setq scroll-conservatively 101) ;; scroll one line at a time when moving the cursor down the page

(use-package rainbow-mode
  :ensure t
  :hook (prog-mode . (lambda () (interactive) (rainbow-mode 1))))
(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . (lambda () (interactive) (rainbow-delimiters-mode 1))))
(use-package rainbow-identifiers
  :ensure t
  :hook (prog-mode . (lambda () (interactive) (rainbow-identifiers-mode 1))))

(add-hook 'java-mode-hook 'java-ts-mode)
(add-hook 'c-mode-hook 'c-ts-mode)
(add-hook 'c++-mode-hook 'c++-ts-mode)

(global-visual-line-mode 1)

(use-package org-tempo
  :ensure nil)

(use-package org-auto-tangle
  :ensure t
  :hook (org-mode . (lambda () (interactive) (org-auto-tangle-mode 1))))

(add-hook 'org-mode-hook 'org-indent-mode)
(setq org-hide-leading-stars nil)

(use-package toc-org
  :ensure t
  :hook (org-mode . (lambda () (interactive) (toc-org-mode 1))))

(setq org-src-fontify-natively t
      org-src-tab-acts-natively t
      org-confirm-babel-evaluate nil
      org-src-window-setup 'current-window)

(setq org-agenda-files (list "~/org/agenda/schedule.org"))

(use-package vertico
  :ensure t
  :config
  (vertico-mode))

(use-package marginalia
  :ensure t
  :config
  (marginalia-mode 1))

(use-package consult
  :ensure t
  :bind ("C-s" . consult-line))

(use-package prescient
  :ensure t
  :config
  (prescient-toggle-fuzzy 1)
  (prescient-persist-mode 1))

(use-package vertico-prescient
  :ensure t
  :after vertico
  :after prescient
  :config
  (vertico-prescient-mode 1))

(add-hook 'java-ts-mode-hook #'eglot)
(add-hook 'c-ts-mode-hook #'eglot)
(add-hook 'c++-ts-mode-hook #'eglot)

(use-package magit
  :defer t
  :ensure t)

(use-package flycheck
  :defer t
  :ensure t
  :config
  (global-flycheck-mode))

(use-package projectile
  :ensure t
  :config
  (projectile-mode +1))

(use-package projectile-ripgrep
  :ensure t
  :after projectile)

(use-package consult-projectile
  :ensure t
  :after projectile
  :after consult)

(use-package aggressive-indent
  :ensure t
  :hook (emacs-lisp-mode . aggressive-indent-mode))

(use-package evil-nerd-commenter
  :ensure t
  :bind ("C-c C-/" . evilnc-comment-or-uncomment-lines))

(use-package page-break-lines
  :ensure t)

(use-package recentf
  :ensure t
  :config
  ;; remove boilerplate files from recentf list
  (add-to-list 'recentf-exclude "~/org/agenda/schedule.org")
  (add-to-list 'recentf-exclude (concat user-emacs-directory "bookmarks")))

(use-package dashboard
  :after page-break-lines
  :after projectile
  :after recentf
  :hook (dashboard-mode . (lambda () (interactive) (page-break-lines-mode 1)))
  :hook (dashboard-mode . (lambda () (interactive) (display-line-numbers-mode -1)))
  :ensure t
  :init
  (setq dashboard-page-separator "

")
  (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
  (setq dashboard-items '((recents . 5)
                          (projects . 5)
                          (agenda . 5)))
  (setq dashboard-center-content t)
  (setq dashboard-projects-switch-function 'projectile-persp-switch-project)
  :config
  (dashboard-setup-startup-hook))

(use-package no-littering
  :ensure t)

(electric-pair-mode 1)
(setq electric-pair-inhibit-predicate
      `(lambda (c)
         (if (char-equal c ?<) t (,electric-pair-inhibit-predicate c))))

(setq indent-tabs-mode t)
(setq-default tab-width 4
              c-basic-offset 4
              c-default-style "stroustrup")
(defvaralias 'c-basic-offset 'tab-width)
(add-hook 'prog-mode-hook #'(lambda ()
                              (interactive)
                              (if (equal major-mode 'emacs-lisp-mode)
                                  (setq indent-tabs-mode nil)
                                (setq indent-tabs-mode t))))

(defalias 'yes-or-no-p 'y-or-n-p)

(global-set-key (kbd "<escape>") 'abort-minibuffers)

(use-package perspective
  :ensure t
  :config
  (setq persp-initial-frame-name "Main")
  (setq persp-mode-prefix-key "C-c p")
  (persp-mode))

(use-package persp-projectile
  :ensure t
  :after perspective
  :after projectile)

(use-package hl-todo
  :ensure t
  :hook (prog-mode . (lambda () (interactive) (hl-todo-mode 1)))
  :config
  (setq hl-todo-highlight-punctuation ":"
        hl-todo-keyword-faces `(("TODO"       warning bold)
                                ("FIXME"      error bold)
                                ("HACK"       font-lock-constant-face bold)
                                ("NOTE"       success bold)
                                ("DEPRECATED" font-lock-doc-face bold))))

(use-package dired-open
  :ensure t
  :after dired
  :config
  (setq dired-open-extensions '(("gif" . "nsxiv")
                                ("jpg" . "nsxiv")
                                ("png" . "nsxiv")
                                ("mkv" . "mpv")
                                ("mp4" . "mpv")
                                ("mp3" . "mpv"))))

(setq backup-directory-alist '((".*" . "~/.cache/emacs/auto-saves")))
(setq auto-save-file-name-transforms '((".*" "~/.cache/emacs/auto-saves" t)))

(use-package page-break-lines
  :ensure t)

(use-package recentf
  :ensure t
  :config
  (add-to-list 'recentf-exclude "~/org/agenda/schedule.org")
  (add-to-list 'recentf-exclude (concat user-emacs-directory "bookmarks")))

(use-package vterm
  :defer t
  :ensure t
  :config
  (setq shell-file-name "/bin/zsh"
        vterm-max-scrollback 5000))

(use-package vterm-toggle
  :after vterm
  :ensure t
  :config
  (setq vterm-toggle-fullscreen-p nil)
  (setq vterm-toggle-scope 'project)
  (add-to-list 'display-buffer-alist
               '((lambda (buffer-or-name _)
                   (let ((buffer (get-buffer buffer-or-name)))
                     (with-current-buffer buffer
                       (or (equal major-mode 'vterm-mode)
                           (string-prefix-p vterm-buffer-name (buffer-name buffer))))))
                 (display-buffer-reuse-window display-buffer-at-bottom)
                 ;;(display-buffer-reuse-window display-buffer-in-direction)
                 ;;display-buffer-in-direction/direction/dedicated is added in emacs27
                 ;;(direction . bottom)
                 ;;(dedicated . t) ;dedicated is supported in emacs27
                 (reusable-frames . visible)
                 (window-height . 0.3))))

(use-package emms
  :ensure t
  ;; :after exwm ;; exwm autostart is where mpd gets started
  :config
  (require 'emms-setup)
  (require 'emms-player-mpd)
  (emms-all)
  (setq emms-seek-seconds 5)
  (setq emms-player-list '(emms-player-mpd))
  (setq emms-info-functions '(emms-info-mpd))
  (setq emms-player-mpd-music-directory (concat (getenv "HOME") "/Music"))
  (setq emms-player-mpd-server-name "localhost")
  (setq emms-player-mpd-server-port "6600")
  (setq mpc-host "localhost:6600"))

(use-package calfw
  :ensure t)
(use-package calfw-org
  :ensure
  :after calfw)

(use-package mu4e
  :ensure nil
  :load-path "/usr/share/emacs/site-lisp/mu4e"
  :config
  (setq smtpmail-stream-type 'starttls
        mu4e-change-filenames-when-moving t
        mu4e-update-interval (* 10 60)
        mu4e-compose-format-flowed t
        mu4e-hide-index-messages t ;; stop flashing my email to everyone around me
        mu4e-get-mail-command "mbsync -a" ;; requires isync to be installed and configured for your emails
        ;; NOTE: I recommend using .authinfo.gpg to store an encrypted set of your email usernames and passwords that mbsync pulls from
        ;; using the decryption function defined below
        message-send-mail-function 'smtpmail-send-it)

  ;; this is a dummy configuration for example
  ;; my real email info is stored in ~/.local/share/emacs/emails.el

  ;; mu4e-contexts (list
  ;;                (make-mu4e-context
  ;;                 :name "My email"
  ;;                 :match-func (lambda (msg)
  ;;                               (when msg
  ;;                                 (string-prefix-p "/Gmail" (mu4e-message-field msg :maildir))))
  ;;                 :vars '((user-mail-address . "myemail@gmail.com")
  ;;                         (user-full-name    . "My Name")
  ;;                         (smtpmail-smtp-server . "smtp.gmail.com")
  ;;                         (smtpmail-smtp-service . 587) ;; this is for tls, use 465 for ssl, 25 for plain
  ;;                         (mu4e-drafts-folder . "/[Gmail]/Drafts")
  ;;                         (mu4e-sent-folder . "/[Gmail]/Sent Mail")
  ;;                         (mu4e-refile-folder . "/[Gmail]/All Mail")
  ;;                         (mu4e-trash-folder . "/[Gmail]/Trash"))))

  (load (concat user-emacs-directory "emails.el")))

(use-package mu4e-alert
  :after mu4e
  :ensure t
  :config
  (mu4e-alert-enable-mode-line-display)
  (mu4e-alert-enable-notifications))

(defun efs/lookup-password (&rest keys)
  (let ((result (apply #'auth-source-search keys)))
    (if result
        (funcall (plist-get (car result) :secret))
      nil)))

(global-set-key (kbd "DEL") 'backward-delete-char)
(setq c-backspace-function 'backward-delete-char)

(defun bugger/emacs-reload ()
  (interactive)
  (setq has-restarted t)
  (org-babel-tangle-file (concat config-dir "config.org"))
  (load-file (concat config-dir "init.el"))
  (load-file (concat config-dir "init.el")))
(global-set-key (kbd "C-c C-r") 'bugger/emacs-reload)

(use-package which-key
  :ensure t
  :config (which-key-mode 1))

(setq gc-cons-threshold (* 2 1024 1024))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(haskell-mode which-key vterm-toggle vertico-prescient toc-org rainbow-mode rainbow-identifiers rainbow-delimiters projectile-ripgrep persp-projectile page-break-lines org-auto-tangle no-littering mu4e-alert marginalia magit hl-todo flycheck evil-nerd-commenter emms dired-open dashboard consult-projectile calfw-org calfw aggressive-indent))
 '(safe-local-variable-values '((org-src-preserve-indentation . t))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
