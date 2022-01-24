#lang sicp
(#%require "stream.scm")

(define (partial-sums s)
  (define sums
    (cons-stream (stream-car s)
                 (add-streams sums (stream-cdr s))))
    sums)

(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))
(define integers (integers-starting-from 1))

(show (partial-sums integers) 10)
