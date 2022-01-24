#lang sicp

(#%require "stream.scm")

(define (merge-weighted s1 s2 weight)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
         (let ((w1 (weight (stream-car s1)))
               (w2 (weight (stream-car s2))))
           (cond ((< w1 w2)
                  (cons-stream (stream-car s1)
                               (merge-weighted (stream-cdr s1) s2 weight)))
                 ((< w2 w1)
                  (cons-stream (stream-car s2)
                               (merge-weighted s1 (stream-cdr s2) weight)))
                 (else
                  (cons-stream (stream-car s1)
                               (cons-stream (stream-car s2)
                                            (merge-weighted (stream-cdr s1)
                                                            (stream-cdr s2)
                                                            weight)))))))))


(define (weighted-pairs s t weight) 
  (cons-stream 
   (list (stream-car s) (stream-car t)) 
   (merge-weighted 
    (stream-map (lambda (x) (list (stream-car s) x)) 
                (stream-cdr t)) 
    (weighted-pairs (stream-cdr s) (stream-cdr t) weight) 
    weight))) 
; a)
(define (weight-a pair)
  (+ (car pair) (cadr pair)))

(define a-pairs (weighted-pairs integers integers weight-a))
(show a-pairs 20)
; b)
(define (weight-b pair)
  (+ (* 2 (car pair))
     (* 3 (cadr pair))
     (* 5 (car pair) (cadr pair))))
(define filter-integers
  (stream-filter (lambda (x)
                   (not (or (= (remainder x 2) 0)
                            (= (remainder x 3) 0)
                            (= (remainder x 5) 0))))
                 integers))
(define b-pairs (weighted-pairs filter-integers filter-integers weight-b))
(show b-pairs 20)


















