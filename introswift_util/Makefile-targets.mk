# Targets Makefile script.
#----------------------------------------
# Common automatic variables legend (GNU make: make (Linux) gmake (FreeBSD)):
# $* - basename (cur target)  $^ - name(s) (all depns)  $< - name (1st depn)
# $@ - name (cur target)      $% - archive member name  $? - changed depns

FMTS ?= tar.gz,zip
distdir = $(proj)-$(version)

build/$(distdir) : 
	-@mkdir -p build/$(distdir) ; cp -f exclude.lst build
#	#-zip -9 -q --exclude @exclude.lst -r - . | unzip -od build/$(distdir) -
	-tar --format=posix --dereference --exclude-from=exclude.lst -cf - . | tar -xpf - -C build/$(distdir)

#LINT = cppcheck --enable=information --report-progress --quiet --force

.PHONY: help clean clobber test dist doc report uninstall install
help: ## help
	@echo "##### subproject: $(proj) #####"
	@echo "Usage: $(MAKE) [target] -- some valid targets:"
#	-@for fileX in $(MAKEFILE_LIST) `if [ -z "$(MAKEFILE_LIST)" ] ; then echo Makefile ./Makefile-targets.mk ; fi` ; do \
#		grep -ve '^[A-Z]' $$fileX | awk '/^[^.%][-A-Za-z0-9_]+[ ]*:.*$$/ { print "...", substr($$1, 1, length($$1)) }' | sort ; \
#	done
	-@for fileX in $(MAKEFILE_LIST) `if [ -z "$(MAKEFILE_LIST)" ] ; then echo Makefile ./Makefile-targets.mk ; fi` ; do \
		grep -E '^[ a-zA-Z_-]+:.*?## .*$$' $$fileX | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "%-25s%s\n", $$1, $$2}' ; \
	done
clean: ## clean build artifacts
	-rm -fr ./build/* ./build/.??* core* *.profraw .coverage *.gcda *.gcno \
		*.log
	swift package --build-path $(BUILD_PATH) clean
clobber: clean ## clean build artifacts & remove build dir
	-rm -fr ./build Package.resolved
	swift package --build-path $(BUILD_PATH) reset
test: ## run test [TOPTS=""]
#	export [DY]LD_LIBRARY_PATH=. # ([da|ba|z]sh Linux)
#	setenv [DY]LD_LIBRARY_PATH . # (tcsh FreeBSD)
	-LLVM_PROFILE_FILE="build/default.profraw" LD_LIBRARY_PATH=$(LD_LIBRARY_PATH):lib swift test --build-path $(BUILD_PATH) $(SWIFTCFLAGS) $(SWIFTLDFLAGS) -c debug $(TOPTS)
uninstall install: ## [un]install executable(s)
	-mkdir -p $(PREFIX)/lib $(PREFIX)/lib
	-@if [ "uninstall" = "$@" ] ; then \
		rm -i $(PREFIX)/lib/*$(proj)*.* || true ; \
		rm -i $(PREFIX)/bin/*$(proj)* || true ; \
	else \
		cp -f $(BUILD_PATH)/$(CONFIG)/lib$(proj)*.* $(BUILD_PATH)/$(CONFIG)/$(proj)*.swiftmodule $(PREFIX)/lib/ || true ; \
		cp -f $(BUILD_PATH)/$(CONFIG)/$(proj)Main $(PREFIX)/bin/ || true ; \
#		sh -xc "$(PKG_CONFIG) --list-all | grep $(proj)" ; sleep 3 ; \
		ls $(PREFIX)/lib | grep $(proj) ; sleep 3 ; \
	fi
dist: | build/$(distdir) ## [FMTS="tar.gz,zip"] archive source code
	-@for fmt in `echo $(FMTS) | tr ',' ' '` ; do \
		case $$fmt in \
			7z) echo "### build/$(distdir).7z ###" ; \
				rm -f build/$(distdir).7z ; \
				(cd build ; 7za a -t7z -mx=9 $(distdir).7z $(distdir)) ;; \
			zip) echo "### build/$(distdir).zip ###" ; \
				rm -f build/$(distdir).zip ; \
				(cd build ; zip -9 -q -r $(distdir).zip $(distdir)) ;; \
			*) tarext=`echo $$fmt | grep -e '^tar$$' -e '^tar.xz$$' -e '^tar.bz2$$' || echo tar.gz` ; \
				echo "### build/$(distdir).$$tarext ###" ; \
				rm -f build/$(distdir).$$tarext ; \
				(cd build ; tar --posix -h -caf $(distdir).$$tarext $(distdir)) ;; \
		esac \
	done
	-@rm -r build/$(distdir)
doc: ## generate documentation [OPTS="??"]
#	-rm -fr build/html
#	-cd build; doxygen ../Doxyfile_c.txt
#	-cd build; doxygen ../Doxyfile_m.txt
	swift package --build-path $(BUILD_PATH) generate-documentation $(OPTS)
lint: ## lint check [OPTS="??"]
#	-$(LINT) --std=posix --std=c99 -Ibuild/include src/*/*.c src/*.c
	swift package --build-path $(BUILD_PATH) lint $(OPTS)
report: ## report code coverage
#	# read coverage data w/ [llvm-cov] gcov -f -b -n *.gcda
#	find . -type f -name '*.gcda' -exec llvm-cov gcov -f -b --no-output {} \;
#	# read coverage data w/ lcov -c -d . -o .coverage ... *.gcda
	-mkdir -p build/cov
#	-lcov --capture -d . -o build/.coverage --gcov-tool ./llvm-gcov.sh
#	-genhtml -o build/cov build/.coverage
	-llvm-profdata merge -o build/cov/Coverage.profdata build/default.profraw
	-llvm-cov show -instr-profile build/cov/Coverage.profdata `find $(BUILD_PATH)/debug -maxdepth 1 -name '*$(proj)*.dylib' -o -name '*$(proj)*.so*' -o -type f -name '$(proj)*'` `find $(BUILD_PATH)/debug/$(proj).build -name '*.o'`
	-llvm-cov report -instr-profile build/cov/Coverage.profdata `find $(BUILD_PATH)/debug -maxdepth 1 -name '*$(proj)*.dylib' -o -name '*$(proj)*.so*' -o -type f -name '$(proj)*'` `find $(BUILD_PATH)/debug/$(proj).build -name '*.o'` > build/cov/cover_rpt.txt
