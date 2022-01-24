#lang sicp

(#%require "ambeval.scm")

(easy-ambeval 10 '(begin

(define (distinct? items)
  (cond ((null? items) true)
        ((null? (cdr items)) true)
        ((member (car items) (cdr items)) false)
        (else (distinct? (cdr items)))))
                    
(define (eight-queens-puzzle)
  (let ((moore   (amb 'gabrielle 'rosalind 'anonymous))
        (downing (amb 'gabrielle 'lorna 'rosalind 'anonymous))
        (hall    (amb 'gabrielle 'lorna 'anonymous))
        (hood    'melissa)
        (parker  (amb 'lorna 'rosalind 'anonymous)))

    (require
      (distinct? (list moore downing hall hood parker)))
    
    (list (list 'moore moore) (list 'downing downing)
          (list 'hall hall)   (list 'hood hood)
          (list 'parker parker))))

(eight-queens-puzzle)

))