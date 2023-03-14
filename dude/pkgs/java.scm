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
                  "1hhx8gmn81k8qrkx4p7ppinmygxga9fqffd626wkvhjgg2ky8lhs"))))
      (build-system ant-build-system)
      (arguments
       `(#:jdk ,openjdk11
         #:jar-name "swt.jar"))
      (home-page "")
      (synopsis "")
      (description "")
      (license #f))))
