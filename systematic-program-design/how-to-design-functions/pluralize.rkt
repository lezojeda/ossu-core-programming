;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname pluralize) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; String -> String
;; pluralizes the given word appending an s to the end
;(define (pluralize word) "")

(check-expect (pluralize "apple") "apples")
(check-expect (pluralize "car") "cars")

(define (pluralize word)
  (string-append word "s"))