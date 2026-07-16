;;; Copyright © 2026 Julian Flake <julian@flake.de>

(define-module (nutguix packages emacs-xyz)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix build-system emacs)
  #:use-module (guix git-download))

;; There is a PR with this package:
;; https://codeberg.org/guix/guix/pulls/9940
(define-public emacs-cypher-mode
  ;; There are no tagged releases upstream
  (let ((commit "ce8543d7877c736c574a17b49874c9dcdc7a06d6")
        (revision "0"))
  (package
    (name "emacs-cypher-mode")
    (version (git-version "0.0.6" revision commit)) ; from cypher-mode.el
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/fxbois/cypher-mode")
             (commit commit)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0vbcq807jpjssabmyjcdkpp6nnx1288is2c6x79dkrviw2xxw3qf"))))
    (build-system emacs-build-system)
    (arguments (list #:tests? #f)) ; no tests
    (home-page "https://github.com/fxbois/cypher-mode")
    (synopsis "Major mode for editing cypher scripts")
    (description "This package provides a major mode for cypher files, which
are used in the context of graph databases.")
    (license license:gpl2+))))

;; Waiting for an upstream release
(define-public emacs-just-mode
  (package
    (name "emacs-just-mode")
    (version "0.1.8")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/leon-barrett/just-mode.el")
             (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "103jwkmg3dphmr885rpbxjp3x8xw45c0zbcvwarkv4bjhph8y4vh"))))
    (build-system emacs-build-system)
    (arguments (list #:tests? #f)) ; no tests
    (home-page "https://github.com/leon-barrett/just-mode.el")
    (synopsis "Justfile editing mode")
    (description
     "This package provides a major mode for editing justfiles, as defined by the tool
\"just\": https://github.com/casey/just.")
    (license license:gpl3+)))

(define-public emacs-just-ts-mode
  (package
    (name "emacs-just-ts-mode")
    (version "0.1.9")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/leon-barrett/just-ts-mode.el")
             (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0gmimdy2isfmyf622926y3w0a0fxm1q98ry0lbqjjvhfq9i2h3mc"))))
    (build-system emacs-build-system)
    (arguments
     (list
      #:tests? #f)) ;no tests
    (home-page "https://github.com/leon-barrett/just-ts-mode.el")
    (synopsis "Justfile editing mode using TreeSitter")
    (description
     "This package provides a major mode for editing justfiles, as defined by
the tool \"just\" (https://github.com/casey/just), using a Tree-Sitter grammar
from tree-sitter-just (https://github.com/IndianBoy42/tree-sitter-just).")
    (license license:gpl3+)))
