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
