(require 'package)

(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
	     '("gnu" . "https://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives
	     '("org" . "https://orgmode.org/elpa/") t)

(unless package-archive-contents
  (package-refresh-contents))

(package-initialize)

(menu-bar-mode -1)
(tool-bar-mode -1)
(line-number-mode +1)
(global-display-line-numbers-mode 1)
(scroll-bar-mode -1)
(global-hl-line-mode 1)
(show-paren-mode 1)

(setq inhibit-startup-screen t)
(setq make-backup-files nil)
(setq auto-save-default nil)

(fset 'yes-or-no-p 'y-or-n-p)

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(setq use-package-verbose t)
(setq use-package-always-ensure t)

(eval-when-compile
  (require 'use-package)
  (require 'delight))

(defun my-reload-my-emacs-config ()
  "Reload init.el"
  (interactive)
  (load-file "~/.emacs.d/init.el"))

(use-package doom-themes
	     :config
	     (load-theme 'doom-outrun-electric t)
	     )

(set-frame-font "Liberation Mono 14" nil t)

(use-package all-the-icons
  :if (display-graphic-p))

(use-package helm
  :delight
  :init
  (helm-mode 1)
  :config
  (progn
    (setq helm-idle-delay 0.0
	  helm-input-idle-delay 0.01
	  helm-quick-update t))
  :bind
  (("C-x C-f" . helm-find-files)
   ("M-x" . helm-M-x)
   ("C-x b" . helm-buffers-list)
   ))

(use-package which-key
  :delight
  :init
  (which-key-mode 1)
  :config
  (progn
    (setq which-key-show-early-on-C-h t)
    (setq which-key-idle-delay 10000)
    (setq which-key-idle-secondary-delay 0.05)
    ))

(use-package which-key-posframe
  :init
  (which-key-posframe-mode 1)
  )

(use-package yasnippet
  :delight
  :init
  (yas-global-mode 1)
  )

(use-package flycheck
  :delight
  :init
  (global-flycheck-mode)
  :config
  (setq flycheck-clang-args '("-std=c++17"))
  :bind (:map flycheck-mode-map
	      ("M-n" . flycheck-next-error)
	      ("M-p" . flycheck-previous-error)
	      ))

(use-package lsp-mode
  :delight
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (progn
    (setq lsp-headerline-breadcrumb-enable t)
    (setq gc-cons-threshold 100000000)
    (setq read-process-output-max (* 1024 1024)) ;; 1mb
    (setq lsp-idle-delay 0.500)
    (setq lsp-prefer-flymake nil)
    (setq lsp-rust-server 'rust-analyzer)
    (setq lsp-rust-analyzer-cargo-watch-command "clippy"))
  :hook
  ((lsp-mode . lsp-enable-which-key-integration))
  )

(use-package lsp-ui
  :commands lsp-ui-mode
  :after lsp-mode
  :delight
  :hook
  ((lsp-ui-doc-frame-mode . (lambda()(display-line-numbers-mode -1))))
  :bind (:map lsp-ui-mode-map
	      ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
	      ([remap xref-find-references] . lsp-ui-peek-find-references)
	      ("C-c u" . lsp-ui-imenu))
  :init
  (setq lsp-ui-peek-always-show t)
  (setq lsp-ui-doc-delay 0.5)
  (setq lsp-ui-show-hover nil)
  (setq lsp-ui-sideline-enable t)
  (setq lsp-ui-sideline-show-code-actions t)
  )

(use-package company
  :delight
  :config
  (progn
    (setq company-idle-delay 0)
    (setq company-minimum-prefix-length 1)
    (setq company-tooltip-align-annotations t)
    )
  :hook
  ((lsp-mode . company-mode))
  )

(use-package company-box
  :delight
  :config
  (progn
    (setq company-box-doc-delay 2.0)
    )
  :hook
  ((company-mode . company-box-mode))
  )

(use-package rust-mode
  :hook
  ((rust-mode . lsp-deferred)
   )
  )


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(lsp-ui company-box company lsp-mode flycheck yasnippet which-key-posframe which-key helm doom-themes use-package delight)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
