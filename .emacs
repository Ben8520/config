;; Me
(setq user-full-name "Ben Leroux")
(setq user-mail-address "benjamin.leroux@outlook.fr")

;; Packages
(load "package")
(package-initialize)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

;; Minimal interface
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(toggle-frame-fullscreen)

;; Disable touchpad
(global-disable-mouse-mode)

;; Removes *Completions* from buffer after you've opened a file.
(add-hook 'minibuffer-exit-hook
      '(lambda ()
         (let ((buffer "*Completions*"))
           (and (get-buffer buffer)
                (kill-buffer buffer)))))

;; Custom theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(if (display-graphic-p) 
    (load-theme 'spolsky t)
  (load-theme 'tango-dark t))

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

;; No backup files
(setq make-backup-files nil)

;; Yes or No
(defalias 'yes-or-no-p 'y-or-n-p)

;; Save sessions
(if (display-graphic-p) 
    (desktop-save-mode t)
  (desktop-save-mode nil))

;; Kill emacs
(global-set-key (kbd "C-x C-c") 'kill-emacs)

;; Display time and battery level
(display-time-mode t)
(display-battery-mode t)

;; Line numbers
(setq linum-format "%d ")
(global-linum-mode t)

;; Column numbers
(setq column-number-mode t)

;;Ido mode
(ido-mode 1)

;; Autopair
(autopair-global-mode t)

;; Auto-complete
(ac-config-default)

;; Message
(message "---> .emacs loaded <---")
