#lang typed/racket/no-check

(require "./log.rkt")
(require "xtools.rkt")

(provide trigger-snippet)

#| (get-clean-log-contents "clean.log") |#
; TODO
;  - figure out how to expand ~
;  - Remove hardcoded directory
(: get-snippets (-> (Listof String)))
(define (get-snippets)
  (map path->string (directory-list "/home/joe/programs/reponere/snippets/")))

; TODO
;   - Put up a PR adding string-contains? to vim-racket

;The holy land
(: trigger-snippet (-> Any))
(define (trigger-snippet)
  (map (lambda (snippet)
         (when (string-contains? (get-clean-log-contents "clean.log")
                                 (string-append snippet "<tab>"))
           (trigger-snippet-for-word snippet)))
         (get-snippets)))

(define (trigger-snippet-for-word word)
   (process (build-xdotool-command
              (file->string
                (string-append "/home/joe/programs/reponere/snippets/" word)))))

#| (trigger-snippet) |#
(trigger-snippet-for-word "email")
(sleep 2)
(trigger-snippet-for-word "hb")
(sleep 2)
; TODO
;  - Breaks on these characters `;| (because shell duh)
;  - Spaces aren't honoured on any snippets'
(trigger-snippet-for-word "validation")
