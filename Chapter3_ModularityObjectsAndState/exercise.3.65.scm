#lang sicp

(#%require "stream.scm")

(define (pi-summands n)
  (cons-stream (/ 1.0 n)
               (stream-map - (pi-summands (+ n 1)))))
(define pi-stream
  (partial-sums (pi-summands 1)))
(show (accelerated-sequence euler-transform pi-stream) 10)