Micro Assignment #2. Pairs 

(1) If you ever spend more than 10 minutes stuck on anything here, stop.

(2) The ocaml notation for a pair VALUE is (a,b). 

  let my_pair = (1, "hello") in
  ...
  let a, b = my_pair in
  Printf.printf "value is %d %s\n" a b  

  The ocaml notation for a pair TYPE is (type1 * type2). So in the above
  example, my_pair has type int * string. 

  Read in pairs of lines from the file "votes" as string*int pairs. Store
  them in a single list. Hint: have two read_lines (or whatever) inside
  the body of your while loop. Each element of the list should be a
  string*int pair. The file contains a list of states and a list of
  electoral college votes. 

  Sort the list in ascending order of votes. Print out the sorted list in
  the following format:

  state_1       votes_1
  state_2       votes_2

  Example:
montana 3
alaska 3
wyoming 3

  Try it again with "%30s %10d" instead of "%s %d" in your Printf statement. 

(3) Sort the list in ascending order of votes, breaking ties in favor 
  ascending order of English text. Print out the list (note Alaska first): 

  Example:
alaska 3
montana 3
wyoming 3

  Hint:

  let result = List.sort (fun (name1,votes1) (name2,votes2) ->
    if votes1 = votes2 then
      ...
    else
      compare votes1 votes2
  ) my_list in 

(4) Filter the entire list (no sorting) so only states with >= 10 votes
    remain. Print it. 

(5) Package up your programs and send them to me. 
