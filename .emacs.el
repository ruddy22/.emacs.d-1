;;
;; Configured by Strzelewicz Alexandre
;; https://github.com/Unitech/.emacs.d
;; Compatible with Emacs 25.x
;;
;; For MacOSx do not forget to add Keyboard action in iterm2
;; for forward-paragraph and backward-paragraph
;;

;; BASE
(setq initial-scratch-message "⌬  Code the Future.")
(setq inhibit-startup-message t)
(setq require-final-newline t)
(setq frame-title-format "%S: %f")
(modify-frame-parameters nil '((wait-for-wm . nil)))
(fset 'yes-or-no-p 'y-or-n-p)
(icomplete-mode 1)
(setq column-number-mode t)
(setq display-time-string-forms '((format "[%s:%s]-[%s/%s/%s] " 24-hours minutes day month year)))
(setq scroll-preserve-screen-position t)
(add-hook 'save-buffer-hook 'delete-trailing-whitespace)
(setq make-backup-files nil)
(setq backup-directory-alist `(("." . "~/.saves")))
(setq delete-auto-save-files t)
(global-font-lock-mode t)
(setq-default indicate-empty-lines t)
(transient-mark-mode t)
(column-number-mode t)
(setq standard-indent 2)
(setq-default indent-tabs-mode nil)
(global-set-key "\M- " 'hippie-expand)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(setq mac-command-modifier 'control)

;;(set-language-environment "UTF-8")


;;
;; el-get
;;
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)

(setq package-list '(smart-mode-line go-mode markdown-mode))

;; Require Emacs' package functionality
(require 'package)
;; Add the Melpa repository to the list of package sources
(setq package-archives '(("elpa" . "http://tromey.com/elpa/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("elpa" . "http://tromey.com/elpa/")))

;; Initialise the package system.
(package-initialize)

;; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

;; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))


(setq el-get-sources
      '((:name js2-mode
               :type git
               :url "git://github.com/mooz/js2-mode.git"
               :load "js2-mode.el"
               :compile ("js2-mode.el")
               :features js2-mode)
        ))

(setq my-el-get-packages
      (append
       '(js-comint js2-mode)
       (mapcar 'el-get-source-name el-get-sources)))

(el-get 'sync my-el-get-packages)

;;(setq warning-minimum-level :emergency)

;; Auto install packages


;; SMART LINE
(setq sml/no-confirm-load-theme t)
(setq sml/theme 'dark)
(sml/setup)



;;
;; COLORS
;;
(set-cursor-color "Red")
(set-face-background 'region "#666")
(set-face-foreground 'minibuffer-prompt "#33FFFF")
(global-hl-line-mode)
(set-face-background hl-line-face "#222")


;;
;; Smarter emacs
;;

(defadvice kill-region (before slick-cut activate compile)
  "When called interactively with no active region, kill a single
line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
           (line-beginning-position 2)))))


;;
;; SHORTCUTS
;;

(defun toggle-comment-on-line ()
  "comment or uncomment current line"
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))

(global-set-key (kbd "C-c g") 'goto-line)
(global-set-key (kbd "C-c c") 'comment-or-uncomment-region)
(global-set-key (kbd "C-c v") 'toggle-comment-on-line)
(global-set-key (kbd "C-c C-c") 'comment-box)
(global-set-key (kbd "C-<up>") 'backward-paragraph)
(global-set-key (kbd "<C-down>") 'forward-paragraph)
(global-set-key (kbd "C-c a") 'my-align-single-equals)

;;
;; Resize window
;;
(global-set-key (kbd "<f5>") 'shrink-window-horizontally)
(global-set-key (kbd "<f6>") 'enlarge-window-horizontally)
(global-set-key (kbd "<f7>") 'shrink-window)
(global-set-key (kbd "<f8>") 'enlarge-window)

;;(global-set-key "\C-c\C-d" "\C-a\C- \C-n\M-w\C-y")

;;
;; Fly between window
;;
(windmove-default-keybindings 'meta)

;;
;; MISC
;;
(add-to-list 'auto-mode-alist '("components\\/.*\\.js\\'" . rjsx-mode))
(load-library "paren")
(show-paren-mode 1)

;;
;; IDO
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ido-mode
;; http://www.emacswiki.org/cgi-bin/wiki/InteractivelyDoThings
(require 'ido)
(ido-mode 'both) ;; for buffers and files
(setq
 ido-save-directory-list-file "~/.emacs.d/cache/ido.last"
 ido-ignore-buffers ;; ignore these guys
 '("\\` " "^\*Mess" "^\*Back" ".*Completion" "^\*Ido" "^\*trace"
   "^\*compilation" "^\*GTAGS" "^session\.*" "^\*")
 ido-work-directory-list '("~/" "~/Desktop" "~/Documents" "~src")
 ido-case-fold  t                 ; be case-insensitive
 ido-enable-last-directory-history t ; remember last used dirs
 ido-max-work-directory-list 30   ; should be enough
 ido-max-work-file-list      50   ; remember many
 ido-use-filename-at-point nil    ; don't use filename at point (annoying)
 ido-use-url-at-point nil         ; don't use url at point (annoying)
 ido-enable-flex-matching nil     ; don't try to be too smart
 ido-max-prospects 8              ; don't spam my minibuffer
 ido-confirm-unique-completion t) ; wait for RET, even with unique completion

;; when using ido, the confirmation is rather annoying...
(setq confirm-nonexistent-file-or-buffer nil)

;; increase minibuffer size when ido completion is active
(add-hook 'ido-minibuffer-setup-hook
          (function
           (lambda ()
             (make-local-variable 'resize-minibuffer-window-max-height)
             (setq resize-minibuffer-window-max-height 1))))

;;
;; shell-toggle-cd
;;
(autoload 'shell-toggle-cd "~/.emacs.d/shell-toggle.el"
  "Pops up a shell-buffer and insert a \"cd <file-dir>\" command." t)


;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  VUE MODE!
;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set Indent for CSS MODE! :))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/mmm-mode"))
(require 'mmm-mode)
(setq mmm-submode-decoration-level 0)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/vue-html-mode"))
(require 'vue-html-mode)
(add-to-list 'load-path (expand-file-name "~/.emacs.d/ssass-mode"))
(require 'ssass-mode)
(setq css-indent-offset 2)
(setq indent-tabs-mode nil
      js-indent-level 2)
(add-to-list 'load-path (expand-file-name "~/.emacs.d/edit-indirect"))
(require 'edit-indirect)
(add-to-list 'load-path (expand-file-name "~/.emacs.d/vue-mode"))
(require 'vue-mode)


;;
;; Python mod
;;
;; JS2-MODE (JAVASCRIPT)
(add-hook 'js-mode-hook 'js2-minor-mode)
(add-to-list 'auto-mode-alist '("\\.json$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.json5$" . json-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))
(add-hook 'js2-mode-hook '(lambda () (local-set-key (kbd "RET") 'newline-and-indent)))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "5008a5c8985fda9803ff9d02bc2a56b45407ccc251ff85a817e9dfe7f345ffe5" default)))
 '(js2-missing-semi-one-line-override t)
 '(js2-strict-inconsistent-return-warning nil)
 '(js2-strict-missing-semi-warning nil)
 '(max-lisp-eval-depth 5000)
 '(max-specpdl-size 50000))


(eval-after-load "js2-mode"
  '(progn
     (setq js2-missing-semi-one-line-override t)
     (setq-default js2-basic-offset 2)
     ;; add from jslint global variable declarations to js2-mode globals list
     ;; modified from one in http://www.emacswiki.org/emacs/Js2Mode
     (defun my-add-jslint-declarations ()
       (when (> (buffer-size) 0)
         (let ((btext (replace-regexp-in-string
                       (rx ":" (* " ") "true") " "
                       (replace-regexp-in-string
                        (rx (+ (char "\n\t\r "))) " "
                        ;; only scans first 1000 characters
                        (save-restriction (widen) (buffer-substring-no-properties (point-min) (min (1+ 1000) (point-max)))) t t))))
           (mapc (apply-partially 'add-to-list 'js2-additional-externs)
                 (split-string
                  (if (string-match (rx "/*" (* " ") "global" (* " ") (group (*? nonl)) (* " ") "*/") btext)
                      (match-string-no-properties 1 btext) "")
                  (rx (* " ") "," (* " ")) t))
           )))
     (add-hook 'js2-post-parse-callbacks 'my-add-jslint-declarations)))
(setq js2-use-font-lock-faces t)

;; HTML
(add-to-list 'auto-mode-alist '("\\.ejs$" . html-mode))


;;
;; Rinari
;;
;; (add-to-list 'load-path "~/.emacs.d/rinari")
;; (require 'rinari)

;;
;; YAML
;;
(add-to-list 'load-path (expand-file-name "~/.emacs.d/yaml-mode"))
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))

;;
;; NGINX files
;;
(add-to-list 'load-path (expand-file-name "~/.emacs.d/nginx-mode"))
(require 'nginx-mode)

;;
;; HAML
;;
(add-to-list 'load-path (expand-file-name "~/.emacs.d/haml-mode"))
(require 'haml-mode)

;;
;; HBS
;;
(add-to-list 'load-path (expand-file-name "~/.emacs.d/web-mode"))
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.hbs$" . web-mode))

;;
;; SASS
;;
(add-to-list 'auto-mode-alist '("\\.scss$" . scss-mode))
(add-to-list 'auto-mode-alist '("\\.css$" . css-mode))

;;
;; MARKDOWN
;;

;;
;; Typescript
;;
(add-to-list 'load-path "~/.emacs.d/typescript.el")
(require 'typescript-mode)
(add-to-list 'auto-mode-alist '("\\.ts$" . typescript-mode))
(setq typescript-indent-level 2)

;;
;; Remove menu bar
;;
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;; (require 'highlight-current-line)
;; (highlight-current-line-on t)
;; To customize the background color
;; (set-face-background 'highlight-current-line-face "#010101")


;;
;; Smart paste (auto indent paste)
;;
(dolist (command '(yank yank-pop))
  (eval `(defadvice ,command (after indent-region activate)
           (and (not current-prefix-arg)
                (member major-mode '(emacs-lisp-mode lisp-mode
                                                     clojure-mode    scheme-mode
                                                     haskell-mode    ruby-mode
                                                     rspec-mode
                                                     c-mode          c++-mode
                                                     js2-mode css-mode
                                                     html-mode
                                                     objc-mode       latex-mode
                                                     plain-tex-mode))
                (let ((mark-even-if-inactive transient-mark-mode))
                  (indent-region (region-beginning) (region-end) nil))))))

;;
;; IDO do not prefix double buffer name with <number>
;;
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;;
;; Yasnippet
;;

(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)
;;(setq yas-snippet-dirs "~/.emacs.d/yas/")

;;
;; Emacs core fix
;;


;;
;; Jade mode
;;
(add-to-list 'load-path "~/.emacs.d/sws-mode")
(add-to-list 'load-path "~/.emacs.d/stylus-mode")
(require 'sws-mode)
(require 'stylus-mode)

(add-to-list 'auto-mode-alist '("\\.styl$" . stylus-mode))
;;(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))
(add-to-list 'auto-mode-alist '("\\.pug$" . jade-mode))

;;
;; Test function
;;
;; (defun doodlebug ()
;;  "Nonce function"
;;  (interactive)
;;  (message "Howdie-doodie fella"))
;; (global-set-key [f5] 'doodlebug)

;;
;; Align C-c a
;;
(defun my-align-single-equals ()
  "Align on a single equals sign (with a space either side)."
  (interactive)
  (align-regexp
   (region-beginning) (region-end)
   "\\(\\s-*\\) = " 1 0 nil))

;;
;; js-commint
;;
(add-to-list 'load-path "~/.emacs.d/js-commint")
(require 'js-comint)
(setq inferior-js-program-command "node") ;; not "node-repl"


;; Use your favorited js mode here:
(add-hook 'js2-mode-hook '(lambda ()
                            (local-set-key "\C-x\C-e"
                                           'js-send-last-sexp)
                            (local-set-key "\C-\M-x"
                                           'js-send-last-sexp-and-go)
                            (local-set-key "\C-cb"
                                           'js-send-buffer)
                            (local-set-key "\C-c\C-b"
                                           'js-send-buffer-and-go)
                            (local-set-key "\C-cl"
                                           'js-load-file-and-go)
                            ))


(setq inferior-js-mode-hook
      (lambda ()
        ;; We like nice colors
        (ansi-color-for-comint-mode-on)
        ;; Deal with some prompt nonsense
        (add-to-list
         'comint-preoutput-filter-functions
         (lambda (output)
           (replace-regexp-in-string "\033\\[[0-9]+[GK]" "" output)))))

(setenv "NODE_NO_READLINE" "1")

(add-to-list 'load-path "~/.emacs.d/flymake-cursor")
(require 'flymake-cursor)

(add-to-list 'load-path "~/.emacs.d/php-mode")

(require 'php-mode)

;;
;; Alias
;;
(defalias 'pipe 'shell-command-on-region)


;; (defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
;;   "Prevent annoying \"Active processes exist\" query when you quit Emacs."
;;   (flet ((process-list ())) ad-do-it))

(setq-default tab-width 2)
;;
;; Automatic indentation (tab or space) depending on user source code
;;
;; (require 'dtrt-indent)
;; (dtrt-indent-mode 1)

;;
;; Automatic byt compile
;;
;;(byte-recompile-directory (expand-file-name "~/.emacs.d") 0)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(defun terminal-init-screen ()
  "Terminal initialization function for screen."
   ;; Use the xterm color initialization code.
   (xterm-register-default-colors)
   (tty-set-up-initial-frame-faces))

(setq frame-background-mode 'dark)

;; Arduino

;; (add-to-list 'load-path "~/.emacs.d/arduino-mode")
;; (setq auto-mode-alist (cons '("\\.\\(pde\\|ino\\)$" . arduino-mode) auto-mode-alist))
;; (autoload 'arduino-mode "arduino-mode" "Arduino editing mode." t)
