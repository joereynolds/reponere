#lang typed/racket

(: get-snippets (-> (Listof String)))
(define (get-snippets)
  (map path->string (directory-list "/home/joe/programs/reponere/snippets/")))
