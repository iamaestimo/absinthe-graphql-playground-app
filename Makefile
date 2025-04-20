.PHONY: all
all: format compile quality

.PHONY: format
format:
	mix format

.PHONY: compile
compile:
	mix compile --warnings-as-errors --all-warnings

.PHONY: test
test:
	mix test

.PHONY: quality
quality:
	mix quality

.PHONY: clean
clean:
	mix clean

.PHONY: run
run:
	mix phx.server

.PHONY: release
release:
	MIX_ENV=prod mix phx.gen.release
