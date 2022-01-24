#lang sicp

;Ben 说得对。本题中描述的方法比练习 4.35 的方法,效率更高。
;练习 4.35 中,有 i、j、k 三层嵌套搜索,而此题中的方法只有 i、j 两层嵌套搜索。
;k 的搜索直接被 sqrt 函数替代了。
;当搜索的区间很大时,计算 sqrt 会比被直接遍历搜索快得多。并且区间越大,本题的方法效率提升越明显。

(#%require "ambeval.scm")
(#%require (only racket current-inexact-milliseconds))

(easy-ambeval 5 '(begin
                    
(define (require p)
  (if (not p) (amb)))

(define (an-integer-between low high)
  (require (<= low high))
  (amb low (an-integer-between (+ low 1) high)))

(define (a-pythagorean-triple-between low high)
  (let ((i (an-integer-between low high))
        (hsq (* high high)))
    (let ((j (an-integer-between i high)))
      (let ((ksq (+ (* i i) (* j j))))
        (require (>= hsq ksq))
        (let ((k (sqrt ksq)))
          (require (integer? k))
          (list i j k))))))

(a-pythagorean-triple-between 1 100)

))
(define star-time (current-inexact-milliseconds))
(easy-ambeval 10 '(begin
(a-pythagorean-triple-between 1 100)
;(a-pythagorean-triple-between-ex-4.37 1 400)
))
(- (current-inexact-milliseconds) star-time)

