#lang sicp

(#%require "mceval.scm")

(define (filter predicate sequence)
  (if (null? sequence)
      '()
      (if (predicate (car sequence))
          (cons (car sequence) (filter predicate (cdr sequence)))
          (filter predicate (cdr sequence)))))
(append (list 1 2) (list 3 4) (list 5 6))

(list (list 1 2) (list 3 4))
(cons (list 1 2) (list 3 4))
(list 'u ''a)
(cons 'u ''a)

(define (f x)
  (letrec
      ((even? (lambda (n)
                (if (= n 0) true (odd? (- n 1)))))
       (odd? (lambda (n)
               (if (= n 0) false (even? (- n 1))))))
    (even? x)))
(f 2)