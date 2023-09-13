(in-package :asdf-user)
(defsystem "cl-provisioning-tests"
  :description "Test suite for the cl-provisioning system"
  :author "Tammy Cravit <tammy@tammymakesthings.com>"
  :version "0.1.0"
  :depends-on (:cl-provisioning
               :fiveam)
  :license "BSD"
  :serial t
  :components ((:module "tests"
                        :serial t
                        :components ((:file "packages")
                                     (:file "test-cl-provisioning"))))

  ;; The following would not return the right exit code on error, but still 0.
  ;; :perform (test-op (op _) (symbol-call :fiveam :run-all-tests))
  )
