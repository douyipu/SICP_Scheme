#lang racket
;; P220 - [3.5.1 流作为延时的表]

(provide cons-stream stream-car stream-cdr stream-null? the-empty-stream)
(provide stream-enumerate-interval display-stream display-stream-n display-line stream-ref)
(provide stream-filter stream-map add-streams mul-streams scale-stream)
(provide show)
(provide integers fibs)
(provide integrate-series mul-series)
(provide partial-sums euler-transform make-tableau accelerated-sequence)

(require "ch3support.scm")

(define (stream-car stream) (car stream))
(define (stream-cdr stream) (force (cdr stream)))
(define (stream-null? stream) (null? stream))
(define the-empty-stream '())

(define-syntax cons-stream
  (syntax-rules ()
    ((_ A B) (cons A (delay B)))))

(define (memo-proc proc)
  (let ((already-run? false)
        (result false))
    (lambda ()
      (if (not already-run?)
          (begin
            (set! result (proc))
            (set! already-run? true)
            result)
          result))))

(define (force delayed-object)
  (delayed-object))

; 具有记忆过程
(define-syntax delay
  (syntax-rules ()
    ((_ exp) (memo-proc (lambda () exp)))))

; 没有记忆过程 
;(define-syntax delay
;  (syntax-rules ()
;    ((_ exp) (lambda () exp))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (stream-ref s n)
  (if (= n 0)
      (stream-car s)
      (stream-ref (stream-cdr s) (- n 1))))

;; P225 - [练习 3.50]
(define (stream-map proc . argstreams)
  (if (stream-null? (car argstreams))
      the-empty-stream
      (cons-stream 
        (apply proc (map stream-car argstreams))
        (apply stream-map
               (cons proc (map stream-cdr argstreams))))))

(define (stream-map-2 proc s)
  (if (stream-null? s)
      the-empty-stream
      (cons-stream (proc (stream-car s))
                   (stream-map-2 proc (stream-cdr s)))))

(define (stream-for-each proc s)
  (cond ((not (stream-null? s))
         (proc (stream-car s))
         (stream-for-each proc (stream-cdr s)))))

(define (stream-filter pred stream)
  (cond ((stream-null? stream) the-empty-stream)
        ((pred (stream-car stream))
         (cons-stream (stream-car stream)
                      (stream-filter pred
                                     (stream-cdr stream))))
        (else (stream-filter pred (stream-cdr stream)))))

(define (display-stream s)
  (stream-for-each display-line s))

(define (display-stream-n s n)
  (cond ((and (> n 0) (not (stream-null? s)))
         (display-line (stream-car s))
         (display-stream-n (stream-cdr s) (- n 1)))))

(define (display-line x)
  (display x)
  (newline))

(define (stream-enumerate-interval low high)
  (if (> low high)
      the-empty-stream
      (cons-stream low
                   (stream-enumerate-interval (+ low 1) high))))

(define (add-streams s1 s2) (stream-map + s1 s2))

(define (mul-streams s1 s2)
  (stream-map * s1 s2))

(define (scale-stream stream factor)
  (stream-map (lambda (x) (* x factor))
              stream))

(define (show stream n)
  (define (iter s count)
    (cond ((not (> count n))
           (display (stream-ref s count))
           (display " ")
           (iter s (+ count 1)))))
  (iter stream 0)
  (newline))

(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))
(define integers (integers-starting-from 1))

(define (fibgen a b) (cons-stream a (fibgen b (+ a b))))
(define fibs (fibgen 0 1))

(define (divide-stream s1 s2)
  (stream-map / s1 s2))
(define (integrate-series s)
  (divide-stream s integers))
(define (neg-stream s)
  (scale-stream s -1))
(define cosine-series (cons-stream 1 (neg-stream (integrate-series sine-series))))
(define sine-series (cons-stream 0 (integrate-series cosine-series)))

(define (mul-series s1 s2)
  (cons-stream
   (* (stream-car s1) (stream-car s2))
   (add-streams (scale-stream (stream-cdr s1) (stream-car s2))
                (mul-series s1 (stream-cdr s2)))))

(define (partial-sums s)
  (define sums
    (cons-stream (stream-car s)
                 (add-streams sums (stream-cdr s))))
    sums)

(define (square x) (* x x))
(define (euler-transform s)
  (let ((s0 (stream-ref s 0))
        (s1 (stream-ref s 1))
        (s2 (stream-ref s 2)))
    (cons-stream (- s2 (/ (square (- s2 s1))
                          (+ s0 (* -2 s1) s2)))
                 (euler-transform (stream-cdr s)))))
(define (make-tableau transform s)
  (cons-stream s (make-tableau transform (transform s))))
(define (accelerated-sequence transform s)
  (stream-map stream-car (make-tableau transform s)))

