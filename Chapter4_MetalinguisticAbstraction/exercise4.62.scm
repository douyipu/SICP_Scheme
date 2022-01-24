#lang sicp

(#%require "queryeval.scm")

(initialize-data-base 
  '(
    (rule (last-pair (?x) (?x)))

    (rule (last-pair (?x . ?y) ?z)
          (last-pair ?y ?z))
    ))

(easy-qeval '(last-pair (3) ?x))
(easy-qeval '(last-pair (1 2 3) ?x))
(easy-qeval '(last-pair (2 ?x) (3)))
;(easy-qeval '(last-pair ?x (3)))
