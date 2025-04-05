;;; Copyright © 2024 Julian Flake <flake@uni-koblenz.de>

(define-module (nutguix packages fonts)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix licenses)
  #:use-module (guix build-system copy)
  #:use-module (gnu packages compression))

;; The build scripts of version 5 (and 6?) are not freely licensed and
;; GNU Guix has to stick with version 4 for now:
;; <https://bugs.gnu.org/32916>
(define-public font-awesome6
  (package
    (name "font-awesome6")
    (version "6.6.0")
    (source (origin
	      (method url-fetch)
	      (uri
	       (string-append
		"https://github.com/FortAwesome/Font-Awesome/releases/download/"
		version "/fontawesome-free-" version "-desktop.zip"))
	      (sha256
	       (base32
		"0z06176z68q52ymi3ggv39m4dzq3akikw9j410ryw67j8bs9pplc"))))
    (inputs (list unzip))
    (build-system copy-build-system)
    (arguments
     `(#:install-plan
       '(("otfs/" "/share/fonts/opentype/"))))
    (synopsis "Font that contains a rich iconset")
    (description
     "Font Awesome is a full suite of pictographic icons for easy scalable
vector graphics.")
    (home-page "https://github.com/FortAwesome/Font-Awesome")
    (license silofl1.1)))
