SCHEME = scheme
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

expander-demo: expander.so demo/expander.ss
	$(SCHEME) $(EXPANDER_DEPS) expander.so demo/expander.ss

PRIMITIVES_TABLES = primitive/kernel.scm primitive/unsafe.scm primitive/flfxnum.scm

expander.so: expander.sls linklet/expander.scm expander-compat.scm $(PRIMITIVES_TABLES) $(EXPANDER_DEPS)
	$(COMP) '(compile-file "expander.sls")' | $(SCHEME) -q $(EXPANDER_DEPS)

linklet/expander.scm: linklet/expander.rktl $(CONVERT_DEPS)
	racket convert.rkt linklet/expander.rktl linklet/expander.scm


linklet-demo: linklet.so
	$(SCHEME) $(LINKLET_DEPS) linklet.so demo/linklet.ss

linklet.so: linklet.sls $(LINKLET_DEPS)
	$(COMP) '(compile-file "linklet.sls")' | $(SCHEME) -q $(LINKLET_DEPS)

schemify.so: schemify.sls linklet/schemify.scm $(SCHEMIFY_DEPS)
	$(COMP) '(compile-file "schemify.sls")' | $(SCHEME) -q $(SCHEMIFY_DEPS)

linklet/schemify.scm: linklet/schemify.rktl $(CONVERT_DEPS)
	racket convert.rkt --skip-export linklet/schemify.rktl linklet/schemify.scm

known-primitive.so: known-primitive.sls
	$(COMP) '(compile-file "known-primitive.sls")' | $(SCHEME) -q

known-primitive.sls: known-primitive.rkt
	racket known-primitive.rkt


regexp-demo: regexp.so demo/regexp.scm
	$(SCHEME) $(REGEXP_DEPS) regexp.so demo/regexp.ss

regexp.so: linklet/regexp.scm regexp.sls $(REGEXP_DEPS)
	$(COMP) '(compile-file "regexp.sls")' | $(SCHEME) -q $(REGEXP_DEPS)

linklet/regexp.scm: linklet/regexp.rktl $(CONVERT_DEPS)
	racket convert.rkt linklet/regexp.rktl linklet/regexp.scm


port-demo: port.so
	$(SCHEME) $(PORT_DEPS) port.so demo/port.ss

port.so: linklet/port.scm port.sls $(PORT_DEPS)
	$(COMP) '(compile-file "port.sls")' | $(SCHEME) -q $(PORT_DEPS)

linklet/port.scm: linklet/port.rktl $(CONVERT_DEPS)
	racket convert.rkt linklet/port.rktl linklet/port.scm


thread-demo: thread.so
	$(SCHEME) $(THREAD_DEPS) thread.so demo/thread.ss

thread.so: linklet/thread.scm thread.sls $(THREAD_DEPS)
	$(COMP) '(compile-file "thread.sls")' | $(SCHEME) -q $(THREAD_DEPS)

linklet/thread.scm: linklet/thread.rktl $(CONVERT_DEPS)
	racket convert.rkt linklet/thread.rktl linklet/thread.scm


hash-demo: core.so
	$(SCHEME) chezpart.so core.so demo/hash.ss

struct-demo: core.so
	$(SCHEME) chezpart.so core.so demo/struct.ss

control-demo: core.so
	$(SCHEME) chezpart.so core.so demo/control.ss

CORE_SRCS = core/constant.ss \
            core/hash-code.ss \
            core/struct.ss \
            core/procedure.ss \
            core/hamt.ss \
            core/hash.ss \
	    core/lock.ss \
            core/thread-cell.ss \
            core/parameter.ss \
            core/begin0.ss \
            core/control.ss \
            core/interrupt.ss \
            core/engine.ss \
            core/error.ss \
            core/bytes.ss \
            core/string.ss \
            core/symbol.ss \
            core/list.ss \
            core/vector.ss \
            core/box.ss \
            core/immutable.ss \
            core/keyword.ss \
            core/mpair.ss \
            core/number.ss \
            core/correlated.ss \
            core/time.ss \
            core/memory.ss \
            core/system.ss \
            core/unsafe.ss

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
	rm -f chezpart.so core.so regexp.so port.so immutable-hash.so linklet.so known-primitive.so linklet.so expander.so schemify.so
	rm -f linklet/expander.scm linklet/port.scm linklet/regexp.scm linklet/schemify.scm linklet/thread.scm
