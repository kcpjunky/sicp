(define (search f neg-point pos-point)
    (let ((midpoint (average neg-point pos-point)))
        (if (close-enough? neg-point pos-point)
            midpoint
            (let ((test-value (f midpoint)))
                (cond ((positive? test-value)
                       (search f neg-point midpoint))
                      ((negative? test-value)
                       (search f midpoint pos-point))
                      (else midpoint)
                )
            )
        )
    )
)

(define (average x y)
    (/ 
        (+ x y)
        2.0
    )
)

(define (close-enough? x y)
    (< (abs (- x y)) 0.001))

(define (test-function x)
    (- 
        (* x x)
        1
    )
)

;wrapper function
;if invalid value passed, this function return error message
(define (half-interval-method f a b)
    (let ((a-value (f a))
          (b-value (f b))
        )
    (cond ((and (negative? a-value) (positive? b-value))
           (search f a b))
          ((and (negative? b-value) (positive? a-value))
           (search f b a))
          (else
            (error "Values are not of opposite sign" a b)
          ))
    )
)

(print (search test-function 0 1.5))

(print (half-interval-method sin 2.0 4.0))

(print (half-interval-method (lambda (x) (- (* x x x) (* 2 x) 3)) 1.0 2.0 ))