(define-module (dude pkgs lisp)
  #:use-module (gnu packages)
  #:use-module (gnu packages lisp-xyz)
  #:use-module (guix gexp)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system asdf))

(define-public lem
  (package
    (name "lem")
    (version "v2.0.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/lem-project/lem")
             (commit version)))
       (file-name (git-file-name "lem" version))
       (sha256
        (base32
         "08iv7b4m0hh7qx2cvq4f510nrgdld0vicnvmqsh9w0fgrcgmyg4k"))))
    (build-system asdf-build-system/sbcl)
    ;; (inputs
    ;;  (list sbcl-alexandria sbcl-anaphora))
    ;; (native-inputs
    ;;  (list sbcl-lift))
    (synopsis "")
    (description "")
    (home-page "")
    (license #f)))
