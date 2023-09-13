
(load "cl-provisioning.asd")
(load "cl-provisioning-tests.asd")

(ql:quickload "cl-provisioning-tests")

(in-package :cl-provisioning-tests)

(uiop:quit (if (run-all-tests) 0 1))
