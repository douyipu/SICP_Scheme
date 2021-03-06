#lang racket

(require "ch4support.scm")

(define (multiple-dwelling)
  (define (ok? lst)
    (let ((baker (list-ref lst 0))
          (cooper (list-ref lst 1))
          (fletcher (list-ref lst 2))
          (miller (list-ref lst 3))
          (smith (list-ref lst 4)))
      (and (not (= baker 5))
           (not (= cooper 1))
           (not (= fletcher 5))
           (not (= fletcher 1))
           (> miller cooper)
           (not (= (abs (- smith fletcher)) 1))
           (not (= (abs (- fletcher cooper)) 1)))))
  (map (lambda (lst)
         (list (list 'baker (list-ref lst 0))
               (list 'cooper (list-ref lst 1))
               (list 'fletcher (list-ref lst 2))
               (list 'miller (list-ref lst 3))
               (list 'smith (list-ref lst 4))))
       (filter ok? (permutations (list 1 2 3 4 5)))))

(multiple-dwelling)
