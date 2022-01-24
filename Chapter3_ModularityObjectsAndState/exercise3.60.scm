#lang sicp

(#%require "stream.scm")

(define (divide-stream s1 s2)
  (stream-map / s1 s2))
(define (integrate-series s)
  (divide-stream s integers))
(define (neg-stream s)
  (scale-stream s -1))
(define cosine-series (cons-stream 1 (neg-stream (integrate-series sine-series))))
(define sine-series (cons-stream 0 (integrate-series cosine-series)))

(define (mul-series s1 s2)
  (cons-stream
   (* (stream-car s1) (stream-car s2))
   (add-streams (scale-stream (stream-cdr s1) (stream-car s2))
                (mul-series s1 (stream-cdr s2)))))
(show (add-streams (mul-series sine-series sine-series)
                   (mul-series cosine-series cosine-series)) 10)
