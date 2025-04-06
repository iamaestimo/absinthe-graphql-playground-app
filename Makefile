.PHONY: all
all: format compile

.PHONY: format
format:
	mix format

.PHONY: compile
compile:
	mix compile --warnings-as-errors --all-warnings

.PHONY: test
test:
	mix test

.PHONY: clean
clean:
	mix clean

.PHONY: run
run:
	mix phx.server

.PHONY: release
release:
	MIX_ENV=prod mix phx.gen.release
