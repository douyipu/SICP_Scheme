#lang sicp

((lambda (n)
   ((lambda (fact) (fact fact n))
    (lambda (ft k) (if (= k 1) 1 (* k (ft ft (- k 1)))))))
 10)

;这是一种小诡计。递归函数需要调用自身,既然不可以使用递归,
;我们就可添加多一个参数(就是那个 self 的参数), 调用时将自身也传递过去。

(define (fib self n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (self self (- n 1))
                 (self self (- n 2))))))
(fib fib 10)

((lambda (n)
   ((lambda (fib)
      (fib fib n))
    (lambda (self n)
      (cond ((= n 0) 0)
            ((= n 1) 1)
            (else (+ (self self (- n 1))
                     (self self (- n 2))))))))
 10)

(define (f x)
  ((lambda (even? odd?) (even? even? odd? x))
   (lambda (ev? od? n)
     (if (= n 0) true (od? ev? od? (- n 1))))
   (lambda (ev? od? n)
     (if (= n 0) false (ev? ev? od? (- n 1))))))
(f 10)





