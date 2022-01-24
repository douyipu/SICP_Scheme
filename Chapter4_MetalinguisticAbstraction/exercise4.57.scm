#lang sicp

a)
(rule (can-replace ?person1 ?person2)
      (and (job ?person1 ?job1)
           (job ?person2 ?job2)
           (not (same ?person1 ?person2))
           (or (same ?job1 ?job2)
               (can-do-job ?job1 ?job2))))

b)
(and (salary ?person1 ?salary1)
     (salary ?person2 ?salary2)
     (can-replace ?person1 ?person2)
     (lisp-value < ?salary1 ?salary2))
