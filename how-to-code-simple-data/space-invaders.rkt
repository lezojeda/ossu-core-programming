;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname space-invaders) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

;; Space Invaders


;; Constants:

(define WIDTH  300)
(define HEIGHT 500)

(define INVADER-X-SPEED 1.5)  ;speeds (not velocities) in pixels per tick
(define INVADER-Y-SPEED 1.5)
(define TANK-SPEED 2)
(define MISSILE-SPEED 10)

(define HIT-RANGE 10)

(define INVADE-RATE 96)

(define BACKGROUND (empty-scene WIDTH HEIGHT "black"))

(define INVADER
  (underlay/xy (ellipse 10 15 "outline" "CornflowerBlue")       ;cockpit cover
               -5 6
               (ellipse 20 10 "solid"   "Silver")))             ;saucer

(define INVADER-WIDTH/2 (/ (image-width INVADER) 2))

(define TANK
  (overlay/xy (overlay (ellipse 28 8 "solid" "Green Yellow")    ;tread center
                       (ellipse 30 10 "solid" "Green Yellow"))  ;tread outline
              5 -14
              (above (rectangle 5 10 "solid" "Gainsboro")       ;gun
                     (rectangle 20 10 "solid" "Light Gray"))))  ;main body

(define TANK-HEIGHT/2 (/ (image-height TANK) 2))
(define TANK-WIDTH/2 (/ (image-width TANK) 2))

(define MISSILE-INITIAL-Y (- HEIGHT (+ (image-height TANK) 2)))

(define MISSILE (ellipse 5 15 "solid" "Orange Red"))



;; Data Definitions:

(define-struct game (invaders missiles tank))
;; Game is (make-game  (listof Invader) (listof Missile) Tank)
;; interp. the current state of a space invaders game
;;         with the current invaders, missiles and tank position

;; Game constants defined below Missile data definition

#;
(define (fn-for-game s)
  (... (fn-for-loinvader (game-invaders s))
       (fn-for-lom (game-missiles s))
       (fn-for-tank (game-tank s))))



(define-struct tank (x dir))
;; Tank is (make-tank Number[TANK-WIDTH, (- WIDTH TANK-WIDTH)] Integer[-1, 1])
;; interp. the tank location is x, HEIGHT - TANK-HEIGHT/2 in screen coordinates
;;         the tank moves TANK-SPEED pixels per clock tick left if dir -1, right if dir 1

(define T0 (make-tank (/ WIDTH 2) 1))             ;center going right
(define T1 (make-tank 50 1))                      ;going right
(define T2 (make-tank 50 -1))                     ;going left
(define T4 (make-tank TANK-WIDTH/2 -1))           ;left border
(define T5 (make-tank (- WIDTH TANK-WIDTH/2) 1))  ;right border

#;
(define (fn-for-tank t)
  (... (tank-x t) (tank-dir t)))



(define-struct invader (x y dx))
;; Invader is (make-invader Number Number Number)
;; interp. the invader is at (x, y) in screen coordinates
;;         the invader along x by dx pixels per clock tick

(define I1 (make-invader 150 100 INVADER-X-SPEED))        ;not landed, moving right
(define I2 (make-invader 150 HEIGHT (- INVADER-X-SPEED))) ;exactly landed, moving left
(define I3 (make-invader 150 (+ HEIGHT 10) 10))           ;> landed, moving right
(define I4 (make-invader 300 (+ HEIGHT 10) 5))            ;moving right at right edge
(define I5 (make-invader 0 (+ HEIGHT 10) -5))             ;moving left at left edge


#;
(define (fn-for-invader invader)
  (... (invader-x invader) (invader-y invader) (invader-dx invader)))


(define-struct missile (x y))
;; Missile is (make-missile Number Number)
;; interp. the missile's location is x y in screen coordinates

(define M1 (make-missile 150 300))                               ;not hit I1
(define M2 (make-missile (invader-x I1) (+ (invader-y I1) 10)))  ;exactly hit I1
(define M3 (make-missile (invader-x I1) (+ (invader-y I1)  5)))  ;> hit I1
(define M4 (make-missile 35 -1))

