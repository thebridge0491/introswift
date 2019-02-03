BUILD_PATH ?= ./.build
PREFIX ?= /usr/local

# Single package Makefile script.
.SUFFIXES: .s .o .a .swift
help:

parent = Introswift
pkg = Foreignc
proj = $(parent)_$(pkg)

version = 0.1.0
ver_major = $(shell echo $(version) | cut -d'.' -f1)

proj_dir = $(shell pwd)
par_dir = $(shell dirname $(proj_dir))
PKG_CONFIG = pkg-config --with-path=$(PREFIX)/lib/pkgconfig
SWIFTCFLAGS = # -Xswiftc -DDEBUG -Xcc -I$(PREFIX)/include
SWIFTLDFLAGS = # -Xlinker -L$(PREFIX)/lib -Xlinker -l$(parent)_Util
COVERAGEFLAGS = # -Xswiftc -profile-generate -Xswiftc -profile-coverage-mapping -Xcc -fprofile-instr-generate -Xcc -fcoverage-mapping

ifeq ($(shell sh -c 'uname -s 2>/dev/null || echo not'),Darwin)
shlibext = dylib
else
shlibext = so
endif

ifdef DEBUG
CONFIG = debug
SWIFTLDFLAGS := $(SWIFTLDFLAGS)
SWIFTCFLAGS := $(SWIFTCFLAGS) -Xswiftc -DDEBUG
COVERAGEFLAGS := $(COVERAGEFLAGS) -Xswiftc -profile-generate -Xswiftc -profile-coverage-mapping -Xcc -fprofile-instr-generate -Xcc -fcoverage-mapping
else
CONFIG = release
SWIFTLDFLAGS := $(SWIFTLDFLAGS)
SWIFTCFLAGS := $(SWIFTCFLAGS) -Xswiftc -DNDEBUG
COVERAGEFLAGS := $(COVERAGEFLAGS)
endif

build/.depend:
	-@echo '' > build/.depend

.PHONY: build testCompile

build: build/.depend ## compile
	swift build -v --build-path $(BUILD_PATH) $(SWIFTCFLAGS) $(SWIFTLDFLAGS) $(COVERAGEFLAGS) -c $(CONFIG)
testCompile: build/.depend ## compile test
	swift build -v --build-path $(BUILD_PATH) --build-tests $(SWIFTCFLAGS) $(SWIFTLDFLAGS) $(COVERAGEFLAGS) -c debug

-include build/.depend ./Makefile-targets.mk
-include ./Makefile-auxffi.mk
