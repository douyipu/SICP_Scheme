#lang sicp 

(#%require "queryeval.scm")

(initialize-data-base 
  '(
    (son Adam Cain) ; 表示 Adam 的儿子是 Cain
    (son Cain Enoch)
    (son Enoch Irad)
    (son Irad Mehujael)
    (son Mehujael Methushael)
    (son Methushael Lamech)
    (wife Lamech Ada)
    (son Ada Jabal)
    (son Ada Jubal)

    (rule (grandson ?g ?s)
          (and (son ?g ?f)
               (son ?f ?s)))

    (rule (son ?man ?son)
          (and (wife ?man ?woman)
               (son ?woman ?son)))
    ))

(easy-qeval '(grandson Cain ?x))

(easy-qeval '(son Lamech ?x))

(easy-qeval '(grandson Methushael ?x))
