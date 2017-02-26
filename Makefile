
COMP = echo '(reset-handler abort) (keyboard-interrupt-handler abort)'

expander-demo: expander.so expander-demo.ss
	scheme core.so regexp.so port.so linklet.so expander.so expander-demo.ss

PRIMITIVES_TABLES = kernel-primitives.scm unsafe-primitives.scm

expander.so: expander.sls expander.scm expander-compat.scm compat.scm $(PRIMITIVES_TABLES) core.so port.so regexp.so linklet.so
	$(COMP) '(compile-file "expander.sls")' | scheme -q core.so port.so regexp.so linklet.so

expander.scm: expander.rktl convert.rkt schemify.rkt
	racket convert.rkt < expander.rktl > expander.scm


linklet-demo: linklet.so
	scheme immutable-hash.so core.so regexp.so primitive-procs.so schemify.so linklet.so linklet-demo.ss

linklet.so: linklet.sls schemify.so primitive-procs.so
	$(COMP) '(compile-file "linklet.sls")' | scheme -q core.so regexp.so primitive-procs.so schemify.so

schemify.so: schemify.sls schemify.scm compat.scm primitive-procs.so regexp.so
	$(COMP) '(compile-file "schemify.sls")' | scheme -q core.so port.so regexp.so primitive-procs.so

schemify.scm: schemify.rktl convert.rkt schemify.rkt
	racket convert.rkt < schemify.rktl > schemify.scm

primitive-procs.so: primitive-procs.sls
	$(COMP) '(compile-file "primitive-procs.sls")' | scheme -q

primitive-procs.sls: make-primitive-procs.rkt
	racket make-primitive-procs.rkt


regexp-demo: regexp.so regexp-demo.scm
	scheme core.so port.so regexp.so regexp-demo.ss

regexp.so: regexp.scm regexp.sls compat.scm core.so port.so
	$(COMP) '(compile-file "regexp.sls")' | scheme -q core.so port.so

regexp.scm: regexp.rktl convert.rkt schemify.rkt
	racket convert.rkt < regexp.rktl > regexp.scm


port-demo: port.so
	scheme core.so port.so port-demo.ss

port.so: port.scm port.sls compat.scm core.so
	$(COMP) '(compile-file "port.sls")' | scheme -q core.so

port.scm: port.rktl convert.rkt schemify.rkt
	racket convert.rkt < port.rktl > port.scm


hash-demo: core.so
	scheme core.so hash-demo.ss

struct-demo: core.so
	scheme core.so struct-demo.ss

core.so: core.sls core-equal.ss core-hash-code.ss core-struct.ss core-hamt.ss core-hash.ss core-error.ss core-bytes.ss core-time.ss
	$(COMP) '(compile-file "core.sls")' | scheme -q


clean:
	rm -f core.so regexp.so port.so immutable-hash.so linklet.so primitive-procs.so linklet.so expander.so schemify.so
	rm -f expander.scm port.scm regexp.scm schemify.scm
