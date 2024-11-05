;;; Copyright © 2024 Julian Flake <flake@uni-koblenz.de>

(define-module (nutguix packages eclipse))

(use-modules (gnu)
	     (guix packages)
	     (guix download)
	     (guix build-system copy)
	     (guix licenses))

(define-public eclipse-mdt
  (let
      ((mirror "https://ftp.halifax.rwth-aachen.de")
       (version "2024-09"))
    (package
      (name "eclipse-mdt")
      (version version)
      (source
       (origin
	 (method url-fetch)
	 (uri (string-append
	       mirror
	       "/eclipse/technology/epp/downloads/release/"
	       version
	       "/R/eclipse-modeling-"
	       version
	       "-R-linux-gtk-x86_64.tar.gz"))
	 (sha256
	  (base32
	   "09n12snlzl4x1hd8ndfsx3bbggnw0qs3xj9x42ibjl2x08shjp00"))))
      (build-system copy-build-system)
      (synopsis "Eclipse Modeling Tools")
      (description
       "Eclipse Modeling Tools.")
      (home-page "https://www.eclipse.org/")
      (license epl2.0))))
