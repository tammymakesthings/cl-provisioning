(in-package :asdf-user)

(defsystem "cl-provisioning"
  :author "Tammy Cravit <tammy@tammymakesthings.com>"
  :version "0.1.0"
  :license "MIT"
  :description "Common Lisp Machine Provisioning"
  :homepage "https://github.com:tammymakesthings/cl-provisioning"
  :bug-tracker "https://github.com:tammymakesthings/cl-provisioning/issues"
  :source-control (:git "git@github.com:tammymakesthings/cl-provisioning.git")

  ;; Dependencies.
  :depends-on
  (:cl-ppcre
   :local-time
   :local-time-duration
   :log4cl
   :cl-yaml
   :trivial-ssh

   ;; scripting
   :clingon
   :cl-ansi-term
   :cl-progress-bar
   :cmd

   ;; deployment
   :deploy

   ;; development utilities
   :fiveam)

  ;; Build a binary.
  ;; :build-operation "program-op"  ;; usual op to build a binary.
  ;; Deploy:
  :defsystem-depends-on (:deploy)
  :build-operation "deploy-op"
  :build-pathname "cl-provisioning"
  :entry-point "cl-provisioning:run"

  ;; Project stucture.
  :serial t
  :components ((:module "src"
                        :components
                        ((:file "packages")
                         (:file "utils")
                         (:file "cl-provisioning")
                         (:file "configuration")))

               (:module "src/engine"
                        :components
                        ((:file "local-linux")
                         (:file "local-macos")
                         (:file "ssh-linux")
                         (:file "ssh-macos")))

               (:static-file "README.md")))

;; Deploy may not find libcrypto on your system.
;; But anyways, we won't ship it to rely instead
;; on its presence on the target OS.
(require :cl+ssl) ; sometimes necessary.
#+linux (deploy:define-library cl+ssl::libssl :dont-deploy T)
#+linux (deploy:define-library cl+ssl::libcrypto :dont-deploy T)
