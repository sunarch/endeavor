#lang racket

(module reader racket
  (require syntax/strip-context)

(provide (rename-out [endeavor-read read]
                     [endeavor-read-syntax read-syntax]))

(define (endeavor-read in)
  (syntax->datum
   (endeavor-read-syntax #f in)))

(define (endeavor-read-syntax src in)
  (with-syntax ([str (port->string in)])
    (strip-context
     #'(module anything racket
         (provide data)
         (define data "endeavor"))))))

(module+ test
  ;; Any code in this `test` submodule runs when this file is run using DrRacket
  ;; or with `raco test`. The code here does not run when this file is
  ;; required by another module.

  (require rackunit)

  (check-equal? (+ 2 2) 4))

(module+ main
  ;; (Optional) main submodule. Put code here if you need it to be executed when
  ;; this file is run using DrRacket or the `racket` executable.  The code here
  ;; does not run when this file is required by another module. Documentation:
  ;; http://docs.racket-lang.org/guide/Module_Syntax.html#%28part._main-and-test%29

  (require racket/cmdline)
  (command-line
    #:program "endeavor-cli"
    #:args ()
    (display "endeavor")))
