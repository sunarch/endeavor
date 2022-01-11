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