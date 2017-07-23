##
##  GemstoneJS -- Gemstone JavaScript Technology Stack
##  Copyright (c) 2016-2017 Gemstone Project <http://gemstonejs.com>
##  Licensed under Apache License 2.0 <https://spdx.org/licenses/Apache-2.0>
##

NODE     = NODE=node node
GEMSTONE = $(NODE) ../gemstone-stub/gemstone.js

SYMLINK = \
	for mod in gemstone-*; do \
	    if [ -d $$mod ]; then rm -rf $$mod; fi; \
	    if [ -h $$mod ]; then rm -f $$mod; fi; \
	    ln -s ../../../$$mod $$mod; \
	done

all: clean generate install symlink build

generate:
	$(GEMSTONE) generate-meta-project     force=true
	$(GEMSTONE) generate-frontend-project force=true
	$(GEMSTONE) generate-backend-project  force=true

install:
	cd example && npm install

symlink:
	cd example-fe/node_modules && $(SYMLINK)
	cd example-be/node_modules && $(SYMLINK)

build:
	cd example && npm run build:bare

dev:
	cd example && npm run dev

clean:
	-rm -rf example
	-rm -rf example-fe
	-rm -rf example-be

