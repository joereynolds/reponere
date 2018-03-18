#lang typed/racket/no-check

(provide get-xdotool-path build-xdotool-command)

(define keymap
  (hash
    "9" "<esc>"
    "105" "<r-ctrl>"
    "111" "<up>"
    "113" "<left>"
    "114" "<right>"
    "116" "<down>"
    "22" "<b-space>"
    "23" "<tab>"
    "24" "q"
    "25" "w"
    "26" "e"
    "27" "r"
    "28" "t"
    "29" "y"
    "30" "u"
    "31" "i"
    "32" "o"
    "33" "p"
    "36" "<enter>"
    "37" "<l-ctrl>"
    "38" "a"
    "39" "s"
    "40" "d"
    "41" "f"
    "42" "g"
    "43" "h"
    "45" "k"
    "46" "l"
    "47" ";"
    "52" "z"
    "53" "x"
    "54" "c"
    "55" "v"
    "56" "b"
    "57" "n"
    "58" "m"
    "62" "<r-shift>"
    "65" "<space>"
    ))

; Starts xinput to track keypresses
(: start-xinput (-> String Any))
(define (start-xinput log-path)
  (let ([command (string-append "xinput test 10 >> " log-path)])
  (if (not (file-exists? log-path))
      (begin
        (open-output-file log-path)
        (process command))
      (process command))))

; TODO - Move this out of xdotool
; Converts xinput's log file into something friendly
(: convert-log-path (-> (Listof String) Any))
(define (convert-log-path file-contents)
  (map (lambda (line)
         ; TODO, only look for "key release N" not "key press" too.
         ; Otherwise you get strange results.
         ;Format of the string is "key press 36"
         (hash-ref keymap (third (string-split line))))
       file-contents))

(: get-xdotool-path (-> String))
(define (get-xdotool-path)
  "xdotool")

(: build-xdotool-command (-> String String))
(define (build-xdotool-command word)
  (string-append
    (get-xdotool-path) " type " word))

; (start-xinput "lll")
(convert-log-path (file->lines "lll"))
