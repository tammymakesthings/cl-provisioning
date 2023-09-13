(in-package :asdf-user)

(defsystem "cl-provisioning-tests"
    :description "Test suite for the cl-provisioning system"
    :author "Tammy Cravit <tammy@tammymakesthings.com>"
    :version "0.1.0"
    :depends-on (:cl-provisioning
		 :fiveam)
    :license "MIT"
    :serial t
    :components
    (
     (:module "tests"
              :serial t
              :components
              (
               (:file "packages")
               (:file "test-cl-provisioning")
               (:file "test-config-parser")
               (:file "test-packages")
               (:file "test-utils")
               (:module "engine"
			:serial t
			:components
			(
			 (:file "test-check-pre-post")
			 (:file "test-commands-local-linux")
			 (:file "test-commands-local-macos")
			 (:file "test-commands-ssh-linux")
			 (:file "test-commands-ssh-macos")
			 (:file "test-install-engine")
			 )
			)
	       )
	      )
