#lang sicp

(#%require "mceval.scm")

;a)
;转换后代码为
;(lambda <vars>
;  (let ((u '*unassigned*)
;        (v '*unassigned*))
;    (set! u <e1>)
;    (set! v <e2>)
;    <e3>))
;见 练习 4.6, let 语法只是 lambda 的派生表达式。每个 let 语句会对应一个 lambda。
;而执行 lambda 会产生多一个环境框架。因此变换后的代码,会比之前多一个框架。
;
;b)
;见上图,变换后的代码,执行 <e3>,查找 vars 的值时。
;在最内层框架找不到 vars, 就会自动查找更外层的环境框架。
;这时就会找到了。并且 vars 值跟变换前的代码,执行时保持一致。
;因而变换后的代码,就算多了一个框架,也不会影响程序的执行。