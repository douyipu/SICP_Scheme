#lang sicp

;在 analyzingmceval.scm 的基础上修改测试。analyze 函数增加判断
;
;((let? exp) (analyze (let->combination exp)))
;
;之后就是 练习 4.6 的代码
;
;(define (let? exp) (tagged-list? exp 'let))
;
;(define (let->combination exp)
;  (define (let-body exp) (cddr exp))
;  (define (let-vars exp) (map car (cadr exp)))
;  (define (let-exps exp) (map cadr (cadr exp)))
;  
;  (cons (make-lambda (let-vars exp) 
;                     (let-body exp)) 
;        (let-exps exp)))