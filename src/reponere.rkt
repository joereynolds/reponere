#lang racket

(require "xtools.rkt")
(require "log.rkt")
(require "snippets.rkt")

(define log-path "lll")
(define snippet-directory "/home/joe/programs/reponere/snippets/")

(define (cleanup)
  (custodian-shutdown-all (make-custodian))) ; Remove log files here too

; TODO check for an already running instance of xinput here before starting xinput
(start-xinput log-path)

(write-converted-log
  "clean.log"
  (convert-xinput-log (file->lines log-path)))

(trigger-snippet snippet-directory)
(trigger-snippet-for-word snippet-directory "email")
(sleep 2)
(trigger-snippet-for-word snippet-directory "hb")
(sleep 2)
; TODO
;  - Breaks on these characters `;| (because shell duh)
;  - Spaces aren't honoured on any snippets'
(trigger-snippet-for-word snippet-directory "validation")

(cleanup)
