#lang sicp

(#%require "mceval.scm")
(#%require "ch4support.scm")

(define (and? exp) (tagged-list? exp 'and))

(define (eval-and exp env)
  (define (loop exps env)
    (let ((first (eval (first-exp exps) env)))
      (cond ((last-exp? exps) first)
            (first (loop (rest-exps exps) env))
            (else #f))))
  (if (null? (cdr exp))
      #t
      (loop (cdr exp) env)))

(define (or? exp) (tagged-list? exp 'or))

(define (eval-or exp env)
  (define (loop exps env)
    (let ((first (eval (first-exp exps) env)))
      (cond ((last-exp? exps) first)
            (first #t)
            (else (loop (rest-exps exps) env)))))
  (if (null? (cdr exp))
      #f
      (loop (cdr exp) env)))
