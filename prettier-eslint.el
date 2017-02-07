;;; prettier-eslint.el --- Autoformat javascript files with prettier-eslint

;; Copyright (C) 2017 Arseny Zarechnev
;; This package uses the MIT License.
;; See the LICENSE file.

;; Author: Arseny Zarechnev <me@evindor.com> (twitter.com/evindor)
;; Version: 1.0
;; Package-Requires: ()
;; Keywords: javascript, prettier, prettier-eslint, eslint, lint, formatting, style
;; URL: https://github.com/evindor/prettier-eslint-emacs

;;; Commentary:
;;
;; This file provides `prettier-eslint', which fixes the current file using prettier-eslint
;; https://github.com/kentcdodds/prettier-eslint-cli
;;
;; Usage:
;;     M-x prettier-eslint
;;
;;     To automatically format after saving:
;;
;;     (add-hook 'js2-mode-hook (lambda () (add-hook 'after-save-hook 'prettier-eslint nil t)))
;;     (add-hook 'react-mode-hook (lambda () (add-hook 'after-save-hook 'prettier-eslint nil t)))
;;
;;     In Spacemacs add the above to your dotspacemacs/user-config
;;
;;     Otherwise:
;;
;;     (eval-after-load 'js2-mode
;;       '(add-hook 'js2-mode-hook (lambda () (add-hook 'after-save-hook 'prettier-eslint nil t))))
;;

;;; Code:
;;;###autoload

(defvar prettier-eslint/single-quote t
  "Not nil:
Use --single-quote option for prettier")

(defvar prettier-eslint/trailing-comma nil
  "Not nil:
Use --trailing-comma option for prettier")

(defvar prettier-eslint/no-bracket-spacing nil
  "Not nil:
Use --bracket-spacing=false option for prettier")

(defun prettier-eslint/binary ()
  (or
   ;; Try to find bin in node_modules (via 'npm install prettier-eslint-cli')
    (let ((root (locate-dominating-file buffer-file-name "node_modules")))
      (if root
          (let ((prettier-binary (concat root "node_modules/.bin/prettier-eslint")))
            (if (file-executable-p prettier-binary) prettier-binary))))
    ;; Fall back to a globally installed binary
    (executable-find "prettier-eslint")
    ;; give up
    (error "Couldn't find a prettier-eslint executable")))

;; TODO account for options
(defun prettier-eslint/options ()
  (let ((options '()))
    (when prettier-eslint/single-quote
      (push "--single-quote" options))
    (when prettier-eslint/trailing-comma
      (push "--trailing-comma" options))
    (when prettier-eslint/no-bracket-spacing
      (push "--bracket-spacing=false" options))
    options
    ))

(defun prettier-eslint ()
  "Format the current file with ESLint."
  (interactive)
  (let ((options (prettier-eslint/options)))
        (progn (call-process
                (prettier-eslint/binary)
                nil "*Prettier-ESLint Errors*" nil
                buffer-file-name "--write" "--single-quote"
                "--trailing-comma" "--bracket-spacing=false")
               (revert-buffer t t t))))


(provide 'prettier-eslint)

;;; prettier-eslint.el ends here
