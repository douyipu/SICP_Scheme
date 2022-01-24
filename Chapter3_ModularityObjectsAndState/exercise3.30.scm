#lang sicp
(define (ripple-carry-adder A B S c-out)
  (define (helper A B S c-in c-out)
    (if (null? (cdr A))
        (full-adder (car A) (car B) c-in (car S) c-out)
        (let ((wire (make-wire)))
          (helper (cdr A) (cdr B) (cdr S) c-in wire)
          (full-adder (car A) (car B) wire (car S) c-out))))
  
  (let ((c-in (make-wire)))
    (set-signal! c-in 0)
    (helper A B S c-in c-out)
    'ok))
