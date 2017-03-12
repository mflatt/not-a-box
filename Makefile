
COMP = echo '(reset-handler abort) (keyboard-interrupt-handler abort)'

SCHEMIFY_DEPS = schemify/schemify.rkt schemify/known.rkt schemify/match.rkt \
                schemify/find-definition.rkt schemify/left-to-right.rkt	schemify/mutated.rkt \
                schemify/struct-type-info.rkt schemify/import.rkt schemify/mutated-state.rkt \
                schemify/simple.rkt
CONVERT_DEPS = convert.rkt $(SCHEMIFY_DEPS)

expander-demo: expander.so expander-demo.ss
	scheme core.so regexp.so port.so linklet.so expander.so expander-demo.ss

PRIMITIVES_TABLES = kernel-primitives.scm unsafe-primitives.scm flfxnum-primitives.scm

expander.so: expander.sls expander.scm expander-compat.scm $(PRIMITIVES_TABLES) core.so port.so regexp.so linklet.so
	$(COMP) '(compile-file "expander.sls")' | scheme -q core.so port.so regexp.so linklet.so

expander.scm: expander.rktl $(CONVERT_DEPS)
	racket convert.rkt expander.rktl expander.scm


linklet-demo: linklet.so
	scheme immutable-hash.so core.so regexp.so known-primitive.so schemify.so linklet.so linklet-demo.ss

linklet.so: linklet.sls schemify.so known-primitive.so
	$(COMP) '(compile-file "linklet.sls")' | scheme -q core.so regexp.so known-primitive.so schemify.so

schemify.so: schemify.sls schemify.scm known-primitive.so regexp.so
	$(COMP) '(compile-file "schemify.sls")' | scheme -q core.so port.so regexp.so known-primitive.so

schemify.scm: schemify.rktl $(CONVERT_DEPS)
	racket convert.rkt schemify.rktl schemify.scm

known-primitive.so: known-primitive.sls
	$(COMP) '(compile-file "known-primitive.sls")' | scheme -q

known-primitive.sls: known-primitive.rkt
	racket known-primitive.rkt


regexp-demo: regexp.so regexp-demo.scm
	scheme core.so port.so regexp.so regexp-demo.ss

regexp.so: regexp.scm regexp.sls core.so port.so
	$(COMP) '(compile-file "regexp.sls")' | scheme -q core.so port.so

regexp.scm: regexp.rktl $(CONVERT_DEPS)
	racket convert.rkt regexp.rktl regexp.scm


port-demo: port.so
	scheme core.so port.so port-demo.ss

port.so: port.scm port.sls core.so
	$(COMP) '(compile-file "port.sls")' | scheme -q core.so

port.scm: port.rktl $(CONVERT_DEPS)
	racket convert.rkt port.rktl port.scm


hash-demo: core.so
	scheme core.so hash-demo.ss

struct-demo: core.so
	scheme core.so struct-demo.ss

CORE_SRCS = core-constant.ss \
            core-hash-code.ss \
            core-struct.ss \
            core-procedure.ss \
            core-hamt.ss \
            core-hash.ss \
            core-thread-cell.ss \
            core-parameter.ss \
            core-control.ss \
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

core.so: core.sls $(CORE_SRCS)
	$(COMP) '(compile-file "core.sls")' | scheme -q

# To build various ".rktl" files from sources, which requires
# a linklet-based Racket repo clone identified by a
# `LINKLET_RACKET` environment variable:
local-linklets:
	$(MAKE) -f Mf-linklet local-linklets SCHEMIFY_DEPS="$(SCHEMIFY_DEPS)"
all-linklets:
	$(MAKE) -f Mf-linklet all-linklets SCHEMIFY_DEPS="$(SCHEMIFY_DEPS)"

clean:
	rm -f core.so regexp.so port.so immutable-hash.so linklet.so known-primitive.so linklet.so expander.so schemify.so
	rm -f expander.scm port.scm regexp.scm schemify.scm
