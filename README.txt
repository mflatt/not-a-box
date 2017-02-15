Work-in-progress for running Racket on Chez Scheme.

The files:

 *.sls - Chez Scheme libraries that provide implementations of Racket
         primitives. In a few cases, such as hash tables, the library
         is implemented directly in Chez. In other cases (and most of
         them, in the long run), a corresponding "*.scm" file contains
         the implementation extracted from from expanded and flattened
         Racket code.

 *.scm - Either a conversion from a ".rktl" file or a temporary
         compatibility layer to be `include`d into an ".sls" library.

 *.rktl - A Racket library (e.g., to implement regexps) that has been
         fully macro expanded and flattened into a linklet. A
         linklet's only free variables are "primitives" that will be
         implemented by various ".sls" libraries in layers.

         For example, "regexp.rktl" is generated from `make
         regexp-src` in the "pkgs/regexp" in the "linklet" branch of
         the Racket repo.

 convert.rkt - A stop-gap linklet-to-library-body compiler, which is
         used to convert a ".rktl" file to a ".sls" file.

 *.ss - Chez scripts to check that a library basically works. For
        example "regexp-demo.ss" runs the regexp matcher on a few
        examples.

 *.rkt - Racket scripts like "convert.rkt" or comparisions like
       "regexp-demo.rkt". For example, you can run "regexp-demo.rkt"
       and compare the reported timing to "regexp-dem.ss".


Status and thoughts on various Racket subsystems:

 * "struct.sls" is half an implementation of Racket structures, with
   structure-type properties, applicable structs, `gen:equal+hash`,
   and so on in terms of Chez records. Applicable structs work by
   adding an indirection to each function call (in a little compiler
   from fully-expanded code to Chez) when the target is not obviously
   a plain procedure; even with a simple analysis, the indirection is
   not needed often in a typical program, and the overhead appears to
   be light.

   I think that `make-struct-type` needs to be different so that Chez
   can see through structure accesses. Specifically, I think that's
   why "port-demo.ss" runs slower in Chez than Racket.

   The rest of the implementation of Racket structures looks
   straightforward.

 * Delimited continuations and continuation marks can be implemented
   in terms of Chez primitives. It looks like there's room for
   improvement by building in some support for continuation marks,
   though.

 * The thread and event layer should be relatively easy to reimplement
   using Chez engines.

 * The Racket FFI looks a lot like the Chez FFI, so I expect that to
   mostly work, although there may be allocation issues.

 * The Racket and Chez numeric systems likely differ in some ways, and
   I don't know how much work that will be.

 * For futures, Chez exposes OS-level threads with limited safety
   guarantees. An implementation of futures can probably take
   advantage of threads with thread-unsafe primitives wrapped to
   divert to a barrier when called in a future.

 * Ephemerons probably require support from Chez, but I haven't
   investigated enough to be sure.

 * GC-based memory accounting similarly seems to require new support,
   but that can wait a while.

 * Extflonums will probably exist only on the Racket VM for a long
   while.

 * Bytecode, as it currently exists, goes away. Platform-independent
   ".zo" files might contain fully expanded source (possibly also run
   through Chez's source-to-source optimizer), and maybe `raco setup`
   will gain a new step in creating platform-specific compiled code.
