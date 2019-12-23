# Worksheet on Functional Programming

## The second worksheet on Racket- Higher-Order Functions

;; worksheet two

;;1)

;(map list ’(1 2 3))
#|Answer: returns 3 lists, containing 1,2,3 respectively.
In genral, map applies the first argument, a procedure, sepratly to each member of the proceeding arguments |#

; (apply list ’(1 2 3))
#|Answer: creates one list, containing all 3 integers. In general, apply callse its first argumnet, a procedure, once, feeding to it as arguments,
all the subsequent arguments it received, following the procedure-argument, sliced in. |#

;;2)
;(filter even? ’(1 2 3 4 5))
;Answer: (2 4)
  
;(map even? ’(1 2 3 4 5))
;Answer: 5 lists (#f) (#t) (#f) (#t) (#f)
  
;(apply and ’(#t #f #t #f #t))
;Answer: #f, becasue AND requires all arguments to be #t.

;;3)

#|Answer: open and closed brackets indicate that you're asking racket to evaluate a procedure followed by at least one function, (odd?) contains no arguments!|#

;;4.1 & 4.2)

#|Define a function `make-counter`, which takes as input a *predicate*, and returns a function that takes a list and returns
the number of elements in the list satisfying that predicate.|#

(define (make-counter1 pred  ) (lambda (lst)
                                (letrec ([f (lambda (ls)
                                              (cond
                                                ((null? ls) 0)
                                                ((pred (car ls)) (+ 1 (f(cdr ls))))  
                                                ((not (pred (car ls))) (+ 0 (f(cdr ls))))
                                                ))
                                            ])
                                                  
                          (f lst) )
                                                 )
  )

 ;Show how to use `make-counter` to define `num-evens` in a concise manner.

(define (num-evens lst) ((make-counter1 even?)  lst))
(num-evens '(1 2 3))

;-----Or (using count)

 (define (make-counter2 pred  ) ( lambda (lst)
                                (if (null? lst) 0 (count pred lst))))

;----------works but not the solution
                                 (define (make-counter3 pred lst ) (define (f lst)
                                (cond [(null? lst) 0]
                               [ (pred (car lst)) (+ 1 (f (cdr lst)))]
                              [#t (+ 0 (f (cdr lst)))] ) ) (f lst) )

;;4.3) Show how to use `make-counter` to count the number of elements "greater than 5" in a list, without defining any intermediate names.

(define (>-5 lst)   ((make-counter1 (lambda (x) (< 5 x)))  lst))
(>-5 '(1 2 3 7))

;4.4)
#|In the same vein, write a function that takes a list of predicates, and returns a function that takes a list
and returns the number of elements in the list satisfying all of the predicates.|#

(define (satisfy-preds1 lst)   ((make-counter1 (lambda (x)  (andmap (lambda (p) (p x)) (list  odd? positive?) )  ) )  lst))
 (satisfy-preds1 '(1 2 3 4 5 0 -1))
;--------------Or
(define (satisfy-preds2 y lst)   ((make-counter1 (lambda (x)  (andmap (lambda (p) (p y x) ) (list  <) )  ) )  lst))
 (satisfy-preds2 5 '(1 2 3 4 5 0 -1 1 6 7))
;------------------Or
(define (satisfy-preds3 y lst)   ((make-counter1 (lambda (x)  (andmap (lambda (p)  (if (null? y) (p x) (p y x)))  (list  < <=) )  ) )  lst))
 (satisfy-preds3 null '(1 2 3 4 5 0 -1 1 6 7))
(satisfy-preds3 5 '(1 2 3 4 5 0 -1 1 6 7))
;-------------------Best
 (define (make-counter4 pred  ) (lambda (y lst)
           (letrec ([f (lambda (ls)
                         (cond
                           ((null? ls) 0)
                           ((andmap (lambda (p) (if (null? y) (p (car ls)) (p y (car ls)))) pred) (+ 1 (f(cdr ls))))  
                           ((not(andmap (lambda (p) (if (null? y) (p (car ls)) (p y (car ls))))pred)) (+ 0 (f(cdr ls))))
                           ))
                       ])  (f lst) ) ) )

            

(define (satisfy-pred-4-1 comparable args) ((make-counter4 (list = <=))comparable args ) )
(satisfy-pred-4-1  5 '(-1 0 1 2 3 4 5 6 7))
(define (satisfy-pred-4-2 comparable args) ((make-counter4 (list odd? positive?))comparable args ) )
(satisfy-pred-4-2  null '(-1 0 1 2 3 4 5 6 7))

5. Prime numbers.  
    In this task, you will generate a list of prime numbers: the numbers greater than 1 that are only divisible by 1 and themselves.  
    Follow the instructions in the starter code, and remember: no recursion allowed! Use the higher-order functions 
    `map`, `filter`, and `foldl` (*fold left*) to do this.
6. A better `prime?` function.  
    The major inefficiency with the `prime?` implementation we led you through above is that it computes all of the factors of its 
    argument, which is often not necessary. If a number `n` has just one factor other than 1 and itself, it is not prime!

    Implement a function `(fastprime? n)` which makes use of this fact, making it a little more efficient for composite numbers 
    by reducing the number of calls to `factor?`.

    You should use a `foldl` over the list `(range n)` (or up to `(sqrt n)` if you prefer) in your solution. 
    You'll also need to be careful with the boolean logic and short-circuiting.

    Interesting to think about: can you use short-circuiting in `foldl` to stop the recursion itself early?
