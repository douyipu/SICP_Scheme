#lang sicp

(#%require "stream.scm")

;我们最初没有头绪,想到先打印 (pairs integers integers) 的项,来找找规律。加上序号,打印 30 项。
;
;1: (1 1)
;2: (1 2)
;3: (2 2)
;4: (1 3)
;5: (2 3)
;6: (1 4)
;7: (3 3)
;8: (1 5)
;9: (2 4)
;10: (1 6)
;11: (3 4)
;12: (1 7)
;13: (2 5)
;14: (1 8)
;15: (4 4)
;16: (1 9)
;17: (2 6)
;18: (1 10)
;19: (3 5)
;20: (1 11)
;21: (2 7)
;22: (1 12)
;23: (4 5)
;24: (1 13)
;25: (2 8)
;26: (1 14)
;27: (3 6)
;28: (1 15)
;29: (2 9)
;30: (1 16)
;
;为方便描述,我们用 num 记号来表示序对的序号。比如
;
;num(1 1) = 1
;num(1 2) = 2
;num(2 2) = 3
;
;a)
;
;注意到 (1 n) 这些项有个规律,其排列顺序为
;
;(1 1), (1 2), xx, (1 3), xx, (1 4), xx, (1 5), xx, (1 6)
;
;其中 xx 是未知项,分析知道 (1 1) 和 (1 2) 之间序号相差 1。之后的序号就相差 2。根据这个规律。有
;
;num(1 1) = 1                        ; n = 1
;num(1 2) = num(1 1) + 1 = 2         ; n = 2
;num(1 n) = num(1 2) + (n - 2) * 2   ; n > 2
;
;于是就知道 (1 100) 的序号为
;
;num(1 100) = 2 + 98 * 2 = 198
;
;b)
;
;除了 (1 n) 这些项,我们再来分析一些 (n n) 这些项,这些项位于对角线上,也比较特殊。在还没有头绪的时候,可以先特殊,再到一般。
;
;1: (1 1)
;3: (2 2)
;7: (3 3)
;15: (4 4)
;
;注意到,这些项也很有规律,其序号为。
;
;num(n n) = 2^n - 1
;
;为了验证这个规律,我们打印更多的项,有:
;
;1: (1 1)
;3: (2 2)
;7: (3 3)
;15: (4 4)
;31: (5 5)
;63: (6 6)
;127: (7 7)
;
;规律的确存在。于是,就知道 (100 100) 的序号为
;
;num(100 100) = 2 ^ 100 - 1
;
;c)
;
;为了知道更一般序对的序号,我们先观察 (2 n) 的序号。
;
;3: (2 2)
;5: (2 3)
;9: (2 4)
;13: (2 5)
;17: (2 6)
;21: (2 7)
;25: (2 8)
;29: (2 9)
;33: (2 10)
;
;注意到 (2 2) 和 (2 3) 的序号相差 2,之后的序号就相差 4。于是就有
;
;num(2 2) = 2 ^ 2 - 1 = 3            ; n = 2
;num(2 3) = num(2 2) + 2 = 5         ; n = 3
;num(2 n) = num(2 3) + (n - 3) * 4   ; n > 3
;
;再观察 (3 n) 的序号
;
;7: (3 3)
;11: (3 4)
;19: (3 5)
;27: (3 6)
;35: (3 7)
;43: (3 8)
;51: (3 9)
;
;注意到 (3 3) 和 (3 4) 的序号相差 4,之后的序号就相差 8。于是有
;
;num(3 3) = 2 ^ 3 - 1                ; n = 3
;num(3 4) = num(3 3) + 4             ; n = 4
;num(3 n) = num(3 4) + (n - 4) * 8   ; n > 4
;
;再观察 (4 n) 的序号,有
;
;15: (4 4)
;23: (4 5)
;39: (4 6)
;55: (4 7)
;71: (4 8)
;
;于是
;
;num(4 4) = 2 ^ 4 - 1                 ; n = 4
;num(4 5) = num(4 4) + 8              ; n = 5
;num(4 n) = num(4 5) + (n - 5) * 16   ; n > 5
;
;将前面观察到的规律,全部放在一起。有
;
;num(1 1) = 1                        ; n = 1
;num(1 2) = num(1 1) + 1 = 2         ; n = 2
;num(1 n) = num(1 2) + (n - 2) * 2   ; n > 2
;
;num(2 2) = 2 ^ 2 - 1 = 3            ; n = 2
;num(2 3) = num(2 2) + 2 = 5         ; n = 3
;num(2 n) = num(2 3) + (n - 3) * 4   ; n > 3
;
;num(3 3) = 2 ^ 3 - 1                ; n = 3
;num(3 4) = num(3 3) + 4             ; n = 4
;num(3 n) = num(3 4) + (n - 4) * 8   ; n > 4
;
;num(4 4) = 2 ^ 4 - 1                 ; n = 4
;num(4 5) = num(4 4) + 8              ; n = 5
;num(4 n) = num(4 5) + (n - 5) * 16   ; n > 5
;
;我们可以猜测 num(m n),其中 n >= m 的公式为
;
;num(m, m) = 2 ^ m - 1                               ; n = m
;num(m, m + 1) = num(m, m) + 2 ^ (m - 1)             ; n = m + 1
;num(m, n) = num(m, m + 1) + [n - (m + 1)] * 2 ^ m   ; n > m + 1
;
;验证
;
;我们来验证
;
;175: (5 10)
;
;这项
;
;num(5 5) = 2 ^ 5 - 1 = 31
;num(5 6) = 31 + 2^(5-1) = 47
;num(5 10) = 47 + (10 - 6) * (2^5) = 175
;
;公式得到验证。
;
;再来验证这项
;
;639: (8 10)
;
;num(8 8) = 2^8 - 1 = 255
;num(8 9) = 255 + 2^(8-1) = 383
;num(8 10) = 383 + (10 - 9) * (2^8) = 639

