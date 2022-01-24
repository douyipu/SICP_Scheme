#lang sicp

(#%require "stream.scm")

; a)
(define (divide-stream s1 s2)
  (stream-map / s1 s2))
(define (integrate-series s)
  (divide-stream s integers))
(show (integrate-series fibs) 10)
; b)
(define exp-series
  (cons-stream 1 (integrate-series exp-series)))
(show exp-series 10)

(define (neg-stream s)
  (scale-stream s -1))
(define cosine-series (cons-stream 1 (neg-stream (integrate-series sine-series))))
(define sine-series (cons-stream 0 (integrate-series cosine-series)))

(show cosine-series 10)
(show sine-series 10)
