CURRENT_DIR = $(shell pwd)
CHARON ?= $(CURRENT_DIR)/../charon/bin/charon
DEST ?= .
OPTIONS =
CHARON_CMD :=
NOT_ALL_TESTS ?=

.PHONY: all
all: build tests

.PHONY: build
build:
	cargo build

.PHONY: tests
tests: cargo-tests charon-tests

.PHONY: cargo-tests
cargo-tests: build
	cargo test

.PHONY: charon-tests
charon-tests: \
	test-insertion_sort test-selection_sort \
	test-loops test-loops_cfg test-hashmap \
	test-paper \
	test-matches test-matches_duplicate test-external \
	test-no_nested_borrows

test-insertion_sort:
test-selection_sort:
test-no_nested_borrows: OPTIONS += --no-code-duplication
test-loops:
test-loops_cfg: OPTIONS += --no-code-duplication
test-hashmap:
# test-hashmap_main: OPTIONS += --opaque=hashmap_utils
test-paper: OPTIONS += --no-code-duplication
# Possible to add `OPTIONS += --no-code-duplication` if we use the optimized MIR
test-matches:
test-external: OPTIONS += --no-code-duplication
test-matches_duplicate:

# =============================================================================
# The tests.
# We use the NOT_ALL_TESTS variable to switch between the full test suite and a
# smaller one.
# =============================================================================

.PHONY: test-%
test-%: CHARON_CMD = $(CHARON) --crate $* --input src/$*.rs $(OPTIONS)
test-%: build

ifeq (, $(NOT_ALL_TESTS))

test-%:
	$(CHARON_CMD) --dest $(DEST)/llbc
#	$(CHARON_CMD) --dest $(DEST)/ullbc --ullbc
#	$(CHARON_CMD) --dest $(DEST)/llbc_prom --mir_promoted
#	$(CHARON_CMD) --dest $(DEST)/llbc_opt --mir_optimized
#	$(CHARON_CMD) --dest $(DEST)/llbc_release --release
#	$(CHARON_CMD) --dest $(DEST)/llbc_release_prom --release --mir_promoted
# TODO: this fails for now (there is some very low-level desugaring happening)
#	$(CHARON_CMD) --dest $(DEST)/llbc_release_opt --release --mir_optimized 

else

test-%:
	$(CHARON_CMD) --dest $(DEST)/llbc

endif
