;;
;; Configured by Strzelewicz Alexandre 
;; https://github.com/Alexandre-Strzelewicz/.emacs.d
;;




(add-to-list 'load-path "~/.emacs.d/")
;;
;; IDO
;;
(require 'ido)
  (ido-mode t)
;;
;; transform file to htmlified !
;;
(require 'htmlize)
;;
;; shell-toggle-cd
;;
(autoload 'shell-toggle-cd "~/.emacs.d/shell-toggle.el"
  "Pops up a shell-buffer and insert a \"cd <file-dir>\" command." t)
;;
;; Python mod
;;
(require 'python-mode)
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
    (setq interpreter-mode-alist (cons '("python" . python-mode)
                                       interpreter-mode-alist))
    (autoload 'python-mode "python-mode" "Python editing mode." )
;;
;; AUTO tab
;;
(add-hook 'c-mode-common-hook '(lambda ()
				 (local-set-key (kbd "RET") 'newline-and-indent)))
;;
;; Save layout (revive.el)
;;
(autoload 'save-current-configuration "revive" "Save status" t)
(autoload 'resume "revive" "Resume Emacs" t)
(autoload 'wipe "revive" "Wipe Emacs" t)
;;
;; Best JS mod (Nespresso)
;; 
(autoload 'espresso-mode "espresso" "Start espresso-mode" t)
(add-to-list 'auto-mode-alist '("\\.js$" . espresso-mode))
(add-to-list 'auto-mode-alist '("\\.js.erb$" . espresso-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . espresso-mode))

;;Ruby emacs : https://github.com/remvee/emacs-rails

;(add-to-list 'load-path (expand-file-name "~/.emacs.d/rails-minor-mode"))
;(require 'rails)


 ;; Rinari
(add-to-list 'load-path "~/.emacs.d/rinari")
(require 'rinari)

;;
;; ERB & co
;;
(add-to-list 'load-path (expand-file-name "~/.emacs.d/rhtml-minor-mode"))
(require 'rhtml-mode)
;;
;; YAML
;;
(add-to-list 'load-path (expand-file-name "~/.emacs.d/yaml-mode"))
(require 'yaml-mode)
;;
;; HAML
;;
(add-to-list 'load-path (expand-file-name "~/.emacs.d/haml-mode"))
(require 'haml-mode)
;;
;; SASS
;;
(add-to-list 'load-path (expand-file-name "~/.emacs.d/sass-mode"))
(require 'sass-mode)

(add-to-list 'auto-mode-alist '("\\.ejs$" . html-mode))

(add-to-list 'auto-mode-alist '("\\.less$" . css-mode))
(add-to-list 'auto-mode-alist '("\\.scss$" . css-mode))
(add-to-list 'auto-mode-alist '("\\.css.erb$" . css-mode))
(add-to-list 'auto-mode-alist '("\\.scss.erb$" . css-mode))
;;
;; MARKDOWN
;;
(add-to-list 'load-path (expand-file-name "~/.emacs.d/markdown-mode"))
(require 'markdown-mode)
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))
;;
;; Coffeescript
;;
(add-to-list 'load-path (expand-file-name "~/.emacs.d/coffee-mode"))
(require 'coffee-mode)

;;
;; Org-mode
;;
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

;;
;; Predictive
;;
;; (add-to-list 'load-path "~/.emacs.d/predictive/")
;; ;; dictionary locations
;; ;; (add-to-list 'load-path "~/.emacs.d/predictive/latex/")
;; ;; (add-to-list 'load-path "~/.emacs.d/predictive/texinfo/")
;; ;; (add-to-list 'load-path "~/.emacs.d/predictive/html/")
;; ;; load predictive package
;; (require 'predictive)
;; (setq predictive-major-mode-alist nil)
;; (predictive-mode)



;;
;; Smex mini-buffer completion IDO
;;
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex) 
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;;
;; COLOR PARENTHESIS
;;
(load-library "paren")
(show-paren-mode 1)
;;
;; DISABLE BACKUP FILES
;;
(setq make-backup-files nil)
(setq delete-auto-save-files t)
(global-font-lock-mode t)
(setq-default indicate-empty-lines t)
(transient-mark-mode t)
(column-number-mode t)
;;
;; COLORS
;;
(set-cursor-color "Red")
(set-face-background 'region "Red")
(set-face-background 'show-paren-match-face "Blue")
(set-face-background 'show-paren-mismatch-face "Magenta")
(set-face-foreground 'show-paren-mismatch-face "Red")
(set-face-foreground 'highlight "yellow")
;;
;; MISC
;;
(setq inhibit-startup-message t)
(setq frame-title-format "%S: %f")
(modify-frame-parameters nil '((wait-for-wm . nil)))
(fset 'yes-or-no-p 'y-or-n-p)
(icomplete-mode 1)
(setq column-number-mode t)
(setq display-time-string-forms '((format "[%s:%s]-[%s/%s/%s] " 24-hours minutes day month year)))
(setq scroll-preserve-screen-position t)
(add-hook 'save-buffer-hook 'delete-trailing-whitespace)
;; 
;; SHORTCUTS
;;
(global-set-key (kbd "C-c g") 'goto-line)
(global-set-key (kbd "C-c c") 'comment-region)
(global-set-key (kbd "C-c v") 'uncomment-region)
;;
;; Fly between window
;;

(windmove-default-keybindings 'meta)

;;
;; Resize window
;;
(global-set-key (kbd "<f5>") 'shrink-window-horizontally)
(global-set-key (kbd "<f6>") 'enlarge-window-horizontally)
(global-set-key (kbd "<f7>") 'shrink-window)
(global-set-key (kbd "<f8>") 'enlarge-window)


     (add-to-list 'load-path (expand-file-name "~/.emacs.d/gc-refresh-mode"))
     (require 'gc-refresh-mode)


;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/gc-refresh"))
;; (require 'gc-refresh-mode)

;; (defun save-and-reload () "Save and reload browser" (interactive)
;;   (save-buffer)
;;   (shell-command "~/.emacs.d/googlechrome/reload.py")
;;   )

;;(define-key global-map "\C-x\C-s" 'save-and-reload)



;;
;;
;; attr_accessor :a,
;;                :time, # ms since epoch
;;                :b,
;;                :c
;;
(defadvice ruby-indent-line (after line-up-args activate)
  (let (indent prev-indent arg-indent)
    (save-excursion
      (back-to-indentation)
      (when (zerop (car (syntax-ppss)))
        (setq indent (current-column))
        (skip-chars-backward " \t\n")
        (when (eq ?, (char-before))
          (ruby-backward-sexp)
          (back-to-indentation)
          (setq prev-indent (current-column))
          (skip-syntax-forward "w_.")
          (skip-chars-forward " ")
          (setq arg-indent (current-column)))))
    (when prev-indent
      (let ((offset (- (current-column) indent)))
        (cond ((< indent prev-indent)
               (indent-line-to prev-indent))
              ((= indent prev-indent)
               (indent-line-to arg-indent)))
        (when (> offset 0) (forward-char offset))))))


(defun align-to-colon (begin end)
  "Align region to colon (:) signs"
  (interactive "r")
  (align-regexp begin end
                (rx (group (zero-or-more (syntax whitespace))) ":") 1 1 ))

(defun align-to-comma (begin end)
  "Align region to comma signs"
  (interactive "r")
  (align-regexp begin end
                (rx "," (group (zero-or-more (syntax whitespace))) ) 1 1 ))


(defun align-to-equals (begin end)
  "Align region to equal signs"
  (interactive "r")
  (align-regexp begin end
                (rx (group (zero-or-more (syntax whitespace))) "=") 1 1 ))

(defun align-to-hash (begin end)
  "Align region to hash ( => ) signs"
  (interactive "r")
  (align-regexp begin end
                (rx (group (zero-or-more (syntax whitespace))) "=>") 1 1 ))

;; work with this
(defun align-to-comma-before (begin end)
  "Align region to equal signs"
  (interactive "r")
  (align-regexp begin end
                (rx (group (zero-or-more (syntax whitespace))) ",") 1 1 ))