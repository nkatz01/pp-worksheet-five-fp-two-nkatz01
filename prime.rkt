;5.1)
#lang plai

#|
(factor? m n)
  m, n: positive natural numbers
  Returns #t if and only if m is a factor of n.
|#
(define (factor? m n)  
                       (cond
                         ((and (= m 0) (= n 0)) 0)
                         ((= m 0) #f)
                         ( #t (=(remainder n m)0))))

; Tests
  (test (factor? 2 6) #t)
  (test (factor? 1 6) #t)
  (test (factor? 6 2) #f)
  (test (factor? 3 10) #f)

#|
  n: positive natural number
  Returns a list of all factors of n, in increasing order.
|#

 (define (factors n)   (filter (lambda(x)  (factor? x n )) (range (+ n 1)))  )
  
; Tests
  (test (factors 5) '(1 5))
  (test (factors 12) '(1 2 3 4 6 12))
  (test (factors 1) '(1))

#|
(prime? n)
  n: positive natural number
  Returns #t if and only if n is prime.
|#


(define (prime? n)
  (if  (and (= (length (factors n))2) (= (car (factors n)) 1) (= (car (cdr (factors n))) n)) #t  #f))


; Tests
   (test (prime? 2) #t)
    (test (prime? 10) #f)
#|
(primes-up-to n)
  n: positive natural number
  Returns a list of all prime numbers up to and including n.
|#

(define (primes-up-to n) (filter prime?(range (+ n 1))))

; Tests
  (test (primes-up-to 20) '(2 3 5 7 11 13 17 19))


#| BONUS!
The above implementation we've guided you through is quite inefficient:
at every number, you calculate *all* of its factors.
Improve your algorithm for primes-up-to. :) 
|#
;COMMENT: not full solution as fastprime? doesn't stop as soon as it founds the first factor of n.

(define (fastprime? n)
  (if(or (= n 0) (= n 1)) #f
(if (= (foldr (lambda (y n) (if (and (factor? y n) (not (= y n))) y n)) n     (foldl cons null   (cddr(range (sqrt ( + 1 n)) ) ))) n) #t #f)))


   (test (fastprime? 2) #t)
    (test (fastprime? 10) #f)

(define (fast-primes-up-to n) (filter fastprime? (range (+ n 1))))

; Tests
    (test (fast-primes-up-to 20) '(2 3 5 7 11 13 17 19))
