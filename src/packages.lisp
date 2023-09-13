;;;
;;; define helper packages,
;;; the models,
;;; the web,
;;; and the base package that relies on all of them.
;;;

(defpackage cl-provisioning/engine
  (:use :cl
        :log4cl)
  (:documentation "Utilities that do not depend on models."))

(defpackage cl-provisioning
  (:use :cl
        :log4cl)
  (:export :main :run)
  (:local-nicknames
   (#:a #:alexandria)
   (#:engine #:cl-provisioning/engine)
   )
  )
