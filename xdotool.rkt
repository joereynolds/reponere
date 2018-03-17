#lang typed/racket

(provide get-xdotool-path build-xdotool-command)

(: get-xdotool-path (-> String));
(define (get-xdotool-path)
  "xdotool")

(: build-xdotool-command (-> String String))
(define (build-xdotool-command word)
  (string-append "xdotool type " word))