#;
(define (fn-for-missile m)
  (... (missile-x m) (missile-y m)))

(define LOM1 (list M4))
(define LOM2 (list M1))
(define LOM3 (list M1 M4))
(define LOM4 (list M2))


(define LOI1 (list I1))
(define LOI2 (list I1 I2))
(define LOI3 (list I4 I5))
(define LOI4 (list I4 I5 I2))


(define G0 (make-game empty empty T0))
(define G1 (make-game empty empty T1))
(define G2 (make-game LOI1 LOM2 T2))
(define G3 (make-game LOI2 LOM3 T1))
(define G4 (make-game LOI4 LOM3 T1))



;; =================
;; Functions:

;; Game -> Game
;; start the world with (main G0)
;; 
(define (main g)
  (big-bang g                          ; G
    (on-tick   tock)                   ; G -> G
    (to-draw   render)                 ; G -> Image
    (stop-when game-lost) ; G -> Boolean
    (on-key    handle-key)))           ; G KeyEvent -> G

;; Game -> Game
;; produce the next state of the game
(check-expect (tock G0) (make-game empty empty (tick-tank T0)))
(check-random (tock G1) (make-game empty empty (tick-tank T1)))
(check-expect (tock G2) (make-game (next-invaders LOI1 (game-missiles G2))
                                   (tick-lom (game-missiles G2))
                                   (tick-tank T2))) 
;(define (tock g) g) ;stub

(define (tock g)
  (make-game (next-invaders (game-invaders g) (game-missiles g))
             (next-missiles (game-missiles g) (game-invaders g))
             (tick-tank (game-tank g))))


;; =========
;; Invaders:

;; ListOfInvader ListOfMissiles -> ListOfInvader
;; produce filtered and ticked list of invaders
(check-expect (next-invaders LOI1 LOM4) empty)
(check-random (next-invaders LOI1 LOM1) (filter-invaders
                                         (tick-loinvaders
                                          (spawn-invaders (random 101)
                                                          LOI1))
                                         LOM1))
(check-random (next-invaders LOI2 LOM1) (filter-invaders
                                         (tick-loinvaders
                                          (spawn-invaders (random 101)
                                                          LOI2))
                                         LOM1))
(check-random (next-invaders LOI2 LOM3) (filter-invaders
                                         (tick-loinvaders
                                          (spawn-invaders (random 101)
                                                          LOI2))
                                         LOM3))

(define (next-invaders loinvaders lom)
  (tick-loinvaders
    (spawn-invaders (random 101)
                    (filter-invaders loinvaders lom))))


;; ListOfInvader -> ListOfInvader
;; remove invaders when they are hit
(check-expect (filter-invaders empty LOM4) empty)     ;no invaders one missile
(check-expect (filter-invaders LOI1  LOM4) empty)     ;missile hit only invader
(check-expect (filter-invaders LOI2  LOM4) (list I2)) ;missile hit one of the two invaders

;(define (filter-invaders loinvaders lom) loinvaders) ;stub

(define (filter-invaders loinvaders lom)
  (cond [(empty? loinvaders) empty]
        [else
         (if (is-hit? lom (first loinvaders))
             (filter-invaders (rest loinvaders) lom)
             (cons (first loinvaders)
                   (filter-invaders (rest loinvaders) lom)))]))


;; Invader ListOfMissile -> Boolean
;; determine if an invader has been hit by any missile
(check-expect (is-hit? (list M3) I1) true)
(check-expect (is-hit? (list M2 M1) I1) true)
(check-expect (is-hit? (list M3 M4) I2) false)
(check-expect (is-hit? (list (make-missile 152 324)
                             (make-missile 87 243))
                       (make-invader 163 335 INVADER-X-SPEED))
              false)
(check-expect (is-hit? (list (make-missile 152 324)
                             (make-missile 87 243))
                       (make-invader 152 300 INVADER-X-SPEED))
              false)
(check-expect (is-hit? (list (make-missile 152 324)
                             (make-missile 87 243))
                       (make-invader 154 334 INVADER-X-SPEED))
              true)

