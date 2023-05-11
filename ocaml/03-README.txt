Micro Assignment #3. Mapping & Higher-Order Utility Functions 
        & Hash Tables

(1) List.map applies the same function to every element in a list and
    gives you a new list with the element-wise result.

    List.map (fun elt -> elt * 2) [ 1;2;3 ]  === [ 2;4;6 ] 

    Read in the list of names in the file 'names' as a list of strings. 
    Convert it, using List.map, to a list of integers, where each integer
    is equal to the length of the string. Use String.length . 

    Print out the list of integers. [ Yes, you could have just gone over the
    list of strings and printed the length of each element, but we want to get
    used to Map. ] 

(2) As above, but instead of mapping "ray" to 3, map "ray" to the pair
    ("ray",3). Print out each element in the pair list: "%20d %10d". 

(3) As (2), but sort the pair-list alphabetically (on names) and print it out.
    Then sort it numerically (on the length part of the pair) and print it
    out. 

(4) The function (Random.int x) returns a random number between 0 and x. 
    The function (Randon.bits ()) returns any random non-negative integer. 
    I want you to print out the names in the file 'names' in a random order. 

    Do this by: mapping each name to a (name,random-value) pair, sorting
    on the second element, mapping the list of pairs back to a list of 
    just names, and the printing out the list of names. 

    Presto, you can now randomize the order of any list. 

(5) We're now going to make a utility function that randomizes the order
    of any given list. It could be a list of strings, a list of integers: you
    don't care. 

    randomize [1;2;3]           == [3;1;2] (for example)
    randomize ["a"; "b"; "c"]   == ["a";"c";"b"] (for example) 

    Your new program will look like this:

      let randomize lst = begin 
        let result = lst in
        (* currently this is just the identity function *) 
        (* put real code here XXX *) 
        result 
      end in

      let main () = begin
        (* unit tests for randomize *) 
        let list1 = [1;2;3;4;5;6] in
        let list2 = randomize list1 in 
        List.iter (fun x -> Printf.printf "%d\n" x) list2 ;
        let list3 = ["a";"b";"c";"d";"e";"f"] in 
        let list4 = randomize list3 in 
        List.iter (fun x -> Printf.printf "%s\n" x) list4 ;
      end ;;
      main () ;;

    Your mission is to put real code near the XXX until this program 
    behaves as desired. 

    We used a function just like this in our PLDI'08 submission: to enumerate
    strings from a grammar in a random order, we randomly ordered elements
    before adding them to our worklist. We'll do worklist algorithms later. 

(6) Read the documentation on Hashtbl, ocaml's standard hashtable type. 
    Notably, look at:
      Hashtbl.create
      Hashtbl.add
      Hashtbl.replace
      Hashtbl.remove
      Hashtbl.mem
      Hashtbl.find
      Hashtbl.iter
      Hashtbl.find_all
    Those should be all you ever need from hash tables. 

(7) Read in 'votes' as before, but instead of making a list of pairs, make a
    hashtable that maps state names to votes. Example:

    let myht = Hashtbl.create 255 in (* number doesn't matter *) 
    ...
      Hashtbl.add myht state_name number_of_votes
    ...

    Iterate through the Hashtbl and print out each state-vote mapping:

    Hashtbl.iter (fun state vote -> ...) myht ;

    You'll get them in a some arbitrary order. 

(8) Done!
