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
(define (cube x) (* x x x))
(define (weight pair)
  (+ (cube (car pair))
     (cube (cadr pair))))

(define pairs (weighted-pairs integers integers weight))

(define (ramanujan-num pairstream n)
  (define (iter pairs sum count repeat)
    (if (= count n)
        'done
        (let ((the-weight (weight (stream-car pairs))))
          (cond ((and (= sum the-weight) (= repeat 0))
                 (display the-weight) (newline)
                 (iter (stream-cdr pairs) sum (+ count 1) (+ repeat 1)))
                ((and (not (= sum the-weight)) (> repeat 0))
                 (iter (stream-cdr pairs) the-weight count 0))
                (else
                 (iter (stream-cdr pairs) the-weight count repeat))))))
  (iter pairstream 0 0 0))

(ramanujan-num pairs 6)







