LISP ?= sbcl

all: test

run:
	rlwrap $(LISP) --load run.lisp

build:
	$(LISP)	--non-interactive \
		--load cl-provisioning.asd \
		--eval '(ql:quickload :cl-provisioning)' \
		--eval '(asdf:make :cl-provisioning)'

test:
	$(LISP) --non-interactive \
		--load run-tests.lisp
