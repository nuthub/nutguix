;;; Copyright © 2023,2024 Julian Flake <flake@uni-koblenz.de

(define-module (nutguix packages astah)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix download)
  #:use-module (nonguix build-system binary)
  #:use-module (guix build-system copy)
  #:use-module ((nonguix licenses) #:prefix license:)
  #:use-module (gnu packages base)
  #:use-module (gnu packages gcc))

;; I'm using the deb package, because it already has some kind of install plan.
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
    (synopsis "Astah Professional, an Easy-to-use UML2.x modeler")
    (description
     "Full-Featured Software Modeling Tool for creating UML, ER Diagrams, DFD, Flowchart and more to create a clear understanding of your software design among teams.")
    (home-page "http://astah.net/products/astah-professional")
    (license (license:nonfree "file://lib/astah_professional/AstahLicenseAgreement-e.txt"))))

;; Simply setting the license file via Astah's GUI doesn't work, because $GUIX_PROFILE/lib/astah_professional directory (aka astah install directory) is not writable.
;; Therefore, the license file needs to be packaged, in order to be able to place it in the $GUIX_PROFILE/lib/astah_professional
;; During build time, the license file needs to be found at file:/tmp/astah_professional_license.xml (it must not ne shared with the public)
(define-public astah-professional-license
  (package
    (name "astah-professional-license")
    (version "2024-11")
    (source
     (origin
       (method url-fetch)
       ;; this must not shared with the public, but must be available during building the package
       (uri "file:/tmp/astah_professional_license.xml")
       (sha256
	(base32 "17lpr1kzyhbyjkas8ycssx67r16dlamrjbs24hrw6h4km0rz8rq5"))))
    (build-system copy-build-system)
    (arguments
     (list
      #:install-plan #~'(("astah_professional_license.xml" "lib/astah_professional/astah_professional_license.xml"))))
    (synopsis "Astah Professional faculty license")
    (description "valid one year?")
    (home-page "http://astah.net/products/astah-professional")
    (license #f)))

;; It's not sufficient to just install the license into $GUIX_PROFILE/lib/astah_professional. Astah does not recognize the file, probably because it links to another directory in the store.
;; Therefore, I create a new package that takes the license file as build input and copies the license file in the resulting package, which effectively is astah-professional + astah-professional-license
(define-public astah-professional-licensed
  (package
    (inherit astah-professional)
    (name "astah-professional-licensed")
    (version "10.0.0.a1b9b1")
    (inputs `(("gcc:lib" ,gcc "lib")
	      ("astah-professional-license" ,astah-professional-license)))
    (arguments
     `(#:patchelf-plan
       '(("usr/lib/astah_professional/lib/rlm/librlm1601.so" ("gcc:lib"))
	 ("usr/lib/astah_professional/lib/rlm/x64/librlm1601.so" ("gcc:lib")))
       #:install-plan
       '(("usr/lib/" "lib")
	 ("usr/bin/" "bin")
	 ("usr/share/" "share"))
       #:phases (modify-phases %standard-phases
		  (add-after 'install 'add-license
		    (lambda* (#:key inputs #:allow-other-keys)
		      (let* ((lic-file "astah_professional_license.xml")
			     (lib-dir "/lib/astah_professional/"))
			(copy-file
			 (string-append (assoc-ref inputs "astah-professional-license") lib-dir lic-file)
			 (string-append (assoc-ref %outputs "out") lib-dir lic-file)))
		      #t)))))
    (synopsis "Astah Professional (with license file), an Easy-to-use UML2.x modeler")))
