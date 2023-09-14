##############################################################################
# cl-provisioning Makefile
# Run 'make help' for a list of Makefile targets
##############################################################################

##### ===> Tool Locations ####################################################
LISP            ?= "$(shell whereis -b sbcl | cut -d':' -f2 | sed 's/ //g')"
RLWRAP          ?= "$(shell whereis -b rlwrap | cut -d':' -f2 | sed 's/ //g')"
FIND            ?= "$(shell whereis -b gfind | cut -d':' -f2 | sed 's/ //g')"

##### ===> Lisp System Metadata ##############################################
SYSTEM_NAME     := "cl-provisioning"
EXECUTABLE_NAME := "clprovision"

##### ===> Source File Groups ################################################
SOURCE_FILES    := $(wildcard *.lisp) \
		   $(shell find src -type f -name '*.lisp')
TEST_FILES      := $(shell find tests -type f -name '*.lisp')
ASDF_FILES      := $(wildcard *.asd)
ROSWELL_FILES   := $(shell find roswell -type f -name '*.ros')
EXTRA_FILES     := Makefile \
		   $(shell find . -type f -name '*.md') \
		   $(shell find . -type f -name '*.json' -o -name '*.toml')

ALL_FILES       := $(SOURCE_FILES) \
		   $(TEST_FILES) \
		   $(ASDF_FILES) \
		   $(ROSWELL_FILES) \
		   $(EXTRA_FILES)

##### ===> Makefile Targets ##################################################

help: # Display a list of Makefile targets
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

all: build test		# Build the executable and run tests

run: ## Run the clprovision tool
	$(RLWRAP) $(LISP) --load run.lisp

build: $(SOURCE_FILES) $(ASDF_FILES) ## Build the clprovision executable
	$(LISP)	--non-interactive \
		--load "$(SYSTEM_NAME).asd" \
		--eval "(ql:quickload :$(SYSTEM_NAME))" \
		--eval "(asdf:make :$(SYSTEM_NAME))"
	mkdir -p bin
	mv $(EXECUTABLE_NAME) bin

test: $(SOURCE_FILES) $(ASDF_FILES) $(TEST_FILES) ## Run the unit tests
	$(LISP) --non-interactive \
		--load run-tests.lisp

check: ## Display Makefile parameters
	@echo "============================| Make Parameters |=============================="
	@echo "     SYSTEM_NAME: $(SYSTEM_NAME)"
	@echo " EXECUTABLE_NAME: $(EXECUTABLE_NAME)"
	@echo ""
	@echo "==> Files"
	@echo ""
	@echo "    SOURCE_FILES: $(SOURCE_FILES)"
	@echo "      TEST_FILES: $(TEST_FILES)"
	@echo "      ASDF_FILES: $(ASDF_FILES)"
	@echo "   ROSWELL_FILES: $(ROSWELL_FILES)"
	@echo "     EXTRA_FILES: $(EXTRA_FILES)"
	@echo ""
	@echo "==> Tool Paths"
	@echo ""
	@echo "            LISP: $(LISP)"
	@echo "          RLWRAP: $(RLWRAP)"
	@echo "============================================================================="

doc: build ; ## Generate documentation
	$(LISP) --non-interactive \
		--eval "(ql:quickload :coo)" \
		--eval "(ql:quickload :$(SYSTEM_NAME))" \
		--eval "(coo:document-system :$(SYSTEM_NAME))"

tar: ## Create a tarball of this directory
	tar cvf $(SYSTEM_NAME)-$(shell date +%Y%m%d%H%M%S).tar $(ALL_FILES)
	ls -ltr *.tar* | head -n -3 | xargs rm -f --

clean: ## Clean intermediate files ;
	rm -f *.tar
	rm -f bin/$(EXECUTABLE_NAME)

.PHONY: all doc check tar clean
