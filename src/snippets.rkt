#lang typed/racket/no-check

(require "log.rkt")
(require "xtools.rkt")

(provide trigger-snippet trigger-snippet-for-word)

(: get-snippets (-> (Listof String)))
(define (get-snippets snippet-directory)
  (map path->string (directory-list snippet-directory)))

(: trigger-snippet (-> Any))
(define (trigger-snippet snippet-directory clean-log-path)
  (for/list ([snippet (in-list (get-snippets snippet-directory))]
             #:when (file-exists? clean-log-path)
             #:when (log-contains-snippet? clean-log-path snippet))
    (process "echo '' > raw-log.log")
    (delete-file clean-log-path)
    (trigger-snippet-for-word snippet-directory snippet)))

(define (log-contains-snippet? log-path snippet)
  (string-contains? (file->string log-path)
                    (string-append snippet "<l-ctrl><space>")))

(define (trigger-snippet-for-word snippet-directory word)
  (process (build-xdotool-command
             (file->string
               (string-append snippet-directory word)))))
