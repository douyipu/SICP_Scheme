#lang sicp

(#%require "stream.scm")

(define (average a b) (/ (+ a b) 2))
(define (sqrt-improve guess x)
  (average guess (/ x guess)))
(define (sqrt-stream x)
  (define guesses
    (cons-stream
     1.0
     (stream-map (lambda (guess) (sqrt-improve guess x))
                 guesses)))
  guesses)

(define (stream-limit s tolerence)
  (let ((sec-ele (stream-car (stream-cdr s))))
    (if (< (abs (- (stream-car s) sec-ele)) tolerence)
        sec-ele
        (stream-limit (stream-cdr s) tolerence))))
(define (sqrt x tolerance)
  (stream-limit (sqrt-stream x) tolerance))
(sqrt 2 0.00001)