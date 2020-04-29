(menu-bar-mode -1)
;;(tool-bar-mode -1)

;;custom-theme-load-path
(add-to-list 'custom-theme-load-path "~/.emacs.d/custom/atom-one-dark-theme/")

;;turn off the sound
(setq visible-bell t)

;;鼠标中健插入
(setq mouse-yank-at-point t)

(setq gc-cons-threshold 100000000)
(setq inhibit-startup-message t)

(defalias 'yes-or-no-p 'y-or-n-p)

;; show unncessary whitespace that can mess up your diff
(add-hook 'prog-mode-hook
          (lambda () (interactive)
            (setq show-trailing-whitespace 1)))

;; use space to indent by default
(setq-default indent-tabs-mode nil)
;; no backup file
(setq make-backup-files nil)
;; set appearance of a tab that is represented by 4 spaces
(setq-default tab-width 4)

;; Compilation
;;(global-set-key (kbd "<f5>") (lambda ()
;;                               (interactive)
;;                               (setq-local compilation-read-command nil)
;;                               (call-interactively 'compile)))

;; setup GDB
(setq
 ;; use gdb-many-windows by default
 gdb-many-windows t

 ;; Non-nil means display source file containing the main routine at startup
 gdb-show-main t
 )

;; company
;;(use-package company
;;  :init
;;  (global-company-mode 1)
;;  (delete 'company-semantic company-backends))
;; (define-key c-mode-map  [(control tab)] 'company-complete)
;; (define-key c++-mode-map  [(control tab)] 'company-complete)
(require `company)

;; activate whitespace-mode to view all whitespace characters
(global-set-key (kbd "C-c w") 'whitespace-mode)
;;(windmove-default-keybindings)
(global-whitespace-mode 1)

;; general setup
(show-paren-mode 1)
(setq show-paren-delay 0)

(setq-default fill-column 80)
;;set auto fill mode
(setq auto-fill-mode 1)
;;enable line and column number
(column-number-mode 1)


;; line number
(global-linum-mode t)
(line-number-mode 1)
(setq column-number-mode t)

(add-hook 'text-mode-hook 'turn-on-auto-fill)

;;no tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 8)
;;indent 8 spaces
(setq-default c-basic-offset 8
                  tab-width 8
                  indent-tabs-mode t)

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
;;(kill-buffer "*Messages*")

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
(add-to-list `load-path "~/.emacs.d/custome/go-mode.el")
(require `go-mode-autoloads)
(require 'go-dlv)

(setq scroll-step            1
      scroll-conservatively  10000)

;; session
;;(require `session)
;;(add-hook 'after-init-hook 'session-initialize)

;;desktop
;;(load "desktop")
;;(desktop-load-default)
;;(desktop-read)

;;ibuffer
;(require 'ibuffer)
;(global-set-key (kbd "C-x C-b") 'ibuffer)

;; browse kill ring
;;(require 'browse-kill-ring)
;;(global-set-key [(control c)(k)] 'browse-kill-ring)
;;(browse-kill-ring-default-keybindings)

;; ido
;;(require 'ido)
;;(ido-mode t)

(mouse-avoidance-mode 'animate)
; file: ~/.emacs.d/init.el
;; High level aesthetic stuff
(setq visible-bell nil)             ; Disable annoying visual bell graphic
(setq ring-bell-function 'ignore)   ; Disable super annoying audio bell

;; Make keyboard bindings not suck
(setq mac-option-modifier 'super)
(setq mac-command-modifier 'meta)
(global-set-key "\M-c" 'copy-region-as-kill)
(global-set-key "\M-v" 'yank)
(global-set-key "\M-g" 'goto-line)

;; Set up package repositories so M-x package-install works.

(load-theme 'atom-one-dark t)       ; Color theme installed via melpa

;; Snag the user's PATH and GOPATH
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "GOPATH"))

;; Define function to call when go-mode loads
(defun my-go-mode-hook ()
  (add-hook 'before-save-hook 'gofmt-before-save) ; gofmt before every save
  (setq gofmt-command "goimports")                ; gofmt uses invokes goimports
  (if (not (string-match "go" compile-command))   ; set compile command default
      (set (make-local-variable 'compile-command)
           "go build -v && go test -v && go vet"))

  ;; guru settings
  (go-guru-hl-identifier-mode)                    ; highlight identifiers

  ;; Key bindings specific to go-mode
  (local-set-key (kbd "M-.") 'godef-jump)         ; Go to definition
  (local-set-key (kbd "M-*") 'pop-tag-mark)       ; Return from whence you came
  (local-set-key (kbd "M-p") 'compile)            ; Invoke compiler
  (local-set-key (kbd "M-P") 'recompile)          ; Redo most recent compile cmd
  (local-set-key (kbd "M-]") 'next-error)         ; Go to next error (or msg)
  (local-set-key (kbd "M-[") 'previous-error)     ; Go to previous error or msg

  ;; Misc go stuff
  (auto-complete-mode 1))                         ; Enable auto-complete mode

;; Connect go-mode-hook with the function we just defined
(add-hook 'go-mode-hook 'my-go-mode-hook)

;; Ensure the go specific autocomplete is active in go-mode.
(with-eval-after-load 'go-mode
   (require 'go-autocomplete))

(require 'go-dlv)

;; If the go-guru.el file is in the load path, this will load it.
;;(require 'me-alpheus-gotags)
;;(global-set-key (kbd "M-.") #'me.alpheus/gotags/tag-search)
;; a minor mode for highlighting empty space at end of lines
;;(require 'redspace-mode)
;; make the tab visible
;;(standard-display-ascii ?\t "^>>")
;;(defface extra-whitespace-face
;;  '((t (:background "pale green")))
;;  "Used for tabs and such.")
;;(defvar my-extra-keywords
;;  '(("\t" . 'extra-whitespace-face)))
;;(add-hook 'emacs-lisp-mode-hook
;;          (lambda () (font-lock-add-keywords nil my-extra-keywords)))
;;(add-hook 'text-mode-hook
;;          (lambda () (font-lock-add-keywords nil my-extra-keywords)))

;; Draw tabs with the same color as trailing whitespace
(add-hook 'font-lock-mode-hook
          (lambda ()
            (font-lock-add-keywords
             nil
             '(("\t" 0 'trailing-whitespace prepend)))))
;;basic kbd setting
(global-set-key (kbd "C-m") 'mark-word)
(global-set-key (kbd "C-j") 'left-word)
(global-set-key (kbd "C-l") 'right-word)

;; make life easier and this is yaml mode
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode))
(add-hook 'yaml-mode-hook
          (lambda ()
            (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

;;(global-set-key (kbd "<f6>") 'isearch-regexp)
;(define-key isearch-mode-map "<f5>" 'isearch-repeat-forward)
(global-set-key (kbd "<f6>") 'replace-string)
;;(define-key isearch--mode-map "<f8>" 'isearch-repeat-forward)

;; json mode
(require 'json-mode)

(provide 'setup-general)
