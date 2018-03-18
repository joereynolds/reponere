#lang typed/racket/no-check

(provide get-xdotool-path build-xdotool-command start-xinput)

; TODO close the open file
(: start-xinput (-> String Any))
(define (start-xinput log-path)
  (let ([command (string-append "xinput test 10 >> " log-path)])
  (if (not (file-exists? log-path))
      (begin
        (open-output-file log-path)
        (process command))
      (process command))))

(: get-xdotool-path (-> String))
(define (get-xdotool-path)
  "xdotool")

(: build-xdotool-command (-> String String))
(define (build-xdotool-command word)
  (string-append
    (get-xdotool-path) " type " word))
