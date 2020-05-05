;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'load-path "~/.emacs.d/custom")

(require 'setup-general)
(require 'setup-ivy-counsel)
(require 'setup-helm)
(require 'setup-helm-gtags)
;;(require 'setup-ggtags)
(require 'setup-cedet)
(require 'setup-editing)
(load-theme 'manoj-dark t)
;; function-args
(require 'function-args)
(fa-config-default)
(define-key c-mode-map  [(tab)] 'company-complete)
(define-key c++-mode-map  [(tab)] 'company-complete)

(setq whitespace-style (quote (spaces tabs newline space-mark tab-mark newline-mark)))
(setq whitespace-display-mappings
      ;; all numbers are Unicode codepoint in decimal. try (insert-char 182 ) to see it
      '(
        ;;(space-mark 32 [183] [46]) ; 32 SPACE, 183 MIDDLE DOT 「·」, 46 FULL STOP 「.」
        (newline-mark 10 [182 10]) ; 10 LINE FEED
        ;;(tab-mark 9 [9655 9] [92 9]) ; 9 TAB, 9655 WHITE RIGHT-POINTING TRIANGLE 「▷」
        ))
(windmove-default-keybindings)
;;(byte-recompile-directory "~/.emacs.d/" 0 t)
(setq python-shell-completion-native-enable nil)

;;settings for go
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (replace-regexp-in-string
                          "[ \t\n]*$"
                          ""
                          (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq eshell-path-env path-from-shell) ; for eshell users
    (setq exec-path (split-string path-from-shell path-separator)))
)

;;(when window-system (set-exec-path-from-shell-PATH))
(require 'go-mode-autoloads)
(setenv "GOPATH" "/Users/dong/go")
(require 'go-guru)
(add-hook 'go-mode-hook #'go-guru-hl-identifier-mode)
(add-to-list 'exec-path "/Users/dong/go/bin")
(defun my-go-mode-hook ()
; Call Gofmt before saving
  (add-hook 'before-save-hook 'gofmt-before-save)
; Godef jump key binding
  (local-set-key (kbd "M-.") 'godef-jump)
  (local-set-key (kbd "M-*") 'pop-tag-mark)
  )
(add-hook 'go-mode-hook 'my-go-mode-hook)

;;auto-complete
(defun auto-complete-for-go ()
  (auto-complete-mode 1))
(add-hook 'go-mode-hook 'auto-complete-for-go)
