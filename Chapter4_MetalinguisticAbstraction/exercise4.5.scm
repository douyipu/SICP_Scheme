#lang sicp

;(assoc 'b '((a 1) (b 2)))
(cond ((assoc 'b '((a 1) (b 2))) => cadr)
      (else false))

(#%require "mceval.scm")

(define (eval-function=> exp env)
  (let ((test (car exp))
        (recipient (caddr exp)))
    (if (test)
        (recipient test)
        #f)))

(define (eval-cond exp env)
  (if (and (not (null? (cddr exp)))
           (null? (cdddr exp))
           (eq? '=> (cadr exp)))
      (eval-function=> exp env)
      (eval (cond->if exp) env)))

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
        ((cond? exp)
         (eval-cond exp env))
        ((let? exp) (eval (let->combination exp) env))
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else
          (error "Unknown expression type -- EVAL" exp))))














