#lang typed/racket/no-check

(require "log.rkt")
(require "xtools.rkt")

(provide trigger-snippet trigger-snippet-for-word)

(: get-snippets (-> (Listof String)))
(define (get-snippets snippet-directory)
  (map path->string (directory-list snippet-directory)))

(: trigger-snippet (-> Any))
(define (trigger-snippet snippet-directory clean-log-path)
  (map (lambda (snippet)
         (when (file-exists? clean-log-path)
           (when (log-contains-snippet? clean-log-path snippet)
             (trigger-snippet-for-word snippet-directory snippet)
             (delete-file clean-log-path)
             (process "echo '' > raw-log.log"))))
         (get-snippets snippet-directory)))

(define (log-contains-snippet? log-path snippet)
  (string-contains? (file->string log-path)
                    (string-append snippet "<l-ctrl><space>")))

(define (trigger-snippet-for-word snippet-directory word)
  (process (build-xdotool-command
             (file->string
               (string-append snippet-directory word)))))
