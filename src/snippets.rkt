#lang typed/racket/no-check

(require "log.rkt")
(require "xtools.rkt")

(provide trigger-snippet get-snippet-contents)

(: get-snippets (-> (Listof String)))
(define (get-snippets snippet-directory)
  (map path->string (directory-list snippet-directory)))

(: trigger-snippet (-> Any))
(define (trigger-snippet snippet-directory clean-log-path)
  (for/list ([snippet (in-list (get-snippets snippet-directory))]
             #:when (and (file-exists? clean-log-path)
                         (log-contains-snippet? clean-log-path snippet)))
    (process "echo '' > raw-log.log")
    (delete-file clean-log-path)
    (trigger-snippet-for-word snippet-directory snippet)))

(define (log-contains-snippet? log-path snippet)
  (string-contains? (file->string log-path)
                    (string-append snippet "<l-ctrl><space>")))

(define (get-snippet-contents snippet-directory word)
  (file->string (string-append snippet-directory word)))

(define (trigger-snippet-for-word snippet-directory word)
  (let* ([deletion-command (string-append* (make-list (string-length word) "BackSpace"))]
         [command (string-append deletion-command word)])
  (process (build-xdotool-command
             (string-append deletion-command (get-snippet-contents snippet-directory word))))))
