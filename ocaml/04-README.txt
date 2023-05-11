Micro Assignment #4. Mapping & Higher-Order Utility Functions 
        & Hash Tables

(8) The file 'vote-query' has a list of state names in it. After building the
    hashtable as in the previous assignment, read in every line from vote
    query and look it up in the hash table. Print out "%s has %d votes\n". 

(9) As above, but use something like this to do error handling:

      begin try
        let votes = ... state in
        Printf.printf "%s has %d votes\n" state votes
      with _ -> 
        Printf.printf "%s not in hash table\n" state 
      end 

(10) As above, but use Hashtbl.mem and an if statement instead of try-with.

(11) As (8), but also make a second hash table mapping votes to states. 
     For every number 0-75, print out the states that have that many votes.
     Ocaml for loops look like this:

     for i = 0 to 75 do
        let states_with_i_votes = ... (* FIXME *) in
        if states_with_i_votes <> [] then begin
          Printf.printf "States with %d votes:" i ;
          List.iter (Printf.printf " %s") states_with_i_votes 
        end 
     done

(12) In (11), we went through all numbers 0-75. That's inefficient, since the
     valid numbers are actually sparse. Now we want to come up with a list of
     actual valid vote numbers. Once we have that list, we'll just iterate
     over elements in that and do our query. Expand this hint code:

       let unique_vote_ht = Hashtbl.create 255 in
       ...
          Hashtbl.replace unique_vote_ht vote_count true 
       ...
       let possible_vote_numbers = ref [] in
       ...  (fun vote _ -> possible_vote_numbers := 
                              vote :: !possible_vote_numbers) ...
       List.iter (fun vote ->
          (* code for 11, without the for loop *) 
       ) !possible_vote_numbers ;

     Next time we'll explore "finding unique elements" in more detail. 

(13) You've seen how to use Hashtbl.replace and iteration to get all of
     the unique elements of a list. Make a utility function, as in (5) above,
     that does this:

     let unique lst = begin
        let result = lst in 
        (* XXX FIXME *) 
        result 
     end

     let main () = begin
        (* unit tests for unique *) 
        let list1 = [1;2;3;1;2;1;7;1;2;] in
        let list2 = unique lst1 in 
        List.iter (fun x -> Printf.printf "%d\n" x) list2 ;
        let list3 = ["a";"b";"c";"a";"e";"b"] in 
        let list4 = unique list3 in 
        List.iter (fun x -> Printf.printf "%s\n" x) list4 ;
     end ;;
     main () ;;

(14) Ocaml also features a Set datatype, but you have to declare a new one
     for each element datatype.

     http://caml.inria.fr/pub/docs/manual-ocaml/libref/Set.S.html

     Here's how you make a set of integers:

        module OrderedInt = (* black magic for now *)
          struct
            type t = int
            let compare = compare
          end
        module IntSet = Set.Make(OrderedInt) (* here's our int-set type *) 
  
     Ocaml sets are *purely functional* -- no side effects. So

      let new_set = IntSet.add 55 old_set in (* does not change old_set *) 
      ...  

     Thus you often use "ref" (or Fold, which we'll get to in a bit) with
     sets. Do (12) above, but instead of using hashtables (or your unqiue
     function), we're going to use intsets. Fill in this hint code:

     let unique_votes = ref IntSet.empty in
     ...
        unique_votes := IntSet.add vote !unique_votes
     ...
     ... (* iter *) (fun vote -> 
      (* code from 11, without the for loop *)
     ) ... 

(15) The files int-list-1 and int-list-2 both contain lists of integers.
     Print me out all integers in both of them using IntSet.inter . 

(16) As (15), but don't use any IntSets. Instead, make a hashtbl of all of the
     elements in int-list-1, and print me out only those elements of
     int-list-2 that are in the Hashtbl. (Hashtbl.mem) 

(17) Done! 
