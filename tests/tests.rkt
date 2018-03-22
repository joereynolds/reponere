#lang racket

(require rackunit)
(require rackunit/text-ui)
(require "../src/xtools.rkt")
(require "../src/log.rkt")
(require "../src/snippets.rkt")

(define-test-suite snippet-suite
  "Snippet test suite"
  (test-case
    "Test we get the contents of a snippet"
    (check-equal? (get-snippet-contents "../snippets/" "email")
    "this is a replacement\n")))

(define-test-suite xtools-suite
  "Xtools test suite"
  (test-case
    "Test we get the correct path for xdotool (flaky test)"
    (check-equal? (get-xdotool-path) "/usr/bin/xdotool"))

  (test-case
    "Test we construct out xdotool command correctly"
    (check-equal?
      (build-xdotool-command "something")
      "/usr/bin/xdotool type something")))

(define-test-suite logging-suite
  "Logging test suite"
  (test-case
    "Test we correctly convert xinput log files to a human readable format"
    (check equal? (convert-xinput-log
                  '("key release 28"
                    "key release 26"
                    "key release 39"
                    "key release 28"))
                '("t" "e" "s" "t")))

  (test-case
    "Test we ignore bad input in the log"
    (check equal? (convert-xinput-log
                    '(
                      "bad data :O"
                      "key release 28"
                      "key release 26"
                      "key press 45646"
                      "key release 39"
                      "key release 28"))
                  '("t" "e" "s" "t"))))

(run-tests logging-suite)
(run-tests xtools-suite)
(run-tests snippet-suite)
