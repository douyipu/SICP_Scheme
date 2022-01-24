#lang sicp

(#%require "mceval.scm")

(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        ((lambda? exp)
         (make-procedure (lambda-parameters exp)
                         (lambda-body exp)
                         env))
        ((begin? exp) 
         (eval-sequence (begin-actions exp) env))
        ((cond? exp) (eval (cond->if exp) env))
        ((let? exp) (eval (let->combination exp) env))
        ((let*? exp) (eval (let*->nested-lets exp) env))
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else
          (error "Unknown expression type -- EVAL" exp))))

(define (let*? exp) (tagged-list? exp 'let*))
(define (let*->nested-lets exp)
  (define (make-let pairs body)
    (list 'let pairs body))
  (define (let*-pairs exp) (cadr exp))
  (define (let*-body exp) (cddr exp))
  (define (extend pairs body)
    (if (null? (cdr pairs))
        (make-let pairs body)
        (make-let (list (car pairs))
                  (list (extend (cdr pairs) body)))))
  (extend (let*-pairs exp)
          (let*-body exp)))






















