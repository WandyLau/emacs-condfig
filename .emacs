(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/lisp")
(require 'cl-lib)

;;(add-to-list 'package-archives
;;             '("melpa" . "http://melpa.milkbox.net/packages/") t)
;;(package-initialize)
;;(setq url-http-attempt-keepalives nil)
;;(require 'package)
;;........

;;(add-to-list 'load-path "~/.emacs.d/evil")
;;(add-to-list 'load-path "~/.emacs.d/auto-complete")
;;(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

;;........,..............
;;M-` or F10 ............
;; (if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;;......
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)

;;....
(setq-default make-backup-files nil)

;;....
(show-paren-mode 1)
(setq show-paren-delay 0)

;;set colors
(set-background-color "black")
(set-foreground-color "white")
(set-cursor-color "red")

;;set fill column
;;(set-fill-column 80)
(setq-default fill-column 80)
;;set auto fill mode
(setq auto-fill-mode 1)
;;enable line and column number
(column-number-mode 1)

;;lua-mode
;;(add-to-list 'load-path "~/.emacs.d/")
;;(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
;;(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
;;(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

;; line number
(global-linum-mode t)
(line-number-mode 1)
(setq column-number-mode t)
;;auto complete
;;(add-to-list 'load-path "/home/dong/.emacs.d/plugin")
;;(require 'auto-complete)
;(add-to-list 'ac-dictionary-directories "/home/dong/.emacs.d/plugin")
;(ac-config-default)
;;yasnippet
;;(add-to-list 'load-path "~/.emacs.d/elpa/yasnippet-20150927.1617")
;;(require 'yasnippet)
;;(yas-global-mode 1)
;;auto fill-mode
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;;auto-complete
;;(add-to-list 'load-path "~/.emacs.d/auto-complete-20150618.1949")
;;(require 'auto-complete-config)
;;(ac-config-default)

;;no tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 8)
;;indent 8 spaces
(setq-default c-basic-offset 8
                  tab-width 8
                  indent-tabs-mode t)
;;auto indent
;;(add-hook 'c-mode-common-hook '(lambda () (c-toggle-auto-state 1)))
;;cscope

(require 'xcscope)
;;(cscope-setup)

;;cscope
;;(require 'xcscope)
(add-hook 'c-mode-common-hook
	    '(lambda ()
	           (require 'xcscope)))

;; Makes *scratch* empty.
(setq initial-scratch-message "")
;; Removes *scratch* from buffer after the mode has been set.
(defun remove-scratch-buffer ()
  (if (get-buffer "*scratch*")
      (kill-buffer "*scratch*")))
(add-hook 'after-change-major-mode-hook 'remove-scratch-buffer)

;; Removes *messages* from the buffer.
(setq-default message-log-max nil)
(kill-buffer "*Messages*")

;; Removes *Completions* from buffer after you've opened a file.
(add-hook 'minibuffer-exit-hook
      '(lambda ()
         (let ((buffer "*Completions*"))
           (and (get-buffer buffer)
                (kill-buffer buffer)))))

;; Don't show *Buffer list* when opening multiple files at the same time.
(setq inhibit-startup-buffer-menu t)

;; Show only one active window when opening multiple files at the same time.
(add-hook 'window-setup-hook 'delete-other-windows)
;;(set-face-attribute 'default nil :height 150)
(global-set-key (kbd "M-<del>") 'delete-forword-char)
;;(set-language-environment "Chinese-GB")

;;Chinese display

;(set-language-environment 'utf-8)
;(set-keyboard-coding-system 'utf-8)
;(set-clipboard-coding-system 'euc-cn)
;(set-terminal-coding-system 'utf-8)
;(set-buffer-file-coding-system 'euc-cn)
;(set-selection-coding-system 'euc-cn)
;(modify-coding-system-alist 'process "*" 'utf-8)
;(setq default-process-coding-system
 ;           '(euc-cn . euc-cn))
;(setq-default pathname-coding-system 'utf-8)

;; .emacs

(custom-set-variables
 ;; uncomment to always end a file with a newline
 ;'(require-final-newline t)
 ;; uncomment to disable loading of "default.el" at startup
 ;'(inhibit-default-init t)
 ;; default to unified diffs
 '(diff-switches "-u"))

;;; uncomment for CJK utf-8 support for non-Asian users
;; (require 'un-define)
(windmove-default-keybindings)
(setq windmove-wrap-around t)

;;auto complete
(add-to-list 'load-path "~/.emacs.d/auto-complete")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete/ac-dict")
(ac-config-default)

;;go mode.
(add-to-list `load-path "~/.emacs.d/go-mode.el")
(require `go-mode-autoloads)

;;(byte-recompile-directory "~/.emacs.d" 0)
