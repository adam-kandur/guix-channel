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
     `(#:asd-systems '("lem")
       #:phases
       (modify-phases %standard-phases
         (add-after 'unpack 'set-home
             (lambda _
               (setenv "HOME" "/tmp")))
         (replace 'build
           (lambda* (#:key inputs #:allow-other-keys)
             (let ((ql-setup (string-append
                              (assoc-ref inputs "sbcl-quicklisp")
                              "/share/common-lisp/sbcl/quicklisp/ql-setup.lisp")))
               (invoke
                "sbcl"
                "--noinform"
                "--non-interactive"
                "--no-userinit"
                "--eval" "(require :asdf)"
                "--eval" "(pushnew (uiop:getcwd) asdf:*central-registry*)"
                "--load" ql-setup)))))))
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
           sbcl-trivia
           sbcl-quicklisp))
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
       `(#:tests? #f
         #:phases
         (modify-phases %standard-phases
           (add-after 'unpack 'set-home
             (lambda _
               (setenv "HOME" "/tmp")))
           (add-after 'set-home 'mv-setup-lisp-to-quicklisp
             (lambda _
               (invoke "mv" "setup.lisp" "quicklisp/ql-setup.lisp")))
           (add-after 'mv-setup-lisp-to-quicklisp 'cd-sdl
             (lambda _
               (chdir "quicklisp")
               #t))
           (add-after 'cd-sdl 'fix-setup
              (lambda _
                (substitute* "ql-setup.lisp"
                  (("\\(ensure-asdf-loaded\\)") "")
                  (("\\(let \\(\\(asdf-init \\(probe-file \\(qmerge \"asdf-config/init\\.lisp\"\\)\\)\\)\\)")
                   "")
                  (("  \\(when asdf-init") "")
                  (("    \\(with-simple-restart \\(skip \"Skip loading ~S\" asdf-init\\)") "")
                  (("      \\(load asdf-init :verbose nil :print nil\\)\\)\\)\\)") "")
                  (("\\(push \\(qmerge \"quicklisp/\"\\) asdf:\\*central-registry\\*\\)") "")
                  (("\\(let \\(\\(\\*compile-print\\* nil\\)") "")
                  (("      \\(\\*compile-verbose\\* nil\\)") "")
                  (("      \\(\\*load-verbose\\* nil\\)") "")
                  (("      \\(\\*load-print\\* nil\\)\\)") "")
                  (("  \\(asdf:oos 'asdf:load-op \"quicklisp\" :verbose nil\\)\\)") "")
                  (("\\(quicklisp:setup\\)") "")
                  )))
           (replace 'build
             (lambda* (#:key outputs #:allow-other-keys)
               (let ((bin (string-append (assoc-ref outputs "out") "/bin")))
                 (invoke
                  "sbcl"
                  "--noinform"
                  "--non-interactive"
                  "--no-userinit"
                  "--eval" "(require :asdf)"
                  "--eval" "(pushnew (uiop:getcwd) asdf:*central-registry*)"
                  "--load" "ql-setup.lisp")))))))
      (synopsis "")
      (description "")
      (home-page "")
      (license #f))))
