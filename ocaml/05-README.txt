Micro Assignment #5. Counting and Regular Expressions.

(18) We often want to find the most common element in a collection. Write
  two polymorphic (generic) procedures, "count" and "greatest". count
  takes a hashtable and an element as an argument, greatest takes
  the hashtable and returns the element that has been passed to count the most
  often. 

  let count ht elt = ...
  let greatest ht = ...

  let main () = begin
    let ht1 = Hashtbl.create 255 in 
    count ht1 1 ;
    count ht1 2 ;
    count ht1 1 ;
    count ht1 7 ;
    printf "most common is %d\n" (greatest ht) ;
    let ht2 = Hashtbl.create 255 in 
    count ht2 "wes" ; 
    count ht2 "kinga" ; 
    count ht2 "pieter" ; 
    count ht2 "kinga" ; 
    count ht2 "pieter" ; 
    count ht2 "kinga" ; 
    printf "most common is %s\n" (greatest ht2) ;
  end 

(19) Use your two procedures from above. Read in the file 'austen.list' (a
  list of words) and print out the line (string) that occurs most commonly. 

  Read in the file 'random.line' -- it's a single line of random characters. 
  Print out the *chararacter* that occurs most commonly. In Ocaml, the syntax
  to get one character out of a string variable str is str.[i], where
  i ranges from 0 to ((String.length str) - 1). A for loop is reasonable here. 

(20) The file 'austen.paragraphs' is just like austen.list, except that
  it is not one-word-per-line. We're going to count words in
  austen.paragraphs. The first step is to split a line up into words. We'll
  use ocaml's built-in regexp support for this. I know how much you love
  regular expressions. The "Str" library (see the ocaml documentation) handles
  this, but it's pretty standard. You build special "regexp" objects out of
  patterns like "[a-z]*" and then you search, replace or split based on them. 
  Use the regular expression "[ \t\r\n]+" for whitespace. 

  let whitespace = Str.regexp "[ \t\r\n]+" 

  Use the Str.split command to split up a line into a list of words. Then
  count each word. You should get the same final answer as in (19). 

  You have to specially link with the Str library to use its powers. Most
  people would build a Makefile for this; we'll get to that later. For now,
  use either:

  ocaml str.cma myfile.ml

  or

  ocamlopt str.cmxa myfile.ml ; ./a.out 

(21) Read in every line from austen.paragraphs into one big string variable. 
  You can either do this with a string reference, as in:

    let big_str = ref "" in
    ...
      big_str := big_str ^ new_str (* ^ is strcat in ocaml *) 
    ...
    let result = !big_str in 

  Or you can use the Buffer standard library functions. 

    let buf = Buffer.create 255 in
    ...
      Buffer.add_string buf new_str 
    ...
    let result = Buffer.contents buf in 

  The string concatenation approach is O(n^2), so you don't want to do it in
  practice (Java has the same issue), but it's fine for quick mockups. 

  Now use Str.search_forward to find all of the occurrences of the regular
  expression "po" (a p followed by an o) in that big string. Hint: make a
  mutable position variable that starts out at 0, and use a while loop. 
  Set the position variable to the result of search_foward if it doesn't throw
  an exception. 

  When you find an occurrence of po at position x, print out the context with
  something like: 
    Printf.printf "Found near %S\n" (String.sub big_string (x-10) 20) 

  Answer: there are 5: possession possession impossible poor upon

