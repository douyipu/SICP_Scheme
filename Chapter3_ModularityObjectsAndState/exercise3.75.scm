#lang sicp

(#%require "stream.scm")

(define (sign-change-detector a b)
  (cond ((and (< a 0) (> b 0)) 1)
        ((and (> a 0) (< b 0)) -1)
        (else 0)))

(define (make-zero-crossings input-stream last-avpt last-value)
  (let ((avpt (/ (+ (stream-car input-stream)
                    last-value)
                 2)))
    (cons-stream
     (sign-change-detector avpt last-avpt)
     (make-zero-crossings
      (stream-cdr input-stream) avpt (stream-car input-stream)))))

(define (list->stream lst)
  (if (null? lst)
      the-empty-stream
      (cons-stream (car lst) (list->stream (cdr lst)))))

(define sense-data-lst '(1 2 1.5 1 0.5 -0.1 -2 -3 -2 -0.5 0.2 3 4))
(define sense-data (list->stream sense-data-lst))
(define zero-crossings
  (make-zero-crossings sense-data 0 0))
(show zero-crossings 11)
