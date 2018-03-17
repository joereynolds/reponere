#lang racket

(require rackunit)
(require "xdotool.rkt")

(check-equal? (get-xdotool-path) "xdotool")
(check-equal? (build-xdotool-command "something") "xdotool type something")
