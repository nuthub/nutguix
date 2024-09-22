;;; Copyright © 2024 Julian Flake <flake@uni-koblenz.de>

(define-module (nutguix packages lenovo-wwan-unlock)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system copy)
  #:use-module ((nonguix licenses) #:prefix license:)
  #:use-module (gnu packages base))

(define-public lenovo-wwan-unlock

  (package
   (name "lenovo-wwan-unlock")
   (version "2.1.2")
   (source
    (origin
     (method url-fetch)
     (uri (string-append
	   "https://github.com/lenovo/lenovo-wwan-unlock/archive/refs/tags/v" version ".tar.gz"))
     (sha256
      (base32
       "02ql8d4d7wqpmwc01imn1xqr8b5dnlz0sg7c1cg559qag6l1akm3"))))
   (build-system copy-build-system)
   (inputs (list binutils tar))
   (arguments
    '(#:install-plan
      '(("fcc-unlock.d/" "/etc/ModemManager/fcc-unlock.d/"))
      #:phases
      (modify-phases %standard-phases
		     (add-after 'unpack 'getscripts
				(lambda* (#:key outputs #:allow-other-keys)
				  (invoke "tar" "xzf" "fcc-unlock.d.tar.gz"))))))
   (synopsis "FCC and DPR unlock for Lenovo PCs")
   (description
    "FCC and DPR unlock for Lenovo PCs for use by modem-manager")
   (home-page "https://github.com/lenovo/lenovo-wwan-unlock")
   (license (license:nonfree "https://github.com/lenovo/lenovo-wwan-unlock/blob/main/Lenovo%20Software%20Code%20License%20Agreement%20for%20wwan.txt"))))