
COMP = echo '(reset-handler abort) (keyboard-interrupt-handler abort)'

expander-demo: expander.so expander-demo.ss
	scheme regexp.so error.so struct.so hash-code.so hash.so equal.so port.so expander.so expander-demo.ss

expander.so: expander.sls expander.scm expander-compat.scm compat.scm kernel.scm struct.so hash-code.so hash.so equal.so port.so bytes.so regexp.so linklet.so
	$(COMP) '(compile-file "expander.sls")' | scheme -q error.so struct.so equal.so hash-code.so hash.so port.so bytes.so regexp.so linklet.so

expander.scm: expander.rktl convert.rkt schemify.rkt
	racket convert.rkt < expander.rktl > expander.scm


linklet-demo: linklet.so
	scheme immutable-hash.so hash.so error.so struct.so regexp.so bytes.so primitive-procs.so schemify.so linklet.so linklet-demo.ss

linklet.so: linklet.sls schemify.so primitive-procs.so
	$(COMP) '(compile-file "linklet.sls")' | scheme -q immutable-hash.so hash.so error.so struct.so regexp.so bytes.so primitive-procs.so schemify.so

schemify.so: schemify.sls schemify.scm compat.scm primitive-procs.so regexp.so
	$(COMP) '(compile-file "schemify.sls")' | scheme -q equal.so immutable-hash.so hash.so error.so struct.so port.so regexp.so bytes.so primitive-procs.so

schemify.scm: schemify.rktl convert.rkt schemify.rkt
	racket convert.rkt < schemify.rktl > schemify.scm

primitive-procs.so: primitive-procs.sls
	$(COMP) '(compile-file "primitive-procs.sls")' | scheme -q

primitive-procs.sls: make-primitive-procs.rkt
	racket make-primitive-procs.rkt


regexp-demo: regexp.so
	scheme struct.so equal.so hash-code.so immutable-hash.so hash.so port.so bytes.so regexp.so regexp-demo.ss

regexp.so: regexp.scm regexp.sls compat.scm bytes.so port.so error.so
	$(COMP) '(compile-file "regexp.sls")' | scheme -q error.so struct.so equal.so hash-code.so immutable-hash.so bytes.so hash.so port.so

regexp.scm: regexp.rktl convert.rkt schemify.rkt
	racket convert.rkt < regexp.rktl > regexp.scm


port-demo: port.so
	scheme equal.so hash-code.so hash.so bytes.so port.so port-demo.ss

port.so: port.scm port.sls compat.scm equal.so struct.so hash.so bytes.so
	$(COMP) '(compile-file "port.sls")' | scheme -q struct.so equal.so hash-code.so immutable-hash.so error.so hash.so bytes.so

port.scm: port.rktl convert.rkt schemify.rkt
	racket convert.rkt < port.rktl > port.scm


bytes.so: bytes.sls
	$(COMP) '(compile-file "bytes.sls")' | scheme -q


hash-demo: immutable-hash.so hash.so
	scheme struct.so equal.so hash-code.so immutable-hash.so hash.so hash-demo.ss

hash.so: hash.sls hash-code.so immutable-hash.so error.so
	$(COMP) '(compile-file "hash.sls")' | scheme -q struct.so hash-code.so equal.so immutable-hash.so error.so


error.so: error.sls immutable-hash.so
	$(COMP) '(compile-file "error.sls")' | scheme -q hash-code.so immutable-hash.so

immutable-hash.so: immutable-hash.sls equal.so hash-code.so
	$(COMP) '(compile-file "immutable-hash.sls")' | scheme -q struct.so equal.so hash-code.so

hash-code.so: hash-code.sls struct.so
	$(COMP) '(compile-file "hash-code.sls")' | scheme -q struct.so

equal.so: equal.sls struct.so
	$(COMP) '(compile-file "equal.sls")' | scheme -q struct.so


struct-demo:
	scheme struct.so struct-demo.ss

struct.so: struct.sls
	$(COMP) '(compile-file "struct.sls")' | scheme -q


# For running a Racket program through the expander and flattener, similar to
# the way "expand.sls" works. After the expander works, the intent it that
# Racket programs are run by the expander running on Chez, instead.

KNOT = ++knot read - ++knot main - ++knot core - ++knot boot - ++knot place-struct -

file: regexp.so error.so path.so struct.so hash-code.so hash.so equal.so port.so immutable-hash.so linklet.so prefix.scm convert.rkt
	racket -l expander/bootstrap-run -- -c compiled/cache-src $(KNOT) -s -x -o compiled/$(ARGS).rktl -t $(ARGS)
	echo ';; generated file' > compiled/$(ARGS).sls
	echo '(top-level-program' >> compiled/$(ARGS).sls
	cat prefix.scm >> compiled/$(ARGS).sls
	racket convert.rkt < compiled/$(ARGS).rktl >> compiled/$(ARGS).sls
	echo ')' >> compiled/$(ARGS).sls
	$(COMP) | scheme -q regexp.so error.so path.so struct.so hash-code.so hash.so equal.so port.so immutable-hash.so linklet.so compiled/$(ARGS).sls
