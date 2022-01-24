#lang sicp

a)
(meeting ?x (Friday ?time))

b)
(rule (meeting-time ?person ?day-and-time)
      (and (meeting ?division ?day-and-time)
           (or (job ?person (?division . ?type))
               (same whole-company ?division))))

c)
(meeting-time (Hacker Alyssa P) (Wednesday ?time))