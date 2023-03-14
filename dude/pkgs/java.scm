(define-module (dude pkgs java)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (gnu packages java)
  #:use-module (guix git-download)
  #:use-module (guix build-system ant))

(define-public java-hello-world
  (let* ((revision "0")
         (commit "f345bc49d7cc90f4599b7c4843755b4757f05739"))
    (package
      (name "java-hello-world")
      (version (git-version "0.1" revision commit))
      (source (origin
                (method git-fetch)
                (uri (git-reference
                      (url "https://github.com/adam-kandur/java-hello-world")
                      (commit commit)))
                (file-name (git-file-name name version))
                (sha256
                 (base32
                  "0wgrw89g8hpdlkp6gmfnijzi9954l6p5w0l57cyqv7lmz7rvxs4v"))))
      (build-system ant-build-system)
      (arguments
       `(#:jdk ,openjdk11
         #:tests? #f
         #:phases
         (modify-phases %standard-phases
           (replace 'install
             (lambda* (#:key inputs outputs #:allow-other-keys)
               (let* ((share (string-append (assoc-ref outputs "out") "/share/java"))
                      (jar-name "hello-world.jar")
                      (jar (string-append ,tlatools
                                          "/dist/" jar-name))
                      ;; (java-cp (string-append share "/" jar-name))
                      ;; (bin (string-append (assoc-ref outputs "out") "/bin"))
                      ;; (java (search-input-file inputs "/bin/java")))
                      )
                 (install-file jar share)))))))
      (home-page "")
      (synopsis "")
      (description "")
      (license #f))))
