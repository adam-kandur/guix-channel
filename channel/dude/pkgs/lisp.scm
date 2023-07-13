(define-module (dude pkgs lisp)
  #:use-module (gnu packages)
  #:use-module (gnu packages lisp-xyz)
  #:use-module (gnu packages lisp-check)
  #:use-module (guix gexp)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system asdf))

(define-public lem
  (package
    (name "lem")
    (version "2.0.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/lem-project/lem")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32
         "1hwgl43mjwzvbcamdiqs8jv8961mp3hiar15cjcz3xwc5bdqwvi2"))))
    (build-system asdf-build-system/sbcl)
    (arguments
     `(#:asd-systems '("lem")))
    (native-inputs
     (list sbcl-dexador))
    (inputs
     (list sbcl-alexandria
           sbcl-trivial-gray-streams
           sbcl-trivial-types
           sbcl-trivial-types
           sbcl-cl-ppcre
           sbcl-inquisitor
           sbcl-bordeaux-threads
           sbcl-yason
           sbcl-log4cl
           sbcl-split-sequence
           sbcl-closer-mop
           sbcl-trivia))
    (synopsis "")
    (description "")
    (home-page "")
    (license #f)))

(define-public sbcl-inquisitor
  (let ((revision "0")
        (commit "423fa9bdd4a68a6ae517b18406d81491409ccae8"))
    (package
      (name "sbcl-inquisitor")
      (version (git-version "0.1" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/t-sin/inquisitor")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32
           "08rkmqnwlq6v84wcz9yp31j5lxrsy33kv3dh7n3ccsg4kc54slzw"))))
      (build-system asdf-build-system/sbcl)
      (arguments
       `(#:asd-systems '("inquisitor")))
      (native-inputs
       (list sbcl-prove))
      (inputs
       (list sbcl-alexandria
             sbcl-anaphora
             sbcl-babel))
      ;;        sbcl-trivial-gray-streams
      ;;        sbcl-trivial-types
      ;;        sbcl-trivial-types
      ;;        sbcl-cl-ppcre))
      ;; (inputs
      ;;  (list sbcl-alexandria sbcl-anaphora))
      ;; (native-inputs
      ;;  (list sbcl-lift))
      (synopsis "")
      (description "")
      (home-page "")
      (license #f))))

(define-public sbcl-quicklisp
  (let ((revision "0")
        (commit "10b61e5220ba20bfdd88c1086d2523bd29414a8b"))
    (package
      (name "sbcl-quicklisp")
      (version (git-version "0.1" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/quicklisp/quicklisp-client")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32
           "0rafdzp67mwq5s2qw8afhh29n4hv1l83qnmvy20s6l00ryxh0p8y"))))
      (build-system asdf-build-system/sbcl)
      (arguments
       `(#:asd-systems '("quicklisp")
         #:phases
         (modify-phases %standard-phases
           (add-after 'unpack 'cd-sdl
             (lambda _
               (chdir "quicklisp")
               #t)))))
      (synopsis "")
      (description "")
      (home-page "")
      (license #f))))
