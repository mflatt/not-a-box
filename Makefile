
COMP = echo '(reset-handler abort) (keyboard-interrupt-handler abort)'

go: expander.so
	scheme regexp.so error.so path.so struct.so hash-code.so hash.so equal.so port.so expander.so

expander.so: expander.sls expander.scm struct.so hash-code.so hash.so equal.so port.so bytes.so regexp.so
	$(COMP) '(compile-file "expander.sls")' | scheme -q error.so struct.so equal.so hash-code.so hash.so path.so port.so bytes.so regexp.so 

expander.scm: expander.rktl convert.rkt
	racket convert.rkt < expander.rktl > expander.scm


regexp-demo: regexp.so
	scheme struct.so equal.so hash-code.so immutable-hash.so hash.so path.so port.so bytes.so regexp.so regexp-demo.ss

regexp.so: regexp.scm regexp.sls bytes.so port.so error.so
	$(COMP) '(compile-file "regexp.sls")' | scheme -q error.so struct.so equal.so hash-code.so immutable-hash.so bytes.so hash.so path.so port.so

regexp.scm: regexp.rktl convert.rkt
	racket convert.rkt < regexp.rktl > regexp.scm


port-demo: port.so
	scheme equal.so hash-code.so hash.so path.so bytes.so port.so port-demo.ss

port.so: port.scm port.sls port-compat.scm equal.so struct.so hash-code.so immutable-hash.so hash.so bytes.so path.so
	$(COMP) '(compile-file "port.sls")' | scheme -q struct.so equal.so hash-code.so immutable-hash.so hash.so path.so bytes.so

port.scm: port.rktl convert.rkt
	racket convert.rkt < port.rktl > port.scm

path.so: path.sls path.scm struct.so error.so bytes.so hash.so
	$(COMP) '(compile-file "path.sls")' | scheme -q struct.so error.so bytes.so hash.so

path.scm: path.rktl convert.rkt
	racket convert.rkt < path.rktl > path.scm

bytes.so: bytes.sls
	$(COMP) '(compile-file "bytes.sls")' | scheme -q

hash-demo: immutable-hash.so hash.so
	scheme struct.so equal.so hash-code.so immutable-hash.so hash.so hash-demo.ss

hash.so: hash.sls hash-code.so immutable-hash.so error.so
	$(COMP) '(compile-file "hash.sls")' | scheme -q struct.so hash-code.so immutable-hash.so error.so

immutable-hash.so: immutable-hash.sls hash-code.so error.so
	$(COMP) '(compile-file "immutable-hash.sls")' | scheme -q struct.so hash-code.so error.so

hash-code.so: hash-code.sls struct.so
	$(COMP) '(compile-file "hash-code.sls")' | scheme -q struct.so

equal.so: equal.sls struct.so
	$(COMP) '(compile-file "equal.sls")' | scheme -q struct.so

struct-demo:
	scheme struct.so struct-demo.ss

struct.so: struct.sls
	$(COMP) '(compile-file "struct.sls")' | scheme -q

error.so: error.sls
	$(COMP) '(compile-file "error.sls")' | scheme -q
