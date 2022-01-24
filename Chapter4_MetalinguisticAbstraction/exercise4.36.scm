#lang sicp

(#%require "ambeval.scm")

(easy-ambeval 10 '(begin
                    
(define (require p)
  (if (not p) (amb)))

(define (an-integer-between low high)
  (require (<= low high))
  (amb low (an-integer-between (+ low 1) high)))               

(define (an-integer-starting-from n)
  (amb n (an-integer-starting-from (+ n 1))))

(define (square x) (* x x))
(define (pythagorean-triple? i j k)
  (= (+ (square i) (square j))
     (square k)))

(define (a-pythagorean-triple)
  (let ((k (an-integer-starting-from 1)))
    (let ((j (an-integer-between 1 k)))
      (let ((i (an-integer-between 1 j)))
        (require (pythagorean-triple? i j k))
        (list i j k)))))

(a-pythagorean-triple)

))
