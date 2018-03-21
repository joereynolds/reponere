#lang typed/racket/no-check

(provide get-xdotool-path build-xdotool-command start-xinput kill-xinput)

(: start-xinput (-> String Any))
(define (start-xinput log-path)
  (let ([command (string-append "xinput test 10 >> " log-path)])
    (process command)))

(: get-xdotool-path (-> String))
(define (get-xdotool-path)
  (path->string (find-executable-path "xdotool")))

(: build-xdotool-command (-> String String))
(define (build-xdotool-command word)
  (string-append
    ; TODO escape word so characters don't break. This
    ; will probably mean reworking this solution.
    (get-xdotool-path) " type " word))

(define (kill-xinput)
  (process "killall xinput"))
