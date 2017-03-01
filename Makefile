
COMP = echo '(reset-handler abort) (keyboard-interrupt-handler abort)'

expander-demo: expander.so expander-demo.ss
	scheme core.so regexp.so port.so linklet.so expander.so expander-demo.ss

PRIMITIVES_TABLES = kernel-primitives.scm unsafe-primitives.scm

expander.so: expander.sls expander.scm expander-compat.scm $(PRIMITIVES_TABLES) core.so port.so regexp.so linklet.so
	$(COMP) '(compile-file "expander.sls")' | scheme -q core.so port.so regexp.so linklet.so

expander.scm: expander.rktl convert.rkt schemify.rkt
	racket convert.rkt < expander.rktl > expander.scm


linklet-demo: linklet.so
	scheme immutable-hash.so core.so regexp.so primitive-procs.so schemify.so linklet.so linklet-demo.ss

linklet.so: linklet.sls schemify.so primitive-procs.so
	$(COMP) '(compile-file "linklet.sls")' | scheme -q core.so regexp.so primitive-procs.so schemify.so

schemify.so: schemify.sls schemify.scm primitive-procs.so regexp.so
	$(COMP) '(compile-file "schemify.sls")' | scheme -q core.so port.so regexp.so primitive-procs.so

schemify.scm: schemify.rktl convert.rkt schemify.rkt
	racket convert.rkt < schemify.rktl > schemify.scm

primitive-procs.so: primitive-procs.sls
	$(COMP) '(compile-file "primitive-procs.sls")' | scheme -q

primitive-procs.sls: make-primitive-procs.rkt
	racket make-primitive-procs.rkt


regexp-demo: regexp.so regexp-demo.scm
	scheme core.so port.so regexp.so regexp-demo.ss

regexp.so: regexp.scm regexp.sls core.so port.so
	$(COMP) '(compile-file "regexp.sls")' | scheme -q core.so port.so

regexp.scm: regexp.rktl convert.rkt schemify.rkt
	racket convert.rkt < regexp.rktl > regexp.scm


port-demo: port.so
	scheme core.so port.so port-demo.ss

port.so: port.scm port.sls core.so
	$(COMP) '(compile-file "port.sls")' | scheme -q core.so

port.scm: port.rktl convert.rkt schemify.rkt
	racket convert.rkt < port.rktl > port.scm


hash-demo: core.so
	scheme core.so hash-demo.ss

struct-demo: core.so
	scheme core.so struct-demo.ss

CORE_SRCS = core-constant.ss \
            core-equal.ss \
            core-hash-code.ss \
            core-struct.ss \
            core-hamt.ss \
            core-hash.ss \
            core-thread-cell.ss \
            core-parameter.ss \
            core-control.ss \
            core-error.ss \
            core-bytes.ss \
            core-string.ss \
            core-list.ss \
            core-vector.ss \
            core-box.ss \
            core-keyword.ss \
            core-mpair.ss \
            core-integer.ss \
            core-time.ss \
            core-unsafe.ss

core.so: core.sls $(CORE_SRCS)
	$(COMP) '(compile-file "core.sls")' | scheme -q

# To build various ".rktl" files from sources, which requires
# a linklet-based Racket repo clone identified by a
# `LINKLET_RACKET` environment variable:
local-linklets:
	$(MAKE) -f Mf-linklet local-linklets
all-linklets:
	$(MAKE) -f Mf-linklet all-linklets

clean:
	rm -f core.so regexp.so port.so immutable-hash.so linklet.so primitive-procs.so linklet.so expander.so schemify.so
	rm -f expander.scm port.scm regexp.scm schemify.scm
