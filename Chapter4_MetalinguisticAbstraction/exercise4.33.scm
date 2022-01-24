#lang sicp

(#%require "lazyeval.scm")

(define (eval-quotation exp env)
  (define (list->cons lst)
    (if (null? lst)
        ''()
        (list 'cons (list 'quote (car lst))
              (list->cons (cdr lst)))))
  (let ((lst (cadr exp)))
    (if (pair? lst)
        (eval (list->cons lst) env)
        lst)))