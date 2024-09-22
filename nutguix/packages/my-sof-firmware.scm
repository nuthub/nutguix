(define-module (nutguix packages my-sof-firmware)
  #:use-module (guix packages)
  #:use-module (guix licenses)
  #:use-module (guix download)
  #:use-module (guix build-system copy))

(define-public my-sof-firmware
  (package
    (name "my-sof-firmware")
    (version "2024.06")
    (source
     (origin
       (method url-fetch)
       (uri (string-append "https://github.com/thesofproject/sof-bin/releases/download/v"
			   version "/sof-bin-" version ".tar.gz"))
       (sha256
	(base32
	 "1mnp0r1m1qgspgafqwxna90n9knxxclzcls9jnl3fs5mbcla672q"))))
    (build-system copy-build-system)
    (arguments
     `(#:install-plan
       '(("sof" "lib/firmware/intel/sof")
	 ;;	("sof-ace-tplg" "lib/firmware/intel/sof-ipc4-tplg")
	 ("sof-ipc4" "lib/firmware/intel/sof-ipc4")
	 ("sof-ipc4-tplg" "lib/firmware/intel/sof-ipc4-tplg")
	 ("sof-tplg" "lib/firmware/intel/sof-tplg"))))
    (home-page "https://www.sofproject.org")
    (synopsis "Sound Open Firmware")
    (description "This package contains Linux firmwares and topology files for
audio DSPs that can be found on the Intel Skylake architecture.  This
firmware can be built from source but need to be signed by Intel in order to be
loaded by Linux.")
    (license bsd-3)))
