#lang sicp

(define (sqrt x)
  (define (good-enough? guess)
    (< (abs (- (square guess) x)) 0.001))
  (define (improve guess)
    (average guess (/ x guess)))
  (define (sqrt-iter guess)
    (if (good-enough? guess)
        guess
        (sqrt-iter (improve guess))))
  (sqrt-iter 1.0))

; Begin by assuming that good-enough? and improve operations
; are available as primitives.
(controller
 (assign guess (const 1.0))
 test-guess
   (test (op good-enough?) (reg guess))
   (branch (label sqrt-done))
   (assign guess (op improve) (reg guess))
   (goto (label test-guess))
 sqrt-done)

; good-enough? 机器,展开 square 和 abs 为算术运算
(controller
 (assign t (op *) (reg guess) (reg guess))
 (assign t (op -) (reg t) (reg x))
 (test (op <) (reg t) (const 0))
 (branch (label abs-positive))
 (assign t (op *) (reg t) (const -1))
 abs-positive
   (test (op <) (reg t) (const 0.001)))

; improve 机器,展开 average 为算术运算。
(controller
 (assign t (op /) (reg x) (reg guess))
 (assign t (op +) (reg guess) (reg t))
 (assign t (op /) (reg t) (const 2)))

; 完整的 sqrt 机器
; 将 good-enough? 和 improve 机器,嵌入到 sqrt 机器中。
; 得到最终的 sqrt 机器,只使用基本的算术运算实现。
(controller
 (assign guess (const 1.0))
 
 test-guess
   (assign t (op *) (reg guess) (reg guess))
   (assign t (op -) (reg t) (reg x))
   (test (op <) (reg t) (const 0))
   (branch (label abs-positive))
   (assign t (op *) (reg t) (const -1))
   
 abs-positive
   (test (op <) (reg t) (const 0.001))
   (branch (label sqrt-done))
   (assign t (op /) (reg x) (reg guess))
   (assign t (op +) (reg guess) (reg t))
   (assign guess (op /) (reg t) (const 2))
   (goto (label test-guess))
   
 sqrt-done)
   










