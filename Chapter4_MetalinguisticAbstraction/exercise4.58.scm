#lang sicp

; wrong
(rule (big-shot ?person)
      (and (job ?person (?division1 . ?type1))
           (supervisor ?person ?su)
           (job ?su (?division2 . ?type2))
           (not (same (?division1 ?division2)))))
; correct
(rule (big-shot ?person ?division)
      (and (job ?person (?division . ?type1))
           (or (not (supervisor ?person ?boss))
               (and (supervisor ?person ?boss)
                    (not (job ?boss (?division . ?type2)))))))