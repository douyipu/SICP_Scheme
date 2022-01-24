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
        ((unbound? exp) (eval-unbound exp env))
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else
          (error "Unknown expression type -- EVAL" exp))))

;我们将 unbound 定义成 define 的逆操作,消除 define 的影响。define 只操作第一个框架(frame), 我们将 unbound 定义成:

;只删除第一个框架的约束。
;假如在第一个框架中,找不到对应的 var, 返回出错消息。

;在 mceval.scm 的基础上修改测试。在 eval 增加一个判断:

;((unbound? exp) (eval-unbound exp env))

;实现代码为:

(define (unbound? exp)
  (tagged-list? exp 'unbound))

(define (eval-unbound exp env)
  (make-unbound! (cadr exp) env)
  'ok)

(define (make-unbound! var env)
  (let ((frame (first-frame env)))
    (define (scan pre-vars pre-vals vars vals)
      (cond ((null? vars)
             (error "Unbound variable -- MAKE-UNBOUND!" var))
            ((eq? var (car vars))
             (if (null? pre-vars)
                 (begin
                   (set-car! frame (cdr vars))
                   (set-cdr! frame (cdr vals)))
                 (begin
                   (set-cdr! pre-vars (cdr vars))
                   (set-cdr! pre-vals (cdr vals)))))
            (else (scan vars vals (cdr vars) (cdr vals)))))
    (scan '()
          '()
          (frame-variables frame)
          (frame-values frame))))                 
