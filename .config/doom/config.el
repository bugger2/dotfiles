(setq server-socket-dir (substitute-in-file-name "$HOME/.config/emacs/server-dir"))

(global-display-line-numbers-mode)

(add-hook 'prog-mode-hook (lambda () (rainbow-mode 1)))
(add-hook 'prog-mode-hook (lambda () (rainbow-delimiters-mode 1)))
(add-hook 'prog-mode-hook (lambda () (rainbow-identifiers-mode 1)))

(setq doom-theme 'doom-one)
(setq doom-font (font-spec :family "JetBrains Mono" :size 15 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Jetbrains Mono" :size 15))
(setq doom-unicode-font (font-spec :family "MesloLGS NF" :size 13))

(dashboard-setup-startup-hook)
(setq dashboard-center-content t)
(setq dashboard-banner-logo-title "The Modal Text Editor With More Than Vim")

(setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))

(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)
(add-hook 'server-after-make-frame-hook 'revert-buffer)

;;(define-minor-mode start-mode
  ;;"Provide functions for custom start page."
  ;;:lighter " start"
  ;;:keymap (let ((map (make-sparse-keymap)))
            ;;(evil-define-key 'normal start-mode-map
              ;;(kbd "e") '(lambda () (interactive) (find-file "~/.config/emacs/config.org"))
              ;;(kbd "z") '(lambda () (interactive) (find-file "~/.config/zsh/.zshrc"))
              ;;(kbd "p") '(lambda () (interactive) (find-file "~/.config/polybar/config.ini"))
              ;;(kbd "a") '(lambda () (interactive) (find-file "~/.config/alacritty/alacritty.yml"))
              ;;(kbd "x") '(lambda () (interactive) (find-file "~/.config/xmonad/xmonad.hs"))
              ;;(kbd "f") 'find-file
              ;;(kbd "d") 'dired)
          ;;map))
;;
;;(add-hook 'start-mode-hook 'read-only-mode)
;;(provide 'start-mode)
;;(add-hook 'dashboard-mode-hook 'start-mode)

(setq nyan-animate-nyancat t)
(setq nyan-wavy-trail t)
(setq nyan-bar-length 30)
(add-hook 'prog-mode-hook (lambda () (nyan-mode 1)))

(setq zone-timer (run-with-idle-timer 120 t 'zone))

(eval-after-load "zone"
  '(unless (memq 'zone-nyan (append zone-programs nil))
     (setq zone-programs
           (vconcat zone-programs [zone-nyan]))))
(eval-after-load "zone"
  '(unless (memq 'zone-pgm-sl (append zone-programs nil))
     (setq zone-programs
           (vconcat zone-programs [zone-pgm-sl]))))
(eval-after-load "zone"
  '(unless (memq 'zone-rainbow (append zone-programs nil))
     (setq zone-programs
           (vconcat zone-programs [zone-rainbow]))))

(use-package tree-sitter)
(use-package tree-sitter-langs
  :after tree-sitter)
(global-tree-sitter-mode)
(add-hook 'tree-sitter-mode-hook (lambda () (tree-sitter-hl-mode 1)))

(beacon-mode 1)
(setq display-line-numbers-type t)

(setq dired-open-extensions '(("gif" . "mpv")
							  ("jpg" . "feh")
							  ("png" . "feh")
							  ("mkv" . "mpv")
							  ("mp4" . "mpv")
							  ("mp3" . "mpv")))

(setq scroll-conservatively 10000)
(setq scroll-step 1)
(setq auto-window-vscroll nil)
(setq ring-bell-function 'ignore)
(setq visible-bell t)
(setq-default evil-cross-lines nil)

(setq-default c-default-style "stroustrup"
	      c-basic-offset 4
	      tab-width 4
	      indent-tabs-mode 1)
(defvaralias 'c-basic-offset 'tab-width)
(add-hook 'haskell-indentation-mode-hook (lambda () (interactive) (setq-default indent-tabs-mode 1)))
(global-set-key (kbd "TAB") 'tab-to-tab-stop)
(define-key evil-insert-state-map (kbd "<remap> <indent-for-tab-command>") 'tab-to-tab-stop)
(define-key evil-insert-state-map (kbd "<remap> <c-indent-line-or-region>") 'tab-to-tab-stop)

(define-key evil-normal-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)

(add-hook 'org-mode-hook 'org-bullets-mode)
(setq org-hide-leading-stars t)

(setq org-src-fontify-natively t
    org-src-tab-acts-natively t
    org-confirm-babel-evaluate nil
	org-src-window-setup 'current-window
	org-src-preserve-indentation t)

(add-hook 'org-mode-hook (lambda () (interactive) (org-auto-tangle-mode 1)))

; Pretty colors and sizes for org mode
(defun bugger/org-colors-doom-molokai ()
  (interactive)
  (dolist
	  (face
	   '((org-level-1       1.7 "#fb2874" ultra-bold)
	     (org-level-2       1.6 "#fd971f" extra-bold)
	     (org-level-3       1.5 "#9c91e4" bold)
	     (org-level-4       1.4 "#268bd2" semi-bold)
	     (org-level-5       1.3 "#e74c3c" normal)
	     (org-level-6       1.2 "#b6e63e" normal)
	     (org-level-7       1.1 "#66d9ef" normal)
	     (org-level-8       1.0 "#e2c770" normal)
	     (org-table         1.0 "#d4d4d4" normal)
	     (org-table-header  1.0 "#d4d4d4" normal)
	     (org-link          1.3 "#9c91e4" normal)))
	  (set-face-attribute (nth 0 face) nil :family 'JetBrainsMono :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
	  (set-face-attribute 'org-table nil :family 'JetBrainsMono :weight 'normal :height 1.0 :foreground "#d4d4d4"))

; thanks dt for this one
(defun dt/org-colors-doom-one ()
  "Enable Doom One colors for Org headers."
  (interactive)
  (dolist
      (face
       '((org-level-1 1.7 "#51afef" ultra-bold)
         (org-level-2 1.6 "#c678dd" extra-bold)
         (org-level-3 1.5 "#98be65" bold)
         (org-level-4 1.4 "#da8548" semi-bold)
         (org-level-5 1.3 "#5699af" normal)
         (org-level-6 1.2 "#a9a1e1" normal)
         (org-level-7 1.1 "#46d9ff" normal)
         (org-level-8 1.0 "#ff6c6b" normal)))
    (set-face-attribute (nth 0 face) nil :family 'JetBrainsMono :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
    (set-face-attribute 'org-table nil :family 'JetBrainsMono :weight 'normal :height 1.0 :foreground "#bfafdf"))
(dt/org-colors-doom-one)

(setq org-ellipsis " ▼ ")

(defun bugger/kill-buffer ()
  (interactive)
  (when (buffer-modified-p)
	(when (y-or-n-p "Buffer modified. Save?")
	  (save-buffer)))
  (kill-buffer (buffer-name)))

(defun bugger/kill-buffer-and-window ()
  (interactive)
  (when (buffer-modified-p)
	(when (y-or-n-p "Buffer modified. Save?")
	  (save-buffer)))
  (kill-buffer-and-window))

(defun bugger/edit-src ()
  (interactive)
  (if (org-src-edit-buffer-p)
	  (org-edit-src-exit)
	(org-edit-special)))

(map! :prefix "SPC b"
  "i" '(ibuffer :which-key "Ibuffer")
  "c" '(bugger/kill-buffer :which-key "Close the current buffer")
  "k" '(bugger/kill-buffer-and-window :which-key "Close the current buffer and window")
  "b" '(pop-to-buffer :which-key "Open a buffer in a new window")
  "r" '(revert-buffer :which-key "Reload the buffer")
  "s" '(switch-to-buffer "*scratch*" :which-key "Open the scratch buffer"))
(define-key evil-normal-state-map (kbd "q") 'bugger/kill-buffer)
(define-key evil-normal-state-map (kbd "Q") 'bugger/kill-buffer-and-window)

(map! :prefix "SPC t"
  "e" '(bugger/edit-src :which-key "Start/Finish editing a code block")
  "a" '(org-auto-tangle-mode :which-key "Toggle auto tangle mode")
  "t" '(org-babel-tangle :which-key "Tangle the current file")
  "k" '(org-edit-src-abort :which-key "Abort editing a code block"))

(map! :prefix "SPC w"
  "v" '(evil-window-vsplit :which-key "Open a vertical split")
  "w" '(evil-window-next :which-key "Switch to the next window")
  "n" '(evil-window-new :which-key "Open a horizontal split")
  "c" '(evil-window-delete :which-key "Close the current window")
  "k" '(bugger/kill-buffer-and-window))

(map! :prefix "SPC d"
		"d" '(dired :which-key "Open dired")
		"j" '(dired-jump :which-key "Open dired in the current directory"))

(map! :prefix "SPC"
  "."	'(find-file :which-key "Open a file")
  "f s" '(save-buffer :which-key "Save file")
  "f r" '(recentf-open-files :which-key "List recent files to open")
  "f u" '(sudo-edit-find-file :which-key "Find file as root")
  "f U" '(sudo-edit :which-key "Edit as root"))

(map! :prefix "SPC t"
  "e" '(bugger/edit-src :which-key "Edit a code block")
  "a" '(org-auto-tangle-mode :which-key "Toggle auto tangle mode")
  "t" '(org-babel-tangle :which-key "Tangle the current file")
  "k" '(org-edit-src-abort :which-key "Abort editing a code block"))

(map! :prefix "SPC r"
  "f" '(org-roam-node-find :which-key "Open a note file")
  "i" '(org-roam-node-insert :which-key "Insert a roam node")
  "r" '(org-roam-buffer-toggle :which-key "Toggle org roam")
  "v" '(org-roam-node-visit :which-key "Visit an org node")
  "u" '(org-roam-db-sync :which-key "Update roam database")
  "c" '(org-capture-finalize :which-key "Finish roam capture")
  "a" '(org-capture-kill :which-key "Abort roam capture")
  "n" '(org-capture-refile :which-key "Refile roam capture"))

(map! :prefix "SPC e"
  "b" '(eval-buffer (current-buffer) :which-key "Evaluate current buffer")
  "r" '(eval-region :which-key "Evaluate region"))

(global-set-key (kbd "C-j") #'(lambda ()
								(interactive)
								(evil-scroll-down 1)))
(define-key evil-normal-state-map (kbd "<remap> <org-return-and-maybe-indent") #'(lambda ()
								(interactive)
								(evil-scroll-down 1)))
(global-set-key (kbd "C-k") #'(lambda ()
								(interactive)
								(evil-scroll-up 1)))

(with-eval-after-load 'dired
  (evil-define-key 'normal dired-mode-map (kbd "h") 'dired-up-directory)
  (evil-define-key 'normal dired-mode-map (kbd "l") 'dired-open-file)) ; use dired-find-file instead if not using dired-open package

(with-eval-after-load 'ibuffer
  (evil-define-key 'normal ibuffer-mode-map (kbd "l") 'ibuffer-visit-buffer))
