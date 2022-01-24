#lang sicp
; 完全就是一维表格的代码,假如有多个 key-1, key-2, key-3, 就将其
; 变成列表 (list key-1 key-2 key-3) 作为 key。这种方式虽然有点取巧,但简单通用,也完全符合题目要求。
(define (lookup key table)
  (let ((record (assoc key (cdr table))))
    (if record
        (cdr record)
        false)))
(define (assoc key records)
  (cond ((null? records) false)
        ((equal? key (caar records)) (car records))
        (else (assoc key (cdr records)))))
(define (insert! key value table)
  (let ((record (assoc key (cdr table))))
    (if record
        (set-cdr! record value)
        (set-cdr! table
                  (cons (cons key value)
                        (cdr table)))))
  'ok)
(define (make-table)
  (list '*table*))
(define A (make-table))
(insert! (list 'math '+) 43 A)
(insert! (list 'math '-) 45 A)
(insert! (list 'math '*) 42 A)
(insert! (list 'letter 'a) 97 A)
(insert! (list 'letter 'b) 98 A)
(lookup 'math A)
(lookup (list 'math '+) A)