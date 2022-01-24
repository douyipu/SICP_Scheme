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
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else
          (error "Unknown expression type -- EVAL" exp))))

(define (let? exp) (tagged-list? exp 'let))
(define (normal-let->combination exp)
  (define (let-body exp) (cddr exp))
  (define (let-vars exp) (map car (cadr exp)))
  (define (let-exps exp) (map cadr (cadr exp)))

  (cons (make-lambda (let-vars exp)
                     (let-body exp))
        (let-exps exp)))
(define (named-let->combination exp)
  (define (let-name exp) (cadr exp))
  (define (let-body exp) (cdddr exp))
  (define (let-vars exp) (map car (caddr exp)))
  (define (let-exps exp) (map cadr (caddr exp)))

  (define (let->define exp)
    (list 'define
          (cons (let-name exp) (let-vars exp))
          (car (let-body exp))))
  (define (call exp)
    (list (let->define exp)
          (cons (let-name exp) (let-exps exp))))

  (cons (make-lambda '()
                     (call exp))
        '()))

(define (let->combination exp)
  (if (symbol? (cadr exp))
      (named-let->combination exp)
      (normal-let->combination exp)))

(define (fib n)
  (let fib-iter ((a 1)
                 (b 0)
                 (count n))
    (if (= count 0)
        b
        (fib-iter (+ a b) a (- count 1)))))

;其中 fib 会转成
;(define (fib n)
;  ((lambda () 
;     (define (fib-iter a b count) 
;       (if (= count 0)
;           b 
;           (fib-iter (+ a b) a (- count 1)))) 
;     (fib-iter 1 0 n))))

(fib 9)

