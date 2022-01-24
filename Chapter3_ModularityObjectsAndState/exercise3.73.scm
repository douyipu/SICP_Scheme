#lang sicp

(#%require "stream.scm")

(define (integral integrand initial-value dt)
  (define int
    (cons-stream initial-value
                 (add-streams (scale-stream integrand dt)
                              int)))
  int)

(define (RC r c dt)
  (lambda (i v0)
    (add-streams (scale-stream i r)
                 (integral i v0 dt))))

(define RC1 (RC 5 1 0.5))

(show (RC1 integers 1) 10)