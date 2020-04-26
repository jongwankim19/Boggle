type prefix_tree

val init : string -> prefix_tree

val insert : string -> prefix_tree -> (string * prefix_tree) list