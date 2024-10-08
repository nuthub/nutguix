;;; Copyright © 2024 Julian Flake <flake@uni-koblenz.de>

(define-module (nutguix packages wwan)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix licenses)
  #:use-module (guix build-system copy)
  #:use-module (gnu packages freedesktop))

(define-public modem-manager-fcc-auto-unlock

  (package
    (name "modem-manager-fcc-auto-unlock")
    (version "0.0.1")
    (source #f)
    (build-system copy-build-system)
    (inputs (list modem-manager))
    (arguments
     `(#:phases
       (modify-phases %standard-phases
	 (delete 'unpack)
	 (replace 'install
	   (lambda* (#:key inputs outputs #:allow-other-keys)
	     (let ((modem-manager (assoc-ref inputs "modem-manager"))
		   (out (assoc-ref outputs "out")))
	       (mkdir-p (string-append out "/etc/ModemManager/fcc-unlock.d/"))
	       (install-file
		(string-append
		 modem-manager
		 "/share/ModemManager/fcc-unlock.available.d/1eac")
		(string-append out "/etc/ModemManager/fcc-unlock.d/"))
	       (install-file
		(string-append
		 modem-manager
		 "/share/ModemManager/fcc-unlock.available.d/1eac:1001")
		(string-append out "/etc/ModemManager/fcc-unlock.d/"))))))))
    (synopsis "Activate automatic FCC unlock for Qectel Modems.")
    (description "Activate automatic FCC unlock for Qectel Modems by copying the relevant file into $profile/etc/ModemManager/fcc-unlock.d/")
    (home-page #f)
    (license #f)))
