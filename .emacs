(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (disable-mouse go-mode auctex helm auto-complete autopair))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Me
(setq user-full-name "Ben Leroux")
(setq user-mail-address "benjamin.l@hotmail.fr")

;; Packages
(load "package")
(package-initialize)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) 

;; Minimal interface
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(toggle-frame-fullscreen)

;; Disable touchpad
(require 'disable-mouse)
(global-disable-mouse-mode)

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
(setq linum-format "%d ")
(global-linum-mode t)

;; Column numbers
(setq column-number-mode t)

;;Ido mode
(ido-mode 0)

;; Helm extended configuration
(require 'helm)
(require 'helm-config)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t
      helm-echo-input-in-header-line t)

(defun spacemacs//helm-hide-minibuffer-maybe ()
  "Hide minibuffer in Helm session if we use the header line as input field."
  (when (with-helm-buffer helm-echo-input-in-header-line)
    (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
      (overlay-put ov 'window (selected-window))
      (overlay-put ov 'face
                   (let ((bg-color (face-background 'default nil)))
                     `(:background ,bg-color :foreground ,bg-color)))
      (setq-local cursor-type nil))))


(add-hook 'helm-minibuffer-set-up-hook
          'spacemacs//helm-hide-minibuffer-maybe)

(setq helm-autoresize-max-height 0)
(setq helm-autoresize-min-height 20)
(helm-autoresize-mode 1)

(global-set-key (kbd "M-x") 'helm-M-x)

(global-set-key (kbd "M-y") 'helm-show-kill-ring)

(global-set-key (kbd "C-x b") 'helm-mini)

(global-set-key (kbd "C-x C-f") 'helm-find-files)

(helm-mode 1)

;; Unset C-v keybiding
(global-unset-key (kbd "C-v"))

;; Compile LaTex files
(global-set-key (kbd "s-1")
                (lambda ()
                  (interactive)
                  (save-buffer)
                  (shell-command "pdflatex -shell-escape main.tex > /dev/null")))

;; Autopair
(require 'autopair)
(autopair-global-mode t)

;; Auto-complete
(require 'auto-complete-config)
(ac-config-default)

;; Turn on fancy prompts in the shell
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; Turn off shell command echo
(defun my-comint-init () 
  (setq comint-process-echoes t)) 
(add-hook 'comint-mode-hook 'my-comint-init) 

;; LaTex
(setq LaTeX-indent-level 4)
(setq LaTeX-item-indent 0)
(setq LaTeX-newline 'reindent-then-newline-and-indent)
(add-hook 'LaTeX-mode-hook 'turn-on-auto-fill)

;; Message
(message "---> .emacs loaded <---")
