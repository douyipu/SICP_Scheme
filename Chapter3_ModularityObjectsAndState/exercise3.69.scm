#lang sicp

(#%require "stream.scm")

(define (interleave s1 s2)
  (if (stream-null? s1)
      s2
      (cons-stream (stream-car s1)
                   (interleave s2 (stream-cdr s1)))))

(define (pairs s t)
  (cons-stream
   (list (stream-car s) (stream-car t))
   (interleave
    (stream-map (lambda (x) (list (stream-car s) x))
                (stream-cdr t))
    (pairs (stream-cdr s) (stream-cdr t)))))

(define (triples s t u)
  (cons-stream
   (list (stream-car s) (stream-car t) (stream-car u))
   (interleave
    (stream-map (lambda (x) (cons (stream-car s) x))
                (stream-cdr (pairs t u)))
    (triples (stream-cdr s) (stream-cdr t) (stream-cdr u)))))

(define int-triples 
  (triples integers integers integers))
(define (square x) (* x x))
(define (pythagorean? t)
  (let ((t0 (car t))
        (t1 (cadr t))
        (t2 (caddr t)))
    (= (+ (square t0) (square t1)) (square t2))))

(define pythagorean-triples
  (stream-filter pythagorean? int-triples))

(show pythagorean-triples 5)

