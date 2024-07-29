;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname making-rain-filtered) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; making-rain-filtered-starter.rkt

;; Make it rain where we want it to by clicking.

;; =================
;; Constants:

(define WIDTH  300)
(define HEIGHT 300)

(define SPEED 1)

(define DROP (ellipse 4 8 "solid" "blue"))

(define MTS (rectangle WIDTH HEIGHT "solid" "light blue"))

;; =================
;; Data definitions:

(define-struct drop (x y))
;; Drop is (make-drop Integer Integer)
;; interp. A raindrop on the screen, with x and y coordinates.

(define D1 (make-drop 10 30))
(define D2 (make-drop 3 6))
(define D3 (make-drop 27 301))

#;
(define (fn-for-drop d)
  (... (drop-x d) 
       (drop-y d)))

;; Template Rules used:
;; - compound: 2 fields


;; ListOfDrop is one of:
;;  - empty
;;  - (cons Drop ListOfDrop)
;; interp. a list of drops

(define LOD1 empty)
(define LOD2 (cons D1 (cons D2 empty)))
(define LOD3 (cons D1 (cons D2 (cons D3 empty))))

#;
(define (fn-for-lod lod)
  (cond [(empty? lod) (...)]
        [else
         (... (fn-for-drop (first lod))
              (fn-for-lod (rest lod)))]))

;; Template Rules used:
;; - one-of: 2 cases
;; - atomic distinct: empty
;; - compound: (cons Drop ListOfDrop)
;; - reference: (first lod) is Drop
;; - self reference: (rest lod) is ListOfDrop

;; =================
;; Functions:

;; ListOfDrop -> ListOfDrop
;; start rain program by evaluating (main empty)
(define (main lod)
  (big-bang lod
    (on-mouse handle-mouse)   ; ListOfDrop Integer Integer MouseEvent -> ListOfDrop
    (on-tick  next-drops)     ; ListOfDrop -> ListOfDrop
    (to-draw  render-drops))) ; ListOfDrop -> Image


;; ListOfDrop Integer Integer MouseEvent -> ListOfDrop
;; if mevt is "button-down" add a new drop at that position
(check-expect (handle-mouse empty 50 50 "button-down") (cons (make-drop 50 50) empty))
(check-expect (handle-mouse (cons D1 empty) 50 50 "button-down") (cons (make-drop 50 50) (cons D1 empty)))

;(define (handle-mouse lod x y mevt) empty) ; stub

(define (handle-mouse lod x y me)
  (cond [(mouse=? me "button-down")
         (cons (make-drop x y) lod)]
        [else lod]))


;; ListOfDrop -> ListOfDrop
;; produce filtered and ticked list of drops
(check-expect (next-drops LOD1) empty)
(check-expect (next-drops LOD2) (cons (make-drop (drop-x D1) (+ (drop-y D1) SPEED))
                                      (cons (make-drop (drop-x D2) (+ (drop-y D2) SPEED))
                                            empty)))
(check-expect (next-drops LOD3) (cons (make-drop (drop-x D1) (+ (drop-y D1) SPEED))
                                      (cons (make-drop (drop-x D2) (+ (drop-y D2) SPEED))
                                            empty)))

;(define (next-drops lod) empty) ; stub

(define (next-drops lod)
  (filter-drops (tick-drops lod)))


;; ListOfDrop -> ListOfDrop
;; increase drops y value by y moving them down the screen
(check-expect (tick-drops empty) empty)
(check-expect (tick-drops LOD2) (cons (make-drop (drop-x D1) (+ (drop-y D1) SPEED))
                                      (cons (make-drop (drop-x D2) (+ (drop-y D2) SPEED))
                                            empty)))

;(define (tick-drops lod) lod) ;stub

(define (tick-drops lod)
  (cond [(empty? lod) empty]
        [else
         (cons (move-drop (first lod))
               (tick-drops (rest lod)))]))


;; Drop -> Drop
;; increase drop y value by SPEED
(check-expect (move-drop D1) (make-drop (drop-x D1) (+ (drop-y D1) SPEED)))
(check-expect (move-drop D2) (make-drop (drop-x D2) (+ (drop-y D2) SPEED)))

;(define (move-drop d) d) ;stub

(define (move-drop d)
  (make-drop (drop-x d) 
             (+ (drop-y d) SPEED)))


;; ListOfDrop -> ListOfDrop
;; remove drops with y value larger than HEIGHT
(check-expect (filter-drops LOD1) empty)
(check-expect (filter-drops LOD2) LOD2)
(check-expect (filter-drops LOD3) (cons (make-drop (drop-x D1) (drop-y D1))
                                        (cons (make-drop (drop-x D2) (drop-y D2))
                                              empty)))
;(define (filter-drops lod) lod) ;stub

(define (filter-drops lod)
  (cond [(empty? lod) empty]
        [else
         (if (felloff? (first lod))
             (filter-drops (rest lod))
             (cons (first lod) (filter-drops (rest lod))))]))


;; Drop -> Boolean
;; determine if a drop has fell off (y value > HEIGHT)
(check-expect (felloff? D1) false)
(check-expect (felloff? D2) false)
(check-expect (felloff? (make-drop 57 301)) true)

;(define (felloff? d) false) ;stub

(define (felloff? d)
  (> (drop-y d) HEIGHT))

;; ListOfDrop -> Image
;; Render the drops onto MTS
(check-expect (render-drops LOD1) MTS)
(check-expect (render-drops LOD2) (place-image DROP
                                               (drop-x D1)
                                               (drop-y D1)
                                               (place-image DROP
                                                            (drop-x D2)
                                                            (drop-y D2)
                                                            MTS)))
(check-expect (render-drops LOD3) (place-image DROP
                                               (drop-x D1)
                                               (drop-y D1)
                                               (place-image DROP
                                                            (drop-x D2)
                                                            (drop-y D2)
                                                            (place-image DROP
                                                                         (drop-x D3)
                                                                         (drop-y D3)
                                                                         MTS))))
;(define (render-drops lod) MTS) ; stub

(define (render-drops lod)
  (cond [(empty? lod) MTS]
        [else
         (place-image DROP
                      (drop-x (first lod))
                      (drop-y (first lod))
                      (render-drops (rest lod)))]))
