(define-module (nutguix packages)
  #:use-module (guix packages)
  #:use-module (guix build-system trivial)
  #:use-module (guix licenses)
  #:use-module (gnu packages fonts)
  #:use-module (gnu packages suckless)
  #:use-module (gnu packages wm))

;;;
;;; i3 (desktop) package
;;;
(define-public i3
  (package
    (name "i3")
    (version (package-version i3-wm))
    (source #f)
    (build-system trivial-build-system)
    (arguments
     '(#:modules ((guix build union))
       #:builder
       (begin
         (use-modules (ice-9 match)
                      (guix build union))
         (match %build-inputs
           (((names . directories) ...)
            (union-build (assoc-ref %outputs "out")
                         directories)
            #t)))))
    (inputs
     (list i3-wm
	   i3status
	   i3lock
	   gvfs
	   pcmanfm
	   polybar
	   dunst
	   st
	   dmenu))
    (propagated-inputs
     ;; Default font that applications such as IceCat require.
     (list font-dejavu))
    ;; (native-search-paths
    ;;  ;; For finding panel and thunar plugins.
    ;;  (append
    ;;   (package-native-search-paths xfce4-panel)
    ;;   (package-native-search-paths thunar)))
    (home-page "https://i3wm.org/")
    (synopsis "Desktop environment (meta-package)")
    (description
     "i3 is a tiling window manager, completely written from scratch. This package is an unofficial set of requirements.")
    (license bsd-3)))
