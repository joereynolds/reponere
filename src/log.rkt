#lang typed/racket/no-check

(require "keys.rkt")

(provide convert-xinput-log write-converted-log remove-log-files)

; Converts xinput's log file into something friendly
(: convert-xinput-log (-> (Listof String) Any))
(define (convert-xinput-log file-contents)
  (let ([log-entries (filter-bad-entries file-contents)])
    (map (lambda (line)
           (hash-ref keymap (third (string-split line))))
      log-entries)))

(: write-converted-log (-> String (Listof String) Any))
(define (write-converted-log log-path log-entries)
  (call-with-output-file log-path
    (lambda (out)
      (write (string-join log-entries "") out))
    #:exists 'truncate/replace))

(: filter-bad-entries (-> (Listof String) Any))
(define (filter-bad-entries file-contents)
  (filter (lambda (line)
   (let ([line (string-split line)])
     (member "release" line)))
    file-contents))

(define (remove-log-files clean-log-path raw-log-path)
  (delete-file clean-log-path)
  (delete-file raw-log-path))

