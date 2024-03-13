;;; Copyright © 2023 Julian Flake <flake@uni-koblenz.de>

(define-module (nutguix packages astah)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system copy)
  #:use-module ((nonguix licenses) #:prefix license:)
  #:use-module (gnu packages base)
  #:use-module (gnu packages java))

;; Getting the binary:
;;
;; guix download https://cdn.change-vision.com/files/astah-professional_9.0.0.1778f1-0_all.deb
;; ar x wga0hq1569ki48amhhv7rs5zk8a2rr0j-astah-professional_9.0.0.1778f1-0_all.deb
;; xz -d data.tar.xz

(define-public astah-professional

  (package
   (name "astah-professional")
   (version "9.2.0.0248cd")
   (source
    (origin
     (method url-fetch)
     (uri "https://members.change-vision.com/files/_EfTycaWjuxKxIiqxCcIZ68vJNAY22QdY/astah_professional/9_2_0/astah-professional_9.2.0.0248cd-0_all.deb")
     (sha256
      (base32
       "1nqccj4dh53ll5drxf4pj74ab52c31zw8hbs6kw7g51x7fi3wy59"))))
   (build-system copy-build-system)
   (inputs (list binutils))
   (propagated-inputs (list icedtea))
   (arguments
    '(#:install-plan
      '(("usr/" "/"))
      #:phases
      (modify-phases %standard-phases
		     (replace 'unpack
			      (lambda* (#:key source #:allow-other-keys)
				(invoke "ar" "x" source)
				(invoke "tar" "xf" "data.tar.xz"))))))
   (synopsis "Astah Professional")
   (description
    "Full-Featured Software Modeling Tool for creating UML, ER Diagrams, DFD, Flowchart and more to create a clear understanding of your software design among teams.Easy-to-use UML2.x modeler")
   (home-page "http://astah.net/products/astah-professional")
   (license (license:nonfree "file://lib/astah_professional/AstahLicenseAgreement-e.txt"))))

