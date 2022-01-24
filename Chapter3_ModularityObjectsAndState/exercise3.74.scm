#lang sicp

(#%require "stream.scm")

(define (sign-change-detector a b)
  (cond ((and (< a 0) (> b 0)) 1)
        ((and (> a 0) (< b 0)) -1)
        (else 0)))

(define (make-zero-crossings input-stream last-value)
  (cons-stream
   (sign-change-detector
    (stream-car input-stream)
    last-value)
   (make-zero-crossings
    (stream-cdr input-stream)
    (stream-car input-stream))))

(define (list->stream lst)
  (if (null? lst)
      the-empty-stream
      (cons-stream (car lst) (list->stream (cdr lst)))))

(define sense-data-lst '(1 2 1.5 1 0.5 -0.1 -2 -3 -2 -0.5 0.2 3 4))
(define sense-data (list->stream sense-data-lst))
(define zero-crossings
  (make-zero-crossings sense-data 0))
(show zero-crossings 11)
(define zero-crossings-2
  (stream-map sign-change-detector
              sense-data
              (cons-stream 0 sense-data)))

(show zero-crossings-2 11)













