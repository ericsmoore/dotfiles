;;; -*- lexical-binding: t; -*-

;; set up default frame, maximized and without ui junk
(push '(fullscreen . maximized) default-frame-alist)
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

;; garbage collector tweak for startup?
(setq gc-cons-threshold most-positive-fixnum)
(add-hook 'emacs-startup-hook
          (lambda () (setq gc-cons-threshold (* 64 1024 1024))))

;; another startup tweak idk
(defvar my/saved-file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)
(add-hook 'emacs-startup-hook
          (lambda ()
	    (setq file-name-handler-alist my/saved-file-name-handler-alist)))

;; set up cache directory now since native comp must be caught before compile
(defconst esm/cache-dir (expand-file-name "~/.cache/emacs/"))

(when (and (fboundp 'native-comp-available-p)
           (native-comp-available-p))
  (startup-redirect-eln-cache
   (expand-file-name "eln-cache" esm/cache-dir))
  (setq native-comp-async-report-warnings-errors 'silent))
