;;
;; Configured by Strzelewicz Alexandre 
;; https://github.com/Alexandre-Strzelewicz/.emacs.d
;;

(defvar hl-tags-start-overlay nil)
(make-variable-buffer-local 'hl-tags-start-overlay)

(defvar hl-tags-end-overlay nil)
(make-variable-buffer-local 'hl-tags-end-overlay)

(defun hl-tags-context ()
  (save-excursion
    (let ((ctx (sgml-get-context)))
      (and ctx
           (if (eq (sgml-tag-type (car ctx)) 'close)
               (cons (sgml-get-context) ctx)
             (cons ctx (progn
                         (sgml-skip-tag-forward 1)
                         (backward-char 1)
                         (sgml-get-context))))))))

(defun hl-tags-update ()
  (let ((ctx (hl-tags-context)))
    (if (null ctx)
        (hl-tags-hide)
      (hl-tags-show)
      (move-overlay hl-tags-end-overlay
                    (sgml-tag-start (caar ctx))
                    (sgml-tag-end (caar ctx)))
      (move-overlay hl-tags-start-overlay
                    (sgml-tag-start (cadr ctx))
                    (sgml-tag-end (cadr ctx))))))

(defun hl-tags-show ()
  (unless hl-tags-start-overlay
    (setq hl-tags-start-overlay (make-overlay 1 1)
          hl-tags-end-overlay (make-overlay 1 1))
    (overlay-put hl-tags-start-overlay 'face 'show-paren-match-face)
    (overlay-put hl-tags-end-overlay 'face 'show-paren-match-face)))

(defun hl-tags-hide ()
  (when hl-tags-start-overlay
    (delete-overlay hl-tags-start-overlay)
    (delete-overlay hl-tags-end-overlay)))

(define-minor-mode hl-tags-mode
  "Toggle hl-tags-mode."
  nil "" nil
  (if hl-tags-mode
      (add-hook 'post-command-hook 'hl-tags-update nil t)
    (remove-hook 'post-command-hook 'hl-tags-update t)
    (hl-tags-hide)))


(provide 'hl-tags-mode)


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

(add-to-list 'auto-mode-alist '("\\.scss$" . css-mode))
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

