#lang racket

(require "xtools.rkt")
(require "log.rkt")

(define log-path "lll")

; TODO check for an already running instance of xinput here before starting xinput
; (start-xinput log-path)
(write-converted-log
  "clean.log"
  (convert-xinput-log (file->lines log-path)))
