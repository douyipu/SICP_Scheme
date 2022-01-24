#lang sicp

(#%require "stream.scm")
   
(define (neg-stream s)
  (scale-stream s -1))
(define (invert-unit-series s)
  (define x
    (cons-stream 1 (neg-stream (mul-series (stream-cdr s) x))))
  x)
(define cosine-series (cons-stream 1 (neg-stream (integrate-series sine-series))))
(define sine-series (cons-stream 0 (integrate-series cosine-series)))

(define (div-series s1 s2)
  (if (= (stream-car s2) 0)
      (error "constant term of s2 can't be 0 -- DIV-SERIES")
      (mul-series s1 (invert-unit-series s2))))

(define tangent-series
  (div-series sine-series cosine-series))
(show sine-series 10)
(show cosine-series 10)
(show tangent-series 10)
