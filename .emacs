(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(desktop-restore-frames nil)
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

;; Minimal interface
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

;; Custom theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'hickey t)

;; Windows move
(windmove-default-keybindings 'meta)

;; Revert buffers
(global-auto-revert-mode t)

;; Text settings
(delete-selection-mode t)
(transient-mark-mode t)
(setq x-select-enable-clipboard t)

;; Identation
(setq tab-width 4
      indent-tabs-mode nil)
(global-set-key (kbd "RET") 'newline-and-indent)

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

;; SMEX
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

;; Column numbers
(setq column-number-mode t)

;; Edit .xml files
(setq auto-mode-alist (cons '("\\.xml$" . nxml-mode) auto-mode-alist))
(autoload 'xml-mode "nxml" "XML editing mode" t)

;; IDO
(ido-mode t)

;; Autopair
(require 'autopair)
(autopair-global-mode t)

;; Origami settings (Code folding utility)
(global-origami-mode t)
(global-set-key (kbd "s-o f") 'origami-show-only-node)
(global-set-key (kbd "s-o s") 'origami-show-node)
(global-set-key (kbd "s-o c") 'origami-close-node-recursively)
(global-set-key (kbd "s-o t") 'origami-toggle-node)
(global-set-key (kbd "s-o p") 'origami-previous-fold)
(global-set-key (kbd "s-o n") 'origami-next-fold)

;; Auto-complete
(require 'auto-complete-config)
(ac-config-default)

;; TABBAR
(require 'tabbar)
(tabbar-mode t)
;; Key bidings
(global-set-key [C-M-left] 'tabbar-backward-tab)
(global-set-key [C-M-right] 'tabbar-forward-tab)
(global-set-key [C-M-up] 'tabbar-forward-group)
(global-set-key [C-M-down] 'tabbar-backward-group)
;; Sort tabs
(defun tabbar-add-tab (tabset object &optional append_ignored)
  (let ((tabs (tabbar-tabs tabset)))
    (if (tabbar-get-tab object tabset)
        tabs
      (let ((tab (tabbar-make-tab object tabset)))
        (tabbar-set-template tabset nil)
        (set tabset (sort (cons tab tabs)
                          (lambda (a b) (string< (buffer-name (car a)) (buffer-name (car b))))))))))

;; Shell
(setenv "PAGER" "/bin/cat")

;; Message
(message "---> .emacs loaded <---")