;(define (is-hit? lom i) false) ;stub

(define (is-hit? lom i)
  (cond [(empty? lom) false]
        [else
         (or (and
              (<= (abs (- (missile-y (first lom))
                          (invader-y i)))
                  HIT-RANGE)
              (<= (abs (- (missile-x (first lom))
                          (invader-x i)))
                  HIT-RANGE))
             (is-hit? (rest lom) i))]))


;; ListOfInvader -> ListOfInvaders
;; produce the next state of the list of invaders
(check-expect (tick-loinvaders LOI1) (list (move-invader I1)))
(check-expect (tick-loinvaders LOI2) (list (move-invader I1)
                                           (move-invader I2)))

;(define (tick-loinvaders loinvaders) loinvaders) ;stub

(define (tick-loinvaders loinvaders)
  (cond [(empty? loinvaders) empty]
        [else
         (cons (move-invader (first loinvaders))
               (tick-loinvaders (rest loinvaders)))]))


;; Invader -> Invader
;; move invader on its y axis by y INVADER-Y-SPEED units and on its x axis by x X-INVADER-SPEED units
(check-expect (move-invader I1) (make-invader (+ (invader-x I1)
                                                 (invader-dx I1))
                                              (+ (invader-y I1)
                                                 INVADER-Y-SPEED)
                                              (invader-dx I1)))
(check-expect (move-invader I2) (make-invader (+ (invader-x I2)
                                                 (invader-dx I2))
                                              (+ (invader-y I2)
                                                 INVADER-Y-SPEED)
                                              (invader-dx I2)))
(check-expect (move-invader I4) (make-invader (- WIDTH INVADER-WIDTH/2) ;bounce from right edge
                                              (+ (invader-y I4)
                                                 INVADER-Y-SPEED)
                                              (- (invader-dx I4))))
(check-expect (move-invader I5) (make-invader INVADER-WIDTH/2           ;bounce from left edge
                                              (+ (invader-y I5)
                                                 INVADER-Y-SPEED)
                                              (- (invader-dx I5))))
;(define (move-invader i) i) ;stub

(define (move-invader i)
  (cond [(> (+ (invader-x i) (invader-dx i))
            (- WIDTH INVADER-WIDTH/2))          (make-invader (- WIDTH INVADER-WIDTH/2)
                                                              (+ (invader-y i) INVADER-Y-SPEED)
                                                              (- (invader-dx i)))]
        [(< (+ (invader-x i)
               (invader-dx i)) INVADER-WIDTH/2) (make-invader INVADER-WIDTH/2
                                                              (+ (invader-y i) INVADER-Y-SPEED)
                                                              (- (invader-dx i)))]
        [else (make-invader (+ (invader-x i) (invader-dx i))
                            (+ (invader-y i) INVADER-Y-SPEED)
                            (invader-dx i))])) ;move normally


;; Number ListOfInvader -> ListOfInvader
;; spawn invaders adding one to the list when Number > INVADER-RATE
(check-expect (spawn-invaders 41 LOI1) LOI1)
(check-random (spawn-invaders 96 LOI1) (list* (make-invader (random WIDTH)
                                                            0
                                                            INVADER-X-SPEED) LOI1))
(check-random (spawn-invaders 98 empty) (list (make-invader (random WIDTH)
                                                            0
                                                            INVADER-X-SPEED)))
(check-expect (spawn-invaders 21 empty) empty)

;(define (spawn-invaders n loinvaders) loinvaders) ;stub

(define (spawn-invaders n loinvaders)
  (cond [(> n INVADE-RATE) (list* (make-invader (random WIDTH)
                                                0
                                                INVADER-X-SPEED) loinvaders)]
        [else loinvaders]))


;; =========
;; Missiles:

;; ListOfMissile ->ListOfMissile
;; produce filtered and ticked list of missiles
(check-expect (next-missiles LOM1 LOI2) empty)
(check-expect (next-missiles LOM2 LOI1) (filter-missiles (tick-lom LOM2) LOI1))
(check-expect (next-missiles LOM3 LOI1) (filter-missiles (tick-lom LOM3) LOI1))

