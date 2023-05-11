Micro Assignment #6. Trees

(22) We'll start with "basic trees" before we get to abstract syntax trees.
  Consider this binary tree definition:

  type btree = 
    | Empty 
    | Node of btree * int * btree

  Thus the btree

        5
       / \
      3   12

  Might be represented as:

    let three_node = Node(Empty, 3, Empty) in 
    let twelve_node = Node(Empty, 12, Empty) in 
    let tree = Node(three_node, 5, twelve_node) in 
    ...

  Or equivalently: 

    Node( (Node(Empty,3,Empty)) , 5 , (Node(Empty,12,Empty)) )

  We'll have you build up some balanced binary trees -- basic CLR data
  structures. In reality, OCaml already does this for you: its
  standard-library Set and Map data types are built using balanced binary
  trees, etc. So you'd never have to do this in reality, but it's good
  practice.

  Note that these trees are *not mutable* -- they are "functional" or
  "applicative" (those two words mean the same thing here). 

  Write a (recursive?) function unbalanced_insert that takes two arguments: 
  a tree and a new element. It returns a new btree that is just like its
  first argument, but that also contains the new element. However, it does not
  build balanced binary trees, it just globs those elements on there. We
  expect:

    unbalanced_insert (Empty) 3         === Node(Empty, 3, Empty)

  While unbalanced_insert         5        7 
                                 / \
                                3   12

  Might yield:  

        5                         7
       / \                       /
      3   12            OR      5           OR whatever
           \                   / \
            7                 3   12

  Write a (recursive?) function print_tree that takes a tree as an argument
  and does an in-order traversal of the tree, printing out its values. 
  So print_tree         5            prints out 3 5 12 
                       / \
                      3   12

  The file "random.numbers" contains 100 random numbers, one on each line.
  Read them all in. Start with a reference to an empty tree. With each number
  that you read in, unbalanced_insert it into your current tree. When you're
  done, print out all of the numbers in your tree using print_tree. Verify
  that the numbers you print out are the same as the numbers you read in
  (e.g., by using 'sort' externally to sort both of them, and then running
  diff, or whatever).  

  This "unit test" verifies that you can build elements of the data structure. 

(23) Now write "insert tree element" that takes a tree and an integer
  and does the standard *sorted* binary tree insertion.  

  Read in "random.numbers" into your sorted tree; print_tree them out. This
  sorts them for you (since it's a sorted btree): compare your results to
  random.numbers.sorted. 

  *Do not worry* about duplicate numbers. Assume no duplicates.
