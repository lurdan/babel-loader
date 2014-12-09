;;;  -*- coding: utf-8; mode: emacs-lisp; -*-
;;; babel-loader.el --- init-loader with Babel.

;; Copyright (C) 1992 Free Software Foundation, Inc.

;; Author: Ryo TAKAISHI <ryo.takaishi.0@gmail.com>
;; Created 25 Aug 2012
;; Version 0.1

;; This file is part of GNU Emacs.
;; This help to load your config file written by Babel.
;; Babel is org-mode's ability to execute source code within org-mode documents.

;; Code goes here

(require 'init-loader)
(require 'ob)

(defun bl:compile (file exported-file)
  (if (file-newer-than-file-p file exported-file)
      (org-babel-tangle-file file exported-file "emacs-lisp")))

(defun bl:compile-dir (dir)
  (mapc #'(lambda (file)
            (let* ((base-name (file-name-sans-extension file))
                   (exported-file (concat base-name ".el")))
              (bl:compile file exported-file)))
        (directory-files dir t "\\.org$")))

(defun bl:load-dir (dir)
  (progn
    (bl:compile-dir dir)
    (init-loader-load dir)))

(provide 'babel-loader)

;;; babel-loader.el ends here