;(define (next-missiles lom) empty) ; stub

(define (next-missiles lom loi)
   (tick-lom (filter-missiles lom loi)))


;; ListOfMissile -> ListOfMissile
;; remove missiles with y value smaller than HEIGHT
(check-expect (filter-missiles LOM1 empty) empty)     ;missile flew off
(check-expect (filter-missiles LOM2 empty) LOM2)      ;missile still in screen
(check-expect (filter-missiles LOM3 empty) (list M1)) ;one of missiles flew off
(check-expect (filter-missiles LOM2 LOI1)  LOM2)      ;missile still in screen not hitting invader
(check-expect (filter-missiles LOM4 LOI1)  empty)     ;missile hit

;(define (filter-missiles lom loi) lom) ;stub

(define (filter-missiles lom loi)
  (cond [(empty? lom) empty]
        [else
         (if (or (flewoff? (first lom))
                 (has-hit? loi (first lom)))
             (filter-missiles (rest lom) loi)
             (cons (first lom) (filter-missiles (rest lom) loi)))]))


;; Missile -> Boolean
;; determine if a missile has fell off (y value < HEIGHT)
(check-expect (flewoff? M1) false)
(check-expect (flewoff? M2) false)
(check-expect (flewoff? M4) true)

;(define (flewoff? m) false) ;stub

(define (flewoff? m)
  (< (missile-y m) 0))


;; Missile ListOfMissile -> Boolean
;; determine if a missile has hit an invader
(check-expect (has-hit? LOI1 M1) false)
(check-expect (has-hit? LOI2 M1) false)
(check-expect (has-hit? LOI1 M2) true)
(check-expect (has-hit? LOI2 M2) true)
(check-expect (has-hit? LOI1 M3) true)
(check-expect (has-hit? LOI1 M4) false)

;(define (has-hit? loi m) false) ;stub

(define (has-hit? loi m)
  (cond [(empty? loi) false]
        [else
         (or (and
              (<= (abs (- (invader-x (first loi))
                          (missile-x m)))
                  HIT-RANGE)
              (<= (abs (- (invader-y (first loi))
                          (missile-y m)))
                  HIT-RANGE))
             (has-hit? (rest loi) m))]))


;; ListOfMissile -> ListOfMissile
;; produce the next state of the list of missiles
(check-expect (tick-lom empty) empty)
(check-expect (tick-lom LOM2) (list (move-missile M1)))
(check-expect (tick-lom (list M1 M2)) (list (move-missile M1)
                                            (move-missile M2)))

;(define (tick-lom lom loi) lom) ;stub

(define (tick-lom lom)
  (cond [(empty? lom) empty]
        [else
         (cons (move-missile (first lom))
               (tick-lom (rest lom)))]))


;; Missile -> Missile
;; move missile on its y axis by y MISSILE-SPEED units
(check-expect (move-missile M1) (make-missile (missile-x M1)
                                              (- (missile-y M1) MISSILE-SPEED)))
(check-expect (move-missile M2) (make-missile (missile-x M2)
                                              (- (missile-y M2) MISSILE-SPEED)))
;(define (move-missile m) m) ;stub

(define (move-missile m)
  (make-missile (missile-x m)
                (- (missile-y m) MISSILE-SPEED)))



;; =========
;; Tank:

;; Tank -> Tank
;; produce the next state of the tank
(check-expect (tick-tank T0) (make-tank (+ (tank-x T0)
                                           TANK-SPEED)
                                        1))
(check-expect (tick-tank T2) (make-tank (- (tank-x T2)
                                           TANK-SPEED)
                                        -1))
(check-expect (tick-tank T4) (make-tank (tank-x T4) -1)) ;tank is at left border
(check-expect (tick-tank T5) (make-tank (tank-x T5) 1))  ;tank is at right border
                                        
;(define (tick-tank t) t) ;stub

(define (tick-tank t)
  (make-tank (if (should-move? t)
                 (+ (tank-x t)
                    (* (tank-dir t) TANK-SPEED))
                 (tank-x t))
             (tank-dir t)))

