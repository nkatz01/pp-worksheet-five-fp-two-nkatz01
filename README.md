# Worksheet on Functional Programming

## The second worksheet on Racket- Higher-Order Functions

1. Students often confuse `map` and `apply`. Explain the difference between them, using the following code snippet as an
example:  
    ```scheme
    (map list ’(1 2 3))
    (apply list ’(1 2 3))
    ```
    If you have forgotten what the list function does, try it out in the interactive `REPL`.
2. For each expression below, write its value, or the (approximate) error raised when Racket attempts to evaluate it.
    ```scheme
    (filter even? ’(1 2 3 4 5))
  
    (map even? ’(1 2 3 4 5))
  
    (apply and ’(#t #f #t #f #t))
    ```
3. Students often get confused when passing in a function as an argument to another function, especially if they haven’t seen this before. 
  Here is an example of one common mistake students make:
    ```scheme
    (filter (odd?) ’(1 2 3 4 5))
    ```
    Explain what error Racket would raise, and why this happens (obviously before trying this on a computer!).
4. Functions returning functions.  
    We have seen that treating functions as values leads to the natural idea of functions taking other functions as arguments, 
  which enables another level of generalization:
    ```scheme
    > (count-pred even? '(1 2 3 4 5))
    2
    > (count-pred odd? '(1 2 3 4 5))
    3
    ```
    Now suppose we wanted to count the number of even numbers in several different lists, and so defined the following function:
    ```scheme
    (define (count-evens lst)
        (count-pred even? lst))
    ```
    Of course we might also want to define a `count-odds` or `count-strings` or even `count-greater-than-5s`
    Even though `count-pred` has allowed us to abstract away the `(if ... (+ 1 ...) ...)` part, 
    it hasn't abstracted the process of function creation itself.

    In other languages, we might be forced to give up here; but because Racket functions are just values, 
    there is nothing stopping us from *returning a function*.
    1. Define a function `make-counter`, which takes as input a *predicate*, and returns a function that takes a list and returns 
    the number of elements in the list satisfying that predicate.
    2. Show how to use `make-counter` to define `num-evens` in a concise manner.
    3. Show how to use `make-counter` to count the number of elements "greater than 5" in a list, without defining any intermediate names.
    4. (Harder) In the same vein, write a function that takes a list of predicates, and returns a function that takes a list 
    and returns the number of elements in the list satisfying all of the predicates.

        Hint: You can actually define such a function using `make-counter`, if you're smart about which predicate to pass in.
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
