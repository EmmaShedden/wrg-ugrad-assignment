Micro Assignment #8. Graphs 2! 

(28) Construct an "extract_min" function that works as follows:
  it takes an unsorted list of (int * string) pairs -- the integers represent
  weights. It sorts the list by weight (use a custom sorting comparison
  function: you've done this before) and returns two things:
    (1) the (int*string) pair with the smallest int weight
    (2) the rest of the list (i.e., without that element) in any order

  Hint: if you mistakenly write "extract_max", just flip around the order of
  the arguments to "compare".  

  Test it on this list:

  [ (30, "wes") ;
    (24, "claire) ; 
    (27, "kinga") ; ]

  It should return (24,"claire") and something like [(30,"wes");(27,"kinga")].

  You'll use extract_min in dijkstra. 

(29) Start a new file using this datatype: 

type node = {
  mutable name : string;                (* the node's name *)
  mutable edges : (int * node) list;    (* outgoing cost+edge pairs *) 
} 

type graph = (string, node) Hashtbl.t 
        (* a mapping from node names to nodes *) 

Note that we now have *weighted* edges. 

http://en.wikipedia.org/wiki/Dijkstra's_algorithm

Use max_int for infinity if needed. Use the extract_min you coded above, but 
use it with (int,node) pairs instead of (int,string) pairs. For dist and
previous and whatnot, use hash table. dist[v] becomes Hashtbl.find dist v. 

Write a procedure "dijkstra graph source_node target_node" that performs
dijstras algorithm and returns two things:
  (1) the shortest path distance (an integer)
  (2) the shortest path as a list of nodes

Here's a graph


[ A ] --- 5 ---> [ B ] --- 6 ---> [ C ] -1-\
  |                |                ^       \
  |                1                2        [ F ]
  |                v                |       /
  \------ 7 ---> [ D ] --- 2 ---> [ E ] -4-/

Let's call it the Wes graph. I have serialized it in the following format:

        node1
        weight
        node2

This means there is an edge from node 1 to node 2 with weight weight, and
*also* from node 2 to node 1 with weight weight. So for every 3 lines you
read in, make two calls to add_edge (which now takes 3 arguments). 

Find for me the following shortest paths using your algorithm:

        B -> E          // hint: 3, B D E 
        F -> D          // hint: 5, F C E D 
        A -> F          // hint: 11, A B D E C F 

(*) Done!
