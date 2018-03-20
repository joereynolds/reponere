#lang typed/racket/no-check

(provide get-xdotool-path build-xdotool-command start-xinput xtools-running? kill-xinput)

(: start-xinput (-> String Any))
(define (start-xinput log-path)
  (let ([command (string-append "xinput test 14 >> " log-path)])
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

(define (xtools-running?)
  (let ([output (read-line (first (process "ps -aux | grep 'xinput' | wc -l")))])
    ; Not entirely sure why this is 2, thought it should've been 1? (shrug)
    (> (string->number output) 2)))

(define (kill-xinput)
  (process "killall xinput"))
