#lang sicp

(#%require "mceval.scm")

(define (let? exp) (tagged-list? exp 'let))

(define (let->combination exp)
  (define (let-body exp) (cddr exp))
  (define (let-vars exp) (map car (cadr exp)))
  (define (let-exps exp) (map cadr (cadr exp)))

  (cons (make-lambda (let-vars exp)
                     (let-body exp))
        (let-exps exp)))
                     
(define (f a) a)

(let ((a (f 'Hello))
      (b (f 'World)))
  (display a)
  (display b))
        






































