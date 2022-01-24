#lang sicp
(#%require "stream.scm")

(define (add-streams s1 s2) (stream-map + s1 s2))
(define s (cons-stream 1 (add-streams s s)))

(show s 10)