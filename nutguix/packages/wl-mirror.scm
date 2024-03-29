;;; Copyright © 2024 Julian Flake <flake@uni-koblenz.de>

(define-module (nutguix packages wl-mirror)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system cmake)
  #:use-module (guix build-system gnu)
  #:use-module (guix gexp)
  #:use-module (gnu packages base)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages freedesktop))

(define-public wlr-protocols
  (let ((revision "3")
	(commit "2b8d43325b7012cc3f9b55c08d26e50e42beac7d"))
    (package
      (name "wlr-protocols")
      (version (git-version "0" revision commit))
      (source (origin
		(method git-fetch)
		(uri (git-reference
		      (url "https://gitlab.freedesktop.org/wlroots/wlr-protocols.git")
		      (commit commit)))
		(sha256
		 (base32
		  "17blwww6rcrahwc6h6j68gh6wjbj14if3mihpxymfdw5pwl72rav"))))
      (build-system gnu-build-system)
      (arguments
       '(#:make-flags (list
                       (string-append "PREFIX=" (assoc-ref %outputs "out")))
         #:phases (modify-phases %standard-phases
		    (delete 'configure))))
      (inputs
       (list wayland))
      (home-page "https://gitlab.freedesktop.org/wlroots/wlr-protocols")
      (synopsis "Wayland protocols designed for use in wlroots (and other compositors).")
      (description
       "Wayland protocols designed for use in wlroots (and other compositors).")
      (license license:expat))))

(define-public wl-mirror
  (package
    (name "wl-mirror")
    (version "0.16.2")
    (source (origin
              (method git-fetch)
	      (uri (git-reference
		    (url "https://github.com/Ferdi265/wl-mirror")
		    (commit (string-append "v" version))))
	      (sha256
	       (base32
		"1jdycr9vf5skbf55kbm2hc3zl3qg58x3bb6xqkf9qx14m4ramcdj"))))
    (build-system cmake-build-system)
    (arguments
     (list
      #:tests? #f
      #:configure-flags
      #~(list "-DFORCE_SYSTEM_WL_PROTOCOLS=ON"
	      (string-append "-DWL_PROTOCOL_DIR="
                             #$(this-package-input "wayland-protocols") "/share/wayland-protocols")
	      "-DFORCE_SYSTEM_WLR_PROTOCOLS=ON"
	      (string-append "-DWLR_PROTOCOL_DIR="
                             #$(this-package-input "wlr-protocols") "/share/wlr-protocols"))))
    (inputs
     (list pkg-config egl-wayland mesa wayland wayland-protocols wlr-protocols))
    (home-page "https://github.com/Ferdi265/wl-mirror")
    (synopsis "A simple Wayland output mirror client")
    (description
     "wl-mirror attempts to provide a solution to sway's lack of output mirroring by mirroring an output onto a client surface.")
    (license license:gpl3)))
