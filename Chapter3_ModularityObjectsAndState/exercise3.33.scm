#lang sicp
(#%require "constraints.scm")

(define (averager a b c)
  (let ((d (make-connector))
        (e (make-connector)))
    (adder a b d)
    (multiplier c e d)
    (constant 2 e)
    'ok))

;;;;;;;;;;;;;;;;;;;;;;;
(define a (make-connector))
(define b (make-connector))
(define c (make-connector))

(probe "a" a)
(probe "b" b)
(probe "c" c)

(averager a b c)

(set-value! a 20 'user)
(set-value! b 10 'user)

(forget-value! a 'user)
(set-value! c 40 'user)