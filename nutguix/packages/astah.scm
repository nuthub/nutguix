;;; Copyright © 2023,2024 Julian Flake <flake@uni-koblenz.de>

(define-module (nutguix packages astah)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (nonguix build-system binary)
  #:use-module ((nonguix licenses) #:prefix license:)
  #:use-module (gnu packages base)
  #:use-module (gnu packages gcc))

(define-public astah-professional
  (package
   (name "astah-professional")
   (version "10.0.0.a1b9b1")
   (source
    (origin
     (method url-fetch)
     (uri (string-append
	   "https://cdn.change-vision.com/files/astah-professional_"
	   version
	   "-0_all.deb"))
     (sha256
      (base32
       "0gk4c5czn5k0hbgbhph6r4ra0z5v97r8w342hbgs8922ghws8j8x"))))
   (build-system binary-build-system)
   (inputs
    `(("gcc:lib" ,gcc "lib")))
   (arguments
    `(#:patchelf-plan
      '(("usr/lib/astah_professional/lib/rlm/librlm1601.so" ("gcc:lib"))
	("usr/lib/astah_professional/lib/rlm/x64/librlm1601.so" ("gcc:lib")))
      #:install-plan
      '(("usr/lib/" "lib")
	("usr/bin/" "bin")
	("usr/share/" "share"))))
   (synopsis "Astah Professional")
   (description
    "Full-Featured Software Modeling Tool for creating UML, ER Diagrams, DFD, Flowchart and more to create a clear understanding of your software design among teams. Easy-to-use UML2.x modeler.")
   (home-page "http://astah.net/products/astah-professional")
   (license (license:nonfree "file://lib/astah_professional/AstahLicenseAgreement-e.txt"))))
