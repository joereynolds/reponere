#lang typed/racket/no-check

(require "./log.rkt")
(require "xtools.rkt")

(provide trigger-snippet trigger-snippet-for-word)

(: get-snippets (-> (Listof String)))
(define (get-snippets snippet-directory)
  (map path->string (directory-list snippet-directory)))

;The holy land
(: trigger-snippet (-> Any))
(define (trigger-snippet snippet-directory)
  (map (lambda (snippet)
         (when (string-contains? (get-clean-log-contents "clean.log")
                                 (string-append snippet "<tab>"))
           (trigger-snippet-for-word snippet)))
         (get-snippets snippet-directory)))

(define (trigger-snippet-for-word snippet-directory word)
   (process (build-xdotool-command
              (file->string
                (string-append snippet-directory word)))))
