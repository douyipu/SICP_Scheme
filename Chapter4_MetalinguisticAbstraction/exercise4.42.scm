#lang sicp

(#%require "ambeval.scm")

(easy-ambeval 10 '(begin

(define (distinct? items)
  (cond ((null? items) true)
        ((null? (cdr items)) true)
        ((member (car items) (cdr items)) false)
        (else (distinct? (cdr items)))))

(define (true-false a b)
  (require
    (if a
        (not b)
        b)))
                    
(define (liars-puzzle)
  (let ((betty (amb 1 2 3 4 5)) (ethel (amb 1 2 3 4 5))
        (joan  (amb 1 2 3 4 5)) (kitty (amb 1 2 3 4 5))
        (mary  (amb 1 2 3 4 5)))
    (require (true-false (= kitty 2) (= betty 3)))
    (require (true-false (= ethel 1) (= joan 2)))
    (require (true-false (= joan 3) (= mary 4)))
    (require (true-false (= mary 4) (= betty 1)))
    (require
      (distinct? (list betty ethel joan kitty mary)))
    
    (list (list 'betty betty) (list 'ethel ethel)
          (list 'joan joan)   (list 'kitty kitty)
          (list 'mary mary))))

(liars-puzzle)

))
