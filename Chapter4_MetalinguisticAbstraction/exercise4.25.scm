#lang sicp

(define (unless condition usual-value exceptional-value)
  (if condition exceptional-value usual-value))
(define (factorial n)
  (unless (= n 1)
          (* n (factorial (- n 1)))
          1))
;(factorial 5)
; when n equals to 0, factorial 0 will loop forever.