;; Tank -> Boolean
;; determine whether tank should move or not
;; it shouldn't move whenever it reaches any of the screen borders
(check-expect (should-move? T0) true)
(check-expect (should-move? T1) true)
(check-expect (should-move? T4) false)
(check-expect (should-move? T5) false)

;(define (should-move? t) t) ;stub

(define (should-move? t)
  (or (and (> (tank-x t) TANK-WIDTH/2)           ;tank at left border
           (= -1 (tank-dir t)))
      (and (< (tank-x t) (- WIDTH TANK-WIDTH/2)) ;tank at right border
           (= 1 (tank-dir t)))))


;; G -> Image
;; render the game's background with the tank, invaders and missiles if any
(check-expect (render G0) (place-images/align
                           (append (invader-images (game-invaders G0))
                                   (missile-images (game-missiles G0))
                                   (list TANK))
                           (append (invader-posn (game-invaders G0))
                                   (missile-posn (game-missiles G0))
                                   (list (make-posn (tank-x (game-tank G0)) HEIGHT)))
                           "center" "bottom"
                           BACKGROUND))
(check-expect (render G2) (place-images/align
                           (append (invader-images (game-invaders G2))
                                   (missile-images (game-missiles G2))
                                   (list TANK))
                           (append (invader-posn (game-invaders G2))
                                   (missile-posn (game-missiles G2))
                                   (list (make-posn (tank-x (game-tank G3)) HEIGHT)))
                           "center" "bottom"
                           BACKGROUND))
(check-expect (render G3) (place-images/align
                           (append (invader-images (game-invaders G3))
                                   (missile-images (game-missiles G3))
                                   (list TANK))
                           (append (invader-posn (game-invaders G3))
                                   (missile-posn (game-missiles G3))
                                   (list (make-posn (tank-x (game-tank G3)) HEIGHT)))
                           "center" "bottom"
                           BACKGROUND))



;; =========
;; Rendering:

;(define (render g) BACKGROUND) ;stub

(define (render g)
  (place-images/align (append (invader-images (game-invaders g))
                              (missile-images (game-missiles g))
                              (list TANK))
                      (append (invader-posn (game-invaders g))
                              (missile-posn (game-missiles g))
                              (list (make-posn (tank-x (game-tank g)) HEIGHT)))
                      "center" "bottom"
                      BACKGROUND))


;; ListOfInvader -> ListOfImage
;; consume a list of invaders and produce a list of their images
(check-expect (invader-images empty)        empty)
(check-expect (invader-images (list I1))    (cons INVADER empty))
(check-expect (invader-images (list I1 I2)) (cons INVADER (cons INVADER empty)))

;(define (invader-images loinvader) empty) ;stub

(define (invader-images loinvader)
  (cond [(empty? loinvader) empty]
        [else
         (cons INVADER
               (invader-images (rest loinvader)))]))


;; ListOfMissile -> ListOfImage
;; consume a list of missiles and produce a list of their images
(check-expect (missile-images  empty)       empty)
(check-expect (missile-images (list M1))    (cons MISSILE empty))
(check-expect (missile-images (list M1 M2)) (cons MISSILE (cons MISSILE empty)))

;(define (missile-images lom) empty) ;stub

(define (missile-images lom)
  (cond [(empty? lom) empty]
        [else
         (cons MISSILE
               (missile-images (rest lom)))]))


;; ListOfInvader -> ListOfPosn
;; consume a list of invaders and produces a list of their positions
(check-expect (invader-posn empty) empty)
(check-expect (invader-posn (list I1)) (list (make-posn (invader-x I1) (invader-y I1))))
(check-expect (invader-posn (list I1
                                  I2)) (list (make-posn (invader-x I1) (invader-y I1))
                                             (make-posn (invader-x I2) (invader-y I2))))

;(define (invader-posn loinvader) empty) ;stub

(define (invader-posn loinvader)
  (cond [(empty? loinvader) empty]
        [else
         (cons (make-posn (invader-x (first loinvader))
                          (invader-y (first loinvader)))
               (invader-posn (rest loinvader)))]))

