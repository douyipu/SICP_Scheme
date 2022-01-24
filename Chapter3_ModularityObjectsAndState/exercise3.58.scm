#lang sicp

(#%require "stream.scm")

(define (expand num den radix)
  (cons-stream
   (quotient (* num radix) den)
   (expand (remainder (* num radix) den) den radix)))

(show (expand 1 7 10) 20)
(newline)
(show (expand 3 8 10) 20)

; expand 其实在模拟手算的过程,计算分数在 n 进制中的小数数字。
; 其中 num 表示分子(numerator), den 表示分母(denominator),radix 表示进制。

