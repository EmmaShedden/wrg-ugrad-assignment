Micro Assignment #7. Graphs

(24) We're now going to make graphs. These are actually more convenient as
mutable data structures -- even in OCaml. Use this type definition:

type node = {
  mutable name : string;        (* the node's name *)
  mutable edges : node list;    (* outgoing edges *) 
} 

type graph = (string, node) Hashtbl.t 
        (* a mapping from node names to nodes *) 

Write a function "new_node graph name" that makes a new node with no edges 
and the given name, and then adds it to the graph hash table. 

Write a function "add_edge graph name1 name2" that looks up the two nodes
by name in the graph and adds an edge from 1 to 2. 

A new graph is just "Hashtbl.create 255" or whatnot. 

A graph can be serialized as a list of edges -- the node set is then
implicitly the union of all nodes mentioned in the edges. The file
"wiki.graph" contains a representation of the first graph picture on

http://en.wikipedia.org/wiki/Graph_(mathematics)

Each line has a node name on it; the file has some even number of lines. The
first line is a source node, the second line is the destination node. Read 
in wiki.graph into a data structure. 

(25) Depth-First Search 

Write a function "dfs graph node" that traverses the graph using depth-first
search visiting each reachable node *once*, starting from the given node.
Hint:

        let dfs graph node =
          let visited = Hashtbl.create 255 in
          let rec visit graph node =
            ...
            Printf.printf "%s\n" node.name 
            ...
          in
          visit graph node

Run your DFS on wiki.graph starting from 6 and also starting from 1. Verify
(using the picture) that the output is a legal depth-first traversal. 

[ In C you might store a mark bit with each node to tell if you've visited it,
but then you have to go clear them all later. Let's let the GC do that by
freeing the visited hash table. ] 

[ Special challenge: do *not* add nodes to the hash table. Instead, hash based
on node names. Be prepared to tell me why. If you're not sure, ask Claire for
a hint. ]

(26) Breadth-First Search

Write a function "bfs graph node" that traverses the graph using breadth-first
search. This requires a queue. You could do this with lists, but ocaml has a
FIFO queue data structure for you. This snippet of code should illustrate it. 

        let q = Queue.create () in
        ...
        Queue.add q "node" ;
        ...
        while not (Queue.empty q) do
          let node = Queue.take q in
          ...
        done 

Here's a hint for BFS:

        let bfs graph node =
          let visited = Hashtbl.create 255 in (* you still need this *)
          let q = Queue.create () in
          ...
          while not (Queue.empty q) do
            let ... = Queue.take q in
            ...
            Printf.printf "%s\n" ...
            ...
          done 

Run BFS on wiki.graph starting from 6 and starting from 1. Verify that your
output is a breadth-first traversal.  
