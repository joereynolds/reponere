#lang racket

(require rackunit)
(require "../src/xtools.rkt")

(check-equal? (get-xdotool-path) "xdotool")
(check-equal? (build-xdotool-command "something") "xdotool type something")
(check-equal?
  (filter-bad-entries '("key press 45" "key release 3"))
  '("key release 3"))
