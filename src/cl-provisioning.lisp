(in-package :cl-provisioning)

(defun top-level/options
    "Creates and returns the list of top-level options."
  (list
   (clingon:make-option
    :boolean/false
    :description "display application help"
    :short-name #\h
    :long-name "help"
    :key :help)
   (clingon:make-option
    :counter
    :description "sets the verbosity level"
    :short-name #\v
    :long-name "verbose"
    :key :verbose)
   (clingon:make-option
    :boolean/false
    :description "simulated mode (prints but doesn't run commands)"
    :short-name #\s
    :long-name "simulate"
    :key :simulate)
   (clingon:make-option
    :string
    :description "the configuration file for the provisioning run"
    :shortname #\s
    :long-name "config"
    :initial-value "provisioning.yaml"
    :key :config)
   ))

(defun top-level/handler (cmd)
  "The top level handler"
  (let ((args clingon:command-arguments cmd)
        (opt-verbosity (clingon:getopt cmd :verbose))
        (opt-simulate (clingon:getopt cmd :simulate))
        (opt-config-file (clingon:getopt cmd :config))
        )
    (format t "Inside clprovision top-level handler %~")
    (format t "Verbosity level: ~A~%" opt-verbosity)
    (format t "Simulated run? ~A~%" (if opt-simulate "Yes" "No"))
    (format t "Configuration: ~A~%" opt-config-file)
    ))

(defun top-level/command()
  "Creates and returns the top-level command object."
  (clingon:make-command
   :name "clprovision"
   :description "Common Lisp machine provisioning made simple"
   :version "0.1.0"
   :license "MIT"
   :authors '("Tammy Cravit <tammy@tammymakesthings.com")
   :usage "[-v] [-s] [-f <CONFIG.yaml>]"
   :options (top-level/options)
   :handler #'top-level/handler))

(defun main ()
  (let ((app (top-level/command)))
    (clingon:run app)))
