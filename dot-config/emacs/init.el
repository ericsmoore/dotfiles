;;; -*- lexical-binding: t; -*-
;;

;; (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;;; default frame and startup
;;
(setq frame-resize-pixelwise t
      frame-inhibit-implied-resize 'force
      frame-title-format nil
      ns-use-proxy-icon nil
      ring-bell-function 'ignore
      inhibit-startup-screen t
      inhibit-startup-echo-area-message t
      initial-buffer-choice t ; scratch buffer
      inhibit-startup-buffer-menu t)

;;; appearance
;;
(set-face-attribute 'default nil :family "Input Mono" :height 200)
(set-face-attribute 'variable-pitch nil :family "Input Sans" :height 1.0)
(set-face-attribute 'fixed-pitch nil :family "Input Mono" :height 1.0)

(setq-default cursor-type 'bar)

(use-package doric-themes
  :ensure t
  :demand t
  :config
  (setq doric-themes-to-toggle '(doric-marble doric-obsidian))
  (doric-themes-select 'doric-obsidian))

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq scroll-conservatively 15
      scroll-margin 5)

;; modeline
(column-number-mode 1)
(setq mode-line-percent-position nil)

(setq resize-mini-windows t)

(defun esm/set-half-maximized ()
  (interactive)
  (set-frame-height nil 30)
  (set-frame-width nil 66))

;;; editing
;;
(setq mac-command-modifier 'control)

(setq use-short-answers t)

(setq indent-tabs-mode nil)

(add-hook 'java-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil)))

(global-auto-revert-mode 1)
(delete-selection-mode 1)
(electric-pair-mode 1)
(which-key-mode 1)

(use-package dired
  :ensure nil
  :hook (dired-mode . dired-omit-mode)
  :config
  (setq dired-kill-when-opening-new-dired-buffer t)
  (setq dired-listing-switches "-lah")
  (setq dired-dwim-target t)
  (setq dired-omit-files "\\.DS_Store"
	dired-omit-verbose nil))
 	
;; completion
(setq completion-auto-help nil
      tab-always-indent t)

(use-package cape
  :ensure t
  :init
  ;; Add to the global default value of `completion-at-point-functions' which is
  ;; used by `completion-at-point'.  The order of the functions matters, the
  ;; first function returning a result wins.  Note that the list of buffer-local
  ;; completion functions takes precedence over the global list.
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-abbrev))

(setq dabbrev-case-fold-search nil
      completion-ignore-case nil)

(use-package icomplete
  :ensure nil
  :init
  (fido-mode 1)
  :config
  (setq icomplete-show-matches-on-no-input t)
  (setq icomplete-prospects-height 1)
  (setq icomplete-separator ",  ")
  (setq icomplete-matches-format nil)
  (setq icomplete-tidy-shadowed-file-names t))

(use-package completion-preview
  :ensure nil
  :demand t
  :bind
  ( :map completion-preview-active-mode-map
    ("C-." . completion-preview-next-candidate)
    ("C-," . completion-preview-prev-candidate))
  :config
  (setq completion-preview-minimum-symbol-length 2)
  :hook (prog-mode))


(with-eval-after-load 'cc-mode
  (define-abbrev-table 'java-mode-abbrev-table
    '(("sysout" "System.out.println")
      ("psmain" "public static void main(String[] args)"))))
(remove-hook 'save-some-buffers-functions #'abbrev--possibly-save)

;;

(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))

;;; prose
;;

(use-package olivetti
  :ensure t
  :custom
  (olivetti-body-width 72))

(use-package org
  :ensure nil
  :hook
  (org-mode . visual-line-mode)
  (org-mode . org-indent-mode)
  :custom
  (org-list-allow-alphabetical t)
  (org-tags-column 0)
  (org-auto-align-tags nil))

(use-package markdown-mode
  :ensure t
  :hook (markdown-mode . visual-line-mode)
  :hook ())

(setq sentence-end-double-space nil)

;;; bindings
;;

;; fix mouse annoyances
(setq use-dialog-box nil
      use-file-dialog nil)
(global-set-key (kbd "<pinch>") 'ignore)
(global-set-key (kbd "<C-wheel-up>") 'ignore)
(global-set-key (kbd "<C-wheel-down>") 'ignore)

;;; clean up, clean up
;; ~/.cache/emacs/ (esm/cache-dir, from early-init.el).
(setq custom-file (make-temp-file "emacs-custom-")
      make-backup-files nil
      create-lockfiles nil
      auto-save-file-name-transforms `((".*" ,esm/cache-dir t))
      auto-save-list-file-prefix
      (expand-file-name "auto-save-list/.saves-" esm/cache-dir))

(make-directory (expand-file-name "auto-save-list/" esm/cache-dir) t)

(use-package savehist
  :custom (savehist-file (expand-file-name "savehist" esm/cache-dir))
  :init (savehist-mode 1))

(use-package recentf
  :custom
  (recentf-save-file (expand-file-name "recentf" esm/cache-dir))
  (recentf-max-saved-items 200)
  :init (recentf-mode 1))

(use-package saveplace
  :custom (save-place-file (expand-file-name "saveplace" esm/cache-dir))
  :init (save-place-mode 1))
;;;


(use-package tex
  :ensure auctex
  :defer t
  :hook ((LaTeX-mode . (lambda ()
                         (setq prettify-symbols-alist
                               (append '(("\\RR" . 8477)
                                         ("\\NN" . 8469)
                                         ("\\ZZ" . 8484)
                                         ("\\QQ" . 8474)
                                         ("\\CC" . 8450)
                                         ("\\HH" . 8461)
                                         ("\\GG" . 120126)
                                         ("\\FF" . 120125)
                                         ("\\varnothing" . 8709)
                                         ("\\colon" . 58))
                                       prettify-symbols-alist))
                         (prettify-symbols-mode 1)))
         (LaTeX-mode . LaTeX-math-mode)
         (LaTeX-mode . completion-preview-mode)
         (LaTeX-mode . (lambda () (setq TeX-command-force "LaTeX"))))
  :custom
  (TeX-master t)
  (TeX-save-query nil)
  (TeX-auto-save t)
  (TeX-parse-self t)
  (LaTeX-electric-left-right-brace t))

;;; init.el ends here
