#lang racket

;并不用添加额外的保护。
;这里的代码只是读取 balance, 并不会设置 blance,对其它进程没有副作用。
;就算 A 进程被打断,中途插入读取 balance 的过程,A 进程也没有任何影响。
;而 balance 只被读取一次,操作不可再分,因而自身并不用受任何保护。
;读取 balance 的操作自身不可再分。并且就算打断其它进程,其它进程也不会受影响。
;因而这里的读取操作并不用添加额外的保护。