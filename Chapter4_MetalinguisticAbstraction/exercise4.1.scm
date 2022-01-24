#lang sicp
(#%require "mceval.scm")

(define (f a)
  (display a)
  (newline)
  a)

; from left to right
(define (list-of-values-lr exps env)
  (if (no-operands? exps)
      '()
      (let ((first (eval (first-operand exps) env)))
        (cons first (list-of-values-lr first (rest-operands exps) env)))))

; from right to left
(define (list-of-values-rl exps env)
  (if (no-operands? exps)
      '()
      (let ((rest (list-of-values-rl (rest-operands exps) env)))
        (cons (eval (first-operand exps) env) rest))))
