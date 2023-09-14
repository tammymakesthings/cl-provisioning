(in-package :asdf-user)
(defsystem "cl-provisioning-tests"
    :description "Test suite for the cl-provisioning system"
    :author "Tammy Cravit <tammy@tammymakesthings.com>"
    :version "0.0.1"
    :depends-on (
		 :cl-provisioning
		 :fiveam
		 )
    :license "MIT"
    :serial t
    :components (
		 (:module "tests"
			  :serial t
			  :components (
				       (:file "packages")
				       (:file "test-cl-provisioning")
				       )
			  )
		 (:static-file "README.md")
		 (:static-file "CODE_OF_CONDUCT.md")
		 )

    ;; The following would not return the right exit code on error, but still 0.
    ;; :perform (test-op (op _) (symbol-call :fiveam :run-all-tests))
    )
