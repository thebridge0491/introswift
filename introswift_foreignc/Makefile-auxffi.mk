# FFI auxiliary makefile script
ffi_libdir = $(shell $(PKG_CONFIG) --variable=libdir intro_c-practice || echo .)
ffi_incdir = $(shell $(PKG_CONFIG) --variable=includedir intro_c-practice || echo .)
LD_LIBRARY_PATH := $(LD_LIBRARY_PATH):$(ffi_libdir)
export LD_LIBRARY_PATH

SWIFTLDFLAGS := $(SWIFTLDFLAGS) -Xlinker -rpath -Xlinker $(PREFIX)/lib -Xlinker -L$(PREFIX)/lib
SWIFTCFLAGS := $(SWIFTCFLAGS) -Xcc -I$(PREFIX)/include -Xcc -fmodule-map-file=Include/module.modulemap
