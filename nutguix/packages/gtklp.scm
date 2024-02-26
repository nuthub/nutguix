;;; Copyright © 2024 Julian Flake <flake@uni-koblenz.de>

(define-module (nutguix packages gtklp)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system gnu)
  #:use-module (guix licenses)
  #:use-module (gnu packages base)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages cups)
  #:use-module (gnu packages gettext)
  #:use-module (gnu packages gtk))

(define-public gtklp
  (package
    (name "gtklp")
    (version "1.3.3")
    (source (origin
	      (method url-fetch)
	      (uri
	       (string-append
		"https://master.dl.sourceforge.net/project/gtklp/gtklp/" version
		"/gtklp-" version ".src.tar.gz"))
	      (sha256
	       (base32
		"1gzv5fjnlkzi6fjv0xwh8c21z12rb4lb6306pazmbs73p0i5q43f"))))
    (build-system gnu-build-system)
    (arguments
     (list
      #:configure-flags '(list "CFLAGS=-fcommon")
      #:phases
      '(modify-phases %standard-phases
	 (add-after 'unpack 'force-bootstrap
	   (lambda _ (delete-file "configure"))))))

    (inputs
     (list cups gtk+-2))
    (native-inputs
     (list autoconf automake gettext-minimal libtool pkg-config))
    (synopsis "A graphical Frontend to CUPS")
    (description
     "GtkLP is a graphical Frontend to CUPS. It is intended to be easy to use, small and it should compile on many UniX-Systems.")
    (home-page "https://sourceforge.net/projects/gtklp/")
    (license gpl2)))
