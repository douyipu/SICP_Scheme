#lang sicp
(define (logical-or a1 a2)
  (cond ((and (= a1 0) (= a2 0)) 0)
        ((and (or (= a1 1) (= a1 0))
              (or (= a2 1) (= a2 0))))
        (else (error "Invalid signal--LOGICAL-OR" a1 a2))))
(define (or-gate a1 a2 output)
  (define (or-action-procedure)
    (let ((new-value
           (logical-or (get-signal a1) (get-signal a2))))
      (after-delay
       or-gate-delay
       (lambda () (set-signal! output new-value)))))
  (add-action! a1 or-action-procedure)
  (add-action! a2 or-action-procedure)
  'ok)

(define input1-or (make-wire))
(define input2-or (make-wire))
(define output-or (make-wire))
(or-gate input1-or input2-or output-or)
(set-signal! input1-or 1)
(get-signal output-or)
(propagate)
(get-signal output-or)
