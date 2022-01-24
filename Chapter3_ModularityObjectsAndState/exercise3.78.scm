#lang racket

(require "stream.scm")

(define (integral delayed-integrand initial-value dt)
  (cons-stream initial-value
               (let ((integrand (force delayed-integrand)))
                 (if (stream-null? integrand)
                     the-empty-stream
                     (integral (delay (stream-cdr integrand))
                               (+ (* dt (stream-car integrand))
                                  initial-value)
                               dt)))))

(define (solve-2nd a b dt y0 dy0)
  (define y (integral (delay dy) y0 dt))
  (define dy (integral (delay ddy) dy0 dt))
  (define ddy (add-streams (scale-stream dy a)
                           (scale-stream y b)))
  y)

;;;;;;;;;;;;;;;;;
; ddy + 2 * dy + y = 0
; y(0) = 4, dy(0) = -2
(displayln "solve-2nd")
(display-stream-n (solve-2nd -2 -1 0.001 4 -2) 20)

; 上面微分方程,特解为 y = (4 + 2t) * exp(-t), 直接打印出方程值作对比
(define (solution t)
  (* (+ 4 (* 2 t)) (exp (- t))))
(define (solution-steam t dt)
  (cons-stream (solution t) (solution-steam (+ t dt) dt)))
(displayln "solution")
(display-stream-n (solution-steam 0 0.001) 20)
