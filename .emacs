(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Me
(setq user-full-name "Ben LRX")
(setq user-mail-address "benjamin.l@hotmail.fr")

;; Packages
(load "package")
(package-initialize)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) 

;; Minimal interface
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

;; Removes *Completions* from buffer after you've opened a file.
(add-hook 'minibuffer-exit-hook
      '(lambda ()
         (let ((buffer "*Completions*"))
           (and (get-buffer buffer)
                (kill-buffer buffer)))))

;; Custom theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'spolsky t)

;; Windows move
(windmove-default-keybindings 'meta)

;; Revert buffers
(global-auto-revert-mode t)

;; Text settings
(delete-selection-mode t)
(transient-mark-mode t)
(setq x-select-enable-clipboard t)
(show-paren-mode t)

;; Identation
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
;; C-style
(setq-default c-basic-offset 4)
(setq-default c-default-style "k&r")
;; Auto-indent new line
(global-set-key (kbd "RET") 'newline-and-indent)

;; C++ Comments 
(add-hook 'c++-mode-hook (lambda () (setq comment-start "/* "
                                          comment-end   " */")))
;; No backup files
(setq make-backup-files nil)

;; Yes or No
(defalias 'yes-or-no-p 'y-or-n-p)

;; Save sessions
(desktop-save-mode t)

;; Kill emacs
(global-set-key (kbd "C-x C-c") 'kill-emacs)

;; End of buffer
(global-set-key (kbd "C-<menu>") 'end-of-buffer)

;; Display time and battery level
(display-time-mode t)
(display-battery-mode t)

;; Line numbers
(global-linum-mode t)
(setq linum-format "%d ")

;; SMEX
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

;; Column numbers
(setq column-number-mode t)

;;Ido mode
(ido-mode t)

;; Autopair
(require 'autopair)
(autopair-global-mode t)

;; Auto-complete
(require 'auto-complete-config)
(ac-config-default)

;; Message
(message "---> .emacs loaded <---")
