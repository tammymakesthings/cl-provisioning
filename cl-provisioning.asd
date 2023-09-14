(in-package :asdf-user)

(defsystem "cl-provisioning"
    :author "Tammy Cravit <tammy@tammymakesthings.com>"
    :version "0.0.1"
    :license "MIT"
    :description "Common Lisp Machine Provisioning"
    :homepage "https://github.com/tammymakesthings/cl-provisioning/"
    :bug-tracker "https://github.com/tammymakesthings/cl-provisioning/issues/"
    :source-control
    (
     :git
     "git@github.com:tammymakesthings/cl-provisioning.git"
     )

    ;; Dependencies.
    :depends-on (
		 :cl-json
		 )

    ;; Project stucture.
    :serial t
    :components (
		 (:module "src"
			  :serial t
			  :components (
				       (:file "packages")
				       (:file "cl-provisioning")
				       )
			  )
		 (:static-file "README.md")
		 (:static-file "CODE_OF_CONDUCT.md")
		 )

    ;; Build a binary:
    ;; don't change this line.
    :build-operation "program-op"
    ;; binary name: adapt.
    :build-pathname "clprovision"
    ;; entry point: here "main" is an exported symbol. Otherwise, use a double ::
    :entry-point "cl-provisioning:main"
    )
