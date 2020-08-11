(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(ido-hacks ido-vertical-mode whole-line-or-region virtualenvwrapper use-package rainbow-delimiters pos-tip pdf-tools markdown-preview-mode magit latex-preview-pane jedi helm flycheck exec-path-from-shell elpy doom-modeline auctex))
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq user-full-name "Yifan Men")
(setq user-mail-address "yifanmen@gmail.com")

;; Ask "y" or "n" instead of "yes" or "no". Yes, laziness is great.
(fset 'yes-or-no-p 'y-or-n-p)

;; Highlight tabulations
(setq-default highlight-tabs t)

;; Show trailing white spaces
(setq-default show-trailing-whitespace t)

;; Remove useless whitespace before saving a file
(add-hook 'before-save-hook 'whitespace-cleanup)
(add-hook 'before-save-hook (lambda() (delete-trailing-whitespace)))

;; Remove all backup files
(setq make-backup-files nil)
(setq backup-inhibited t)
(setq auto-save-default nil)

;; Set locale to UTF8
(set-language-environment 'utf-8)
(set-terminal-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("marmalade" . "http://marmalade-repo.org/packages/")
			 ("melpa" . "http://melpa.org/packages/")))
(package-initialize)

(unless (package-installed-p 'use-package)
  (progn
    (package-refresh-contents)
    (package-install 'use-package)))

(require 'use-package)

;; Use rainbow delimiter
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; Highlight matching parentheses
(show-paren-mode t)

;; Enable flycheck
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

;; Set keybinding for compile
(global-set-key (kbd "C-c C-v") 'compile)

;; Set global company mode
(add-hook 'after-init-hook 'global-company-mode)

;; Set markdown mode
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode))
  :init (setq markdown-command "/usr/local/bin/multimarkdown"))

;; Set default font
(add-to-list 'default-frame-alist
	     '(font . "Office Code Pro-16"))

;; Disable scroll bar display
(scroll-bar-mode -1)

;; Set apropos
(setq apropos-sort-by-scores t)

;; Set latex preview pane mode
(add-hook 'LaTeX-mode-hook 'latex-preview-pane-mode)

;; Set path
;(when (memq window-system '(mac ns x))
;  (exec-path-from-shell-initialize))

;; Set doc-view to fit width to window
(defadvice doc-view-display (after fit-width activate)
  (doc-view-fit-width-to-window))

;; Set theme
(add-hook 'after-init-hook (lambda () (load-theme 'tango-dark)))

;; Add key binding for switching window
(global-set-key (kbd "M-o") 'other-window)

;; Disable command echo
(defun my-comint-init ()
  (setq comint-process-echoes t))
(add-hook 'comint-mode-hook 'my-comint-init)

;; Use doom modeline
(require 'doom-modeline)
(doom-modeline-mode 1)

;; Use Python 3
(setq python-shell-interpreter "python3")

(use-package elpy
  :ensure t
  :init
  (elpy-enable))

;; Key binding for Imenu
(global-set-key (kbd "M-i") 'imenu)

;; Use Helm
(require 'helm-config)

;; Use Ido
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)

(require 'ido-vertical-mode)
(ido-vertical-mode)

(require 'ido-hacks)
(ido-hacks-mode)

;; Disable toolbar
(tool-bar-mode -1)

;; Use Hippie Expand
(global-set-key [remap dabbrev-expand] 'hippie-expand)

;; Use spell check in TeX
(add-hook 'tex-mode-hook
	  #'(lambda () (setq ispell-parser 'tex)))

(defun sudo ()
  "Use TRAMP to `sudo' the current buffer" (interactive)
  (when buffer-file-name
    (find-alternate-file
     (concat "/sudo:root@localhost:"
	     buffer-file-name))))

;; Use dired-x
(require 'dired-x)

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(setq inhibit-startup-screen t)

;; Switch to visible bell
; (setq visible-bell 1)
