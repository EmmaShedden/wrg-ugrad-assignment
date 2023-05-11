Micro Assignment #1. Filtering and File I/O 

(0) If you ever spend more than 10 minutes stuck on anything here, stop.

(1) Write an ocaml program that constructs the list [1;2;3;4]
  and prints out each element on a new line. Use List.iter . 

(2) Write an ocaml program that reads in the lines from random-list as
  integers. Store them in a list. Use a ref cell for the list of integers
  you build up. Your code should look something like this:

    let sofar = ref [] in
    while ... do
      let next_line = ... in
      let next_integer = ... next_line in
      sofar := next_integer :: !sofar
    done

  Then print out everything in the list (as in (1), using List.iter) to
  stdout. Make sure your output is the same as the input. 

(3) Extend (2) by filtering out the odd numbers and only printing the even
  ones. Use List.filter . Should look something like this:

    ...
    let filtered = List.filter (fun elt -> ...) !sofar in
    ...

(4) Read in the lines from random-list as integers. Store them in a list.
  Sort the list in ascending numerical order (1-2-3) using List.sort and
  a custom (anonymous) comparison function. Print them out. 

(5) Sort them in descending numerical order. Print them out. 

(6) Sort them so that all of the odd numbers come first in ascending order,
  then all of the evens in ascending order. Print them out. 

  1 3 5 .... 2 4 6 ....

(7) Package up your programs and send them to me. 
