#lang sicp

(#%require "mceval.scm")

;我们在原来语法的基础上,新加一种新的赋值语法。比如
;
;(set! a 10)
;
;也可以写成
;
;(a := 10)
;
;在 mceval.scm 的基础上修改测试。

(define (new-assignment? exp)
  (and (pair? exp) 
       (pair? (cdr exp)) 
       (eq? (cadr exp) ':=)))

(define (assignment? exp)
  (or (tagged-list? exp 'set!)
      (new-assignment? exp)))

(define (assignment-variable exp)
  (if (tagged-list? exp 'set!) 
      (cadr exp)
      (car exp)))

(define (assignment-value exp) (caddr exp))

;添加新的 := 赋值语法,并不需要修改 eval 和 apply。
