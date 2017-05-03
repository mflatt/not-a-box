#SCHEME = scheme
SCHEME = /Users/mflatt/repo/ChezScheme/a6osx/bin/scheme -b /Users/mflatt/repo/ChezScheme/a6osx/boot/a6osx/petite.boot -b /Users/mflatt/repo/ChezScheme/a6osx/boot/a6osx/scheme.boot
UNSAFE = # '(optimize-level 3)'

COMP = echo '(reset-handler abort) (keyboard-interrupt-handler abort)'

SCHEMIFY_SRC_DEPS = schemify/schemify.rkt schemify/known.rkt schemify/match.rkt \
                    schemify/find-definition.rkt schemify/left-to-right.rkt	schemify/mutated.rkt \
                    schemify/struct-type-info.rkt schemify/import.rkt schemify/mutated-state.rkt \
                    schemify/simple.rkt
CONVERT_DEPS = convert.rkt $(SCHEMIFY_SRC_DEPS)

THREAD_DEPS = chezpart.so core.so
PORT_DEPS = $(THREAD_DEPS) thread.so
REGEXP_DEPS = $(PORT_DEPS) port.so
SCHEMIFY_DEPS = $(REGEXP_DEPS) regexp.so known-primitive.so
LINKLET_DEPS = $(SCHEMIFY_DEPS) schemify.so
EXPANDER_DEPS = $(LINKLET_DEPS) linklet.so

expander-demo: expander.so expander-demo.ss
	$(SCHEME) $(EXPANDER_DEPS) expander.so expander-demo.ss

PRIMITIVES_TABLES = kernel-primitives.scm unsafe-primitives.scm flfxnum-primitives.scm

expander.so: expander.sls expander.scm expander-compat.scm $(PRIMITIVES_TABLES) $(EXPANDER_DEPS)
	$(COMP) '(compile-file "expander.sls")' | $(SCHEME) -q $(EXPANDER_DEPS)

expander.scm: expander.rktl $(CONVERT_DEPS)
	racket convert.rkt expander.rktl expander.scm


linklet-demo: linklet.so
	$(SCHEME) $(LINKLET_DEPS) linklet.so linklet-demo.ss

linklet.so: linklet.sls $(LINKLET_DEPS)
	$(COMP) '(compile-file "linklet.sls")' | $(SCHEME) -q $(LINKLET_DEPS)

schemify.so: schemify.sls schemify.scm $(SCHEMIFY_DEPS)
	$(COMP) '(compile-file "schemify.sls")' | $(SCHEME) -q $(SCHEMIFY_DEPS)

schemify.scm: schemify.rktl $(CONVERT_DEPS)
	racket convert.rkt --skip-export schemify.rktl schemify.scm

known-primitive.so: known-primitive.sls
	$(COMP) '(compile-file "known-primitive.sls")' | $(SCHEME) -q

known-primitive.sls: known-primitive.rkt
	racket known-primitive.rkt


regexp-demo: regexp.so regexp-demo.scm
	$(SCHEME) $(REGEXP_DEPS) regexp.so regexp-demo.ss

regexp.so: regexp.scm regexp.sls $(REGEXP_DEPS)
	$(COMP) '(compile-file "regexp.sls")' | $(SCHEME) -q $(REGEXP_DEPS)

regexp.scm: regexp.rktl $(CONVERT_DEPS)
	racket convert.rkt regexp.rktl regexp.scm


port-demo: port.so
	$(SCHEME) $(PORT_DEPS) port.so port-demo.ss

port.so: port.scm port.sls $(PORT_DEPS)
	$(COMP) '(compile-file "port.sls")' | $(SCHEME) -q $(PORT_DEPS)

port.scm: port.rktl $(CONVERT_DEPS)
	racket convert.rkt port.rktl port.scm


thread-demo: thread.so
	$(SCHEME) $(THREAD_DEPS) thread.so thread-demo.ss

thread.so: thread.scm thread.sls $(THREAD_DEPS)
	$(COMP) '(compile-file "thread.sls")' | $(SCHEME) -q $(THREAD_DEPS)

thread.scm: thread.rktl $(CONVERT_DEPS)
	racket convert.rkt thread.rktl thread.scm


hash-demo: core.so
	$(SCHEME) chezpart.so core.so hash-demo.ss

struct-demo: core.so
	$(SCHEME) chezpart.so core.so struct-demo.ss

control-demo: core.so
	$(SCHEME) chezpart.so core.so control-demo.ss

CORE_SRCS = core-constant.ss \
            core-hash-code.ss \
            core-struct.ss \
            core-procedure.ss \
            core-hamt.ss \
            core-hash.ss \
	    core-lock.ss \
            core-thread-cell.ss \
            core-parameter.ss \
            core-begin0.ss \
            core-control.ss \
            core-engine.ss \
            core-error.ss \
            core-bytes.ss \
            core-string.ss \
            core-symbol.ss \
            core-list.ss \
            core-vector.ss \
            core-box.ss \
            core-immutable.ss \
            core-keyword.ss \
            core-mpair.ss \
            core-number.ss \
            core-correlated.ss \
            core-time.ss \
            core-memory.ss \
            core-system.ss \
            core-unsafe.ss

core.so: chezpart.so core.sls $(CORE_SRCS)
	$(COMP) $(UNSAFE) '(compile-file "core.sls")' | $(SCHEME) -q

chezpart.so: chezpart.sls
	$(COMP) '(compile-file "chezpart.sls")' | $(SCHEME) -q

# To build various ".rktl" files from sources, which requires
# a linklet-based Racket repo clone identified by a
# `LINKLET_RACKET` environment variable:
local-linklets:
	$(MAKE) -f Mf-linklet local-linklets SCHEMIFY_SRC_DEPS="$(SCHEMIFY_SRC_DEPS)"
all-linklets:
	$(MAKE) -f Mf-linklet all-linklets SCHEMIFY_SRC_DEPS="$(SCHEMIFY_SRC_DEPS)"

clean:
	rm -f core.so regexp.so port.so immutable-hash.so linklet.so known-primitive.so linklet.so expander.so schemify.so
	rm -f expander.scm port.scm regexp.scm schemify.scm
