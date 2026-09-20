;;; Copyright © 2026 Julian Flake <julian@flake.de>

(define-module (nutguix packages emacs-xyz)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix build-system emacs)
  #:use-module (guix git-download))

(define-public emacs-ttl-ts-mode
  (package
   (name "emacs-ttl-ts-mode")
   (version "0.1")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://codeberg.org/nutcase/ttl-ts-mode")
           (commit version)))
     (file-name (git-file-name name version))
     (sha256
      (base32 "18wb7vdrrhc8zy5vi1dk7qzj552q7c5vmfm88p6gl76cgzdfmvfv"))))
   (build-system emacs-build-system)
   (arguments (list #:tests? #f))      ; No tests upstream.
   (home-page "https://codeberg.org/nutcase/ttl-ts-mode")
   (synopsis
    "Emacs Turtle and Notation 3 mode based on tree sitter grammar")
   (description
    "This package provides a tree-sitter based Emacs mode for editing
 Turtle (RDF) files, supporting indentation.")
   (license license:bsd-2)))

(define-public emacs-ttl-mode
;; There are warnings:
;; phase `compress-elisp' succeeded after 0.0 seconds
;; starting phase `build'
;; Compiling ‘ttl-mode-autoloads.el’
;; Compiling ‘ttl-mode-pkg.el’
;; Compiling ‘ttl-mode.el’

;; In toplevel form:
;; ttl-mode.el:1:1: Warning: file has no ‘lexical-binding’ directive on its first line
;; ttl-mode.el:67:12: Warning: custom-declare-variable ‘ttl-electric-punctuation’ docstring wider than 80 characters
;; ttl-mode.el:75:12: Warning: custom-declare-variable ‘ttl-indent-idle-timer-period’ docstring wider than 80 characters
;; ttl-mode.el:80:9: Warning: defvar ‘ttl-indent-idle-timer’ docstring wider than 80 characters

;; In ttl-propertize-comments:
;; ttl-mode.el:123:2: Warning: docstring wider than 80 characters

;; In ttl-adjusted-paren-depth:
;; ttl-mode.el:184:2: Warning: docstring wider than 80 characters

;; In ttl-skip-uninteresting-lines:
;; ttl-mode.el:207:29: Warning: ‘point-at-eol’ is an obsolete function (as of 29.1); use ‘line-end-position’ or ‘pos-eol’ instead.

  ;; No releases.
  (let ((commit "04b86536e0363a78c11ca10ac83096b28fc5fbf0")
        (revision "0"))
    (package
      (name "emacs-ttl-mode")
      (version (git-version "0.0.1" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/jeeger/ttl-mode")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "0il6in3vzp74sjrnw7h6w7pnh1xq2ix6xgiy1ags4z1yl8alhya4"))))
      (build-system emacs-build-system)
      (arguments (list #:tests? #f))      ; No tests upstream.
      (home-page "https://github.com/jeeger/ttl-mode")
      (synopsis
       "Emacs Turtle and Notation 3 mode")
      (description
       "This package provides an Emacs mode for editing Turtle (RDF)
files, supporting indentation some electric punctuation, and hungry
delete.")
      (license license:bsd-2))))