;; ListOfMissile -> ListOfPosn
;; consume a list of missiles and produces a list of their positions
(check-expect (missile-posn empty) empty)
(check-expect (missile-posn (list M1)) (list (make-posn (missile-x M1) (missile-y M1))))
(check-expect (missile-posn (list M1
                                  M2)) (list (make-posn (missile-x M1) (missile-y M1))
                                             (make-posn (missile-x M2) (missile-y M2))))

;(define (missile-posn lom) empty) ;stub

(define (missile-posn lom)
  (cond [(empty? lom) empty]
        [else
         (cons (make-posn (missile-x (first lom))
                          (missile-y (first lom)))
               (missile-posn (rest lom)))]))



;; =========
;; Interaction:

;; Game KeyEvent -> G
;; moves the tank to the left or right when pressing left or right arrows respectively
;; fire a missile when the space bar is pressed
(check-expect (handle-key G0 "up") (make-game (game-invaders G0)
                                              (game-missiles G0)
                                              (game-tank     G0)))
(check-expect (handle-key G0 " ") (make-game (game-invaders  G0)
                                             (fire-missiles (game-missiles G0) (tank-x T0))
                                             (game-tank      G0)))
(check-expect (handle-key G1 "right") (make-game (game-invaders G1)
                                                 (game-missiles G1)
                                                 (move-tank (game-tank G1) "right")))

(define (handle-key g ke)
  (cond [(or (key=? ke "right")
             (key=? ke "left"))
         (make-game (game-invaders g)
                    (game-missiles g)
                    (move-tank (game-tank g) ke))]
        [(key=? ke " ") (make-game (game-invaders g)
                                   (fire-missiles (game-missiles g)
                                                  (tank-x (game-tank g)))
                                   (game-tank g))]
        [else 
         g]))


;; Tank KeyEvent -> Tank
;; move tank to the left or to the right
(check-expect (move-tank T0 "right") T0)                         ;press right while going right
(check-expect (move-tank T2 "right") (make-tank (tank-x T2)  1)) ;press right while going left
(check-expect (move-tank T1 "left")  (make-tank (tank-x T2) -1)) ;press left while going right
(check-expect (move-tank T2 "left")  T2)                         ;press left while going left

;(define (move-tank t ke) t) ;stub

(define (move-tank t ke)
  (if (key=? ke "right")
      (make-tank (tank-x t) 1)
      (make-tank (tank-x t) -1)))


;; ListOfMissile Number[TANK-WIDTH, (- WIDTH TANK-WIDTH)] -> ListOfMissile
;; fire missiles from the tank at position x tx adding one to the list
(check-expect (fire-missiles empty 50) (list (make-missile 50 MISSILE-INITIAL-Y)))
(check-expect (fire-missiles (list M1) 150) (list M1 (make-missile 150 MISSILE-INITIAL-Y)))

;(define (fire-missiles tx lom) lom)

(define (fire-missiles lom tx)
  (cond [(empty? lom) (cons (make-missile tx MISSILE-INITIAL-Y) empty)]
        [else
         (cons (first lom)
               (fire-missiles (rest lom) tx))]))



;; =========
;; Stop when:

;; Game -> Boolean
;; stop the game when any invader reaches the bottom of the screen
(check-expect (game-lost G0) false)
(check-expect (game-lost G1) false)
(check-expect (game-lost G2) false)
(check-expect (game-lost G4) true)

;(define (game-lost g) false) ;stub

(define (game-lost g)
  (invader-reached-bottom? (game-invaders g)))

;; Invaders -> Boolean
;; determine if any invader has reached the bottom of the screen
(check-expect (invader-reached-bottom? LOI1) false)
(check-expect (invader-reached-bottom? LOI2) true)
                                              
;(define (invader-reached-bottom? loinvaders) false) ;stub

(define (invader-reached-bottom? loinvaders)
  (cond [(empty? loinvaders) false]
        [else
         (or (<= HEIGHT (invader-y (first loinvaders)))
             (invader-reached-bottom? (rest loinvaders)))]))