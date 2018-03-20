#lang racket

(require "xtools.rkt")
(require "log.rkt")
(require "snippets.rkt")

(define clean-log-path "clean.log")
(define log-path "raw-log.log")
(define snippet-directory "/home/joe/programs/reponere/snippets/")

(define (cleanup)
  (kill-xinput)
  (remove-log-files clean-log-path log-path)
  (custodian-shutdown-all (make-custodian)))

(define (loop)

  (unless (file-exists? log-path)
    (open-output-file  log-path #:exists 'truncate))

  (write-converted-log
    clean-log-path
    (convert-xinput-log (file->lines log-path)))
  (trigger-snippet snippet-directory clean-log-path)
  (loop))

; TODO
;  - Breaks on these characters `;| (because shell duh)
;  - Spaces aren't honoured on any snippets'
#| (trigger-snippet-for-word snippet-directory "validation") |#
(cleanup)
(open-output-file log-path #:exists 'truncate)
(start-xinput log-path)
(loop)
