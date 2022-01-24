#lang sicp

(#%require "stream.scm")

(define (neg-stream s)
  (scale-stream s -1))

(define (invert-unit-series s)
  (define x
    (cons-stream 1 (neg-stream (mul-series (stream-cdr s) x))))
  x)

(show (invert-unit-series integers) 10)
